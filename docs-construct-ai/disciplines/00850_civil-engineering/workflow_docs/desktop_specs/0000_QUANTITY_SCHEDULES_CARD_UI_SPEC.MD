---
title: Quantity Schedules Card Modal Specification
author: Construct AI Memory System Team
date: 2026-03-29
version: 1.0
memory_layer: durable_knowledge
para_section: disciplines/00850_civil-engineering/workflow_docs
gigabrain_tags: disciplines, 00850_civil-engineering, modal-cards, quantity-schedules, validation-agent, document-control, approval-workflow
openstinger_context: modal-card-specification, agent-coordination, document-management, approval-system
last_updated: 2026-03-29
related_docs:
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_UI_CARDS_IMPLEMENTATION_SUMMARY.md
  - disciplines/00850_civil-engineering/workflow_docs/00850_CIVIL_ENGINEERING_MODAL_REDESIGN_SPECIFICATION.md
---

# 00850_0_QUANTITY_SCHEDULES_CARD_UI_SPEC.md - Quantity Schedules Card Modal Specification

## Status
- [x] Modal redesign completed
- [x] Agent integration implemented
- [x] Document control integrated
- [x] Approval workflow configured
- [x] Production ready

## Version History
- v1.0 (2026-03-29): Initial quantity schedules card specification

## Modal Card Overview

### Card Identity
- **Card Type**: Quantity Schedules (Phase 4, Card 3)
- **Modal Button Actions**: 👁️ View • 👤 Assign • ✅ Complete • 📥 Download • 📤 Submit
- **Agent Assignment**: Validation Agent
- **Input Documents**: Construction Drawings, Material Take-offs, Unit Rates
- **Output Documents**: BOQ Excel
- **Approval Workflow**: Quantity Surveyor → 00900 Doc Control

### Modal Integration
This card operates within the Civil Engineering Workflow Modal System, providing:
- **Quantity Calculation**: Automated generation of bill of quantities from construction drawings
- **Agent Integration**: Validation Agent for automated quantity checking and validation
- **Document Control**: 00900 system integration for quantity schedule management
- **Approval Workflows**: Quantity Surveyor sign-off for tender documentation
- **Cost Integration**: Direct links to cost management and procurement systems

## Modal Card Structure

### Card Header (Modal Context)
```
┌─────────────────────────────────────────────────────────────────┐
│ 📊 QUANTITY SCHEDULES CARD - Phase 4 of 5                      │
│ Status: 🔄 In Progress | Progress: ████████░░░░░░ 40%          │
│ Agent: Validation | Due: [Auto-calculated]                    │
│ Modal Controls: [Filter] [Progress] [Actions] [Close]          │
└─────────────────────────────────────────────────────────────────┘
```

### Main Content Area (Modal Body)

#### Section 1: Agent Status Dashboard
```
┌─ Validation Agent Status ───────────────────────────────────────┐
│                                                               │
│ ✅ Validation Agent: [🟢 Active]                               │
│    Task: Quantity Take-off & Schedule Validation              │
│    Progress: ████████░░░░░░ 80% | ETA: 8 min                  │
│    [📊 View Details] [🔄 Refresh] [⚙️ Configure]              │
│                                                               │
│ 📋 Quantity Calculation Results:                              │
│    • Bill items calculated: 245 line items                   │
│    • Quantity validation completed: 98% accuracy             │
│    • Cost estimation integrated: R85M total estimated        │
│    • Schedule completeness verified: All sections complete   │
└───────────────────────────────────────────────────────────────┘
```

#### Section 2: Quantity Schedule Framework (Modal Viewport)
```
┌─ Bill of Quantities Structure & Categories ────────────────────┐
│                                                               │
│ 📋 BOQ Sections:                                              │
│    [x] Preliminaries & General                                │
│    [x] Earthworks & Excavation                                │
│    [x] Concrete Works                                         │
│    [x] Reinforcement & Structural Steel                       │
│    [x] Road Pavements & Surfacing                             │
│    [x] Drainage & Services                                    │
│    [x] Traffic Signs & Road Markings                          │
│    [x] Provisional Sums                                       │
│                                                               │
│ 📊 Quantity Summary by Category:                              │
│                                                               │
│    ┌─────────────┬─────────────┬─────────────┬─────────────┐  │
│    │ Category    │ Quantity    │ Unit        │ Est. Cost   │  │
│    │             │             │             │ (R)         │  │
│    ├─────────────┼─────────────┼─────────────┼─────────────┤  │
│    │ Earthworks  │ 45,200      │ m³          │ 12,500,000  │  │
│    │ Concrete    │ 2,850       │ m³          │ 8,200,000   │  │
│    │ Reinforcement│ 185        │ tonne       │ 3,800,000   │  │
│    │ Pavements   │ 18,500      │ m²          │ 25,000,000  │  │
│    │ Drainage    │ 3,200       │ m           │ 8,500,000   │  │
│    │ Services    │ 1,450       │ m           │ 4,200,000   │  │
│    └─────────────┴─────────────┴─────────────┴─────────────┘  │
│                                                               │
│ 💰 Total Estimated Cost: [R61,200,000]                        │
│                                                               │
│ 📈 Quantity Validation Status:                                │
│    [Rich Text Editor - Agent Assisted]                        │
│    "All quantities calculated from construction drawings.     │
│    Validation completed against design specifications.        │
│    Cost rates applied from current market data. Ready for    │
│    tender documentation and procurement."                     │
└───────────────────────────────────────────────────────────────┘
```

