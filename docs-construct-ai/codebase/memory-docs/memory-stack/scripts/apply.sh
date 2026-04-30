#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "usage: $0 /path/to/workspace [--mode core|core-plus-guidance|core-plus-openstinger]" >&2
}

TARGET="${1:-}"
shift || true
MODE="core"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --mode)
      MODE="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "error: unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

case "$MODE" in
  core|core-plus-guidance|core-plus-openstinger) ;;
  *)
    echo "error: invalid mode: $MODE" >&2
    usage
    exit 1
    ;;
esac

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TS="$(date +%Y%m%d-%H%M%S)"

if [[ -z "$TARGET" ]]; then
  usage
  exit 1
fi

if [[ ! -d "$TARGET" ]]; then
  echo "error: target workspace does not exist: $TARGET" >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "error: python3 is required by this script" >&2
  exit 1
fi

BACKUP_DIR="$TARGET/.memory-stack-backups/$TS"
mkdir -p "$BACKUP_DIR" "$TARGET/memory" "$TARGET/docs"

echo "== Memory Stack Giveaway Apply =="
echo "target: $TARGET"
echo "mode: $MODE"
echo "backup dir: $BACKUP_DIR"
echo

backup_if_exists() {
  local file="$1"
  if [[ -f "$TARGET/$file" ]]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$file")"
    cp "$TARGET/$file" "$BACKUP_DIR/$file"
    echo "backed up: $file"
  fi
}

ensure_file() {
  local name="$1"
  local template="$2"
  if [[ ! -f "$TARGET/$name" ]]; then
    cp "$ROOT/templates/files/$template" "$TARGET/$name"
    echo "created:   $name"
  else
    echo "kept:      $name"
  fi
}

apply_managed_block() {
  local file="$1"
  local patch="$2"
  backup_if_exists "$file"
  ensure_file "$file" "$file"
  python3 - <<PY
from pathlib import Path
file = Path(r'''$TARGET/$file''')
patch = Path(r'''$ROOT/templates/patches/$patch''').read_text().rstrip() + "\n"
text = file.read_text() if file.exists() else ''
start = '<!-- MEMORY-STACK-GIVEAWAY:START -->'
end = '<!-- MEMORY-STACK-GIVEAWAY:END -->'
if start in text and end in text:
    before, remainder = text.split(start, 1)
    _, after = remainder.split(end, 1)
    before = before.rstrip() + '\n\n' if before.strip() else ''
    after = '\n' + after.lstrip() if after.strip() else ''
    file.write_text(before + patch + after)
else:
    text = text.rstrip()
    if text:
        text += '\n\n'
    file.write_text(text + patch)
PY
  echo "patched:   $file"
}

ensure_file "MEMORY.md" "MEMORY.md"
ensure_file "PARA.md" "PARA.md"
ensure_file "WORKSPACE_MEMORY_SYSTEM.md" "WORKSPACE_MEMORY_SYSTEM.md"
ensure_file "AGENTS.md" "AGENTS.md"

touch "$TARGET/memory/.gitkeep"
echo "ensured:   memory/.gitkeep"

apply_managed_block "AGENTS.md" "AGENTS.memory-stack-block.md"
apply_managed_block "MEMORY.md" "MEMORY.routing-block.md"
apply_managed_block "PARA.md" "PARA.conventions-block.md"

cp "$ROOT/docs/FIRST_VERSION_SPEC.md" "$TARGET/docs/memory-stack-local-notes.md"
echo "wrote:     docs/memory-stack-local-notes.md"

echo
case "$MODE" in
  core)
    echo "core scaffolding applied"
    ;;
  core-plus-guidance)
    echo "core scaffolding applied"
    echo "next: review examples/openclaw-config-snippets.md for Gigabrain + LCM guidance"
    ;;
  core-plus-openstinger)
    echo "core scaffolding applied"
    echo "next: review examples/openclaw-config-snippets.md for Gigabrain + LCM + optional OpenStinger guidance"
    ;;
esac

echo "done"
