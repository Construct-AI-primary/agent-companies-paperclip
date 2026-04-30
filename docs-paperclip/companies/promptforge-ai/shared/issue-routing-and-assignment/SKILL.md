---
name: issue-routing-and-assignment
description: >
  Use when intelligent issue routing, assignment optimization, skill matching,
  or workload balancing across agents is needed. Covers priority assessment,
  dependency mapping, capacity planning, and assignment validation.
company: promptforge-ai
---

# Issue Routing and Assignment

## Overview

This skill provides comprehensive guidance for intelligent issue routing and agent assignment within the Paperclip ecosystem. It enables optimal distribution of work across agents based on skills, capacity, priority, and dependencies.

## When to Use This Skill

- Routing issues to appropriate agents based on expertise
- Balancing workload across multiple agents
- Assessing issue priority and urgency
- Mapping issue dependencies
- Validating assignment decisions
- Optimizing agent utilization
- Handling cross-team assignments
- Managing assignment conflicts

## Routing Decision Framework

### Step 1: Issue Analysis

```javascript
// Analyze issue requirements
const issueAnalysis = {
  discipline: extractDiscipline(issue),
  platform: identifyPlatform(issue),
  complexity: assessComplexity(issue),
  skills: extractRequiredSkills(issue),
  dependencies: identifyDependencies(issue),
  priority: assessPriority(issue),
  estimatedHours: estimateEffort(issue)
};
```

### Step 2: Agent Capability Matching

```javascript
// Match issue to agent capabilities
const capabilityMatch = {
  skillMatch: calculateSkillMatch(issueAnalysis.skills, agent.skills),
  experienceLevel: assessExperience(issueAnalysis, agent),
  availability: checkAvailability(agent),
  currentWorkload: getCurrentWorkload(agent),
  historicalPerformance: getPerformanceMetrics(agent, issueAnalysis.discipline)
};
```

### Step 3: Assignment Scoring

```javascript
// Calculate assignment score
const assignmentScore = {
  skillFit: capabilityMatch.skillMatch * 0.35,
  availabilityFit: (1 - capabilityMatch.currentWorkload) * 0.25,
  performanceFit: capabilityMatch.historicalPerformance * 0.25,
  priorityFit: assessPriorityFit(issueAnalysis.priority, agent) * 0.15
};

const totalScore = Object.values(assignmentScore).reduce((a, b) => a + b, 0);
```

## Skill Matching Matrix

### Discipline-to-Skill Mapping

| Discipline Code | Required Skills | Preferred Agents |
|-----------------|-----------------|------------------|
| 02500-security | security-assessment, threat-modeling | Guardian, Gatekeeper |
| 01900-procurement | procurement-workflows, supplier-management | Procurement Specialist |
| 00850-civil-engineering | civil-design, structural-analysis | Civil Engineer |
| 01700-logistics | logistics-planning, supply-chain | Logistics Agent |

### Skill Level Requirements

| Issue Complexity | Minimum Skill Level |
|------------------|---------------------|
| Simple | Basic |
| Moderate | Intermediate |
| Complex | Advanced |
| Critical | Expert |

## Priority Assessment

### Priority Levels

| Priority | Description | SLA | Assignment Criteria |
|----------|-------------|-----|---------------------|
| Critical | Business-critical, immediate action | 1 hour | Expert agent, low workload |
| High | Important, time-sensitive | 4 hours | Senior agent |
| Medium | Standard priority | 24 hours | Available agent |
| Low | Can wait | 72 hours | Any qualified agent |

### Priority Factors

```javascript
const priorityFactors = {
  businessImpact: assessBusinessImpact(issue),
  urgency: assessUrgency(issue),
  dependencies: assessDependencyUrgency(issue),
  stakeholderPriority: getStakeholderPriority(issue),
  deadline: assessDeadline(issue)
};

const priorityScore = calculateWeightedScore(priorityFactors, {
  businessImpact: 0.30,
  urgency: 0.25,
  dependencies: 0.20,
  stakeholderPriority: 0.15,
  deadline: 0.10
});
```

## Dependency Mapping

### Dependency Types

| Type | Description | Routing Impact |
|------|-------------|----------------|
| **Blocking** | Must complete before dependent | Assign first |
| **Sequential** | Should complete before dependent | Maintain order |
| **Parallel** | Can complete concurrently | Route in parallel |
| **Informational** | Reference only | No routing impact |

### Dependency Resolution

```javascript
// Resolve dependencies for routing
function resolveDependencies(issues) {
  const dependencyGraph = buildDependencyGraph(issues);
  const routingOrder = topologicalSort(dependencyGraph);
  
  // Group parallelizable issues
  const parallelGroups = identifyParallelGroups(dependencyGraph);
  
  return {
    order: routingOrder,
    parallelGroups,
    criticalPath: identifyCriticalPath(dependencyGraph)
  };
}
```

## Capacity Planning

### Agent Capacity Model

```javascript
const agentCapacity = {
  maxConcurrentIssues: 3,
  currentIssues: getCurrentIssueCount(agent),
  availableSlots: 3 - getCurrentIssueCount(agent),
  averageCompletionTime: getAverageCompletionTime(agent),
  skillUtilization: calculateSkillUtilization(agent),
  bandwidthScore: calculateBandwidthScore(agent)
};
```

### Workload Balancing

