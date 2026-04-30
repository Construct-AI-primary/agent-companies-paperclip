---
title: PROD-TEST HITL Workflow - Human-in-the-Loop Decision Framework
date: 2026-04-25
version: 1.0
status: draft
project: PROD-TEST
phase: all
---

# PROD-TEST HITL Workflow

## Human-in-the-Loop Decision Framework for Production Testing

---

## 1. Overview

This document defines the Human-in-the-Loop (HITL) workflow for the PROD-TEST production testing project. It establishes clear decision criteria, escalation paths, and approval processes for handling errors detected during testing execution.

### 1.1 Purpose

- Provide clear decision criteria for when human intervention is required
- Define escalation paths for different severity levels
- Establish approval chains for budget and timeline impacts
- Ensure consistent error handling across all 14 testing issues

### 1.2 Scope

Applies to all PROD-001 through PROD-014 issues in the PROD-TEST project.

---

## 2. Severity Classification

### 2.1 Five-Tier Severity System

| Level | Name | Description | Examples | Auto-Fix |
|-------|------|-------------|----------|----------|
| **SEV-1** | Critical | System unusable, data loss risk, security breach | Database corruption, auth bypass, data leakage | ❌ No |
| **SEV-2** | High | Major feature broken, workflow blocked | Login failure, payment broken, data not saving | ⚠️ Limited |
| **SEV-3** | Medium | Feature degraded, workarounds exist | Slow performance, minor UI glitch | ✅ Yes |
| **SEV-4** | Low | Minor issue, cosmetic | Typo, color mismatch | ✅ Yes |
| **SEV-5** | Trivial | Non-functional | Spacing, formatting | ✅ Yes |

### 2.2 Severity Classification Rules

#### SEV-1 (Critical) - MUST Escalate

- Authentication system completely fails
- Database connection cannot be established
- Data loss or corruption detected
- Security vulnerability exposed
- System crashes or becomes unresponsive
- Critical data (user info, payments) exposed

#### SEV-2 (High) - Escalate for Approval

- Login flow broken for specific scenarios
- User creation fails
- Database operations fail partially
- Core UI component fails to render
- API endpoints return 5xx errors
- Session management broken

#### SEV-3 (Medium) - Document & Monitor

- Feature works but with degraded performance
- Minor functionality missing
- UI displays incorrectly but is usable
- Non-critical API errors
- Warning messages in logs
- Partial feature failures

#### SEV-4 (Low) - Auto-Fix Allowed

- Minor UI styling issues
- Non-critical text errors
- Cosmetic layout issues
- Performance below threshold but functional
- Minor accessibility issues

#### SEV-5 (Trivial) - Auto-Fix

- Typos in text
- Spacing issues
- Color variations
- Non-functional decorative elements

---

## 3. HITL Decision Matrix

### 3.1 Decision Flow

```
                    ┌─────────────────────────────┐
                    │     ERROR DETECTED          │
                    └─────────────┬───────────────┘
                                  │
                                  ▼
                    ┌─────────────────────────────┐
                    │  CLASSIFY SEVERITY          │
                    │  SEV-1 to SEV-5             │
                    └─────────────┬───────────────┘
                                  │
          ┌───────────────────────┼───────────────────────┐
          │                       │                       │
          ▼                       ▼                       ▼
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   SEV-1/SEV-2   │     │     SEV-3       │     │   SEV-4/SEV-5   │
│                 │     │                 │     │                 │
│ 1. Pause Testing│     │ 1. Continue     │     │ 1. Continue     │
│ 2. Document     │     │ 2. Document     │     │ 2. Document     │
│ 3. Escalate     │     │ 3. Auto-fix OK  │     │ 3. Auto-fix OK  │
│ 4. Await Action │     │ 4. Monitor      │     │ 4. Log only     │
└────────┬────────┘     └────────┬────────┘     └────────┬────────┘
         │                       │                       │
         ▼                       │                       │
┌─────────────────┐              │                       │
│  CHECK IMPACT   │              │                       │
│                 │              │                       │
│ Budget > $500?──┼──YES──→ Request Approval             │
│      │         │              │                       │
│      NO        │              │                       │
│      │         │              │                       │
│      ▼         │              │                       │
│ Timeline >     │              │                       │
│ 2 days?        │              │                       │
│      │         │              │                       │
│      NO        │              │                       │
│      │         │              │                       │
│      ▼         │              │                       │
│ Proceed with   │              │                       │
│ fix (approved) │              │                       │
└─────────────────┘              │                       │
                                ▼                       │
                    ┌─────────────────────────────┐    │
                    │   CONTINUE TESTING          │    │
                    │   Document all findings     │────┘
                    └─────────────────────────────┘
```

