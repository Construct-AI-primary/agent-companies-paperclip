---
name: board-orchestration-management
description: >
  Use when orchestrating Paperclip board operations, managing task workflows,
  coordinating multi-agent execution, monitoring board health, or managing
  board-level automation routines. Covers board UI, task lifecycle, and
  orchestration patterns.
company: promptforge-ai
---

# Board Orchestration Management

## Overview

This skill provides comprehensive guidance for orchestrating Paperclip board operations. The Paperclip board is the control plane interface for managing AI-agent companies, tasks, issues, and routines. This skill enables effective board-level orchestration for discipline automation.

## When to Use This Skill

- Managing task workflows on the Paperclip board
- Coordinating multi-agent execution through the board
- Monitoring board health and performance
- Setting up and managing routines (scheduled tasks)
- Managing board-level automation
- Troubleshooting board operations
- Optimizing board orchestration efficiency
- Managing cross-company board operations

## Paperclip Board Architecture

### Board Components

| Component | Purpose | Key Operations |
|-----------|---------|-----------------|
| **Companies** | Top-level organization container | Create, update, archive |
| **Teams** | Agent groupings within companies | Create, assign agents |
| **Agents** | Individual AI agents | Create, configure, monitor |
| **Tasks** | Work items for agents | Create, assign, track status |
| **Issues** | Detailed work specifications | Create, link to tasks |
| **Routines** | Scheduled recurring tasks | Create, enable, disable |
| **Activity Logs** | Audit trail | Query, analyze |

### Board Access Modes

| Mode | Access Level | Capabilities |
|------|--------------|--------------|
| **Board UI** | Full control operator | All operations |
| **Agent API** | Company-scoped | Company entities only |
| **External Plugin** | Adapter-specific | Varies by adapter |

## Task Lifecycle Orchestration

### Task Status Flow

```
backlog → todo → in_progress → in_review → done
```

### Status Transition Rules

```javascript
const validTransitions = {
  backlog: ['todo'],
  todo: ['in_progress', 'backlog'],
  in_progress: ['in_review', 'todo'],
  in_review: ['done', 'in_progress'],
  done: []  // Terminal state
};

// Validate and execute transition
function transitionTask(taskId, newStatus) {
  const task = getTask(taskId);
  
  if (!validTransitions[task.status].includes(newStatus)) {
    throw new Error(`Invalid transition: ${task.status} → ${newStatus}`);
  }
  
  return updateTask(taskId, { status: newStatus });
}
```

### Task Checkout Semantics

- **Atomic Checkout**: Task assignment is atomic
- **Single Assignee**: Only one agent can be assigned
- **Lock Release**: Lock released on status change to done/backlog

## Multi-Agent Coordination

### Coordination Patterns

#### Pattern 1: Sequential Handoff

```javascript
// Sequential agent handoff
async function sequentialHandoff(tasks, agents) {
  for (const task of tasks) {
    const agent = agents.find(a => a.id === task.assigneeId);
    await executeTask(agent, task);
    await transitionTask(task.id, 'in_review');
  }
  
  // Final review and completion
  for (const task of tasks) {
    await transitionTask(task.id, 'done');
  }
}
```

#### Pattern 2: Parallel Execution

```javascript
// Parallel agent execution
async function parallelExecution(tasks, agents) {
  const batches = chunkTasks(tasks, agents.length);
  
  await Promise.all(
    batches.map((batch, i) => 
      executeTaskBatch(agents[i], batch)
    )
  );
}
```

#### Pattern 3: Pipeline Orchestration

```javascript
// Pipeline with stages
async function pipelineOrchestration(tasks) {
  const stages = ['analysis', 'development', 'review', 'deployment'];
  
  for (const stage of stages) {
    const stageTasks = tasks.filter(t => t.stage === stage);
    await Promise.all(
      stageTasks.map(task => executeStage(task, stage))
    );
  }
}
```

## Board Health Monitoring

### Health Metrics

```javascript
const boardHealth = {
  // Task metrics
  taskMetrics: {
    totalTasks: countTasks(),
    byStatus: groupByStatus(),
    overdueRate: calculateOverdueRate(),
    completionRate: calculateCompletionRate()
  },
  
  // Agent metrics
  agentMetrics: {
    activeAgents: countActiveAgents(),
    workloadDistribution: getWorkloadDistribution(),
    capacityUtilization: calculateCapacityUtilization()
  },
  
  // Company metrics
  companyMetrics: {
    activeCompanies: countActiveCompanies(),
    agentCount: countTotalAgents(),
    taskThroughput: calculateThroughput()
  }
};
```

