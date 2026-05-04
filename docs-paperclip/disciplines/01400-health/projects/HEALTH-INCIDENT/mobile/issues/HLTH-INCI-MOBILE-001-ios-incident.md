---
id: HLTH-INCI-MOBILE-001
title: "Health Incident iOS — Field Incident Reporting, Evidence Capture & Investigation"
labels: ["health", "incident", "mobile", "ios", "4 — Mobile & Offline"]
phase: "4 — Mobile & Offline"
status: todo
priority: High
story_points: 5
assignee: devforge-ai
company: devforge-ai
created_date: 2026-05-04
due_date: 2026-10-30
estimated_hours: 40
blocked_by: ["HLTH-INCI-002"]
---

# HLTH-INCI-MOBILE-001: Health Incident iOS — Field Incident Reporting, Evidence Capture & Investigation

## Description

Build the iOS mobile application for health incident reporting, enabling health officers to record incidents in the field, capture photo/video evidence, document exposure details, and manage investigations on iPhone/iPad.

**Phase:** 4 — Mobile & Offline
**Priority:** High
**Story Points:** 5
**Estimated Hours:** 40
**Assignee:** devforge-ai
**Company:** devforge-ai
**Due Date:** 2026-10-30

**Blocked By:** HLTH-INCI-002

## Acceptance Criteria

- [ ] Incident recording with type, severity, and classification
- [ ] Photo/video evidence capture with GPS metadata
- [ ] Exposure assessment quick form
- [ ] Investigation timeline and notes
- [ ] Offline queue with auto-sync
- [ ] Push notifications for incident assignments

## Technical Details

- iOS 15.0+ deployment target
- SwiftUI for modern iOS interface
- AVFoundation for photo/video capture
- Core Data for offline caching
- CloudKit for encrypted data sync

## Dependencies

- **HLTH-INCI-002** — Core incident management

## Status

- [ ] To Do
- [ ] In Progress
- [ ] In Review
- [ ] Done
