#!/bin/bash
# Migrate discipline projects into desktop/ and mobile/ subfolders
# Also moves the 3 workflow markdown docs into projects/desktop/
# Usage: ./scripts/migrate-discipline-platforms.sh

set -e

DISCIPLINES_DIR="docs-paperclip/disciplines"

echo "=== Discipline Platform Migration ==="
echo "Splitting projects/ into desktop/ and mobile/ for all disciplines"
echo "Moving workflow docs into projects/desktop/"
echo ""

# Count disciplines
total=0
migrated=0
skipped=0

# Get all discipline directories (those starting with a number pattern)
for discipline_dir in "$DISCIPLINES_DIR"/*/; do
    # Skip non-discipline directories
    dirname=$(basename "$discipline_dir")
    
    # Only process directories that look like disciplines (start with 00 or 01 or 02 or 03)
    if [[ ! "$dirname" =~ ^[0-9]{4,5}- ]]; then
        echo "⏭️  Skipping non-discipline: $dirname"
        continue
    fi
    
    projects_dir="$discipline_dir/projects"
    
    # Skip if no projects directory exists
    if [ ! -d "$projects_dir" ]; then
        echo "⏭️  Skipping (no projects/): $dirname"
        skipped=$((skipped + 1))
        total=$((total + 1))
        continue
    fi
    
    # Check if already migrated
    if [ -d "$projects_dir/desktop" ] && [ -d "$projects_dir/mobile" ]; then
        echo "⏭️  Already migrated: $dirname"
        skipped=$((skipped + 1))
        total=$((total + 1))
        continue
    fi
    
    total=$((total + 1))
    
    echo "🔄 Migrating: $dirname"
    
    # Create desktop and mobile directories
    mkdir -p "$projects_dir/desktop"
    mkdir -p "$projects_dir/mobile"
    
    # Move all existing project directories to desktop/ (exclude desktop/ and mobile/ themselves)
    for project in "$projects_dir"/*/; do
        project_name=$(basename "$project")
        if [ -d "$project" ] && [ "$project_name" != "desktop" ] && [ "$project_name" != "mobile" ]; then
            mv "$project" "$projects_dir/desktop/"
            echo "   📦 Moved $project_name → desktop/"
        fi
    done
    
    # Move the 3 workflow markdown docs into projects/desktop/
    for doc in "$discipline_dir"/*workflow*.md "$discipline_dir"/*workflows*.md; do
        if [ -f "$doc" ]; then
            doc_name=$(basename "$doc")
            mv "$doc" "$projects_dir/desktop/"
            echo "   📄 Moved $doc_name → desktop/"
        fi
    done
    
    migrated=$((migrated + 1))
    echo "✅ Done: $dirname"
    echo ""
done

echo "=== Migration Summary ==="
echo "Total disciplines processed: $total"
echo "Migrated: $migrated"
echo "Skipped (already done or no projects): $skipped"
echo ""
echo "Next steps:"
echo "1. Create mobile-specific project stubs for each discipline"
echo "2. Update workflow lists with platform tags"
echo "3. Update workflow implementation docs"