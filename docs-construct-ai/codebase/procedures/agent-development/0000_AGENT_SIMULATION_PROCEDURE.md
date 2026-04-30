---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation
documentation
openstinger_context: general-documentation
last_updated: 2026-03-30
related_docs:
  - docs/
---

# 0000 Agent Simulation Procedure

## Overview

This document provides a comprehensive procedure for conducting agent simulations across all workflow domains in the ConstructAI system. The procedure covers the complete simulation lifecycle from setup and execution through analysis and optimization, utilizing the advanced testing infrastructure and real-time performance monitoring capabilities.

## Requirements

### Prerequisites
- Access to ConstructAI simulation framework with agent orchestration permissions
- Understanding of workflow processes and agent roles across different domains
- Familiarity with the target business domains (procurement, safety, correspondence)
- Access to simulation data sources and test datasets

### Technical Requirements
- **Agent Simulation Framework**: Correspondence, procurement, and safety workflow simulators operational
- **Real-time Performance Monitoring**: Active monitoring system at `http://localhost:3002`
- **Error Scenario Testing**: Comprehensive testing framework with 24+ error scenarios
- **Scale Testing Infrastructure**: Large-scale data generation capabilities (175,000+ records)
- **Quality Validation System**: Multi-dimensional quality scoring and specialist validation
- **HITL Integration**: Human-in-the-Loop capabilities for complex decision validation
- **Workflow Abstraction Layer**: Unified interface for different agent workflows

### Access Requirements
- **Simulation Framework**: `agents/simulation/` directory with all simulators
- **Monitoring Dashboard**: `http://localhost:3002` for real-time performance tracking
- **Workflow Definitions**: `agents/simulation/workflows/` with JSON definitions
- **Test Frameworks**: Error testing and scale testing capabilities
- **Data Sources**: Access to simulation data and test datasets
- **Permissions**: `simulation:execute` and `monitoring:view` permissions required

## Simulation Framework Architecture

### Core Components

#### 1. Workflow Abstraction Layer
- **Location**: `agents/simulation/workflow-abstraction.js`
- **Capabilities**: Unified interface for all workflow types
- **Workflow Loading**: Dynamic loading of JSON workflow definitions
- **Simulator Creation**: Factory pattern for creating workflow-specific simulators

#### 2. Domain-Specific Simulators
- **Correspondence Simulator**: `agents/simulation/correspondence-workflow-simulator.js`
- **Procurement Simulator**: `agents/simulation/procurement-workflow-simulator.js`
- **Safety Simulator**: `agents/simulation/safety-workflow-simulator.js`
- **Extensible Framework**: Support for additional domain simulators

#### 3. Workflow Definitions
- **Location**: `agents/simulation/workflows/`
- **Correspondence**: `correspondence-workflow.json` (6 agents, 6 stages)
- **Procurement**: `procurement-workflow.json` (6 agents, 5 stages)
- **Safety**: `safety-workflow.json` (7 agents, 6 stages)
- **Standard Format**: JSON schema for consistent workflow definitions

#### 4. Real-time Performance Monitoring
- **Dashboard**: `http://localhost:3002`
- **Metrics**: Response time, error rate, throughput, memory usage, queue depth
- **Alerts**: Configurable thresholds with automated notifications
- **Analytics**: Historical trends and performance forecasting

#### 5. Error Scenario Testing Framework
- **Location**: `scripts/error-scenario-testing.cjs`
- **Coverage**: 24 error scenarios across 6 categories (Network, Data, System, Integration, Security, Performance)
- **Capabilities**: Automated test execution, detailed reporting, failure analysis
- **Integration**: Seamless integration with all workflow simulations

#### 6. Scale Testing Infrastructure
- **Location**: `scripts/scale-testing-data-generation.cjs`
- **Scale**: Generate 175,000+ realistic test records in seconds
- **Data Types**: Correspondence, procurement, safety, and general test datasets
- **Performance**: 23,600 records/second generation capability

#### 7. Training Data Transformation
- **Location**: `scripts/transform_simulation_to_training.py`
- **Function**: Converts simulation outputs to training data records
- **Integration**: Automated pipeline for continual learning
- **Storage**: Saves to Supabase `correspondence_training_data` table

## Simulation Planning and Setup

### Phase 1: Simulation Requirements Analysis

