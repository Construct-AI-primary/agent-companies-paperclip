---
title: Site Survey Card Modal Specification
author: Construct AI Memory System Team
date: 2026-03-28
version: 2.0
memory_layer: durable_knowledge
para_section: disciplines/00850_civil-engineering/workflow_docs
gigabrain_tags: disciplines, 00850_civil-engineering, modal-cards, site-survey, gis-agent, topographic-data, document-control, approval-workflow
openstinger_context: modal-card-specification, gis-integration, survey-data-management, document-management, approval-system
last_updated: 2026-03-28
related_docs:
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_UI_CARDS_IMPLEMENTATION_SUMMARY.md
  - disciplines/00850_civil-engineering/workflow_docs/00850_CIVIL_ENGINEERING_MODAL_REDESIGN_SPECIFICATION.md
---

# 00850_0_SITE_SURVEY_CARD_UI_SPEC.md - Site Survey Card Modal Specification

## Status
- [x] Modal redesign completed
- [x] Agent integration implemented
- [x] Document control integrated
- [x] Approval workflow configured
- [x] Production ready

## Version History
- v1.0 (2026-03-27): Initial card specification
- v2.0 (2026-03-28): Complete modal workflow integration

## Modal Card Overview

### Card Identity
- **Card Type**: Site Survey (Phase 1, Card 2)
- **Modal Button Actions**: 👁️ View • 👤 Assign • ✅ Complete • 📥 Download • 📤 Submit
- **Agent Assignment**: GIS Processing Agent
- **Input Documents**: Topographic Data, Utility Maps (from Survey DB/00900)
- **Output Documents**: Survey Report
- **Approval Workflow**: Technical Lead Sign-off → 00900 Doc Control

### Modal Integration
This card operates within the Civil Engineering Workflow Modal System, providing:
- **Topographic Data Management**: Interactive survey data visualization and analysis
- **Agent Integration**: GIS Processing Agent for spatial data analysis
- **Document Control**: 00900 system integration for survey data and reports
- **Approval Workflows**: Technical Lead sign-off for survey data validation
- **Real-time Analysis**: Live survey data processing and quality assessment

## Modal Card Structure

### Card Header (Modal Context)
```
┌─────────────────────────────────────────────────────────────────┐
│ 📍 SITE SURVEY CARD - Phase 1 of 5                             │
│ Status: 🔄 In Progress | Progress: ████████░░░░░░ 40%          │
│ Agent: GIS Processing | Due: [Auto-calculated]                 │
│ Modal Controls: [Filter] [Progress] [Actions] [Close]          │
└─────────────────────────────────────────────────────────────────┘
```

### Main Content Area (Modal Body)

#### Section 1: Agent Status Dashboard
```
┌─ Agent Coordination Status ────────────────────────────────────┐
│                                                               │
│ 🗺️ GIS Processing Agent: [🟢 Active]                           │
│    Task: Topographic Data Analysis & Processing               │
│    Progress: ████████░░░░░░ 80% | ETA: 2 min                  │
│    [📊 View Details] [🔄 Refresh] [⚙️ Configure]              │
│                                                               │
│ 📊 Analysis Results:                                          │
│    • Topographic features extracted: 1,247 points            │
│    • Utility lines mapped: 89 features                        │
│    • Surface model generated: 95% coverage                   │
│    • Quality validation: ±5mm accuracy confirmed             │
└───────────────────────────────────────────────────────────────┘
```

#### Section 2: Interactive Survey Map (Modal Viewport)
```
┌─ Topographic Survey Viewer ────────────────────────────────────┐
│                                                               │
│ [Modal-Optimized Map Canvas - 1000x600px]                    │
│ ┌─────────────────┬─────────────────┬─────────────────┐       │
│ │   2D Plan View  │  3D Surface     │  Profile View    │       │
│ │                 │  Model View     │                 │       │
│ │ [Topo Lines]    │ [3D Terrain]    │ [Elevation]      │       │
│ │ [Contours]      │ [Render]        │ [Profile]        │       │
│ │ Modal Controls: │ Modal Controls: │ Modal Controls: │       │
│ │ [Zoom][Pan]     │ [Orbit][Zoom]    │ [Scale][Pan]    │       │
│ │ [Measure][Grid] │ [Views][Layers]  │ [Measure][Grid] │       │
│ └─────────────────┴─────────────────┴─────────────────┘       │
│                                                               │
│ [Real-time Agent Feed]                                        │
│ ⏰ GIS: "Processing topographic contours..."                  │
│ ⏰ GIS: "Utility mapping complete - 89 features detected"     │
│ ⏰ GIS: "Surface model validation: ±5mm accuracy achieved"    │
│                                                               │
│ [Layer Control Panel]                                         │
│ □ Topographic Contours | □ Utility Lines | □ Property Boundaries │
│ □ Environmental Features | □ Survey Points | □ Grid System    │
└───────────────────────────────────────────────────────────────┘
```

