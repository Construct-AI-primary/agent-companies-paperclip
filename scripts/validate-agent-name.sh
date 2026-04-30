#!/bin/bash

# KnowledgeForge AI Agent Name Validation Script
# Validates agent names against established naming standards (Flexible)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print usage
usage() {
    echo "Usage: $0 <agent-name>"
    echo ""
    echo "Validates an agent name against KnowledgeForge AI naming standards."
    echo "Standards: Compound words OR space-separated names (Title Case)"
    echo ""
    echo "Examples:"
    echo "  $0 SystemAdministrator"
    echo "  $0 \"System Administrator\""
    echo "  $0 \"Quality Assurance\""
    echo "  $0 Buyer"
    echo ""
    echo "Exit codes:"
    echo "  0 - Name is valid"
    echo "  1 - Name contains invalid characters"
    echo "  2 - Name is too long"
    echo "  3 - Name is too short"
    echo "  4 - Name is too generic"
    echo "  5 - Name has inconsistent formatting"
}

# Function to validate agent name
validate_agent_name() {
    local name="$1"
    local issues=()

    echo -e "${BLUE}🔍 Validating agent name: '${name}'${NC}"
    echo

    # Check 1: Valid characters (letters, spaces, hyphens for special cases)
    if [[ "$name" =~ [^a-zA-Z[:space:]-] ]]; then
        issues+=("❌ FAIL: Contains invalid special characters (only letters, spaces, and hyphens allowed)")
    else
        echo -e "✅ ${GREEN}Valid characters only${NC}"
    fi

    # Check 2: Length constraints
    if [[ ${#name} -gt 35 ]]; then
        issues+=("❌ FAIL: Too long (>35 characters)")
    elif [[ ${#name} -lt 3 ]]; then
        issues+=("❌ FAIL: Too short (<3 characters)")
    else
        echo -e "✅ ${GREEN}Length OK (${#name} characters)${NC}"
    fi

    # Check 3: Title Case (each word starts with capital) or PascalCase (compound word)
    local is_compound_word=false
    local is_space_separated=false

    # Detect if it's a compound word (no spaces, starts with capital)
    if [[ ! "$name" =~ [[:space:]] ]] && [[ "$name" =~ ^[A-Z] ]]; then
        is_compound_word=true
        echo -e "✅ ${GREEN}Compound word format (PascalCase)${NC}"
    # Detect if it's space-separated (has spaces, each word starts with capital)
    elif [[ "$name" =~ [[:space:]] ]]; then
        is_space_separated=true
        local title_case=true
        local words=($name)
        for word in "${words[@]}"; do
            if [[ ! "$word" =~ ^[A-Z] ]]; then
                title_case=false
                break
            fi
        done

        if [[ "$title_case" == true ]]; then
            echo -e "✅ ${GREEN}Space-separated format (Title Case)${NC}"
        else
            issues+=("❌ FAIL: Space-separated names must be in Title Case")
        fi
    else
        issues+=("❌ FAIL: Must be either compound word (PascalCase) or space-separated (Title Case)")
    fi

    # Check 4: Not too generic (for single words only)
    if [[ "$name" =~ ^[A-Z][a-zA-Z]*$ ]] && [[ ! "$name" =~ [[:space:]] ]]; then
        local generic_words=("Manager" "Administrator" "Specialist" "Coordinator" "Expert" "Officer" "Director")
        local is_generic=false

        for generic in "${generic_words[@]}"; do
            if [[ "$name" == "$generic" ]]; then
                is_generic=true
                break
            fi
        done

        if [[ "$is_generic" == true ]]; then
            issues+=("❌ FAIL: Too generic (add context, e.g., 'SystemManager' or 'System Manager')")
        else
            echo -e "✅ ${GREEN}Descriptive enough${NC}"
        fi
    else
        echo -e "✅ ${GREEN}Multi-word or compound format${NC}"
    fi

    # Report results
    echo
    if [[ ${#issues[@]} -eq 0 ]]; then
        echo -e "${GREEN}🎉 SUCCESS: '${name}' is a valid agent name!${NC}"
        echo
        echo "✅ Meets all KnowledgeForge AI naming standards:"
        if [[ "$is_compound_word" == true ]]; then
            echo "   • Compound word (PascalCase) - follows AIManager pattern"
        elif [[ "$is_space_separated" == true ]]; then
            echo "   • Space-separated (Title Case) - follows 'Coordinator Guardian' pattern"
        fi
        echo "   • Valid characters only"
        echo "   • Appropriate length"
        echo "   • Not too generic"
        return 0
    else
        echo -e "${RED}❌ VALIDATION FAILED${NC}"
        echo
        echo "Issues found:"
        for issue in "${issues[@]}"; do
            echo "   $issue"
        done
        echo
        echo -e "${YELLOW}💡 Suggestions:${NC}"
        echo "   • Use compound words: SystemAdministrator, AIManager, UserManager"
        echo "   • Use space-separated: 'System Administrator', 'Quality Assurance'"
        echo "   • Title Case for spaces: 'User Manager' (not 'user manager')"
        echo "   • Be specific: 'Manager' → 'SystemManager' or 'System Manager'"
        echo "   • Follow existing patterns: AIManager, 'Coordinator Guardian'"
        return 1
    fi
}

# Main script
if [[ $# -ne 1 ]]; then
    usage
    exit 1
fi

agent_name="$1"

# Validate the name
validate_agent_name "$agent_name"
exit_code=$?

echo
echo "Exit code: $exit_code"

exit $exit_code