### 3.2 HITL Trigger Conditions

| Condition | Severity | Required Action | Escalate To | Response Time |
|-----------|----------|-----------------|-------------|---------------|
| SEV-1 error detected | Critical | Pause & Escalate | Project Lead + Security | Immediate (< 15 min) |
| SEV-2 error detected | High | Pause & Request Approval | Project Lead | < 1 hour |
| Budget impact > $500 | Financial | Request Approval | Project Lead | < 4 hours |
| Budget impact > $2000 | Financial | Executive Approval | CEO | < 24 hours |
| Timeline impact > 2 days | Schedule | Request Scope Adjustment | Project Lead | < 24 hours |
| Cross-company dependency fails | Coordination | Schedule Meeting | All Involved | < 48 hours |
| Security-related error | Security | Notify Security Team | Security Lead | Immediate |
| 3+ SEV-3 errors in one phase | Pattern | Review & Assess | Project Lead | < 4 hours |

### 3.3 Approval Thresholds

| Decision Type | Threshold | Approver | SLA |
|---------------|-----------|----------|-----|
| Auto-fix SEV-3+ | Any | Agent (self-approved) | N/A |
| Fix SEV-2 error | < $500 | Project Lead | 4 hours |
| Fix SEV-2 error | $500 - $2000 | Project Lead + Budget Owner | 24 hours |
| Fix SEV-2 error | > $2000 | Executive | 48 hours |
| Scope change | Any | Project Lead | 24 hours |
| Timeline extension | > 2 days | Project Lead | 24 hours |
| Cancel issue | Any | Project Lead | 48 hours |

---

## 4. Escalation Procedures

### 4.1 Escalation Levels

```
Level 1: Agent Self-Service
├── SEV-4/SEV-5 errors
├── Auto-fix allowed
└── Document only

Level 2: Project Lead (promptforge-ai-sage)
├── SEV-2 errors
├── Budget < $500
├── Timeline < 2 days impact
└── Cross-phase coordination

Level 3: Executive (CEO / Board)
├── SEV-1 errors
├── Budget > $2000
├── Timeline > 2 days impact
├── Security issues
└── Scope changes
```

### 4.2 Escalation Communication Template

#### Level 2 Escalation (SEV-2)

```
SUBJECT: [PROD-TEST] SEV-2 Escalation - [Issue ID] - [Brief Description]

ISSUE: [Issue ID]
SEVERITY: SEV-2 (High)
DETECTED: [Timestamp]
ESCALATED BY: [Agent Name]

ERROR DESCRIPTION:
[Detailed description of the error]

IMPACT ASSESSMENT:
- User Impact: [Description]
- System Impact: [Description]
- Business Impact: [Description]

BUDGET IMPACT:
- Estimated Fix Cost: $XXX
- Contingency: XX%
- Total: $XXX

TIMELINE IMPACT:
- Estimated Fix Time: XX hours
- Timeline Delay: XX days

RECOMMENDED ACTION:
[What should be done]

ATTACHMENTS:
- Test logs
- Error screenshots
- Related documentation
```

#### Level 3 Escalation (SEV-1 / Executive)

```
SUBJECT: [PROD-TEST] 🚨 CRITICAL ESCALATION - SEV-1 - [Issue ID]

ISSUE: [Issue ID]
SEVERITY: SEV-1 (Critical)
DETECTED: [Timestamp]
ESCALATED BY: [Agent Name]

IMMEDIATE IMPACT:
- System Status: [Up/Down/Degraded]
- Users Affected: [Number/Percentage]
- Data Risk: [Yes/No/Unknown]

SECURITY IMPLICATIONS:
[If security-related, detail the vulnerability]

BUDGET IMPACT:
- Estimated Fix Cost: $XXX - $XXX
- Urgency: [Standard/Expedited]

TIMELINE IMPACT:
- Estimated Fix Time: XX - XX hours
- Timeline Delay: XX days

RECOMMENDED ACTION:
[Immediate action required]

ESCALATION CHAIN NOTIFIED:
- [ ] Project Lead
- [ ] CEO
- [ ] Security Team
- [ ] Legal (if data breach)
```

