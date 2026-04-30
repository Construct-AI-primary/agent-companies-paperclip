---
memory_layer: durable_knowledge
para_section: pages/hitl-testing
gigabrain_tags: testing, hitl-testing, hermes-agent, human-in-the-loop, task-management, notifications, workflow-integration, error-tracking
openstinger_context: hitl-testing-documentation
last_updated: 2026-04-02
---

# HITL (Human-in-the-Loop) System Production Testing Document

## System Overview

The Human-in-the-Loop (HITL) system integrates AI agents (including Hermes and other agents) with human oversight capabilities. When AI agents encounter decisions requiring human judgment, uncertainty, or compliance verification, they can create HITL tasks that are managed through a structured workflow system.

### Core Components
- **HITL Task Management**: Creation, assignment, resolution, and tracking of human intervention tasks
- **Agent Workflow Integration**: Seamless integration with AI agent execution workflows
- **Notification System**: Alerts for task creation and status updates
- **UI Panels and Modals**: Interfaces for task review and decision making
- **Data Persistence**: Local storage and state management

### Key System Characteristics
- **Async Operation**: Non-blocking task creation and evaluation
- **Audit Trail**: Complete logging of decisions and timestamps
- **Performance Monitoring**: Metrics on resolution times and success rates
- **Error Handling**: Robust error tracking and recovery mechanisms

## Source Files

The HITL system is implemented through the following React hooks and utilities:

- `/Users/chadferguson/.cline/worktrees/0c4c9/construct_ai/.clinerules/hooks/useHITLManager.js` - Core task management hook
- `/Users/chadferguson/.cline/worktrees/0c4c9/construct_ai/.clinerules/hooks/useAgentWorkflowTracker.js` - Agent workflow integration
- `/Users/chadferguson/.cline/worktrees/0c4c9/construct_ai/.clinerules/hooks/useDocumentProcessingTracker.js` - Document processing workflow integration

## Key Features to Test

1. **Task Creation**: Automated creation of HITL tasks by agents
2. **Assignment**: Manual and automated task assignment to human operators
3. **Resolution**: Human decision making and task completion
4. **Rejection**: Task rejection with reasons and comments
5. **Retrieval**: Filtering and querying tasks by status, agent, and priority
6. **Statistics**: Metrics and reporting on task performance
7. **UI Panel**: Task management dashboard for operators
8. **Task Review Modal**: Individual task review and decision interface
9. **Notification Service**: Real-time alerts for task events
10. **Workflow Event Integration**: Agent workflow triggering and synchronization
11. **Task Monitoring**: Real-time monitoring and status updates
12. **Data Persistence**: Task data retention and recovery

## Testing Requirements

### Functional Testing
- Core task lifecycle operations (create, assign, resolve, reject)
- Data integrity and state management
- Agent-HITL integration points
- UI responsiveness and usability

### Integration Testing
- Agent workflow state changes
- Notification system connectivity
- UI component interactions
- Data persistence across sessions

### Edge Cases Testing
- Concurrent task operations
- Large task volumes (>100 active tasks)
- Network disconnect scenarios
- Invalid task data handling
- Permission and access control

### Performance Testing
- Task creation throughput (>10 tasks/second)
- Query response times (<100ms for task retrieval)
- Storage performance with >10,000 historical tasks
- Memory usage during sustained operation

## Test Cases

### Functional Test Suite

#### TC-HITL-001: Basic Task Creation
**Description**: Test creation of HITL tasks from agent workflows

**Priority**: Critical (P1)

**Prerequisites**:
- Agent workflow system active
- Hermes agent or test agent running
- HITL manager hook initialized

**Test Data**:
```javascript
const testTask = {
  agentName: 'Hermes',
  taskType: 'approval_required',
  context: {
    decisionType: 'content_moderation',
    contentId: 'test-123',
    confidence: 0.65
  },
  priority: 'high'
};
```

**Steps**:
1. Initialize useHITLManager hook with workflow ID
2. Call createHITLTask() with test data
3. Verify task object creation
4. Check localStorage persistence
5. Validate task ID generation and uniqueness

