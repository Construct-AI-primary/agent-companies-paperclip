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
# 10 - 7-Agent Streaming Workflow

## Overview

The procurement workflow implements a sophisticated 7-agent streaming workflow that processes procurement data sequentially, with each agent specializing in a specific task. This workflow provides real-time feedback and includes Human-in-the-Loop (HITL) gates for critical validation points.

## Architecture

### Workflow Sequence

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    7-AGENT STREAMING WORKFLOW                                │
│                                                                              │
│  Stage 1        Stage 2        Stage 3        Stage 4        Stage 5       │
│  ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐      │
│  │Template │ → │Require- │ → │Compliance│ → │Field    │ → │Quality  │      │
│  │Analysis │   │ments    │   │Validation│   │Population│   │Assurance│      │
│  │800ms    │   │700ms    │   │900ms    │   │800ms    │   │600ms    │      │
│  └─────────┘   └─────────┘   └─────────┘   └─────────┘   └─────────┘      │
│                     │                          │                           │
│                     │                          │                           │
│               Stage 6                         │                           │
│               ┌─────────┐                     │                           │
│               │Final    │ ←───────────────────┘                           │
│               │Review   │                                                 │
│               │850ms    │                                                 │
│               └─────────┘                                                 │
│                     │                                                      │
│               Stage 7                                                      │
│               ┌─────────┐                                                 │
│               │Assign-  │                                                 │
│               │ment     │                                                 │
│               │650ms    │                                                 │
│               └─────────┘                                                 │
└─────────────────────────────────────────────────────────────────────────────┘

