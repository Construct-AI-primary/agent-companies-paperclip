# LAND-MAINT-002 — Maintenance Core: Task Management, Crew Assignment & Completion Tracking

## Metadata

| Field | Value |
|-------|-------|
| **id** | LAND-MAINT-002 |
| **title** | Maintenance Core — Task Management, Crew Assignment & Completion Tracking |
| **labels** | `landscaping`, `maintenance`, `2 — Core Integration` |
| **phase** | 2 — Core Integration |
| **status** | todo |
| **priority** | High |
| **story_points** | 13 |
| **due_date** | 2026-07-31 |
| **assignee** | devforge-ai |
| **company** | devforge-ai |
| **estimated_weeks** | 6 |

## Dependencies

- **Blocks:** LAND-MAINT-003
- **Blocked By:** LAND-MAINT-001

## Description

Build the core task management system on top of the foundation data models. This includes the full task lifecycle (Created → Scheduled → Assigned → In Progress → Completed → Verified), crew assignment with skill matching and workload balancing, task dependency management, prioritization, bulk operations, and completion tracking with photo evidence and time tracking.

## Technical Requirements

### Task Management
- Task lifecycle state machine with transitions
- Task assignment engine with skill matching and workload balancing
- Task dependency management (pruning must precede mulching)
- Task prioritization (emergency, high, normal, low)
- Bulk task operations (assign, reschedule, complete)

### Crew Assignment & Dispatch
- Crew availability calendar
- Skill-based crew-to-task matching
- Crew workload view with capacity management
- Dispatch workflow with notifications
- Route optimization for multi-property daily schedules

### Completion Tracking
- Task completion workflow with required fields
- Photo evidence capture and storage pipeline
- Completion verification workflow (self-verify, supervisor verify)
- Time tracking for tasks (start time, end time, breaks)
- Completion analytics and reporting

## Acceptance Criteria

- [ ] Task lifecycle fully implemented with all state transitions
- [ ] Crew assignment engine matches skills and balances workload
- [ ] Task dependencies enforced (dependent tasks blocked until prerequisites complete)
- [ ] Bulk operations functional for assign, reschedule, complete
- [ ] Completion tracking captures required fields and photo evidence
- [ ] Verification workflow supports self-verify and supervisor-verify
- [ ] Time tracking records accurate task durations
- [ ] Route optimization produces efficient daily schedules
- [ ] All endpoints have integration tests passing
- [ ] Performance tested with 10,000+ concurrent tasks

## Notes

This is the largest issue in the project (13 story points, 6 weeks). It builds directly on the foundation from LAND-MAINT-001 and serves as the core operational engine for the entire maintenance platform. The crew assignment and route optimization algorithms are particularly critical for field efficiency.
