---
memory_layer: durable_knowledge
para_section: pages/codebase/procedures/general
gigabrain_tags: governance, ai-governance, eu-ai-act, iso-42001, iso-27701, nis2, aiuc-1, compliance, standards, ai-regulation, multi-jurisdiction, privacy, security, accountability, agent-governance, risk-management, audit-trail, compliance-framework, regulatory-compliance
openstinger_context: ai-governance-framework, compliance-validation, regulatory-standards, multi-jurisdiction-privacy
last_updated: 2026-03-30
related_docs:
  - codebase/procedures/agent-development/
  - codebase/agents/
  - disciplines/
---

# 0000_GOVERNANCE_FRAMEWORK_PROCEDURE.md - AI Governance Framework

## Document Overview

**Purpose**: Comprehensive documentation of the 11-Agent Governance Swarm implementing AIUC-1, ISO 42001, ISO 27701, EU AI Act, and NIS2 compliance frameworks.

**Scope**: All AI agents within the ConstructAI deep-agents system

**Version**: 1.2.0

---

## Governance Framework Coverage

The **11-Agent Governance Swarm** provides comprehensive compliance coverage for major AI governance frameworks:

### 1. ISO 42001 (AI Management Systems)

ISO 42001:2023 is the international standard for AI management systems. The governance swarm implements controls across all Annex A control categories:

| Control Category | ISO 42001 Controls | Implementing Agent |
|-----------------|-------------------|-------------------|
| **A.4** - Context of the organization | A.4.1, A.4.2 | SocietalAgent |
| **A.5** - Leadership | A.5.1 | AccountabilityAgent |
| **A.6** - Planning/Security | A.6.1, A.6.2, A.6.3, A.6.4, A.6.5, A.6.6 | SecurityAgent, IncidentResponseAgent, SupplyChainSecurityAgent |
| **A.7** - Support/Operations | A.7.1, A.7.2, A.7.3 | SafetyAgent, PrivacyAgent, ReliabilityAgent |
| **A.8** - Performance evaluation | A.8.1, A.8.2, A.8.3, A.8.4 | PrivacyAgent, ThirdPartyRiskAgent, SupplyChainSecurityAgent, IncidentResponseAgent |
| **A.9** - Improvement | A.9.1, A.9.2, A.9.3, A.9.4, A.9.5 | EUAIActAgent, AccountabilityAgent, ManagementReviewAgent |

### 2. EU AI Act

The EU AI Act governance agent (`0070_eu_ai_act_agent.py`) provides comprehensive coverage:

| EU AI Act Requirement | Coverage | Articles |
|---------------------|----------|----------|
| **High-risk system classification** | Annex III classification for construction/infrastructure AI | Annex III |
| **Transparency obligations** | AI disclosure requirements | Article 13 |
| **Human oversight** | Human-in-the-loop requirements | Article 14 |
| **Accuracy requirements** | Performance metrics and validation | Article 15 |
| **FRIA** | Fundamental Rights Impact Assessment | Article 27 |
| **Technical documentation** | Annex IV documentation generation | Annex IV |
| **Post-market monitoring** | Continuous monitoring requirements | Article 72 |
| **Risk management** | Risk assessment and mitigation | Article 10 |

### 3. NIS2 Directive

Network and Information Security 2 (NIS2) compliance:

| NIS2 Requirement | Coverage | Articles |
|-----------------|----------|----------|
| **Cybersecurity risk management** | Security controls and assessments | Article 21 |
| **Incident reporting** | 24h/72h/1-month reporting deadlines | Article 23 |
| **Supply chain security** | Third-party risk management | Article 23 |

**Implementing Agents**:
- `0100_incident_response_agent.py` - Incident detection and NIS2 reporting
- `0110_supply_chain_security_agent.py` - Supply chain security compliance

### 4. ISO 27701 (Privacy Information Management)

Privacy information management system extensions:

- **PII protection** controls via `0030_privacy_agent.py`
- **Multi-jurisdiction privacy** (GDPR, POPIA, Guinea DPL, Saudi PDPL)
- **Data subject rights** management
- **Privacy by design** implementation

### 5. AIUC-1 (AI User Charter)

All 51 AIUC-1 safeguards are mapped across the 11 governance agents:

| Principle | Safeguards | Agent |
|-----------|-----------|-------|
| **Security** | 1-8 | SecurityAgent |
| **Privacy** | 9-16 | PrivacyAgent |
| **Safety** | 17-22 | SafetyAgent |
| **Reliability** | 23-28 | ReliabilityAgent |
| **Accountability** | 29-34 | AccountabilityAgent |
| **Societal** | 35-40 | SocietalAgent |
| **Regulatory** | 41-48 | EUAIActAgent |
| **Supply Chain** | 49-51 | SupplyChainSecurityAgent |

---

## 11-Agent Governance Swarm Architecture

### Core 7 Agents (Tier 0)

| Agent | PRINCIPLE | ISO 42001 | EU AI Act | AIUC-1 Safeguards |
|-------|-----------|-----------|-----------|-------------------|
| **SecurityAgent** | security | A.6.1-A.6.4 | Art. 10 | 1-8 |
| **SafetyAgent** | safety | A.7.1, A.8.2 | Art. 10 | 17-22 |
| **PrivacyAgent** | privacy | A.7.2, A.8.1, A.8.2 | Art. 10 | 9-16 |
| **ReliabilityAgent** | reliability | A.7.3 | Art. 15 | 23-28 |
| **AccountabilityAgent** | accountability | A.5.1, A.9.1 | Art. 14 | 29-34 |
| **SocietalAgent** | societal | A.4.1, A.4.2 | Art. 27 | 35-40 |
| **EUAIActAgent** | eu_ai_act | A.9.1-A.9.3 | **Full Coverage** | 41-48 |

### Extended 4 Agents (Tier 1)

| Agent | Purpose | ISO 42001 | EU AI Act | NIS2 |
|-------|---------|-----------|-----------|------|
| **ThirdPartyRiskAgent** | Third-party risk management | A.8.3 | Art. 52 | Art. 23 |
| **ManagementReviewAgent** | Management review processes | A.9.4, A.9.5 | Art. 72 | - |
| **IncidentResponseAgent** | Incident response & reporting | A.6.5, A.8.4 | Art. 72 | Art. 23 |
| **SupplyChainSecurityAgent** | Supply chain security | A.8.3, A.6.6 | Art. 52 | Art. 21 |

---

## Multi-Jurisdiction Privacy Compliance

The governance framework supports privacy compliance across multiple jurisdictions:

### Finland (FI)
- **Tietosuojalaki** (Finnish Data Protection Act)
- **GDPR**
- **YSE 2013** (Construction standards)
- **Henkilötunnus** (SSN) protection
- Trade secret protection (yrityssalaisuus)

### South Africa (ZA)
- **POPIA** (Protection of Personal Information Act)
- **B-BBEE Act**
- **PFMA** (Public Finance Management Act)
- Accountable party requirements
- Data breach notification to Information Regulator

### Sweden (SE)
- **Dataskyddsförordningen**
- **GDPR**
- **Arbetsmiljölagen** (Work Environment Act)
- Employee monitoring notice requirements

### Guinea (GN)
- **Loi sur la Protection des Données Personnelles**
- **Cybercriminalité** legislation
- CNIL notification requirements
- Data sovereignty - local data storage
- Local representative requirements

### Saudi Arabia (SA)
- **PDPL** (Personal Data Protection Law)
- **SDAIA Regulations**
- **Cybersecurity Law**
- SDAIA registration for AI systems
- Data controller registration
- Privacy notice in Arabic
- Data localization requirements

---

## Implementation Architecture

### Base Governance Agent

All governance agents inherit from `0000_base_governance_agent.py`:

```python
class GovernanceAgent(SubAgent):
    """Base class for AIUC-1 aligned governance agents."""
    
    PRINCIPLE: str = ""           # Override in subclass
    SAFEGUARDS: List[int] = []    # AIUC-1 safeguard IDs (1-51)
    ISO42001_CONTROLS: List[str] = []
    EU_AI_ACT_ARTICLES: List[str] = []
```

### Compliance Verdict

Each governance validation returns a `ComplianceVerdict`:

```python
class ComplianceVerdict:
    approved: bool                # Pass/fail
    principle: str               # Which principle was validated
    risk_score: float            # 0-100 risk assessment
    safeguard_ids: List[int]     # AIUC-1 safeguards applied
    iso42001_controls: List[str] # ISO controls validated
    eu_ai_act_articles: List[str]# EU AI Act articles checked
    evidence: Dict[str, Any]     # Audit evidence
    rejection_reason: Optional[str]
    remediation_steps: List[str]
```

