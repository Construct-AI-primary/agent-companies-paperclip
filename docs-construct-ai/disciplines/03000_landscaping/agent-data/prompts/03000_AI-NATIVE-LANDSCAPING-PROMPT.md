---
title: 03000 Landscaping AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement Landscaping features including planting plan generation, irrigation specification, maintenance programme generation, soil testing, and landscape documentation with structured data architecture
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/03000_landscaping/agent-data/prompts
gigabrain_tags: disciplines, 03000_landscaping, ai-native-operations, document-generation, landscape-design, planting-specifications, irrigation-design, hard-landscaping, maintenance-programmes
openstinger_context: landscaping-ai-native-operations, automated-documentation, agent-integration, code-generation
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/03000_landscaping/agent-data/domain-knowledge/03000_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/03000_landscaping/agent-data/domain-knowledge/03000_GLOSSARY.MD
  - docs_construct_ai/codebase/procedures/workflow-management/0000_PROMPT_REVIEW_REMEDIATION_PROCEDURE.md
---

# 03000 Landscaping AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement Landscaping features on large-scale engineering, infrastructure, mining, and architectural projects. It provides agents with the architectural context, automation spectrum, safety boundaries, and implementation patterns needed to generate correct, compliant landscaping code covering planting plan generation, irrigation specification, maintenance programme generation, soil testing, hard landscaping, and establishment monitoring. Use this prompt when agents are developing landscaping components, workflows, APIs, or UI elements.

**Key Lessons from Prior Domains:** The automation spectrum approach (Full Automation / Augment AI+Human / Human-Led) and structured data architecture patterns are foundational principles. Agents must understand what landscaping code they can generate independently vs. what requires human landscape architect review. Planting and irrigation data must be based on verified specifications—not fabricated.

**Important:** This prompt is for **OpenClaw coding agents operating in dev mode**. Agents use this prompt to **generate, modify, and validate code**. This prompt is NOT for the running application in production. The automation spectrum defines what **code** agents can generate independently vs. what requires human architect review.

## Implementation Action List & Progress Tracking

### Phase 1: Foundation — Text-Native vs Geometry-Native Architecture
- [ ] **Classify all landscaping data sources** — Tag each input as text-native (planting plans, specifications, maintenance programmes), geometry-native (site plans, irrigation layouts, hardscape drawings), image-native (plant health photos, irrigation coverage), or structured data (soil test results, irrigation flow rates)
- [ ] **Implement planting specification pipeline** — Plant data input → spec verification → planting plan generation
- [ ] **Implement irrigation specification pipeline** — Water requirement calculation → sprinkler selection → zone design
- [ ] **Implement provenance tracking** — Every planting and irrigation value tagged with source data, designer, date

### Phase 2: Document Generation Pipeline Implementation
- [ ] **Create template library** — Standardize all landscaping document templates (planting plans, irrigation specifications, maintenance programmes, soil test reports, plant inventory, handover documentation)
- [ ] **Implement structured data injection** — Template engine fills placeholders from planting data, irrigation calculations, soil test results
- [ ] **Develop Phase 1 documents (Design)** — Landscape design concepts, planting plans, irrigation layouts, hard landscape drawings
- [ ] **Develop Phase 2 documents (Specification)** — Plant specifications, soil improvement specs, irrigation specs, maintenance specs
- [ ] **Develop Phase 3 documents (Construction)** — Installation checklists, commissioning records, inspection reports, plant inventory
- [ ] **Develop Phase 4 documents (Handover)** — Maintenance programmes, handover documentation, as-built records
- [ ] **Add quality validation** — Automated completeness checks, plant appropriateness for climate, irrigation efficiency verification
- [ ] **Implement version control** — Document revision tracking with immutable audit trail

