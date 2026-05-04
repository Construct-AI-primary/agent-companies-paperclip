---
id: LAND-IRRIG-WEB-001
title: "Irrigation Web — System Dashboard, Zone Map & Schedule Overview"
labels: ["landscaping", "irrigation", "web", "2 — Core Integration"]
phase: "2 — Core Integration"
status: todo
priority: High
story_points: 5
due_date: "2026-07-15"
assignee: devforge-ai
company: devforge-ai
blocked_by: [LAND-IRRIG-002]
estimated_weeks: 2
---

# LAND-IRRIG-WEB-001: Irrigation Web — System Dashboard, Zone Map & Schedule Overview

## Issue Summary

Build the web-based irrigation system dashboard featuring an interactive zone map, real-time system status, and schedule overview. This is the primary web interface for monitoring and managing irrigation operations.

## Phase

**2 — Core Integration**

## Priority

**High**

## Story Points

**5**

## Estimated Duration

**2 weeks**

## Due Date

**2026-07-15**

## Assignee

**devforge-ai**

## Blocked By

- LAND-IRRIG-002 — Irrigation Core: Zone Scheduling, Flow Monitoring & Controller Integration

---

## Objectives

- Build interactive zone map with status visualization and spatial context
- Implement schedule overview calendar view with event details
- Create system status dashboard with key performance metrics
- Develop real-time data refresh via WebSocket connections
- Build zone control interface for manual start/stop and runtime adjustment

---

## Scope of Work

### 1. System Dashboard

#### 1.1 Dashboard Overview
- System status summary (online, offline, error counts)
- Active zone display with runtime remaining
- Current flow rate and pressure readings
- Today's water usage vs. target
- Active alerts summary with severity breakdown

#### 1.2 Key Metrics
- Total water usage (today, this week, this month)
- System efficiency indicators
- Controller health status
- Sensor online/offline counts
- Schedule completion percentage

### 2. Interactive Zone Map

#### 2.1 Map Interface
- Interactive map with zone boundaries and labels
- Zone status color coding (running, scheduled, idle, offline, error)
- Click-to-select zone details panel
- Zoom and pan controls
- Satellite and street map layer options

#### 2.2 Zone Details
- Zone information panel (name, area, plant type, soil type)
- Current zone status and runtime remaining
- Last watering report with duration and water used
- Quick actions (start, stop, adjust runtime)
- Zone sensor readings (moisture, flow, pressure)

### 3. Schedule Overview

#### 3.1 Calendar View
- Monthly, weekly, and daily schedule views
- Schedule events with zone name, duration, and status
- Color-coded schedule events by zone group
- Drag-and-drop schedule adjustment
- Schedule conflict indicators

#### 3.2 Schedule Details
- Schedule event detail with zone, time, and duration
- Weather-adjusted runtime indicators
- Schedule history with completion status
- Schedule override and skip controls
- Recurring schedule pattern display

---

## Deliverables

1. **Web Dashboard Application**
   - System status dashboard
   - Interactive zone map
   - Schedule overview calendar
   - Zone control interface

2. **Documentation**
   - User guide for dashboard operations
   - Dashboard configuration guide
   - API integration guide for real-time data

---

## Technical Requirements

### Frontend
- React 18+ with TypeScript
- Map library (Mapbox GL JS or Leaflet)
- WebSocket client for real-time updates
- Chart library for metrics visualization
- Responsive design for desktop and tablet

### Performance
- Dashboard initial load < 3 seconds
- Zone map rendering < 2 seconds for 100+ zones
- Real-time data refresh < 1 second
- Schedule calendar load < 2 seconds

---

## Success Criteria

- [ ] Dashboard displays real-time system status with < 1 second latency
- [ ] Zone map renders correctly with 100+ zones
- [ ] Schedule calendar supports monthly, weekly, and daily views
- [ ] Zone control commands executed within 2 seconds
- [ ] WebSocket connection maintains stability during extended sessions
- [ ] Dashboard passes accessibility testing (WCAG 2.1 AA)

---

## Dependencies

- BLOCKED BY: LAND-IRRIG-002 (Core Integration API)
- Requires: Zone map data and spatial coordinates
- Requires: WebSocket infrastructure for real-time updates

---

## Notes

- Coordinate with LAND-IRRIG-002 for API contracts
- Map should support both GeoJSON zone boundaries and pin-based zone markers
- Dashboard should be embeddable in iframe for third-party integrations

---

**Issue Number**: LAND-IRRIG-WEB-001  
**Status**: Todo  
**Priority**: High  
**Assignee**: devforge-ai  
**Company**: devforge-ai  
**Estimated Weeks**: 2  
**Due Date**: 2026-07-15
