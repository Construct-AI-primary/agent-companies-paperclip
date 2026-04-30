---
memory_layer: durable_knowledge
para_section: pages/codebase/agents
gigabrain_tags: agents, codebase, ai-automation
documentation
openstinger_context: agent-development, ai-systems
last_updated: 2026-03-21
related_docs:
  - codebase/agents/
  - disciplines/
---
# 16 - Agent Inventory

## Overview

This document provides a comprehensive inventory of all agents used in the 01900 Procurement workflow. Agents are organized by category: Main Agents, Specialist Agents, and Support Agents.

## Agent Architecture

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                        PROCUREMENT AGENT ECOSYSTEM                               │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                        MAIN AGENTS (6)                                    │   │
│  │  Sequential Processing Pipeline - Core Document Generation                │   │
│  │  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐│   │
│  │  │Template │ │Require- │ │Compliance│ │  Field  │ │ Quality │ │  Final  ││   │
│  │  │Analysis │→│  ment   │→│Validation│→│Populate │→│Assurance│→│ Review  ││   │
│  │  │         │ │Extract  │ │         │ │         │ │         │ │         ││   │
│  │  └─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘│   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                      │                                          │
│                                      ▼                                          │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                     SPECIALIST AGENTS (14)                                │   │
│  │  Domain-Specific Expertise - Technical & Compliance Support               │   │
│  │  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐    │   │
│  │  │  Technical   │ │   Safety     │ │  Logistics   │ │  Packaging   │    │   │
│  │  │  (6 agents)  │ │  (1 agent)   │ │  (2 agents)  │ │  (1 agent)   │    │   │
│  │  └──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘    │   │
│  │  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐    │   │
│  │  │  Training    │ │   Input      │ │  Workflow    │ │ Compliance   │    │   │
│  │  │  (1 agent)   │ │Validation(2) │ │ Support (2)  │ │ Monitor (1)  │    │   │
│  │  └──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘    │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                      │                                          │
│                                      ▼                                          │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                     COORDINATION & SUPPORT                                │   │
│  │  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐      │   │
│  │  │ HITL Coordinator │  │  Input Agent     │  │ Order Creation   │      │   │
│  │  │    (1 agent)     │  │   (3 agents)     │  │    (1 agent)     │      │   │
│  │  └──────────────────┘  └──────────────────┘  └──────────────────┘      │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## Main Agents (6)

### 1. Template Analysis Agent
**File**: `main_agents/01900_template_analysis_agent.py`
**Stage**: 1 of 6
**Duration**: ~800ms

**Purpose**: First-line assessment and template compatibility validation

**Input**:
- Procurement order data
- Available templates from `sow_templates` table

**Processing**:
- Template compatibility analysis
- Requirement matching
- Risk assessment
- Template recommendations with scoring

**Output**:
- Template Compatibility Report
- Compatibility scores
- Optimization suggestions

**Prompt**: "Analyzing procurement requirements against available templates..."

---

### 2. Requirement Extraction Agent
**File**: `main_agents/01900_requirement_extraction_agent.py`
**Stage**: 2 of 6
**Duration**: ~700ms

**Purpose**: Deep procurement data analysis and structured extraction

**Input**:
- Procurement order
- Template context from Stage 1

**Processing**:
- Extract technical specifications
- Extract quality requirements
- Extract compliance needs
- Extract commercial terms

**Output**:
- Requirements Specification Document
- Structured requirements with confidence scores
- Completeness metrics

**Prompt**: "Extracting structured requirements from procurement specifications..."

---

### 3. Compliance Validation Agent
**File**: `main_agents/01900_compliance_validation_agent.py`
**Stage**: 3 of 6
**Duration**: ~900ms

**Purpose**: Regulatory and organizational compliance enforcement

**Input**:
- Extracted requirements
- Compliance frameworks (PPPA, ISO, CIDB)

**Processing**:
- PPPA compliance checking
- Regulatory standards validation
- Approval matrix checking
- Country-specific compliance (CDC for Guinea)

**Output**:
- Compliance Validation Report
- Violations list
- Recommendations
- Required approvals

**Prompt**: "Validating requirements against PPPA, ISO, and CIDB standards..."

**HITL Gate 1**: Blocks when violations detected OR order value ≥ ZAR 500,000

