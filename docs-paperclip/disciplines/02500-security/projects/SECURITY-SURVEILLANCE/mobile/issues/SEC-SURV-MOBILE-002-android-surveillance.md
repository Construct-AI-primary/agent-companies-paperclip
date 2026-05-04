# SEC-SURV-MOBILE-002 — Surveillance Android — Live Camera Viewing, PTZ Control & Evidence Capture

- **id:** SEC-SURV-MOBILE-002
- **title:** Surveillance Android — Live Camera Viewing, PTZ Control & Evidence Capture
- **labels:** ["security", "surveillance", "mobile", "android", "4 — Mobile & Offline"]
- **phase:** 4 — Mobile & Offline
- **status:** todo
- **priority:** High
- **story_points:** 5
- **due_date:** 2026-09-15
- **assignee:** devforge-ai
- **company:** devforge-ai
- **blocked_by:** [SEC-SURV-002]
- **estimated:** 3 weeks

## Description

Build the native Android surveillance application enabling security personnel to view live camera feeds, control PTZ cameras, capture evidence clips and screenshots, and receive push alerts. The app supports offline clip storage with background upload.

## Technical Requirements

### Live Camera Viewing
- Camera grid and list views with live thumbnail previews
- Full-screen live player with PTZ control overlay
- WebRTC-based low-latency streaming with HLS fallback
- Multi-camera split-view layouts
- Bandwidth-aware adaptive streaming

### PTZ Control
- Directional pad for pan/tilt control
- Zoom slider with smooth interpolation
- Preset recall with one-tap navigation
- PTZ tour/patrol activation
- Absolute and relative positioning commands

### Evidence Capture
- Screenshot capture with timestamp overlay
- Clip recording with start/stop and metadata tagging
- Evidence annotation: draw on frame, add text notes
- Evidence library with thumbnail grid and search/filter
- Tamper-evident evidence export with metadata sidecar

### Push Alerts & Offline
- FCM integration for motion and analytics notifications
- Alert detail view with camera snapshot and quick actions
- Offline clip storage with background upload on connectivity restore
- Offline camera list caching with last-known status
- Queued PTZ commands synced on reconnect

## Acceptance Criteria

- [ ] Live camera streams render at <1s latency over WiFi
- [ ] PTZ controls respond with <200ms command latency
- [ ] Evidence clips and screenshots capture correctly with metadata
- [ ] Push alerts delivered within 3 seconds via FCM
- [ ] Offline clips upload when connectivity is restored
- [ ] App passes Google Play Store review guidelines

## Dependencies

- **Blocked by:** SEC-SURV-002 (Core streaming and recording engine)
