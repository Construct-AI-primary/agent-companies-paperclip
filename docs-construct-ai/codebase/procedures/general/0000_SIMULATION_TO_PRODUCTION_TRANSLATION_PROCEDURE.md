---
memory_layer: durable_knowledge
para_section: pages/codebase/procedures/general
gigabrain_tags: procedures, general, codebase
documentation
openstinger_context: operational-procedures, general-practices
last_updated: 2026-03-21
related_docs:
  - codebase/procedures/
  - disciplines/
---
# Simulation to Production Translation Procedure

This procedure provides a systematic approach for translating validated simulation results back to production agent code, ensuring that improvements discovered through simulation are properly implemented in the live system.

## Overview

### Purpose
Bridge the gap between simulation validation and production implementation by providing a clear methodology for translating successful simulation patterns into production agent updates.

### Key Challenge Addressed
Simulation systems provide controlled testing environments, but the real value comes from applying validated improvements back to production agents.

### Success Criteria
- Production agents exhibit the same validated behaviors as simulations
- Agent improvements maintain performance in live environment
- Changes are traceable from simulation validation to production deployment

## Procedure Overview

### Phase 1: Simulation Result Analysis
### Phase 2: Pattern Extraction
### Phase 3: Production Agent Mapping
### Phase 4: Implementation Planning
### Phase 5: Production Updates
### Phase 6: Validation & Rollback

---

## Phase 1: Simulation Result Analysis

### 1.1 Collect Successful Simulation Runs

**Objective**: Gather comprehensive data from successful simulation executions.

**Required Data**:
```json
{
  "simulationRun": {
    "executionId": "sim_1234567890_abc123",
    "scenario": "happy-path-001",
    "correspondenceFile": "sample-variation-request.txt",
    "responseType": "good_response",
    "specialists": ["civil_engineering", "quantity_surveying"]
  },
  "results": {
    "workflowCompleted": true,
    "successRate": "100.0%",
    "keyOutputs": {
      "document_analysis": {"identifiersExtracted": 3, "confidence": 0.92},
      "domain_specialist": {"specialistsConsulted": 2, "averageConfidence": 0.87},
      "human_review": {"finalDecision": "approved", "confidenceScore": 0.89}
    }
  },
  "validationResults": {
    "noHypotheticals": "PASS",
    "hitlTasksCreated": "PASS",
    "citationsPresent": "PASS"
  }
}
```

**Collection Method**:
```bash
# Run simulation and capture detailed output
/workflow correspondence-simulation-workflow \
  --correspondence_file="docs/agents/source-data/correspondence/sample-variation-request.txt" \
  --response_type="good_response" \
  --specialists="civil_engineering,quantity_surveying" > simulation_output.log
```

### 1.2 Identify Key Success Patterns

**Objective**: Extract the specific elements that made the simulation successful.

**Pattern Analysis Framework**:
```javascript
const successPatternAnalysis = {
  // What worked well
  successfulElements: {
    specialistResponses: {
      citationQuality: "HIGH", // Direct quotes, specific references
      technicalAccuracy: "VERIFIED", // Correct contract clause interpretation
      responseStructure: "CONSISTENT" // Clear sections, recommendations
    },
    workflowExecution: {
      stepCompletion: "100%", // All steps successful
      dataFlow: "CLEAN", // No data loss between steps
      errorHandling: "ROBUST" // Proper fallback mechanisms
    },
    hitlIntegration: {
      taskCreation: "AUTOMATIC", // Proper specialist assignment
      escalationLogic: "APPROPRIATE", // Correct priority handling
      resolutionTracking: "COMPLETE" // Full audit trail
    }
  },

  // Performance characteristics
  performanceMetrics: {
    averageResponseTime: "1250ms",
    memoryUsage: "45MB",
    successRate: "100%"
  },

  // Quality indicators
  qualityMetrics: {
    citationAccuracy: "95%",
    technicalCorrectness: "98%",
    responseCompleteness: "100%"
  }
};
```

### 1.3 Benchmark Against Known Issues

**Objective**: Compare successful patterns against previously identified problems.

