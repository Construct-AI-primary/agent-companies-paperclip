"""
Paperclip Unified Worker — polls issues for assigned agents,
executes tasks via HTTP adapter or local Hermes CLI, then posts results.
"""
import json
import logging
import os
import subprocess
import sys
import tempfile
import time
import uuid
from http.server import HTTPServer, BaseHTTPRequestHandler
from pathlib import Path
from typing import Any, Dict, List, Optional

logger = logging.getLogger("paperclip_worker")


# =============================================================================
# Config
# =============================================================================

class WorkerConfig:
    supabase_url: str = os.getenv("SUPABASE_URL", "")
    supabase_service_role_key: str = os.getenv("SUPABASE_SERVICE_ROLE_KEY", "")
    github_token: str = os.getenv("GITHUB_TOKEN", "")
    poll_interval_seconds: float = float(os.getenv("POLL_INTERVAL_SECONDS", "5"))
    max_runs_per_process: Optional[int] = (
        int(os.getenv("PAPERCLIP_MAX_RUNS_PER_PROCESS", "0")) or None
    )
    _clone_cache: Dict[str, Path] = {}

    def __post_init__(self):
        missing = [k for k in ("supabase_url", "supabase_service_role_key") if not getattr(self, k)]
        if missing:
            raise ValueError(f"Missing env vars: {missing}")


def _load_config_from_env() -> WorkerConfig:
    return WorkerConfig()


# =============================================================================
# Supabase client
# =============================================================================

def _create_supabase_client(cfg: WorkerConfig):
    from supabase import create_client
    return create_client(cfg.supabase_url, cfg.supabase_service_role_key)


def _safe_json(obj: Any) -> Any:
    try:
        json.dumps(obj)
        return obj
    except Exception:
        return {"_unserializable": str(type(obj))}


def _get_data(res) -> List[Dict[str, Any]]:
    """Extract rows from supabase-py response (handles both object and dict forms)."""
    if hasattr(res, "data") and res.data is not None:
        return res.data
    if isinstance(res, dict):
        return res.get("data") or []
    return []


# =============================================================================
# Agent data access
# =============================================================================

def _fetch_agent_by_id(supabase, agent_id: str) -> Optional[Dict[str, Any]]:
    """Fetch single agent by ID."""
    res = (
        supabase.table("agents")
        .select("id, adapter_type, company_id, role, name, runtime_config, capabilities, is_active")
        .eq("id", agent_id)
        .limit(1)
        .execute()
    )
    rows = _get_data(res)
    return rows[0] if rows else None


def _fetch_agent_model_config(supabase, agent_id: str) -> Dict[str, Any]:
    """Fetch agent_models config for given agent."""
    res = (
        supabase.table("agent_models")
        .select("model_id, temperature, max_tokens")
        .eq("agent_id", agent_id)
        .eq("is_active", True)
        .eq("assignment_type", "primary")
        .limit(1)
        .execute()
    )
    rows = _get_data(res)
    return rows[0] if rows else {}


def _fetch_agent_api_key(supabase, agent_id: str, company_id: str) -> Optional[str]:
    """Look up per-agent per-company API key for LLM billing."""
    res = (
        supabase.table("agent_api_keys")
        .select("api_key")
        .eq("agent_id", agent_id)
        .eq("company_id", company_id)
        .limit(1)
        .execute()
    )
    rows = _get_data(res)
    if rows:
        return rows[0].get("api_key")
    # Fallback: any key for this agent
    res = (
        supabase.table("agent_api_keys")
        .select("api_key")
        .eq("agent_id", agent_id)
        .limit(1)
        .execute()
    )
    rows = _get_data(res)
    return rows[0].get("api_key") if rows else None


# =============================================================================
# Issue-based polling (NEW - primary path for CEO delegation)
# =============================================================================

