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
# 11 - Data Flow and Sources

## Overview

This document details the complete data flow through the procurement workflow, from initial user input through to final document generation. It maps all data sources, transformations, and destinations.

## Data Flow Architecture

### High-Level Flow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         PROCUREMENT DATA FLOW                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐  │
│  │   USER      │    │     AI      │    │ SPECIALIST  │    │  DATABASE   │  │
│  │   INPUT     │ →  │   AGENT     │ →  │   AGENTS    │ →  │  STORAGE    │  │
│  └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘  │
│        │                  │                  │                  │           │
│        ▼                  ▼                  ▼                  ▼           │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐  │
│  │ Natural     │    │ Extracted   │    │ Validated   │    │ Persistent  │  │
│  │ Language    │    │ Data        │    │ & Enriched  │    │ Records     │  │
│  │ Text        │    │ Object      │    │ Data        │    │             │  │
│  └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘  │
│                                                                              │
│        │                  │                  │                  │           │
│        └──────────────────┴──────────────────┴──────────────────┘           │
│                                    │                                         │
│                                    ▼                                         │
│                           ┌─────────────┐                                   │
│                           │  DOCUMENT   │                                   │
│                           │ GENERATION  │                                   │
│                           │ (SOW + A-F) │                                   │
│                           └─────────────┘                                   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Input Data Sources

### 1. User Chat Input

| Source | Data Type | Example | Extracted Field |
|--------|-----------|---------|-----------------|
| Text selection | String | "2" | `group.code` |
| Text selection | String | "5" | `category.code` |
| Natural language | String | "Guinea" | `destination_country.name` |
| Natural language | String | "NIF123456789" | `importer_nif.value` |
| Natural language | String | "yes" | `confirmation flags` |
| Natural language | String | "none" | `requirements.value` |

### 2. Tabular Data Input

| Column | Data Type | Example | Extracted Field |
|--------|-----------|---------|-----------------|
| Product Name | String | "D3 Small Bulldozer" | `items[].productName` |
| Specification | String | "80-100 HP" | `items[].specification` |
| Category | String | "Bulldozer" | `items[].category` |
| Typical Use | String | "Landscaping" | `items[].typicalUse` |
| Unit | String | "Hour" | `items[].unit` |
| Quantity | Number | 1 | `items[].quantity` |
| Rate | Number | 650 | `items[].rate` |
| Amount | Number | 650 | `items[].amount` |

### 3. Calculated/Derived Data

| Calculation | Source Data | Result Field |
|-------------|-------------|--------------|
| Total Value | `items[].amount` sum | `estimated_value.value` |
| CDC Required | `destination_country.code === "GN"` | `cdc_required` |
| Item Count | `items.length` | `item_count` |
| Currency | Default or selection | `currency` |

### 4. Static/Configuration Data

| Data | Source | Usage |
|------|--------|-------|
| Incoterms | Configuration | Default "DAP" |
| Warranty Period | Configuration | Default 12 months |
| Payment Terms | Configuration | 30/40/30 split |
| Quality Standards | Configuration | ISO, API, SAE |

## Data Transformation Pipeline

### Stage 1: Input Parsing

```javascript
// Raw user input → Parsed data
const parseUserInput = (input, currentStep) => {
  switch (currentStep) {
    case 'group':
      return { group: { code: parseInt(input), value: getGroupName(input) } };
    case 'category':
      return { category: { code: parseInt(input), value: getCategoryName(input) } };
    case 'destination':
      return { destination_country: { name: input, code: getCountryCode(input) } };
    // ... other steps
  }
};
```

### Stage 2: Data Extraction

```javascript
// Parsed data → Extracted data object
const extractData = (messages) => {
  const extractedData = {};
  
  messages.forEach(message => {
    if (message.role === 'user') {
      // Apply extraction rules based on conversation context
      const extracted = applyExtractionRules(message.content, message.context);
      Object.assign(extractedData, extracted);
    }
  });
  
  return extractedData;
};
```

### Stage 3: Validation