### 4.3 Response Requirements

| Escalation Level | Expected Response Time | Required Acknowledgment |
|------------------|------------------------|-------------------------|
| Level 1 (Self) | N/A | Self-document |
| Level 2 (Project Lead) | 4 hours | Written acknowledgment |
| Level 3 (Executive) | 1 hour | Phone/chat + written |

---

## 5. Error Documentation

### 5.1 Required Documentation Fields

Every error must be documented with:

```yaml
error_report:
  id: ERR-[YYYYMMDD]-[XXX]
  issue_id: PROD-XXX
  severity: SEV-X
  timestamp: "YYYY-MM-DD HH:MM:SS"
  test_case: "[Test case name]"
  environment: "[dev|staging|production]"
  
  description:
    summary: "[Brief description]"
    details: "[Detailed description]"
    steps_to_reproduce: |
      1. [Step 1]
      2. [Step 2]
      3. [Step 3]
    expected_behavior: "[What should happen]"
    actual_behavior: "[What actually happened]"
  
  classification:
    category: "[authentication|database|ui|api|security|other]"
    subcategory: "[Specific subcategory]"
    root_cause: "[Identified or suspected root cause]"
  
  impact:
    user_impact: "[None|Low|Medium|High|Critical]"
    system_impact: "[None|Low|Medium|High|Critical]"
    business_impact: "[None|Low|Medium|High|Critical]"
  
  resolution:
    hitl_required: true|false
    escalation_level: "[1|2|3]"
    approved_action: "[Action approved]"
    fix_cost: $XXX
    fix_time: XX hours
    status: "[open|in_progress|resolved|closed]"
  
  metadata:
    detected_by: "[Agent name]"
    assigned_to: "[Agent name]"
    resolved_by: "[Agent name]"
    resolution_date: "YYYY-MM-DD"
```

### 5.2 Error Report Example

```yaml
error_report:
  id: ERR-20260425-001
  issue_id: PROD-002
  severity: SEV-2
  timestamp: "2026-04-25 10:30:00"
  test_case: "login_with_invalid_credentials"
  environment: "production"
  
  description:
    summary: "Login with invalid credentials shows success message"
    details: "When a user attempts to login with incorrect password, 
             the system displays 'Login successful' instead of an 
             error message."
    steps_to_reproduce: |
      1. Navigate to login page
      2. Enter valid username
      3. Enter incorrect password
      4. Click login button
    expected_behavior: "Display error message 'Invalid credentials'"
    actual_behavior: "Display success message and redirect to dashboard"
  
  classification:
    category: "authentication"
    subcategory: "credential_validation"
    root_cause: "Likely missing server-side validation"
  
  impact:
    user_impact: "High"
    system_impact: "Medium"
    business_impact: "High"
  
  resolution:
    hitl_required: true
    escalation_level: "2"
    approved_action: "Fix validation logic in auth service"
    fix_cost: 300
    fix_time: 2
    status: "open"
  
  metadata:
    detected_by: "validator-qualityforge"
    assigned_to: "devcore-devforge"
    resolved_by: null
    resolution_date: null
```

---

## 6. Budget Tracking

### 6.1 Budget Categories

| Category | Description | Per-Issue Budget | Contingency |
|----------|-------------|------------------|-------------|
| Testing Execution | Agent time for test execution | $150 (1 hr) | 10% |
| Error Fix | Development time for fixes | Variable | 20% |
| HITL Review | Human review time | $75 (30 min) | 10% |
| Coordination | Cross-team coordination | $100 (1 hr) | 15% |
| Contingency | Unexpected issues | N/A | 15% |

### 6.2 Budget Tracking Fields