### Health Thresholds

| Metric | Healthy | Warning | Critical |
|--------|---------|---------|----------|
| Task Overdue Rate | < 5% | 5-15% | > 15% |
| Agent Utilization | 60-80% | 80-90% | > 90% |
| Task Throughput | > 10/day | 5-10/day | < 5/day |
| Error Rate | < 1% | 1-5% | > 5% |

### Monitoring Dashboard

```javascript
// Generate monitoring dashboard
function generateDashboard(companyId) {
  return {
    overview: {
      totalTasks: getTaskCount(companyId),
      activeAgents: getActiveAgentCount(companyId),
      completionRate: getCompletionRate(companyId)
    },
    
    taskBreakdown: {
      backlog: getTaskCountByStatus(companyId, 'backlog'),
      todo: getTaskCountByStatus(companyId, 'todo'),
      inProgress: getTaskCountByStatus(companyId, 'in_progress'),
      inReview: getTaskCountByStatus(companyId, 'in_review'),
      done: getTaskCountByStatus(companyId, 'done')
    },
    
    agentPerformance: getAgentPerformanceMetrics(companyId),
    
    recentActivity: getRecentActivity(companyId, { limit: 20 })
  };
}
```

## Routine Management

### Routine Configuration

```javascript
// Create recurring routine
const routine = {
  name: 'Daily Discipline Sync',
  cronExpression: '0 9 * * *',  // 9 AM daily
  taskTemplate: {
    title: 'Daily discipline sync - {{date}}',
    description: 'Automated sync of discipline knowledge and project status',
    priority: 'medium',
    assigneeId: 'discipline-automation-agent-id'
  },
  companyId: 'promptforge-ai-id',
  enabled: true,
  metadata: {
    discipline: 'automation',
    automationType: 'sync'
  }
};
```

### Cron Expression Patterns

| Pattern | Description | Example |
|---------|-------------|---------|
| `0 9 * * *` | Daily at 9 AM | Every day at 9:00 |
| `0 */4 * * *` | Every 4 hours | 0, 4, 8, 12, 16, 20 |
| `0 9 * * 1-5` | Weekdays at 9 AM | Mon-Fri at 9:00 |
| `0 9 1 * *` | Monthly on 1st | 1st of each month |
| `*/15 * * * *` | Every 15 minutes | Continuous |

### Routine Lifecycle

```javascript
// Routine lifecycle management
const routineLifecycle = {
  create: (routine) => api.post('/routines', routine),
  enable: (routineId) => api.put(`/routines/${routineId}`, { enabled: true }),
  disable: (routineId) => api.put(`/routines/${routineId}`, { enabled: false }),
  update: (routineId, updates) => api.put(`/routines/${routineId}`, updates),
  delete: (routineId) => api.delete(`/routines/${routineId}`),
  execute: (routineId) => api.post(`/routines/${routineId}/execute`)
};
```

## Automation Orchestration

### Automation Engine

```javascript
// Discipline automation orchestration
class DisciplineAutomationEngine {
  constructor(companyId) {
    this.companyId = companyId;
    this.engines = {
      knowledge: new KnowledgeEngine(),
      project: new ProjectEngine(),
      issue: new IssueEngine(),
      orchestration: new OrchestrationEngine(),
      learning: new LearningEngine()
    };
  }
  
  async automate(disciplineCode, options) {
    // Phase 1: Knowledge synthesis
    const knowledge = await this.engines.knowledge.synthesize(disciplineCode);
    
    // Phase 2: Project intelligence
    const projects = await this.engines.project.analyze(knowledge);
    
    // Phase 3: Issue generation
    const issues = await this.engines.issue.generate(projects, options);
    
    // Phase 4: Orchestration preparation
    const orchestration = await this.engines.orchestration.prepare(issues);
    
    // Phase 5: Learning integration
    await this.engines.learning.integrate(orchestration);
    
    return orchestration;
  }
}
```

### Workflow Automation

