---
id: SEC-PATROL-004
title: "Patrol Management Mobile — Mobile Patrol App, QR Checkpoints & Offline Logging"
labels: ["security", "patrol", "4 — Mobile & Offline"]
phase: "4 — Mobile & Offline"
status: todo
priority: High
story_points: 8
due_date: "2026-09-30"
assignee: devforge-ai
company: devforge-ai
blocked_by: [SEC-PATROL-003]
estimated_weeks: 4
---

# SEC-PATROL-004: Patrol Management Mobile — Mobile Patrol App, QR Checkpoints & Offline Logging

## Description

Develop the mobile patrol applications for iOS and Android, enabling guards to execute patrols, scan QR/NFC checkpoints, report incidents, and operate offline when connectivity is unavailable. This issue covers the mobile app backend services, offline sync engine, and push notification integration.

## Objectives

- Build backend services supporting iOS and Android patrol apps
- Implement QR code generation and validation API
- Implement NFC tag association and validation API
- Develop offline sync engine with conflict resolution
- Integrate push notifications (APNs and FCM)

## Technical Approach

### Mobile Backend Services

- REST API for patrol data synchronisation
- QR code generation endpoint (signed JWT tokens per checkpoint per patrol)
- NFC tag registration and validation endpoint
- Media upload endpoint for incident attachments

### Offline Sync Engine

- Local data storage: routes, checkpoints, patrol state cached on device
- Sync queue: checkpoint verifications, incident reports, location updates queued when offline
- Sync trigger: on connectivity restore, periodic background sync
- Conflict resolution: last-write-wins with supervisor override for conflicts
- Sync status tracking per device per patrol

### Push Notifications

- APNs integration for iOS devices
- FCM integration for Android devices
- Notification types: patrol_start_reminder, route_change, shift_update, dispatch_alert
- Device token management API

## Acceptance Criteria

- [ ] QR code generation API returns signed tokens per checkpoint
- [ ] NFC tag validation API verifies tag against checkpoint registry
- [ ] Offline sync engine queues events when offline
- [ ] Queued events sync successfully when connectivity is restored
- [ ] Conflict resolution handles simultaneous submissions
- [ ] Push notifications are delivered to iOS and Android devices
- [ ] Media upload API supports photo and video attachments

## Dependencies

- Blocked by: SEC-PATROL-003

## Estimated Effort

4 weeks | 8 story points
