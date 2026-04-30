---
title: Site Survey Card Mobile Modal Specification
author: Construct AI Memory System Team
date: 2026-03-29
version: 1.0
memory_layer: durable_knowledge
para_section: disciplines/00850_civil-engineering/workflow_docs
gigabrain_tags: disciplines, 00850_civil-engineering, mobile-cards, site-survey, gis-processing-agent, document-control, offline-capabilities
openstinger_context: mobile-card-specification, field-data-capture, offline-mapping, gps-integration
last_updated: 2026-03-29
related_docs:
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD
  - disciplines/00850_civil-engineering/workflow_docs/desktop_specs/00850_0_SITE_SURVEY_CARD_UI_SPEC.md
---

# 00850_0_SITE_SURVEY_CARD_MOBILE_UI_SPEC.md - Site Survey Card Mobile Modal Specification

## Status
- [x] Mobile modal design completed
- [x] GPS integration implemented
- [x] Offline mapping enabled
- [x] Field survey tools activated
- [x] Production ready

## Version History
- v1.0 (2026-03-29): Initial mobile site survey card specification

## Mobile Card Overview

### Card Identity
- **Card Type**: Site Survey (Phase 1, Card 2) - Mobile Optimized
- **Mobile Button Actions**: 👁️ View • 👤 Assign • ✅ Complete • 📥 Download • 📤 Submit
- **Agent Assignment**: GIS Processing Agent (Mobile Optimized)
- **Input Documents**: Topographic Data, Utility Maps (Offline Cached)
- **Output Documents**: Survey Report
- **Approval Workflow**: Technical Lead → 00900 Doc Control
- **Mobile Features**: GPS Survey, Photo Documentation, Offline Maps, Voice Notes

### Mobile Integration
This card operates within the Civil Engineering Mobile Workflow System, providing:
- **Field Survey Capabilities**: Complete topographic and utility surveying from mobile devices
- **Offline Mapping**: Full offline map access with cached satellite imagery
- **GPS Survey Tools**: Integrated GPS positioning with sub-meter accuracy
- **Photo Documentation**: Automatic geo-tagged photo capture for survey points
- **Real-time Data Collection**: Live survey data collection with instant validation
- **Offline Synchronization**: Seamless sync of survey data when connectivity restored

## Mobile Modal Structure

### Mobile Header (Field Context)
```
┌─────────────────────────────────────────┐
│ 📍 SITE SURVEY CARD                    │
│ Phase 1 of 5 • 🔄 In Progress          │
│ Agent: GIS Processing                  │
│ 📍 GPS: ±2m • 🗺️ Offline Maps         │
└─────────────────────────────────────────┘
```

### Main Content Area (Mobile Viewport - Map-Centric)

#### Section 1: Survey Status Dashboard (Collapsible)
```
┌─ Survey Status ─────────────────────────┐
│ 🗺️ GIS Processing Agent: 🟢 Active      │
│ Task: Topographic Survey & Mapping     │
│ Progress: ████████░░░░░░ 80%           │
│ ETA: 3 min • [Tap to expand]          │
│                                        │
│ 📊 Survey Results:                     │
│ • Points surveyed: 247 captured       │
│ • Area mapped: 45.2 hectares          │
│ • Accuracy: ±0.05m achieved           │
└───────────────────────────────────────┘
```

#### Section 2: Interactive Survey Map (Mobile Optimized)
```
┌─ Survey Map View ───────────────────────┐
│ 🗺️ [Interactive Map - Full Screen]     │
│                                        │
│ 📍 Survey Points: [247 active]         │
│ 🔵 Control Points • 🔴 Detail Points   │
│ 🟡 Utility Points • 🟢 Boundary Points  │
│                                        │
│ 🛠️ Survey Tools:                       │
│ 📍 GPS Point • 📷 Photo Point          │
│ 🎤 Voice Note • 📏 Measure Distance    │
│                                        │
│ 📊 Real-time Stats:                    │
│ GPS Accuracy: ±0.03m                  │
│ Points Today: 89                      │
│ Coverage: 78% complete                │
└───────────────────────────────────────┘
```

#### Section 3: Field Data Collection (Mobile Specific)
```
┌─ Field Survey Tools ────────────────────┐
│                                        │
│ 📍 GPS Survey Point:                   │
│ Tap map to place • Auto-capture GPS    │
│ Accuracy: ±0.05m • Elevation: Auto     │
│                                        │
│ 📷 Photo Documentation:                │
│ [12 photos captured]                   │
│ 🖼️ Tap to view • 📷 Capture New        │
│ Auto geo-tag • Timestamp included      │
│                                        │
│ 🎤 Voice Survey Notes:                 │
│ [8 recordings] • 🎵 Play • 🎤 Record   │
│ "Noted underground utility at point    │
│ 147. Marked for avoidance zone."       │
│                                        │
│ 📊 Survey Measurements:                │
│ Distance: 247.5m • Area: 12,450m²     │
│ Elevation Range: 1452-1489m AHD       │
│                                        │
│ 🌤️ Environmental Conditions:          │
│ Temp: 26°C • Visibility: Good          │
│ Wind: 15km/h • Time: 14:32            │
└───────────────────────────────────────┘
```

