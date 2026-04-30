---
title: Tender Documents Card Modal Specification
author: Construct AI Memory System Team
date: 2026-03-29
version: 1.0
memory_layer: durable_knowledge
para_section: disciplines/00850_civil-engineering/workflow_docs
gigabrain_tags: disciplines, 00850_civil-engineering, modal-cards, tender-documents, documentation-agent, document-control, approval-workflow
openstinger_context: modal-card-specification, agent-coordination, document-management, approval-system
last_updated: 2026-03-29
related_docs:
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_UI_CARDS_IMPLEMENTATION_SUMMARY.md
  - disciplines/00850_civil-engineering/workflow_docs/00850_CIVIL_ENGINEERING_MODAL_REDESIGN_SPECIFICATION.md
---

# 00850_0_TENDER_DOCUMENTS_CARD_UI_SPEC.md - Tender Documents Card Modal Specification

## Status
- [x] Modal redesign completed
- [x] Agent integration implemented
- [x] Document control integrated
- [x] Approval workflow configured
- [x] Production ready

## Version History
- v1.0 (2026-03-29): Initial tender documents card specification

## Modal Card Overview

### Card Identity
- **Card Type**: Tender Documents (Phase 5, Card 1)
- **Modal Button Actions**: 👁️ View • 👤 Assign • ✅ Complete • 📥 Download • 📤 Submit
- **Agent Assignment**: Documentation Agent
- **Input Documents**: All Phase 4 Outputs, Procurement Requirements, Compliance Matrices
- **Output Documents**: Tender Package
- **Approval Workflow**: Procurement Lead → 00900 Doc Control

### Modal Integration
This card operates within the Civil Engineering Workflow Modal System, providing:
- **Procurement Documentation**: Complete tender package assembly for contractor procurement
- **Agent Integration**: Documentation Agent for automated tender document compilation and validation
- **Document Control**: 00900 system integration for tender package management
- **Approval Workflows**: Procurement Lead sign-off for tender release
- **Procurement Integration**: Direct links to procurement and tendering systems

## Modal Card Structure

### Card Header (Modal Context)
```
┌─────────────────────────────────────────────────────────────────┐
│ 📄 TENDER DOCUMENTS CARD - Phase 5 of 5                        │
│ Status: 🔄 In Progress | Progress: ████████░░░░░░ 40%          │
│ Agent: Documentation | Due: [Auto-calculated]                 │
│ Modal Controls: [Filter] [Progress] [Actions] [Close]          │
└─────────────────────────────────────────────────────────────────┘
```

### Main Content Area (Modal Body)

#### Section 1: Agent Status Dashboard
```
┌─ Documentation Agent Status ────────────────────────────────────┐
│                                                               │
│ 📝 Documentation Agent: [🟢 Active]                            │
│    Task: Tender Package Assembly & Compliance Validation      │
│    Progress: ████████░░░░░░ 80% | ETA: 10 min                 │
│    [📊 View Details] [🔄 Refresh] [⚙️ Configure]              │
│                                                               │
│ 📋 Tender Assembly Results:                                   │
│    • Tender documents compiled: 28 separate documents        │
│    • Compliance validation completed: 97% all requirements met│
│    • Procurement requirements verified: All sections complete│
│    • Tender package ready for distribution: Final QC passed  │
└───────────────────────────────────────────────────────────────┘
```

#### Section 2: Tender Package Structure (Modal Viewport)
```
┌─ Tender Package Contents & Organization ────────────────────────┐
│                                                               │
│ 📋 Tender Package Sections:                                   │
│    [x] Instructions to Tenderers                              │
│    [x] Conditions of Contract                                 │
│    [x] Specifications (Technical)                             │
│    [x] Drawings (Construction Set)                            │
│    [x] Bill of Quantities                                     │
│    [x] Inspection & Test Plans                                │
│    [x] Health & Safety Requirements                           │
│    [x] Environmental Management Plan                          │
│    [x] Pricing Schedules                                      │
│    [x] Contract Data                                          │
│                                                               │
│ 📊 Document Summary by Category:                              │
│                                                               │
│    ┌─────────────┬─────────────┬─────────────┬─────────────┐  │
│    │ Category    │ Documents   │ Pages       │ Status      │  │
│    │             │ Included    │             │             │  │
│    ├─────────────┼─────────────┼─────────────┼─────────────┤  │
│    │ Contract    │ 4           │ 45          │ ✅ Complete │  │
│    │ Technical   │ 8           │ 120         │ ✅ Complete │  │
│    │ Drawings    │ 12          │ 85          │ ✅ Complete │  │
│    │ Commercial  │ 3           │ 35          │ ✅ Complete │  │
│    │ H&S/Env     │ 2           │ 25          │ ⚠️ Final QC │  │
│    └─────────────┴─────────────┴─────────────┴─────────────┘  │
│                                                               │
│ 📦 Total Tender Package: [28 documents, 310 pages]           │
│                                                               │
│ 📈 Tender Readiness Status:                                   │
│    [Rich Text Editor - Agent Assisted]                        │
│    "Complete tender package assembled from all Phase 4       │
│    outputs. All procurement requirements included and        │
│    validated. Tender package ready for procurement lead      │
│    approval and contractor distribution."                    │
└───────────────────────────────────────────────────────────────┘
```