```javascript
// Extracted data → Validated data
const validateData = (extractedData) => {
  const validationResults = {
    isValid: true,
    errors: [],
    warnings: []
  };
  
  // Required field validation
  const requiredFields = ['procurement_type', 'estimated_value', 'items'];
  requiredFields.forEach(field => {
    if (!extractedData[field]) {
      validationResults.errors.push(`Missing required field: ${field}`);
      validationResults.isValid = false;
    }
  });
  
  // Country-specific validation
  if (extractedData.cdc_required && !extractedData.importer_nif) {
    validationResults.errors.push('NIF required for Guinea imports');
    validationResults.isValid = false;
  }
  
  return validationResults;
};
```

### Stage 4: Enrichment

```javascript
// Validated data → Enriched data
const enrichData = (validatedData) => {
  return {
    ...validatedData,
    // Add calculated fields
    item_count: validatedData.items?.length || 0,
    total_value: calculateTotal(validatedData.items),
    
    // Add compliance flags
    cdc_required: validatedData.destination_country?.code === 'GN',
    
    // Add timestamps
    extracted_at: new Date().toISOString(),
    
    // Add metadata
    data_quality_score: calculateQualityScore(validatedData)
  };
};
```

## Data Destination Mapping

### SOW Document Fields

| SOW Section | Data Source | Field Path |
|-------------|-------------|------------|
| Introduction | `procurement_type` | `extractedData.procurement_type.value` |
| Scope - Type | `procurement_type` | `extractedData.procurement_type.value` |
| Scope - Items | `items` | `extractedData.items.length` |
| Scope - Value | `estimated_value` | `extractedData.estimated_value.value` |
| Scope - Destination | `destination_country` | `extractedData.destination_country.name` |
| Scope - Requirements | `requirements` | `extractedData.requirements.value` |
| Tech Specs | `items[]` | `extractedData.items.slice(0,3)` |
| Logistics - Location | `destination_country` | `extractedData.destination_country.name` |
| Logistics - NIF | `importer_nif` | `extractedData.importer_nif.value` |
| Logistics - Address | `importer_address` | `extractedData.importer_address.value` |
| Timeline | `timeline` | `extractedData.timeline.timeframe` |
| CDC Block | `cdc_required` | Conditional display |

### Appendix A - Product Specifications

| Table Column | Data Source | Field Path |
|--------------|-------------|------------|
| # | Index | `idx + 1` |
| Product Name | `items[]` | `item.productName` |
| Specification | `items[]` | `item.specification` |
| Typical Use | `items[]` | `item.typicalUse` |
| Unit | `items[]` | `item.unit` |
| Quantity | `items[]` | `item.quantity` |
| Rate | `items[]` | `item.rate` |
| Amount | `items[]` | `item.amount` |
| TOTAL | Calculated | `items.reduce((sum, item) => sum + item.amount, 0)` |

### Appendix B - Safety Data Sheets

| Field | Data Source | Notes |
|-------|-------------|-------|
| Product List | `items[]` | Filter for materials requiring SDS |
| SDS Status | Default | "Pending" for all items |
| SDS Requirements | Static | 16-point SDS checklist |

### Appendix C - Delivery Schedule

| Field | Data Source | Notes |
|-------|-------------|-------|
| Order Number | `createdOrder` | From order creation response |
| Timeline | `timeline` | User-selected timeframe |
| Destination | `destination_country` | Delivery location |
| CDC Required | `cdc_required` | Customs flag |

### Appendix E - Logistics Documents

| Document | Data Source | Notes |
|----------|-------------|-------|
| Commercial Invoice | Generated | From items and value |
| Packing List | Generated | From items |
| CDC | `cdc_required` | Conditional |
| NIF | `importer_nif` | Conditional |

## Database Storage

### Session Data

```sql
-- procurement_agent_sessions table
{
  id: UUID,
  user_id: STRING,
  session_id: STRING,
  current_step: STRING,
  current_state: STRING,
  extracted_data: JSONB,
  messages: JSONB[],
  validation_status: JSONB,
  specialist_agents: JSONB,
  created_at: TIMESTAMP,
  updated_at: TIMESTAMP
}
```

