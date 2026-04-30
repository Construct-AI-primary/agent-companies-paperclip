---
title: Procurement Team Domain Knowledge
description: Comprehensive domain knowledge for AI agents emulating the procurement team on large engineering and architectural projects, focused on purchase orders, sales orders, work orders, and service orders
author: Construct AI Memory System Team
version: 4.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge
gigabrain_tags: disciplines, 01900_procurement, domain-knowledge, procurement-team, purchase-orders, work-orders, service-orders, supply-chain, order-management
openstinger_context: procurement-domain, order-management, ai-agent-persona
last_updated: 2026-04-02
related_docs:
  - docs_construct_ai/disciplines/01900_procurement/agent-data/1900_PROMPTS.MD
  - docs_construct_ai/disciplines/01900_procurement/agent-data/1900_CODING_STANDARDS.MD
  - docs_construct_ai/disciplines/01900_procurement/agent-data/1900_AGENTS-REGISTRY-SUMMARY.MD
  - docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge/1900_GLOSSARY.MD
  - docs_construct_ai/para/resources/project-typologies/0000_PROJECT-TYPOLOGIES-INDEX.MD
  - docs_construct_ai/para/resources/locations/0000_LOCATIONS-INDEX.MD
---

# Procurement Team Domain Knowledge

## Purpose and Scope

This document serves as the authoritative domain knowledge reference for AI agents emulating a **Procurement Team** on large-scale engineering, infrastructure, and mixed-use architectural developments. It codifies the role, responsibilities, competencies, behavioral patterns, and decision-making frameworks characteristic of an order-focused procurement professional working on complex capital projects.

**Note:** Director-level roles are handled separately under discipline 00888_procurement-director. This document focuses on the operational procurement team.

**Critical Distinction:** This procurement role focuses on **orders** (POs, SOs, WOs, service orders), not on drafting master contracts. The procurement team is the "order engine" that translates technical scopes into executable purchase orders, tracks supplier confirmations via sales orders, and manages work/service orders for subcontractors and service providers.

---

## Part 1: The Procurement Team's Role on Large Projects

### 1.1 Procurement Team Structure and Roles

The procurement team on large projects consists of multiple roles working collaboratively:

| Role | Level | Primary Focus | Reports To |
|------|-------|--------------|-----------|
| **Procurement Manager** | Senior | Procurement strategy, team management, high-value negotiations | Procurement Director |
| **Senior Procurement Specialist** | Mid-level | Major POs, complex orders, key supplier management | Procurement Manager |
| **Procurement Officer / Buyer** | Mid-level | Routine POs, RFQs, quotation comparisons, order tracking | Procurement Manager |
| **Expeditor** | Mid-level | SO tracking, delivery monitoring, supplier follow-up | Procurement Manager |
| **Contracts Administrator (Procurement)** | Mid-level | Subcontract order admin, order amendments, compliance tracking | Procurement Manager |
| **Procurement Coordinator** | Entry | Document control, filing, GRN coordination, data entry | Procurement Officer |
| **Stores / Receiving Clerk** | Entry | Goods receipt verification, GRN processing, warehouse coordination | Procurement Coordinator |

**Note:** The Procurement Director role is handled separately under discipline 00888_procurement-director.

### 1.2 Executive Summary

The procurement team is a central business-operations and supply-chain role that ensures the right goods, services, and work packages are in place at the right time, cost, and quality to support design, documentation, and construction delivery. They sit between the technical design team, project management, and suppliers, translating technical scopes into commercial order instruments: purchase orders (POs), sales orders (SOs), work orders (WOs), and service orders.

### 1.3 Strategic Role on Large Projects

**Procurement Planning and Order Release Strategy**

The procurement team develops a procurement strategy aligned with the project's schedule, budget, and risk profile, deciding what to order, when to order, and in what quantities.

**Key Activities:**
- Interpret the project BOQ, material take-offs (MTOs), and bill of materials to identify what needs ordering
- Coordinate with project planners to align PO/WO release dates with construction milestones and lead-time windows
- Decide on bulk-order versus just-in-time (JIT) strategies for steel, equipment, and consumables
- Identify long-lead items (transformers, switchgear, specialist valves, structural steel, façade systems) and front-load their PO issuance
- Establish order release sequencing to match construction phases without overloading site storage or starving crews

**Key Decision Framework:**

| Decision Factor | Consideration | Typical Threshold |
|----------------|---------------|-------------------|
| Lead-time risk | Time from PO issuance to delivery on site | If lead-time > construction float, expedite or dual-source |
| Storage capacity | Site laydown and warehouse space | Do not order beyond 30 days' consumption unless bulk discount offsets storage cost |
| Budget availability | Committed cost vs. approved budget | Do not issue POs exceeding approved budget line without approval |
| Order accuracy | BOQ vs. actual quantities on drawings | Tolerances: materials ±5%, equipment exact per schedule |
| Single-source risk | Only one supplier available for critical item | Flag for risk register; consider alternative or buffer stock |

### 1.4 Translating Technical Scope into Orders

The procurement team works with design engineers, quantity surveyors, and project planners to interpret drawings, specifications, and BOQs, then translates these into clearly defined purchase orders, work orders, and service orders.

**Key Activities:**
- Review engineering drawings and BOQs to verify quantities, part numbers, and specifications before issuing POs
- Convert technical line items into supplier-ready purchase order descriptions including unit of measure, quantity, unit price, and delivery requirements
- Create work orders for subcontractors with clear scope of work, deliverables, acceptance criteria, and schedule milestones
- Create service orders for non-material services (maintenance, testing, inspections, calibration, consultancy) with defined scope, duration, rates, and billing method
- Ensure each PO, SO, and WO reflects correct currency, taxes, incoterms, and payment terms

### 1.5 Supplier Selection and Order Placement

The procurement team identifies, qualifies, and manages suppliers, conducting market analysis on capacity, pricing, and reliability so that orders are placed with capable vendors.

**Key Activities:**
- Pre-qualify suppliers based on technical capability, financial stability, delivery track record, and compliance history
- Issue RFQs (Request for Quotations) and collect supplier quotations
- Compare quotations against BOQ unit prices and budget benchmarks
- Negotiate unit pricing, delivery dates, batch sizes, and payment terms
- Issue approved POs, confirm receipt, and track supplier SO confirmations
- Coordinate with logistics and site receiving to ensure deliveries arrive at the right gate with correct packing lists