**Issue Resolution Validation**:
```javascript
const issueResolutionCheck = {
  "ERR-001": { // Hypothetical content issue
    status: "RESOLVED",
    evidence: "No 'given the constraints' language detected",
    confidence: "HIGH"
  },
  "ERR-002": { // HITL assignment issue
    status: "RESOLVED",
    evidence: "Specialists properly assigned via backend service",
    confidence: "HIGH"
  },
  "ERR-003": { // Citation quality issue
    status: "RESOLVED",
    evidence: "All specialist responses include 2+ specific citations",
    confidence: "HIGH"
  }
};
```

---

## Phase 2: Pattern Extraction

### 2.1 Extract Response Patterns

**Objective**: Identify the specific language patterns, structures, and approaches that produce successful results.

**Pattern Extraction Process**:

#### Specialist Response Pattern Analysis
```javascript
// Extract successful response patterns
const responsePatterns = {
  structure: {
    opening: "Based on the correspondence content provided:",
    citation_format: "Paragraph X, line Y: 'exact quote'",
    technical_analysis: "Clear technical assessment with specific references",
    recommendations: "Actionable recommendations with justifications",
    closing: "Risk assessment and final position"
  },

  language_patterns: {
    avoid: ["given the constraints", "without access to", "hypothetical"],
    prefer: ["based on the provided correspondence", "as stated in", "according to clause X"]
  },

  content_patterns: {
    citations: {
      minimum_per_response: 2,
      types: ["direct_quotes", "document_references", "clause_citations"]
    },
    technical_accuracy: {
      verification_required: true,
      source_tracing: "MANDATORY"
    }
  }
};
```

#### HITL Assignment Pattern Analysis
```javascript
// Extract HITL success patterns
const hitlPatterns = {
  automatic_assignment: {
    trigger: "specialist_analysis_completion",
    method: "backend_service_call",
    criteria: ["discipline_match", "workload_balance", "availability"]
  },

  task_metadata: {
    business_object_type: "specialist_analysis_output",
    priority: "high",
    intervention_type: "complex_decision"
  },

  specialist_selection: {
    primary_criteria: "discipline_expertise",
    secondary_criteria: ["current_workload", "success_rate", "response_time"]
  }
};
```

### 2.2 Document Pattern Dependencies

**Objective**: Understand how patterns interact and depend on each other.

**Dependency Mapping**:
```javascript
const patternDependencies = {
  "specialist_response_quality": {
    depends_on: ["input_data_quality", "prompt_clarity", "context_availability"],
    enables: ["hitl_task_creation", "final_decision_accuracy"],
    constraints: ["must_have_citation_support", "requires_technical_validation"]
  },

  "hitl_assignment_success": {
    depends_on: ["specialist_response_quality", "backend_service_availability"],
    enables: ["human_expert_validation", "audit_trail_completeness"],
    constraints: ["must_assign_by_discipline", "requires_workload_balancing"]
  },

  "workflow_completion": {
    depends_on: ["all_step_success", "data_flow_integrity", "error_handling_robustness"],
    enables: ["production_deployment", "user_acceptance"],
    constraints: ["zero_data_loss", "100%_step_completion_rate"]
  }
};
```

---

## Phase 3: Production Agent Mapping

### 3.1 Identify Target Production Agents

**Objective**: Map simulation components to their production counterparts.

**Agent Mapping Matrix**:
```javascript
const productionAgentMapping = {
  simulation: {
    component: "CorrespondenceWorkflowSimulator",
    mockServices: {
      documentAnalysis: "DocumentAnalysisAgent",
      informationExtraction: "InformationExtractionAgent",
      documentRetrieval: "DocumentRetrievalAgent",
      domainSpecialist: "DomainSpecialistAgent",
      contractManagement: "ContractManagementAgent",
      humanReview: "HumanReviewAgent"
    }
  },

  production: {
    location: "client/src/pages/00435-contracts-post-award/components/agents/",
    agents: {
      "correspondence-01-document-analysis.js": "DocumentAnalysisAgent",
      "correspondence-02-information-extraction.js": "InformationExtractionAgent",
      "correspondence-03-document-retrieval.js": "DocumentRetrievalAgent",
      "correspondence-04-domain-specialist-agent.js": "DomainSpecialistAgent",
      "correspondence-05-contract-management.js": "ContractManagementAgent",
      "correspondence-06-human-review.js": "HumanReviewAgent"
    }
  },

  backend_services: {
    hitlAssignment: "server/src/services/hitl-assignment-service.js",
    promptManagement: "server/src/services/enhanced-prompts-service.js",
    databaseOperations: "server/src/routes/correlation-routes.js"
  }
};
```

