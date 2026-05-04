# SEC-EMERG-WEB-001 — Emergency Response Web — Emergency Dashboard, Evacuation Status & Alert History

- **id:** SEC-EMERG-WEB-001
- **title:** Emergency Response Web — Emergency Dashboard, Evacuation Status & Alert History
- **labels:** ["security", "emergency", "web", "2 — Core Integration"]
- **phase:** "2 — Core Integration"
- **status:** todo
- **priority:** High
- **story_points:** 5
- **due_date:** "2026-07-15"
- **assignee:** devforge-ai
- **company:** devforge-ai
- **blocked_by:** [SEC-EMERG-002]
- **estimated:** 4 weeks

## Description

Build the primary web-based emergency dashboard providing real-time evacuation status visualization, alert history, muster point overview, and roll call progress tracking for security operations centers.

## Technical Requirements

### Emergency Dashboard

- Real-time evacuation status overview with building and zone-level views
- Active emergency alerts display with severity color coding (info=blue, warning=yellow, critical=red)
- Evacuation progress visualization with percentage completion per zone
- Building floor plan rendering with zone status overlays (safe, evacuating, evacuated, compromised)
- Muster point status panel: headcount, capacity utilization, check-in rate
- Roll call progress tracker with present/absent/unaccounted counts
- Timeline view of emergency events with timestamps

### Evacuation Status

- Zone-level evacuation status with color-coded indicators
- Per-zone details: total occupants, evacuated count, remaining count, last check-in time
- Evacuation route status (clear, congested, blocked, alternate route available)
- Estimated time to full evacuation per zone
- Filtering by building, floor, zone, and alert type

### Alert History

- Searchable alert history with full-text search
- Filtering by date range, alert type, severity, and status
- Alert detail view: message, target zones, sent time, delivery stats, acknowledgment status
- Alert delivery analytics: delivered count, acknowledged count, delivery rate
- Alert export to CSV for external analysis

### Real-Time Updates

- WebSocket connection for live dashboard updates
- Server-sent events for non-critical status changes
- Automatic reconnection with state recovery
- Visual indicators for connection status (connected, reconnecting, disconnected)

## Acceptance Criteria

- [ ] Dashboard displays real-time evacuation status for all configured buildings
- [ ] Zone status indicators update within 2 seconds of status change
- [ ] Alert history search returns results within 3 seconds
- [ ] Alert detail view shows complete delivery and acknowledgment data
- [ ] Building floor plan renders with correct zone overlays
- [ ] Muster point panel shows accurate real-time headcount
- [ ] Roll call progress tracker updates in real-time
- [ ] WebSocket reconnection recovers state correctly
- [ ] Dashboard is responsive for 1920x1080 and 1366x768 resolutions
- [ ] All E2E tests pass for dashboard scenarios

## Dependencies

- SEC-EMERG-002: Mass notification, muster point management, roll call
- Building floor plan data and mapping service
- WebSocket infrastructure for real-time updates

## Notes

This is the primary interface for security operations center personnel. Prioritize performance and reliability — the dashboard must remain responsive during active emergencies with high data volume.
