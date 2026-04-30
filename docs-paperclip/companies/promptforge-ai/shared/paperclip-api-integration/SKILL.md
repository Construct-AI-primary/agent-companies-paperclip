---
name: paperclip-api-integration
description: >
  Use when integrating with Paperclip control plane API, managing agent API keys,
  creating/updating/deleting companies, teams, agents, tasks, issues, or routines.
  Covers authentication, endpoint patterns, error handling, and data synchronization.
company: promptforge-ai
---

# Paperclip API Integration

## Overview

This skill provides comprehensive guidance for integrating with the Paperclip control plane API. Paperclip is a control plane for AI-agent companies that manages companies, teams, agents, tasks, issues, and routines through a REST API.

## When to Use This Skill

- Creating or managing companies in Paperclip
- Managing teams and agent hierarchies
- Creating, updating, or deleting agents
- Managing agent API keys
- Creating and managing tasks and issues
- Setting up routines (scheduled tasks)
- Integrating external agents via adapters
- Troubleshooting API integration issues

## Paperclip Architecture

### Core Entities

| Entity | Description | Key Attributes |
|--------|-------------|----------------|
| **Company** | Top-level organization | slug, name, schema |
| **Team** | Group of agents within company | name, company_id |
| **Agent** | Individual AI agent | slug, name, company_id, team_id, adapter |
| **Task** | Work item assigned to agent | title, status, assignee_id |
| **Issue** | Detailed work specification | title, priority, platform, discipline |
| **Routine** | Scheduled recurring task | cron expression, task_template |

### Adapter System

Paperclip supports multiple agent adapters:
- `hermes_local` - Hermes agent runtime
- `claude_local` - Claude Code CLI
- `codex_local` - OpenAI Codex
- `cursor_local` - Cursor AI
- External plugins via `~/.paperclip/adapter-plugins.json`

## API Base Configuration

### Base URL Pattern
```
http://localhost:3100/api
```

### Authentication

**Board Access (Full Control):**
- No authentication required for board UI access
- Full operator context

**Agent Access:**
- Bearer token authentication via `agent_api_keys`
- Keys are hashed at rest in database
- Agent keys must not access other companies

### Headers
```http
Content-Type: application/json
Authorization: Bearer <agent_api_key>
```

## Core API Endpoints

### Companies

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/companies` | List all companies |
| GET | `/companies/:id` | Get company details |
| POST | `/companies` | Create new company |
| PUT | `/companies/:id` | Update company |
| DELETE | `/companies/:id` | Delete company |

**Create Company Request:**
```json
{
  "name": "My Company",
  "slug": "my-company",
  "schema": "agentcompanies/v1"
}
```

### Teams

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/companies/:companyId/teams` | List teams |
| POST | `/companies/:companyId/teams` | Create team |
| PUT | `/teams/:id` | Update team |
| DELETE | `/teams/:id` | Delete team |

### Agents

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/companies/:companyId/agents` | List agents |
| GET | `/agents/:id` | Get agent details |
| POST | `/companies/:companyId/agents` | Create agent |
| PUT | `/agents/:id` | Update agent |
| DELETE | `/agents/:id` | Delete agent |

**Create Agent Request:**
```json
{
  "name": "My Agent",
  "slug": "my-agent",
  "teamId": "team-uuid",
  "adapter": "hermes_local",
  "model": "openrouter/anthropic/claude-sonnet-4.5",
  "prompt": "Agent system prompt...",
  "toolsets": ["file_tools", "terminal_tools"]
}
```

### Agent API Keys

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/agents/:agentId/api-keys` | List API keys |
| POST | `/agents/:agentId/api-keys` | Generate new key |
| DELETE | `/api-keys/:id` | Revoke key |

### Tasks

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/tasks` | List tasks (filterable) |
| GET | `/tasks/:id` | Get task details |
| POST | `/tasks` | Create task |
| PUT | `/tasks/:id` | Update task |
| DELETE | `/tasks/:id` | Delete task |

**Task Status Flow:**
```
backlog → todo → in_progress → in_review → done
```

**Create Task Request:**
```json
{
  "title": "Task title",
  "description": "Task description",
  "status": "backlog",
  "priority": "high",
  "assigneeId": "agent-uuid",
  "companyId": "company-uuid"
}
```

### Issues

Issues are detailed work specifications linked to tasks.

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/issues` | List issues |
| POST | `/issues` | Create issue |
| PUT | `/issues/:id` | Update issue |
| DELETE | `/issues/:id` | Delete issue |

**Issue Attributes:**
- `discipline` - Discipline code (e.g., "02500-security")
- `platform` - Target platform (desktop/mobile/web)
- `priority` - Priority level
- `dueDate` - Due date
- `estimatedHours` - Effort estimate

