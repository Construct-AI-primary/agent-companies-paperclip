#!/bin/bash
# post-commit-sync.sh - Git post-commit hook for automatic Supabase-SQLite sync
#
# Installation:
#   cp scripts/git-hooks/post-commit-sync.sh .git/hooks/post-commit
#   chmod +x .git/hooks/post-commit
#
# This hook runs after every commit to sync local SQLite with Supabase.
# It performs a full backup before sync and flags conflicts for manual review.
#
# To skip sync for a specific commit, use:
#   git commit --no-verify -m "message"

set -euo pipefail

# Check if sync should be skipped
if [ "${SKIP_SYNC:-0}" = "1" ]; then
  echo "⏭️  Sync skipped (SKIP_SYNC=1)"
  exit 0
fi

# Check if we're in a merge/rebase (don't sync during those)
if [ -f "$(git rev-parse --git-dir)/MERGE_HEAD" ]; then
  echo "⏭️  Sync skipped (merge in progress)"
  exit 0
fi

# Check if required environment is available
if [ -z "${SUPABASE_URL:-}" ] || [ -z "${SUPABASE_SERVICE_ROLE_KEY:-}" ]; then
  # Try to load from .env
  if [ -f .env ]; then
    set -a
    source .env
    set +a
  fi
  
  if [ -z "${SUPABASE_URL:-}" ] || [ -z "${SUPABASE_SERVICE_ROLE_KEY:-}" ]; then
    echo "⏭️  Sync skipped (Supabase credentials not configured)"
    exit 0
  fi
fi

echo "🔄 Post-commit sync triggered..."
echo "   Commit: $(git log -1 --format='%h %s')"

# Run sync - push local SQLite changes to Supabase after commit
bash scripts/database/sqlite-sync.sh push 2>&1 || {
  EXIT_CODE=$?
  if [ $EXIT_CODE -eq 2 ]; then
    echo ""
    echo "⚠️  Sync completed with conflicts. Please review:"
    echo "   logs/conflicts-*.md"
    echo ""
    echo "   Resolve conflicts before making further changes."
  else
    echo ""
    echo "❌ Sync failed with exit code $EXIT_CODE"
    echo "   Check logs/sync-*.log for details"
  fi
  exit $EXIT_CODE
}

echo "✅ Post-commit sync complete"