#### Section 3: Quantity Validation & Cost Integration
```
┌─ Quantity Validation & Cost Estimation ────────────────────────┐
│                                                               │
│ 🔍 Quantity Validation Checks:                                │
│                                                               │
│    Validation Metric: Quantity Accuracy & Completeness       │
│    ┌─────────────┬─────────────┬─────────────┬─────────────┐  │
│    │ Section     │ Items      │ Validation  │ Status      │  │
│    │             │ Checked    │ Status      │             │  │
│    ├─────────────┼─────────────┼─────────────┼─────────────┤  │
│    │ Earthworks  │ 45/45      │ ✅ Verified │ Complete    │  │
│    │ Concrete    │ 28/28      │ ✅ Verified │ Complete    │  │
│    │ Reinforcement│ 15/15     │ ⚠️ Minor    │ Adjustments │  │
│    │ Pavements   │ 32/32      │ ✅ Verified │ Complete    │  │
│    │ Drainage    │ 22/22      │ ✅ Verified │ Complete    │  │
│    └─────────────┴─────────────┴─────────────┴─────────────┘  │
│                                                               │
│ 💵 Cost Estimation Integration:                               │
│                                                               │
│    Cost Data Source: Current Market Rates (Updated 2026)     │
│    • Unit rates verified: [98% from current data]            │
│    • Provisional sums included: [15% contingencies]          │
│    • Escalation allowance: [8% over 24 months]               │
│    • Total with contingencies: [R67,800,000]                 │
│                                                               │
│ ⚠️ Quantity Review Notes:                                     │
│    [Rich Text Editor]                                         │
│    "Quantity schedules complete and validated. Minor         │
│    adjustments made to reinforcement quantities based on     │
│    final design. Cost estimation integrated with current     │
│    market rates. Ready for Quantity Surveyor approval."      │
└───────────────────────────────────────────────────────────────┘
```

### Modal Footer Actions
```
┌─────────────────────────────────────────────────────────────────┐
│ [👁️ View Details] [👤 Assign Agent] [✅ Complete & Submit] [📥 Download Templates] [💾 Save Progress] │
│ [❌ Cancel] [🔄 Reset] [📤 Export BOQ] [❓ Help] [✖️ Close Modal] │
└─────────────────────────────────────────────────────────────────┘
```

## Modal Button Functionality

### 👁️ View Button (Primary Action)
**Function**: Open detailed quantity schedules interface with full calculation capabilities
**Modal Behavior**:
- Expands to full modal view with all quantity sections visible
- Loads existing construction drawings and material data from workflow state
- Initializes Validation Agent for automated quantity checking
- Displays complete bill of quantities with editing and review tools
- Enables full editing of quantities and cost rates

### 👤 Assign Button (Agent Assignment)
**Function**: Assign or reassign Validation Agent to this card
**Modal Behavior**:
- Opens agent selection interface (Validation Agent optimized for quantity surveying)
- Shows agent availability and current processing load
- Allows configuration of cost rates and validation parameters
- Confirms agent assignment with processing time estimates
- Updates modal header with assigned agent status

### ✅ Complete Button (Workflow Progression)
**Function**: Mark quantity schedules as completed and trigger approval workflow
**Modal Behavior**:
- Validates all quantities are calculated and cost estimates complete
- Submits work to Quantity Surveyor approval workflow
- Updates card status to "Under Review"
- Notifies approver through system notification
- Unlocks dependent cards (Inspection & Test Plans)