### 3.2 Map Simulation Configurations to Production Settings

**Objective**: Translate simulation parameters to production configuration.

**Configuration Translation**:
```javascript
// Simulation config to production mapping
const configTranslationMap = {
  simulation: {
    responseType: "good_response",
    specialists: ["civil_engineering", "quantity_surveying"],
    timeout: 2000
  },

  production: {
    // Specialist Agent Configuration
    specialistAgent: {
      defaultResponseType: "validated_response", // Maps to "good_response"
      specialistSelection: ["civil_engineering", "quantity_surveying"],
      timeoutMs: 120000, // Production timeout
      retryAttempts: 2
    },

    // HITL Service Configuration
    hitlService: {
      autoAssignment: true,
      assignmentCriteria: ["discipline_match", "workload_balance"],
      escalationRules: [], // Production escalation rules
      auditTrail: true
    },

    // Prompt Configuration
    promptConfig: {
      templateVersion: "validated-v1.0",
      contextInclusion: "mandatory",
      citationRequirements: "enforced"
    }
  }
};
```

### 3.3 Validate Production Agent Current State

**Objective**: Assess current production agent implementations against simulation patterns.

**Production Agent Audit**:
```javascript
const productionAgentAudit = {
  "DomainSpecialistAgent": {
    currentStatus: "PARTIALLY_ALIGNED",
    simulationAlignment: {
      responseQuality: "REQUIRES_UPDATE", // Hypothetical content still present
      hitlIntegration: "REQUIRES_UPDATE", // Manual assignment instead of service
      citationHandling: "REQUIRES_UPDATE" // Citations not enforced
    },
    requiredChanges: [
      "Update prompt templates to remove hypothetical language",
      "Replace manual HITL assignment with service calls",
      "Add citation validation and enforcement",
      "Update response parsing to handle validated patterns"
    ]
  },

  "HITLAssignmentService": {
    currentStatus: "ALIGNED",
    simulationAlignment: {
      assignmentLogic: "ALIGNED",
      specialistSelection: "ALIGNED",
      auditTrail: "ALIGNED"
    },
    requiredChanges: [] // No changes needed
  }
};
```

---

## Phase 4: Implementation Planning

### 4.1 Create Implementation Roadmap

**Objective**: Develop a phased plan for production updates.

**Implementation Roadmap**:
```javascript
const implementationRoadmap = {
  phase1: {
    name: "Critical Bug Fixes",
    duration: "2-3 days",
    priority: "HIGH",
    changes: [
      {
        component: "DomainSpecialistAgent",
        change: "Remove hypothetical language from prompts",
        files: ["docs/dev-prompts/00435-contracts-post-award/correspondence-workflow/specialists/*.md"],
        validation: "Simulation validation test passes"
      },
      {
        component: "DomainSpecialistAgent",
        change: "Replace manual HITL assignment with service call",
        files: ["client/src/pages/00435-contracts-post-award/components/agents/correspondence-04-domain-specialist-agent.js"],
        validation: "HITL tasks properly assigned"
      }
    ]
  },

  phase2: {
    name: "Quality Improvements",
    duration: "3-5 days",
    priority: "MEDIUM",
    changes: [
      {
        component: "DomainSpecialistAgent",
        change: "Add citation validation and enforcement",
        files: ["client/src/pages/00435-contracts-post-award/components/agents/correspondence-04-domain-specialist-agent.js"],
        validation: "All responses include required citations"
      },
      {
        component: "DocumentAnalysisAgent",
        change: "Improve identifier extraction accuracy",
        files: ["client/src/pages/00435-contracts-post-award/components/agents/correspondence-01-document-analysis.js"],
        validation: "Identifier extraction matches simulation results"
      }
    ]
  },

  phase3: {
    name: "Performance Optimization",
    duration: "2-3 days",
    priority: "LOW",
    changes: [
      {
        component: "All Agents",
        change: "Implement caching for frequently accessed data",
        files: ["client/src/pages/00435-contracts-post-award/components/agents/*.js"],
        validation: "Response times within performance targets"
      }
    ]
  }
};
```

