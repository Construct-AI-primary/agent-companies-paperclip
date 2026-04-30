---
title: 02050 Information Technology AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement Information Technology features including error tracking systems, AI integration, code generation, log analysis, team collaboration, and enterprise IT operations with structured data architecture and IT safety boundaries
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02050_information-technology/agent-data/prompts
gigabrain_tags: disciplines, 02050_information-technology, ai-native-operations, document-generation, error-tracking, ai-integration, multi-agent-orchestration, log-analysis, code-intelligence, natural-language-interface, code-generation
openstinger_context: information-technology-ai-native-operations, automated-documentation, code-generation, agent-integration, enterprise-it
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/02050_information-technology/agent-data/domain-knowledge/02050_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/02050_information-technology/01500_MASTER_GUIDE.md
  - docs_construct_ai/disciplines/02050_information-technology/01500_MASTER_GUIDE_INFORMATION_TECHNOLOGY.md
  - docs_construct_ai/disciplines/02050_information-technology/01500_MASTER_GUIDE_ERROR_TRACKING.md
  - docs_construct_ai/disciplines/02050_information-technology/01500_MASTER_GUIDE_TEAM_COLLABORATION.md
  - docs_construct_ai/disciplines/02050_information-technology/01500_MASTER_GUIDE_TEMPLATE_EDITOR.md
  - docs_construct_ai/codebase/procedures/workflow-management/0000_PROMPT_REVIEW_REMEDIATION_PROCEDURE.md
---

# 02050 Information Technology AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement Information Technology features for the ConstructAI platform. It provides agents with the architectural context, automation spectrum, safety boundaries, and implementation patterns needed to generate correct, compliant IT code covering error tracking systems, AI integration, code generation pipelines, log analysis, team collaboration, and enterprise IT operations. Use this prompt when agents are developing IT components, workflows, APIs, or UI elements.

**Key Lesson from Safety and Civil Engineering Domains:** The automation spectrum approach (Full Automation / Augment AI+Human / Human-Led) and structured data architecture patterns are foundational principles. Agents must understand what IT code they can generate independently vs. what requires human architect review. The code generation and log analysis pipelines must never allow LLMs to fabricate system state data or bypass security controls.

**Important:** This prompt is for **OpenClaw coding agents operating in dev mode**. Agents use this prompt to **generate, modify, and validate code**. This prompt is NOT for the running application in production. The automation spectrum defines what **code** agents can generate independently vs. what requires human architect review.

## Implementation Action List & Progress Tracking

### Phase 1: Foundation — Text-Native vs Code-Native Architecture
- [ ] **Classify all IT data sources** — Tag each input as text-native (LLM-friendly), code-native (AST parsing), structured data (JSON, DB), or visual (screenshots, diagrams)
- [ ] **Implement code extraction pipeline** — AST parsing → schema validate → structured JSON → LLM analysis
- [ ] **Build extraction schemas per code type** — React components, SQL schemas, API handlers, CSS modules
- [ ] **Implement provenance tracking** — Every code-derived value tagged with source file, version, line references
- [ ] **Enforce guard rails** — LLM cannot create/edit code without validation; must flag missing data as "unknown"

### Phase 2: Document Generation Pipeline Implementation
- [ ] **Create template library** — Standardize all IT document templates (architecture docs, error reports, API guides, security audits)
- [ ] **Implement structured data injection** — Template engine fills placeholders from APIs, databases, logs (not raw LLM text)
- [ ] **Develop Phase 1 documents (System Documentation)** — Architecture diagrams, schema docs, API guides, security reports
- [ ] **Develop Phase 2 documents (Error Management)** — Error reports, resolution workflows, health reports, analytics
- [ ] **Develop Phase 3 documents (AI Operations)** — LLM configs, prompt libraries, AI performance reports
- [ ] **Develop Phase 4 documents (Operational)** — Meeting minutes, method statements, risk assessments
- [ ] **Develop Phase 5 documents (Strategic)** — IT roadmap, capability assessments, compliance audits
- [ ] **Add quality validation** — Automated completeness checks, system accuracy verification
- [ ] **Implement version control** — Document revision tracking with immutable audit trail

