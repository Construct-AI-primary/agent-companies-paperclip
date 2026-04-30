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
# 0000_AGENT_WIRING_METHODOLOGY_PROCEDURE.md

## Agent Wiring Methodology for Construct AI Workflows

**Document ID**: `0000_AGENT_WIRING_METHODOLOGY_PROCEDURE`  
**Version**: 1.0.0  
**Created**: 2026-02-22  
**Last Updated**: 2026-02-22  
**Author**: Construct AI Development Team  
**Review Cycle**: Quarterly  
**Status**: ✅ ACTIVE

---

## Table of Contents

1. [Overview](#overview)
2. [Purpose](#purpose)
3. [Agent Architecture Summary](#agent-architecture-summary)
4. [Wiring Components](#wiring-components)
5. [Standard Wiring Checklist](#standard-wiring-checklist)
6. [Implementation Procedure](#implementation-procedure)
7. [Workflow-Specific Wiring](#workflow-specific-wiring)
8. [Testing Requirements](#testing-requirements)
9. [Verification & Validation](#verification--validation)
10. [Troubleshooting](#troubleshooting)
11. [Related Procedures](#related-procedures)

---

## Overview

This procedure provides a comprehensive methodology for wiring AI agents into Construct AI workflows. It ensures consistent integration of all agent types with core services, messaging infrastructure, governance frameworks, and testing systems.

### Problem Statement

Workflows require multiple agent types working together, but inconsistent wiring leads to:
- Missing observability (no checkpoints, metrics, or health monitoring)
- Governance compliance gaps
- Testing blind spots
- Inter-agent communication failures
- Difficulty debugging workflow issues

### Solution

A standardized wiring methodology that ensures every agent is properly integrated with:
- **MessagingMixin**: Mail, checkpoints, metrics, health monitoring
- **Governance Framework**: `@with_governance` decorator for compliance
- **Agent Registry**: Database-driven discovery and configuration
- **Testing Infrastructure**: Proactive testing and validation
- **Service Patterns**: Discipline-specific extraction patterns

---

## Purpose

### Primary Objectives

1. **Standardize Agent Integration**: Consistent wiring across all workflows
2. **Ensure Observability**: All agents have checkpointing, metrics, and health monitoring
3. **Enforce Governance**: Compliance with AIUC-1, ISO 42001, ISO 27701, EU AI Act, NIS2
4. **Enable Testing**: Proactive testing integration for all agents
5. **Facilitate Debugging**: Complete audit trails and state management

### Target Audience

- **Backend Developers**: Implementing Python deep agents
- **Frontend Developers**: Integrating agents with UI workflows
- **System Architects**: Designing workflow orchestration
- **QA Engineers**: Testing agent integration

---

## Agent Architecture Summary

### Directory Structure

```
deep-agents/deep_agents/
├── agents/
│   ├── pages/                          # Discipline-specific agents
│   │   └── 01900-procurement/          # Example: Procurement workflow
│   │       ├── 01900_procurement_hitl_coordinator.py
│   │       ├── main_agents/            # Core workflow agents
│   │       │   ├── 01900_template_analysis_agent.py
│   │       │   ├── 01900_requirements_extraction_agent.py
│   │       │   ├── 01900_compliance_validation_agent.py
│   │       │   ├── 01900_field_population_agent.py
│   │       │   ├── 01900_quality_assurance_agent.py
│   │       │   └── 01900_final_review_agent.py
│   │       ├── specialist_agents/      # Domain specialists
│   │       │   ├── technical/
│   │       │   ├── logistics/
│   │       │   ├── safety/
│   │       │   └── ...
│   │       └── tests/                  # Workflow tests
│   │
│   └── shared/                         # Shared agent infrastructure
│       ├── governance/                 # 11-Agent Governance Swarm
│       │   ├── a_0000_base_governance_agent.py
│       │   ├── a_0001_governance_swarm_orchestrator.py
│       │   └── ... (11 governance agents)
│       ├── discipline_it_specialists/  # Discipline IT specialists
│       │   ├── a_01900_procurement_it_specialist.py
│       │   ├── proactive_testing_agent.py
│       │   └── ...
│       ├── orchestrators/              # Workflow orchestrators
│       │   ├── 0000_multi_instance_orchestrator.py
│       │   └── 0010_workflow_orchestrator.py
│       └── builders/                   # Agent builders
│
├── core/                               # Core framework
│   ├── checkpointing.py                # Checkpoint management
│   ├── agent_registry.py               # Agent discovery
│   ├── agent_loader.py                 # Dynamic loading
│   ├── c_deep_agents_core_framework.py # Base agent class
│   ├── c_deep_agents_state_management.py
│   └── c_deep_agents_sub_agent_framework.py
│
├── messaging/                          # Messaging infrastructure
│   ├── mixin.py                        # MessagingMixin
│   ├── mail_store.py                   # Inter-agent mail
│   ├── checkpoint.py                   # Workflow checkpoints
│   ├── metrics.py                      # Token/cost metrics
│   └── health_monitor.py               # Health monitoring
│
├── services/                           # Discipline patterns
│   ├── 01900_procurement_patterns.py
│   └── ... (50+ discipline patterns)
│
└── utils/                              # Utilities
    ├── database.py
    ├── supabase_client.py
    └── prompt_manager.py
```

### Agent Types

| Type | Location | Purpose | Base Class |
|------|----------|---------|------------|
| **HITL Coordinator** | `pages/{discipline}/` | Human-in-the-loop orchestration | `MessagingMixin` |
| **Main Agents** | `pages/{discipline}/main_agents/` | Core workflow processing | `MessagingMixin` + `@with_governance` |
| **Specialist Agents** | `pages/{discipline}/specialist_agents/` | Domain-specific processing | `SubAgent` |
| **Governance Agents** | `shared/governance/` | Compliance validation | `GovernanceAgent` |
| **IT Specialists** | `shared/discipline_it_specialists/` | Discipline support | `BaseDisciplineITSpecialist` |
| **Orchestrators** | `shared/orchestrators/` | Multi-agent coordination | `DeepAgent` |

---

## Wiring Components

### 1. MessagingMixin Integration

**Purpose**: Provides mail, checkpointing, metrics, and health monitoring.

**Implementation**:
```python
from deep_agents.messaging.mixin import MessagingMixin

class MyAgent(MessagingMixin):
    def __init__(self, agent_config: Optional[Dict[str, Any]] = None):
        self.config = agent_config or self._default_config()
        self.agent_id = "01900_my_agent"
        self.agent_name = "My Agent"
        self.version = "1.0.0"
        
        # Initialize MessagingMixin
        self.init_messaging(organization_id=self.config.get("organization_id"))
    
    async def process(self, input_data: Dict[str, Any]) -> Dict[str, Any]:
        session_id = input_data.get("session_id", str(uuid.uuid4()))
        
        # Heartbeat at start
        self.messaging_heartbeat(step="processing")
        
        # Save checkpoint
        self.messaging_checkpoint(
            workflow_id=session_id,
            current_step="processing",
            completed_steps=["init"],
            pending_steps=["finalize"],
            partial_results={}
        )
        
        # ... processing logic ...
        
        # Record metrics
        self.messaging_record_metrics(
            workflow_id=session_id,
            discipline="procurement",
            input_tokens=100,
            output_tokens=200,
            success=True
        )
        
        # Send completion notification
        self.messaging_send(
            to_agent="orchestrator",
            subject="Processing Complete",
            body=f"Session {session_id} completed successfully",
            type="result"
        )
        
        return result
```

### 2. Governance Decorator

**Purpose**: Enforces AIUC-1, ISO 42001, ISO 27701, EU AI Act, NIS2 compliance.

**Implementation**:
```python
from deep_agents.agents.shared.governance import with_governance

class MyAgent(MessagingMixin):
    @with_governance(jurisdiction='FI', strict_mode=True)
    async def process(self, input_data: Dict[str, Any]) -> Dict[str, Any]:
        # Governance validation happens automatically
        # before and after method execution
        return result
```

**Governance Configuration**:
```python
# In agent config
"governance": {
    "jurisdiction": "FI",      # Finland (EU AI Act)
    "strict_mode": True,       # Fail on compliance violations
    "frameworks": [
        "AIUC-1",
        "ISO_42001",
        "ISO_27701",
        "EU_AI_Act",
        "NIS2"
    ]
}
```

### 3. Agent Registry Integration

**Purpose**: Database-driven agent discovery and configuration.

**Database Schema** (`agents_tracking` table):
```sql
CREATE TABLE agents_tracking (
    agent_name TEXT PRIMARY KEY,
    organization_id TEXT NOT NULL,
    page_prefix TEXT,
    discipline TEXT,
    module_path TEXT NOT NULL,
    class_name TEXT NOT NULL,
    capabilities JSONB DEFAULT '[]',
    dependencies JSONB DEFAULT '[]',
    config_schema JSONB DEFAULT '{}',
    version TEXT DEFAULT '1.0.0',
    auto_load BOOLEAN DEFAULT false,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Registration**:
```python
from deep_agents.core.agent_registry import AgentRegistry

async def register_agent():
    registry = AgentRegistry.get_instance()
    await registry.initialize()
    
    await registry.register_agent({
        "agent_name": "01900_template_analysis_agent",
        "organization_id": "construct_ai",
        "page_prefix": "01900",
        "discipline": "procurement",
        "module_path": "deep_agents.agents.pages.01900-procurement.main_agents.01900_template_analysis_agent",
        "class_name": "ProcurementTemplateAnalysisAgent",
        "capabilities": [
            "template_compatibility_analysis",
            "procurement_requirement_extraction",
            "template_ranking_and_recommendation"
        ],
        "dependencies": [],
        "version": "1.0.0",
        "auto_load": True
    })
```

### 4. Checkpointing Integration

**Purpose**: Enable workflow resumption after failures.

**Implementation**:
```python
from deep_agents.core.checkpointing import (
    CheckpointManager,
    CheckpointResumeEngine,
    DisciplineWorkflowFactory,
    CheckpointConfig
)

class MyWorkflowCoordinator(MessagingMixin):
    def __init__(self, config: Optional[Dict[str, Any]] = None):
        super().__init__()
        self.checkpoint_manager = CheckpointManager()
        self.workflow_factory = DisciplineWorkflowFactory()
    
    async def run_workflow(
        self,
        workflow_id: str,
        discipline: str,
        use_checkpoints: bool = True
    ):
        # Create workflow with checkpointing
        workflow = self.workflow_factory.create_workflow_with_checkpointing(
            discipline=discipline,
            use_checkpoints=use_checkpoints
        )
        
        # Check for existing checkpoint
        existing = await self.checkpoint_manager.load_checkpoint(workflow_id)
        if existing:
            # Resume from checkpoint
            resume_engine = CheckpointResumeEngine(self.workflow_factory)
            return await resume_engine.resume_from_checkpoint(
                thread_id=workflow_id,
                discipline=discipline
            )
        
        # Execute new workflow
        result = await workflow.ainvoke(
            {"input": data},
            {"configurable": {"thread_id": workflow_id}}
        )
        
        # Save final checkpoint
        await self.checkpoint_manager.create_checkpoint(
            thread_id=workflow_id,
            discipline=discipline,
            step="completed",
            state=result
        )
        
        return result
```

### 5. Proactive Testing Integration

**Purpose**: Failure prediction and self-healing.

**Implementation**:
```python
from deep_agents.agents.shared.discipline_it_specialists.proactive_testing_agent import (
    ProactiveTestingAgent,
    PredictiveFailureDetector,
    SelfHealingEngine
)

class MyWorkflowCoordinator(MessagingMixin):
    def __init__(self, config: Optional[Dict[str, Any]] = None):
        super().__init__()
        self.testing_agent = ProactiveTestingAgent(config)
        self.failure_detector = PredictiveFailureDetector()
        self.self_healing = SelfHealingEngine()
    
    async def run_with_proactive_testing(
        self,
        workflow_state: Dict[str, Any],
        discipline: str
    ) -> Dict[str, Any]:
        # Phase 1: Predict potential failures
        potential_failures = await self.failure_detector.scan_workflow(
            workflow_state, discipline
        )
        
        # Phase 2: Apply self-healing
        healed_state = await self.self_healing.apply_retries_and_fallbacks(
            workflow_state, potential_failures
        )
        
        # Phase 3: Run proactive tests
        test_results = await self.testing_agent._execute_impl(
            workflow_state=healed_state,
            discipline=discipline,
            developer_mode=True
        )
        
        return {
            "workflow_result": healed_state,
            "testing_report": test_results
        }
```

---

## Standard Wiring Checklist

### Pre-Implementation Checklist

- [ ] **Agent Identity Defined**
  - [ ] `agent_id` follows naming convention: `{prefix}_{function}_agent`
  - [ ] `agent_name` is human-readable
  - [ ] `version` follows semantic versioning

- [ ] **Base Class Selected**
  - [ ] `MessagingMixin` for standalone agents
  - [ ] `SubAgent` for subordinate agents
  - [ ] `GovernanceAgent` for governance agents

- [ ] **Configuration Schema Defined**
  - [ ] Default configuration method implemented
  - [ ] Required vs optional parameters documented
  - [ ] Environment-specific overrides supported

### Implementation Checklist

- [ ] **MessagingMixin Wired**
  - [ ] `init_messaging()` called in `__init__`
  - [ ] `messaging_heartbeat()` called at processing start
  - [ ] `messaging_checkpoint()` called at each major step
  - [ ] `messaging_record_metrics()` called on completion
  - [ ] `messaging_send()` used for notifications

- [ ] **Governance Decorator Applied**
  - [ ] `@with_governance` on main processing method
  - [ ] Jurisdiction configured (default: 'FI')
  - [ ] Strict mode enabled for production agents

- [ ] **Agent Registry Entry Created**
  - [ ] Agent registered in `agents_tracking` table
  - [ ] Capabilities list complete
  - [ ] Dependencies documented
  - [ ] Module path and class name correct

- [ ] **Checkpointing Enabled**
  - [ ] `CheckpointManager` integrated
  - [ ] Resume capability tested
  - [ ] State serialization validated

- [ ] **Testing Infrastructure**
  - [ ] Unit tests created
  - [ ] Integration tests with workflow
  - [ ] Proactive testing integration

### Post-Implementation Checklist

- [ ] **Documentation Complete**
  - [ ] Agent README created
  - [ ] API documentation updated
  - [ ] Workflow documentation updated

- [ ] **Verification Passed**
  - [ ] All tests pass
  - [ ] Governance compliance verified
  - [ ] Checkpoint/resume tested
  - [ ] Health monitoring active

---

## Implementation Procedure

### Step 1: Create Agent File

**Location**: `deep_agents/deep_agents/agents/pages/{discipline}/{category}/`

**Template**:
```python
"""
{Agent Name} ({Discipline Code})
{Phase/Description}

{Detailed description of agent purpose and functionality}
"""

import asyncio
import json
import logging
from typing import Dict, List, Any, Optional
from datetime import datetime
import uuid

from deep_agents.messaging.mixin import MessagingMixin
from deep_agents.agents.shared.governance import with_governance

logger = logging.getLogger(__name__)


class {AgentClassName}(MessagingMixin):
    """
    {Agent Name} - {Brief Description}
    
    {Extended description of capabilities and integration points}
    """

    VERSION = "1.0.0"
    DISCIPLINE = "{Discipline Name}"
    PREFIX = "{Discipline Code}"

    def __init__(self, agent_config: Optional[Dict[str, Any]] = None):
        self.config = agent_config or self._default_config()
        self.agent_id = "{discipline_code}_{function}_agent"
        self.agent_name = "{Agent Name}"
        self.version = self.VERSION
        self.discipline = self.DISCIPLINE
        self.prefix = self.PREFIX

        # Initialize MessagingMixin
        self.init_messaging(organization_id=self.config.get("organization_id"))

        logger.info(f"🤖 {self.agent_name} initialized (v{self.version})")

    def _default_config(self) -> Dict[str, Any]:
        """Default agent configuration"""
        return {
            "timeout": 30000,
            "max_retries": 2,
            "confidence_threshold": 0.75,
            "governance": {
                "jurisdiction": "FI",
                "strict_mode": True,
            },
        }

    @with_governance(jurisdiction='FI', strict_mode=True)
    async def process(self, input_data: Dict[str, Any]) -> Dict[str, Any]:
        """
        Main processing method.
        
        Args:
            input_data: Processing input with required fields
            
        Returns:
            Processing result with status and data
        """
        session_id = input_data.get("session_id", str(uuid.uuid4()))
        start_time = datetime.now()
        
        # Heartbeat
        self.messaging_heartbeat(step="processing")
        
        try:
            # Save start checkpoint
            self.messaging_checkpoint(
                workflow_id=session_id,
                current_step="processing",
                completed_steps=["init"],
                pending_steps=["finalize"],
                partial_results={}
            )
            
            # ... Main processing logic here ...
            
            result = {
                "status": "success",
                "session_id": session_id,
                "agent_id": self.agent_id,
                "agent_name": self.agent_name,
                "discipline": self.discipline,
                "processing_time_seconds": (datetime.now() - start_time).total_seconds(),
                "timestamp": datetime.now().isoformat(),
            }
            
            # Record metrics
            self.messaging_record_metrics(
                workflow_id=session_id,
                discipline=self.discipline,
                success=True
            )
            
            # Send completion notification
            self.messaging_send(
                to_agent="orchestrator",
                subject=f"[{self.prefix}] {self.agent_name} Complete",
                body=f"Session {session_id} completed successfully",
                type="result"
            )
            
            return result
            
        except Exception as e:
            logger.error(f"{self.agent_name} failed: {e}")
            
            # Record failure metrics
            self.messaging_record_metrics(
                workflow_id=session_id,
                discipline=self.discipline,
                success=False
            )
            
            return {
                "status": "error",
                "session_id": session_id,
                "agent_id": self.agent_id,
                "error": str(e),
                "timestamp": datetime.now().isoformat(),
            }

    def get_capabilities(self) -> Dict[str, Any]:
        """Get agent capabilities"""
        return {
            "agent_id": self.agent_id,
            "agent_name": self.agent_name,
            "version": self.version,
            "discipline": self.discipline,
            "capabilities": [
                # List capabilities here
            ],
        }

    def get_health_status(self) -> Dict[str, Any]:
        """Get agent health status"""
        return {
            "agent_id": self.agent_id,
            "status": "healthy",
            "version": self.version,
            "timestamp": datetime.now().isoformat(),
        }


def create_{function}_agent(config: Dict[str, Any] = None) -> {AgentClassName}:
    """Factory function to create agent instance"""
    return {AgentClassName}(config)


if __name__ == "__main__":
    # Test execution
    async def test():
        agent = create_{function}_agent()
        result = await agent.process({"test": True})
        print(json.dumps(result, indent=2, default=str))
    
    asyncio.run(test())
```

### Step 2: Register Agent

**Create registration script**:
```python
# scripts/register_{discipline}_agents.py

import asyncio
from deep_agents.core.agent_registry import AgentRegistry

async def register_agents():
    registry = AgentRegistry.get_instance()
    await registry.initialize()
    
    agents = [
        {
            "agent_name": "01900_template_analysis_agent",
            "organization_id": "construct_ai",
            "page_prefix": "01900",
            "discipline": "procurement",
            "module_path": "deep_agents.agents.pages.01900-procurement.main_agents.01900_template_analysis_agent",
            "class_name": "ProcurementTemplateAnalysisAgent",
            "capabilities": [
                "template_compatibility_analysis",
                "procurement_requirement_extraction",
                "template_ranking_and_recommendation"
            ],
            "dependencies": [],
            "version": "1.0.0",
            "auto_load": True
        },
        # ... more agents
    ]
    
    for agent in agents:
        success = await registry.register_agent(agent)
        print(f"{'✓' if success else '✗'} {agent['agent_name']}")

if __name__ == "__main__":
    asyncio.run(register_agents())
```

### Step 3: Create Tests

**Create test file**:
```javascript
// tests/test-{discipline}-{agent}.cjs

'use strict';

const { testAgent } = require('./test-helpers.cjs');

async function runTests() {
  console.log('Testing {Agent Name}...\n');
  
  // Test 1: Agent initialization
  const initResult = await testAgent('01900_template_analysis_agent', {
    test: 'initialize'
  });
  console.log(`✓ Initialization: ${initResult.success ? 'PASS' : 'FAIL'}`);
  
  // Test 2: Processing
  const processResult = await testAgent('01900_template_analysis_agent', {
    test: 'process',
    input: {
      procurement_data: { id: 'TEST-001' },
      available_templates: []
    }
  });
  console.log(`✓ Processing: ${processResult.success ? 'PASS' : 'FAIL'}`);
  
  // Test 3: Checkpointing
  const checkpointResult = await testAgent('01900_template_analysis_agent', {
    test: 'checkpoint',
    session_id: 'test-session-001'
  });
  console.log(`✓ Checkpointing: ${checkpointResult.success ? 'PASS' : 'FAIL'}`);
  
  // Summary
  const passed = [initResult, processResult, checkpointResult].filter(r => r.success).length;
  console.log(`\n${passed}/3 tests passed`);
  
  process.exit(passed === 3 ? 0 : 1);
}

runTests().catch(console.error);
```

### Step 4: Wire into Workflow

**Update HITL Coordinator**:
```python
# In {discipline}_hitl_coordinator.py

def _load_agents(self) -> None:
    """Lazy-load sub-agents"""
    if self._agents:
        return

    import importlib

    def _get(module_name: str, class_name: str):
        mod = importlib.import_module(
            f"deep_agents.agents.pages.{self.prefix}-{self.discipline.lower()}.main_agents.{module_name}"
        )
        return getattr(mod, class_name)

    cfg = self.config

    self._agents = {
        "template_analysis": _get(
            "01900_template_analysis_agent", "ProcurementTemplateAnalysisAgent"
        )(cfg),
        # ... more agents
    }
```

---

## Workflow-Specific Wiring

### Procurement Workflow (01900) - Complete Example

**Agents to Wire**:

| Agent | Type | Wiring Requirements |
|-------|------|---------------------|
| `ProcurementHITLCoordinator` | HITL Coordinator | MessagingMixin, @with_governance, CheckpointManager |
| `ProcurementTemplateAnalysisAgent` | Main Agent | MessagingMixin, @with_governance |
| `ProcurementRequirementsExtractionAgent` | Main Agent | MessagingMixin, @with_governance |
| `ProcurementComplianceValidationAgent` | Main Agent | MessagingMixin, @with_governance |
| `ProcurementFieldPopulationAgent` | Main Agent | MessagingMixin, @with_governance |
| `ProcurementQualityAssuranceAgent` | Main Agent | MessagingMixin, @with_governance |
| `ProcurementFinalReviewAgent` | Main Agent | MessagingMixin, @with_governance |
| `TechnicalRoutingSpecialistAgent` | Specialist | SubAgent, MessagingMixin |
| `LogisticsSpecialistAgent` | Specialist | SubAgent, MessagingMixin |
| `SafetySpecialistAgent` | Specialist | SubAgent, MessagingMixin |
| `ProactiveTestingAgent` | Testing | SubAgent, CheckpointManager |

**Wiring Verification Command**:
```bash
# Run all procurement tests
node deep-agents/deep_agents/agents/pages/01900-procurement/tests/run-all-tests.cjs

# Run specific stage
node deep-agents/deep_agents/agents/pages/01900-procurement/tests/run-all-tests.cjs --stage=3
```

---

## Testing Requirements

### Test Stages

| Stage | Purpose | File |
|-------|---------|------|
| 1 | Order Creation Agent | `test-stage1-order-creation.cjs` |
| 2 | Procurement Input Agent | `test-stage2-conversation.cjs` |
| 3 | 6-Agent Deep Workflow | `test-stage3-deep-agents.cjs` |
| 4 | Proactive Testing | `test-stage4-proactive-testing.cjs` |

### Test Coverage Requirements

- [ ] **Unit Tests**: Each agent has isolated unit tests
- [ ] **Integration Tests**: Agent works within workflow
- [ ] **Checkpoint Tests**: Resume from checkpoint works
- [ ] **Governance Tests**: Compliance validation passes
- [ ] **Error Handling**: Graceful failure and recovery

---

## Verification & Validation

### Automated Verification Script

```python
# scripts/verify_agent_wiring.py

import asyncio
import importlib
from typing import Dict, List, Any

async def verify_agent_wiring(agent_module: str, agent_class: str) -> Dict[str, Any]:
    """Verify an agent is properly wired"""
    results = {
        "agent": f"{agent_module}.{agent_class}",
        "checks": [],
        "passed": 0,
        "failed": 0
    }
    
    try:
        # Import agent
        mod = importlib.import_module(agent_module)
        agent_cls = getattr(mod, agent_class)
        agent = agent_cls()
        
        # Check 1: MessagingMixin
        has_messaging = hasattr(agent, 'init_messaging')
        results["checks"].append({
            "check": "MessagingMixin",
            "passed": has_messaging,
            "details": "init_messaging method exists" if has_messaging else "MISSING init_messaging"
        })
        
        # Check 2: Governance decorator
        has_governance = hasattr(agent_cls.process, '__wrapped__')
        results["checks"].append({
            "check": "Governance Decorator",
            "passed": has_governance,
            "details": "@with_governance applied" if has_governance else "MISSING @with_governance"
        })
        
        # Check 3: Agent identity
        has_identity = hasattr(agent, 'agent_id') and hasattr(agent, 'agent_name')
        results["checks"].append({
            "check": "Agent Identity",
            "passed": has_identity,
            "details": f"agent_id: {agent.agent_id}" if has_identity else "MISSING agent_id/agent_name"
        })
        
        # Check 4: Capabilities method
        has_capabilities = hasattr(agent, 'get_capabilities')
        results["checks"].append({
            "check": "Capabilities Method",
            "passed": has_capabilities,
            "details": "get_capabilities() exists" if has_capabilities else "MISSING get_capabilities()"
        })
        
        # Check 5: Health status method
        has_health = hasattr(agent, 'get_health_status')
        results["checks"].append({
            "check": "Health Status Method",
            "passed": has_health,
            "details": "get_health_status() exists" if has_health else "MISSING get_health_status()"
        })
        
        # Summary
        results["passed"] = sum(1 for c in results["checks"] if c["passed"])
        results["failed"] = len(results["checks"]) - results["passed"]
        
    except Exception as e:
        results["error"] = str(e)
        results["failed"] = 1
    
    return results


async def main():
    agents = [
        ("deep_agents.agents.pages.01900-procurement.main_agents.01900_template_analysis_agent", 
         "ProcurementTemplateAnalysisAgent"),
        ("deep_agents.agents.pages.01900-procurement.main_agents.01900_requirements_extraction_agent",
         "ProcurementRequirementsExtractionAgent"),
        # ... more agents
    ]
    
    print("=" * 70)
    print("AGENT WIRING VERIFICATION")
    print("=" * 70)
    
    total_passed = 0
    total_failed = 0
    
    for module, cls in agents:
        result = await verify_agent_wiring(module, cls)
        print(f"\n{result['agent']}")
        for check in result["checks"]:
            icon = "✓" if check["passed"] else "✗"
            print(f"  {icon} {check['check']}: {check['details']}")
        total_passed += result["passed"]
        total_failed += result["failed"]
    
    print("\n" + "=" * 70)
    print(f"TOTAL: {total_passed} passed, {total_failed} failed")
    print("=" * 70)


if __name__ == "__main__":
    asyncio.run(main())
```

---

## Troubleshooting

### Common Wiring Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| `MessagingMixin` not working | `init_messaging()` not called | Add call in `__init__` |
| Governance not enforced | `@with_governance` missing | Add decorator to `process()` |
| Checkpoint not saving | `CheckpointManager` not initialized | Initialize in coordinator |
| Agent not discovered | Not registered in `agents_tracking` | Run registration script |
| Tests failing | Missing dependencies | Check import paths |

### Debug Commands

```bash
# Check agent registry
python -c "from deep_agents.core.agent_registry import AgentRegistry; import asyncio; asyncio.run(AgentRegistry.get_instance().get_system_status())"

# Test messaging
python -c "from deep_agents.messaging.mixin import MessagingMixin; print('MessagingMixin OK')"

# Test governance
python -c "from deep_agents.agents.shared.governance import with_governance; print('Governance OK')"

# Run verification
python scripts/verify_agent_wiring.py
```

---

## Related Procedures

| Procedure | Relationship |
|-----------|--------------|
| [`0000_WORKFLOW_CHECKPOINTER_IMPLEMENTATION_PROCEDURE.md`](0000_WORKFLOW_CHECKPOINTER_IMPLEMENTATION_PROCEDURE.md) | Checkpointing implementation details |
| [`0000_DEEP_AGENT_MESSAGING_OBSERVABILITY_PROCEDURE.md`](agent-development/0000_DEEP_AGENT_MESSAGING_OBSERVABILITY_PROCEDURE.md) | Messaging infrastructure details |
| [`0000_GOVERNANCE_FRAMEWORK_PROCEDURE.md`](../agents/procedures/0000_GOVERNANCE_FRAMEWORK_PROCEDURE.md) | Governance framework details |
| [`0000_TESTING_WORKFLOW_PROCEDURE.md`](../0000_TESTING_WORKFLOW_PROCEDURE.md) | Testing framework details |
| [`02100_AGENT_DEVELOPMENT_PROCEDURE.md`](../02100_AGENT_DEVELOPMENT_PROCEDURE.md) | Agent development lifecycle |

---

## Document Information

- **Document ID**: `0000_AGENT_WIRING_METHODOLOGY_PROCEDURE`
- **Version**: 1.0.0
- **Created**: 2026-02-22
- **Last Updated**: 2026-02-22
- **Author**: Construct AI Development Team
- **Review Cycle**: Quarterly
- **Status**: ✅ ACTIVE

---

**Navigation**: This procedure is part of the Implementation Procedures cluster. Use this for wiring agents into any workflow.