Total Estimated Duration: ~5.7 seconds
```

## Agent Details

### Stage 1: Template Analysis Agent (800ms)

**Purpose**: Analyzes available templates and selects the most appropriate one for the procurement type.

**Input Data**:
```javascript
{
  extractedData: { procurement_type, items, destination_country, ... },
  discipline: '01900',
  templates_available: true
}
```

**Output**:
```javascript
{
  selectedTemplate: 'procurement_equipment_sow',
  templateMatch: 0.95,
  requiredFields: ['procurement_type', 'items', 'estimated_value'],
  optionalFields: ['requirements', 'timeline']
}
```

**Agent Logic**:
1. Query templates database for discipline 01900
2. Match procurement type to template categories
3. Identify required vs optional fields
4. Return template selection with confidence score

### Stage 2: Requirements Extraction Agent (700ms)

**Purpose**: Extracts structured requirements from the chat conversation.

**Input Data**:
```javascript
{
  extractedData: { ... },
  messages: [ conversation history ],
  session_context: { currentStep, sessionId }
}
```

**Output**:
```javascript
{
  requirements: {
    technical: ['specification1', 'specification2'],
    compliance: ['ISO 9001', 'API standards'],
    delivery: ['DAP Incoterms', 'CDC for Guinea'],
    special: ['training required', 'installation support']
  },
  confidence: 0.92,
  missingFields: []
}
```

**Agent Logic**:
1. Parse conversation messages for requirements keywords
2. Cross-reference with extracted data fields
3. Identify missing or incomplete requirements
4. Generate structured requirements object

### Stage 3: Compliance Validation Agent (900ms) ⚠️ HITL Gate 1

**Purpose**: Validates regulatory and policy compliance requirements.

**Input Data**:
```javascript
{
  extractedData: { ... },
  governance_attributes: { fieldAttributes },
  validation_status: { isValid, errors }
}
```

**Output**:
```javascript
{
  complianceStatus: 'valid',
  checks: {
    regulatory: { status: 'pass', details: '...' },
    policy: { status: 'pass', details: '...' },
    customs: { status: 'pass', details: 'CDC required for Guinea' }
  },
  warnings: ['CDC documentation required for Guinea imports'],
  hitlRequired: true
}
```

**HITL Gate 1**:
- User reviews compliance requirements
- Confirms CDC and customs documentation needs
- Approves or requests changes

**Agent Logic**:
1. Check destination country compliance requirements
2. Validate against governance field attributes
3. Apply business rules (approval thresholds, restricted items)
4. Flag HITL review if compliance issues detected

### Stage 4: Field Population Agent (800ms)

**Purpose**: Populates template fields with extracted and validated data.

**Input Data**:
```javascript
{
  extractedData: { ... },
  templates: { selectedTemplate },
  field_attributes: { governance attributes }
}
```

**Output**:
```javascript
{
  populatedFields: {
    procurement_type: 'Equipment',
    items: [...],
    estimated_value: 125000,
    destination: 'Guinea',
    // ... all SOW fields
  },
  skippedFields: ['special_requirements'],
  fieldValidation: { valid: true, errors: [] }
}
```

**Agent Logic**:
1. Apply field attributes (readonly, editable, ai_editable)
2. Map extracted data to template fields
3. Apply formatting (currency, dates, lists)
4. Validate populated fields against schema

### Stage 5: Quality Assurance Agent (600ms)

**Purpose**: Performs quality checks on populated data and documents.

**Input Data**:
```javascript
{
  extractedData: { ... },
  validation_results: { ... },
  agent_results: { templateAnalysis, requirementsExtraction, ... },
  completeness_check: 85
}
```

**Output**:
```javascript
{
  qaStatus: 'passed',
  checks: {
    completeness: { score: 85, missing: [] },
    consistency: { score: 92, issues: [] },
    formatting: { score: 100, issues: [] }
  },
  recommendations: ['Consider adding delivery timeline']
}
```

**Agent Logic**:
1. Calculate completeness percentage
2. Check data consistency across fields
3. Validate formatting and data types
4. Generate improvement recommendations

### Stage 6: Final Review Agent (850ms) ⚠️ HITL Gate 2

**Purpose**: Performs final document review before submission.

**Input Data**:
```javascript
{
  extractedData: { ... },
  all_agent_results: { ... },
  final_validation: { ... },
  document_readiness: true
}
```

**Output**:
```javascript
{
  reviewStatus: 'approved',
  documentQuality: 0.94,
  sections: {
    introduction: { status: 'complete', quality: 0.95 },
    scope: { status: 'complete', quality: 0.92 },
    specifications: { status: 'complete', quality: 0.96 },
    // ... all sections
  },
  hitlRequired: true
}
```

**HITL Gate 2**:
- User reviews final SOW document
- Confirms all sections are accurate
- Approves for order creation

**Agent Logic**:
1. Review all document sections
2. Calculate quality scores per section
3. Verify all required sections present
4. Flag for HITL review before final submission

### Stage 7: Assignment Agent (650ms)

**Purpose**: Assigns tasks and routes workflow for approval.

**Input Data**:
```javascript
{
  extractedData: { ... },
  workflow_results: { all agent results },
  task_distribution: {
    sow_generation: true,
    document_compilation: true,
    approval_routing: true
  }
}
```

**Output**:
```javascript
{
  assignments: {
    sowGeneration: { assigned: true, status: 'complete' },
    documentCompilation: { assigned: true, status: 'pending' },
    approvalRouting: { assigned: true, approver: 'procurement_manager' }
  },
  nextSteps: ['Submit for approval', 'Generate appendices'],
  workflowComplete: true
}
```

**Agent Logic**:
1. Determine required next steps
2. Assign tasks to appropriate roles
3. Route for approval based on value thresholds
4. Mark workflow as complete

## Streaming Implementation

### Event System
```javascript
// Workflow start event
window.dispatchEvent(new CustomEvent('streaming-workflow-started', {
  detail: { totalAgents: 7, estimatedDuration: 5700 }
}));

// Agent activation event
window.dispatchEvent(new CustomEvent('streaming-agent-activated', {
  detail: { agent: 'Template Analysis Agent', stage: 1, totalStages: 7 }
}));

// Agent completion event
window.dispatchEvent(new CustomEvent('streaming-agent-completed', {
  detail: { agent: 'Template Analysis Agent', stage: 1, result: {...} }
}));

// Workflow completion event
window.dispatchEvent(new CustomEvent('streaming-workflow-completed', {
  detail: { totalAgents: 7, duration: 5700, allResults: {...} }
}));
```

### State Management
```javascript
const [streamingWorkflow, setStreamingWorkflow] = useState({
  isActive: false,
  currentAgent: null,
  completedAgents: new Set(),
  totalAgents: 7,
  startTime: null,
  estimatedDuration: 5700
});

