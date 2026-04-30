---
name: hitl-review-approval
description: >
  Use when reviewing and approving issues before submission to Paperclip board.
  Implements Human-in-the-Loop (HITL) quality gate for discipline automation.
  Covers review criteria, approval workflow, rejection handling, and escalation.
company: promptforge-ai
---

# HITL Review and Approval

## Overview

This skill implements a Human-in-the-Loop (HITL) quality gate between issue preparation and Paperclip submission. All issues must pass human review before being submitted to the Paperclip board, ensuring quality, accuracy, and alignment with organizational goals.

## When to Use This Skill

- Reviewing prepared issues before Paperclip submission
- Approving or rejecting generated issues
- Requesting modifications to issues
- Escalating disputed decisions
- Auditing the review process
- Managing approval quotas and SLAs

## Workflow Position

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│ Issue           │───▶│ HITL Review     │───▶│ Paperclip       │───▶│ Execution        │
│ Preparation     │    │ & Approval      │    │ Submission      │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘    └─────────────────┘
                           ▲ HITL GAP
                      Human Quality Gate
```

## Review Criteria

### 1. Completeness Check

| Criteria | Requirement | Weight |
|----------|-------------|--------|
| Title | Clear, actionable, < 80 chars | Required |
| Description | Detailed, < 500 chars minimum | Required |
| Assignee | Valid agent slug, exists | Required |
| Priority | Critical/High/Medium/Low | Required |
| Platform | desktop/mobile/web/shared | Required |
| Discipline Code | Valid CSI format (02500) | Required |

### 2. Quality Assessment

| Criteria | Requirement | Weight |
|----------|-------------|--------|
| Clarity | Unambiguous language | 20% |
| Actionability | Clear next steps | 25% |
| Dependencies | Properly mapped | 15% |
| Estimates | Realistic effort | 15% |
| Acceptance Criteria | Measurable outcomes | 25% |

### 3. Alignment Check

| Criteria | Requirement | Weight |
|----------|-------------|--------|
| Project Fit | Aligns with project goals | 30% |
| Company Strategy | Supports company priorities | 25% |
| Resource Availability | Agents with skills available | 25% |
| Timeline Feasibility | Can meet deadline | 20% |

## Review Actions

### Action 1: Approve

```javascript
const approvalAction = {
  action: 'approve',
  timestamp: new Date().ISOString(),
  reviewer: 'human-reviewer-id',
  confidence: 0.95,
  notes: 'Issue meets all criteria',
  signature: 'base64-encoded-signature'
};
```

### Action 2: Request Changes

```javascript
const changeRequest = {
  action: 'request_changes',
  timestamp: new Date().ISOString(),
  reviewer: 'human-reviewer-id',
  requiredChanges: [
    { field: 'priority', current: 'low', required: 'high' },
    { field: 'description', current: 'vague', required: 'specific' }
  ],
  rationale: 'Priority mismatch with project urgency',
  deadline: '2026-04-16T12:00:00Z'
};
```

### Action 3: Reject

```javascript
const rejectionAction = {
  action: 'reject',
  timestamp: new Date().ISOString(),
  reviewer: 'human-reviewer-id',
  reason: {
    code: 'OUT_OF_SCOPE',
    details: 'Issue belongs to different discipline'
  },
  alternatives: ['Consider PROC-001 instead', 'Split into two issues']
};
```

### Action 4: Escalate

```javascript
const escalationAction = {
  action: 'escalate',
  timestamp: new Date().ISOString(),
  reviewer: 'human-reviewer-id',
  escalateTo: 'operations-director',
  reason: 'Novel scenario requiring leadership input',
  urgency: 'high'
};
```

## Review Queue Management

### Queue Rules

```javascript
const queueRules = {
  maxQueueSize: 50,
  slaHours: {
    critical: 1,
    high: 4,
    medium: 24,
    low: 72
  },
  escalationThreshold: {
    critical: 30,    // minutes
    high: 120,      // minutes
    medium: 480,    // minutes
    low: 1440       // minutes
  },
  batchReview: {
    enabled: true,
    minBatchSize: 5,
    maxBatchSize: 20
  }
};
```

### Priority Sorting

```javascript
function sortReviewQueue(issues) {
  return issues.sort((a, b) => {
    // Priority first (descending)
    if (a.priority !== b.priority) {
      const priorityOrder = { critical: 0, high: 1, medium: 2, low: 3 };
      return priorityOrder[a.priority] - priorityOrder[b.priority];
    }
    
    // Then by age (oldest first)
    return new Date(a.createdAt) - new Date(b.createdAt);
  });
}
```

## Review Dashboard

### Metrics

| Metric | Target | Warning | Critical |
|--------|--------|---------|----------|
| Queue Depth | < 10 | 10-25 | > 25 |
| Avg Review Time | < 2 hours | 2-4 hours | > 4 hours |
| Approval Rate | > 80% | 70-80% | < 70% |
| Change Request Rate | < 15% | 15-25% | > 25% |
| Rejection Rate | < 5% | 5-10% | > 10% |

### Dashboard Data

```javascript
function generateReviewDashboard() {
  return {
    queue: {
      total: countPendingReviews(),
      byPriority: groupByPriority(),
      oldestIssue: getOldestPendingIssue()
    },
    performance: {
      avgReviewTime: calculateAvgReviewTime(),
      throughput: calculateThroughput(),
      slaCompliance: calculateSLACompliance()
    },
    quality: {
      approvalRate: calculateApprovalRate(),
      changeRequestRate: calculateChangeRequestRate(),
      rejectionRate: calculateRejectionRate()
    },
    trends: {
      dailyVolume: getDailyVolume(),
      weeklyComparison: compareWeekly()
    }
  };
}
```

## Integration with Issue Generation

### Pre-Submission Hook

```javascript
async function preSubmissionHook(issue) {
  // 1. Add to review queue
  await addToReviewQueue(issue);
  
  // 2. Notify reviewer
  await notifyReviewer(issue);
  
  // 3. Start SLA timer
  await startSLATimer(issue);
  
  // 4. Return queue position
  return {
    issueId: issue.id,
    queuePosition: await getQueuePosition(issue),
    estimatedWait: await estimateWaitTime(issue.priority)
  };
}
```

### Post-Approval Hook

```javascript
async function postApprovalHook(issue, approval) {
  // 1. Record approval
  await recordApproval(issue, approval);
  
  // 2. Clear SLA timer
  await clearSLATimer(issue);
  
  // 3. Submit to Paperclip
  await submitToPaperclip(issue);
  
  // 4. Update metrics
  await incrementApprovalMetric();
  
  return { status: 'submitted', paperclipId: await getPaperclipId(issue) };
}
```

## Success Metrics

- **Review SLA Compliance**: > 95% within SLA
- **Approval Rate**: 80-90% optimal
- **Change Request Accuracy**: < 15% with valid changes
- **Rejection Justification**: 100% documented
- **Cycle Time**: < 4 hours average

## Related Skills

- `issue-generation-optimization` - Issue preparation before review
- `paperclip-api-integration` - Submission after approval
- `inter-company-delegation` - Cross-company review coordination
- `skill-validation-remediation` - Skill alignment verification

## Best Practices

1. **Review in batches** - Group similar issues for efficiency
2. **Document decisions** - Always provide rationale for changes/rejections
3. **Provide alternatives** - When rejecting, suggest alternatives
4. **Monitor SLAs** - Escalate before breaching SLA
5. **Track patterns** - Identify recurring issues for upstream fixes
6. **Balance speed/quality** - Fast approval for routine issues
7. **Escalate novel scenarios** - Don't guess on unprecedented situations