#### Section 3: Procurement Compliance & Validation
```
┌─ Procurement Compliance & Tender Validation ───────────────────┐
│                                                               │
│ 🔍 Procurement Compliance Checks:                             │
│                                                               │
│    Compliance Metric: Tender Documentation Completeness      │
│    ┌─────────────┬─────────────┬─────────────┬─────────────┐  │
│    │ Requirement │ Status      │ Reference   │ Comments    │  │
│    │             │             │             │             │  │
│    ├─────────────┼─────────────┼─────────────┼─────────────┤  │
│    │ CIDB Reg    │ ✅ Compliant│ CIDB Grading│ Grade 9 CE  │  │
│    │ B-BBEE      │ ✅ Included │ Level 1-4   │ Preferential│  │
│    │ Local Cont  │ ✅ Specified│ 90% Target  │ Procurement │  │
│    │ H&S Spec    │ ⚠️ Review   │ OHS Act     │ Final Check │  │
│    │ Env Compliance│ ✅ Complete│ NEMA       │ All Permits │  │
│    └─────────────┴─────────────┴─────────────┴─────────────┘  │
│                                                               │
│ 📋 Tender Issue Requirements:                                 │
│                                                               │
│    Tender Period: 42 days from issue                          │
│    • Site Inspection: [Mandatory for all tenderers]          │
│    • Clarification Deadline: [21 days from issue]            │
│    • Tender Validity: [90 days from closing]                 │
│    • Evaluation Method: [80% Price + 20% Quality]            │
│                                                               │
│ ⚠️ Tender Documentation Notes:                                │
│    [Rich Text Editor]                                         │
│    "Tender package complete and compliant with all           │
│    procurement requirements. H&S specifications require      │
│    final review. Tender evaluation criteria clearly defined  │
│    for procurement process."                                  │
└───────────────────────────────────────────────────────────────┘
```

### Modal Footer Actions
```
┌─────────────────────────────────────────────────────────────────┐
│ [👁️ View Details] [👤 Assign Agent] [✅ Complete & Submit] [📥 Download Templates] [💾 Save Progress] │
│ [❌ Cancel] [🔄 Reset] [📤 Export Tender Package] [❓ Help] [✖️ Close Modal] │
└─────────────────────────────────────────────────────────────────┘
```

## Modal Button Functionality

### 👁️ View Button (Primary Action)
**Function**: Open detailed tender documents interface with full procurement package capabilities
**Modal Behavior**:
- Expands to full modal view with all tender sections visible
- Loads existing Phase 4 outputs and procurement requirements from workflow state
- Initializes Documentation Agent for automated tender package assembly
- Displays complete tender package with navigation and review tools
- Enables full editing of tender documents and procurement requirements

### 👤 Assign Button (Agent Assignment)
**Function**: Assign or reassign Documentation Agent to this card
**Modal Behavior**:
- Opens agent selection interface (Documentation Agent optimized for procurement)
- Shows agent availability and current processing load
- Allows configuration of procurement standards and tender requirements
- Confirms agent assignment with processing time estimates
- Updates modal header with assigned agent status

### ✅ Complete Button (Workflow Progression)
**Function**: Mark tender documents as completed and trigger approval workflow
**Modal Behavior**:
- Validates all tender documents are complete and procurement compliant
- Submits work to Procurement Lead approval workflow
- Updates card status to "Under Review"
- Notifies approver through system notification
- Unlocks dependent cards (Construction Support)

### 📥 Download Button (Template Access)
**Function**: Download tender document templates and procurement standards
**Modal Behavior**:
- Downloads tender package templates and standard documents
- Provides procurement compliance checklists and evaluation forms
- Includes tendering guidelines and contract templates
- All templates sourced from 00900 template library
- Includes procurement process guidelines and standards

