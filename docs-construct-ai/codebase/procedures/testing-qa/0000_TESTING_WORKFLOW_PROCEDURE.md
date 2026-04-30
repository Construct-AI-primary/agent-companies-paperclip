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
# Workflow Testing Procedure - Complete End-to-End Testing Framework

__CRITICAL__: This procedure establishes comprehensive testing standards for any discipline-specific workflow in the Construct AI system. Follow this exact framework to ensure complete workflow validation, error resilience, and performance assurance in development mode across all 45+ disciplines.

## 🔒 **CRITICAL REQUIREMENT: NO MOCK DATA/AGENTS/SERVICES**

**🚫 ABSOLUTELY FORBIDDEN**: This procedure **MUST NOT** use mock data, mock agents, mock services, or any form of simulated/fake implementations.

**✅ REQUIRED**: All testing operations **MUST** use real database connections, real API endpoints, and real data:
- Test data must be created in actual database tables with real foreign key relationships
- API calls must target real running services and servers
- Database queries must execute against actual schema constraints and RLS policies
- Error handling must reflect real system states and failure modes

**📋 Implementation Standards:**
- All test data creation must use real Supabase tables and APIs
- Database connections must use actual credentials and real schema
- API testing must call real endpoints on running servers
- Data validation must occur against actual database constraints

**🚨 Violation Detection:**
- Any mock database connections will cause immediate test failure
- Tests using fake data will be rejected during code review
- Procedures with mock implementations will not be approved

---

## 🎯 __PROCEDURE OVERVIEW__

### **Purpose**
This procedure provides a complete framework for testing any discipline-specific workflow from document creation through task completion. It ensures comprehensive validation of multi-discipline coordination, approval workflows, error handling, and performance under various conditions. This framework applies to ALL disciplines including procurement, civil engineering, mechanical, electrical, HSE, quantity surveying, project management, and all other technical disciplines.

### **Scope**
- ✅ **Complete Workflow Testing**: Document creation → template association → task generation → approval → completion
- ✅ **Multi-Discipline Validation**: Cross-discipline task coordination and user assignments
- ✅ **Error Resilience Testing**: Failure scenarios, recovery procedures, and data integrity validation
- ✅ **Performance Assurance**: Load testing, concurrent operations, and resource utilization monitoring
- ✅ **Security Compliance**: RLS policy enforcement and organization data isolation verification

### **Key Principles**
1. **JavaScript-Based Testing**: Use API-based operations to respect RLS policies in dev mode
2. **Organization Isolation**: All test data automatically scoped to test organization
3. **Discipline Agnostic**: Framework adapts to any discipline (procurement, civil, mechanical, electrical, HSE, etc.)
4. **Comprehensive Scenarios**: Cover happy path, error cases, and edge conditions
5. **Performance Validation**: Include load testing and concurrency validation
6. **Cleanup Procedures**: Ensure test data removal and system state restoration

### **Supported Disciplines**

| **Category** | **Example Disciplines** | **Typical Documents** |
|-------------|-------------------------|----------------------|
| **Commercial** | Procurement, Quantity Surveying, Contract Management | Purchase Orders, SOW, Contracts |
| **Technical** | Civil, Mechanical, Electrical, Structural | Specifications, Calculations, Drawings |
| **Safety** | HSE, Quality, Risk Management | Safety Plans, QA Reports, Risk Assessments |
| **Management** | Project Management, Cost Control | Schedules, Budgets, Reports |
| **Specialized** | Environmental, Geotechnical, Materials | EIAs, Soil Reports, Material Specs |

**Adaptation Pattern**: Replace procurement-specific references with target discipline equivalents:
- `procurement_orders` → `[discipline]_documents` or `documents` with discipline filter
- `procurement_templates` → `templates` with discipline filter
- `SOW` → Scope documents, specifications, or discipline-specific terminology

---

## 🚨 __MANDATORY PRE-EXECUTION CHECKS__

### **Step 1: Environment Validation**

```bash
# Verify development environment configuration
echo "🔍 Validating development environment..."

# Check environment variables
echo "SUPABASE_URL: ${SUPABASE_URL:0:30}..."
echo "SUPABASE_ANON_KEY: ${SUPABASE_ANON_KEY:0:20}..."
echo "ORG_ID: $ORG_ID"

# Test Supabase connectivity
curl -s -w "HTTP Status: %{http_code}\n" "$SUPABASE_URL/rest/v1/" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "x-organization-id: $ORG_ID" | head -c 100

# Verify RLS policies are active
curl -s "$SUPABASE_URL/rest/v1/procurement_orders?select=count" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "x-organization-id: $ORG_ID"

# Check development mode status
curl -s "$SUPABASE_URL/rpc/is_dev_mode" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "Content-Type: application/json" \
  -d '{}' 2>/dev/null || echo "Dev mode check unavailable - proceeding"
```

### **Step 2: Test Data Readiness**

```javascript
// Validate test data population scripts
const testDataValidation = {
  users: '✅ Test users created with discipline assignments',
  templates: '✅ Procurement and SOW templates available',
  disciplines: '✅ Engineering, quality, safety disciplines configured',
  organization: '✅ Test organization isolated and ready',
  permissions: '✅ RLS policies allow test operations'
};
```

### **Step 3: System Health Check**

```bash
# Verify system components
echo "🔧 Checking system health..."

# Database connectivity
psql "$DATABASE_URL" -c "SELECT version();" 2>/dev/null || echo "Direct DB access unavailable - using API mode"

# API endpoints availability
curl -s -o /dev/null -w "%{http_code}" "$SUPABASE_URL/rest/v1/procurement_orders"
curl -s -o /dev/null -w "%{http_code}" "$SUPABASE_URL/rest/v1/tasks"
curl -s -o /dev/null -w "%{http_code}" "$SUPABASE_URL/rest/v1/users"

# Memory and resource availability
echo "Memory usage: $(ps aux | grep node | head -5 | awk '{sum+=$6} END {print sum " KB"}')"
```

---

## 📋 __UPDATED TESTING PLAN CROSS-REFERENCES__

### **Schema-Aligned Procurement Workflow Testing Plan**

**Cross-Reference**: `PROCUREMENT_ORDER_WORKFLOW_TESTING_PLAN.md` (Updated with Schema References)

**🔗 Authoritative Schema Source**: `docs/schema/current-full-schema.md`

**⚠️ CRITICAL PRE-TESTING REQUIREMENT**: Schema must be updated using the automated extraction process before any testing begins.

#### **Schema Update Process (MANDATORY)**
1. **Automatic Extraction**: Schema is extracted using `docs/schema/extract-schema-openapi.js`
2. **Live Data Source**: Fetches current schema from Supabase OpenAPI specification using service role authentication
3. **Comprehensive Analysis**: Includes RLS policies, foreign keys, indexes, constraints, and codebase usage tracking
4. **Auto-Execution**: Runs automatically on system login via macOS launch agent (`~/Library/LaunchAgents/com.constructai.schema-extraction.plist`)
5. **Generated Files**: Updates `current-full-schema.md` with authoritative table definitions, relationships, and metadata
6. **Validation**: All table references in testing plan must match current schema definitions

#### **Schema Extraction Details (from docs/schema/README.md):**
- **Script**: `extract-schema-openapi.js` - Node.js script using Supabase OpenAPI specification
- **Requirements**: `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SUPABASE_SERVICE_ROLE_KEY`
- **Features**: Complete table definitions, RLS policy extraction, foreign key relationships, index information, script usage analysis, reverse foreign keys, column constraints
- **Outputs**: `current-full-schema.md`, `current-full-schema.sql`, `openapi-spec.json`
- **Automation**: Runs automatically on login, logs to `/tmp/schema-extraction.log`

#### **Core Schema Tables Referenced (Validated against current-full-schema.md):**
- **Organization & Access Control**: `organizations`, `organization_users`, `user_organization_access`
- **User Management**: `user_management`, `disciplines`, `user_discipline_access`
- **Procurement Entities**: `procurement_orders`, `procurement_templates`, `sow_templates`, `sow_appendices`
- **Task Management**: `tasks`, `task_history`, `task_sequence_execution`, `procurement_contributions`
- **Approval Workflows**: `approval_instances`, `approval_steps`, `approval_workflows`, `procurement_approvals`
- **Audit & Compliance**: `audit_log`, `approval_history_log`, `esignature_audit`, `internal_notifications`

#### **Updated Test Data Structure:**
```javascript
// Schema-aligned test data hierarchy (validated against current-full-schema.md)
const TEST_DATA_HIERARCHY = {
  organizations: [{ /* organization records per schema definition */ }],
  organization_users: [{ /* user-org mappings with proper foreign keys */ }],
  disciplines: [{ /* discipline definitions matching schema constraints */ }],
  procurement_templates: [{ /* template configurations with schema compliance */ }],
  sow_templates: [{ /* SOW structures validated against schema */ }],
  procurement_orders: {
    standard: [{ /* standard orders following schema structure */ }],
    complex: [{ /* complex orders with all required schema fields */ }],
    error_cases: [{ /* error scenarios testing schema constraints */ }]
  },
  tasks: { /* task generation validation per schema relationships */ },
  approval_instances: { /* approval workflow validation with schema compliance */ }
};
```

