#!/bin/bash

# Script to add Working Directory & Repository section to all PROC-ORDER issue files
# This ensures all issues have the local repo path information needed for batch import

ISSUES_DIR="docs-paperclip/disciplines/01900-procurement/projects/PROC-ORDER/issues"
LOCAL_REPO_PATH="/Users/_Hermes/paperclip-render"

echo "Adding working directory information to all PROC-ORDER issues..."

# Function to add working directory section to an issue file
add_working_directory() {
    local file="$1"
    local issue_id=$(basename "$file" | sed 's/\.md$//')

    # Check if Working Directory section already exists
    if grep -q "## Working Directory & Repository" "$file"; then
        echo "✓ $issue_id already has working directory section"
        return
    fi

    # Determine target files based on issue type
    local target_files=""
    case "$issue_id" in
        PROC-001*)
            target_files="- ui/src/pages/01900-procurement/components/CreateOrderModal.jsx
  - ui/src/pages/01900-procurement/components/01900-procurement-page.js
  - server/src/routes/procurement-routes.js
  - server/src/services/procurementOrderService.js"
            ;;
        PROC-010*|PROC-011*|PROC-012*|PROC-013*)
            target_files="- server/src/routes/procurement-routes.js
  - server/src/services/procurementOrderService.js
  - server/src/services/sowGenerationService.js
  - packages/db/src/schema/procurement.ts
  - packages/shared/src/types/procurement.ts"
            ;;
        PROC-020*|PROC-021*|PROC-022*|PROC-023*)
            target_files="- docs-construct-ai/disciplines/01900_procurement/testing/
  - ui/src/pages/01900-procurement/components/
  - server/src/routes/procurement-routes.js
  - server/src/services/procurementOrderService.js
  - Test data and configuration files"
            ;;
        PROC-030*|PROC-031*|PROC-032*|PROC-033*)
            target_files="- docs-construct-ai/disciplines/01900_procurement/
  - KnowledgeForge indexing configuration
  - Supplier portal integration files
  - Multi-discipline appendix templates"
            ;;
        PROC-040*|PROC-041*|PROC-042*|PROC-043*)
            target_files="- docs-construct-ai/disciplines/01900_procurement/testing/
  - Procurement readiness dashboard
  - Testing summary templates
  - UX copy and documentation files"
            ;;
        PROC-000*)
            target_files="- docs-paperclip/companies/domainforge-ai/skills/
  - DomainForge procurement agent skill files
  - Shared procurement-testing skill reference"
            ;;
        PROC-002*|PROC-003*)
            target_files="- docs-construct-ai/disciplines/01900_procurement/templates/
  - SOW template files
  - Approval matrix configuration
  - Document ordering management integration"
            ;;
        *)
            target_files="- docs-construct-ai/disciplines/01900_procurement/
  - Related procurement workflow files
  - Testing and configuration files"
            ;;
    esac

    # Create the working directory section
    local working_dir_section="## Working Directory & Repository

- **Local Repository:** $LOCAL_REPO_PATH
- **Working Directory:** $LOCAL_REPO_PATH
- **Target Files:**
$target_files

## Required Skills"

    # Insert the section before "## Required Skills"
    sed -i '' "/## Required Skills/i\\
$working_dir_section
" "$file"

    echo "✓ Added working directory section to $issue_id"
}

# Process all issue files
for issue_file in "$ISSUES_DIR"/*.md; do
    if [[ -f "$issue_file" ]]; then
        add_working_directory "$issue_file"
    fi
done

echo ""
echo "✅ Completed adding working directory information to all PROC-ORDER issues"
echo "All issues now include:"
echo "  - Local repository path: $LOCAL_REPO_PATH"
echo "  - Working directory path: $LOCAL_REPO_PATH"
echo "  - Target files list for the specific issue type"
echo ""
echo "This information will be used by the issue-batch-importer skill"
echo "to properly configure execution paths for agents."