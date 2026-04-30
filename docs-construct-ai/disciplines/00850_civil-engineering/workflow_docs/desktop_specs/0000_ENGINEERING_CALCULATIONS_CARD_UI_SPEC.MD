---
title: Engineering Calculations Card Modal Specification
author: Construct AI Memory System Team
date: 2026-03-29
version: 1.0
memory_layer: durable_knowledge
para_section: disciplines/00850_civil-engineering/workflow_docs
gigabrain_tags: disciplines, 00850_civil-engineering, modal-cards, engineering-calculations, analysis-agent, document-control, approval-workflow
openstinger_context: modal-card-specification, agent-coordination, document-management, approval-system
last_updated: 2026-03-29
related_docs:
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_UI_CARDS_IMPLEMENTATION_SUMMARY.md
  - disciplines/00850_civil-engineering/workflow_docs/00850_CIVIL_ENGINEERING_MODAL_REDESIGN_SPECIFICATION.md
---

# 00850_0_ENGINEERING_CALCULATIONS_CARD_UI_SPEC.md - Engineering Calculations Card Modal Specification

## Status
- [x] Modal redesign completed
- [x] Agent integration implemented
- [x] Document control integrated
- [x] Approval workflow configured
- [x] Production ready

## Version History
- v1.0 (2026-03-29): Initial engineering calculations card specification

## Modal Card Overview

### Card Identity
- **Card Type**: Engineering Calculations (Phase 3, Card 1)
- **Modal Button Actions**: 👁️ View • 👤 Assign • ✅ Complete • 📥 Download • 📤 Submit
- **Agent Assignment**: Analysis Agent
- **Input Documents**: Layout Drawings, Load Requirements, Material Properties
- **Output Documents**: Calculation Package
- **Approval Workflow**: Technical Lead → 00900 Doc Control

### Modal Integration
This card operates within the Civil Engineering Workflow Modal System, providing:
- **Engineering Analysis**: Comprehensive structural and hydraulic calculations
- **Agent Integration**: Analysis Agent for automated calculation validation and verification
- **Document Control**: 00900 system integration for calculation packages and analysis reports
- **Approval Workflows**: Technical Lead sign-off before detailed design progression
- **Calculation Engine**: Integration with analysis software and design codes

## Modal Card Structure

### Card Header (Modal Context)
```
┌─────────────────────────────────────────────────────────────────┐
│ 🧮 ENGINEERING CALCULATIONS CARD - Phase 3 of 5                │
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
│    Task: Engineering Calculations & Analysis Validation       │
│    Progress: ████████░░░░░░ 80% | ETA: 6 min                  │
│    [📊 View Details] [🔄 Refresh] [⚙️ Configure]              │
│                                                               │
│ 📋 Analysis Results:                                          │
│    • Structural calculations completed: 15 load cases        │
│    • Hydraulic modeling finished: 8 flow scenarios           │
│    • Code compliance verified: 92% pass rate                 │
│    • Critical load case identified: Seismic Event A          │
└───────────────────────────────────────────────────────────────┘
```

#### Section 2: Calculation Framework (Modal Viewport)
```
┌─ Engineering Analysis & Design Parameters ────────────────────┐
│                                                               │
│ 🏗️ Structure Type & Analysis:                                │
│    Structure: [Bridge Structure] [Retaining Wall] [Culvert]  │
│    Analysis Type: [Structural] [Hydraulic] [Geotechnical]    │
│    Design Code: [SANS 10160] [BS 5400] [AASHTO LRFD]         │
│                                                               │
│ 📊 Load Cases & Combinations:                                 │
│    [x] Dead Load (DL)                                        │
│    [x] Live Load (LL) - Highway Loading                      │
│    [x] Wind Load (WL) - 45 m/s basic wind speed              │
│    [x] Seismic Load (EQ) - Zone 2, PGA 0.15g                 │
│    [ ] Temperature Load (TL) - ±25°C                         │
│    [x] Construction Load (CL) - Mobile crane loading         │
│                                                               │
│ 🔢 Key Design Parameters:                                     │
│    Safety Factor (γ): [1.5] | Load Factor (α): [1.35]        │
│    Material Strength (f'c): [30 MPa] | Steel Grade: [S355]    │
│    Design Life: [100 years] | Exposure Class: [XD3]          │
│                                                               │
│ 📈 Analysis Results Summary:                                  │
│    [Rich Text Editor - Agent Assisted]                        │
│    "All load combinations analyzed. Maximum utilization       │
│    ratio: 0.87 (acceptable <1.0). Critical section at         │
│    pier P3 with seismic loading. Hydraulic capacity verified  │
│    for 1:100 year flood event."                               │
└───────────────────────────────────────────────────────────────┘
```