---

### 4. Field Population Agent
**File**: `main_agents/01900_field_population_agent.py`
**Stage**: 4 of 6
**Duration**: ~800ms

**Purpose**: Intelligent template field completion

**Input**:
- Template structure from `sow_templates`
- Extracted data
- Procurement details

**Processing**:
- Map data to template fields
- Validate field completion
- Ensure data consistency
- Apply governance field attributes

**Output**:
- Populated Procurement Order
- Field validation metrics
- Completeness percentage

**Prompt**: "Mapping extracted data to procurement template fields..."

---

### 5. Quality Assurance Agent
**File**: `main_agents/01900_quality_assurance_agent.py`
**Stage**: 5 of 6
**Duration**: ~600ms

**Purpose**: Comprehensive document validation and quality control

**Input**:
- Populated document
- Procurement data
- Compliance report

**Processing**:
- Completeness checks
- Accuracy validation
- Consistency verification
- Compliance alignment

**Output**:
- Quality Assessment Report
- Issues list
- Recommendations
- Approval readiness score

**Prompt**: "Validating document completeness and accuracy..."

---

### 6. Final Review Agent
**File**: `main_agents/01900_final_review_agent.py`
**Stage**: 6 of 6
**Duration**: ~850ms

**Purpose**: Executive-level assessment and final approval recommendation

**Input**:
- Quality assessment
- Populated document
- Procurement context

**Processing**:
- Strategic alignment review
- Risk evaluation
- Organizational impact assessment
- Governance compliance verification
- Appendix generation (A-F)

**Output**:
- Final approval recommendation
- Complete Procurement Order Package
- All 6 appendices generated
- Next steps and contingency planning

**Prompt**: "Assembling final procurement documents with appendices..."

**HITL Gate 2**: Blocks when recommendation is not "approved"

---

## Specialist Agents (14)

### Technical Specialists (6)

#### 7. Chemical Engineering Specialist
**File**: `specialist_agents/technical/01900_chemical_engineering_specialist_agent.py`
**Purpose**: Chemical and process engineering requirements validation

#### 8. Civil Engineering Specialist
**File**: `specialist_agents/technical/01900_civil_engineering_specialist_agent.py`
**Purpose**: Civil engineering and construction requirements

#### 9. Electrical Engineering Specialist
**File**: `specialist_agents/technical/01900_electrical_engineering_specialist_agent.py`
**Purpose**: Electrical systems and equipment specifications

#### 10. Mechanical Engineering Specialist
**File**: `specialist_agents/technical/01900_mechanical_engineering_specialist_agent.py`
**Purpose**: Mechanical equipment and machinery specifications

#### 11. Process Engineering Specialist
**File**: `specialist_agents/technical/01900_process_engineering_specialist_agent.py`
**Purpose**: Process engineering and industrial requirements

#### 12. Technical Routing Specialist
**File**: `specialist_agents/technical/01900_technical_routing_specialist_agent.py`
**Purpose**: Routes requests to appropriate technical specialists

---

### Safety Specialist (1)

#### 13. Safety Specialist Agent
**File**: `specialist_agents/safety/01900_safety_specialist_agent.py`
**Purpose**: Safety requirements, SDS validation, hazard compliance

**Responsibilities**:
- SDS requirements identification
- GHS compliance validation
- Hazard classification
- Safety documentation requirements

---

### Logistics Specialists (2)

#### 14. Logistics Specialist Agent
**File**: `specialist_agents/logistics/01900_logistics_specialist_agent.py`
**Purpose**: Logistics planning and coordination

**Responsibilities**:
- Shipping documentation
- Incoterms validation
- Delivery scheduling
- Carrier coordination

#### 15. Supply Chain Specialist Agent
**File**: `specialist_agents/logistics/01900_supply_chain_specialist_agent.py`
**Purpose**: Supply chain optimization and vendor management

---

### Packaging Specialist (1)

#### 16. Packaging Specialist Agent
**File**: `specialist_agents/packaging/01900_packaging_specialist_agent.py`
**Purpose**: Packaging specifications and standards compliance

**Responsibilities**:
- ISPM 15 compliance
- Packaging requirements
- Marking specifications
- Hazardous materials packaging

