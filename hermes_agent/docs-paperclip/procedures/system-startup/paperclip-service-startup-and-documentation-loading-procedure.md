---
title: Paperclip Service Startup and Documentation Loading Procedure
summary: Complete procedure for starting Paperclip services, configuring agents, and loading documentation for agent execution
---

# Paperclip Service Startup and Documentation Loading Procedure

## Overview

This procedure provides comprehensive instructions for starting the Paperclip multi-agent orchestration platform, configuring agents for execution, and loading documentation for automated processing. This enables the full Paperclip + Hermes agent workflow for GitHub PR automation and document processing.

## Prerequisites

### System Requirements
- Node.js and pnpm package manager
- PostgreSQL database (local PGlite or remote Supabase)
- Hermes agent runtime environment
- API keys for external services (OpenRouter, GitHub, etc.)

### Required Files
- `package.json` with proper scripts
- `.env` file with API keys
- Agent configuration in database
- Documentation files to be processed

## Procedure Steps

### Step 1: Service Startup

#### 1.1 Navigate to Project Directory
```bash
cd /Users/_test-20260416/paperclip-render
```

#### 1.2 Start Paperclip Service
```bash
pnpm dev
```

**Expected Output:**
- Service starts on `http://localhost:3100`
- WebSocket connections established
- Database connections initialized

#### 1.3 Verify Service Health
```bash
curl -s http://localhost:3100/api/health
```

**Expected Response:**
```json
{
  "status": "ok",
  "version": "0.3.1",
  "deploymentMode": "local_trusted",
  "deploymentExposure": "private",
  "authReady": true,
  "bootstrapStatus": "ready",
  "bootstrapInviteActive": false,
  "features": {
    "companyDeletionEnabled": true
  }
}
```

### Step 2: Agent Configuration

#### 2.1 Enable Agent Heartbeats
For each agent that should execute work:

```bash
curl -s -X PATCH \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"runtimeConfig": {"heartbeat": {"enabled": true, "intervalSec": 1800}}}' \
  http://localhost:3100/api/agents/AGENT_ID
```

**Parameters:**
- `AGENT_ID`: The UUID of the agent (found in agent list)
- `intervalSec`: Heartbeat interval in seconds (default: 1800 = 30 minutes)

#### 2.2 Verify Agent Status
```bash
curl -s -H "Authorization: Bearer YOUR_API_KEY" \
  http://localhost:3100/api/companies/COMPANY_ID/agents
```

**Expected Status Values:**
- `idle`: Agent ready for work
- `running`: Agent actively executing
- `error`: Agent encountered issues

#### 2.3 Trigger Manual Heartbeat (Optional)
```bash
curl -s -X POST \
  -H "Authorization: Bearer YOUR_API_KEY" \
  http://localhost:3100/api/agents/AGENT_ID/heartbeat/invoke
```

### Step 3: Documentation Loading

#### 3.1 Create Issue for Document Processing
```bash
curl -s -X POST \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Process Documentation: DOCUMENT_TITLE",
    "description": "Load and process the following documentation files for automated analysis and execution...",
    "status": "todo",
    "priority": "high",
    "assigneeAgentId": "AGENT_ID",
    "project": "DOCUMENT_PROJECT",
    "phase": "Documentation Processing",
    "estimatedHours": 4,
    "dueDate": "2026-12-31"
  }' \
  http://localhost:3100/api/companies/COMPANY_ID/issues
```

#### 3.2 Attach Documentation Files
```bash
curl -s -X POST \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -F "file=@/path/to/document.pdf" \
  -F "file=@/path/to/document.md" \
  http://localhost:3100/api/companies/COMPANY_ID/issues/ISSUE_ID/attachments
```

#### 3.3 Add Document References
```bash
curl -s -X PUT \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Implementation Guide",
    "format": "markdown",
    "body": "# Document Content\n\n...",
    "baseRevisionId": null
  }' \
  http://localhost:3100/api/issues/ISSUE_ID/documents/guide
```

### Step 4: Agent Execution Monitoring

#### 4.1 Monitor Issue Status
```bash
curl -s -H "Authorization: Bearer YOUR_API_KEY" \
  http://localhost:3100/api/issues/ISSUE_ID
```

