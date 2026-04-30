#!/bin/bash
# Phase 1: Copy platform-agnostic files from paperclip-render to agent-companies-core
set -euo pipefail

SRC="/Users/_Final UI testing/paperclip-render"
DST="/Users/_Final UI testing/agent-companies-core"

echo "=== Step 1.2.1: Copy docs-construct-ai/disciplines/ -> domain-knowledge/disciplines/ ==="
rsync -a "$SRC/docs-construct-ai/disciplines/" "$DST/domain-knowledge/disciplines/"

echo "=== Step 1.2.2: Copy knowledge-disciplines-shared/ -> domain-knowledge/shared-disciplines/ ==="
rsync -a "$SRC/docs-paperclip/knowledge-disciplines-shared/" "$DST/domain-knowledge/shared-disciplines/"

echo "=== Step 1.2.3: Copy knowledge-organisations/ -> domain-knowledge/organisations/ ==="
rsync -a "$SRC/docs-paperclip/knowledge-organisations/" "$DST/domain-knowledge/organisations/"

echo "=== Step 1.2.4: Copy disciplines-non/ -> domain-knowledge/disciplines-non/ ==="
rsync -a "$SRC/docs-paperclip/disciplines-non/" "$DST/domain-knowledge/disciplines-non/"

echo "=== Step 1.2.5: Copy PARA -> para/ ==="
rsync -a "$SRC/docs-construct-ai/para/" "$DST/para/"

echo "=== Step 1.2.6: Copy COMPANY.md files -> companies/(company)/ ==="
find "$SRC/docs-paperclip/companies" -name "COMPANY.md" -maxdepth 2 | while read f; do
    rel="${f#$SRC/docs-paperclip/companies/}"
    company="${rel%%/*}"
    mkdir -p "$DST/companies/$company"
    cp "$f" "$DST/companies/$company/COMPANY.md"
done

echo "=== Step 1.2.7: Copy TEAM.md files -> companies/(company)/teams/ ==="
find "$SRC/docs-paperclip/companies" -name "TEAM.md" -maxdepth 4 | while read f; do
    rel="${f#$SRC/docs-paperclip/companies/}"
    company="${rel%%/*}"
    mkdir -p "$DST/companies/$company/teams"
    basename=$(basename "$(dirname "$f")")
    cp "$f" "$DST/companies/$company/teams/${basename}_TEAM.md"
done

echo "=== Step 1.2.8: Copy AGENTS.md files -> agents/ ==="
find "$SRC/docs-paperclip/companies" -name "AGENTS.md" -maxdepth 4 | while read f; do
    rel="${f#$SRC/docs-paperclip/companies/}"
    dir=$(dirname "$rel")
    mkdir -p "$DST/agents/$dir"
    cp "$f" "$DST/agents/$rel"
done

echo "=== Step 1.2.9: Copy SKILL.md files -> skills/ ==="
find "$SRC/docs-paperclip/companies" -name "SKILL.md" -maxdepth 4 -not -path "*/shared/*" | while read f; do
    rel="${f#$SRC/docs-paperclip/companies/}"
    dir=$(dirname "$rel")
    mkdir -p "$DST/skills/$dir"
    cp "$f" "$DST/skills/$rel"
done

echo "=== Step 1.2.10: Copy shared SKILL.md files -> skills/shared/ ==="
rsync -a "$SRC/docs-paperclip/companies/shared/" "$DST/skills/shared/"

echo "=== Step 1.2.11: Copy project.md files -> projects/ ==="
find "$SRC/docs-paperclip/disciplines" -name "project.md" | while read f; do
    rel="${f#$SRC/docs-paperclip/disciplines/}"
    dir=$(dirname "$rel")
    mkdir -p "$DST/projects/$dir"
    cp "$f" "$DST/projects/$rel"
done

echo "=== Step 1.2.12: Copy issue files -> projects/.../issues/ ==="
find "$SRC/docs-paperclip/disciplines" -path "*/issues/*" -type f | while read f; do
    rel="${f#$SRC/docs-paperclip/disciplines/}"
    dir=$(dirname "$rel")
    mkdir -p "$DST/projects/$dir"
    cp "$f" "$DST/projects/$rel"
done

echo "=== Step 1.2.13: Copy UI-UX-SPECIFICATION.md files -> specs/ ==="
find "$SRC/docs-paperclip" -name "UI-UX-SPECIFICATION.md" | while read f; do
    rel="${f#$SRC/docs-paperclip/}"
    discipline=$(echo "$rel" | cut -d'/' -f2)
    mkdir -p "$DST/specs/$discipline"
    cp "$f" "$DST/specs/$discipline/UI-UX-SPECIFICATION.md"
done

echo "=== Step 1.2.14: Copy cross-reference files ==="
cp "$SRC/docs-paperclip/companies-teams/Paperclip_Teams_Cross_Reference.md" "$DST/cross-reference/"
cp "$SRC/docs-paperclip/companies-teams/Paperclip_Companies_Roster.md" "$DST/cross-reference/"

echo "=== Step 1.2.17: Copy companies-spec.md ==="
if [ -f "$SRC/docs-paperclip/companies/companies-spec.md" ]; then
    cp "$SRC/docs-paperclip/companies/companies-spec.md" "$DST/companies-spec.md"
fi

echo ""
echo "=== Copy complete ==="
echo "Run: du -sh $DST to verify size"