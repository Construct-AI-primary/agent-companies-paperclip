---
name: inter-company-delegation
description: >
  Use when coordinating work between Paperclip companies, delegating tasks across
  company boundaries, or establishing cross-company workflows. Covers delegation
  protocols, cross-company communication, handoff procedures, and coordination patterns.
company: promptforge-ai
---

# Inter-Company Delegation

## Overview

This skill provides comprehensive guidance for delegating tasks and coordinating work across Paperclip companies. It enables seamless handoffs between specialized companies while maintaining proper company boundaries and ensuring accountability.

## When to Use This Skill

- Delegating tasks to other companies
- Receiving delegated work from other companies
- Coordinating cross-company workflows
- Establishing handoff protocols
- Managing cross-company dependencies
- Resolving inter-company conflicts
- Monitoring cross-company progress
- Performing cross-company quality checks

## Company Specialization Matrix

| Company | Specialization | Primary Delegation To | Primary Delegation From |
|---------|---------------|----------------------|------------------------|
| **PromptForge AI** | Prompt Engineering, Orchestration | DevForge, QualityForge | All companies |
| **DevForge AI** | Enterprise Development | InfraForge, QualityForge | PromptForge, DomainForge |
| **DomainForge AI** | Domain Knowledge, Engineering | DevForge, QualityForge | Construct-AI disciplines |
| **InfraForge AI** | Infrastructure, Database | DevForge | All companies |
| **QualityForge AI** | Testing, QA | PromptForge, DevForge | All companies |
| **KnowledgeForge AI** | Knowledge Management | All companies | All companies |
| **PaperclipForge AI** | Project Management | PromptForge, DevForge | All companies |
| **Loopy AI** | Creative Content | PromptForge, DevForge | Marketing needs |
| **LearningForge AI** | Learning, Improvement | All companies | All companies |

## Delegation Protocol

### Step 1: Delegation Request

```javascript
// Create delegation request
const delegationRequest = {
  sourceCompany: 'promptforge-ai',
  targetCompany: 'devforge-ai',
  taskDescription: 'Implement API integration module',
  priority: 'high',
  deadline: '2026-04-20',
  requirements: {
    skills: ['api-development', 'typescript'],
    skillLevel: 'advanced',
    resources: ['api-documentation']
  },
  dependencies: [],
  handoffFormat: 'detailed_brief'
};
```

### Step 2: Acceptance Criteria

```javascript
// Define acceptance criteria
const acceptanceCriteria = {
  deliverables: [
    'API endpoint implementation',
    'Unit test coverage > 80%',
    'Documentation in docs-paperclip'
  ],
  qualityStandards: [
    'Code review approval',
    'Test pass rate 100%',
    'TypeScript compilation successful'
  ],
  timeline: {
    startDate: '2026-04-16',
    milestone1: '2026-04-18',
    milestone2: '2026-04-19',
    endDate: '2026-04-20'
  },
  communication: {
    updateFrequency: 'daily',
    escalationPath: 'promptforge-ai-operations-director'
  }
};
```

### Step 3: Handoff Documentation

```javascript
// Create handoff package
const handoffPackage = {
  delegationId: generateDelegationId(),
  taskBrief: createTaskBrief(delegationRequest),
  contextDocuments: collectRelevantDocuments(delegationRequest),
  technicalRequirements: documentTechnicalNeeds(delegationRequest),
  qualityCriteria: acceptanceCriteria,
  timeline: acceptanceCriteria.timeline,
  contactInformation: {
    delegator: getDelegatorContact(),
    escalation: getEscalationContact()
  }
};
```

## Cross-Company Coordination Patterns

### Pattern 1: Sequential Delegation

```javascript
// Sequential handoff between companies
async function sequentialDelegation(task, companies) {
  let currentTask = task;
  
  for (const company of companies) {
    const result = await delegateToCompany(currentTask, company);
    currentTask = transformForNextCompany(result, companies[companies.indexOf(company) + 1]);
  }
  
  return currentTask;
}
```