#### Section 3: Survey Data Management
```
┌─ Survey Data & Document Control ──────────────────────────────┐
│                                                               │
│ 📥 Input Documents:                                           │
│    • Topographic Data (from Survey Database)                 │
│    • Utility Maps (from GIS Repository)                      │
│    • Previous Surveys (Reference library)                    │
│                                                               │
│ 📤 Output Documents:                                          │
│    • Survey Report (Auto-saved to 00900)                     │
│    • Topographic Drawings (Generated by GIS Agent)           │
│    • Utility Mapping (GIS-processed)                         │
│                                                               │
│ 🔗 Document References:                                       │
│    [View in 00900] [Download All] [Version History]          │
│                                                               │
│ 📊 Data Quality Metrics:                                      │
│    Horizontal Accuracy: ±5mm ✓ | Vertical Accuracy: ±5mm ✓   │
│    Coverage: 95% ✓ | Age: Current ✓ | Datum: WGS84 ✓         │
└───────────────────────────────────────────────────────────────┘
```

### Modal Footer Actions
```
┌─────────────────────────────────────────────────────────────────┐
│ [👁️ View Details] [👤 Assign Agent] [✅ Complete & Submit] [📥 Download Data] [💾 Save Progress] │
│ [❌ Cancel] [🔄 Reset] [📤 Export Survey] [❓ Help] [✖️ Close Modal] │
└─────────────────────────────────────────────────────────────────┘
```

## Modal Button Functionality

### 👁️ View Button (Primary Action)
**Function**: Open detailed survey data interface with full topographic visualization
**Modal Behavior**:
- Expands to full modal view with interactive map and data panels
- Loads GIS Processing Agent for real-time data analysis
- Retrieves survey documents from 00900 Doc Control
- Displays current progress and data quality metrics
- Enables full topographic analysis and measurement tools

### 👤 Assign Button (Agent Assignment)
**Function**: Assign or reassign GIS Processing Agent to this card
**Modal Behavior**:
- Opens agent selection interface (primarily GIS Processing Agent)
- Shows agent availability and processing capabilities
- Allows configuration of analysis parameters and quality thresholds
- Confirms agent assignment with processing time estimates
- Updates modal header with assigned agent status

### ✅ Complete Button (Workflow Progression)
**Function**: Mark survey data collection as completed and trigger approval workflow
**Modal Behavior**:
- Validates all survey data quality requirements are met
- Submits work to Technical Lead approval workflow
- Updates card status to "Under Review"
- Notifies approver through system notification
- Unlocks dependent cards (Geotechnical, Environmental)

### 📥 Download Button (Data Export)
**Function**: Download survey data, reports, and analysis results
**Modal Behavior**:
- Downloads processed survey data in multiple formats
- Exports topographic drawings and utility maps
- Provides quality assurance reports
- Includes raw data for external analysis
- All exports sourced from 00900 system

### 📤 Submit Button (Approval Submission)
**Function**: Submit completed survey data for formal approval
**Modal Behavior**:
- Packages all survey data and analysis results
- Uploads to 00900 with approval metadata and quality certifications
- Routes to Technical Lead approval queue
- Creates complete audit trail for survey data validation
- Updates workflow progress tracking

## Agent Integration Architecture

### GIS Processing Agent
The GIS Processing Agent provides comprehensive spatial data analysis:

#### Processing Capabilities
- **Topographic Analysis**: Contour generation and surface modeling
- **Utility Mapping**: Infrastructure detection and classification
- **Quality Assessment**: Accuracy validation and error detection
- **Data Integration**: Merging multiple survey sources
- **Format Conversion**: Export to various GIS and CAD formats

#### Real-Time Processing
```
┌─ Agent Processing Feed ───────────────────────────────────────┐
│ ⏰ GIS: "Loading topographic survey data..."                 │
│ ⏰ GIS: "Generating contour lines at 0.5m intervals"         │
│ ⏰ GIS: "Detecting utility features - 89 elements found"     │
│ ⏰ GIS: "Validating coordinate system: WGS84 confirmed"      │
│ ⏰ GIS: "Quality check complete: ±5mm accuracy achieved"     │
└──────────────────────────────────────────────────────────────┘
```

