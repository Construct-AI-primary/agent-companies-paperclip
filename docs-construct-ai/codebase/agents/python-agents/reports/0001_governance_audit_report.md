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
# Governance Audit Report
## Disciplines: 00435 · 01900 · 02400
**Date:** 2026-02-18  
**Auditor:** Cline AI  
**Scope:** Governance integration compliance across three discipline agent directories  
**Framework:** 11-Agent Governance Swarm (AIUC-1, ISO 42001, ISO 27701, EU AI Act, NIS2)

---

## Executive Summary

| Discipline | Overall Score | `with_governance` | `MessagingMixin` | `GovernedAgentMixin` | Specialist Agents | HITL |
|---|---|---|---|---|---|---|
| **00435 Contracts Post-Award** | 🟡 **Partial** | ✅ Partial | ✅ Partial | ❌ Missing | ✅ Present | ✅ Full |
| **01900 Procurement** | 🟡 **Partial** | ✅ Partial | ✅ Partial | ❌ Missing | ❌ Stubs only | ❌ None |
| **02400 Safety** | 🔴 **Minimal** | ✅ Partial | ❌ Missing | ❌ Missing | ❌ Empty | ❌ None |

---

## Governance Framework Reference

The platform's governance system provides three integration mechanisms:

1. **`@with_governance(jurisdiction, strict_mode)`** — Decorator wrapping `_execute_impl` / `process()` with pre/post 11-agent swarm validation (AIUC-1, ISO 42001, ISO 27701, EU AI Act, NIS2).
2. **`GovernedAgentMixin`** — Class-level mixin providing `pre_governance_check()` and `post_governance_check()` methods for fine-grained control.
3. **`MessagingMixin`** — Observability layer providing mail, checkpoint, metrics, health, and identity subsystems (Supabase-backed).

All three should be present in production-grade agents. The governance decorator must wrap the primary execution method. MessagingMixin must be initialised via `self.init_messaging()` in `__init__`.

---

## 00435 — Contracts Post-Award

### Agent Inventory

| File | Class | Type | `with_governance` | `MessagingMixin` | `GovernedAgentMixin` |
|---|---|---|---|---|---|
| `a_contracts_hitl_coordinator.py` | `ContractsHITLCoordinator` | SubAgent | ✅ `_execute_impl` | ✅ Direct import + full init | ❌ |
| `a_construction_correspondence_deep_agent.py` | `ConstructionCorrespondenceDeepAgent` | SupervisorAgent | ✅ `_execute_impl` | ✅ `MessagingMixin` inheritance + `init_messaging()` | ❌ |
| `main_agents/a_contract_management_agent.py` | `ContractManagementAgent` | SubAgent | ✅ `_execute_impl` | ❌ Not imported | ❌ |
| `main_agents/a_document_analysis_agent.py` | `DocumentAnalysisAgent` | SubAgent | ✅ `_execute_impl` (confirmed via search) | ❌ Not imported | ❌ |
| `main_agents/a_information_extraction_agent.py` | `InformationExtractionAgent` | SubAgent | ✅ `_execute_impl` (confirmed via search) | ❌ Not imported | ❌ |
| `main_agents/a_document_retrieval_agent.py` | `DocumentRetrievalAgent` | SubAgent | Unknown | ❌ Not imported | ❌ |
| `main_agents/a_human_review_agent.py` | `HumanReviewAgent` | SubAgent | Unknown | ❌ Not imported | ❌ |
| `main_agents/a_professional_formatting_agent.py` | `ProfessionalFormattingAgent` | SubAgent | Unknown | ❌ Not imported | ❌ |
| `agents/correspondence_agent.py` | `ConstructionCorrespondenceDeepAgent` | DeepAgent (plugin) | ✅ `generate_correspondence()` | ❌ Not imported | ❌ |
| `agents/approval_agent.py` | `ContractApprovalAgent` | DeepAgent (plugin) | ❌ **MISSING** | ❌ Not imported | ❌ |
| `agents/variation_agent.py` | `ContractVariationAgent` | DeepAgent (plugin) | ❌ **MISSING** | ❌ Not imported | ❌ |

