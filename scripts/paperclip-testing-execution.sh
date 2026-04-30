#!/bin/bash
# Paperclip Production Testing - Manual Phase Execution
# Run each phase sequentially. After completing a phase, run the next one.
#
# Usage: ./scripts/paperclip-testing-execution.sh [phase_number]
#   phase_number: 1-5 (default: shows status)
#
# Example: ./scripts/paperclip-testing-execution.sh 1

set -e

PAPERCLIP_URL="https://paperclip-render.onrender.com"
COMPANY_ID="f535f9bc-00be-4b6d-9f53-c53abfacacef"
PROJECT_ID="627d4c09-152d-4cbb-bbe4-d91368f1fd0e"

# Cookie - update this with your current session token
COOKIE="__Secure-better-auth.session_token=r7f5dfbwrj1JYbeIbBB1zMLOfluoHz27.RgG9mytpoDTBS0QaT6Rv14axG0Ag0Wes7cjy6rFMJv8%3D"

# Phase issue IDs
PHASE1_ISSUE="a88ac2c0-3396-4060-9164-530a6274b22b"  # QFA-6
PHASE2_ISSUE="da7f45ab-aa21-4578-ab90-7f7020d07f95"  # QFA-7
PHASE3_ISSUE="681c7edd-0de2-4bc7-aaef-c011e92d14b2"  # QFA-8
PHASE4_ISSUE="5815797a-9472-4d34-9b37-58b9e2e5df78"  # QFA-9
PHASE5_ISSUE="091ccc13-2762-4ce3-bc7a-7c05ef2c84c0"  # QFA-10

show_status() {
    echo "=== Production Testing Sprint Status ==="
    echo ""
    for issue_id in $PHASE1_ISSUE $PHASE2_ISSUE $PHASE3_ISSUE $PHASE4_ISSUE $PHASE5_ISSUE; do
        curl -s "${PAPERCLIP_URL}/api/issues/$issue_id" \
            -H "Cookie: $COOKIE" -H "Origin: ${PAPERCLIP_URL}" | \
            python3 -c "
import json, sys
d = json.load(sys.stdin)
status = d.get('status', 'unknown')
icon = {'todo': '⬜', 'in_progress': '🔄', 'done': '✅', 'cancelled': '❌'}.get(status, '❓')
print(f\"{icon} {d.get('identifier', '?'):6s} | {d.get('title', '?'):50s} | {status}\")
"
    done
    echo ""
    echo "Usage: $0 [1-5]  (run a specific phase)"
}

start_phase() {
    local phase=$1
    local issue_id=""
    local phase_name=""

    case $phase in
        1) issue_id=$PHASE1_ISSUE; phase_name="Phase 1: Foundation Testing" ;;
        2) issue_id=$PHASE2_ISSUE; phase_name="Phase 2: Core Feature Testing" ;;
        3) issue_id=$PHASE3_ISSUE; phase_name="Phase 3: Integration Testing" ;;
        4) issue_id=$PHASE4_ISSUE; phase_name="Phase 4: Comprehensive Testing" ;;
        5) issue_id=$PHASE5_ISSUE; phase_name="Phase 5: Polish and Edge Cases" ;;
        *) echo "Invalid phase: $phase (use 1-5)"; exit 1 ;;
    esac

    echo "=== Starting $phase_name ==="
    echo ""

    # Get issue description
    curl -s "${PAPERCLIP_URL}/api/issues/$issue_id" \
        -H "Cookie: $COOKIE" -H "Origin: ${PAPERCLIP_URL}" | \
        python3 -c "
import json, sys
d = json.load(sys.stdin)
print(d.get('description', 'No description'))
"

    echo ""
    echo "---"
    echo "Set issue to in_progress:"
    curl -s -X PATCH "${PAPERCLIP_URL}/api/issues/$issue_id" \
        -H "Cookie: $COOKIE" -H "Content-Type: application/json" \
        -H "Origin: ${PAPERCLIP_URL}" \
        -d '{"status": "in_progress"}' | \
        python3 -c "import json,sys; d=json.load(sys.stdin); print(f'  {d.get(\"identifier\")} -> {d.get(\"status\")}')"

    echo ""
    echo "Now execute the testing tasks described above."
    echo "When done, mark as complete with:"
    echo "  curl -s -X PATCH '${PAPERCLIP_URL}/api/issues/$issue_id' \\"
    echo "    -H 'Cookie: $COOKIE' -H 'Content-Type: application/json' \\"
    echo "    -H 'Origin: ${PAPERCLIP_URL}' \\"
    echo "    -d '{\"status\": \"done\"}'"
    echo ""

    if [ "$phase" -lt 5 ]; then
        next=$((phase + 1))
        echo "After this phase passes, run: $0 $next"
    fi
}

# Main
if [ -z "$1" ]; then
    show_status
else
    start_phase "$1"
fi