---

### Training Specialist (1)

#### 17. Training Specialist Agent
**File**: `specialist_agents/training/01900_training_specialist_agent.py`
**Purpose**: Training requirements and materials generation

**Responsibilities**:
- Training needs assessment
- Training schedule creation
- Materials preparation
- Competency documentation

---

### Input Validation Specialists (2)

#### 18. Data Quality Validator
**File**: `specialist_agents/input_validation/data_quality_validator.py`
**Purpose**: Validates extracted procurement data for completeness and accuracy

**Integration**: ProcurementInputAgentModal - Preview State

#### 19. Smart Suggestion Agent
**File**: `specialist_agents/input_validation/smart_suggestion_agent.py`
**Purpose**: Provides AI-powered suggestions for procurement type, suppliers, workflow

**Integration**: ProcurementInputAgentModal - Chat & Preview States

---

### Workflow Support Specialists (2)

#### 20. Session Recovery Agent
**File**: `specialist_agents/workflow_support/session_recovery_agent.py`
**Purpose**: Auto-saves session state and provides recovery on timeouts

**Integration**: ProcurementInputAgentModal - All States

#### 21. Performance Monitor Agent
**File**: `specialist_agents/workflow_support/performance_monitor_agent.py`
**Purpose**: Tracks API response times and identifies workflow bottlenecks

**Integration**: ProcurementInputAgentModal - Background

---

### Compliance Monitoring Specialist (1)

#### 22. Compliance Checker Agent
**File**: `specialist_agents/compliance_monitoring/compliance_checker_agent.py`
**Purpose**: Validates procurement against approval policies and regulatory requirements

**Integration**: ProcurementInputAgentModal - Preview & Handoff States

---

## Coordination & Support Agents (5)

### 23. HITL Coordinator
**File**: `01900_procurement_hitl_coordinator.py`
**Purpose**: Coordinates Human-in-the-Loop gates

**Gates**:
- **Gate 1** (After Stage 3): Compliance review
- **Gate 2** (After Stage 6): Final approval

**Blocking Conditions**:
- Gate 1: Violations detected OR order value ≥ ZAR 500,000
- Gate 2: Recommendation is not "approved"

---

### 24. Procurement Input Agent
**File**: `input-agent/agents/ProcurementInputAgent.js`
**Purpose**: Main conversational agent for procurement data collection

**Responsibilities**:
- Conversational data extraction
- User guidance through workflow
- Data validation during input

---

### 25. Prompt-Driven Procurement Input Agent
**File**: `input-agent/agents/PromptDrivenProcurementInputAgent.js`
**Purpose**: Prompt-based procurement input processing

---

### 26. Order Creation Agent
**File**: `input-agent/agents/OrderCreationAgent.js`
**Purpose**: Creates procurement orders in database

**Responsibilities**:
- Order record creation
- Order number generation
- Database persistence

---

### 27. Order Intelligence Agent
**File**: `main_agents/01900_order_intelligence_agent.py`
**Purpose**: Order analysis and intelligence extraction

---

### 28. Template Recommendation Agent
**File**: `main_agents/01900_template_recommendation_agent.py`
**Purpose**: Template matching and recommendations

---

### 29. Localization Agent
**File**: `main_agents/01900_localization_agent.py`
**Purpose**: Language and regional adaptation

---

### 30. Audit Trail Agent
**File**: `main_agents/01900_audit_trail_agent.py`
**Purpose**: Comprehensive audit logging

---

### 31. Approval Routing Agent
**File**: `main_agents/01900_approval_routing_agent.py`
**Purpose**: Routes orders through approval workflow

---

### 32. Document Assembly Agent
**File**: `main_agents/01900_document_assembly_agent.py`
**Purpose**: Final document compilation and assembly

---

## Agent Summary Table

