#!/bin/bash
# ============================================================================
# Hermes Agent Profile Switcher
# ============================================================================
# Interactive profile selection for Hermes Agent.
# Run directly to launch the UI, or with an argument to switch directly.
#
# Usage:
#   ./switch-profile.sh              # Interactive menu
#   ./switch-profile.sh forge        # Direct switch to profile
#   ./switch-profile.sh forge "task" # Run task with profile
# ============================================================================

set -e
cd "$(dirname "$0")"

HOME_DIR="$HOME"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'
BOLD='\033[1m'

# Print profile menu
print_menu() {
  echo ""
  echo -e "${CYAN}╔══════════════════════════════════════════════════════╗${NC}"
  echo -e "${CYAN}║${NC}          ${BOLD}⚕  Hermes Agent Profile Switcher  ${NC}          ${CYAN}║${NC}"
  echo -e "${CYAN}╠══════════════════════════════════════════════════════╣${NC}"
  
  echo -e "${CYAN}║${NC}                                                   ${CYAN}║${NC}"
  echo -e "${CYAN}║${NC}  ${BOLD}👔 Select Agent Profile:${NC}                      ${CYAN}║${NC}"
  echo -e "${CYAN}║${NC}                                                   ${CYAN}║${NC}"
  echo -e "${CYAN}║${NC}  1. 👑  ${BOLD}Orion${NC}      — Executive orchestration & governance  ${CYAN}║${NC}"
  echo -e "${CYAN}║${NC}  2. 🔧  ${BOLD}Forge${NC}     — Development & system architecture     ${CYAN}║${NC}"
  echo -e "${CYAN}║${NC}  3. ⚕  ${BOLD}Sage${NC}      — Prompt engineering & QA               ${CYAN}║${NC}"
  echo -e "${CYAN}║${NC}  4. 🧭  ${BOLD}Strategos${NC} — Strategy, market analysis & UX         ${CYAN}║${NC}"
  echo -e "${CYAN}║${NC}  5. 🛡️  ${BOLD}Guardian${NC}  — Security, compliance & risk            ${CYAN}║${NC}"
  echo -e "${CYAN}║${NC}  6. 📋  ${BOLD}Status${NC}   — Show current profile                  ${CYAN}║${NC}"
  echo -e "${CYAN}║${NC}                                                   ${CYAN}║${NC}"
  echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}"
  echo ""
}

# Show profile info
show_status() {
  echo ""
  echo -e "${CYAN}┌─ Profile Status ─────────────────────────────────────┐${NC}"
  echo -e "${CYAN}│${NC}  Current Profile: ${BOLD}${SELECTED_PROFILE}${NC}                  ${CYAN}│${NC}"
  echo -e "${CYAN}│${NC}  Memory Dir:      ${BOLD}${MEMORY_DIR}${NC}   ${CYAN}│${NC}"
  echo -e "${CYAN}│${NC}  MEMORY.md:       $([ -f "${MEMORY_DIR}/MEMORY.md" ] && echo "${GREEN}✓${NC} exists" || echo "${RED}✗${NC} missing")      ${CYAN}│${NC}"
  echo -e "${CYAN}│${NC}  USER.md:         $([ -f "${MEMORY_DIR}/USER.md" ] && echo "${GREEN}✓${NC} exists" || echo "${RED}✗${NC} missing")         ${CYAN}│${NC}"
  echo -e "${CYAN}│${NC}  API Key Set:     $([ -f ".env" ] && grep -q "OPENROUTER_API_KEY=sk" .env 2>/dev/null && echo "${GREEN}✓${NC} configured" || echo "${RED}✗${NC} not set")  ${CYAN}│${NC}"
  echo -e "${CYAN}└──────────────────────────────────────────────────────┘${NC}"
  echo ""
}

# Run task with selected profile
run_task() {
  local task="$1"
  echo ""
  echo -e "${GREEN}╔══════════════════════════════════════════════════════╗${NC}"
  echo -e "${GREEN}║${NC}  🚀 Running Hermes Agent with profile: ${BOLD}${SELECTED_PROFILE}${NC}       ${GREEN}║${NC}"
  echo -e "${GREEN}╚══════════════════════════════════════════════════════╝${NC}"
  echo ""
  
  cd "$(dirname "$0")/.."
  HERMES_MEMORY_DIR="${MEMORY_DIR}" bash hermes_agent/run.sh "$task"
}

# Handle direct profile switch from argument
if [ -n "$1" ] && [ "$1" != "status" ]; then
  PROFILE_NAME="$1"
  shift
  
  case "$PROFILE_NAME" in
    orion|1)
      SELECTED_PROFILE="Orion"
      MEMORY_DIR="$HOME_DIR/.hermes-memory"
      ;;
    forge|2)
      SELECTED_PROFILE="Forge"
      MEMORY_DIR="$HOME_DIR/.hermes-memory-forge"
      ;;
    sage|3)
      SELECTED_PROFILE="Sage"
      MEMORY_DIR="$HOME_DIR/.hermes-memory-quality"
      ;;
    strategos|4)
      SELECTED_PROFILE="Strategos"
      MEMORY_DIR="$HOME_DIR/.hermes-memory-strategy"
      ;;
    guardian|5)
      SELECTED_PROFILE="Guardian"
      MEMORY_DIR="$HOME_DIR/.hermes-memory-guardian"
      ;;
    *)
      echo -e "  ${RED}✗${NC} Unknown profile: ${YELLOW}$PROFILE_NAME${NC}"
      echo -e "  ${NC}Valid profiles: orion(1), forge(2), sage(3), strategos(4), guardian(5)"
      exit 1
      ;;
  esac
  
  if [ -n "$1" ]; then
    # Run task directly
    run_task "$*"
  else
    show_status
    echo -e "${GREEN}✓${NC} Switched to ${BOLD}${SELECTED_PROFILE}${NC} profile"
    echo -e "${NC}Run tasks with: ${CYAN}HERMES_MEMORY_DIR=${MEMORY_DIR} bash hermes_agent/run.sh \"your task\"${NC}"
    echo ""
    # Export for current session
    export HERMES_MEMORY_DIR="${MEMORY_DIR}"
    echo -e "${NC}HERMES_MEMORY_DIR has been set for this session."
  fi
  exit 0