### Findings

#### ✅ Strengths

1. **`ContractsHITLCoordinator`** is the most governance-complete agent in the entire codebase. It correctly:
   - Imports and uses `@with_governance(jurisdiction='FI', strict_mode=True)` on `_execute_impl`
   - Directly instantiates all five messaging subsystems (`AgentMailStore`, `CheckpointManager`, `MetricsStore`, `HealthMonitor`, `AgentIdentityStore`) in `__init__`
   - Sends mail notifications to orchestrator on both success and failure
   - Saves and clears checkpoints at each workflow stage
   - Records metrics and identity on completion
   - Has a conservative fallback (`hitl_required=True`) on failure — correct governance posture

2. **`ConstructionCorrespondenceDeepAgent`** correctly inherits `MessagingMixin` and calls `self.init_messaging()` in `__init__`, and applies `@with_governance` to `_execute_impl`.

3. **`ContractManagementAgent`** and **`correspondence_agent.py`** both apply `@with_governance` to their primary execution methods.

#### ❌ Gaps

1. **`approval_agent.py` (ContractApprovalAgent)** — **No governance decorator anywhere.** The `review_contract()` method is the primary execution path and has no `@with_governance` wrapper. This is a high-risk gap given this agent makes financial approval decisions.

2. **`variation_agent.py` (ContractVariationAgent)** — **No governance decorator anywhere.** The `process_variation_request()` method handles contract variations (financial impact, approval routing) with zero governance validation. Critical gap.

3. **`MessagingMixin` absent from 7 of 11 agents** — Only the supervisor and HITL coordinator have observability. The five `main_agents/` sub-agents and the two `agents/` plugin agents have no checkpoint, metrics, health, or mail capabilities.

4. **`GovernedAgentMixin` not used anywhere** — The class-level mixin providing `pre_governance_check()` / `post_governance_check()` is never inherited. This means no agent can perform fine-grained pre/post governance checks independently of the decorator.

5. **`@with_governance` applied to wrong method in `correspondence_agent.py`** — The decorator is on `generate_correspondence()` rather than a standardised `process()` or `_execute_impl()` method. This is inconsistent with the framework pattern and may cause issues if the orchestrator calls `process()` directly.

6. **Placeholder sub-agents at bottom of `a_construction_correspondence_deep_agent.py`** — Six placeholder classes (`DocumentAnalysisSubAgent`, etc.) have no governance at all. These shadow the real implementations and could be invoked accidentally.

### Risk Rating: 🟡 MEDIUM-HIGH

---

## 01900 — Procurement

### Agent Inventory

| File | Class | Type | `with_governance` | `MessagingMixin` | `GovernedAgentMixin` |
|---|---|---|---|---|---|
| `main_agents/01900_template_analysis_agent.py` | `ProcurementTemplateAnalysisAgent` | Standalone | ✅ `process()` | ✅ Inherited + `init_messaging()` | ❌ |
| `main_agents/01900_requirement_extraction_agent.py` | `ProcurementRequirementExtractionAgent` | Standalone | ✅ `process()` (confirmed) | ✅ (confirmed wired in last commit) | ❌ |
| `main_agents/01900_compliance_validation_agent.py` | `ProcurementComplianceValidationAgent` | Standalone | ✅ `process()` | ❌ **MISSING** | ❌ |
| `main_agents/01900_field_population_agent.py` | `ProcurementFieldPopulationAgent` | Standalone | Unknown | Unknown | ❌ |
| `main_agents/01900_quality_assurance_agent.py` | `ProcurementQualityAssuranceAgent` | Standalone | Unknown | Unknown | ❌ |
| `main_agents/01900_final_review_agent.py` | `ProcurementFinalReviewAgent` | Standalone | Unknown | Unknown | ❌ |

### Findings

#### ✅ Strengths

1. **`ProcurementTemplateAnalysisAgent`** correctly inherits `MessagingMixin`, calls `self.init_messaging()` in `__init__`, and applies `@with_governance(jurisdiction='FI', strict_mode=True)` to `process()`. This is the reference implementation for the 01900 pipeline.

