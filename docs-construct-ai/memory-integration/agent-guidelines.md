---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation
documentation
openstinger_context: general-documentation
last_updated: 2026-03-30
related_docs:
  - docs/
---

# Agent Documentation Access Guidelines

## Memory Layer Access Patterns

### For Code Generation (Layer E - Gigabrain)
When generating code for target disciplines, reference:
- `disciplines/[discipline]/para-index.md` for complete context
- `disciplines/[discipline]/workflow_docs/` for business processes
- `para/projects/[discipline]-system/` for active development work
- Related API docs in `disciplines/[discipline]/api/`

### For Workflow Implementation (Layer C - PARA)
- Use `para/pages/disciplines/[discipline]/` for complete context
- Reference `para/areas/` for integration patterns
- Check `memory/YYYY-MM-DD.md` for recent workflow updates

### For Session Continuity (Layer B - LCM)
- Preserve workflow state across coding sessions
- Reference PARA indexes for context recovery
- Use daily memory for task continuity

## Target Disciplines Priority Order

1. **01900 Procurement** (Highest Priority)
   - Complex workflow: 1900_CREATE_PROCUREMENT_ORDER_WORKFLOW.MD
   - Multiple phases and approval processes
   - API integration requirements

2. **02400 Safety** (Critical for Compliance)
   - Safety-critical workflows
   - Regulatory compliance requirements
   - Risk assessment processes

3. **01700 Logistics** (Complex Coordination)
   - Multi-party coordination workflows
   - Supply chain integration
   - Timeline-critical processes

4. **00435 Contracts Post-Award** (Legal/Financial)
   - Contract execution workflows
   - Financial compliance requirements
   - Legal documentation processes

## Documentation Priority Order
1. **PARA Index**: `disciplines/[discipline]/para-index.md`
2. **Workflow Docs**: `disciplines/[discipline]/workflow_docs/`
3. **API References**: `disciplines/[discipline]/api/`
4. **Related Procedures**: `procedures/[relevant-area]/`

## Deep Agent Workflow Communication

For implementing multi-agent workflows, reference:
- **`memory-integration/deep-agent-workflow-communication.md`** — Complete guide to:
  - Virtual Filesystem (VFS) for document persistence across agents
  - MessagingMixin for inter-agent communication
  - CheckpointManager for crash recovery
  - HITL Coordinator patterns
  - Cross-discipline handoff examples

### Quick Reference: Adding a New Agent to Workflow

```python
from deep_agents.messaging.mixin import MessagingMixin

class MyAgent(MessagingMixin, BaseAgent):
    def __init__(self, agent_id, config):
        super().__init__(agent_id, config)
        self.init_messaging(organization_id=config.get("organization_id"))
    
    async def process(self, workflow_id, data):
        # 1. Signal heartbeat
        self.messaging_heartbeat("processing")
        
        # 2. Check for saved checkpoint
        checkpoint = self.messaging_load_checkpoint(workflow_id)
        
        # 3. Process and checkpoint progress
        result = await self.do_work(data)
        self.messaging_checkpoint(
            workflow_id=workflow_id,
            current_step="my_step",
            completed_steps=["..."],
            pending_steps=["..."],
            partial_results={"my_step": result}
        )
        
        # 4. Send to next agent
        self.messaging_send(
            to_agent="next_agent",
            subject="Task Complete",
            type="result",
            payload=result
        )
```