```yaml
budget_tracking:
  issue_id: PROD-XXX
  allocated_budget: $XXX
  spent_testing: $XXX
  spent_fix: $XXX
  spent_hitl: $XXX
  spent_coordination: $XXX
  total_spent: $XXX
  remaining: $XXX
  variance_percent: XX%
  status: "[under|on_track|over]"
```

### 6.3 Budget Alert Thresholds

| Threshold | Alert Level | Action |
|-----------|-------------|--------|
| 70% spent | Warning | Notify Project Lead |
| 90% spent | Alert | Request approval for additional budget |
| 100% spent | Critical | Halt work, require executive approval |
| 110% spent | Overrun | Require budget reallocation |

---

## 7. Timeline Management

### 7.1 Timeline Tracking Fields

```yaml
timeline_tracking:
  issue_id: PROD-XXX
  planned_start: "YYYY-MM-DD HH:MM"
  planned_end: "YYYY-MM-DD HH:MM"
  planned_duration: "XX hours"
  
  actual_start: "YYYY-MM-DD HH:MM"
  actual_end: null
  actual_duration: null
  
  variance_hours: XX
  variance_percent: XX%
  status: "[on_track|ahead|behind|cancelled]"
  
  milestones:
    - name: "Test Execution"
      planned: "YYYY-MM-DD HH:MM"
      actual: null
      status: "[pending|in_progress|complete]"
    - name: "Documentation"
      planned: "YYYY-MM-DD HH:MM"
      actual: null
      status: "[pending|in_progress|complete]"
    - name: "Fix Implementation"
      planned: "YYYY-MM-DD HH:MM"
      actual: null
      status: "[pending|in_progress|complete]"
    - name: "Review & Approval"
      planned: "YYYY-MM-DD HH:MM"
      actual: null
      status: "[pending|in_progress|complete]"
```

### 7.2 Timeline Alert Thresholds

| Threshold | Alert Level | Action |
|-----------|-------------|--------|
| 1 day behind | Warning | Notify Project Lead |
| 2 days behind | Alert | Request timeline adjustment |
| 3 days behind | Critical | Escalate to executive |
| Phase delay | Critical | Re-scope or re-prioritize |

---

## 8. Agent Responsibilities

### 8.1 Testing Agent (validator-qualityforge)

**Responsibilities:**
- Execute test cases per issue requirements
- Classify detected errors by severity
- Document all errors using error_report template
- Determine HITL requirements
- Request escalation when criteria met
- Track time spent per category

**Authorities:**
- Auto-fix SEV-4 and SEV-5 errors
- Escalate to Level 2 without approval
- Request Level 3 escalation

**Limitations:**
- Cannot fix SEV-1 or SEV-2 without approval
- Cannot exceed budget without approval
- Cannot extend timeline without approval

### 8.2 Project Lead (promptforge-ai-sage)

**Responsibilities:**
- Monitor all 14 issues progress
- Review and respond to Level 2 escalations
- Approve or deny fix requests
- Track overall project budget
- Manage timeline impacts
- Coordinate cross-phase dependencies

**Authorities:**
- Approve fixes up to $500
- Approve timeline adjustments up to 2 days
- Escalate to Level 3 when needed
- Re-prioritize issues within phase

**Limitations:**
- Cannot approve fixes > $2000
- Cannot extend timeline > 2 days without executive approval
- Cannot cancel issues without justification

### 8.3 Supporting Agents

#### promptforge-ai-validator
- Secondary error classification
- Syntax/logic validation of fixes
- Quality assurance of documentation

#### promptforge-ai-analyzer
- Aggregate test results
- Identify patterns
- Generate phase reports
- Recommend improvements

#### promptforge-ai-quantifier
- Track budget vs actual
- Monitor timeline adherence
- Generate cost reports
- Alert on variances

---

## 9. Workflow States

### 9.1 Issue States

| State | Description | Valid Transitions |
|-------|-------------|------------------|
| `backlog` | Not started | → `todo` |
| `todo` | Ready to start | → `in_progress`, `blocked`, `cancelled` |
| `in_progress` | Currently executing | → `in_review`, `blocked`, `done` |
| `in_review` | Awaiting HITL decision | → `in_progress`, `done`, `blocked` |
| `blocked` | Waiting on dependency | → `in_progress` |
| `done` | Completed successfully | (terminal) |
| `cancelled` | Cancelled | (terminal) |

