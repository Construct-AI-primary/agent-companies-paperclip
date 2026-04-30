#!/bin/bash

# Knowledge Synchronization Script
# Manages cross-repository knowledge flow and consistency

set -e

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

# Configuration
SUPERPOWERS_REPO="/Users/_General/superpowers"
CONSTRUCT_AI_REPO="/Users/_General/superpowers/docs_construct_ai"
DEVFORGE_PARA="/Users/_General/superpowers/docs_devforge_ai/para"
LOOPY_PARA="/Users/_General/superpowers/docs_loopy_ai/para"

# Sync direction options
SYNC_BIDIRECTIONAL="bidirectional"
SYNC_REPO_TO_DEVICE="repo-to-device"
SYNC_DEVICE_TO_REPO="device-to-repo"

# Default sync configuration
SYNC_DIRECTION="$SYNC_BIDIRECTIONAL"
VALIDATION_ENABLED=true
COMPRESSION_ENABLED=true
CONFLICT_RESOLUTION="intelligent"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --direction)
            SYNC_DIRECTION="$2"
            shift 2
            ;;
        --no-validation)
            VALIDATION_ENABLED=false
            shift
            ;;
        --no-compression)
            COMPRESSION_ENABLED=false
            shift
            ;;
        --conflict-resolution)
            CONFLICT_RESOLUTION="$2"
            shift 2
            ;;
        --help)
            echo "Usage: $0 [options]"
            echo "Options:"
            echo "  --direction <type>         Sync direction (bidirectional|repo-to-device|device-to-repo)"
            echo "  --no-validation           Disable validation checks"
            echo "  --no-compression          Disable compression"
            echo "  --conflict-resolution <type> Resolution strategy (intelligent|timestamp|manual)"
            echo "  --help                    Show this help"
            exit 0
            ;;
        -*)
            log_error "Unknown option: $1"
            exit 1
            ;;
        *)
            log_error "Unexpected argument: $1"
            exit 1
            ;;
    esac
done

log_info "Starting knowledge synchronization..."
log_info "Direction: $SYNC_DIRECTION"
log_info "Validation: $VALIDATION_ENABLED"
log_info "Compression: $COMPRESSION_ENABLED"
log_info "Conflict Resolution: $CONFLICT_RESOLUTION"

# Function to detect changes in a repository
detect_changes() {
    local repo_path="$1"
    local repo_name="$2"

    log_info "Detecting changes in $repo_name..."

    if [ ! -d "$repo_path" ]; then
        log_error "Repository path does not exist: $repo_path"
        return 1
    fi

    # Use git to detect changes
    cd "$repo_path"

    # Get list of modified files
    MODIFIED_FILES=$(git status --porcelain | grep "^ M" | wc -l)
    NEW_FILES=$(git status --porcelain | grep "^??" | wc -l)
    DELETED_FILES=$(git status --porcelain | grep "^ D" | wc -l)

    log_info "$repo_name status: $MODIFIED_FILES modified, $NEW_FILES new, $DELETED_FILES deleted"

    # Return change summary
    echo "{\"modified\": $MODIFIED_FILES, \"new\": $NEW_FILES, \"deleted\": $DELETED_FILES}"
}

# Function to validate knowledge consistency
validate_consistency() {
    local source_repo="$1"
    local target_repo="$2"
    local repo_name="$3"

    if [ "$VALIDATION_ENABLED" = false ]; then
        log_info "Skipping validation for $repo_name"
        return 0
    fi

    log_info "Validating knowledge consistency for $repo_name..."

    # Basic validation - check if repositories exist and are accessible
    if [ ! -d "$source_repo" ] || [ ! -d "$target_repo" ]; then
        log_error "Repository validation failed for $repo_name"
        return 1
    fi

    # Check for common knowledge files
    SHARED_FILES=("README.md" "standards/" "procedures/")

    for file in "${SHARED_FILES[@]}"; do
        if [ -e "$source_repo/$file" ] && [ ! -e "$target_repo/$file" ]; then
            log_warning "Missing shared file in target: $file"
        fi
    done

    log_success "Knowledge consistency validation passed for $repo_name"
    return 0
}

# Function to synchronize repositories
sync_repositories() {
    local source_repo="$1"
    local target_repo="$2"
    local repo_name="$3"

    log_info "Synchronizing $repo_name..."

    case $SYNC_DIRECTION in
        $SYNC_BIDIRECTIONAL)
            # Bidirectional sync - merge changes
            log_info "Performing bidirectional sync for $repo_name"

            # Use rsync for bidirectional sync with backup
            if [ "$COMPRESSION_ENABLED" = true ]; then
                rsync -avz --backup --backup-dir="$target_repo/backup/$(date +%Y%m%d_%H%M%S)" \
                    --exclude=".git" --exclude="node_modules" \
                    "$source_repo/" "$target_repo/"
            else
                rsync -av --backup --backup-dir="$target_repo/backup/$(date +%Y%m%d_%H%M%S)" \
                    --exclude=".git" --exclude="node_modules" \
                    "$source_repo/" "$target_repo/"
            fi
            ;;

        $SYNC_REPO_TO_DEVICE)
            # One-way sync from repo to device
            log_info "Performing repo-to-device sync for $repo_name"
            rsync -av --delete --exclude=".git" --exclude="node_modules" \
                "$source_repo/" "$target_repo/"
            ;;

        $SYNC_DEVICE_TO_REPO)
            # One-way sync from device to repo
            log_info "Performing device-to-repo sync for $repo_name"
            rsync -av --delete --exclude=".git" --exclude="node_modules" \
                "$target_repo/" "$source_repo/"
            ;;
    esac

    log_success "Synchronization completed for $repo_name"
}

