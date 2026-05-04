---
id: LAND-IRRIG-002
title: "Irrigation Core — Zone Scheduling, Flow Monitoring & Controller Integration"
labels: ["landscaping", "irrigation", "2 — Core Integration"]
phase: "2 — Core Integration"
status: todo
priority: High
story_points: 13
due_date: "2026-07-31"
assignee: devforge-ai
company: devforge-ai
blocked_by: [LAND-IRRIG-001]
estimated_weeks: 6
---

# LAND-IRRIG-002: Irrigation Core — Zone Scheduling, Flow Monitoring & Controller Integration

## Issue Summary

Implement the core irrigation engine including zone scheduling, real-time flow monitoring, leak detection, and multi-vendor controller integration. This issue delivers the central runtime components that manage irrigation operations.

## Phase

**2 — Core Integration**

## Priority

**High**

## Story Points

**13**

## Estimated Duration

**6 weeks**

## Due Date

**2026-07-31**

## Assignee

**devforge-ai**

## Blocked By

- LAND-IRRIG-001 — Irrigation Foundation: System Architecture, Zone Design & Data Model

---

## Objectives

- Implement zone scheduling engine with calendar-based and cycle-and-soak scheduling
- Build real-time flow monitoring system with leak detection algorithms
- Develop multi-vendor controller integration layer with command execution
- Create flow alert generation and notification routing
- Implement controller health monitoring and status polling

---

## Scope of Work

### 1. Zone Scheduling Engine

#### 1.1 Schedule Management
- Create, read, update, delete schedule operations
- Calendar-based scheduling with start times, durations, and day-of-week patterns
- Cycle-and-soak scheduling for slopes and heavy soils
- Zone sequencing with configurable delays between zones
- Schedule conflict detection and resolution

#### 1.2 Schedule Execution
- Schedule dispatch engine with time-based triggers
- Runtime tracking and adjustment for weather overrides
- Manual start/stop with priority overrides
- Schedule pause and resume capabilities
- Historical schedule execution logging

#### 1.3 Schedule Optimization
- Water window optimization based on time-of-day restrictions
- Zone grouping for concurrent operation within flow capacity
- Priority-based schedule compression
- Seasonal adjustment factors

### 2. Flow Monitoring System

#### 2.1 Flow Data Ingestion
- Real-time flow meter data ingestion pipeline
- Flow rate calculation and totalization per zone and system-wide
- Pressure monitoring and data collection
- Historical flow data storage and retrieval

#### 2.2 Leak Detection
- Continuous flow detection (flow when no zones active)
- High flow rate anomaly detection
- Low pressure anomaly detection
- Baseline learning for normal flow patterns
- Leak location estimation using zone-level flow data

#### 2.3 Flow Alerts
- Alert severity classification (info, warning, critical)
- Alert generation rules engine
- Notification routing to mobile, email, SMS
- Alert acknowledgment and resolution workflow
- Alert history and trending

### 3. Controller Integration

#### 3.1 Communication Layer
- TCP/IP and serial communication protocol support
- Command encoding/decoding for vendor-specific protocols
- Reliable command delivery with retry and acknowledgment
- Connection pooling and keep-alive management

#### 3.2 Vendor Adapters
- Adapter interface implementation for each supported controller brand
- Capability discovery and feature negotiation
- Vendor-specific schedule format conversion
- Controller firmware version management

#### 3.3 Controller Management
- Controller registration and configuration
- Status polling and health monitoring
- Command queue with priority and ordering
- Offline detection and reconnection strategy
- Controller time synchronization

---

## Deliverables

1. **Zone Scheduling Engine**
   - Schedule management REST API
   - Schedule execution service
   - Schedule optimization algorithms

2. **Flow Monitoring System**
   - Flow data ingestion pipeline
   - Leak detection algorithms
   - Alert generation and notification service

3. **Controller Integration Layer**
   - Communication protocol abstraction
   - Vendor adapter implementations (minimum 3 vendors)
   - Controller management service

4. **Documentation**
   - API documentation for scheduling and monitoring
   - Controller integration guide
   - Alert configuration guide

---

## Technical Requirements

### Scheduling
- Support schedules with 1-minute resolution
- Support unlimited zones per schedule
- Cycle-and-soak must support up to 10 cycles per zone
- Schedule changes must take effect within 30 seconds

### Flow Monitoring
- Flow data sampling at minimum 1-second intervals
- Leak detection within 30 seconds of continuous flow
- Flow rate accuracy within ±2% of calibrated meter
- Support for both pulse-output and digital flow meters

### Controller Integration
- Support minimum 3 vendor protocols
- Command acknowledgment within 5 seconds
- Automatic reconnection within 30 seconds of connection loss
- Support for minimum 100 controllers per gateway

---

## Success Criteria

- [ ] Zone scheduling engine passes all test scenarios including edge cases
- [ ] Flow monitoring detects leaks within 30 seconds of occurrence
- [ ] Controller integration supports at least 3 vendor protocols
- [ ] Alert notifications delivered within 10 seconds of detection
- [ ] API integration tests pass with 95%+ coverage
- [ ] Schedule execution accuracy within ±1 second of programmed time

---

## Dependencies

- BLOCKED BY: LAND-IRRIG-001 (Foundation complete)
- Requires: Controller hardware for integration testing
- Requires: Flow meter specifications and test data
- Requires: Access to vendor API documentation and SDKs

---

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Vendor protocol complexity | Medium | High | Early prototyping, vendor engineering support |
| Leak detection false positives | Medium | Medium | Machine learning baseline, configurable thresholds |
| Controller communication reliability | Medium | High | Robust retry logic, offline queue, health monitoring |
| Schedule conflict resolution complexity | Low | Medium | Deterministic conflict resolution rules |

---

## Notes

- Coordinate with LAND-IRRIG-WEB-001 for dashboard integration
- Mobile issues LAND-IRRIG-MOBILE-001 and LAND-IRRIG-MOBILE-002 depend on this issue's API
- Performance testing with simulated 100+ controllers required

---

**Issue Number**: LAND-IRRIG-002  
**Status**: Todo  
**Priority**: High  
**Assignee**: devforge-ai  
**Company**: devforge-ai  
**Estimated Weeks**: 6  
**Due Date**: 2026-07-31
