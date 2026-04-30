#!/bin/bash
set -e

echo "=== [BUILD-STEP-1] Environment Info ==="
echo "PWD: $(pwd)"
echo "USER: $(whoami)"
echo "HOME: $HOME"
echo "GIT_DIR: $(git rev-parse --git-dir 2>/dev/null || echo 'not a git repo')"
echo "Python3: $(command -v python3 2>/dev/null || echo 'not found')"
echo "Node: $(node --version 2>/dev/null || echo 'not found')"
echo "NPM: $(npm --version 2>/dev/null || echo 'not found')"

echo "=== [BUILD-STEP-2] Git Submodule Status ==="
git submodule status 2>&1 || echo "git submodule status failed"

echo "=== [BUILD-STEP-3] Initializing git submodules ==="
echo "[3a] Initializing docs-construct-ai..."
git submodule update --init docs-construct-ai 2>&1 && echo "[3a] SUCCESS: docs-construct-ai initialized" || echo "[3a] WARNING: docs-construct-ai submodule init failed"

echo "[3b] Initializing docs-paperclip..."
git submodule update --init docs-paperclip 2>&1 && echo "[3b] SUCCESS: docs-paperclip initialized" || echo "[3b] WARNING: docs-paperclip submodule init failed"

echo "[3c] Skipping hermes_agent submodule - hermes_local adapter is built into the server"

echo "=== [BUILD-STEP-4] Installing pnpm ==="
npm install -g pnpm@9.15.4

echo "=== [BUILD-STEP-5] Installing dependencies ==="
# Must include devDependencies because shared package's tsconfig includes test files
# that import vitest, and build runs tsc which checks those imports
pnpm install --frozen-lockfile --prod=false

echo "=== [BUILD-STEP-5.5] Installing Hermes Agent CLI ==="
# The hermes_local adapter requires the hermes CLI command to be available
# Install the local hermes_agent directory as an editable package
# This provides the 'hermes' command that hermes-paperclip-adapter needs
python3 -m pip install --user --no-cache-dir --timeout=60 --upgrade pip 2>&1 | head -20
python3 -m pip install --user --no-cache-dir --timeout=120 -e hermes_agent 2>&1 | head -50

# Add Python user bin to PATH for runtime
export PATH="$HOME/.local/bin:$PATH"
echo "Python user bin added to PATH: $HOME/.local/bin"
echo "Hermes installation complete. Version check: $(hermes --version 2>&1 || echo 'hermes command not in PATH')"
echo "Hermes location: $(which hermes 2>&1 || echo 'not found in PATH')"

echo "=== [BUILD-STEP-6] Building packages ==="
# shared first - it has no internal workspace deps
pnpm --filter @paperclipai/shared build
# Then db - it imports from @paperclipai/shared
pnpm --filter @paperclipai/db build
pnpm --filter @paperclipai/adapter-utils build
pnpm --filter @paperclipai/adapter-claude-local build
pnpm --filter @paperclipai/adapter-codex-local build
pnpm --filter @paperclipai/adapter-cursor-local build
pnpm --filter @paperclipai/adapter-gemini-local build
pnpm --filter @paperclipai/adapter-openclaw-gateway build
pnpm --filter @paperclipai/adapter-opencode-local build
pnpm --filter @paperclipai/adapter-pi-local build
pnpm --filter @paperclipai/plugin-sdk build
pnpm --filter @paperclipai/ui build
# Skip preflight:workspace-links for server build - workspace links are already correct after pnpm install
cd server && tsc && mkdir -p dist/onboarding-assets && cp -R src/onboarding-assets/. dist/onboarding-assets/ && cd ..

echo "=== [BUILD-STEP-7] Final deployment verification ==="
echo "[7a] server/dist/index.js: $(test -f server/dist/index.js && echo EXISTS || echo MISSING)"
echo "[7b] hermes_local adapter is built into the server - no external hermes_agent needed"

echo "=== [BUILD-COMPLETE] Build finished ==="