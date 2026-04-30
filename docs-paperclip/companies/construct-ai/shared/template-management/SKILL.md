---
title: Template Management & Configuration
description: Manage procurement templates including template creation, complexity specification, version control, and migration for unified template architecture
version: 1.0
frequency_percent: 65.0
success_rate_percent: 85.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/skills/domainforge_ai/template-management
gigabrain_tags: disciplines, 01900_procurement, template-management, unified-templates, template-migration, complexity-specification, version-control
openstinger_context: template-management, procurement-templates, document-templates
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge/1900_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/01900_procurement/agent-data/prompts/01900_PROCUREMENT_ORDER_PROMPT.md
  - docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge/1900_GLOSSARY.MD
related_skills:
  - pre-task-assessment-readiness
  - procurement-order-management
  - sow-generation
---

# Template Management & Configuration

## Overview

Manage procurement templates using the unified template architecture. Includes template creation, complexity specification (simple/standard/complex/emergency/compliance), version control, agent assignments for template variation, template migration procedures, and quality assurance testing.

**Announce at start:** "I'm using the template-management skill to create or update a procurement template."

## When to Use This Skill

**Trigger Conditions:**
- Creating a new procurement template for a new category of procurement
- Updating an existing template with new requirements or field changes
- Migrating templates from a legacy system to the unified template architecture
- Defining complexity specifications for template variations
- Assigning agents to template variations for automated processing

**Prerequisites:**
- Template requirements defined (fields, sections, validation rules)
- Target order types identified (PO, WO, Service Order)
- Complexity levels determined per template
- Discipline assignments for template sections

## Step-by-Step Procedure

### Step 1: Identify Template Type

Identify the template type based on procurement category:

| Category | Template Type | Use Cases |
|----------|---------------|-----------|
| Material | Material PO Template | Steel, concrete, cable, fasteners, equipment |
| Service | Service Order Template | Maintenance, testing, calibration, consultancy |
| Work | Work Order Template | Subcontractor work, site work, installation |
| Emergency | Emergency Procurement Template | Urgent materials, emergency services |
| Compliance | Compliance Procurement Template | Regulatory-mandated, safety-critical, environmental |

### Step 2: Define Template Structure

Define the template structure with the following sections:

| Section | Required Fields | Validation Rules |
|---------|----------------|-----------------|
| Header | Template name, version, type, complexity | Name unique, version sequential |
| Scope Description | Description, objectives, boundaries | Description required, <500 words |
| Quantity & Specifications | Item, quantity, UoM, specification, standard | Quant > 0, valid UoM, spec required |
| Schedule | Start date, milestones, completion date | Dates valid, milestones ≥1, completion ≥ start |
| Deliverables | Description, acceptance criteria, responsible party | Each deliverable has measurable Acceptance criteria |
| Price & Payment | Unit price, currency, payment terms, taxes | Price ≥ 0, valid currency, payment terms documented |
| Quality Requirements | Standards, inspection, testing, certificates | Standards referenced, FAT/witness points defined |
| Safety Requirements | PPE, permits, HSE compliance, training | All required safety sections complete |
| Environment Requirements | Waste, emissions, permits, handling | Environmental impact assessed |
| Documentation & Submittals | Shop drawings, certificates, manuals, as-builts | Submittal list complete, deadlines defined |
| Approval & Signatures | Approver roles, signature blocks, dates | All required approvers defined |

### Step 3: Define Complexity Specification

Assign one of five complexity levels to the template:

| Complexity Level | Characteristics | Template Sections Required | Approval Requirements |
|-----------------|-----------------|---------------------------|---------------------|
| Simple | Single item, standard specs, routine approval | Header, Scope, Quantity/Specs, Price, Approval | Single approver |
| Standard | Multiple items, detailed specs, standard review | All sections (quality, safety, environment optional) | 2-3 approvers |
| Complex | Custom items, specialized requirements, FAT required | All sections mandatory + Appendix A-F, FAT, certifications | Multi-level approval |
| Emergency | Time-critical, minimal scope, essential fields only | Header, Scope, Quantity/Specs, Price, Emergency justification | Expedited (2 approvers, retroactive) |
| Compliance | Regulatory-mandated, audit trail required | All sections + compliance checklist, audit log | Multi-level + legal/compliance review |

### Step 4: Agent Assignment for Template Variations

Assign agents to template variations for automated processing:

| Template Variation | Assigned Agent | Responsibilities |
|-------------------|----------------|------------------|
| Material PO - Standard | Procurement Strategy Specialist | Template validation, pricing check, supplier matching |
| Material PO - Complex | Contract Administration Specialist | Contract terms, FAT requirements, specifications review |
| Service Order - Standard | Supplier Management Specialist | Supplier qualification, scope clarity, rate validation |
| Work Order - Standard | Procurement Strategy Specialist | Scope completeness, milestone acceptance criteria |
| Emergency Procurement | Mobile Workflow Designer | Expedited approval, rapid supplier matching |
| Compliance Procurement | Financial Compliance Specialist | Compliance checklist, audit trail, regulatory validation |