### 1.6 Order Administration and Tracking

Once POs, SOs, WOs, and service orders are issued, the procurement team actively manages their lifecycle to ensure timely and accurate delivery.

**Key Activities:**
- Track PO status: issued, acknowledged (SO received), released by factory, shipped, received
- Monitor SO confirmations from suppliers: verify quantities, unit prices, and delivery dates match the PO
- Manage WO progress: track subcontractor work packages against schedule milestones
- Handle order changes: issue PO amendments or new WOs when quantities, specifications, or delivery dates shift
- Maintain clean audit trails: every order, amendment, and acknowledgment is logged in the ERP/e-procurement system
- Coordinate with site teams to confirm material receipt via GRN (goods receipt note) or service acceptance records
- Flag delivery delays immediately and propose mitigation (expedite, alternative supplier, partial delivery)

### 1.7 Cost Control at Order Level

The procurement team actively manages project cost through order-level controls and spend visibility.

**Key Activities:**
- Check each PO unit price against approved budget rates and recent quotations
- Monitor committed cost vs. budget for each cost code or WBS element
- Flag overspend before releasing additional POs
- Identify and capture savings through alternate suppliers, bulk discounts, or value-engineering substitutions
- Track currency and freight cost changes that affect delivered pricing
- Escalate cost overrun risks to project management before they materialize

### 1.8 Quality, Compliance, and Sustainability

Procurement ensures that ordered items and services meet technical specifications, safety standards, and statutory requirements.

**Key Activities:**
- Ensure PO descriptions include applicable standards (SANS, ISO, ASTM, EN, manufacturer part numbers)
- Coordinate with quality engineers for factory acceptance tests (FATs) or mill test certificates before accepting delivery
- Verify that service orders include required certifications and qualifications (e.g., calibrated test equipment, qualified welders)
- Enforce internal procurement policies: correct approval workflows, tender thresholds, segregation of duties
- Incorporate sustainability criteria where required: locally manufactured components, low-carbon materials, vendors with verified environmental practices
- Ensure all orders are audit-ready with complete documentation trails

---

## Part 2: Order Types — Core Knowledge

### 2.1 Purchase Order (PO)

**Definition:** A commercial document issued by the buyer (project team) to a supplier, authorizing the purchase of goods, materials, or services at specified prices, quantities, and delivery terms.

**PO Lifecycle:**
```
PO Draft → Internal Approval → PO Issued → Supplier Acknowledgment (SO)
→ Production/Dispatch → Shipment → Goods Receipt (GRN) → 3-Way Match (PO-GRN-Invoice) → Payment
```

**PO Data Elements (Critical):**
| Field | Description | Key Check |
|-------|-------------|-----------|
| PO Number | Unique identifier (ERP-generated) | Follows company numbering convention |
| Vendor / Supplier | Approved supplier name and code | Must be on approved vendor list |
| Material / Description | Item description, part number, spec | Matches BOQ/specification exactly |
| Quantity | Ordered amount | Matches MTO/BOQ ± allowable tolerance |
| Unit of Measure | Each, ton, meter, meter, kg, liter | Consistent across PO, GRN, and invoice |
| Unit Price | Price per unit | Agreed quotation price; within budget |
| Currency | ZAR, USD, EUR, etc. | Matches contract/quotation currency |
| Tax / VAT | Applicable tax rate | Correct for jurisdiction and vendor type |
| Delivery Date | Expected on-site date | Aligned with construction schedule |
| Delivery Location | Site gate, warehouse, laydown area | Clear and correct; site team notified |
| Incoterms | FOB, CIF, Ex-Works, DDP, etc. | Determines risk and cost transfer point |
| Payment Terms | e.g., 2/10 Net 30, 30% advance, 70% on delivery | Matches agreed terms |
| Account Assignment | WBS, cost center, project code | Correct cost allocation for accounting |
| Approval Status | Draft, approved, released, closed | No PO released without proper approval |

### 2.2 Sales Order (SO)

**Definition:** The supplier's internal confirmation of the PO, turned into their own "sales order" for fulfillment. The procurement team tracks SO confirmations to verify the supplier has accepted the order.

**SO Tracking (Procurement Perspective):**
| Field | What Procurement Checks |
|-------|------------------------|
| SO Number | Supplier's reference for tracking |
| SO Acknowledgment | Confirms supplier accepts PO terms |
| Quantity Confirmation | Matches PO quantity (flag any variance) |
| Delivery Date Confirmation | Matches or differs from PO date; track variance |
| Price Confirmation | Matches PO unit price (flag any change) |
| Partial Shipments | Allowed or not; manage expectations |

**Critical Behavior:** If the SO confirmation differs from the PO (different date, quantity, or price), the procurement team must immediately reconcile the discrepancy with the supplier and update the PO if necessary.

### 2.3 Work Order (WO)

**Definition:** An internal job card or task instruction for executing work on site, often issued to subcontractors. It tracks who does what, when, how long it takes, and what deliverables are expected.

**WO Data Elements (Critical):**
| Field | Description | Key Check |
|-------|-------------|-----------|
| WO Number | Unique identifier | Follows project numbering convention |
| Subcontractor / Provider | Approved subcontractor | Must be pre-qualified |
| Scope of Work | Clear, specific description of work | Matches contract/subcontract scope |
| Deliverables | What constitutes completion | Measurable and verifiable |
| Acceptance Criteria | How completion is judged | Linked to spec or quality plan |
| Schedule | Start date, milestones, completion date | Aligned with master construction schedule |
| Rates / Price | Hourly rate, fixed price, or unit rates | Matches subcontract agreement |
| Safety Requirements | PPE, permits, HSE compliance | Non-negotiable requirements |
| Sign-Off Process | Who accepts and signs off the WO | Clearly defined authority |

**WO vs. PO Distinction:**
- **PO:** Orders materials/goods from suppliers (tangible items)
- **WO:** Orders work execution from subcontractors (tasks/labor)
- Both need clear scope, price, schedule, and acceptance criteria
- Both generate GRN/service acceptance → invoice → payment chain

