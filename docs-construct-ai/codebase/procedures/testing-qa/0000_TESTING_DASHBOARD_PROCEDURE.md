---
memory_layer: durable_knowledge
para_section: pages/codebase/procedures/testing-qa
gigabrain_tags: procedures, testing-qa, codebase
documentation
openstinger_context: operational-procedures, testing-qa-practices
last_updated: 2026-03-21
related_docs:
  - codebase/procedures/
  - disciplines/
---
# Testing Dashboard Procedure

**Document ID:** 0000_TESTING_DASHBOARD_PROCEDURE  
**Discipline:** 00999 - Testing & Quality Assurance  
**Version:** 1.0  
**Last Updated:** 2026-02-19  

---

## Document Usage Guide

**🎯 This Document's Role**: Comprehensive procedure for running, monitoring, and managing tests across all ConstructAI workflows using the Testing Dashboard. **Use this guide** for test execution, result analysis, and coverage tracking.

**📚 Related Documents in Testing & Documentation Ecosystem:**

- **`docs/workflows-simulations/TESTING_FRAMEWORK.md`** → Overall testing framework and strategy
- **`docs/workflows-simulations/01900_TESTING_GUIDE_HANDOFF_SYSTEM.md`** → Handoff system specific testing
- **`docs/standards/0002_FILE_NAMING_STANDARDS.md`** → File naming conventions
- **`docs/standards/0005_WORKFLOW_OPTIMIZATION_STANDARDS.md`** → Workflow optimization standards
- **`deep-agents/docs/0000_WORKFLOW_OPTIMIZATION_GUIDE.md`** → Agent workflow optimization

---

## 1. Purpose

This procedure defines how to use the Testing Dashboard for running, monitoring, and managing tests across all ConstructAI workflows. The dashboard provides a centralized interface for executing tests, viewing results, and tracking coverage.

---

## 2. Scope

This procedure applies to:
- All workflow tests (Procurement, Correspondence, Governance, Contractor Vetting)
- Integration tests
- Unit tests
- Security tests
- End-to-end tests

---

## 3. Architecture Overview

### 3.1 No-Duplication Design

The Testing Dashboard follows a **single source of truth** architecture where test definitions are stored only in actual test files. The dashboard reads these definitions dynamically via API.

```
┌─────────────────────────────────────────────────────────────────┐
│                    Testing Dashboard (UI)                        │
│  Location: client/src/pages/02050-testing-dashboard/             │
│                                                                  │
│  - Fetches test metadata from API                               │
│  - No hardcoded test definitions                                │
│  - Displays what's in actual test files                         │
└──────────────────────────┬──────────────────────────────────────┘
                           │ GET /api/test-metadata/structure
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                 Test Metadata API                                │
│  Location: server/src/routes/test-metadata-routes.js             │
│                                                                  │
│  - Scans test files for exported testMetadata                    │
│  - Parses and returns test structure                             │
│  - Provides source file references                               │
└──────────────────────────┬──────────────────────────────────────┘
                           │ Reads
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                 Actual Test Files                                │
│  Example: server/src/tests/01900_procurement/                    │
│           01900_procurement_workflow.test.js                     │
│                                                                  │
│  export const testMetadata = {                                   │
│    workflow: '01900-procurement',                                │
│    parts: [{                                                     │
│      sourceFile: 'ProcurementInputAgent.js',                     │
│      sourceClass: 'ProcurementInputAgent',                       │
│      mockScenarios: [...],                                       │
│      tests: [...]                                                │
│    }]                                                            │
│  }                                                               │
│                                                                  │
│  // Tests IMPORT actual source code:                             │
│  import { ProcurementInputAgent } from '...';                    │
└─────────────────────────────────────────────────────────────────┘
```

### 3.2 Key Components

| Component | Location | Purpose |
|-----------|----------|---------|
| Testing Dashboard UI | `client/src/pages/02050-testing-dashboard/` | User interface for test management |
| Test Metadata API | `server/src/routes/test-metadata-routes.js` | Serves test structure from actual files |
| Test Files | `server/src/tests/` | Contain tests and exported metadata |
| Source Code | `deep-agents/deep_agents/agents/pages/` | Production code being tested |

---

## 4. Accessing the Dashboard

### 4.1 Navigation Path

1. Open ConstructAI application
2. Navigate to: **Information Technology** → **Developer settings** → **Testing Dashboard**
3. URL: `/testing-dashboard`

### 4.2 Dashboard Tabs

| Tab | Description |
|-----|-------------|
| **Overview** | Summary statistics, test suites list, quick actions |
| **Agent Tests** | Workflow-specific tests loaded from actual test files |
| **Test Suites** | All test suites with filtering and selection |
| **Results** | Test execution results with pass/fail breakdown |
| **Coverage** | Code coverage reports by category |
| **History** | Historical test run data |

---

## 5. Running Tests

### 5.0 Test Execution Flow (Practical Overview)

When you click "Run Tests" in the dashboard, the following sequence occurs:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        TEST EXECUTION FLOW                                   │
└─────────────────────────────────────────────────────────────────────────────┘

USER ACTION                    SYSTEM RESPONSE                    RESULT
─────────────                  ───────────────                    ───────

1. Click "Run Tests"  ──────►  POST /api/workflow-tests/run     ──►  Test queued
   on workflow card            {
     workflowId: '01900...'
     testFile: '01900_procurement_workflow.test.js'
     parts: [...]
   }

                          ┌─────────────────────────────────────────────────┐
                          │ SERVER: test-runner-service.js                  │
                          │                                                 │
   2. Server receives   ──►│  a) Locate test file on disk                   │
      request              │  b) Spawn Jest process                          │
                          │  c) Stream results back to client               │
                          └─────────────────────────────────────────────────┘

                          ┌─────────────────────────────────────────────────┐
                          │ JEST: Test Execution                            │
                          │                                                 │
   3. Jest executes     ──►│  For each part:                                 │
      test file            │    For each mockScenario:                       │
                          │      a) Load mockData                           │
                          │      b) Import source code class                │
                          │      c) Execute test functions                  │
                          │      d) Capture pass/fail results               │
                          │                                                 │
                          │  Example:                                       │
                          │  ┌───────────────────────────────────────────┐  │
                          │  │ import { ProcurementInputAgent }          │  │
                          │  │   from '../../../deep-agents/...';        │  │
                          │  │                                           │  │
                          │  │ const agent = new ProcurementInputAgent();│  │
                          │  │ const result = await agent.initialize();  │  │
                          │  │ expect(result.status).toBe('initialized');│  │
                          │  └───────────────────────────────────────────┘  │
                          └─────────────────────────────────────────────────┘

   4. Results stream   ◄────  { passed: 45, failed: 2, skipped: 1,         ──►  Dashboard
      back to client          duration: '1.5s', parts: [...] }                updates UI

   5. Dashboard        ──────►  Display in Results tab  ──────────────────►  User sees
      renders results                                                       pass/fail
```

### 5.0.1 Command Line Alternative

Tests can also be run directly via command line:

```bash
# Run specific workflow test
npm test -- server/src/tests/01900_procurement/01900_procurement_workflow.test.js

# Run all tests in a directory
npm test -- server/src/tests/01900_procurement/

# Run with coverage
npm test -- --coverage server/src/tests/01900_procurement/

# Run specific test part (using Jest test name pattern)
npm test -- -t "Part 1: Order Creation" server/src/tests/01900_procurement/
```

### 5.0.2 Test Runner Service Implementation

The server-side test runner (`server/src/services/test-runner-service.js`) handles execution:

```javascript
// Pseudocode for test runner service
class TestRunnerService {
  async runWorkflowTests(workflowId, testFile, parts) {
    // 1. Resolve full path to test file
    const testPath = path.join(__dirname, '../tests', testFile);
    
    // 2. Execute Jest as child process
    const result = await exec(`npx jest ${testPath} --json`);
    
    // 3. Parse results
    const testResults = JSON.parse(result.stdout);
    
    // 4. Map results to parts structure
    return {
      passed: testResults.numPassedTests,
      failed: testResults.numFailedTests,
      skipped: testResults.numPendingTests,
      duration: testResults.testRunDurationMs / 1000,
      parts: this.mapResultsToParts(testResults, parts)
    };
  }
}
```

### 5.0.3 Real-Time Result Streaming

For long-running tests, results stream via WebSocket:

```javascript
// Client subscribes to test run
socket.emit('run-tests', { workflowId: '01900-procurement' });

// Server streams progress
socket.on('test-progress', (data) => {
  // data: { part: 'Part 1', test: 'Modal opens...', status: 'passed' }
  updateUI(data);
});

// Final results
socket.on('test-complete', (results) => {
  // results: { passed: 45, failed: 2, ... }
  displayFinalResults(results);
});
```

/Users/_General/Feb-19-1/deep-agents/deep_agents/agents/shared/ai_it_specialists 

#### Feedback Loop Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        TEST FEEDBACK LOOP                                    │
└─────────────────────────────────────────────────────────────────────────────┘

┌──────────────┐    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│   DASHBOARD  │───►│   TEST API   │───►│    JEST      │───►│ SOURCE CODE  │
│     (UI)     │    │   (Server)   │    │  (Runner)    │    │   (Agent)    │
└──────────────┘    └──────────────┘    └──────────────┘    └──────────────┘
       ▲                   │                   │                   │
       │                   │                   │                   │
       │                   ▼                   ▼                   ▼
       │            ┌─────────────────────────────────────────────────────┐
       │            │                  FEEDBACK DATA                      │
       │            ├─────────────────────────────────────────────────────┤
       └────────────│  • Mock data snapshot                              │
                    │  • Decision fork taken (with reason)               │
                    │  • Routing path visualization                      │
                    │  • Agent state at each step                        │
                    │  • Expected vs actual outcomes                     │
                    │  • Execution timeline                              │
                    └─────────────────────────────────────────────────────┘
```

#### Detailed Test Result Structure

Each test result includes comprehensive feedback:

```javascript
{
  testId: 'part_1_order_creation_scenario_domestic',
  testName: 'Domestic Order (ZA)',
  timestamp: '2026-02-19T18:55:00Z',
  duration: '1.23s',
  status: 'passed',
  
  // FEEDBACK: Mock data used
  mockDataUsed: {
    supplier_country: 'ZA',
    delivery_country: 'ZA',
    currency: 'ZAR',
    order_value: 500000,
    is_international: false
  },
  
  // FEEDBACK: Decision forks encountered
  decisionForks: [
    {
      fork: 'is_international',
      condition: 'delivery_country !== supplier_country',
      evaluatedValue: false,
      pathTaken: 'DOMESTIC_FLOW',
      reason: 'ZA to ZA - domestic order'
    },
    {
      fork: 'cdc_required',
      condition: 'delivery_country === "GN"',
      evaluatedValue: false,
      pathTaken: 'NO_CDC',
      reason: 'Not Guinea destination'
    },
    {
      fork: 'hitl_required',
      condition: 'order_value >= 1000000',
      evaluatedValue: false,
      pathTaken: 'STANDARD_APPROVAL',
      reason: 'Order value R500,000 below R1M threshold'
    }
  ],
  
  // FEEDBACK: Routing path visualization
  routingPath: {
    start: 'OrderCreationModal',
    steps: [
      { step: 1, agent: 'ProcurementInputAgent', action: 'initialize', duration: '0.1s' },
      { step: 2, agent: 'ProcurementInputAgent', action: 'extractOrderData', duration: '0.3s' },
      { step: 3, agent: 'ProcurementInputAgent', action: 'createSOW', duration: '0.5s' },
      { step: 4, agent: 'ProcurementInputAgent', action: 'saveOrder', duration: '0.33s' }
    ],
    end: 'OrderSaved',
    branchesNotTaken: ['CDC_SUBMISSION', 'HITL_REVIEW', 'HAZARDOUS_HANDLING']
  },
  
  // FEEDBACK: Agent state snapshots
  agentStates: [
    {
      step: 'after_initialize',
      state: {
        modalOpen: true,
        threadId: 'thread-abc123',
        userInput: 'I need to order mining equipment'
      }
    },
    {
      step: 'after_extract',
      state: {
        extractedData: {
          supplier: 'Caterpillar SA',
          items: ['Excavator CAT 320', 'Dump Truck Volvo A40G'],
          deliveryLocation: 'Johannesburg'
        }
      }
    }
  ],
  
  // FEEDBACK: Expected vs Actual
  assertions: [
    {
      description: 'Order should be saved as domestic',
      expected: { is_international: false },
      actual: { is_international: false },
      passed: true
    },
    {
      description: 'No CDC submission should be created',
      expected: { cdc_submission: null },
      actual: { cdc_submission: null },
      passed: true
    }
  ]
}
```

