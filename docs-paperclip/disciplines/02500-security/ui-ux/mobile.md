# 02500 Security — Mobile UI/UX Specification

**Version:** 1.0  
**Last Updated:** 2026-05-04  
**Status:** Draft

## Overview

The mobile security interface provides field security personnel with real-time access to surveillance feeds, incident reporting, patrol management, access control verification, and emergency response tools on smartphones and tablets.

## Design Principles

1. **One-Hand Operation** — Primary actions within thumb reach
2. **Offline First** — Full functionality without connectivity, sync when online
3. **Quick Capture** — Rapid photo/video evidence collection, voice notes
4. **Push Notifications** — Real-time alerts for incidents, breaches, patrol tasks
5. **Battery Optimization** — Efficient location tracking and background sync

## Navigation

### Bottom Tab Bar
- Dashboard — Overview of current status and pending actions
- Incidents — Incident reporting and investigation
- Patrol — Patrol route and checkpoint management
- Alerts — Real-time alert feed with acknowledgment
- More — Settings, reports, admin functions

### Key Mobile Components

### Mobile Dashboard
- Status summary cards (Access, Incidents, Patrol, Alerts)
- Active alert count with severity breakdown
- Quick action buttons (Report Incident, Start Patrol, Acknowledge Alert)
- Recent activity feed

### Incident Reporter
- Step-by-step incident capture wizard
- Photo/video evidence capture with metadata
- Location auto-tagging from device GPS
- Voice-to-text notes
- Offline queue with auto-sync

### Patrol Manager
- Route progress with checkpoint list
- QR/NFC checkpoint scanning
- Guard tour timer and route deviation alerts
- Note and photo attachment at each checkpoint

### Surveillance Viewer
- Live camera feed thumbnails
- Tap to view full-screen with pinch-to-zoom
- PTZ camera controls for authorized users
- Quick clip recording for evidence

## Screen States

| State | Implementation |
|-------|---------------|
| Loading | Minimal skeleton with status bar placeholder |
| Empty | "All Clear" with patrol suggestion or next action |
| Error | Offline banner, cached data display, retry button |
| Data | Real-time data with pull-to-refresh and sync indicator |

## Touch Targets

- Minimum touch target: 44x44px
- Button spacing: 8px minimum
- Swipe gestures for quick actions (acknowledge, escalate, dismiss)

## Offline Behavior

- Incident reports queued locally with full metadata
- Patrol checkpoints logged with timestamps and GPS
- Photos/videos stored in local cache, compressed for upload
- Automatic sync when connectivity restored
- Conflict resolution with server timestamp priority

## Notifications

- Push notifications for: incident assignments, alert acknowledgments, patrol tasks, emergency broadcasts
- Notification categories with custom sounds (Critical, High, Medium)
- Quick actions from notification (Acknowledge, View, Escalate)
- Notification history with pull-to-refresh