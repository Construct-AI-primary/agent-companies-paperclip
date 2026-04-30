#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIST="$ROOT/dist"
NAME="openclaw-memory-stack-giveaway.zip"

mkdir -p "$DIST"
rm -f "$DIST/$NAME"

cd "$ROOT"
zip -qr "$DIST/$NAME" \
  README.md \
  manifest.json \
  INSTALL_PROMPT.md \
  docs \
  templates \
  scripts \
  examples

printf '%s\n' "$DIST/$NAME"
sha256sum "$DIST/$NAME"
