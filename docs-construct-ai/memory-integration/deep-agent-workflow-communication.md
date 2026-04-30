---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: deep-agents, workflow, multi-agent, messaging, checkpointing, VFS
documentation
openstinger_context: agent-workflow-integration
last_updated: 2026-04-11
related_docs:
  - docs/messaging/mixin.md
  - docs/messaging/mail_store.md
  - docs/messaging/checkpoint.md
  - docs/services/vfs_procurement_filesystem.md
  - disciplines/01900_procurement/
---

# Deep Agent Workflow Communication Patterns

## Overview

Deep agents in Construct AI pass information through workflows using a **3-layer information architecture** that combines persistent document storage, inter-agent messaging, and crash-recovery checkpointing.

## Layer 1: Virtual Filesystem (VFS) — Document Persistence

**Location:** `deep-agents/deep_agents/services/vfs_procurement_filesystem.py`

Provides structured filesystem abstraction for agent document access across workflow stages.

### Directory Structure
```
/orders/{order_id}/
├── /templates/     # Symlinked from global templates
├── /references/     # Supplier cards, search cache, selected vendors
├── /working/         # Agent workspace (intermediate results)
└── /outputs/         # Final deliverables
```

### VFS Operations
```python
# Write agent output to working directory
await vfs.write_file("working/compliance_report.json", json_data)

# Read previous agent's output
supplier_data = await vfs.read_file("references/cards/SUPPLIER_001.json")

# Search across supplier data
results = await vfs.grep_search("references/cards/*.json", '"cidb_grade": "GR8"')
```

### Integration Points
- **SupplierCardGenerator**: Caches supplier cards to `references/cards/`
- **ComplianceRuleManager**: Reads/writes compliance reports to `working/`
- **HITL Coordinators**: Write intermediate results to `working/` for human review

---

## Layer 2: MessagingMixin — Inter-Agent Communication

**Location:** `deep-agents/deep_agents/messaging/mixin.py`

Wires together four messaging subsystems via single inheritance.

### 2.1 AgentMailStore (Supabase `agent_messages` table)
```python
# Send message to another agent
msg_id = self.messaging_send(
    to_agent="specialist_agent",
    subject="Analysis Complete",
    body="Contract review finished",
    type="result",
    payload={"contract_id": "C-001", "risk_level": "low"}
)

# Poll for incoming messages
messages = self.messaging_get_unread()
```

### 2.2 CheckpointManager (Supabase `workflow_checkpoints` table)
```python
# Save workflow progress (crash recovery)
self.messaging_checkpoint(
    workflow_id="wf-123",
    current_step="specialist_analysis",
    completed_steps=["document_retrieval", "extraction", "civil"],
    pending_steps=["electrical", "structural"],
    partial_results={"civil": {"risk": "low", "findings": [...]}}
)

# Load checkpoint after crash
checkpoint = self.messaging_load_checkpoint("wf-123")
if checkpoint:
    print(f"Resuming from: {checkpoint.current_step}")
```

### 2.3 MetricsStore
```python
# Record token usage
self.messaging_record_metrics(
    workflow_id="wf-123",
    discipline="01900_procurement",
    input_tokens=4500,
    output_tokens=1200,
    model_used="claude-3-5-sonnet",
    success=True
)
```

### 2.4 HealthMonitor
```python
# Signal alive
self.messaging_heartbeat("document_analysis")
```

---

## Layer 3: WorkflowState — Execution Context

**Location:** `deep-agents/deep_agents/core/c_deep_agents_state_management.py`

Manages workflow execution state including current step, completed steps, and pending steps.

---

## Typical Workflow Flow (Procurement Example)

```
1. HITL Coordinator initializes VFS for order
   └─> ProcurementVirtualFilesystem(order_id, org_id)
   
2. Specialist Agent reads templates from VFS
   └─> vfs.read_file("templates/procurement_form.md")
   
3. Agent processes and writes intermediate results
   └─> vfs.write_file("working/stage1_analysis.json", results)
   
4. Checkpoint saves progress to Supabase
   └─> messaging_checkpoint(workflow_id, "stage1", [...], [...], results)
   
5. Next agent reads previous output from VFS
   └─> vfs.read_file("working/stage1_analysis.json")
   
6. HITL coordinator sends message for human review
   └─> messaging_send(to_agent="human_reviewer", type="question", ...)
   
7. On completion, final output to outputs/, checkpoint cleared
   └─> vfs.write_file("outputs/final_report.md", final)
   └─> messaging_clear_checkpoint(workflow_id)
```

---

## HITL Coordinator Pattern

Each discipline's HITL coordinator follows this pattern:

```python
class ProcurementHITLCoordinator(MessagingMixin, BaseAgent):
    def __init__(self, config):
        self.init_messaging(organization_id=config.get("organization_id"))
        self.vfs = ProcurementVirtualFilesystem(order_id)
    
    async def run_workflow(self, session_id, procurement_data):
        # Initialize VFS
        await self.vfs.initialize_order_filesystem()
        
        # Stage 1: Document Analysis
        stage1 = await self.analyze_documents(procurement_data)
        await self._save_checkpoint(session_id, "stage1_document_analysis", stage1)
        
        # HITL Gate (human review checkpoint)
        if self._requires_human_review(stage1):
            await self.messaging_send(
                to_agent="human_reviewer",
                type="question",
                payload={"stage": "document_analysis", "data": stage1}
            )
        
        # Stage 2: Continue processing...
```

---

## Memory System Integration

### Daily Memory Files
- Location: `disciplines/[discipline]/memories/`
- Pattern: `{discipline}_{sequence}_{title}.md`
- Used for tracking workflow completion milestones

### Agent Guidelines
- Location: `memory-integration/agent-guidelines.md`
- Documents memory layer access patterns for code generation

### Cross-Discipline Handoffs
- Logistics → Procurement: `procurement_logistics_handoff.js`
- Uses VFS for shared supplier data via `references/cards/`

---

## Target Disciplines with Deep Agent Workflows

| Discipline | Code | HITL Coordinator | Specialist Agents |
|------------|------|-----------------|------------------|
| Procurement | 01900 | ✅ `01900_procurement_hitl_coordinator_clean.py` | input, supplier_vetting, order_processing |
| Safety | 02400 | ✅ `02400_safety_hitl_coordinator.py` | risk_assessment, incident_reporting |
| Logistics | 01700 | ✅ `01700_logistics_hitl_coordinator.py` | customs, delivery_tracking |
| Contracts | 00435 | ✅ `a_construction_correspondence_deep_agent.py` | 17 specialists |

---

## Success Criteria

- ✅ VFS provides persistent document storage across agent handoffs
- ✅ MessagingMixin enables fault-tolerant inter-agent communication
- ✅ CheckpointManager ensures crash recovery without data loss
- ✅ HITL gates integrate human review at critical decision points
- ✅ All messaging calls wrapped in try/except (Supabase outage safe)