### Phase 3: Multi-Agent Landscaping Orchestration
- [ ] **Implement Planting Plan Agent** — Auto-generate planting plans from site data and design briefs
- [ ] **Implement Irrigation Design Agent** — Calculate water requirements, design irrigation layouts
- [ ] **Implement Soil Analysis Agent** — Process soil test results, recommend soil improvement
- [ ] **Implement Maintenance Programme Agent** — Generate maintenance programmes from planting and irrigation data
- [ ] **Implement Establishment Monitoring Agent** — Track plant establishment rates, identify underperforming areas
- [ ] **Implement Plant Health Analysis Agent** — Analyze plant health from photos, identify disease or stress
- [ ] **Implement Hard Landscaping Agent** — Generate hardscape documentation from drawings and specifications
- [ ] **Implement agent coordination layer** — Design → Planting → Irrigation → Establishment → Maintenance workflow

### Phase 4: Plant Health Intelligence
- [ ] **Implement plant health analysis from photos** — Auto-detect disease, pest damage, water stress from photos
- [ ] **Implement establishment tracking** — Monitor plant survival rates, identify areas needing remedial planting
- [ ] **Implement growth tracking** — Compare actual growth against expected benchmarks
- [ ] **Develop remedial planting recommendations** — Suggest replanting or remedial measures from health data

### Phase 5: Natural Language Landscaping Interface
- [ ] **Implement Plant Query Assistant** — "What plants are appropriate for this zone?" → climate-appropriate recommendations
- [ ] **Develop Irrigation Query Assistant** — "What is the water requirement for Zone B?" → calculated water requirements
- [ ] **Implement Maintenance Query Assistant** — "What maintenance is required this month?" → monthly maintenance schedule
- [ ] **Implement chatbot with landscaping boundaries** — Cannot approve landscape design, cannot commit to plant selection for critical sites

### Phase 6: Irrigation Intelligence
- [ ] **Implement water requirement calculation** — Calculate water needs by plant type, area, season, weather
- [ ] **Develop irrigation scheduling** — Optimize irrigation timing for water efficiency
- [ ] **Implement weather-based adjustment** — Adjust irrigation schedule based on forecast rainfall and temperature
- [ ] **Develop water efficiency tracking** — Monitor water usage against targets, identify efficiency improvements

### Phase 7: Data-Driven Landscaping Operations
- [ ] **Implement soil health tracking** — Track soil condition changes over time
- [ ] **Develop plant establishment trending** — Predict final establishment rates from early performance
- [ ] **Implement maintenance cost tracking** — Track actual maintenance costs against programme estimates
- [ ] **Develop landscape dashboard** — Real-time landscape status with health, irrigation, and maintenance metrics

### Phase 8: AI Safety Boundaries & Governance
- [ ] **Implement non-delegable decision controls** — Landscape design final approval always requires human landscape architect
- [ ] **Develop uncertainty disclosure** — AI must disclose when plant appropriateness uncertain, soil test requires specialist
- [ ] **Implement immutable audit trail** — Log all landscaping outputs with provenance tags
- [ ] **Develop human review gates** — Design approval, plant selection for critical sites, handover acceptance require human validation
- [ ] **Implement data retention requirements** — Compliance with landscape record retention

## Discipline Context

### 03000 Landscaping Scope
The 03000 Landscaping discipline encompasses:
- **AI-Native Operations**: Automating landscaping documentation from planting plans to maintenance programmes
- **Planting Plan Pipeline**: Automated planting plan generation from site data, climate, and briefs
- **Irrigation Design Pipeline**: Water requirement calculation, irrigation layout optimization
- **Maintenance Programme Pipeline**: Automated maintenance programme generation from planting data
- **Plant Health Intelligence**: Plant health assessment from photos, establishment tracking
- **Soil Analysis**: Soil test processing, improvement recommendations
- **Landscaping Governance**: AI safety boundaries, human review gates, audit trails, landscape architect sign-off

### Related Disciplines
- **00850 Civil Engineering**: Site works, earthworks, drainage integration
- **01000 Environmental**: Erosion control, rehabilitation, biodiversity
- **01900 Procurement**: Plant procurement, irrigation equipment procurement
- **00825 Architectural**: External works, hard landscaping integration

## Core Template Structure

