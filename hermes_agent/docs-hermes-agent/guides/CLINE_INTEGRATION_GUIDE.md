# Using Hermes Agent via Cline

Since Cline already provides its own LLM and tool capabilities, this guide focuses on how to use Hermes **through Cline's terminal** without paying for duplicate LLM calls.

---

## The Architecture

```
You ──[prompt]──> Cline ──[terminal]──> Hermes Agent ──[tools]──> Results
                                          ↑
                              Uses Cline's LLM? NO
                              Uses Hermes's LLM? YES
```

Right now, `hermes-agent` makes its own LLM calls. This means you pay for:
1. Cline's LLM call (to decide to run Hermes)
2. Hermes's LLM call (to execute the task)

This is fine for learning. Later, you might want to call Hermes tools directly from Cline.

---

## Quick Start

### 1. Configuration (Done ✅)
```bash
cd /Users/_Hermes/hermes-agent
source venv/bin/activate
hermes-agent --user-message "Hello"
```

### 2. Basic Usage from Cline

When you ask Cline something like:
> "Summarize the architecture of this project"

Cline would run:
```bash
cd /Users/_Hermes/hermes-agent && source venv/bin/activate && hermes-agent \
  --user-message "Analyze /path/to/project and summarize the architecture" \
  --model "anthropic/claude-sonnet-4" \
  --max-iterations 10
```

### 3. What Can Hermes Do That Cline Can't Do Natively?

| Feature | Cline | Hermes | Value Add |
|---------|-------|--------|-----------|
| File read/write | ✅ | ✅ | None |
| Terminal commands | ✅ | ✅ | None |
| Web search | ✅ (via tools) | ✅ (Parallel/Firecrawl/Exa) | Maybe |
| Browser automation | ❌ | ✅ (Browserbase) | **High** |
| Subagent delegation | ❌ | ✅ | **Medium** |
| Session search | ❌ | ✅ | **Medium** |
| Scheduled jobs | ❌ | ✅ (cron) | **Medium** |
| Telegram/Discord bot | ❌ | ✅ | **High** |
| MCP client | ❌ | ✅ | **Medium** |
| Voice (TTS/STT) | ❌ | ✅ | **Medium** |

### 4. Recommended Workflow for Learning

**Step 1: Basic tasks via Cline**
Just use Cline normally. Most of what you need Cline already does.

**Step 2: When you need browser automation**
Tell Cline: "Use Hermes's browser tool to navigate to X and extract Y"

Cline will run:
```bash
cd /Users/_Hermes/hermes-agent && source venv/bin/activate && hermes-agent \
  --user-message "Navigate to example.com, fill out the form, and extract the results" \
  --model "anthropic/claude-sonnet-4"
```
*Note: Requires BROWSERBASE_API_KEY and BROWSERBASE_PROJECT_ID in `.env`*

**Step 3: When you need parallel work**
Tell Cline: "Use Hermes to delegate these tasks in parallel"

Cline will run Hermes which spawns subagents.

### 5. Available Models (OpenRouter)

| Model ID | Cost | Speed | Best For |
|----------|------|-------|----------|
| `anthropic/claude-sonnet-4` | Low | Fast | Daily tasks |
| `anthropic/claude-sonnet-4.5` | Medium | Fast | Better reasoning |
| `anthropic/claude-opus-4.6` | High | Medium | Complex tasks |

### 6. Cost Management

Since each `hermes-agent` call uses your OpenRouter credits:
- Use `--max-iterations 5` for simple tasks (default: 10+)
- Use `anthropic/claude-sonnet-4` for routine work
- Reserve `claude-opus-4.6` for complex analysis only

### 7. Tools That Need Additional API Keys

These tools are enabled but won't work until you add keys to `.env`:

| Tool | API Key | Purpose |
|------|---------|---------|
| `web_search` | `PARALLEL_API_KEY` or `EXA_API_KEY` | Web search |
| `browser_*` | `BROWSERBASE_API_KEY` | Browser automation |
| `text_to_speech` | `VOICE_TOOLS_OPENAI_KEY` | Voice output |
| `delegate_task` | (built-in) | Subagents — works without extra config |

---

## Cline Task Examples

### Example 1: File Analysis
**You say to Cline:**
> "Use Hermes to analyze the project structure in src/"

**What it does:** Reads all files, maps dependencies, identifies issues.

### Example 2: Research
**You say to Cline:**
> "Use Hermes to research React Server Components best practices"

**What it does:** Needs web_search configured. Searches the web, extracts content, compiles report.

### Example 3: Browser Automation
**You say to Cline:**
> "Use Hermes to take a screenshot of our website homepage"

**What it does:** Needs Browserbase configured. Opens browser, navigates, captures screenshot.

---

## Setup Status

| Item | Status |
|------|--------|
| Repository cloned | ✅ `/Users/_Hermes/hermes-agent` |
| Virtual environment | ✅ `venv/` created |
| Dependencies installed | ✅ All packages |
| OpenRouter API key | ✅ `OPENROUTER_API_KEY` set in `.env` |
| Test execution | ✅ Successfully ran `hermes-agent` |
| Web search tools | ❌ Needs API key (optional) |
| Browser automation | ❌ Needs BROWSERBASE keys (optional) |
| Voice tools | ❌ Needs OpenAI key (optional) |

---

## Next Steps as You Learn

1. Run simple tasks → get familiar with Hermes's capabilities
2. Add web search API key → enable research abilities
3. Add Browserbase → enable browser automation
4. Explore skills → `hermes skills browse`
5. Try gateway setup → `hermes gateway setup` for Telegram/Discod