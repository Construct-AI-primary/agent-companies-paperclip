#!/bin/bash
# Phase 2: Create agent-companies-paperclip from paperclip-render
# Option B: Separate repo with full Paperclip application code + agent-companies-core submodule
set -euo pipefail

SRC="/Users/_Final UI testing/paperclip-render"
DST="/Users/_Final UI testing/agent-companies-paperclip"
CORE_REPO="https://github.com/Construct-AI-primary/agent-companies-core.git"

echo "=== Phase 2: Create agent-companies-paperclip ==="
echo "Source: $SRC"
echo "Target: $DST"

# Step 2.1: Create target directory
mkdir -p "$DST"
cd "$DST"

# Step 2.2: Initialize git
git init
git branch -m main

echo "=== Step 2.3: Copy Paperclip application code ==="

# Copy server/ (Express REST API)
echo "  -> server/"
rsync -a "$SRC/server/" "$DST/server/"

# Copy ui/ (React + Vite)
echo "  -> ui/"
rsync -a "$SRC/ui/" "$DST/ui/"

# Copy packages/
echo "  -> packages/"
rsync -a "$SRC/packages/" "$DST/packages/"

# Copy docker/
echo "  -> docker/"
rsync -a "$SRC/docker/" "$DST/docker/"

# Copy tests/
echo "  -> tests/"
rsync -a "$SRC/tests/" "$DST/tests/"

# Copy scripts/ (database utilities, restructure scripts, etc.)
echo "  -> scripts/"
rsync -a "$SRC/scripts/" "$DST/scripts/"

# Copy hermes_agent/ (submodule ref only)
echo "  -> hermes_agent/ (submodule)"
rsync -a "$SRC/hermes_agent/" "$DST/hermes_agent/"

# Copy doc/ (architecture, development, spec, guides)
echo "  -> doc/"
rsync -a "$SRC/doc/" "$DST/doc/"

# Copy releases/
echo "  -> releases/"
rsync -a "$SRC/releases/" "$DST/releases/"

# Copy evals/
echo "  -> evals/"
rsync -a "$SRC/evals/" "$DST/evals/"

# Copy mcp/
echo "  -> mcp/"
rsync -a "$SRC/mcp/" "$DST/mcp/"

# Copy docs-paperclip as submodule reference
echo "  -> docs-paperclip/ (submodule)"
rsync -a "$SRC/docs-paperclip/" "$DST/docs-paperclip/"

# Copy docs-construct-ai as submodule reference
echo "  -> docs-construct-ai/ (submodule)"
rsync -a "$SRC/docs-construct-ai/" "$DST/docs-construct-ai/"

# Copy root-level config files
echo "  -> Root config files"
for f in \
    package.json pnpm-workspace.yaml pnpm-lock.yaml tsconfig.base.json \
    tsconfig.json vitest.config.ts .npmrc .gitignore .dockerignore \
    Dockerfile render.yaml render-config.json config.json \
    vite.config.ts jest.config.ts; do
    [ -f "$SRC/$f" ] && cp "$SRC/$f" "$DST/$f"
done

# Copy root-level dotfiles
for f in .env.example; do
    [ -f "$SRC/$f" ] && cp "$SRC/$f" "$DST/$f"
done

# Copy root docs
for f in README.md AGENTS.md CONTRIBUTING.md SECURITY.md LICENSE; do
    [ -f "$SRC/$f" ] && cp "$SRC/$f" "$DST/$f"
done

# Copy business documents
echo "  -> Business documents"
for f in \
    FINAL_PRODUCTION_GO_LIVE_PROCEDURE.md \
    PRODUCTION_DEPLOYMENT_GUIDE.md \
    README_SUPABASE_BACKUP.md \
    adapter-plugin.md \
    superpowers.code-workspace; do
    [ -f "$SRC/$f" ] && cp "$SRC/$f" "$DST/$f"
done

# Copy root SQL files
echo "  -> Root SQL files"
find "$SRC" -maxdepth 1 -name "*.sql" -exec cp {} "$DST/" \;

# Copy root JS/CJS files
echo "  -> Root JS files"
find "$SRC" -maxdepth 1 -name "*.js" -o -name "*.cjs" -o -name "*.mjs" | while read f; do
    cp "$f" "$DST/"
done

# Copy root Python files
find "$SRC" -maxdepth 1 -name "*.py" | while read f; do
    cp "$f" "$DST/"
done

# Copy root JSON files (excluding node_modules references)
find "$SRC" -maxdepth 1 -name "*.json" | while read f; do
    cp "$f" "$DST/"
done

# Copy root shell scripts
find "$SRC" -maxdepth 1 -name "*.sh" | while read f; do
    cp "$f" "$DST/"
done

# Copy testing/ directory
[ -d "$SRC/testing" ] && rsync -a "$SRC/testing/" "$DST/testing/"

# Copy src/ directory if it exists
[ -d "$SRC/src" ] && rsync -a "$SRC/src/" "$DST/src/"

# Copy cli/ directory
[ -d "$SRC/cli" ] && rsync -a "$SRC/cli/" "$DST/cli/"

# Copy report/ directory
[ -d "$SRC/report" ] && rsync -a "$SRC/report/" "$DST/report/"

# Copy construct-ai-docs/ directory
[ -d "$SRC/construct-ai-docs" ] && rsync -a "$SRC/construct-ai-docs/" "$DST/construct-ai-docs/"

echo ""
echo "=== Step 2.4: Create .gitignore ==="
cat > "$DST/.gitignore" << 'GITIGNORE'
node_modules/
dist/
build/
.next/
coverage/
.env
*.log
.DS_Store
Thumbs.db
*.swp
*.swo
*~
.idea/
.vscode/
*.sublime-*
tmp/
temp/
data/
pglite/
GITIGNORE

echo "=== Step 2.5: Write .gitmodules ==="
cat > "$DST/.gitmodules" << 'GITMODULES'
[submodule "agent-companies-core"]
	path = agent-companies-core
	url = https://github.com/Construct-AI-primary/agent-companies-core.git
[submodule "docs-construct-ai"]
	path = docs-construct-ai
	url = https://github.com/Construct-AI-primary/construct_ai_docs.git
[submodule "docs-paperclip"]
	path = docs-paperclip
	url = https://github.com/Construct-AI-primary/docs-paperclip.git
[submodule "hermes_agent"]
	path = hermes_agent
	url = https://github.com/tennantalistair/hermes-agent.git
GITMODULES

echo ""
echo "=== Copy complete ==="
echo "Run: cd $DST && git add -A && git status --short | wc -l"