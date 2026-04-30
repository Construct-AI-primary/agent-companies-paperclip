#!/bin/bash

# DevForge AI Company Setup Script
# Initializes company structure and PARA framework

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

# Default values
COMPANY_NAME=""
TEMPLATE="standard"
AGENTS=0
DISCIPLINES=0
PARA_STRUCTURE="basic"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --template)
            TEMPLATE="$2"
            shift 2
            ;;
        --agents)
            AGENTS="$2"
            shift 2
            ;;
        --disciplines)
            DISCIPLINES="$2"
            shift 2
            ;;
        --para-structure)
            PARA_STRUCTURE="$2"
            shift 2
            ;;
        -*)
            log_error "Unknown option: $1"
            echo "Usage: $0 <company-name> [options]"
            echo "Options:"
            echo "  --template <type>        Company template (enterprise|creative|standard)"
            echo "  --agents <count>         Number of agents"
            echo "  --disciplines <count>    Number of disciplines"
            echo "  --para-structure <type>  PARA structure (full|standard|basic)"
            exit 1
            ;;
        *)
            if [ -z "$COMPANY_NAME" ]; then
                COMPANY_NAME="$1"
            else
                log_error "Multiple company names specified"
                exit 1
            fi
            shift
            ;;
    esac
done

# Validate inputs
if [ -z "$COMPANY_NAME" ]; then
    log_error "Company name is required"
    echo "Usage: $0 <company-name> [options]"
    exit 1
fi

# Validate template
case $TEMPLATE in
    enterprise|creative|standard)
        ;;
    *)
        log_error "Invalid template: $TEMPLATE"
        log_error "Valid templates: enterprise, creative, standard"
        exit 1
        ;;
esac

# Validate PARA structure
case $PARA_STRUCTURE in
    full|standard|basic)
        ;;
    *)
        log_error "Invalid PARA structure: $PARA_STRUCTURE"
        log_error "Valid structures: full, standard, basic"
        exit 1
        ;;
esac

log_info "Setting up company: $COMPANY_NAME"
log_info "Template: $TEMPLATE"
log_info "Agents: $AGENTS"
log_info "Disciplines: $DISCIPLINES"
log_info "PARA Structure: $PARA_STRUCTURE"

# Use existing company directory structure
COMPANY_DIR="docs_${COMPANY_NAME}_ai"
# Handle special case for existing directories
if [ "$COMPANY_NAME" = "devforge-ai" ] && [ -d "docs_devforge_ai" ]; then
    COMPANY_DIR="docs_devforge_ai"
elif [ "$COMPANY_NAME" = "loopy-ai" ] && [ -d "docs_loopy_ai" ]; then
    COMPANY_DIR="docs_loopy_ai"
fi
if [ ! -d "$COMPANY_DIR" ]; then
    log_error "Company directory $COMPANY_DIR does not exist"
    log_error "Please ensure the company directory exists before running setup"
    exit 1
fi

log_info "Using existing company directory: $COMPANY_DIR"

# Create agents directory
log_info "Setting up agents directory..."
mkdir -p "$COMPANY_DIR/agents"

# Create agent registry based on template
case $TEMPLATE in
    enterprise)
        AGENT_TYPES=("executive" "strategy" "product" "engineering" "data" "security" "revenue")
        ;;
    creative)
        AGENT_TYPES=("creative" "technical" "design" "content" "strategy")
        ;;
    standard)
        AGENT_TYPES=("core" "support" "analysis")
        ;;
esac

# Generate agent registry
cat > "$COMPANY_DIR/agents/agent-registry.json" << EOF
{
  "company": "$COMPANY_NAME",
  "template": "$TEMPLATE",
  "total_agents": $AGENTS,
  "disciplines": $DISCIPLINES,
  "agents": [
EOF

AGENT_COUNT=0
for type in "${AGENT_TYPES[@]}"; do
    case $type in
        executive)
            AGENTS_IN_TYPE=5
            ;;
        strategy)
            AGENTS_IN_TYPE=7
            ;;
        product)
            AGENTS_IN_TYPE=7
            ;;
        engineering)
            AGENTS_IN_TYPE=11
            ;;
        data)
            AGENTS_IN_TYPE=8
            ;;
        security)
            AGENTS_IN_TYPE=6
            ;;
        revenue)
            AGENTS_IN_TYPE=7
            ;;
        creative)
            AGENTS_IN_TYPE=10
            ;;
        technical)
            AGENTS_IN_TYPE=8
            ;;
        design)
            AGENTS_IN_TYPE=4
            ;;
        content)
            AGENTS_IN_TYPE=3
            ;;
        core)
            AGENTS_IN_TYPE=5
            ;;
        support)
            AGENTS_IN_TYPE=3
            ;;
        analysis)
            AGENTS_IN_TYPE=2
            ;;
    esac

    for ((i=1; i<=AGENTS_IN_TYPE && AGENT_COUNT<AGENTS; i++)); do
        AGENT_ID="${type}_${i}"
        cat >> "$COMPANY_DIR/agents/agent-registry.json" << EOF
    {
      "id": "$AGENT_ID",
      "type": "$type",
      "company": "$COMPANY_NAME",
      "capabilities": ["${type}_operations"],
      "memory_profile": "$TEMPLATE",
      "status": "initialized"
    }
EOF

        if [ $((AGENT_COUNT + 1)) -lt $AGENTS ]; then
            echo "," >> "$COMPANY_DIR/agents/agent-registry.json"
        fi

        AGENT_COUNT=$((AGENT_COUNT + 1))
    done
done

