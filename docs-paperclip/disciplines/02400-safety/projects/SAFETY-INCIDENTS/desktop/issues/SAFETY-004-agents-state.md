---
id: SAFETY-004
title: "02400 Agents State — AI Incident Analysis & Risk Assessment"
phase: "Phase 2 — State/Modals"
status: open
priority: high
platform: desktop
blocked_by: []
depends_on: [SAFETY-001, SAFETY-002, SAFETY-003]
parent_goal: SAFETY-INCIDENTS-2026
due_date: 2026-05-20
---

# SAFETY-004: 02400 Agents State — AI Incident Analysis & Risk Assessment

## Executive Summary

Implement the Agents state for the 02400 Safety discipline, providing AI-powered safety agents for incident classification, root cause analysis, and risk assessment. This state enables safety managers to leverage AI for initial triage and analysis before human review.

## Problem Statement / Scope

Safety teams need AI assistance to rapidly classify incidents, assess risk levels, and identify root causes. Manual analysis is time-consuming and inconsistent. The Agents state delivers:

- Agent list view showing available safety AI agents with status indicators
- guardian-qualityforge agent: Incident classification (severity scoring, type categorization)
- devforge-ai-workflow-developer agent: Root cause analysis pattern matching
- infraforge-ai-integration-specialist agent: Risk assessment scoring
- Agent detail modal (98vw, red gradient header) showing agent capabilities, resolution rate, compliance accuracy
- CreateNewAgent modal for governance role to configure new safety agents
- AgentConfig modal for editing agent skills and compliance domains
- Loading/empty/error states per UI-UX spec

## Required Actions

| # | Action | Detail |
|---|--------|--------|
| 1 | Build Agents state view | Agent cards with name, role, status (online/offline/error), resolution rate |
| 2 | Implement guardian-qualityforge agent | Incident classification: severity scoring, type categorization, reportability determination |
| 3 | Implement devforge-ai-workflow-developer agent | Root cause analysis: pattern matching against historical incidents, RCA report generation |
| 4 | Implement infraforge-ai-integration-specialist agent | Risk assessment: probability × severity scoring, risk matrix visualization |
| 5 | Build AgentDetails modal | 98vw modal with red gradient header, agent capabilities, performance metrics |
| 6 | Build CreateNewAgent modal | Governance-only: agent name, role selection, skill toggles, compliance domain config |
| 7 | Build AgentConfig modal | Editor+: skill toggles, model selection, temperature config |
| 8 | Add loading/empty/error states | Skeleton cards, "No safety agents" CTA, red banner + retry |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** domainforge-ai
- **Supporting:** guardian-qualityforge, devforge-ai-workflow-developer, infraforge-ai-integration-specialist

## Required Skills

- AI agent integration (Qwen 2.5 model via HuggingFace endpoints)
- LoRA adapter management (incident classifier, compliance checker)
- Modal implementation (98vw, red gradient header)
- Risk matrix visualization
- Role-based visibility gating

## Acceptance Criteria

- [ ] Agents state renders three safety agent cards with status indicators
- [ ] guardian-qualityforge agent classifies incidents with severity score and type
- [ ] devforge-ai-workflow-developer agent performs root cause analysis with pattern matching
- [ ] infraforge-ai-integration-specialist agent generates risk assessment with matrix
- [ ] AgentDetails modal opens with full agent information
- [ ] CreateNewAgent modal is visible only for governance role
- [ ] AgentConfig modal is visible only for editor+ role
- [ ] Loading skeleton displays during agent data fetch
- [ ] Empty state shows "No safety agents" with CTA
- [ ] Error state shows red banner with retry

## Dependencies

- BLOCKED BY: SAFETY-001, SAFETY-002, SAFETY-003
- BLOCKS: SAFETY-005, SAFETY-006, SAFETY-007

## Estimated Duration

- **Estimated Hours:** 32 hours
- **Complexity:** High
- **Timeline:** 4 business days

## Risk Level

**High** — AI model integration carries accuracy and latency risks; incorrect classification could impact safety decisions.

## QC Team Checks

- [ ] AI classification accuracy meets 90% threshold on test dataset
- [ ] Agent API calls timeout gracefully after 30s with user notification
- [ ] Modal header gradient matches UI-UX spec
- [ ] Role gates prevent unauthorized agent creation
- [ ] Risk matrix renders correctly at all severity combinations
- [ ] Agent status indicators update in real-time