```javascript
// Balance workload across agents
function balanceWorkload(issues, agents) {
  const sortedIssues = sortByPriority(issues);
  const assignments = [];
  
  for (const issue of sortedIssues) {
    const bestAgent = findBestAgent(issue, agents, assignments);
    if (bestAgent) {
      assignments.push({ issue, agent: bestAgent });
      updateAgentWorkload(bestAgent, issue);
    } else {
      // Queue for later assignment
      queueIssue(issue);
    }
  }
  
  return assignments;
}
```

## Assignment Validation

### Validation Checklist

```javascript
const validationChecklist = {
  // Skill validation
  hasRequiredSkills: validateSkills(issue, agent),
  skillLevelSufficient: validateSkillLevel(issue, agent),
  
  // Capacity validation
  hasCapacity: validateCapacity(agent),
  workloadAcceptable: validateWorkload(agent),
  
  // Priority validation
  priorityMatch: validatePriorityMatch(issue, agent),
  deadlineFeasible: validateDeadline(issue, agent),
  
  // Conflict validation
  noConflicts: validateNoConflicts(issue, agent),
  noOverAssignment: validateNoOverAssignment(agent)
};
```

### Conflict Detection

```javascript
// Detect assignment conflicts
function detectConflicts(issue, agent, existingAssignments) {
  const conflicts = [];
  
  // Check skill conflicts
  if (!hasRequiredSkills(issue, agent)) {
    conflicts.push({ type: 'skill_mismatch', severity: 'high' });
  }
  
  // Check capacity conflicts
  if (agent.currentIssues >= agent.maxConcurrentIssues) {
    conflicts.push({ type: 'capacity_exceeded', severity: 'high' });
  }
  
  // Check deadline conflicts
  if (!canMeetDeadline(issue, agent)) {
    conflicts.push({ type: 'deadline_risk', severity: 'medium' });
  }
  
  // Check dependency conflicts
  if (hasBlockingDependencies(issue, existingAssignments)) {
    conflicts.push({ type: 'dependency_blocked', severity: 'medium' });
  }
  
  return conflicts;
}
```

## Cross-Team Assignment

### Team Boundary Rules

1. **Primary Team First**: Assign to agents within the same team as the issue discipline
2. **Cross-Team Escalation**: Escalate to other teams only when primary team is at capacity
3. **Company Boundaries**: Never assign across company boundaries
4. **Team Lead Override**: Team leads can reassign within their team

### Cross-Team Routing

```javascript
// Route to cross-team agent when needed
function routeCrossTeam(issue, primaryTeamAgents) {
  const availableAgents = primaryTeamAgents.filter(a => hasCapacity(a));
  
  if (availableAgents.length > 0) {
    return assignToBestFit(issue, availableAgents);
  }
  
  // Escalate to operations director for cross-team routing
  return escalateToOperationsDirector(issue, {
    reason: 'primary_team_at_capacity',
    alternativeTeams: identifyAlternativeTeams(issue)
  });
}
```

## Assignment Monitoring

### Real-time Monitoring

```javascript
// Monitor assignment health
const assignmentHealth = {
  pendingAssignments: countPendingAssignments(),
  overdueAssignments: countOverdueAssignments(),
  capacityUtilization: calculateCapacityUtilization(),
  assignmentAccuracy: measureAssignmentAccuracy(),
  reassignmentRate: calculateReassignmentRate()
};
```

### Health Thresholds

| Metric | Healthy | Warning | Critical |
|--------|---------|---------|----------|
| Pending Assignments | < 10 | 10-25 | > 25 |
| Overdue Rate | < 5% | 5-15% | > 15% |
| Capacity Utilization | 60-80% | 80-90% | > 90% |
| Reassignment Rate | < 10% | 10-20% | > 20% |

## Assignment Optimization

### Optimization Strategies

1. **Skill-Based Pooling**: Group similar issues for specialized agents
2. **Batch Assignment**: Assign multiple related issues to same agent
3. **Load Shifting**: Move issues from overloaded to underutilized agents
4. **Priority Boosting**: Accelerate high-priority issue routing
5. **Dependency Batching**: Route dependent issues together

### Optimization Algorithm

```javascript
// Optimize assignments for efficiency
function optimizeAssignments(issues, agents) {
  // Phase 1: Initial assignment
  const initialAssignments = greedyAssignment(issues, agents);
  
  // Phase 2: Load balancing
  const balancedAssignments = rebalanceWorkload(initialAssignments, agents);
  
  // Phase 3: Dependency optimization
  const optimizedAssignments = optimizeDependencies(balancedAssignments);
  
  // Phase 4: Final validation
  return validateAllAssignments(optimizedAssignments);
}
```

## Success Metrics

- **Assignment Accuracy**: 95%+ correct skill matching
- **First-Pass Success Rate**: 90%+ issues assigned correctly on first attempt
- **Reassignment Rate**: < 10% issues requiring reassignment
- **Capacity Utilization**: 70-85% average utilization
- **Priority SLA Compliance**: 95%+ issues meeting SLA
- **Agent Satisfaction**: Balanced workload across agents

## Related Skills

- `paperclip-api-integration` - API operations for assignment management
- `board-orchestration-management` - Board-level orchestration
- `dispatching-parallel-agents` - Parallel agent dispatch
- `capacity-planning` - Resource capacity planning
- `risk-assessment` - Risk assessment for assignments

## Best Practices

1. **Always validate skills before assignment**
2. **Check capacity before finalizing assignment**
3. **Map dependencies before routing**
4. **Monitor workload balance continuously**
5. **Escalate conflicts to operations director**
6. **Document assignment rationale**
7. **Track and learn from reassignments**
