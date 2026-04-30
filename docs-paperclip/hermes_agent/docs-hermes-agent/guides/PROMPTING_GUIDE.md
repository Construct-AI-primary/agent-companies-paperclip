# How to Direct Prompts to Hermes Agent

This guide explains the various methods for sending prompts/tasks to Hermes Agent, from simple CLI commands to advanced Python API integration.

---

## Table of Contents

1. [CLI Methods](#cli-methods)
2. [Python API Methods](#python-api-methods)
3. [Configuration Options](#configuration-options)
4. [Advanced Patterns](#advanced-patterns)
5. [Integration Examples](#integration-examples)

---

## CLI Methods

### Method 1: Interactive TUI (Terminal User Interface)

The simplest way — start a conversation and type your prompts:

```bash
hermes
```

Then type your prompt at the `You ▶` prompt:
```
You ▶ Analyze the Python files in src/ and suggest improvements
```

**Use case:** Manual exploration, debugging, interactive tasks.

---

### Method 2: Single-Shot CLI (Headless)

Execute a single prompt and exit:

```bash
hermes-agent --user-message "Your prompt here"
```

**Complete example:**
```bash
hermes-agent \
  --model "anthropic/claude-sonnet-4" \
  --user-message "Review the code in this directory and create a detailed report of potential issues"
```

**Use case:** Scripting, automation, CI/CD pipelines, Cline tasks.

---

### Method 3: Using `run_agent.py` Directly

For development or when you need more control:

```bash
python run_agent.py \
  --model="anthropic/claude-opus-4.6" \
  --user_message="Your prompt here" \
  --max_iterations=50 \
  --quiet_mode=True
```

---

## Python API Methods

### Method 1: Basic Conversation

```python
from run_agent import AIAgent

# Initialize agent
agent = AIAgent(
    model="anthropic/claude-sonnet-4",
    base_url="https://openrouter.ai/api/v1",
    api_key="your-key-here",  # or set via env var
    max_iterations=50,
    quiet_mode=True,
)

# Send a prompt
result = agent.run_conversation(
    user_message="Analyze this codebase and suggest improvements"
)

# Access results
print(result["final_response"])
print(f"Completed: {result['completed']}")
print(f"API calls used: {result['api_calls']}")
```

---

### Method 2: Multi-Turn Conversation

```python
from run_agent import AIAgent

agent = AIAgent(
    model="anthropic/claude-sonnet-4",
    quiet_mode=True,
)

# First prompt
result1 = agent.run_conversation(
    user_message="Read the file src/main.py"
)

# Continue conversation with history
result2 = agent.run_conversation(
    user_message="Now suggest improvements for that file",
    conversation_history=result1["messages"]
)

print(result2["final_response"])
```

---

### Method 3: With System Prompt (Persona)

```python
agent = AIAgent(
    model="anthropic/claude-sonnet-4",
    quiet_mode=True,
)

result = agent.run_conversation(
    user_message="Review this code for security issues",
    system_message="""You are a senior security engineer with expertise in:
    - OWASP Top 10 vulnerabilities
    - Cryptography best practices
    - Authentication and authorization
    
    Provide detailed, actionable security recommendations."""
)
```

---

### Method 4: Batch Processing Multiple Prompts

```python
from run_agent import AIAgent
import json

prompts = [
    "Analyze file1.py for bugs",
    "Review file2.py for performance",
    "Check file3.py for security issues"
]

agent = AIAgent(
    model="anthropic/claude-sonnet-4",
    quiet_mode=True,
    skip_context_files=True,  # Faster for batch tasks
    skip_memory=True,
)

results = []
for i, prompt in enumerate(prompts):
    print(f"Processing prompt {i+1}/{len(prompts)}...")
    result = agent.run_conversation(
        user_message=prompt,
        task_id=f"batch-{i}"  # Isolate VMs/browsers per task
    )
    results.append({
        "prompt": prompt,
        "response": result["final_response"],
        "api_calls": result["api_calls"],
        "tokens": agent.session_total_tokens,
    })

# Save results
with open("batch_results.json", "w") as f:
    json.dump(results, f, indent=2)
```

---

## Configuration Options

### Essential Parameters

| Parameter | Type | Purpose | Example |
|-----------|------|---------|---------|
| `user_message` | str | **The prompt/task** | `"Review this code"` |
| `model` | str | LLM to use | `"anthropic/claude-opus-4.6"` |
| `max_iterations` | int | Max tool-calling turns | `50` |
| `quiet_mode` | bool | Suppress output | `True` |
| `conversation_history` | list | Previous messages | `result1["messages"]` |
| `system_message` | str | Custom persona/instructions | `"You are a..."` |
| `task_id` | str | Unique identifier | `"cline-task-001"` |

### Advanced Parameters

```python
agent = AIAgent(
    # Model selection
    model="anthropic/claude-sonnet-4",
    base_url="https://openrouter.ai/api/v1",
    api_key="sk-...",
    
    # Tool control
    enabled_toolsets=["file", "terminal", "web"],  # Only these
    disabled_toolsets=["browser"],                 # Exclude these
    
    # Performance
    max_iterations=50,
    tool_delay=0.5,  # Seconds between tool calls
    
    # Context management
    skip_context_files=True,   # Skip SOUL.md injection
    skip_memory=True,           # Skip memory loading
    
    # Output control
    quiet_mode=True,
    verbose_logging=False,
    
    # Session management
    save_trajectories=False,    # Don't save to disk
    session_id="custom-id",
    
    # Callbacks (for integration)
    tool_progress_callback=my_callback,
    stream_delta_callback=my_stream_callback,
)
```

---

## Advanced Patterns

### Pattern 1: Prompt with Specific Tools Only

```python
# Code review agent — only file and search tools
agent = AIAgent(
    model="anthropic/claude-sonnet-4",
    enabled_toolsets=["file"],
    quiet_mode=True,
)

result = agent.run_conversation(
    user_message="""
    Review all Python files in the current directory:
    1. Read each .py file
    2. Check for security issues, bugs, and code quality
    3. Provide a structured report
    """
)
```

---

### Pattern 2: Research Task with Web Access

```python
# Research agent — web search and extraction
agent = AIAgent(
    model="anthropic/claude-sonnet-4",
    enabled_toolsets=["web", "file"],
    quiet_mode=True,
)

result = agent.run_conversation(
    user_message="""
    Research the latest best practices for React 19:
    1. Search for official documentation
    2. Find recent blog posts from trusted sources
    3. Summarize key changes and recommendations
    4. Save the summary to research_report.md
    """
)
```

---

### Pattern 3: Delegated Multi-Agent Workflow

```python
# Parent agent coordinates subagents
agent = AIAgent(
    model="anthropic/claude-opus-4.6",  # Smarter model for orchestration
    max_iterations=30,
    quiet_mode=True,
)

result = agent.run_conversation(
    user_message="""
    Use the delegate_task tool to parallelize this work:
    
    1. Task 1: Analyze all Python files for security issues
    2. Task 2: Review all JavaScript files for performance problems
    3. Task 3: Check all test files for completeness
    
    Coordinate the results and provide a unified report.
    """
)
```

---

### Pattern 4: Streaming Responses (Real-Time)

```python
def handle_stream(text_delta):
    """Called for each text chunk as it's generated"""
    print(text_delta, end="", flush=True)

agent = AIAgent(
    model="anthropic/claude-sonnet-4",
    quiet_mode=True,
)

result = agent.run_conversation(
    user_message="Explain how async/await works in Python",
    stream_callback=handle_stream  # Real-time text streaming
)
```

---

### Pattern 5: With Custom System Prompt File

```python
# Load persona from file
with open("personas/security_expert.txt") as f:
    security_persona = f.read()

agent = AIAgent(
    model="anthropic/claude-opus-4.6",
    quiet_mode=True,
)

result = agent.run_conversation(
    user_message="Review this authentication code",
    system_message=security_persona
)
```

---

## Integration Examples

### Example 1: Cline Task Integration

```python
#!/usr/bin/env python3
"""
Cline Task: Run Hermes for code review
Usage: python cline_hermes_review.py <directory>
"""
import sys
from pathlib import Path
from run_agent import AIAgent

def review_directory(directory: str) -> dict:
    """Run Hermes code review on a directory"""
    
    agent = AIAgent(
        model="anthropic/claude-sonnet-4",
        enabled_toolsets=["file"],
        max_iterations=30,
        quiet_mode=True,
        skip_context_files=True,
    )
    
    prompt = f"""
    Perform a comprehensive code review of the directory: {directory}
    
    Tasks:
    1. Read all Python files in the directory
    2. Identify:
       - Security vulnerabilities
       - Performance issues
       - Code quality problems
       - Missing error handling
       - Potential bugs
    3. Create a detailed report in markdown format
    4. Save the report to code_review_report.md
    
    Focus on actionable, specific recommendations.
    """
    
    result = agent.run_conversation(
        user_message=prompt,
        task_id=f"review-{Path(directory).name}"
    )
    
    return {
        "success": result["completed"],
        "response": result["final_response"],
        "report_file": "code_review_report.md",
        "api_calls": result["api_calls"],
        "tokens_used": agent.session_total_tokens,
    }

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python cline_hermes_review.py <directory>")
        sys.exit(1)
    
    directory = sys.argv[1]
    result = review_directory(directory)
    
    print(f"Review completed: {result['success']}")
    print(f"Report saved to: {result['report_file']}")
    print(f"API calls: {result['api_calls']}")
    print(f"Tokens: {result['tokens_used']:,}")
```

Run it:
```bash
python cline_hermes_review.py ./src
```

---

### Example 2: Shell Script Wrapper

```bash
#!/bin/bash
# hermes_task.sh - Run Hermes with a prompt from command line

set -e

PROMPT="$1"
MODEL="${HERMES_MODEL:-anthropic/claude-sonnet-4}"
MAX_ITER="${HERMES_MAX_ITER:-30}"

if [ -z "$PROMPT" ]; then
    echo "Usage: $0 'your prompt here'"
    exit 1
fi

# Run Hermes in headless mode
hermes-agent \
    --model="$MODEL" \
    --max-iterations="$MAX_ITER" \
    --quiet-mode \
    --user-message="$PROMPT" \
    2>&1 | tee hermes_output.log

echo ""
echo "Output saved to: hermes_output.log"
```

Usage:
```bash
chmod +x hermes_task.sh
./hermes_task.sh "Analyze this codebase and create a report"
```

---

### Example 3: REST API Wrapper

```python
#!/usr/bin/env python3
"""
Simple HTTP API wrapper for Hermes Agent
Usage: python hermes_api.py
Then: curl -X POST http://localhost:8000/prompt -d '{"message": "..."}'
"""
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from run_agent import AIAgent
import uvicorn

app = FastAPI(title="Hermes Agent API")

class PromptRequest(BaseModel):
    message: str
    model: str = "anthropic/claude-sonnet-4"
    max_iterations: int = 30

class PromptResponse(BaseModel):
    response: str
    completed: bool
    api_calls: int
    tokens_used: int

@app.post("/prompt", response_model=PromptResponse)
async def run_prompt(request: PromptRequest):
    """Execute a Hermes prompt"""
    try:
        agent = AIAgent(
            model=request.model,
            max_iterations=request.max_iterations,
            quiet_mode=True,
            skip_context_files=True,
        )
        
        result = agent.run_conversation(
            user_message=request.message
        )
        
        return PromptResponse(
            response=result["final_response"],
            completed=result["completed"],
            api_calls=result["api_calls"],
            tokens_used=agent.session_total_tokens,
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

Start the server:
```bash
python hermes_api.py
```

Send a prompt:
```bash
curl -X POST http://localhost:8000/prompt \
  -H "Content-Type: application/json" \
  -d '{"message": "List all Python files in the current directory"}'
```

---

## Key Takeaways

1. **CLI**: Use `hermes-agent --user-message "prompt"` for one-shot tasks
2. **Python API**: Use `AIAgent.run_conversation(user_message="prompt")` for programmatic control
3. **System Prompts**: Add `system_message=` to customize the agent's persona
4. **Conversation History**: Pass `conversation_history=result["messages"]` for multi-turn
5. **Tool Control**: Use `enabled_toolsets=` and `disabled_toolsets=` to limit capabilities
6. **Task Isolation**: Use unique `task_id=` values for parallel tasks

---

## Next Steps

- **Interactive CLI**: Run `hermes` to explore interactively
- **Configuration**: Run `hermes setup` to configure models and tools
- **Skills**: Run `hermes skills browse` to see available skills
- **Gateway**: Run `hermes gateway setup` for Telegram/Discord integration

For more details, see the [official documentation](https://hermes-agent.nousresearch.com/docs/).