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
# 12 - Chat Thread Sequences

## Overview

This document records the complete chat thread sequences for the procurement workflow, including all conversation steps, data extraction points, and agent interactions.

## Standard Procurement Thread Sequence

### Complete Thread Flow (17 Steps)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    PROCUREMENT CHAT THREAD SEQUENCE                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Step 1-2: INITIALIZATION                                                    │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │ Agent: "Hello! I can help you create a procurement order."          │    │
│  │ Agent: "What type of procurement do you need?                       │    │
│  │         (Equipment, Services, Materials, or Mixed)"                 │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                              │                                               │
│                              ▼                                               │
│  Step 3-4: GROUP SELECTION                                                   │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │ User: "2" (Industrial equipment)                                    │    │
│  │ Agent: "Great! You've selected Industrial equipment.                │    │
│  │         What category are you interested in?"                       │    │
│  │         [Lists 10 categories]                                       │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                              │                                               │
│                              ▼                                               │
│  Step 5-6: CATEGORY SELECTION                                                │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │ User: "5" (Mining mobile equipment)                                 │    │
│  │ Agent: "Perfect! Mining mobile equipment.                           │    │
│  │         Please provide the detailed specifications for your items." │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                              │                                               │
│                              ▼                                               │
│  Step 7: ITEM DATA INPUT                                                     │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │ User: [Pastes tabular data]                                         │    │
│  │ Agent: "I've received your item specifications. [X] items detected. │    │
│  │         Total estimated value: R[Y]"                                │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                              │                                               │
│                              ▼                                               │
│  Step 8-9: DESTINATION COUNTRY                                               │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │ Agent: "Where will these items be delivered?"                       │    │
│  │ User: "Guinea"                                                      │    │
│  │ Agent: "Guinea selected. This triggers CDC (Customs Declaration)    │    │
│  │         requirements for import."                                   │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                              │                                               │
│                              ▼                                               │
│  Step 10-12: IMPORTER DETAILS (CDC Required)                                 │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │ Agent: "For Guinea imports, please provide the importer's NIF       │    │
│  │         (Numéro d'Identification Fiscale):"                         │    │
│  │ User: "NIF123456789"                                                │    │
│  │ Agent: "Please provide the importer's address in Guinea:"           │    │
│  │ User: "123 Mining District, Conakry, Guinea"                        │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                              │                                               │
│                              ▼                                               │
│  Step 13: VALUE CONFIRMATION                                                 │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │ Agent: "Based on your specifications, the estimated value is        │    │
│  │         R[X]. Is this correct?"                                     │    │
│  │ User: "yes"                                                         │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                              │                                               │
│                              ▼                                               │
│  Step 14: PROCUREMENT TYPE CONFIRMATION                                      │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │ Agent: "What type of procurement is this?                           │    │
│  │         1. Equipment  2. Services  3. Materials  4. Mixed"          │    │
│  │ User: "1"                                                           │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                              │                                               │
│                              ▼                                               │
│  Step 15: SPECIAL REQUIREMENTS                                               │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │ Agent: "Any special requirements or specifications?"                │    │
│  │ User: "none" (or detailed requirements)                             │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                              │                                               │
│                              ▼                                               │
│  Step 16: TIMELINE SELECTION                                                 │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │ Agent: "What's your preferred delivery timeline?                    │    │
│  │         1. Urgent (1-2 weeks)                                       │    │
│  │         2. Standard (2-4 weeks)                                     │    │
│  │         3. This month                                               │    │
│  │         4. This quarter"                                            │    │
│  │ User: "3"                                                           │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                              │                                               │
│                              ▼                                               │
│  Step 17: ORDER CONFIRMATION                                                 │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │ Agent: "Ready to create procurement order for [X] items             │    │
│  │         totaling R[Y]? Type 'yes' to confirm."                      │    │
│  │ User: "yes"                                                         │    │
│  │ Agent: "Order created successfully! Order #[Z].                     │    │
│  │         Preparing Scope of Work..."                                 │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                              │                                               │
│                              ▼                                               │
│  AUTO TRAVERSE TO SOW TAB                                                    │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Data Extraction Points

### Step-by-Step Data Mapping

| Step | User Input | Extracted Field | Data Type |
|------|------------|-----------------|-----------|
| 3 | "2" | `group` | { value: "Industrial equipment", code: 2 } |
| 5 | "5" | `category` | { value: "Mining mobile equipment", code: 5 } |
| 7 | [Tabular data] | `items[]` | Array of item objects |
| 7 | [Calculated] | `estimated_value` | { value: 125000, currency: "ZAR" } |
| 8 | "Guinea" | `destination_country` | { name: "Guinea", code: "GN" } |
| 8 | [Auto-detected] | `cdc_required` | true |
| 10 | "NIF123456789" | `importer_nif` | { value: "NIF123456789" } |
| 11 | "123 Mining..." | `importer_address` | { value: "123 Mining District..." } |
| 13 | "yes" | `value_confirmed` | true |
| 14 | "1" | `procurement_type` | { value: "Equipment", code: 1 } |
| 15 | "none" | `requirements` | { value: "None" } |
| 16 | "3" | `timeline` | { value: "This month", code: 3 } |
| 17 | "yes" | `order_confirmed` | true |

## Item Data Structure

### Tabular Input Format
```
Product Name | Specification | Category | Typical Use | Unit | Quantity | Rate | Amount
-------------|---------------|----------|-------------|------|----------|------|-------
D3 Small Bulldozer | 80-100 HP | Bulldozer | Landscaping | Hour | 1 | 650 | 650
```

### Parsed Item Object
```javascript
{
  productName: "D3 Small Bulldozer – Caterpillar",
  specification: "80–100 HP, operating weight ±8,500 kg",
  category: "Small Bulldozer",
  typicalUse: "Landscaping, site clearing, light grading",
  unit: "Hour",
  quantity: 1,
  rate: 650,
  currency: "ZAR",
  amount: 650
}
```

## Alternative Thread Sequences

### Services Procurement Thread
```
Step 1-2: Initialization (same)
Step 3-4: Group Selection → "Consulting Services"
Step 5-6: Category Selection → "Engineering Consulting"
Step 7: Service Description Input (text-based, not tabular)
Step 8-9: Destination Country
Step 10-12: Importer Details (if applicable)
Step 13: Value Confirmation
Step 14: Procurement Type → "Services"
Step 15: Special Requirements
Step 16: Timeline Selection
Step 17: Order Confirmation
```

### Materials Procurement Thread
```
Step 1-2: Initialization (same)
Step 3-4: Group Selection → "Consumables"
Step 5-6: Category Selection → "Lubricants & Oils"
Step 7: Materials Data Input (tabular with SDS requirements)
Step 8-9: Destination Country
Step 10-12: Importer Details (if applicable)
Step 13: Value Confirmation
Step 14: Procurement Type → "Materials"
Step 15: Special Requirements (SDS requirements auto-added)
Step 16: Timeline Selection
Step 17: Order Confirmation
```

### Mixed Procurement Thread
```
Step 1-2: Initialization (same)
Step 3-4: Group Selection → Multiple groups allowed
Step 5-6: Category Selection → Multiple categories
Step 7: Mixed Data Input (equipment + materials + services)
Step 8-9: Destination Country
Step 10-12: Importer Details (if applicable)
Step 13: Value Confirmation (combined total)
Step 14: Procurement Type → "Mixed"
Step 15: Special Requirements (combined requirements)
Step 16: Timeline Selection
Step 17: Order Confirmation
```

## Country-Specific Thread Variations

### Guinea (CDC Required)
```
Additional Steps After Destination Selection:
- Step 10: Request NIF (Numéro d'Identification Fiscale)
- Step 11: Request Importer Address
- Step 12: Confirm CDC Requirements

Auto-Generated Compliance:
- CDC (Déclaration en Détail en Douane)
- Importer NIF documentation
- Customs clearance documentation
```

### South Africa (Local)
```
Simplified Thread:
- No CDC requirements
- No importer NIF needed
- SABS certification may be required for certain items
- Local content requirements for government contracts
```

### International (Non-Guinea)
```
Standard Thread:
- Incoterms selection (DAP, FOB, CIF, etc.)
- Export documentation requirements
- Country-specific import regulations
- Currency selection (ZAR, USD, EUR)
```

## Thread State Management

### Session State Object
```javascript
{
  sessionId: "session-1234567890-abc123",
  currentStep: 17,
  currentState: "sow", // chat, preview, draft, handoff, sow, appendix_*
  extractedData: { ... },
  messages: [
    { id: 1, role: 'agent', content: '...', timestamp: '...' },
    { id: 2, role: 'user', content: '...', timestamp: '...' },
    // ... all messages
  ],
  validationStatus: { isValid: true, errors: [] },
  specialistAgents: { ... },
  createdAt: "2026-02-24T02:00:00.000Z",
  updatedAt: "2026-02-24T02:15:00.000Z"
}
```

### Checkpoint States
```javascript
// Checkpoint saved at each major step
const checkpointSteps = [
  'group',           // After group selection
  'category',        // After category selection
  'items',           // After items input
  'destination',     // After destination selection
  'importer',        // After importer details
  'value',           // After value confirmation
  'type',            // After procurement type
  'requirements',    // After requirements
  'timeline',        // After timeline
  'complete'         // After order creation
];
```

## Error Recovery Threads

### Missing Data Recovery
```
Agent: "I noticed some items are missing specifications. 
       Would you like to add them now or proceed with 
       the available data?"

User: "add them"
Agent: "Please provide the specification for [Item Name]:"
User: [Provides specification]
Agent: "Specification added. Any other missing details?"
```

### Validation Error Recovery
```
Agent: "The estimated value seems incorrect based on the 
       items provided. The calculated total is R[X] but 
       you specified R[Y]. Which is correct?"

User: "R[X]"
Agent: "Value updated to R[X]. Continuing..."
```

### Session Recovery
```
[On page reload]

Agent: "Welcome back! I found a previous session from 
       [date]. You were at step [X] - [step name].
       Would you like to continue where you left off?"

User: "yes"
Agent: [Resumes from checkpoint with context message]
```

## Agent Interaction Points

### AI Agent Triggers
| Step | Agent Triggered | Purpose |
|------|-----------------|---------|
| 7 | Data Extraction Agent | Parse tabular data |
| 8 | Compliance Agent | Check country requirements |
| 13 | Validation Agent | Verify calculated values |
| 17 | Order Creation Agent | Create database record |
| Post-17 | 7-Agent Workflow | Generate SOW and appendices |

### Streaming Workflow Trigger
```javascript
// Triggered after order confirmation
const executeStreamingWorkflow = async () => {
  // Stage 1: Template Analysis (800ms)
  // Stage 2: Requirements Extraction (700ms)
  // Stage 3: Compliance Validation (900ms) - HITL Gate 1
  // Stage 4: Field Population (800ms)
  // Stage 5: Quality Assurance (600ms)
  // Stage 6: Final Review (850ms) - HITL Gate 2
  // Stage 7: Assignment (650ms)
};
```

## Testing Thread Sequences

### Test Scenario: Equipment to Guinea
```javascript
const testSteps = [
  { step: 3, input: "2", expected: "Industrial equipment selected" },
  { step: 5, input: "5", expected: "Mining mobile equipment selected" },
  { step: 7, input: testData.items, expected: "5 items detected" },
  { step: 8, input: "Guinea", expected: "CDC requirements triggered" },
  { step: 10, input: "NIF123456789", expected: "NIF recorded" },
  { step: 11, input: "123 Mining District, Conakry", expected: "Address recorded" },
  { step: 13, input: "yes", expected: "Value confirmed" },
  { step: 14, input: "1", expected: "Equipment type selected" },
  { step: 15, input: "none", expected: "No special requirements" },
  { step: 16, input: "3", expected: "This month timeline" },
  { step: 17, input: "yes", expected: "Order created, SOW generated" }
];
```

### Test Scenario: Services Local
```javascript
const testSteps = [
  { step: 3, input: "3", expected: "Consulting Services selected" },
  { step: 5, input: "2", expected: "Engineering Consulting selected" },
  { step: 7, input: "Engineering review services...", expected: "Service recorded" },
  { step: 8, input: "South Africa", expected: "Local procurement" },
  { step: 13, input: "yes", expected: "Value confirmed" },
  { step: 14, input: "2", expected: "Services type selected" },
  // ... continue
];