### 📥 Download Button (Template Access)
**Function**: Download quantity schedule templates and cost databases
**Modal Behavior**:
- Downloads bill of quantities templates and formats
- Provides cost rate databases and quantity calculation spreadsheets
- Includes validation checklists and quality assurance templates
- All templates sourced from 00900 template library
- Includes quantity surveying guidelines and standards

### 📤 Submit Button (Approval Submission)
**Function**: Submit completed quantity schedules for formal approval
**Modal Behavior**:
- Packages complete bill of quantities with all calculations
- Uploads to 00900 with version control and approval metadata
- Routes to Quantity Surveyor approval queue
- Creates complete audit trail for quantity approval
- Updates workflow progress tracking

## Agent Integration Architecture

### Validation Agent
The Validation Agent provides intelligent assistance for quantity calculation and validation:

#### Analysis Capabilities
- **Quantity Take-off**: Automated calculation of quantities from construction drawings
- **Cost Estimation**: Integration with current market rates and cost databases
- **Validation Checking**: Automated verification of quantity accuracy and completeness
- **Schedule Generation**: Intelligent organization of quantities into standard formats
- **Cost Analysis**: Automated cost estimation and budget analysis

#### Real-Time Assistance
```
┌─ Agent Validation Feed ────────────────────────────────────────┐
│ ⏰ 14:32 Agent: "Calculating earthworks quantities from drawings" │
│ ⏰ 14:33 Agent: "Applying current market rates for cost estimation" │
│ ⏰ 14:35 Agent: "Validating quantities against design specifications" │
│ ⏰ 14:36 Agent: "Generating bill of quantities schedule"            │
│ ⏰ 14:37 Agent: "Quantity schedules validation: 98% complete"       │
└─────────────────────────────────────────────────────────────────┘
```

## Document Control Integration

### 00900 System Integration
- **Automatic Retrieval**: Modal loads construction drawings and cost data on open
- **Real-time Sync**: Document changes reflected immediately in modal
- **Version Control**: All quantity schedules tracked with complete revision history
- **Approval Routing**: Documents automatically routed through approval process
- **Audit Trail**: Complete history of all quantity document interactions

### Document Workflow
1. **Data Loading**: Modal queries 00900 for construction drawings and specifications
2. **Agent Processing**: Validation Agent calculates quantities and costs
3. **Validation**: Automated checking of quantity accuracy and completeness
4. **Documentation**: Complete bill of quantities prepared for approval
5. **Approval Submission**: Documents routed to Quantity Surveyor for sign-off
6. **Final Storage**: Approved quantity schedules stored with permanent 00900 links

## Approval Workflow Integration

### Quantity Surveyor Approval Process
1. **Notification**: Quantity Surveyor receives modal access link and notification
2. **Document Review**: Full access to quantity schedules, calculations, and cost estimates
3. **Technical Validation**: Review of quantity accuracy, cost rates, and schedule completeness
4. **Comments & Revisions**: Feedback provided through modal interface
5. **Final Approval**: Digital sign-off with audit trail

### Approval Status Tracking
- **Submitted**: Quantity schedules submitted, awaiting review
- **Under Review**: Quantity Surveyor actively reviewing
- **Approved**: Sign-off complete, quantities released for tendering
- **Rejected**: Revisions required, card returns to "In Progress"
- **Re-submitted**: Revised schedules submitted for re-approval

## Template System Integration

### Quantity Schedule Templates
- **BOQ Templates**: Standardized bill of quantities formats
- **Cost Rate Templates**: Current market rate databases and schedules
- **Quantity Templates**: Calculation templates for different construction elements
- **Validation Templates**: Quality assurance and checking templates

### Template Features
- **Auto-Population**: Templates pre-filled with project design data
- **Cost Integration**: Built-in links to current cost databases
- **Contractor Integration**: Direct links to tendering and procurement systems
- **Export Options**: Multiple formats (Excel, PDF) for tender documentation

## Performance & Scalability

### Modal Performance Optimization
- **Lazy Loading**: Agent interface loads on demand
- **Progressive Rendering**: Quantity sections load as needed
- **Background Processing**: Agent quantity calculation runs without blocking UI
- **Memory Management**: Efficient handling of large quantity datasets

### Agent Scalability
- **Load Balancing**: Validation Agent distributed across resources
- **Priority Queuing**: Critical quantity calculations prioritized
- **Resource Monitoring**: Automatic scaling based on demand
- **Fallback Handling**: Manual quantity calculation available when agent unavailable

## Error Handling & Validation

### Form Validation
- **Required Fields**: Visual indicators for missing quantity parameters
- **Business Rules**: Quantity calculation and cost estimation validation
- **Calculation Logic**: Quantity accuracy and cost rate validation
- **Data Ranges**: Realistic quantity and cost checking

