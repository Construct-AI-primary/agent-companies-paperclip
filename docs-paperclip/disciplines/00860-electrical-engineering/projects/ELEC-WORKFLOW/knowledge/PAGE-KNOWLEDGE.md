---
title: ELEC-WORKFLOW Project Knowledge — 00860 Electrical Engineering Page Architecture
description: Complete page architecture, component inventory, database schema, API patterns, and agent ownership for the 00860 Electrical Engineering discipline page
author: KnowledgeForge AI / DomainForge AI
version: 2.0
memory_layer: durable_knowledge
para_section: docs_paperclip/disciplines/00860-electrical-engineering/projects/ELEC-WORKFLOW
gigabrain_tags: electrical-engineering, page-architecture, component-inventory, workflow-knowledge
last_updated: 2026-04-28
---

# ELEC-WORKFLOW Project Knowledge — 00860 Electrical Engineering Page Architecture

## Page Architecture

### Page Identification

| Property | Value |
|----------|-------|
| Page ID | `00860-electrical-engineering` |
| Discipline | 00860 Electrical Engineering |
| Accordion Section | Engineering (display_order: 860) |
| Route | `/electrical-engineering` |
| Template Type | Template B (Complex / Three-State) |
| UI/UX Spec | `docs-paperclip/disciplines/00860-electrical-engineering/UI-UX-SPECIFICATION.md` |

### Three-State Navigation

| State | Purpose | Key Components |
|-------|---------|----------------|
| Agents | Electrical engineering AI agents | Agent cards, skill toggles, configuration |
| Upserts | Workflow record creation/import | Workflow forms, import, edit, delete |
| Workspace | Engineering calculations, HITL review | Load flow, short circuit, arc flash, coordination, cable sizing, ground grid, voltage drop, HITL queue |

## Component Inventory

### Desktop Components

| Component | File Location | Purpose | CSS Class Prefix | Issue Ref |
|-----------|--------------|---------|-----------------|-----------|
| StateButtons | Page template | Three-state navigation | `.A-00860-state-btn` | ELEC-001 |
| NavContainer | Page template | Bottom-fixed nav | `.A-00860-nav-container` | ELEC-001 |
| LoginForm | Auth | Authentication | `.A-00860-login` | ELEC-001 |
| LogoutButton | Auth | Session termination | `.A-00860-logout` | ELEC-001 |
| WorkflowSelector | Form | Workflow type selection | `.A-00860-workflow-selector` | ELEC-001 |
| LoadCalcPanel | Calculation | Load flow analysis | `.A-00860-load-calc` | ELEC-001 |
| ShortCircuitPanel | Calculation | Fault analysis | `.A-00860-short-circuit` | ELEC-001 |
| ArcFlashPanel | Calculation | Arc flash study | `.A-00860-arc-flash` | ELEC-001 |
| CoordinationPanel | Calculation | Protection coordination | `.A-00860-coordination` | ELEC-005 |
| CableSizingPanel | Calculation | Cable sizing calc | `.A-00860-cable-sizing` | ELEC-006 |
| GroundGridPanel | Calculation | Ground grid design | `.A-00860-ground-grid` | ELEC-005 |
| VoltageDropPanel | Calculation | Voltage drop calc | `.A-00860-voltage-drop` | ELEC-006 |
| StandardsSelector | Form | Standards reference | `.A-00860-standards-selector` | ELEC-001 |
| ConfirmationModal | Modal | Destructive actions | `.A-00860-confirmation-modal` | All |
| ApprovalModal | Modal | Approve workflow | `.A-00860-approval-modal` | All |

### Modal Inventory

| Modal | State | Purpose | Width |
|-------|-------|---------|-------|
| CreateNewAgent | Agents | Create electrical engineering agent | 98vw |
| AgentConfig | Agents | Configure agent settings | 98vw |
| CreateRecord | Upserts | New workflow record | 98vw |
| Import | Upserts | Bulk import CSV/Excel | 98vw |
| EditRecord | Upserts | Edit existing record | 98vw |
| LoadFlow | Workspace | Load flow analysis | 98vw |
| ShortCircuit | Workspace | Short circuit study | 98vw |
| ArcFlash | Workspace | Arc flash hazard analysis | 98vw |
| Coordination | Workspace | Protection coordination | 98vw |
| CableSizing | Workspace | Cable sizing calculation | 98vw |
| GroundGrid | Workspace | Ground grid design | 98vw |
| VoltageDrop | Workspace | Voltage drop calculation | 98vw |
| Approval | Workspace | Approve AI calculation | 98vw |
| Rejection | Workspace | Reject with feedback | 98vw |
| Export | Workspace | Export report | 98vw |

## Database Schema

