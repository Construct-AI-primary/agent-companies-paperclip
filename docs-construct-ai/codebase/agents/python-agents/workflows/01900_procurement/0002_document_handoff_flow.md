---
memory_layer: durable_knowledge
para_section: pages/codebase/agents
gigabrain_tags: agents, codebase, ai-automation
documentation
openstinger_context: agent-development, ai-systems
last_updated: 2026-03-21
related_docs:
  - codebase/agents/
  - disciplines/
---
# 15 - Document Handoff Flow

## Overview

This document defines the clear handoff process between each document type in the procurement workflow. Each document passes specific data and triggers the generation of the next document in the sequence.

## Document Sequence Flow

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                         PROCUREMENT DOCUMENT HANDOFF FLOW                            │
├─────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                      │
│  ┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐       │
│  │    CHAT     │────▶│   PREVIEW   │────▶│   HANDOFF   │────▶│ SCOPE OF    │       │
│  │  (Input)    │     │ (Validate)  │     │ (Create)    │     │ WORK        │       │
│  └─────────────┘     └─────────────┘     └─────────────┘     └─────────────┘       │
│        │                                                           │                │
│        │                                                           │                │
│        ▼                                                           ▼                │
│  ┌─────────────┐                                           ┌─────────────┐         │
│  │ Extracted   │                                           │  APPENDIX   │         │
│  │ Data Object │                                           │     A-F     │         │
│  └─────────────┘                                           └─────────────┘         │
│                                                                                      │
└─────────────────────────────────────────────────────────────────────────────────────┘
```

## Handoff 1: Chat → Preview

### Trigger
User clicks "Preview" button or agent detects sufficient data completeness.

### Data Passed
```javascript
const handoffData = {
  sessionId: "session-123",
  extractedData: {
    procurement_type: { value: "Equipment" },
    items: [...],
    estimated_value: { value: 125000 },
    destination_country: { name: "Guinea", code: "GN" },
    cdc_required: true,
    importer_nif: { value: "NIF123456789" },
    importer_address: { value: "123 Mining District, Conakry" },
    timeline: { timeframe: "Standard (2-4 weeks)" },
    requirements: { value: "None" }
  },
  messages: [...], // Full conversation history
  completenessScore: 85
};
```

### Validation Checks
| Check | Condition | Action |
|-------|-----------|--------|
| Required Fields | `procurement_type`, `items`, `estimated_value` present | Block if missing |
| CDC Requirements | `destination_country.code === "GN"` | Require NIF and address |
| Value Match | `sum(items.amount) === estimated_value` | Warn if mismatch |

### Next State
`currentState = 'preview'`

---

## Handoff 2: Preview → Handoff (Order Creation)

### Trigger
User clicks "Proceed to Submit" after validation passes.

### Data Passed
```javascript
const handoffData = {
  sessionId: "session-123",
  extractedData: { ... }, // Complete extracted data
  validationStatus: {
    isValid: true,
    errors: [],
    warnings: []
  },
  specialistAgents: {
    templateAnalysis: { ... },
    requirementsExtraction: { ... },
    complianceValidation: { ... },
    fieldPopulation: { ... },
    qualityAssurance: { ... },
    finalReview: { ... },
    assignment: { ... }
  }
};
```

### Validation Checks
| Check | Condition | Action |
|-------|-----------|--------|
| Validation Status | `isValid === true` | Block if false |
| Completeness | `completenessScore >= 70%` | Warn if below |
| Agent Workflow | All 7 agents completed | Block if incomplete |

### API Call
```javascript
POST /api/procurement/agent/handoff
{
  session_id: "session-123",
  extracted_data: { ... }
}
```

### Response
```javascript
{
  success: true,
  createdOrder: {
    order_number: "PO-2026-0001",
    id: "order-uuid"
  },
  sowData: {
    sowSections: { ... } // Only included if procurement category requires SOW
  },
  requiresSOW: true // or false based on procurement_categories.requires_sow
}
```

### Conditional Next State
```javascript
// Check if SOW is required for this procurement category
const procurementCategory = await getProcurementCategory(extractedData.categoryCode);
const requiresSOW = procurementCategory?.requires_sow === true;