### Phase 3: Multi-Agent IT Orchestration
- [ ] **Implement Error Discovery Agent** — Automated error detection, classification, and prioritization
- [ ] **Implement Log Analysis Agent** — Pattern detection, anomaly identification, root cause analysis
- [ ] **Implement Code Generation Agent** — Template-based code scaffolding with AST validation
- [ ] **Implement Documentation Agent** — Auto-generate documentation from code and system state
- [ ] **Implement Performance Monitoring Agent** — System load tracking, performance degradation detection
- [ ] **Implement Security Analysis Agent** — RLS policy checking, access control validation
- [ ] **Implement agent coordination layer** — Error discovery → Analysis → Template generation → Resolution → Verification workflow

### Phase 4: Log Analysis & System Monitoring
- [ ] **Implement error pattern detection** — Real-time error identification with trend analysis
- [ ] **Develop system health monitoring** — Component status tracking, resource usage analysis
- [ ] **Implement anomaly detection** — Detect unusual patterns in logs, metrics, user behavior
- [ ] **Develop alert system** — Real-time notifications for detected anomalies, error spikes
- [ ] **Implement predictive monitoring** — Forecast system load, predict performance degradation

### Phase 5: Natural Language IT Interface
- [ ] **Implement Code Query Assistant** — "Show all RLS policies for error_tracking table" → exact code locations
- [ ] **Develop Configuration Discovery** — "What LangChain models are configured?" → config summary
- [ ] **Implement Error Investigation Assistant** — "Show 500 errors in last hour" → filtered error report
- [ ] **Develop System Query Interface** — "Which components use the three-state navigation pattern?" → code locations
- [ ] **Implement chatbot with IT boundaries** — Cannot modify RLS policies directly, cannot approve production deployments

### Phase 6: Code Intelligence & Static Analysis
- [ ] **Implement static analysis integration** — ESLint, TypeScript compiler analysis for code quality
- [ ] **Develop dependency tracking** — Track code dependencies, identify circular references
- [ ] **Implement refactoring suggestions** — Identify code smells, suggest improvements with evidence
- [ ] **Develop test generation** — Generate test cases from code patterns and error history
- [ ] **Implement code review assistance** — Pre-review suggestions with confidence scoring

### Phase 7: Data-Driven IT Operations
- [ ] **Implement error rate trending** — Track error rates over time, identify degrading components
- [ ] **Develop deployment risk prediction** — Predict deployment issues from code changes
- [ ] **Implement performance correlation** — Correlate code changes with performance metrics
- [ ] **Develop capacity forecasting** — Predict infrastructure needs from usage patterns
- [ ] **Implement dashboard interface** — Real-time IT visualization with trend analysis

### Phase 8: AI Safety Boundaries & Governance
- [ ] **Implement non-delegable decision controls** — Production deployments always require human approval
- [ ] **Develop uncertainty disclosure** — AI must disclose when system state unverified, analysis limited
- [ ] **Implement immutable audit trail** — Log all AI outputs with provenance tags for code-derived values
- [ ] **Develop human review gates** — Security changes, architecture decisions require human validation
- [ ] **Implement data retention and privacy** — Compliance with system logs, user data privacy requirements

## Discipline Context

### 02050 Information Technology Scope
The 02050 Information Technology discipline encompasses:
- **AI-Native Operations**: Automating IT operations from error analysis to code generation
- **Error Management**: Tracking, discovery, classification, resolution workflows, analytics
- **Code Generation Pipeline**: Template-based generation with AST validation and quality gates
- **AI Integration**: LangChain, LLM management, prompt engineering, RAG pipelines
- **Log Analysis**: Pattern detection, anomaly identification, root cause analysis
- **Team Collaboration**: Meeting documentation, method statements, risk assessments
- **System Monitoring**: Real-time health tracking, performance analytics, alert systems
- **IT Governance**: AI boundaries, human review gates, audit trails, security controls

### Related Disciplines
- **00872 Developer**: IT provides infrastructure for development operations
- **00884 Engineering Director**: IT reports to engineering leadership
- **01200 Finance**: IT cost tracking and budget management
- **02500 Security**: IT security infrastructure and cybersecurity
- **02200 Quality Assurance**: IT system quality monitoring
- **01300 Governance**: IT governance and compliance
- **All Disciplines**: IT provides platform infrastructure for all disciplines