### Supabase Tables

| Table | Description | Primary Agent | Issue Ref |
|-------|-------------|---------------|-----------|
| `electrical_distribution` | Power distribution load schedules, panel schedules | electrical-domainforge | ELEC-001 |
| `traffic_signals` | Traffic signal phasing, timing, controller config | electrical-domainforge | ELEC-002 |
| `hv_transmission` | High voltage transmission line data, tower specs | electrical-domainforge | ELEC-003 |
| `generators` | Generator and power plant data | electrical-domainforge | ELEC-004 |
| `substations` | Substation design data, bus configurations | electrical-domainforge | ELEC-005 |
| `cable_reticulation` | Cable selection, ampacity, voltage drop | electrical-domainforge | ELEC-006 |
| `electrical_maintenance` | Maintenance schedules, thermography data | electrical-domainforge | ELEC-007 |
| `electrical_commissioning` | Commissioning test plans, results | electrical-domainforge | ELEC-008 |

### Table Schema Pattern

All tables follow the Paperclip standard pattern:

```sql
CREATE TABLE electrical_distribution (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID NOT NULL REFERENCES companies(id),
    project_id UUID NOT NULL REFERENCES projects(id),
    -- Workflow-specific fields
    name TEXT NOT NULL,
    description TEXT,
    -- Standards compliance
    standard_refs JSONB DEFAULT '[]',
    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_elec_dist_company ON electrical_distribution(company_id);
CREATE INDEX idx_elec_dist_project ON electrical_distribution(project_id);
```

All tables are scoped by `company_id` with appropriate indexes.

## API Endpoint Patterns

| Endpoint | Method | Purpose | Company Scoped |
|----------|--------|---------|---------------|
| `/api/companies/:companyId/electrical/distribution` | GET/POST | Power distribution CRUD | Yes |
| `/api/companies/:companyId/electrical/traffic-signals` | GET/POST | Traffic signals CRUD | Yes |
| `/api/companies/:companyId/electrical/transmission` | GET/POST | HV transmission CRUD | Yes |
| `/api/companies/:companyId/electrical/generators` | GET/POST | Generator CRUD | Yes |
| `/api/companies/:companyId/electrical/substations` | GET/POST | Substation CRUD | Yes |
| `/api/companies/:companyId/electrical/cables` | GET/POST | Cable CRUD | Yes |
| `/api/companies/:companyId/electrical/maintenance` | GET/POST | Maintenance CRUD | Yes |
| `/api/companies/:companyId/electrical/commissioning` | GET/POST | Commissioning CRUD | Yes |

## CSS Architecture

### Import Chain

```css
/* 1. Template A Standard */
@import "../../templates/template-a-standard.css";

/* 2. Page-Specific Electrical Engineering Styles */
@import "00860-electrical-engineering-page-style.css";
```

**File**: `client/src/common/css/pages/00860-electrical-engineering/00860-electrical-engineering-page-style.css`

### Color Variables

```css
:root {
  --elec-primary: #1565C0;
  --elec-secondary: #1E88E5;
  --elec-accent: #FFB300;
  --elec-warning: #FF6F00;
  --elec-danger: #D32F2F;
  --elec-success: #2E7D32;
  --elec-bg: #E3F2FD;
  --elec-card-border: #90CAF9;
}
```

### CSS Class Convention

All page-level elements use the `A-00860-*` prefix convention.

## Workflow Knowledge Map

| Issue | Workflow | Key Standards | Primary Software |
|-------|----------|---------------|------------------|
| ELEC-001 | Electrical Power Distribution | NEC (NFPA 70), NESC | SKM PowerTools, ETAP |
| ELEC-002 | Traffic Signals and ITS | MUTCD, NEMA TS2 | Trafficware, Econolite |
| ELEC-003 | High Voltage Transmission | NESC, NERC | PLS-CADD, PLS-TOWER |
| ELEC-004 | Generator and Power Plant | NFPA 110, NEC 700/701/702 | SKM, ETAP |
| ELEC-005 | Substation Design | IEEE C37, NESC | ETAP, EasyPower |
| ELEC-006 | Cable Selection and Reticulation | NEC, ICEA, NEMA | SKM, ETAP |
| ELEC-007 | Electrical Maintenance | NETA MTS, NFPA 70E | CMMS, Thermography |
| ELEC-008 | Electrical Commissioning | IEEE C57, NFPA 70E | Hi-pot, relay test sets |

## Cross-Discipline Dependencies