if (requiresSOW) {
  currentState = 'sow'; // Show SOW tab
} else {
  currentState = 'appendix_a'; // Skip SOW, go directly to appendices
}
```

---

## Handoff 3: SCOPE OF WORK → Appendix A (Product Specifications)

### Trigger
SCOPE OF WORK document generated, user clicks Appendix A tab or SCOPE OF WORK references Appendix A.

### Data Passed
```javascript
const handoffData = {
  orderId: "order-uuid",
  orderNumber: "PO-2026-0001",
  items: [
    {
      productName: "D3 Small Bulldozer – Caterpillar",
      specification: "80–100 HP, operating weight ±8,500 kg",
      category: "Small Bulldozer",
      typicalUse: "Landscaping, site clearing, light grading",
      unit: "Hour",
      quantity: 1,
      rate: 650,
      amount: 650
    },
    // ... more items
  ],
  totalValue: 125000,
  currency: "ZAR"
};
```

### Template Used
- **Table**: `sow_templates.appendix_definitions` → Appendix A reference
- **Source File**: `docs/pages-forms-templates/01900_procurement/source/01900_appendix_a_product_specification_sheets_template.md`

### Generated Output
Product specifications table with all items, quantities, rates, and totals.

### Next State
`currentState = 'appendix_a'`

---

## Handoff 4: Appendix A → Appendix B (Safety Data Sheets)

### Trigger
User clicks Appendix B tab, or items include hazardous materials (lubricants, oils, chemicals).

### Data Passed
```javascript
const handoffData = {
  orderId: "order-uuid",
  items: [...], // Filtered for items requiring SDS
  sdsRequired: true,
  destinationCountry: "Guinea",
  // Items requiring SDS
  sdsItems: items.filter(item => 
    item.category?.toLowerCase().includes('lubricant') ||
    item.category?.toLowerCase().includes('oil') ||
    item.category?.toLowerCase().includes('chemical')
  )
};
```

### Conditional Logic
```javascript
// Only show Appendix B if applicable products exist
if (extractedData.items?.some(item => requiresSDS(item))) {
  // Enable Appendix B tab
  // Generate SDS requirements checklist
}
```

### Generated Output
- 16-point SDS checklist
- Products requiring SDS table
- SDS request status

### Next State
`currentState = 'appendix_b'`

---

## Handoff 5: Appendix B → Appendix C (Delivery Schedule)

### Trigger
User clicks Appendix C tab, or SCOPE OF WORK references delivery schedule.

### Data Passed
```javascript
const handoffData = {
  orderId: "order-uuid",
  orderNumber: "PO-2026-0001",
  timeline: {
    timeframe: "Standard (2-4 weeks)",
    code: 2
  },
  destinationCountry: {
    name: "Guinea",
    code: "GN"
  },
  cdcRequired: true,
  orderDate: "2026-02-24T02:00:00.000Z"
};
```

### Calculated Fields
```javascript
// Milestone dates calculated from timeline
const milestones = {
  contractAward: addDays(orderDate, 2),
  manufacturing: addDays(orderDate, getTimelineDays(timeline)),
  shipping: addDays(orderDate, getTimelineDays(timeline) + 7),
  delivery: addDays(orderDate, getTimelineDays(timeline) + 14),
  installation: addDays(orderDate, getTimelineDays(timeline) + 21)
};
```

### Generated Output
- Delivery timeline table
- Milestone dates
- Delivery requirements section

### Next State
`currentState = 'appendix_c'`

---

## Handoff 6: Appendix C → Appendix D (Training Materials)

### Trigger
User clicks Appendix D tab, or `procurement_type === "Equipment"`.

### Data Passed
```javascript
const handoffData = {
  orderId: "order-uuid",
  procurementType: "Equipment",
  trainingRequired: true,
  items: [...], // Equipment items requiring training
  destinationCountry: "Guinea"
};
```

### Conditional Logic
```javascript
// Training typically required for Equipment procurement
if (extractedData.procurement_type?.value === 'Equipment') {
  // Enable Appendix D tab
  // Generate training requirements
}
```

### Generated Output
- Training topics checklist
- Training schedule table
- Training requirements section

### Next State
`currentState = 'appendix_d'`

---

## Handoff 7: Appendix D → Appendix E (Logistics Documents)

### Trigger
User clicks Appendix E tab, or SCOPE OF WORK references logistics documentation.

### Data Passed
```javascript
const handoffData = {
  orderId: "order-uuid",
  orderNumber: "PO-2026-0001",
  destinationCountry: {
    name: "Guinea",
    code: "GN"
  },
  cdcRequired: true,
  importerNif: "NIF123456789",
  importerAddress: "123 Mining District, Conakry, Guinea",
  incoterm: "DAP",
  items: [...]
};
```

### Conditional Documents
```javascript
// CDC documents for Guinea
if (extractedData.cdc_required) {
  documents.push({
    type: "CDC",
    name: "Déclaration en Détail en Douane",
    required: true
  });
  documents.push({
    type: "NIF",
    name: "Numéro d'Identification Fiscale",
    value: extractedData.importer_nif?.value
  });
}
```

### Generated Output
- Required shipping documents table
- Country-specific documents (CDC for Guinea)
- Document status indicators

### Next State
`currentState = 'appendix_e'`

---

## Handoff 8: Appendix E → Appendix F (Packing Specification)

### Trigger
User clicks Appendix F tab, or SCOPE OF WORK references packaging requirements.

### Data Passed
```javascript
const handoffData = {
  orderId: "order-uuid",
  orderNumber: "PO-2026-0001",
  items: [...],
  destinationCountry: "Guinea",
  hazardousMaterials: false // or true if SDS items present
};
```

### Generated Output
- Packing requirements section
- Packing standards checklist
- Marking requirements table

### Next State
`currentState = 'appendix_f'`

---

## Complete Handoff Summary Table

| From | To | Trigger | Key Data Passed | Validation |
|------|-----|---------|-----------------|------------|
| Chat | Preview | Click Preview | extractedData, messages | Required fields present |
| Preview | Handoff | Click Submit | validationStatus, specialistAgents | isValid === true |
| Handoff | SCOPE OF WORK* | Order created + category check | createdOrder, sowSections | Order success + requires_sow: true |
| Handoff | Appendix A** | Order created + category check | createdOrder, items[] | Order success + requires_sow: false |
| SCOPE OF WORK | Appendix A | Tab click / Reference | items[], totalValue | Items exist |
| Appendix A | Appendix B | Tab click / SDS items | sdsItems[] | SDS required |
| Appendix B | Appendix C | Tab click / Reference | timeline, destination | Timeline selected |
| Appendix C | Appendix D | Tab click / Equipment | procurementType | Equipment type |
| Appendix D | Appendix E | Tab click / Reference | destination, cdcRequired | Destination set |
| Appendix E | Appendix F | Tab click / Reference | items[], destination | Items exist |

*Only when `procurement_categories.requires_sow = true`  
**Direct path when `procurement_categories.requires_sow = false`

## Data Persistence Across Handoffs

### Session State Object
```javascript
const sessionState = {
  sessionId: "session-123",
  currentState: "appendix_e",
  extractedData: { ... },
  createdOrder: {
    order_number: "PO-2026-0001",
    id: "order-uuid"
  },
  documents: {
    sow: { generated: true, content: "..." },
    appendix_a: { generated: true, content: "..." },
    appendix_b: { generated: true, content: "..." },
    appendix_c: { generated: true, content: "..." },
    appendix_d: { generated: false },
    appendix_e: { generated: true, content: "..." },
    appendix_f: { generated: false }
  },
  validationStatus: { isValid: true },
  specialistAgents: { ... }
};
```

### Checkpoint Saving
Each handoff triggers a checkpoint save:
```javascript
const saveCheckpoint = async (step, state) => {
  await fetch('/api/checkpoints', {
    method: 'POST',
    body: JSON.stringify({
      thread_id: sessionId,
      discipline: '01900',
      step: step,
      state: state
    })
  });
};
```

## Error Recovery During Handoffs

### Handoff Failure
```javascript
const handleHandoffError = async (error, fromState, toState) => {
  // Save current state
  await saveCheckpoint(fromState, sessionState);
  
  // Log error
  console.error(`Handoff failed: ${fromState} → ${toState}`, error);
  
  // Trigger IT Swarm debugging
  await triggerITSwarmDebug({
    error: error.message,
    context: { fromState, toState, sessionState }
  });
  
  // Offer recovery options
  showRecoveryOptions({
    retry: () => retryHandoff(fromState, toState),
    rollback: () => rollbackToState(fromState)
  });
};
```

### Recovery Options
1. **Retry**: Attempt handoff again
2. **Rollback**: Return to previous state
3. **Manual Override**: Skip validation and proceed
4. **Debug**: Open Agent Operations Center