def _select_next_issues(supabase) -> List[Dict[str, Any]]:
    """
    Fetch ALL queued/pending issues that have an assignee_agent_id.
    This is the primary path for CEO delegation - each assigned issue becomes a task.
    """
    # Fetch issues assigned to active agents with http/hermes adapter types
    res = (
        supabase.table("issues")
        .select("id, title, description, project_workspace_id, company_id, project_id, assignee_agent_id, status")
        .in_("status", ["queued", "pending", "in_progress"])
        .not_.is_("assignee_agent_id", "null")
        .order("created_at", desc=False)
        .limit(10)
        .execute()
    )
    issues = _get_data(res)
    
    if not issues:
        return []
    
    # Get all unique agent IDs
    agent_ids = list(set(i.get("assignee_agent_id") for i in issues if i.get("assignee_agent_id")))
    
    if not agent_ids:
        return []
    
    # Fetch agent info for all agents
    agent_res = (
        supabase.table("agents")
        .select("id, adapter_type, company_id, role, name, runtime_config, capabilities, is_active")
        .in_("id", agent_ids)
        .in_("adapter_type", ["hermes", "hermes_local", "http"])
        .execute()
    )
    agent_rows = _get_data(agent_res)
    agent_map = {a["id"]: a for a in agent_rows}
    
    # Fetch agent_models for each agent
    agent_models_map = {}
    if agent_ids:
        models_res = (
            supabase.table("agent_models")
            .select("agent_id, model_id, temperature, max_tokens")
            .in_("agent_id", agent_ids)
            .eq("is_active", True)
            .eq("assignment_type", "primary")
            .execute()
        )
        for row in _get_data(models_res):
            agent_models_map[row["agent_id"]] = row
    
    # Attach agent info to each issue
    enriched_issues = []
    for issue in issues:
        agent_id = issue.get("assignee_agent_id")
        agent = agent_map.get(agent_id)
        
        if not agent:
            logger.debug("Issue %s has assignee %s but no active HTTP agent found", 
                        issue["id"][:8], agent_id[:8] if agent_id else "None")
            continue
        
        # Skip inactive agents
        if not agent.get("is_active", True):
            logger.debug("Issue %s assignee agent %s is not active", 
                        issue["id"][:8], agent.get("name", "?"))
            continue
        
        # Merge agent_models config with agent runtime_config
        model_row = agent_models_map.get(agent_id, {})
        runtime_cfg = dict(agent.get("runtime_config") or {})
        if model_row.get("model_id"):
            runtime_cfg["model"] = model_row["model_id"]
        if model_row.get("temperature") is not None:
            runtime_cfg["temperature"] = float(model_row["temperature"])
        if model_row.get("max_tokens") is not None:
            runtime_cfg["max_tokens"] = int(model_row["max_tokens"])
        
        issue["_agent"] = agent
        issue["_runtime_config"] = runtime_cfg
        enriched_issues.append(issue)
    
    return enriched_issues


def _claim_issue(supabase, issue_id: str) -> bool:
    """Atomic claim: update queued/pending/in_progress → running."""
    res = (
        supabase.table("issues")
        .update({"status": "running", "started_at": "now()"})
        .eq("id", issue_id)
        .in_("status", ["queued", "pending", "in_progress"])
        .execute()
    )
    rows = _get_data(res)
    return bool(rows)


def _fetch_issue_context(supabase, issue: Dict[str, Any]) -> Dict[str, Any]:
    """
    Enrich issue with workspace and company info.
    Returns flat context dict for execution.
    """
    issue_id = issue["id"]
    agent = issue.get("_agent", {})
    
    # Fetch workspace info
    workspace_id = issue.get("project_workspace_id")
    repo_url = None
    cwd = None
    repo_ref = "main"
    
    if workspace_id:
        ws_res = (
            supabase.table("project_workspaces")
            .select("repo_url, cwd, repo_ref, default_ref")
            .eq("id", workspace_id)
            .limit(1)
            .execute()
        )
        ws_rows = _get_data(ws_res)
        if ws_rows:
            ws = ws_rows[0]
            repo_url = ws.get("repo_url")
            cwd = ws.get("cwd") or ""
            repo_ref = ws.get("repo_ref") or ws.get("default_ref") or "main"
    
    # Fetch company info
    company_id = issue.get("company_id")
    company_name = None
    if company_id:
        comp_res = (
            supabase.table("companies")
            .select("name")
            .eq("id", company_id)
            .limit(1)
            .execute()
        )
        comp_rows = _get_data(comp_res)
        if comp_rows:
            company_name = comp_rows[0].get("name")
    
    # Prefer merged agent_models config, fall back to runtime_config
    runtime_config = issue.get("_runtime_config") or agent.get("runtime_config") or {}
    
    return {
        "issue_id": issue_id,
        "issue_title": issue.get("title", ""),
        "issue_description": issue.get("description", ""),
        "company_id": company_id,
        "company_name": company_name,
        "project_id": issue.get("project_id"),
        "repo_url": repo_url,
        "repo_ref": repo_ref,
        "cwd": cwd,
        "agent_id": issue.get("assignee_agent_id"),
        "agent_role": agent.get("role"),
        "agent_name": agent.get("name"),
        "agent_capabilities": agent.get("capabilities"),
        "adapter_type": agent.get("adapter_type", "http"),
        "agent_runtime_config": runtime_config,
        "run_context": issue.get("context_snapshot") or {},
    }