#### Dashboard Feedback Display

The Results tab shows detailed feedback for each test:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ TEST RESULT: Domestic Order (ZA)                                   ✓ PASSED │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│ MOCK DATA USED                                                              │
│ ┌─────────────────────────────────────────────────────────────────────────┐ │
│ │ supplier_country: ZA    delivery_country: ZA    currency: ZAR           │ │
│ │ order_value: R500,000   is_international: false                        │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│ DECISION FORKS                                                              │
│ ┌─────────────────────────────────────────────────────────────────────────┐ │
│ │ ✓ is_international: false → DOMESTIC_FLOW                              │ │
│ │   └── Reason: ZA to ZA - domestic order                                │ │
│ │                                                                         │ │
│ │ ✓ cdc_required: false → NO_CDC                                         │ │
│ │   └── Reason: Not Guinea destination                                   │ │
│ │                                                                         │ │
│ │ ✓ hitl_required: false → STANDARD_APPROVAL                             │ │
│ │   └── Reason: Order value R500,000 below R1M threshold                 │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│ ROUTING PATH                                                                │
│ ┌─────────────────────────────────────────────────────────────────────────┐ │
│ │ OrderCreationModal                                                      │ │
│ │     │                                                                   │ │
│ │     ▼ [ProcurementInputAgent.initialize - 0.1s]                        │ │
│ │     │                                                                   │ │
│ │     ▼ [ProcurementInputAgent.extractOrderData - 0.3s]                 │ │
│ │     │                                                                   │ │
│ │     ▼ [ProcurementInputAgent.createSOW - 0.5s]                        │ │
│ │     │                                                                   │ │
│ │     ▼ [ProcurementInputAgent.saveOrder - 0.33s]                       │ │
│ │     │                                                                   │ │
│ │ OrderSaved                                                              │ │
│ │                                                                         │ │
│ │ Branches NOT taken: [CDC_SUBMISSION, HITL_REVIEW, HAZARDOUS_HANDLING]  │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│ ASSERTIONS                                              5/5 passed          │
│ ┌─────────────────────────────────────────────────────────────────────────┐ │
│ │ ✓ Order should be saved as domestic                                    │ │
│ │ ✓ No CDC submission should be created                                  │ │
│ │ ✓ SOW should be created before item selection                          │ │
│ │ ✓ Professional tone in generated text                                  │ │
│ │ ✓ Data validation passes                                               │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│ [View Full Log] [Download JSON] [Re-run Test] [Compare with Other]         │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Comparison View for Different Scenarios

Users can compare how different mock data leads to different paths:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ SCENARIO COMPARISON: Order Creation                                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                    Domestic (ZA)      International (GN)      High-Value    │
│ MOCK DATA        ─────────────────────────────────────────────────────────  │
│ order_value      R500,000            USD 85,000             R5,500,000     │
│ delivery_country ZA                  GN                      GN             │
│ is_international false               true                    true           │
│                                                                             │
│ DECISION FORKS   ─────────────────────────────────────────────────────────  │
│ cdc_required     ✗ NO_CDC            ✓ CDC_SUBMISSION       ✓ CDC_SUBMISSION│
│ hitl_required    ✗ STANDARD          ✗ STANDARD             ✓ HITL_REVIEW   │
│ ddi_required     ✗ N/A               ✓ DDI_REQUIRED         ✓ DDI_REQUIRED  │
│                                                                             │
│ FINAL PATH       ─────────────────────────────────────────────────────────  │
│                  OrderSaved          →CDC→OrderSaved    →HITL→CDC→OrderSaved│
│                                                                             │
│ DURATION         1.2s                2.8s                   3.5s            │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Implementation: Test Logger Service

```javascript
// server/src/services/test-logger-service.js
class TestLoggerService {
  constructor() {
    this.currentTest = null;
    this.decisionForks = [];
    this.routingPath = [];
    this.agentStates = [];
  }

  // Called at test start
  startTest(testId, mockData) {
    this.currentTest = {
      testId,
      mockDataUsed: mockData,
      startTime: Date.now(),
      decisionForks: [],
      routingPath: [],
      agentStates: []
    };
  }

  // Called when a decision fork is encountered
  logDecisionFork(forkName, condition, evaluatedValue, pathTaken, reason) {
    this.currentTest.decisionForks.push({
      fork: forkName,
      condition,
      evaluatedValue,
      pathTaken,
      reason,
      timestamp: Date.now()
    });
    
    // Stream to dashboard in real-time
    this.emit('decision-fork', {
      testId: this.currentTest.testId,
      fork: forkName,
      pathTaken,
      reason
    });
  }

  // Called at each routing step
  logRoutingStep(agent, action, duration) {
    this.currentTest.routingPath.push({
      step: this.currentTest.routingPath.length + 1,
      agent,
      action,
      duration,
      timestamp: Date.now()
    });
    
    this.emit('routing-step', {
      testId: this.currentTest.testId,
      agent,
      action
    });
  }

  // Called to capture agent state
  logAgentState(stepName, state) {
    this.currentTest.agentStates.push({
      step: stepName,
      state: JSON.parse(JSON.stringify(state)), // Deep copy
      timestamp: Date.now()
    });
  }

  // Called at test end
  endTest(status, assertions) {
    const result = {
      ...this.currentTest,
      endTime: Date.now(),
      duration: `${((Date.now() - this.currentTest.startTime) / 1000).toFixed(2)}s`,
      status,
      assertions
    };
    
    this.emit('test-complete', result);
    return result;
  }
}

export const testLogger = new TestLoggerService();
```

#### Usage in Test Files

```javascript
import { testLogger } from '../services/test-logger-service.js';

describe('Part 1: Order Creation', () => {
  test('Domestic Order (ZA)', async () => {
    const mockData = testMetadata.parts[0].mockScenarios[0].mockData;
    
    // Start logging with mock data
    testLogger.startTest('part_1_domestic', mockData);
    
    const agent = new ProcurementInputAgent();
    
    // Log routing steps
    testLogger.logRoutingStep('ProcurementInputAgent', 'initialize', '0.1s');
    await agent.initialize(mockData);
    
    // Log decision forks
    const isInternational = mockData.delivery_country !== mockData.supplier_country;
    testLogger.logDecisionFork(
      'is_international',
      'delivery_country !== supplier_country',
      isInternational,
      isInternational ? 'INTERNATIONAL_FLOW' : 'DOMESTIC_FLOW',
      `${mockData.supplier_country} to ${mockData.delivery_country}`
    );
    
    // Log agent state
    testLogger.logAgentState('after_initialize', agent.getState());
    
    // Continue test...
    const result = await agent.processOrder(mockData);
    
    // End test with assertions
    const assertions = [
      { description: 'Order saved as domestic', expected: false, actual: result.is_international, passed: result.is_international === false }
    ];
    
    testLogger.endTest('passed', assertions);
  });
});
```

### 5.1 Quick Actions (Overview Tab)

From the Overview tab, use Quick Actions to run common test suites:

| Button | Tests Executed |
|--------|----------------|
| Run Procurement Tests | All 01900 procurement workflow tests |
| Run Integration Tests | API integration tests |
| Run Unit Tests | Individual module tests |
| Run Security Tests | XSS, SQL injection, authentication tests |

### 5.2 Running All Tests

1. Click **Run All Tests** button in the header
2. Monitor progress in the Results tab
3. Review pass/fail statistics

### 5.3 Running Selected Tests

1. Navigate to Overview or Test Suites tab
2. Check the boxes next to desired test suites
3. Click **Run Selected (N)** button

### 5.4 Running Workflow Tests

1. Navigate to **Agent Tests** tab
2. Locate the desired workflow card
3. Click **Run Tests** button on the workflow card
4. Results appear in the Results tab

---

## 6. Understanding Test Structure

### 6.1 Workflow Test Parts

Each workflow test is organized into **parts** representing workflow stages:

**Example: Procurement (01900) Workflow**

| Part | Description | Source File |
|------|-------------|-------------|
| Part 1: Order Creation | User creates order via modal | `ProcurementInputAgent.js` |
| Part 2: Input Agent Pipeline | Agent processes and extracts requirements | `ProcurementInputAgent.js` |
| Part 3: 6-Agent Pipeline | Template → Extraction → Compliance → Population → QA → Review | Multiple agents |
| Part 4: Order Signed Handoff | Handoff events to Logistics and CDC | `handoff-events.js` |

### 6.2 Mock Scenarios

Each part includes mock scenarios for different test conditions:

| Scenario | Description | Mock Data |
|----------|-------------|-----------|
| Domestic Order (ZA) | South African supplier, local delivery | `supplier_country: 'ZA', delivery_country: 'ZA'` |
| International Order (Guinea) | International with CDC requirements | `cdc_required: true, nif: '123456789'` |
| High-Value Order (>R1M) | Triggers HITL review | `hitl_required: true` |
| Hazardous Materials | Special handling required | `hazardous_materials: true` |

### 6.3 Generic Tests

Each part concludes with generic validation tests:

- Professional tone in all generated text
- Data validation passes (required fields)
- Error handling for invalid inputs
- Governance compliance (@with_governance)
- ISO 42001 compliance for AI decisions
- Audit trail completeness

---

## 7. Creating New Tests

### 7.1 Test File Requirements

Each test file must:

1. **Export testMetadata object:**
```javascript
export const testMetadata = {
  workflow: '01900-procurement',
  name: 'Procurement (01900) Full Workflow',
  description: 'Complete procurement workflow tests',
  parts: [
    {
      id: 'part_1_order_creation',
      name: 'Part 1: Order Creation',
      description: 'User creates order via modal',
      sourceFile: 'ProcurementInputAgent.js',
      sourceClass: 'ProcurementInputAgent',
      mockScenarios: [...],
      tests: [...],
      genericTests: [...]
    }
  ]
};
```

2. **Import actual source code:**
```javascript
import { ProcurementInputAgent } from '../../../deep-agents/deep_agents/agents/pages/01900-procurement/input-agent/agents/ProcurementInputAgent.js';
```

3. **Test against production code:**
```javascript
describe('Part 1: Order Creation', () => {
  let inputAgent;
  
  beforeAll(() => {
    inputAgent = new ProcurementInputAgent();
  });

  test('Modal opens with correct initial state', async () => {
    const result = await inputAgent.initialize(mockData);
    expect(result).toBeDefined();
  });
});
```

### 7.2 File Location

Place test files in the appropriate directory:

| Test Type | Directory |
|-----------|-----------|
| Procurement | `server/src/tests/01900_procurement/` |
| Safety | `server/src/tests/02400_safety/` |
| Integration | `server/src/tests/integration/` |
| Unit | `server/src/tests/unit/` |

### 7.3 Automatic Discovery

The API automatically discovers new test files. No dashboard configuration needed.

---

## 8. API Endpoints

### 8.1 Test Metadata Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/test-metadata/structure` | GET | Full test structure for dashboard |
| `/api/test-metadata/workflows` | GET | List all workflow test files |
| `/api/test-metadata/workflow/:id` | GET | Specific workflow metadata |
| `/api/test-metadata/source/:workflowId/:partId` | GET | Source file reference for a part |

### 8.2 Test Execution Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/test-runner/run` | POST | Run specified test suites |
| `/api/workflow-tests/run` | POST | Run workflow-specific tests |
| `/api/test-results/history` | GET | Historical test results |

---

## 9. Viewing Results

### 9.1 Results Tab

After running tests, the Results tab displays:

- **Pass/Fail/Skip counts** with visual progress bar
- **Duration** of test execution
- **Per-suite breakdown** with individual results

### 9.2 History Tab

View historical test runs:

| Column | Description |
|--------|-------------|
| Timestamp | When the test was run |
| Test Suite | Which suite was executed |
| Passed | Number of passing tests |
| Failed | Number of failing tests |
| Skipped | Number of skipped tests |
| Duration | Execution time |
| Status | Visual indicator (✓/✗) |

### 9.3 Coverage Tab

Coverage reports by category:

