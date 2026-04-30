---
memory_layer: durable_knowledge
para_section: pages/codebase/procedures/agent-development
gigabrain_tags: procedures, agent-development, codebase
documentation
openstinger_context: operational-procedures, agent-development-practices
last_updated: 2026-03-21
related_docs:
  - codebase/procedures/
  - disciplines/
---
# 0000_DEEP_AGENT_MESSAGING_OBSERVABILITY_PROCEDURE.md
# Deep Agent Messaging & Observability Procedure

**Document ID**: `0000_DEEP_AGENT_MESSAGING_OBSERVABILITY`  
**Version**: 1.0  
**Created**: 2026-02-18  
**Last Updated**: 2026-02-18  
**Status**: ✅ ACTIVE  
**Location**: `docs/procedures/agent-development/`

---

## Document Usage Guide

**🎯 This Document's Role**: Reference procedure for implementing and maintaining the Supabase-backed observability layer for the Python deep-agents framework. Use this when:
- Adding messaging/observability to a new deep agent
- Provisioning the 5 Supabase tables in a new environment
- Debugging agent health, checkpoints, or message flows
- Understanding what each messaging subsystem does

**📚 Related Documents:**
- **`docs/procedures/0000_PROCEDURES_GUIDE.md`** → Primary system procedures index
- **`docs/procedures/0000_AGENT_PROCEDURES_GUIDE.md`** → Agent-specific procedures index
- **`docs/research/OVERSTORY_ASSESSMENT.md`** → Architecture rationale and design decisions
- **`docs/procedures/0000_SQL_EXECUTION_PROCEDURE.md`** → How to run SQL files in Supabase

---

## 1. Overview

The deep-agents observability layer is a **Supabase-backed messaging and monitoring system** adapted from the Overstory open-source project's architectural patterns. It provides:

| Capability | What it enables |
|---|---|
| **Inter-agent messaging** | Persistent, cross-process agent communication |
| **Workflow checkpointing** | Crash recovery for long-running workflows |
| **Health monitoring** | Visibility into stuck or failed agents |
| **Token/cost metrics** | Per-session LLM cost tracking |
| **Agent identity** | Agents accumulate expertise across sessions |

All subsystems are **non-fatal by design** — a Supabase outage never crashes an agent workflow. Every call is wrapped in try/except inside `MessagingMixin`.

---

## 2. Architecture

### 2.1 Python Module Structure

```
deep-agents/deep_agents/messaging/
├── __init__.py              # Exports all classes + MessagingMixin
├── mail_store.py            # AgentMailStore — inter-agent messages
├── checkpoint.py            # CheckpointManager — workflow state persistence
├── health_monitor.py        # HealthMonitor — ZFC-principle health checks
├── metrics.py               # MetricsStore + SessionMetrics — token/cost tracking
├── agent_identity.py        # AgentIdentityStore — agent expertise accumulation
└── mixin.py                 # MessagingMixin — unified interface for all agents
```

### 2.2 Supabase Tables

| Table | Python Class | Purpose |
|---|---|---|
| `agent_messages` | `AgentMailStore` | Typed inter-agent messages with inbox/read tracking |
| `workflow_checkpoints` | `CheckpointManager` | Resumable workflow state (upsert on `workflow_id`) |
| `agent_health_records` | `HealthMonitor` | Heartbeat + stall/zombie detection |
| `agent_session_metrics` | `MetricsStore` / `SessionMetrics` | Token counts, cost, success/failure per run |
| `agent_identity_store` | `AgentIdentityStore` | Cumulative agent stats across all sessions |

### 2.3 MessagingMixin

`MessagingMixin` is a Python mixin class that provides a **unified, lazy-initialized interface** to all 5 subsystems. Any agent class can inherit it:

```python
class MyAgent(MessagingMixin, SupervisorAgent):
    def __init__(self, ...):
        super().__init__(...)
        self.init_messaging(organization_id=org_id)
```

**Public API:**

| Method | Description |
|---|---|
| `init_messaging(organization_id)` | Initialize all subsystems (call in `__init__`) |
| `messaging_heartbeat(step)` | Signal agent is alive; updates `agent_health_records` |
| `messaging_checkpoint(workflow_id, step, summary, completed, pending, partial)` | Save resumable checkpoint |
| `messaging_clear_checkpoint(workflow_id)` | Delete checkpoint on successful completion |
| `messaging_load_checkpoint(workflow_id)` | Load existing checkpoint for resume |
| `messaging_send(to, subject, body, type, priority, payload, workflow_id)` | Send typed message |
| `messaging_get_unread(agent_name)` | Fetch unread inbox messages |
| `messaging_record_metrics(session)` | Persist `SessionMetrics` to Supabase |
| `messaging_escalate(subject, body, workflow_id, payload)` | Send high-priority escalation to orchestrator |

---

## 3. Supabase Table Provisioning

### 3.1 SQL Files

All 5 SQL creation scripts are in `sql/creations/`:

| File | Table created |
|---|---|
| `create_agent_messages_table.sql` | `agent_messages` |
| `create_workflow_checkpoints_table.sql` | `workflow_checkpoints` |
| `create_agent_session_metrics_table.sql` | `agent_session_metrics` |
| `create_agent_health_records_table.sql` | `agent_health_records` |
| `create_agent_identity_store_table.sql` | `agent_identity_store` |

### 3.2 How to Provision

1. Open the **Supabase SQL Editor** for your project
2. Paste and run each `.sql` file in the order listed above
3. Run the verification test: `sql/creations/test_agent_messaging_tables.sql`

### 3.3 Verification Test

`sql/creations/test_agent_messaging_tables.sql` is a single CTE query that returns one row per table with:

| Column | Meaning |
|---|---|
| `exists_status` | `✅ EXISTS` or `❌ MISSING` |
| `actual_columns` / `expected_columns` | Column count match |
| `column_check` | `✅ MATCH` or `⚠️ MISMATCH` |
| `rls_status` | `✅ RLS ON` or `⚠️ RLS OFF` |
| `rls_policy_count` | Number of RLS policies |
| `write_test` | `✅ WRITE OK` — live insert+delete confirmed |

**Expected passing result (all 5 tables):**

| table_name | exists_status | column_check | rls_status | write_test |
|---|---|---|---|---|
| agent_health_records | ✅ EXISTS | ✅ MATCH (10) | ✅ RLS ON | ✅ WRITE OK |
| agent_identity_store | ✅ EXISTS | ✅ MATCH (16) | ✅ RLS ON | ✅ WRITE OK |
| agent_messages | ✅ EXISTS | ✅ MATCH (13) | ✅ RLS ON | ✅ WRITE OK |
| agent_session_metrics | ✅ EXISTS | ✅ MATCH (14) | ✅ RLS ON | ✅ WRITE OK |
| workflow_checkpoints | ✅ EXISTS | ✅ MATCH (11) | ✅ RLS ON | ✅ WRITE OK |

### 3.4 RLS Policies

Each table has 3 RLS policies:
- `dev_mode_full_access` — allows full access when `app.dev_mode` is set
- `service_role_full_access` — allows full access for the Supabase service role
- `organization_view_access` — SELECT access scoped to the user's organization

---

## 4. Wiring MessagingMixin into an Agent

### 4.1 Pattern for SupervisorAgent subclasses

```python
from deep_agents.messaging.mixin import MessagingMixin
from deep_agents.core.c_deep_agents_supervisor_framework import SupervisorAgent

class MyDeepAgent(MessagingMixin, SupervisorAgent):
    def __init__(self, agent_id=None, config=None, organization_id=None):
        super().__init__(agent_id or "my_deep_agent", config or {})
        
        # Wire MessagingMixin (non-fatal if Supabase unavailable)
        self.init_messaging(organization_id=organization_id)
```

> **MRO note**: `MessagingMixin` must be listed **before** `SupervisorAgent` in the class definition so its methods take precedence.

### 4.2 Pattern for plain Python classes

```python
from deep_agents.messaging.mixin import MessagingMixin

class MyAgent(MessagingMixin):
    def __init__(self, agent_config=None):
        self.config = agent_config or {}
        self.agent_id = "my_agent"
        
        # Wire MessagingMixin
        self.init_messaging(
            organization_id=self.config.get("organization_id")
        )
```

### 4.3 Priority agents already wired

| Agent | File | Class signature |
|---|---|---|
| Construction Correspondence | `00435-contracts_post_award/main_agents/a_construction_correspondence_deep_agent.py` | `ConstructionCorrespondenceDeepAgent(MessagingMixin, SupervisorAgent)` |
| Procurement Template Analysis | `01900-procurement/main_agents/01900_template_analysis_agent.py` | `ProcurementTemplateAnalysisAgent(MessagingMixin)` |
| Contractor Vetting | `contractor_vetting/a_contractor_vetting_deep_agent.py` | `ContractorVettingDeepAgent(MessagingMixin, SupervisorAgent)` |

---

## 5. Using the Messaging API in Agent Workflows

### 5.1 Heartbeat (health monitoring)

Call at the start of each major step so `HealthMonitor` knows the agent is alive:

```python
await self.messaging_heartbeat(step="document_analysis")
```

### 5.2 Checkpointing (crash recovery)

Save before each expensive step; clear on success:

```python
# Before a long step
await self.messaging_checkpoint(
    workflow_id=workflow_id,
    step="running_specialists",
    summary="Running 17 specialist agents in parallel",
    completed=["document_analysis", "extraction"],
    pending=["specialists", "formatting"],
    partial={"doc_count": 3}
)

# On successful completion
await self.messaging_clear_checkpoint(workflow_id)
```

To resume after a crash:

```python
checkpoint = await self.messaging_load_checkpoint(workflow_id)
if checkpoint:
    # Resume from checkpoint.current_step
    pass
```

### 5.3 Sending messages