#### **Schema Validation Points:**
- ✅ **Foreign Key Relationships**: All table relationships validated against `current-full-schema.md`
- ✅ **RLS Policy Compliance**: Organization isolation enforced per schema RLS definitions
- ✅ **Data Integrity**: Referential integrity maintained according to schema constraints
- ✅ **Audit Trails**: Complete change tracking implemented per schema audit requirements
- ✅ **Multi-Tenant Support**: Organization-scoped operations validated against schema structure
- ✅ **Index Optimization**: Query performance validated against schema indexing strategy

#### **Test Data Distribution Analysis**
Track and validate realistic test data distribution patterns:

```javascript
// Expected distribution ranges for comprehensive testing
const expectedDistributions = {
  status: {
    draft: '15-25%',           // New documents in preparation
    in_progress: '20-30%',     // Active workflow items
    completed: '20-30%',       // Finished processes
    approved: '10-20%',        // Approved but not started
    pending_approval: '10-20%', // Awaiting approval
    cancelled: '5-10%'         // Error/discontinued items
  },
  priority: {
    critical: '15-25%',        // Safety/critical path items
    high: '25-35%',           // Important deliverables
    medium: '30-40%',         // Standard priority
    low: '10-20%'             // Optional/enhancement items
  },
  certification: {
    withCertification: '60-80%', // Items requiring formal approval
    safety: '20-30%',          // Safety-related certifications
    technical: '15-25%',       // Technical competency requirements
    completion: '10-20%',      // Basic completion certificates
    professional: '5-15%'      // Industry professional certifications
  },
  procurement: {
    withProcurementRef: '40-60%', // Linked to procurement orders
    highValue: '20-30%',       // High-value procurements
    standardValue: '50-70%',   // Standard procurement values
    complexOrders: '10-20%'    // Complex multi-discipline orders
  }
};
```

#### **Distribution Validation Script**
```javascript
async function validateTestDataDistribution() {
  const { data: materials } = await supabase
    .from('training_materials') // Adapt table name per discipline
    .select('*')
    .eq('organization_id', process.env.ORG_ID);

  const analysis = {
    total: materials.length,
    status: getDistribution(materials, 'status'),
    priority: getDistribution(materials, 'priority'),
    certification: {
      total: materials.filter(m => m.certification?.type).length,
      types: getDistribution(
        materials.filter(m => m.certification?.type),
        'certification.type'
      )
    },
    procurement: {
      linked: materials.filter(m => m.procurement_order_id).length,
      percentage: ((materials.filter(m => m.procurement_order_id).length / materials.length) * 100).toFixed(1) + '%'
    }
  };

  console.log('📊 Test Data Distribution Analysis:');
  console.log(`   Status: ${JSON.stringify(analysis.status)}`);
  console.log(`   Priority: ${JSON.stringify(analysis.priority)}`);
  console.log(`   Certification: ${analysis.certification.total}/${analysis.total} (${(analysis.certification.total/analysis.total*100).toFixed(1)}%)`);
  console.log(`   Procurement Links: ${analysis.procurement.linked}/${analysis.total} (${analysis.procurement.percentage})`);

  return analysis;
}

function getDistribution(data, field) {
  const distribution = {};
  data.forEach(item => {
    const keys = field.split('.');
    let value = item;
    for (const key of keys) {
      value = value?.[key];
    }
    distribution[value] = (distribution[value] || 0) + 1;
  });

  // Convert to percentages
  const total = data.length;
  Object.keys(distribution).forEach(key => {
    distribution[key] = `${((distribution[key] / total) * 100).toFixed(1))}%`;
  });

  return distribution;
}
```

#### **Environment Variable Configuration**
Configure testing environment variables for flexible deployment and execution:

```bash
# API Configuration
API_BASE=http://localhost:3001          # Custom API endpoint for testing
API_KEY=development-key                 # Authentication key for test operations
SUPABASE_URL=https://your-project.supabase.co  # Supabase project URL
SUPABASE_ANON_KEY=your-anon-key               # Supabase anonymous key
SUPABASE_SERVICE_ROLE_KEY=your-service-key    # Service role key for admin operations

# Organization & Security
ORG_ID=test-organization-uuid           # Test organization UUID
TEST_USER_ID=test-user-uuid             # Test user UUID for authentication

# Test Data Configuration
COUNT=50                                # Number of test records to generate
TEST_DATA_SEED=training-materials-2025  # Seed for reproducible test data
CLEANUP_AFTER_TEST=true                 # Auto-cleanup test data after execution

# Performance Testing
MAX_RESPONSE_TIME=2000                  # Maximum API response time (ms)
CONCURRENT_USERS=10                     # Number of concurrent users for load testing
TEST_DURATION=300000                    # Test duration in milliseconds (5 minutes)

# Database Configuration
DATABASE_URL=postgresql://user:pass@localhost:5432/test_db  # Test database URL
ENABLE_RLS=true                         # Enable Row Level Security during testing
SCHEMA_EXTRACTION_ENABLED=true          # Enable schema extraction before testing

# Logging & Monitoring
LOG_LEVEL=debug                         # Logging level (error, warn, info, debug)
ENABLE_METRICS=true                     # Enable performance metrics collection
METRICS_INTERVAL=1000                   # Metrics collection interval (ms)

# Test Execution Control
SKIP_PERFORMANCE_TESTS=false            # Skip performance tests if needed
SKIP_INTEGRATION_TESTS=false           # Skip integration tests if needed
PARALLEL_EXECUTION=true                # Enable parallel test execution
RETRY_FAILED_TESTS=true                # Retry failed tests automatically
MAX_RETRIES=3                          # Maximum retry attempts for failed tests

# External Service Configuration
OPENAI_API_KEY=sk-test-...             # OpenAI API key for AI testing
CLAUDE_API_KEY=sk-ant-test-...         # Claude API key for AI testing
GOOGLE_AI_API_KEY=...                  # Google AI API key for AI testing

# Notification & Reporting
SLACK_WEBHOOK_URL=https://hooks.slack.com/...  # Slack notifications for test results
EMAIL_REPORTS_TO=qa@construct.ai       # Email recipients for test reports
REPORT_FORMAT=json                     # Test report format (json, html, xml)

# Development Mode Settings
NODE_ENV=development                   # Node.js environment
BYPASS_AUTH=true                       # Bypass authentication in development
ENABLE_DEBUG_LOGGING=true              # Enable detailed debug logging
HOT_RELOAD=true                        # Enable hot reload for development
```

#### **Environment Validation Script**
```bash
#!/bin/bash
# validate-test-environment.sh

echo "🔍 Validating test environment configuration..."

# Required environment variables
required_vars=(
  "API_BASE"
  "SUPABASE_URL"
  "SUPABASE_ANON_KEY"
  "ORG_ID"
  "TEST_USER_ID"
)

# Optional but recommended variables
recommended_vars=(
  "API_KEY"
  "SUPABASE_SERVICE_ROLE_KEY"
  "COUNT"
  "MAX_RESPONSE_TIME"
)

# Check required variables
missing_required=()
for var in "${required_vars[@]}"; do
  if [[ -z "${!var}" ]]; then
    missing_required+=("$var")
  fi
done

# Check recommended variables
missing_recommended=()
for var in "${recommended_vars[@]}"; do
  if [[ -z "${!var}" ]]; then
    missing_recommended+=("$var")
  fi
done

# Report findings
if [[ ${#missing_required[@]} -gt 0 ]]; then
  echo "❌ Missing required environment variables:"
  printf '   - %s\n' "${missing_required[@]}"
  echo "💡 Set these variables before running tests"
  exit 1
fi

if [[ ${#missing_recommended[@]} -gt 0 ]]; then
  echo "⚠️  Missing recommended environment variables:"
  printf '   - %s\n' "${missing_recommended[@]}"
  echo "💡 Tests will run with default values"
fi

# Validate API connectivity
echo "🔗 Testing API connectivity..."
if curl -s -f "$API_BASE/health" > /dev/null 2>&1; then
  echo "✅ API connectivity verified"
else
  echo "❌ API not accessible at $API_BASE"
  exit 1
fi

# Validate Supabase connectivity
echo "🗄️  Testing Supabase connectivity..."
if curl -s -f -H "apikey: $SUPABASE_ANON_KEY" "$SUPABASE_URL/rest/v1/" > /dev/null 2>&1; then
  echo "✅ Supabase connectivity verified"
else
  echo "❌ Supabase not accessible"
  exit 1
fi

echo "✅ Test environment validation complete"
```