| Category | Target | Status |
|----------|--------|--------|
| Critical Paths | 90% | On Target / Below Target |
| API Routes | 80% | On Target / Below Target |
| Business Logic | 75% | On Target / Below Target |
| UI Components | 60% | On Target / Below Target |

---

## 10. Troubleshooting

### 10.1 No Test Definitions Loaded

**Symptom:** Agent Tests tab shows "No workflow test definitions found"

**Solution:**
1. Verify test files export `testMetadata` object
2. Check API endpoint `/api/test-metadata/structure` returns data
3. Ensure test files are in correct directories

### 10.2 API Errors

**Symptom:** "Could not load test metadata from API"

**Solution:**
1. Check server is running
2. Verify routes are registered in server configuration
3. Check file permissions for test directories

### 10.3 Tests Not Running

**Symptom:** Click "Run Tests" but no results appear

**Solution:**
1. Check browser console for errors
2. Verify `/api/workflow-tests/run` endpoint exists
3. Ensure Jest is configured correctly

---

## 11. Best Practices

### 11.1 Test Organization

- Group tests by workflow part
- Use descriptive test names
- Include both positive and negative test cases
- Add generic tests for compliance validation

### 11.2 Mock Data

- Use realistic mock data matching production scenarios
- Include edge cases (high-value, international, hazardous)
- Document mock scenario purposes

#### 11.2.1 Mock Data Design Principle: Cover All Decision Forks

Mock data must be designed to exercise **all possible decision forks** in the workflow. Each fork represents a point where different conditions lead to different outcomes.

**Required Mock Data Categories:**

| Decision Fork | Mock Scenario | Outcome |
|---------------|---------------|---------|
| **Order Value** | `< R1,000,000` | Standard approval flow |
| **Order Value** | `≥ R1,000,000` | HITL review required |
| **Destination Country** | `ZA (Domestic)` | No CDC requirements |
| **Destination Country** | `GN (Guinea)` | CDC submission required, DDI if >$1,250 |
| **Destination Country** | `Other International` | Standard import/export docs |
| **Import Required** | `Yes (cross-border)` | Import documentation package |
| **Import Required** | `No (domestic)` | No import docs needed |
| **Export Required** | `Yes (cross-border)` | Export documentation package |
| **Export Required** | `No (domestic)` | No export docs needed |
| **Materials** | `Standard` | Normal handling |
| **Materials** | `Hazardous` | Special handling, additional docs |
| **Supplier Type** | `Registered` | Standard vendor flow |
| **Supplier Type** | `New Vendor` | Vetting workflow triggered |

**Example: CDC Decision Fork Mock Data**

```javascript
// Mock scenario: Triggers CDC submission fork
{
  id: 'scenario_guinea_cdc_required',
  name: 'Guinea Import (CDC Required)',
  description: 'Tests the CDC submission decision fork',
  mockData: {
    supplier_country: 'ZA',
    delivery_country: 'GN',        // Triggers CDC fork
    order_value_usd: 85000,        // > $1,250 triggers DDI
    cdc_required: true,
    ddi_required: true,
    nif: '123456789',              // Required for CDC
    rccm: 'RCCM-GN-2019-B-12345',  // Required for CDC
    customs_office: 'CKY'
  },
  expectedOutcomes: [
    'CDC submission created',
    'DDI application initiated',
    'NIF/RCCM validation triggered',
    'Handoff to 01900-CDC discipline'
  ]
}
```

**Example: HITL Decision Fork Mock Data**

```javascript
// Mock scenario: Triggers Human-in-the-Loop fork
{
  id: 'scenario_high_value_hitl',
  name: 'High-Value Order (HITL Required)',
  description: 'Tests the HITL review decision fork',
  mockData: {
    order_value: 5500000,          // > R1M triggers HITL
    currency: 'ZAR',
    hitl_threshold: 1000000,
    hitl_required: true
  },
  expectedOutcomes: [
    'Order flagged for HITL review',
    'Notification sent to approvers',
    'Workflow paused pending approval',
    'Audit trail entry created'
  ]
}
```

**Example: SOW Decision Fork Mock Data**

```javascript
// Mock scenario: Triggers SOW creation fork
{
  id: 'scenario_sow_required',
  name: 'Complex Order (SOW Required)',
  description: 'Tests the SOW creation decision fork',
  mockData: {
    order_type: 'complex',
    multiple_deliverables: true,
    sow_required: true,
    technical_specs_required: true
  },
  expectedOutcomes: [
    'SOW document created before item selection',
    'Technical specifications template loaded',
    'Deliverables breakdown initiated'
  ]
}
```

#### 11.2.2 Import/Export Decision Forks

Import and export requirements create additional decision forks based on the trade route:

**Import Documentation Decision Fork:**

| Condition | Import Docs Required | Documents Generated |
|-----------|---------------------|---------------------|
| `supplier_country === delivery_country` | No | None |
| `supplier_country !== delivery_country` | Yes | Commercial Invoice, Packing List, Bill of Lading, Certificate of Origin, Import Permit |
| `delivery_country === 'GN'` | Yes + CDC | All above + Domiciliation Request, Import Declaration, Bank Transfer Proof |
| `order_value_usd > 1250 && delivery_country === 'GN'` | Yes + CDC + DDI | All above + DDI Application |

**Export Documentation Decision Fork:**

| Condition | Export Docs Required | Documents Generated |
|-----------|---------------------|---------------------|
| `supplier_country === delivery_country` | No | None |
| `supplier_country !== delivery_country` | Yes | Export Declaration, Export Permit, Customs Clearance |
| `hazardous_materials === true` | Yes + Hazmat | All above + Phytosanitary Certificate, Dangerous Goods Declaration |

**Mock Scenario: Import/Export Cross-Border (ZA → GN)**

```javascript
{
  id: 'scenario_import_export_zn_to_gn',
  name: 'Cross-Border ZA to Guinea',
  description: 'Tests import/export documentation decision forks',
  mockData: {
    supplier_country: 'ZA',
    delivery_country: 'GN',
    order_value_usd: 85000,
    is_international: true,
    import_required: true,
    export_required: true,
    cdc_required: true,
    ddi_required: true
  },
  expectedOutcomes: [
    // Export docs (from ZA)
    'Export Declaration created',
    'Export Permit application initiated',
    'Customs Clearance (ZA) initiated',
    'Port of Exit: DUR (Durban)',
    
    // Import docs (to GN)
    'Commercial Invoice generated',
    'Packing List generated',
    'Bill of Lading created',
    'Certificate of Origin created',
    'Import Permit application initiated',
    
    // CDC docs (Guinea specific)
    'Domiciliation Request created',
    'Import Declaration (DDI) initiated',
    'Bank Transfer Proof required',
    'Customs Duty Receipt pending',
    
    // Handoff events
    'Handoff to 01700 Logistics discipline',
    'Handoff to 01900-CDC discipline'
  ],
  documentPackage: {
    export: ['export_declaration', 'export_permit', 'customs_clearance_za'],
    import: ['commercial_invoice', 'packing_list', 'bill_of_lading', 'certificate_of_origin', 'import_permit'],
    cdc: ['domiciliation_request', 'import_declaration', 'bank_transfer_proof', 'customs_duty_receipt']
  }
}
```

#### 11.2.3 Document Compilation Tests

Document compilation tests verify that all required documents are retrieved and assembled correctly:

**Test Suite: Document Compilation**

```javascript
describe('Document Compilation Tests', () => {
  describe('SOW Document Retrieval', () => {
    test('should retrieve SOW document with all sections', async () => {
      const sow = await documentService.getSOW(orderId);
      expect(sow).toBeDefined();
      expect(sow.type).toBe('scope_of_work');
      expect(sow.sections).toHaveLength(3);
      expect(sow.status).toBe('approved');
    });

    test('should validate SOW section structure', async () => {
      const sow = await documentService.getSOW(orderId);
      sow.sections.forEach(section => {
        expect(section).toHaveProperty('id');
        expect(section).toHaveProperty('title');
        expect(section).toHaveProperty('content');
      });
    });
  });

  describe('Appendix A-F Compilation', () => {
    test('should compile Appendix A - Pricing Schedule', async () => {
      const appendixA = await documentService.getAppendixA(orderId);
      expect(appendixA.items).toHaveLength(3);
      expect(appendixA.grand_total).toBeGreaterThan(0);
    });

    test('should compile all 6 appendices', async () => {
      const appendices = await documentService.getAllAppendices(orderId);
      expect(appendices).toHaveLength(6);
      expect(appendices.map(a => a.type)).toEqual([
        'appendix_a', 'appendix_b', 'appendix_c', 
        'appendix_d', 'appendix_e', 'appendix_f'
      ]);
    });
  });

  describe('Import Documentation Compilation', () => {
    test('should compile import documents for Guinea', async () => {
      const importDocs = await documentService.getImportDocs(orderId);
      expect(importDocs.destination_country).toBe('GN');
      expect(importDocs.documents).toContain('commercial_invoice');
      expect(importDocs.documents).toContain('bill_of_lading');
      expect(importDocs.documents).toContain('import_permit');
    });

    test('should identify required import documents', async () => {
      const importDocs = await documentService.getImportDocs(orderId);
      const requiredDocs = importDocs.documents.filter(d => d.required);
      expect(requiredDocs.length).toBe(5);
    });
  });

  describe('Export Documentation Compilation', () => {
    test('should compile export documents for South Africa', async () => {
      const exportDocs = await documentService.getExportDocs(orderId);
      expect(exportDocs.origin_country).toBe('ZA');
      expect(exportDocs.documents).toContain('export_declaration');
      expect(exportDocs.documents).toContain('customs_clearance');
    });
  });

  describe('CDC Documentation Compilation (Guinea)', () => {
    test('should compile CDC documents for Guinea import', async () => {
      const cdcDocs = await documentService.getCDCDocs(orderId);
      expect(cdcDocs.destination_country).toBe('GN');
      expect(cdcDocs.importer_nif).toBeDefined();
      expect(cdcDocs.importer_rccm).toBeDefined();
    });

    test('should identify DDI requirement based on value', async () => {
      const cdcDocs = await documentService.getCDCDocs(orderId);
      // DDI required for orders > $1,250 USD to Guinea
      expect(cdcDocs.estimated_value_usd).toBeGreaterThan(1250);
      expect(cdcDocs.ddi_required).toBe(true);
    });
  });

  describe('Complete Document Package Compilation', () => {
    test('should compile complete procurement document package', async () => {
      const completePackage = await documentService.compilePackage(orderId);
      
      expect(completePackage.sow).toBeDefined();
      expect(Object.keys(completePackage.appendices)).toHaveLength(6);
      expect(completePackage.order).toBeDefined();
      expect(completePackage.importDocs).toBeDefined();
      expect(completePackage.exportDocs).toBeDefined();
      expect(completePackage.cdcDocs).toBeDefined();
    });

    test('should validate document package completeness', async () => {
      const validation = await documentService.validatePackage(orderId);
      
      expect(validation.missingDocuments).toEqual([]);
      expect(validation.completenessPercentage).toBe(100);
    });

    test('should generate document compilation summary', async () => {
      const summary = await documentService.getSummary(orderId);
      
      expect(summary.totalDocuments).toBe(10);
      expect(summary.sowSections).toBe(3);
      expect(summary.appendixCount).toBe(6);
      expect(summary.isInternational).toBe(true);
    });
  });
});
```

#### 11.2.4 Document Compilation Decision Fork Matrix

| Scenario | SOW | Appendix A-F | Import Docs | Export Docs | CDC Docs | Total Docs |
|----------|-----|--------------|-------------|-------------|----------|------------|
| Domestic (ZA→ZA) | ✓ | ✓ | ✗ | ✗ | ✗ | 7 |
| International (ZA→GN) | ✓ | ✓ | ✓ | ✓ | ✓ | 17 |
| International (ZA→Other) | ✓ | ✓ | ✓ | ✓ | ✗ | 12 |
| Hazardous (ZA→GN) | ✓ | ✓ | ✓ | ✓ | ✓ | 18 |

#### 11.2.5 Messaging System Tests

The messaging system (`deep-agents/deep_agents/messaging/`) provides observability for all agents. Tests must verify:

**MessagingMixin Subsystems:**

