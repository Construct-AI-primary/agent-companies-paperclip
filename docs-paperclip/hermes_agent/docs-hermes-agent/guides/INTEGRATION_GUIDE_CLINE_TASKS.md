# Using Hermes Agent via Cline Tasks

This guide explains how to seamlessly use Hermes Agent through Cline tasks — you describe what you need in natural language, and Cline orchestrates Hermes to do the work.

---

## Prerequisites

### 1. Install Hermes Agent

```bash
cd /Users/_Hermes/hermes-agent
python3 -m venv venv
source venv/bin/activate
pip install -e .
```

### 2. Configure API Key

Create `.env` in the Hermes directory:

```bash
cd /Users/_Hermes/hermes-agent
cp .env.example .env
```

Edit `.env` and set your OpenRouter API key:

```env
OPENROUTER_API_KEY=your-key-here
```

Get a key at: https://openrouter.ai/keys

### 3. Verify Installation

```bash
cd /Users/_Hermes/hermes-agent
source venv/bin/activate
hermes-agent --help
```

---

## How to Use Hermes via Cline Tasks

### The Simple Workflow

Just type your request in natural language to Cline. Cline will construct and run the appropriate Hermes command.

**What you say to Cline:**
> "Use Hermes to review the Python files in src/"

**What Cline executes:**
```bash
cd /Users/_Hermes/hermes-agent && source venv/bin/activate && hermes-agent --user-message "Review all Python files in /project/src/ directory. Read each file, identify bugs, security issues, performance problems, and code quality concerns. Provide a detailed report with specific recommendations."
```

---

### Common Task Patterns

#### Pattern 1: Code Review

**You say:**
> "Use Hermes to review the code in src/api/"

**What Cline runs:**
```bash
cd /Users/_Hermes/hermes-agent && source venv/bin/activate && hermes-agent \
  --user-message "Read all files in /project/src/api/ and perform a thorough code review. Check for: security vulnerabilities, error handling, code duplication, naming consistency, and architectural issues. Save findings to /project/code_review.md"
```

---

#### Pattern 2: Research Task

**You say:**
> "Use Hermes to research the latest React Server Components patterns"

**What Cline runs:**
```bash
cd /Users/_Hermes/hermes-agent && source venv/bin/activate && hermes-agent \
  --model "anthropic/claude-sonnet-4" \
  --max-iterations 50 \
  --user-message "Research React Server Components best practices as of 2025. Search the web for official docs, blog posts, and examples. Summarize key patterns, gotchas, and recommendations. Save the research to research_rsc.md"
```

---

#### Pattern 3: Write Documentation

**You say:**
> "Use Hermes to write documentation for src/auth.py"

**What Cline runs:**
```bash
cd /Users/_Hermes/hermes-agent && source venv/bin/activate && hermes-agent \
  --user-message "Read /project/src/auth.py and write comprehensive documentation including: module overview, class descriptions, method signatures with parameter/return docs, usage examples, and integration notes. Write the documentation to /project/docs/auth_module.md"
```

---

#### Pattern 4: Testing

**You say:**
> "Use Hermes to create tests for the utils module"

**What Cline runs:**
```bash
cd /Users/_Hermes/hermes-agent && source venv/bin/activate && hermes-agent \
  --user-message "Read all files in /project/src/utils/. For each function, create comprehensive Python unit tests covering: normal cases, edge cases, error conditions, and boundary values. Save tests to /project/tests/test_utils.py"
```

---

#### Pattern 5: Refactoring

**You say:**
> "Use Hermes to refactor the database module"

**What Cline runs:**
```bash
cd /Users/_Hermes/hermes-agent && source venv/bin/activate && hermes-agent \
  --user-message "Read /project/src/database.py and refactor it to: 1) Use async/await for all database operations, 2) Add connection pooling, 3) Extract query builders into separate functions, 4) Add proper type hints. Create the refactored version as /project/src/database_v2.py"
```

---

### Using Different Models

For simple tasks, use the faster/cheaper model:
```
Use Hermes with claude-sonnet to summarize README.md
```

For complex analysis, use the smarter model:
```  
Use Hermes with claude-opus to do a deep security review of the auth module
```