**Expected Results**:
- Task object returned with valid ID
- Task stored in localStorage ('constructAI_hitl_tasks')
- Console logs HITL task creation message
- Task status set to 'pending'
- All required fields populated correctly

**Pass/Fail**:

#### TC-HITL-002: Task Assignment
**Description**: Test assignment of HITL tasks to human operators

**Priority**: Critical (P1)

**Prerequisites**:
- Active HITL task in 'pending' status
- Valid user credentials
- Assignment permissions enabled

**Test Data**:
```javascript
const assignmentData = {
  taskId: 'hitl_1712030400000_xyz',
  userId: 'operator-001',
  userName: 'John Doe'
};
```

**Steps**:
1. Create a pending HITL task
2. Call assignHITLTask() with assignment data
3. Verify task status change in localStorage
4. Check assignedTo field updates
5. Validate assignedAt timestamp
6. Confirm console logging

**Expected Results**:
- Task status changes from 'pending' to 'assigned'
- assignedTo object populated with user details
- assignedAt timestamp within last 5 seconds
- localStorage updated correctly
- Assignment logged in console

**Pass/Fail**:

#### TC-HITL-003: Task Resolution
**Description**: Test positive resolution (approval) of assigned tasks

**Priority**: Critical (P1)

**Prerequisites**:
- Assigned HITL task available
- User permissions for task resolution
- Task in 'assigned' status

**Test Data**:
```javascript
const resolutionData = {
  taskId: 'hitl_1712030400000_xyz',
  decision: 'approved',
  comments: 'Content meets quality standards'
};
```

**Steps**:
1. Assign HITL task to test user
2. Call resolveHITLTask() with resolution data
3. Verify status change and decision recording
4. Check comments array population
5. Validate completedAt timestamp
6. Confirm data persistence

**Expected Results**:
- Task status changes to 'completed'
- decision field matches input value
- Comments added to comments array with timestamp
- completedAt timestamp set
- All changes persisted to localStorage

**Pass/Fail**:

#### TC-HITL-004: Task Rejection
**Description**: Test rejection of HITL tasks with reasons

**Priority**: Critical (P1)

**Prerequisites**:
- Assigned HITL task
- Rejection permissions enabled
- Decision workflow supports rejection

**Test Data**:
```javascript
const rejectionData = {
  taskId: 'hitl_1712030400000_xyz',
  reason: 'policy_violation',
  comments: 'Content violates community guidelines'
};
```

**Steps**:
1. Assign existing HITL task
2. Call rejectHITLTask() with rejection data
3. Verify rejection status and reason recording
4. Check comments array update
5. Validate completion timestamp
6. Confirm no further assignment allowed

**Expected Results**:
- Task status set to 'rejected'
- decision field set to 'rejected'
- Reason and comments added to comments array
- completedAt timestamp recorded
- Task marked as final state

**Pass/Fail**:

#### TC-HITL-005: Task Retrieval and Filtering
**Description**: Test querying and filtering HITL tasks

**Priority**: High (P2)

**Prerequisites**:
- Multiple HITL tasks in various states
- getHITLTasks function available
- Local storage populated with test data

**Test Data**:
```javascript
const filterScenarios = [
  { status: null, agentName: null }, // All tasks
  { status: 'pending', agentName: null }, // Pending only
  { status: null, agentName: 'Hermes' }, // Hermes tasks only
  { status: 'completed', agentName: 'Hermes' } // Completed Hermes tasks
];
```

**Steps**:
1. Create multiple tasks with different statuses and agents
2. Call getHITLTasks() with various filter combinations
3. Verify returned arrays match expected criteria
4. Test edge cases (no matching tasks, invalid filters)
5. Confirm workflow ID filtering works

**Expected Results**:
- Correct task arrays returned for each filter
- Workflow-specific filtering applied
- Empty arrays for no matches
- No errors on invalid filters
- Performance acceptable (<50ms queries)

**Pass/Fail**:

#### TC-HITL-006: Statistics Generation
**Description**: Test HITL statistics and metrics calculation

