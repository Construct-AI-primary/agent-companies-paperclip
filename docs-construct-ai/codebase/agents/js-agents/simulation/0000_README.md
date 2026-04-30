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
# Correspondence Workflow Simulator

A reverse-engineered simulation agent for the Construct AI correspondence analysis workflow. This simulator enables rapid testing and iteration of complex agent workflows without requiring full system deployments.

## Quick Start

### Prerequisites
- Node.js v14+ installed
- Access to the Construct AI project directory

### Installation
```bash
cd docs/agents/simulation
npm install
```

### Directory Structure
```
docs/agents/simulation/
├── correspondence-workflow-simulator.js  # Core simulation engine
├── run-simulation.js                     # CLI runner for simulations
├── test-runner.js                        # Comprehensive test suite
├── simulation-config.json                # Configuration file
├── package.json                          # NPM scripts and dependencies
└── README.md                            # This documentation
```

### Primary Interface: Cline Workflow System

**This simulation system is designed primarily for use through Cline's workflow interface:**

```bash
# Basic simulation
/workflow correspondence-simulation-workflow --correspondence_file="docs/agents/source-data/correspondence/sample-variation-request.txt"

# Test with different response types
/workflow correspondence-simulation-workflow --correspondence_file="docs/agents/source-data/correspondence/Letter 5 - Contractor to Engineer - BB:DHBEP:C003.txt" --response_type="hypothetical_response"

# Custom specialist configuration
/workflow correspondence-simulation-workflow --correspondence_file="docs/agents/source-data/correspondence/your-file.txt" --specialists="civil_engineering,structural_engineering,quantity_surveying"

# Run validation tests
/workflow correspondence-simulation-workflow --validate_fixes=true
```

### Development Interface: NPM Scripts

**For development and quick testing, limited npm scripts are available:**

```bash
# Quick development test
npm run dev

# Validate our fixes work
npm run validate

# Demo with real correspondence file
npm run demo
```

### Real API Integration (Default Behavior)

**This simulation uses REAL API calls by default - no misleading mocks:**

```bash
# Normal usage (uses real APIs)
node run-simulation.js --correspondence-file=your-file.txt

# Via workflow (uses real APIs)
workflow correspondence-simulation-workflow --correspondence_file="your-file.txt"
```

**Real API Integration Features:**
- ✅ **HITL API**: Real `/api/tasks/hitl` calls for task creation
- ✅ **LangExtract**: Actual document processing service calls
- ✅ **Prompt Service**: Real database-driven prompt retrieval
- ✅ **No Mocks**: Fails if APIs are unavailable (accurate testing)

**Requirements:**
- Construct AI backend services running on `http://localhost:3000`
- HITL service database available
- LangExtract Python service running (port 8000)
- Valid authentication tokens (if required)

**Why No Mocks?** Mock data can be misleading and doesn't validate real integrations. This tool requires actual services to ensure accurate testing results.

## Available Commands

### Run Simulations
```bash
# Basic happy path simulation
node run-simulation.js happy-path-001

# Test with different specialist response types
node run-simulation.js happy-path-001 --response-type=hypothetical_response
node run-simulation.js happy-path-001 --response-type=good_response
node run-simulation.js happy-path-001 --response-type=error_response

# Customize specialists consulted
node run-simulation.js happy-path-001 --specialists=civil_engineering,structural_engineering,quantity_surveying

# Skip specific workflow steps
node run-simulation.js happy-path-001 --skip-steps=document_retrieval,human_review

# Load correspondence from file
node run-simulation.js --correspondence-file=my-correspondence.txt
node run-simulation.js --correspondence-file=../docs/my-letter.md
node run-simulation.js --correspondence-file=/absolute/path/to/correspondence.txt

# Combine file loading with other options
node run-simulation.js --correspondence-file=variation-request.txt --response-type=good_response --specialists=civil_engineering,quantity_surveying
```

### Utility Commands
```bash
# List all available test scenarios
node run-simulation.js --list-scenarios

# Show performance metrics across all runs
node run-simulation.js --performance-report

# Validate that our bug fixes work correctly
node run-simulation.js --validate-fixes

# Show help
node run-simulation.js
```

### NPM Scripts
```bash
npm run start          # Interactive mode
npm run test           # Run validation tests
npm run list           # List scenarios
npm run perf           # Show performance report
npm run simulate       # Quick simulation
```

## Understanding Results

### Successful Simulation Output
```
📋 SIMULATION RESULTS
==================================================
✅ Status: SUCCESS
🆔 Execution ID: sim_1736989456789_abc123def
🎯 Scenario: happy-path-001
⏱️  Total Duration: 1250ms
🔢 Steps Executed: 6/6

📊 WORKFLOW STATUS
✅ Workflow Completed: YES
📈 Success Rate: 100.0%
⚡ Steps Successful: 6/6

🔄 STEP DETAILS
  document_analysis: {"identifiersExtracted":5,"confidence":0.92}
  information_extraction: {"outputSize":456}
  document_retrieval: {"outputSize":789}
  domain_specialist: {"specialistsConsulted":2,"averageConfidence":0.87}
  contract_management: {"outputSize":234}
  human_review: {"finalDecision":"approved","confidenceScore":0.89}

🎯 KEY OUTPUTS
  document_analysis: {
    identifiersExtracted: 5,
    confidence: 0.92
  }
  domain_specialist: {
    specialistsConsulted: 2,
    averageConfidence: 0.87
  }
  human_review: {
    finalDecision: "approved",
    confidenceScore: 0.89
  }
==================================================
```

