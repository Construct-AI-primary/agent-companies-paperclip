---
id: LAND-PLANT-MOBILE-001
title: "Planting Operations iOS — Planting Log, Photo Evidence & GPS Location Tagging"
labels: ["landscaping", "planting", "mobile", "ios", "4 — Mobile & Offline"]
phase: "4 — Mobile & Offline"
status: todo
priority: High
story_points: 5
due_date: "2026-09-15"
assignee: devforge-ai
company: devforge-ai
blocked_by:
  - LAND-PLANT-002
platform: ios
---

# LAND-PLANT-MOBILE-001: Planting Operations iOS — Planting Log, Photo Evidence & GPS Location Tagging

## Description

Develop the iOS mobile application for field planting operations. The app enables landscape crews to record planting activities, capture photo evidence with GPS location tagging, and synchronise data with the backend platform. Built with SwiftUI, Core Data for offline persistence, and MapKit for location services.

## Objectives

1. Build planting log interface with species, quantity, zone, and date capture
2. Implement photo evidence capture with camera integration and annotation
3. Integrate GPS location tagging for planting records and inspections
4. Provide offline data persistence with Core Data and background sync
5. Deliver intuitive field-first user experience optimised for outdoor use

## Requirements

### Planting Log

- [ ] SwiftUI interface for daily planting log entry
- [ ] Species selection from synced plant catalogue
- [ ] Quantity entry with unit of measure
- [ ] Planting zone selection from project zones
- [ ] Crew member assignment and time tracking
- [ ] Date/time stamp with manual override option
- [ ] Notes and observations text field
- [ ] Progress indicator showing planned vs actual quantities

### Photo Evidence

- [ ] Camera integration for photo capture within the app
- [ ] Photo annotation (draw, text, arrows) overlay
- [ ] Multiple photos per planting record
- [ ] Photo gallery view with thumbnails
- [ ] EXIF data preservation (GPS, date, camera info)
- [ ] Offline photo storage with compression
- [ ] Photo upload queue with progress indication

### GPS Location Tagging

- [ ] MapKit integration for location selection and display
- [ ] Automatic GPS coordinate capture at time of record creation
- [ ] Location accuracy indicator
- [ ] Map view showing planted zones and inspection points
- [ ] Reverse geocoding for address display
- [ ] Offline map tile caching for remote sites

### Offline & Sync

- [ ] Core Data persistence for offline operation
- [ ] Background sync with conflict resolution
- [ ] Sync status indicators (pending, synced, error)
- [ ] Queue management for pending uploads
- [ ] Data integrity validation on sync
- [ ] Offline search and filter capabilities

## Acceptance Criteria

- [ ] Planting log functional with species, quantity, zone, and date capture
- [ ] Photo capture with annotation working offline
- [ ] GPS location tagging accurate and stored with records
- [ ] Offline data persistence with Core Data operational
- [ ] Background sync working with conflict resolution
- [ ] Sync status indicators visible to user
- [ ] App tested on iOS 16+ devices
- [ ] Field trials completed with user acceptance

## Dependencies

- BLOCKED BY: LAND-PLANT-002 (Core workflow API)
- Requires: iOS development environment (Xcode 15+)
- Requires: Apple Developer Program membership for distribution
- Requires: API documentation from LAND-PLANT-004

## Notes

- Design for one-handed operation in field conditions
- Support Dark Mode and accessibility features
- Consider Apple Pencil support for photo annotation
- Test on various iPhone models and lighting conditions