## Core Template Structure

```
[TASK DESCRIPTION]

Using the Construct AI memory system with Gigabrain for 02050 Information Technology AI-Native Operations:

**PARA Navigation:**
- Access docs_construct_ai/disciplines/02050_information-technology/agent-data/domain-knowledge/
- Reference AI-native operations documentation (Part 7 in DOMAIN-KNOWLEDGE.MD)
- Reference related areas: [additional PARA paths based on task]

**Gigabrain Search:**
- Search gigabrain tags for "disciplines, 02050_information-technology", "ai-native-operations", "[specific-capability]"
- Filter by tags: "error-tracking", "code-generation", "ai-integration", "log-analysis", "multi-agent-orchestration"

**Memory Context:**
- Include memory headers showing related_docs, para_section, and gigabrain_tags
- Cross-reference with IT domain knowledge and existing master guides
- Check memory for recent IT AI implementation patterns

**Information Technology AI-Native Context:**
- Reference text-native, code-native, and structured data input classification
- Apply code processing pipeline (AST parsing → extraction → validation → structured data → LLM)
- Follow document generation pipeline principles (template-based structured data injection)
- Respect non-delegable human decisions (production deployments, security policy changes)

**Knowledge Integration:**
- Follow cross-references in memory headers
- Identify patterns across similar IT AI implementations
- Build on established IT organizational knowledge
- Ensure compliance with system architecture and security requirements

[SPECIFIC REQUIREMENTS OR QUESTIONS]
```

## IT AI-Native Use Case Templates

### Error Discovery and Analysis Pipeline Execution
```
Process [ERROR_SCENARIO] using error discovery pipeline:

PARA Navigation:
- Access docs_construct_ai/disciplines/02050_information-technology/agent-data/domain-knowledge/02050_DOMAIN-KNOWLEDGE.MD
- Reference error tracking architecture: Part 6.3
- Check docs_construct_ai/disciplines/02050_information-technology/01500_MASTER_GUIDE_ERROR_TRACKING.md

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02050_information-technology", "error-tracking", "[error-type]"
- Filter by tags: "error-discovery", "pattern-matching", "automated-classification"

Memory Context:
- Include memory headers with error tracking gigabrain_tags
- Cross-reference with error tracking and analytics master guides
- Reference historical error patterns and resolution strategies

IT AI-NATIVE CONTEXT:
- Apply error discovery pipeline: Detection → Classification → Prioritization → Assignment → Resolution
- Use structured log data for analysis (not raw LLM log parsing)
- Enforce guard rails: AI cannot dismiss errors without human validation for critical classifications
- Implement provenance tracking: source component, timestamp, error context

Provide error discovery implementation with:
- Detection mechanisms (log monitoring, user reports, automated scans)
- Classification schema with confidence scoring
- Prioritization rules based on impact and frequency
- Resolution workflow with template suggestions
- Human verification checkpoints for critical errors
- Trend analysis and pattern detection algorithms
```

### Code Generation Pipeline Execution
```
Implement [CODE_COMPONENT] generation using code generation pipeline:

PARA Navigation:
- Access docs_construct_ai/disciplines/02050_information-technology/agent-data/domain-knowledge/02050_DOMAIN-KNOWLEDGE.MD
- Reference code-generation pipeline: Part 7A code-native architecture
- Check existing component architecture for patterns

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02050_information-technology", "code-generation", "[component-type]"
- Filter by tags: "template-based", "ast-validation", "provenance-tracking"

Memory Context:
- Include memory headers with code generation gigabrain_tags
- Cross-reference with existing component implementations
- Reference coding standards and patterns

IT AI-NATIVE CONTEXT:
- Apply code generation pipeline: Template selection → Structured data injection → AST validation → Quality checks
- Use template engine with structured data injection (not raw LLM code generation)
- Enforce AST validation for all generated code
- Follow coding standards: ESLint rules, TypeScript strictness

Provide code generation implementation with:
- Template structure with all variable placeholders mapped
- Data sources for template variables (APIs, config, database)
- AST validation rules to verify generated code
- Quality validation checks before code output
- Human review requirements for generated code
- Provenance tracking for template-derived code
```

