# Learning Integration

**Status**: ✅ Active — Updated with current patterns.

## Purpose

This document describes how learning and feedback loops work in the OpenClaw-orchestrated agent ecosystem — how agents learn from past tasks, how domain knowledge is updated, and how quality improvements propagate.

## Learning Workflow

### Post-Task Learning Capture
1. After each issue is completed, results are captured in the project's `learning/` directory
2. Key decisions, blockers, and resolutions are documented
3. Phase gate results inform quality improvement loops
4. Knowledge files in `knowledge/` are updated with new insights

### Knowledge Base Updates
- Domain knowledge lives in `agent-companies-core/domain-knowledge/`
- Project-specific knowledge lives in `knowledge/` under each project
- Agent definitions (AGENTS.md) are updated when new capabilities are discovered
- Skill definitions (SKILL.md) are refined based on execution experience

### Quality Score Tracking
- Phase gate pass rates are tracked per project
- Issue-level pass/fail results feed into quality metrics
- Improvement loops: failed issues → root cause analysis → remediation → re-execution

### Cross-Agent Knowledge Sharing
- Agents share knowledge through shared knowledge files
- Cross-company RACI matrices document responsibility boundaries
- Agent delegation maps document hierarchy and escalation paths

## Related Documents

- `orchestration/OVERVIEW.md` — Orchestration architecture
- `orchestration/EXECUTION-TRACKER.md` — Execution status
- `orchestration/RISK-TRACKER.md` — Risk registry
- `agent-companies-core/domain-knowledge/` — Domain knowledge base