```python
await self.messaging_send(
    to="orchestrator",
    subject="Correspondence analysis complete",
    body=f"Workflow {workflow_id} completed. 3 documents processed.",
    type="worker_done",
    workflow_id=workflow_id,
    payload={"doc_count": 3, "success": True}
)
```

### 5.4 Recording metrics

```python
from deep_agents.messaging import SessionMetrics

session = SessionMetrics(
    agent_id=self.agent_id,
    workflow_id=workflow_id,
    discipline="contracts_post_award",
    model_used="moonshotai/kimi-k2.5",
)

# ... run LLM calls, accumulate tokens ...
session.input_tokens += 1500
session.output_tokens += 800

session.mark_complete(success=True)
await self.messaging_record_metrics(session)
```

### 5.5 Escalation

```python
await self.messaging_escalate(
    subject="Specialist timeout after 3 retries",
    body="HSE specialist failed to respond within 300s",
    workflow_id=workflow_id,
    payload={"agent": "hse_management_agent", "retries": 3}
)
```

---

## 6. Message Types Reference

| Type | When to use |
|---|---|
| `status` | Progress updates during a workflow |
| `worker_done` | Signal successful completion to orchestrator |
| `error` | Report a non-fatal error |
| `escalation` | High-priority issue requiring human or orchestrator attention |
| `dispatch` | Assign work to a sub-agent |
| `question` | Request information from another agent |
| `result` | Return a result to a requesting agent |
| `health_check` | Health monitoring ping |

---

## 7. Health Monitoring

`HealthMonitor` uses the **ZFC (Zero Failure Crash) principle** from Overstory: trust what you can observe, not what's recorded.

| Threshold | Behaviour |
|---|---|
| > 120s without heartbeat | Agent marked `stalled`; `stalled_since` recorded |
| > 600s without heartbeat | Agent marked `failed`; escalation message sent to orchestrator |

To check all active agents:

```python
health_results = await self.health.check_all()
# Returns: {"agent_id": "running"|"stalled"|"failed", ...}
```

---

## 8. Outstanding Work (Next Steps)

| Item | Priority | Status | Notes |
|---|---|---|---|
| Add `messaging_heartbeat()` calls inside long-running specialist loops | 🔴 High | ⏳ TODO | All 3 priority agents init messaging but never call `messaging_heartbeat()` mid-workflow. Must be added inside specialist dispatch loops in `00435`, `01900`, and `contractor_vetting` so `HealthMonitor` can detect stalls. |
| Add event logging (tool_start/end, session_start/end) | 🟠 Medium | ⏳ TODO | Audit trail for debugging — not yet implemented. Use `messaging_send(type="status")` at tool entry/exit and session boundaries to create a queryable event log in `agent_messages`. |
| Build React UI for workflow status visibility | 🟠 Medium | ⏳ TODO | Show agent health, messages, checkpoints in the frontend. Query the 5 Supabase tables directly from the React client. |
| Wire MessagingMixin into remaining 46 discipline page agents | 🟡 Low | ⏳ TODO | Stubs exist; need real agent logic + mixin wiring |
| Mine Cline history for debug patterns | 🟡 Low | ⏳ TODO | Appendix G of OVERSTORY_ASSESSMENT.md — Phase 4+ |

---

## 9. Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| `init_messaging()` silently does nothing | Supabase env vars not set | Check `SUPABASE_URL` and `SUPABASE_SERVICE_KEY` in `.env` |
| Table missing error on write | SQL not run in Supabase | Run `sql/creations/create_*.sql` files in Supabase SQL Editor |
| `⚠️ MISMATCH` in test | Schema drift — table was created from an older version of the SQL | Drop and recreate the table using the current SQL file |
| `⚠️ RLS OFF` in test | RLS not enabled | Run the `ALTER TABLE ... ENABLE ROW LEVEL SECURITY` statement from the creation SQL |
| Agent shows `stalled` immediately | Heartbeat not being called | Add `await self.messaging_heartbeat(step=...)` at the start of each major step |

---

## 10. Cross-References

- **Architecture rationale**: `docs/research/OVERSTORY_ASSESSMENT.md` — Section 5 (Recommendations) and Section 8 (Implementation Order)
- **SQL creation files**: `sql/creations/create_agent_*.sql` and `sql/creations/create_workflow_checkpoints_table.sql`
- **Verification test**: `sql/creations/test_agent_messaging_tables.sql`
- **Python source**: `deep-agents/deep_agents/messaging/`
- **Priority agent implementations**:
  - `deep-agents/deep_agents/agents/pages/00435-contracts_post_award/main_agents/`
  - `deep-agents/deep_agents/agents/pages/01900-procurement/main_agents/`
  - `deep-agents/deep_agents/agents/pages/contractor_vetting/`

---

*Procedure by: Cline (AI Assistant)*  
*Based on: Overstory architectural patterns adapted for Supabase + Python*  
*Review cycle: Monthly or when messaging schema changes*
