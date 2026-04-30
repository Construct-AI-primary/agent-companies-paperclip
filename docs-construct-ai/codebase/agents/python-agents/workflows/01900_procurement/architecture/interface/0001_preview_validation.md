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
# 02 - Preview and Validation

## Overview

The Preview tab provides a comprehensive view of all extracted data before order submission. It includes data validation, specialist agent processing, and completeness assessment.

## Component Structure

### Core Files
- `AgentDataPreview.js` - Preview UI component
- `useProcurementAgentSession.js` - Validation hook

### UI Elements
- **Data Fields Grid** - All extracted fields with values
- **Validation Status** - Pass/fail indicators
- **Completeness Meter** - Percentage complete
- **Specialist Agents Panel** - 7-agent workflow status
- **Action Buttons** - Refresh, Validate, Edit, Proceed

## Data Validation

### Field-Level Validation

| Field | Validation Rule | Error Message |
|-------|-----------------|---------------|
| `procurement_type` | Required, enum | "Please select a procurement type" |
| `items` | Required, min 1 item | "At least one item is required" |
| `estimated_value` | Required, positive number | "Please provide an estimated value" |
| `destination_country` | Required, valid country | "Please select a destination country" |
| `importer_nif` | Conditional (CDC required) | "NIF required for Guinea imports" |

### Cross-Field Validation

```javascript
const validateCrossFields = (data) => {
  const errors = [];
  
  // CDC validation
  if (data.destination_country?.code === 'GN') {
    if (!data.importer_nif?.value) {
      errors.push('NIF required for Guinea imports');
    }
    if (!data.importer_address?.value) {
      errors.push('Importer address required for Guinea imports');
    }
  }
  
  // Value validation
  const calculatedTotal = data.items?.reduce((sum, item) => 
    sum + (item.amount || 0), 0) || 0;
  if (Math.abs(calculatedTotal - data.estimated_value?.value) > 0.01) {
    errors.push('Estimated value does not match item totals');
  }
  
  return errors;
};
```

## Completeness Assessment

### Completeness Score Calculation

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
  
  return Math.round((requiredScore * 0.7 + optionalScore * 0.3) * 100);
};
```

### Completeness Display

| Score | Status | Color |
|-------|--------|-------|
| 90-100% | Complete | Green |
| 70-89% | Nearly Complete | Yellow |
| 50-69% | In Progress | Orange |
| 0-49% | Incomplete | Red |

## Specialist Agents Panel

### 7-Agent Workflow Status

| Agent | Status | Result |
|-------|--------|--------|
| Template Analysis | ⏳ Running | - |
| Requirements Extraction | ⏳ Pending | - |
| Compliance Validation | ⏳ Pending | - |
| Field Population | ⏳ Pending | - |
| Quality Assurance | ⏳ Pending | - |
| Final Review | ⏳ Pending | - |
| Assignment | ⏳ Pending | - |

### Agent Results Display

```javascript
const renderAgentResult = (agentName, result) => {
  if (!result) return <span className="pending">⏳ Pending</span>;
  
  return (
    <div className="agent-result">
      <span className="status complete">✓ Complete</span>
      <div className="result-details">
        <p>Confidence: {result.confidence}%</p>
        <p>Fields: {result.fieldsProcessed}/{result.totalFields}</p>
      </div>
    </div>
  );
};
```

## Preview Actions

### Refresh Data
- Re-extracts data from conversation
- Updates validation status
- Recalculates completeness

### Validate
- Runs all validation rules
- Displays errors and warnings
- Enables/disables proceed button

### Edit
- Returns to Chat tab
- Allows modification of extracted data
- Preserves conversation history

### Proceed to Submit
- Validates all required fields
- Triggers 7-agent workflow
- Moves to Handoff state

## Error Display

### Error Categories

| Category | Icon | Action |
|----------|------|--------|
| Critical | 🔴 | Block submission |
| Warning | 🟡 | Allow submission with confirmation |
| Info | 🔵 | Display only |

### Error Recovery

```javascript
const handleValidationError = (error) => {
  // Highlight problematic field
  highlightField(error.field);
  
  // Show error message
  showErrorToast({
    title: 'Validation Error',
    message: error.message,
    action: 'Fix Now',
    onClick: () => navigateToField(error.field)
  });
};
```

## Data Preview Grid

### Field Display

| Field | Value | Status | Edit |
|-------|-------|--------|------|
| Procurement Type | Equipment | ✓ Valid | Edit |
| Items | 5 items | ✓ Valid | Edit |
| Estimated Value | R 125,000 | ✓ Valid | Edit |
| Destination | Guinea | ✓ Valid | Edit |
| NIF | NIF123456789 | ✓ Valid | Edit |
| Timeline | This month | ⚠️ Optional | Edit |

### Inline Editing

```javascript
const handleFieldEdit = (fieldName, newValue) => {
  setExtractedData(prev => ({
    ...prev,
    [fieldName]: { ...prev[fieldName], value: newValue }
  }));
  
  // Re-validate after edit
  validateField(fieldName, newValue);
};
```

## Agent Integration

### Auto-Run on Preview
```javascript
useEffect(() => {
  if (currentState === 'preview' && extractedData) {
    runAllAgents();
  }
}, [currentState, extractedData]);
```

### Streaming Updates
```javascript
// Real-time agent status updates
window.addEventListener('streaming-agent-activated', (event) => {
  updateAgentStatus(event.detail.agent, 'running');
});

window.addEventListener('streaming-agent-completed', (event) => {
  updateAgentStatus(event.detail.agent, 'complete', event.detail.result);
});
```

## Performance Metrics

### Key Metrics
- **Validation Time**: Target < 500ms
- **Agent Workflow Time**: Target < 6 seconds
- **Completeness Calculation**: Target < 100ms

### Monitoring
```javascript
const trackPreviewMetrics = () => {
  trackWorkflowMetrics({
    action: 'preview_validation',
    completeness: getCompletenessPercentage(),
    validationStatus: validationStatus?.isValid ? 'valid' : 'invalid',
    agentCount: Object.values(specialistAgents).filter(Boolean).length
  });
};