**Priority**: High (P2)

**Prerequisites**:
- Multiple completed task cycles
- getHITLStats function available
- Sufficient task history for meaningful statistics

**Test Data**:
```javascript
const testStats = {
  totalTasks: 50,
  completedTasks: 35,
  rejectedTasks: 5,
  hermesTasks: 20
};
```

**Steps**:
1. Populate localStorage with diverse task data
2. Call getHITLStats() function
3. Verify statistics calculation accuracy
4. Check agent-wise and task-type breakdowns
5. Validate resolution time calculations

**Expected Results**:
- Accurate total counts by status
- Correct agent performance metrics
- Proper task type categorization
- Resolution time averages calculated
- Statistics limited to current workflow

**Pass/Fail**:

#### TC-HITL-007: Agent Workflow Integration
**Description**: Test HITL triggering from agent workflows

**Priority**: Critical (P1)

**Prerequisites**:
- useAgentWorkflowTracker hook active
- Hermes agent workflow running
- HITL enabled for workflow

**Test Data**:
```javascript
const triggerData = {
  agentName: 'Hermes',
  reason: 'low_confidence_score',
  context: {
    confidence: 0.6,
    threshold: 0.8,
    content: 'Test content for review'
  }
};
```

**Steps**:
1. Initialize agent workflow tracker
2. Call triggerHITL() with test data
3. Verify HITL event logging
4. Check task creation synchronization
5. Confirm event persistence

**Expected Results**:
- HITL event logged to localStorage
- Console logging shows trigger message
- No workflow blocking occurs
- Event data includes workflow context

**Pass/Fail**:

#### TC-HITL-008: Notification Service Integration
**Description**: Test notification alerts for task events

**Priority**: High (P2)

**Prerequisites**:
- Notification system configured
- User notification preferences set
- Task events triggering notifications

**Test Data**:
```javascript
const notificationScenarios = [
  { event: 'task_created', user: 'operator-001' },
  { event: 'task_assigned', user: 'operator-002' },
  { event: 'task_due_soon', user: 'operator-001' }
];
```

**Steps**:
1. Configure notification service
2. Trigger various task events
3. Monitor notification delivery
4. Verify notification content
5. Check user receipt and acknowledgement

**Expected Results**:
- Notifications sent for relevant events
- Content includes task details
- Delivery confirmation working
- No duplicate notifications
- User preferences respected

**Pass/Fail**:

### Integration Test Suite

#### TC-HITL-INT-001: Workflow State Synchronization
**Description**: Test HITL impact on agent workflow states

**Priority**: Critical (P1)

**Prerequisites**:
- Running agent workflow with HITL integration
- Multiple workflow steps configured
- HITL enabled workflow tracking

**Test Data**:
```javascript
const workflowConfig = {
  id: 'test-workflow-123',
  steps: ['data_ingestion', 'processing', 'hitl_check', 'final_output']
};
```

**Steps**:
1. Start workflow with HITL integration
2. Process workflow until HITL trigger point
3. Verify HITL task creation
4. Check workflow pause state
5. Resolve HITL task
6. Confirm workflow resumption

**Expected Results**:
- Workflow pauses at HITL trigger
- Task created with workflow context
- Workflow state shows HITL pending
- Resolution allows workflow continuation
- No workflow corruption

**Pass/Fail**:

#### TC-HITL-INT-002: UI Panel Data Binding
**Description**: Test UI panel integration with HITL data

**Priority**: High (P2)

**Prerequisites**:
- UI panel component loaded
- HITL manager active
- Real-time updates enabled

**Test Data**:
```javascript
const uiScenario = {
  operator: 'test-operator',
  filters: ['pending', 'assigned', 'high_priority'],
  refreshInterval: 5000
};
```

**Steps**:
1. Load HITL dashboard UI
2. Create tasks through HITL manager
3. Verify UI updates automatically
4. Test filtering functionality
5. Check real-time notifications

**Expected Results**:
- UI reflects current HITL state
- Real-time updates work
- Filtering operates correctly
- No UI blocking on data loads
- Error states handled gracefully

