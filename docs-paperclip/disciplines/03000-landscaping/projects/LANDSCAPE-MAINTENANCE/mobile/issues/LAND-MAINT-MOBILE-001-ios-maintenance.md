# LAND-MAINT-MOBILE-001 — Maintenance iOS: Task List, Completion Confirmation & Photo Evidence

## Metadata

| Field | Value |
|-------|-------|
| **id** | LAND-MAINT-MOBILE-001 |
| **title** | Maintenance iOS — Task List, Completion Confirmation & Photo Evidence |
| **labels** | `landscaping`, `maintenance`, `4 — Mobile & Offline`, `ios` |
| **phase** | 4 — Mobile & Offline |
| **status** | todo |
| **priority** | High |
| **story_points** | 5 |
| **due_date** | 2026-09-15 |
| **assignee** | devforge-ai |
| **company** | devforge-ai |

## Dependencies

- **Blocks:** LAND-MAINT-MOBILE-003
- **Blocked By:** LAND-MAINT-002

## Description

Build the iOS mobile application for landscape maintenance field crews. The app provides a task list view with filtering and sorting, task detail view with completion workflow, photo evidence capture with camera integration, offline task completion with local storage, background sync engine, and signature capture for service verification.

## Technical Requirements

### Task List
- Task list view with status-based filtering (assigned, in progress, completed)
- Sort by priority, due date, property, or distance
- Pull-to-refresh with sync status indicator
- Search by property name, task type, or description
- Offline task list with local Core Data storage

### Task Detail & Completion
- Task detail view with full description, instructions, and materials
- Completion workflow with required field validation
- Photo evidence capture with native camera integration
- Multiple photo capture per task with reordering
- Signature capture with canvas-based input

### Offline & Sync
- Full offline task completion with local storage
- Background fetch sync engine
- Sync queue with visual status indicators
- Conflict resolution notifications
- Offline photo storage with deferred upload

## Acceptance Criteria

- [ ] Task list displays with filtering and sorting
- [ ] Task detail view shows all required information
- [ ] Completion workflow validates required fields before submission
- [ ] Photo evidence capture works with native camera
- [ ] Multiple photos can be captured and attached per task
- [ ] Signature capture with smooth canvas input
- [ ] Full offline task completion without network
- [ ] Background sync processes queue on connectivity
- [ ] Sync status indicators visible to user
- [ ] App performance tested with 500+ tasks offline

## Notes

Built with Swift and SwiftUI. Uses Core Data for local persistence and background fetch for sync. The offline capability is critical for field crews in areas with limited cellular connectivity. Photo compression should balance quality and upload speed.