#### Section 3: Detailed Calculations & Validation
```
┌─ Calculation Details & Code Compliance ───────────────────────┐
│                                                               │
│ 📐 Structural Analysis Results:                               │
│                                                               │
│    Load Case: Ultimate Limit State (ULS) - Seismic           │
│    ┌─────────────┬─────────────┬─────────────┬─────────────┐  │
│    │ Section     │ Bending     │ Shear       │ Utilization │  │
│    │             │ Moment (kNm)│ Force (kN)  │ Ratio       │  │
│    ├─────────────┼─────────────┼─────────────┼─────────────┤  │
│    │ Pier P1     │ 2,450       │ 890         │ 0.78        │  │
│    │ Pier P2     │ 3,120       │ 1,050       │ 0.82        │  │
│    │ Pier P3     │ 4,180       │ 1,420       │ 0.87        │  │
│    │ Abutment A1 │ 1,890       │ 650         │ 0.71        │  │
│    │ Abutment A2 │ 2,050       │ 720         │ 0.74        │  │
│    └─────────────┴─────────────┴─────────────┴─────────────┘  │
│                                                               │
│ 💧 Hydraulic Analysis Results:                                │
│                                                               │
│    Design Flow: 1:100 year flood (850 m³/s)                  │
│    • Water Level: 12.45m AHD (acceptable <12.8m)             │
│    • Velocity: 3.2 m/s (scour protection required)           │
│    • Freeboard: 1.35m (meets 1.0m minimum)                   │
│                                                               │
│ ⚖️ Code Compliance Check:                                     │
│    [x] SANS 10160: Structural design - PASS                  │
│    [x] TMH 7: Highway bridge loading - PASS                  │
│    [x] SANS 10400: Hydraulic structures - PASS               │
│    [x] Seismic design requirements - PASS                    │
│                                                               │
│ 📋 Critical Design Issues:                                    │
│    [Rich Text Editor]                                         │
│    "Seismic analysis shows overstressed condition at Pier P3.│
│    Recommend foundation strengthening or pier enlargement.    │
│    Hydraulic analysis confirms adequate flood capacity with   │
│    350mm freeboard margin."                                   │
└───────────────────────────────────────────────────────────────┘
```

### Modal Footer Actions
```
┌─────────────────────────────────────────────────────────────────┐
│ [👁️ View Details] [👤 Assign Agent] [✅ Complete & Submit] [📥 Download Templates] [💾 Save Progress] │
│ [❌ Cancel] [🔄 Reset] [📤 Export Calculations] [❓ Help] [✖️ Close Modal] │
└─────────────────────────────────────────────────────────────────┘
```

## Modal Button Functionality

### 👁️ View Button (Primary Action)
**Function**: Open detailed engineering calculations interface with full analysis capabilities
**Modal Behavior**:
- Expands to full modal view with all calculation sections visible
- Loads existing layout drawings and design parameters from workflow state
- Initializes Analysis Agent for automated calculation validation
- Displays structural and hydraulic analysis results
- Enables full editing of calculation parameters and load cases

### 👤 Assign Button (Agent Assignment)
**Function**: Assign or reassign Analysis Agent to this card
**Modal Behavior**:
- Opens agent selection interface (Analysis Agent optimized for engineering calculations)
- Shows agent availability and current processing load
- Allows configuration of analysis software and design codes
- Confirms agent assignment with processing time estimates
- Updates modal header with assigned agent status

### ✅ Complete Button (Workflow Progression)
**Function**: Mark engineering calculations as completed and trigger approval workflow
**Modal Behavior**:
- Validates all calculations are complete and code-compliant
- Submits work to Technical Lead approval workflow
- Updates card status to "Under Review"
- Notifies approver through system notification
- Unlocks dependent cards (Preliminary Drawings)

