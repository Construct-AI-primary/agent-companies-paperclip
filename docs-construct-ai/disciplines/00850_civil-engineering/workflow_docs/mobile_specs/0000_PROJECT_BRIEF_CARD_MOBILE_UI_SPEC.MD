---
title: Project Brief Card Mobile Modal Specification
author: Construct AI Memory System Team
date: 2026-03-29
version: 1.0
memory_layer: durable_knowledge
para_section: disciplines/00850_civil-engineering/workflow_docs
gigabrain_tags: disciplines, 00850_civil-engineering, mobile-cards, project-brief, content-analysis-agent, document-control, approval-workflow, mobile-optimized
openstinger_context: mobile-card-specification, agent-coordination, document-management, offline-capabilities
last_updated: 2026-03-29
related_docs:
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD
  - disciplines/00850_civil-engineering/workflow_docs/desktop_specs/00850_0_PROJECT_BRIEF_CARD_UI_SPEC.md
---

# 00850_0_PROJECT_BRIEF_CARD_MOBILE_UI_SPEC.md - Project Brief Card Mobile Modal Specification

## Status
- [x] Mobile modal design completed
- [x] Touch optimization implemented
- [x] Offline capabilities integrated
- [x] Field data capture enabled
- [x] Production ready

## Version History
- v1.0 (2026-03-29): Initial mobile project brief card specification

## Mobile Card Overview

### Card Identity
- **Card Type**: Project Brief (Phase 1, Card 1) - Mobile Optimized
- **Mobile Button Actions**: 👁️ View • 👤 Assign • ✅ Complete • 📥 Download • 📤 Submit
- **Agent Assignment**: Content Analysis Agent (Mobile Optimized)
- **Input Documents**: Client Requirements, Scope Documents (Offline Cached)
- **Output Documents**: Approved Brief
- **Approval Workflow**: PM Sign-off → 00900 Doc Control
- **Mobile Features**: GPS Location, Photo Capture, Voice Notes, Offline Sync

### Mobile Integration
This card operates within the Civil Engineering Mobile Workflow System, providing:
- **Field-Ready Project Initiation**: Complete project brief creation from any location
- **Offline-First Architecture**: Full functionality without network connectivity
- **Mobile-Optimized Interface**: Touch-friendly controls and gesture navigation
- **Field Data Capture**: GPS coordinates, photos, voice recordings, and sensor data
- **Agent Integration**: Content Analysis Agent optimized for mobile processing
- **Document Control**: 00900 system integration with offline synchronization

## Mobile Modal Structure

### Mobile Header (Compact Context)
```
┌─────────────────────────────────────────┐
│ 📋 PROJECT BRIEF CARD                 │
│ Phase 1 of 5 • 🔄 In Progress         │
│ Agent: Content Analysis               │
│ 📍 GPS: Active • 📶 Offline Ready    │
└─────────────────────────────────────────┘
```

### Main Content Area (Mobile Viewport - Swipe Navigation)

#### Section 1: Agent Status Dashboard (Collapsible)
```
┌─ Agent Status ─────────────────────────┐
│ 🧮 Content Analysis Agent: 🟢 Active   │
│ Task: Document Analysis & Processing  │
│ Progress: ████████░░░░░░ 80%          │
│ ETA: 1 min • [Tap to expand]         │
│                                       │
│ 📋 Results:                           │
│ • Requirements: 15 extracted         │
│ • Scope: 8 deliverables identified   │
│ • Risks: 3 critical items            │
└───────────────────────────────────────┘
```

#### Section 2: Project Information Form (Mobile Optimized)
```
┌─ Project Details ──────────────────────┐
│                                       │
│ 📋 Project Information:               │
│ Title: [Highway Expansion Project]    │
│ Client: [Department of Transport]     │
│ Number: [CE-2026-001]                 │
│ Type: [Road Construction] ▼           │
│                                       │
│ 📍 Location & Timeline:               │
│ Address: [Johannesburg, SA]          │
│ GPS: [-26.2041, 28.0473] 📍          │
│ Start: [2026-01-15] 📅               │
│ End: [2027-12-31] 📅                 │
│ Budget: [R500M - R600M] 💰           │
│                                       │
│ 🎯 Objectives: [Voice-to-Text] 🎤    │
│ "Design and construct 2km highway    │
│ bypass to alleviate CBD congestion"  │
│                                       │
│ ✅ Success Criteria:                 │
│ • 20,000 vehicles/day capacity       │
│ • ISO 14001 compliance               │
│ • <10% budget variance               │
└───────────────────────────────────────┘
```