### 9.2 Error States

| State | Description | Valid Transitions |
|-------|-------------|------------------|
| `open` | Detected, not assigned | → `assigned` |
| `assigned` | Assigned for fix | → `in_progress`, `closed` |
| `in_progress` | Fix being implemented | → `resolved`, `open` |
| `resolved` | Fix complete, pending verification | → `verified`, `open` |
| `verified` | Fix verified working | → `closed` |
| `closed` | No further action needed | (terminal) |
| `false_positive` | Not actually an error | → `closed` |

---

## 10. Reporting

### 10.1 Daily Status Report

```yaml
daily_status_report:
  date: "YYYY-MM-DD"
  project: "PROD-TEST"
  
  summary:
    issues_total: 14
    issues_completed: X
    issues_in_progress: X
    issues_blocked: X
    
  errors:
    total_detected: XX
    by_severity:
      SEV-1: X
      SEV-2: X
      SEV-3: X
      SEV-4: X
      SEV-5: X
    resolved: X
    open: X
    
  budget:
    allocated: $XX,XXX
    spent: $XX,XXX
    remaining: $XX,XXX
    variance: XX%
    
  timeline:
    on_track: X issues
    behind: X issues
    ahead: X issues
    
  escalations:
    level_2: X
    level_3: X
    
  blockers:
    - issue_id: "PROD-XXX"
      description: "[Description]"
      resolution: "[What's needed]"
```

### 10.2 Weekly Executive Summary

```yaml
weekly_executive_summary:
  week: "Week X"
  date_range: "YYYY-MM-DD to YYYY-MM-DD"
  
  progress:
    phases_completed: X/5
    issues_completed: X/14
    test_cases_executed: XXX
    test_cases_passed: XXX
    test_cases_failed: XXX
    
  quality:
    pass_rate: XX%
    critical_issues: X
    high_issues: X
    medium_issues: X
    low_issues: X
    
  budget:
    total_allocated: $XX,XXX
    total_spent: $XX,XXX
    projected_total: $XX,XXX
    variance: XX%
    
  timeline:
    planned_end_date: "YYYY-MM-DD"
    projected_end_date: "YYYY-MM-DD"
    variance_days: X
    
  risks:
    - risk: "[Description]"
      severity: SEV-X
      mitigation: "[Strategy]"
      
  next_week:
    planned_issues: ["PROD-XXX", ...]
    expected_completions: X
    anticipated_challenges: ["[Description]", ...]
```

---

## 11. Quick Reference

### 11.1 Severity at a Glance

| When you detect... | It's... | Action |
|-------------------|---------|--------|
| System crash, data loss, security breach | SEV-1 | STOP, Escalate immediately |
| Major feature broken, workflow blocked | SEV-2 | STOP, Request approval |
| Feature degraded, workaround exists | SEV-3 | Continue, auto-fix OK |
| Minor UI issue, cosmetic | SEV-4 | Continue, auto-fix OK |
| Typo, formatting | SEV-5 | Continue, auto-fix OK |

### 11.2 HITL Checklist

Before continuing past any error, confirm:

- [ ] Error classified by severity
- [ ] Error documented in error_report format
- [ ] HITL required? (SEV-1/SEV-2 = YES)
- [ ] If HITL required, escalation sent?
- [ ] Approval received? (if required)
- [ ] Budget impact calculated?
- [ ] Timeline impact calculated?
- [ ] All stakeholders notified?

### 11.3 Contact Information

| Role | Agent | Response Time |
|------|-------|---------------|
| Project Lead | promptforge-ai-sage | < 4 hours |
| Testing Agent | validator-qualityforge | Real-time |
| Error Classifier | promptforge-ai-validator | < 2 hours |
| Budget Tracker | promptforge-ai-quantifier | < 4 hours |
| Results Analyst | promptforge-ai-analyzer | < 8 hours |

---

**Document Status**: Draft
**Review Cycle**: Weekly
**Last Updated**: 2026-04-25
**Document Owner**: promptforge-ai-sage
**Approved By**: [Pending]