| Subsystem | Test Category | Description |
|-----------|---------------|-------------|
| **Mail** | Inter-agent communication | Messages sent/received between agents |
| **Checkpoint** | Workflow state persistence | Save/load workflow state for crash recovery |
| **Metrics** | Token usage & latency | Record and retrieve session metrics |
| **Health** | Heartbeat monitoring | Agent liveness tracking |
| **Identity** | Agent registration | Unique agent ID resolution |

**Test Suite: MessagingMixin**

```javascript
describe('MessagingMixin Tests', () => {
  describe('Inter-Agent Mail', () => {
    test('should send message to another agent', async () => {
      const msgId = await agent.messaging_send(
        to_agent: 'quality_assurance_agent',
        subject: 'Compliance violations found',
        body: '3 PPPA violations detected',
        type: 'alert',
        priority: 'high'
      );
      expect(msgId).toBeDefined();
    });

    test('should retrieve unread messages', async () => {
      const messages = await agent.messaging_get_unread();
      expect(messages).toBeInstanceOf(Array);
    });

    test('should escalate to HITL coordinator', async () => {
      await agent.messaging_escalate(
        subject: 'High-value order requires approval',
        body: 'Order exceeds automated threshold'
      );
      // Verify escalation was sent to HITL coordinator
    });
  });

  describe('Workflow Checkpoints', () => {
    test('should save checkpoint for crash recovery', async () => {
      await agent.messaging_checkpoint(
        workflow_id: 'wf-001',
        current_step: 'compliance_validation',
        completed_steps: ['template_analysis', 'requirement_extraction'],
        pending_steps: ['field_population', 'quality_assurance'],
        progress_summary: 'Compliance check in progress'
      );
      
      const checkpoint = await agent.messaging_load_checkpoint('wf-001');
      expect(checkpoint.current_step).toBe('compliance_validation');
    });

    test('should resume from checkpoint after crash', async () => {
      const checkpoint = await agent.messaging_load_checkpoint('wf-001');
      if (checkpoint) {
        // Resume from checkpoint.current_step
        expect(checkpoint.completed_steps).toContain('template_analysis');
      }
    });

    test('should clear checkpoint after successful completion', async () => {
      await agent.messaging_clear_checkpoint('wf-001');
      const checkpoint = await agent.messaging_load_checkpoint('wf-001');
      expect(checkpoint).toBeNull();
    });
  });

  describe('Metrics Recording', () => {
    test('should record token usage and latency', async () => {
      await agent.messaging_record_metrics(
        workflow_id: 'wf-001',
        discipline: 'procurement',
        input_tokens: 1500,
        output_tokens: 800,
        model_used: 'gpt-4o',
        success: true
      );
      
      // Verify metrics were stored
    });

    test('should calculate total tokens', async () => {
      // total_tokens = input_tokens + output_tokens
    });

    test('should record failure metrics', async () => {
      await agent.messaging_record_metrics(
        workflow_id: 'wf-002',
        discipline: 'procurement',
        success: false
      );
    });
  });

  describe('Health Monitoring', () => {
    test('should send heartbeat at step start', async () => {
      await agent.messaging_heartbeat(step: 'process_start');
      // Verify heartbeat was recorded with TTL
    });

    test('should detect stale agents', async () => {
      // Query for agents that missed heartbeats
    });
  });
});
```

**Mock Scenario: Messaging Flow**

```javascript
{
  id: 'scenario_messaging_full_flow',
  name: 'Full Messaging Flow',
  description: 'Tests complete messaging flow through workflow',
  mockData: {
    workflow_id: 'wf-test-001',
    agent_id: 'procurement_input_agent',
    organization_id: '01900-procurement'
  },
  expectedOutcomes: [
    'Heartbeat sent at workflow start',
    'Checkpoint saved after each major step',
    'Metrics recorded with token counts',
    'Mail sent to downstream agents',
    'Escalation sent if HITL required',
    'Checkpoint cleared on completion'
  ]
}
```

#### 11.2.6 Governance & EU Standards Tests

The governance module (`deep-agents/deep_agents/agents/shared/governance/`) ensures adherence to EU AI Act and other standards. Tests must verify:

**Governance Agents:**

| Agent | Purpose | Test Focus |
|-------|---------|------------|
| `eu_ai_act_agent` | EU AI Act compliance | Risk classification, prohibited practices |
| `security_agent` | Security validation | Vulnerability detection, access control |
| `privacy_agent` | Data privacy | GDPR compliance, data handling |
| `accountability_agent` | Audit trails | Decision logging, explainability |
| `policy_generator_agent` | Policy creation | Policy document generation |
| `incident_response_agent` | Incident handling | Response procedures, escalation |

**Test Suite: Governance Compliance**

```javascript
describe('Governance Compliance Tests', () => {
  describe('EU AI Act Compliance', () => {
    test('should classify AI system risk level', async () => {
      const classification = await euAiActAgent.classifyRisk({
        system_type: 'procurement_agent',
        decision_impact: 'high',
        human_oversight: true
      });
      
      expect(['minimal', 'limited', 'high', 'unacceptable']).toContain(classification.risk_level);
    });

    test('should detect prohibited practices', async () => {
      const result = await euAiActAgent.checkProhibitedPractices({
        use_case: 'credit_scoring',
        techniques: ['social_scoring']
      });
      
      expect(result.prohibited).toBe(true);
    });

    test('should require human oversight for high-risk systems', async () => {
      const result = await euAiActAgent.validateHumanOversight({
        risk_level: 'high',
        hitl_configured: true
      });
      
      expect(result.compliant).toBe(true);
    });

    test('should validate transparency requirements', async () => {
      const result = await euAiActAgent.checkTransparency({
        ai_generated_content: true,
        disclosure_provided: true
      });
      
      expect(result.compliant).toBe(true);
    });
  });

  describe('Security Agent', () => {
    test('should validate access controls', async () => {
      const result = await securityAgent.validateAccess({
        user_role: 'procurement_officer',
        resource: 'order_approval',
        action: 'approve'
      });
      
      expect(result.authorized).toBeDefined();
    });

    test('should detect vulnerabilities in agent output', async () => {
      const result = await securityAgent.scanOutput({
        content: generatedContent,
        check_xss: true,
        check_sql_injection: true
      });
      
      expect(result.vulnerabilities).toEqual([]);
    });
  });

  describe('Privacy Agent (GDPR)', () => {
    test('should validate data minimization', async () => {
      const result = await privacyAgent.checkDataMinimization({
        data_collected: ['name', 'email', 'phone'],
        purpose: 'order_processing'
      });
      
      expect(result.compliant).toBe(true);
    });

    test('should check consent requirements', async () => {
      const result = await privacyAgent.validateConsent({
        data_type: 'personal',
        consent_obtained: true,
        consent_timestamp: '2026-02-19T12:00:00Z'
      });
      
      expect(result.valid).toBe(true);
    });

    test('should validate data retention policy', async () => {
      const result = await privacyAgent.checkRetention({
        data_type: 'order_records',
        retention_days: 2555, // 7 years
        policy_max_days: 2555
      });
      
      expect(result.compliant).toBe(true);
    });
  });

  describe('Accountability Agent', () => {
    test('should log all AI decisions', async () => {
      await accountabilityAgent.logDecision({
        agent_id: 'procurement_input_agent',
        decision: 'order_approved',
        reasoning: 'All compliance checks passed',
        confidence: 0.95
      });
      
      const audit = await accountabilityAgent.getAuditTrail('procurement_input_agent');
      expect(audit.length).toBeGreaterThan(0);
    });

    test('should provide decision explainability', async () => {
      const explanation = await accountabilityAgent.explainDecision({
        decision_id: 'dec-001'
      });
      
      expect(explanation.reasoning).toBeDefined();
      expect(explanation.factors).toBeInstanceOf(Array);
    });
  });

  describe('@with_governance Decorator', () => {
    test('should apply governance to agent method', async () => {
      // Test that @with_governance decorator wraps method correctly
      const agent = new ProcurementInputAgent();
      const result = await agent.process(mockData);
      
      // Verify governance was applied
      expect(result.governance_applied).toBe(true);
      expect(result.jurisdiction).toBeDefined();
    });

    test('should enforce jurisdiction rules', async () => {
      // Test jurisdiction-specific rules (FI, ZA, SE, GN, SA)
      const jurisdictions = ['FI', 'ZA', 'SE', 'GN', 'SA'];
      
      for (const jurisdiction of jurisdictions) {
        const result = await agent.processWithJurisdiction(mockData, jurisdiction);
        expect(result.jurisdiction_rules_applied).toBe(true);
      }
    });

    test('should handle strict mode violations', async () => {
      const result = await agent.processWithStrictMode(mockData, true);
      
      if (result.violations.length > 0) {
        expect(result.blocked).toBe(true);
      }
    });
  });
});
```

**Mock Scenario: EU AI Act Compliance**

```javascript
{
  id: 'scenario_eu_ai_act_compliance',
  name: 'EU AI Act Compliance Check',
  description: 'Tests EU AI Act compliance for procurement agent',
  mockData: {
    system_type: 'ai_decision_support',
    decision_impact: 'financial',
    human_oversight: true,
    transparency_required: true,
    risk_factors: ['automated_decision', 'financial_impact']
  },
  expectedOutcomes: [
    'Risk level classified as "high"',
    'Human oversight requirement identified',
    'Transparency disclosure generated',
    'Audit trail entry created',
    'Compliance certificate issued'
  ],
  governanceChecks: [
    'EU AI Act Article 6 - Classification rules',
    'EU AI Act Article 14 - Human oversight',
    'EU AI Act Article 13 - Transparency',
    'EU AI Act Article 15 - Accuracy and robustness'
  ]
}
```

**Mock Scenario: GDPR Data Handling**

```javascript
{
  id: 'scenario_gdpr_compliance',
  name: 'GDPR Data Handling',
  description: 'Tests GDPR compliance for personal data processing',
  mockData: {
    data_subjects: ['supplier_contacts', 'delivery_recipients'],
    data_types: ['name', 'email', 'phone', 'address'],
    purpose: 'procurement_order_processing',
    legal_basis: 'contract_performance',
    retention_period_days: 2555
  },
  expectedOutcomes: [
    'Legal basis validated',
    'Data minimization check passed',
    'Retention policy compliant',
    'Consent records verified',
    'Data subject rights documented'
  ]
}
```

#### 11.2.7 Workflow Knowledge Accumulation Tests

Tests for knowledge accumulation across workflow execution:

```javascript
describe('Workflow Knowledge Accumulation', () => {
  test('should accumulate context across workflow steps', async () => {
    const workflow = new ProcurementWorkflow();
    
    // Step 1: Order Creation
    await workflow.executeStep('order_creation', orderData);
    expect(workflow.accumulatedKnowledge.order_context).toBeDefined();
    
    // Step 2: Input Agent
    await workflow.executeStep('input_agent', {});
    expect(workflow.accumulatedKnowledge.extracted_requirements).toBeDefined();
    
    // Step 3: 6-Agent Pipeline
    await workflow.executeStep('six_agent_pipeline', {});
    expect(workflow.accumulatedKnowledge.compliance_results).toBeDefined();
    
    // Step 4: Handoff
    await workflow.executeStep('handoff', {});
    expect(workflow.accumulatedKnowledge.handoff_events).toBeDefined();
  });

  test('should persist knowledge for audit', async () => {
    const knowledge = await workflow.getAccumulatedKnowledge();
    
    expect(knowledge.workflow_id).toBeDefined();
    expect(knowledge.steps_completed).toBeInstanceOf(Array);
    expect(knowledge.decisions_made).toBeInstanceOf(Array);
    expect(knowledge.timestamp).toBeDefined();
  });

  test('should enable knowledge transfer between agents', async () => {
    // Agent A accumulates knowledge
    const agentA = new TemplateAnalysisAgent();
    await agentA.process(mockData);
    const knowledge = agentA.getKnowledge();
    
    // Agent B receives knowledge
    const agentB = new RequirementExtractionAgent();
    await agentB.processWithKnowledge(mockData, knowledge);
    
    expect(agentB.context.template_analysis).toBeDefined();
  });
});
```

#### 11.2.8 Knowledge System Tests

The deep-agents architecture includes several **static knowledge systems** that provide domain expertise, patterns, and specialist knowledge to agents. These are different from runtime workflow state accumulation.