| # | Agent Name | Category | File | Stage |
|---|------------|----------|------|-------|
| 1 | Template Analysis | Main | `01900_template_analysis_agent.py` | 1 |
| 2 | Requirement Extraction | Main | `01900_requirement_extraction_agent.py` | 2 |
| 3 | Compliance Validation | Main | `01900_compliance_validation_agent.py` | 3 |
| 4 | Field Population | Main | `01900_field_population_agent.py` | 4 |
| 5 | Quality Assurance | Main | `01900_quality_assurance_agent.py` | 5 |
| 6 | Final Review | Main | `01900_final_review_agent.py` | 6 |
| 7 | Chemical Engineering | Technical | `01900_chemical_engineering_specialist_agent.py` | - |
| 8 | Civil Engineering | Technical | `01900_civil_engineering_specialist_agent.py` | - |
| 9 | Electrical Engineering | Technical | `01900_electrical_engineering_specialist_agent.py` | - |
| 10 | Mechanical Engineering | Technical | `01900_mechanical_engineering_specialist_agent.py` | - |
| 11 | Process Engineering | Technical | `01900_process_engineering_specialist_agent.py` | - |
| 12 | Technical Routing | Technical | `01900_technical_routing_specialist_agent.py` | - |
| 13 | Safety Specialist | Safety | `01900_safety_specialist_agent.py` | - |
| 14 | Logistics Specialist | Logistics | `01900_logistics_specialist_agent.py` | - |
| 15 | Supply Chain Specialist | Logistics | `01900_supply_chain_specialist_agent.py` | - |
| 16 | Packaging Specialist | Packaging | `01900_packaging_specialist_agent.py` | - |
| 17 | Training Specialist | Training | `01900_training_specialist_agent.py` | - |
| 18 | Data Quality Validator | Input Validation | `data_quality_validator.py` | - |
| 19 | Smart Suggestion | Input Validation | `smart_suggestion_agent.py` | - |
| 20 | Session Recovery | Workflow Support | `session_recovery_agent.py` | - |
| 21 | Performance Monitor | Workflow Support | `performance_monitor_agent.py` | - |
| 22 | Compliance Checker | Compliance | `compliance_checker_agent.py` | - |
| 23 | HITL Coordinator | Coordination | `01900_procurement_hitl_coordinator.py` | - |
| 24 | Procurement Input | Input | `ProcurementInputAgent.js` | - |
| 25 | Prompt-Driven Input | Input | `PromptDrivenProcurementInputAgent.js` | - |
| 26 | Order Creation | Input | `OrderCreationAgent.js` | - |
| 27 | Order Intelligence | Main | `01900_order_intelligence_agent.py` | - |
| 28 | Template Recommendation | Main | `01900_template_recommendation_agent.py` | - |
| 29 | Localization | Main | `01900_localization_agent.py` | - |
| 30 | Audit Trail | Main | `01900_audit_trail_agent.py` | - |
| 31 | Approval Routing | Main | `01900_approval_routing_agent.py` | - |
| 32 | Document Assembly | Main | `01900_document_assembly_agent.py` | - |

---

## Governance Integration

All main agents are protected by the **11-agent governance swarm** enforcing:
- AIUC-1
- ISO 42001
- ISO 27701
- EU AI Act
- NIS2

```python
from deep_agents.agents.shared.governance import with_governance

@with_governance(jurisdiction='FI', strict_mode=True)
async def process(self, input_data):
    ...
```

---

## MessagingMixin Integration

All main agents inherit `MessagingMixin` for Supabase observability:

| Subsystem | Property | Class | Purpose |
|-----------|----------|-------|---------|
| Mail | `_mail` | `AgentMailStore` | Inter-agent messaging |
| Checkpoint | `_checkpoint` | `CheckpointManager` | Workflow state persistence |
| Metrics | `_metrics` | `MetricsStore` | Token/latency tracking |
| Health | `_health` | `HealthMonitor` | Heartbeat & liveness |
| Identity | — | `agent_identity.py` | Agent registration |

---

## Performance Targets

| Agent | Target Duration | Max Duration |
|-------|-----------------|--------------|
| Template Analysis | 800ms | 30s |
| Requirement Extraction | 700ms | 45s |
| Compliance Validation | 900ms | 60s |
| Field Population | 800ms | 90s |
| Quality Assurance | 600ms | 30s |
| Final Review | 850ms | 30s |
| **Total Workflow** | **4.65s** | **5min** |

---

## Related Files

- **Agent Registry**: `/docs/agents/0000_AGENTS_REGISTRY.md`
- **Register Agents**: `register_agents.py`
- **Tests**: `tests/` directory
- **Services**: `input-agent/services/`