## Document Control Integration

### 00900 System Integration
- **Automatic Retrieval**: Modal loads survey data from 00900 on open
- **Real-time Sync**: Survey data changes reflected immediately in modal
- **Version Control**: All survey data versions tracked with change history
- **Quality Certification**: Survey accuracy certifications stored
- **Audit Trail**: Complete history of all survey data interactions

### Document Workflow
1. **Data Loading**: Modal queries 00900 for existing survey data and maps
2. **Agent Processing**: GIS Agent processes and analyzes survey data
3. **Quality Validation**: Automated accuracy and completeness checks
4. **Report Generation**: GIS Agent creates survey reports and drawings
5. **Approval Submission**: Survey deliverables routed to Technical Lead
6. **Final Storage**: Approved survey data stored with permanent 00900 links

## Approval Workflow Integration

### Technical Lead Approval Process
1. **Notification**: Technical Lead receives modal access link and notification
2. **Document Review**: Full access to survey data, maps, and quality reports
3. **Technical Validation**: Review of survey accuracy, coverage, and methodology
4. **Quality Assessment**: Validation of data quality metrics and standards compliance
5. **Comments & Revisions**: Feedback provided through modal interface
6. **Final Approval**: Digital sign-off with audit trail

### Approval Status Tracking
- **Submitted**: Survey data submitted, awaiting review
- **Under Review**: Technical Lead actively reviewing
- **Approved**: Sign-off complete, workflow progresses to next cards
- **Rejected**: Revisions required, card returns to "In Progress"
- **Re-submitted**: Revised survey data submitted for re-approval

## Survey Data Analysis Tools

### Topographic Analysis
- **Contour Generation**: Automated contour line creation at specified intervals
- **Surface Modeling**: Digital terrain model generation and validation
- **Volume Calculations**: Cut/fill analysis and material balance
- **Slope Analysis**: Gradient calculations and stability assessment

### Utility Mapping
- **Feature Detection**: Automated identification of underground utilities
- **Classification**: Categorization by utility type and ownership
- **Conflict Analysis**: Identification of potential design conflicts
- **Documentation**: Generation of utility mapping reports

### Quality Assurance
- **Accuracy Validation**: Statistical analysis of survey point accuracy
- **Coverage Assessment**: Evaluation of survey area completeness
- **Consistency Checks**: Cross-validation between survey sources
- **Standards Compliance**: Verification against surveying standards

## Performance & Scalability

### Modal Performance Optimization
- **Progressive Loading**: Large survey datasets loaded in tiles
- **WebGL Rendering**: Hardware-accelerated map and 3D visualization
- **Background Processing**: Agent analysis runs without blocking UI
- **Memory Management**: Efficient handling of large geospatial datasets

### Agent Scalability
- **Distributed Processing**: GIS Agent can scale across multiple instances
- **Load Balancing**: Survey processing distributed based on complexity
- **Caching Strategy**: Frequently accessed survey data cached locally
- **Fallback Handling**: Manual data entry available when agent unavailable

## Error Handling & Validation

### Data Quality Validation
- **Accuracy Requirements**: Horizontal and vertical accuracy validation
- **Completeness Checks**: Required survey coverage area verification
- **Consistency Validation**: Cross-check between survey data sources
- **Timeliness Assessment**: Survey data currency and age validation

### Agent Error Handling
- **Processing Timeouts**: Automatic retry with exponential backoff
- **Data Format Issues**: Validation and conversion of incompatible formats
- **Resource Limitations**: Queue management for large dataset processing
- **Network Issues**: Offline capability with sync resumption

## Security & Compliance

### Data Security
- **End-to-End Encryption**: All survey data encrypted during processing and storage
- **Access Control**: Role-based permissions for sensitive survey data
- **Watermarking**: Digital watermarks on exported survey drawings
- **Audit Logging**: Complete record of all survey data access and modifications

### Survey Standards Compliance
- **Accuracy Standards**: Compliance with local surveying accuracy requirements
- **Professional Standards**: Adherence to surveying best practices
- **Regulatory Requirements**: Meeting environmental and safety survey standards
- **Quality Assurance**: Independent validation of survey data quality

## Mobile & Field Integration

