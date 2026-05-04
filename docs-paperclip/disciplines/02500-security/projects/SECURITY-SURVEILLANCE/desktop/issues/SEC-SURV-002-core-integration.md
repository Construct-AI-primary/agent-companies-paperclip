# SEC-SURV-002 — Surveillance Core — Live Camera Feeds, Recording Management & PTZ Controls

- **id:** SEC-SURV-002
- **title:** Surveillance Core — Live Camera Feeds, Recording Management & PTZ Controls
- **labels:** ["security", "surveillance", "2 — Core Integration"]
- **phase:** 2 — Core Integration
- **status:** todo
- **priority:** High
- **story_points:** 13
- **due_date:** 2026-07-31
- **assignee:** devforge-ai
- **company:** devforge-ai
- **blocked_by:** [SEC-SURV-001]
- **estimated:** 6 weeks

## Description

Implement the core surveillance engine: live camera feed ingestion and streaming, recording management with scheduled and event-triggered capture, and PTZ (Pan-Tilt-Zoom) control interface. This is the largest implementation issue and forms the backbone of the entire surveillance system.

## Technical Requirements

### Live Camera Feed Engine
- ONVIF device discovery and capability negotiation
- RTSP/RTMP stream ingestion service with auto-reconnection
- Frame decoding pipeline (software + GPU-accelerated)
- WebRTC output for low-latency browser/mobile streaming
- HLS fallback for adaptive bitrate streaming
- Stream health monitoring: FPS, latency, packet loss

### Recording Management
- Scheduled recording service (time-based, 24/7, custom schedules)
- Event-triggered recording (motion, alarm, external trigger)
- Segment-based recording writer with index generation
- Storage manager: tier placement, cleanup, archiving
- Recording browser API: list, search by camera/time, playback URL

### PTZ Controls
- PTZ command interface: pan, tilt, zoom
- Preset management: create, recall, delete
- Speed control and smooth movement interpolation
- Tour/patrol functionality (preset sequences with dwell times)
- Absolute and relative positioning commands

## Acceptance Criteria

- [ ] ONVIF discovery works with 5+ camera models
- [ ] Live streaming delivers sub-500ms latency over LAN
- [ ] Recording engine captures scheduled and event-triggered clips reliably
- [ ] PTZ commands execute with <100ms response time
- [ ] Recording browser API returns searchable results
- [ ] Stream health monitoring reports accurate metrics
- [ ] Integration tests pass for all core functions

## Dependencies

- **Blocked by:** SEC-SURV-001 (Foundation architecture and data models)

## Blocking

- SEC-SURV-WEB-001: Web Dashboard
- SEC-SURV-MOBILE-001: iOS App
- SEC-SURV-MOBILE-002: Android App
- SEC-SURV-003: Discipline Integration