### Pattern 2: Parallel Delegation

```javascript
// Parallel delegation to multiple companies
async function parallelDelegation(task, companies) {
  const delegations = companies.map(company => ({
    company,
    task: prepareTaskForCompany(task, company)
  }));
  
  const results = await Promise.all(
    delegations.map(d => delegateToCompany(d.task, d.company))
  );
  
  return consolidateResults(results);
}
```

### Pattern 3: Hub-and-Spoke

```javascript
// Central coordinator with spokes
async function hubAndSpokeDelegation(hubCompany, task, spokeCompanies) {
  // Hub prepares and coordinates
  const coordinatedTask = await hubCompany.coordinate(task, spokeCompanies);
  
  // Spokes execute in parallel
  const spokeResults = await Promise.all(
    spokeCompanies.map(spoke => spoke.execute(coordinatedTask))
  );
  
  // Hub consolidates
  return hubCompany.consolidate(spokeResults);
}
```

## Handoff Procedures

### Delegation Handoff

```javascript
// Execute delegation handoff
async function executeHandoff(delegation, targetCompany) {
  // 1. Notify target company
  await notifyTargetCompany(targetCompany, delegation);
  
  // 2. Transfer context
  await transferContext(delegation, targetCompany);
  
  // 3. Create tracking task
  const trackingTask = await createTrackingTask(delegation, targetCompany);
  
  // 4. Establish monitoring
  await establishMonitoring(delegation, trackingTask);
  
  // 5. Set up escalation
  await configureEscalation(delegation);
  
  return { handoffComplete: true, trackingTask };
}
```

### Receipt Handoff

```javascript
// Process incoming delegation
async function processIncomingHandoff(delegation) {
  // 1. Acknowledge receipt
  await acknowledgeReceipt(delegation);
  
  // 2. Validate requirements
  const validation = await validateRequirements(delegation);
  
  if (!validation.valid) {
    await requestClarification(delegation, validation.issues);
    return { status: 'awaiting_clarification' };
  }
  
  // 3. Plan execution
  const executionPlan = await planExecution(delegation);
  
  // 4. Confirm acceptance
  await confirmAcceptance(delegation, executionPlan);
  
  return { status: 'accepted', executionPlan };
}
```

## Communication Protocols

### Status Updates

```javascript
// Send cross-company status update
async function sendStatusUpdate(delegation, status) {
  const update = {
    delegationId: delegation.id,
    timestamp: new Date().toISOString(),
    status,
    progress: calculateProgress(delegation),
    blockers: identifyBlockers(delegation),
    nextMilestone: getNextMilestone(delegation),
    requestedSupport: identifySupportNeeds(delegation)
  };
  
  await sendToSourceCompany(delegation.sourceCompany, update);
}
```

### Escalation Protocol

```javascript
// Escalate cross-company issue
async function escalateIssue(delegation, issue) {
  const escalation = {
    delegationId: delegation.id,
    company: delegation.sourceCompany,
    issue,
    severity: assessIssueSeverity(issue),
    requestedAction: determineRequestedAction(issue),
    timeline: assessTimelineImpact(issue)
  };
  
  // Level 1: Direct contact
  await escalateToOperationsDirector(delegation.sourceCompany, escalation);
  
  // Level 2: Company leadership
  if (issue.severity === 'critical') {
    await escalateToCEO(delegation.sourceCompany, escalation);
  }
  
  return { escalationLevel: issue.severity === 'critical' ? 2 : 1 };
}
```

## Quality Assurance

### Cross-Company QA Checks