### 📤 Submit Button (Approval Submission)
**Function**: Submit completed tender documents for formal approval
**Modal Behavior**:
- Packages complete tender package with all procurement documentation
- Uploads to 00900 with version control and approval metadata
- Routes to Procurement Lead approval queue
- Creates complete audit trail for tender release
- Updates workflow progress tracking

## Agent Integration Architecture

### Documentation Agent
The Documentation Agent provides intelligent assistance for tender package assembly:

#### Analysis Capabilities
- **Document Assembly**: Automated compilation of all Phase 4 outputs into tender package
- **Compliance Validation**: Automatic checking against procurement regulations and requirements
- **Document Organization**: Intelligent structuring and cross-referencing of tender documents
- **Quality Assurance**: Automated validation of document completeness and consistency
- **Procurement Integration**: Direct links to procurement systems and tendering platforms

#### Real-Time Assistance
```
┌─ Agent Documentation Feed ─────────────────────────────────────┐
│ ⏰ 14:32 Agent: "Assembling technical specifications into tender" │
│ ⏰ 14:33 Agent: "Validating procurement compliance requirements" │
│ ⏰ 14:35 Agent: "Cross-referencing all tender documents"         │
│ ⏰ 14:36 Agent: "Final QC check on tender package completeness" │
│ ⏰ 14:37 Agent: "Tender documents validation: 97% complete"     │
└─────────────────────────────────────────────────────────────────┘
```

## Document Control Integration

### 00900 System Integration
- **Automatic Retrieval**: Modal loads all Phase 4 outputs and procurement templates on open
- **Real-time Sync**: Document changes reflected immediately in modal
- **Version Control**: All tender documents tracked with complete revision history
- **Approval Routing**: Documents automatically routed through approval process
- **Audit Trail**: Complete history of all tender document interactions

### Document Workflow
1. **Data Loading**: Modal queries 00900 for all Phase 4 deliverables and procurement templates
2. **Agent Processing**: Documentation Agent assembles and validates tender package
3. **Compliance Checking**: Automated validation of procurement requirements and standards
4. **Package Assembly**: Complete tender package prepared for approval and distribution
5. **Approval Submission**: Documents routed to Procurement Lead for tender release
6. **Final Storage**: Approved tender package stored with permanent 00900 links

## Approval Workflow Integration

### Procurement Lead Approval Process
1. **Notification**: Procurement Lead receives modal access link and notification
2. **Document Review**: Full access to tender package, compliance checks, and procurement requirements
3. **Technical Validation**: Review of tender completeness, procurement compliance, and contractor requirements
4. **Comments & Revisions**: Feedback provided through modal interface
5. **Final Approval**: Digital sign-off with audit trail for tender release

### Approval Status Tracking
- **Submitted**: Tender package submitted, awaiting review
- **Under Review**: Procurement Lead actively reviewing
- **Approved**: Sign-off complete, tender package released for procurement
- **Rejected**: Revisions required, card returns to "In Progress"
- **Re-submitted**: Revised tender package submitted for re-approval

## Template System Integration

### Tender Document Templates
- **Tender Package Templates**: Pre-configured tender document structures
- **Procurement Templates**: Standard procurement clauses and conditions
- **Compliance Templates**: Regulatory compliance and certification templates
- **Evaluation Templates**: Tender evaluation criteria and scoring templates

### Template Features
- **Auto-Population**: Templates pre-filled with project procurement data
- **Regulatory Integration**: Built-in compliance with procurement regulations
- **Contractor Integration**: Direct links to contractor registration systems
- **Export Options**: Multiple formats (PDF, DOCX) for tender distribution

## Performance & Scalability

### Modal Performance Optimization
- **Lazy Loading**: Agent interface loads on demand
- **Progressive Rendering**: Tender sections load as needed
- **Background Processing**: Agent document assembly runs without blocking UI
- **Memory Management**: Efficient handling of large tender packages

### Agent Scalability
- **Load Balancing**: Documentation Agent distributed across resources
- **Priority Queuing**: Critical tender documentation prioritized
- **Resource Monitoring**: Automatic scaling based on demand
- **Fallback Handling**: Manual tender assembly available when agent unavailable

## Error Handling & Validation

### Form Validation
- **Required Fields**: Visual indicators for missing tender documentation parameters
- **Business Rules**: Procurement compliance and tender requirement validation
- **Document Logic**: Tender package completeness and cross-reference validation
- **Regulatory Compliance**: Procurement regulation and standard checking

