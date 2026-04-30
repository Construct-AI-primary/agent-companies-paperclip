#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-}"
if [[ -z "$TARGET" ]]; then
  echo "usage: $0 /path/to/workspace" >&2
  exit 1
fi

if [[ ! -d "$TARGET" ]]; then
  echo "error: target workspace does not exist: $TARGET" >&2
  exit 1
fi

have_cmd() {
  command -v "$1" >/dev/null 2>&1
}

echo "== Memory Stack Giveaway Preflight =="
echo "target: $TARGET"
echo

echo "-- bootstrap files --"
for f in AGENTS.md MEMORY.md PARA.md WORKSPACE_MEMORY_SYSTEM.md; do
  if [[ -f "$TARGET/$f" ]]; then
    echo "found:   $f"
  else
    echo "missing: $f (can be created)"
  fi
done

if [[ -d "$TARGET/memory" ]]; then
  echo "found:   memory/"
else
  echo "missing: memory/ (can be created)"
fi

echo
printf '%s\n' "-- required tooling --"
for cmd in bash cp mkdir date zip; do
  if have_cmd "$cmd"; then
    echo "$cmd: yes"
  else
    echo "$cmd: no"
  fi
done

if have_cmd python3; then
  echo "python3: yes"
elif have_cmd python; then
  echo "python: yes (python3 missing; script may need adjustment on target)"
else
  echo "python: no"
fi

echo
printf '%s\n' "-- optional dependency signals --"
if have_cmd docker; then
  echo "docker: yes"
else
  echo "docker: no"
fi

if have_cmd docker && docker compose version >/dev/null 2>&1; then
  echo "docker compose: yes"
elif have_cmd docker-compose; then
  echo "docker-compose: yes"
else
  echo "docker compose: no"
fi

if have_cmd openclaw; then
  echo "openclaw: yes"
else
  echo "openclaw: no"
fi

echo
printf '%s\n' "-- portability notes --"
echo "- Review examples/openclaw-config-snippets.md before changing config."
echo "- Treat source-machine absolute paths as examples only."
echo "- Install missing plugins/dependencies using current docs for this machine."

echo
echo "preflight: OK"