### Field Data Collection
- **GNSS Integration**: Real-time GPS/GNSS data collection and validation
- **Mobile Mapping**: Integration with mobile survey devices and drones
- **Field Verification**: On-site survey data validation and correction
- **Offline Capability**: Survey data collection without network connectivity

### Remote Collaboration
- **Real-time Sync**: Live synchronization of survey data across team members
- **Field Office Link**: Seamless connection between field collection and office processing
- **Quality Control**: Remote validation of field survey data
- **Progress Tracking**: Real-time monitoring of survey data collection progress

## Implementation Architecture

### Modal Component Structure
```
CivilEngineeringModal/
├── SiteSurveyCard/
│   ├── CardHeader.jsx          # Status and modal controls
│   ├── AgentDashboard.jsx      # GIS Processing Agent status
│   ├── SurveyMap.jsx           # Interactive topographic viewer
│   ├── DataPanel.jsx           # Survey data management
│   ├── AnalysisTools.jsx       # Measurement and analysis tools
│   └── CardFooter.jsx          # Action buttons
```

### API Integration Points
```javascript
// Agent coordination
POST /api/workflows/{projectId}/cards/{cardId}/agents/assign
GET  /api/workflows/{projectId}/cards/{cardId}/agents/status
POST /api/workflows/{projectId}/cards/{cardId}/agents/process-survey

// Document control
GET  /api/document-control/{projectId}/survey-data
POST /api/document-control/{projectId}/survey-data/upload
PUT  /api/document-control/{projectId}/survey-data/{id}/version

// GIS processing
POST /api/gis/process-topography
POST /api/gis/analyze-utilities
GET  /api/gis/surface-model
POST /api/gis/validate-accuracy

// Approval workflow
POST /api/approvals/{projectId}/cards/{cardId}/submit
GET  /api/approvals/{projectId}/pending
POST /api/approvals/{approvalId}/decide
```

## Testing & Validation

### Modal Functionality Testing
- **Button Actions**: All modal buttons function correctly
- **Agent Integration**: GIS Processing Agent processes survey data properly
- **Map Interaction**: Topographic viewer responds to user interactions
- **Data Export**: Survey data downloads work in multiple formats
- **Document Flow**: 00900 integration complete and reliable

### Performance Testing
- **Load Times**: Modal opens within 2 seconds with survey data
- **Map Rendering**: Smooth 60fps performance with large datasets
- **Agent Response**: Survey processing completes within 5 minutes
- **Data Export**: Large survey datasets export within 10 minutes

### User Acceptance Testing
- **Survey Data Loading**: Various survey formats load correctly
- **Topographic Analysis**: Measurement and analysis tools work accurately
- **Agent Processing**: GIS Agent produces expected results
- **Approval Routing**: Technical Lead approval process works
- **Data Quality**: Survey accuracy meets professional standards

## Success Metrics

### Functional Metrics
- **Modal Load Time**: <2 seconds average
- **Agent Processing Time**: <5 minutes for standard survey datasets
- **Data Accuracy**: >98% accurate topographic data processing
- **Approval Completion**: <24 hours average approval time

### Quality Metrics
- **Survey Accuracy**: ±5mm horizontal, ±5mm vertical accuracy maintained
- **Data Completeness**: >95% coverage of required survey areas
- **Processing Reliability**: >99% successful survey data processing
- **Standards Compliance**: 100% compliance with surveying standards

## Related Documentation

- [00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD](00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD) - Main workflow overview
- [00850_0_UI_CARDS_IMPLEMENTATION_SUMMARY.md](00850_0_UI_CARDS_IMPLEMENTATION_SUMMARY.md) - All cards summary
- [00850_CIVIL_ENGINEERING_MODAL_REDESIGN_SPECIFICATION.md](00850_CIVIL_ENGINEERING_MODAL_REDESIGN_SPECIFICATION.md) - Modal architecture
- [00850_MODAL_IMPLEMENTATION_GUIDE.md](00850_MODAL_IMPLEMENTATION_GUIDE.md) - Technical implementation

## Status
- [x] Modal card specification complete
- [x] Agent integration documented
- [x] Document control integrated
- [x] Approval workflow configured
- [x] Performance optimized
- [x] Accessibility compliant
- [x] Testing validated
- [x] Production ready

## Version History
- v1.0 (2026-03-27): Initial card specification
- v2.0 (2026-03-28): Complete modal workflow integration with GIS Processing Agent, 00900 document control, and Technical Lead approval workflow