#### Step 1.1: Define Simulation Objectives

**Objective**: Clearly articulate what the simulation aims to achieve and validate.

**Activities:**
1. Identify the business process or workflow domain to be simulated
2. Select appropriate workflow type (correspondence, procurement, safety)
3. Determine the specific agents and roles involved
4. Establish success criteria and performance benchmarks
5. Identify stakeholders and success metrics

**Deliverables:**
- Simulation objectives document
- Domain and workflow type selection
- Scope definition and constraints
- Success criteria matrix
- Stakeholder identification list

**Example Objectives:**
```
Simulation Objective: Validate procurement order processing efficiency
Domain: Procurement
Workflow: procurement-workflow
Agents: 6 specialized procurement agents
Success Criteria: 95% accuracy, <45 second processing time, 99% compliance rate
Stakeholders: Procurement team, compliance officers, IT operations
```

#### Step 1.2: Assess Technical Requirements

**Objective**: Determine the technical infrastructure and resources needed.

**Activities:**
1. Identify data sources and volumes required for the selected domain
2. Assess computational resources needed
3. Determine monitoring and logging requirements
4. Evaluate integration points with existing systems
5. Plan for scalability and performance requirements

**Deliverables:**
- Technical requirements specification
- Domain-specific data requirements
- Infrastructure assessment report
- Integration requirements document
- Performance requirements matrix

**Technical Assessment Template:**
```javascript
const technicalRequirements = {
  domain: 'procurement', // correspondence, procurement, safety
  dataSources: {
    primary: 'procurement_orders_table',
    secondary: ['supplier_database', 'approval_workflow'],
    volume: '500-2000_records',
    dataTypes: ['purchase_orders', 'supplier_data', 'compliance_docs']
  },
  infrastructure: {
    compute: '4-core_minimum',
    memory: '8GB_minimum',
    storage: '100GB_available',
    network: 'stable_high_bandwidth'
  },
  monitoring: {
    realTimeDashboard: true,
    domainSpecificMetrics: true,
    alertingEnabled: true,
    loggingLevel: 'detailed',
    retentionPeriod: '30_days'
  },
  integration: {
    apis: ['supplier_api', 'approval_system'],
    databases: ['supabase', 'procurement_db'],
    externalServices: ['llm_providers', 'monitoring_services']
  },
  performance: {
    targetResponseTime: '<45_seconds',
    targetThroughput: '20_transactions/hour',
    availabilityTarget: '99.5%'
  }
};
```

### Phase 2: Simulation Environment Setup

#### Step 2.1: Configure Simulation Framework

**Objective**: Set up the simulation environment with appropriate configurations.

**Configuration Steps:**
1. Access the simulation framework directory
2. Configure environment variables and API keys
3. Set up database connections and data sources
4. Select and configure the appropriate workflow simulator
5. Initialize monitoring and logging systems

**Environment Setup:**
```bash
# Navigate to simulation directory
cd agents/simulation

# Configure environment
export SIMULATION_ENV=development
export SUPABASE_URL=your_supabase_url
export SUPABASE_ANON_KEY=your_anon_key
export MONITORING_PORT=3002
export LOG_LEVEL=detailed
export WORKFLOW_DOMAIN=procurement  # correspondence, procurement, safety

# Initialize simulation framework
node workflow-abstraction.js --initialize
echo "Simulation framework initialized"
```

#### Step 2.2: Prepare Domain-Specific Test Data

**Objective**: Generate or prepare realistic test data for the selected domain.

**Data Preparation Methods:**

**Correspondence Domain:**
```bash
# Generate correspondence test data
node scripts/scale-testing-data-generation.cjs \
  --dataset=correspondence \
  --records=1000 \
  --output=test-data/correspondence-test.json \
  --realistic=true
```

**Procurement Domain:**
```bash
# Generate procurement test data
node scripts/scale-testing-data-generation.cjs \
  --dataset=procurement \
  --records=500 \
  --output=test-data/procurement-test.json \
  --realistic=true
```

**Safety Domain:**
```bash
# Generate safety test data
node scripts/scale-testing-data-generation.cjs \
  --dataset=safety \
  --records=300 \
  --output=test-data/safety-test.json \
  --realistic=true
```

#### Step 2.3: Configure Domain-Specific Agent Roles

**Objective**: Set up agent roles with appropriate domain-specific configurations.