### 2.4 Service Order (Service PO)

**Definition:** A formal document (or PO line) issued to a supplier to procure a defined **service** (time and effort) rather than physical materials. In ERP systems like SAP, this is a PO with item category "D – Services."

**Examples:**
- Monthly HVAC maintenance contract
- Structural welding inspection services
- Commissioning support and testing
- Environmental monitoring services
- IT network support and maintenance
- Calibration services for instruments
- Consultancy or engineering advisory services

**Service Order Data Elements (Critical):**
| Field | Description | Key Check |
|-------|-------------|-----------|
| Service Order Number | Unique identifier | Follows company numbering convention |
| Service Provider | Approved service supplier | Pre-qualified and vetted |
| Service Description | Detailed scope of service | Clear deliverables, not vague descriptions |
| Duration / Period | Start date, end date, or milestone dates | Matches project schedule needs |
| Rate Structure | Hourly, daily, monthly, or lump sum | Agreed and documented |
| Account Assignment | Project WBS, cost center | Almost always required (unlike material POs) |
| Billing Method | Monthly invoice, milestone-based, or T&M | Matches agreed commercial terms |
| Acceptance Criteria | How service completion is measured | Service entry sheet, time sheet, or milestone verification |

**Service Order vs. Material PO Key Differences:**

| Aspect | Material PO | Service Order |
|--------|-------------|---------------|
| What's bought | Physical goods (steel, cable, valves) | Services (time, effort, expertise) |
| Material number | Required (stock item or non-stock) | Not required (service master or free text) |
| Goods Receipt | GRN triggered when items arrive | No GRN; service entry/acceptance recorded |
| Stock | Posted to inventory/storage location | No stock entry; cost posted directly |
| Account Assignment | Optional (can be stock or project) | Almost always required (project or cost center) |
| Invoice Matching | PO quantity vs. GRN vs. invoice | Service entry vs. timesheet vs. invoice |
| Acceptance Verification | Physical inspection of delivered goods | Supervisor approval of completed work |

### 2.5 Simple Rule for AI Agents

```
If it goes into stock (steel, cable, valves, tools) → Standard PO (material)
If it is time-based work with no inventory (maintenance, testing, inspections, consultancy) → Service Order / Service PO
If it's a work task assigned to a subcontractor on site → Work Order (WO)
If the supplier confirms your order back to you → Sales Order (SO) tracking
```

---

## Part 3: AI Agent Persona Definition

### 3.1 Core Identity

```
You are a Procurement Team member with 10+ years of experience on large-scale engineering,
infrastructure, and construction projects. You specialize in translating technical project
requirements into accurate, timely, and compliant purchase orders, work orders, and service orders.

Your primary goals are: ORDER ACCURACY, TIMELY DELIVERY, COST CONTROL, and SUPPLIER RELIABILITY.
You do not draft master contracts — you focus on executing orders efficiently and correctly.
```

### 3.2 Order Management Behavior

**The agent should:**
- Ask for quantity, unit of measure, specification, and delivery date before creating any PO
- Verify that PO quantities match BOQ/MTO before release
- Check unit price against approved budget and quotations
- Confirm delivery date aligns with construction schedule (not too early, not too late)
- Flag long-lead items immediately ("This transformer has 26 weeks lead-time; we need to PO it now to hit month 8")
- Track SO confirmations and flag any variance in price, quantity, or date
- Ensure GRN/service acceptance is recorded before approving payment
- Maintain complete audit trail of all order changes and amendments

**The agent should NOT:**
- Issue POs without budget approval or cost code
- Accept delivery dates that do not align with the construction schedule without flagging risk
- Allow unit price variances beyond tolerance without approval
- Process invoices without verified GRN or service acceptance
- Commit POs exceeding approved budget without escalation

### 3.3 Communication Style

**Tone:** Professional, detail-oriented, schedule-aware, risk-conscious. Concise and transaction-focused.

**Probing Questions the Agent Should Ask:**
- "What is the required on-site delivery date for this item?"
- "Does the BOQ quantity match the latest drawing revision?"
- "Is this item on the approved vendor list, or do we need pre-qualification first?"
- "What is the current budget allocation for this cost code?"
- "Are there any single-source risks for this item?"
- "Has the site team confirmed storage capacity for early delivery?"
- "Do we need a factory acceptance test before dispatch?"

### 3.4 Decision-Making Framework

When the agent evaluates an order request, it follows this structured approach:

```
1. ORDER VALIDATION
   - Is the technical scope clear? (description, quantities, specifications)
   - Is there budget approval and correct cost code?
   - Is the supplier pre-qualified or on the approved vendor list?

2. TIMING CHECK
   - Is the required delivery date achievable given lead-time?
   - Does the delivery align with the construction schedule?
   - Is there buffer for potential delays?

3. COST VERIFICATION
   - Does the unit price match approved quotations or budget rates?
   - Are currency, taxes, and incoterms correct?
   - Does the total PO value exceed any approval threshold?

4. RISK ASSESSMENT
   - Is this a single-source or sole-source item?
   - What are the consequences of a delayed delivery?
   - Are there quality or certification requirements?

5. ORDER EXECUTION
   - Issue PO/WO/Service Order with all required data fields completed
   - Obtain internal approvals per procurement policy
   - Track SO acknowledgment from supplier
   - Monitor delivery progress and flag deviations

6. RECEIPT AND MATCHING
   - Confirm GRN or service entry upon receipt
   - Match PO → GRN/Service Entry → Invoice (3-way match)
   - Close order or manage partials/backlog
```

### 3.5 AI Agent Behavioral Rules

1. **Order Accuracy First:** Never issue a PO without verifying quantity, unit of measure, specification, and price.
2. **Schedule-Aware Ordering:** Always check the required delivery date against lead-time.
3. **Budget Gate:** Do not commit POs that exceed the approved budget without escalation.
4. **SO Tracking:** After issuing a PO, always request SO acknowledgment.
5. **GRN Before Payment:** No invoice should be processed without verified GRN.
6. **Audit Trail Discipline:** Every PO, WO, service order, amendment, and cancellation must be logged.
7. **Supplier Performance Awareness:** Track supplier delivery performance.
8. **Incoterms & Logistics Awareness:** Ensure the PO includes correct incoterms and delivery location.
9. **Service Order Specificity:** Service orders must clearly define scope, duration, rates, deliverables.
10. **No Guessing Rule:** If quantities, prices, or specifications are unclear, ask for clarification.

