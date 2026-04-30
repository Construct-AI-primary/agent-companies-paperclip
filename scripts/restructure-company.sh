#!/usr/bin/env bash
# Restructure a company's skills to follow agentcompanies/v1 spec
# This script operates inside the docs-construct-ai submodule
#
# Usage: cd docs-construct-ai && ../scripts/restructure-company.sh loopy-ai --dry-run
#        cd docs-construct-ai && ../scripts/restructure-company.sh loopy-ai --run

set -euo pipefail

COMPANY="${1:-}"
MODE="${2:---dry-run}"

if [[ -z "$COMPANY" ]]; then
  echo "Usage: $0 <company-slug> [--dry-run|--run]"
  exit 1
fi

SKILLS_ROOT="skills"
COMPANY_DIR="$SKILLS_ROOT/$COMPANY"
ALT_DIR="$SKILLS_ROOT/${COMPANY//-/_}"

echo "═══════════════════════════════════════"
echo "Restructuring: $COMPANY"
echo "═══════════════════════════════════════"
echo "Company dir: $COMPANY_DIR"
if [[ -d "$ALT_DIR" ]]; then
  echo "Alt dir:     $ALT_DIR ⚠️  (duplicate)"
fi

if [[ "$MODE" == "--run" ]]; then
  echo "Mode: RUN (making changes)"

  mkdir -p "$COMPANY_DIR/skills"

  # Move all skill dirs into skills/
  for skill_dir in "$COMPANY_DIR"/*/; do
    dir_name=$(basename "$skill_dir")
    # Skip special directories
    [[ "$dir_name" == "skills" || "$dir_name" == "agents" || "$dir_name" == "shared" ]] && continue
    [[ ! -f "$skill_dir/SKILL.md" ]] && continue

    # Skip if already exists
    if [[ -d "$COMPANY_DIR/skills/$dir_name" ]]; then
      echo "  ⏭ Already exists: skills/$dir_name"
      continue
    fi
    echo "  📦 Moving: $dir_name -> skills/$dir_name"
    mv "$skill_dir" "$COMPANY_DIR/skills/$dir_name"
  done

  # Handle duplicate with underscores
  if [[ -d "$ALT_DIR" ]]; then
    echo ""
    echo "  Processing duplicate: ${COMPANY//-/_}/"
    for skill_dir in "$ALT_DIR"/*/; do
      dir_name=$(basename "$skill_dir")
      [[ "$dir_name" == "skills" || "$dir_name" == "agents" || "$dir_name" == "shared" ]] && continue
      [[ ! -f "$skill_dir/SKILL.md" ]] && continue
      if [[ -d "$COMPANY_DIR/skills/$dir_name" ]]; then
        echo "  ⏭ Already exists: skills/$dir_name (duplicate content)"
        continue
      fi
      echo "  📦 Moving from duplicate: $dir_name -> skills/$dir_name"
      mv "$skill_dir" "$COMPANY_DIR/skills/$dir_name"
    done
    echo "  🗑  Removing duplicate directory"
    rm -rf "$ALT_DIR"
  fi

  echo ""
  echo "  ✅ Done. Next steps:"
  echo "    git add skills/$COMPANY"
  echo "    git commit -m 'restructure: $COMPANY to agentcompanies/v1'"
  echo "    cd .. && git add docs-construct-ai && git commit -m 'chore: update submodule'"
else
  echo "Mode: DRY RUN (no changes)"
  echo ""
  echo "  Skills that would be moved into skills/:"
  count=0
  for skill_dir in "$COMPANY_DIR"/*/; do
    dir_name=$(basename "$skill_dir")
    [[ "$dir_name" == "skills" || "$dir_name" == "agents" || "$dir_name" == "shared" ]] && continue
    if [[ -f "$skill_dir/SKILL.md" ]]; then
      echo "    - $dir_name"
      count=$((count + 1))
    fi
  done
  echo "  Total: $count skills"
  if [[ -d "$ALT_DIR" ]]; then
    echo ""
    echo "  ⚠️  Duplicate directory: ${COMPANY//-/_}/"
    alt_count=0
    for skill_dir in "$ALT_DIR"/*/; do
      dir_name=$(basename "$skill_dir")
      [[ "$dir_name" == "skills" || "$dir_name" == "agents" || "$dir_name" == "shared" ]] && continue
      if [[ -f "$skill_dir/SKILL.md" ]]; then
        if [[ -d "$COMPANY_DIR/skills/$dir_name" || -d "$COMPANY_DIR/$dir_name" ]]; then
          echo "    - $dir_name (DUPLICATE)"
        else
          echo "    - $dir_name (UNIQUE - would be moved)"
          alt_count=$((alt_count + 1))
        fi
      fi
    done
    echo "  Unique skills in duplicate: $alt_count"
  fi
  echo ""
  echo "  After restructuring:"
  echo "    skills/$COMPANY/"
  echo "    ├── COMPANY.md          (company metadata)"
  echo "    ├── agents/             (agent definitions)"
  echo "    │   └── {agent}/AGENTS.md"
  echo "    └── skills/             (all skill packages)"
  echo "        ├── {skill}/SKILL.md"
  echo "        └── .../SKILL.md"
fi