**Domain-Specific Agent Configuration:**

**Procurement Agents:**
```javascript
const procurementAgentConfig = {
  procurement_coordinator: {
    role: 'coordinator',
    permissions: ['order:create', 'workflow:manage'],
    domain: 'procurement',
    specialization: 'orchestration'
  },
  requirement_analyzer: {
    role: 'specialist',
    permissions: ['requirements:analyze', 'specs:validate'],
    domain: 'procurement',
    specialization: 'requirements'
  },
  supplier_evaluator: {
    role: 'specialist',
    permissions: ['suppliers:evaluate', 'pricing:analyze'],
    domain: 'procurement',
    specialization: 'supplier_management'
  }
};
```

**Safety Agents:**
```javascript
const safetyAgentConfig = {
  safety_coordinator: {
    role: 'coordinator',
    permissions: ['safety:manage', 'compliance:oversee'],
    domain: 'safety',
    specialization: 'orchestration'
  },
  contractor_vetter: {
    role: 'specialist',
    permissions: ['contractors:vet', 'safety:assess'],
    domain: 'safety',
    specialization: 'contractor_safety'
  },
  risk_assessor: {
    role: 'specialist',
    permissions: ['risk:assess', 'hazards:identify'],
    domain: 'safety',
    specialization: 'risk_management'
  }
};
```

### Phase 3: Simulation Execution

#### Step 3.1: Initialize Domain Simulator

**Objective**: Start the appropriate simulator for the selected domain.

**Domain-Specific Initialization:**

**Correspondence Simulation:**
```bash
# Initialize correspondence simulator
node correspondence-workflow-simulator.js --initialize
echo "Correspondence simulator initialized"
```

**Procurement Simulation:**
```bash
# Initialize procurement simulator
node procurement-workflow-simulator.js --initialize
echo "Procurement simulator initialized"
```

**Safety Simulation:**
```bash
# Initialize safety simulator
node safety-workflow-simulator.js --initialize
echo "Safety simulator initialized"
```

#### Step 3.2: Execute Domain Workflow Scenarios

**Objective**: Run simulation scenarios with domain-appropriate configurations and workloads.

**Domain-Specific Execution Options:**

**Correspondence Workflow Simulation:**
```bash
# Run correspondence workflow simulation
node correspondence-workflow-simulator.js \
  --workflow=correspondence_processing \
  --agents=all \
  --data-source=test-data/correspondence-test.json \
  --monitoring=enabled \
  --specialists=civil_engineering,structural_engineering \
  --logging=detailed
```

**Procurement Workflow Simulation:**
```bash
# Run procurement workflow simulation
node procurement-workflow-simulator.js \
  --workflow=procurement_processing \
  --agents=all \
  --data-source=test-data/procurement-test.json \
  --monitoring=enabled \
  --approval-threshold=50000 \
  --logging=detailed
```

**Safety Workflow Simulation:**
```bash
# Run safety workflow simulation
node safety-workflow-simulator.js \
  --workflow=safety_assessment \
  --agents=all \
  --data-source=test-data/safety-test.json \
  --monitoring=enabled \
  --compliance-level=iso_45001 \
  --logging=detailed
```

#### Step 3.3: Monitor Domain-Specific Performance

**Objective**: Track domain-specific simulation execution and performance metrics.

**Domain-Specific Monitoring:**

**Procurement Metrics:**
```javascript
const procurementMetrics = {
  orderProcessingTime: 'avg_time_per_order',
  supplierEvaluationAccuracy: 'supplier_scoring_accuracy',
  complianceRate: 'regulatory_compliance_percentage',
  approvalCycleTime: 'time_to_final_approval',
  costEfficiency: 'cost_savings_percentage'
};
```

**Safety Metrics:**
```javascript
const safetyMetrics = {
  incidentResponseTime: 'avg_response_to_incidents',
  riskAssessmentAccuracy: 'hazard_identification_accuracy',
  complianceAuditScore: 'regulatory_compliance_score',
  trainingCompletionRate: 'safety_training_completion',
  contractorVettingAccuracy: 'safety_qualification_accuracy'
};
```

### Phase 4: Simulation Analysis and Reporting

#### Step 4.1: Collect Domain-Specific Results

**Objective**: Gather comprehensive data from simulation execution for domain-specific analysis.

