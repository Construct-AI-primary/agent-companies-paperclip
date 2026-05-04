# SEC-SURV-WEB-002 — Surveillance Web — Camera Configuration, Recording Schedules & Retention Policies

- **id:** SEC-SURV-WEB-002
- **title:** Surveillance Web — Camera Configuration, Recording Schedules & Retention Policies
- **labels:** ["security", "surveillance", "web", "admin", "3 — Discipline Integration"]
- **phase:** 3 — Discipline Integration
- **status:** todo
- **priority:** High
- **story_points:** 5
- **due_date:** 2026-08-15
- **assignee:** devforge-ai
- **company:** devforge-ai
- **blocked_by:** [SEC-SURV-WEB-001]
- **estimated:** 3 weeks

## Description

Build the web-based administration interface for camera configuration, recording schedule management, motion zone configuration, and retention policy management. This is the primary interface for system administrators to configure and maintain the surveillance system.

## Technical Requirements

### Camera Configuration
- Camera add/edit form: name, location, model, firmware, stream URLs
- ONVIF auto-discovery with one-click camera adoption
- Camera capability viewer: supported resolutions, codecs, PTZ features
- Camera grouping: create/manage camera groups and site hierarchy
- Camera firmware update management and version tracking

### Recording Schedule Editor
- Visual weekly calendar editor for recording schedules
- Per-camera and per-group schedule templates
- Time range selection with drag-to-select intervals
- Recording mode: continuous, motion-triggered, scheduled-only
- Holiday schedule overrides and exception rules

### Motion Zone Configuration
- Visual polygon drawing tool overlaid on camera feed
- Zone naming and color coding for identification
- Sensitivity and threshold sliders per zone
- Zone enable/disable toggle and schedule-based activation
- Zone test mode: show detected motion within zone boundaries

### Retention Policy Management
- Retention policy editor: duration (days), max storage (GB), priority
- Policy inheritance viewer: global → site → group → camera
- Storage usage visualization: current usage vs. policy limits
- Retention hold management: apply/remove legal hold on recordings
- Retention compliance dashboard: % compliant per camera/group

### User & Permission Management
- Role-based access control: viewer, operator, admin, auditor
- Camera-level permission assignment
- User activity log: login history, camera access, configuration changes
- Multi-factor authentication configuration

## Acceptance Criteria

- [ ] Camera configuration form saves and applies settings correctly
- [ ] Recording schedule editor allows intuitive time range selection
- [ ] Motion zone drawing tool accurately maps polygon coordinates
- [ ] Retention policies enforce correctly with inheritance
- [ ] Storage usage visualization shows accurate consumption data
- [ ] Role-based permissions restrict access as configured
- [ ] Admin interface works in Chrome, Firefox, Safari, and Edge

## Dependencies

- **Blocked by:** SEC-SURV-WEB-001 (Web Dashboard)
