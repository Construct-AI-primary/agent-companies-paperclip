---
title: Preliminary Drawings Card Modal Specification
author: Construct AI Memory System Team
date: 2026-03-29
version: 1.0
memory_layer: durable_knowledge
para_section: disciplines/00850_civil-engineering/workflow_docs
gigabrain_tags: disciplines, 00850_civil-engineering, modal-cards, preliminary-drawings, cad-agent, document-control, approval-workflow
openstinger_context: modal-card-specification, agent-coordination, document-management, approval-system
last_updated: 2026-03-29
related_docs:
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_UI_CARDS_IMPLEMENTATION_SUMMARY.md
  - disciplines/00850_civil-engineering/workflow_docs/00850_CIVIL_ENGINEERING_MODAL_REDESIGN_SPECIFICATION.md
---

# 00850_0_PRELIMINARY_DRAWINGS_CARD_UI_SPEC.md - Preliminary Drawings Card Modal Specification

## Status
- [x] Modal redesign completed
- [x] Agent integration implemented
- [x] Document control integrated
- [x] Approval workflow configured
- [x] Production ready

## Version History
- v1.0 (2026-03-29): Initial preliminary drawings card specification

## Modal Card Overview

### Card Identity
- **Card Type**: Preliminary Drawings (Phase 3, Card 2)
- **Modal Button Actions**: 👁️ View • 👤 Assign • ✅ Complete • 📥 Download • 📤 Submit
- **Agent Assignment**: CAD Agent
- **Input Documents**: Calculation Results, Standards & Codes, Coordination Req
- **Output Documents**: Drawing Set
- **Approval Workflow**: Drawing Office → 00900 Doc Control

### Modal Integration
This card operates within the Civil Engineering Workflow Modal System, providing:
- **Drawing Production**: Automated generation of preliminary construction drawings
- **Agent Integration**: CAD Agent for intelligent drawing creation and coordination
- **Document Control**: 00900 system integration for drawing management and version control
- **Approval Workflows**: Drawing Office sign-off before detailed design progression
- **CAD Integration**: Direct links to AutoCAD Civil 3D and other CAD platforms

## Modal Card Structure

### Card Header (Modal Context)
```
┌─────────────────────────────────────────────────────────────────┐
│ 📏 PRELIMINARY DRAWINGS CARD - Phase 3 of 5                    │
│ Status: 🔄 In Progress | Progress: ████████░░░░░░ 40%          │
│ Agent: CAD | Due: [Auto-calculated]                           │
│ Modal Controls: [Filter] [Progress] [Actions] [Close]          │
└─────────────────────────────────────────────────────────────────┘
```

### Main Content Area (Modal Body)

#### Section 1: Agent Status Dashboard
```
┌─ CAD Agent Status ─────────────────────────────────────────────┐
│                                                               │
│ 🏗️ CAD Agent: [🟢 Active]                                     │
│    Task: Preliminary Drawing Generation & Coordination        │
│    Progress: ████████░░░░░░ 80% | ETA: 8 min                  │
│    [📊 View Details] [🔄 Refresh] [⚙️ Configure]              │
│                                                               │
│ 📋 Drawing Generation Results:                                │
│    • Preliminary drawings created: 12 sheets                 │
│    • Clash detection completed: 3 conflicts resolved         │
│    • Standards compliance verified: 95% pass rate            │
│    • BIM coordination completed: All disciplines aligned     │
└───────────────────────────────────────────────────────────────┘
```

#### Section 2: Drawing Framework (Modal Viewport)
```
┌─ Drawing Set Configuration & Standards ────────────────────────┐
│                                                               │
│ 📐 Drawing Type & Scope:                                      │
│    Structure Type: [Bridge] [Retaining Wall] [Road] [Services]│
│    Drawing Scale: [1:100] [1:200] [1:500] [1:1000]           │
│    Standard: [SANS 10400] [BS 1192] [ISO 5455]               │
│                                                               │
│ 📋 Required Drawing Sheets:                                   │
│    [x] General Arrangement (GA) Drawings                     │
│    [x] Foundation Layout Plans                                │
│    [x] Structural Details                                     │
│    [x] Reinforcement Drawings                                 │
│    [x] Section & Elevation Views                              │
│    [ ] Construction Details                                   │
│                                                               │
│ 🎨 Drawing Standards & Symbols:                               │
│    Line Weights: [0.25mm - 2.0mm] | Text Height: [2.5mm]     │
│    Hatch Patterns: [Standard Civil] | Dimensions: [Aligned]  │
│    Title Blocks: [Company Standard] | Border: [A1 Portrait]   │
│                                                               │
│ 📊 Drawing Progress Summary:                                   │
│    [Rich Text Editor - Agent Assisted]                        │
│    "Preliminary drawing set generated. All major elements    │
│    shown with dimensions and annotations. Coordination with   │
│    architectural and structural drawings completed."         │
└───────────────────────────────────────────────────────────────┘
```

