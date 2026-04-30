---
title: Project Brief Card Modal Specification
author: Construct AI Memory System Team
date: 2026-03-28
version: 2.0
memory_layer: durable_knowledge
para_section: disciplines/00850_civil-engineering/workflow_docs
gigabrain_tags: disciplines, 00850_civil-engineering, modal-cards, project-brief, content-analysis-agent, document-control, approval-workflow
openstinger_context: modal-card-specification, agent-coordination, document-management, approval-system
last_updated: 2026-03-28
related_docs:
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_UI_CARDS_IMPLEMENTATION_SUMMARY.md
  - disciplines/00850_civil-engineering/workflow_docs/00850_CIVIL_ENGINEERING_MODAL_REDESIGN_SPECIFICATION.md
---

# 00850_0_PROJECT_BRIEF_CARD_UI_SPEC.md - Project Brief Card Modal Specification

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
- **Card Type**: Project Brief (Phase 1, Card 1)
- **Modal Button Actions**: 👁️ View • 👤 Assign • ✅ Complete • 📥 Download • 📤 Submit
- **Agent Assignment**: Content Analysis Agent
- **Input Documents**: Client Requirements, Scope Documents (from 00900 Doc Control)
- **Output Documents**: Approved Brief
- **Approval Workflow**: Project Manager Sign-off → 00900 Doc Control

### Modal Integration
This card operates within the Civil Engineering Workflow Modal System, providing:
- **Project Initiation**: Foundation for all subsequent workflow cards
- **Agent Integration**: Content Analysis Agent for document processing
- **Document Control**: 00900 system integration for all project documentation
- **Approval Workflows**: Project Manager sign-off before workflow progression
- **Template System**: Pre-configured project brief templates

## Modal Card Structure

### Card Header (Modal Context)
```
┌─────────────────────────────────────────────────────────────────┐
│ 📋 PROJECT BRIEF CARD - Phase 1 of 5                           │
│ Status: 🔄 In Progress | Progress: ████████░░░░░░ 40%          │
│ Agent: Content Analysis | Due: [Auto-calculated]               │
│ Modal Controls: [Filter] [Progress] [Actions] [Close]          │
└─────────────────────────────────────────────────────────────────┘
```

### Main Content Area (Modal Body)

#### Section 1: Agent Status Dashboard
```
┌─ Agent Coordination Status ────────────────────────────────────┐
│                                                               │
│ 📝 Content Analysis Agent: [🟢 Active]                         │
│    Task: Document Analysis & Template Processing              │
│    Progress: ████████░░░░░░ 80% | ETA: 1 min                  │
│    [📊 View Details] [🔄 Refresh] [⚙️ Configure]              │
│                                                               │
│ 📋 Analysis Results:                                          │
│    • Client requirements extracted: 15 key points            │
│    • Scope boundaries identified: 8 deliverables             │
│    • Risk factors highlighted: 3 critical items              │
│    • Template compatibility: 95% match found                 │
└───────────────────────────────────────────────────────────────┘
```

#### Section 2: Project Information Form (Modal Viewport)
```
┌─ Project Details & Requirements ──────────────────────────────┐
│                                                               │
│ 📋 Project Information:                                       │
│    Title: [Highway Expansion Project]                         │
│    Client: [Department of Transportation]                     │
│    Number: [CE-2026-001] (Auto-generated)                     │
│    Type: [Road Construction] [Bridge] [Infrastructure]       │
│                                                               │
│ 📍 Location & Timeline:                                       │
│    Address: [Johannesburg, South Africa]                      │
│    Coordinates: [-26.2041, 28.0473]                          │
│    Start Date: [2026-01-15] | End Date: [2027-12-31]          │
│    Budget: [R500M - R600M]                                    │
│                                                               │
│ 🎯 Project Objectives:                                        │
│    [Rich Text Editor - Agent Assisted]                        │
│    "Design and construct a 2km highway bypass to alleviate   │
│     traffic congestion in the Johannesburg CBD area..."       │
│                                                               │
│ ✅ Success Criteria:                                          │
│    • Meet traffic capacity of 20,000 vehicles/day             │
│    • Maintain environmental standards (ISO 14001)             │
│    • Stay within 10% of approved budget                       │
│    • Complete within 24-month construction period             │
└───────────────────────────────────────────────────────────────┘
```