### Log Analysis and System Monitoring Implementation
```
Implement [MONITORING_CAPABILITY] using log analysis framework:

PARA Navigation:
- Access docs_construct_ai/disciplines/02050_information-technology/agent-data/domain-knowledge/
- Reference log analysis architecture: Part 7D
- Check error tracking and analytics implementations

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02050_information-technology", "log-analysis", "[capability]"
- Filter by tags: "pattern-detection", "anomaly-identification", "root-cause-analysis"

Memory Context:
- Include memory headers with log analysis gigabrain_tags
- Cross-reference with error discovery and performance monitoring
- Reference historical log analysis patterns and alerts

IT AI-NATIVE CONTEXT:
- Apply log analysis capability: Pattern Detection, Anomaly Identification, Root Cause Analysis, or Trend Prediction
- Use structured log aggregation for analysis (not LLM for raw log files)
- Implement structured data pipeline: Logs → Aggregation → Analysis → Report generation
- Define alert thresholds and escalation paths

Provide log analysis implementation with:
- Log collection pipeline architecture
- Data schema for log entries and metrics
- Analysis algorithms (pattern matching, anomaly detection, trend analysis)
- Output format (alert, report, dashboard widget, root cause summary)
- Integration with error tracking pipeline for discovered issues
- Human review thresholds for automated alert dismissal
```

### Multi-Agent IT Orchestration
```
Coordinate multi-agent workflow for [IT_PROCESS]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02050_information-technology/agent-data/domain-knowledge/
- Reference multi-agent orchestration: Part 7D
- Check agent definitions and capabilities documentation

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02050_information-technology", "multi-agent-orchestration", "[process-type]"
- Filter by tags: "agent-handoff", "data-flow", "workflow-automation"

Memory Context:
- Include memory headers with agent orchestration gigabrain_tags
- Cross-reference with agent capabilities and IT workflows
- Reference completed implementations of similar orchestrations

IT AI-NATIVE CONTEXT:
- Apply standard orchestration pattern: Error Discovery → Log Analysis → Classification → Template Assignment → Resolution → Verification
- Define data formats passed between agents (structured JSON, not raw logs)
- Implement IT boundaries: no agent can modify RLS policies directly, no agent can approve production deployments

Provide agent orchestration implementation with:
- Agent coordination sequence with trigger conditions
- Data schema passed between agents
- Error handling and escalation when agent cannot process
- Quality validation checkpoints between agent handoffs
- Human intervention points in the workflow
- Audit trail tracking for all agent actions and decisions
```

## Automation Spectrum for IT Operations Tasks

### Fully Automatable Tasks (Human-Free Generation)
The AI can independently execute these tasks with structured data input, requiring only final human review before distribution:

| Output | Trigger | Input Data | Quality Gate |
|--------|---------|-----------|--------------|
| **Error Classification** | Error detected | Error logs, stack traces, component context | Auto-validation: component identified, severity assessed |
| **Log Analysis Summary** | Log data available | Aggregated logs, metrics, timestamps | Auto-validation: patterns identified, confidence scored |
| **Code Documentation** | Code update | Source files, docstrings, API contracts | Auto-validation: completeness checked, accuracy verified |
| **Template Generation** | New document type needed | Document schema, data sources, format spec | Auto-validation: all fields mapped, format valid |
| **Configuration Validation** | Config change | Config files, schema definitions, constraints | Auto-validation: constraints checked, dependencies verified |
| **Dashboard Data Population** | Dashboard load | Metrics, logs, system state | Auto-validation: data freshness checked, completeness verified |
| **Code Review Suggestions** | PR created | Diff, coding standards, historical issues | Auto-validation: suggestions reference specific rules |
| **Test Case Generation** | Code update | Source files, test patterns, historical bugs | Auto-validation: tests compile, cover critical paths |
| **System Health Report** | Scheduled | Component metrics, error rates, resource usage | Auto-validation: all components checked, trends noted |
| **API Documentation** | API change | Endpoint definitions, request/response schemas | Auto-validation: all endpoints documented, examples valid |