```
[TASK DESCRIPTION]

Using the Construct AI memory system with Gigabrain for 03000 Landscaping AI-Native Operations:

**PARA Navigation:**
- Access docs_construct_ai/disciplines/03000_landscaping/agent-data/domain-knowledge/
- Reference AI-native operations documentation (Part 6 in DOMAIN-KNOWLEDGE.MD)
- Reference related areas: [additional PARA paths based on task]

**Gigabrain Search:**
- Search gigabrain tags for "disciplines, 03000_landscaping", "ai-native-operations", "[specific-capability]"
- Filter by tags: "landscape-design", "planting-plans", "irrigation-design", "maintenance-programmes"

**Memory Context:**
- Include memory headers showing related_docs, para_section, and gigabrain_tags
- Cross-reference with landscaping domain knowledge and glossary
- Check memory for recent landscaping AI implementation patterns

**Landscaping AI-Native Context:**
- Reference text-native, geometry-native, image-native, and structured data input classification
- Apply planting specification pipeline (plant data → spec verification → plan generation)
- Follow document generation pipeline principles (template-based structured data injection)
- Respect non-delegable human decisions (layout approval, plant selection)

**Knowledge Integration:**
- Follow cross-references in memory headers
- Identify patterns across similar landscaping AI implementations
- Build on established landscaping organizational knowledge
- Ensure appropriate plants for climate and soil conditions

[SPECIFIC REQUIREMENTS OR QUESTIONS]
```

## Landscaping AI-Native Use Case Templates

### Planting Plan Generation
```
Generate Planting Plan for [ZONE]:

PARA Navigation:
- Access docs_construct_ai/disciplines/03000_landscaping/agent-data/domain-knowledge/03000_DOMAIN-KNOWLEDGE.MD
- Reference planting plan generation: Part 6, Phase 2
- Check climate zone and soil conditions: Part 2.2

Gigabrain Search:
- Search gigabrain tags for "disciplines, 03000_landscaping", "planting-plans", "[plant-type]"
- Filter by tags: "climate-appropriate", "native-species", "establishment-success"

Memory Context:
- Include memory headers with planting plan gigabrain_tags
- Cross-reference with climate zone data and soil conditions
- Reference historical planting plans for similar zones

LANDSCAPING AI-NATIVE CONTEXT:
- Apply planting plan generation from site data and design brief
- Select appropriate plants for climate zone, soil conditions, and design intent
- Calculate quantities and spacing from area measurements
- Generate planting plan with plant schedule and installation notes

Provide planting plan generation with:
- Plant list with species, quantity, size, spacing
- Soil preparation requirements for the zone
- Planting method notes for each plant type
- Establishment requirements and maintenance schedule
- Provenance tracking: source data, planting plan date, designer
```

### Irrigation Specification Generation
```
Generate Irrigation Specification for [ZONE]:

PARA Navigation:
- Access docs_construct_ai/disciplines/03000_landscaping/agent-data/domain-knowledge/
- Reference irrigation design: Part 3.1
- Check water requirements by plant type: Part 3

Gigabrain Search:
- Search gigabrain tags for "disciplines, 03000_landscaping", "irrigation-design", "[irrigation-type]"
- Filter by tags: "water-efficiency", "zone-design", "sprinkler-selection"

Memory Context:
- Include memory headers with irrigation design gigabrain_tags
- Cross-reference with planting plan and water requirement data
- Reference historical irrigation specifications

LANDSCAPING AI-NATIVE CONTEXT:
- Apply irrigation specification pipeline: Water requirement → Sprinkler selection → Zone design → Schedule
- Calculate water requirements from plant types, area, and climate
- Design irrigation zones for efficient operation
- Generate specification with equipment schedule and controller program

Provide irrigation specification with:
- Water requirement calculation for all plant types in zone
- Sprinkler head selection and spacing
- Pipe sizing and pressure calculations
- Controller program with seasonal adjustments
- Provenance tracking: source planting data, specification date, designer
```

## Automation Spectrum for Landscaping Operations Tasks

### Fully Automatable Tasks (Human-Free Generation)
The AI can independently execute these tasks with structured data input, requiring only final human review before distribution:

| Output | Trigger | Input Data | Quality Gate |
|--------|---------|-----------|--------------|
| **Planting Plan Draft** | Planting brief received | Climate zone, soil, area, plant preferences | Auto-validation: plants appropriate, quantities correct, spacing verified |
| **Irrigation Specification Draft** | Planting plan complete | Plant types, area, water pressure data | Auto-validation: water requirements calculated, sprinkler coverage adequate |
| **Maintenance Programme Draft** | Planting and irrigation complete | Plant types, establishment period | Auto-validation: maintenance tasks complete, schedule appropriate |
| **Soil Test Report** | Soil samples received | Sample data, laboratory results | Auto-validation: results matched to improvement recommendations |
| **Plant Inventory** | Plants delivered | Delivery docket, plant list | Auto-validation: quantities match, species and sizes verified |
| **Establishment Status Report** | Establishment monitoring period | Plant survival data, growth measurements | Auto-validation: establishment rates calculated, areas flagged |

### Augmented Tasks (AI + Human Co-Creation)
The AI drafts, suggests, or analyses — human specialist reviews and finalizes:

| Output | AI Contribution | Human Role | Decision Authority |
|--------|----------------|-----------|---------------------|
| **Landscape Design Concept** | Draft concept options from site analysis | Landscape architect reviews, selects, develops | Human |
| **Hard Landscaping Specification** | Draft hardscape specs from drawings | Landscape architect reviews, confirms materials | Human |
| **Installation Checklist** | Draft from planting and hardscape plans | Site manager reviews, adjusts for site conditions | Human |
| **Commissioning Record** | Compile test results, adjustments | Irrigation engineer reviews, signs off | Human |
| **Handover Documentation** | Compile maintenance programme, as-builts | Landscape manager reviews, accepts for handover | Human |

### Human-Led Tasks (AI Informs, Human Decides)
The AI provides data, context, and recommendations — human makes the final decision or action:

| Task | AI Support | Human Decision |
|------|-----------|----------------|
| **Landscape Design Approval** | Compile concept options, site analysis | Landscape architect approves final design |
| **Plant Selection for Critical Sites** | Suggest climate-appropriate plants | Landscape architect selects final plants |
| **Irrigation Commissioning** | Compile test results, adjustments | Irrigation engineer signs off commissioning |
| **Remedial Planting Decisions** | Identify underperforming areas, suggest measures | Landscape manager decides action |
| **Landscape Handover Acceptance** | Compile completion data, maintenance programme | Client or operations team accepts |
| **Soil Treatment Approval** | Compile test results, improvement recommendations | Landscape manager approves treatment |

## Document Generation Pipeline

### Pipeline Architecture
All AI-generated landscaping documents flow through a consistent pipeline with quality gates at each stage:

```
INPUT DATA COLLECTION (site data, planting plans, irrigation data, soil results)
    ↓
STRUCTURED DATA VALIDATION (plant appropriateness, water requirements, soil)
    ↓
TEMPLATE SELECTION & CONFIGURATION (document type, zone, climate)
    ↓
DATA INJECTION INTO TEMPLATE PLACEHOLDERS (structured data, not raw LLM)
    ↓
QUALITY VALIDATION (completeness, plant appropriateness, irrigation efficiency)
    ↓
DRAFT DOCUMENT GENERATED
    ↓
HUMAN REVIEW (where required — design approval, plant selection, sign-off)
    ↓
FINAL APPROVAL (landscape architect for design approval, authority acceptance)
    ↓
OUTPUT GENERATION (PDF, DWG, structured data, handover package)
    ↓
VERSION CONTROL & AUDIT LOG
    ↓
DISTRIBUTION & ARCHIVAL
```

### Template Design Principles
1. **Structured Data Injection, Not Raw Generation**: All templates use placeholders filled from verified structured data sources (planting plans, irrigation calculations, soil test results). The LLM structures and formats, but does not invent plants or irrigation data.
2. **Provenance Tracking**: Every plant, irrigation value, and soil measurement injected into a template is tagged with its source (e.g., "water requirement from Zone B, plant type: Acacia spp., calculated: 2026-04-01").
3. **Conditional Logic**: Templates include logic to add or omit sections based on data (e.g., "if no hardscape, omit hardscape section").
4. **Climate and Soil Appropriateness**: Templates must reference appropriate plants for climate zone and soil conditions. Recommendations must be verified.
5. **Multi-Format Output**: Design documents (DWG, PDF), specifications (PDF), checklists (forms), and handover (package) all supported.
6. **Traceable and Auditable**: All landscaping documentation must be traceable to source data and design intent.

