---
title: Geotechnical Card Modal Specification
author: Construct AI Memory System Team
date: 2026-03-29
version: 1.0
memory_layer: durable_knowledge
para_section: disciplines/00850_civil-engineering/workflow_docs
gigabrain_tags: disciplines, 00850_civil-engineering, modal-cards, geotechnical, analysis-agent, document-control, approval-workflow
openstinger_context: modal-card-specification, agent-coordination, document-management, approval-system
last_updated: 2026-03-29
related_docs:
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_UI_CARDS_IMPLEMENTATION_SUMMARY.md
  - disciplines/00850_civil-engineering/workflow_docs/00850_CIVIL_ENGINEERING_MODAL_REDESIGN_SPECIFICATION.md
---

# 00850_0_GEOTECHNICAL_CARD_UI_SPEC.md - Geotechnical Card Modal Specification

## Status
- [x] Modal redesign completed
- [x] Agent integration implemented
- [x] Document control integrated
- [x] Approval workflow configured
- [x] Production ready

## Version History
- v1.0 (2026-03-29): Initial geotechnical card specification

## Modal Card Overview

### Card Identity
- **Card Type**: Geotechnical (Phase 1, Card 3)
- **Modal Button Actions**: 👁️ View • 👤 Assign • ✅ Complete • 📥 Download • 📤 Submit
- **Agent Assignment**: Analysis Agent
- **Input Documents**: Soil Reports, Borehole Data (from 00900 Doc Control or Geo DB)
- **Output Documents**: Foundation Recommendations
- **Approval Workflow**: Geotech Engineer Sign-off → 00900 Doc Control

### Modal Integration
This card operates within the Civil Engineering Workflow Modal System, providing:
- **Foundation Analysis**: Comprehensive geotechnical assessment for civil structures
- **Agent Integration**: Analysis Agent for automated soil parameter extraction and foundation recommendations
- **Document Control**: 00900 system integration for geotechnical reports and borehole data
- **Approval Workflows**: Geotech Engineer sign-off before foundation design progression
- **Database Integration**: Direct links to geotechnical investigation databases

## Modal Card Structure

### Card Header (Modal Context)
```
┌─────────────────────────────────────────────────────────────────┐
│ 🌍 GEOTECHNICAL CARD - Phase 1 of 5                            │
│ Status: 🔄 In Progress | Progress: ████████░░░░░░ 40%          │
│ Agent: Analysis | Due: [Auto-calculated]                       │
│ Modal Controls: [Filter] [Progress] [Actions] [Close]          │
└─────────────────────────────────────────────────────────────────┘
```

### Main Content Area (Modal Body)

#### Section 1: Agent Status Dashboard
```
┌─ Analysis Agent Status ────────────────────────────────────────┐
│                                                               │
│ 🧮 Analysis Agent: [🟢 Active]                                 │
│    Task: Soil Analysis & Foundation Recommendations           │
│    Progress: ████████░░░░░░ 80% | ETA: 2 min                  │
│    [📊 View Details] [🔄 Refresh] [⚙️ Configure]              │
│                                                               │
│ 📋 Analysis Results:                                          │
│    • Soil profiles analyzed: 12 boreholes                    │
│    • Foundation types recommended: 3 options                 │
│    • Bearing capacity calculated: 150-250 kPa                │
│    • Settlement analysis: <25mm acceptable                   │
└───────────────────────────────────────────────────────────────┘
```

#### Section 2: Geotechnical Data Form (Modal Viewport)
```
┌─ Site Investigation & Soil Parameters ─────────────────────────┐
│                                                               │
│ 📍 Investigation Location:                                    │
│    Site: [Highway Expansion Project]                          │
│    Coordinates: [-26.2041, 28.0473]                          │
│    Investigation Type: [Boreholes] [Trial Pits] [CPT]        │
│                                                               │
│ 🏗️ Structure Type & Loading:                                 │
│    Structure: [Bridge Abutment] [Retaining Wall] [Building]  │
│    Design Load: [500 kN/m²] | Safety Factor: [2.5]           │
│    Settlement Criteria: [<25mm] [Serviceability Limit]       │
│                                                               │
│ 🌱 Soil Profile Summary:                                      │
│    [Rich Text Editor - Agent Assisted]                        │
│    "Upper 3m: Sandy SILT (SP) with SPT N=15-25               │
│     Middle 5m: Clayey SAND (SC) with SPT N=20-35              │
│     Lower: Weathered ROCK with SPT N>50"                      │
│                                                               │
│ 📊 Key Parameters:                                            │
│    • Unit Weight (γ): 18 kN/m³                                │
│    • Cohesion (c'): 15 kPa                                    │
│    • Friction Angle (φ'): 28°                                 │
│    • Bearing Capacity: 180 kPa (allowable)                   │
└───────────────────────────────────────────────────────────────┘
```