### Key Metrics Explained
- **Status**: SUCCESS/FAILED
- **Execution ID**: Unique identifier for tracking
- **Duration**: Total time for workflow completion
- **Steps Executed**: X/Y format (executed/total possible)
- **Success Rate**: Percentage of steps that completed successfully
- **Key Outputs**: Important results from each workflow step

## Test Scenarios

### Available Scenarios
- `happy-path-001`: Simple variation request with successful completion
- *(More scenarios can be added by creating JSON files in `../source-data/test-scenarios/`)*

### Scenario Structure
```json
{
  "id": "scenario-id",
  "name": "Human readable name",
  "description": "What this scenario tests",
  "correspondence": "sample-correspondence-001.json",
  "expected_workflow": {
    "steps": [...],
    "success_criteria": [...]
  },
  "validation_rules": [...]
}
```

## Configuration Options

### Response Types
- `good_response`: Proper analysis with citations (our fix validated)
- `hypothetical_response`: The problematic responses we eliminated
- `error_response`: Failure scenarios for testing error handling

### Specialist Selection
- Default: `civil_engineering, structural_engineering`
- Available: `civil_engineering, structural_engineering, mechanical_engineering, electrical_engineering, geotechnical_engineering, safety_engineering, quantity_surveying`

### Step Skipping
Skip workflow steps to test partial workflows:
```bash
--skip-steps=document_retrieval,human_review
```

## Validation Tests

The simulator includes automated validation of our fixes:

```bash
node run-simulation.js --validate-fixes
```

**Tests Performed:**
1. **Hypothetical Content Check**: Ensures no "given the constraints" language
2. **HITL Task Creation**: Verifies specialists are properly consulted
3. **Citation Validation**: Confirms specialist responses include proper citations

**Expected Output:**
```
🔧 VALIDATING FIXES
==================================================
Test 1: Checking for absence of hypothetical responses...
  Hypothetical content detected: ✅ PASS

Test 2: Checking HITL task creation...
  HITL tasks created: ✅ PASS

Test 3: Checking specialist citations...
  Citations present: ✅ PASS

🎯 VALIDATION COMPLETE
```

## Troubleshooting

### Common Issues

**"Scenario not found" Error**
```bash
# Check available scenarios
node run-simulation.js --list-scenarios

# Ensure scenario file exists in source-data/test-scenarios/
ls ../source-data/test-scenarios/
```

**"Correspondence not found" Error**
```bash
# Check available correspondence samples
ls ../source-data/correspondence/

# Ensure scenario references correct correspondence ID
```

**Timeout Errors**
- Simulations include realistic delays (100-600ms per step)
- Increase timeout values in simulator config if needed
- Use `--skip-steps` to bypass slow components during debugging

### Debug Mode
Enable verbose logging:
```javascript
const simulator = new CorrespondenceWorkflowSimulator({
  enableLogging: true,
  debug: true
});
```

## Extending the Simulator

### Adding New Scenarios
1. Create JSON file in `../source-data/test-scenarios/`
2. Follow the existing scenario structure
3. Reference valid correspondence samples

### Adding New Correspondence Samples
1. Create JSON file in `../source-data/correspondence/`
2. Include realistic construction correspondence
3. Add expected analysis outcomes for validation

### Adding New Specialist Types
1. Create response file in `../source-data/specialist-responses/`
2. Include `good_response`, `hypothetical_response`, `error_response`
3. Update simulator configuration

## Performance Monitoring

Track simulation performance over time:

```bash
# Run multiple simulations
for i in {1..10}; do
  node run-simulation.js happy-path-001
done

# View performance report
node run-simulation.js --performance-report
```

**Sample Performance Report:**
```
📊 PERFORMANCE REPORT
==================================================
Total Executions: 10

🔄 document_analysis
  Executions: 10
  Avg Duration: 245.60ms
  Min/Max Duration: 180ms / 320ms
  Success Rate: 100.0%

🔄 domain_specialist
  Executions: 10
  Avg Duration: 580.40ms
  Min/Max Duration: 520ms / 650ms
  Success Rate: 100.0%
```

## Integration with Development Workflow

### Pre-commit Testing
```bash
# Add to package.json scripts in main project
"precommit": "cd docs/agents/simulation && npm run test"
```

### CI/CD Integration
```yaml
# .github/workflows/test.yml
- name: Run Workflow Simulations
  run: |
    cd docs/agents/simulation
    npm run test
    npm run perf
```

### Development Workflow
1. **Code Changes**: Modify agent logic
2. **Run Simulations**: `npm run test`
3. **Validate Fixes**: `npm run validate-fixes`
4. **Performance Check**: `npm run perf`
5. **Commit**: Only if all tests pass

## Architecture Overview

```
CorrespondenceWorkflowSimulator
├── Configuration Layer
│   ├── Workflow Definition (6 steps)
│   ├── Test Scenarios (JSON files)
│   └── Mock Data Providers
├── Simulation Engine
│   ├── Step Execution Manager
│   ├── State Management (shared data)
│   └── Result Aggregation
├── Mock Services Layer
│   ├── Document Analysis Mock
│   ├── Specialist Consultation Mock
│   └── HITL Creation Mock
└── Reporting Layer
    ├── Execution Results
    ├── Performance Metrics
    └── Validation Reports
```

This simulator provides a complete testing environment for the correspondence workflow, enabling rapid iteration and validation of agent changes without requiring full system deployments.