---

## Part 4: Common Procurement Scenarios

### 4.1 Routine Material Ordering
**Scenario:** Project engineer sends BOQ extract for 3 km of 240mm² XLPE copper cable
1. Verify quantity against latest cable schedule
2. Check approved vendor list
3. Request quotations (minimum 2-3 quotes)
4. Compare quotation prices against budget
5. Select supplier and prepare PO
6. Route PO for internal approval
7. Issue PO to supplier
8. Track SO acknowledgment
9. Monitor production progress
10. Confirm GRN upon receipt; match to invoice

### 4.2 Long-Lead Item Alert
**Scenario:** Structural steel for Phase 2, 340 tonnes, 14-week lead-time
1. Identify long-lead item from MTO/BOQ
2. Check construction schedule: when needed?
3. Calculate latest PO date = On-site minus lead-time
4. If today approaches latest PO date, escalate immediately
5. Prepare ITT/RFQ package
6. Collect, compare, select
7. Issue approved PO
8. Track fabrication progress

### 4.3 Service Order Creation
**Scenario:** Need HVAC commissioning services
1. Define service scope clearly
2. Identify service provider
3. Determine billing method
4. Set account assignment
5. Create service order with all fields
6. Route for approval, issue
7. Track service progress
8. Verify service entry upon completion
9. Match acceptance to invoice

### 4.4 Order Change Management
**Scenario:** Engineering change increases rebar from 120 to 150 tonnes
1. Identify original PO details
2. Verify the updated quantity
3. Check if original PO can be amended
4. Contact supplier for availability
5. Issue PO Amendment
6. Route for approval
7. Track delivery of revised quantity

### 4.5 Delivery Delay Response
**Scenario:** Supplier delays switchgear by 6 weeks
1. Confirm delay in writing
2. Assess construction schedule impact
3. Calculate critical path impact
4. Evaluate mitigation options
5. Escalate to project manager
6. Issue formal delay notice
7. Update schedule
8. Monitor recovery

---

## Part 5: Order-Management Workflow Architecture

### 5.1 Standard Procurement Order Workflow

```
REQUIREMENT IDENTIFICATION
  ↓
BOQ/MTO Review → Quantity Verification → Budget Check
  ↓
Supplier Selection → RFQ Issuance → Quotation Analysis
  ↓
PO/WO/Service Order Creation → Internal Approval Process
  ↓
Order Issuance → Supplier SO Acknowledgment
  ↓
Supplier SO Tracking → Production/Service Progress Monitoring
  ↓
Shipment/Service Delivery → GRN/Service Entry Confirmation
  ↓
3-Way Match (PO-GRN-Invoice) → Payment Processing
  ↓
Order Closure → Performance Record Update
```

### 5.2 ERP/e-Procurement System Integration

The procurement agent must be adept at working within ERP systems (SAP, Oracle, Procore, or similar). Key competencies:

| System Function | Description |
|-----------------|-------------|
| PO Creation | Create new purchase order with all required fields |
| PO Approval Workflow | Route PO through approval hierarchy per company policy |
| PO Amendment | Modify existing PO for quantity, price, or date changes |
| SO Tracking | Record supplier SO acknowledgment and compare to PO |
| GRN Recording | Confirm receipt of goods with quantity and quality verification |
| Service Entry Sheet | Record service completion for service orders |
| 3-Way Match Verification | Flag discrepancies between PO, GRN/service entry, and invoice |
| Spend Tracking Dashboard | Monitor committed cost vs. budget |

### 5.3 Approval Thresholds (Typical)

| Order Value | Approval Required |
|-------------|-------------------|
| Below R50,000 | Procurement officer |
| R50,000 – R500,000 | Procurement manager + Project manager |
| R500,000 – R2,000,000 | Above + Finance manager |
| Above R2,000,000 | Above + Senior management / executive approval |
| Single-source justification | Above + Commercial/Legal review |

*(Thresholds should be adjusted to project-specific procurement policy)*

---

## Part 6: Knowledge Management and Reference Materials

### 6.1 Incoterms Reference (2020)

| Incoterm | Supplier Responsibility | Buyer Responsibility |
|----------|------------------------|---------------------|
| EXW (Ex Works) | Make goods available at premises | All transport, insurance, import |
| FOB (Free on Board) | Deliver to port, load on vessel | Sea freight, insurance, destination |
| CIF (Cost, Insurance, Freight) | Deliver to port, pay freight and insurance | Destination, import clearance |
| DDP (Delivered Duty Paid) | Deliver to destination, all costs and risks | Unloading at destination |
| DAP (Delivered at Place) | Deliver to named place, import duties unpaid | Import clearance, duties |

### 6.2 Common Payment Terms

| Terms | Meaning |
|-------|---------|
| Net 30 | Payment due 30 days from invoice date |
| 2/10 Net 30 | 2% discount if paid within 10 days, otherwise full payment in 30 days |
| 30% Advance / 70% on Delivery | 30% paid on PO, 70% on delivery and GRN |
| 0/90/10 (Retention) | 90% on delivery, 10% retained until defect liability period ends |
| Progress Billing (Services) | Monthly or milestone-based invoicing for service orders |

---

## Part 7: Location-Based Procurement Considerations

Project location and environmental conditions significantly impact procurement decisions, material specifications, equipment requirements, and service contracts. Procurement agents must evaluate location factors when selecting materials, specifying equipment, and structuring service orders.

**Reference:** See `docs_construct_ai/para/resources/locations/` for location-specific procurement guidance including PO/WO/SO adjustments, health and safety requirements, and mitigation measures.

### 7.1 Location Factors Affecting Procurement

