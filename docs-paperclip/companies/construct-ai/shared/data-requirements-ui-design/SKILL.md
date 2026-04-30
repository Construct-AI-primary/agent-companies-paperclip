---
title: Data Requirements & UI Design
description: Analyze AI-native use cases to determine data requirements, design UI components, and create structured data schemas that connect domain knowledge to automated workflows
version: 1.0
frequency_percent: 70.0
success_rate_percent: 90.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/skills/domainforge_ai/data-requirements-ui-design
gigabrain_tags: disciplines, data-requirements, UI-design, schema-design, workflow-data-mapping, ai-native-operations
openstinger_context: data-analysis, UI-architecture, workflow-design
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/codebase/procedures/workflow-management/0000_AI_NATIVE_DOMAIN_PROMPT_GENERATION_PROCEDURE.md
  - docs_construct_ai/skills/shared/pre-task-assessment-readiness/SKILL.md
  - docs_construct_ai/skills/shared/workflow-implementation/SKILL.md
related_skills:
  - pre-task-assessment-readiness
  - workflow-implementation
---

# Data Requirements & UI Design

## Overview

This skill guides agents to analyze AI-native use cases from domain knowledge, determine the data requirements for each automated workflow, and design UI components that surface the right data at the right time. It bridges domain knowledge (what the discipline does) with code generation (what the UI and data layer must support).

**Announce at start:** "I'm using the data-requirements-ui-design skill to map AI-native use cases to data requirements and UI components."

## When to Use This Skill

**Trigger Conditions:**
- New AI-native use case identified in domain knowledge Part 6B
- New workflow requires data modeling before code generation
- Existing workflow UI missing data sources or displaying incorrect data
- New discipline being onboarded and needs data schema design
- Audit trail requirements identified for a workflow

**Prerequisites:**
- Domain knowledge document exists with AI-Native Operations section (Part 6B)
- Automation spectrum defined for the discipline
- Workflow documentation available (or being created)

## Step-by-Step Procedure

### Step 1: Extract AI-Native Use Cases from Domain Knowledge

Read the domain knowledge Part 6B section and extract all AI-native use cases:

| Source Section | What to Extract |
|----------------|-----------------|
| Automation Spectrum | Each task by automation level (Full/Augment/Human-Led) |
| Document Generation Pipeline | Each document type with trigger, input, output |
| Multi-Agent Orchestration | Each agent handoff with data schema between agents |
| AI-Native Capabilities | Each capability (predictive, CV, NL, BIM) with data inputs |
| AI Safety Boundaries | Each non-delegable decision requiring UI gate |

**Output:** Use case inventory table with columns: Use Case, Automation Level, Data Inputs, Data Outputs, UI Component, Validation Rules, Human Review Point

### Step 2: Map Data Requirements per Use Case

For each use case, identify required data:

| Data Category | Questions to Answer |
|---------------|--------------------|
| **Source Systems** | What ERP tables, external APIs, file systems, or databases provide this data? |
| **Data Format** | Is it structured (JSON, database), semi-structured (CSV, XML), or unstructured (text, image, PDF)? |
| **Data Volume** | Single record, list, time series, file, or stream? |
| **Data Freshness** | Real-time, hourly, daily, or on-demand? |
| **Data Provenance** | What source tags must be carried through the pipeline? |
| **Data Sensitivity** | PII, health data, financial, regulatory — requires encryption or access control? |
| **Validation Rules** | Required fields, value ranges, cross-references, business rules? |
| **Missing Data Handling** | What happens when required data is unavailable? Must block, warn, or default? |

**Output:** Data requirements matrix per use case

### Step 3: Design Data Schema

Create structured data schemas for all inputs and outputs:

```json
{
  "use_case": "permit-to-work-generation",
  "input_schema": {
    "work_request": { "type": "object", "required": ["work_type", "location", "contractor_id", "start_date", "end_date"] },
    "RAMS_approval": { "type": "object", "required": ["RAMS_id", "approved_by", "approved_at", "control_measures[]"] },
    "training_verification": { "type": "array", "items": { "worker_id": "string", "certifications[]": "string" } }
  },
  "output_schema": {
    "permit_document": { "type": "object", "required": ["permit_id", "work_type", "location", "conditions[]", "expiry_date", "authorised_person"] },
    "audit_log": { "type": "array", "items": { "action": "string", "actor": "string", "timestamp": "ISO8601", "data_changed": "object" } }
  },
  "validation_rules": [
    "RAMS_approval.approved_at must be before permit start_date",
    "All workers in work_request must have valid certifications for work_type",
    "Permit expiry_date must not exceed 7 days from start_date"
  ]
}
```

### Step 4: Design UI Components

For each use case, design the UI components needed:

| UI Element | Data Source | Validation | User Action |
|-----------|-------------|------------|------------|
| **Form** | Input schema fields | Required field markers, range validation, dropdown from lookup tables | Submit, save draft, cancel |
| **Dashboard** | Output schema aggregations | Data freshness indicator, empty state handling | Filter, drill down, export |
| **Status Indicator** | Workflow state machine | Current state validation, next action availability | Transition, escalate |
| **Alert/Notification** | Threshold triggers from rules | Severity classification, suppression rules | Acknowledge, escalate, dismiss |
| **Review Gate** | Non-delegable decision point | Human identity confirmation, reason capture required | Approve, reject (with reason) |

**Output:** UI component specification mapped to data schema

### Step 5: Connect to AI-Native Architecture

Map each UI component to the AI-Native architecture layer:

| Architecture Layer | UI Component Pattern |
|-------------------|---------------------|
| **Full Automation** | Status indicator + audit log viewer (no user action needed) |
| **Augment AI + Human** | Form with AI draft → human review/edit → submit |
| **Human-Led, AI-Informed** | AI recommendation card + human decision form |
| **Human-Led Only** | Form with validation only, no AI involvement |

### Step 6: Validate Against Safety Boundaries

For each use case, verify safety boundaries are enforced:

| Safety Check | Verification |
|-------------|-------------|
| Non-delegable decisions have human review gates | Confirm UI requires human action before proceeding |
| AI uncertainty is disclosed | Confirm UI shows uncertainty indicators |
| Immutable audit trail is generated | Confirm all user + AI actions are logged |
| Data provenance is tracked | Confirm all displayed values carry source tags |
| Access control is enforced | Confirm role-based visibility for sensitive data |

### Step 7: Generate Implementation Spec

Produce a complete data + UI implementation specification:

```
USE CASE: [Name]
AUTOMATION LEVEL: [Full/Augment/Human-Led]

DATA INPUTS:
- [Source system] → [Field names] → [Validation rules]

DATA OUTPUTS:
- [Target system] → [Field names] → [Provenance tags]

UI COMPONENTS:
- [Component type]: [Purpose] → [Data binding] → [User actions]

SAFETY GATES:
- [Non-delegable decision] → [Human review UI] → [Audit logging]

IMPLEMENTATION PRIORITY: [High/Medium/Low]
DEPENDENCIES: [Data source availability, API endpoints, external services]
```

## Success Criteria

- [ ] All AI-native use cases extracted from domain knowledge Part 6B
- [ ] Data requirements mapped for each use case (source, format, volume, freshness)
- [ ] Data schemas defined for all inputs and outputs
- [ ] UI components designed for each use case with data bindings
- [ ] Automation spectrum reflected in UI patterns (Full = status, Augment = draft + review, Human-Led = form)
- [ ] Safety boundaries enforced in UI design (human review gates, audit logging)
- [ ] Implementation spec generated with priority, dependencies, and validation rules

## Common Pitfalls

1. **Designing UI Without Data Sources** — Every UI field must map to a data source. Never design empty forms assuming data will appear later.
2. **Missing Provenance in UI** — Data displayed without source tags cannot be audited. Every value shown should carry its origin.
3. **Ignoring Automation Spectrum in UI** — Full automation tasks need status indicators, not forms. Human-led tasks need decision forms, not dashboards.
4. **Skipping Safety Gates** — Non-delegable decisions must have explicit human review UI, not auto-approvals with audit-only logging.
5. **Over-Collecting Data** — Only request data that is actually used. Extra fields create maintenance burden and privacy risk.

## Cross-References

### Related Skills
- `workflow-implementation` — Uses data schemas to build workflow logic
- `procurement-data-extraction` — Source data for procurement use cases
- `pre-task-assessment-readiness` — Assess readiness before starting design

### Related Agents
- Workflow implementation agents in each discipline
- UI/UX designers for component implementation
- Data architects for schema validation

## Example Usage

**Scenario:** Design data requirements and UI for Safety Permit-to-Work automation

1. **Extract Use Cases:** From 02400_DOMAIN-KNOWLEDGE.MD Part 6B → permit-to-work is Fully Automatable with human review
2. **Map Data:** Input (work request, RAMS approval, training verification) → Output (permit document, audit log)
3. **Design Schema:** JSON schemas with required fields, validation rules, provenance tags
4. **Design UI:** Permit form with auto-populated fields from RAMS, checklist for prerequisites, authorised person sign-off gate
5. **Connect Architecture:** Full automation = permit generation from approved RAMS → status indicator → human sign-off gate
6. **Validate Safety:** Sign-off is non-delegable → UI requires authorised person ID + reason capture → audit log entry generated
7. **Generate Spec:** Complete data + UI implementation specification for coding agent

## Performance Metrics

**Target Performance:**
- Use case extraction completeness: 100% of Part 6B use cases mapped
- Data schema coverage: All inputs and outputs defined with required fields
- UI component alignment: Each use case has at least one UI component designed
- Safety gate enforcement: 100% of non-delegable decisions have human review UI
- Implementation spec quality: Ready for coding agent to implement without clarification