### Agent Error Handling
- **Processing Timeouts**: Automatic retry with exponential backoff
- **Data Quality Issues**: Validation prompts for unclear procurement requirements
- **Integration Failures**: Graceful fallback to manual entry
- **Recovery Mechanisms**: State preservation during error recovery

## Security & Compliance

### Data Security
- **End-to-End Encryption**: All tender data encrypted during processing
- **Access Control**: Role-based permissions for tender document data access
- **Audit Logging**: Complete record of all user and agent actions
- **Compliance Monitoring**: Procurement regulation compliance validation

### Tender Data Protection
- **Professional Standards**: Procurement information handled according to tendering standards
- **Data Retention**: Automatic cleanup of temporary tender files
- **Access Logging**: Complete audit trail of tender data access
- **Secure Storage**: Encrypted storage of all procurement documentation

## Mobile & Accessibility

### Responsive Modal Design
- **Touch Optimization**: Large touch targets for mobile tender document review
- **Gesture Support**: Swipe navigation and pinch-to-zoom for tender packages
- **Progressive Disclosure**: Simplified views for smaller screens
- **Offline Capability**: Core tender document review available offline

### Accessibility Compliance (WCAG 2.1 AA)
- **Keyboard Navigation**: Full keyboard accessibility for tender document navigation
- **Screen Reader Support**: ARIA labels and live regions for tender document content
- **High Contrast**: Support for high contrast tender document display
- **Motion Preferences**: Respects reduced motion settings

## Implementation Architecture

### Modal Component Structure
```
CivilEngineeringModal/
├── TenderDocumentsCard/
│   ├── CardHeader.jsx              # Status and modal controls
│   ├── AgentDashboard.jsx          # Documentation Agent status
│   ├── TenderForm.jsx              # Main tender package parameters
│   ├── PackageViewer.jsx           # Tender package display
│   ├── ApprovalQueue.jsx           # Sign-off workflow display
│   └── CardFooter.jsx              # Action buttons
```

### API Integration Points
```javascript
// Agent coordination
POST /api/workflows/{projectId}/cards/{cardId}/agents/assign
GET  /api/workflows/{projectId}/cards/{cardId}/agents/status
POST /api/workflows/{projectId}/cards/{cardId}/agents/assemble

// Document control
GET  /api/document-control/{projectId}/tender-documents
POST /api/document-control/{projectId}/tender-documents/upload
PUT  /api/document-control/{projectId}/tender-documents/{docId}/version

// Tender data
GET  /api/projects/{projectId}/tender-documents
POST /api/projects/{projectId}/tender-documents
PUT  /api/projects/{projectId}/tender-documents

// Approval workflow
POST /api/approvals/{projectId}/cards/{cardId}/submit
GET  /api/approvals/{projectId}/pending
POST /api/approvals/{approvalId}/decide
```

## Testing & Validation

### Modal Functionality Testing
- **Button Actions**: All modal buttons function correctly
- **Agent Integration**: Documentation Agent processes tender data properly
- **Form Validation**: All required tender parameters validated appropriately
- **Document Flow**: 00900 integration complete and reliable
- **Approval Process**: Procurement Lead approval workflow functions

### Performance Testing
- **Load Times**: Modal opens within 2 seconds
- **Agent Response**: Tender assembly completes within 15 minutes
- **Form Saving**: Auto-save works without data loss
- **Document Upload**: Large tender packages upload within 20 minutes

### User Acceptance Testing
- **Tender Documents**: Complete procurement package assembly workflow
- **Agent Assistance**: Documentation Agent provides accurate tender compilation
- **Document Management**: All tender documents properly managed
- **Approval Routing**: Procurement Lead approval process works
- **Template Usage**: Template system enhances tender documentation productivity

## Success Metrics

### Functional Metrics
- **Modal Load Time**: <2 seconds average
- **Agent Processing Time**: <15 minutes for standard tender packages
- **Form Completion Rate**: >95% successful tender documentation completion
- **Approval Completion**: <24 hours average approval time

### Quality Metrics
- **Documentation Accuracy**: >98% accurate tender package assembly
- **Procurement Compliance**: >97% automatic compliance verification
- **Contractor Readiness**: >95% tender packages meet procurement requirements
- **Procurement Efficiency**: >90% reduction in tender preparation time

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
- v1.0 (2026-03-29): Initial tender documents card specification with Documentation Agent, 00900 document control, and Procurement Lead approval workflow