### Augmented Tasks (AI + Human Co-Creation)
The AI drafts, suggests, or analyses — human specialist reviews and finalizes:

| Output | AI Contribution | Human Role | Decision Authority |
|--------|----------------|-----------|---------------------|
| **Code Generation from Templates** | Scaffold code from patterns, inject structured data | Developer validates, customizes for edge cases | Human |
| **Error Pattern Analysis** | Identify patterns, suggest root causes, recommend fixes | Developer validates analysis, selects resolution strategy | Human |
| **API Integration Scaffolding** | Generate API client code, request/response handlers | Developer validates security, error handling, edge cases | Human |
| **Security Analysis Report** | Identify potential vulnerabilities, flag suspicious patterns | Security engineer validates findings, determines action | Human |
| **Performance Optimization Suggestions** | Analyze metrics, identify bottlenecks, suggest improvements | Developer validates, implements, benchmarks | Human |
| **Architecture Documentation** | Generate from code analysis, dependency mapping | Architect validates, updates for design decisions | Human |

### Human-Led Tasks (AI Informs, Human Decides)
The AI provides data, context, and recommendations — human makes the final decision or action:

| Task | AI Support | Human Decision |
|------|-----------|----------------|
| **Production Deployment Approval** | Compile deployment checklist, risk assessment, rollback plan | Engineering lead approves deployment |
| **Security Policy Changes** | Analyze impact, flag vulnerabilities, suggest alternatives | Security lead approves changes |
| **System Architecture Decisions** | Compile metrics, suggest patterns, identify tradeoffs | System architect decides architecture |
| **Critical Bug Triage** | Gather evidence, assess impact, suggest severity | Product manager determines priority |
| **Data Retention Policy** | Analyze storage, compliance requirements, cost impact | Management decides policy |
| **Encryption Key Management** | Monitor key age, usage patterns, rotation readiness | Security team authorizes rotation |

## Document Generation Pipeline

### Pipeline Architecture
All AI-generated documents flow through a consistent pipeline with quality gates at each stage:

```
INPUT DATA COLLECTION (logs, code, API responses, system metrics)
    ↓
STRUCTURED DATA VALIDATION (schema, format, completeness, freshness)
    ↓
TEMPLATE SELECTION & CONFIGURATION (document type, audience, format)
    ↓
DATA INJECTION INTO TEMPLATE PLACEHOLDERS (structured data, not raw LLM)
    ↓
QUALITY VALIDATION (completeness, accuracy, format compliance)
    ↓
DRAFT DOCUMENT GENERATION
    ↓
HUMAN REVIEW (where required — security reports, architecture decisions)
    ↓
FINAL APPROVAL (engineering lead for critical documents)
    ↓
OUTPUT GENERATION (MD, PDF, JSON, Web UI)
    ↓
VERSION CONTROL & AUDIT LOG
    ↓
DISTRIBUTION & ARCHIVAL
```

### Template Design Principles
1. **Structured Data Injection, Not Raw Generation**: All templates use placeholders filled from verified structured data sources (APIs, databases, logs). The LLM structures and formats, but does not invent facts or metrics.
2. **Provenance Tracking**: Every data point injected into a template is tagged with its source (e.g., "error_count from error_logs table, component: auth, query: 2026-04-01 02:00:00").
3. **Conditional Logic**: Templates include logic to add or omit sections based on data availability (e.g., "if no errors in reporting period, include 'No Critical Errors' section").
4. **System Accuracy**: Templates must reflect current system state. System changes trigger template reviews to ensure accuracy.
5. **Multi-Environment Support**: Templates support dev, staging, and production contexts with appropriate data segregation.
6. **Machine Readable with Human-Friendly Export**: Generated documents are available in structured data format for analytics and human-readable format for review.

## AI-Native IT Capabilities Beyond Automation

### Code Intelligence
- **Static Analysis Integration**: ESLint, TypeScript compiler analysis with AI-suggested fixes
- **Dependency Tracking**: Map code dependencies, identify circular references, suggest decoupling
- **Refactoring Suggestions**: Identify code smells with evidence, suggest improvements with impact analysis
- **Test Generation**: Generate test cases from code patterns, error history, and edge cases

