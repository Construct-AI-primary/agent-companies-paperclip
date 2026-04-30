#!/bin/bash
# Hermes Agent Runner
# Usage: ./run.sh "your task description"
# Or:    ./run.sh --model "anthropic/claude-sonnet-4" --task "your task"

set -e
cd "$(dirname "$0")"
source venv/bin/activate

# Default model
MODEL="anthropic/claude-sonnet-4"
TASK=""
MAX_ITER="30"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --model)
            MODEL="$2"
            shift 2
            ;;
        --task)
            TASK="$2"
            shift 2
            ;;
        --max-iter)
            MAX_ITER="$2"
            shift 2
            ;;
        *)
            # If no flag, treat as the task
            if [ -z "$TASK" ]; then
                TASK="$*"
            fi
            break
            ;;
    esac
done

if [ -z "$TASK" ]; then
    echo "Usage: $0 'your task description'"
    echo "       $0 --model 'model' --task 'your task'"
    exit 1
fi

hermes-agent \
  --model="$MODEL" \
  --max-iterations="$MAX_ITER" \
  --user-message="$TASK"

deactivate