#### Section 3: Drawing Review & Coordination
```
┌─ Drawing Review & BIM Coordination ───────────────────────────┐
│                                                               │
│ 🔍 Drawing Quality Checks:                                    │
│                                                               │
│    Quality Metric: Preliminary Design Completeness           │
│    ┌─────────────┬─────────────┬─────────────┬─────────────┐  │
│    │ Sheet       │ Dimensions  │ Annotations │ Completeness│  │
│    │             │ Complete    │ Complete    │ Rating      │  │
│    ├─────────────┼─────────────┼─────────────┼─────────────┤  │
│    │ GA-001      │ 100%        │ 95%         │ Excellent   │  │
│    │ FOUND-001   │ 98%         │ 92%         │ Good        │  │
│    │ STRUCT-001  │ 95%         │ 88%         │ Good        │  │
│    │ REINF-001   │ 90%         │ 85%         │ Satisfactory│  │
│    │ SECT-001    │ 97%         │ 90%         │ Good        │  │
│    └─────────────┴─────────────┴─────────────┴─────────────┘  │
│                                                               │
│ 🤝 BIM Coordination Status:                                   │
│                                                               │
│    Discipline Coordination:                                   │
│    • Architectural: [Coordinated] - No clashes detected      │
│    • Structural: [Coordinated] - 2 minor clashes resolved    │
│    • MEP Services: [Pending] - Coordination scheduled        │
│    • Geotechnical: [Coordinated] - Foundation alignment OK   │
│                                                               │
│ ⚠️ Drawing Review Comments:                                   │
│    [Rich Text Editor]                                         │
│    "All preliminary drawings generated and coordinated.      │
│    Minor annotation improvements needed on reinforcement     │
│    drawings. BIM model exported for clash detection."        │
└───────────────────────────────────────────────────────────────┘
```

### Modal Footer Actions
```
┌─────────────────────────────────────────────────────────────────┐
│ [👁️ View Details] [👤 Assign Agent] [✅ Complete & Submit] [📥 Download Templates] [💾 Save Progress] │
│ [❌ Cancel] [🔄 Reset] [📤 Export Drawings] [❓ Help] [✖️ Close Modal] │
└─────────────────────────────────────────────────────────────────┘
```

## Modal Button Functionality

### 👁️ View Button (Primary Action)
**Function**: Open detailed preliminary drawings interface with full CAD capabilities
**Modal Behavior**:
- Expands to full modal view with all drawing sections visible
- Loads existing calculation results and design parameters from workflow state
- Initializes CAD Agent for automated drawing generation
- Displays drawing sheets with zoom and pan controls
- Enables full editing of drawing elements and annotations

### 👤 Assign Button (Agent Assignment)
**Function**: Assign or reassign CAD Agent to this card
**Modal Behavior**:
- Opens agent selection interface (CAD Agent optimized for civil drawings)
- Shows agent availability and current processing load
- Allows configuration of CAD standards and drawing templates
- Confirms agent assignment with processing time estimates
- Updates modal header with assigned agent status

### ✅ Complete Button (Workflow Progression)
**Function**: Mark preliminary drawings as completed and trigger approval workflow
**Modal Behavior**:
- Validates all required drawing sheets are complete and coordinated
- Submits work to Drawing Office approval workflow
- Updates card status to "Under Review"
- Notifies approver through system notification
- Unlocks dependent cards (Construction Drawings)

### 📥 Download Button (Template Access)
**Function**: Download drawing templates and CAD standards
**Modal Behavior**:
- Downloads standard drawing templates for different structure types
- Provides CAD standard files and symbol libraries
- Includes drawing checklist and quality assurance templates
- All templates sourced from 00900 template library
- Includes CAD drawing guidelines and standards