### Log Analysis & System Monitoring
- **Error Pattern Detection**: Real-time error identification with trend analysis and root cause hints
- **Anomaly Detection**: Identify unusual patterns in logs, metrics, user behavior
- **Performance Forecasting**: Predict system load, performance degradation from trends
- **System Health Dashboard**: Real-time component status, resource usage, alert history

### Natural Language IT Interface
- **Code Query Assistant**: "Show all RLS policies for error_tracking table" → exact code locations with snippets
- **Error Investigation**: "Show 500 errors in last hour with stack traces" → filtered error report
- **Configuration Discovery**: "What LangChain models are configured?" → config summary with sources
- **System Query Interface**: "Which components use the three-state navigation pattern?" → component list with refs

### Predictive Intelligence
- **Error Rate Prediction**: Forecast error rates from trends, suggest preventive actions
- **Deployment Risk Assessment**: Predict deployment issues from code changes, test coverage
- **Capacity Forecasting**: Predict infrastructure needs from usage patterns and growth rate
- **Performance Degradation Detection**: Identify degrading components before user impact

## AI Safety Boundaries — What Must NOT Be Automated

Certain decisions and actions must remain under human control for security, legal, and operational reasons:

**Non-Delegable Human Decisions:**
1. Production deployment approvals for all code changes
2. Security policy changes and RLS policy modifications
3. System architecture decisions affecting multiple disciplines
4. Critical bug triage and priority decisions for customer-impacting issues
5. Vendor selection and contract decisions
6. Data retention policy changes
7. Encryption key management and rotation decisions

**AI Must Always Disclose:**
1. When system state data is stale or potentially inaccurate
2. When error analysis is based on incomplete log data
3. When code generation recommendations have not been tested
4. When security analysis has limited coverage or false positive risk
5. What manual verification steps remain before production deployment
6. When AI confidence in error classification is below threshold
7. What system components may be affected by proposed changes

## Technical Architecture Recommendations

| Component | Recommended Approach |
|-----------|---------------------|
| **Code generation** | Template-based generation with AST validation |
| **Error tracking** | Structured logging with vector search for pattern matching |
| **Document generation** | Template engine with structured data injection from APIs, databases |
| **Log analysis** | Dedicated log aggregation; LLM works from structured summaries |
| **Code analysis** | Static analysis tools (ESLint, TypeScript compiler); LLM for guidance only |
| **Knowledge retrieval** | Vector database (RAG pattern) for docs, configs, error solutions |
| **Audit trail** | Immutable log of all AI outputs with provenance tags |
| **AI orchestration** | Agent coordination with structured data handoffs |

## AI Agent Coordination Workflow

```
Error Event Detected (500 error, user report, log anomaly)
    → Error Discovery Agent classifies and prioritizes
    → If critical: Page/SLA breach alert sent to on-call
    → Log Analysis Agent gathers context (recent changes, related errors)
    → Template Matching Agent suggests resolution path
    → If template exists: Resolution workflow generated
    → If no template: Human engineer assigned for investigation
    → Post-Resolution: Pattern recorded for future detection
    → Knowledge Base Agent updates error patterns and solutions
    → Trend Monitoring Agent updates forecasts and dashboards
```

## Implementation Best Practices

### Agent Coordination Guidelines
1. **Start with data quality** — garbage in, garbage out applies doubly for IT operations AI
2. **Implement one agent/pipeline** at a time, validate, then add next
3. **Engage QualityForge AI** for all validation and quality assurance before deployment
4. **Define clear agent boundaries** in prompts and tools from day one
5. **Document all agent decisions** with audit trail for system compliance
6. **Never let LLM process raw logs directly** — always route through aggregation pipeline first

### IT Boundary Enforcement
1. **Never allow AI to approve production deployments** — always require human engineering lead approval
2. **Never allow AI to modify RLS policies** without human security team review
3. **Never allow AI to dismiss critical errors** without human validation
4. **Always disclose AI limitations** — analysis scope, data coverage, assumption validity
5. **Always maintain immutable audit trail** for all AI decisions and outputs
6. **Always tag data-derived values** with provenance (source, timestamp, query used)

