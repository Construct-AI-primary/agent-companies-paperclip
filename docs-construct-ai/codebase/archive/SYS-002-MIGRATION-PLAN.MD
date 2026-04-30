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

# 🚀 **SYS_002 Migration Plan: JavaScript Server Agents → Unified Framework**
**ConstructAI Phase 2 - High Priority Consolidation**

**Date**: January 16, 2026
**Status**: **MIGRATION PLAN COMPLETE - READY FOR EXECUTION**
**Target**: Migrate 29 JavaScript services to unified agent framework
**Timeline**: 2 weeks (Phase 2 Week 1-2)
**Business Impact**: 60% reduction in service maintenance overhead

---

## 📋 **Executive Summary**

### **Migration Overview**
SYS_002 consists of **29 JavaScript services** in `server/services/` that provide critical business functionality but operate in architectural isolation. This migration plan transforms these scattered services into unified agents that leverage the cross-language framework while maintaining all existing functionality.

### **Migration Strategy**
- **Framework Adoption**: Migrate services to use `UnifiedAgent` base class
- **Incremental Migration**: Migrate in functional groups to minimize risk
- **Parallel Operation**: Run old and new implementations during transition
- **Feature Parity**: Ensure 100% functional compatibility post-migration

### **Success Criteria**
- ✅ All 29 services migrated to unified framework
- ✅ Zero functional regressions in business processes
- ✅ 60% reduction in maintenance overhead achieved
- ✅ Cross-language communication enabled for all services

---

## 📊 **SYS_002 Service Inventory & Analysis**

### **Service Categories & Migration Priority**

#### **🔴 HIGH PRIORITY - Core Business Services (Migrate First)**
| Service | Lines | Complexity | Dependencies | Business Criticality |
|---------|-------|------------|--------------|---------------------|
| `document-assembler-service.js` | 400+ | High | puppeteer, supabase | **CRITICAL** |
| `intelligent-template-selector.js` | 800+ | Very High | Multiple services | **CRITICAL** |
| `deep-agent-procurement-orchestrator.js` | 300+ | High | Multiple agents | **CRITICAL** |
| `parallel-specialist-coordinator.js` | 250+ | Medium | Specialist agents | **HIGH** |
| `template-generation-service.js` | 200+ | Medium | supabase | **HIGH** |

#### **🟡 MEDIUM PRIORITY - Supporting Services (Migrate Second)**
| Service | Lines | Complexity | Dependencies | Business Criticality |
|---------|-------|------------|--------------|---------------------|
| `langchainDocumentChatService.js` | 150+ | Medium | langchain | **HIGH** |
| `langchainProcessingService.js` | 120+ | Medium | langchain | **HIGH** |
| `order-template-derivation-service.js` | 100+ | Low | supabase | **MEDIUM** |
| `questionnaire-config-service.cjs` | 80+ | Low | supabase | **MEDIUM** |
| `questionnaire-template-service.cjs` | 90+ | Low | supabase | **MEDIUM** |
| `template-hierarchy-service.js` | 110+ | Medium | supabase | **MEDIUM** |
| `template-manipulation-service.js` | 95+ | Low | supabase | **MEDIUM** |

#### **🟢 LOW PRIORITY - Infrastructure Services (Migrate Last)**
| Service | Lines | Complexity | Dependencies | Business Criticality |
|---------|-------|------------|--------------|---------------------|
| `performance-monitoring-service.js` | 120+ | Medium | System APIs | **LOW** |
| `feature-flag-service.js` | 80+ | Low | Database | **LOW** |
| `field-attribute-compliance-service.js` | 100+ | Medium | supabase | **MEDIUM** |
| `protection-system-integration-service.js` | 90+ | Low | External APIs | **LOW** |
| `agent-registry-service.js` | 70+ | Low | supabase | **LOW** |
| `mock-prompts-service.js` | 50+ | Low | None | **LOW** |
| `flowiseService.js` | 60+ | Low | External API | **MEDIUM** |
| `form-generation-service.js` | 85+ | Low | supabase | **LOW** |
| `excelLoaderService.js` | 75+ | Low | File system | **LOW** |
| `emailSendService.js` | 65+ | Low | SMTP | **LOW** |
| `documensoDeploy.js` | 55+ | Low | External API | **LOW** |
| `database-template-service.js` | 70+ | Low | supabase | **LOW** |

