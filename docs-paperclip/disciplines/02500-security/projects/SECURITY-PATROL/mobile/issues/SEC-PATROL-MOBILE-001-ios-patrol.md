---
id: SEC-PATROL-MOBILE-001
title: "Patrol Management iOS — Guard Tour App, NFC Checkpoints & Route Navigation"
labels: ["security", "patrol", "mobile", "ios", "4 — Mobile & Offline"]
phase: "4 — Mobile & Offline"
status: todo
priority: High
story_points: 5
due_date: "2026-09-15"
assignee: devforge-ai
company: devforge-ai
blocked_by: [SEC-PATROL-002]
estimated_weeks: 3
---

# SEC-PATROL-MOBILE-001: Patrol Management iOS — Guard Tour App, NFC Checkpoints & Route Navigation

## Description

Build the native iOS guard tour application that enables security guards to execute patrols, scan NFC checkpoints, navigate routes, and report incidents. The app supports offline operation with automatic sync when connectivity is restored.

## Objectives

- Develop native iOS app with Swift and SwiftUI
- Implement NFC checkpoint scanning using Core NFC
- Add turn-by-turn route navigation with MapKit
- Support offline mode with local data caching and sync queue
- Integrate push notifications via APNs

## Technical Approach

### App Architecture

- SwiftUI with MVVM architecture
- Core Data for local persistence
- URLSession for network requests with reachability monitoring
- Combine framework for reactive state management

### NFC Checkpoint Scanning

- Core NFC framework for reading NFC tags
- Tag data format: NDEF record with checkpoint UUID
- Validation: read tag → send to backend → confirm checkpoint
- Fallback: manual checkpoint ID entry if NFC read fails

### Route Navigation

- MapKit integration for route display
- Turn-by-turn directions between checkpoints
- Current location marker with accuracy indicator
- Route deviation warning when guard leaves geofence

### Offline Mode

- Core Data cache for routes, checkpoints, patrol state
- Operation queue for checkpoint verifications, incident reports, location updates
- Background sync when connectivity restored
- Conflict resolution: timestamp-based last-write-wins

## Acceptance Criteria

- [ ] Guard can view assigned patrol routes on map
- [ ] NFC checkpoint scanning verifies checkpoint successfully
- [ ] Turn-by-turn navigation guides guard between checkpoints
- [ ] Route deviation triggers visual and haptic alert
- [ ] App functions fully offline with queued sync
- [ ] Incident can be reported with photo attachment
- [ ] Push notifications received for alerts and reminders

## Dependencies

- Blocked by: SEC-PATROL-002

## Estimated Effort

3 weeks | 5 story points
