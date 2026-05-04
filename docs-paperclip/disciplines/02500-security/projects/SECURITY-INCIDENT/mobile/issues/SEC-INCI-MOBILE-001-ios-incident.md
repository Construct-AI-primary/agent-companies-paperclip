# SEC-INCI-MOBILE-001 — Incident Management iOS — Field Incident Reporting, Photo Evidence & GPS Tagging

---

**Metadata**

| Field | Value |
|-------|-------|
| **ID** | SEC-INCI-MOBILE-001 |
| **Title** | Incident Management iOS — Field Incident Reporting, Photo Evidence & GPS Tagging |
| **Labels** | `security`, `incident`, `4 — Mobile & Offline` |
| **Phase** | 4 — Mobile & Offline |
| **Status** | todo |
| **Priority** | High |
| **Story Points** | 5 |
| **Due Date** | 2026-09-15 |
| **Assignee** | devforge-ai |
| **Company** | devforge-ai |
| **Estimated** | — |

---

## Dependencies

- **Blocks:** SEC-INCI-MOBILE-003
- **Blocked By:** SEC-INCI-002

---

## Description

Build the iOS mobile application for field incident reporting, enabling security personnel to create incidents, capture photo evidence with GPS tagging, and operate offline when network connectivity is unavailable.

---

## Objectives

1. Build incident creation form optimized for iOS mobile
2. Implement photo evidence capture with camera integration
3. Implement GPS tagging and location services
4. Build offline incident creation queue
5. Implement secure local storage with Core Data

---

## Technical Specifications

### 1. iOS Incident Creation Form

**UI Components:**
- SwiftUI form with dynamic sections based on incident type
- Quick-select buttons for common incident types
- Severity selector with color-coded indicators
- Location auto-detect with manual override
- Reporter information pre-filled from user profile

**Form Fields:**
- Incident Type (picker with search)
- Severity (segmented control: P1–P4)
- Title (text field, required)
- Description (text editor, required)
- Location (auto-detected + manual entry)
- Timestamp (auto-set, editable)
- Affected Assets (multi-select from asset list)
- Witnesses (name and contact entry)
- Initial Evidence (photo capture or gallery pick)

### 2. Photo Evidence Capture

**Camera Integration:**
- AVFoundation camera capture with preview
- Photo resolution options (standard, high, evidence)
- Flash control (auto, on, off)
- Grid overlay for consistent framing
- Timestamp and GPS watermark overlay

**Photo Management:**
- Gallery picker with multi-select
- Photo review and delete before submission
- Auto-rotation and orientation correction
- EXIF data extraction (GPS, timestamp, device info)
- Thumbnail generation for list views

### 3. GPS Tagging

**Location Services:**
- Core Location integration with significant-change monitoring
- Auto-tag incident location on creation
- Manual location search and pin drop
- Geofence detection for known facility locations
- Location accuracy indicator

**Location Data:**
- Latitude, longitude, altitude
- Address reverse geocoding
- Facility/location name mapping
- Indoor positioning support (where available)

### 4. Offline Queue

**Local Storage:**
- Core Data stack for incident and evidence storage
- Encrypted file system for evidence files
- Queue table for pending sync operations
- Queue persistence across app restarts

**Offline Operations:**
- Create incident with all fields
- Capture and store photo evidence
- Record GPS location
- Edit draft incidents
- View previously synced incidents

### 5. Security & Compliance

- iOS Data Protection for all stored data
- Keychain for secure token storage
- Biometric authentication (Face ID / Touch ID)
- Jailbreak detection
- Screen recording prevention

---

## Acceptance Criteria

- [ ] Incident creation form captures all required fields
- [ ] Camera capture produces evidence-quality photos
- [ ] GPS tagging accurately records incident location
- [ ] Offline incident creation works without network
- [ ] Photo evidence stored securely offline
- [ ] Sync queue flushes correctly on connectivity
- [ ] Biometric authentication secures app access
- [ ] All stored data encrypted at rest
- [ ] Integration tests pass for iOS-specific workflows

---

## Implementation Notes

- Target iOS 16+ for latest SwiftUI features
- Use async/await for network operations
- Implement background fetch for sync
- Test on physical devices for camera and GPS
- Follow Apple Human Interface Guidelines
