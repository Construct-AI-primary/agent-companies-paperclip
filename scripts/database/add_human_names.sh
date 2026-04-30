#!/bin/bash
# Script to add human_name field to all AGENTS.md files
# Extracts human name from directory name

set -e

COMPANIES_DIR="docs-paperclip/companies"

# Function to convert directory name to human name
dir_to_human_name() {
    local dir="$1"
    # Get just the directory name
    local name=$(basename "$dir")
    
    # Remove company slug prefix (e.g., "devforge-ai-Nexus" -> "Nexus")
    # Pattern: company-slug-AgentName where company-slug ends with -ai or similar
    name=$(echo "$name" | sed -E 's/^[a-z0-9]+-[a-z0-9]+-//')
    
    # Convert CamelCase to space-separated words
    # e.g., "MultiDisciplineCoordinator" -> "Multi Discipline Coordinator"
    name=$(echo "$name" | sed -E 's/([A-Z])/ \1/g' | sed 's/^ //')
    
    # Convert hyphens to spaces
    name=$(echo "$name" | tr '-' ' ')
    
    echo "$name"
}

# Find all AGENTS.md files
count=0
skipped=0
added=0

find "$COMPANIES_DIR" -name "AGENTS.md" -type f | while read -r file; do
    dir=$(dirname "$file")
    
    # Skip if already has human_name
    if grep -q "^human_name:" "$file" 2>/dev/null; then
        ((skipped++))
        continue
    fi
    
    # Get human name from directory
    human_name=$(dir_to_human_name "$dir")
    
    # Check length (must be < 23)
    len=${#human_name}
    if [ "$len" -ge 23 ]; then
        echo "WARNING: '$human_name' is $len chars (too long): $file"
        # Shorten it - take first 22 chars
        human_name="${human_name:0:22}"
    fi
    
    # Add human_name after name: line
    sed -i '' "s/^name: /name: \nhuman_name: $human_name\n/" "$file"
    
    ((added++))
    echo "Added: $human_name -> $(basename $(dirname $file))"
done

echo ""
echo "Done! Added: $added, Skipped (already had): $skipped"