#### Section 3: Document Control Integration
```
┌─ 00900 Document Control Integration ──────────────────────────┐
│                                                               │
│ 📥 Input Documents:                                           │
│    • Client Requirements (Linked from CRM)                   │
│    • Scope Documents (Retrieved from 00900)                  │
│    • Previous Project Briefs (Reference library)             │
│                                                               │
│ 📤 Output Documents:                                          │
│    • Approved Project Brief (Auto-saved to 00900)            │
│    • Requirements Matrix (Agent-generated)                   │
│    • Stakeholder Register (Auto-populated)                   │
│                                                               │
│ 🔗 Document References:                                       │
│    [View in 00900] [Download All] [Version History]          │
│                                                               │
│ 📄 Template System:                                           │
│    [Download Standard Brief Template]                         │
│    [Download Requirements Matrix Template]                    │
│    [Download Stakeholder Register Template]                   │
└───────────────────────────────────────────────────────────────┘
```

### Modal Footer Actions
```
┌─────────────────────────────────────────────────────────────────┐
│ [👁️ View Details] [👤 Assign Agent] [✅ Complete & Submit] [📥 Download Templates] [💾 Save Progress] │
│ [❌ Cancel] [🔄 Reset] [📤 Export Brief] [❓ Help] [✖️ Close Modal] │
└─────────────────────────────────────────────────────────────────┘
```

## Modal Button Functionality

### 👁️ View Button (Primary Action)
**Function**: Open detailed project brief interface with full editing capabilities
**Modal Behavior**:
- Expands to full modal view with all form sections visible
- Loads existing project data from workflow state
- Initializes Content Analysis Agent for document processing
- Displays progress tracking and validation status
- Enables full editing of all project brief elements

### 👤 Assign Button (Agent Assignment)
**Function**: Assign or reassign Content Analysis Agent to this card
**Modal Behavior**:
- Opens agent selection interface (primarily Content Analysis Agent)
- Shows agent availability and current workload
- Allows configuration of analysis parameters
- Confirms agent assignment with processing estimates
- Updates modal header with assigned agent status

### ✅ Complete Button (Workflow Progression)
**Function**: Mark project brief as completed and trigger approval workflow
**Modal Behavior**:
- Validates all required fields and document attachments
- Submits work to Project Manager approval workflow
- Updates card status to "Under Review"
- Notifies approver through system notification
- Unlocks dependent cards (Site Survey, Geotechnical, Environmental)

### 📥 Download Button (Template Access)
**Function**: Download project brief templates and reference documents
**Modal Behavior**:
- Downloads standard project brief template
- Provides requirements matrix template
- Includes stakeholder register template
- All templates sourced from 00900 template library
- Includes usage instructions and examples

### 📤 Submit Button (Approval Submission)
**Function**: Submit completed project brief for formal approval
**Modal Behavior**:
- Packages all project brief documents
- Uploads to 00900 with approval metadata
- Routes to Project Manager approval queue
- Creates complete audit trail for submission
- Updates workflow progress tracking

## Agent Integration Architecture

### Content Analysis Agent
The Content Analysis Agent provides intelligent assistance for project brief creation:

#### Analysis Capabilities
- **Document Processing**: Extracts key requirements from client documents
- **Template Matching**: Identifies best-matching project brief templates
- **Requirements Extraction**: Pulls objectives, constraints, and success criteria
- **Stakeholder Identification**: Recognizes project stakeholders and roles
- **Risk Assessment**: Highlights potential project risks and constraints