def _update_issue_status(supabase, issue_id: str, status: str, result: Dict[str, Any]):
    """Update issue with final status and result."""
    payload = {
        "status": status,
        "finished_at": "now()",
        "result_json": _safe_json({
            "exit_code": result.get("exit_code"),
            "pr_url": result.get("pr_url"),
            "stdout_excerpt": (result.get("stdout") or "")[:1000],
            "stderr_excerpt": (result.get("stderr") or "")[:500],
        }),
    }
    if status == "completed":
        payload["exit_code"] = 0
    else:
        payload["exit_code"] = result.get("exit_code", 1)
        payload["error"] = result.get("error", "unknown error")
    
    try:
        supabase.table("issues").update(payload).eq("id", issue_id).execute()
    except Exception as exc:
        logger.warning("Could not update issue status: %s", exc)


# =============================================================================
# Git helpers
# =============================================================================

def _auth_git_url(repo_url: str, token: str) -> str:
    if not token:
        return repo_url
    if repo_url.startswith("https://github.com/"):
        return repo_url.replace("https://", f"https://{token}@")
    return repo_url


def _clone_repo(repo_url: str, ref: str, github_token: str, cache: Dict[str, Path]) -> Path:
    """Clone or reuse from cache."""
    cache_key = f"{repo_url}@{ref}"
    if cache_key in cache:
        logger.info("Reusing cached clone of %s @ %s", repo_url, ref)
        return cache[cache_key]

    authed_url = _auth_git_url(repo_url, github_token)
    tmp = Path(tempfile.mkdtemp(prefix="hermes_"))
    clone_dest = tmp / "repo"

    logger.info("Cloning %s (ref=%s) → %s", repo_url, ref, clone_dest)
    _run(["git", "clone", "--quiet", "--depth=1", authed_url, str(clone_dest)])
    _run(["git", "-C", str(clone_dest), "fetch", "--quiet", "origin", ref])
    _run(["git", "-C", str(clone_dest), "checkout", "--quiet", ref])

    cache[cache_key] = clone_dest
    return clone_dest


def _run(cmd: List[str], cwd: Optional[str] = None, timeout: int = 120) -> str:
    try:
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            cwd=cwd,
            timeout=timeout,
            env={**os.environ, "GIT_TERMINAL_PROMPT": "0"},
        )
        if result.returncode != 0:
            logger.warning("Command %s exited %d: %s", cmd, result.returncode, result.stderr.strip())
        return result.stdout.strip()
    except subprocess.TimeoutExpired:
        logger.error("Command timed out after %ds: %s", timeout, cmd)
        raise


def _create_pr(repo_url: str, branch: str, title: str, body: str, github_token: str) -> str:
    """Create a GitHub PR via API. Returns PR URL."""
    parts = repo_url.rstrip("/").split("/")
    owner_repo = "/".join(parts[-2:]).replace(".git", "")

    import urllib.request

    url = f"https://api.github.com/repos/{owner_repo}/pulls"
    payload = json.dumps({
        "title": title,
        "head": branch,
        "base": "main",
        "body": body,
    }).encode("utf-8")

    req = urllib.request.Request(
        url, data=payload,
        headers={
            "Authorization": f"Bearer {github_token}",
            "Accept": "application/vnd.github+json",
            "X-GitHub-Api-Version": "2022-11-28",
            "Content-Type": "application/json",
        },
        method="POST",
    )
    with urllib.request.urlopen(req, timeout=30) as resp:
        data = json.loads(resp.read())
    return data.get("html_url") or data.get("url", "")


