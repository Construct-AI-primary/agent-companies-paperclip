---
memory_layer: durable_knowledge
para_section: pages/documentation/paperclip-integration
gigabrain_tags: paperclip, knowledge-enhancement, openclaw, workflow-implementation, research, hitl
openstinger_context: knowledge-enhancement-implementation
last_updated: 2026-04-04
related_docs:
  - /construct-ai-docs/codebase/other-apps/paperclip/integration/HITL_APPROVAL_WORKFLOWS.md
  - /construct-ai-docs/adapters/openclaw-gateway.md
---

# Knowledge Enhancement Workflow Implementation

## Overview

This document provides the complete implementation guide for knowledge enhancement using OpenClaw with HITL approval. It covers the workflow from task detection through research, approval, and integration into the construct-ai knowledge base.

---

## Workflow Phases

### Phase 1: Knowledge Gap Detection

**Trigger:** Agent identifies missing or inadequate domain knowledge for task completion

**Detection Criteria:**
- Task requires knowledge not in construct-ai
- Existing knowledge confidence < 0.80
- New techniques or standards identified
- Cross-domain knowledge required

**Detection Flow:**
```
Task Request → Scope Analysis → Knowledge Check → Gap Identified → Research Request
```

### Phase 2: Research Execution

**Agent Assignment:**
| Domain | Primary Research Agent | Backup |
|--------|----------------------|--------|
| Technical | explorer-promptforge-new-techniques | scholar-promptforge-academic-research |
| Academic | scholar-promptforge-academic-research | explorer-promptforge-new-techniques |
| Innovation | enhancer-promptforge-advanced-innovation | specialist-promptforge-domain-adaptation |
| Domain-specific | specialist-promptforge-domain-adaptation | enhancer-promptforge-advanced-innovation |

**Research Process:**
1. Agent receives research request with context
2. Agent searches construct-ai for existing knowledge
3. Agent identifies specific gaps
4. Agent performs research via OpenClaw gateway
5. Agent compiles findings with sources
6. Agent assigns confidence score
7. Agent routes to HITL if confidence < threshold

### Phase 3: HITL Approval

**Approval Trigger:** Research confidence < 0.90 OR first-time knowledge for domain

**Approval Flow:**
```
Research Complete → Confidence Check → HITL Queue → Expert Assignment → Expert Review → Decision → [Integration | Resubmit]
```

**Expert Assignment Logic:**
```python
def assign_expert(domain, topic):
    registry = HITL_Expert_Registry
    experts = registry.get(domain)
    primary = experts.get_primary(topic)
    backup = experts.get_backup(topic)
    
    if primary.available:
        return primary
    elif backup.available:
        return backup
    else:
        escalate_to_director(domain)
        
def escalate_to_director(domain):
    directors = {
        "civil-engineering": "engineering-director",
        "commercial": "commercial-director",
        "contracts": "contracts-director",
        "safety": "hse-director",
        "it": "it-director"
    }
    return directors.get(domain, "ceo")
```

### Phase 4: Integration

**Integration Steps:**
1. Expert approves with comments
2. System creates knowledge entry in construct-ai
3. Entry tagged with Gigabrain metadata
4. PARA index updated
5. Related agents notified of new knowledge
6. Audit log created
7. Integration confirmation sent to requesting agent

**Knowledge Entry Structure:**
```yaml
---
name: {discipline}-{topic}
description: >
  Concise description of the knowledge area and application
version: 1.0
frequency_percent: {estimated_usage}
success_rate_percent: {initial_confidence}
memory_layer: durable_knowledge
para_section: docs_construct_ai/{discipline}/knowledge
gigabrain_tags: {domain}, {topic}, {related_topics}
openstinger_context: {context}
last_updated: 2026-04-04
related_docs:
  - docs_construct_ai/{discipline}/related/
approved_by: {expert_name}
approval_date: 2026-04-04
approved_confidence: {approval_confidence}
source: openclaw-research-with-hitl-approval
---

# Knowledge Entry Title

## Overview
{knowledge content}

## Procedures
{procedures and guidelines}

## Integration Notes
{domain-specific integration details}
```

---

## Agent Configuration for OpenClaw

### Updating Agent Adapters

To enable OpenClaw with HITL for an agent:

```json
{
  "id": "explorer-promptforge-new-techniques",
  "name": "Explorer",
  "companyId": "promptforge-ai",
  "adapterType": "openclaw_gateway",
  "adapterConfig": {
    "gatewayUrl": "http://openclaw-gateway:18789",
    "apiToken": "${OPENCLAW_GATEWAY_TOKEN}",
    "hitlEnabled": true,
    "hitlConfig": {
      "queueUrl": "http://paperclip-api/hitl/queue",
      "approvalWebhook": "http://paperclip-api/hitl/approval",
      "defaultTimeoutHours": 48,
      "autoRejectOnTimeout": false,
      "expertRegistry": "http://paperclip-api/experts"
    }
  }
}
```

### Agent Routing Rules

Research agent routing:

| Agent | HITL Threshold | Default Expert Escalation |
|-------|---------------|--------------------------|
| explorer-promptforge-new-techniques | 0.80 | domain-specific-expert |
| scholar-promptforge-academic-research | 0.85 | domain-specific-expert |
| enhancer-promptforge-advanced-innovation | 0.75 | domain-specific-expert |
| specialist-promptforge-domain-adaptation | 0.80 | domain-specific-expert |

