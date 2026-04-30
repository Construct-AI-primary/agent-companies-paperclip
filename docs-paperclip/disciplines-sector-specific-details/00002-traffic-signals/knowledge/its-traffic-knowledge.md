---
title: ITS Engineering Knowledge for Traffic Signal Installations
description: Comprehensive ITS requirements for traffic signal systems including controller programming, detection systems, adaptive control, communication networks, and NTCIP compliance
author: Paperclip Traffic Signals Project
version: 1.0
date: 2026-04-20
discipline: ITS (Intelligent Transportation Systems)
traffic_focus: true
---

# ITS Engineering Requirements for Traffic Signal Installations

## Overview

Intelligent Transportation Systems (ITS) for traffic signal installations encompass the electronic systems that control traffic flow, detect vehicles and pedestrians, and integrate signals into broader traffic management networks. This document covers the key ITS requirements for traffic signal systems, focusing on controllers, detection, communication, and integration with traffic management centers.

## 1. Traffic Signal Controllers

### Controller Types

#### NEMA TS 1 Controllers
- **Standard**: Older technology, widely deployed
- **Features**: Basic timing, phase skip, pedestrian timing
- **Interface**: Proprietary or standard TS 1 interface
- **Applications**: Smaller intersections, simple timing requirements

#### NEMA TS 2 Controllers
- **Standard**: Current industry standard
- **Features**: Advanced timing, coordination, preemption
- **Interface**: Standard TS 2 interface with NTCIP support
- **Applications**: Standard intersections, coordinated systems

#### Advanced Transportation Controller (ATC)
- **Standard**: Latest technology, open architecture
- **Features**: Software-defined operation, IP connectivity
- **Interface**: Standard ATC interface, NTCIP 1203
- **Applications**: Advanced traffic management, adaptive control

### Controller Specifications
- **Operating Temperature**: -35°C to +74°C
- **Power**: 120VAC, 60Hz (or local standard)
- **Memory**: Minimum 512KB RAM, 2MB flash
- **Channels**: Minimum 16 phases, 8 overlaps
- **Communication**: Ethernet, serial, wireless options

### Timing Parameters
- **Ring Structure**: Standard 8-phase ring with barrier
- **Phases**: 1-8 standard, with vehicle and pedestrian
- **Intervals**: Green, Yellow, All-Red, Pedestrian Walk/Ped Clear
- **Timing Ranges**: Per MUTCD and local requirements

## 2. Vehicle Detection Systems

### Inductive Loop Detection

#### Loop Design
- **Shape**: Rectangular or quadrupole configurations
- **Size**: 6' x 20' minimum for standard lanes
- **Wire**: #12 AWG THHN, 3 turns minimum
- **Sensitivity**: Adjustable, typically 0.02% to 2% inductance change

#### Installation
- **Depth**: 3 inches below pavement surface
- **Sealant**: Hot rubberized asphalt or epoxy
- **Lead-in**: Shielded cable to detector
- **Testing**: Inductance verification before and after installation

#### Advantages
- Proven technology with decades of use
- Reliable detection in all weather
- Low cost per detection point
- Well-understood failure modes

#### Limitations
- Pavement cutting required
- Disruption during installation
- Degradation over time
- Limited data collection

### Video Detection

#### Camera Systems
- **Resolution**: Minimum 720p, 1080p recommended
- **Mounting**: Overhead pole or bracket mounting
- **Detection Zones**: Software-defined detection areas
- **Processing**: Edge-based or virtual loop detection

#### Installation
- **Height**: 15-30 feet above roadway
- **Angle**: 20-30 degrees from vertical
- **Lighting**: Adequate lighting for night operation
- **Mounting**: Vibration-free mounting critical

#### Advantages
- No pavement cutting
- Multiple detection points per camera
- Rich data collection (volume, speed, classification)
- Easy to modify detection zones

#### Limitations
- Weather sensitivity (fog, rain, snow)
- Sun glare issues
- Initial cost higher than loops
- Requires line-of-sight