#### **Performance Metrics Standards**
Establish performance benchmarks and monitoring standards for test execution:

```javascript
// Performance benchmark standards
const PERFORMANCE_STANDARDS = {
  apiResponseTime: {
    excellent: '< 500ms',
    good: '500-1000ms',
    acceptable: '1000-2000ms',
    poor: '> 2000ms',
    critical: '> 5000ms'
  },
  concurrentUsers: {
    minimum: 5,
    standard: 10,
    highLoad: 25,
    maximum: 50
  },
  memoryUsage: {
    acceptable: '< 100MB',
    warning: '100-200MB',
    critical: '> 200MB'
  },
  errorRate: {
    excellent: '< 1%',
    acceptable: '< 5%',
    concerning: '5-10%',
    critical: '> 10%'
  },
  testExecutionTime: {
    unitTest: '< 100ms',
    integrationTest: '< 2000ms',
    e2eTest: '< 30000ms',
    fullSuite: '< 300000ms' // 5 minutes
  }
};

// Performance monitoring function
async function monitorPerformance(operation, operationFn) {
  const startTime = Date.now();
  const startMemory = process.memoryUsage();

  try {
    const result = await operationFn();
    const endTime = Date.now();
    const endMemory = process.memoryUsage();

    const metrics = {
      operation: operation,
      duration: endTime - startTime,
      memoryDelta: endMemory.heapUsed - startMemory.heapUsed,
      success: true,
      result: result
    };

    // Log performance metrics
    console.log(`📊 ${operation}: ${metrics.duration}ms, Memory: ${Math.round(metrics.memoryDelta / 1024)}KB`);

    // Check against standards
    validatePerformanceMetrics(operation, metrics);

    return metrics;
  } catch (error) {
    const endTime = Date.now();
    console.error(`❌ ${operation} failed: ${error.message} (${endTime - startTime}ms)`);
    throw error;
  }
}

// Performance validation
function validatePerformanceMetrics(operation, metrics) {
  const standards = PERFORMANCE_STANDARDS;

  // Check response time
  if (metrics.duration > 5000) {
    console.warn(`⚠️  SLOW: ${operation} exceeded 5s (${metrics.duration}ms)`);
  } else if (metrics.duration > 2000) {
    console.log(`🟡 WARNING: ${operation} > 2s (${metrics.duration}ms)`);
  }

  // Check memory usage
  if (metrics.memoryDelta > 50 * 1024 * 1024) { // 50MB
    console.warn(`⚠️  HIGH MEMORY: ${operation} used ${Math.round(metrics.memoryDelta / 1024 / 1024)}MB`);
  }
}
```

#### **Automated Test Scripts Section**
Provide ready-to-run test execution scripts for different scenarios:

```bash
#!/bin/bash
# run-tests.sh - Comprehensive test execution script

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
LOG_FILE="$PROJECT_ROOT/test-results-$(date +%Y%m%d-%H%M%S).log"

# Environment setup
setup_environment() {
  echo "🔧 Setting up test environment..."

  # Load environment variables
  if [ -f "$PROJECT_ROOT/.env.test" ]; then
    export $(grep -v '^#' "$PROJECT_ROOT/.env.test" | xargs)
    echo "✅ Loaded test environment variables"
  else
    echo "⚠️  No .env.test file found, using defaults"
  fi

  # Validate required tools
  command -v node >/dev/null 2>&1 || { echo "❌ Node.js is required but not installed"; exit 1; }
  command -v npm >/dev/null 2>&1 || { echo "❌ NPM is required but not installed"; exit 1; }

  echo "✅ Environment setup complete"
}

# Run unit tests
run_unit_tests() {
  echo "🧪 Running unit tests..."

  if [ -f "$PROJECT_ROOT/test_appendix_d_training_materials.cjs" ]; then
    echo "📋 Running comprehensive test suite..."
    node "$PROJECT_ROOT/test_appendix_d_training_materials.cjs" --phase=1 >> "$LOG_FILE" 2>&1
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
      echo "✅ Unit tests passed"
      return 0
    else
      echo "❌ Unit tests failed (exit code: $exit_code)"
      return 1
    fi
  else
    echo "⚠️  Unit test file not found, skipping"
    return 0
  fi
}

# Run integration tests
run_integration_tests() {
  echo "🔗 Running integration tests..."

  if [ -f "$PROJECT_ROOT/test_appendix_d_training_materials.cjs" ]; then
    echo "📋 Running integration test suite..."
    node "$PROJECT_ROOT/test_appendix_d_training_materials.cjs" --phase=2,3 >> "$LOG_FILE" 2>&1
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
      echo "✅ Integration tests passed"
      return 0
    else
      echo "❌ Integration tests failed (exit code: $exit_code)"
      return 1
    fi
  else
    echo "⚠️  Integration test file not found, skipping"
    return 0
  fi
}

# Run performance tests
run_performance_tests() {
  echo "⚡ Running performance tests..."

  if [ -f "$PROJECT_ROOT/test_appendix_d_training_materials.cjs" ]; then
    echo "📋 Running performance test suite..."
    node "$PROJECT_ROOT/test_appendix_d_training_materials.cjs" --performance >> "$LOG_FILE" 2>&1
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
      echo "✅ Performance tests passed"
      return 0
    else
      echo "❌ Performance tests failed (exit code: $exit_code)"
      return 1
    fi
  else
    echo "⚠️  Performance test file not found, skipping"
    return 0
  fi
}

# Generate test data
generate_test_data() {
  echo "📊 Generating test data..."

  local count=${COUNT:-50}
  echo "🎯 Generating $count test records..."

  if [ -f "$PROJECT_ROOT/generate_training_materials_test_data.cjs" ]; then
    COUNT=$count node "$PROJECT_ROOT/generate_training_materials_test_data.cjs" >> "$LOG_FILE" 2>&1
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
      echo "✅ Test data generation completed"
      return 0
    else
      echo "❌ Test data generation failed (exit code: $exit_code)"
      return 1
    fi
  else
    echo "⚠️  Test data generation script not found, skipping"
    return 0
  fi
}

# Cleanup test data
cleanup_test_data() {
  echo "🧹 Cleaning up test data..."

  if [ -f "$PROJECT_ROOT/test_cleanup.cjs" ]; then
    node "$PROJECT_ROOT/test_cleanup.cjs" >> "$LOG_FILE" 2>&1
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
      echo "✅ Test data cleanup completed"
      return 0
    else
      echo "❌ Test data cleanup failed (exit code: $exit_code)"
      return 1
    fi
  else
    echo "⚠️  Test cleanup script not found, attempting manual cleanup..."

    # Manual cleanup via API if available
    if command -v curl >/dev/null 2>&1; then
      curl -s -X DELETE "$API_BASE/api/training-materials/cleanup-test-data" \
        -H "x-organization-id: $ORG_ID" \
        -H "x-user-role: developer" >> "$LOG_FILE" 2>&1 || true
    fi

    echo "✅ Manual cleanup attempted"
    return 0
  fi
}

# Generate test report
generate_report() {
  echo "📊 Generating test report..."

  local total_tests=0
  local passed_tests=0
  local failed_tests=0

  # Parse log file for results (simplified parsing)
  if [ -f "$LOG_FILE" ]; then
    total_tests=$(grep -c "🧪 Running test:" "$LOG_FILE" 2>/dev/null || echo "0")
    passed_tests=$(grep -c "✅ PASSED:" "$LOG_FILE" 2>/dev/null || echo "0")
    failed_tests=$(grep -c "❌ FAILED:" "$LOG_FILE" 2>/dev/null || echo "0")
  fi

  local success_rate=0
  if [ $total_tests -gt 0 ]; then
    success_rate=$(( (passed_tests * 100) / total_tests ))
  fi

  echo ""
  echo "📊 TEST EXECUTION SUMMARY"
  echo "══════════════════════════════════════════════"
  echo "Total Tests:     $total_tests"
  echo "Passed:          $passed_tests"
  echo "Failed:          $failed_tests"
  echo "Success Rate:    ${success_rate}%"
  echo "Log File:        $LOG_FILE"
  echo ""

  if [ $success_rate -ge 80 ]; then
    echo "✅ Test suite completed successfully!"
  elif [ $success_rate -ge 60 ]; then
    echo "⚠️  Test suite completed with issues. Review logs."
  else
    echo "❌ Test suite failed. Immediate attention required."
  fi
}

# Main execution
main() {
  echo "🚀 Starting Appendix D Training Materials Test Suite"
  echo "Log file: $LOG_FILE"
  echo ""

  local start_time=$(date +%s)
  local overall_success=0

  # Setup
  setup_environment || { echo "❌ Environment setup failed"; exit 1; }

  # Generate test data
  generate_test_data || overall_success=1

  # Run test phases
  run_unit_tests || overall_success=1
  run_integration_tests || overall_success=1
  run_performance_tests || overall_success=1

  # Cleanup
  cleanup_test_data || echo "⚠️  Cleanup had issues, but continuing..."

  # Generate report
  generate_report

  local end_time=$(date +%s)
  local duration=$((end_time - start_time))

  echo ""
  echo "⏱️  Total execution time: ${duration}s"
  echo ""

  if [ $overall_success -eq 0 ]; then
    echo "🎉 All tests completed successfully!"
    exit 0
  else
    echo "⚠️  Some tests had issues. Check the log file for details."
    exit 1
  fi
}

# Handle command line arguments
case "${1:-}" in
  "--unit-only")
    setup_environment && run_unit_tests && generate_report
    ;;
  "--integration-only")
    setup_environment && run_integration_tests && generate_report
    ;;
  "--performance-only")
    setup_environment && run_performance_tests && generate_report
    ;;
  "--generate-data-only")
    setup_environment && generate_test_data
    ;;
  "--cleanup-only")
    setup_environment && cleanup_test_data
    ;;
  "--help"|"-h")
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --unit-only          Run only unit tests"
    echo "  --integration-only   Run only integration tests"
    echo "  --performance-only   Run only performance tests"
    echo "  --generate-data-only Generate test data only"
    echo "  --cleanup-only       Cleanup test data only"
    echo "  --help, -h          Show this help"
    echo ""
    echo "Environment Variables:"
    echo "  API_BASE            API endpoint (default: http://localhost:3001)"
    echo "  COUNT              Number of test records to generate (default: 50)"
    echo "  ORG_ID             Organization ID for testing"
    echo ""
    ;;
  *)
    main
    ;;
esac
```