## Success Metrics

### Document Generation Metrics
- **Accuracy**: 99%+ data accuracy in generated documents vs source systems
- **Timeliness**: 80%+ reduction in document preparation time vs manual methods
- **Review Efficiency**: 50%+ reduction in human review cycles through pre-validation
- **Compliance**: 100% of system documentation generated within required timeframes

### Error Management Metrics
- **Detection Coverage**: 95%+ of errors detected before user reports
- **Classification Accuracy**: 90%+ of errors correctly classified and prioritized
- **Resolution Time**: 50%+ reduction in mean time to resolution (MTTR)
- **Pattern Learning**: 100% of resolved errors logged for future detection

### Code Intelligence Metrics
- **Static Analysis Coverage**: 100% of PRs pass automated code review
- **Test Coverage**: 80%+ code coverage for AI-generated code
- **Refactoring Impact**: Measurable improvement in code quality metrics after suggestions
- **False Positive Rate**: <10% of AI suggestions are incorrect

### Log Analysis Metrics
- **Anomaly Detection Accuracy**: 90%+ of anomalies correctly identified
- **Root Cause Identification**: 80%+ of errors have root cause context provided
- **Alert Fatigue Reduction**: 50%+ reduction in non-actionable alerts
- **Prediction Accuracy**: 75%+ accuracy in performance degradation forecasts

### Multi-Agent Orchestration Metrics
- **Completion Rate**: 95%+ of agent workflow sequences complete without failure
- **Latency**: End-to-end agent handoff <5 seconds for each transition
- **Error Recovery**: 100% of failed agent executions recovered or escalated to human
- **Audit Trail Integrity**: 100% of agent actions logged with source, timestamp, and decision

## Version History

- **v1.0** (2026-04-01): Initial AI-Native Information Technology Operations Prompt Template
- Added structured metadata header following established pattern
- Incorporated lessons learned from Safety and Civil Engineering domains
- Created IT-specific use case templates for error discovery, code generation, log analysis, and agent orchestration
- Defined automation spectrum for all IT operations tasks (Full, Augmented, Human-Led)
- Built comprehensive document generation pipeline with quality gates and template design principles
- Added code processing pipeline architecture with guard rails and provenance tracking
- Included code intelligence patterns with static analysis, dependency tracking, and test generation
- Detailed success metrics for all AI capabilities
- Added implementation best practices and IT boundary enforcement

## Information Technology AI Agent Behavioral Rules

### Non-Negotiable Rules for All IT AI Agents

1. **System Integrity Rule:** Never recommend an action that compromises system stability, security, or data integrity for speed or convenience. If a risk exists, the agent must explicitly flag it.

2. **No Data Fabrication Rule:** Never invent system metrics, error codes, or configuration values. Only use data from verified sources (APIs, databases, logs, configs).

3. **Provenance Tracking Rule:** All data-derived values must carry provenance tags (source API, timestamp, query used). Never present extracted values without their source attribution.

4. **No Guessing Rule:** If system state, configuration values, or error context is unclear, flag as "unknown — requires verification." Never assume.

5. **Specialist Referral Rule:** When a question exceeds the agent's competency boundary (security analysis, architecture decisions, deployment planning), explicitly recommend specialist input.

6. **Security Reference Rule:** When making a security-related assertion, cite the applicable policy, standard, or best practice. If uncertain, state "I would need to verify this against [specific policy/standard]."

7. **Assumption Statement Rule:** Before any system recommendation, state the assumptions it depends on (e.g., "Assuming the recent deployment did not change auth configuration...").

8. **Documentation Rule:** All recommendations should be structured so they could appear in a professional engineering email, incident report, or technical memorandum. Use formal, auditable language.

9. **Respect Non-Delegable Decisions:** Never approve production deployments, modify RLS policies directly, or make security-critical decisions. These require human professional judgment.

10. **Audit Trail Rule:** All AI outputs, data extractions, and recommendations must be recorded with full audit trail for security review, incident investigation, and continuous improvement.