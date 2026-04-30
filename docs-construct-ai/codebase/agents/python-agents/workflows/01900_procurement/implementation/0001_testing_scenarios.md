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
# 14 - Testing Scenarios

## Overview

This document provides comprehensive testing scenarios for the procurement workflow, including happy paths, edge cases, error scenarios, and country-specific variations.

## Test Scenarios

### 1. Happy Path - Equipment to Guinea

**Description**: Complete workflow for equipment procurement to Guinea with CDC requirements.

**Steps**:
| Step | Input | Expected Output |
|------|-------|-----------------|
| 1 | Modal opens | Session initialized, greeting displayed |
| 2 | "2" | Industrial equipment selected |
| 3 | "5" | Mining mobile equipment selected |
| 4 | [Paste items table] | Items parsed, value calculated |
| 5 | "Guinea" | CDC requirements triggered |
| 6 | "NIF123456789" | NIF recorded |
| 7 | "123 Mining District, Conakry" | Address recorded |
| 8 | "yes" | Value confirmed |
| 9 | "1" | Equipment type selected |
| 10 | "none" | No special requirements |
| 11 | "3" | This month timeline |
| 12 | "yes" | Order created, SOW generated |

**Expected Result**: Order created, SOW displayed with all sections populated, CDC requirements included.

### 2. Happy Path - Services Local

**Description**: Services procurement to South Africa (no CDC).

**Steps**:
| Step | Input | Expected Output |
|------|-------|-----------------|
| 1 | Modal opens | Session initialized |
| 2 | "3" | Consulting Services selected |
| 3 | "2" | Engineering Consulting selected |
| 4 | "Engineering review services..." | Service description recorded |
| 5 | "South Africa" | Local procurement, no CDC |
| 6 | "yes" | Value confirmed |
| 7 | "2" | Services type selected |
| 8 | "none" | No special requirements |
| 9 | "2" | Standard timeline |
| 10 | "yes" | Order created |

**Expected Result**: Order created without CDC requirements.

### 3. Happy Path - Materials with SDS

**Description**: Materials procurement requiring Safety Data Sheets.

**Steps**:
| Step | Input | Expected Output |
|------|-------|-----------------|
| 1 | Modal opens | Session initialized |
| 2 | "4" | Consumables selected |
| 3 | "1" | Lubricants & Oils selected |
| 4 | [Paste lubricants table] | Items parsed, SDS requirements detected |
| 5 | "Guinea" | CDC + SDS requirements |
| 6 | [Complete CDC steps] | Importer details recorded |
| 7 | "yes" | Order created |

**Expected Result**: Order created with SDS requirements in Appendix B.

## Edge Cases

### 4. Large Order (50+ Items)

**Description**: Test performance with large item count.

**Input**: Paste table with 50+ items

**Expected Behavior**:
- Items parsed within 2 seconds
- Value calculated correctly
- SOW displays first 3 items with "see Appendix A" reference
- Appendix A shows all 50+ items with pagination

### 5. Partial Data

**Description**: Missing specifications for some items.

**Input**: Table with some empty specification cells

**Expected Behavior**:
- Agent prompts for missing specifications
- User can skip or provide
- SOW shows "TBD" for missing specs

### 6. Invalid Country

**Description**: Invalid or unrecognized country.

**Input**: "InvalidCountry123"

**Expected Behavior**:
- Agent prompts for valid country
- Suggestion list provided
- Cannot proceed until valid country selected

### 7. Value Mismatch

**Description**: Estimated value doesn't match calculated total.

**Input**: Items totaling R100,000, user confirms R50,000

**Expected Behavior**:
- Agent highlights discrepancy
- User can confirm calculated value or override
- Warning displayed in validation

## Error Scenarios

### 8. Network Timeout

**Description**: API timeout during message send.

**Simulation**: Disconnect network during step

**Expected Behavior**:
- Loading indicator shows
- Retry button appears
- Session state preserved
- Can retry or cancel

### 9. Session Expiry

**Description**: Session expires during workflow.

**Simulation**: Wait for session timeout

**Expected Behavior**:
- Session recovery prompt
- Can resume from checkpoint
- Or start new session

### 10. Invalid NIF Format

**Description**: Invalid NIF for Guinea imports.

**Input**: "INVALID_NIF"