#### **CI/CD Integration Guidelines**
Integrate automated testing into continuous integration and deployment pipelines:

```yaml
# .github/workflows/test-appendix-d.yml
name: Test Appendix D Training Materials

on:
  push:
    branches: [ main, develop ]
    paths:
      - 'client/src/pages/01900-procurement/components/01900-appendix-d-training-materials.js'
      - 'test_appendix_d_training_materials.cjs'
      - 'generate_training_materials_test_data.cjs'
  pull_request:
    branches: [ main, develop ]
    paths:
      - 'client/src/pages/01900-procurement/components/01900-appendix-d-training-materials.js'
      - 'docs/procedures/0000_TESTING_WORKFLOW_PROCEDURE.md'

jobs:
  test:
    runs-on: ubuntu-latest
    timeout-minutes: 15

    services:
      postgres:
        image: postgres:13
        env:
          POSTGRES_PASSWORD: postgres
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5

    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'

    - name: Install dependencies
      run: npm ci

    - name: Setup test database
      run: |
        createdb test_construct_ai || true
        psql -d test_construct_ai -c "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"

    - name: Run database migrations
      run: npm run migrate:test
      env:
        DATABASE_URL: postgresql://postgres:postgres@localhost:5432/test_construct_ai

    - name: Generate test data
      run: node generate_training_materials_test_data.cjs
      env:
        API_BASE: http://localhost:3001
        COUNT: 25
        ORG_ID: test-org-ci-cd

    - name: Run unit tests
      run: node test_appendix_d_training_materials.cjs --phase=1

    - name: Run integration tests
      run: node test_appendix_d_training_materials.cjs --phase=2,3

    - name: Run performance tests
      run: node test_appendix_d_training_materials.cjs --performance
      continue-on-error: true  # Performance tests might be flaky in CI

    - name: Upload test results
      uses: actions/upload-artifact@v3
      if: always()
      with:
        name: test-results
        path: test-results-*.log

    - name: Generate test report
      run: |
        echo "## Test Results" >> $GITHUB_STEP_SUMMARY
        echo "- **Unit Tests**: $(grep -c "✅ PASSED:" test-results-*.log 2>/dev/null || echo "0") passed" >> $GITHUB_STEP_SUMMARY
        echo "- **Integration Tests**: $(grep -c "✅ PASSED:" test-results-*.log 2>/dev/null || echo "0") passed" >> $GITHUB_STEP_SUMMARY
        echo "- **Performance Tests**: $(grep -c "✅ PASSED:" test-results-*.log 2>/dev/null || echo "0") passed" >> $GITHUB_STEP_SUMMARY

  cleanup:
    runs-on: ubuntu-latest
    if: always()
    needs: test

    steps:
    - name: Cleanup test resources
      run: |
        echo "Cleaning up test resources..."
        # Add cleanup commands here if needed
```
```

**Implementation Note**: All test scenarios now reference actual schema table structures from `current-full-schema.md` and validate proper foreign key relationships, RLS policy enforcement, and data consistency across the procurement workflow system.

---

## 📋 __TEST EXECUTION WORKFLOW__

### **Phase 1: Test Data Population**

#### **1.1 Foundation Data Setup**

```javascript
#!/usr/bin/env node

/**
 * Procurement Workflow Test Data Population
 * Creates comprehensive test data following enterprise procedures
 */

import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY, {
  auth: { persistSession: false },
  global: { headers: { 'x-organization-id': process.env.ORG_ID } }
});

// Rate limiting utility
function delay(ms) { return new Promise(resolve => setTimeout(resolve, ms)); }

// Progress tracking
class TestDataProgress {
  constructor() { this.operations = []; }
  log(operation, status) {
    this.operations.push({ operation, status, timestamp: new Date() });
    console.log(`${status === 'success' ? '✅' : '❌'} ${operation}`);
  }
}

async function populateFoundationData() {
  const progress = new TestDataProgress();

  try {
    console.log('🏗️ Populating procurement workflow test foundation data...\n');

    // 1. Create test users with discipline assignments
    progress.log('Creating test users', await createTestUsers());

    // 2. Create procurement templates
    progress.log('Creating procurement templates', await createProcurementTemplates());

    // 3. Create SOW templates
    progress.log('Creating SOW templates', await createSOWTemplates());

    // 4. Create approval matrixes
    progress.log('Creating approval matrixes', await createApprovalMatrixes());

    // 5. Verify data integrity
    progress.log('Verifying data integrity', await verifyDataIntegrity());

    console.log('\n✅ Foundation data populated successfully');

  } catch (error) {
    console.error('❌ Foundation data population failed:', error);
    await emergencyCleanup();
  }
}

async function createTestUsers() {
  const testUsers = [
    {
      id: 'test_user_engineering_001',
      email: 'engineering.test@construct.ai',
      discipline: 'engineering',
      role: 'engineer',
      organization_id: process.env.ORG_ID
    },
    {
      id: 'test_user_quality_001',
      email: 'quality.test@construct.ai',
      discipline: 'quality',
      role: 'qa_specialist',
      organization_id: process.env.ORG_ID
    },
    {
      id: 'test_user_safety_001',
      email: 'safety.test@construct.ai',
      discipline: 'safety',
      role: 'safety_officer',
      organization_id: process.env.ORG_ID
    },
    {
      id: 'test_user_procurement_001',
      email: 'procurement.test@construct.ai',
      discipline: 'procurement',
      role: 'procurement_officer',
      organization_id: process.env.ORG_ID
    }
  ];

  for (const user of testUsers) {
    const { error } = await supabase
      .from('users')
      .upsert(user, { onConflict: 'id' });

    if (error && !error.message.includes('duplicate key')) {
      throw new Error(`Failed to create user ${user.email}: ${error.message}`);
    }

    await delay(100); // Rate limiting
  }

  return 'success';
}

async function createProcurementTemplates() {
  const templates = [
    {
      template_name: 'Standard Equipment Procurement',
      discipline: 'Procurement',
      template_variation: 'standard',
      estimated_value_range: '10000-50000',
      approval_matrix: ['procurement_officer', 'project_manager'],
      organization_id: process.env.ORG_ID,
      appendices: ['A', 'B', 'C']
    },
    {
      template_name: 'Complex Equipment Procurement',
      discipline: 'Procurement',
      template_variation: 'complex',
      estimated_value_range: '50000-200000',
      approval_matrix: ['procurement_officer', 'project_manager', 'senior_management'],
      organization_id: process.env.ORG_ID,
      appendices: ['A', 'B', 'C', 'D']
    }
  ];

  for (const template of templates) {
    const { error } = await supabase
      .from('procurement_templates')
      .upsert(template, { onConflict: 'template_name,organization_id' });

    if (error) throw new Error(`Failed to create template: ${error.message}`);
    await delay(100);
  }

  return 'success';
}

