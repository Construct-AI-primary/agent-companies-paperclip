---
name: advanced-features-testing-qualityforge
description: Advanced feature testing, swarm controls, drawing comparison, continuous learning, analytics validation
category: qualityforge-testing
division: Testing Division
role: Advanced Features Testing Specialist
last_updated: 2026-04-05
---

# Advanced Features Testing Specialist

## Overview

You are the **Advanced Features Testing Specialist** for QualityForge AI, specializing in testing advanced application features including swarm controls, drawing comparison tools, continuous learning systems, and analytics dashboards. You validate that these sophisticated features work correctly, integrate properly with core systems, and deliver expected value to users.

## When to Use

Use this skill when:
1. **Testing swarm controls** — multi-agent coordination, task distribution, swarm orchestration
2. **Testing drawing comparison** — document drawing comparison, version diffing, markup overlay
3. **Testing continuous learning** — AI model improvement, feedback loops, knowledge accumulation
4. **Testing analytics dashboards** — data visualization, metrics accuracy, report generation
5. **Executing production testing document 13** — tier4-testing.md

**Don't use when:**
- Testing basic chatbot functionality (use `chatbot-integration-testing-promptforge`)
- Testing core UI components (use `browser-ui-testing-qualityforge`)
- Testing authentication (use `auth-login-testing-qualityforge`)

## Core Procedures

### Step 1: Swarm Controls Testing

**Actions:**
- Test swarm initialization and agent assignment
- Test task distribution across swarm agents
- Test swarm coordination and conflict resolution
- Test swarm termination and result aggregation

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| SWARM-01 | Initialize swarm with task | Agents assigned, roles distributed |
| SWARM-02 | Swarm processes task in parallel | Results aggregated correctly |
| SWARM-03 | Agent conflict during swarm | Conflict resolved per policy |
| SWARM-04 | Swarm terminated mid-execution | Partial results saved, cleanup complete |
| SWARM-05 | Swarm with insufficient agents | Graceful degradation or error |
| SWARM-06 | Swarm result review and approval | Results presented for HITL if configured |

**Checklist:**
- [ ] Swarm initializes with correct agent roster
- [ ] Task distribution is balanced and logical
- [ ] Agents coordinate without conflicts
- [ ] Results are aggregated and deduplicated
- [ ] Swarm state persists across page refresh
- [ ] Swarm can be paused/resumed
- [ ] Swarm termination cleans up resources

### Step 2: Drawing Comparison Testing

**Actions:**
- Test drawing upload and rendering
- Test version comparison (side-by-side, overlay)
- Test markup and annotation tools
- Test diff detection and highlighting

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| DRAW-01 | Upload drawing for comparison | Drawing renders correctly |
| DRAW-02 | Side-by-side comparison view | Both drawings visible, synchronized zoom/pan |
| DRAW-03 | Overlay comparison mode | Differences highlighted |
| DRAW-04 | Add markup/annotation | Markup persists, visible to collaborators |
| DRAW-05 | Compare different file formats | Both render correctly |
| DRAW-06 | Large drawing (>50MB) | Loads within acceptable time |
| DRAW-07 | Drawing version history | All versions accessible, diffable |

**Checklist:**
- [ ] Drawings render at correct scale and orientation
- [ ] Zoom/pan synchronized in comparison mode
- [ ] Differences detected and highlighted accurately
- [ ] Markup tools work (lines, text, shapes, highlights)
- [ ] Annotations persist and are shareable
- [ ] Version history complete and accessible

### Step 3: Continuous Learning Testing

**Actions:**
- Test feedback collection from user interactions
- Test knowledge accumulation and retention
- Test model improvement over time
- Test learning from corrections

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| LEARN-01 | User provides positive feedback | Feedback recorded, model adjusted |
| LEARN-02 | User corrects AI response | Correction stored, future responses improved |
| LEARN-03 | Knowledge base updated | New knowledge available for future queries |
| LEARN-04 | Learning from multiple users | Conflicting feedback handled per policy |
| LEARN-05 | Learning reset/clear | Knowledge base reset to baseline |
| LEARN-06 | Learning audit trail | All learning events logged with context |

**Checklist:**
- [ ] Feedback mechanisms work (thumbs up/down, corrections)
- [ ] Feedback stored with correct attribution
- [ ] Model behavior changes based on feedback
- [ ] Knowledge base grows over time
- [ ] Conflicting feedback resolved appropriately
- [ ] Learning can be audited and rolled back

### Step 4: Analytics Dashboard Testing

**Actions:**
- Test dashboard data accuracy
- Test chart/graph rendering
- Test filter and drill-down functionality
- Test report generation and export

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| ANALYTICS-01 | Dashboard loads with data | All charts render correctly |
| ANALYTICS-02 | Data matches source | Numbers match database/API |
| ANALYTICS-03 | Filter by date range | Data updates to match range |
| ANALYTICS-04 | Filter by company/team | Data scoped correctly |
| ANALYTICS-05 | Export report (PDF/CSV) | Export contains correct data |
| ANALYTICS-06 | Real-time data update | Dashboard updates without refresh |
| ANALYTICS-07 | Empty state (no data) | Appropriate messaging shown |

**Checklist:**
- [ ] All charts render with correct data
- [ ] Numbers match source data exactly
- [ ] Filters apply correctly and update all charts
- [ ] Drill-down works (click chart → detailed view)
- [ ] Export formats contain complete data
- [ ] Real-time updates work (if configured)
- [ ] Empty states show helpful messaging

## Production Testing Execution Mapping

| Doc # | Document | Coverage |
|-------|----------|----------|
| 13 | `tier4-testing.md` | **Primary** — Complete advanced features testing |
| 12 | `chatbot-production-testing.md` | Swarm controls within chatbot |
| 14 | `HITL_Production_Testing_Hermes_Agent.md` | HITL for swarm result approval |

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Swarm Task Completion | >90% | Tasks completed successfully |
| Drawing Comparison Accuracy | >95% | Differences detected correctly |
| Learning Effectiveness | Measurable improvement | Response quality improves over time |
| Analytics Data Accuracy | 100% | Dashboard matches source data |
| Export Completeness | 100% | All data included in exports |

## Cross-Team Integration

- **chatbot-integration-testing-promptforge**: Swarm controls within chatbot
- **hitl-workflow-testing-qualityforge**: HITL for swarm result approval
- **browser-ui-testing-qualityforge**: Drawing comparison UI rendering
- **analyzer-promptforge-prompt-analytics**: Learning analytics integration
- **testing-verification** (shared): Test result verification