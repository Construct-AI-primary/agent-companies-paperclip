---
id: SEC-PATROL-003
title: "Patrol Management Integration — Incident Linking, Alert Dispatch & Shift Handover"
labels: ["security", "patrol", "3 — Discipline Integration"]
phase: "3 — Discipline Integration"
status: todo
priority: High
story_points: 8
due_date: "2026-08-31"
assignee: devforge-ai
company: devforge-ai
blocked_by: [SEC-PATROL-002]
estimated_weeks: 4
---

# SEC-PATROL-003: Patrol Management Integration — Incident Linking, Alert Dispatch & Shift Handover

## Description

Integrate patrol management with the broader Security discipline by enabling incident reporting during patrols, dispatching alerts to response teams, and implementing digital shift handover procedures. This issue connects patrol operations with the Security incident management ecosystem.

## Objectives

- Enable guards to report incidents during patrol with media attachments
- Link incidents to specific checkpoints and route segments
- Integrate with Security discipline alert dispatch system
- Implement digital shift handover with patrol status capture
- Connect patrol data with Security operations centre

## Technical Approach

### Incident Reporting

- Incident types: suspicious_activity, security_breach, equipment_failure, safety_hazard, medical_emergency, fire, other
- Severity levels: low, medium, high, critical
- Media capture: photo, video, audio notes
- Auto-escalation: high/critical incidents → immediate dispatch notification
- Incident linked to patrol_id, checkpoint_id, and guard_id

### Alert Dispatch Integration

- REST API integration with Security alerting service
- Alert payload: incident_id, type, severity, location, guard_info, timestamp
- Dispatch targets: supervisor, response team, security operations centre
- Acknowledgement workflow: received → acknowledged → resolved

### Shift Handover

- Handover triggered when guard shift ends
- Captured data: completed checkpoints, pending items, open incidents, notes
- Digital sign-off by both outgoing and incoming guards
- Handover report generated and stored in audit log

## Acceptance Criteria

- [ ] Guard can report incident during patrol with photo attachment
- [ ] Incident is linked to checkpoint and route
- [ ] High-severity incidents trigger immediate dispatch alert
- [ ] Shift handover captures all patrol status data
- [ ] Handover requires digital sign-off from both guards
- [ ] Patrol data is accessible from Security operations centre

## Dependencies

- Blocked by: SEC-PATROL-002

## Estimated Effort

4 weeks | 8 story points