#### Section 3: Field Data Capture (Mobile Specific)
```
┌─ Field Data Capture ───────────────────┐
│                                       │
│ 📷 Site Photos: [3 captured]          │
│ 🖼️ Tap to view • ➕ Add Photo         │
│                                       │
│ 🎤 Voice Notes: [2 recordings]        │
│ 🎵 Tap to play • 🎤 Record New        │
│                                       │
│ 📍 GPS Coordinates:                   │
│ Current: [-26.2041, 28.0473]         │
│ Accuracy: ±3m • 📍 Update Location    │
│                                       │
│ 🌤️ Environmental Data:               │
│ Temp: 24°C • Humidity: 45%           │
│ Barometric: 1013 hPa                 │
│                                       │
│ 📝 Field Observations:               │
│ [Quick notes from site visit]        │
└───────────────────────────────────────┘
```

### Mobile Footer Actions (Touch Optimized)
```
┌─────────────────────────────────────────────────┐
│ 👁️ View    👤 Assign    ✅ Complete    📥 Download │
│ 📤 Submit    💾 Save     🔄 Sync       ❓ Help     │
└─────────────────────────────────────────────────┘
```

## Mobile Button Functionality

### 👁️ View Button (Primary Action - Touch Optimized)
**Function**: Open detailed project brief interface optimized for mobile
**Mobile Behavior**:
- Expands to full-screen mobile view with swipe navigation
- Loads cached project data and offline documents
- Initializes mobile Content Analysis Agent
- Displays touch-friendly form controls and data entry
- Enables voice-to-text input and photo capture

### 👤 Assign Button (Agent Assignment - Mobile)
**Function**: Assign or reassign Content Analysis Agent optimized for mobile
**Mobile Behavior**:
- Opens mobile agent selection with touch controls
- Shows agent availability and mobile processing capabilities
- Allows voice configuration of analysis parameters
- Confirms assignment with mobile-optimized notifications
- Updates mobile header with assigned agent status

### ✅ Complete Button (Workflow Progression - Mobile)
**Function**: Mark project brief as completed with mobile approval workflow
**Mobile Behavior**:
- Validates all required fields with mobile-friendly error messages
- Submits work to PM approval with offline queuing
- Updates card status with mobile push notifications
- Unlocks dependent cards with mobile alerts
- Syncs completion status when connectivity restored

### 📥 Download Button (Template Access - Mobile)
**Function**: Download project brief templates optimized for mobile
**Mobile Behavior**:
- Downloads compressed mobile-friendly templates
- Provides offline-accessible template library
- Includes mobile-optimized form layouts
- Caches templates for offline use
- Syncs downloaded content in background

### 📤 Submit Button (Approval Submission - Mobile)
**Function**: Submit completed project brief with mobile document handling
**Mobile Behavior**:
- Packages documents for mobile transmission
- Queues submission for when connectivity available
- Provides submission confirmation with mobile UI
- Tracks approval status with push notifications
- Enables offline approval viewing

## Mobile Agent Integration

### Content Analysis Agent (Mobile Optimized)
The Content Analysis Agent provides mobile-optimized assistance:

#### Mobile Analysis Capabilities
- **Offline Document Processing**: Processes cached documents without network
- **Voice-Activated Analysis**: Voice commands for document analysis requests
- **Mobile-Optimized AI**: Reduced computational requirements for mobile devices
- **Field Data Integration**: Incorporates GPS, photos, and sensor data
- **Offline Synchronization**: Syncs analysis results when connectivity restored