fi

# Show status only
if [ "$1" = "status" ]; then
  # Read current profile from environment or default
  CURRENT="${HERMES_MEMORY_DIR:-$HOME_DIR/.hermes-memory}"
  case "$CURRENT" in
    "$HOME_DIR/.hermes-memory") CURRENT_NAME="Orion (Default)" ;;
    "$HOME_DIR/.hermes-memory-forge") CURRENT_NAME="Forge" ;;
    "$HOME_DIR/.hermes-memory-quality") CURRENT_NAME="Sage" ;;
    "$HOME_DIR/.hermes-memory-strategy") CURRENT_NAME="Strategos" ;;
    "$HOME_DIR/.hermes-memory-guardian") CURRENT_NAME="Guardian" ;;
    *) CURRENT_NAME="Unknown" ;;
  esac
  echo ""
  echo -e "${CYAN}┌─ Current Profile ──────────────────────────────────┐${NC}"
  echo -e "${CYAN}│${NC}  Profile: ${BOLD}${CURRENT_NAME}${NC}                                      ${CYAN}│${NC}"
  echo -e "${CYAN}│${NC}  Dir:     ${BOLD}${CURRENT}${NC}                           ${CYAN}│${NC}"
  echo -e "${CYAN}└──────────────────────────────────────────────────────┘${NC}"
  echo ""
  exit 0
fi

# Interactive mode
print_menu

while true; do
  read -p "  Enter choice (1-6): " choice
  
  case "$choice" in
    1) SELECTED_PROFILE="Orion"; MEMORY_DIR="$HOME_DIR/.hermes-memory"; break ;;
    2) SELECTED_PROFILE="Forge"; MEMORY_DIR="$HOME_DIR/.hermes-memory-forge"; break ;;
    3) SELECTED_PROFILE="Sage"; MEMORY_DIR="$HOME_DIR/.hermes-memory-quality"; break ;;
    4) SELECTED_PROFILE="Strategos"; MEMORY_DIR="$HOME_DIR/.hermes-memory-strategy"; break ;;
    5) SELECTED_PROFILE="Guardian"; MEMORY_DIR="$HOME_DIR/.hermes-memory-guardian"; break ;;
    6) 
      # Show current profile
      CURRENT="${HERMES_MEMORY_DIR:-$HOME_DIR/.hermes-memory}"
      case "$CURRENT" in
        "$HOME_DIR/.hermes-memory") echo -e "  ${CYAN}↦${NC} Current profile: ${BOLD}Orion${NC} (default)" ;;
        "$HOME_DIR/.hermes-memory-forge") echo -e "  ${CYAN}↦${NC} Current profile: ${BOLD}Forge${NC}" ;;
        "$HOME_DIR/.hermes-memory-quality") echo -e "  ${CYAN}↦${NC} Current profile: ${BOLD}Sage${NC}" ;;
        "$HOME_DIR/.hermes-memory-strategy") echo -e "  ${CYAN}↦${NC} Current profile: ${BOLD}Strategos${NC}" ;;
        "$HOME_DIR/.hermes-memory-guardian") echo -e "  ${CYAN}↦${NC} Current profile: ${BOLD}Guardian${NC}" ;;
        *) echo -e "  ${CYAN}↦${NC} Current profile: ${BOLD}Unknown${NC} ($CURRENT)" ;;
      esac
      echo ""
      print_menu
      continue 
      ;;
    *) echo -e "  ${RED}✗${NC} Invalid choice. Enter 1-6."; echo ""; continue ;;
  esac
done

echo ""
echo -e "  ${GREEN}✓${NC} Switched to: ${BOLD}${SELECTED_PROFILE}${NC}"
echo -e "  ${NC}Memory directory: ${CYAN}${MEMORY_DIR}${NC}"
echo ""

# Ask for task
read -p "  Enter task description (or press Enter to exit): " task_input

if [ -n "$task_input" ]; then
  echo ""
  echo -e "${GREEN}╔══════════════════════════════════════════════════════╗${NC}"
  echo -e "${GREEN}║${NC}  🚀 Running Hermes Agent with profile: ${BOLD}${SELECTED_PROFILE}${NC}       ${GREEN}║${NC}"
  echo -e "${GREEN}╚══════════════════════════════════════════════════════╝${NC}"
  echo ""
  
  cd "$(dirname "$0")/.."
  HERMES_MEMORY_DIR="${MEMORY_DIR}" bash hermes_agent/run.sh "$task_input"
else
  echo ""
  echo -e "  ${CYAN}↦${NC} To run a task with this profile:"
  echo -e "  ${CYAN}${NC}HERMES_MEMORY_DIR=${MEMORY_DIR} bash hermes_agent/run.sh \"your task\"${NC}"
  echo ""
  echo -e "  ${CYAN}↦${NC} Or set for this session:"
  echo -e "  ${CYAN}${NC}export HERMES_MEMORY_DIR=${MEMORY_DIR}${NC}"
  echo ""
  exit 0
fi