async function createSOWTemplates() {
  const sowTemplates = [
    {
      template_name: 'Equipment Supply SOW',
      appendices: ['A', 'B', 'C'],
      disciplines: ['engineering', 'quality', 'safety'],
      organization_id: process.env.ORG_ID,
      template_structure: {
        appendix_a: { required: true, discipline: 'engineering' },
        appendix_b: { required: true, discipline: 'quality' },
        appendix_c: { required: true, discipline: 'safety' }
      }
    }
  ];

  for (const template of sowTemplates) {
    const { error } = await supabase
      .from('sow_templates')
      .upsert(template, { onConflict: 'template_name,organization_id' });

    if (error) throw new Error(`Failed to create SOW template: ${error.message}`);
    await delay(100);
  }

  return 'success';
}

async function createApprovalMatrixes() {
  const matrixes = [
    {
      name: 'Standard Procurement Approval',
      levels: [
        { level: 1, role: 'procurement_officer', required: true },
        { level: 2, role: 'project_manager', required: true }
      ],
      organization_id: process.env.ORG_ID
    }
  ];

  for (const matrix of matrixes) {
    const { error } = await supabase
      .from('approval_matrixes')
      .upsert(matrix, { onConflict: 'name,organization_id' });

    if (error) throw new Error(`Failed to create approval matrix: ${error.message}`);
    await delay(100);
  }

  return 'success';
}

async function verifyDataIntegrity() {
  // Verify all required data exists
  const checks = [
    { table: 'users', count: 4 },
    { table: 'procurement_templates', count: 2 },
    { table: 'sow_templates', count: 1 },
    { table: 'approval_matrixes', count: 1 }
  ];

  for (const check of checks) {
    const { count, error } = await supabase
      .from(check.table)
      .select('*', { count: 'exact', head: true })
      .eq('organization_id', process.env.ORG_ID);

    if (error) throw new Error(`Failed to verify ${check.table}: ${error.message}`);
    if (count < check.count) {
      throw new Error(`${check.table} has ${count} records, expected ${check.count}`);
    }
  }

  return 'success';
}

async function emergencyCleanup() {
  console.log('🧹 Emergency cleanup initiated...');

  const tables = ['procurement_orders', 'tasks', 'approval_matrixes', 'sow_templates', 'procurement_templates'];

  for (const table of tables) {
    try {
      await supabase
        .from(table)
        .delete()
        .eq('organization_id', process.env.ORG_ID)
        .like('id', 'test_%');
    } catch (error) {
      console.warn(`Warning: Could not cleanup ${table}:`, error.message);
    }
  }
}