cat >> "$COMPANY_DIR/agents/agent-registry.json" << EOF
  ]
}
EOF

log_success "Created agent registry with $AGENT_COUNT agents"

# Set up PARA structure
log_info "Setting up PARA structure..."
mkdir -p "$COMPANY_DIR/para"

# Create PARA directories based on structure type
case $PARA_STRUCTURE in
    full)
        PARA_DIRS=("projects" "areas" "resources" "archives" "pages")
        ;;
    standard)
        PARA_DIRS=("projects" "areas" "resources" "archives")
        ;;
    basic)
        PARA_DIRS=("projects" "areas" "resources")
        ;;
esac

for dir in "${PARA_DIRS[@]}"; do
    mkdir -p "$COMPANY_DIR/para/$dir"

    # Capitalize first letter of directory name
    DIR_CAPITALIZED="$(tr '[:lower:]' '[:upper:]' <<< ${dir:0:1})${dir:1}"

    # Handle plural forms
    if [ "$dir" = "archives" ]; then
        ITEM_TYPE="archive"
    else
        ITEM_TYPE="${dir%s}"
    fi

    cat > "$COMPANY_DIR/para/$dir/README.md" << EOF
# $COMPANY_NAME PARA - $DIR_CAPITALIZED

This directory contains ${COMPANY_NAME}'s $dir within the PARA knowledge management system.

## Purpose
$DIR_CAPITALIZED represent ongoing work and responsibilities that require regular attention and management.

## Organization
- Each subdirectory represents a specific $ITEM_TYPE
- Documentation follows the company's knowledge standards
- Regular review and maintenance required

## Maintenance
- Review monthly for relevance
- Archive completed items to archives/
- Update status and priorities regularly

---
*Generated for $COMPANY_NAME on $(date)*
EOF
done

# Create sync directory for cross-device synchronization
mkdir -p "$COMPANY_DIR/para/sync"
cat > "$COMPANY_DIR/para/sync/config.json" << EOF
{
  "company": "$COMPANY_NAME",
  "sync_targets": ["openclaw-device"],
  "frequency": "real-time",
  "conflict_resolution": "company-wins",
  "compression": true,
  "encryption": true
}
EOF

# Create deployment directory
mkdir -p "$COMPANY_DIR/para/deployment"
cat > "$COMPANY_DIR/para/deployment/openclaw-integration.md" << EOF
# $COMPANY_NAME OpenClaw Integration

## Company Configuration
- **Company**: $COMPANY_NAME
- **Template**: $TEMPLATE
- **Agents**: $AGENTS
- **Disciplines**: $DISCIPLINES
- **PARA Structure**: $PARA_STRUCTURE

## Integration Points
- **Agent Registration**: Automatic registration with OpenClaw
- **Memory Systems**: Hierarchical knowledge access
- **Synchronization**: Real-time PARA sync with OpenClaw
- **Monitoring**: Health checks and performance monitoring

## Deployment Checklist
- [ ] PARA structure initialized
- [ ] Agent registry created
- [ ] OpenClaw company environment configured
- [ ] Memory systems integrated
- [ ] Synchronization enabled
- [ ] Monitoring activated

## Success Metrics
- [ ] All agents registered with OpenClaw
- [ ] PARA knowledge accessible via memory systems
- [ ] Real-time synchronization operational
- [ ] Performance meets targets (<50ms query response)

---
*Generated for $COMPANY_NAME on $(date)*
EOF

# Create company README
cat > "$COMPANY_DIR/README.md" << EOF
# $COMPANY_NAME Autonomous Company

## Overview
$COMPANY_NAME is an autonomous AI company operating within the DevForge AI ecosystem.

## Configuration
- **Template**: $TEMPLATE
- **Agents**: $AGENTS
- **Disciplines**: $DISCIPLINES
- **PARA Structure**: $PARA_STRUCTURE

## Structure
- **agents/**: Agent definitions and registry
- **para/**: PARA knowledge management system
  - **projects/**: Active initiatives
  - **areas/**: Ongoing responsibilities
  - **resources/**: Reference materials
  - **archives/**: Historical knowledge
  - **pages/**: Discipline-specific documentation (if applicable)
  - **sync/**: Cross-device synchronization
  - **deployment/**: OpenClaw integration

## Integration
This company integrates with:
- **OpenClaw**: Distributed processing and memory systems
- **DevForge AI**: Enterprise orchestration and coordination
- **Construct AI**: Application codebase and documentation
- **Shared Resources**: Cross-company frameworks and standards

## Operations
- Agents operate autonomously within their defined roles
- PARA system manages knowledge and project coordination
- OpenClaw provides distributed processing capabilities
- Real-time synchronization maintains knowledge consistency

---
*Generated on $(date)*
EOF

# Initialize git if in a git repository
if git rev-parse --git-dir > /dev/null 2>&1; then
    log_info "Adding company structure to git..."
    git add "$COMPANY_DIR"
    git commit -m "Initialize $COMPANY_NAME autonomous company

- Company template: $TEMPLATE
- Agent count: $AGENTS
- Discipline count: $DISCIPLINES
- PARA structure: $PARA_STRUCTURE
- OpenClaw integration prepared"
fi

log_success "Company $COMPANY_NAME setup complete!"
log_info "Next steps:"
log_info "1. Review and customize agent configurations in $COMPANY_DIR/agents/"
log_info "2. Set up PARA content in $COMPANY_DIR/para/"
log_info "3. Configure OpenClaw integration"
log_info "4. Test agent registration and operation"

echo
log_success "🎉 $COMPANY_NAME autonomous company initialized successfully!"