**Domain-Specific Data Collection:**

**Procurement Results:**
```javascript
const procurementResults = {
  ordersProcessed: 150,
  averageProcessingTime: 185000, // ms
  supplierEvaluationsCompleted: 75,
  complianceIssuesIdentified: 12,
  approvalDecisionsMade: 148,
  costSavingsIdentified: 250000,
  qualityScore: 94.2
};
```

**Safety Results:**
```javascript
const safetyResults = {
  assessmentsCompleted: 89,
  incidentsInvestigated: 15,
  riskAssessmentsPerformed: 67,
  complianceAuditsPassed: 85,
  trainingProgramsCompleted: 42,
  safetyImprovementsIdentified: 23,
  responseTimeAvg: 120000, // ms
  qualityScore: 96.1
};
```

#### Step 4.2: Generate Domain-Specific Reports

**Objective**: Create comprehensive reports tailored to each domain's requirements.

**Report Generation:**
```bash
# Generate domain-specific simulation report
node scripts/generate-simulation-report.cjs \
  --domain=procurement \
  --simulation-id=sim_proc_2026_01_21_001 \
  --format=comprehensive \
  --include-raw-data=true \
  --output=reports/procurement-simulation-2026-01-21.pdf

# Generate cross-domain comparison report
node scripts/generate-simulation-report.cjs \
  --domains=correspondence,procurement,safety \
  --format=comparison \
  --output=reports/cross-domain-analysis-2026-01-21.pdf
```

**Domain-Specific Report Components:**
1. **Executive Summary**: Domain-specific key findings and recommendations
2. **Performance Analysis**: Domain-relevant metrics and KPIs
3. **Quality Assessment**: Domain-specific compliance and accuracy measures
4. **Agent Performance**: Individual agent analysis within domain context
5. **Business Impact**: Domain-specific efficiency improvements and ROI
6. **Recommendations**: Actionable improvements for the specific domain

### Phase 5: Training Data Transformation

#### Step 5.1: Transform Simulation to Training Data

**Objective**: Convert simulation outputs into training data for continual learning.

**Domain-Specific Transformation:**

**Correspondence Training Data:**
```bash
# Transform correspondence simulation data
python scripts/transform_simulation_to_training.py \
  --supabase-url $SUPABASE_URL \
  --supabase-key $SUPABASE_SERVICE_ROLE_KEY \
  --simulation-dir "agents/simulation/docs/correspondence-workflow" \
  --domain=correspondence
```

**Procurement Training Data:**
```bash
# Transform procurement simulation data
python scripts/transform_simulation_to_training.py \
  --supabase-url $SUPABASE_URL \
  --supabase-key $SUPABASE_SERVICE_ROLE_KEY \
  --simulation-dir "agents/simulation/docs/procurement-workflow" \
  --domain=procurement
```

**Safety Training Data:**
```bash
# Transform safety simulation data
python scripts/transform_simulation_to_training.py \
  --supabase-url $SUPABASE_URL \
  --supabase-key $SUPABASE_SERVICE_ROLE_KEY \
  --simulation-dir "agents/simulation/docs/safety-workflow" \
  --domain=safety
```

#### Step 5.2: Validate Training Data Quality

**Objective**: Ensure transformed training data meets quality standards.

**Quality Validation:**
```bash
# Validate training data quality
python scripts/validate_training_data.py \
  --domain=procurement \
  --quality-threshold=0.85 \
  --output=reports/training-data-quality-2026-01-21.json
```

### Phase 6: Optimization and Scaling

#### Step 6.1: Domain-Specific Performance Optimization

**Objective**: Apply domain-specific improvements based on simulation results.

**Domain Optimization Strategies:**

**Procurement Optimization:**
```javascript
const procurementOptimizations = {
  parallelProcessing: {
    supplierEvaluations: 'parallel_supplier_scoring',
    complianceChecks: 'concurrent_validation'
  },
  cachingStrategy: {
    supplierData: 'cache_frequent_suppliers',
    approvalRules: 'cache_business_rules'
  },
  workflowStreamlining: {
    autoApproval: 'low_value_auto_approve',
    batchProcessing: 'bulk_order_processing'
  }
};
```

