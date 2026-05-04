# SEC-SURV-MOBILE-001 — Surveillance iOS — Live Camera Viewing, Clip Recording & Push Alerts

- **id:** SEC-SURV-MOBILE-001
- **title:** Surveillance iOS — Live Camera Viewing, Clip Recording & Push Alerts
- **labels:** ["security", "surveillance", "mobile", "ios", "4 — Mobile & Offline"]
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

Build the native iOS surveillance application enabling security personnel to view live camera feeds, record video clips, and receive push alerts for motion and analytics events. The app supports offline clip storage and background streaming.

## Technical Requirements

### Live Camera Viewing
- Camera list view with live thumbnail previews
- Full-screen live player with pinch-to-zoom and stream switching (primary/sub-stream)
- WebRTC-based low-latency streaming with HLS fallback
- Multi-camera split-view (2×2, 3×3 grid layouts)
- Bandwidth-aware auto-switch between HD and SD streams

### Clip Recording
- Start/stop clip recording with local storage
- Metadata tagging: camera name, timestamp, location, event type
- Clip library with thumbnail previews and search/filter
- Background upload to server when WiFi is available
- Offline recording queue for clips captured without connectivity

### Push Alerts
- APNs integration for motion and analytics event notifications
- Alert detail view: camera snapshot, event type, timestamp
- Quick actions: view camera, acknowledge alert, start recording
- Notification preferences per camera and event severity

### Background & Offline
- Background audio mode for persistent streaming
- Offline camera list caching with last-known thumbnails
- Queued actions (PTZ commands, config changes) synced on reconnect
- Local authentication (Face ID / Touch ID) for app access

## Acceptance Criteria

- [ ] Live camera streams render at <1s latency over WiFi
- [ ] Clip recording captures and stores video locally
- [ ] Push alerts delivered within 3 seconds of event trigger
- [ ] Offline clips upload successfully when WiFi is restored
- [ ] Background streaming continues when app is backgrounded
- [ ] Face ID / Touch ID authentication secures app access
- [ ] App passes iOS App Store review guidelines

## Dependencies

- **Blocked by:** SEC-SURV-002 (Core streaming and recording engine)