### Governance Swarm Orchestrator

The `0001_governance_swarm_orchestrator.py` coordinates all 11 agents:

- **Pre-execution validation**: Validates workflows before agent execution
- **Post-execution validation**: Validates results after agent execution
- **Parallel validation**: Runs agents concurrently for performance
- **Strict mode**: Fails on any governance rejection
- **Audit logging**: Comprehensive compliance audit trail

---

## Integration with Specialist Agents

All specialist agents include governance integration:

```python
# GOVERNANCE INTEGRATION: This agent implements the 11-Agent Governance Swarm
# for AIUC-1, ISO 42001, ISO 27701, EU AI Act, and NIS2 compliance.

class SpecialistAgent(SubAgent):
    # Agent implementation with governance validation
    pass
```

### Governance Integration Points

1. **Pre-execution**: All inputs validated before processing
2. **During execution**: Real-time compliance monitoring
3. **Post-execution**: Output validation and audit logging
4. **Violation handling**: Automatic task creation for violations

---

## Audit Trail & Compliance Reporting

### Supabase Integration

Governance decisions are logged to `ai_governance_decisions` table:

```sql
- request_id
- workflow_state_id
- project_id
- organization_id
- agent_id
- aiuc1_principle
- aiuc1_safeguards
- iso42001_controls
- eu_ai_act_articles
- approved
- risk_score
- risk_level
- evidence
- rejection_reason
- remediation_steps
```

### Compliance Reports

Generate comprehensive compliance reports:

```python
# Generate audit evidence for certification renewals
audit_evidence = await agent.generate_audit_evidence()

# Generate compliance report for auditors
compliance_report = await orchestrator.get_compliance_report()
```

---

## Usage Guidelines

### For Agent Developers

1. **Always include governance comment** at the top of agent files
2. **Extend base classes** from `GovernanceAgent` for governance agents
3. **Use `with_governance` decorator** for existing agent wrapping
4. **Implement required methods**: `validate_compliance()`

### For System Integrators

1. **Initialize the orchestrator** before agent execution
2. **Wrap agent execution** with governance validation
3. **Handle governance rejections** appropriately
4. **Monitor compliance metrics** via Supabase dashboards

### For Compliance Officers

1. **Access audit trails** via `ai_governance_decisions` table
2. **Generate compliance reports** via orchestrator API
3. **Review violation tasks** for remediation tracking
4. **Verify framework coverage** using this document

---

## File Locations

| Component | Path |
|-----------|------|
| Base Governance Agent | `deep-agents/deep_agents/agents/shared/governance/0000_base_governance_agent.py` |
| Swarm Orchestrator | `deep-agents/deep_agents/agents/shared/governance/0001_governance_swarm_orchestrator.py` |
| EU AI Act Agent | `deep-agents/deep_agents/agents/shared/governance/0070_eu_ai_act_agent.py` |
| Security Agent | `deep-agents/deep_agents/agents/shared/governance/0010_security_agent.py` |
| Privacy Agent | `deep-agents/deep_agents/agents/shared/governance/0030_privacy_agent.py` |
| Package Init | `deep-agents/deep_agents/agents/shared/governance/__init__.py` |
| Governance Integration | `deep-agents/deep_agents/agents/shared/governance/governance_integration.py` |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2025-01 | Initial 7-agent governance swarm |
| 1.1.0 | 2025-02 | Added 4 extended agents (NIS2 compliance) |
| 1.2.0 | 2025-02 | Full ISO 42001, EU AI Act, NIS2 coverage |

---

## Related Documents

- `docs/procedures/0000_PROCEDURES_GUIDE.md` - Main procedures index
- `docs/agents/procedures/0000_AGENT_PROCEDURES_GUIDE.md` - Agent-specific procedures
- `deep-agents/README.md` - Deep agents architecture overview
- `docs/agents/plans/IT_SWARM_IMPLEMENTATION_PROGRESS.md` - IT Swarm progress

---

**Document ID**: `0000_GOVERNANCE_FRAMEWORK_PROCEDURE`  
**Last Updated**: 2026-02-09  
**Author**: Construct AI Governance Team  
**Review Cycle**: Quarterly
