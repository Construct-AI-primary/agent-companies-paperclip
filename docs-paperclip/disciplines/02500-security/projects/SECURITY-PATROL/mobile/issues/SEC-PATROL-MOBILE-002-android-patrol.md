---
id: SEC-PATROL-MOBILE-002
title: "Patrol Management Android — QR Checkpoint Scanning, Incident Reporting & Route Deviation Alerts"
labels: ["security", "patrol", "mobile", "android", "4 — Mobile & Offline"]
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

# SEC-PATROL-MOBILE-002: Patrol Management Android — QR Checkpoint Scanning, Incident Reporting & Route Deviation Alerts

## Description

Build the native Android guard patrol application that enables security guards to scan QR checkpoints, report incidents with media attachments, and receive route deviation alerts. The app supports offline operation with automatic sync.

## Objectives

- Develop native Android app with Kotlin and Jetpack Compose
- Implement QR checkpoint scanning using CameraX and ML Kit
- Add incident reporting with photo/video capture
- Implement route deviation alerts with Google Maps integration
- Support offline mode with Room database and WorkManager sync

## Technical Approach

### App Architecture

- Kotlin with Jetpack Compose UI
- MVVM architecture with Android Architecture Components
- Room database for local persistence
- Retrofit for network requests
- WorkManager for background sync scheduling
- Hilt for dependency injection

### QR Checkpoint Scanning

- CameraX for camera preview and image capture
- ML Kit barcode scanning for QR code detection
- QR code format: signed JWT token containing checkpoint_id and patrol_id
- Validation: scan QR → decode token → verify signature → confirm checkpoint
- Haptic and audio feedback on successful scan

### Incident Reporting

- Incident types: suspicious_activity, security_breach, equipment_failure, safety_hazard, medical_emergency, fire
- Media capture: CameraX for photo/video, microphone for audio notes
- Location auto-tagged from GPS
- Severity selection with escalation guidance

### Route Deviation Alerts

- Google Maps SDK for route display and navigation
- Geofencing API for checkpoint proximity detection
- Deviation detection: guard location outside checkpoint geofence for > 2 minutes
- Alert types: visual warning, audio alert, push notification to supervisor

### Offline Mode

- Room database cache for routes, checkpoints, patrol state
- WorkManager for queued sync operations
- Sync triggers: connectivity restored, periodic (every 15 minutes), manual
- Conflict resolution: timestamp-based with supervisor override

## Acceptance Criteria

- [ ] Guard can scan QR checkpoint and verify successfully
- [ ] Incident can be reported with photo and video attachments
- [ ] Route deviation triggers visual and audio alert
- [ ] Google Maps shows route with checkpoint markers
- [ ] App functions fully offline with queued sync
- [ ] Background sync completes automatically on connectivity restore
- [ ] Push notifications received via FCM

## Dependencies

- Blocked by: SEC-PATROL-002

## Estimated Effort

3 weeks | 5 story points