### 📥 Download Button (Template Access)
**Function**: Download engineering calculation templates and reference documents
**Modal Behavior**:
- Downloads standard calculation templates for different structure types
- Provides load combination and analysis spreadsheets
- Includes design code compliance checklists
- All templates sourced from 00900 template library
- Includes engineering calculation guidelines

### 📤 Submit Button (Approval Submission)
**Function**: Submit completed engineering calculations for formal approval
**Modal Behavior**:
- Packages all calculation results and analysis reports
- Uploads to 00900 with approval metadata
- Routes to Technical Lead approval queue
- Creates complete audit trail for submission
- Updates workflow progress tracking

## Agent Integration Architecture

### Analysis Agent
The Analysis Agent provides intelligent assistance for engineering calculations:

#### Analysis Capabilities
- **Structural Analysis**: Automated finite element analysis and design verification
- **Hydraulic Modeling**: Computational fluid dynamics and flood analysis
- **Code Compliance**: Automated checking against design standards and codes
- **Load Case Generation**: Systematic generation of load combinations
- **Results Validation**: Verification of calculation accuracy and reasonableness

#### Real-Time Assistance
```
┌─ Agent Analysis Feed ──────────────────────────────────────────┐
│ ⏰ 14:32 Agent: "Running structural analysis for 15 load cases" │
│ ⏰ 14:33 Agent: "Hydraulic modeling completed - Q100 flow verified" │
│ ⏰ 14:35 Agent: "Code compliance check: 92% pass rate achieved" │
│ ⏰ 14:36 Agent: "Critical load case identified: Seismic Event A" │
│ ⏰ 14:37 Agent: "Engineering calculations validation: 95% complete" │
└─────────────────────────────────────────────────────────────────┘
```

## Document Control Integration

### 00900 System Integration
- **Automatic Retrieval**: Modal loads layout drawings and design parameters on open
- **Real-time Sync**: Document changes reflected immediately in modal
- **Version Control**: All calculations tracked with change history
- **Approval Routing**: Documents automatically routed through approval process
- **Audit Trail**: Complete history of all calculation document interactions

### Document Workflow
1. **Data Loading**: Modal queries 00900 for design inputs and parameters
2. **Agent Processing**: Analysis Agent performs engineering calculations
3. **Results Validation**: User reviews and validates calculation outputs
4. **Documentation**: Agent-assisted generation of calculation reports
5. **Approval Submission**: Documents routed to Technical Lead for sign-off
6. **Final Storage**: Approved calculations stored with permanent 00900 links

## Approval Workflow Integration

### Technical Lead Approval Process
1. **Notification**: Technical Lead receives modal access link and notification
2. **Document Review**: Full access to calculations, analysis results, and code compliance
3. **Technical Validation**: Review of calculation methodology, load cases, and design assumptions
4. **Comments & Revisions**: Feedback provided through modal interface
5. **Final Approval**: Digital sign-off with audit trail

### Approval Status Tracking
- **Submitted**: Calculations submitted, awaiting review
- **Under Review**: Technical Lead actively reviewing
- **Approved**: Sign-off complete, workflow progresses to next card
- **Rejected**: Revisions required, card returns to "In Progress"
- **Re-submitted**: Revised calculations submitted for re-approval

## Template System Integration

### Engineering Calculation Templates
- **Structural Analysis Templates**: Pre-configured finite element models
- **Hydraulic Calculation Templates**: Flood analysis and scour calculations
- **Load Combination Templates**: Standardized load case generation
- **Code Compliance Templates**: Design standard verification checklists

### Template Features
- **Auto-Population**: Templates pre-filled with project design parameters
- **Calculation Engines**: Built-in engineering formulas and analysis algorithms
- **Code Updates**: Automatic inclusion of latest design standards
- **Export Options**: Multiple formats (PDF, DOCX, XLSX)

## Performance & Scalability

### Modal Performance Optimization
- **Lazy Loading**: Agent interface loads on demand
- **Progressive Rendering**: Calculation sections load as needed
- **Background Processing**: Agent analysis runs without blocking UI
- **Memory Management**: Efficient handling of large calculation datasets

### Agent Scalability
- **Load Balancing**: Analysis Agent distributed across resources
- **Priority Queuing**: Critical engineering calculations prioritized
- **Resource Monitoring**: Automatic scaling based on demand
- **Fallback Handling**: Manual entry available when agent unavailable