**Safety Optimization:**
```javascript
const safetyOptimizations = {
  riskPrioritization: {
    criticalIncidents: 'immediate_escalation',
    highRiskSites: 'enhanced_monitoring'
  },
  automatedChecks: {
    complianceValidation: 'real_time_scanning',
    trainingVerification: 'automated_tracking'
  },
  predictiveAnalytics: {
    incidentPrediction: 'risk_trend_analysis',
    safetyMetrics: 'performance_forecasting'
  }
};
```

## Domain-Specific Best Practices

### Correspondence Simulation
- **Data Volume**: 1,000-10,000 correspondence items
- **Specialist Coverage**: 3-5 engineering disciplines
- **Quality Focus**: Response accuracy and completeness
- **Performance Target**: <30 seconds per correspondence

### Procurement Simulation
- **Data Volume**: 500-2,000 procurement orders
- **Approval Levels**: Multi-tier approval workflows
- **Quality Focus**: Compliance and cost efficiency
- **Performance Target**: <45 seconds per order

### Safety Simulation
- **Data Volume**: 300-1,000 safety assessments
- **Risk Levels**: Critical, high, medium, low categorization
- **Quality Focus**: Regulatory compliance and risk mitigation
- **Performance Target**: <60 seconds per assessment

## Integration with Continual Learning

### Training Pipeline Integration

**Automated Training Data Flow:**
```
1. Domain Simulation
   └─> Generates domain-specific outputs

2. Data Transformation (this procedure)
   └─> Parses outputs by domain
   └─> Saves to domain-specific training tables

3. Model Training
   └─> Trains domain-specific specialist models
   └─> Validates model quality per domain

4. Model Deployment
   └─> Deploys improved models to domain workflows
   └─> Updates simulation with new model versions
```

### Quality Assurance

**Domain-Specific Quality Gates:**
- **Correspondence**: 95% response accuracy, 90% completeness
- **Procurement**: 96% compliance rate, 92% cost efficiency
- **Safety**: 98% regulatory compliance, 94% risk identification

### Performance Monitoring

**Cross-Domain Metrics:**
- **Simulation Coverage**: Percentage of workflows with active simulators
- **Training Data Quality**: Average quality score across domains
- **Model Performance**: Domain-specific accuracy improvements
- **System Efficiency**: Overall simulation and training pipeline efficiency

## Troubleshooting Guide

### Domain-Specific Issues

#### Procurement Simulation Issues
**Problem**: Supplier evaluation timeouts
**Solution**: Reduce concurrent evaluations or increase timeout limits

**Problem**: Approval workflow deadlocks
**Solution**: Review approval rule logic and add timeout mechanisms

#### Safety Simulation Issues
**Problem**: Risk assessment delays
**Solution**: Implement risk scoring caching and parallel processing

**Problem**: Compliance validation failures
**Solution**: Update regulatory rule sets and validation logic

#### Correspondence Simulation Issues
**Problem**: Specialist assignment failures
**Solution**: Verify specialist availability and routing logic

**Problem**: Response quality degradation
**Solution**: Review prompt templates and specialist training data

## Success Metrics

### Overall Simulation Metrics
- **Domain Coverage**: Percentage of business domains with simulators (target: 100%)
- **Simulation Quality**: Average quality score across all domains (target: >90%)
- **Training Data Volume**: Records generated per simulation cycle (target: >10,000)
- **Model Improvement**: Average accuracy improvement per training cycle (target: >5%)

### Domain-Specific KPIs

**Correspondence:**
- Response accuracy: >95%
- Processing time: <30 seconds
- Specialist utilization: >85%

**Procurement:**
- Order compliance: >96%
- Processing efficiency: >90%
- Cost optimization: >15% savings

**Safety:**
- Risk identification: >95%
- Compliance rate: >98%
- Incident response: <2 hours

## Related Procedures

- **[0000_CORRESPONDENCE_AGENT_SIMULATION_PROCEDURE.md](./0000_CORRESPONDENCE_AGENT_SIMULATION_PROCEDURE.md)**: Correspondence simulation details
- **[02500_SIMULATION_TO_TRAINING_TRANSFORM.md](../simulation/02500_SIMULATION_TO_TRAINING_TRANSFORM.md)**: Training data transformation
- **[02100_AGENT_DEVELOPMENT_PROCEDURE.md](./02100_AGENT_DEVELOPMENT_PROCEDURE.md)**: Agent development lifecycle

## Version History

