---
memory_layer: durable_knowledge
para_section: pages/disciplines
gigabrain_tags: disciplines, documentation
documentation
openstinger_context: discipline-knowledge
last_updated: 2026-03-30
related_docs:
  - disciplines/
---

t---
title: Preliminary Layout Card Modal Specification
author: Construct AI Memory System Team
date: 2026-03-28
version: 2.0
memory_layer: durable_knowledge
para_section: disciplines/00850_civil-engineering/workflow_docs
gigabrain_tags: disciplines, 00850_civil-engineering, modal-cards, agent-integration, cad-gis-analysis, document-control, approval-workflow
openstinger_context: modal-card-specification, agent-coordination, document-management, approval-system
last_updated: 2026-03-28
related_docs:
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_UI_CARDS_IMPLEMENTATION_SUMMARY.md
  - disciplines/00850_civil-engineering/workflow_docs/00850_CIVIL_ENGINEERING_MODAL_REDESIGN_SPECIFICATION.md
---

# 00850_0_PRELIMINARY_LAYOUT_CARD_UI_SPEC.md - Preliminary Layout Card Modal Specification

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
- **Card Type**: Preliminary Layout (Phase 2, Card 6)
- **Modal Button Actions**: 👁️ View • 👤 Assign • ✅ Complete • 📥 Download • 📤 Submit
- **Agent Assignment**: CAD Agent + GIS Agent + Analysis Agent
- **Input Documents**: Selected Option, Alignment Data, Mass Balance Req (from 00900 Doc Control)
- **Output Documents**: Layout Drawings
- **Approval Workflow**: Senior Engineer Sign-off → 00900 Doc Control

### Modal Integration
This card operates within the Civil Engineering Workflow Modal System, providing seamless integration with:
- **13 Interactive Cards**: Full workflow navigation and dependencies
- **Agent Coordination**: Real-time multi-agent collaboration
- **Document Control**: 00900 system integration for all inputs/outputs
- **Approval Workflows**: Multi-level sign-off with specific approvers
- **Progress Tracking**: Real-time status updates and completion metrics

## Modal Card Structure

### Card Header (Modal Context)
```
┌─────────────────────────────────────────────────────────────────┐
│ 📐 PRELIMINARY LAYOUT CARD - Phase 2 of 5                      │
│ Status: 🔄 In Progress | Progress: ████████░░░░░░ 40%          │
│ Agent: CAD + GIS + Analysis | Due: [Auto-calculated]           │
│ Modal Controls: [Filter] [Progress] [Actions] [Close]          │
└─────────────────────────────────────────────────────────────────┘
```

### Main Content Area (Modal Body)

#### Section 1: Agent Status Dashboard
```
┌─ Agent Coordination Status ────────────────────────────────────┐
│                                                               │
│ 🤖 CAD Agent: [🟢 Active]                                      │
│    Task: 2D/3D Model Generation                              │
│    Progress: ████████░░░░░░ 80% | ETA: 2 min                 │
│    [📊 View Details] [🔄 Refresh] [⚙️ Configure]              │
│                                                               │
│ 🗺️ GIS Agent: [🟡 Processing]                                  │
│    Task: Alignment Optimization                               │
│    Progress: ██████░░░░░░░░ 60% | ETA: 3 min                 │
│    [📊 View Details] [🔄 Refresh] [⚙️ Configure]              │
│                                                               │
│ 📊 Analysis Agent: [🟢 Active]                                 │
│    Task: Mass Balance Calculation                             │
│    Progress: ██████████░░ 90% | ETA: 1 min                   │
│    [📊 View Details] [🔄 Refresh] [⚙️ Configure]              │
│                                                               │
│ 🔄 Overall Coordination: Optimizing design parameters...     │
└───────────────────────────────────────────────────────────────┘
```

