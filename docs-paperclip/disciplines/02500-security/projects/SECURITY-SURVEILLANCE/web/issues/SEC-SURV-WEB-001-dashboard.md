# SEC-SURV-WEB-001 — Surveillance Web — Camera Dashboard, Recording Browser & System Status

- **id:** SEC-SURV-WEB-001
- **title:** Surveillance Web — Camera Dashboard, Recording Browser & System Status
- **labels:** ["security", "surveillance", "web", "dashboard", "2 — Core Integration"]
- **phase:** 2 — Core Integration
- **status:** todo
- **priority:** High
- **story_points:** 5
- **due_date:** 2026-07-15
- **assignee:** devforge-ai
- **company:** devforge-ai
- **blocked_by:** [SEC-SURV-002]
- **estimated:** 3 weeks

## Description

Build the web-based surveillance dashboard providing live camera viewing, recording browser with timeline playback, and system status monitoring. This is the primary web interface for security operators to monitor and review surveillance footage.

## Technical Requirements

### Camera Dashboard
- Camera grid view with live thumbnail previews (auto-refreshing)
- Full-screen live view with stream selector (primary/sub-stream)
- Multi-camera layout support (1×1, 2×2, 3×3, 4×4 grids)
- Camera search and filter by name, location, status, group
- Drag-and-drop camera arrangement for custom layouts

### PTZ Control Overlay
- Directional pad for pan/tilt control
- Zoom slider with smooth interpolation
- Preset buttons with one-click recall
- PTZ tour activation button
- Joystick mode for continuous pan/tilt

### Recording Browser
- Calendar-based date picker for recording selection
- Timeline scrubber with motion event markers
- Playback controls: play, pause, rewind, fast-forward, step frame
- Speed control: 0.5x, 1x, 2x, 4x, 8x
- Clip export: select time range and download as MP4

### System Status Panel
- Camera health summary: online/offline counts, error count
- Recording status: active recordings, storage usage, retention compliance
- Stream health: average FPS, latency, bandwidth usage
- Recent alerts feed with severity indicators
- System uptime and service health indicators

## Acceptance Criteria

- [ ] Camera grid displays live thumbnails with <2s refresh
- [ ] Full-screen live view streams at <500ms latency
- [ ] PTZ controls execute commands with visual feedback
- [ ] Recording browser loads timeline with accurate motion markers
- [ ] Clip export produces valid MP4 files
- [ ] System status panel updates metrics in real-time
- [ ] Dashboard works in Chrome, Firefox, Safari, and Edge

## Dependencies

- **Blocked by:** SEC-SURV-002 (Core streaming and recording engine)