#### Real-Time Mobile Assistance
```
┌─ Mobile Agent Feed ────────────────────┐
│ ⏰ 14:32 Agent: "Analyzed RFP docs"    │
│ ⏰ 14:33 Agent: "Extracted 15 reqs"    │
│ ⏰ 14:35 Agent: "Recommended template" │
│ ⏰ 14:36 Agent: "Brief validation: 98%"│
│ ⏰ 14:37 Agent: "Ready for submission" │
└───────────────────────────────────────┘
```

## Mobile Document Control

### Offline-First Document Management
- **Local Caching**: All documents cached for offline access
- **Background Sync**: Automatic synchronization when connectivity available
- **Conflict Resolution**: Mobile-optimized conflict resolution for offline edits
- **Version Control**: Offline version tracking with cloud reconciliation
- **Compressed Storage**: Optimized storage for mobile device constraints

### Mobile Document Workflow
1. **Offline Loading**: Access cached documents without network
2. **Mobile Editing**: Touch-optimized document editing and annotation
3. **Field Capture**: Integrated photo, voice, and GPS data capture
4. **Background Sync**: Automatic upload when connectivity restored
5. **Cloud Integration**: Seamless integration with 00900 when online

## Mobile Approval Workflow

### Touch-Optimized Approval Process
1. **Mobile Notification**: Push notification of approval requests
2. **Offline Review**: Review documents cached on device
3. **Touch Approval**: Large touch targets for approval actions
4. **Voice Comments**: Voice-to-text for approval comments
5. **Offline Queue**: Queue approvals for transmission when online

### Mobile Approval Status Tracking
- **Push Notifications**: Real-time status updates via mobile alerts
- **Offline Indicators**: Clear offline/online status indicators
- **Touch Feedback**: Haptic feedback for approval actions
- **Voice Status**: Voice announcements of approval status changes

## Mobile Field Capabilities

### GPS Integration
- **Automatic Location Capture**: GPS coordinates automatically captured
- **Location Accuracy**: Real-time accuracy indicators and updates
- **Location History**: Track movement during site visits
- **Geofencing**: Automatic triggers based on location
- **Offline Maps**: Cached maps for offline navigation

### Photo Capture
- **Integrated Camera**: Direct access to device camera
- **Photo Annotation**: Touch-based photo markup and notes
- **Automatic Metadata**: GPS, timestamp, and device info
- **Offline Storage**: Compressed storage for offline access
- **Sync Management**: Intelligent photo upload prioritization

### Voice Recording
- **Voice Notes**: Integrated voice recording for field observations
- **Voice-to-Text**: Automatic transcription for documentation
- **Voice Commands**: Voice-activated workflow controls
- **Offline Processing**: Local voice processing without network
- **Audio Compression**: Optimized storage for mobile devices

### Sensor Data Integration
- **Environmental Sensors**: Temperature, humidity, barometric pressure
- **Device Sensors**: Accelerometer, gyroscope for context awareness
- **Automatic Logging**: Continuous sensor data collection
- **Context Awareness**: Automatic workflow triggers based on conditions

## Mobile Performance Optimization

### Offline-First Architecture
- **Service Worker**: Background sync and caching management
- **Progressive Web App**: Installable mobile experience
- **Local Storage**: IndexedDB for structured data storage
- **Cache Management**: Intelligent cache invalidation and updates
- **Bandwidth Optimization**: Compressed data transmission

### Mobile UI Performance
- **Touch Responsiveness**: <100ms response to touch interactions
- **Smooth Scrolling**: 60fps scrolling performance
- **Lazy Loading**: On-demand content loading
- **Memory Management**: Efficient memory usage for mobile constraints
- **Battery Optimization**: Minimal battery impact during operation

## Mobile Security & Compliance

### Mobile Data Security
- **Device Encryption**: Full device-level encryption
- **Biometric Access**: Fingerprint/Face ID integration
- **Remote Wipe**: Remote data wipe for lost devices
- **Offline Security**: Encrypted local data storage
- **Secure Sync**: End-to-end encrypted synchronization

### Mobile Compliance
- **Offline Audit Trail**: Complete local audit logging
- **Compliance Validation**: Offline compliance checking
- **Data Retention**: Mobile-optimized data cleanup policies
- **Access Control**: Role-based permissions with mobile UI
- **Regulatory Compliance**: Mobile access to compliance documentation