const [specialistAgents, setSpecialistAgents] = useState({
  templateAnalysis: null,
  requirementsExtraction: null,
  complianceValidation: null,
  fieldPopulation: null,
  qualityAssurance: null,
  finalReview: null,
  assignment: null
});
```

### Progress Tracking
```javascript
// Progress bar calculation
const progress = (completedAgents.size / totalAgents) * 100;

// Time estimation
const elapsed = Date.now() - streamingWorkflow.startTime;
const remaining = streamingWorkflow.estimatedDuration - elapsed;
```

## HITL Gate Implementation

### Gate 1: Compliance Validation
```javascript
// Trigger HITL Gate 1
if (complianceValidation.hitlRequired) {
  // Pause workflow
  setStreamingWorkflow(prev => ({ ...prev, isActive: false }));
  
  // Show compliance review modal
  showComplianceReviewModal({
    checks: complianceValidation.checks,
    warnings: complianceValidation.warnings,
    onApprove: () => resumeWorkflow(),
    onModify: () => returnToChat()
  });
}
```

### Gate 2: Final Review
```javascript
// Trigger HITL Gate 2
if (finalReview.hitlRequired) {
  // Pause workflow
  setStreamingWorkflow(prev => ({ ...prev, isActive: false }));
  
  // Show final review modal
  showFinalReviewModal({
    documentQuality: finalReview.documentQuality,
    sections: finalReview.sections,
    onApprove: () => completeWorkflow(),
    onModify: () => returnToPreview()
  });
}
```

## Error Handling

### Agent Failure Recovery
```javascript
try {
  await agent.action();
} catch (error) {
  // Emit error event
  window.dispatchEvent(new CustomEvent('streaming-workflow-error', {
    detail: {
      error: error.message,
      failedAgent: streamingWorkflow.currentAgent,
      sessionId
    }
  }));
  
  // Trigger IT Swarm debugging
  await triggerITSwarmDebug({
    error: error.message,
    failedAgent: streamingWorkflow.currentAgent,
    context: { extractedData, sessionState }
  });
}
```

### Retry Logic
```javascript
const executeAgentWithRetry = async (agent, maxRetries = 3) => {
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await agent.action();
    } catch (error) {
      if (attempt === maxRetries) throw error;
      await new Promise(resolve => setTimeout(resolve, 1000 * attempt));
    }
  }
};
```

## Performance Optimization

### Parallel Processing (Future Enhancement)
```javascript
// Stages 1-2 can run in parallel
const [templateResult, requirementsResult] = await Promise.all([
  runTemplateAnalysis(),
  runRequirementsExtraction()
]);
```

### Caching
```javascript
// Cache template analysis results
const templateCache = new Map();
if (templateCache.has(procurementType)) {
  return templateCache.get(procurementType);
}
```

### Lazy Loading
```javascript
// Load agent implementations on demand
const loadAgent = async (agentName) => {
  const module = await import(`./agents/${agentName}.js`);
  return module.default;
};
```

## Monitoring and Metrics

### Key Metrics
- **Total Workflow Duration**: Target < 6 seconds
- **Agent Success Rate**: Target > 99%
- **HITL Gate Pass Rate**: Target > 90%
- **Error Recovery Rate**: Target > 95%

### Logging
```javascript
console.log('[STREAMING_WORKFLOW] Starting 7-agent workflow', {
  sessionId,
  extractedData: extractedDataSummary,
  timestamp: new Date().toISOString()
});

console.log('[STREAMING_WORKFLOW] Agent completed', {
  agent: agentName,
  stage: stageNumber,
  duration: agentDuration,
  result: resultSummary
});
```

## Integration Points

### API Endpoints
- `POST /api/agent-development-tasks` - Invoke specialist agents
- `POST /api/procurement/agent/validate` - Validation endpoint
- `POST /api/procurement/agent/handoff` - Order creation endpoint

### Event Listeners
```javascript
// Listen for workflow events
window.addEventListener('streaming-workflow-started', handleWorkflowStart);
window.addEventListener('streaming-agent-activated', handleAgentActivation);
window.addEventListener('streaming-agent-completed', handleAgentCompletion);
window.addEventListener('streaming-workflow-completed', handleWorkflowComplete);
window.addEventListener('streaming-workflow-error', handleWorkflowError);