| Issue | Civil (00850) | Structural (00872) | Mechanical (00870) | Construction (00300) | HSE (01100) |
|-------|---------------|-------------------|--------------------|---------------------|-------------|
| ELEC-001 | C | I | I | C | C |
| ELEC-002 | C | I | I | C | C |
| ELEC-003 | C | C | I | C | C |
| ELEC-004 | I | C | C | C | C |
| ELEC-005 | C | C | C | C | C |
| ELEC-006 | C | I | I | C | I |
| ELEC-007 | I | I | I | I | C |
| ELEC-008 | I | I | C | C | C |

### Key Cross-Discipline Handoffs

- **Civil (00850)**: Underground duct bank design (ELEC-006), structure foundations for transmission towers (ELEC-003), substation foundations (ELEC-005)
- **Structural (00872)**: Structural analysis for transmission tower foundations (ELEC-003), substation bus supports (ELEC-005)
- **Mechanical (00870)**: Generator mechanical systems (ELEC-004), HVAC coordination for substations (ELEC-005), commissioning mechanical checks (ELEC-008)
- **Construction (00300)**: Installation sequences for power distribution (ELEC-001), transmission lines (ELEC-003), substations (ELEC-005)
- **HSE (01100)**: Arc flash safety for maintenance (ELEC-007) and commissioning (ELEC-008), LOTO procedures

## Agent Ownership

| Company | Agent | Role | Issues |
|---------|-------|------|--------|
| **DomainForge AI** | electrical-domainforge | Workflow execution lead | All 8 ELEC issues |
| **DomainForge AI** | domainforge-ai-architectural-integration | Cross-discipline coordination | ELEC-003, ELEC-005 |
| **DevForge AI** | devforge-ai-ui-implementation | UI component implementation | All 8 ELEC issues |
| **InfraForge AI** | infraforge-ai-integration-specialist | Database/API implementation | All 8 ELEC issues |
| **QualityForge AI** | guardian-qualityforge | Workflow validation, compliance testing | All 8 ELEC issues |
| **KnowledgeForge AI** | knowledge-manager | Metadata extraction, standards reference | All 8 ELEC issues |

## Knowledge Sources

| Source | Location | Description |
|--------|----------|-------------|
| Discipline Knowledge | `../../knowledge/PAGE-KNOWLEDGE.md` | Comprehensive electrical engineering domain knowledge (discipline-level) |
| Implementation Plan | `../ELEC-WORKFLOW-implementation.md` | Phase mapping and skills matrix |
| UI/UX Specification | `../../UI-UX-SPECIFICATION.md` | Complete UI/UX spec for 00860 Electrical Engineering |
| Cross-Company RACI | `../knowledge/CROSS-COMPANY-RACI.md` | RACI matrix for all 8 workflow issues |
| Agent Delegation Map | `../knowledge/AGENT-DELEGATION-MAP.md` | Agent hierarchy and delegation flow |
| Metadata Bundle | `../knowledge/METADATA-BUNDLE.md` | JSON metadata bundle for QC upload |
| Heartbeat Config | `../knowledge/HEARTBEAT-MONITORING-CONFIG.md` | Agent heartbeat monitoring configuration |
| Geotechnical Reference | `docs-construct-ai/disciplines/00855_geotechnical-engineering/` | Foundation/grounding reference for ELEC-003, ELEC-005 |

## Platform Adaptations

| Resolution | Navigation | Grid Layout | Touch Targets |
|------------|-----------|-------------|---------------|
| Desktop (1280px+) | Full three-state visible | 3-column calc panels | Standard |
| Tablet (768-1279px) | Collapsible dropdown | 2-column calc panels | Standard |
| Mobile (<768px) | Bottom tab bar | 1-column full width | 48dp minimum |

## QC Checklist

### Pre-Execution
- [ ] All 8 ELEC issues created in Paperclip with correct assigneeAgentId
- [ ] Knowledge bundle uploaded to EE-ROOT-ELEC-WORKFLOW-2026 issue
- [ ] UI/UX specification finalized
- [ ] CSS architecture defined with A-00860-* prefix convention

### Per-Issue Validation
- [ ] Workflow form renders all required input fields
- [ ] Standards compliance checks functional
- [ ] API endpoints respond correctly for CRUD operations
- [ ] Cross-discipline handoff points documented
- [ ] Calculation outputs validated against known test cases

### Post-Execution
- [ ] All 8 issues completed with status = done
- [ ] Knowledge documents uploaded to DB
- [ ] Agent heartbeat configured and verified
- [ ] RACI assignments confirmed in Paperclip

---

> **Note**: This file was enhanced from v1.0 (2026-04-17) to v2.0 (2026-04-28) to align with the SAFETY-CONTRACTOR PAGE-KNOWLEDGE standard (372 lines).

**Version**: 2.0
**Last Updated**: 2026-04-28
**Author**: KnowledgeForge AI