```javascript
// Automated workflow execution
async function executeAutomatedWorkflow(workflow) {
  const results = [];
  
  for (const step of workflow.steps) {
    const stepResult = await executeStep(step);
    results.push(stepResult);
    
    if (step.onError === 'halt' && !stepResult.success) {
      await rollbackWorkflow(results);
      throw new Error(`Workflow halted at step: ${step.name}`);
    }
  }
  
  return results;
}
```

## Cross-Company Orchestration

### Company Boundary Enforcement

```javascript
// Enforce company boundaries
function enforceCompanyBoundary(entity, requestingCompanyId) {
  if (entity.companyId !== requestingCompanyId) {
    throw new Error('Access denied: Company boundary violation');
  }
  return true;
}

// Cross-company coordination
async function crossCompanyOrchestration(sourceCompany, targetCompany, task) {
  // Verify permissions
  await verifyCrossCompanyPermission(sourceCompany, targetCompany);
  
  // Create linked task in target company
  const linkedTask = await createLinkedTask(targetCompany, {
    ...task,
    linkedFrom: sourceCompany,
    syncDirection: task.syncDirection || 'bidirectional'
  });
  
  // Set up synchronization
  await setupTaskSync(linkedTask, task);
  
  return linkedTask;
}
```

## Activity Logging

### Logging Requirements

All mutating operations must log activity:

```javascript
// Log activity for mutating operations
async function logActivity(action, entity, actor, metadata = {}) {
  return api.post('/activity-logs', {
    action,
    entityType: entity.type,
    entityId: entity.id,
    entityName: entity.name,
    actorId: actor.id,
    actorName: actor.name,
    companyId: entity.companyId,
    timestamp: new Date().toISOString(),
    metadata
  });
}

// Activity types
const activityTypes = {
  CREATE: 'entity_created',
  UPDATE: 'entity_updated',
  DELETE: 'entity_deleted',
  ASSIGN: 'task_assigned',
  TRANSITION: 'status_transitioned',
  EXECUTE: 'routine_executed',
  ORCHESTRATE: 'workflow_orchestrated'
};
```

### Audit Trail Queries

```javascript
// Query activity logs
function queryActivityLogs(filters) {
  return api.get('/activity-logs', {
    params: {
      companyId: filters.companyId,
      entityType: filters.entityType,
      actorId: filters.actorId,
      action: filters.action,
      from: filters.fromDate,
      to: filters.toDate,
      limit: filters.limit || 100
    }
  });
}
```

## Error Handling

### Error Categories

| Category | Description | Recovery Action |
|----------|-------------|-----------------|
| **Validation** | Invalid input data | Fix and retry |
| **Authorization** | Permission denied | Request access |
| **Not Found** | Entity doesn't exist | Verify ID |
| **Conflict** | Duplicate or state conflict | Resolve conflict |
| **Capacity** | Resource exhausted | Wait or scale |
| **Timeout** | Operation timed out | Retry with timeout |

### Error Recovery Patterns

```javascript
// Retry with exponential backoff
async function retryWithBackoff(operation, maxRetries = 3) {
  let lastError;
  
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await operation();
    } catch (error) {
      lastError = error;
      
      if (!isRetryable(error)) {
        throw error;
      }
      
      const delay = Math.pow(2, i) * 1000;
      await sleep(delay);
    }
  }
  
  throw lastError;
}
```

## Success Metrics

- **Task Completion Rate**: > 90% on-time completion
- **Orchestration Efficiency**: < 5 minute average execution
- **Error Rate**: < 2% orchestration failures
- **Agent Utilization**: 70-85% average utilization
- **Routine Reliability**: > 99% routine execution success
- **Cross-Company Coordination**: 95%+ successful handoffs

## Related Skills

- `paperclip-api-integration` - API operations for board management
- `issue-routing-and-assignment` - Intelligent issue routing
- `dispatching-parallel-agents` - Parallel agent dispatch
- `subagent-driven-development` - Subagent coordination
- `workflow-implementation` - Workflow design and implementation

## Best Practices

1. **Always enforce company boundaries**
2. **Log all mutating operations**
3. **Monitor board health continuously**
4. **Implement proper error handling with retries**
5. **Use routines for recurring operations**
6. **Balance agent workload**
7. **Document orchestration decisions**
8. **Track and optimize orchestration efficiency**
