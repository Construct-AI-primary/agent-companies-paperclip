# PROC-TRACK Agent Instructions

## Project-Specific Agent Configuration

This document provides project-specific instructions for agents working on the PROC-TRACK Order Tracking & Expediting Workflow implementation.

## Agent Roles

### Lead Agents

| Agent | Role | Responsibilities |
|-------|------|------------------|
| interface-devforge | Technical Lead | Overall implementation, API integration |
| domain-devforge | Domain Expert | Procurement tracking expertise |
| guardian-qualityforge | Quality Assurance | Testing and validation |

### Supporting Agents

| Agent | Role | Responsibilities |
|-------|------|------------------|
| orchestrator-paperclip | Orchestration | Cross-company coordination |
| knowledgeforge-ai | Documentation | Knowledge management |
| learningforge-ai | Learning | Performance monitoring |

## Agent Instructions

### interface-devforge (Technical Lead)

1. **Order Tracking Implementation**
   - Implement real-time order status tracking
   - Create delivery milestone monitoring
   - Build delay detection and alerting

2. **API Integration**
   - Integrate with PROC-ORDER for order data
   - Connect to supplier systems for status updates
   - Implement notification APIs

3. **Platform Development**
   - Desktop: Native tracking UI with Supabase
   - Mobile: Offline-capable tracking with SQLite
   - Web: Responsive tracking dashboard

### domain-devforge (Domain Expert)

1. **Procurement Tracking Expertise**
   - Define tracking milestones and stages
   - Identify delay patterns and root causes
   - Recommend expediting strategies

2. **Business Logic**
   - Implement delay detection rules
   - Define escalation thresholds
   - Create supplier engagement workflows

### guardian-qualityforge (Quality Assurance)

1. **Testing Strategy**
   - End-to-end tracking workflow tests
   - Delay identification validation
   - Expediting action verification

2. **Quality Metrics**
   - Track accuracy metrics
   - Measure delay detection time
   - Validate expediting success rates

## Communication Protocols

### Cross-Company Communication

```
interface-devforge → domain-devforge: Tracking requirements
interface-devforge → guardian-qualityforge: Test specifications
orchestrator-paperclip → all agents: Coordination updates
```

### Status Reporting

- Daily: Progress updates via Paperclip
- Weekly: Milestone reviews
- Ad-hoc: Blocker escalation

## Skill Requirements

### Required Skills

- `paperclip-orchestration`
- `procurement-tracking`
- `api-integration`
- `supabase-database`
- `e2e-testing`

### Recommended Skills

- `mobile-development`
- `offline-first-architecture`
- `supplier-integration`

---

**Document Version**: 1.0
**Last Updated**: 2026-04-08
