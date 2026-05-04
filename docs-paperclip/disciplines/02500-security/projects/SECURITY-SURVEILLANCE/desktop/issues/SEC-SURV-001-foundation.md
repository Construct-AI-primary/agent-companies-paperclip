# SEC-SURV-001 — Surveillance Foundation — Camera System Architecture & Video Management Design

- **id:** SEC-SURV-001
- **title:** Surveillance Foundation — Camera System Architecture & Video Management Design
- **labels:** ["security", "surveillance", "1 — Foundation"]
- **phase:** 1 — Foundation
- **status:** todo
- **priority:** Critical
- **story_points:** 8
- **due_date:** 2026-06-15
- **assignee:** domainforge-ai
- **company:** domainforge-ai
- **blocks:** [SEC-SURV-002, SEC-SURV-003, SEC-SURV-004, SEC-SURV-005]
- **estimated:** 4 weeks

## Description

Design and document the complete CCTV camera system architecture and Video Management System (VMS) foundation. This issue covers camera hierarchy modeling, ONVIF/RTSP protocol integration, VMS data models, video storage architecture, and streaming pipeline design. All subsequent surveillance issues depend on this foundation.

## Technical Requirements

### Camera System Architecture
- Define camera hierarchy: sites → zones → cameras → streams
- Model camera capabilities: resolution, FPS, codec support (H.264, H.265, MJPEG)
- Design ONVIF Profile S/G/T discovery and device management layer
- Define RTSP/RTMP streaming endpoint abstraction
- Document proprietary protocol adapter interface (Axis, Hikvision, Dahua)

### VMS Data Models
- `Camera` entity: id, name, model, firmware, location, status, capabilities
- `Stream` entity: id, camera_id, protocol, url, codec, resolution, fps
- `Recording` entity: id, camera_id, start_time, end_time, file_path, size, type
- `PTZPreset` entity: id, camera_id, name, pan, tilt, zoom, speed
- `MotionZone` entity: id, camera_id, polygon_coords, sensitivity, threshold

### Video Storage Architecture
- Storage tiers: hot (SSD/NVMe), warm (HDD), cold (NAS/Object archive)
- Segment-based recording file format (MP4 segments with index)
- Retention policy data model: camera_id, duration_days, max_size_gb, priority
- Storage abstraction layer (local FS, NFS, S3-compatible)

### Streaming Pipeline
- Live stream ingestion: camera → decoder → frame buffer → encoder → output
- WebRTC / HLS / RTMP output profiles
- Frame-level metadata pipeline: timestamp, motion flags, analytics annotations
- Transcoding requirements and GPU acceleration strategy

## Acceptance Criteria

- [ ] C4 architecture diagrams (Context, Container, Component, Code) reviewed and approved
- [ ] Camera and VMS data model specifications documented
- [ ] Video storage architecture blueprint completed
- [ ] Streaming pipeline design documented
- [ ] API contracts for camera management, stream control, recording CRUD specified
- [ ] Architecture decision records (ADRs) published for key technology choices
- [ ] Security review completed (encryption, authentication, access control)

## Dependencies

- **None** — This is the foundation issue

## Blocking

- SEC-SURV-002: Core Integration
- SEC-SURV-003: Discipline Integration
- SEC-SURV-004: Mobile & Offline
- SEC-SURV-005: Compliance & Audit