#### Real-Time Assistance
```
┌─ Agent Assistance Feed ────────────────────────────────────────┐
│ ⏰ 14:32 Agent: "Extracted 15 key requirements from RFP"      │
│ ⏰ 14:33 Agent: "Recommended Highway Design Template v2.1"    │
│ ⏰ 14:35 Agent: "Identified 8 project deliverables"           │
│ ⏰ 14:36 Agent: "Flagged budget contingency requirement"      │
│ ⏰ 14:37 Agent: "Project brief validation: 98% complete"      │
└───────────────────────────────────────────────────────────────┘
```

## Document Control Integration

### 00900 System Integration
- **Automatic Retrieval**: Modal loads client requirements and scope documents on open
- **Real-time Sync**: Document changes reflected immediately in modal
- **Version Control**: All project brief versions tracked with change history
- **Approval Routing**: Documents automatically routed through approval process
- **Audit Trail**: Complete history of all document interactions

### Document Workflow
1. **Input Loading**: Modal queries 00900 for client documents and templates
2. **Agent Processing**: Content Analysis Agent processes and extracts information
3. **Draft Creation**: User edits and refines project brief content
4. **Validation**: Agent-assisted validation of completeness and compliance
5. **Approval Submission**: Documents routed to Project Manager for sign-off
6. **Final Storage**: Approved project brief stored with permanent 00900 links

## Approval Workflow Integration

### Project Manager Approval Process
1. **Notification**: Project Manager receives modal access link and notification
2. **Document Review**: Full access to project brief and all supporting documents
3. **Technical Validation**: Review of objectives, scope, budget, and timeline
4. **Comments & Revisions**: Feedback provided through modal interface
5. **Final Approval**: Digital sign-off with audit trail

### Approval Status Tracking
- **Submitted**: Project brief submitted, awaiting review
- **Under Review**: Project Manager actively reviewing
- **Approved**: Sign-off complete, workflow progresses to Phase 1 cards
- **Rejected**: Revisions required, card returns to "In Progress"
- **Re-submitted**: Revised brief submitted for re-approval

## Template System Integration

### Project Brief Templates
- **Standard Highway Project Brief**: Pre-configured sections and checklists
- **Bridge Construction Brief**: Specialized for bridge projects
- **Infrastructure Development Brief**: Comprehensive infrastructure template
- **Custom Template Creation**: Agent-assisted template generation

### Template Features
- **Auto-Population**: Templates pre-filled with project information
- **Validation Rules**: Built-in checklists and requirements validation
- **Compliance Checking**: Automatic regulatory compliance verification
- **Export Options**: Multiple formats (PDF, DOCX, collaborative editing)

## Performance & Scalability

### Modal Performance Optimization
- **Lazy Loading**: Agent interface loads on demand
- **Progressive Rendering**: Form sections load as needed
- **Background Processing**: Agent analysis runs without blocking UI
- **Memory Management**: Efficient handling of large document sets

### Agent Scalability
- **Load Balancing**: Content Analysis Agent distributed across resources
- **Priority Queuing**: Critical project briefs prioritized
- **Resource Monitoring**: Automatic scaling based on demand
- **Fallback Handling**: Manual entry available when agent unavailable

## Error Handling & Validation

### Form Validation
- **Required Fields**: Visual indicators for missing project information
- **Business Rules**: Budget vs scope consistency validation
- **Date Logic**: Start/end date validation and timeline feasibility
- **Document Requirements**: Mandatory document attachment checking

### Agent Error Handling
- **Processing Timeouts**: Automatic retry with exponential backoff
- **Data Quality Issues**: Validation prompts for unclear documents
- **Integration Failures**: Graceful fallback to manual entry
- **Recovery Mechanisms**: State preservation during error recovery

## Security & Compliance

