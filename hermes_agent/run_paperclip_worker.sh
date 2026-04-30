#!/bin/bash
# Hermes Paperclip Worker — Render entrypoint
# Usage: ./run_paperclip_worker.sh
# Required env vars:
#   SUPABASE_URL
#   SUPABASE_SERVICE_ROLE_KEY
#   PAPERCLIP_HERMES_AGENT_ID
# Optional:
#   PAPERCLIP_POLL_INTERVAL_SECONDS (default: 3)
#   PAPERCLIP_MAX_RUNS_PER_PROCESS    (default: unlimited)

set -e
cd "$(dirname "$0")"

# Activate venv if present (local dev), otherwise rely on system Python (Render)
if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
fi

exec python3 supabase_paperclip_worker.py