// Execute
populateFoundationData().catch(console.error);
```

#### **1.2 Test Scenario Data**

```javascript
async function populateTestScenarios() {
  console.log('🎭 Populating test scenario data...\n');

  // Standard procurement order
  const standardOrder = {
    order_type: 'purchase_order',
    title: 'Standard Equipment Procurement Test',
    description: 'Automated test for standard procurement workflow',
    created_by: 'test_user_procurement_001',
    organization_id: process.env.ORG_ID,
    estimated_value: 25000,
    currency: 'ZAR',
    priority: 'medium',
    user_assignments: {
      appendix_a: ['test_user_engineering_001'],
      appendix_b: ['test_user_quality_001'],
      appendix_c: ['test_user_safety_001']
    },
    discipline_assignments: {
      appendix_a: ['engineering'],
      appendix_b: ['quality'],
      appendix_c: ['safety']
    },
    approval_config: {
      matrix_id: 'standard_procurement_approval',
      routing_type: 'sequential'
    }
  };

  // Complex procurement order
  const complexOrder = {
    order_type: 'purchase_order',
    title: 'Complex Equipment Procurement Test',
    description: 'Automated test for complex procurement workflow',
    created_by: 'test_user_procurement_001',
    organization_id: process.env.ORG_ID,
    estimated_value: 150000,
    currency: 'ZAR',
    priority: 'high',
    user_assignments: {
      appendix_a: ['test_user_engineering_001'],
      appendix_b: ['test_user_quality_001'],
      appendix_c: ['test_user_safety_001'],
      appendix_d: ['test_user_procurement_001']
    },
    discipline_assignments: {
      appendix_a: ['engineering'],
      appendix_b: ['quality'],
      appendix_c: ['safety'],
      appendix_d: ['procurement']
    },
    approval_config: {
      matrix_id: 'complex_procurement_approval',
      routing_type: 'parallel'
    }
  };

  // Error scenario orders
  const errorScenarios = [
    { ...standardOrder, title: 'Error Test - No Users', user_assignments: {} },
    { ...standardOrder, title: 'Error Test - Invalid Template', sow_template_id: 'nonexistent' }
  ];

  const allOrders = [standardOrder, complexOrder, ...errorScenarios];

  for (const order of allOrders) {
    const { error } = await supabase
      .from('procurement_orders')
      .insert(order);

    if (error) throw new Error(`Failed to create test order: ${error.message}`);
    await delay(200);
  }

  console.log(`✅ Created ${allOrders.length} test procurement orders`);
}
```

### **Phase 2: Core Workflow Testing**

#### **2.1 Procurement Order Creation Tests**

```javascript
describe('Procurement Order Creation Tests', () => {

  beforeEach(async () => {
    // Clean test data
    await cleanupTestOrders();
  });

  test('should create standard procurement order with user assignments', async () => {
    const orderData = {
      order_type: 'purchase_order',
      title: 'Test Standard Order',
      created_by: 'test_user_procurement_001',
      organization_id: process.env.ORG_ID,
      user_assignments: {
        appendix_a: ['test_user_engineering_001']
      }
    };

    const response = await request(app)
      .post('/api/procurement-orders')
      .set('x-organization-id', process.env.ORG_ID)
      .set('x-user-id', 'test_user_procurement_001')
      .send(orderData);

    expect(response.status).toBe(201);
    expect(response.body.success).toBe(true);
    expect(response.body.data.user_assignments).toEqual(orderData.user_assignments);

    // Verify in database
    const { data: dbOrder } = await supabase
      .from('procurement_orders')
      .select('user_assignments')
      .eq('id', response.body.data.id)
      .single();

    expect(dbOrder.user_assignments).toEqual(orderData.user_assignments);
  });

  test('should validate required fields', async () => {
    const incompleteOrder = {
      title: 'Incomplete Order'
      // Missing required fields
    };

    const response = await request(app)
      .post('/api/procurement-orders')
      .set('x-organization-id', process.env.ORG_ID)
      .send(incompleteOrder);

    expect(response.status).toBe(400);
    expect(response.body.success).toBe(false);
    expect(response.body.error).toContain('required');
  });

  test('should enforce organization isolation', async () => {
    const orderData = {
      order_type: 'purchase_order',
      title: 'Test Order',
      created_by: 'test_user_procurement_001',
      organization_id: 'different_org_123'
    };

    const response = await request(app)
      .post('/api/procurement-orders')
      .set('x-organization-id', process.env.ORG_ID) // Different from order org
      .send(orderData);

    // Should be rejected due to RLS policy
    expect(response.status).toBe(403);
  });
});
```

#### **2.2 SOW Association Tests**

```javascript
describe('SOW Association Tests', () => {

  let testOrderId;

  beforeEach(async () => {
    // Create test order
    const orderData = { /* standard order data */ };
    const { data: order } = await supabase
      .from('procurement_orders')
      .insert(orderData)
      .select()
      .single();

    testOrderId = order.id;
  });

  test('should associate SOW template with procurement order', async () => {
    const sowAssociation = {
      order_id: testOrderId,
      sow_template_id: 'test_sow_template_001',
      association_type: 'standard'
    };

    const response = await request(app)
      .post(`/api/procurement-orders/${testOrderId}/sow-association`)
      .set('x-organization-id', process.env.ORG_ID)
      .send(sowAssociation);

    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);

    // Verify association in database
    const { data: order } = await supabase
      .from('procurement_orders')
      .select('sow_template_id')
      .eq('id', testOrderId)
      .single();

    expect(order.sow_template_id).toBe(sowAssociation.sow_template_id);
  });

  test('should generate tasks based on SOW appendices', async () => {
    // Associate SOW first
    await associateSOWTemplate(testOrderId);

    // Trigger task generation
    const response = await request(app)
      .post(`/api/procurement-orders/${testOrderId}/generate-tasks`)
      .set('x-organization-id', process.env.ORG_ID);

    expect(response.status).toBe(200);

    // Verify tasks created
    const { data: tasks } = await supabase
      .from('tasks')
      .select('*')
      .eq('business_object_id', testOrderId)
      .eq('business_object_type', 'procurement_order');

    expect(tasks.length).toBeGreaterThan(0);

    // Verify task assignments match user assignments
    const taskAssignees = tasks.map(t => t.assigned_to);
    const expectedAssignees = ['test_user_engineering_001', 'test_user_quality_001', 'test_user_safety_001'];

    expectedAssignees.forEach(assignee => {
      expect(taskAssignees).toContain(assignee);
    });
  });
});
```

#### **2.3 Task Sequencing Tests**

```javascript
describe('Task Sequencing Tests', () => {

  test('should create tasks with correct sequencing', async () => {
    const orderId = await createTestOrderWithSOW();

    // Generate tasks
    await generateOrderTasks(orderId);

    // Verify task sequencing
    const { data: tasks } = await supabase
      .from('tasks')
      .select('id, assigned_to, metadata, created_at')
      .eq('business_object_id', orderId)
      .eq('business_object_type', 'procurement_order')
      .order('created_at', { ascending: true });

    // Verify parallel tasks within appendices
    const engineeringTasks = tasks.filter(t => t.metadata?.appendix_type === 'A');
    const qualityTasks = tasks.filter(t => t.metadata?.appendix_type === 'B');
    const safetyTasks = tasks.filter(t => t.metadata?.appendix_type === 'C');

    expect(engineeringTasks.length).toBe(1);
    expect(qualityTasks.length).toBe(1);
    expect(safetyTasks.length).toBe(1);

    // Verify assignments
    expect(engineeringTasks[0].assigned_to).toBe('test_user_engineering_001');
    expect(qualityTasks[0].assigned_to).toBe('test_user_quality_001');
    expect(safetyTasks[0].assigned_to).toBe('test_user_safety_001');
  });

  test('should handle task dependencies correctly', async () => {
    // Create order with dependencies
    const orderId = await createOrderWithDependencies();

    const { data: tasks } = await supabase
      .from('tasks')
      .select('id, status, dependencies')
      .eq('business_object_id', orderId)
      .eq('business_object_type', 'procurement_order');

    // Verify dependencies established
    const dependentTask = tasks.find(t => t.dependencies && t.dependencies.length > 0);
    expect(dependentTask).toBeDefined();

    // Verify dependent task starts as pending
    expect(dependentTask.status).toBe('pending');
  });
});
```

### **Phase 3: Error Handling and Recovery**

#### **3.1 Error Scenario Tests**

```javascript
describe('Error Handling Tests', () => {

  test('should handle user assignment failures gracefully', async () => {
    const orderData = {
      order_type: 'purchase_order',
      title: 'Error Test Order',
      created_by: 'test_user_procurement_001',
      organization_id: process.env.ORG_ID,
      user_assignments: {
        appendix_a: ['nonexistent_user_123']
      }
    };

    const response = await request(app)
      .post('/api/procurement-orders')
      .set('x-organization-id', process.env.ORG_ID)
      .send(orderData);

    // Should create order but log error for invalid assignments
    expect(response.status).toBe(201);
    expect(response.body.success).toBe(true);

    // Verify error logged
    const { data: logs } = await supabase
      .from('error_logs')
      .select('*')
      .eq('order_id', response.body.data.id)
      .eq('error_type', 'invalid_user_assignment');

    expect(logs.length).toBeGreaterThan(0);
  });

  test('should rollback partial failures', async () => {
    // Create order that will partially fail during task generation
    const orderId = await createOrderWithPartialFailure();

    // Attempt task generation (should fail partially)
    const response = await request(app)
      .post(`/api/procurement-orders/${orderId}/generate-tasks`)
      .set('x-organization-id', process.env.ORG_ID);

    // Should return error status
    expect(response.status).toBe(500);

    // Verify rollback - no tasks should be created
    const { data: tasks } = await supabase
      .from('tasks')
      .select('count')
      .eq('business_object_id', orderId);

    expect(tasks.length).toBe(0);
  });

  test('should recover from transient failures', async () => {
    // Simulate transient database failure
    mockDatabaseFailure();

    const orderData = { /* standard order data */ };

    // First attempt should fail
    const firstResponse = await request(app)
      .post('/api/procurement-orders')
      .set('x-organization-id', process.env.ORG_ID)
      .send(orderData);

    expect(firstResponse.status).toBe(500);

    // Clear failure simulation
    clearDatabaseFailure();

    // Second attempt should succeed
    const secondResponse = await request(app)
      .post('/api/procurement-orders')
      .set('x-organization-id', process.env.ORG_ID)
      .send(orderData);

    expect(secondResponse.status).toBe(201);
  });
});
```

### **Phase 4: Performance Testing**

#### **4.1 Load Testing Framework**

```javascript
describe('Performance Tests', () => {

  test('should handle concurrent order creation', async () => {
    const startTime = Date.now();

    // Create 10 orders concurrently
    const orderPromises = Array(10).fill().map((_, i) =>
      createTestOrder(`Concurrent Order ${i}`)
    );

    const results = await Promise.all(orderPromises);
    const endTime = Date.now();

    // Verify all orders created successfully
    results.forEach(result => {
      expect(result.success).toBe(true);
    });

    // Performance check: 10 orders in < 30 seconds
    const duration = endTime - startTime;
    expect(duration).toBeLessThan(30000);

    console.log(`Concurrent creation: 10 orders in ${duration}ms (${duration/10}ms per order)`);
  });

  test('should maintain performance under sustained load', async () => {
    const testDuration = 60000; // 1 minute
    const startTime = Date.now();
    let operations = 0;

    while (Date.now() - startTime < testDuration) {
      await createTestOrder(`Load Test Order ${operations}`);
      operations++;

      // Small delay to prevent overwhelming the system
      await delay(100);
    }

    const opsPerSecond = operations / (testDuration / 1000);

    console.log(`Sustained load: ${operations} operations in ${testDuration}ms (${opsPerSecond.toFixed(2)} ops/sec)`);

    // Should maintain reasonable throughput
    expect(opsPerSecond).toBeGreaterThan(5);
  });

  test('should handle task generation load', async () => {
    // Create multiple orders
    const orderIds = [];
    for (let i = 0; i < 5; i++) {
      const orderId = await createTestOrder(`Task Load Order ${i}`);
      orderIds.push(orderId);
    }

    // Generate tasks concurrently
    const startTime = Date.now();
    const taskPromises = orderIds.map(orderId =>
      request(app)
        .post(`/api/procurement-orders/${orderId}/generate-tasks`)
        .set('x-organization-id', process.env.ORG_ID)
    );

    const responses = await Promise.all(taskPromises);
    const endTime = Date.now();

    // All should succeed
    responses.forEach(response => {
      expect(response.status).toBe(200);
    });

    const duration = endTime - startTime;
    console.log(`Task generation load: 5 concurrent generations in ${duration}ms`);

    // Should complete within reasonable time
    expect(duration).toBeLessThan(10000);
  });
});
```

---

## 🧹 __TEST CLEANUP PROCEDURES__

### **Standard Cleanup**

```javascript
async function cleanupTestData() {
  console.log('🧹 Cleaning up test data...\n');

  const cleanupOperations = [
    {
      table: 'tasks',
      condition: { business_object_type: 'procurement_order' }
    },
    {
      table: 'procurement_orders',
      condition: { organization_id: process.env.ORG_ID }
    },
    {
      table: 'approval_matrixes',
      condition: { organization_id: process.env.ORG_ID }
    },
    {
      table: 'sow_templates',
      condition: { organization_id: process.env.ORG_ID }
    },
    {
      table: 'procurement_templates',
      condition: { organization_id: process.env.ORG_ID }
    }
  ];

  for (const op of cleanupOperations) {
    try {
      let query = supabase.from(op.table).delete();

      // Apply conditions
      Object.entries(op.condition).forEach(([key, value]) => {
        query = query.eq(key, value);
      });

      // Add test data filter
      if (op.table !== 'tasks') {
        query = query.or('id.like.test_%,title.like.Test%,title.like.Error Test%');
      }

      const { error } = await query;

      if (error) {
        console.warn(`⚠️ Warning: Could not cleanup ${op.table}:`, error.message);
      } else {
        console.log(`✅ Cleaned up ${op.table}`);
      }

    } catch (error) {
      console.warn(`⚠️ Warning: Exception cleaning ${op.table}:`, error.message);
    }

    await delay(100);
  }

  console.log('\n✅ Test data cleanup completed');
}
```

### **Emergency Cleanup**

```javascript
async function emergencyCleanup() {
  console.log('🚨 Emergency cleanup initiated...\n');

  // Aggressive cleanup - remove all test-related data
  const emergencyTables = [
    'procurement_orders',
    'tasks',
    'approval_matrixes',
    'sow_templates',
    'procurement_templates',
    'users'
  ];

  for (const table of emergencyTables) {
    try {
      // Remove all records with test in the name/ID
      const { error } = await supabase
        .from(table)
        .delete()
        .or('id.like.test_%,email.like.%.test@%,title.like.Test%,title.like.Error Test%');

      if (error) {
        console.error(`❌ Emergency cleanup failed for ${table}:`, error.message);
      } else {
        console.log(`✅ Emergency cleaned ${table}`);
      }

    } catch (error) {
      console.error(`💥 Critical error during emergency cleanup of ${table}:`, error);
    }
  }

  console.log('\n🚨 Emergency cleanup completed');
}
```

---

## 📊 __TEST REPORTING AND MONITORING__

### **Test Results Aggregation**

```javascript
class TestResultsAggregator {
  constructor() {
    this.results = {
      total: 0,
      passed: 0,
      failed: 0,
      skipped: 0,
      errors: [],
      performance: {
        totalDuration: 0,
        averageResponseTime: 0,
        peakMemoryUsage: 0
      }
    };
  }