#### Section 2: Design Canvas (Modal Viewport)
```
┌─ Interactive Design Workspace ────────────────────────────────┐
│                                                               │
│ [Modal-Optimized Canvas - 1000x600px]                        │
│ ┌─────────────────┬─────────────────┬─────────────────┐       │
│ │   2D Plan View  │  3D Model View  │  Profile View    │       │
│ │                 │                 │                 │       │
│ │ [CAD Rendering] │ [3D Rendering]  │ [Profile Graph] │       │
│ │                 │                 │                 │       │
│ │ Modal Controls: │ Modal Controls: │ Modal Controls: │       │
│ │ [Zoom][Pan]     │ [Orbit][Zoom]    │ [Scale][Pan]    │       │
│ │ [Measure][Grid] │ [Views][Layers]  │ [Measure][Grid] │       │
│ └─────────────────┴─────────────────┴─────────────────┘       │
│                                                               │
│ [Real-time Agent Feed]                                        │
│ ⏰ CAD: "Cross-sections updated for new alignment"            │
│ ⏰ GIS: "Environmental constraints applied"                   │
│ ⏰ Analysis: "Mass balance: Cut 15,000 m³, Fill 12,000 m³"    │
│                                                               │
│ [Agent Collaboration Panel]                                   │
│ 👤 Senior Engineer (You) | 🤖 CAD Agent | 🗺️ GIS Agent | 📊 Analysis Agent │
└───────────────────────────────────────────────────────────────┘
```

#### Section 3: Document Control Integration
```
┌─ 00900 Document Control Integration ──────────────────────────┐
│                                                               │
│ 📥 Input Documents:                                           │
│    • Selected Option (from Design Options card)               │
│    • Alignment Data (from GIS Agent processing)               │
│    • Mass Balance Requirements (from project specs)           │
│                                                               │
│ 📤 Output Documents:                                          │
│    • Layout Drawings (Auto-saved to 00900)                   │
│    • Design Calculations (Generated by Analysis Agent)       │
│    • Technical Memorandums (Agent-generated)                 │
│                                                               │
│ 🔗 Document References:                                       │
│    [View in 00900] [Download All] [Version History]          │
└───────────────────────────────────────────────────────────────┘
```

### Modal Footer Actions
```
┌─────────────────────────────────────────────────────────────────┐
│ [👁️ View Details] [👤 Assign Agents] [✅ Complete & Submit] [📥 Download] [💾 Save Progress] │
│ [❌ Cancel] [🔄 Reset] [📤 Export] [❓ Help] [✖️ Close Modal] │
└─────────────────────────────────────────────────────────────────┘
```

## Modal Button Functionality

### 👁️ View Button (Primary Action)
**Function**: Open detailed card interface with full agent collaboration
**Modal Behavior**:
- Expands to full modal view with all sections visible
- Loads agent status and initializes real-time updates
- Retrieves documents from 00900 Doc Control
- Displays current progress and next steps
- Enables full interaction with design canvas

### 👤 Assign Button (Agent Assignment)
**Function**: Assign or reassign agents to this card
**Modal Behavior**:
- Opens agent selection interface
- Shows available agents and their current workload
- Allows manual override of automatic assignments
- Confirms agent assignments with capacity checks
- Updates modal header with assigned agents

### ✅ Complete Button (Workflow Progression)
**Function**: Mark card as completed and trigger approval workflow
**Modal Behavior**:
- Validates all required outputs are generated
- Submits work to approval workflow (Senior Engineer)
- Updates card status to "Under Review"
- Notifies approver through system
- Unlocks dependent cards in workflow

### 📥 Download Button (Template Access)
**Function**: Download templates and current outputs
**Modal Behavior**:
- Downloads layout drawing templates
- Exports current design data
- Provides calculation spreadsheets
- Generates technical memorandums
- All files sourced from 00900 template library