```javascript
// Perform cross-company quality check
async function crossCompanyQACheck(delegation, targetCompany) {
  const qualityCriteria = delegation.acceptanceCriteria.qualityStandards;
  
  const results = {
    deliverables: await verifyDeliverables(delegation, targetCompany),
    standards: await verifyStandardsCompliance(delegation, targetCompany),
    timeline: await verifyTimelineCompliance(delegation, targetCompany),
    communication: await verifyCommunicationCompliance(delegation, targetCompany)
  };
  
  return {
    passed: Object.values(results).every(r => r.passed),
    details: results,
    recommendations: generateQARecommendations(results)
  };
}
```

### Acceptance Sign-off

```javascript
// Sign off on delegation completion
async function signOffDelegation(delegation, targetCompany) {
  const acceptanceCheck = await crossCompanyQACheck(delegation, targetCompany);
  
  if (!acceptanceCheck.passed) {
    await requestRevisions(delegation, acceptanceCheck.recommendations);
    return { status: 'revision_requested' };
  }
  
  // Document completion
  await documentCompletion(delegation, targetCompany, acceptanceCheck);
  
  // Close tracking
  await closeDelegation(delegation);
  
  return { status: 'completed', acceptanceCheck };
}
```

## Monitoring and Tracking

### Delegation Tracking Dashboard

```javascript
// Generate delegation tracking data
function generateDelegationDashboard(sourceCompanyId) {
  return {
    activeDelegations: getActiveDelegations(sourceCompanyId),
    pendingResponses: getPendingResponses(sourceCompanyId),
    completedThisMonth: getCompletedDelegations(sourceCompanyId, { thisMonth: true }),
    averageTurnaround: calculateAverageTurnaround(sourceCompanyId),
    qualityMetrics: getQualityMetrics(sourceCompanyId),
    escalationCount: getEscalationCount(sourceCompanyId)
  };
}
```

### Health Metrics

| Metric | Target | Warning | Critical |
|--------|--------|---------|----------|
| On-time Completion | > 90% | 80-90% | < 80% |
| Quality Pass Rate | > 95% | 90-95% | < 90% |
| Avg Response Time | < 4 hours | 4-8 hours | > 8 hours |
| Escalation Rate | < 5% | 5-10% | > 10% |

## PromptForge AI ↔ PaperclipForge AI Coordination

### Specific Delegation Patterns

```javascript
// PromptForge → PaperclipForge: Project management delegation
const projectDelegation = {
  from: 'promptforge-ai',
  to: 'paperclipforge-ai',
  triggers: ['complex_project', 'multi-team_coordination', 'issue_orchestration'],
  handoffContent: ['project_plan', 'task_breakdown', 'resource_requirements'],
  qualityGate: 'project_maestro_approval'
};

// PaperclipForge → PromptForge: Orchestration expertise
const orchestrationDelegation = {
  from: 'paperclipforge-ai',
  to: 'promptforge-ai',
  triggers: ['prompt_optimization', 'workflow_design', 'agent_coordination'],
  handoffContent: ['workflow_requirements', 'agent_capabilities', 'success_criteria'],
  qualityGate: 'sage_approval'
};
```

## Success Metrics

- **Delegation Acceptance Rate**: > 95% successful acceptance
- **On-time Completion**: > 90% within deadline
- **Quality Pass Rate**: > 95% first-pass acceptance
- **Communication Response**: < 4 hours average response
- **Escalation Rate**: < 5% requiring escalation

## Related Skills

- `paperclip-api-integration` - API operations for delegation tracking
- `board-orchestration-management` - Board-level coordination
- `issue-routing-and-assignment` - Task assignment across companies
- `skill-validation-remediation` - Skill matching for delegation
- `cross-team-collaboration` - Collaboration best practices

## Best Practices

1. **Clear requirements** - Document everything needed for execution
2. **Defined boundaries** - Respect company responsibilities
3. **Active monitoring** - Track progress and blockers
4. **Timely communication** - Respond within 4 hours
5. **Quality gates** - Verify before accepting
6. **Document learnings** - Capture delegation lessons
7. **Continuous improvement** - Refine protocols based on results