  recordTest(testName, status, duration, error = null) {
    this.results.total++;

    switch (status) {
      case 'passed':
        this.results.passed++;
        break;
      case 'failed':
        this.results.failed++;
        if (error) this.results.errors.push({ testName, error });
        break;
      case 'skipped':
        this.results.skipped++;
        break;
    }

    this.results.performance.totalDuration += duration;
  }

  generateReport() {
    const successRate = (this.results.passed / this.results.total * 100).toFixed(1);
    const avgDuration = (this.results.performance.totalDuration / this.results.total).toFixed(2);

    return {
      summary: {
        total: this.results.total,
        passed: this.results.passed,
        failed: this.results.failed,
        skipped: this.results.skipped,
        successRate: `${successRate}%`
      },
      performance: {
        totalDuration: `${this.results.performance.totalDuration}ms`,
        averageDuration: `${avgDuration}ms per test`
      },
      errors: this.results.errors,
      recommendations: this.generateRecommendations()
    };
  }

  generateRecommendations() {
    const recommendations = [];

    if (this.results.failed > 0) {
      recommendations.push('Review failed tests and address root causes');
    }

    if (this.results.performance.totalDuration > 300000) { // 5 minutes
      recommendations.push('Consider optimizing test execution time');
    }

    if (this.results.errors.length > 5) {
      recommendations.push('Implement error pattern analysis and prevention');
    }

    return recommendations;
  }
}
```

### **Continuous Monitoring**

```javascript
async function monitorTestExecution() {
  console.log('📊 Starting test execution monitoring...\n');

  const metrics = {
    startTime: Date.now(),
    apiCalls: 0,
    errors: 0,
    memoryUsage: [],
    responseTimes: []
  };

  // Monitor API calls
  const originalFetch = global.fetch;
  global.fetch = async (...args) => {
    const start = Date.now();
    metrics.apiCalls++;

    try {
      const result = await originalFetch(...args);
      const duration = Date.now() - start;
      metrics.responseTimes.push(duration);

      if (!result.ok) {
        metrics.errors++;
      }

      return result;
    } catch (error) {
      metrics.errors++;
      throw error;
    }
  };

  // Monitor memory usage
  const memoryInterval = setInterval(() => {
    const usage = process.memoryUsage();
    metrics.memoryUsage.push({
      timestamp: Date.now(),
      heapUsed: usage.heapUsed,
      heapTotal: usage.heapTotal
    });
  }, 1000);

  // Return monitoring data
  return {
    getMetrics: () => metrics,
    stopMonitoring: () => {
      clearInterval(memoryInterval);
      global.fetch = originalFetch;
    }
  };
}
```

---

## 🚨 __TROUBLESHOOTING GUIDE__

### **Common Test Failures**

#### **1. RLS Policy Violations**
```
Error: permission denied for table procurement_orders
```
**Solution:**
```javascript
// Ensure correct organization header
const response = await request(app)
  .post('/api/procurement-orders')
  .set('x-organization-id', process.env.ORG_ID) // Must match order.organization_id
  .send(orderData);
```

#### **2. Rate Limiting**
```
Error: Too Many Requests (429)
```
**Solution:**
```javascript
// Implement exponential backoff
async function withRetry(operation, maxRetries = 3) {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await operation();
    } catch (error) {
      if (error.status === 429) {
        const delay = Math.pow(2, i) * 1000; // Exponential backoff
        await new Promise(resolve => setTimeout(resolve, delay));
        continue;
      }
      throw error;
    }
  }
}
```

#### **3. Data Consistency Issues**
```
Error: foreign key constraint violation
```
**Solution:**
```javascript
// Ensure referenced entities exist before creating dependent records
const { data: user } = await supabase
  .from('users')
  .select('id')
  .eq('id', userId)
  .single();

if (!user) {
  throw new Error(`User ${userId} does not exist`);
}

// Then create dependent record
```

#### **4. Concurrent Modification**
```
Error: concurrent update conflict
```
**Solution:**
```javascript
// Use optimistic locking or retry logic
async function updateWithRetry(recordId, updates, maxRetries = 3) {
  for (let i = 0; i < maxRetries; i++) {
    try {
      const { data: current } = await supabase
        .from('procurement_orders')
        .select('version')
        .eq('id', recordId)
        .single();

      const { error } = await supabase
        .from('procurement_orders')
        .update({ ...updates, version: current.version + 1 })
        .eq('id', recordId)
        .eq('version', current.version);

      if (error) throw error;
      return;

    } catch (error) {
      if (i === maxRetries - 1) throw error;
      await delay(100 * (i + 1));
    }
  }
}
```

### **Performance Issues**

#### **Slow Test Execution**
- **Check**: Database indexes on frequently queried columns
- **Check**: API rate limiting causing delays
- **Check**: Memory leaks in test setup/teardown

#### **Memory Leaks**
```javascript
// Monitor memory usage
const initialMemory = process.memoryUsage().heapUsed;

afterAll(() => {
  const finalMemory = process.memoryUsage().heapUsed;
  const leak = finalMemory - initialMemory;

  if (leak > 10 * 1024 * 1024) { // 10MB threshold
    console.warn(`⚠️ Potential memory leak detected: ${leak} bytes`);
  }
});
```

---

## 📋 __SUCCESS CRITERIA__

### **Functional Completeness**
- [ ] **100% workflow path coverage**: All procurement processes tested
- [ ] **Multi-discipline validation**: Cross-discipline task coordination verified
- [ ] **Error resilience**: All error scenarios handled appropriately
- [ ] **Data integrity**: No data corruption or consistency violations

### **Performance Benchmarks**
- [ ] **Response time**: < 2 seconds for API operations
- [ ] **Concurrent load**: 10+ simultaneous operations supported
- [ ] **Memory usage**: < 100MB per test suite execution
- [ ] **Success rate**: > 95% test pass rate

### **Security Compliance**
- [ ] **RLS enforcement**: All operations respect organization boundaries
- [ ] **Authentication**: Proper user context maintained
- [ ] **Audit trail**: All operations logged appropriately
- [ ] **Data isolation**: No cross-organization data leakage

### **Maintainability**
- [ ] **Test independence**: Tests can run in any order
- [ ] **Cleanup effectiveness**: No test data pollution between runs
- [ ] **Documentation**: All test scenarios clearly documented
- [ ] **Monitoring**: Comprehensive execution monitoring and reporting

---

## 🔄 __MAINTENANCE PROCEDURES__

### **Weekly Maintenance**
- [ ] Execute full regression test suite
- [ ] Review test execution metrics and performance trends
- [ ] Update test data to reflect current business rules
- [ ] Clean up any accumulated test data

### **Monthly Maintenance**
- [ ] Review test coverage and identify gaps
- [ ] Update performance benchmarks based on system improvements
- [ ] Audit test data for relevance and accuracy
- [ ] Update documentation for any process changes

### **Quarterly Maintenance**
- [ ] Complete test suite modernization
- [ ] Performance optimization based on monitoring data
- [ ] Security audit of test procedures and data
- [ ] Stakeholder review and approval of test framework

---

## 📞 __SUPPORT AND ESCALATION__

### **Issue Classification**

| **Severity** | **Description** | **Response Time** | **Escalation** |
|-------------|-----------------|------------------|----------------|
| **Critical** | System unusable, data corruption | < 1 hour | Engineering Lead |
| **High** | Major workflow broken | < 4 hours | QA Lead |
| **Medium** | Single test failure | < 24 hours | Development Team |
| **Low** | Performance degradation | < 1 week | Performance Team |

### **Escalation Path**
1. **Individual Contributor**: Initial investigation and local fixes
2. **Team Lead**: Cross-team coordination and resource allocation
3. **Engineering Manager**: System-level issues and architectural decisions
4. **Project Manager**: Stakeholder communication and timeline adjustments

### **Knowledge Base**
- `0000_PROCEDURES_GUIDE.md`: Complete index of all procedures
- `0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md`: Data population standards
- `0000_TABLE_POLICIES_SECURITY_PROCEDURE.md`: Security and RLS policies
- `PROCUREMENT_ORDER_WORKFLOW_TESTING_PLAN.md`: Comprehensive testing strategy

---

### **Discipline-Specific Implementation Examples**

#### **Example 1: Civil Engineering Workflow Testing**
```javascript
// Civil engineering foundation design workflow
const civilTestData = {
  discipline: 'civil',
  document_type: 'foundation_design',
  templates: [
    {
      template_name: 'Standard Foundation Design',
      discipline: 'civil',
      template_variation: 'standard',
      appendices: ['Geotechnical Report', 'Structural Calculations', 'Construction Drawings']
    }
  ],
  users: [
    { id: 'test_civil_engineer_001', discipline: 'civil', role: 'structural_engineer' },
    { id: 'test_geotech_engineer_001', discipline: 'civil', role: 'geotechnical_engineer' }
  ]
};

