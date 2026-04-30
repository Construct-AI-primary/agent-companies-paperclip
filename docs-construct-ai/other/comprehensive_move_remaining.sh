#!/bin/bash

# Comprehensive script to categorize and move ALL remaining documentation files

echo "=== COMPREHENSIVE DOCUMENTATION MOVE SCRIPT ==="
echo "Moving ALL remaining files to appropriate functional categories..."
echo ""

# Function to move files by comprehensive categorization
move_comprehensive() {
    local pattern="$1"
    local category="$2"
    local folder="$3"
    
    echo "🔄 Processing $category pattern '$pattern'..."
    
    # Find and move files matching the comprehensive patterns
    find . -maxdepth 1 -name "${pattern}*.md" -not -name "0000_DOCUMENTATION_SYSTEM_REORGANIZATION_TRACKING.md" | while read -r file; do
        if [ -f "$file" ]; then
            local filename=$(basename "$file")
            echo "  📁 $filename → $category ($folder/)"
            mv "$file" "$folder/"
        fi
    done
}

# COMPREHENSIVE CATEGORIZATION - ALL PREFIXES IDENTIFIED

# 0000-0099: Core documentation (KEEP IN ROOT as foundational docs)
echo "📌 Keeping in root: 0000-0099 (Core documentation) - $(find . -maxdepth 1 -name "000[0-9]*.md" -o -name "0000*.md" | wc -l) files"

# Missing categories that should be moved:

# 0050-0059: Rendering/Deployment → Development Tools
echo "🚀 Moving 0050 series: Render/Deployment → Development Tools"
move_comprehensive "005[0-9]" "Development Tools" "development-tools"

# 0060-0069: Testing systems → Development Tools  
echo "🧪 Moving 0060 series: Testing → Development Tools"
move_comprehensive "006[0-9]" "Development Tools" "development-tools"

# 0100-0199: Application Logic
echo "🧠 Moving 0100 series: Application Logic → Application Logic"
move_comprehensive "01[0-9][0-9]" "Application Logic" "application-logic"

# 0170-0179: Modal system → User Interface
echo "🎨 Moving 0170 series: Modal System → User Interface" 
move_comprehensive "017[0-9]" "User Interface" "user-interface"

# 1000-1999: Various application logic → Application Logic
echo "🧠 Moving 1000-1999 series: Application Components → Application Logic"
move_comprehensive "1[0-9][0-9][0-9]" "Application Logic" "application-logic"

# 1600-1699: Document numbering → Data Processing
echo "📊 Moving 1600 series: Document Numbering → Data Processing"
move_comprehensive "16[0-9][0-9]" "Data Processing" "data-processing"

# Special cases - exact matches
echo "🔄 Moving special cases..."

# DEV, DEPLOYMENT, AUTHENTICATION → Development Tools  
move_comprehensive "DEV" "Development Tools" "development-tools"
move_comprehensive "DEPLOYMENT" "Development Tools" "development-tools" 
move_comprehensive "AUTHENTICATION" "Authentication" "authentication"

echo ""
echo "=== MOVE COMPLETED ==="
echo ""

# Comprehensive final count
echo "📊 FINAL FILE DISTRIBUTION:"
total_all=$(find . -name "*.md" | wc -l)

# Count files in each functional category
for dir in pages-disciplines data-processing database-systems user-interface external-services development-tools authentication application-logic legacy-files; do
    if [ -d "$dir" ]; then
        count=$(find "$dir" -name "*.md" 2>/dev/null | wc -l)
        echo "$dir/: $count files"
    fi
done

# Count core docs still in root (0000 series)
core_count=$(find . -maxdepth 1 -name "000[0-9]*.md" -o -name "0000*.md" 2>/dev/null | wc -l)
echo "docs/ (core docs): $core_count files"

# Calculate and verify total
total_moved=$(find pages-disciplines data-processing database-systems user-interface external-services development-tools authentication application-logic legacy-files -name "*.md" 2>/dev/null | wc -l 2>/dev/null || echo "0")
total_remaining=$(find . -maxdepth 1 -name "*.md" -not -name "0000_DOCUMENTATION_SYSTEM_REORGANIZATION_TRACKING.md" | wc -l)

echo ""
echo "📈 SUMMARY:"
echo "Total .md files in system: $total_all"
echo "Files in functional folders: $total_moved"
echo "Core docs in root: $core_count" 
echo "Total remaining: $total_remaining"

expected_total=$((total_moved + core_count))
if [ "$expected_total" -eq "$total_all" ]; then
    echo "✅ ALL FILES ACCOUNTED FOR"
else 
    echo "❌ MISMATCH: Expected $expected_total, got $total_all"
fi

echo ""
echo "🎉 FUNCTIONAL REORGANIZATION COMPLETE!"