## Mobile Accessibility

### Touch Accessibility
- **Large Touch Targets**: Minimum 44px touch targets
- **Gesture Support**: Multi-touch gesture recognition
- **Voice Control**: Voice-activated interface controls
- **Haptic Feedback**: Tactile feedback for user actions
- **Screen Reader**: Mobile screen reader compatibility

### Visual Accessibility
- **High Contrast**: High contrast mode support
- **Font Scaling**: Dynamic font size adjustment
- **Color Independence**: Interface usable in monochrome
- **Motion Reduction**: Respects reduced motion preferences
- **Dark Mode**: Automatic dark mode support

## Mobile Implementation Architecture

### Mobile Component Structure
```
CivilEngineeringMobile/
├── ProjectBriefCard/
│   ├── MobileHeader.jsx         # Compact mobile header
│   ├── TouchForm.jsx           # Touch-optimized form
│   ├── FieldCapture.jsx        # GPS/Photo/Voice capture
│   ├── OfflineSync.jsx         # Background sync management
│   ├── MobileFooter.jsx        # Touch-optimized actions
│   └── MobileAgent.jsx         # Mobile agent integration
```

### Mobile API Integration
```javascript
// Mobile-optimized endpoints
POST /mobile-api/workflows/{projectId}/cards/{cardId}/sync
GET  /mobile-api/workflows/{projectId}/cards/{cardId}/offline-status
POST /mobile-api/field-data/capture
GET  /mobile-api/documents/cached

// Offline queue management
POST /mobile-api/queue/submit
GET  /mobile-api/queue/status
DELETE /mobile-api/queue/clear

// Mobile agent coordination
POST /mobile-api/agents/mobile-assign
GET  /mobile-api/agents/mobile-status
POST /mobile-api/agents/mobile-process
```

## Mobile Testing & Validation

### Mobile Device Testing
- **iOS Compatibility**: iOS 14+ with full feature support
- **Android Compatibility**: Android 8+ with full feature support
- **Cross-Device Testing**: Consistent experience across device sizes
- **Offline Testing**: Full functionality without network connectivity
- **Performance Testing**: Optimized for various mobile hardware

### Mobile User Experience Testing
- **Touch Interaction**: Intuitive touch-based navigation
- **Gesture Recognition**: Natural gesture-based controls
- **Voice Integration**: Reliable voice command processing
- **Field Usability**: Effective use in various field conditions
- **Accessibility Testing**: WCAG 2.1 AA compliance validation

## Mobile Success Metrics

### Functional Metrics
- **Mobile Load Time**: <3 seconds on 4G, <5 seconds on 3G
- **Offline Functionality**: 100% core features work offline
- **Sync Reliability**: >99% successful background synchronization
- **Touch Responsiveness**: <100ms response to all touch interactions
- **Battery Usage**: <15% additional battery consumption

### User Experience Metrics
- **Task Completion**: >95% mobile task completion rate
- **Field Productivity**: >30% improvement in field data capture speed
- **User Satisfaction**: >90% user satisfaction with mobile experience
- **Error Rate**: <2% user errors in mobile interface
- **Adoption Rate**: >85% field staff using mobile application

## Mobile Related Documentation

- [00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD](00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD) - Main workflow overview
- [desktop_specs/00850_0_PROJECT_BRIEF_CARD_UI_SPEC.md](desktop_specs/00850_0_PROJECT_BRIEF_CARD_UI_SPEC.md) - Desktop specification
- [00850_MOBILE_PLATFORM_SPEC.md](00850_MOBILE_PLATFORM_SPEC.md) - Mobile platform architecture

## Status
- [x] Mobile modal specification complete
- [x] Touch optimization implemented
- [x] Offline capabilities integrated
- [x] Field data capture enabled
- [x] Performance optimized
- [x] Accessibility compliant
- [x] Testing validated
- [x] Production ready

## Version History
- v1.0 (2026-03-29): Initial mobile project brief card specification with touch optimization, offline capabilities, and field data capture