---

## 🏗️ **Migration Architecture**

### **Unified Agent Structure Post-Migration**

```
agents/types/services/
├── procurement/
│   ├── document-assembler-agent.js      # From document-assembler-service.js
│   ├── template-selector-agent.js       # From intelligent-template-selector.js
│   ├── procurement-orchestrator-agent.js # From deep-agent-procurement-orchestrator.js
│   └── parallel-coordinator-agent.js    # From parallel-specialist-coordinator.js
├── document/
│   ├── chat-service-agent.js            # From langchainDocumentChatService.js
│   ├── processing-service-agent.js      # From langchainProcessingService.js
│   └── template-generation-agent.js     # From template-generation-service.js
├── business/
│   ├── order-derivation-agent.js        # From order-template-derivation-service.js
│   ├── questionnaire-config-agent.js     # From questionnaire-config-service.cjs
│   └── questionnaire-template-agent.js   # From questionnaire-template-service.cjs
├── infrastructure/
│   ├── monitoring-agent.js              # From performance-monitoring-service.js
│   ├── feature-flag-agent.js            # From feature-flag-service.js
│   ├── compliance-agent.js              # From field-attribute-compliance-service.js
│   └── registry-agent.js                # From agent-registry-service.js
└── utilities/
    ├── email-agent.js                   # From emailSendService.js
    ├── excel-agent.js                   # From excelLoaderService.js
    └── form-generation-agent.js         # From form-generation-service.js
```

### **Agent Configuration Schema**
```javascript
// Example: Document Assembler Agent Configuration
const documentAssemblerConfig = {
  agentId: "document-assembler-agent-001",
  agentType: "service",
  capabilities: [
    "document_assembly",
    "pdf_generation",
    "procurement_document_processing",
    "html_to_pdf_conversion"
  ],
  language: "javascript",
  version: "2.0.0",

  // Service-specific configuration
  customConfig: {
    puppeteerConfig: {
      headless: true,
      args: ['--no-sandbox', '--disable-setuid-sandbox']
    },
    documentFormats: ["pdf", "html"],
    maxDocumentSize: "50MB",
    timeoutSeconds: 300
  },

  // Monitoring and communication
  enableMonitoring: true,
  communicationProtocol: "http",
  registryUrl: "http://localhost:3001",

  // Dependencies (now managed by framework)
  dependencies: ["template-hierarchy-service", "document-formatting-service"]
};
```

---

## 🔄 **Migration Methodology**

### **Phase 1: Framework Adoption Pattern**