### 4.2 Risk Assessment and Mitigation

**Objective**: Identify potential risks and mitigation strategies.

**Risk Assessment Matrix**:
```javascript
const riskAssessment = {
  highRisk: [
    {
      risk: "Production agent behavior changes unexpectedly",
      impact: "HIGH",
      probability: "MEDIUM",
      mitigation: [
        "Implement feature flags for gradual rollout",
        "Maintain backup of previous agent versions",
        "Conduct extensive testing in staging environment"
      ]
    },
    {
      risk: "HITL assignment failures in production",
      impact: "HIGH",
      probability: "LOW",
      mitigation: [
        "Test HITL service integration thoroughly",
        "Implement fallback assignment logic",
        "Monitor HITL assignment success rates"
      ]
    }
  ],

  mediumRisk: [
    {
      risk: "Performance degradation",
      impact: "MEDIUM",
      probability: "MEDIUM",
      mitigation: [
        "Conduct performance benchmarking before/after",
        "Implement performance monitoring",
        "Have rollback plan ready"
      ]
    }
  ]
};
```

### 4.3 Define Success Metrics

**Objective**: Establish measurable criteria for successful implementation.

**Success Metrics**:
```javascript
const successMetrics = {
  functional: {
    "hypothetical_content_eliminated": {
      metric: "Percentage of responses without hypothetical language",
      target: "100%",
      measurement: "Automated scan of agent responses"
    },
    "hitl_assignment_success": {
      metric: "Percentage of HITL tasks properly assigned",
      target: "100%",
      measurement: "HITL service logs analysis"
    },
    "citation_quality": {
      metric: "Average citations per specialist response",
      target: "2.0+",
      measurement: "Response content analysis"
    }
  },

  performance: {
    "response_time": {
      metric: "Average workflow completion time",
      target: "< 3000ms",
      measurement: "Application performance monitoring"
    },
    "error_rate": {
      metric: "Workflow failure rate",
      target: "< 1%",
      measurement: "Error logging and monitoring"
    }
  },

  quality: {
    "user_satisfaction": {
      metric: "User satisfaction with response quality",
      target: "> 95%",
      measurement: "User feedback surveys"
    },
    "compliance_accuracy": {
      metric: "Contractual compliance accuracy",
      target: "> 98%",
      measurement: "Audit review of decisions"
    }
  }
};
```

---

## Phase 5: Production Updates

### 5.1 Implement Changes Systematically

**Objective**: Apply validated patterns to production agents following the implementation roadmap.

**Change Implementation Process**:

#### Update 1: Prompt Template Corrections
```javascript
// File: docs/dev-prompts/00435-contracts-post-award/correspondence-workflow/specialists/civil-engineering.md
// BEFORE (problematic)
"You will receive the following inputs and are expected to provide specialist analysis..."

// AFTER (validated)
"You ARE receiving the actual correspondence content in this prompt. Based on the correspondence content provided below..."
```

#### Update 2: HITL Assignment Service Integration
```javascript
// File: client/src/pages/00435-contracts-post-award/components/agents/correspondence-04-domain-specialist-agent.js
// BEFORE (manual assignment - problematic)
await this.manualHITLAssignment(specialistResults);

// AFTER (service-based assignment - validated)
await this.hitlAssignmentService.assignHITLTasks(specialistResults);
```

#### Update 3: Citation Validation
```javascript
// File: client/src/pages/00435-contracts-post-award/components/agents/correspondence-04-domain-specialist-agent.js
// ADD: Citation validation
validateSpecialistResponse(response) {
  const citations = this.extractCitations(response);
  if (citations.length < 2) {
    throw new Error('Specialist response must include at least 2 citations');
  }
  return this.validateCitationQuality(citations);
}
```

### 5.2 Version Control and Documentation

**Objective**: Maintain proper version control and documentation of changes.