### 📤 Submit Button (Approval Submission)
**Function**: Submit completed work for formal approval
**Modal Behavior**:
- Packages all outputs for approval
- Uploads to 00900 with approval metadata
- Routes to Senior Engineer approval queue
- Creates audit trail for submission
- Updates workflow progress tracking

## Agent Integration Architecture

### Multi-Agent Coordination
The Preliminary Layout Card demonstrates advanced multi-agent coordination:

#### CAD Agent Responsibilities
- **2D/3D Model Generation**: Creates detailed design models
- **Cross-Section Development**: Generates road/pipe cross-sections
- **Visualization**: Provides real-time 3D rendering
- **Standards Compliance**: Ensures CAD standards are met

#### GIS Agent Responsibilities
- **Spatial Analysis**: Terrain and constraint analysis
- **Alignment Optimization**: Route optimization algorithms
- **Environmental Integration**: Protected area overlays
- **Coordinate Systems**: Datum and projection management

#### Analysis Agent Responsibilities
- **Mass Balance Calculations**: Cut/fill volume analysis
- **Hydraulic Analysis**: Preliminary drainage design
- **Structural Checks**: Basic stability assessments
- **Cost Estimation**: Preliminary quantity analysis

### Real-Time Agent Communication
```
┌─ Agent Communication Feed ────────────────────────────────────┐
│ ⏰ 14:32 CAD: "Model topology updated successfully"          │
│ ⏰ 14:33 GIS: "Alignment optimized for 2.5% max grade"       │
│ ⏰ 14:35 Analysis: "Mass balance calculated: Net cut 3,000m³"│
│ ⏰ 14:36 CAD: "Cross-sections generated for 12 stations"     │
│ ⏰ 14:37 System: "All agents synchronized - design complete" │
└───────────────────────────────────────────────────────────────┘
```

## Document Control Integration

### 00900 System Integration
- **Automatic Retrieval**: Modal loads required input documents on open
- **Real-time Sync**: Document changes reflected immediately in modal
- **Version Control**: All outputs saved with version tracking
- **Approval Routing**: Documents automatically routed through approval
- **Audit Trail**: Complete history of all document interactions

### Document Workflow
1. **Input Loading**: Modal queries 00900 for required documents
2. **Agent Processing**: Agents access documents through secure APIs
3. **Output Generation**: Results automatically saved to 00900
4. **Approval Submission**: Documents routed to approver inboxes
5. **Final Storage**: Approved documents stored with permanent links

## Approval Workflow Integration

### Senior Engineer Approval Process
1. **Notification**: Approver receives modal access link and notification
2. **Document Review**: Full access to all generated outputs in 00900
3. **Technical Validation**: Engineering review of calculations and drawings
4. **Comments & Revisions**: Feedback provided through modal interface
5. **Final Approval**: Digital sign-off with audit trail

### Approval Status Tracking
- **Submitted**: Work submitted, awaiting review
- **Under Review**: Approver actively reviewing
- **Approved**: Sign-off complete, workflow progresses
- **Rejected**: Revisions required, card returns to "In Progress"
- **Re-submitted**: Revised work submitted for re-approval

## Performance & Scalability

### Modal Performance Optimization
- **Lazy Loading**: Agent interfaces load on demand
- **Progressive Rendering**: Design canvas renders progressively
- **Background Processing**: Agent tasks run without blocking UI
- **Memory Management**: Automatic cleanup of large datasets

### Agent Scalability
- **Load Balancing**: Agents distributed across available resources
- **Priority Queuing**: Critical tasks prioritized over background work
- **Resource Monitoring**: Automatic scaling based on demand
- **Fallback Handling**: Graceful degradation when agents unavailable

## Error Handling & Recovery

### Agent Failure Scenarios
- **Connection Timeout**: Automatic retry with exponential backoff
- **Data Errors**: Validation and correction prompts
- **Resource Exhaustion**: Queue management and load shedding
- **Coordination Conflicts**: Conflict resolution and merge strategies