#### **Step 1: Extend UnifiedAgent Base Class**
```javascript
// Before: Standalone service class
class DocumentAssemblerService {
  constructor() {
    this.browser = null;
    this.templatesCache = new Map();
  }

  async initializeBrowser() {
    // Puppeteer setup
  }

  async assembleProcurementDocument(orderId) {
    // Core business logic
  }
}

// After: Unified agent extending base class
const { UnifiedAgent } = require('../core/javascript/unified-agent-framework');

class DocumentAssemblerAgent extends UnifiedAgent {
  static DESCRIPTION = "Handles assembly of procurement documents including SOW integration and PDF generation";

  constructor(config) {
    // Validate required capabilities
    const requiredCaps = ["document_assembly", "pdf_generation"];
    if (!config.capabilities.some(cap => requiredCaps.includes(cap))) {
      throw new Error(`Agent requires capabilities: ${requiredCaps.join(', ')}`);
    }

    super(config);

    // Agent-specific initialization
    this.puppeteerConfig = config.customConfig?.puppeteerConfig || {};
    this.templatesCache = new Map();
  }

  async _executeImpl(workflowState, options = {}) {
    try {
      const { action, parameters } = workflowState;

      switch (action) {
        case 'assemble_document':
          return await this._assembleProcurementDocument(parameters.orderId);
        case 'generate_cover_sheet':
          return await this._generateApprovalCoverSheet(parameters.orderId);
        default:
          throw new Error(`Unsupported action: ${action}`);
      }
    } catch (error) {
      await this._handleProcessingError(error, workflowState);
      throw error;
    }
  }

  async _assembleProcurementDocument(orderId) {
    // Original business logic migrated here
    // ... existing implementation
  }

  async _generateApprovalCoverSheet(orderId) {
    // Original business logic migrated here
    // ... existing implementation
  }

  async _handleProcessingError(error, workflowState) {
    this.logger.error(`Document assembly error: ${error.message}`);
    // Framework-provided error handling
  }

  async initialize() {
    // Framework initialization
    const success = await super.initialize();
    if (!success) return false;

    // Agent-specific initialization (browser setup)
    await this._initializeBrowser();
    return true;
  }

  async cleanup() {
    // Cleanup browser instance
    if (this.browser) {
      await this.browser.close();
    }

    // Framework cleanup
    await super.cleanup();
  }
}
```

#### **Step 2: Migrate Configuration Management**
```javascript
// Before: Inline configuration
const supabaseClient = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY);

// After: Configuration-driven setup
async _setupDependencies(config) {
  // Supabase client setup through config
  this.supabase = createClient(
    config.customConfig?.supabaseUrl || process.env.SUPABASE_URL,
    config.customConfig?.supabaseKey || process.env.SUPABASE_SERVICE_ROLE_KEY
  );

  // Other dependencies setup
  this.documentFormattingService = await this._resolveDependency('document-formatting-service');
}
```

#### **Step 3: Implement Framework Integration**
```javascript
// Communication integration
async communicateWithAgent(targetAgentId, message) {
  const messagePayload = {
    messageId: this._generateId(),
    fromAgent: { agentId: this.agentId, agentType: this.agentType },
    toAgent: { agentId: targetAgentId },
    messageType: 'request',
    action: message.action,
    payload: message.payload,
    correlationId: message.correlationId
  };

  return await this.communicator.sendMessage(messagePayload);
}

// Progress reporting
async reportProgress(progress, step, metadata = {}) {
  await this._notifyProgress(progress, step);

  // Send progress to coordinating agents
  if (this.parentCoordinator) {
    await this.communicateWithAgent(this.parentCoordinator, {
      action: 'progress_update',
      payload: { progress, step, metadata }
    });
  }
}
```

### **Phase 2: Dependency Management**

#### **Service Dependency Resolution**
```javascript
// Before: Direct imports
import TemplateHierarchyService from './template-hierarchy-service.js';
import FieldAttributeComplianceService from './field-attribute-compliance-service.js';

// After: Framework-managed dependencies
async _resolveDependencies() {
  // Template hierarchy service
  this.templateHierarchy = await this.registry.discoverAndConnect({
    capabilities: ['template_hierarchy'],
    healthStatus: 'healthy'
  });

  // Compliance service
  this.complianceService = await this.registry.discoverAndConnect({
    capabilities: ['field_compliance'],
    healthStatus: 'healthy'
  });
}
```

#### **Cross-Agent Communication**
```javascript
// Example: Template selector coordinating with compliance service
async applyComplianceFilter(templates, requirements, context) {
  // Communicate with compliance agent
  const complianceCheck = await this.communicateWithAgent(
    this.complianceService.agentId,
    {
      action: 'validate_before_ai',
      payload: {
        templateId: templates[0]?.id,
        documentData: requirements.documentData,
        context: {
          organizationId: context.organizationId,
          workflowId: context.workflowId
        }
      }
    }
  );

  return complianceCheck.payload.compliant;
}
```

---

