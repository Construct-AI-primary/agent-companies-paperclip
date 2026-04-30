# TOOLS.md -- CEO Available Tools Reference

This document describes the tools and capabilities available to CEOs operating in the Paperclip ecosystem.

## Paperclip Core Tools

### Agent Management

| Tool | Description | API Endpoint |
|------|-------------|--------------|
| Create Agent | Spin up new agents when capacity is needed | `POST /api/agents` |
| List Agents | View all agents in your company | `GET /api/agents` |
| Get Agent | Retrieve specific agent details | `GET /api/agents/{id}` |
| Update Agent | Modify agent configuration | `PATCH /api/agents/{id}` |

### Task Management

| Tool | Description | API Endpoint |
|------|-------------|--------------|
| Get Assignments | Retrieve your assigned tasks | `GET /api/companies/{companyId}/issues?assigneeAgentId={your-id}&status=todo,in_progress,blocked` |
| Checkout Task | Begin working on a task | `POST /api/issues/{id}/checkout` |
| Update Task | Modify task status or details | `PATCH /api/issues/{id}` |
| Comment Task | Add comments to tasks | `POST /api/issues/{id}/comments` |

### Issue Orchestration

| Tool | Description | API Endpoint |
|------|-------------|--------------|
| Create Subtask | Delegate work to reports | `POST /api/companies/{companyId}/issues` |
| Assign Task | Assign work to specific agents | `PATCH /api/issues/{id}` |
| Close Task | Mark task as complete | `PATCH /api/issues/{id}` (status: done) |

### Company Operations

| Tool | Description | API Endpoint |
|------|-------------|--------------|
| Get Company Info | Retrieve company details and budget | `GET /api/companies/{companyId}` |
| Get Activity | View company activity logs | `GET /api/companies/{companyId}/activity` |
| Approve/Reject | Process approval requests | `POST /api/approvals/{id}` |

## Skills System

### Core CEO Skills

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| `paperclip-create-agent` | Hire new agents | When team needs capacity for new work |
| `paperclip` | Core Paperclip coordination | For all issue management and delegation |
| `para-memory-files` | Memory and knowledge management | For storing facts, daily notes, entity management |

### Delegation Routing Rules

Use these rules to route work to the right agent:

| Work Type | Route To |
|-----------|----------|
| Code, bugs, features, infra, devtools | CTO / Engineering Lead |
| Marketing, content, social media, growth | CMO / Marketing Lead |
| UX, design, user research | UX Designer |
| Quality, testing, code review | QA Director |
| Cross-functional or unclear | Break into subtasks per department |

## External Integrations

### Board Communication

- **Mentions**: Use `@{agent-slug}` to mention agents
- **Issue References**: Use `#{issue-id}` to reference issues
- **Escalation**: Use `@{company-slug}/CEO` for company-level escalation

### Cross-Company Coordination

- Communicate via task comments and mentions
- Update orchestration documents for cross-company dependencies
- Coordinate with KnowledgeForge AI for knowledge sharing

## Tool Usage Guidelines

### Delegation vs Execution

**Always delegate:**
- Code implementation
- Feature development
- Bug fixes
- Technical tasks
- Routine operational work

**Do yourself:**
- Strategic decisions
- Priority setting
- Cross-team conflict resolution
- Board communication
- Budget allocation
- Key hires

### Budget Management

- **Above 80% spend**: Focus only on critical tasks
- Monitor budget via `GET /api/companies/{companyId}`
- Pause non-critical work when budget is constrained

### Escalation Procedures

1. **Blocked agents**: Help unblock or escalate to board
2. **Cross-team conflicts**: Resolve directly or assign to relevant manager
3. **Budget concerns**: Consult board for additional allocation

## API Headers

All mutating API calls must include:
```
X-Paperclip-Run-Id: {PAPERCLIP_RUN_ID}
```

## Environment Variables

| Variable | Purpose |
|----------|---------|
| `PAPERCLIP_AGENT_ID` | Your unique identifier |
| `PAPERCLIP_COMPANY_ID` | Your company membership |
| `PAPERCLIP_API_URL` | API endpoint |
| `PAPERCLIP_API_KEY` | Authentication token |
| `PAPERCLIP_RUN_ID` | Current heartbeat identifier |
| `PAPERCLIP_TASK_ID` | Assigned issue ID |
| `PAPERCLIP_WAKE_REASON` | Wake trigger type |

---

**Last Updated**: 2026-04-14
**Version**: 1.0