**Status Progression:**
- `backlog` → `todo` → `in_progress` → `in_review` → `done`
- `in_progress` requires checkout (single agent execution)
- `started_at` and `completed_at` timestamps are set automatically

#### 4.2 Check Agent Execution Logs
```bash
curl -s -H "Authorization: Bearer YOUR_API_KEY" \
  http://localhost:3100/api/issues/ISSUE_ID/comments
```

#### 4.3 Monitor Agent Heartbeat Status
```bash
ps aux | grep hermes
```

**Expected Output:**
Hermes processes should be running with heartbeat instructions.

### Step 5: Troubleshooting

#### 5.1 Service Won't Start
**Symptoms:** Port 3100 not responding
**Solutions:**
1. Check for port conflicts: `lsof -i :3100`
2. Verify dependencies: `pnpm install`
3. Check database connection
4. Review startup logs

#### 5.2 Agents Not Executing
**Symptoms:** Issues remain in `backlog` or `todo` status
**Solutions:**
1. Verify heartbeats enabled: Check `runtimeConfig.heartbeat.enabled`
2. Trigger manual heartbeat: Use heartbeat invoke endpoint
3. Check agent status: Ensure status is `idle` not `error`
4. Verify agent configuration: Check adapter settings

#### 5.3 API Authentication Issues
**Symptoms:** 401/403 errors
**Solutions:**
1. Verify API key format and permissions
2. Check company ID matches agent company
3. Ensure Bearer token format: `Authorization: Bearer <key>`

#### 5.4 Document Loading Issues
**Symptoms:** Documents not accessible to agents
**Solutions:**
1. Verify file permissions
2. Check document format compatibility
3. Ensure proper document keys
4. Validate baseRevisionId for updates

## Configuration Examples

### Agent Heartbeat Configuration
```json
{
  "runtimeConfig": {
    "heartbeat": {
      "enabled": true,
      "intervalSec": 1800
    },
    "tools_allowed": ["git", "read", "write", "run_terminal"],
    "memory_systems": ["gigabrain", "para"]
  }
}
```

### Issue Creation Template
```json
{
  "title": "Process Technical Documentation",
  "description": "Load and analyze technical documentation for automated processing and execution",
  "status": "todo",
  "priority": "high",
  "assigneeAgentId": "agent-uuid-here",
  "companyId": "company-uuid-here",
  "project": "DOCUMENTATION",
  "phase": "Analysis Phase",
  "estimatedHours": 8,
  "dueDate": "2026-12-31"
}
```

## Success Criteria

- [ ] Paperclip service running on port 3100
- [ ] Health check returns status "ok"
- [ ] Agents have heartbeats enabled
- [ ] Issues created successfully
- [ ] Documents attached and accessible
- [ ] Agents begin execution within 5 minutes
- [ ] Issue status progresses from `todo` to `in_progress`

## Estimated Duration

- Service startup: 2-3 minutes
- Agent configuration: 5-10 minutes per agent
- Documentation loading: 5-15 minutes
- Total procedure: 15-30 minutes

## Risk Mitigation

### High Risk: Service Startup Failure
- **Impact:** Complete system unavailability
- **Mitigation:** Have backup startup scripts and alternative ports
- **Recovery:** Check logs, verify dependencies, restart with debug mode

### Medium Risk: Agent Configuration Issues
- **Impact:** Agents unable to execute work
- **Mitigation:** Test agent configuration before bulk operations
- **Recovery:** Manual heartbeat triggers, configuration rollback

### Low Risk: Document Loading Issues
- **Impact:** Delayed processing
- **Mitigation:** Validate documents before upload
- **Recovery:** Re-upload corrected documents, update issue descriptions

## Related Procedures

- [Agent Selection Guide](../agents/agent-selection-guide.md)
- [Adapter URL Migration](../adapters/adapter-url-migration-procedure.md)
- [Workflow Code and Doc Placement](../workflows/code-and-doc-placement-procedure.md)

## Version History

- v1.0 (2026-04-18): Initial procedure based on Paperclip + Hermes integration testing
- Comprehensive startup, configuration, and monitoring steps
- Troubleshooting section with common issues and solutions