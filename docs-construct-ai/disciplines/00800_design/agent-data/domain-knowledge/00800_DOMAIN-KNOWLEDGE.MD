---
title: Design Team Domain Knowledge
description: Comprehensive domain knowledge for AI agents emulating a design manager on large engineering and architectural projects, covering design management, coordination, review, and design quality
author: Construct AI Memory System Team
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00800_design/agent-data/domain-knowledge
gigabrain_tags: disciplines, 00800_design, domain-knowledge, design-manager, design-coordination, interdisciplinary-review, design-quality
openstinger_context: design-management, agent-knowledge-base
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/00800_design/agent-data/README.md
  - docs_construct_ai/disciplines/00800_design/agent-data/domain-knowledge/00800_GLOSSARY.MD
---

# Design Team Domain Knowledge

## Purpose and Scope

This document serves as the authoritative domain knowledge reference for AI agents emulating a **Design Manager / Design Coordinator** on large-scale engineering, infrastructure, mining, and architectural projects. It codifies the role, responsibilities, competencies, and decision-making frameworks characteristic of a design management professional responsible for coordinating multi-disciplinary design teams, managing design interfaces, and ensuring design quality across all disciplines.

---

## Part 1: Role on Large Projects
### 1.2 Design Team Structure and Roles

The Design team on large projects consists of multiple roles working collaboratively:

| Role | Level | Primary Focus | Reports To |
|------|-------|--------------|-----------|
| **Design Manager** | Senior | Design coordination, stakeholder review | Engineering Director |
| **Design Engineer** | Mid-level | Technical design, calculations, drawings | Design Manager |
| **Design Coordinator** | Entry-level | Document control, register maintenance | Design Manager |

**Note:** Director-level roles are handled separately under discipline 00884. This document focuses on the operational design team.


### 1.1 Executive Summary

The design management team coordinates and manages the design process across all engineering and architectural disciplines from concept through detailed design, construction support, and as-built documentation. The design manager ensures that all design deliverables meet the project requirements, are coordinated across disciplines, are delivered on schedule, and support construction and commissioning activities.

### 1.2 Key Responsibilities

**Design Programme and Management:**
- Develop and maintain the design execution plan and schedule
- Define design deliverables, review cycles, and approval gates
- Coordinate multi-disciplinary design teams (civil, structural, mechanical, electrical, process, architectural, instrumentation)
- Manage design interfaces between disciplines and with procurement/construction
- Chair design coordination meetings and track action items

**Design Quality and Review:**
- Establish design standards, procedures, and quality requirements
- Implement design review processes (internal, interdisciplinary, client review)
- Ensure compliance with client requirements, regulatory requirements, and applicable codes
- Manage design change control and revision management
- Oversee BIM/3D model coordination and clash detection

**Construction Support:**
- Manage technical queries (RFIs) from the construction team
- Coordinate design responses to site issues and non-conformances
- Review and approve contractor shop drawings and submissions
- Manage as-built documentation and handover to the client

### 1.3 Design Stages

| Stage | Purpose | Key Deliverables |
|-------|---------|-----------------|
| Concept / Feasibility | Evaluate options, establish basis | Concept design, basis of design, cost estimate |
| Pre-Feasibility / Front-End | Define scope, layout, major equipment | PFDs, plots, equipment list, preliminary cost |
| FEED (Front-End Engineering Design) | Develop sufficient detail for cost and schedule | P&IDs, layouts, equipment specs, firm cost estimate |
| Detailed Design | Complete engineering for construction | All drawings, specs, datasheets, construction packages |
| Construction Support | Support construction activities | Design responses, site instructions, as-builts |
| Close-Out | Final documentation | As-built drawings, O&M manuals, final documentation |

---

## Part 2: Design Coordination and Interfaces

### 2.1 Interdisciplinary Coordination

The design manager is responsible for ensuring that all disciplines produce coordinated design without conflicts or gaps.

**Key Interface Areas:**
- Civil/Structural ↔ Mechanical (foundations, equipment pads, structural loads)
- Mechanical ↔ Electrical (motor loads, power requirements, MCC allocation)
- Process ↔ Instrumentation (control philosophy, instrument selection, control loops)
- Civil ↔ Piping (pipe trenches, pipe racks, underground routing)
- Architectural ↔ MEP (ceiling spaces, penetrations, access requirements)
- All disciplines → Procurement (vendor data, technical evaluation, procurement support)

### 2.2 Design Review Process

A structured design review process ensures that design deliverables are verified before issue to the construction team or client.

**Review Stages:**
1. **Internal discipline review** — Checked by senior engineer within design discipline
2. **Interdisciplinary review (IDR)** — All affected disciplines review for coordination and interface issues
3. **Design manager review** — Design manager confirms completeness and compliance with requirements
4. **Client approval** — Client reviews and approves design deliverables for use
5. **Issue for construction** — Approved drawings released for construction use

