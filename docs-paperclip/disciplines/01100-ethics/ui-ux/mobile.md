# 01100 Ethics — Mobile Specification

**Version:** 1.0
**Last Updated:** 2026-05-04
**Status:** Draft

## Overview

The mobile platform provides ethics officers and compliance personnel with on-the-go access to whistleblower intake, training access, gift declaration, and Code of Conduct reference. Designed for field use with offline capabilities and secure communication.

## Target Users

- Ethics Officers (field)
- Compliance Officers (remote)
- Employees (self-service)
- Managers (approval)

## Layout Structure

```
┌──────────────────────────────┐
│  Status Bar                   │
├──────────────────────────────┤
│  ← Ethics Mobile    [Profile] │
├──────────────────────────────┤
│  ┌──────────────────────────┐ │
│  │ Compliance Score: 94%    │ │
│  │ 3 Open Cases | 2 Pending │ │
│  └──────────────────────────┘ │
│                               │
│  [Quick Actions]              │
│  ┌──────┐ ┌──────┐ ┌──────┐ │
│  │Report│ │Code  │ │Gift  │ │
│  │Issue │ │Access│ │Decl. │ │
│  └──────┘ └──────┘ └──────┘ │
│                               │
│  [Recent Cases]               │
│  ┌──────────────────────────┐ │
│  │ Case ETH-2026-0042       │ │
│  │ Status: Investigation    │ │
│  │ Priority: High           │ │
│  └──────────────────────────┘ │
│  ┌──────────────────────────┐ │
│  │ Case ETH-2026-0041       │ │
│  │ Status: Triage           │ │
│  │ Priority: Medium         │ │
│  └──────────────────────────┘ │
│                               │
│  [Pending Approvals]          │
│  ┌──────────────────────────┐ │
│  │ Gift: Client Dinner $150 │ │
│  │ Submitted: 2026-05-03    │ │
│  │ [Approve] [Reject]       │ │
│  └──────────────────────────┘ │
├──────────────────────────────┤
│  Tab Bar: Home | Cases |     │
│  Training | Profile          │
└──────────────────────────────┘
```

## Key Features

### Whistleblower Intake
- **Anonymous reporting** with secure submission
- **Category selection** (fraud, corruption, harassment, safety, other)
- **Attachment upload** (photos, documents, audio)
- **Case reference number** for anonymous follow-up
- **Push notifications** for case status updates

### Code of Conduct Access
- **Offline policy viewing** with cached content
- **Searchable policy sections**
- **Quick reference** for key policies (gifts, conflicts, reporting)
- **Acknowledgment** with digital signature
- **Multi-language** support

### Training Access
- **Course catalog** with completion status
- **Offline course content** download
- **Quiz and assessment** completion
- **Certificate** download and sharing
- **Training reminders** and deadlines

### Gift Declaration
- **Quick declaration** form with photo capture
- **Threshold alerts** for gifts approaching limits
- **Approval workflow** with push notifications
- **Annual limit tracker** per individual
- **Receipt capture** via camera

## Screen States

### Loading State
- Skeleton loaders for case lists and training modules
- Progress indicators for content downloads

### Empty State
- "No cases assigned" for case list
- "All training complete" for training
- "No gifts to declare" for gift register

### Error State
- "Unable to submit report" with draft save
- "Sync pending" with offline indicator
- "Connection lost" with cached data indicator

### Data State
- Card-based layouts for cases and approvals
- List views with pull-to-refresh
- Bottom sheet for detailed information
- Swipe actions for quick operations

## Navigation

- **Bottom Tab Bar:** Primary navigation (Home, Cases, Training, Profile)
- **Stack Navigation:** Drill-down into case details, training modules
- **Modal Sheets:** For quick actions (gift declaration, report submission)
- **Search:** Global search across cases, policies, training

## Offline Capabilities

- Cached Code of Conduct for offline viewing
- Draft case reports saved locally
- Training content downloaded for offline completion
- Gift declaration drafts stored locally
- Sync queue with conflict resolution

## Push Notifications

- New case assignment
- Case status updates
- Approval requests (gifts, training)
- Training deadline reminders
- Policy update notifications
- Compliance score changes