## AI-Native Landscaping Capabilities Beyond Automation

### Plant Health Intelligence
- **Plant Health Assessment from Photos**: Analyze landscape photos for plant health, disease identification, pest damage, water stress
- **Establishment Tracking**: Monitor plant survival rates, identify areas needing remedial planting, predict final establishment
- **Growth Tracking**: Compare actual growth against expected benchmarks, identify underperforming plants
- **Disease Identification**: Identify common plant diseases from visual symptoms, recommend treatment

### Irrigation Intelligence
- **Water Requirement Calculation**: Calculate water needs from plant type, area, season, weather
- **Irrigation Schedule Optimization**: Optimize irrigation timing for water efficiency and plant health
- **Weather-based Adjustment**: Adjust irrigation schedule from forecast rainfall and temperature

### Natural Language Landscaping Interface
- **Plant Query Assistant**: "What plants are appropriate for this zone?" → climate-appropriate recommendations
- **Irrigation Query Assistant**: "What is the water requirement for Zone B?" → calculated water requirements
- **Maintenance Query Assistant**: "What maintenance is required this month?" → monthly maintenance schedule
- **Design Query Assistant**: "What hardscape materials are specified for the entry path?" → material specification

## AI Safety Boundaries — What Must NOT Be Automated

Certain decisions and actions must remain under human control for design, environmental, and legal reasons:

**Non-Delegable Human Decisions:**
1. Landscape design final approval
2. Plant selection for critical sites
3. Major maintenance programme changes
4. Landscape handover acceptance
5. Irrigation system commissioning sign-off
6. Soil treatment approval
7. Plant health remediation decisions

**AI Must Always Disclose:**
1. When plant selection may not be appropriate for local conditions
2. When irrigation calculations are based on incomplete data
3. When soil test results require specialist interpretation
4. When plant establishment is below expected levels
5. What physical inspections are required for landscape acceptance
6. What irrigation commissioning steps require human verification

## Technical Architecture Recommendations

| Component | Recommended Approach |
|-----------|---------------------|
| Document generation | Template engine with structured data injection from planting plans, irrigation data, soil tests |
| Plant specification | Plant database with climate zone, soil, and water requirements; LLM verifies appropriateness |
| Irrigation design | Water requirement calculation engine with climate and plant data |
| Plant health analysis | CV models for health assessment from photos; LLM works from extracted findings |
| Knowledge retrieval | RAG pattern for plant specifications, irrigation standards, soil improvement |
| Audit trail | Immutable log of all landscaping outputs with provenance tags |

## AI Agent Coordination Workflow

```
Site Analysis Received (topography, soil, climate, drainage)
    → Planting Plan Agent generates planting plan from brief
    → Irrigation Design Agent calculates water requirements, designs layout
    → Hard Landscaping Agent processes hardscape drawings and specifications
    → Soil Analysis Agent processes soil test results, recommends improvement
    → As installation completes: Establishment Monitoring Agent tracks plant survival
    → Plant Health Analysis Agent monitors plant health from photos
    → Maintenance Programme Agent generates maintenance schedule
    → Handover documentation compiled: landscape manager reviews
    → Landscape architect approves: documents distributed and archived
```

## Implementation Best Practices

### Agent Coordination Guidelines
1. **Start with data quality** — plant and irrigation data accuracy is critical
2. **Implement one agent/pipeline** at a time, validate, then add next
3. **Engage QualityForge AI** for all validation and quality assurance before deployment
4. **Define clear agent boundaries** in prompts and tools from day one
5. **Document all landscaping outputs** with provenance for audit and design review
6. **Never let LLM invent plant data** — always use verified plant databases