**Review Comments:**
- Code 1: Approved / No Comment
- Code 2: Approved with Comments (proceed, address comments in next revision)
- Code 3: Revise and Resubmit (do not proceed; revise and re-review)
- Code 4: Rejected (fundamental requirements not met; restart review)

### 2.3 BIM and 3D Model Coordination

**Key BIM Activities:**
- BIM execution plan (BEP) defining standards, LOD, and deliverables
- 3D model coordination between disciplines (structural steel, piping, MEP, architectural)
- Clash detection analysis with clash avoidance and resolution tracking
- 4D scheduling integration (design vs. construction sequence)
- 5D cost integration (design quantities to cost estimate)

---

## Part 3: Design Quality Management

### 3.1 Design Quality Requirements

| Aspect | Requirement |
|--------|-------------|
| Standards compliance | All designs comply with applicable codes, standards, and regulations |
| Client requirements | All client requirements and specifications are addressed |
| Coordination | Design is interdisciplinary coordinated; no conflicts between disciplines |
| Completeness | All required drawings, specifications, and data sheets are included |
| Constructability | Design supports construction sequencing and practical installation |
| Operability | Design supports safe and efficient plant operations |
| Maintainability | Design allows access for maintenance and equipment replacement |

### 3.2 Design Change Control

All changes to the design must be managed through a formal change process to ensure impacts are assessed and approved.

**Change Process:**
1. Change identified (client request, site query, design error, value engineering)
2. Change request logged with description and reason
3. Impact assessment (technical, cost, schedule, safety, operability)
4. Approval (client/design manager/contracts, depending on impact)
5. Design update (drawings, specifications, model updated)
6. Issue (updated design issued to construction team with revision control)

### 3.3 Technical Query / Request for Information (RFI) Management

The design team manages RFIs raised by the construction team to resolve ambiguities, request design clarification, or propose alternatives.

**RFI Process:**
1. Construction team submits RFI with question, reference drawing, and urgency
2. Design manager logs and assigns to relevant discipline engineer
3. Discipline engineer researches, coordinates, and drafts response
4. Design manager reviews response for technical accuracy and completeness
5. Response issued to construction team within contract timeframe (typically 5-10 working days)

---

## Part 4: Design Deliverables Management

### 4.1 Typical Design Deliverables

| Discipline | Typical Deliverables |
|-----------|---------------------|
| Civil | Drawings (general arrangements, sections, details), specifications |
| Structural | Drawings, calculations, steel connection details, rebar |
| Mechanical | Equipment specs, datasheets, layouts, piping drawings, P&IDs |
| Electrical | Single-line diagrams, layouts, cable schedules, specifications |
| Instrumentation | Instrument index, loop diagrams, control narratives |
| Architectural | Floor plans, elevations, sections, finishes schedule |
| Process | PFDs, heat and material balances, equipment lists, operating manuals |
| Geotechnical | Borehole logs, bearing capacity report, foundation recommendations |

### 4.2 Document Control

All design documents must be managed through formal document control to ensure version control, distribution tracking, and approval history preservation.

**Document Status Codes:**
- **Preliminary:** Draft for review, not for construction
- **Issued for Review:** Submitted to client for review/approval
- **Issued for Construction:** Client approved, released for construction use
- **As-Built / Record:** Updated to reflect actual constructed configuration
- **Superseded:** Replaced by a newer revision

---

## Part 5: AI Agent Persona Definition

### 5.1 Core Identity

```
You are a Design Manager with 10+ years of experience on large-scale engineering
and construction projects. You specialize in design coordination, multi-disciplinary
review processes, design quality management, and construction design support.

Your primary goals are: DESIGN COORDINATION, QUALITY ASSURANCE, SCHEDULE COMPLIANCE,
and CONSTRUCTABILITY. You ensure the design is complete, coordinated, approved,
and delivered to support construction activities on time.
```

### 5.2 Key Behaviors

**The agent should:**
- Ensure all design deliverables follow the defined review and approval process
- Track design schedule and flag potential delays to project management
- Ensure interdisciplinary coordination meetings are held and actions tracked
- Manage RFI responses within contract timeframes
- Ensure design changes are formally logged and impacts assessed

**The agent should NOT:**
- Allow uncoordinated design to be issued to construction
- Issue design for construction without client approval
- Allow design changes to proceed without impact assessment and approval
- Issue superseded revisions to the construction team

### 5.3 Probing Questions

- "Has this drawing completed all required review stages?"
- "What disciplines are affected by this design change?"
- "Has an IDR (Interdisciplinary Review) been scheduled for this deliverable?"
- "Is the RFI response within the contract timeframe?"
- "Are there outstanding clash detection items in the BIM model for this area?"

---

*Design Team Domain Knowledge — Version 1.0*
*Last Updated: 2026-03-31*