### Mobile Footer Actions (Survey Optimized)
```
┌─────────────────────────────────────────────────┐
│ 👁️ Map View    📍 GPS Point    📷 Photo    🎤 Voice │
│ ✅ Complete    📥 Export      🔄 Sync      🛠️ Tools │
└─────────────────────────────────────────────────┘
```

## Mobile Button Functionality

### 👁️ View Button (Map-Centric Display)
**Function**: Open interactive survey map with full mobile mapping capabilities
**Mobile Behavior**:
- Launches full-screen map view with offline satellite imagery
- Displays real-time GPS position and survey points
- Enables touch-based map navigation and zoom
- Provides survey point selection and editing
- Integrates with device compass for orientation

### 📍 GPS Point Button (Survey Data Capture)
**Function**: Capture precise GPS survey points with mobile-optimized interface
**Mobile Behavior**:
- Activates high-accuracy GPS with real-time accuracy display
- Allows touch placement of survey points on map
- Auto-captures elevation data and environmental conditions
- Provides haptic feedback for successful point capture
- Queues data for offline synchronization

### 📷 Photo Button (Visual Documentation)
**Function**: Capture geo-tagged survey photographs with mobile camera integration
**Mobile Behavior**:
- Launches device camera with survey-specific overlays
- Auto-applies GPS coordinates and survey point metadata
- Provides photo annotation tools (markup, notes)
- Compresses images for efficient mobile storage
- Syncs photos in background when connectivity available

### 🎤 Voice Button (Audio Survey Notes)
**Function**: Record voice notes for survey observations with mobile audio capture
**Mobile Behavior**:
- Activates voice recording with noise reduction
- Associates recordings with specific survey points
- Provides voice-to-text transcription for documentation
- Stores compressed audio files for offline access
- Enables voice commands for survey tool activation

### ✅ Complete Button (Survey Finalization)
**Function**: Complete survey data collection with mobile validation
**Mobile Behavior**:
- Validates survey coverage and point density requirements
- Generates survey report with mobile-optimized formatting
- Submits to Technical Lead approval with offline queuing
- Provides completion summary with key survey statistics
- Unlocks dependent workflow cards

## Mobile GIS Integration

### Offline Mapping Capabilities
- **Cached Satellite Imagery**: High-resolution offline map tiles
- **Vector Data Layers**: Survey points, boundaries, utilities
- **GPS Integration**: Real-time positioning with accuracy indicators
- **Map Synchronization**: Background update of map data
- **Custom Overlays**: Project-specific survey boundaries and zones

### Mobile Survey Tools
- **Point Capture**: Touch-based survey point placement
- **Line Survey**: Continuous GPS tracking for alignments
- **Area Survey**: Polygon creation for site boundaries
- **Utility Mapping**: Underground service detection and marking
- **Level Survey**: Elevation profiling with device sensors

## Mobile Data Management

### Offline Survey Database
- **Local SQLite Storage**: Structured survey data storage
- **IndexedDB Integration**: Fast retrieval of survey points
- **Data Compression**: Optimized storage for large survey datasets
- **Conflict Resolution**: Intelligent merging of offline edits
- **Version Control**: Offline change tracking with cloud sync

### Background Synchronization
- **Smart Sync**: Prioritizes critical survey data for upload
- **Bandwidth Optimization**: Compressed data transmission
- **Resume Capability**: Continues interrupted sync operations
- **Status Monitoring**: Real-time sync progress indicators
- **Error Recovery**: Automatic retry with exponential backoff

## Mobile Survey Features

### GPS Accuracy Optimization
- **Multi-Constellation**: GPS, GLONASS, Galileo integration
- **RTK Capability**: Real-time kinematic positioning when available
- **Accuracy Indicators**: Real-time precision display
- **Calibration Tools**: Device-specific accuracy calibration
- **Quality Assurance**: Automated point quality validation

### Environmental Integration
- **Weather Monitoring**: Automatic weather condition logging
- **Visibility Tracking**: Survey condition documentation
- **Time Synchronization**: NTP-based timestamp accuracy
- **Device Orientation**: Compass integration for survey alignment
- **Battery Monitoring**: Low-power mode for extended field use

## Mobile Performance Optimization

### Field-Ready Performance
- **Fast Map Loading**: <2 seconds map display from cache
- **Responsive GPS**: <1 second position updates
- **Efficient Storage**: 50MB survey data capacity
- **Battery Efficiency**: 8-hour continuous survey operation
- **Memory Management**: Automatic cleanup of old survey data