#### Section 3: Foundation Recommendations
```
┌─ Foundation Design Recommendations ────────────────────────────┐
│                                                               │
│ 🏗️ Recommended Foundation Types:                              │
│    [ ] Shallow Foundation (Spread Footing)                    │
│    [x] Deep Foundation (Piles/Bored Piles)                    │
│    [ ] Raft Foundation                                        │
│    [ ] Other: [Specify]                                       │
│                                                               │
│ 📐 Design Parameters:                                         │
│    Pile Type: [Bored Piles] | Diameter: [600mm]              │
│    Design Load per Pile: [800 kN]                            │
│    Pile Length: [8-12m] | Set Spacing: [3x diameter]          │
│                                                               │
│ ⚠️ Geotechnical Considerations:                               │
│    • Groundwater at 2.5m depth - corrosion protection        │
│    • Seismic zone consideration - ductility requirements     │
│    • Expansive soil potential - swelling analysis required   │
│                                                               │
│ 📋 Additional Recommendations:                                │
│    [Rich Text Editor]                                         │
│    "Conduct pile load testing for 2% of piles.               │
│     Monitor groundwater levels during construction.          │
│     Consider soil improvement if required."                  │
└───────────────────────────────────────────────────────────────┘
```

### Modal Footer Actions
```
┌─────────────────────────────────────────────────────────────────┐
│ [👁️ View Details] [👤 Assign Agent] [✅ Complete & Submit] [📥 Download Templates] [💾 Save Progress] │
│ [❌ Cancel] [🔄 Reset] [📤 Export Report] [❓ Help] [✖️ Close Modal] │
└─────────────────────────────────────────────────────────────────┘
```

## Modal Button Functionality

### 👁️ View Button (Primary Action)
**Function**: Open detailed geotechnical assessment interface with full analysis capabilities
**Modal Behavior**:
- Expands to full modal view with all geotechnical sections visible
- Loads existing soil investigation data from workflow state
- Initializes Analysis Agent for automated parameter extraction
- Displays foundation recommendation algorithms
- Enables full editing of geotechnical parameters and recommendations

### 👤 Assign Button (Agent Assignment)
**Function**: Assign or reassign Analysis Agent to this card
**Modal Behavior**:
- Opens agent selection interface (Analysis Agent optimized for geotechnical data)
- Shows agent availability and current processing load
- Allows configuration of analysis parameters (soil classification standards, safety factors)
- Confirms agent assignment with processing time estimates
- Updates modal header with assigned agent status

### ✅ Complete Button (Workflow Progression)
**Function**: Mark geotechnical assessment as completed and trigger approval workflow
**Modal Behavior**:
- Validates all required geotechnical parameters and foundation recommendations
- Submits work to Geotech Engineer approval workflow
- Updates card status to "Under Review"
- Notifies approver through system notification
- Unlocks dependent cards (Environmental, Design Options)

### 📥 Download Button (Template Access)
**Function**: Download geotechnical assessment templates and reference documents
**Modal Behavior**:
- Downloads standard geotechnical assessment template
- Provides foundation recommendation matrix
- Includes soil parameter calculation spreadsheets
- All templates sourced from 00900 template library
- Includes usage instructions and geotechnical standards

### 📤 Submit Button (Approval Submission)
**Function**: Submit completed geotechnical assessment for formal approval
**Modal Behavior**:
- Packages all geotechnical data and recommendations
- Uploads to 00900 with approval metadata
- Routes to Geotech Engineer approval queue
- Creates complete audit trail for submission
- Updates workflow progress tracking

## Agent Integration Architecture

### Analysis Agent
The Analysis Agent provides intelligent assistance for geotechnical assessment:

