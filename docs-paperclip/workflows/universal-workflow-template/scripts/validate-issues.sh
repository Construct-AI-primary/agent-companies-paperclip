#!/bin/bash

# UNIV-WORKFLOW Issue Validation Script
# Validates all generated issues for completeness and correctness

# set -e  # Don't exit on validation errors - we want to check all files

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
ISSUES_DIR="$PROJECT_DIR/issues"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
total_issues=0
passed_issues=0
failed_issues=0
errors=()

# Validation functions
validate_yaml_frontmatter() {
    local file="$1"
    local filename=$(basename "$file")

    # Check if file starts with ---
    if ! head -n 1 "$file" | grep -q "^---$"; then
        errors+=("$filename: Missing YAML frontmatter start marker")
        return 1
    fi

    # Find the end of frontmatter
    local frontmatter_end=$(grep -n "^---$" "$file" | sed -n '2p' | cut -d: -f1)
    if [ -z "$frontmatter_end" ]; then
        errors+=("$filename: Missing YAML frontmatter end marker")
        return 1
    fi

    # Extract frontmatter
    local frontmatter=$(sed -n "2,${frontmatter_end}p" "$file")

    # Check required fields
    local required_fields=("id" "title" "phase" "status" "priority")
    for field in "${required_fields[@]}"; do
        if ! echo "$frontmatter" | grep -q "^$field:"; then
            errors+=("$filename: Missing required field '$field' in frontmatter")
            return 1
        fi
    done

    return 0
}

validate_id_format() {
    local file="$1"
    local filename=$(basename "$file")

    # Extract ID from frontmatter
    local id=$(grep "^id:" "$file" | head -n 1 | sed 's/id: *//')

    # Check UNIV-XXX format
    if ! echo "$id" | grep -q "^UNIV-[0-9]\{3\}$"; then
        errors+=("$filename: Invalid ID format '$id' (expected UNIV-XXX)")
        return 1
    fi

    # Check ID matches filename
    if ! echo "$filename" | grep -q "^$id-"; then
        errors+=("$filename: ID '$id' doesn't match filename")
        return 1
    fi

    return 0
}

validate_sections() {
    local file="$1"
    local filename=$(basename "$file")

    # Required sections
    local required_sections=("## Description" "## Acceptance Criteria" "## Assigned Company & Agent" "## Dependencies")

    for section in "${required_sections[@]}"; do
        if ! grep -q "^$section" "$file"; then
            errors+=("$filename: Missing required section '$section'")
            return 1
        fi
    done

    # Check acceptance criteria format
    if ! grep -A 10 "## Acceptance Criteria" "$file" | grep -q "^- \[ \]"; then
        errors+=("$filename: Acceptance criteria not properly formatted with checkboxes")
        return 1
    fi

    return 0
}

validate_file_structure() {
    local file="$1"
    local filename=$(basename "$file")

    # Check file ends with metadata
    if ! tail -n 5 "$file" | grep -q "^---$"; then
        errors+=("$filename: Missing file ending metadata")
        return 1
    fi

    # Check for Created/Updated dates
    if ! grep -q "^\\*\\*Created\\*\\*:" "$file"; then
        errors+=("$filename: Missing Created date")
        return 1
    fi

    if ! grep -q "^\\*\\*Updated\\*\\*:" "$file"; then
        errors+=("$filename: Missing Updated date")
        return 1
    fi

    return 0
}

validate_issue_file() {
    local file="$1"
    local filename=$(basename "$file")

    echo -n "Validating $filename... "

    local issue_passed=true

    # Run all validations
    if ! validate_yaml_frontmatter "$file"; then
        issue_passed=false
    fi

    if ! validate_id_format "$file"; then
        issue_passed=false
    fi

    if ! validate_sections "$file"; then
        issue_passed=false
    fi

    if ! validate_file_structure "$file"; then
        issue_passed=false
    fi

    if [ "$issue_passed" = true ]; then
        echo -e "${GREEN}✓ PASSED${NC}"
        ((passed_issues++))
        return 0
    else
        echo -e "${RED}✗ FAILED${NC}"
        ((failed_issues++))
        return 1
    fi
}

# Main validation
echo "🚀 UNIV-WORKFLOW Issue Validation"
printf '%.0s=' {1..60}
echo
echo "Issues Directory: $ISSUES_DIR"
echo

# Check if issues directory exists
if [ ! -d "$ISSUES_DIR" ]; then
    echo -e "${RED}Error: Issues directory not found: $ISSUES_DIR${NC}"
    exit 1
fi

# Count total issues
total_issues=$(find "$ISSUES_DIR" -name "UNIV-*.md" | wc -l)
echo "Found $total_issues issue files to validate"
echo

# Validate each issue file
for issue_file in "$ISSUES_DIR"/UNIV-*.md; do
    if [ -f "$issue_file" ]; then
        validate_issue_file "$issue_file"
    fi
done

echo
printf '%.0s=' {1..60}
echo
echo "VALIDATION SUMMARY"
printf '%.0s=' {1..60}
echo
echo "Total Issues: $total_issues"
echo -e "Passed: ${GREEN}$passed_issues${NC}"
echo -e "Failed: ${RED}$failed_issues${NC}"

# Show errors if any
if [ ${#errors[@]} -gt 0 ]; then
    echo
    echo -e "${RED}ERROR DETAILS:${NC}"
    for error in "${errors[@]}"; do
        echo -e "${RED}• $error${NC}"
    done
fi

echo

# Final status
if [ $failed_issues -eq 0 ]; then
    echo -e "${GREEN}✅ ALL ISSUES PASSED VALIDATION${NC}"
    echo
    echo "Next steps:"
    echo "1. Update ISSUE-GENERATION-STATUS.md to show 25/25 complete"
    echo "2. Update BATCH-IMPORT-READINESS.md status to 'ready-for-import'"
    echo "3. Import issues using issue-batch-importer-paperclipforge agent"
    exit 0
else
    echo -e "${RED}❌ VALIDATION FAILED${NC}"
    echo
    echo "Please fix the errors above and re-run validation."
    exit 1
fi