### Step 5: Template Version Control

Implement version control for template lifecycle management:

| Field | Description | Rules |
|-------|-------------|-------|
| Version Number | Sequential: 1.0, 1.1, 2.0 | Major version for structural changes, minor for corrections |
| Effective Date | When template becomes active | Must be future date or current date |
| Supersedes | Previous template version | Reference to template replaced |
| Status | Draft, Review, Approved, Active, Archived | Status transitions controlled |
| Change Log | Description of changes from previous version | Required, dated and attributed |
| Approved By | Name and role of approver | Required for Active status |

### Step 6: Template Migration Procedures

When migrating templates from a legacy system to the unified template architecture:

**Step 6.1: Inventory Legacy Templates**
- List all legacy templates with names, types, and usage frequency
- Identify duplicate or obsolete templates (archive, don't migrate)
- Map legacy template fields to the unified template structure
- Flag fields with no equivalent in unified template (resolve before migration)

**Step 6.2: Data Migration**
- Extract legacy template data (structure, fields, validation rules)
- Transform to unified template format
- Load into new template repository
- Validate field mapping and data integrity

**Step 6.3: Template Validation**
- Verify all migrated templates have required sections and fields
- Test template in a sandbox environment with sample data
- Verify template generates correct output
- Obtain approval from template owner before activating

**Step 6.4: Post-Migration Cleanup**
- Archive legacy templates after successful migration
- Document migration in change log
- Notify users of new template location and usage
- Monitor template usage and field for issues

### Step 7: Template Testing and Approval

Before making a template active:

1. **Unit Testing**: Test each section and field independently — validate required fields, data types, validation rules
2. **Integration Testing**: Test the template end-to-end with sample procurement data — create order, generate document, route approval
3. **User Acceptance Testing**: Have procurement team complete the template with real procurement scenario — verify usability and completeness
4. **Quality Assurance**: Template QA team reviews all test results, confirms all defects fixed, approves template for production
5. **Deployment**: Move template to production, update version registry, notify users

## Success Criteria

- [ ] Template type correctly identified and matched to procurement category
- [ ] Template structure complete with all required sections and fields
- [ ] Complexity level assigned with correct characteristics and approval requirements
- [ ] Agents assigned to template variations for automated processing
- [ ] Version control implemented with version number, effective date, and change log
- [ ] Template migration procedures followed (if migrating from legacy)
- [ ] Template tested (unit, integration, UAT, QA) and approved for production

## Common Pitfalls

1. **Incomplete Template Structure** — Don't create templates without all required template sections — missing sections create procurement errors.
2. **Wrong Complexity Definition** — Don't assign Simple complexity to a template that requires FAT or specialized certifications — use Complex.
3. **No Agent Assignment** — Templates without agent assignments won't be processed by the automation system. Always assign agents.
4. **Skipping UAT** — Never deploy a template that hasn't been tested by actual procurement users. What looks complete on paper may be unusable in practice.
5. **Migration Without Validation** — Don't migrate legacy templates without validating field mapping and data integrity. Garbage in, garbage out.
6. **Missing Version Control** — Every template change must increment the version number and update the change log. Without version control, you cannot track what changed and why.

## Cross-References

### Related Skills
- `procurement-order-management` — Templates are selected in Phase 2 of order creation
- `sow-generation` — SOW templates are a subset of procurement templates
- `approval-routing` — Template complexity determines approval routing configuration
- `pre-task-assessment-readiness` — Assess readiness before starting template creation

### Related Agents
- `Procurement Strategy Specialist` (DomainForge) — Template strategy and architecture
- `Procurement Analytics Specialist` (DomainForge) — Template usage analytics and performance metrics
- `Contract Administration Specialist` (DomainForge) — Contract template validation
- `QualityForge AI Team` — Template testing and quality assurance

## Example Usage

**Scenario:** Create new template for HVAC equipment procurement

1. **Template Type:** Material PO Template (HVAC equipment — physical goods)
2. **Structure:** Header, Scope (chiller specifications, capacity, efficiency), Quantity/Specs (2 × 500-ton chillers, ASHRAE standards), Schedule (delivery, installation, commissioning), Deliverables (chiller units, controls, installation manual), Price/Payment (lump sum, 30/70 payment), Quality (FAT required, performance test), Safety (lifting, rigging, electrical safety), Environment (refrigerant handling, energy efficiency), Documentation (O&M manuals, certifications, warranties), Approval/signatures
3. **Complexity:** Complex (custom manufacturing, FAT required, performance testing, commissioning)
4. **Agent Assignment:** Procurement Strategy Specialist (template validity), Contract Administration Specialist (contract terms, warranty, Liquidated damages), Quality Assurance (FAT, performance test), Safety (site safety plan)
5. **Version:** v1.0, effective 2026-04-15, supersedes: N/A (new template)
6. **Testing:** Unit test fields, integration test with sample chiller PO, UAT with MEP procurement team, QA approval → Deploy to production.