**Change Documentation Template**:
```markdown
## Production Agent Update: [Agent Name]

**Date:** YYYY-MM-DD
**Simulation Reference:** sim_[execution_id]
**Change Type:** [BUG_FIX | IMPROVEMENT | OPTIMIZATION]

### Problem Addressed
[Description of the issue identified in simulation]

### Solution Implemented
[How the simulation-validated pattern was applied]

### Files Modified
- `client/src/pages/00435-contracts-post-award/components/agents/[filename].js`
- `docs/dev-prompts/[path]/[filename].md`

### Validation
-  Simulation test: [test_name] - PASSED
-  Code review completed
-  Backward compatibility verified

### Rollback Plan
[Steps to revert changes if issues occur]

### Related Issues
- ERR-[number]: [error_title]
- Fixes #[issue_number]
```

---

## Phase 6: Validation & Rollback

### 6.1 Post-Implementation Validation

**Objective**: Verify that production agents exhibit the validated simulation behaviors.

**Validation Process**:
```bash
# 1. Run simulation with same parameters
/workflow correspondence-simulation-workflow \
  --correspondence_file="test-file.txt" \
  --validate_fixes=true

# 2. Deploy to staging environment
# 3. Run production agent with identical inputs
# 4. Compare outputs using validation framework

const validationComparison = {
  simulation: {
    response: "Based on correspondence paragraph 2: '45m³ of concrete poured'",
    citations: 3,
    hitlAssigned: true
  },
  production: {
    response: "Based on correspondence paragraph 2: '45m³ of concrete poured'",
    citations: 3,
    hitlAssigned: true
  },
  match: {
    responseSimilarity: "100%",
    citationMatch: "100%",
    behaviorMatch: "100%"
  }
};
```

### 6.2 Monitoring and Alerting

**Objective**: Monitor production behavior and alert on deviations.

**Monitoring Setup**:
```javascript
const productionMonitoring = {
  metrics: {
    "response_quality": {
      threshold: 95, // Minimum quality score
      alert: "Response quality dropped below threshold"
    },
    "hitl_assignment_rate": {
      threshold: 100, // All HITL tasks assigned
      alert: "HITL assignment failures detected"
    },
    "citation_compliance": {
      threshold: 2.0, // Minimum citations per response
      alert: "Citation requirements not met"
    }
  },

  alerts: {
    channels: ["slack", "email"],
    escalation: {
      "critical": "immediate_response",
      "high": "within_1_hour",
      "medium": "within_4_hours"
    }
  }
};
```

### 6.3 Rollback Procedures

**Objective**: Ensure ability to quickly revert changes if issues occur.

**Rollback Plan Template**:
```bash
# Rollback Procedure for Agent Updates

echo "Initiating rollback for production agent changes..."

# 1. Stop new agent instances
kubectl scale deployment correspondence-agents-v2 --replicas=0

# 2. Restore previous version
kubectl scale deployment correspondence-agents-v1 --replicas=3

# 3. Update service to point to previous version
kubectl apply -f k8s/service-rollback.yaml

# 4. Verify rollback success
curl -X POST http://correspondence-service/health \
  -H "Content-Type: application/json" \
  -d '{"test": "rollback_verification"}'

# 5. Monitor for 30 minutes
# 6. If stable, investigate root cause before re-attempting deployment

echo "Rollback completed. Previous version active."
```

---

## Success Criteria and Next Steps

### Overall Success Criteria
-  Production agents generate identical outputs to validated simulations
-  All success metrics meet or exceed targets
-  No critical issues reported in production monitoring
-  User acceptance testing passes

### Continuous Improvement
1. **Monitor Production Metrics**: Track performance against simulation benchmarks
2. **Gather User Feedback**: Collect feedback on improved response quality
3. **Iterate on Improvements**: Use production data to further refine simulations
4. **Expand Test Coverage**: Add more scenarios based on production usage patterns

### Documentation Updates
- Update error tracking log with resolution status
- Document successful patterns for future reference
- Create case study of simulation-to-production translation success

This procedure ensures that valuable insights gained through simulation validation are systematically and reliably applied to production systems, closing the loop between testing and deployment.