### 📤 Submit Button (Approval Submission)
**Function**: Submit completed preliminary drawings for formal approval
**Modal Behavior**:
- Packages all drawing files and coordination reports
- Uploads to 00900 with approval metadata and version control
- Routes to Drawing Office approval queue
- Creates complete audit trail for submission
- Updates workflow progress tracking

## Agent Integration Architecture

### CAD Agent
The CAD Agent provides intelligent assistance for drawing production:

#### Analysis Capabilities
- **Automated Drawing Generation**: Intelligent creation of drawings from design data
- **Standards Compliance**: Automatic application of drawing standards and conventions
- **BIM Coordination**: Clash detection and coordination with other disciplines
- **Quality Assurance**: Automated checking of drawing completeness and accuracy
- **Template Application**: Intelligent selection and application of appropriate templates

#### Real-Time Assistance
```
┌─ Agent CAD Feed ──────────────────────────────────────────────┐
│ ⏰ 14:32 Agent: "Generating foundation layout drawings"        │
│ ⏰ 14:33 Agent: "Applying SANS 10400 dimensioning standards"  │
│ ⏰ 14:35 Agent: "BIM coordination completed - no clashes found"│
│ ⏰ 14:36 Agent: "Quality check: 95% completeness achieved"    │
│ ⏰ 14:37 Agent: "Preliminary drawings validation: 98% complete"│
└─────────────────────────────────────────────────────────────────┘
```

## Document Control Integration

### 00900 System Integration
- **Automatic Retrieval**: Modal loads calculation results and design data on open
- **Real-time Sync**: Document changes reflected immediately in modal
- **Version Control**: All drawings tracked with complete revision history
- **Approval Routing**: Documents automatically routed through approval process
- **Audit Trail**: Complete history of all drawing document interactions

### Document Workflow
1. **Data Loading**: Modal queries 00900 for design inputs and calculation results
2. **Agent Processing**: CAD Agent generates preliminary drawings
3. **Coordination**: BIM coordination and clash detection performed
4. **Quality Check**: Automated quality assurance and standards compliance
5. **Approval Submission**: Documents routed to Drawing Office for sign-off
6. **Final Storage**: Approved drawings stored with permanent 00900 links

## Approval Workflow Integration

### Drawing Office Approval Process
1. **Notification**: Drawing Office receives modal access link and notification
2. **Document Review**: Full access to drawings, coordination reports, and quality checks
3. **Technical Validation**: Review of drawing standards, completeness, and coordination
4. **Comments & Revisions**: Feedback provided through modal interface
5. **Final Approval**: Digital sign-off with audit trail

### Approval Status Tracking
- **Submitted**: Drawings submitted, awaiting review
- **Under Review**: Drawing Office actively reviewing
- **Approved**: Sign-off complete, workflow progresses to next card
- **Rejected**: Revisions required, card returns to "In Progress"
- **Re-submitted**: Revised drawings submitted for re-approval

## Template System Integration

### Drawing Templates
- **Structure-Specific Templates**: Pre-configured templates for different civil structures
- **Standard Sheet Templates**: Title blocks, borders, and standard layouts
- **Annotation Libraries**: Standard symbols, leaders, and dimensioning styles
- **CAD Standards Files**: Layer standards, text styles, and plotting configurations

### Template Features
- **Auto-Population**: Templates pre-filled with project and design data
- **Standards Enforcement**: Built-in compliance with drawing standards
- **Scalability**: Automatic scaling and layout optimization
- **Export Options**: Multiple formats (DWG, PDF, DGN)

## Performance & Scalability

### Modal Performance Optimization
- **Lazy Loading**: Agent interface loads on demand
- **Progressive Rendering**: Drawing sections load as needed
- **Background Processing**: Agent drawing generation runs without blocking UI
- **Memory Management**: Efficient handling of large CAD datasets

### Agent Scalability
- **Load Balancing**: CAD Agent distributed across resources
- **Priority Queuing**: Critical drawing production prioritized
- **Resource Monitoring**: Automatic scaling based on demand
- **Fallback Handling**: Manual drawing creation available when agent unavailable

## Error Handling & Validation

### Form Validation
- **Required Fields**: Visual indicators for missing drawing parameters
- **Business Rules**: Drawing standards and coordination validation
- **CAD Logic**: Drawing completeness and annotation validation
- **Data Ranges**: Realistic drawing scale and dimension checking