### Agent Error Handling
- **Processing Timeouts**: Automatic retry with exponential backoff
- **Data Quality Issues**: Validation prompts for unclear drawing data
- **Integration Failures**: Graceful fallback to manual entry
- **Recovery Mechanisms**: State preservation during error recovery

## Security & Compliance

### Data Security
- **End-to-End Encryption**: All quantity data encrypted during processing
- **Access Control**: Role-based permissions for quantity schedule data access
- **Audit Logging**: Complete record of all user and agent actions
- **Compliance Monitoring**: Quantity surveying standards compliance validation

### Quantity Data Protection
- **Professional Standards**: Quantity information handled according to surveying standards
- **Data Retention**: Automatic cleanup of temporary quantity files
- **Access Logging**: Complete audit trail of quantity data access
- **Secure Storage**: Encrypted storage of all quantity documentation

## Mobile & Accessibility

### Responsive Modal Design
- **Touch Optimization**: Large touch targets for mobile quantity review
- **Gesture Support**: Swipe navigation and pinch-to-zoom for quantity schedules
- **Progressive Disclosure**: Simplified views for smaller screens
- **Offline Capability**: Core quantity review available offline

### Accessibility Compliance (WCAG 2.1 AA)
- **Keyboard Navigation**: Full keyboard accessibility for quantity navigation
- **Screen Reader Support**: ARIA labels and live regions for quantity data
- **High Contrast**: Support for high contrast quantity display
- **Motion Preferences**: Respects reduced motion settings

## Implementation Architecture

### Modal Component Structure
```
CivilEngineeringModal/
├── QuantitySchedulesCard/
│   ├── CardHeader.jsx              # Status and modal controls
│   ├── AgentDashboard.jsx          # Validation Agent status
│   ├── QuantityForm.jsx            # Main quantity parameters
│   ├── ScheduleViewer.jsx          # Quantity schedule display
│   ├── ApprovalQueue.jsx           # Sign-off workflow display
│   └── CardFooter.jsx              # Action buttons
```

### API Integration Points
```javascript
// Agent coordination
POST /api/workflows/{projectId}/cards/{cardId}/agents/assign
GET  /api/workflows/{projectId}/cards/{cardId}/agents/status
POST /api/workflows/{projectId}/cards/{cardId}/agents/calculate

// Document control
GET  /api/document-control/{projectId}/quantities
POST /api/document-control/{projectId}/quantities/upload
PUT  /api/document-control/{projectId}/quantities/{docId}/version

// Quantity data
GET  /api/projects/{projectId}/quantities
POST /api/projects/{projectId}/quantities
PUT  /api/projects/{projectId}/quantities

// Approval workflow
POST /api/approvals/{projectId}/cards/{cardId}/submit
GET  /api/approvals/{projectId}/pending
POST /api/approvals/{approvalId}/decide
```

## Testing & Validation

### Modal Functionality Testing
- **Button Actions**: All modal buttons function correctly
- **Agent Integration**: Validation Agent processes quantity data properly
- **Form Validation**: All required quantity parameters validated appropriately
- **Document Flow**: 00900 integration complete and reliable
- **Approval Process**: Quantity Surveyor approval workflow functions

### Performance Testing
- **Load Times**: Modal opens within 2 seconds
- **Agent Response**: Quantity calculation completes within 10 minutes
- **Form Saving**: Auto-save works without data loss
- **Document Upload**: Large quantity datasets upload within 15 minutes

### User Acceptance Testing
- **Quantity Schedules**: Complete quantity calculation and validation workflow
- **Agent Assistance**: Validation Agent provides accurate quantity checking
- **Document Management**: All quantity schedules properly managed
- **Approval Routing**: Quantity Surveyor approval process works
- **Template Usage**: Template system enhances quantity surveying productivity

## Success Metrics

### Functional Metrics
- **Modal Load Time**: <2 seconds average
- **Agent Processing Time**: <10 minutes for standard quantity schedules
- **Form Completion Rate**: >95% successful quantity completion
- **Approval Completion**: <24 hours average approval time

### Quality Metrics
- **Quantity Accuracy**: >98% accurate automated quantity calculation
- **Cost Estimation**: >95% alignment with market rates
- **Validation Success**: >97% quantities pass surveying review
- **Contractor Readiness**: >90% BOQ meets tender requirements

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
- v1.0 (2026-03-29): Initial quantity schedules card specification with Validation Agent, 00900 document control, and Quantity Surveyor approval workflow