**Knowledge Systems Architecture:**

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                     KNOWLEDGE SYSTEMS (Static)                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌────────────────────────┐     ┌────────────────────────┐
│  discipline-knowledge/ │     │   deep_agents/services/│
│  (Domain Expertise)    │     │   (Page Patterns)      │
│                        │     │                        │
│  • procurement.md      │     │  • 01900_procurement_  │
│  • logistics.md        │     │    patterns.py         │
│  • legal.md            │     │  • 01700_logistics_    │
│  • Domain terminology  │     │    patterns.py         │
│  • Industry standards  │     │  • FastAPI endpoints   │
│  • Best practices      │     │  • LangExtract config  │
└────────────────────────┘     └────────────────────────┘
           │                              │
           │                              │
           ▼                              ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│              discipline_it_specialists/ (47 Specialists)                     │
│                                                                              │
│  Each specialist knows:                                                     │
│  • Page structure for their discipline                                      │
│  • Supabase table schemas                                                   │
│  • Available agents registry                                                │
│  • Workspace actions catalog                                                │
│  • Known issues database                                                    │
│  • Enhancement opportunities                                                │
│  • Self-validation & health monitoring                                      │
└─────────────────────────────────────────────────────────────────────────────┘
           │
           │
           ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                     builders/ (Discipline Builder Agent)                     │
│                                                                              │
│  Meta-agent that creates new discipline-specific agents:                    │
│  • Analyzes natural language specifications                                 │
│  • Selects appropriate templates (deep_agent, swarm_agent, js_agent)        │
│  • Generates complete agent implementations                                 │
│  • Creates JSX integration code                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Test Suite: Discipline Knowledge**

```javascript
describe('Discipline Knowledge Tests', () => {
  describe('Knowledge File Structure', () => {
    test('should have knowledge file for each active discipline', async () => {
      const disciplines = ['01900-procurement', '01700-logistics', '01750-legal'];
      
      for (const discipline of disciplines) {
        const knowledgeFile = await knowledgeService.getKnowledgeFile(discipline);
        expect(knowledgeFile).toBeDefined();
        expect(knowledgeFile.content).toContain('## Domain Expertise');
      }
    });

    test('should include required knowledge sections', async () => {
      const knowledge = await knowledgeService.getKnowledge('01900-procurement');
      
      expect(knowledge.terminology).toBeDefined();
      expect(knowledge.industry_standards).toBeDefined();
      expect(knowledge.best_practices).toBeDefined();
      expect(knowledge.common_workflows).toBeDefined();
      expect(knowledge.key_concepts).toBeDefined();
    });

    test('should validate knowledge content format', async () => {
      const knowledge = await knowledgeService.getKnowledge('01900-procurement');
      
      // Should be valid markdown
      expect(knowledge.format).toBe('markdown');
      
      // Should have proper heading structure
      expect(knowledge.headings).toContain('Domain Expertise');
      expect(knowledge.headings).toContain('Industry Standards');
    });
  });

  describe('Knowledge Loading', () => {
    test('should load knowledge on demand', async () => {
      const knowledge = await knowledgeService.loadDisciplineKnowledge('01900-procurement');
      expect(knowledge).toBeDefined();
      expect(knowledge.discipline_code).toBe('01900');
    });

    test('should cache knowledge for performance', async () => {
      // First load
      const start1 = Date.now();
      await knowledgeService.loadDisciplineKnowledge('01900-procurement');
      const time1 = Date.now() - start1;
      
      // Second load (should be cached)
      const start2 = Date.now();
      await knowledgeService.loadDisciplineKnowledge('01900-procurement');
      const time2 = Date.now() - start2;
      
      expect(time2).toBeLessThan(time1);
    });
  });
});
```

**Test Suite: Discipline Services (Page Patterns)**

```javascript
describe('Discipline Services Tests', () => {
  describe('Pattern File Structure', () => {
    test('should have pattern file for each discipline', async () => {
      const patternFiles = await servicesService.listPatternFiles();
      
      expect(patternFiles).toContain('01900_procurement_patterns.py');
      expect(patternFiles).toContain('01700_logistics_patterns.py');
      expect(patternFiles).toContain('02400_safety_patterns.py');
    });

    test('should export required pattern classes', async () => {
      const patterns = await import('../../../deep-agents/deep_agents/services/01900_procurement_patterns.py');
      
      expect(patterns.ProcurementPatterns).toBeDefined();
      expect(patterns.PAGE_STRUCTURE).toBeDefined();
      expect(patterns.AVAILABLE_AGENTS).toBeDefined();
    });
  });

  describe('FastAPI Service Integration', () => {
    test('should initialize FastAPI service for discipline', async () => {
      const service = await servicesService.getFastAPIService('01900-procurement');
      
      expect(service).toBeDefined();
      expect(service.endpoints).toContain('/api/procurement/process');
    });

    test('should handle LangExtract configuration', async () => {
      const config = await servicesService.getLangExtractConfig('01900-procurement');
      
      expect(config.model).toBeDefined();
      expect(config.fallback_enabled).toBe(true);
    });
  });

  describe('Pattern Validation', () => {
    test('should validate page structure patterns', async () => {
      const patterns = await servicesService.getPatterns('01900-procurement');
      
      patterns.page_structure.forEach(page => {
        expect(page).toHaveProperty('route');
        expect(page).toHaveProperty('components');
        expect(page).toHaveProperty('modals');
      });
    });

    test('should validate agent registry patterns', async () => {
      const patterns = await servicesService.getPatterns('01900-procurement');
      
      patterns.available_agents.forEach(agent => {
        expect(agent).toHaveProperty('agent_id');
        expect(agent).toHaveProperty('capabilities');
        expect(agent).toHaveProperty('type');
      });
    });
  });
});
```

**Test Suite: Discipline IT Specialists**

```javascript
describe('Discipline IT Specialists Tests', () => {
  describe('Specialist Initialization', () => {
    test('should initialize all 47 discipline specialists', async () => {
      const specialists = await specialistService.listSpecialists();
      
      expect(specialists.length).toBe(47);
    });

    test('should load specialist knowledge areas', async () => {
      const specialist = new ProcurementITSpecialist();
      await specialist.initialize();
      
      expect(specialist.knowledge_areas).toContain('page_structure');
      expect(specialist.knowledge_areas).toContain('supabase_tables');
      expect(specialist.knowledge_areas).toContain('available_agents');
      expect(specialist.knowledge_areas).toContain('workspace_actions');
      expect(specialist.knowledge_areas).toContain('known_issues');
      expect(specialist.knowledge_areas).toContain('enhancement_opportunities');
    });
  });

  describe('Query Processing', () => {
    test('should answer page_structure queries', async () => {
      const specialist = new ProcurementITSpecialist();
      await specialist.initialize();
      
      const result = await specialist.process_task({ query_type: 'page_structure' });
      
      expect(result.page_route).toBe('/01900-procurement');
      expect(result.components).toBeDefined();
      expect(result.modals).toBeDefined();
    });

    test('should answer supabase_tables queries', async () => {
      const specialist = new ProcurementITSpecialist();
      await specialist.initialize();
      
      const result = await specialist.process_task({ query_type: 'supabase_tables' });
      
      expect(result.tables).toContain('procurement_orders');
      expect(result.tables).toContain('procurement_sow');
    });

    test('should answer available_agents queries', async () => {
      const specialist = new ProcurementITSpecialist();
      await specialist.initialize();
      
      const result = await specialist.process_task({ query_type: 'available_agents' });
      
      expect(result.agents).toContainEqual(
        expect.objectContaining({ agent_id: 'procurement_input_agent' })
      );
    });

    test('should answer full_knowledge queries', async () => {
      const specialist = new ProcurementITSpecialist();
      await specialist.initialize();
      
      const result = await specialist.process_task({ query_type: 'full_knowledge' });
      
      expect(result.page_structure).toBeDefined();
      expect(result.supabase_tables).toBeDefined();
      expect(result.available_agents).toBeDefined();
      expect(result.workspace_actions).toBeDefined();
      expect(result.known_issues).toBeDefined();
      expect(result.enhancement_opportunities).toBeDefined();
    });
  });

  describe('Self-Validation & Health Monitoring', () => {
    test('should validate UI anomalies', async () => {
      const specialist = new ProcurementITSpecialist();
      await specialist.initialize();
      
      const anomalies = specialist.validate_ui_anomalies();
      
      expect(anomalies).toHaveProperty('intentional_exclusions');
      expect(anomalies).toHaveProperty('potential_errors');
      expect(anomalies).toHaveProperty('missing_content');
      expect(anomalies).toHaveProperty('health_score');
    });

    test('should calculate UI health score', async () => {
      const specialist = new ProcurementITSpecialist();
      await specialist.initialize();
      
      const healthScore = specialist._calculate_ui_health_score();
      
      expect(healthScore.overall).toBeGreaterThanOrEqual(0);
      expect(healthScore.overall).toBeLessThanOrEqual(100);
      expect(healthScore.components.ui_config).toBeDefined();
      expect(healthScore.components.modal_mappings).toBeDefined();
    });

    test('should generate health report', async () => {
      const specialist = new ProcurementITSpecialist();
      await specialist.initialize();
      
      const report = specialist.get_ui_health_report();
      
      expect(report).toContain('Health Score');
      expect(report).toContain('Critical Issues');
      expect(report).toContain('Intentional Exclusions');
    });

    test('should classify anomalies correctly', async () => {
      const specialist = new ProcurementITSpecialist();
      await specialist.initialize();
      
      const anomalies = specialist.validate_ui_anomalies();
      
      // Intentional exclusions should have reasons
      anomalies.intentional_exclusions.forEach(exclusion => {
        expect(exclusion).toHaveProperty('type');
        expect(exclusion).toHaveProperty('reason');
      });
      
      // Potential errors should have severity
      anomalies.potential_errors.forEach(error => {
        expect(error).toHaveProperty('type');
        expect(error).toHaveProperty('severity');
        expect(['low', 'medium', 'critical']).toContain(error.severity);
      });
    });

    test('should export validation data', async () => {
      const specialist = new ProcurementITSpecialist();
      await specialist.initialize();
      
      const exportData = specialist.export_ui_validation_data();
      
      expect(exportData.discipline_code).toBe('01900');
      expect(exportData.ui_config).toBeDefined();
      expect(exportData.page_structure).toBeDefined();
      expect(exportData.anomaly_validation).toBeDefined();
    });
  });

  describe('Issue Reporting', () => {
    test('should report known issues', async () => {
      const specialist = new ProcurementITSpecialist();
      await specialist.initialize();
      
      const result = await specialist.process_task({ query_type: 'known_issues' });
      
      expect(result.issues).toBeInstanceOf(Array);
      result.issues.forEach(issue => {
        expect(issue).toHaveProperty('issue_id');
        expect(issue).toHaveProperty('description');
        expect(issue).toHaveProperty('severity');
      });
    });

    test('should suggest enhancements', async () => {
      const specialist = new ProcurementITSpecialist();
      await specialist.initialize();
      
      const result = await specialist.process_task({ query_type: 'enhancements' });
      
      expect(result.enhancements).toBeInstanceOf(Array);
      result.enhancements.forEach(enhancement => {
        expect(enhancement).toHaveProperty('enhancement_id');
        expect(enhancement).toHaveProperty('description');
        expect(enhancement).toHaveProperty('priority');
      });
    });
  });
});
```

**Test Suite: Discipline Builder Agent**

