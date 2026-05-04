---
id: HLTH-INCI-MOBILE-002
title: "Health Incident Android — Field Incident Reporting, Evidence Capture & Offline Operations"
labels: ["health", "incident", "mobile", "android", "4 — Mobile & Offline"]
phase: "4 — Mobile & Offline"
status: todo
priority: High
story_points: 5
assignee: devforge-ai
company: devforge-ai
created_date: 2026-05-04
due_date: 2026-11-15
estimated_hours: 40
blocked_by: ["HLTH-INCI-002"]
---

# HLTH-INCI-MOBILE-002: Health Incident Android — Field Incident Reporting, Evidence Capture & Offline Operations

## Description

Build the Android mobile application for health incident reporting, enabling health officers to record incidents, capture evidence, and manage investigations on Android devices with offline-first architecture.

**Phase:** 4 — Mobile & Offline
**Priority:** High
**Story Points:** 5
**Estimated Hours:** 40
**Assignee:** devforge-ai
**Company:** devforge-ai
**Due Date:** 2026-11-15

**Blocked By:** HLTH-INCI-002

## Acceptance Criteria

- [ ] Incident recording with type and severity selection
- [ ] Photo/video evidence capture with CameraX
- [ ] GPS location tagging for incident location
- [ ] Offline-first with Room database
- [ ] WorkManager for background sync
- [ ] Push notification handling

## Technical Details

- Android 11.0+ (API 30+) deployment target
- Kotlin with Jetpack Compose
- CameraX for photo/video capture
- Room database for offline storage
- WorkManager for background sync

## Dependencies

- **HLTH-INCI-002** — Core incident management

## Status

- [ ] To Do
- [ ] In Progress
- [ ] In Review
- [ ] Done