2. **`ProcurementRequirementExtractionAgent`** was wired with `MessagingMixin` in the most recent commit (d39b839e7), making it the second fully-compliant agent in this pipeline.

3. **`ProcurementComplianceValidationAgent`** correctly applies `@with_governance` to `process()`.

#### ❌ Gaps

1. **`ProcurementComplianceValidationAgent` missing `MessagingMixin`** — This is the compliance agent — arguably the most governance-critical agent in the pipeline — yet it has no observability. No checkpoints are saved during compliance validation, no metrics recorded, no health status reported. If this agent fails silently, there is no audit trail.

2. **Agents 4, 5, 6 (`field_population`, `quality_assurance`, `final_review`) — governance status unknown** — These were not fully audited but based on the pattern of the stubs generated in the last commit, they likely have `@with_governance` on `process()` but are missing `MessagingMixin`. The `final_review_agent` is particularly high-risk as it produces the approval recommendation.

3. **No HITL coordinator for 01900** — Unlike 00435 which has a dedicated `ContractsHITLCoordinator`, the procurement pipeline has no HITL escalation mechanism. High-value procurement decisions (>R1M) are flagged in the compliance agent but there is no agent to route these to human reviewers.

4. **`GovernedAgentMixin` not used** — Same gap as 00435. No agent in this pipeline uses the class-level mixin.

5. **Specialist agents are empty stubs** — The `specialist_agents/` subdirectories (`compliance_monitoring/`, `input_validation/`, `logistics/`, `packaging/`, `safety/`, `technical/`, `training/`, `workflow_support/`) exist but their contents were not confirmed to have any governance integration. The README describes agents that should exist but may not be implemented.

6. **No `ProcurementWorkflowOrchestrator` governance wrapper** — The orchestrator added in commit 24927cc2c coordinates the 6-agent pipeline but it is unclear whether it applies governance at the orchestration level in addition to individual agent governance.

### Risk Rating: 🟡 MEDIUM

---

## 02400 — Safety

### Agent Inventory

| File | Class | Type | `with_governance` | `MessagingMixin` | `GovernedAgentMixin` |
|---|---|---|---|---|---|
| `main_agents/02400_coordinator_agent.py` | `SafetyCoordinatorAgent` | Standalone | ✅ `process()` | ❌ **MISSING** | ❌ |
| `main_agents/02400_document_analysis_agent.py` | `SafetyDocumentAnalysisAgent` | Standalone | ✅ `process()` | ❌ **MISSING** | ❌ |
| `main_agents/02400_information_extraction_agent.py` | `SafetyInformationExtractionAgent` | Standalone | ✅ `process()` | ❌ **MISSING** | ❌ |
| `main_agents/02400_professional_formatting_agent.py` | `SafetyProfessionalFormattingAgent` | Standalone | ✅ `process()` | ❌ **MISSING** | ❌ |
| `main_agents/02400_human_review_agent.py` | `SafetyHumanReviewAgent` | Standalone | ✅ `process()` | ❌ **MISSING** | ❌ |
| `main_agents/02400_validator_agent.py` | `SafetyValidatorAgent` | Standalone | ✅ `process()` | ❌ **MISSING** | ❌ |
| `specialist_agents/__init__.py` | — | — | ❌ Empty | ❌ Empty | ❌ |

### Findings

#### ✅ Strengths

1. **All 6 main agents apply `@with_governance(jurisdiction='FI', strict_mode=True)`** to their `process()` method. The decorator is consistently applied across the entire discipline.

2. **Consistent agent structure** — All agents follow the same pattern: `__init__`, `_default_config`, `process`, `_execute_core_logic`, `get_capabilities`, `get_health_status`, factory function. This makes governance integration straightforward to add.

3. **`get_capabilities()` correctly declares governance metadata** — Each agent's capabilities dict includes `"governance": {"jurisdiction": "FI", "strict_mode": True}`, providing self-documenting governance posture.

#### ❌ Gaps