Available models (via OpenRouter):
- `anthropic/claude-sonnet-4` — Fast, cost-effective
- `anthropic/claude-opus-4.6` — Most capable, expensive
- `anthropic/claude-3.5-sonnet` — Balanced

---

### Controlling Tool Access

Limit what Hermes can do for safety:

**Read-only review:**
> "Use Hermes to review the code (read-only, no file modifications)"

**Read + write:**
> "Use Hermes to analyze and fix the bugs in utils.py"

**Full access:**
> "Use Hermes to refactor the entire module, including running tests"

---

## Advanced Integration Options

### Option A: Bash Script Wrapper

Create `run_hermes.sh` for reuse:

```bash
#!/bin/bash
# run_hermes.sh - Run Hermes with Cline
# Usage: ./run_hermes.sh "your task description"

set -e
HERMES_DIR="/Users/_Hermes/hermes-agent"
PROMPT="$1"
MODEL="${2:-anthropic/claude-sonnet-4}"

cd "$HERMES_DIR"
source venv/bin/activate

hermes-agent \
  --model="$MODEL" \
  --max-iterations 50 \
  --quiet-mode \
  --user-message="$PROMPT"

deactivate
```

Then in Cline tasks:
```bash
./run_hermes.sh "Review all TypeScript files in src/components/"
```

---

### Option B: Python Direct API

For fine-grained control, create a Python script:

```python
#!/usr/bin/env python3
"""Cline task: Run Hermes with custom configuration"""
import sys
sys.path.insert(0, "/Users/_Hermes/hermes-agent")

from run_agent import AIAgent

def run_task(prompt: str, model: str = "anthropic/claude-sonnet-4"):
    agent = AIAgent(
        model=model,
        max_iterations=50,
        quiet_mode=True,
    )
    result = agent.run_conversation(user_message=prompt)
    print(result["final_response"])
    return result

if __name__ == "__main__":
    prompt = sys.argv[1] if len(sys.argv) > 1 else "Review the codebase"
    run_task(prompt)
```

Run with:
```bash
python /Users/_Hermes/hermes-agent/cline_task.py "Summarize the project architecture"
```

---

### Option C: Background Long Tasks

For tasks that take a long time:

```bash
cd /Users/_Hermes/hermes-agent && source venv/bin/activate && hermes-agent \
  --max-iterations 100 \
  --user-message "Perform a comprehensive audit of the entire codebase..." &
```

---

## Configuring Default Settings

Run the interactive setup:
```bash
cd /Users/_Hermes/hermes-agent && source venv/bin/activate && hermes setup
```

Or edit `~/.hermes/config.yaml` directly:
```yaml
model:
  default: anthropic/claude-sonnet-4

terminal:
  backend: local
  cwd: "."

compression:
  enabled: true
  threshold: 0.85
  summary_model: google/gemini-3-flash-preview
```

---

## Available Hermes Tools

Hermes has 40+ tools available, including:

| Toolset | Tools | Capabilities |
|---------|-------|-------------|
| **File** | read_file, write_file, patch, search_files | Read, create, modify, search files |
| **Terminal** | terminal, execute_code | Run shell commands, execute Python code |
| **Web** | web_search, web_extract | Search the internet, extract web content |
| **Browser** | browser_navigate, browser_click, browser_type | Full browser automation |
| **Delegation** | delegate_task | Spawn sub-agents for parallel work |
| **Organization** | todo, memory, session_search | Task management, memory, search |
| **Skills** | skills_list, skill_view, skill_manage | Skill system for specialized tasks |

The agent automatically selects appropriate tools based on your prompt.

---

## Quick Reference

| Action | Command |
|--------|---------|
| **Single prompt** | `hermes-agent --user-message "task"` |
| **With model** | `hermes-agent --model "model" --user-message "task"` |
| **More iterations** | `hermes-agent --max-iterations 100 --user-message "task"` |
| **Interactive mode** | `hermes` |
| **Setup wizard** | `hermes setup` |
| **Browse skills** | `hermes skills browse` |
| **List tools** | `hermes tools list` |