**Expected Behavior**:
- Validation error displayed
- Correct format shown
- Cannot proceed until valid

### 11. Empty Items

**Description**: No items provided.

**Input**: Empty table or skip items step

**Expected Behavior**:
- Validation error: "At least one item required"
- Cannot proceed to handoff
- Return to chat to add items

## Country-Specific Tests

### 12. Guinea - CDC Complete

**Description**: Full CDC workflow for Guinea.

**Verification Points**:
- CDC flag set to true
- NIF field required
- Address field required
- SOW includes CDC section
- Appendix E includes CDC documents

### 13. South Africa - Local

**Description**: Local procurement without CDC.

**Verification Points**:
- CDC flag set to false
- NIF not required
- SABS certification mentioned
- Standard customs documentation

### 14. International - Multi-currency

**Description**: International procurement with currency selection.

**Verification Points**:
- Currency selector displayed
- Exchange rate applied
- Documents in selected currency

## Agent Workflow Tests

### 15. 7-Agent Streaming Success

**Description**: Verify all 7 agents execute successfully.

**Verification Points**:
- Each agent activates in sequence
- Progress bar updates
- All agents complete within 6 seconds
- Results stored in state

### 16. Agent Failure Recovery

**Description**: Agent fails during execution.

**Simulation**: Mock agent failure

**Expected Behavior**:
- Error event dispatched
- Retry option provided
- IT Swarm debug triggered
- User can continue or abort

### 17. HITL Gate 1 - Compliance

**Description**: Compliance validation requires user input.

**Simulation**: Flagged compliance issue

**Expected Behavior**:
- Workflow pauses at Gate 1
- User reviews compliance
- Approve or modify options
- Workflow resumes after approval

### 18. HITL Gate 2 - Final Review

**Description**: Final review requires user approval.

**Expected Behavior**:
- Workflow pauses at Gate 2
- SOW preview displayed
- User approves or requests changes
- Order created after approval

## Document Generation Tests

### 19. SOW Generation

**Description**: Verify SOW document generation.

**Verification Points**:
- All 13 sections present
- Data correctly populated
- Conditional sections (CDC) included
- References to appendices correct

### 20. Appendix A - Specifications Table

**Description**: Verify product specifications table.

**Verification Points**:
- All items displayed
- Calculations correct
- Total matches estimated value
- Export options available

### 21. Appendix E - Logistics Documents

**Description**: Verify logistics documentation.

**Verification Points**:
- Standard documents listed
- CDC documents included (if applicable)
- Status indicators correct
- Document generation templates ready

## Performance Tests

### 22. Response Time

**Description**: Verify API response times.

**Targets**:
| Operation | Target | Max |
|-----------|--------|-----|
| Session start | < 500ms | 1s |
| Message send | < 1s | 2s |
| Data extraction | < 500ms | 1s |
| Validation | < 200ms | 500ms |
| Handoff | < 2s | 5s |
| 7-Agent workflow | < 6s | 10s |

### 23. Concurrent Sessions

**Description**: Multiple simultaneous sessions.

**Test**: 10 concurrent users

**Expected Behavior**:
- All sessions independent
- No data cross-contamination
- Response times within targets

## Test Automation

### Automated Test Script

```javascript
const runTestScenario = async (scenario) => {
  const results = [];
  
  for (const step of scenario.steps) {
    const startTime = Date.now();
    
    try {
      const response = await handleSendMessage(step.input);
      
      results.push({
        step: step.step,
        input: step.input,
        expected: step.expected,
        actual: response.message,
        passed: response.message.includes(step.expected),
        duration: Date.now() - startTime
      });
    } catch (error) {
      results.push({
        step: step.step,
        passed: false,
        error: error.message
      });
    }
  }
  
  return {
    scenario: scenario.name,
    passed: results.every(r => r.passed),
    results
  };
};
```

### Test Data Fixtures

```javascript
const testScenarios = {
  equipmentToGuinea: {
    name: 'Equipment to Guinea',
    steps: [
      { step: 1, input: '2', expected: 'Industrial equipment' },
      { step: 2, input: '5', expected: 'Mining mobile equipment' },
      { step: 3, input: 'Guinea', expected: 'CDC' },
      // ... more steps
    ]
  },
  servicesLocal: {
    name: 'Services Local',
    steps: [
      // ... steps
    ]
  }
};