| Version | Date | Major Changes |
|---------|------|---------------|
| 1.0 | 2026-01-23 | Initial generic simulation procedure |
|  |  | Unified framework for all workflow domains |
|  |  | Domain-specific configurations and best practices |
|  |  | Integration with training data transformation |
|  |  | Cross-domain performance monitoring and optimization |

---

### Phase 7: Runtime Integration Testing

#### Step 7.1: Browser-Based Component Testing

**Objective**: Execute components in real browser environment to catch runtime errors that simulators miss.

**Activities:**
1. Start local development server (`npm run dev`)
2. Load application in browser with live data sources
3. Test all interactive components (modals, forms, async operations)
4. Monitor browser console for unhandled promise rejections
5. Validate useEffect hooks, event handlers, and cleanup functions
6. Test component unmounting and memory leak prevention

**Deliverables:**
- Runtime error detection report
- Component unmounting validation
- Memory leak assessment
- Browser compatibility verification

**Runtime Testing Framework:**
```bash
# Comprehensive runtime testing script
#!/bin/bash

echo "🚀 Starting Comprehensive Runtime Integration Testing"
echo "Script: client/__tests__/runtime-integration-tests.sh"

# Start development server
npm run dev &
SERVER_PID=$!

# Install Playwright browsers if needed
npx playwright install --yes

# Run modal and component tests
npx playwright test client/__tests__/modal-runtime-test.spec.ts

# Check for console errors and promise rejections
curl -s http://localhost:3060/ > /dev/null 2>&1

# Clean shutdown
kill $SERVER_PID 2>/dev/null || true

echo "✅ Runtime integration testing completed"
```

#### Step 7.2: Error Scenario Testing

**Objective**: Test error conditions that only manifest during actual execution.

**Activities:**
1. Network failure simulation (disconnect, timeout, slow connections)
2. API error response testing (4xx, 5xx status codes)
3. Invalid data handling (malformed responses, null values)
4. Component error boundary testing
5. Memory limit and performance degradation scenarios
6. Concurrent user operation conflicts

**Error Scenario Categories:**
```javascript
const runtimeErrorScenarios = {
  networkErrors: {
    timeout: 'API request timeouts',
    disconnect: 'Network connectivity loss',
    slowNetwork: 'Degraded connection speeds',
    dnsFailure: 'DNS resolution failures'
  },
  componentErrors: {
    unhandledPromise: 'Promise rejections without catch handlers',
    memoryLeak: 'Component not cleaning up event listeners/timers',
    infiniteLoop: 'useEffect dependency arrays causing re-renders',
    stateCorruption: 'Concurrent state updates causing race conditions'
  },
  dataErrors: {
    malformedResponse: 'Unexpected API response structure',
    nullData: 'Missing required fields in API responses',
    largeDataset: 'Performance with large data volumes',
    encodingIssues: 'Character encoding and special character handling'
  }
};
```

#### Step 7.3: Cross-Browser Compatibility Testing

**Objective**: Ensure runtime behavior is consistent across supported browsers.

**Activities:**
1. Chrome/Edge Chromium-based testing
2. Firefox Gecko testing
3. Safari WebKit testing
4. Mobile browser testing (iOS Safari, Chrome Mobile)
5. JavaScript engine differences validation

### Phase 8: Three-Level Testing Framework and Coverage Analysis

#### Step 8.1: Comprehensive Testing Hierarchy

**Objective**: Establish comprehensive testing strategy with clear separation of concerns and full error coverage.

**Three-Level Testing Framework (Updated 2026-01-26):**

**Level 1: Logic Testing (Agent Simulation)**
- **Purpose**: Validate business logic, algorithms, and data transformations
- **Tools**: `agents/simulation/workflow-abstraction.js`, custom simulators
- **Coverage**: Data structures, calculation logic, workflow algorithms
- **Limitations**: No browser runtime execution, no UI interactions
- **Error Detection**: Compile-time errors, logical bugs, data structure issues
- **Example**: Modal simulator (logic validation without browser execution)

**Level 2: Component Testing (Jest/React Testing Library)**
- **Purpose**: Test React component rendering and infrastructure in isolated environment
- **Tools**: Jest, React Testing Library, component unit tests
- **Coverage**: Component rendering, props handling, basic state management, user events
- **Limitations**: No real browser APIs, no network calls, no useEffect side effects
- **Error Detection**: Component mounting, prop validation, basic interaction logic
- **Example**: Jest component tests, JSX rendering validation

