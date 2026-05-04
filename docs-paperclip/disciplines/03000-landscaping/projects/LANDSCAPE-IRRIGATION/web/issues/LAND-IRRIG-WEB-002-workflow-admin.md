---
id: LAND-IRRIG-WEB-002
title: "Irrigation Web — Zone Configuration, Schedule Programming & Sensor Calibration"
labels: ["landscaping", "irrigation", "web", "3 — Discipline Integration"]
phase: "3 — Discipline Integration"
status: todo
priority: High
story_points: 5
due_date: "2026-08-15"
assignee: devforge-ai
company: devforge-ai
blocked_by: [LAND-IRRIG-WEB-001]
estimated_weeks: 2
---

# LAND-IRRIG-WEB-002: Irrigation Web — Zone Configuration, Schedule Programming & Sensor Calibration

## Issue Summary

Build the web-based administration interface for irrigation zone configuration, schedule programming, and sensor calibration. This interface provides system administrators with comprehensive tools for managing irrigation system setup and tuning.

## Phase

**3 — Discipline Integration**

## Priority

**High**

## Story Points

**5**

## Estimated Duration

**2 weeks**

## Due Date

**2026-08-15**

## Assignee

**devforge-ai**

## Blocked By

- LAND-IRRIG-WEB-001 — Irrigation Web: System Dashboard, Zone Map & Schedule Overview

---

## Objectives

- Build zone configuration management interface for system setup
- Implement schedule programming wizard with visual timeline
- Create sensor calibration and configuration tools
- Develop weather integration settings panel
- Build water budget configuration dashboard

---

## Scope of Work

### 1. Zone Configuration

#### 1.1 Zone Management
- Zone creation wizard with spatial boundary drawing
- Zone property editor (name, area, plant type, soil type, slope, sun exposure)
- Sprinkler/emitter assignment and configuration
- Valve assignment with wiring configuration
- Pipe network visualization and editing

#### 1.2 Zone Grouping
- Zone group creation and management
- Group sequencing and interlock configuration
- Group priority and water allocation settings
- Zone-to-group assignment interface
- Group schedule coordination

### 2. Schedule Programming

#### 2.1 Schedule Wizard
- Step-by-step schedule creation wizard
- Calendar-based scheduling with visual timeline
- Cycle-and-soak configuration for slope management
- Zone sequencing with delay configuration
- Schedule preview and validation

#### 2.2 Advanced Scheduling
- Weather-based adjustment rules configuration
- Seasonal adjustment curves
- Rain delay and freeze protection settings
- Water window and time-of-day restrictions
- Schedule conflict resolution rules

### 3. Sensor Calibration

#### 3.1 Sensor Management
- Sensor registration and configuration
- Sensor type and model selection
- Communication parameter configuration
- Sensor location mapping on zone map
- Sensor firmware update management

#### 3.2 Calibration Tools
- Moisture sensor calibration with offset adjustment
- Flow meter calibration with K-factor configuration
- Pressure sensor zero and span calibration
- Sensor reading validation and comparison
- Calibration history and certificate management

### 4. Weather & Budget Configuration

#### 4.1 Weather Settings
- Weather provider selection and API key configuration
- Weather station assignment to zones or properties
- ET calculation method selection
- Weather data refresh interval configuration
- Weather alert thresholds

#### 4.2 Budget Configuration
- Budget period definition (monthly, seasonal, annual)
- Budget allocation by zone, group, or property
- Budget rollover and carryover policies
- Conservation goal setting
- Budget alert threshold configuration

---

## Deliverables

1. **Web Administration Interface**
   - Zone configuration management
   - Schedule programming wizard
   - Sensor calibration tools
   - Weather and budget configuration

2. **Documentation**
   - System administration guide
   - Schedule programming reference
   - Sensor calibration procedures

---

## Technical Requirements

### Frontend
- React 18+ with TypeScript
- Form libraries for complex data entry
- Map-based zone boundary editing
- Drag-and-drop schedule timeline
- Real-time validation and preview

### Performance
- Zone configuration save < 2 seconds
- Schedule preview generation < 3 seconds
- Sensor calibration response < 1 second
- Configuration form load < 2 seconds

---

## Success Criteria

- [ ] Zone configuration wizard guides user through complete setup
- [ ] Schedule programming supports all scheduling patterns
- [ ] Sensor calibration tools achieve ±2% accuracy
- [ ] Weather integration settings validated with live API
- [ ] Budget configuration correctly allocates and tracks usage
- [ ] All configuration changes reflected in dashboard within 30 seconds

---

## Dependencies

- BLOCKED BY: LAND-IRRIG-WEB-001 (Dashboard complete)
- Requires: Zone data model from LAND-IRRIG-001
- Requires: Weather API integration from LAND-IRRIG-003
- Requires: Sensor integration from LAND-IRRIG-003

---

## Notes

- Configuration changes should have audit logging for compliance
- Provide configuration templates for common irrigation system types
- Support bulk import/export of zone configurations

---

**Issue Number**: LAND-IRRIG-WEB-002  
**Status**: Todo  
**Priority**: High  
**Assignee**: devforge-ai  
**Company**: devforge-ai  
**Estimated Weeks**: 2  
**Due Date**: 2026-08-15
