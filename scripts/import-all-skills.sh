#!/bin/bash
# =============================================================
# Import all testing skills via Paperclip API
# Usage: sh scripts/import-all-skills.sh YOUR_API_KEY YOUR_COMPANY_ID
# =============================================================

set -euo pipefail

API_KEY="${1:?Error: Paperclip API key required as first argument}"
COMPANY_ID="${2:?Error: Paperclip company ID required as second argument}"
API_BASE="${PAPERCLIP_API_URL:-https://paperclip-render.onrender.com}"

echo "=========================================="
echo "  Paperclip Skill Import Script"
echo "=========================================="
echo "API Base:    ${API_BASE}"
echo "Company ID:  ${COMPANY_ID}"
echo "=========================================="
echo ""

# Resolve the doc/company base dir
DOCS_DIR="$(cd "$(dirname "$0")/.." && pwd)/doc/companies"

if [ ! -d "${DOCS_DIR}" ]; then
  echo "ERROR: doc/companies directory not found at: ${DOCS_DIR}"
  echo "Run this script from the paperclip-render repository root."
  exit 1
fi

TOTAL=0
IMPORTED=0
SKIPPED=0

# Iterate over all SKILL.md files
find "${DOCS_DIR}" -name "SKILL.md" | while read -r skill_file; do
  TOTAL=$((TOTAL + 1))
  dir=$(dirname "$skill_file")
  skill_name=$(basename "$dir")

  echo -n "Importing ${skill_name}... "

  # Read content, strip frontmatter (YAML between --- markers)
  content=$(awk '/^---/{c++} c>=2{print}' "$skill_file" | sed '1{/^$/d}')

  response=$(curl -sf -w "HTTP_STATUS:%{http_code}" \
    -X POST "${API_BASE}/api/companies/${COMPANY_ID}/skills/import" \
    -H "Authorization: Bearer ${API_KEY}" \
    -H "Content-Type: application/json" \
    -d "$(jq -n --arg name "$skill_name" --arg content "$content" \
      '{skills: [{name: $name, content: $content}]}')" 2>/dev/null || echo "HTTP_STATUS:000")

  http_status=$(echo "$response" | grep -oP 'HTTP_STATUS:\K\d+')
  body=$(echo "$response" | sed 's/HTTP_STATUS:.*//')

  if [ "$http_status" = "200" ]; then
    echo "✅ Imported"
    IMPORTED=$((IMPORTED + 1))
  elif [ "$http_status" = "409" ]; then
    echo "⏭️  Already exists (skipped)"
    SKIPPED=$((SKIPPED + 1))
  else
    echo "❌ Failed (HTTP ${http_status})"
    echo "   Body: ${body}"
  fi
done

echo ""
echo "=========================================="
echo "  Summary"
echo "=========================================="
echo "Total:  ${TOTAL}"
echo "New:    ${IMPORTED}"
echo "Skipped:${SKIPPED}"
echo "=========================================="