#### Analysis Capabilities
- **Soil Parameter Extraction**: Automated analysis of borehole logs and lab test results
- **Foundation Type Selection**: Intelligent recommendation of appropriate foundation systems
- **Bearing Capacity Calculations**: Automated calculations using established geotechnical formulas
- **Settlement Analysis**: Prediction of foundation settlements under design loads
- **Risk Assessment**: Identification of geotechnical risks and mitigation requirements

#### Real-Time Assistance
```
┌─ Agent Analysis Feed ──────────────────────────────────────────┐
│ ⏰ 14:32 Agent: "Analyzed 12 borehole logs - SP/SC soil profile" │
│ ⏰ 14:33 Agent: "Calculated bearing capacity: 180 kPa allowable" │
│ ⏰ 14:35 Agent: "Recommended bored piles for foundation system" │
│ ⏰ 14:36 Agent: "Settlement analysis: <20mm predicted"          │
│ ⏰ 14:37 Agent: "Geotechnical assessment validation: 95% complete" │
└─────────────────────────────────────────────────────────────────┘
```

## Document Control Integration

### 00900 System Integration
- **Automatic Retrieval**: Modal loads geotechnical reports and borehole data on open
- **Real-time Sync**: Document changes reflected immediately in modal
- **Version Control**: All geotechnical assessments tracked with change history
- **Approval Routing**: Documents automatically routed through approval process
- **Audit Trail**: Complete history of all geotechnical document interactions

### Document Workflow
1. **Data Loading**: Modal queries 00900 for geotechnical investigation data
2. **Agent Processing**: Analysis Agent processes and extracts soil parameters
3. **Assessment Creation**: User refines foundation recommendations and design parameters
4. **Validation**: Agent-assisted validation of geotechnical calculations and recommendations
5. **Approval Submission**: Documents routed to Geotech Engineer for sign-off
6. **Final Storage**: Approved geotechnical assessment stored with permanent 00900 links

## Approval Workflow Integration

### Geotech Engineer Approval Process
1. **Notification**: Geotech Engineer receives modal access link and notification
2. **Document Review**: Full access to geotechnical data, calculations, and recommendations
3. **Technical Validation**: Review of soil parameters, foundation recommendations, and design assumptions
4. **Comments & Revisions**: Feedback provided through modal interface
5. **Final Approval**: Digital sign-off with audit trail

### Approval Status Tracking
- **Submitted**: Geotechnical assessment submitted, awaiting review
- **Under Review**: Geotech Engineer actively reviewing
- **Approved**: Sign-off complete, workflow progresses to next phase
- **Rejected**: Revisions required, card returns to "In Progress"
- **Re-submitted**: Revised assessment submitted for re-approval

## Template System Integration

### Geotechnical Templates
- **Standard Geotechnical Assessment**: Pre-configured sections and calculation templates
- **Foundation Recommendation Matrix**: Decision tree for foundation type selection
- **Soil Parameter Calculator**: Spreadsheet templates for bearing capacity and settlement calculations
- **Geotechnical Report Template**: Comprehensive reporting format

### Template Features
- **Auto-Population**: Templates pre-filled with site investigation data
- **Calculation Engines**: Built-in geotechnical calculation formulas
- **Standards Compliance**: Automatic checking against local geotechnical codes
- **Export Options**: Multiple formats (PDF, DOCX, XLSX)

## Performance & Scalability

### Modal Performance Optimization
- **Lazy Loading**: Agent interface loads on demand
- **Progressive Rendering**: Geotechnical sections load as needed
- **Background Processing**: Agent analysis runs without blocking UI
- **Memory Management**: Efficient handling of large borehole datasets

### Agent Scalability
- **Load Balancing**: Analysis Agent distributed across resources
- **Priority Queuing**: Critical foundation assessments prioritized
- **Resource Monitoring**: Automatic scaling based on demand
- **Fallback Handling**: Manual entry available when agent unavailable

## Error Handling & Validation

### Form Validation
- **Required Fields**: Visual indicators for missing geotechnical parameters
- **Business Rules**: Soil classification and foundation type consistency validation
- **Calculation Logic**: Bearing capacity and settlement calculation validation
- **Data Ranges**: Realistic parameter range checking for geotechnical properties

### Agent Error Handling
- **Processing Timeouts**: Automatic retry with exponential backoff
- **Data Quality Issues**: Validation prompts for unclear borehole data
- **Integration Failures**: Graceful fallback to manual entry
- **Recovery Mechanisms**: State preservation during error recovery