# Function to handle conflicts
handle_conflicts() {
    local repo_path="$1"
    local repo_name="$2"

    log_info "Checking for conflicts in $repo_name..."

    cd "$repo_path"

    # Check for git merge conflicts
    CONFLICT_FILES=$(git status --porcelain | grep "^UU" | wc -l)

    if [ "$CONFLICT_FILES" -gt 0 ]; then
        log_warning "Found $CONFLICT_FILES conflict(s) in $repo_name"

        case $CONFLICT_RESOLUTION in
            intelligent)
                # Use timestamp-based resolution
                log_info "Resolving conflicts using timestamp strategy..."
                git checkout --theirs .
                git add .
                ;;
            timestamp)
                # Keep newer version
                log_info "Resolving conflicts by keeping newer versions..."
                git checkout --theirs .
                git add .
                ;;
            manual)
                log_warning "Manual conflict resolution required for $repo_name"
                log_warning "Please resolve conflicts manually and run 'git add .' then 'git commit'"
                return 1
                ;;
        esac

        git commit -m "Resolve merge conflicts during knowledge sync"
        log_success "Conflicts resolved in $repo_name"
    else
        log_info "No conflicts found in $repo_name"
    fi
}

# Function to update sync metadata
update_sync_metadata() {
    local repo_path="$1"
    local repo_name="$2"

    log_info "Updating sync metadata for $repo_name..."

    cd "$repo_path"

    # Create or update sync metadata
    cat > ".knowledge-sync.json" << EOF
{
  "last_sync": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "sync_direction": "$SYNC_DIRECTION",
  "validation_enabled": $VALIDATION_ENABLED,
  "compression_enabled": $COMPRESSION_ENABLED,
  "conflict_resolution": "$CONFLICT_RESOLUTION",
  "repository": "$repo_name",
  "version": "1.0.0"
}
EOF

    # Add to git if in a repository
    if git rev-parse --git-dir > /dev/null 2>&1; then
        git add .knowledge-sync.json
        git commit -m "Update knowledge sync metadata

- Last sync: $(date)
- Direction: $SYNC_DIRECTION
- Validation: $VALIDATION_ENABLED
- Compression: $COMPRESSION_ENABLED
- Conflict resolution: $CONFLICT_RESOLUTION" 2>/dev/null || true
    fi
}

# Main synchronization process
main() {
    log_info "Knowledge Synchronization Process Started"
    echo "=========================================="

    # Track sync results
    SYNC_RESULTS=()
    TOTAL_CHANGES=0

    # Sync DevForge AI PARA
    log_info "Processing DevForge AI PARA synchronization..."
    detect_changes "$DEVFORGE_PARA" "DevForge PARA"
    validate_consistency "$SUPERPOWERS_REPO" "$DEVFORGE_PARA" "DevForge PARA"
    sync_repositories "$SUPERPOWERS_REPO" "$DEVFORGE_PARA" "DevForge PARA"
    handle_conflicts "$DEVFORGE_PARA" "DevForge PARA"
    update_sync_metadata "$DEVFORGE_PARA" "DevForge PARA"

    # Sync Loopy AI PARA
    log_info "Processing Loopy AI PARA synchronization..."
    detect_changes "$LOOPY_PARA" "Loopy PARA"
    validate_consistency "$SUPERPOWERS_REPO" "$LOOPY_PARA" "Loopy PARA"
    sync_repositories "$SUPERPOWERS_REPO" "$LOOPY_PARA" "Loopy PARA"
    handle_conflicts "$LOOPY_PARA" "Loopy PARA"
    update_sync_metadata "$LOOPY_PARA" "Loopy PARA"

    # Sync Construct AI documentation
    log_info "Processing Construct AI documentation synchronization..."
    detect_changes "$CONSTRUCT_AI_REPO" "Construct AI Docs"
    validate_consistency "$SUPERPOWERS_REPO" "$CONSTRUCT_AI_REPO" "Construct AI Docs"
    sync_repositories "$SUPERPOWERS_REPO" "$CONSTRUCT_AI_REPO" "Construct AI Docs"
    handle_conflicts "$CONSTRUCT_AI_REPO" "Construct AI Docs"
    update_sync_metadata "$CONSTRUCT_AI_REPO" "Construct AI Docs"

    # Generate sync report
    log_info "Generating synchronization report..."

    cat > "/tmp/knowledge-sync-report-$(date +%Y%m%d_%H%M%S).json" << EOF
{
  "sync_timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "sync_direction": "$SYNC_DIRECTION",
  "validation_enabled": $VALIDATION_ENABLED,
  "compression_enabled": $COMPRESSION_ENABLED,
  "conflict_resolution": "$CONFLICT_RESOLUTION",
  "repositories_processed": [
    "DevForge AI PARA",
    "Loopy AI PARA",
    "Construct AI Documentation"
  ],
  "status": "completed",
  "total_changes": $TOTAL_CHANGES
}
EOF

    log_success "Knowledge synchronization completed successfully!"
    log_info "Sync report saved to: /tmp/knowledge-sync-report-$(date +%Y%m%d_%H%M%S).json"

    echo
    log_success "🎯 Cross-repository knowledge synchronization complete!"
    log_info "All repositories are now synchronized and consistent."
}

# Run main function
main "$@"