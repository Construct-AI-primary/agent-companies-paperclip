#!/bin/bash
# Hermes Agent Submodule Setup
# Run this script from the root of any repo to add hermes_agent as a submodule
# and configure .clinerules for "hermes run" commands

set -e

REPO_ROOT="$(pwd)"
SUBMODULE_PATH="$REPO_ROOT/hermes_agent"

echo "=== Hermes Agent Submodule Setup ==="
echo ""

# Check if submodule already exists
if [ -d "$SUBMODULE_PATH" ]; then
    echo "hermes_agent/ already exists at $SUBMODULE_PATH"
    echo "Skipping submodule addition."
else
    echo "Adding hermes_agent as submodule..."
    git submodule add https://github.com/tennantalistair/hermes-agent.git hermes_agent
    git submodule update --init --recursive
    echo "Submodule added."
fi

echo ""

# Check if .clinerules exists
if [ -f "$REPO_ROOT/.clinerules" ]; then
    # Check if hermes rules already exist
    if grep -q "hermes run" "$REPO_ROOT/.clinerules" 2>/dev/null; then
        echo ".clinerules already has hermes run rules."
    else
        echo "Adding hermes rules to .clinerules..."
        cat >> "$REPO_ROOT/.clinerules" << 'HERMES_RULES'

# Hermes Run Command
When the user types "hermes run" followed by a task description, execute:
```bash
./hermes_agent/run.sh "task description here"
```

Examples:
- User: `hermes run summarize this file`
  → Run: `./hermes_agent/run.sh "Summarize this file"`

- User: `hermes run --model "anthropic/claude-opus-4.6" --task "deep analysis"`
  → Run: `./hermes_agent/run.sh --model "anthropic/claude-opus-4.6" --task "deep analysis"`

## Setup Required
Before running Hermes, ensure:
1. API key is set in `hermes_agent/.env` — uncomment `OPENROUTER_API_KEY=` and add your key
2. Virtual environment exists at `hermes_agent/venv/`
HERMES_RULES
        echo "Rules added."
    fi
else
    echo "Creating .clinerules with hermes rules..."
    cat > "$REPO_ROOT/.clinerules" << 'HERMES_RULES'
# Hermes Run Command
When the user types "hermes run" followed by a task description, execute:
```bash
./hermes_agent/run.sh "task description here"
```

Examples:
- User: `hermes run summarize this file`
  → Run: `./hermes_agent/run.sh "Summarize this file"`

- User: `hermes run --model "anthropic/claude-opus-4.6" --task "deep analysis"`
  → Run: `./hermes_agent/run.sh --model "anthropic/claude-opus-4.6" --task "deep analysis"`

## Setup Required
Before running Hermes, ensure:
1. API key is set in `hermes_agent/.env` — uncomment `OPENROUTER_API_KEY=` and add your key
2. Virtual environment exists at `hermes_agent/venv/`
HERMES_RULES
    echo ".clinerules created."
fi

echo ""
echo "=== Setup Complete ==="
echo ""
echo "To finish:"
echo "1. Uncomment OPENROUTER_API_KEY in hermes_agent/.env and add your key"
echo "2. Run: cd hermes_agent && python3 -m venv venv && source venv/bin/activate && pip install -e ."
echo "3. Test: ./hermes_agent/run.sh hello"