```javascript
describe('Discipline Builder Agent Tests', () => {
  describe('Requirement Analysis', () => {
    test('should analyze specification for complexity', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'information_technology' });
      
      const analysis = builder.analyze_requirements('Create a data validation agent');
      
      expect(analysis.complexity).toBeDefined();
      expect(['low', 'medium', 'high']).toContain(analysis.complexity);
    });

    test('should select correct agent type based on keywords', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'information_technology' });
      
      // High complexity keywords → deep_agent
      const analysis1 = builder.analyze_requirements('Create an ML prediction agent');
      expect(analysis1.agent_type).toBe('deep_agent');
      
      // Medium complexity keywords → swarm_agent
      const analysis2 = builder.analyze_requirements('Create a multi-agent coordination workflow');
      expect(analysis2.agent_type).toBe('swarm_agent');
      
      // Low complexity → js_agent
      const analysis3 = builder.analyze_requirements('Create a simple button component');
      expect(analysis3.agent_type).toBe('js_agent');
    });

    test('should extract capabilities from specification', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'information_technology' });
      
      const analysis = builder.analyze_requirements('Create a monitoring and alerting agent');
      
      expect(analysis.capabilities).toContain('monitoring');
      expect(analysis.capabilities).toContain('notification');
    });

    test('should estimate resource requirements', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'information_technology' });
      
      const analysis = builder.analyze_requirements('Create a complex AI analysis agent');
      
      expect(analysis.resources.cpu).toBeDefined();
      expect(analysis.resources.memory).toBeDefined();
      expect(analysis.resources.gpu).toBeDefined();
    });
  });

  describe('Agent Configuration Generation', () => {
    test('should generate valid agent configuration', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'information_technology' });
      
      const config = builder.build_agent({
        specification: 'Create a data validation agent',
        agent_type: 'js_agent'
      });
      
      expect(config.id).toBeDefined();
      expect(config.name).toBeDefined();
      expect(config.type).toBe('js_agent');
      expect(config.capabilities).toBeInstanceOf(Array);
      expect(config.language).toBe('javascript');
    });

    test('should generate Python config for deep_agent', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'information_technology' });
      
      const config = builder.build_agent({
        specification: 'Create an ML prediction agent',
        agent_type: 'deep_agent'
      });
      
      expect(config.language).toBe('python');
      expect(config.framework).toBe('fastapi');
      expect(config.training_required).toBe(true);
    });

    test('should estimate training time for deep agents', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'information_technology' });
      
      const config = builder.build_agent({
        specification: 'Create an ML prediction agent',
        agent_type: 'deep_agent'
      });
      
      expect(config.estimated_training_time).toBeGreaterThan(0);
    });
  });

  describe('JSX Code Generation', () => {
    test('should generate React component for js_agent', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'information_technology' });
      
      const config = builder.build_agent({
        specification: 'Create a data validation agent',
        agent_type: 'js_agent'
      });
      
      expect(config.generatedJsx).toBeDefined();
      expect(config.generatedJsx).toContain('import React');
      expect(config.generatedJsx).toContain('useState');
    });

    test('should include API call handlers in JSX', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'information_technology' });
      
      const config = builder.build_agent({
        specification: 'Create a data validation agent',
        agent_type: 'js_agent'
      });
      
      expect(config.generatedJsx).toContain("fetch('/api/agents/");
      expect(config.generatedJsx).toContain('execute');
    });

    test('should include error handling in JSX', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'information_technology' });
      
      const config = builder.build_agent({
        specification: 'Create a data validation agent',
        agent_type: 'js_agent'
      });
      
      expect(config.generatedJsx).toContain('try');
      expect(config.generatedJsx).toContain('catch');
    });

    test('should include modal integration in JSX', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'information_technology' });
      
      const config = builder.build_agent({
        specification: 'Create a data validation agent',
        agent_type: 'js_agent'
      });
      
      expect(config.generatedJsx).toContain('Modal');
      expect(config.generatedJsx).toContain('showModal');
    });
  });

  describe('Template System', () => {
    test('should use correct template for agent type', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'information_technology' });
      
      // Deep agent template
      const deepConfig = builder.build_agent({
        specification: 'ML agent',
        agent_type: 'deep_agent'
      });
      expect(deepConfig.template_used).toBe('deep_agent_template.py');
      
      // Swarm agent template
      const swarmConfig = builder.build_agent({
        specification: 'Coordination agent',
        agent_type: 'swarm_agent'
      });
      expect(swarmConfig.template_used).toBe('swarm_agent_template.js');
      
      // JS agent template
      const jsConfig = builder.build_agent({
        specification: 'UI agent',
        agent_type: 'js_agent'
      });
      expect(jsConfig.template_used).toBe('js_agent_template.js');
    });

    test('should substitute variables in template', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'information_technology' });
      
      const config = builder.build_agent({
        specification: 'Create a data validation agent',
        agent_type: 'js_agent',
        agent_name: 'DataValidationAgent'
      });
      
      expect(config.generatedJsx).toContain('DataValidationAgent');
    });
  });

  describe('Output & Persistence', () => {
    test('should save generated agent to correct directory', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'information_technology' });
      
      const config = builder.build_agent({
        specification: 'Create a data validation agent',
        agent_type: 'js_agent'
      });
      
      expect(config.output_path).toContain('generated-agents');
      expect(config.output_path).toContain('information_technology');
    });

    test('should generate unique agent ID', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'information_technology' });
      
      const config1 = builder.build_agent({
        specification: 'Create agent 1',
        agent_type: 'js_agent'
      });
      
      const config2 = builder.build_agent({
        specification: 'Create agent 2',
        agent_type: 'js_agent'
      });
      
      expect(config1.id).not.toBe(config2.id);
    });
  });

  describe('Error Handling', () => {
    test('should handle missing discipline gracefully', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'invalid_discipline' });
      
      const result = builder.build_agent({
        specification: 'Create an agent',
        agent_type: 'js_agent'
      });
      
      expect(result.error).toBeDefined();
    });

    test('should fallback to js_agent for unknown specifications', async () => {
      const builder = new DisciplineBuilderAgent({ discipline: 'information_technology' });
      
      const analysis = builder.analyze_requirements('');
      
      expect(analysis.agent_type).toBe('js_agent');
    });
  });
});
```

**Mock Scenario: Knowledge System Integration**

```javascript
{
  id: 'scenario_knowledge_system_integration',
  name: 'Knowledge System Integration',
  description: 'Tests integration between knowledge systems and agents',
  mockData: {
    discipline_code: '01900',
    discipline_name: 'procurement'
  },
  expectedOutcomes: [
    'Discipline knowledge loaded from discipline-knowledge/',
    'Page patterns loaded from services/',
    'IT specialist initialized with all knowledge areas',
    'Builder agent can create new agents using templates',
    'Knowledge transfer between systems verified'
  ],
  knowledgeFlow: {
    step1: 'Load domain expertise from discipline-knowledge/procurement.md',
    step2: 'Load page patterns from services/01900_procurement_patterns.py',
    step3: 'Initialize ProcurementITSpecialist with knowledge',
    step4: 'Specialist provides knowledge to agents via queries',
    step5: 'Builder agent uses templates to create new agents'
  }
}
```

#### 11.2.9 Standards Compliance Tests

Tests for validating compliance with ConstructAI coding, naming, and workflow optimization standards.

**Test Suite: Agent Coding Standards (0000_AGENT_CODING_STANDARDS.md)**

```javascript
describe('Agent Coding Standards Tests', () => {
  describe('ES6+ Syntax Compliance', () => {
    test('should use ES6 imports instead of require', async () => {
      const files = await codeAnalyzer.getJavaScriptFiles('deep-agents/');
      
      files.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Should not use CommonJS require
        if (!file.includes('node_modules')) {
          expect(content).not.toMatch(/require\s*\(\s*['"]/);
        }
      });
    });

    test('should use const/let instead of var', async () => {
      const files = await codeAnalyzer.getJavaScriptFiles('client/src/');
      
      files.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Should not use var declarations
        const varDeclarations = content.match(/\bvar\s+\w+/g);
        expect(varDeclarations).toBeNull();
      });
    });

    test('should use arrow functions for callbacks', async () => {
      const files = await codeAnalyzer.getJavaScriptFiles('server/src/');
      
      files.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Check for arrow function usage
        const hasArrowFunctions = content.includes('=>');
        const hasOldStyleCallbacks = content.match(/function\s*\([^)]*\)\s*\{/);
        
        // Modern code should prefer arrow functions
        if (hasOldStyleCallbacks && !content.includes('class ')) {
          // Allow for class methods and named functions
        }
      });
    });

    test('should use async/await instead of .then() chains', async () => {
      const files = await codeAnalyzer.getAgentFiles();
      
      files.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Count .then() usage vs async/await
        const thenCount = (content.match(/\.then\s*\(/g) || []).length;
        const asyncCount = (content.match(/async\s+\w+/g) || []).length;
        const awaitCount = (content.match(/await\s+/g) || []).length;
        
        // Prefer async/await over .then() chains
        if (thenCount > 3) {
          console.warn(`File ${file} uses many .then() chains. Consider async/await.`);
        }
      });
    });
  });

  describe('Naming Conventions', () => {
    test('should use camelCase for variables and functions', async () => {
      const files = await codeAnalyzer.getJavaScriptFiles('client/src/');
      
      files.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Extract variable declarations
        const constDeclarations = content.match(/const\s+(\w+)/g) || [];
        const letDeclarations = content.match(/let\s+(\w+)/g) || [];
        
        [...constDeclarations, ...letDeclarations].forEach(decl => {
          const name = decl.replace(/const\s+|let\s+/, '');
          
          // Should be camelCase or UPPER_SNAKE_CASE for constants
          const isCamelCase = /^[a-z][a-zA-Z0-9]*$/.test(name);
          const isUpperSnake = /^[A-Z][A-Z0-9_]*$/.test(name);
          
          expect(isCamelCase || isUpperSnake).toBe(true);
        });
      });
    });

    test('should use PascalCase for React components', async () => {
      const componentFiles = await codeAnalyzer.getReactComponents();
      
      componentFiles.forEach(file => {
        const fileName = path.basename(file, '.js');
        
        // React component files should be PascalCase
        const isPascalCase = /^[A-Z][a-zA-Z0-9]*$/.test(fileName);
        expect(isPascalCase).toBe(true);
      });
    });

    test('should use descriptive variable names', async () => {
      const files = await codeAnalyzer.getJavaScriptFiles('deep-agents/');
      
      files.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Check for single-letter variables (except in loops)
        const singleLetterVars = content.match(/\b(const|let|var)\s+[a-z]\b/g) || [];
        
        // Allow i, j, k in loops but not as general variables
        singleLetterVars.forEach(varDecl => {
          if (!['i', 'j', 'k', 'x', 'y', 'z'].includes(varDecl.split(' ')[1])) {
            console.warn(`Single-letter variable in ${file}: ${varDecl}`);
          }
        });
      });
    });
  });

  describe('File Structure Organization', () => {
    test('should place server code in /server directory', async () => {
      const serverFiles = await codeAnalyzer.getFilesByPattern('server/**/*.js');
      
      serverFiles.forEach(file => {
        expect(file).toMatch(/^server\//);
      });
    });

    test('should place client code in /client directory', async () => {
      const clientFiles = await codeAnalyzer.getFilesByPattern('client/**/*.js');
      
      clientFiles.forEach(file => {
        expect(file).toMatch(/^client\//);
      });
    });

    test('should place documentation in /docs directory', async () => {
      const docFiles = await codeAnalyzer.getFilesByPattern('**/*.md');
      
      docFiles.forEach(file => {
        // Allow README.md in root and docs in docs/
        if (!file.startsWith('docs/') && !file.endsWith('README.md')) {
          console.warn(`Documentation file outside docs/: ${file}`);
        }
      });
    });

    test('should organize routes by feature', async () => {
      const routeFiles = await codeAnalyzer.getFilesByPattern('server/src/routes/*.js');
      
      routeFiles.forEach(file => {
        const fileName = path.basename(file);
        
        // Routes should be organized by feature
        expect(fileName).toMatch(/^[a-z]+Routes\.js$/);
      });
    });
  });

  describe('Error Handling', () => {
    test('should use try/catch for async operations', async () => {
      const agentFiles = await codeAnalyzer.getAgentFiles();
      
      agentFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Check for async functions
        const asyncFunctions = content.match(/async\s+\w+\s*\(/g) || [];
        
        // Each async function should have try/catch
        const tryCatchCount = (content.match(/try\s*\{/g) || []).length;
        
        if (asyncFunctions.length > 0 && tryCatchCount === 0) {
          console.warn(`File ${file} has async functions but no try/catch`);
        }
      });
    });

    test('should return appropriate HTTP status codes', async () => {
      const routeFiles = await codeAnalyzer.getFilesByPattern('server/src/routes/*.js');
      
      routeFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Check for status code usage
        const statusCodes = content.match(/\.status\(\d+\)/g) || [];
        
        // Should use appropriate status codes
        statusCodes.forEach(status => {
          const code = parseInt(status.match(/\d+/)[0]);
          expect(code).toBeGreaterThanOrEqual(200);
          expect(code).toBeLessThan(600);
        });
      });
    });

    test('should log errors with context', async () => {
      const files = await codeAnalyzer.getJavaScriptFiles('server/src/');
      
      files.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Check for error logging
        const catchBlocks = content.match(/catch\s*\([^)]*\)\s*\{[^}]*\}/g) || [];
        
        catchBlocks.forEach(catchBlock => {
          // Should log the error
          const hasLogging = catchBlock.includes('console.') || 
                            catchBlock.includes('logger.') ||
                            catchBlock.includes('logError');
          
          if (!hasLogging && catchBlock.length > 50) {
            console.warn(`Catch block without logging in ${file}`);
          }
        });
      });
    });
  });

  describe('Database Security', () => {
    test('should use parameterized queries', async () => {
      const dbFiles = await codeAnalyzer.getFilesByPattern('server/src/**/*.js');
      
      dbFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Check for SQL injection vulnerabilities
        const stringConcatInQuery = content.match(/\$\{[^}]+\}.*SELECT|SELECT.*\$\{[^}]+\}/gi);
        
        expect(stringConcatInQuery).toBeNull();
      });
    });

    test('should use snake_case for database columns', async () => {
      const migrationFiles = await codeAnalyzer.getFilesByPattern('server/sql/*.sql');
      
      migrationFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Extract column names from CREATE TABLE statements
        const columnDefs = content.match(/\w+\s+(?:INTEGER|TEXT|VARCHAR|BOOLEAN|TIMESTAMP)/gi) || [];
        
        columnDefs.forEach(colDef => {
          const columnName = colDef.split(/\s+/)[0];
          
          // Should be snake_case
          const isSnakeCase = /^[a-z][a-z0-9_]*$/.test(columnName);
          expect(isSnakeCase).toBe(true);
        });
      });
    });
  });

  describe('Prompt Key Naming Convention', () => {
    test('should follow hierarchical naming pattern', async () => {
      const promptKeys = await promptService.getAllPromptKeys();
      
      promptKeys.forEach(key => {
        // Pattern: {category}_{subcategory}_{specific}_{variant}
        const parts = key.split('_');
        
        expect(parts.length).toBeGreaterThanOrEqual(3);
        
        // All parts should be lowercase
        expect(key).toBe(key.toLowerCase());
        
        // No special characters
        expect(key).toMatch(/^[a-z0-9_]+$/);
      });
    });

    test('should use valid category prefixes', async () => {
      const validCategories = ['agent', 'specialist', 'function', 'system'];
      const promptKeys = await promptService.getAllPromptKeys();
      
      promptKeys.forEach(key => {
        const category = key.split('_')[0];
        
        expect(validCategories).toContain(category);
      });
    });

    test('should validate correspondence agent keys', async () => {
      const correspondenceKeys = await promptService.getKeysByPrefix('agent_correspondence_');
      
      correspondenceKeys.forEach(key => {
        // Pattern: agent_correspondence_{number}_{purpose}
        const parts = key.split('_');
        
        expect(parts[0]).toBe('agent');
        expect(parts[1]).toBe('correspondence');
        expect(parts[2]).toMatch(/^\d{2}$/); // Two-digit number
        expect(parts[3]).toBeDefined(); // Purpose
      });
    });
  });

  describe('Governance Integration', () => {
    test('should use @with_governance decorator', async () => {
      const agentFiles = await codeAnalyzer.getAgentFiles();
      
      agentFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Check for governance integration
        if (content.includes('class ') && content.includes('Agent')) {
          const hasGovernance = content.includes('@with_governance') ||
                               content.includes('GovernedAgentMixin') ||
                               content.includes('MessagingMixin');
          
          if (!hasGovernance) {
            console.warn(`Agent ${file} missing governance integration`);
          }
        }
      });
    });

    test('should specify jurisdiction', async () => {
      const agentFiles = await codeAnalyzer.getAgentFiles();
      
      agentFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        if (content.includes('@with_governance')) {
          // Should specify jurisdiction
          const hasJurisdiction = content.includes("jurisdiction='") ||
                                 content.includes('jurisdiction="') ||
                                 content.includes('primary_controller');
          
          expect(hasJurisdiction).toBe(true);
        }
      });
    });

    test('should handle governance_blocked results', async () => {
      const agentFiles = await codeAnalyzer.getAgentFiles();
      
      agentFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        if (content.includes('@with_governance')) {
          // Should handle blocked state
          const handlesBlocked = content.includes('governance_blocked') ||
                                content.includes('blocked');
          
          expect(handlesBlocked).toBe(true);
        }
      });
    });
  });

  describe('Debug Logging Requirements', () => {
    test('should log prompt key retrieval', async () => {
      const agentFiles = await codeAnalyzer.getAgentFiles();
      
      agentFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        if (content.includes('getPromptByKey')) {
          // Should log the key being retrieved
          const hasKeyLogging = content.includes('Prompt Key:') ||
                               content.includes('promptKey');
          
          expect(hasKeyLogging).toBe(true);
        }
      });
    });

    test('should log prompt content preview', async () => {
      const agentFiles = await codeAnalyzer.getAgentFiles();
      
      agentFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        if (content.includes('getPromptByKey')) {
          // Should log content preview
          const hasContentLogging = content.includes('substring(0, 200)') ||
                                   content.includes('first 200 chars') ||
                                   content.includes('Prompt Content');
          
          expect(hasContentLogging).toBe(true);
        }
      });
    });

    test('should indicate fallback mode', async () => {
      const agentFiles = await codeAnalyzer.getAgentFiles();
      
      agentFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        if (content.includes('getPromptByKey')) {
          // Should indicate when using fallback
          const hasFallbackLogging = content.includes('fallback') ||
                                     content.includes('Fallback');
          
          expect(hasFallbackLogging).toBe(true);
        }
      });
    });
  });
});
```

