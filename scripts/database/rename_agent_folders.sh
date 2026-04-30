#!/bin/bash
# Script to rename agent folders to match human_name in AGENTS.md
# Handles nested paths like: agents/coordinators/measureforge-ai-Nexus

COMPANIES_DIR="docs-paperclip/companies"

# Function to convert human_name to folder suffix
human_name_to_suffix() {
    local name="$1"
    # Remove spaces
    name=$(echo "$name" | tr -d ' ')
    echo "$name"
}

# Find all AGENTS.md files
renamed=0
skipped=0
errors=0

while IFS= read -r file; do
    # Get the agent folder (parent of AGENTS.md)
    agent_dir=$(dirname "$file")
    current_folder=$(basename "$agent_dir")
    
    # Get human_name from file - handle YAML properly
    human_name=$(awk '/^human_name:/ {gsub(/^human_name: */, ""); print; exit}' "$file")
    
    if [ -z "$human_name" ]; then
        echo "SKIP: No human_name in $file"
        ((skipped++))
        continue
    fi
    
    # Convert to suffix
    new_suffix=$(human_name_to_suffix "$human_name")
    
    # Extract company prefix from current folder (e.g., "measureforge-ai" from "measureforge-ai-Nexus")
    company_prefix=$(echo "$current_folder" | sed -E 's/^([a-z0-9]+-[a-z0-9]+)-.*/\1/')
    
    # Build new folder name
    new_folder="${company_prefix}-${new_suffix}"
    
    if [ "$current_folder" != "$new_folder" ]; then
        echo "RENAME: $current_folder -> $new_folder"
        parent_dir=$(dirname "$agent_dir")
        mv "$agent_dir" "$parent_dir/$new_folder"
        if [ $? -eq 0 ]; then
            ((renamed++))
        else
            echo "ERROR: Failed to rename $current_folder"
            ((errors++))
        fi
    else
        echo "OK: $current_folder (already matches)"
        ((skipped++))
    fi
done < <(find "$COMPANIES_DIR" -name "AGENTS.md" -type f 2>/dev/null)

echo ""
echo "Done! Renamed: $renamed, Skipped: $skipped, Errors: $errors"