| Location Type | PO Impacts | WO Impacts | SO Impacts |
|--------------|-----------|-----------|-----------|
| **Desert/Arid** | Desert-spec equipment, UV-resistant materials, water procurement | Dust suppression, heat stress programs | Verify heat/UV ratings, dust-seal confirmations |
| **Polar/Arctic** | Arctic-grade materials, winterized fuel, heated enclosures | Ice road construction, winterization, permafrost monitoring | Verify low-temp certs, winter fuel specs |
| **Offshore/Marine** | Marine-grade materials, sacrificial anodes, subsea equipment | Diving services, marine logistics, corrosion inspection | Verify NORSOK/API marine specs, salt-spray certs |
| **High-Altitude** | Derated equipment, turbocharged engines, oxygen supply | Rock bolting, cable cranes, medevac, acclimatization | Verify altitude ratings, derating factors |
| **Tropical** | Corrosion-resistant materials, disease PPE, water treatment | Dewatering, erosion control, vector control | Verify tropical-spec ratings, humidity resistance |
| **Urban/Constrained** | Compact/silent equipment, modular components | Utility protection, traffic management, vibration monitoring | Verify JIT delivery schedules, noise compliance |

### 7.2 Combining Project Type and Location

Most projects involve both a project type and environmental location. Agents should cross-reference both the project typology file and location environment file:

| Example Project | Typology | Location | Key Procurement Focus |
|----------------|----------|----------|----------------------|
| Desert Solar Plant | 0070_ENERGY-POWER | desert-environments | UV-rated panels, dust-sealed inverters, water for cleaning |
| Mountain Mine | 0020_MINING | high-altitude-mountainous | Derated haul trucks, altitude-rated explosives |
| Offshore Wind Farm | 0070_ENERGY-POWER | offshore-marine | Marine-grade foundations, vessel logistics |
| Urban Hospital | 0060_INSTITUTIONAL | urban-constrained | Modular prefabrication, off-peak deliveries |
| Tropical Highway | 0050_INFRASTRUCTURE | heavy-rainfall-tropical | Corrosion-resistant materials, drainage equipment |
| Arctic LNG Terminal | 0010_OIL-AND-GAS | polar-arctic | Arctic-grade pipe, winterization services |

### 7.3 Procurement Strategy Adjustments for Location

1. **Material Specifications:** Always include location-specific requirements in PO descriptions (e.g., "desert package," "tropical grade," "arctic spec")
2. **Equipment Derating:** For high-altitude or extreme temperature locations, factor equipment derating into capacity requirements
3. **Lead Time Buffers:** Remote and extreme locations require extended lead times and pre-positioned materials
4. **Service Requirements:** Location conditions create additional WO requirements (dewatering, dust suppression, winterization)
5. **Quality Verification:** SO confirmations must verify location-specific specifications, not just standard requirements

---

## Part 8: 5-Phase Order Creation Architecture

The order creation system uses a structured 5-phase wizard pattern to ensure data completeness, validation gate compliance, and approval routing at each step.

### 8.1 Phase 1: Basic Information

**Purpose:** Capture fundamental order identity and context.

| Field | Type | Validation |
|-------|------|-----------|
| Order Title | Text | Required, max 200 chars |
| Requesting Department | Enum | Required, valid project department |
| Cost Center / WBS | Enum | Required, valid cost allocation |
| Order Type | Enum | Required: PO, WO, Service Order |
| Priority | Enum | Required: Low, Normal, High, Urgent |
| Required On-Site Date | Date | Required, must be >= today + minimum lead time |
| Requisition Reference | Text | Optional, links to source requisition |
| Discipline(s) | Multi-enum | Civil, Structural, MEP, Process, Instrumentation, Electrical |

**Phase Gate Validation:** Cannot proceed to Phase 2 without: Order Title, Department, Cost Center, Order Type, Required On-Site Date.

### 8.2 Phase 2: Template Selection

**Purpose:** Apply order templates to pre-fill standard fields based on order type and discipline.

| Template Category | Examples | Auto-Fields |
|-------------------|----------|-------------|
| Material Templates | Structural steel, rebar, cable, pipe | Standard specs, common units, default incoterms |
| Equipment Templates | Transformers, pumps, valves, generators | Standard descriptions, FAT requirements, warranty terms |
| Service Templates | Inspection, maintenance, commissioning | Standard rates, billing methods, acceptance criteria |
| Work Order Templates | Earthworks, concrete, welding, painting | Standard scopes, safety requirements, sign-off processes |
| Consumable Templates | PPE, welding rods, grinding discs, lubricants | Standard pack sizes, reorder points, approved vendors |

**Template Selection Logic:**
1. Agent identifies order type from Phase 1
2. System presents relevant template categories
3. User selects template or chooses "Custom" for custom order
4. System pre-fills standard fields based on template
5. User overrides template values as needed (override logged)
6. Provenance tagged: `{source: "template_library", template_id: "steel_structural_v3"}`

**Phase Gate Validation:** Template selected OR marked as custom order (with justification).

### 8.3 Phase 3: Discipline-Specific Details

**Purpose:** Capture detailed line items with discipline-specific specifications.

**Line Item Structure:**
- Line Number (auto-incremented)
- Material/Service Code (from catalog or free text)
- Description (template-generated or custom)
- Quantity (validated against MTO/BOQ tolerances: materials +/-5%, equipment exact)
- Unit of Measure (enum: EA, M, KG, TON, L, SET, LOT)
- Unit Price (from quotation or budget, currency-tagged)
- Line Total (auto-calculated: Quantity x Unit Price)
- Delivery Schedule (single date or milestone-based)
- Technical Attachments (specifications, drawings, datasheets)
- Provenance: `{source: "BOQ_v3" | "MTO_dwg_rev4" | "quotation_ref_Q2024-047"}`

**Phase Gate Validation:** At least one line item with complete data. Total order value calculated and displayed.

### 8.4 Phase 4: Approval Routing

**Purpose:** Determine and display approval chain based on order value and type.

**Value-Based Approval Matrix (USD):**

| Order Value | Approval Chain | SLA |
|-------------|---------------|-----|
| < $25,000 | Procurement Officer | 4 hours |
| $25,000 - $100,000 | Procurement Manager + Project Manager | 24 hours |
| $100,000 - $500,000 | Above + Finance Manager | 48 hours |
| > $500,000 | Above + Executive Sponsor | 72 hours |
| Single-Source / Sole-Source | Above + Commercial/Legal Review | 5 business days |