## Security & Compliance

### Data Security
- **End-to-End Encryption**: All geotechnical data encrypted during processing
- **Access Control**: Role-based permissions for geotechnical data access
- **Audit Logging**: Complete record of all user and agent actions
- **Compliance Monitoring**: Regulatory compliance validation for geotechnical assessments

### Geotechnical Data Protection
- **Professional Standards**: Geotechnical information handled according to engineering standards
- **Data Retention**: Automatic cleanup of temporary calculation data
- **Access Logging**: Complete audit trail of geotechnical data access
- **Secure Storage**: Encrypted storage of all geotechnical documentation

## Mobile & Accessibility

### Responsive Modal Design
- **Touch Optimization**: Large touch targets for mobile geotechnical data entry
- **Gesture Support**: Swipe navigation and pinch-to-zoom for borehole logs
- **Progressive Disclosure**: Simplified views for smaller screens
- **Offline Capability**: Core geotechnical assessment available offline

### Accessibility Compliance (WCAG 2.1 AA)
- **Keyboard Navigation**: Full keyboard accessibility for parameter input
- **Screen Reader Support**: ARIA labels and live regions for calculation fields
- **High Contrast**: Support for high contrast calculation display
- **Motion Preferences**: Respects reduced motion settings

## Implementation Architecture

### Modal Component Structure
```
CivilEngineeringModal/
├── GeotechnicalCard/
│   ├── CardHeader.jsx              # Status and modal controls
│   ├── AgentDashboard.jsx          # Analysis Agent status
│   ├── GeotechnicalForm.jsx        # Main geotechnical data form
│   ├── FoundationPanel.jsx         # Foundation recommendations
│   ├── ApprovalQueue.jsx           # Sign-off workflow display
│   └── CardFooter.jsx              # Action buttons
```

### API Integration Points
```javascript
// Agent coordination
POST /api/workflows/{projectId}/cards/{cardId}/agents/assign
GET  /api/workflows/{projectId}/cards/{cardId}/agents/status
POST /api/workflows/{projectId}/cards/{cardId}/agents/analyze

// Document control
GET  /api/document-control/{projectId}/geotechnical
POST /api/document-control/{projectId}/geotechnical/upload
PUT  /api/document-control/{projectId}/geotechnical/{docId}/version

// Geotechnical data
GET  /api/projects/{projectId}/geotechnical
POST /api/projects/{projectId}/geotechnical
PUT  /api/projects/{projectId}/geotechnical

// Approval workflow
POST /api/approvals/{projectId}/cards/{cardId}/submit
GET  /api/approvals/{projectId}/pending
POST /api/approvals/{approvalId}/decide
```

## Testing & Validation

### Modal Functionality Testing
- **Button Actions**: All modal buttons function correctly
- **Agent Integration**: Analysis Agent processes geotechnical data properly
- **Form Validation**: All required parameters validated appropriately
- **Document Flow**: 00900 integration complete and reliable
- **Approval Process**: Geotech Engineer approval workflow functions

### Performance Testing
- **Load Times**: Modal opens within 2 seconds
- **Agent Response**: Geotechnical analysis completes within 5 minutes
- **Form Saving**: Auto-save works without data loss
- **Document Upload**: Large borehole datasets upload within 10 minutes

### User Acceptance Testing
- **Geotechnical Assessment**: Complete foundation analysis workflow
- **Agent Assistance**: Analysis Agent provides accurate recommendations
- **Document Management**: All geotechnical documents properly managed
- **Approval Routing**: Geotech Engineer approval process works
- **Template Usage**: Template system enhances geotechnical productivity

## Success Metrics

### Functional Metrics
- **Modal Load Time**: <2 seconds average
- **Agent Processing Time**: <5 minutes for standard geotechnical assessments
- **Form Completion Rate**: >95% successful foundation recommendations
- **Approval Completion**: <24 hours average approval time

### Quality Metrics
- **Analysis Accuracy**: >95% accurate soil parameter extraction by agent
- **Foundation Recommendations**: >90% alignment with geotechnical best practices
- **Validation Success**: >95% assessments pass geotechnical review
- **Compliance Rate**: 100% local code compliance verification

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
- v1.0 (2026-03-29): Initial geotechnical card specification with Analysis Agent, 00900 document control, and Geotech Engineer approval workflow