**Test Suite: File Naming Standards (0002_FILE_NAMING_STANDARDS.md)**

```javascript
describe('File Naming Standards Tests', () => {
  describe('General Naming Principles', () => {
    test('should use lowercase for all filenames', async () => {
      const allFiles = await fileAnalyzer.getAllFiles();
      
      allFiles.forEach(file => {
        const fileName = path.basename(file);
        
        // Should be lowercase (except for README, LICENSE, etc.)
        const exceptions = ['README', 'LICENSE', 'CHANGELOG', 'Dockerfile'];
        const isException = exceptions.some(exc => fileName.startsWith(exc));
        
        if (!isException) {
          expect(fileName).toBe(fileName.toLowerCase());
        }
      });
    });

    test('should use underscores instead of spaces', async () => {
      const allFiles = await fileAnalyzer.getAllFiles();
      
      allFiles.forEach(file => {
        const fileName = path.basename(file);
        
        expect(fileName).not.toContain(' ');
      });
    });

    test('should use correct file extensions', async () => {
      const validExtensions = {
        docs: ['.md'],
        javascript: ['.js', '.jsx', '.mjs'],
        typescript: ['.ts', '.tsx'],
        json: ['.json'],
        sql: ['.sql'],
        images: ['.png', '.jpg', '.jpeg', '.svg', '.gif'],
        config: ['.yaml', '.yml', '.toml', '.ini']
      };
      
      const allFiles = await fileAnalyzer.getAllFiles();
      
      allFiles.forEach(file => {
        const ext = path.extname(file);
        
        // Check if extension is recognized
        const allValidExts = Object.values(validExtensions).flat();
        
        if (ext && !allValidExts.includes(ext)) {
          console.warn(`Unrecognized extension: ${ext} in ${file}`);
        }
      });
    });
  });

  describe('Documentation File Naming', () => {
    test('should use numeric prefixes for ordering', async () => {
      const docFiles = await fileAnalyzer.getFilesByPattern('docs/**/*.md');
      
      docFiles.forEach(file => {
        const fileName = path.basename(file);
        
        // Should have numeric prefix
        const hasNumericPrefix = /^\d{4}_/.test(fileName);
        
        if (!hasNumericPrefix && !fileName.startsWith('README')) {
          console.warn(`Missing numeric prefix: ${file}`);
        }
      });
    });

    test('should follow prefix ranges correctly', async () => {
      const standardsFiles = await fileAnalyzer.getFilesByPattern('docs/standards/*.md');
      
      standardsFiles.forEach(file => {
        const fileName = path.basename(file);
        const prefix = parseInt(fileName.split('_')[0]);
        
        // Standards should use 0000-0999 range
        expect(prefix).toBeGreaterThanOrEqual(0);
        expect(prefix).toBeLessThan(1000);
      });
    });

    test('should use correct procedure naming pattern', async () => {
      const procedureFiles = await fileAnalyzer.getFilesByPattern('docs/procedures/**/*.md');
      
      procedureFiles.forEach(file => {
        const fileName = path.basename(file);
        
        // Should match pattern: {prefix}_{descriptive_name}.md
        expect(fileName).toMatch(/^\d{4}_[a-z0-9_]+\.md$/);
      });
    });

    test('should use correct agent documentation naming', async () => {
      const agentDocFiles = await fileAnalyzer.getFilesByPattern('docs/pages-agents/*.md');
      
      agentDocFiles.forEach(file => {
        const fileName = path.basename(file);
        
        // Should match pattern: {page_id}_AGENT_{agent_name}_PROCEDURE.md
        if (fileName.includes('AGENT')) {
          expect(fileName).toMatch(/^\d{4}_\d{5}_AGENT_[A-Z0-9_]+_PROCEDURE\.md$/);
        }
      });
    });
  });

  describe('Source Code File Naming', () => {
    test('should use camelCase for JavaScript files', async () => {
      const jsFiles = await fileAnalyzer.getFilesByPattern('client/src/common/**/*.js');
      
      jsFiles.forEach(file => {
        const fileName = path.basename(file, '.js');
        
        // Should be camelCase
        const isCamelCase = /^[a-z][a-zA-Z0-9]*$/.test(fileName);
        
        expect(isCamelCase).toBe(true);
      });
    });

    test('should use PascalCase for React components', async () => {
      const componentFiles = await fileAnalyzer.getReactComponents();
      
      componentFiles.forEach(file => {
        const fileName = path.basename(file, '.js');
        
        // Should be PascalCase
        const isPascalCase = /^[A-Z][a-zA-Z0-9]*$/.test(fileName);
        
        expect(isPascalCase).toBe(true);
      });
    });

    test('should use camelCase for directories', async () => {
      const directories = await fileAnalyzer.getDirectories('client/src/');
      
      directories.forEach(dir => {
        const dirName = path.basename(dir);
        
        // Should be camelCase
        const isCamelCase = /^[a-z][a-zA-Z0-9]*$/.test(dirName);
        
        expect(isCamelCase).toBe(true);
      });
    });
  });

  describe('Database File Naming', () => {
    test('should use correct migration naming pattern', async () => {
      const migrationFiles = await fileAnalyzer.getFilesByPattern('server/sql/*.sql');
      
      migrationFiles.forEach(file => {
        const fileName = path.basename(file);
        
        // Should match pattern: {operation}_{table}_{description}.sql
        const validOperations = ['create', 'add', 'alter', 'drop', 'insert', 'update'];
        const operation = fileName.split('_')[0];
        
        expect(validOperations).toContain(operation);
      });
    });

    test('should use snake_case for SQL files', async () => {
      const sqlFiles = await fileAnalyzer.getFilesByPattern('**/*.sql');
      
      sqlFiles.forEach(file => {
        const fileName = path.basename(file, '.sql');
        
        // Should be snake_case
        const isSnakeCase = /^[a-z][a-z0-9_]*$/.test(fileName);
        
        expect(isSnakeCase).toBe(true);
      });
    });
  });

  describe('Configuration File Naming', () => {
    test('should use correct environment file naming', async () => {
      const envFiles = await fileAnalyzer.getFilesByPattern('.env*');
      
      envFiles.forEach(file => {
        const fileName = path.basename(file);
        
        // Should match pattern: .env or .env.{environment}
        const isValidEnv = fileName === '.env' ||
                          fileName.match(/^\.env\.\w+$/) ||
                          fileName === '.env.example';
        
        expect(isValidEnv).toBe(true);
      });
    });

    test('should use correct project configuration naming', async () => {
      const configFiles = await fileAnalyzer.getFilesByPattern('*.json');
      
      configFiles.forEach(file => {
        const fileName = path.basename(file);
        
        // Common config files
        const validConfigs = ['package.json', 'tsconfig.json', '.eslintrc.json'];
        
        if (!validConfigs.includes(fileName)) {
          // Should be lowercase with possible dots
          expect(fileName).toMatch(/^[a-z0-9_.]+\.json$/);
        }
      });
    });
  });

  describe('Numeric Prefix Validation', () => {
    test('should use correct prefix ranges', async () => {
      const prefixRanges = {
        'docs/standards/': [0, 999],
        'docs/procedures/': [0, 999],
        'docs/pages-agents/': [1000, 1999],
        'docs/workflows/': [2000, 2999],
        'docs/implementation/': [3000, 3999]
      };
      
      for (const [dir, [min, max]] of Object.entries(prefixRanges)) {
        const files = await fileAnalyzer.getFilesByPattern(`${dir}*.md`);
        
        files.forEach(file => {
          const fileName = path.basename(file);
          const prefix = parseInt(fileName.split('_')[0]);
          
          if (!isNaN(prefix)) {
            expect(prefix).toBeGreaterThanOrEqual(min);
            expect(prefix).toBeLessThanOrEqual(max);
          }
        });
      }
    });
  });
});
```

