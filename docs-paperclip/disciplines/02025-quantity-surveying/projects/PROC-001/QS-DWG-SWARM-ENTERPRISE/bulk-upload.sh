#!/bin/bash

# QS-DWG-SWARM-ENTERPRISE Bulk Upload Script
# Submits the complete project package to Paperclip via Issue Batch Importer Agent

set -e  # Exit on any error

# Configuration
PROJECT_NAME="QS-DWG-SWARM-ENTERPRISE"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$PROJECT_DIR/../../../.." && pwd)"
MANIFEST_FILE="$PROJECT_DIR/bulk-upload-manifest.json"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Pre-upload validation
validate_upload() {
    log_info "Running pre-upload validation checks..."

    # Check if manifest exists
    if [[ ! -f "$MANIFEST_FILE" ]]; then
        log_error "Bulk upload manifest not found: $MANIFEST_FILE"
        exit 1
    fi

    # Validate JSON syntax
    if ! jq empty "$MANIFEST_FILE" 2>/dev/null; then
        log_error "Invalid JSON in manifest file: $MANIFEST_FILE"
        exit 1
    fi

    # Check all issue files exist
    local issues_count=$(jq '.uploadOrder | length' "$MANIFEST_FILE")
    log_info "Found $issues_count issues to upload"

    for ((i=0; i<issues_count; i++)); do
        local file=$(jq -r ".uploadOrder[$i].file" "$MANIFEST_FILE")
        local filepath="$PROJECT_DIR/$file"

        if [[ ! -f "$filepath" ]]; then
            log_error "Issue file not found: $filepath"
            exit 1
        fi

        log_info "✓ Validated: $file"
    done

    # Check project documentation
    if [[ ! -f "$PROJECT_DIR/project.md" ]]; then
        log_error "Project specification not found: $PROJECT_DIR/project.md"
        exit 1
    fi

    if [[ ! -f "$PROJECT_DIR/README.md" ]]; then
        log_warning "Project README not found: $PROJECT_DIR/README.md"
    fi

    log_success "Pre-upload validation completed successfully"
}

# Generate upload summary
generate_summary() {
    log_info "Generating upload summary..."

    local total_issues=$(jq '.bulkUpload.totalIssues' "$MANIFEST_FILE")
    local total_budget=$(jq '.bulkUpload.totalBudget' "$MANIFEST_FILE")
    local duration=$(jq -r '.bulkUpload.estimatedDuration' "$MANIFEST_FILE")

    echo "=================================================="
    echo "QS-DWG-SWARM-ENTERPRISE Bulk Upload Summary"
    echo "=================================================="
    echo "Project: $PROJECT_NAME"
    echo "Issues: $total_issues"
    echo "Budget: \$$(printf "%'d" $total_budget)"
    echo "Duration: $duration"
    echo "Upload Date: $(date)"
    echo ""
    echo "Issues to be uploaded:"
    echo ""

    local issues_count=$(jq '.uploadOrder | length' "$MANIFEST_FILE")
    for ((i=0; i<issues_count; i++)); do
        local id=$(jq -r ".uploadOrder[$i].id" "$MANIFEST_FILE")
        local title=$(jq -r ".uploadOrder[$i].title" "$MANIFEST_FILE")
        local company=$(jq -r ".uploadOrder[$i].company // .uploadOrder[$i].companies[0]" "$MANIFEST_FILE")
        local priority=$(jq -r ".uploadOrder[$i].priority" "$MANIFEST_FILE")

        printf "%-12s %-8s %-15s %s\n" "$id" "$priority" "$company" "$title"
    done

    echo ""
    echo "=================================================="
}

# Submit to Issue Batch Importer Agent
submit_to_paperclip() {
    log_info "Submitting to Paperclip Issue Batch Importer Agent..."

    # Check if we're in the correct repository
    if [[ ! -d "$REPO_ROOT/.git" ]]; then
        log_error "Not in a git repository. Please run from the paperclip-render repository."
        exit 1
    fi

    # Create a temporary directory for the upload package
    local temp_dir=$(mktemp -d)
    local upload_package="$temp_dir/${PROJECT_NAME}-upload-$(date +%Y%m%d-%H%M%S)"

    log_info "Creating upload package: $upload_package"

    # Copy project files
    mkdir -p "$upload_package"
    cp -r "$PROJECT_DIR"/* "$upload_package/"

    # Create upload metadata
    cat > "$upload_package/upload-metadata.json" << EOF
{
  "uploadType": "bulk-project",
  "projectName": "$PROJECT_NAME",
  "submittedBy": "$(whoami)",
  "submittedAt": "$(date -Iseconds)",
  "repository": "$(basename "$REPO_ROOT")",
  "sourcePath": "${PROJECT_DIR#$REPO_ROOT/}",
  "manifestVersion": "1.0",
  "paperclipAgent": "issue-batch-importer-paperclipforge"
}
EOF

    log_info "Upload package created successfully"
    log_info "Package location: $upload_package"

    # Instructions for manual submission
    echo ""
    echo "=================================================="
    echo "MANUAL SUBMISSION REQUIRED"
    echo "=================================================="
    echo ""
    echo "The upload package has been prepared at:"
    echo "  $upload_package"
    echo ""
    echo "To complete the bulk upload:"
    echo ""
    echo "1. Locate the Issue Batch Importer Agent in Paperclip:"
    echo "   Company: PaperclipForge AI"
    echo "   Agent: issue-batch-importer-paperclipforge"
    echo ""
    echo "2. Submit the upload package:"
    echo "   Command: Upload folder '$upload_package'"
    echo ""
    echo "3. Monitor upload progress:"
    echo "   - Check Paperclip dashboard for issue creation"
    echo "   - Verify all 6 issues are created successfully"
    echo "   - Confirm company assignments are correct"
    echo ""
    echo "4. Post-upload validation:"
    echo "   - All issues should appear in respective company queues"
    echo "   - Master issue QS-DWG-SWARM-001 should be assigned to DevForge AI"
    echo "   - Sub-issues should be distributed across companies as specified"
    echo ""
    echo "Expected Results:"
    echo "  ✓ QS-DWG-SWARM-001: DevForge AI (Critical)"
    echo "  ✓ QSDWG-001: DevForge AI (UI Workflow)"
    echo "  ✓ QSDWG-002: InfraForge AI (OpenCV Engine)"
    echo "  ✓ QSDWG-003: KnowledgeForge AI (QS Standards)"
    echo "  ✓ QSDWG-004: DevForge AI (Enterprise Integration)"
    echo "  ✓ QSDWG-005: QualityForge AI (Testing Framework)"
    echo ""
    echo "=================================================="

    log_success "Bulk upload preparation completed"
    log_info "Upload package ready for submission to Paperclip"
}

# Main execution
main() {
    echo "=================================================="
    echo "QS-DWG-SWARM-ENTERPRISE Bulk Upload Script"
    echo "=================================================="
    echo ""

    # Validate environment
    if ! command -v jq &> /dev/null; then
        log_error "jq is required but not installed. Please install jq to continue."
        exit 1
    fi

    # Run validation
    validate_upload

    # Generate summary
    generate_summary

    # Confirm before proceeding
    echo ""
    read -p "Do you want to proceed with bulk upload preparation? (y/N): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Bulk upload cancelled by user"
        exit 0
    fi

    # Submit to Paperclip
    submit_to_paperclip

    log_success "QS-DWG-SWARM-ENTERPRISE bulk upload process completed"
    log_info "Follow the manual submission instructions above to complete the upload"
}

# Run main function
main "$@"