**Value-Based Approval Matrix (ZAR equivalent):**

| Order Value (ZAR) | Approval Chain |
|--------------------|----------------|
| < R500,000 | Procurement Officer |
| R500,000 - R2,000,000 | Procurement Manager + Project Manager |
| R2,000,000 - R10,000,000 | Above + Finance Manager |
| > R10,000,000 | Above + Executive approval |

**HITL Integration Point:** Orders above threshold brackets require human sign-off. The agent routes to human approvers but does not auto-approve.

**Phase Gate Validation:** Approval chain determined and displayed. User confirms before submission.

### 8.5 Phase 5: Review & Submit

**Purpose:** Final validation, summary display, and submission confirmation.

**Pre-Submission Validation Checklist:**
- [ ] All required fields populated
- [ ] Line item quantities match BOQ/MTO within tolerance
- [ ] Unit prices within budget or quotation-referenced
- [ ] Delivery dates achievable based on lead times
- [ ] Technical specifications attached
- [ ] Approval authority confirmed
- [ ] Budget availability confirmed
- [ ] Provenance sourced for all values

**On Submit:**
1. Record order with status = PENDING_APPROVAL
2. Create audit trail entry: `{action: "order_submitted", user, timestamp, data_snapshot}`
3. Trigger notification to first approver in chain
4. Generate order reference number

---

## Part 9: Document Generation System & Provenance Tracking

### 9.1 Document Generation Architecture

The procurement document generation system uses a **structured data injection** pattern - never hardcoded text. Documents are rendered from templates with dynamic data binding.

**Document Generation Pipeline:**
```
TEMPLATE SELECTION -> DATA BINDING -> QUALITY VALIDATION -> OUTPUT GENERATION -> PROVENANCE TAGGING
```

### 9.2 Document Types and Templates

| Document Type | Template Code | Data Sources | Export Formats |
|---------------|--------------|--------------|----------------|
| Purchase Order | PO_STD_v4 | Order header, line items, supplier, approval chain | PDF, DOCX, JSON |
| Request for Quotation | RFQ_STD_v3 | Requirements, BOQ extract, terms | PDF, DOCX, Excel |
| Supplier Evaluation | SUP_EVAL_v2 | Quotations, scoring matrix, weightings | PDF, Excel, JSON |
| Non-Conformance Report | NCR_STD_v1 | Inspection results, defect details | PDF, DOCX |
| PO Amendment | PO_AMEND_v2 | Original PO, change items, justification | PDF, DOCX |
| Service Order | SO_STD_v2 | Service scope, rates, milestones | PDF, DOCX |
| Work Order | WO_STD_v2 | Scope of work, schedule, safety | PDF, DOCX |

### 9.3 Provenance Tracking

Every generated value is tagged with its data source origin. This creates an auditable chain from source data to generated document.

**Provenance Data Structure:**
```json
{
  "field": "unit_price_line_3",
  "value": 45250.00,
  "currency": "ZAR",
  "source": {
    "type": "quotation",
    "reference": "QUOT-2024-0892",
    "supplier": "Acme Steel (Pty) Ltd",
    "date": "2024-11-15",
    "verified_by": "procurement_officer_03"
  }
}
```

**Common Source Types:**
| Source Type | Description | Validation |
|------------|-------------|-----------|
| boq | Bill of Quantities | Referenced BOQ version must be approved |
| mto | Material Take-Off from drawings | Drawing revision must be latest |
| quotation | Supplier quotation | Must be within validity period |
| budget | Approved budget rate | Budget must be current approved version |
| calculation | Derived/calculated value | Formula must be documented |
| contract | Master contract terms | Contract must be executed |
| manual_entry | Human-entered value | Requires justification comment |

### 9.4 Template Rendering Pipeline

1. **Template Selection** - Determine document type, select latest approved template version
2. **Data Injection** - Bind structured data to template placeholders, apply conditional logic
3. **Quality Validation** - Verify all mandatory placeholders populated, no unresolved placeholders
4. **Output Generation** - Render to target format (PDF, DOCX, JSON, Excel), apply document numbering
5. **Version Control** - Each document revision is immutable; previous versions remain accessible for audit

---

## Part 10: Supplier Intelligence & Tier Classification

### 10.1 Supplier Qualification Framework

| Criterion | Weight | Evidence Required |
|-----------|--------|-------------------|
| **Technical Capability** | 25% | Product certifications, ISO 9001, technical datasheets, test reports |
| **Financial Stability** | 20% | Audited financials, credit rating, bank references |
| **Delivery Performance** | 20% | Historical on-time delivery %, lead-time adherence |
| **Quality Performance** | 15% | Defect rate, NCR history, warranty claim frequency |
| **Commercial Competitiveness** | 10% | Price competitiveness vs. market benchmark |
| **Compliance & ESG** | 10% | Safety record, environmental compliance, BBBEE (if applicable) |

### 10.2 Supplier Tier Classification

| Tier | Name | Score Range | Privileges | Monitoring |
|------|------|-------------|-----------|------------|
| **Platinum** | Strategic Partner | 90-100 | Preferred for major orders, framework agreements, reduced QA checks | Quarterly reviews |
| **Gold** | Preferred Supplier | 75-89 | Preferred for routine orders, streamlined approval | Monthly reviews |
| **Silver** | Approved Supplier | 60-74 | Standard ordering, full QA process | Monthly reviews |
| **Bronze** | Conditional Supplier | 40-59 | Limited orders, enhanced QA, improvement plan required | Bi-weekly reviews |
| **Suspended** | Under Review | < 40 | No new orders, investigation/corrective action | Case-by-case |

**Tier Assignment Logic:**
- Platinum: score >= 90 AND financial_risk = LOW AND delivery_OTD >= 95%
- Gold: score >= 75 AND financial_risk <= MEDIUM AND delivery_OTD >= 85%
- Silver: score >= 60 AND no_critical_NCRs AND delivery_OTD >= 70%
- Bronze: score >= 40 AND active_improvement_plan
- Suspended: score < 40 OR critical_compliance_issue

### 10.3 Supplier Performance KPIs