**Test Suite: Workflow Optimization Standards (0005_WORKFLOW_OPTIMIZATION_STANDARDS.md)**

```javascript
describe('Workflow Optimization Standards Tests', () => {
  describe('Performance Monitoring', () => {
    test('should track response times', async () => {
      const routeFiles = await fileAnalyzer.getFilesByPattern('server/src/routes/*.js');
      
      routeFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Should have performance tracking
        const hasPerfTracking = content.includes('trackResponseTime') ||
                               content.includes('performanceMonitor') ||
                               content.includes('duration');
        
        expect(hasPerfTracking).toBe(true);
      });
    });

    test('should implement memory usage tracking', async () => {
      const serviceFiles = await fileAnalyzer.getFilesByPattern('server/src/services/*.js');
      
      serviceFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Should track memory for long-running operations
        if (content.includes('process') || content.includes('workflow')) {
          const hasMemoryTracking = content.includes('memoryUsage') ||
                                   content.includes('trackMemory');
          
          // Memory tracking recommended for services
          if (!hasMemoryTracking) {
            console.info(`Consider adding memory tracking to ${file}`);
          }
        }
      });
    });

    test('should implement database query tracking', async () => {
      const dbFiles = await fileAnalyzer.getFilesByPattern('server/src/**/*.js');
      
      dbFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        if (content.includes('supabase') || content.includes('query')) {
          // Should track query performance
          const hasQueryTracking = content.includes('trackDatabaseQuery') ||
                                  content.includes('queryDuration') ||
                                  content.includes('duration');
          
          expect(hasQueryTracking).toBe(true);
        }
      });
    });
  });

  describe('Quality Metrics System', () => {
    test('should assess code quality', async () => {
      const qualityMetrics = await qualityService.getCodeQualityMetrics();
      
      qualityMetrics.forEach(metric => {
        // Should have quality score
        expect(metric.score).toBeGreaterThanOrEqual(0);
        expect(metric.score).toBeLessThanOrEqual(100);
        
        // Should flag issues
        if (metric.linesOfCode > 500) {
          expect(metric.flags).toContain('LONG_FILE');
        }
        
        if (metric.complexity > 20) {
          expect(metric.flags).toContain('HIGH_COMPLEXITY');
        }
      });
    });

    test('should track workflow performance', async () => {
      const workflowFiles = await fileAnalyzer.getFilesByPattern('deep-agents/**/*workflow*.py');
      
      workflowFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Should track workflow step completion
        const hasWorkflowTracking = content.includes('trackWorkflowPerformance') ||
                                   content.includes('workflow_step_completed') ||
                                   content.includes('step_duration');
        
        expect(hasWorkflowTracking).toBe(true);
      });
    });

    test('should track user experience metrics', async () => {
      const clientFiles = await fileAnalyzer.getFilesByPattern('client/src/pages/**/*.js');
      
      clientFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Should track UX for key actions
        if (content.includes('onClick') || content.includes('onSubmit')) {
          const hasUXTracking = content.includes('trackUserExperience') ||
                               content.includes('analytics') ||
                               content.includes('trackEvent');
          
          // UX tracking recommended for user interactions
          if (!hasUXTracking) {
            console.info(`Consider adding UX tracking to ${file}`);
          }
        }
      });
    });
  });

  describe('Structured Logging Implementation', () => {
    test('should use structured JSON logging', async () => {
      const serverFiles = await fileAnalyzer.getFilesByPattern('server/src/**/*.js');
      
      serverFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Should use structured logging
        const hasStructuredLogging = content.includes('JSON.stringify') ||
                                    content.includes('logger.info') ||
                                    content.includes('logger.error');
        
        expect(hasStructuredLogging).toBe(true);
      });
    });

    test('should include timestamp in logs', async () => {
      const logFiles = await fileAnalyzer.getFilesByPattern('server/src/services/*logger*.js');
      
      if (logFiles.length > 0) {
        logFiles.forEach(file => {
          const content = fs.readFileSync(file, 'utf8');
          
          // Should include timestamp
          expect(content).toContain('timestamp');
          expect(content).toContain('toISOString');
        });
      }
    });

    test('should include correlation IDs', async () => {
      const routeFiles = await fileAnalyzer.getFilesByPattern('server/src/routes/*.js');
      
      routeFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Should use correlation IDs for request tracing
        const hasCorrelation = content.includes('correlationId') ||
                              content.includes('requestId') ||
                              content.includes('traceId');
        
        expect(hasCorrelation).toBe(true);
      });
    });

    test('should include context in error logs', async () => {
      const files = await fileAnalyzer.getJavaScriptFiles('server/src/');
      
      files.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Find error logging
        const errorLogs = content.match(/logger\.error\([^)]+\)/g) || [];
        
        errorLogs.forEach(log => {
          // Should include context object
          expect(log).toContain('{');
        });
      });
    });
  });

  describe('Code Quality Assessment', () => {
    test('should flag functions exceeding 50 lines', async () => {
      const files = await fileAnalyzer.getJavaScriptFiles('deep-agents/');
      
      files.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Extract function bodies
        const functions = content.match(/(?:async\s+)?(?:function\s+\w+|const\s+\w+\s*=\s*(?:async\s+)?(?:\([^)]*\)|[^=])\s*=>)\s*\{[\s\S]*?\n\}/g) || [];
        
        functions.forEach(func => {
          const lines = func.split('\n').length;
          
          if (lines > 50) {
            console.warn(`Function exceeds 50 lines in ${file}: ${lines} lines`);
          }
        });
      });
    });

    test('should flag files exceeding 500 lines', async () => {
      const files = await fileAnalyzer.getJavaScriptFiles('server/src/');
      
      files.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        const lines = content.split('\n').length;
        
        if (lines > 500) {
          console.warn(`File exceeds 500 lines: ${file} (${lines} lines)`);
        }
      });
    });

    test('should measure cyclomatic complexity', async () => {
      const files = await fileAnalyzer.getJavaScriptFiles('deep-agents/');
      
      files.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Simple complexity estimation
        const ifCount = (content.match(/\bif\s*\(/g) || []).length;
        const elseCount = (content.match(/\belse\b/g) || []).length;
        const forCount = (content.match(/\bfor\s*\(/g) || []).length;
        const whileCount = (content.match(/\bwhile\s*\(/g) || []).length;
        const caseCount = (content.match(/\bcase\s+/g) || []).length;
        
        const complexity = 1 + ifCount + elseCount + forCount + whileCount + caseCount;
        
        if (complexity > 20) {
          console.warn(`High complexity (${complexity}) in ${file}`);
        }
      });
    });
  });

  describe('Document Usage Guide Compliance', () => {
    test('should have Document Usage Guide section', async () => {
      const docFiles = await fileAnalyzer.getFilesByPattern('docs/**/*.md');
      
      docFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Major documents should have usage guide
        if (content.includes('## 1. Purpose') || content.includes('## 1. Overview')) {
          const hasUsageGuide = content.includes('## Document Usage Guide') ||
                               content.includes('## Document Usage');
          
          if (!hasUsageGuide) {
            console.info(`Consider adding Document Usage Guide to ${file}`);
          }
        }
      });
    });

    test('should have Related Documents section', async () => {
      const docFiles = await fileAnalyzer.getFilesByPattern('docs/**/*.md');
      
      docFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Should reference related documents
        const hasRelatedDocs = content.includes('Related Documents') ||
                              content.includes('Related documents') ||
                              content.includes('See also');
        
        expect(hasRelatedDocs).toBe(true);
      });
    });

    test('should have Revision History section', async () => {
      const docFiles = await fileAnalyzer.getFilesByPattern('docs/**/*.md');
      
      docFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Should have revision history
        const hasRevisionHistory = content.includes('Revision History') ||
                                  content.includes('Version History') ||
                                  content.includes('Changelog');
        
        expect(hasRevisionHistory).toBe(true);
      });
    });
  });

  describe('Architecture Diagram Standards', () => {
    test('should use mermaid for diagrams', async () => {
      const docFiles = await fileAnalyzer.getFilesByPattern('docs/**/*.md');
      
      docFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // If file has diagrams, should use mermaid
        if (content.includes('```mermaid')) {
          // Valid mermaid syntax
          const mermaidBlocks = content.match(/```mermaid[\s\S]*?```/g) || [];
          
          mermaidBlocks.forEach(block => {
            expect(block).toContain('graph') || 
            expect(block).toContain('sequenceDiagram') ||
            expect(block).toContain('flowchart');
          });
        }
      });
    });

    test('should have architecture overview for complex systems', async () => {
      const architectureDocs = await fileAnalyzer.getFilesByPattern('docs/**/*architecture*.md');
      
      architectureDocs.forEach(file => {
        const content = fs.readFileSync(file, 'utf8');
        
        // Should have visual diagram
        expect(content).toContain('```mermaid');
      });
    });
  });
});
```

#### 11.2.10 Mock Data Coverage Matrix

When creating mock scenarios, ensure coverage of all decision forks:

| Workflow | Decision Fork | Mock Scenarios | Coverage |
|----------|---------------|----------------|----------|
| Procurement | CDC Required? | Domestic vs Guinea vs Other | ✅ |
| Procurement | HITL Required? | Standard vs High-Value | ✅ |
| Procurement | SOW Required? | Simple vs Complex | ✅ |
| Procurement | Hazardous? | Standard vs Hazardous | ✅ |
| Procurement | New Vendor? | Registered vs New | ✅ |
| Procurement | Import Required? | Domestic vs Cross-Border | ✅ |
| Procurement | Export Required? | Domestic vs Cross-Border | ✅ |
| Procurement | DDI Required? | <$1250 vs >$1250 to Guinea | ✅ |
| Correspondence | Format? | Email vs Letter | ✅ |
| Governance | AI Generated? | Manual vs AI (ISO 42001) | ✅ |
| Contractor Vetting | ISO 45001? | Certified vs Not Certified | ✅ |

#### 11.2.3 Documenting Expected Outcomes

Each mock scenario must document expected outcomes:

```javascript
{
  id: 'scenario_xxx',
  name: 'Scenario Name',
  mockData: { ... },
  expectedOutcomes: [
    'Outcome 1: Description of expected behavior',
    'Outcome 2: Database changes expected',
    'Outcome 3: External services called',
    'Outcome 4: Handoff events triggered'
  ],
  unexpectedBehaviors: [
    'Should NOT trigger X',
    'Should NOT create Y'
  ]
}
```

### 11.3 Source Code Linking

- Always import from actual source files
- Reference source file in `testMetadata`
- Keep tests synchronized with source code changes

---

## 12. Related Documents

| Document | Location |
|----------|----------|
| Testing Framework | `docs/workflows-simulations/TESTING_FRAMEWORK.md` |
| Handoff System Testing | `docs/workflows-simulations/01900_TESTING_GUIDE_HANDOFF_SYSTEM.md` |
| File Naming Standards | `docs/standards/0002_FILE_NAMING_STANDARDS.md` |
| Workflow Optimization Guide | `deep-agents/docs/0000_WORKFLOW_OPTIMIZATION_GUIDE.md` |

---

## 13. Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-02-19 | Testing Team | Initial procedure document |

---

## 14. Approval

| Role | Name | Signature | Date |
|------|------|-----------|------|
| Document Owner | | | |
| Technical Reviewer | | | |
| Quality Assurance | | | |