### Agent Error Handling
- **Processing Timeouts**: Automatic retry with exponential backoff
- **Data Quality Issues**: Validation prompts for unclear design data
- **Integration Failures**: Graceful fallback to manual entry
- **Recovery Mechanisms**: State preservation during error recovery

## Security & Compliance

### Data Security
- **End-to-End Encryption**: All drawing data encrypted during processing
- **Access Control**: Role-based permissions for drawing data access
- **Audit Logging**: Complete record of all user and agent actions
- **Compliance Monitoring**: Drawing standards compliance validation

### Drawing Data Protection
- **Professional Standards**: Drawing information handled according to engineering standards
- **Data Retention**: Automatic cleanup of temporary drawing files
- **Access Logging**: Complete audit trail of drawing data access
- **Secure Storage**: Encrypted storage of all CAD documentation

## Mobile & Accessibility

### Responsive Modal Design
- **Touch Optimization**: Large touch targets for mobile drawing review
- **Gesture Support**: Pinch-to-zoom and swipe navigation for drawings
- **Progressive Disclosure**: Simplified views for smaller screens
- **Offline Capability**: Core drawing review available offline

### Accessibility Compliance (WCAG 2.1 AA)
- **Keyboard Navigation**: Full keyboard accessibility for drawing navigation
- **Screen Reader Support**: ARIA labels and live regions for drawing elements
- **High Contrast**: Support for high contrast drawing display
- **Motion Preferences**: Respects reduced motion settings

## Implementation Architecture

### Modal Component Structure
```
CivilEngineeringModal/
├── PreliminaryDrawingsCard/
│   ├── CardHeader.jsx              # Status and modal controls
│   ├── AgentDashboard.jsx          # CAD Agent status
│   ├── DrawingForm.jsx             # Main drawing parameters
│   ├── CanvasPanel.jsx             # Drawing display and editing
│   ├── ApprovalQueue.jsx           # Sign-off workflow display
│   └── CardFooter.jsx              # Action buttons
```

### API Integration Points
```javascript
// Agent coordination
POST /api/workflows/{projectId}/cards/{cardId}/agents/assign
GET  /api/workflows/{projectId}/cards/{cardId}/agents/status
POST /api/workflows/{projectId}/cards/{cardId}/agents/generate

// Document control
GET  /api/document-control/{projectId}/drawings
POST /api/document-control/{projectId}/drawings/upload
PUT  /api/document-control/{projectId}/drawings/{docId}/version

// Drawing data
GET  /api/projects/{projectId}/drawings
POST /api/projects/{projectId}/drawings
PUT  /api/projects/{projectId}/drawings

// Approval workflow
POST /api/approvals/{projectId}/cards/{cardId}/submit
GET  /api/approvals/{projectId}/pending
POST /api/approvals/{approvalId}/decide
```

## Testing & Validation

### Modal Functionality Testing
- **Button Actions**: All modal buttons function correctly
- **Agent Integration**: CAD Agent processes drawing data properly
- **Form Validation**: All required drawing parameters validated appropriately
- **Document Flow**: 00900 integration complete and reliable
- **Approval Process**: Drawing Office approval workflow functions

### Performance Testing
- **Load Times**: Modal opens within 2 seconds
- **Agent Response**: Drawing generation completes within 10 minutes
- **Form Saving**: Auto-save works without data loss
- **Document Upload**: Large drawing files upload within 15 minutes

### User Acceptance Testing
- **Preliminary Drawings**: Complete drawing generation and coordination workflow
- **Agent Assistance**: CAD Agent provides accurate drawing production
- **Document Management**: All drawing documents properly managed
- **Approval Routing**: Drawing Office approval process works
- **Template Usage**: Template system enhances drawing productivity

## Success Metrics

### Functional Metrics
- **Modal Load Time**: <2 seconds average
- **Agent Processing Time**: <10 minutes for standard drawing sets
- **Form Completion Rate**: >95% successful drawing completion
- **Approval Completion**: <24 hours average approval time

### Quality Metrics
- **Drawing Accuracy**: >98% accurate automated drawing generation
- **Standards Compliance**: >95% automatic standards compliance
- **Coordination Success**: >90% successful BIM coordination
- **Review Satisfaction**: >85% reviewer satisfaction with drawing quality

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
- v1.0 (2026-03-29): Initial preliminary drawings card specification with CAD Agent, 00900 document control, and Drawing Office approval workflow