# =============================================================================
# Hermes execution (local CLI)
# =============================================================================

def _run_hermes_agent(
    repo_path: Path,
    cwd: str,
    prompt: str,
    runtime_config: Dict[str, Any],
    github_token: str,
    api_key: Optional[str],
) -> Dict[str, Any]:
    """Run Hermes CLI in repo_path with the given prompt."""
    work_dir = repo_path / cwd if cwd else repo_path

    model = runtime_config.get("model")
    max_turns = runtime_config.get("max_turns", 20)
    temperature = runtime_config.get("temperature")

    cmd = [
        sys.executable, "-m", "hermes",
        "--model", model or "openrouter/qwen/qwen-3-6-plus",
        "--max-iterations", str(max_turns),
        "--no-stream",
        "--message", prompt,
    ]
    if temperature is not None:
        cmd += ["--temperature", str(temperature)]

    env = {**os.environ}
    if api_key:
        env["OPENROUTER_API_KEY"] = api_key
    if github_token:
        env["GITHUB_TOKEN"] = github_token

    # max_tokens from agent_models → HERMES_MAX_TOKENS env var for LLM API
    max_tokens = runtime_config.get("max_tokens")
    if max_tokens:
        env["HERMES_MAX_TOKENS"] = str(max_tokens)

    logger.info(
        "Running Hermes (model=%s, turns=%d, agent_role=%s) in %s",
        model or "default", max_turns,
        runtime_config.get("role", "unknown"),
        work_dir,
    )

    try:
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            cwd=str(work_dir),
            timeout=900,  # 15 min max per run
            env=env,
        )
        return {
            "exit_code": result.returncode,
            "stdout": result.stdout or "",
            "stderr": (result.stderr or "")[-500:],
        }
    except subprocess.TimeoutExpired:
        return {
            "exit_code": -1,
            "stdout": "",
            "stderr": "Hermes timed out after 900 seconds",
        }


# =============================================================================
# HTTP Adapter execution
# =============================================================================

def _run_http_adapter(
    ctx: Dict[str, Any],
    runtime_config: Dict[str, Any],
    api_key: Optional[str],
    github_token: str = "",
) -> Dict[str, Any]:
    """
    Execute via HTTP adapter endpoint.
    The endpoint URL should be in runtime_config or use default HERMES_ADAPTER_ENDPOINT.
    Injects GITHUB_TOKEN into repo_url so Paperclip's managed checkout can clone private repos.
    """
    import urllib.request
    import urllib.error

    # Get the HTTP adapter endpoint from runtime_config or use default
    endpoint = runtime_config.get("adapter_endpoint")
    if not endpoint:
        # Always use PORT env var (Render sets this to the actual listening port)
        # Ignore HERMES_ADAPTER_ENDPOINT which may be set to wrong port
        port = os.getenv("PORT", "8642")
        endpoint = f"http://localhost:{port}/invoke"

    model = runtime_config.get("model", "openrouter/qwen/qwen-3-6-plus")
    max_turns = runtime_config.get("max_turns", 20)
    temperature = runtime_config.get("temperature")

    # Auth the repo_url so Paperclip's managed checkout can clone private repos
    repo_url = ctx.get("repo_url") or ""
    repo_url = _auth_git_url(repo_url, github_token)

    # Build the payload
    payload = {
        "prompt": ctx.get("issue_description") or ctx.get("issue_title", ""),
        "repo_url": repo_url,
        "repo_ref": ctx.get("repo_ref", "main"),
        "cwd": ctx.get("cwd", ""),
        "model": model,
        "max_turns": max_turns,
        "temperature": temperature,
        "max_tokens": runtime_config.get("max_tokens"),
        "github_token": github_token,  # Include GitHub token for agent environment
        "agent_id": ctx.get("agent_id"),
        "company_id": ctx.get("company_id"),
        "issue_id": ctx.get("issue_id"),
    }

    # Remove None values
    payload = {k: v for k, v in payload.items() if v is not None}

    logger.info("Calling HTTP adapter at %s with payload: %s", endpoint, json.dumps(payload, default=str)[:200])

    try:
        data = json.dumps(payload).encode("utf-8")
        req = urllib.request.Request(
            endpoint,
            data=data,
            headers={
                "Content-Type": "application/json",
                "Accept": "application/json",
            },
            method="POST",
        )

        # Add API key header if available
        if api_key:
            req.add_header("Authorization", f"Bearer {api_key}")

        with urllib.request.urlopen(req, timeout=900) as resp:
            result_data = json.loads(resp.read())
            return {
                "exit_code": 0,
                "stdout": json.dumps(result_data),
                "stderr": "",
            }

    except urllib.error.HTTPError as e:
        error_body = e.read().decode("utf-8", errors="replace") if e.fp else ""
        logger.error("HTTP adapter error %d: %s", e.code, error_body[:500])
        return {
            "exit_code": e.code,
            "stdout": "",
            "stderr": f"HTTP {e.code}: {error_body[:500]}",
        }
    except Exception as exc:
        logger.error("HTTP adapter failed: %s", exc)
        return {
            "exit_code": -1,
            "stdout": "",
            "stderr": str(exc),
        }


