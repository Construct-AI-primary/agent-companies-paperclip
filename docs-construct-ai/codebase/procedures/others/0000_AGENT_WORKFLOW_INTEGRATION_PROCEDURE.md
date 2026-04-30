---
memory_layer: durable_knowledge
para_section: pages/codebase/workflows
gigabrain_tags: workflows, codebase, automation
documentation
openstinger_context: workflow-automation, process-management
last_updated: 2026-03-21
related_docs:
  - codebase/workflows/
  - disciplines/
---
# 0000_AGENT_WORKFLOW_INTEGRATION_PROCEDURE.md

## Agent Workflow Integration Procedure

**Document ID**: `0000_AGENT_WORKFLOW_INTEGRATION_PROCEDURE`  
**Version**: 1.0.0  
**Created**: 2026-02-23  
**Last Updated**: 2026-02-23  
**Author**: Construct AI Development Team  
**Review Cycle**: Quarterly  
**Status**: ✅ ACTIVE

---

## Table of Contents

1. [Overview](#overview)
2. [Integration Layers](#integration-layers)
3. [Step-by-Step Integration Guide](#step-by-step-integration-guide)
4. [HITL Coordinator Pattern](#hitl-coordinator-pattern)
5. [Message Handler Implementation](#message-handler-implementation)
6. [Checkpoint Integration](#checkpoint-integration)
7. [Testing Integration](#testing-integration)
8. [Complete Integration Example](#complete-integration-example)
9. [Verification Checklist](#verification-checklist)
10. [Troubleshooting](#troubleshooting)
11. [Related Procedures](#related-procedures)

---

## Overview

This procedure provides a comprehensive guide for integrating AI agents into Construct AI workflows. It covers the complete integration lifecycle from infrastructure wiring to production deployment.

### What is "Full Integration"?

An agent is "fully integrated" when it:

1. **Infrastructure Layer**: Has MessagingMixin for observability
2. **Orchestration Layer**: Is called by the HITL Coordinator in the correct sequence
3. **Communication Layer**: Can send/receive messages from other agents
4. **Persistence Layer**: Creates checkpoints for workflow resumption
5. **Governance Layer**: Enforces compliance via `@with_governance`
6. **Testing Layer**: Has unit and integration tests

### Integration Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        FULLY INTEGRATED AGENT                            │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │                     GOVERNANCE LAYER                                │ │
│  │  @with_governance(jurisdiction='FI', strict_mode=True)             │ │
│  │  • AIUC-1 compliance                                               │ │
│  │  • ISO 42001 / ISO 27701                                          │ │
│  │  • EU AI Act / NIS2                                               │ │
│  └────────────────────────────────────────────────────────────────────┘ │
│                                   │                                      │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │                   ORCHESTRATION LAYER                               │ │
│  │  HITL Coordinator calls agent in workflow sequence                 │ │
│  │  • Stage 1 → Stage 2 → Stage 3 → ... → Stage N                    │ │
│  │  • HITL Gates at critical decision points                          │ │
│  └────────────────────────────────────────────────────────────────────┘ │
│                                   │                                      │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │                   COMMUNICATION LAYER                               │ │
│  │  on_message() handler for inter-agent communication                │ │
│  │  • status, question, result, error, escalation types               │ │
│  └────────────────────────────────────────────────────────────────────┘ │
│                                   │                                      │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │                   PERSISTENCE LAYER                                 │ │
│  │  messaging_checkpoint() for workflow state persistence             │ │
│  │  • Save state at each major step                                   │ │
│  │  • Resume from failure point                                       │ │
│  └────────────────────────────────────────────────────────────────────┘ │
│                                   │                                      │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │                   INFRASTRUCTURE LAYER                              │ │
│  │  MessagingMixin provides:                                          │ │
│  │  • messaging_heartbeat() - alive signal                            │ │
│  │  • messaging_send() - agent mail                                   │ │
│  │  • messaging_record_metrics() - token/cost tracking                │ │
│  │  • messaging_escalate() - error escalation                         │ │
│  └────────────────────────────────────────────────────────────────────┘ │
│                                   │                                      │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │                     TESTING LAYER                                   │ │
│  │  Unit tests + Integration tests + Proactive testing                │ │
│  └────────────────────────────────────────────────────────────────────┘ │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Integration Layers

### Layer 1: Infrastructure (MessagingMixin)

**Purpose**: Provides observability and communication primitives.

**Implementation**:
```python
from deep_agents.messaging.mixin import MessagingMixin

class MyAgent(MessagingMixin):
    def __init__(self, agent_config: Optional[Dict[str, Any]] = None):
        self.config = agent_config or self._default_config()
        self.agent_id = "01900_my_agent"
        self.agent_name = "My Agent"
        self.version = "1.0.0"
        
        # Initialize MessagingMixin - REQUIRED
        self.init_messaging(organization_id=self.config.get("organization_id"))
```

**Available Methods**:
| Method | Purpose | Usage |
|--------|---------|-------|
| `messaging_heartbeat(step)` | Signal agent is alive | Call at start of processing |
| `messaging_checkpoint(...)` | Save workflow state | Call at each major step |
| `messaging_send(to, subject, body, ...)` | Send message to another agent | Call to notify other agents |
| `messaging_get_unread()` | Get unread messages | Call to receive messages |
| `messaging_record_metrics(...)` | Record token/cost metrics | Call on completion |
| `messaging_escalate(subject, body, ...)` | Escalate error to orchestrator | Call on critical errors |
| `messaging_clear_checkpoint(workflow_id)` | Clear checkpoint on success | Call after successful completion |
| `messaging_load_checkpoint(workflow_id)` | Load checkpoint for resume | Call to resume from failure |

### Layer 2: Governance

**Purpose**: Enforce compliance with AI regulations.

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

**Governance Frameworks**:
- AIUC-1 (AI Use Cases)
- ISO 42001 (AI Management System)
- ISO 27701 (Privacy Information Management)
- EU AI Act (European AI Regulation)
- NIS2 (Network and Information Security)

### Layer 3: Orchestration

**Purpose**: Define how agents are called in sequence.

**Implementation in HITL Coordinator**:
```python
class ProcurementHITLCoordinator(MessagingMixin):
    def _load_agents(self) -> None:
        """Lazy-load sub-agents"""
        self._agents = {
            "template_analysis": ProcurementTemplateAnalysisAgent(self.config),
            "requirements_extraction": ProcurementRequirementExtractionAgent(self.config),
            "compliance_validation": ProcurementComplianceValidationAgent(self.config),
            "field_population": ProcurementFieldPopulationAgent(self.config),
            "quality_assurance": ProcurementQualityAssuranceAgent(self.config),
            "final_review": ProcurementFinalReviewAgent(self.config),
        }
    
    @with_governance(jurisdiction='FI', strict_mode=True)
    async def coordinate(self, input_data: Dict[str, Any]) -> Dict[str, Any]:
        # Stage 1
        stage1 = await self._agents["template_analysis"].process({
            "document": document,
            "procurement_data": procurement_data,
        })
        await self._save_checkpoint(session_id, "stage1_template_analysis", stage1)
        
        # Stage 2
        stage2 = await self._agents["requirements_extraction"].process({
            "document": document,
            "template_analysis": stage1,
            "procurement_data": procurement_data,
        })
        await self._save_checkpoint(session_id, "stage2_requirements_extraction", stage2)
        
        # ... continue for all stages
```

### Layer 4: Communication (Message Handlers)

**Purpose**: Enable inter-agent communication.

**Implementation**:
```python
class ProcurementHITLCoordinator(MessagingMixin):
    async def on_message(self, message: Dict[str, Any]) -> Optional[Dict[str, Any]]:
        """
        Handle incoming messages from other agents.
        
        Message types:
        - 'status': Status update from sub-agent
        - 'question': Question requiring coordinator decision
        - 'result': Final result from sub-agent
        - 'error': Error report from sub-agent
        - 'escalation': Escalation requiring human attention
        """
        msg_type = message.get("type", "status")
        from_agent = message.get("from_agent", "unknown")
        
        if msg_type == "escalation":
            return await self._handle_escalation(from_agent, message)
        elif msg_type == "error":
            return await self._handle_agent_error(from_agent, message)
        elif msg_type == "question":
            return await self._handle_agent_question(from_agent, message)
        elif msg_type == "result":
            return {"status": "acknowledged", "from_agent": from_agent}
        else:
            return {"status": "received"}
```

### Layer 5: Persistence (Checkpointing)

**Purpose**: Enable workflow resumption after failures.

**Implementation**:
```python
class MyAgent(MessagingMixin):
    @with_governance(jurisdiction='FI', strict_mode=True)
    async def process(self, input_data: Dict[str, Any]) -> Dict[str, Any]:
        session_id = input_data.get("session_id", str(uuid.uuid4()))
        
        # Heartbeat at start
        self.messaging_heartbeat(step="processing")
        
        # Checkpoint at start
        self.messaging_checkpoint(
            workflow_id=session_id,
            current_step="processing_started",
            completed_steps=["init"],
            pending_steps=["extract", "validate", "finalize"],
            partial_results={"procurement_id": input_data.get("procurement_id")}
        )
        
        # ... do work ...
        
        # Checkpoint at completion
        self.messaging_checkpoint(
            workflow_id=session_id,
            current_step="processing_completed",
            completed_steps=["init", "extract", "validate", "finalize"],
            pending_steps=[],
            partial_results=result
        )
        
        # Clear checkpoint on success
        self.messaging_clear_checkpoint(session_id)
        
        # Record metrics
        self.messaging_record_metrics(
            workflow_id=session_id,
            discipline="procurement",
            success=True
        )
        
        return result
```

### Layer 6: Testing

**Purpose**: Ensure agent works correctly in isolation and integration.

**Implementation**:
```python
# tests/integration/test_procurement_workflow.py

import pytest

class TestMyAgent:
    @pytest.mark.asyncio
    async def test_agent_initialization(self):
        """Test agent initializes correctly"""
        agent = MyAgent()
        assert agent.agent_id == "01900_my_agent"
        assert hasattr(agent, 'messaging_heartbeat')
        assert hasattr(agent, 'messaging_checkpoint')
    
    @pytest.mark.asyncio
    async def test_process_with_checkpointing(self, sample_data):
        """Test process method with checkpointing"""
        agent = MyAgent()
        result = await agent.process({
            **sample_data,
            "session_id": "test-session-123"
        })
        assert result["status"] == "success"
    
    @pytest.mark.asyncio
    async def test_message_handling(self):
        """Test on_message handler"""
        coordinator = ProcurementHITLCoordinator()
        result = await coordinator.on_message({
            "type": "escalation",
            "from_agent": "test_agent",
            "subject": "Test",
            "body": "Test escalation"
        })
        assert result["status"] == "escalated"
```

---

## Step-by-Step Integration Guide

### Step 1: Create Agent with MessagingMixin

```python
# File: deep_agents/deep_agents/agents/pages/01900-procurement/main_agents/01900_my_agent.py

"""
My Agent (01900)
Description of what this agent does.

Wiring Status:
- ✅ MessagingMixin integration
- ✅ Explicit checkpointing
- ✅ Governance decorator
"""

import asyncio
import json
import uuid
from typing import Dict, List, Any, Optional
from datetime import datetime
import logging

from deep_agents.agents.shared.governance import with_governance
from deep_agents.messaging.mixin import MessagingMixin

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class MyAgent(MessagingMixin):
    """
    My Agent - Description of purpose.
    
    Uses MessagingMixin for:
    - Agent mail communication
    - Workflow checkpointing
    - Metrics recording
    - Health monitoring
    """

    VERSION = "1.0.0"
    DISCIPLINE = "Procurement"
    PREFIX = "01900"

    def __init__(self, agent_config: Dict[str, Any] = None):
        self.config = agent_config or self._default_config()
        self.agent_id = "01900_my_agent"
        self.agent_name = "My Agent"
        self.version = self.VERSION
        self.discipline = self.DISCIPLINE
        self.prefix = self.PREFIX

        # Initialize MessagingMixin - REQUIRED
        self.init_messaging(
            organization_id=self.config.get("organization_id")
        )

        logger.info(f"🤖 {self.agent_name} initialized (v{self.version})")

    def _default_config(self) -> Dict[str, Any]:
        """Default agent configuration"""
        return {
            "timeout": 30000,
            "max_retries": 2,
            "confidence_threshold": 0.75,
        }

    @with_governance(jurisdiction='FI', strict_mode=True)
    async def process(self, input_data: Dict[str, Any]) -> Dict[str, Any]:
        """
        Main processing method with full integration.
        
        Args:
            input_data: Processing input including session_id
            
        Returns:
            Processing result with status and data
        """
        session_id = input_data.get("session_id", str(uuid.uuid4()))
        start_time = datetime.now()
        
        # 1. Heartbeat - signal we're alive
        self.messaging_heartbeat(step="my_agent_processing")
        
        # 2. Checkpoint at start
        self.messaging_checkpoint(
            workflow_id=session_id,
            current_step="my_agent_started",
            completed_steps=["init"],
            pending_steps=["process", "finalize"],
            partial_results={"input_received": True}
        )
        
        try:
            # 3. Main processing logic
            result_data = await self._do_work(input_data)
            
            # 4. Checkpoint at completion
            self.messaging_checkpoint(
                workflow_id=session_id,
                current_step="my_agent_completed",
                completed_steps=["init", "process", "finalize"],
                pending_steps=[],
                partial_results=result_data
            )
            
            # 5. Notify next agent in chain
            self.messaging_send(
                to_agent="01900_next_agent",
                subject=f"Processing complete: {session_id}",
                body=f"MyAgent completed successfully",
                type="worker_done",
                payload={"session_id": session_id},
                workflow_id=session_id
            )
            
            # 6. Clear checkpoint on success
            self.messaging_clear_checkpoint(session_id)
            
            # 7. Record metrics
            self.messaging_record_metrics(
                workflow_id=session_id,
                discipline=self.discipline,
                success=True
            )
            
            return {
                "status": "success",
                "session_id": session_id,
                "agent_id": self.agent_id,
                "result": result_data,
                "processing_time_seconds": (datetime.now() - start_time).total_seconds()
            }
            
        except Exception as e:
            logger.error(f"{self.agent_name} failed: {e}")
            
            # Record failure metrics
            self.messaging_record_metrics(
                workflow_id=session_id,
                discipline=self.discipline,
                success=False
            )
            
            # Escalate error
            self.messaging_escalate(
                subject=f"{self.agent_name} failed: {session_id}",
                body=str(e),
                workflow_id=session_id
            )
            
            return {
                "status": "error",
                "session_id": session_id,
                "agent_id": self.agent_id,
                "error": str(e)
            }

    async def _do_work(self, input_data: Dict[str, Any]) -> Dict[str, Any]:
        """Actual processing logic"""
        # Implement your agent's logic here
        return {"processed": True}

    def get_capabilities(self) -> Dict[str, Any]:
        """Get agent capabilities"""
        return {
            "agent_id": self.agent_id,
            "agent_name": self.agent_name,
            "version": self.version,
            "capabilities": ["capability_1", "capability_2"],
        }

    def get_health_status(self) -> Dict[str, Any]:
        """Get agent health status"""
        return {
            "agent_id": self.agent_id,
            "status": "healthy",
            "version": self.version,
            "timestamp": datetime.now().isoformat()
        }


def create_my_agent(config: Dict[str, Any] = None) -> MyAgent:
    """Factory function to create agent instance"""
    return MyAgent(config)
```

### Step 2: Register Agent in Workflow

```python
# File: deep_agents/deep_agents/agents/pages/01900-procurement/register_agents.py

PROCUREMENT_AGENTS = [
    # ... existing agents ...
    {
        "agent_name": "01900_my_agent",
        "page_prefix": "01900",
        "discipline": "procurement",
        "module_path": "deep_agents.agents.pages.01900-procurement.main_agents.01900_my_agent",
        "class_name": "MyAgent",
        "capabilities": ["capability_1", "capability_2"],
        "version": "1.0.0",
        "messaging_enabled": True,  # ✅ WIRED
        "governance_enabled": True,
        "checkpointing_enabled": True,
    },
]
```

### Step 3: Add to HITL Coordinator

```python
# File: deep_agents/deep_agents/agents/pages/01900-procurement/01900_procurement_hitl_coordinator.py

def _load_agents(self) -> None:
    """Lazy-load sub-agents"""
    self._agents = {
        # ... existing agents ...
        "my_agent": MyAgent(self.config),
    }

@with_governance(jurisdiction='FI', strict_mode=True)
async def coordinate(self, input_data: Dict[str, Any]) -> Dict[str, Any]:
    # ... existing stages ...
    
    # Stage N: My Agent
    logger.info("🎯 Stage N: My Agent")
    stage_n = await self._agents["my_agent"].process({
        "previous_stage_result": stage_n_minus_1,
        "procurement_data": procurement_data,
        "session_id": session_id,
    })
    workflow_results["my_agent"] = stage_n
    await self._save_checkpoint(session_id, "stage_n_my_agent", stage_n)
```

### Step 4: Create Tests

```python
# File: deep-agents/tests/integration/test_procurement_workflow.py

class TestMyAgent:
    @pytest.mark.asyncio
    async def test_agent_initialization(self):
        """Test agent initializes correctly"""
        from deep_agents.agents.pages.01900-procurement.main_agents.01900_my_agent import MyAgent
        
        agent = MyAgent()
        assert agent.agent_id == "01900_my_agent"
        assert hasattr(agent, 'messaging_heartbeat')
        assert hasattr(agent, 'messaging_checkpoint')
        assert hasattr(agent, 'messaging_send')
    
    @pytest.mark.asyncio
    async def test_process_success(self, sample_data):
        """Test successful processing"""
        from deep_agents.agents.pages.01900-procurement.main_agents.01900_my_agent import MyAgent
        
        agent = MyAgent()
        result = await agent.process({
            **sample_data,
            "session_id": "test-session-123"
        })
        
        assert result["status"] == "success"
        assert "result" in result
```

---

## HITL Coordinator Pattern

### Standard 6-Stage Workflow

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    PROCUREMENT WORKFLOW (01900)                          │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  Stage 1: Template Analysis                                              │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │ Input: document, procurement_data, context                         │ │
│  │ Output: template_recommendations, compatibility_scores             │ │
│  │ Checkpoint: stage1_template_analysis                               │ │
│  └────────────────────────────────────────────────────────────────────┘ │
│                                   │                                      │
│                                   ▼                                      │
│  Stage 2: Requirements Extraction                                        │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │ Input: document, template_analysis, procurement_data               │ │
│  │ Output: structured_requirements, extraction_summary                │ │
│  │ Checkpoint: stage2_requirements_extraction                         │ │
│  └────────────────────────────────────────────────────────────────────┘ │
│                                   │                                      │
│                                   ▼                                      │
│  Stage 3: Compliance Validation                                          │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │ Input: procurement_data, extracted_requirements                    │ │
│  │ Output: compliance_report, validation_status                       │ │
│  │ Checkpoint: stage3_compliance_validation                           │ │
│  │ ⚠️ HITL GATE 1: Compliance Review                                  │ │
│  └────────────────────────────────────────────────────────────────────┘ │
│                                   │                                      │
│                                   ▼                                      │
│  Stage 4: Field Population                                               │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │ Input: template_structure, extracted_data, procurement_data        │ │
│  │ Output: populated_fields, field_validation                         │ │
│  │ Checkpoint: stage4_field_population                                │ │
│  └────────────────────────────────────────────────────────────────────┘ │
│                                   │                                      │
│                                   ▼                                      │
│  Stage 5: Quality Assurance                                              │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │ Input: populated_document, procurement_data, compliance_report     │ │
│  │ Output: quality_assessment, completeness_score                     │ │
│  │ Checkpoint: stage5_quality_assurance                               │ │
│  └────────────────────────────────────────────────────────────────────┘ │
│                                   │                                      │
│                                   ▼                                      │
│  Stage 6: Final Review                                                   │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │ Input: quality_assessment, populated_document, procurement_data    │ │
│  │ Output: final_approval_recommendation, risk_assessment             │ │
│  │ Checkpoint: stage6_final_review                                    │ │
│  │ ⚠️ HITL GATE 2: Final Approval                                     │ │
│  └────────────────────────────────────────────────────────────────────┘ │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### HITL Gate Implementation

```python
async def _evaluate_hitl_gate(
    self,
    gate_name: str,
    session_id: str,
    stage_result: Dict[str, Any],
    procurement_data: Dict[str, Any],
) -> Dict[str, Any]:
    """
    Evaluate whether a human review gate should block or allow progression.
    
    Triggers human review when:
    - Compliance violations are present
    - Procurement value exceeds high_value_threshold
    - Quality score is below hitl_review_threshold
    - Final recommendation is not 'approved'
    """
    if not self.config.get("hitl_enabled", True):
        return {"gate": gate_name, "triggered": False, "blocked": False}

    procurement_value = procurement_data.get("totalValue", 0)
    high_value = procurement_value >= self.config.get("high_value_threshold", 500000)

    triggered = False
    blocked = False
    reasons = []

    if gate_name == "compliance_review":
        compliance_report = stage_result.get("compliance_report", {})
        if not compliance_report.get("overall_compliant", True):
            triggered = True
            reasons.append("Compliance violations detected")
        if high_value:
            triggered = True
            reasons.append(f"High-value procurement (ZAR {procurement_value:,}) requires human review")

    elif gate_name == "final_approval":
        final_review = stage_result.get("final_review", {})
        recommendation = final_review.get("final_approval_recommendation", {}).get("recommendation", "approved")
        quality_score = stage_result.get("quality_assessment", {}).get("overall_quality_score", 1.0)

        if recommendation not in ("approved", "approved_with_conditions"):
            triggered = True
            blocked = True
            reasons.append(f"Final recommendation requires human decision: '{recommendation}'")
        if quality_score < self.config.get("hitl_review_threshold", 0.70):
            triggered = True
            reasons.append(f"Quality score {quality_score:.2f} below threshold")
        if high_value:
            triggered = True
            reasons.append(f"High-value procurement requires human sign-off")

    return {
        "gate": gate_name,
        "triggered": triggered,
        "blocked": blocked,
        "reasons": reasons,
        "session_id": session_id,
        "timestamp": datetime.now().isoformat(),
    }
```

---

## Message Handler Implementation

### Message Types

| Type | Purpose | Expected Response |
|------|---------|-------------------|
| `status` | Status update from sub-agent | `{"status": "received"}` |
| `question` | Question requiring decision | `{"status": "answered", "answer": "..."}` |
| `result` | Final result from sub-agent | `{"status": "acknowledged"}` |
| `error` | Error report | `{"status": "recovery_initiated"}` or escalation |
| `escalation` | Critical issue requiring human attention | Forward to orchestrator |

### Complete Message Handler

```python
async def on_message(self, message: Dict[str, Any]) -> Optional[Dict[str, Any]]:
    """
    Handle incoming messages from other agents.
    """
    try:
        msg_type = message.get("type", "status")
        from_agent = message.get("from_agent", "unknown")
        subject = message.get("subject", "")
        body = message.get("body", "")
        payload = message.get("payload", {})
        workflow_id = message.get("workflow_id")
        
        logger.info(f"📨 Received {msg_type} from {from_agent}: {subject}")
        
        # Send heartbeat to show we're processing
        self.messaging_heartbeat(step=f"processing_{msg_type}")
        
        if msg_type == "escalation":
            return await self._handle_escalation(from_agent, subject, body, payload, workflow_id)
        
        elif msg_type == "error":
            logger.error(f"Error from {from_agent}: {body}")
            return await self._handle_agent_error(from_agent, subject, body, payload, workflow_id)
        
        elif msg_type == "question":
            return await self._handle_agent_question(from_agent, subject, body, payload, workflow_id)
        
        elif msg_type == "result":
            logger.info(f"Result received from {from_agent}: {subject}")
            return {"status": "acknowledged", "from_agent": from_agent}
        
        else:
            logger.debug(f"Status from {from_agent}: {body}")
            return {"status": "received"}
            
    except Exception as e:
        logger.error(f"Message handling failed: {e}")
        return {"status": "error", "error": str(e)}

async def _handle_escalation(self, from_agent, subject, body, payload, workflow_id):
    """Handle escalation from sub-agent."""
    logger.warning(f"🚨 ESCALATION from {from_agent}: {subject}")
    
    # Forward to orchestrator with high priority
    self.messaging_send(
        to_agent="orchestrator",
        subject=f"[ESCALATION] {subject}",
        body=f"Escalated from {from_agent}:\n\n{body}",
        type="escalation",
        priority="urgent",
        payload={"original_agent": from_agent, **payload},
        workflow_id=workflow_id,
    )
    
    return {"status": "escalated", "from_agent": from_agent, "action": "forwarded_to_orchestrator"}

async def _handle_agent_error(self, from_agent, subject, body, payload, workflow_id):
    """Handle error report from sub-agent."""
    error_type = payload.get("error_type", "unknown")
    recoverable = payload.get("recoverable", False)
    
    if recoverable:
        logger.info(f"Attempting recovery for {from_agent}")
        return {"status": "recovery_initiated", "from_agent": from_agent, "action": "retry"}
    else:
        return await self._handle_escalation(from_agent, f"Non-recoverable error: {subject}", body, payload, workflow_id)

async def _handle_agent_question(self, from_agent, subject, body, payload, workflow_id):
    """Handle question from sub-agent requiring coordinator decision."""
    logger.info(f"Question from {from_agent}: {subject}")
    
    return {
        "status": "answered",
        "from_agent": from_agent,
        "answer": "proceed_with_defaults",
        "note": "Coordinator approved proceeding with default handling"
    }
```

---

## Checkpoint Integration

### Checkpoint Lifecycle

```
┌─────────────────────────────────────────────────────────────────────────┐
│                     CHECKPOINT LIFECYCLE                                 │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  1. WORKFLOW START                                                       │
│     └─► messaging_checkpoint(workflow_id, "started", ...)               │
│                                                                          │
│  2. EACH STAGE                                                           │
│     └─► messaging_checkpoint(workflow_id, "stage_N", ...)               │
│                                                                          │
│  3. FAILURE/INTERRUPTION                                                 │
│     └─► Checkpoint preserved in database                                 │
│     └─► User can close browser/session                                   │
│                                                                          │
│  4. RESUME                                                               │
│     └─► messaging_load_checkpoint(workflow_id)                          │
│     └─► Continue from last successful stage                              │
│                                                                          │
│  5. SUCCESS                                                              │
│     └─► messaging_clear_checkpoint(workflow_id)                         │
│     └─► messaging_record_metrics(...)                                    │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### Checkpoint Best Practices

1. **Save at each major step**: Don't lose progress
2. **Include meaningful partial_results**: Enable debugging
3. **Clear on success**: Don't leave stale checkpoints
4. **Use consistent workflow_id**: Usually session_id

---

## Testing Integration

### Test File Structure

```
deep-agents/tests/
├── unit/
│   └── test_my_agent.py           # Unit tests for individual agent
├── integration/
│   └── test_procurement_workflow.py  # Integration tests for workflow
└── e2e/
    └── test_full_workflow.py      # End-to-end tests
```

### Test Categories

| Category | Purpose | Command |
|----------|---------|---------|
| Unit | Test agent in isolation | `pytest tests/unit/ -v` |
| Integration | Test agent in workflow | `pytest tests/integration/ -v` |
| E2E | Test full user flow | `pytest tests/e2e/ -v` |
| Proactive | Failure prediction | `pytest -m proactive` |

---

## Complete Integration Example

### Full Agent Implementation

See the [Step-by-Step Integration Guide](#step-by-step-integration-guide) above for a complete example.

### Full HITL Coordinator Implementation

```python
"""
Procurement HITL Coordinator (01900)

Human-in-the-Loop coordinator for the 6-agent procurement workflow.
"""

import asyncio
import uuid
from typing import Dict, List, Any, Optional
from datetime import datetime
import logging

from deep_agents.agents.shared.governance import with_governance
from deep_agents.messaging.mixin import MessagingMixin

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class ProcurementHITLCoordinator(MessagingMixin):
    """
    Human-in-the-Loop Coordinator for Procurement (01900).
    
    Orchestrates the 6-agent procurement workflow with:
    - Pre/post governance validation
    - Full MessagingMixin observability
    - Human review gates at critical stages
    - Audit trail for compliance
    """

    VERSION = "1.0.0"
    DISCIPLINE = "Procurement"
    PREFIX = "01900"

    def __init__(self, agent_config: Optional[Dict[str, Any]] = None):
        self.config = agent_config or self._default_config()
        self.agent_id = "01900_procurement_hitl_coordinator"
        self.agent_name = "Procurement HITL Coordinator"
        
        # Initialize MessagingMixin
        self.init_messaging(organization_id=self.config.get("organization_id"))
        
        # Lazy-loaded sub-agents
        self._agents: Dict[str, Any] = {}
        
        logger.info(f"🤖 {self.agent_name} v{self.VERSION} initialized")

    def _default_config(self) -> Dict[str, Any]:
        return {
            "timeout": 60000,
            "max_retries": 2,
            "hitl_enabled": True,
            "hitl_review_threshold": 0.70,
            "high_value_threshold": 500000,
            "governance": {"jurisdiction": "FI", "strict_mode": True},
        }

    def _load_agents(self) -> None:
        """Lazy-load sub-agents."""
        if self._agents:
            return
        
        # Import and instantiate agents
        from .main_agents.01900_template_analysis_agent import ProcurementTemplateAnalysisAgent
        from .main_agents.01900_requirement_extraction_agent import ProcurementRequirementExtractionAgent
        # ... other imports
        
        self._agents = {
            "template_analysis": ProcurementTemplateAnalysisAgent(self.config),
            "requirements_extraction": ProcurementRequirementExtractionAgent(self.config),
            # ... other agents
        }

    @with_governance(jurisdiction='FI', strict_mode=True)
    async def coordinate(self, input_data: Dict[str, Any]) -> Dict[str, Any]:
        """Coordinate the full 6-agent procurement workflow."""
        session_id = input_data.get("session_id") or str(uuid.uuid4())
        start_time = datetime.now()
        
        # Save opening checkpoint
        await self._save_checkpoint(session_id, "coordination_started", {
            "session_id": session_id,
            "timestamp": start_time.isoformat(),
        })
        
        try:
            self._load_agents()
            
            # Execute stages...
            # (See full implementation in HITL Coordinator Pattern section)
            
            return result
            
        except Exception as e:
            # Handle error
            return {"status": "error", "error": str(e)}

    async def _save_checkpoint(self, session_id, stage, data):
        """Save workflow checkpoint."""
        self.messaging_checkpoint(
            workflow_id=session_id,
            current_step=stage,
            completed_steps=[],  # Calculate based on stage
            pending_steps=[],    # Calculate based on stage
            partial_results=data
        )

    async def on_message(self, message: Dict[str, Any]) -> Optional[Dict[str, Any]]:
        """Handle incoming messages from other agents."""
        # See Message Handler Implementation section
        pass
```

---

## Verification Checklist

### Pre-Integration

- [ ] Agent file created in correct directory
- [ ] MessagingMixin imported
- [ ] `init_messaging()` called in `__init__`
- [ ] `@with_governance` decorator on process method
- [ ] Agent identity defined (agent_id, agent_name, version)

### During Integration

- [ ] `messaging_heartbeat()` called at start
- [ ] `messaging_checkpoint()` called at each major step
- [ ] `messaging_send()` used for notifications
- [ ] `messaging_record_metrics()` called on completion
- [ ] `messaging_clear_checkpoint()` called on success
- [ ] Error handling with `messaging_escalate()`

### Post-Integration

- [ ] Agent registered in `register_agents.py`
- [ ] Agent added to HITL Coordinator `_load_agents()`
- [ ] Agent called in correct sequence in `coordinate()`
- [ ] Unit tests created
- [ ] Integration tests created
- [ ] All tests pass

### Production Readiness

- [ ] Governance compliance verified
- [ ] Checkpoint/resume tested
- [ ] Message handling tested
- [ ] Error recovery tested
- [ ] Performance acceptable

---

## Troubleshooting

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| `MessagingMixin` methods not available | `init_messaging()` not called | Add call in `__init__` |
| Governance not enforced | `@with_governance` missing | Add decorator to `process()` |
| Checkpoint not saving | Wrong workflow_id | Use consistent session_id |
| Agent not called in workflow | Not added to coordinator | Add to `_load_agents()` and `coordinate()` |
| Tests failing | Missing dependencies | Check import paths |

### Debug Commands

```bash
# Test MessagingMixin
python -c "from deep_agents.messaging.mixin import MessagingMixin; print('OK')"

# Test governance
python -c "from deep_agents.agents.shared.governance import with_governance; print('OK')"

# Run tests
pytest tests/integration/test_procurement_workflow.py -v
```

---

## Related Procedures

| Procedure | Relationship |
|-----------|--------------|
| [`0000_AGENT_WIRING_METHODOLOGY_PROCEDURE.md`](0000_AGENT_WIRING_METHODOLOGY_PROCEDURE.md) | Infrastructure wiring details |
| [`0000_WORKFLOW_CHECKPOINTER_IMPLEMENTATION_PROCEDURE.md`](0000_WORKFLOW_CHECKPOINTER_IMPLEMENTATION_PROCEDURE.md) | Checkpointing implementation |
| [`0000_PROCEDURES_GUIDE.md`](../0000_PROCEDURES_GUIDE.md) | Procedures overview |

---

## Document Information

- **Document ID**: `0000_AGENT_WORKFLOW_INTEGRATION_PROCEDURE`
- **Version**: 1.0.0
- **Created**: 2026-02-23
- **Last Updated**: 2026-02-23
- **Author**: Construct AI Development Team
- **Review Cycle**: Quarterly
- **Status**: ✅ ACTIVE

---

**Navigation**: This procedure is part of the Implementation Procedures cluster. Use this for full agent integration into workflows.