### Radar Detection

#### Microwave Radar
- **Frequency**: 24 GHz or 77 GHz
- **Range**: Up to 500 feet
- **Beam Width**: Configurable detection zones
- **Mounting**: Side-fire or forward-fire mounting

#### Advantages
- No pavement cutting
- Works in all weather
- Multiple lanes from single unit
- Easy installation

#### Limitations
- Lane assignment challenges
- Stationary vehicle detection issues
- Cost per lane higher than loops
- Limited vehicle classification

### Other Detection Technologies
- **Magnetometers**: Passive magnetic detection
- **Acoustic Sensors**: Sound-based detection
- **Thermal Cameras**: Heat-based detection for night operation
- **Bluetooth/WiFi**: Travel time and origin-destination data

## 3. Pedestrian Detection

### Push Button Detection
- **Standard**: ADA-compliant accessible pedestrian signals
- **Operation**: Mechanical or electronic actuation
- **Feedback**: Visual and audible confirmation
- **Timing**: Recall pedestrian intervals on call

### Passive Pedestrian Detection
- **Video Analytics**: Pedestrian tracking in crosswalk
- **Infrared**: Passive infrared detection
- **Microwave**: Motion detection in pedestrian areas
- **Pressure Mats**: Accessible location detection

### Accessible Pedestrian Signals (APS)
- **Features**: Audible and tactile indications
- **Operation**: Locator tone, walk indication, clearance indication
- **Compliance**: ADA requirements for accessibility
- **Programming**: Per MUTCD and local requirements

## 4. Adaptive Signal Control

### Adaptive Control Technologies

#### SCOOT (Split, Cycle, Offset Optimization Technique)
- **Developer**: TRL (UK)
- **Algorithm**: Real-time optimization of splits, cycles, offsets
- **Data**: Continuous vehicle detection
- **Applications**: Urban arterial corridors

#### SCATS (Sydney Coordinated Adaptive Traffic System)
- **Developer**: Transport for NSW (Australia)
- **Algorithm**: Hierarchical optimization
- **Data**: Degree of saturation at each intersection
- **Applications**: Urban networks, arterial corridors

#### InSync (Adaptive Signal Control Technology)
- **Developer**: Rhythm Engineering
- **Algorithm**: Video-based real-time optimization
- **Data**: Video detection
- **Applications**: Arterials and urban networks

#### OPAC (Optimized Policies for Adaptive Control)
- **Developer**: Iteris
- **Algorithm**: Search-based optimization
- **Data**: Point detection
- **Applications**: Arterials and networks

### Adaptive Control Requirements
- **Detection**: Continuous detection on all approaches
- **Communication**: Real-time communication to central system
- **Processing**: Sufficient computing capacity
- **Integration**: Integration with existing traffic management

## 5. Communication Networks

### Communication Types

#### Fiber Optic
- **Type**: Single-mode or multi-mode fiber
- **Bandwidth**: High bandwidth, future-proof
- **Distance**: Up to 20 km without repeaters
- **Cost**: Higher initial cost, lower operating cost

#### Wireless
- **Types**: Point-to-point microwave, cellular, mesh
- **Bandwidth**: Variable, cellular limited
- **Distance**: Point-to-point up to 15 miles
- **Applications**: Backup communication, remote locations

#### Copper
- **Types**: T1/E1, leased lines
- **Bandwidth**: Limited, legacy systems
- **Distance**: Limited without repeaters
- **Applications**: Legacy systems, backup

### Network Architecture
- **Topology**: Star, ring, or hybrid
- **Protocols**: TCP/IP, UDP, SNMP
- **Security**: Firewalls, encryption, authentication
- **Redundancy**: Dual communication paths for critical signals

### NTCIP Communications
- **NTCIP 1101**: SNMP v1/v2c
- **NTCIP 1102**: STMP (Simple Transportation Management Protocol)
- **NTCIP 1201**: Global Object Definitions
- **NTCIP 1202**: Actuated Signal Controller Objects
- **NTCIP 1203**: Dynamic Message Sign Objects