# =============================================================================
# Execute a single issue
# =============================================================================

def _execute_issue(
    ctx: Dict[str, Any], cfg: WorkerConfig, supabase
) -> Dict[str, Any]:
    """Execute one Paperclip issue with the resolved agent + company config."""
    repo_url = ctx.get("repo_url")
    if not repo_url:
        # Default to construct_ai repo if no repo_url provided
        repo_url = "https://github.com/Construct-AI-primary/construct_ai.git"
        logger.info("No repo_url provided, using default: %s", repo_url)

    repo_ref = ctx.get("repo_ref", "main")
    cwd = ctx.get("cwd", "")
    issue_title = ctx.get("issue_title", "Hermes task")
    issue_description = ctx.get("issue_description", "")
    company_id = ctx.get("company_id")
    agent_id = ctx.get("agent_id")
    runtime_config = ctx.get("agent_runtime_config", {})
    company_name = ctx.get("company_name") or "unknown"
    adapter_type = ctx.get("adapter_type", "http")

    prompt = issue_description.strip() if issue_description.strip() else issue_title

    # Per-company, per-agent API key
    api_key = None
    if agent_id and company_id:
        try:
            api_key = _fetch_agent_api_key(supabase, agent_id, company_id)
        except Exception as exc:
            logger.warning("Could not fetch agent API key: %s", exc)

    # Get github_token from config
    github_token = cfg.github_token

    # Check adapter type and execute accordingly
    if adapter_type == "http":
        # Use HTTP adapter — pass github_token so repo_url is authed for private repos
        result = _run_http_adapter(ctx, runtime_config, api_key, github_token)
    else:
        # Use local Hermes CLI (hermes/hermes_local)
        # Clone repo
        try:
            repo_path = _clone_repo(repo_url, repo_ref, github_token, cfg._clone_cache)
        except Exception as exc:
            return {"error": f"Clone failed: {exc}"}

        result = _run_hermes_agent(
            repo_path, cwd, prompt, runtime_config, github_token, api_key
        )

    pr_url = None
    branch_name = f"hermes-{uuid.uuid4().hex[:8]}"

    if result.get("exit_code") == 0:
        try:
            body = (
                f"**Hermes Task Result**\n"
                f"Company: {company_name}\n"
                f"Agent Role: {ctx.get('agent_role', 'unknown')}\n\n"
                f"```\n{result.get('stdout', '')}\n```"
            )
            pr_url = _create_pr(
                repo_url, branch_name,
                f"Hermes [{company_name}]: {issue_title[:50]}",
                body[:65536],
                github_token,
            )
        except Exception as exc:
            logger.warning("PR creation failed: %s", exc)

    return {
        "repo_url": repo_url,
        "repo_ref": repo_ref,
        "pr_url": pr_url,
        "exit_code": result.get("exit_code"),
        "stdout": result.get("stdout", ""),
        "stderr": result.get("stderr", ""),
    }


# =============================================================================
# Comment posting
# =============================================================================