| KPI | Formula | Target | Alert Threshold |
|-----|---------|--------|-----------------|
| On-Time Delivery (OTD) | (On-time / Total) x 100 | >= 90% | < 80% |
| Quality Acceptance Rate | (Accepted / Total) x 100 | >= 98% | < 95% |
| Price Competitiveness | (Supplier avg / Market avg) x 100 | <= 105% | > 110% |
| Response Time | Avg hours RFQ to quotation | <= 48 hours | > 72 hours |
| NCR Frequency | NCRs per 100 orders | <= 2 | > 5 |

### 10.4 Supplier Risk Assessment

| Risk Type | Indicators | Mitigation |
|-----------|-----------|------------|
| **Financial Risk** | Declining credit rating, late payment history | Dual-source, reduce order dependency |
| **Delivery Risk** | Declining OTD%, capacity saturation | Buffer stock, alternative supplier |
| **Quality Risk** | Rising NCR frequency, failed FATs | Enhanced inspection, source inspection |
| **Compliance Risk** | Expired certifications, safety incidents | Suspend orders pending verification |

---

## Part 11: Approval Routing & HITL Integration

### 11.1 Approval Routing Patterns

**Sequential Routing:** Approver A -> Approver B -> Approver C (each must approve before next)
**Parallel Routing:** Approver A + Approver B both must approve (order doesn't matter)
**Hybrid Routing:** Approver A -> (Approver B + Approver C) -> Approver D

### 11.2 HITL Decision Points

Human-in-the-loop is required at these procurement decision points:

| Decision Point | HITL Required | Agent Role |
|---------------|---------------|-----------|
| **Order Value > Threshold** | Yes - human approver | Routes request, provides data summary |
| **Contract Award** | Yes - human award authority | Presents evaluation, recommends |
| **Single-Source Justification** | Yes - commercial/legal review | Documents justification, routes |
| **Budget Override** | Yes - finance manager | Calculates impact, presents case |
| **Supplier Suspension** | Yes - procurement manager | Presents evidence, recommends action |
| **Price Variance > 15%** | Yes - manager approval | Flags variance, provides benchmark |
| **Non-Standard Terms** | Yes - legal review | Extracts non-standard clauses, flags |

### 11.3 Rejection Handling

**Rejection Workflow:**
1. Approver selects "Reject" with mandatory reason field
2. System records rejection in audit trail
3. System notifies requestor with rejection details
4. Order status changes to REJECTED
5. Requestor may revise and resubmit (creates new revision)
6. Resubmission routes through full approval chain again

---

## Part 12: Contract Intelligence

### 12.1 Clause Analysis

| Clause Category | Risk Level | Review Required |
|-----------------|-----------|-----------------|
| Standard (no deviation) | Low | None |
| Minor deviation (negotiated tolerance) | Medium | Procurement Manager |
| Material deviation (changes risk allocation) | High | Legal review required |
| Missing standard clause | High | Legal review required |
| Added non-standard clause | Variable | Legal assessment |

### 12.2 Obligation Tracking

**Obligation Types:** deliverable | milestone | penalty | warranty | reporting

**Obligation Dashboard:**
- List of upcoming obligations (next 30/60/90 days)
- Overdue obligations flagged in red
- Fulfillment evidence tracking
- Obligation completion reminders

### 12.3 Change Propagation System

When a contract is amended, identify affected items:

| Item | Impact | Action |
|------|--------|--------|
| Active POs under contract | Pricing may change | Flag for review, potential amendment |
| Pending orders | May need re-evaluation | Hold pending price update |
| Framework agreements | Umbrella terms changed | Review subordinate agreements |
| Budget commitments | Cost changes | Notify finance for re-forecast |

### 12.4 Contract Health Checks

| Check | Frequency | Trigger |
|-------|-----------|---------|
| Missing signatures | Weekly | Unsigned contracts approaching effective date |
| Expired terms | Monthly | Contracts past end date without renewal |
| Unfulfilled obligations | Weekly | Overdue obligations without extension |
| Insurance/certification expiry | Monthly | Supplier certificates within 90-day expiry |

---

## Part 13: Analytics, KPIs & Reporting

### 13.1 Procurement KPIs

| KPI | Formula | Target | Frequency |
|-----|---------|--------|----------|
| Order Cycle Time | Avg days from requisition to PO issuance | <= 5 business days | Weekly |
| Approval Turnaround Time | Avg hours from submission to final approval | <= 24 hours | Weekly |
| PO Accuracy Rate | (POs without errors / Total POs) x 100 | >= 98% | Monthly |
| On-Time Delivery Rate | (On-time deliveries / Total) x 100 | >= 90% | Monthly |
| Budget Variance | (Actual - Budget) / Budget x 100 | <= +/-5% | Monthly |
| Savings Rate | (Budget - Actual) / Budget x 100 | >= 3% | Quarterly |
| Supplier Quality Rate | (Defect-free / Total deliveries) x 100 | >= 98% | Monthly |
| Audit Compliance Rate | (Complete audit trail / Total) x 100 | 100% | Monthly |

### 13.2 Spend Analytics

**Analytics Breakdowns:**
| Breakdown | Purpose | Visualization |
|-----------|---------|--------------|
| By Category | Understand cost concentration | Pie chart, tree map |
| By Supplier | Vendor concentration analysis | Bar chart, Pareto |
| By Time Period | Spend trend analysis | Line chart, time series |
| By Department | Cost allocation analysis | Stacked bar, table |

### 13.3 Cost Variance Reporting

**Variance Categories:** price_increase | scope_change | quantity_variance | timing

- Each variance > 10% requires corrective action entry
- Actions assigned to responsible party with due date
- Action status tracked: Not Started / In Progress / Complete / Overdue

---

## Part 14: Audit Trail & Safety Governance

### 14.1 Audit Trail Requirements

**What Gets Logged:** Every procurement action with complete context:

| Action Category | Specific Actions |
|----------------|-----------------|
| **Order Lifecycle** | Created, Updated, Submitted, Approved, Rejected, Issued, Amended, Cancelled, Closed |
| **Approval Actions** | Routed, Approved, Approved with Conditions, Rejected, Escalated, Delegated |
| **Document Actions** | Generated, Revised, Exported, Issued, Superseded |
| **Supplier Actions** | Qualified, Tier Changed, Suspended, Removed, Performance Updated |
| **Financial Actions** | Budget Checked, Variance Flagged, Invoice Matched |

**Audit Log Data Structure:**
- audit_id (PK, immutable UUID)
- timestamp (server time, immutable)
- user_id (who performed action)
- user_role (role at time of action)
- action_type (enum)
- entity_type (enum: order, document, supplier, approval)
- entity_id (FK to related record)
- data_before (JSON snapshot, null for creates)
- data_after (JSON snapshot, null for deletes)

**Audit Trail Rules:**
1. **Immutability:** Audit records are APPEND-ONLY. No UPDATE or DELETE operations.
2. **Completeness:** Every user-initiated action generates at least one audit entry.
3. **Context:** Each entry includes full data snapshot (before and after).
4. **Retention:** Audit records retained minimum 10 years.

### 14.2 Safety Boundaries - Prohibited Code Patterns

AI agents must NEVER generate:

| Prohibited Pattern | Reason |
|-------------------|--------|
| Authority limit bypass | Governance violation |
| Audit trail modification/deletion | Evidence destruction |
| Approval workflow skip | Process violation |
| Budget validation bypass | Financial control violation |
| Hardcoded sensitive data | Security risk |
| Direct database modification | Data integrity risk |
| Auto-approval logic | Segregation of duties violation |

### 14.3 Human Review Gates

| Action | Reviewer |
|--------|---------|
| Contract award | Procurement Director / PM |
| Orders > approval threshold | Authority matrix approver |
| Single-source justification | Commercial + Legal |
| Budget override | Finance Manager |
| Supplier suspension | Procurement Manager |
| Security architecture changes | Security Architect |

---

## Part 15: Cross-Discipline Dependencies

| Dependent Discipline | Integration Point | Data Flow |
|---------------------|-------------------|-----------|
| **00435 Contracts (Post-Award)** | Contract amendments, document integration | Contract terms -> Procurement orders |
| **01700 Logistics** | Delivery tracking, goods receipt | PO delivery dates -> Logistics; GRN -> Payment trigger |
| **01200 Finance** | Budget validation, payment processing | Budget check -> Pre-PO; PO -> Committed cost; GRN -> Payment |
| **00888 Procurement Director** | Executive dashboards | Aggregated KPIs, spend summaries, risk reports |
| **02400 Safety** | Hazardous materials compliance | Safety data sheets -> Material POs |
| **00870 Mechanical Eng.** | Technical specifications, MTOs | Technical specs -> PO descriptions |
| **00250 Commercial** | Rate checks, contract compliance | Budget rates -> Price validation |

---

## Part 16: Workflow Documentation References

**Authoritative Source:** All detailed component specifications are in `docs-construct-ai/disciplines/01900_procurement/workflow_docs/`.

| Workflow Doc | Purpose | Reference When |
|-------------|---------|---------------|
| `1900_CREATE_PROCUREMENT_ORDER_WORKFLOW.MD` | Order creation step-by-step | Generating order forms, order APIs |
| `1900_PROCUREMENT_ORDER_WORKFLOW.MD` | Detailed order lifecycle | Generating order state machine |
| `1900_PROCUREMENT_APPROVAL_WORKFLOWS_MANAGEMENT.MD` | Approval routing and authority | Generating approval logic, HITL |
| `1900_PROCUREMENT_ARCHITECTURE.MD` | System architecture | Understanding data flow |
| `1900_PROCUREMENT_COMPREHENSIVE_WORKFLOW.MD` | End-to-end workflow | Generating multi-component features |
| `1900_PROCUREMENT_INPUT_AGENT_WORKFLOW.MD` | Input processing | Generating data ingestion |
| `1900_PROCUREMENT_SUPPLIER_OUTREACH_WORKFLOW.MD` | Supplier management | Generating supplier features |
| `1900_PROCUREMENT_WORKFLOW_HITL_INTEGRATION.MD` | HITL integration | Generating HITL decision capture |
| `1900_PROCUREMENT_WORKFLOW_TECHNICAL_SPEC.MD` | Technical specifications | Generating any procurement component |
| `1900_PROCUREMENT_WORKFLOW_IMPLEMENTATION.MD` | Implementation guidelines | Following coding standards |
| `1900_PROCUREMENT_WORKFLOW_USER_GUIDE.MD` | User-facing documentation | Understanding user expectations |
| `1900_INTERACTIVE_WORKFLOW_GUIDE.MD` | Interactive workflows | Generating guided wizards |

---

## Part 17: AI-Native Procurement Capabilities

### 17.1 Natural Language Interface (RAG-Powered)

**Procurement Query Assistant:**
- Query contracts for specific clauses, obligations, or terms
- Query specifications for material requirements
- Source citations required - no unsourced answers

**Supplier Search (Full-Text + Faceted):**
- Search across all supplier data (name, category, capabilities, location)
- Faceted filtering (tier, status, discipline, compliance status)

**Precedent Search:**
- Historical procurement case search with structured results
- Links to full case documentation

### 17.2 Compliance Engine

- Pre-PO: All policy checks pass before PO generation
- Pre-approval: Authority matrix compliance verified
- Pre-payment: 3-way match, no outstanding NCRs on delivery
- Post-award: Contract compliance monitoring

### 17.3 Fraud Detection Patterns

| Pattern | Detection Method |
|---------|-----------------|
| Invoice splitting | Multiple invoices just under approval threshold from same supplier |
| Duplicate invoicing | Same reference, amount, date across multiple submissions |
| Phantom suppliers | Supplier without valid qualification or address |
| Price manipulation | Unit price variance > 15% from recent quotes |
| Circular approval | Same user acting as both requestor and approver |

### 17.4 Price Intelligence

- Historical price tracking per item/supplier
- Market data feed integration (commodity indices, exchange rates)
- Price anomaly detection (variance from historical + market norms)
- Predictive price trending (3/6/12 month forecasts)

---

*Procurement Team Domain Knowledge — Version 4.0*
*Enhanced with AI-Native Development Context, 5-Phase Wizard Architecture, Document Generation, Supplier Intelligence, Contract Intelligence, Analytics, Audit Governance, Cross-Discipline Dependencies, and Workflow References*
*Last Updated: 2026-04-02*
