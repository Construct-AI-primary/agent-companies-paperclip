# 01400 Health — Mobile UI/UX Specification

**Version:** 1.0
**Last Updated:** 2026-05-04
**Status:** Draft

## Overview

The mobile health interface provides field health officers, first aiders, and site supervisors with on-the-go access to health surveillance checks, incident reporting, fitness assessments, and emergency response tools on smartphones and tablets.

## Design Principles

1. **One-Hand Operation** — Primary health actions within thumb reach
2. **Offline First** — Full field health check functionality without connectivity, sync when online
3. **Quick Capture** — Rapid health data entry, photo evidence collection, voice notes
4. **Push Notifications** — Real-time alerts for health incidents, overdue assessments, emergency broadcasts
5. **Battery Optimization** — Efficient location tracking and background sync for field operations

## Navigation

### Bottom Tab Bar
- Dashboard — Overview of health status and pending actions
- Surveillance — Medical surveillance checks and results
- Incidents — Health incident reporting and investigation
- Fitness — Fitness for work assessments and status
- More — Emergency response, settings, reports

### Key Mobile Components

### Mobile Health Dashboard
- Health status summary cards (Surveillance, Incidents, Fitness, Emergency)
- Active health alert count with severity breakdown
- Quick action buttons (Report Incident, Record Health Check, Start Assessment)
- Today's surveillance schedule with overdue indicators
- Worker fitness status summary

### Field Health Check Recorder
- Step-by-step health check wizard (audiometry, spirometry, biological monitoring)
- Test result entry with normal/abnormal ranges
- Photo/documentation capture with metadata
- Worker identification via QR code or NFC badge
- Voice-to-text notes for clinical observations
- Offline queue with auto-sync

### Health Incident Reporter
- Rapid incident capture with minimal taps
- Incident type selection (exposure, illness, injury, biological)
- Photo/video evidence capture with GPS location tagging
- Exposure assessment quick form
- Regulatory report flagging (RIDDOR, OSHA recordable)
- Offline queue with auto-sync

### Fitness Assessment Tool
- Pre-employment health questionnaire
- Fitness assessment checklist with pass/fail criteria
- Drug and alcohol test recording
- Medical restriction entry
- Return-to-work clearance workflow
- Digital signature capture for consent

### Emergency Response
- Emergency alert with one-tap activation
- First aid kit and AED locator with map view
- Emergency contact speed dial
- Casualty assessment form (ABCs)
- Incident scene documentation
- Emergency service coordination

## Screen States

| State | Implementation |
|-------|---------------|
| Loading | Minimal skeleton with health status bar placeholder |
| Empty | "No health records" with suggested next action |
| Error | Offline banner, cached health data display, retry button |
| Data | Real-time health data with pull-to-refresh and sync indicator |

## Touch Targets

- Minimum touch target: 44x44px
- Button spacing: 8px minimum
- Swipe gestures for quick actions (acknowledge alert, escalate incident, complete check)
- Large form fields for field data entry with gloves

## Offline Behavior

- Health check records queued locally with full clinical metadata
- Incident reports stored with photos and GPS coordinates
- Fitness assessments cached with worker data
- Automatic sync when connectivity restored
- Conflict resolution with server timestamp priority
- Data encryption for sensitive medical information

## Notifications

- Push notifications for: incident assignments, overdue surveillance, emergency broadcasts, fitness expiry
- Notification categories with custom sounds (Critical, High, Medium, Info)
- Quick actions from notification (Acknowledge, View, Respond)
- Notification history with pull-to-refresh
- Clinical alert escalation notifications