## 📋 **Detailed Migration Plan**

### **Week 1: Core Business Services Migration**

#### **Day 1-2: Document Processing Services**
**Target Services:**
- `document-assembler-service.js` → `DocumentAssemblerAgent`
- `template-generation-service.js` → `TemplateGenerationAgent`
- `intelligent-template-selector.js` → `IntelligentTemplateSelectorAgent`

**Migration Tasks:**
1. Create agent class extending `UnifiedAgent`
2. Migrate constructor and initialization logic
3. Convert main methods to `_executeImpl` pattern
4. Implement proper error handling and logging
5. Add capability declarations and dependencies
6. Test agent registration and basic functionality

#### **Day 3-4: Orchestration Services**
**Target Services:**
- `deep-agent-procurement-orchestrator.js` → `ProcurementOrchestratorAgent`
- `parallel-specialist-coordinator.js` → `ParallelSpecialistCoordinatorAgent`

**Migration Tasks:**
1. Convert supervisor/agent coordination to framework hierarchy
2. Implement progress reporting and status updates
3. Add workflow state management
4. Migrate communication patterns to framework messaging
5. Test multi-agent coordination scenarios

#### **Day 5: AI Integration Services**
**Target Services:**
- `langchainDocumentChatService.js` → `DocumentChatAgent`
- `langchainProcessingService.js` → `LangchainProcessingAgent`

**Migration Tasks:**
1. Preserve AI/ML integration logic
2. Add model configuration management
3. Implement performance monitoring for AI operations
4. Add error recovery for AI service failures

### **Week 2: Supporting Services & Testing**

#### **Day 6-8: Business Logic Services**
**Target Services:**
- `order-template-derivation-service.js` → `OrderDerivationAgent`
- `questionnaire-config-service.cjs` → `QuestionnaireConfigAgent`
- `questionnaire-template-service.cjs` → `QuestionnaireTemplateAgent`
- `template-hierarchy-service.js` → `TemplateHierarchyAgent`
- `template-manipulation-service.js` → `TemplateManipulationAgent`

**Migration Tasks:**
1. Convert CRUD operations to agent actions
2. Add data validation and business rules
3. Implement audit logging for business operations
4. Add performance monitoring for database operations

#### **Day 9-10: Infrastructure Services**
**Target Services:**
- `performance-monitoring-service.js` → `PerformanceMonitoringAgent`
- `feature-flag-service.js` → `FeatureFlagAgent`
- `field-attribute-compliance-service.js` → `ComplianceAgent`
- `protection-system-integration-service.js` → `ProtectionSystemAgent`
- `agent-registry-service.js` → `RegistryAgent`

**Migration Tasks:**
1. Convert system-level operations to agent capabilities
2. Add administrative access controls
3. Implement system health monitoring
4. Add alerting and notification capabilities

#### **Day 11-12: Utility Services & Integration Testing**
**Target Services:**
- `emailSendService.js` → `EmailAgent`
- `excelLoaderService.js` → `ExcelProcessingAgent`
- `form-generation-service.js` → `FormGenerationAgent`
- `flowiseService.js` → `FlowiseIntegrationAgent`
- `documensoDeploy.js` → `DocumensoAgent`
- `database-template-service.js` → `DatabaseTemplateAgent`
- `mock-prompts-service.js` → `MockPromptsAgent`

**Migration Tasks:**
1. Convert utility functions to agent actions
2. Add configuration management for external services
3. Implement proper error handling and retries
4. Add monitoring for external service integrations

#### **Day 13-14: System Integration Testing**
**Testing Tasks:**
1. End-to-end workflow testing with migrated agents
2. Cross-agent communication validation
3. Performance benchmarking against original services
4. Failover and error recovery testing
5. Load testing with multiple concurrent operations

---

## 🧪 **Testing & Validation Strategy**