### Recovery Mechanisms
- **State Preservation**: All work saved during failures
- **Partial Results**: Continue with available agent outputs
- **Manual Override**: User can intervene in agent processes
- **Rollback Capability**: Return to previous stable state

## Security & Compliance

### Data Security
- **End-to-End Encryption**: All agent communications encrypted
- **Access Control**: Role-based permissions for modal features
- **Audit Logging**: Complete record of all user and agent actions
- **Compliance Monitoring**: Regulatory compliance validation

### Agent Security
- **Secure APIs**: Token-based authentication for agent services
- **Data Sanitization**: Input validation and sanitization
- **Isolated Processing**: Agents run in secure, isolated environments
- **Monitoring**: Real-time security monitoring and alerting

## Mobile & Accessibility

### Responsive Modal Design
- **Touch Optimization**: Large touch targets for mobile interaction
- **Gesture Support**: Swipe navigation and pinch-to-zoom
- **Progressive Disclosure**: Simplified views for smaller screens
- **Offline Capability**: Core functionality available offline

### Accessibility Compliance (WCAG 2.1 AA)
- **Keyboard Navigation**: Full keyboard accessibility
- **Screen Reader Support**: ARIA labels and live regions
- **High Contrast**: Support for high contrast themes
- **Motion Preferences**: Respects reduced motion settings

## Implementation Architecture

### Modal Component Structure
```
CivilEngineeringModal/
├── PreliminaryLayoutCard/
│   ├── CardHeader.jsx          # Status and modal controls
│   ├── AgentDashboard.jsx      # Real-time agent status
│   ├── DesignCanvas.jsx        # Interactive 3D/2D views
│   ├── DocumentPanel.jsx       # 00900 integration
│   ├── ApprovalQueue.jsx       # Sign-off workflow
│   └── CardFooter.jsx          # Action buttons
```

### API Integration Points
```javascript
// Agent coordination
POST /api/workflows/{projectId}/cards/{cardId}/agents/assign
GET  /api/workflows/{projectId}/cards/{cardId}/agents/status
POST /api/workflows/{projectId}/cards/{cardId}/agents/coordinate

// Document control
GET  /api/document-control/{projectId}/documents
POST /api/document-control/{projectId}/documents/upload
PUT  /api/document-control/{projectId}/documents/{docId}/version

// Approval workflow
POST /api/approvals/{projectId}/cards/{cardId}/submit
GET  /api/approvals/{projectId}/pending
POST /api/approvals/{approvalId}/decide
```

## Testing & Validation

### Modal Functionality Testing
- **Button Actions**: All modal buttons function correctly
- **Agent Integration**: Multi-agent coordination works seamlessly
- **Document Flow**: 00900 integration complete and reliable
- **Approval Process**: Sign-off workflow functions end-to-end
- **State Management**: Modal state persists correctly

### Performance Testing
- **Load Times**: Modal opens within 2 seconds
- **Agent Response**: Real-time updates within 500ms
- **Large Datasets**: Handles 100MB+ design files smoothly
- **Concurrent Users**: Supports 50+ simultaneous users

### User Acceptance Testing
- **Workflow Completion**: Full 13-card workflow executable
- **Agent Collaboration**: Multi-agent tasks complete successfully
- **Document Management**: All documents properly managed
- **Approval Routing**: Sign-off process works for all approvers

## Success Metrics

### Functional Metrics
- **Modal Load Time**: <2 seconds average
- **Agent Response Time**: <5 seconds for complex operations
- **Document Sync**: Real-time 00900 integration
- **Approval Completion**: <24 hours average approval time

### Quality Metrics
- **Error Rate**: <1% user-reported errors
- **Agent Success Rate**: >95% successful agent operations
- **Document Accuracy**: 100% 00900 integration accuracy
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
- v2.0 (2026-03-28): Complete modal workflow integration with agent coordination, document control, and approval workflows