### Landscaping Boundary Enforcement
1. **Never allow AI to approve landscape designs** — always require landscape architect approval
2. **Never allow AI to select plants for critical sites** — always require human landscape architect
3. **Never allow AI to sign off irrigation commissioning** — always require irrigation engineer
4. **Always disclose AI limitations** — plant appropriateness certainty, data completeness
5. **Always maintain immutable audit trail** — all landscaping outputs with provenance
6. **Always tag landscaping data** with provenance (source data, designer, date, verification status)

## Success Metrics

### Document Generation Metrics
- **Accuracy**: 99%+ data accuracy in generated documents vs source plans
- **Timeliness**: 80%+ reduction in landscaping documentation time vs manual methods
- **Review Efficiency**: 50%+ reduction in human review cycles through pre-validation
- **Compliance**: 100% of landscaping documents generated within required timeframes

### Plant Establishment Metrics
- **Survival Rate**: 90%+ plant survival at establishment period end
- **Identification Accuracy**: 85%+ accuracy in plant health assessment from photos
- **Establishment Trend Detection**: 90%+ of underperforming areas identified early
- **Remedial Planting**: 95%+ of areas needing remedial planting identified and addressed

### Irrigation Metrics
- **Water Efficiency**: 20%+ reduction in water usage from optimized scheduling
- **Coverage Adequacy**: 100% of planting areas adequately irrigated
- **Schedule Compliance**: 95%+ of irrigation schedule adjustments made based on weather
- **System Performance**: 100% of irrigation zones operating at design pressure

### Multi-Agent Orchestration Metrics
- **Completion Rate**: 95%+ of landscaping workflow sequences complete without failure
- **Latency**: End-to-end agent handoff <5 seconds for each transition
- **Error Recovery**: 100% of failed agent executions recovered or escalated to human
- **Audit Trail Integrity**: 100% of landscaping actions logged with source, timestamp, and decision

## Version History

- **v1.0** (2026-04-01): Initial AI-Native Landscaping Operations Prompt Template
- Added structured metadata header following established pattern
- Incorporated lessons learned from Safety, Civil Engineering, IT, Inspection, Safety, and Security domains
- Created landscaping-specific use case templates for planting plan generation and irrigation specification
- Defined automation spectrum for all landscaping operations tasks (Full, Augmented, Human-Led)
- Built comprehensive document generation pipeline with quality gates and template design principles
- Detailed success metrics for all AI capabilities
- Added implementation best practices and landscaping boundary enforcement

## Landscaping AI Agent Behavioral Rules

### Non-Negotiable Rules for All Landscaping AI Agents

1. **Plant Appropriateness Rule:** Never recommend plants that are inappropriate for the climate zone, soil type, or site conditions. If uncertain, the agent must flag as "requires landscape architect review."

2. **Water Efficiency Rule:** Always calculate water requirements accurately and recommend efficient irrigation practices. Never specify irrigation that wastes water.

3. **No Data Fabrication Rule:** Never invent plant data, irrigation calculations, soil test results, or health assessments. Only use data from verified sources (plant databases, soil labs, irrigation calculations, photo analysis).

4. **Provenance Tracking Rule:** All landscaping outputs must carry provenance tags (source data, designer, date, verification status). Never present recommendations without their source attribution.

5. **Establishment Monitoring Rule:** Always track and report plant establishment rates honestly. Do not overstate survival rates or hide underperforming areas.

6. **Code Reference Rule:** When making plant recommendations or irrigation specifications, cite authoritative sources (plant database, irrigation standards, soil guidelines).

7. **Safety Boundary Rule:** Never approve landscape designs, select plants for critical sites, or sign off irrigation commissioning. Always require human landscape architect or engineer.

8. **Documentation Rule:** All landscaping outputs should be structured for formal landscape documentation. Use professional, auditable language that meets landscape industry standards.

9. **Respect Non-Delegable Decisions:** Never design landscapes, select plants for critical sites, or accept landscape handover. These require human landscape architect judgment.

10. **Audit Trail Rule:** All landscaping outputs, recommendations, and decisions must be recorded with full audit trail for design review, quality assurance, and landscape industry compliance.