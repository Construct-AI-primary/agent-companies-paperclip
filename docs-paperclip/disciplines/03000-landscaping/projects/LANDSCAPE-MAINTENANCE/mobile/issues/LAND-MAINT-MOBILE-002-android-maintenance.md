# LAND-MAINT-MOBILE-002 — Maintenance Android: Crew Dispatch, Route Optimization & Offline Task Sync

## Metadata

| Field | Value |
|-------|-------|
| **id** | LAND-MAINT-MOBILE-002 |
| **title** | Maintenance Android — Crew Dispatch, Route Optimization & Offline Task Sync |
| **labels** | `landscaping`, `maintenance`, `4 — Mobile & Offline`, `android` |
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

Build the Android mobile application for landscape maintenance crew dispatch and field operations. The app provides crew dispatch view with route optimization, turn-by-turn navigation to properties, offline task sync with Room database, photo evidence capture and compression, background sync with WorkManager, and crew communication features.

## Technical Requirements

### Crew Dispatch & Route Optimization
- Crew dispatch view showing daily task assignments
- Route optimization with turn-by-turn navigation
- Property location mapping with cluster view
- Estimated travel time and task duration display
- Real-time crew location sharing (optional)

### Task Execution
- Task detail view with completion workflow
- Photo evidence capture with compression
- Multiple photo capture per task
- Signature capture for service verification
- Task status updates with timestamps

### Offline & Sync
- Offline task sync with Room database
- Background sync with WorkManager
- Sync queue with priority ordering
- Conflict detection and resolution
- Offline photo storage with deferred upload
- Cache management and data pruning

### Crew Communication
- In-app messaging for crew coordination
- Status updates and availability sharing
- Emergency task reassignment notifications
- Supervisor alerts for completion verification

## Acceptance Criteria

- [ ] Crew dispatch view shows daily task assignments with route
- [ ] Turn-by-turn navigation integrates with Google Maps or similar
- [ ] Route optimization minimizes travel time between properties
- [ ] Task completion workflow functional with required fields
- [ ] Photo evidence capture with compression (< 1MB per image)
- [ ] Signature capture with smooth input
- [ ] Offline task sync with Room database functional
- [ ] Background sync with WorkManager processes queue reliably
- [ ] Crew messaging delivers messages in real-time
- [ ] App performance tested with 500+ tasks offline

## Notes

Built with Kotlin and Jetpack Compose. Uses Room for local persistence and WorkManager for background sync. Route optimization is a key differentiator for crew efficiency. Navigation integration should support both driving and walking directions for large properties.