**Pass/Fail**:

### Edge Cases Test Suite

#### TC-HITL-EDGE-001: Concurrent Operations
**Description**: Test multiple simultaneous HITL operations

**Priority**: Medium (P3)

**Prerequisites**:
- Multiple HITL managers active
- Same workflow or different workflows
- Concurrent task creation capability

**Test Data**:
```javascript
const concurrentTasks = 10; // Number of simultaneous operations
```

**Steps**:
1. Initialize multiple HITL managers
2. Trigger concurrent task creation
3. Perform simultaneous assignments
4. Execute concurrent resolutions
5. Monitor system stability and data integrity

**Expected Results**:
- All operations complete successfully
- No race conditions or data corruption
- Task IDs remain unique
- localStorage integrity maintained
- Performance doesn't degrade significantly

**Pass/Fail**:

#### TC-HITL-EDGE-002: Large Data Volume Handling
**Description**: Test system behavior with high task volumes

**Priority**: Medium (P3)

**Prerequisites**:
- Clean localStorage state
- Batch task creation capability
- Statistics calculation active

**Test Data**:
```javascript
const bulkTestData = {
  taskCount: 1000,
  agents: ['Hermes', 'Apollo', 'Athena'],
  taskTypes: ['approval', 'review', 'verification']
};
```

**Steps**:
1. Generate bulk test tasks
2. Process retrieval queries
3. Calculate statistics
4. Test filtering on large datasets
5. Monitor memory usage and performance

**Expected Results**:
- All bulk operations complete
- Query performance remains acceptable
- Statistics calculated accurately
- No memory leaks detected
- Browsing and filtering smooth

**Pass/Fail**:

#### TC-HITL-EDGE-003: Network Failure Recovery
**Description**: Test behaviour during connectivity issues

**Priority**: Medium (P3)

**Prerequisites**:
- Local storage persistence working
- Offline task management capability
- Sync mechanism when online

**Test Data**:
```javascript
const offlineScenario = {
  offlineDuration: 300000, // 5 minutes
  pendingTasks: 5,
  offlineActions: ['create', 'assign', 'resolve']
};
```

**Steps**:
1. Create tasks in online state
2. Simulate network disconnect
3. Perform local operations
4. Restore connectivity
5. Verify data synchronization

**Expected Results**:
- Local operations work offline
- Data integrity maintained
- Successful sync on reconnection
- No data loss during outage
- UI updates correctly after sync

**Pass/Fail**:

### Performance Test Suite

#### TC-HITL-PERF-001: Task Creation Throughput
**Description**: Test rapid task creation performance

**Priority**: High (P2)

**Prerequisites**:
- Performance monitoring tools configured
- Clean baseline measurements
- Multiple agents available for testing

**Test Data**:
```javascript
const performanceTargets = {
  creationRate: 20, // tasks per second
  duration: 30000, // 30 seconds test
  expectedTotal: 600 // total tasks created
};
```

**Steps**:
1. Start performance monitoring
2. Execute rapid task creation loop
3. Measure creation rates and success
4. Monitor CPU and memory usage
5. Analyze localStorage performance

**Expected Results**:
- Meets creation rate targets (20 TPS)
- No failures during rapid creation
- Memory usage remains stable
- localStorage operations performant
- System responsive during load

**Pass/Fail**:

## Test Execution Summary Template

### Test Session Information
**Test Session ID**: TS-[Date]-[Time]-[Tester]

**Environment**:
- Browser Version:
- Node.js Version:
- Operating System:
- Hardware Configuration:

**Testers**:
- Primary Tester:
- Secondary Tester:

### Summary Metrics
**Test Cases Executed**: [X]/[Y] (Pass Rate: [Z]%)

**Critical Issues Found**: [Count]
**Blocker Issues**: [Count]
**Major Issues**: [Count]
**Minor Issues**: [Count]

**Performance Results**:
- Task Creation Rate: [X] TPS
- Query Response Time: [X] ms (avg)
- Memory Usage Peak: [X] MB

### Detailed Results by Category