### Data Security
- **End-to-End Encryption**: All project data encrypted during processing
- **Access Control**: Role-based permissions for project brief access
- **Audit Logging**: Complete record of all user and agent actions
- **Compliance Monitoring**: Regulatory compliance validation

### Client Data Protection
- **GDPR Compliance**: Client information handled according to privacy regulations
- **Data Retention**: Automatic cleanup of temporary project data
- **Access Logging**: Complete audit trail of client data access
- **Secure Storage**: Encrypted storage of all project documentation

## Mobile & Accessibility

### Responsive Modal Design
- **Touch Optimization**: Large touch targets for mobile project brief editing
- **Gesture Support**: Swipe navigation and pinch-to-zoom for documents
- **Progressive Disclosure**: Simplified views for smaller screens
- **Offline Capability**: Core project brief editing available offline

### Accessibility Compliance (WCAG 2.1 AA)
- **Keyboard Navigation**: Full keyboard accessibility for form navigation
- **Screen Reader Support**: ARIA labels and live regions for form fields
- **High Contrast**: Support for high contrast form display
- **Motion Preferences**: Respects reduced motion settings

## Implementation Architecture

### Modal Component Structure
```
CivilEngineeringModal/
├── ProjectBriefCard/
│   ├── CardHeader.jsx          # Status and modal controls
│   ├── AgentDashboard.jsx      # Content Analysis Agent status
│   ├── ProjectForm.jsx         # Main project information form
│   ├── DocumentPanel.jsx       # 00900 integration interface
│   ├── ApprovalQueue.jsx       # Sign-off workflow display
│   └── CardFooter.jsx          # Action buttons
```

### API Integration Points
```javascript
// Agent coordination
POST /api/workflows/{projectId}/cards/{cardId}/agents/assign
GET  /api/workflows/{projectId}/cards/{cardId}/agents/status
POST /api/workflows/{projectId}/cards/{cardId}/agents/analyze

// Document control
GET  /api/document-control/{projectId}/documents
POST /api/document-control/{projectId}/documents/upload
PUT  /api/document-control/{projectId}/documents/{docId}/version

// Project data
GET  /api/projects/{projectId}/brief
POST /api/projects/{projectId}/brief
PUT  /api/projects/{projectId}/brief

// Approval workflow
POST /api/approvals/{projectId}/cards/{cardId}/submit
GET  /api/approvals/{projectId}/pending
POST /api/approvals/{approvalId}/decide
```

## Testing & Validation

### Modal Functionality Testing
- **Button Actions**: All modal buttons function correctly
- **Agent Integration**: Content Analysis Agent processes documents properly
- **Form Validation**: All required fields validated appropriately
- **Document Flow**: 00900 integration complete and reliable
- **Approval Process**: Project Manager approval workflow functions

### Performance Testing
- **Load Times**: Modal opens within 2 seconds
- **Agent Response**: Content analysis completes within 5 minutes
- **Form Saving**: Auto-save works without data loss
- **Document Upload**: Large files upload within 10 minutes

### User Acceptance Testing
- **Project Creation**: Complete project brief creation workflow
- **Agent Assistance**: Content Analysis Agent provides useful insights
- **Document Management**: All documents properly managed
- **Approval Routing**: Project Manager approval process works
- **Template Usage**: Template system enhances productivity

## Success Metrics

### Functional Metrics
- **Modal Load Time**: <2 seconds average
- **Agent Processing Time**: <5 minutes for standard project briefs
- **Form Completion Rate**: >95% successful project brief creation
- **Approval Completion**: <24 hours average approval time

### Quality Metrics
- **Data Accuracy**: >98% accurate information extraction by agent
- **Template Usage**: >80% projects use recommended templates
- **Validation Success**: >95% project briefs pass initial validation
- **Approval Compliance**: 100% audit trail completeness

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
- v2.0 (2026-03-28): Complete modal workflow integration with Content Analysis Agent, 00900 document control, and Project Manager approval workflow