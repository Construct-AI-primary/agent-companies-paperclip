---
id: SEC-PATROL-002
title: "Patrol Management Core — Route Execution, Checkpoint Verification & Guard Tracking"
labels: ["security", "patrol", "2 — Core Integration"]
phase: "2 — Core Integration"
status: todo
priority: High
story_points: 13
due_date: "2026-07-31"
assignee: devforge-ai
company: devforge-ai
blocked_by: [SEC-PATROL-001]
estimated_weeks: 6
---

# SEC-PATROL-002: Patrol Management Core — Route Execution, Checkpoint Verification & Guard Tracking

## Description

Build the core patrol execution engine that enables guards to start/end patrols, verify checkpoints via QR/NFC, and enables real-time guard tracking. This issue covers the route execution workflow, checkpoint verification system, GPS tracking, and the notification engine for route deviations and missed checkpoints.

## Objectives

- Implement patrol start/end workflow with guard check-in
- Build checkpoint verification flow (sequential progression, QR/NFC validation)
- Develop real-time GPS guard tracking with geofencing
- Create notification engine for route deviations, missed checkpoints, and delays
- Build guard status board (online, on-patrol, on-break, offline)

## Technical Approach

### Route Execution

- Patrol instance created when guard starts assigned shift
- Sequential checkpoint progression enforced (must verify checkpoint N before N+1)
- Route deviation detection: guard location outside geofence for > threshold time
- Manual checkpoint override with supervisor authorisation

### Checkpoint Verification

- QR code generation per checkpoint per patrol instance (signed JWT tokens)
- NFC tag reading with tag ID validation against checkpoint registry
- Verification payload: checkpoint_id, guard_id, timestamp, latitude, longitude, method (qr/nfc/manual)
- Duplicate verification prevention (one verification per checkpoint per patrol)

### Guard Tracking

- GPS location updates every 30 seconds during active patrol
- Geofence radius configurable per checkpoint (default 50m)
- Location history stored for audit and replay
- Guard status transitions: offline → online → on-patrol → on-break → on-patrol → offline

### Notification Engine

- Alert types: route_deviation, missed_checkpoint, patrol_delay, shift_reminder
- Dispatch channels: push notification, in-app alert, email (escalation)
- Escalation: unacknowledged alert → supervisor notification after 5 minutes

## Acceptance Criteria

- [ ] Patrol can be started and completed with full event logging
- [ ] Checkpoint verification works via QR code scanning
- [ ] Checkpoint verification works via NFC tag reading
- [ ] GPS tracking captures guard location during patrol
- [ ] Route deviation triggers alert notification
- [ ] Missed checkpoint triggers alert notification
- [ ] Guard status board reflects real-time status changes
- [ ] Supervisor can override checkpoint verification

## Dependencies

- Blocked by: SEC-PATROL-001

## Estimated Effort

6 weeks | 13 story points
