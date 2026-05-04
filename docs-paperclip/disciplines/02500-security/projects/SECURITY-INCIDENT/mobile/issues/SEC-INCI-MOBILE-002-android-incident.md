# SEC-INCI-MOBILE-002 — Incident Management Android — Incident Capture, Voice Notes & Offline Queue

---

**Metadata**

| Field | Value |
|-------|-------|
| **ID** | SEC-INCI-MOBILE-002 |
| **Title** | Incident Management Android — Incident Capture, Voice Notes & Offline Queue |
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

Build the Android mobile application for incident capture in the field, enabling security personnel to create incidents, record voice notes with transcription, capture attachments, and operate with a robust offline queue using WorkManager.

---

## Objectives

1. Build incident capture form with Material Design
2. Implement voice note recording and transcription
3. Implement offline queue with WorkManager
4. Build attachment management (photos, audio, documents)
5. Implement background sync on connectivity

---

## Technical Specifications

### 1. Android Incident Capture Form

**UI Components:**
- Jetpack Compose UI with Material Design 3
- Dynamic form sections based on incident type selection
- Severity selector with color-coded chips
- Location auto-detect with Google Play Services
- Offline indicator showing queue status

**Form Fields:**
- Incident Type (dropdown with search and icons)
- Severity (chip group: P1–P4 with color coding)
- Title (text field with character count)
- Description (multi-line text field)
- Location (auto-detected + map picker)
- Timestamp (auto-set with timezone)
- Affected Assets (searchable asset list)
- Witnesses (dynamic list with add/remove)
- Voice Note (record button with waveform)
- Attachments (photo, audio, document)

### 2. Voice Note Recording

**Audio Recording:**
- MediaRecorder integration with high-quality audio
- Voice note activation from incident form
- Recording controls: record, pause, resume, stop
- Waveform visualization during recording
- Recording duration display and limit

**Transcription:**
- Speech-to-text integration (Google Speech API)
- Real-time transcription preview
- Transcription editing after recording
- Multi-language support
- Transcription stored as incident note

**Audio Management:**
- Audio file compression (AAC/MP4 format)
- Playback with speed control
- Audio metadata (duration, file size, timestamp)
- Secure storage of audio evidence files

### 3. Offline Queue with WorkManager

**WorkManager Integration:**
- Periodic sync work with constraints (network, battery)
- One-time sync work for priority incidents
- Chained work for dependent operations
- Work status observation and reporting

**Queue Operations:**
- Create incident (enqueue on creation)
- Update incident (enqueue on modification)
- Upload evidence (enqueue with file reference)
- Transition state (enqueue on state change)

**Queue Management:**
- Queue priority based on incident severity
- Retry policy with exponential backoff
- Queue persistence across device reboot
- Queue flush on connectivity restoration

### 4. Attachment Management

**Supported Types:**
- Photos (Camera capture + Gallery pick)
- Audio (Voice notes + File picker)
- Documents (PDF, DOCX, XLSX, TXT)
- Video (Camera recording + Gallery pick)

**Attachment Handling:**
- File size validation and compression
- Thumbnail generation for images and documents
- MIME type validation
- Virus scanning before queue upload
- Encrypted local storage

### 5. Security & Compliance

- Android Keystore for cryptographic operations
- EncryptedSharedPreferences for settings
- Biometric authentication (fingerprint, face)
- Root detection
- Work profile support for managed devices

---

## Acceptance Criteria

- [ ] Incident capture form follows Material Design guidelines
- [ ] Voice note recording captures clear audio
- [ ] Speech-to-text transcription is accurate
- [ ] Offline queue persists across app restarts
- [ ] WorkManager syncs queue on connectivity
- [ ] Attachments are stored securely offline
- [ ] Biometric authentication secures app access
- [ ] Background sync does not drain battery
- [ ] Integration tests pass for Android-specific workflows

---

## Implementation Notes

- Target Android 13+ (API 33+) for latest features
- Use Jetpack Compose for UI
- Implement WorkManager constraints for efficient sync
- Test on physical devices for audio and camera
- Follow Material Design 3 guidelines