### Order Data

```sql
-- procurement_orders table
{
  id: UUID,
  order_number: STRING,
  session_id: STRING,
  procurement_type: STRING,
  estimated_value: DECIMAL,
  items: JSONB[],
  destination_country: STRING,
  cdc_required: BOOLEAN,
  importer_nif: STRING,
  importer_address: STRING,
  timeline: STRING,
  requirements: TEXT,
  status: STRING,
  created_at: TIMESTAMP
}
```

### Document Data

```sql
-- procurement_documents table
{
  id: UUID,
  order_id: UUID,
  document_type: STRING, -- 'sow', 'appendix_a', etc.
  content: TEXT,
  metadata: JSONB,
  generated_at: TIMESTAMP
}
```

## API Data Exchange

### Request Payloads

#### Start Session
```javascript
POST /api/procurement/agent/start
{
  user_id: "user-123",
  procurement_type: "unknown"
}
```

#### Send Message
```javascript
POST /api/procurement/agent/message
{
  session_id: "session-123",
  message: "2",
  current_step: "group"
}
```

#### Extract Data
```javascript
POST /api/procurement/agent/extract
{
  session_id: "session-123"
}
```

#### Validate Data
```javascript
POST /api/procurement/agent/validate
{
  session_id: "session-123",
  extracted_data: { ... }
}
```

#### Handoff to SOW
```javascript
POST /api/procurement/agent/handoff
{
  session_id: "session-123",
  extracted_data: { ... }
}
```

### Response Payloads

#### Message Response
```javascript
{
  response: "Great! You've selected Industrial equipment...",
  extracted_data: { group: { code: 2, value: "Industrial equipment" } },
  next_step: "category",
  is_complete: false
}
```

#### Handoff Response
```javascript
{
  success: true,
  createdOrder: {
    order_number: "PO-2026-0001",
    id: "order-uuid"
  },
  sowData: {
    sowSections: { ... }
  }
}
```

## Data Validation Rules

### Field-Level Validation

| Field | Type | Required | Validation |
|-------|------|----------|------------|
| `procurement_type` | Enum | Yes | One of: Equipment, Services, Materials, Mixed |
| `items[]` | Array | Yes | Min length: 1 |
| `items[].productName` | String | Yes | Non-empty string |
| `items[].quantity` | Number | Yes | Positive integer |
| `items[].rate` | Number | Yes | Positive number |
| `estimated_value` | Number | Yes | Positive number |
| `destination_country` | Object | Yes | Valid country code |
| `importer_nif` | String | Conditional | Required if `cdc_required` |
| `timeline` | Enum | No | One of: Urgent, Standard, This month, This quarter |

### Cross-Field Validation

```javascript
// CDC validation
if (extractedData.destination_country?.code === 'GN') {
  if (!extractedData.importer_nif?.value) {
    errors.push('NIF required for Guinea imports');
  }
  if (!extractedData.importer_address?.value) {
    errors.push('Importer address required for Guinea imports');
  }
}

// Value validation
const calculatedTotal = extractedData.items?.reduce((sum, item) => 
  sum + (item.amount || 0), 0) || 0;
if (Math.abs(calculatedTotal - extractedData.estimated_value?.value) > 0.01) {
  warnings.push('Estimated value does not match item totals');
}
```

## Data Quality Metrics

### Completeness Score
```javascript
const calculateCompleteness = (data) => {
  const requiredFields = [
    'procurement_type',
    'estimated_value', 
    'items',
    'destination_country'
  ];
  
  const optionalFields = [
    'requirements',
    'timeline',
    'importer_nif',
    'importer_address'
  ];
  
  const requiredScore = requiredFields.filter(f => data[f]).length / requiredFields.length;
  const optionalScore = optionalFields.filter(f => data[f]).length / optionalFields.length;
  
  return (requiredScore * 0.7) + (optionalScore * 0.3);
};
```

### Quality Indicators
- **Completeness**: Percentage of fields populated
- **Consistency**: Cross-field validation pass rate
- **Accuracy**: Value calculation match rate
- **Timeliness**: Data freshness (time since last update)