## Error Handling & Validation

### Form Validation
- **Required Fields**: Visual indicators for missing calculation parameters
- **Business Rules**: Design code and load combination validation
- **Calculation Logic**: Engineering formula and analysis validation
- **Data Ranges**: Realistic engineering parameter range checking

### Agent Error Handling
- **Processing Timeouts**: Automatic retry with exponential backoff
- **Data Quality Issues**: Validation prompts for unclear design data
- **Integration Failures**: Graceful fallback to manual entry
- **Recovery Mechanisms**: State preservation during error recovery

## Security & Compliance

### Data Security
- **End-to-End Encryption**: All calculation data encrypted during processing
- **Access Control**: Role-based permissions for engineering calculation data access
- **Audit Logging**: Complete record of all user and agent actions
- **Compliance Monitoring**: Design code compliance validation

### Engineering Data Protection
- **Professional Standards**: Engineering information handled according to professional standards
- **Data Retention**: Automatic cleanup of temporary calculation data
- **Access Logging**: Complete audit trail of engineering data access
- **Secure Storage**: Encrypted storage of all engineering documentation

## Mobile & Accessibility

### Responsive Modal Design
- **Touch Optimization**: Large touch targets for mobile calculation input
- **Gesture Support**: Swipe navigation and pinch-to-zoom for calculation results
- **Progressive Disclosure**: Simplified views for smaller screens
- **Offline Capability**: Core engineering calculations available offline

### Accessibility Compliance (WCAG 2.1 AA)
- **Keyboard Navigation**: Full keyboard accessibility for calculation input
- **Screen Reader Support**: ARIA labels and live regions for calculation fields
- **High Contrast**: Support for high contrast calculation display
- **Motion Preferences**: Respects reduced motion settings

## Implementation Architecture

### Modal Component Structure
```
CivilEngineeringModal/
├── EngineeringCalculationsCard/
│   ├── CardHeader.jsx              # Status and modal controls
│   ├── AgentDashboard.jsx          # Analysis Agent status
│   ├── CalculationForm.jsx         # Main calculation parameters
│   ├── ResultsPanel.jsx            # Analysis results display
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
GET  /api/document-control/{projectId}/calculations
POST /api/document-control/{projectId}/calculations/upload
PUT  /api/document-control/{projectId}/calculations/{docId}/version

// Engineering data
GET  /api/projects/{projectId}/calculations
POST /api/projects/{projectId}/calculations
PUT  /api/projects/{projectId}/calculations

// Approval workflow
POST /api/approvals/{projectId}/cards/{cardId}/submit
GET  /api/approvals/{projectId}/pending
POST /api/approvals/{approvalId}/decide
```

## Testing & Validation

### Modal Functionality Testing
- **Button Actions**: All modal buttons function correctly
- **Agent Integration**: Analysis Agent processes engineering data properly
- **Form Validation**: All required calculation parameters validated appropriately
- **Document Flow**: 00900 integration complete and reliable
- **Approval Process**: Technical Lead approval workflow functions

### Performance Testing
- **Load Times**: Modal opens within 2 seconds
- **Agent Response**: Engineering calculations complete within 10 minutes
- **Form Saving**: Auto-save works without data loss
- **Document Upload**: Large calculation datasets upload within 15 minutes

### User Acceptance Testing
- **Engineering Calculations**: Complete structural and hydraulic analysis workflow
- **Agent Assistance**: Analysis Agent provides accurate calculation validation
- **Document Management**: All calculation documents properly managed
- **Approval Routing**: Technical Lead approval process works
- **Template Usage**: Template system enhances calculation productivity

## Success Metrics

### Functional Metrics
- **Modal Load Time**: <2 seconds average
- **Agent Processing Time**: <10 minutes for standard engineering calculations
- **Form Completion Rate**: >95% successful calculation completion
- **Approval Completion**: <24 hours average approval time

### Quality Metrics
- **Calculation Accuracy**: >98% accurate engineering analysis results
- **Code Compliance**: >95% automatic compliance verification
- **Validation Success**: >95% calculations pass technical review
- **Design Confidence**: >90% engineer confidence in calculation results

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
- v1.0 (2026-03-29): Initial engineering calculations card specification with Analysis Agent, 00900 document control, and Technical Lead approval workflow