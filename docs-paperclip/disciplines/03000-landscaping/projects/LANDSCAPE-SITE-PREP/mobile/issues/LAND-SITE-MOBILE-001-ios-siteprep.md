# LAND-SITE-MOBILE-001 — Site Preparation iOS — Field Survey, Soil Sample Logging & GPS Markers

| Field | Value |
|-------|-------|
| **ID** | LAND-SITE-MOBILE-001 |
| **Title** | Site Preparation iOS — Field Survey, Soil Sample Logging & GPS Markers |
| **Labels** | `landscaping`, `site-prep`, `4 — Mobile & Offline` |
| **Phase** | 4 — Mobile & Offline |
| **Status** | todo |
| **Priority** | High |
| **Story Points** | 5 |
| **Due Date** | 2026-09-15 |
| **Assignee** | devforge-ai |
| **Company** | devforge-ai |
| **Blocked by** | LAND-SITE-002 |
| **Estimated** | 3 weeks |

---

## Description

Build the iOS mobile application for site preparation field work. This app enables field surveyors to conduct site assessments, log soil samples with barcode generation, capture geotagged photos, and mark GPS locations — all with full offline support.

---

## Objectives

- Build field survey interface with GPS location capture
- Implement soil sample logging with barcode/label generation
- Create site photo capture with geotagging
- Implement offline data storage with Core Data
- Add MapKit integration for site boundary visualization
- Implement sync engine for offline-to-cloud data transfer

---

## Features

| Feature | Description | Offline Support |
|---------|-------------|-----------------|
| Field Survey | Site assessment form with GPS location | Yes |
| Soil Sampling | Sample logging with barcode labels | Yes |
| Photo Capture | Geotagged site photos | Yes |
| GPS Markers | Location marking on MapKit | Yes |
| Data Sync | Background sync when online | N/A |

---

## Technical Requirements

- Swift 5.9+ with SwiftUI
- Core Data for offline storage
- MapKit for GPS and boundary visualization
- AVFoundation for camera capture
- REST API integration with desktop backend
- Background sync with conflict detection
- Unit and UI test coverage > 80%

---

## Acceptance Criteria

- [ ] Field survey form capturing all required site data
- [ ] Soil sample logging with barcode label generation
- [ ] Geotagged photo capture and storage
- [ ] GPS markers displayed on MapKit
- [ ] Offline data storage working without network
- [ ] Background sync operational on reconnect
- [ ] Test suite passing with > 80% coverage

---

## Dependencies

- **Blocked by:** LAND-SITE-002 (Core integration APIs)

---

## Subtasks

- [ ] iOS project setup and architecture
- [ ] Field survey interface implementation
- [ ] Soil sample logging with barcodes
- [ ] Photo capture and geotagging
- [ ] MapKit integration
- [ ] Offline storage with Core Data
- [ ] Sync engine implementation
- [ ] Testing and validation