### Offline Reliability
- **100% Offline Operation**: Full functionality without network
- **Data Persistence**: Survives app restarts and device reboots
- **Error Recovery**: Automatic recovery from GPS signal loss
- **Data Integrity**: Checksum validation for survey data accuracy
- **Backup Systems**: Local backup of critical survey data

## Mobile Security & Compliance

### Field Data Security
- **Encrypted Storage**: AES-256 encryption for survey data
- **Biometric Access**: Fingerprint/Face ID for app access
- **Remote Lock**: GPS-based device locking for lost equipment
- **Data Sanitization**: Automatic cleanup of sensitive location data
- **Audit Logging**: Complete field activity logging

### Survey Compliance
- **Accuracy Standards**: Meets survey accuracy requirements
- **Data Quality**: Automated validation against survey standards
- **Regulatory Compliance**: Adherence to surveying regulations
- **Professional Standards**: Compliance with engineering practice
- **Data Retention**: Configurable retention policies for survey data

## Mobile Accessibility

### Field Accessibility
- **Glove-Friendly**: Large touch targets for gloved operation
- **High Contrast**: Clear visibility in bright sunlight
- **Voice Control**: Hands-free operation for safety
- **Screen Reader**: Audio feedback for visually impaired users
- **Emergency Access**: Quick access to emergency contacts

### Device Compatibility
- **Rugged Devices**: Support for ruggedized field tablets
- **Screen Sizes**: Optimized for 7-12 inch displays
- **Orientation Support**: Portrait and landscape operation
- **Peripheral Integration**: External GPS and survey equipment
- **Cross-Platform**: Consistent experience across iOS and Android

## Mobile Implementation Architecture

### Mobile Survey Components
```
CivilEngineeringMobile/
├── SiteSurveyCard/
│   ├── MobileMap.jsx           # Interactive survey map
│   ├── GPSTools.jsx           # GPS survey functionality
│   ├── PhotoCapture.jsx       # Camera integration
│   ├── VoiceRecorder.jsx      # Audio survey notes
│   ├── OfflineStorage.jsx     # Local data management
│   ├── SyncManager.jsx        # Background synchronization
│   └── SurveyTools.jsx        # Survey-specific tools
```

### Mobile Survey APIs
```javascript
// GPS and mapping
GET  /mobile-api/survey/gps/position
POST /mobile-api/survey/points/capture
GET  /mobile-api/maps/tiles/offline

// Data collection
POST /mobile-api/survey/photos/upload
POST /mobile-api/survey/voice/record
POST /mobile-api/survey/measurements/log

// Synchronization
POST /mobile-api/survey/sync/upload
GET  /mobile-api/survey/sync/status
POST /mobile-api/survey/conflicts/resolve
```

## Mobile Testing & Validation

### Field Testing
- **GPS Accuracy**: ±0.05m accuracy validation in various conditions
- **Offline Operation**: 8-hour continuous operation without network
- **Data Integrity**: 100% data preservation through app restarts
- **Sync Reliability**: >99.5% successful background synchronization
- **Battery Performance**: Minimum 6-hour operation under typical use

### User Experience Testing
- **Field Usability**: Intuitive operation while wearing PPE
- **Weather Resistance**: Functionality in rain, dust, and extreme temperatures
- **Device Durability**: Operation after drops and rough handling
- **Learning Curve**: <30 minutes training for new surveyors
- **Error Recovery**: Clear guidance for GPS signal loss and equipment issues

## Mobile Success Metrics

### Functional Metrics
- **Survey Accuracy**: >99% of points within required accuracy (±0.05m)
- **Data Collection Speed**: 50% faster than traditional survey methods
- **Offline Capability**: 100% functionality without network connectivity
- **Sync Success Rate**: >99% successful data synchronization
- **App Stability**: <0.1% crash rate during field operations

### User Experience Metrics
- **Field Productivity**: >40% increase in daily survey point collection
- **User Satisfaction**: >95% surveyor satisfaction with mobile tools
- **Training Time**: <2 hours for full proficiency
- **Error Rate**: <1% user-generated data errors
- **Adoption Rate**: >90% field surveyors using mobile application

## Mobile Related Documentation

- [00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD](00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD) - Main workflow overview
- [desktop_specs/00850_0_SITE_SURVEY_CARD_UI_SPEC.md](desktop_specs/00850_0_SITE_SURVEY_CARD_UI_SPEC.md) - Desktop specification
- [00850_MOBILE_PLATFORM_SPEC.md](00850_MOBILE_PLATFORM_SPEC.md) - Mobile platform architecture

## Status
- [x] Mobile modal specification complete
- [x] GPS integration implemented
- [x] Offline mapping enabled
- [x] Field survey tools activated
- [x] Performance optimized
- [x] Accessibility compliant
- [x] Testing validated
- [x] Production ready

## Version History
- v1.0 (2026-03-29): Initial mobile site survey card specification with GPS integration, offline mapping, and field survey tools