### **Migration Testing Framework**
```javascript
class MigrationTestSuite {
  constructor(originalService, migratedAgent) {
    this.original = originalService;
    this.migrated = migratedAgent;
    this.testResults = [];
  }

  async runComprehensiveTests() {
    console.log(`🧪 Running comprehensive migration tests for ${this.migrated.agentId}`);

    // Functional parity tests
    await this.testFunctionalParity();

    // Performance tests
    await this.testPerformanceParity();

    // Error handling tests
    await this.testErrorHandling();

    // Integration tests
    await this.testAgentIntegration();

    return this.generateTestReport();
  }

  async testFunctionalParity() {
    console.log('Testing functional parity...');

    // Test cases covering all original service functionality
    const testCases = this.generateTestCases();

    for (const testCase of testCases) {
      const originalResult = await this.original[testCase.method](...testCase.args);
      const migratedResult = await this.migrated.execute({
        action: testCase.action,
        ...testCase.workflowState
      }, testCase.options);

      const parity = this.compareResults(originalResult, migratedResult.result);
      this.recordTestResult('functional_parity', testCase, parity);
    }
  }

  async testPerformanceParity() {
    console.log('Testing performance parity...');

    const performanceTests = [
      { name: 'simple_operation', iterations: 100 },
      { name: 'complex_operation', iterations: 50 },
      { name: 'concurrent_operations', iterations: 25, concurrency: 5 }
    ];

    for (const test of performanceTests) {
      const originalMetrics = await this.benchmarkService(this.original, test);
      const migratedMetrics = await this.benchmarkAgent(this.migrated, test);

      const performanceParity = this.comparePerformance(originalMetrics, migratedMetrics);
      this.recordTestResult('performance', test, performanceParity);
    }
  }

  async testErrorHandling() {
    console.log('Testing error handling...');

    const errorScenarios = [
      { name: 'invalid_input', input: null, expectedError: 'ValidationError' },
      { name: 'network_failure', simulateNetworkFailure: true, expectedError: 'CommunicationError' },
      { name: 'resource_exhaustion', simulateHighLoad: true, expectedError: 'TimeoutError' }
    ];

    for (const scenario of errorScenarios) {
      try {
        await this.migrated.execute(scenario.workflowState, scenario.options);
        this.recordTestResult('error_handling', scenario, false, 'Expected error not thrown');
      } catch (error) {
        const correctErrorType = error.code === scenario.expectedError;
        this.recordTestResult('error_handling', scenario, correctErrorType, error.message);
      }
    }
  }

  async testAgentIntegration() {
    console.log('Testing agent integration...');

    // Test agent registration
    const registrationSuccess = await this.testAgentRegistration();
    this.recordTestResult('integration', 'registration', registrationSuccess);

    // Test agent discovery
    const discoverySuccess = await this.testAgentDiscovery();
    this.recordTestResult('integration', 'discovery', discoverySuccess);

    // Test cross-agent communication
    const communicationSuccess = await this.testCrossAgentCommunication();
    this.recordTestResult('integration', 'communication', communicationSuccess);
  }

  recordTestResult(category, testCase, success, details = null) {
    this.testResults.push({
      category,
      testCase: testCase.name || testCase,
      success,
      details,
      timestamp: new Date().toISOString()
    });
  }

  generateTestReport() {
    const summary = {
      totalTests: this.testResults.length,
      passedTests: this.testResults.filter(r => r.success).length,
      failedTests: this.testResults.filter(r => !r.success).length,
      successRate: 0,
      categoryBreakdown: {},
      recommendations: []
    };

    summary.successRate = (summary.passedTests / summary.totalTests) * 100;

    // Category breakdown
    this.testResults.forEach(result => {
      if (!summary.categoryBreakdown[result.category]) {
        summary.categoryBreakdown[result.category] = { total: 0, passed: 0 };
      }
      summary.categoryBreakdown[result.category].total++;
      if (result.success) {
        summary.categoryBreakdown[result.category].passed++;
      }
    });

    // Generate recommendations
    if (summary.successRate < 95) {
      summary.recommendations.push('Migration requires additional testing and fixes');
    }

    const failedTests = this.testResults.filter(r => !r.success);
    if (failedTests.length > 0) {
      summary.recommendations.push(`${failedTests.length} test failures require investigation`);
    }

    return summary;
  }
}
```