## 6. Emergency Vehicle Preemption

### Preemption Types

#### Optical Preemption
- **Emitter**: Emergency vehicle-mounted strobe
- **Detector**: Traffic signal-mounted optical sensor
- **Priority**: Immediate green for emergency approach
- **Applications**: Fire apparatus, ambulances

#### Radio Preemption
- **Emitter**: Emergency vehicle radio transmitter
- **Detector**: Traffic signal-mounted radio receiver
- **Priority**: Immediate green for emergency approach
- **Applications**: All emergency vehicles

#### GPS Preemption
- **Emitter**: Emergency vehicle GPS + transmitter
- **Detector**: Central system with GPS tracking
- **Priority**: Preemptive green based on approach
- **Applications**: Fleet vehicles, transit vehicles

### Preemption Operation
- **Detection**: Immediate detection of emergency vehicle
- **Timing**: Immediate transition to preemption phase
- **Duration**: Configurable preemption time
- **Return**: Automatic return to normal operation

## 7. Transit Signal Priority

### Priority Types

#### Passive Priority
- **Method**: Timing adjustments based on schedule
- **Detection**: Schedule-based, no vehicle detection
- **Impact**: Minimal disruption to other traffic
- **Applications**: Bus routes, rail crossings

#### Active Priority
- **Method**: Real-time priority based on vehicle location
- **Detection**: GPS or transponder-based detection
- **Impact**: May disrupt other traffic
- **Applications**: BRT, high-frequency transit

### Priority Levels
- **Level 1**: Minor adjustments, no phase suppression
- **Level 2**: Phase extension, minor phase suppression
- **Level 3**: Phase skip, significant adjustments
- **Level 4**: Full preemption for critical vehicles

## 8. Central Management Systems

### Traffic Management Center (TMC)
- **Functions**: Central monitoring, control, and coordination
- **Interface**: GIS-based map display, signal status
- **Control**: Remote signal timing adjustments
- **Reporting**: Performance metrics, incident reports

### Software Platforms
- **Type**: Commercial or custom traffic management software
- **Features**: Real-time monitoring, historical data, reporting
- **Integration**: Integration with other agency systems
- **Scalability**: Support for small to large networks

### Data Management
- **Collection**: Continuous data collection from signals
- **Storage**: Historical data storage and retrieval
- **Analysis**: Performance analysis and reporting
- **Archive**: Long-term data archiving

## 9. System Integration

### Integration Requirements
- **Standards**: NTCIP compliance for interoperability
- **Protocols**: Standard communication protocols
- **Data Exchange**: Common data formats
- **Documentation**: Interface control documents

### Third-Party Integration
- **RTSP**: Real Time Streaming Protocol for video
- **ONVIF**: Video device interoperability
- **GTFS**: General Transit Feed Specification
- **Datex II**: Traffic information exchange

## 10. Testing and Commissioning

### Controller Testing
- **Timing Verification**: All phases and intervals
- **Coordination**: Verify coordination timing
- **Detection**: Test all detection inputs
- **Preemption**: Test emergency vehicle preemption

### Detection Testing
- **Call Verification**: Detection calls to controller
- **Extension Verification**: Passage and extension time
- **Cancel Verification**: Detection cancel after vehicle passes
- **Count Verification**: Vehicle counts match observation

### Communication Testing
- **Connectivity**: Verify communication to all signals
- **NTCIP**: Verify NTCIP communications
- **Latency**: Verify response time
- **Redundancy**: Test backup communication

### System Integration Testing
- **Central Control**: Verify central commands execute
- **Data Collection**: Verify data collection accuracy
- **Alarms**: Verify alarm generation and notification
- **Reports**: Verify report generation

---

**Document Version**: 1.0
**Last Updated**: 2026-04-20
**Next Review**: 2027-04-20
**Contact**: Traffic Signals ITS Engineering Team
