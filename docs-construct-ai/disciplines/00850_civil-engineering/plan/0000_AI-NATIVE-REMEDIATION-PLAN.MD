---
title: Civil Engineering Workflow Docs AI-Native Remediation Plan
description: Remediation plan for updating workflow_docs to incorporate AI-native operations principles from the new DOMAIN-KNOWLEDGE.MD Part 6B
version: 1.1
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00850_civil-engineering/workflow_docs
gigabrain_tags: disciplines, 00850_civil-engineering, ai-native-remediation, workflow-updates, document-generation, dwg-processing
openstinger_context: civil-engineering-workflow-remediation, ai-native-updates
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/00850_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/00850_GLOSSARY.MD
  - docs_construct_ai/disciplines/00850_civil-engineering/agent-data/prompts/00850_AI-NATIVE-CIVIL-ENGINEERING-PROMPT.md
---

# Civil Engineering Workflow Docs AI-Native Remediation Plan

## Overview

This document outlines what needs to be updated across workflow_docs files to align with the AI-native civil engineering principles defined in the updated DOMAIN-KNOWLEDGE.MD (Part 6B) and the new AI-NATIVE-CIVIL-ENGINEERING-PROMPT.md.

**Recommendation:** Use AI agents to execute these updates. The prompt at `00850_AI-NATIVE-CIVIL-ENGINEERING-PROMPT.md` is designed for this purpose.

## Files Requiring Updates

### Main Workflow Doc: `main/0000_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD`

**What needs updating:**

1. **DWG Processing Pipeline Section** — Currently has basic DWG segregation text, needs to be updated to align with Part 6B Section 6B.2:
   - Add the formal pipeline architecture: RAW → PREPROCESSING (AUDIT/PURGE/OVERKILL) → EXTRACTION → SCHEMA VALIDATION → STRUCTURED DATA → HUMAN VERIFICATION
   - Add extraction schemas by drawing type table
   - Add guard rails for geometry-derived data (5 rules)
   - Reference provenance tagging requirements

2. **Phase Definitions** — Add AI-native capabilities to each phase:
   - **Phase 1 (Site Assessment):** Add AI document generation (Feasibility Reports, Site Assessment Reports), Site Assessment Agent, automated compliance checking
   - **Phase 2 (Conceptual Design):** Add AI-generated Concept Design Briefs, automated options analysis, Design Options Agent
   - **Phase 3 (Preliminary Design):** Add AI document generation (Calculation Summaries, Stormwater Reports), Structural Analysis Agent, Drainage Sizing Agent
   - **Phase 4 (Detailed Design):** Add AI-generated method statements, ITPs, specifications; BIM Clash Agent, Quantity Take-Off Agent
   - **Phase 5 (Procurement):** Add AI-generated tender documentation, contract documents, NCR/RFI drafting agents

3. **Integration Points** — Add:
   - Document Generation Agent as integration point for all phases
   - Spec Compliance Agent for code/spec verification
   - BIM Intelligence capabilities (clash detection, quantity extraction, design change propagation)
   - Computer Vision for construction monitoring

4. **Document Generation** — New section needed covering:
   - Four-phase document generation pipeline
   - Template design principles (structured data injection, provenance tracking)
   - Quality gates and human review requirements

5. **Automation Spectrum** — Add table mapping each phase activity to automation level (Full/Augmented/Human-Led)

### Mobile Spec Files (14 files in `mobile_specs/`)

Each mobile spec file needs:
- Addition of AI-native capabilities relevant to that card (e.g., voice dictation, photo defect detection)
- Reference to structured data injection vs raw input
- AI assistance notes where applicable

**Priority updates by file:**
| Mobile Spec | AI-Native Additions |
|------------|---------------------|
| SITE_SURVEY | GPS data collection, survey agent integration, structured data validation |
| GEOTECHNICAL | Borehole data processing, foundation recommendation agent, specialist referral flags |
| ENGINEERING_CALCULATIONS | Integration with analysis libraries (OpenSees, frames2D), not LLM calculation |
| CONSTRUCTION_DRAWINGS | Structured data injection only, provenance tagging, no raw LLM geometry |
| QUANTITY_SCHEDULES | BIM quantity extraction agent, structured data source requirements |
| INSPECTION_TEST_PLANS | Auto-generation from specs, hold point validation, digital checklists |
| CONSTRUCTION_SUPPORT | Photo defect detection, progress monitoring via CV, NCR generation |

### Desktop Specs (`desktop_specs/`)

Update with:
- AI agent coordination architecture
- Document generation pipeline integration
- DWG processing workflow for each card
- Quality gates aligned with AI-Native prompt template

### Diagrams (`diagrams/`)

- Add multi-agent orchestration diagrams from Part 6B
- Add document generation pipeline flowchart
- Add DWG processing pipeline architecture diagram
- Add BIM intelligence workflow

### Implementation (`implementation/`)

- Add implementation phases aligned with 8-phase checklist in AI-Native prompt
- Add data quality requirements for each phase
- Add validation checkpoints between agent handoffs

## Agent Prompt for Execution

To have agents execute these updates, use the following prompt pattern:

```
Update [FILE_PATH] to incorporate AI-native civil engineering operations principles:

PARA Navigation:
- Access docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/00850_DOMAIN-KNOWLEDGE.MD
- Reference Part 6B: AI-Native Civil Engineering Operations
- Reference docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/00850_GLOSSARY.MD for new AI-native terms

Requirements:
1. Add AI-native capabilities section for workflow phase
2. Reference automation spectrum for relevant tasks (Full/Augmented/Human-Led)
3. Integrate document generation pipeline references
4. Add DWG processing pipeline alignment where geometry inputs are used
5. Reference non-delegable human decisions for final design sign-off points
6. Add multi-agent orchestration references

Quality Gates:
- All AI claims must reference Part 6B in DOMAIN-KNOWLEDGE.MD
- All new terms must be defined in GLOSSARY.MD
- No fabricated capabilities beyond what is defined in domain knowledge
- Maintain existing Mermaid diagrams (add new ones, don't replace)
```

## Execution Priority

**Phase 1 (Critical):**
1. `main/0000_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD` — Primary workflow document, needs all Part 6B integration

**Phase 2 (Important):**
2. All 14 mobile spec files — Add AI-native capabilities per card
3. Desktop spec files — Add agent coordination architecture

**Phase 3 (Supporting):**
4. Diagrams — Add new AI-native workflow diagrams
5. Implementation — Add implementation phases and validation checkpoints

## Notes

- The existing Civil Engineering prompt (`00850_CIVIL-DOCUMENTATION-WORKFLOW-PROMPT.md`) already has extensive DWG segregation principles — these should be harmonized with Part 6B to ensure consistency
- The new `00850_AI-NATIVE-CIVIL-ENGINEERING-PROMPT.md` is optimized for generating code and implementation guidance
- Both prompts can be used together: the documentation prompt for workflow docs, the AI-native prompt for code and architecture decisions