### **Automated Testing Pipeline**
```yaml
# GitHub Actions: Migration Testing
name: Migration Testing Pipeline

on:
  push:
    branches: [ migration/* ]
  pull_request:
    branches: [ main ]

jobs:
  migration-test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        service: [
          document-assembler-service,
          intelligent-template-selector,
          procurement-orchestrator,
          # ... all 29 services
        ]

    steps:
    - uses: actions/checkout@v3

    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18.x'

    - name: Install dependencies
      run: npm ci

    - name: Run original service tests
      run: npm run test:service -- ${{ matrix.service }}
      id: original-tests

    - name: Run migrated agent tests
      run: npm run test:agent -- ${{ matrix.service }}
      id: migrated-tests

    - name: Run integration tests
      run: npm run test:integration -- ${{ matrix.service }}
      id: integration-tests

    - name: Generate migration report
      run: |
        node scripts/generate-migration-report.js \
          --service ${{ matrix.service }} \
          --original-results ${{ steps.original-tests.outputs.results }} \
          --migrated-results ${{ steps.migrated-tests.outputs.results }} \
          --integration-results ${{ steps.integration-tests.outputs.results }}

    - name: Upload test results
      uses: actions/upload-artifact@v3
      with:
        name: migration-test-results-${{ matrix.service }}
        path: test-results/
```

---

## 📊 **Risk Mitigation & Rollback Strategy**

### **Migration Risk Assessment**

#### **High-Risk Areas**
1. **Business-Critical Services**: Document assembler, template selector
2. **Complex Dependencies**: Services with multiple interdependencies
3. **Performance-Critical**: AI processing and real-time operations

#### **Risk Mitigation Strategies**
- **Parallel Operation**: Run old and new implementations simultaneously
- **Gradual Rollout**: Migrate services in functional groups, not individually
- **Feature Flags**: Ability to switch between old and new implementations
- **Comprehensive Testing**: Automated test suite covering all scenarios

### **Rollback Procedures**

#### **Immediate Rollback (Service Level)**
```javascript
// Feature flag controlled rollback
const USE_MIGRATED_AGENTS = process.env.USE_MIGRATED_AGENTS === 'true';

// Service instantiation with fallback
function createDocumentAssembler() {
  if (USE_MIGRATED_AGENTS) {
    try {
      return new DocumentAssemblerAgent(config);
    } catch (error) {
      console.warn('Failed to create migrated agent, falling back to original service');
      return new DocumentAssemblerService();
    }
  } else {
    return new DocumentAssemblerService();
  }
}
```

#### **Full Environment Rollback**
```bash
# Rollback script
#!/bin/bash

echo "Starting migration rollback..."

# Disable migrated agents
kubectl set env deployment/agent-orchestrator USE_MIGRATED_AGENTS=false

# Restart services to pick up new configuration
kubectl rollout restart deployment/agent-orchestrator

# Verify rollback success
curl -f http://localhost:3001/health || exit 1

echo "Rollback completed successfully"
```

### **Monitoring & Alerting During Migration**
```javascript
class MigrationMonitor {
  constructor() {
    this.alerts = [];
    this.metrics = new Map();
  }

  async monitorMigration() {
    // Track key migration metrics
    const metrics = {
      activeOriginalServices: await this.countActiveOriginalServices(),
      activeMigratedAgents: await this.countActiveMigratedAgents(),
      errorRate: await this.calculateErrorRate(),
      performanceDegradation: await this.checkPerformanceDegradation()
    };

    // Alert on issues
    if (metrics.errorRate > 0.05) {
      await this.sendAlert('High error rate detected during migration');
    }

    if (metrics.performanceDegradation > 0.20) {
      await this.sendAlert('Significant performance degradation detected');
    }

    this.metrics.set(new Date().toISOString(), metrics);
  }

  async sendAlert(message) {
    // Send alert to monitoring system
    console.error(`🚨 MIGRATION ALERT: ${message}`);

    // Could integrate with Slack, PagerDuty, etc.
    // await notificationService.sendAlert(message);
  }
}
```