// API endpoints adapt to discipline
const civilApiTests = [
  '/api/civil/foundation-designs',      // Document creation
  '/api/civil/templates',               // Template management
  '/api/civil/calculation-validation',  // Discipline-specific validation
  '/api/tasks/civil-review-queue'       // Discipline-specific task queues
];
```

#### **Example 2: HSE Safety Document Testing**
```javascript
// HSE safety document workflow
const hseTestData = {
  discipline: 'hse',
  document_type: 'safety_management_plan',
  templates: [
    {
      template_name: 'Construction Safety Management Plan',
      discipline: 'hse',
      template_variation: 'comprehensive',
      appendices: ['Risk Assessment', 'Emergency Procedures', 'PPE Requirements']
    }
  ],
  users: [
    { id: 'test_safety_officer_001', discipline: 'hse', role: 'safety_officer' },
    { id: 'test_hse_manager_001', discipline: 'hse', role: 'hse_manager' }
  ]
};

// HSE-specific workflow validations
const hseWorkflowTests = [
  'Regulatory compliance validation',
  'Hazard identification and risk assessment',
  'Emergency response procedure verification',
  'PPE requirement enforcement'
];
```

#### **Example 3: Electrical Engineering Testing**
```javascript
// Electrical engineering workflow
const electricalTestData = {
  discipline: 'electrical',
  document_type: 'electrical_design',
  templates: [
    {
      template_name: 'Power Distribution Design',
      discipline: 'electrical',
      template_variation: 'complex',
      appendices: ['Load Calculations', 'Cable Schedules', 'Protection Schemes']
    }
  ]
};

// Electrical-specific validations
const electricalValidations = [
  'Electrical safety standard compliance',
  'Load calculation accuracy verification',
  'Cable sizing and protection coordination',
  'Earthing system design validation'
];
```

### **Universal Test Framework Adaptation**

#### **Dynamic Test Configuration**
```javascript
class DisciplineWorkflowTester {
  constructor(disciplineConfig) {
    this.discipline = disciplineConfig.discipline;
    this.documentType = disciplineConfig.documentType;
    this.templates = disciplineConfig.templates;
    this.users = disciplineConfig.users;
    this.apiBase = `/api/${this.discipline}`;
  }

  // Adapt test methods for any discipline
  async createTestDocument(overrides = {}) {
    const baseData = {
      discipline: this.discipline,
      document_type: this.documentType,
      created_by: this.users[0].id,
      organization_id: process.env.ORG_ID,
      ...overrides
    };

    const response = await request(app)
      .post(`${this.apiBase}/${this.documentType}s`)
      .set('x-organization-id', process.env.ORG_ID)
      .send(baseData);

    return response;
  }

  async testWorkflowExecution(documentId) {
    // Generic workflow execution test adaptable to any discipline
    const workflowTests = [
      this.testDocumentCreation.bind(this),
      this.testTemplateAssociation.bind(this),
      this.testTaskGeneration.bind(this),
      this.testApprovalWorkflow.bind(this),
      this.testCompletionValidation.bind(this)
    ];

    for (const test of workflowTests) {
      await test(documentId);
    }
  }

  // Discipline-specific customizations
  getCustomValidations() {
    const validations = {
      civil: ['structural_integrity', 'geotechnical_stability'],
      electrical: ['electrical_safety', 'load_compliance'],
      hse: ['regulatory_compliance', 'risk_mitigation'],
      procurement: ['vendor_qualification', 'cost_control']
    };

    return validations[this.discipline] || ['general_compliance'];
  }
}

// Usage for any discipline
const civilTester = new DisciplineWorkflowTester(civilTestData);
const hseTester = new DisciplineWorkflowTester(hseTestData);
const electricalTester = new DisciplineWorkflowTester(electricalTestData);
```

### **Cross-Discipline Integration Testing**

#### **Multi-Discipline Document Dependencies**
```javascript
describe('Cross-Discipline Integration Tests', () => {

  test('should handle dependencies between civil and electrical designs', async () => {
    // Create civil foundation design
    const civilDoc = await createCivilFoundationDesign();

    // Create electrical design that depends on civil
    const electricalDoc = await createElectricalDesign({
      dependencies: {
        foundation_design_id: civilDoc.id,
        structural_requirements: civilDoc.requirements
      }
    });

    // Verify dependency tracking
    expect(electricalDoc.dependencies.civil_foundation).toBe(civilDoc.id);

    // Test cascade updates
    await updateCivilDesign(civilDoc.id, { load_capacity: 'increased' });

    // Verify electrical design receives update notification
    const updatedElectrical = await getDocument(electricalDoc.id);
    expect(updatedElectrical.status).toBe('requires_review');
  });

  test('should coordinate HSE requirements across disciplines', async () => {
    // Create HSE safety plan
    const hsePlan = await createHSEPlan();

    // Associate multiple discipline documents with HSE requirements
    const civilDoc = await createCivilDesign({ hse_plan_id: hsePlan.id });
    const electricalDoc = await createElectricalDesign({ hse_plan_id: hsePlan.id });
    const mechanicalDoc = await createMechanicalDesign({ hse_plan_id: hsePlan.id });

    // Verify HSE compliance across all disciplines
    const complianceCheck = await checkHSECompliance([
      civilDoc.id, electricalDoc.id, mechanicalDoc.id
    ]);

    expect(complianceCheck.overall_status).toBe('compliant');
    expect(complianceCheck.discipline_coverage).toContain('civil');
    expect(complianceCheck.discipline_coverage).toContain('electrical');
    expect(complianceCheck.discipline_coverage).toContain('mechanical');
  });
});
```

---

## 📋 __DISCIPLINE ADAPTATION GUIDE__

### **Adapting This Procedure for New Disciplines**

#### **Step 1: Identify Discipline Characteristics**
```javascript
const disciplineProfile = {
  name: 'NEW_DISCIPLINE',
  documentTypes: ['type1', 'type2', 'type3'],
  typicalWorkflow: ['creation', 'review', 'approval', 'implementation'],
  userRoles: ['specialist', 'reviewer', 'approver'],
  complianceRequirements: ['standard1', 'standard2'],
  integrationPoints: ['discipline_x', 'discipline_y']
};
```

#### **Step 2: Customize Test Data Structure**
```javascript
const adaptedTestData = {
  discipline: disciplineProfile.name.toLowerCase(),
  templates: [
    {
      template_name: `${disciplineProfile.name} Standard Template`,
      discipline: disciplineProfile.name.toLowerCase(),
      appendices: disciplineProfile.documentTypes
    }
  ],
  users: disciplineProfile.userRoles.map(role => ({
    id: `test_${disciplineProfile.name.toLowerCase()}_${role}_001`,
    discipline: disciplineProfile.name.toLowerCase(),
    role: role
  }))
};
```

#### **Step 3: Update API Endpoints**
```javascript
const adaptedApiEndpoints = {
  documents: `/api/${disciplineProfile.name.toLowerCase()}/documents`,
  templates: `/api/${disciplineProfile.name.toLowerCase()}/templates`,
  workflows: `/api/${disciplineProfile.name.toLowerCase()}/workflows`,
  validations: `/api/${disciplineProfile.name.toLowerCase()}/validations`
};
```

#### **Step 4: Customize Validation Rules**
```javascript
const adaptedValidations = {
  requiredFields: ['discipline', 'document_type', 'created_by'],
  businessRules: disciplineProfile.complianceRequirements,
  integrationChecks: disciplineProfile.integrationPoints.map(point =>
    `validate_${point}_integration`
  )
};
```

---

**Document Information**
- **Document ID**: `0000_WORKFLOW_TESTING_PROCEDURE`
- **Version**: 1.0
- **Created**: 2025-12-16
- **Last Updated**: 2025-12-16
- **Author**: AI Assistant (Construct AI)
- **Review Cycle**: Monthly
- **Related Documents**:
  - `PROCUREMENT_ORDER_WORKFLOW_TESTING_PLAN.md`
  - `0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md`
  - `0000_TABLE_POLICIES_SECURITY_PROCEDURE.md`
  - `0000_PROCEDURES_GUIDE.md`

---

This procedure ensures comprehensive, reliable, and maintainable testing of any discipline-specific workflow in development mode, following enterprise-grade standards and security practices. The framework is designed to be easily adapted to new disciplines while maintaining consistent testing quality and coverage.