---

## HITL Queue Implementation

### Queue Schema
```sql
CREATE TABLE hitl_queue (
    id UUID PRIMARY KEY,
    request_id VARCHAR(255) UNIQUE NOT NULL,
    domain VARCHAR(100) NOT NULL,
    discipline_code VARCHAR(50),
    topic VARCHAR(255) NOT NULL,
    research_agent VARCHAR(100) NOT NULL,
    research_results JSONB,
    requested_by VARCHAR(100) NOT NULL,
    requested_at TIMESTAMP NOT NULL,
    required_expert VARCHAR(100) NOT NULL,
    assigned_expert VARCHAR(100),
    assigned_at TIMESTAMP,
    approval_criteria JSONB,
    timeout_hours INTEGER DEFAULT 48,
    escalation_path TEXT[],
    priority VARCHAR(20) DEFAULT 'medium',
    status VARCHAR(20) DEFAULT 'pending',
    expert_response JSONB,
    expert_response_at TIMESTAMP,
    integration_status VARCHAR(20) DEFAULT 'pending',
    integration_completed_at TIMESTAMP,
    audit_trail JSONB,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
```

### Webhook Endpoint
```typescript
// POST /api/hitl/approval
export async function handleApproval(req: Request) {
  const { requestId, action, reviewedBy, reviewedAt, comments, rejectionReason, suggestedModifications, approvalConfidence } = req.body;
  
  const request = await db.hitl_queue.findUnique({ where: { request_id: requestId } });
  if (!request) throw new Error('Request not found');
  
  await db.hitl_queue.update({
    where: { request_id: requestId },
    data: {
      status: action === 'approved' ? 'approved' : 'rejected',
      expert_response: {
        action,
        reviewedBy,
        reviewedAt,
        comments,
        rejectionReason,
        suggestedModifications,
        approvalConfidence
      },
      expert_response_at: reviewedAt
    }
  });
  
  if (action === 'approved') {
    await integrateKnowledge(request);
  } else {
    await notifyAgent(request.requestedBy, { type: 'rejection', request, suggestions: suggestedModifications });
  }
  
  return { success: true };
}
```

---

## Knowledge Integration Process

### Integration Steps
1. Validate expert approval
2. Create knowledge file in construct-ai/{discipline}/{topic}/
3. Update PARA index
4. Update Gigabrain tag registry
5. Notify related agents
6. Create audit entry
7. Update HITL queue status

### Knowledge File Creation
```typescript
async function integrateKnowledge(request: HITLRequest) {
  const discipline = request.discipline_code;
  const topic = slugify(request.topic);
  const knowledgePath = `construct-ai-docs/skills/construct-ai/${discipline}/${topic}/SKILL.md`;
  
  const skillContent = generateSkillMarkdown(request);
  await fs.writeFile(knowledgePath, skillContent);
  
  // Update PARA index
  await updateParaIndex(discipline, topic);
  
  // Update Gigabrain tags
  await updateGigabrainTags(request.research_results.gigabrain_tags);
  
  // Notify related agents
  await notifyRelatedAgents(discipline, topic);
  
  // Create audit entry
  await createAuditEntry(request);
  
  // Update HITL queue
  await db.hitl_queue.update({
    where: { request_id: request.requestId },
    data: {
      status: 'approved',
      integration_status: 'completed',
      integration_completed_at: new Date()
    }
  });
}
```

---

## Monitoring and Observability

### Key Metrics
```sql
-- Average approval time by domain
SELECT domain, 
       AVG(EXTRACT(EPOCH FROM (expert_response_at - requested_at))/3600) as avg_hours
FROM hitl_queue 
WHERE expert_response_at IS NOT NULL
GROUP BY domain;

-- First-pass approval rate
SELECT domain,
       COUNT(*) as total,
       SUM(CASE WHEN status = 'approved' AND expert_response->>'rejectionReason' IS NULL THEN 1 ELSE 0 END) as first_pass,
       ROUND(100.0 * SUM(CASE WHEN status = 'approved' AND expert_response->>'rejectionReason' IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) as first_pass_rate
FROM hitl_queue
GROUP BY domain;

-- Timeout rate by priority
SELECT priority,
       COUNT(*) as total,
       SUM(CASE WHEN status = 'pending' AND requested_at < NOW() - (timeout_hours || ' hours')::interval THEN 1 ELSE 0 END) as timed_out,
       ROUND(100.0 * SUM(CASE WHEN status = 'pending' AND requested_at < NOW() - (timeout_hours || ' hours')::interval THEN 1 ELSE 0 END) / COUNT(*), 2) as timeout_rate
FROM hitl_queue
GROUP BY priority;
```

### Alert Configuration
```yaml
alerts:
  queue_backlog:
    condition: hitl_queue.pending > 20
    severity: warning
    action: notify_expert_managers
    
  timeout_approaching:
    condition: hitl_queue.requested_at < NOW() - (timeout_hours * 0.8 || ' hours')::interval AND status = 'pending'
    severity: info
    action: remind_expert
    
  expert_unavailable:
    condition: hitl_queue.assigned_at < NOW() - '1 hour'::interval AND status = 'assigned'
    severity: warning
    action: reassign_to_backup
```

---

*Knowledge Enhancement Workflow - Ready for deployment*