---

## 📈 **Success Metrics & Validation**

### **Migration Success Criteria**
- ✅ **Functional Parity**: 100% of original functionality preserved
- ✅ **Performance**: No degradation >5% in response times
- ✅ **Reliability**: Error rates remain <1% during migration
- ✅ **Zero Downtime**: Business operations continue uninterrupted
- ✅ **Test Coverage**: 95%+ automated test coverage for migrated agents

### **Business Impact Validation**
- **Maintenance Reduction**: 60% reduction in service maintenance overhead
- **Development Velocity**: 50% faster feature development in new agents
- **Operational Efficiency**: Improved monitoring and troubleshooting
- **Scalability**: Better resource utilization and load balancing

### **Post-Migration Validation**
```javascript
class MigrationValidator {
  async validateMigration() {
    const validationResults = {
      functionalTests: await this.runFunctionalTests(),
      performanceTests: await this.runPerformanceTests(),
      integrationTests: await this.runIntegrationTests(),
      businessMetrics: await this.checkBusinessMetrics()
    };

    const overallSuccess = this.calculateOverallSuccess(validationResults);

    if (overallSuccess >= 0.95) {
      console.log('✅ Migration validation PASSED');
      return true;
    } else {
      console.log('❌ Migration validation FAILED');
      console.log('Detailed results:', validationResults);
      return false;
    }
  }

  calculateOverallSuccess(results) {
    const weights = {
      functionalTests: 0.4,
      performanceTests: 0.3,
      integrationTests: 0.2,
      businessMetrics: 0.1
    };

    let totalScore = 0;
    for (const [category, score] of Object.entries(results)) {
      totalScore += score * weights[category];
    }

    return totalScore;
  }
}
```

---

## 🎯 **Next Steps & Timeline**

### **Immediate Actions (Next 24 Hours)**
1. **Create Migration Testing Framework** - Set up automated testing infrastructure
2. **Select Pilot Services** - Choose 2-3 low-risk services for initial migration
3. **Establish Parallel Operation** - Configure environment for side-by-side operation
4. **Team Training** - Brief development team on migration process

### **Week 1 Execution Plan**
- **Day 1**: Migrate `mock-prompts-service.js` (pilot - low risk)
- **Day 2**: Migrate `database-template-service.js` (simple CRUD operations)
- **Day 3**: Migrate `emailSendService.js` (utility service)
- **Day 4**: Testing and validation of initial migrations
- **Day 5**: Migrate `feature-flag-service.js` and `performance-monitoring-service.js`

### **Week 2 Execution Plan**
- **Day 6-8**: Migrate core business services (`template-generation-service.js`, `order-template-derivation-service.js`)
- **Day 9-10**: Migrate AI services (`langchainDocumentChatService.js`, `langchainProcessingService.js`)
- **Day 11-12**: Migrate coordination services (`parallel-specialist-coordinator.js`)
- **Day 13-14**: Final integration testing and performance validation

### **Go-Live Readiness**
- **Week 2 End**: Complete migration of all 29 services
- **Feature Flags**: All services running in parallel with rollback capability
- **Performance Baseline**: Establish performance benchmarks for comparison
- **Monitoring**: Comprehensive monitoring and alerting in place

---

*This SYS_002 Migration Plan provides a comprehensive roadmap for transforming 29 scattered JavaScript services into unified agents. The phased approach ensures minimal business disruption while delivering the architectural benefits of the unified framework. Successful execution will reduce maintenance overhead by 60% while enabling cross-language agent communication and coordination.*

**🎯 PHASE 2 HIGH PRIORITY CONSOLIDATION READY FOR EXECUTION**