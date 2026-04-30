#!/bin/bash

# Script to categorize and move documentation files to appropriate sub-folders

echo "Starting documentation categorization and move process..."

# Function to move files based on prefix pattern
move_by_category() {
    local pattern="$1"
    local category="$2"
    local folder="$3"
    
    echo "Moving files with pattern '$pattern' to $folder..."
    
    # Find and move files matching the pattern
    find . -maxdepth 1 -name "${pattern}*.md" -not -name "0000_DOCUMENTATION_SYSTEM_REORGANIZATION_TRACKING.md" | while read -r file; do
        if [ -f "$file" ]; then
            echo "  Moving: $file → $folder/"
            mv "$file" "$folder/"
        fi
    done
}

# Categorize and move files according to our established rules

# 0000-0099: Core documentation → Multiple categories (keep in root or move to appropriate folders)
echo "=== Processing 0000-0099: Core documentation ==="
# These largely stay as they are mixed across categories

# 0010-0199: Development Tools → 1500
echo "=== Processing 0010-0199: Development Tools ==="
move_by_category "001[0-9]" "Development Tools" "development-tools"

# 0200-0299: External Services → 0200
echo "=== Processing 0200-0299: External Services ==="
move_by_category "02[0-9][0-9]" "External Services" "external-services"

# 0300-0399: Database Systems → 0300
echo "=== Processing 0300-0399: Database Systems ==="
move_by_category "03[0-9][0-9]" "Database Systems" "database-systems"

# 0400-0699: User Interface → 0750
echo "=== Processing 0400-0699: User Interface ==="
move_by_category "04[0-9][0-9]" "User Interface" "user-interface"
move_by_category "05[0-9][0-9]" "User Interface" "user-interface"
move_by_category "06[0-9][0-9]" "User Interface" "user-interface"

# 0700-0999: User Interface → 0750  
echo "=== Processing 0700-0999: User Interface ==="
move_by_category "07[0-9][0-9]" "User Interface" "user-interface"
move_by_category "08[0-9][0-9]" "User Interface" "user-interface"
move_by_category "09[0-9][0-9]" "User Interface" "user-interface"

# 0975: Accordion UI components → 0750
move_by_category "0975" "UI Accordion" "user-interface"

# 1300-XXXX: Pages & Disciplines → 1300
echo "=== Processing 1300-XXXX: Pages & Disciplines ==="
move_by_category "1300" "Pages & Disciplines" "pages-disciplines"

# 1350-1399: Data Processing → 0500
echo "=== Processing 1350-1399: Data Processing ==="
move_by_category "135[0-9]" "Data Processing" "data-processing"
move_by_category "136[0-9]" "Data Processing" "data-processing"
move_by_category "137[0-9]" "Data Processing" "data-processing"
move_by_category "138[0-9]" "Data Processing" "data-processing"
move_by_category "139[0-9]" "Data Processing" "data-processing"

# 1400-1499: User Interface → 0750
echo "=== Processing 1400-1499: User Interface ==="
move_by_category "14[0-9][0-9]" "User Interface" "user-interface"

# 1500-1599: Development Tools → 1500
echo "=== Processing 1500-1599: Development Tools ==="
move_by_category "15[0-9][0-9]" "Development Tools" "development-tools"

# 9999: Migrations → legacy-files or appropriate category
echo "=== Processing 9999: Migration files ==="
move_by_category "9999" "Migration Files" "legacy-files"

echo "Categorization and move process completed!"

# Count files moved to each category
echo ""
echo "File counts by category:"
for dir in pages-disciplines data-processing database-systems user-interface external-services development-tools authentication application-logic legacy-files; do
    if [ -d "$dir" ]; then
        count=$(find "$dir" -name "*.md" | wc -l)
        echo "  $dir: $count files"
    fi
done

# Check remaining files in root
remaining=$(find . -maxdepth 1 -name "*.md" -not -name "0000_DOCUMENTATION_SYSTEM_REORGANIZATION_TRACKING.md" | wc -l)
echo "  Remaining in root: $remaining files"