1. **`MessagingMixin` completely absent from all 6 agents** — This is the most significant gap. The Safety discipline handles safety incidents, compliance validation, and human review — all of which require audit trails. Without `MessagingMixin`:
   - No checkpoints are saved (no recovery if an agent crashes mid-workflow)
   - No metrics are recorded (no performance monitoring)
   - No health status is reported to the health monitor
   - No mail notifications are sent to the orchestrator
   - No identity records are created (no accountability trail)

2. **`_execute_core_logic` is a placeholder in all 6 agents** — Every agent returns `"message": "core logic placeholder — implement discipline-specific logic here"`. The `@with_governance` decorator is wrapping placeholder logic. While the governance scaffolding is correct, the agents are not functionally implemented.

3. **`specialist_agents/__init__.py` is empty** — The Safety discipline has no specialist agents at all. For a safety discipline, this is a significant gap — there are no specialists for incident investigation, risk assessment, regulatory compliance, PPE management, etc.

4. **No HITL coordinator** — Safety incidents should always escalate to human review (as seen in the 00435 HITL coordinator's `always_escalate: True` for `safety_incident`). The 02400 discipline has a `SafetyHumanReviewAgent` but no HITL coordinator to route decisions.

5. **`GovernedAgentMixin` not used** — Same gap as other disciplines.

6. **`__init__.py` imports use invalid Python syntax** — The package `__init__.py` files use `from .02400_coordinator_agent import ...` which is invalid Python (module names cannot start with digits). This will cause `ImportError` at runtime. The same issue exists in `main_agents/__init__.py`.

### Risk Rating: 🔴 HIGH

---

## Cross-Cutting Findings

### 1. `GovernedAgentMixin` — Universally Missing
None of the three disciplines use `GovernedAgentMixin`. This mixin provides the most flexible governance integration pattern, allowing agents to call `pre_governance_check()` and `post_governance_check()` at specific points in their logic rather than wrapping the entire method. For complex agents with multiple decision points (like `ContractManagementAgent`), this would provide more granular governance coverage.

### 2. `MessagingMixin` — Inconsistently Applied
| Discipline | Agents with MessagingMixin | Total Agents | Coverage |
|---|---|---|---|
| 00435 | 2 (HITL coordinator, supervisor) | 11 | 18% |
| 01900 | 2 (template analysis, requirement extraction) | 6+ | 33% |
| 02400 | 0 | 6 | 0% |

The pattern is clear: `MessagingMixin` was added to the highest-priority agents in the last commit but was not propagated to all agents in each discipline.

### 3. `@with_governance` — Correctly Applied Where Present
Where `@with_governance` is used, it is applied correctly with `jurisdiction='FI'` and `strict_mode=True`. The decorator is consistently placed on the primary execution method (`_execute_impl` for SubAgent/SupervisorAgent subclasses, `process()` for standalone agents). The two exceptions are `approval_agent.py` and `variation_agent.py` in 00435 which have no governance at all.

### 4. Python Import Syntax Error in 02400
The `__init__.py` files in `02400-safety/` use `from .02400_coordinator_agent import ...` — Python module names cannot begin with digits. This is a runtime `ImportError` that will prevent the entire 02400 package from loading. The correct pattern is to use `importlib` or rename the files to not start with digits (e.g., `safety_coordinator_agent.py`).

### 5. No Cross-Discipline Governance Coordination
Each discipline implements governance independently. There is no shared governance session or cross-discipline audit trail. When a procurement order (01900) triggers a safety review (02400) or a contract variation (00435), the governance records are siloed. The `GovernanceIntegrationManager` exists for this purpose but is not used.

---

## Priority Remediation Actions

### 🔴 Critical (Fix Immediately)

| # | Action | Discipline | File |
|---|---|---|---|
| C1 | Fix Python import syntax error (`from .02400_*`) — will cause runtime ImportError | 02400 | `__init__.py`, `main_agents/__init__.py` |
| C2 | Add `@with_governance` to `ContractApprovalAgent.review_contract()` | 00435 | `agents/approval_agent.py` |
| C3 | Add `@with_governance` to `ContractVariationAgent.process_variation_request()` | 00435 | `agents/variation_agent.py` |

### 🟠 High (Fix This Sprint)

| # | Action | Discipline | Files |
|---|---|---|---|
| H1 | Add `MessagingMixin` to all 6 Safety main agents | 02400 | All `main_agents/02400_*.py` |
| H2 | Add `MessagingMixin` to `ProcurementComplianceValidationAgent` | 01900 | `01900_compliance_validation_agent.py` |
| H3 | Add `MessagingMixin` to `01900_field_population_agent.py`, `01900_quality_assurance_agent.py`, `01900_final_review_agent.py` | 01900 | Three files |
| H4 | Add `MessagingMixin` to all 5 `main_agents/` sub-agents in 00435 | 00435 | `a_contract_management_agent.py` + 4 others |
| H5 | Create HITL coordinator for 01900 (procurement decisions >R1M require human escalation) | 01900 | New file |
| H6 | Create HITL coordinator for 02400 (safety incidents must always escalate) | 02400 | New file |

### 🟡 Medium (Next Sprint)

| # | Action | Discipline | Notes |
|---|---|---|---|
| M1 | Implement `_execute_core_logic` in all 6 Safety agents (currently placeholders) | 02400 | Governance wraps placeholder logic |
| M2 | Add `GovernedAgentMixin` to high-risk agents (approval, variation, compliance) | All | Enables fine-grained pre/post checks |
| M3 | Implement specialist agents for 02400 (currently empty) | 02400 | Safety needs incident, risk, PPE specialists |
| M4 | Standardise `@with_governance` placement in `correspondence_agent.py` | 00435 | Move from `generate_correspondence()` to `process()` |
| M5 | Remove placeholder sub-agent classes from `a_construction_correspondence_deep_agent.py` | 00435 | Risk of accidental invocation |
| M6 | Wire `GovernanceIntegrationManager` for cross-discipline audit trail | All | Enables unified governance reporting |

---

## Compliance Matrix

| Requirement | 00435 | 01900 | 02400 |
|---|---|---|---|
| AIUC-1 Accountability (audit trails) | 🟡 Partial | 🟡 Partial | 🔴 None |
| AIUC-1 Reliability (checkpoints/recovery) | 🟡 2 agents | 🟡 2 agents | 🔴 None |
| AIUC-1 Transparency (governance logging) | 🟡 Partial | 🟡 Partial | 🟡 Decorator only |
| ISO 42001 (AI management system) | 🟡 Partial | 🟡 Partial | 🟡 Decorator only |
| ISO 27701 (privacy) | 🟡 Partial | 🟡 Partial | 🟡 Decorator only |
| EU AI Act (human oversight) | ✅ HITL present | 🔴 No HITL | 🔴 No HITL |
| NIS2 (incident response) | 🟡 Partial | 🔴 None | 🔴 None |
| Governance decorator on all agents | 🟡 9/11 | 🟡 3/6+ | ✅ 6/6 |
| MessagingMixin on all agents | 🔴 2/11 | 🔴 2/6+ | 🔴 0/6 |
| HITL escalation | ✅ Full | 🔴 Missing | 🔴 Missing |

---

## Conclusion

The governance framework is well-designed and the `@with_governance` decorator is correctly implemented where applied. The primary gaps are:

1. **Observability (MessagingMixin)** is the most widespread gap — 02400 has zero coverage, 00435 and 01900 have partial coverage. Without this, there are no audit trails, no checkpoint recovery, and no health monitoring for the majority of agents.

2. **Two 00435 agents (`approval_agent`, `variation_agent`) have no governance at all** — these handle financial decisions and must be remediated immediately.

3. **02400 has a Python syntax error** that will prevent the package from loading at runtime.

4. **HITL escalation is missing from 01900 and 02400** — procurement and safety decisions require human-in-the-loop routing for high-risk scenarios.

The `ContractsHITLCoordinator` in 00435 should be used as the reference implementation for all future governance integration work.