def _post_issue_comment(supabase, issue_id: str, body: str):
    try:
        supabase.table("issue_comments").insert({
            "issue_id": issue_id,
            "body": body,
        }).execute()
    except Exception as exc:
        logger.debug("Could not post issue comment: %s", exc)


# =============================================================================
# Health check server
# =============================================================================

def _start_health_server():
    # Skip health server if running in "both" mode - API server already provides health endpoints
    if os.getenv("HERMES_MODE") == "both":
        logger.info("Skipping health server in both mode (API server provides /health)")
        return
    
    port = int(os.getenv("PORT", "8080"))

    class HealthHandler(BaseHTTPRequestHandler):
        def do_GET(self):
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.end_headers()
            self.wfile.write(b"OK")

        def log_message(self, format, *args):
            pass  # suppress logging

    server = HTTPServer(("0.0.0.0", port), HealthHandler)
    logger.info("Health server listening on port %s", port)
    import threading
    t = threading.Thread(target=server.serve_forever, daemon=True)
    t.start()


# =============================================================================
# Main worker loop
# =============================================================================

def run_forever():
    logging.basicConfig(
        level=logging.getLevelName(os.getenv("LOG_LEVEL", "INFO")),
        format="%(asctime)s %(levelname)s %(name)s: %(message)s",
    )

    cfg = _load_config_from_env()
    supabase = _create_supabase_client(cfg)

    processed = 0
    skipped = 0
    logger.info("Paperclip unified worker starting — polling issues every %.1fs", cfg.poll_interval_seconds)
    logger.info("HTTP adapter endpoint: %s", os.getenv("HERMES_ADAPTER_ENDPOINT", "http://localhost:8642/invoke"))

    while True:
        if cfg.max_runs_per_process and processed >= cfg.max_runs_per_process:
            logger.info("Reached PAPERCLIP_MAX_RUNS_PER_PROCESS=%s, exiting", cfg.max_runs_per_process)
            return

        try:
            # Poll issues directly - this is the primary path for CEO delegation
            issues = _select_next_issues(supabase)
            if not issues:
                time.sleep(cfg.poll_interval_seconds)
                continue

            for issue in issues:
                issue_id = issue["id"]
                agent_name = issue.get("_agent", {}).get("name", "?")
                company = issue.get("company_id", "")[:8] if issue.get("company_id") else "?"

                claimed = _claim_issue(supabase, issue_id)
                if not claimed:
                    logger.debug("Issue %s already claimed by another worker", issue_id[:8])
                    continue

                logger.info(
                    "Claimed issue %s — agent=%s company=%s",
                    issue_id[:8], agent_name, company,
                )

                # Build execution context
                ctx = _fetch_issue_context(supabase, issue)

                # _execute_issue now defaults to construct_ai repo if no repo_url provided
                # so we always proceed (no early skip)

                # Execute the task
                result = _execute_issue(ctx, cfg, supabase)

                # Update issue status
                status = "completed" if result.get("exit_code") == 0 else "failed"
                _update_issue_status(supabase, issue_id, status, result)

                # Post result comment
                pr = result.get("pr_url")
                if status == "completed" and pr:
                    msg = f"✅ Task completed — [View PR]({pr})"
                elif status == "completed":
                    msg = "✅ Task completed"
                else:
                    error_msg = result.get('error') or 'unknown error'
                    msg = f"⚠️ Task failed: {error_msg}"
                _post_issue_comment(supabase, issue_id, msg)

                processed += 1

            # Log stats periodically
            if skipped > 0 and skipped % 10 == 0:
                logger.info("Stats: processed=%d, skipped=%d", processed, skipped)

        except Exception:
            logger.exception("Worker loop error — retrying")
            time.sleep(max(1.0, cfg.poll_interval_seconds))


# =============================================================================
# Entry point
# =============================================================================

if __name__ == "__main__":
    PROJECT_ROOT = Path(__file__).parent.resolve()
    if str(PROJECT_ROOT) not in sys.path:
        sys.path.insert(0, str(PROJECT_ROOT))

    dotenv_path = PROJECT_ROOT / ".env"
    if dotenv_path.exists():
        try:
            from dotenv import load_dotenv
            load_dotenv(dotenv_path, override=True)
        except ImportError:
            pass

    _start_health_server()
    run_forever()