#### Functional Testing
- **Pass Rate**: [X]%
- **Issues**: [List major findings]
- **Performance**: [Acceptable/Degraded/Blocked]

#### Integration Testing
- **Pass Rate**: [X]%
- **Issues**: [List major findings]
- **Coverage**: [Actual vs Target]

#### Edge Cases Testing
- **Pass Rate**: [X]%
- **Issues**: [List major findings]
- **Recommendations**: [For robustness improvements]

#### Performance Testing
- **Pass Rate**: [X]%
- **Issues**: [List bottlenecks]
- **Recommendations**: [For optimization]

### Risk Assessment
**Production Readiness**: [Go/No-Go/With-Cautions]

**Risk Level**: [Low/Medium/High/Critical]

**Blocking Issues**: [List any critical blockers]

### Recommendations
**Immediate Actions**:
- [List items requiring immediate attention]

**Short Term**:
- [List items for next sprint/iteration]

**Long Term**:
- [List architectural or strategic improvements]

**Testing Improvements**:
- [Suggestions for better test coverage or automation]

### Sign-off
**Test Lead**: ____________ Date: __________

**Product Owner**: ____________ Date: __________

**Development Lead**: ____________ Date: __________

## Error Reporting

If errors are encountered during HITL system testing, create error report markdown documents in `/Users/chadferguson/Documents/construct_ai/docs-construct-ai/error-tracking/` with the following naming convention and format:

### Error Report Format

```markdown
---
error_id: ERR-HITL-[Date]-[Sequence]-[Component]
timestamp: 2026-04-02T[HH]:[MM]:[SS]Z
affected_component: [e.g., hitl-manager, workflow-tracker, ui-panel]
severity: critical|major|minor|info
status: open|investigating|resolved|closed
priority: P1|P2|P3
reported_by: [Tester Name]
assigned_to: [Developer/Team]
---

# Error Report: [Brief Title]

## Error Summary
[Brief description of the error]

## Environment
- **Browser/Node Version**: [version]
- **OS**: [operating system]
- **Test Case ID**: [TC-HITL-XXX]
- **Component**: [affected component]
- **Timestamp**: [when error occurred]

## Reproduction Steps
1. [Step 1]
2. [Step 2]
3. [More steps as needed]

## Expected Behavior
[What should have happened]

## Actual Behavior
[What actually happened]

## Error Details
### Console Logs
```
[Paste relevant console output here]
```

### Error Messages
```
[Paste error messages, stack traces, etc.]
```

### Screenshots/Artifacts
- [Attach screenshots if UI-related]
- [Include network logs if applicable]

## Impact Assessment
### User Impact
[Describe impact on end users]

### System Impact
[Describe impact on system functionality]

### Business Impact
[Describe business consequences]

## Root Cause Analysis
[Initial analysis of likely cause]

## Mitigation Steps
[Temporary workarounds or fixes]

## Resolution Steps
[Steps to permanently resolve the issue]

## Related Issues
- [Link to related test cases]
- [Link to relevant requirements]
- [Link to other error reports]

## Resolution Verification
### Test Steps
1. [Steps to verify fix]

### Test Results
[Pass/Fail status after fix]

## Comments and Updates
### [Date/Time] - [Author]
[Additional notes, progress updates, etc.]
```

### Error Report File Naming Convention
- `ERR-HITL-20260402-001-Manager.md` (Task Manager errors)
- `ERR-HITL-20260402-002-Workflow.md` (Workflow Integration errors)
- `ERR-HITL-20260402-003-UI.md` (UI Component errors)
- `ERR-HITL-20260402-004-Performance.md` (Performance-related errors)

Use sequential numbering for the same day and component errors.

### Error Tracking Categories
Create subdirectories as needed for organization:
- `🔧 Business Logic Errors/`
- `🗄️ Database & System Errors/`
- `🎯 Format-Specific Processing Errors/`
- `⚡ Performance & Optimization Errors/`
- `🖥️ UI/UX Errors/`
- `🔗 Integration Errors/`
- `🔒 Security & Permissions Errors/`

All error reports should cross-reference this testing document and include the relevant test case IDs.