**Level 3: Runtime Integration Testing (Browser Automation)**
- **Purpose**: Validate actual component execution in browser environment with full runtime context
- **Tools**: Playwright, Selenium, runtime-integration-tests.sh, modal-runtime-test.spec.ts
- **Coverage**: useEffect execution, promise handling, event cleanup, network errors, memory leaks
- **Limitations**: Slower execution, more complex setup, harder to debug than unit tests
- **Error Detection**: Unhandled promises, memory leaks, browser incompatibilities, real network issues
- **Example**: `npm run test:runtime` - full browser execution with live API connections

#### Step 8.2: Coverage Gap Analysis and Remediation

**Objective**: Identify and eliminate testing gaps that lead to production runtime errors.

**Critical Gap Identified (2026-01-26):**
- **Issue**: Agent simulators couldn't detect unhandled promise rejections in MyTasksDashboard.jsx
- **Root Cause**: Simulators don't execute React components in browser environments
- **Impact**: Silent runtime errors causing unhandled promise rejections
- **Solution**: Added Phase 7-8 for comprehensive runtime testing

**Coverage Matrix (Remediation Applied):**
```javascript
const testingCoverage = {
  logicTesting: {
    strengths: ['Data validation', 'Business rules', 'Algorithm correctness'],
    gaps: ['Runtime execution', 'Browser APIs', 'Async side effects'],
    remediation: 'Runtime testing handles execution gaps'
  },
  componentTesting: {
    strengths: ['UI rendering', 'User interactions', 'Component logic'],
    gaps: ['Server communication', 'Real DOM events', 'Browser storage'],
    remediation: 'Integration testing handles server communication'
  },
  runtimeTesting: {
    strengths: ['Real execution', 'Error handling', 'Memory issues', 'Async operations'],
    gaps: ['Unit-level debugging', 'Isolated testing', 'Fast iteration'],
    remediation: 'Component and logic testing provide fast iteration path'
  }
};

// Recommended resource allocation (40% logic, 30% component, 30% runtime)
const testingResourceAllocation = {
  totalTestingEffort: '100%',
  logicTesting: '40%',      // Foundational correctness, fastest feedback
  componentTesting: '30%',  // UI/UX validation, medium feedback
  runtimeTesting: '30%'     // Production reality, slowest but most critical
};
```

## Updated Implementation Guide

### Testing Command Structure

```bash
# Level 1: Logic Testing (Fast, automated)
npm test                    # Jest unit tests and logic simulators
npm run test:modal         # Modal logic simulator

# Level 2: Component Testing (Medium speed, automated)
npm run test:coverage      # Component rendering tests
npm run test:integration   # Component workflow tests

# Level 3: Runtime Testing (Slow, comprehensive)
npm run test:runtime       # Full browser execution with live APIs
./client/__tests__/runtime-integration-tests.sh  # Direct script execution
```

### Test File Organization

```
agent-simulation-procedures/
├── agents/simulation/                    # Logic/algorithm testing
│   └── workflow-abstraction.js
├── client/__tests__/                     # Component and runtime testing
│   ├── modal-simulator.test.js          # Level 1: Logic testing
│   ├── component-lifecycle-test.spec.ts # Level 2: Component testing
│   ├── modal-runtime-test.spec.ts       # Level 3: Runtime testing
│   └── runtime-integration-tests.sh     # Level 3: Test orchestration
└── docs/procedures/                      # Test procedures and documentation
    └── 0000_AGENT_SIMULATION_PROCEDURE.md
```

---

**Procedure Version:** v1.1 (2026-01-26)
**Last Updated:** 2026-01-26
**Author:** AI Assistant (ConstructAI)
**Review Cycle:** Quarterly
**Next Review:** 2026-04-26

**Version Changes:**
- **v1.1 (2026-01-26)**: Added comprehensive runtime integration testing phases, three-level testing hierarchy, and coverage gap remediation following production unhandled promise rejection incident.

**Document Control:**
- **Classification**: Operational Procedure
- **Access Level**: Internal Use
- **Related Systems**: Agent Simulation Framework, Training Pipeline, Domain Workflows
- **Dependencies**: Workflow simulators, training data transformation, quality validation