### Routines

Routines are scheduled recurring tasks.

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/routines` | List routines |
| POST | `/routines` | Create routine |
| PUT | `/routines/:id` | Update routine |
| DELETE | `/routines/:id` | Delete routine |

**Routine Schema:**
```json
{
  "name": "Daily Standup",
  "cronExpression": "0 9 * * *",
  "taskTemplate": {
    "title": "Daily standup reminder",
    "description": "Post daily standup message",
    "assigneeId": "agent-uuid"
  },
  "companyId": "company-uuid",
  "enabled": true
}
```

## Error Handling

### HTTP Status Codes

| Code | Meaning | Action |
|------|---------|--------|
| 400 | Bad Request | Validate request body |
| 401 | Unauthorized | Check API key |
| 403 | Forbidden | Verify company access |
| 404 | Not Found | Check entity ID |
| 409 | Conflict | Check for duplicates |
| 422 | Unprocessable | Validate business rules |
| 500 | Server Error | Log and retry |

### Error Response Format
```json
{
  "error": "Error type",
  "message": "Human readable message",
  "details": {}
}
```

## Data Synchronization

### Company Boundaries

All domain entities must be scoped to a company:
- Agents belong to companies
- Tasks belong to companies
- API keys are company-scoped
- Company boundaries must be enforced in routes/services

### Atomic Operations

- Task checkout is atomic
- Single-assignee task model
- Budget hard-stop auto-pause behavior

## Integration Patterns

### Pattern 1: Create Company with Hierarchy

```javascript
async function createCompanyWithHierarchy(companyData) {
  // 1. Create company
  const company = await api.post('/companies', companyData);
  
  // 2. Create teams
  const teams = await Promise.all(
    companyData.teams.map(team => 
      api.post(`/companies/${company.id}/teams`, team)
    )
  );
  
  // 3. Create agents
  const agents = await Promise.all(
    companyData.agents.map(agent => {
      const team = teams.find(t => t.name === agent.teamName);
      return api.post(`/companies/${company.id}/agents`, {
        ...agent,
        teamId: team.id
      });
    })
  );
  
  // 4. Generate API keys
  const apiKeys = await Promise.all(
    agents.map(agent => 
      api.post(`/agents/${agent.id}/api-keys`)
    )
  );
  
  return { company, teams, agents, apiKeys };
}
```

### Pattern 2: Task Lifecycle Management

```javascript
async function advanceTask(taskId, newStatus) {
  const task = await api.get(`/tasks/${taskId}`);
  
  // Validate status transition
  const validTransitions = {
    'backlog': ['todo'],
    'todo': ['in_progress', 'backlog'],
    'in_progress': ['in_review', 'todo'],
    'in_review': ['done', 'in_progress'],
    'done': []
  };
  
  if (!validTransitions[task.status].includes(newStatus)) {
    throw new Error(`Invalid status transition: ${task.status} → ${newStatus}`);
  }
  
  return api.put(`/tasks/${taskId}`, { status: newStatus });
}
```

### Pattern 3: Routine Scheduling

```javascript
async function createRecurringTask(routineData) {
  // Validate cron expression
  const cronValidator = /^\d+ \d+ \d+ \d+ \d+$/;
  if (!cronValidator.test(routineData.cronExpression)) {
    throw new Error('Invalid cron expression');
  }
  
  return api.post('/routines', {
    ...routineData,
    enabled: true
  });
}
```

## Activity Logging

Mutating actions must write activity log entries:

```javascript
async function logActivity(action, entity, actor) {
  return api.post('/activity-logs', {
    action,
    entityType: entity.type,
    entityId: entity.id,
    actorId: actor.id,
    companyId: entity.companyId,
    timestamp: new Date().toISOString()
  });
}
```

## Health Checks

```bash
# API Health
curl http://localhost:3100/api/health

# List Companies
curl http://localhost:3100/api/companies
```

## Best Practices

1. **Company Scoping**: Always scope operations to a company
2. **Error Handling**: Handle all HTTP status codes appropriately
3. **Activity Logging**: Log all mutating actions
4. **Validation**: Validate request bodies before sending
5. **Pagination**: Use cursor-based pagination for large lists
6. **Rate Limiting**: Respect rate limits on bulk operations

## Related Skills

- `issue-routing-and-assignment` - Intelligent issue routing
- `board-orchestration-management` - Board-level orchestration
- `dispatching-parallel-agents` - Parallel agent dispatch
- `subagent-driven-development` - Subagent coordination

## References

- Paperclip SPEC: `doc/SPEC-implementation.md`
- API Documentation: `doc/guides/api.md`
- Agent Adapters: `packages/adapters/`
