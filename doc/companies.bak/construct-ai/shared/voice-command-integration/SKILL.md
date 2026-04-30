---
title: Voice Command Integration for Procurement
description: Implement voice-powered procurement order creation with AI parsing, context-aware recognition, real-time validation, and GPS-embedded approval routing
version: 1.0
frequency_percent: 45.0
success_rate_percent: 85.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/skills/domainforge_ai/voice-command-integration
gigabrain_tags: disciplines, 01900_procurement, voice-commands, ai-parsing, natural-language, mobile-integration, voice-ordering
openstinger_context: voice-procurement, natural-language-ordering, mobile-voice
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/01900_procurement/agent-data/prompts/01900_PROCUREMENT_ORDER_PROMPT.md
  - docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge/1900_GLOSSARY.MD
related_skills:
  - pre-task-assessment-readiness
  - procurement-order-management
  - approval-routing
---

# Voice Command Integration for Procurement

## Overview

Implement voice-powered procurement order creation with AI parsing of natural language procurement requirements. Includes context-aware recognition of procurement terminology and specifications, real-time validation against project requirements and budget, and GPS-embedded approval routing.

**Announce at start:** "I'm using the voice-command-integration skill to process a voice procurement order."

## When to Use This Skill

**Trigger Conditions:**
- User initiates voice procurement order via voice-enabled device or mobile app
- Field worker needs to place an order while at a construction site
- User prefers voice-to-order over typing or form-filling
- Emergency procurement requires rapid order placement

**Prerequisites:**
- Voice-enabled device with microphone and internet connectivity
- User authenticated and authorized for procurement actions
- Project context known (project, WBS, site location)

## Step-by-Step Procedure

### Step 1: Voice Command Capture

Capture the voice command from the user:

```
USER: "Order 500 meters of 240mm² XLPE copper cable for the ABC project, needed by May 15th at Gate 2."
```

### Step 2: AI Parsing of Natural Language

Parse the voice command using NLP to extract structured procurement data:

| Command Phrase | Extracted Field | Value |
|---------------|-----------------|-------|
| "500 meters" | Quantity | 500 |
| "meters" | Unit of Measure | Meter |
| "240mm² XLPE copper cable" | Description/Specification | Cable, 240mm², XLPE insulated, copper conductor |
| "ABC project" | Project | Project ABC |
| "May 15th" | Required Delivery Date | 2026-05-15 |
| "Gate 2" | Delivery Location | Site Gate 2 |

### Step 3: Context-Aware Recognition

Enhance parsing with procurement-specific context awareness:

| Context | Recognition Enhancement |
|---------|------------------------|
| "240mm²" | Recognized as cable cross-section (standard electrical cable size) |
| "XLPE" | Recognized as insulation type (Cross-Linked Polyethylene) |
| "cable" | Recognized as material category → Material PO Template |
| Project "ABC" | Verified as active project with WBS available |
| "May 15th" | Verified against project schedule — feasible delivery date |

### Step 4: Real-Time Validation

Validate extracted data against the following:

| Validation Check | Source | Result |
|-----------------|--------|--------|
| Does project ABC exist and is active? | Project database | ✅ |
| Is there a WBS for cable procurement on Project ABC? | WBS registry | ✅ |
| Is 500m of 240mm² cable within budget? | BOQ + committed cost check | ✅ or ⚠️ |
| Is Gate 2 a valid delivery location? | Site locations database | ✅ |
| Is May 15th achievable within lead-time? | Supplier lead-time database | ✅ if lead-time < current date to May 15th |
| Is the item a standard procurement category? | Approved procurement categories | ✅ |

If any validation check fails, prompt the user for clarification:

**Example:** "I couldn't find a WBS for cable procurement on Project ABC. Can you provide the WBS element or cost code?"
**Example:** "Lead-time for 240mm² cable is 10 weeks. May 15th is not achievable. Earliest delivery: July 20th. Proceed?"

### Step 5: Intelligent Supplier Matching

Match the procurement requirement to qualified suppliers:

| Matching Factor | Weight |
|----------------|--------|
| Supplier qualification tier (Platinum > Gold > Silver > Bronze) | 30% |
| Past performance on similar items (on-time delivery rate) | 25% |
| Competitive pricing (quotation history) | 20% |
| Availability and current capacity | 15% |
| Geographic proximity to delivery location | 10% |

**Output:** Top 3 recommended suppliers with rationale

### Step 6: Catalog Integration (If Available)

If the item exists in the procurement catalog:

| Catalog Field | Auto-Populated Value |
|--------------|---------------------|
| Item code | [Catalog item code] |
| Description | [Catalog description] |
| Specification | [Catalog specification] |
| Unit price | [Current catalog price] |
| Preferred supplier | [Catalog default supplier] |
| Lead-time | [Catalog lead-time] |

### Step 7: Real-Time Voice Feedback and Correction

Provide voice feedback to the user and allow corrections:

**System:** "I've prepared your order: 500 meters, 240mm² XLPE copper cable, Project ABC, delivery May 15th to Gate 2. Estimated cost: $45,000. Supplier: Cable Corp (Gold tier, 96% on-time). Proceed?"

**User Options:**
- "Yes, proceed" → Continue to GPS approval
- "Change quantity to 600 meters" → Update and re-validate
- "Change supplier to WireTech" → Update supplier and re-check lead-time
- "Cancel" → Abort and discard draft

### Step 8: GPS-Embedded Approval Routing

After user confirms, route for approval using the approval-routing skill with GPS-embedded location verification, GPS-embedded signature, and GPS-proximity approval authority determination.

## Success Criteria

- [ ] Voice command captured and transcribed accurately
- [ ] AI parsing correctly extracts all procurement fields (quantity, UoM, description, project, date, location)
- [ ] Context-aware recognition correctly identifies procurement terminology
- [ ] Real-time validation passes all checks (project exists, WBS available, budget confirmed, lead-time achievable, location valid)
- [ ] Intelligent supplier matching returns top 3 qualified suppliers
- [ ] Voice feedback provided with complete order summary
- [ ] User confirmation received before proceeding to approval
- [ ] GPS approval routing initiated

## Common Pitfalls

1. **Poor Audio Quality** — Background noise on construction sites can corrupt voice capture. Ensure noise-cancelling microphone or alternative input method.
2. **Ambiguous Specifications** — "cable" could be electrical, data, telecommunications — context-aware recognition must disambiguate or ask for clarification.
3. **Budget Not Validated** — Never auto-approve voice orders exceeding budget without explicit escalation and approval.
4. **Lead-Time Not Checked** — Voice orders often come from field workers who may not know supplier lead-times. Always validate deliverability before confirming.
5. **No User Confirmation** — Never auto-execute a voice order without explicit confirmation from the user. Voice parsing errors can result in costly mistakes.

## Cross-References

### Related Skills
- `procurement-order-management` — Voice orders create POs using the 5-phase workflow
- `approval-routing` — Voice orders require GPS-embedded approval routing
- `gps-approval-configuration` — GPS approval used after voice order confirmation
- `supplier-evaluation` — Supplier matching uses qualification tiers

### Related Agents
- `Mobile Workflow Designer` (DomainForge) — Voice command workflow design and UX
- `Procurement Strategy Specialist` (DomainForge) — Voice order validation and supplier matching
- `AI Integration` — NLP engine for voice-to-order parsing

## Example Usage

**Scenario:** Field worker orders cable at construction site

1. **Voice Command:** "Order 500 meters of 240mm² XLPE copper cable for ABC project, needed by May 15th at Gate 2."
2. **AI Parsing:** Quantity: 500m, Spec: 240mm² XLPE copper cable, Project: ABC, Date: 2026-05-15, Location: Gate 2
3. **Validation:** Project ABC exists ✅, WBS for cable: 01900-ELEC-01 ✅, Lead-time: 8 weeks (May 15th not achievable, earliest July 20th) ⚠️, Gate 2 is valid ✅
4. **Feedback:** "May 15th is not achievable — lead-time is 8 weeks. Earliest delivery: July 20th. Supplier: Cable Corp. Proceed?"
5. **User Confirms:** "Yes, July 20th with Cable Corp."
6. **Approval:** Route for GPS-embedded approval — order created and routed with location verification.