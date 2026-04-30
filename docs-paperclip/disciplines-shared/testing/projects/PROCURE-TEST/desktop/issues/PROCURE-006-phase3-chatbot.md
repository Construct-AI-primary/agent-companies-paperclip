---
id: PROCURE-006
title: 01900 Chatbot — HITL & Confidence Thresholds
description: Verify ProcurementChatbot loads with correct theme, citations, document count, HITL confidence threshold of 0.7, and conversation history persistence
labels: ["testing", "procurement", "3 — Integration"]
blocked_by: []
depends_on: ["PROCURE-001", "PROCURE-002"]
para_section: testing/projects/PROCURE-TEST/desktop/issues
phase: 3 — Integration
status: todo
priority: High
story_points: 5
due_date: "2026-05-03"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-PROCUREMENT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 01900 procurement page production readiness"
  agent_goal: "As validator-qualityforge, verify ProcurementChatbot loads with correct theme, citations, document count, HITL confidence threshold of 0.7, and conversation history persistence"
  task_goal: "Execute chatbot validation across all configured features with >90% pass rate"
---

# PROCURE-006: 01900 Chatbot — HITL & Confidence Thresholds

## Executive Summary

This issue validates the ProcurementChatbot component on the 01900 page. The chatbot is the primary user-facing AI interaction point for procurement queries. It must load with the correct orange theme, render a welcome message, display accurate citations and document counts, trigger Human-In-The-Loop (HITL) escalation at the configured 0.7 confidence threshold, and persist conversation history across sessions. A pass rate above 90% is required.

## Problem Statement / Scope

The ProcurementChatbot is an embedded AI assistant that answers procurement-related questions using vector search and LLM generation. It must be visually themed (orange) to match the procurement brand, provide transparent citations for its answers, display the correct document count from the vector store, escalate to human review when confidence falls below 0.7, and maintain conversation history across browser sessions. This issue covers all chatbot features end-to-end, excluding workflow orchestration (covered in PROCURE-007).

## Required Actions

| Step | Action | Expected Result |
|------|--------|-----------------|
| 6A | Chatbot component loads with orange theme | Chatbot renders in the page; primary color is orange (#FFA500 or equivalent); styling matches procurement brand |
| 6B | Welcome message renders | Chatbot displays a welcome/greeting message on initial load |
| 6C | Citations display correctly | Chatbot responses include citation references; citations link to source documents |
| 6D | Document count is accurate | Chatbot displays the correct number of documents available in the vector store |
| 6E | HITL triggers at 0.7 threshold | When confidence is below 0.7, chatbot offers HITL escalation; escalation connects to human agent |
| 6F | Conversation history persists across sessions | Chat messages persist in localStorage or database; history loads on return visit |

## Assigned Company & Agent

- **Company:** qualityforge-ai
- **Agent:** validator-qualityforge
- **Sub-agents:** None

## Required Skills

- quality-assurance
- chatbot-testing
- hitl-validation

## Acceptance Criteria

- [ ] Chatbot component renders on the 01900 page
- [ ] Chatbot uses orange theme (primary color #FFA500 or equivalent)
- [ ] Welcome/greeting message displays on initial load
- [ ] Chatbot responses include citation references
- [ ] Citation links navigate to or display source documents
- [ ] Document count displayed matches actual vector store count
- [ ] HITL escalation option appears when confidence < 0.7
- [ ] HITL escalation connects to a human agent or queue
- [ ] Conversation history persists after page refresh
- [ ] Conversation history loads correctly on return visit
- [ ] Chat input accepts text and sends messages
- [ ] Chatbot responds within acceptable latency (< 5s)

## Dependencies

- **Blocked by:** PROCURE-001 (page foundation), PROCURE-002 (database connectivity)
- **Depends on:** PROCURE-001, PROCURE-002
- **Blocks:** None

## Estimated Duration

45 minutes

## Risk Level

**High** — The chatbot is the primary user-facing AI feature. Failures here directly impact user trust and the perceived intelligence of the procurement system.

## QC Team Checks

The following checks must be performed against the PAGE-KNOWLEDGE metadata for the 01900 page:

- [ ] **Orange theme:** Verify CSS variables or class names apply orange (#FFA500 or equivalent) as the primary chatbot color
- [ ] **Welcome message:** Confirm a greeting message (e.g., "How can I help you with procurement?") renders on initial load
- [ ] **Citations display:** Verify each chatbot response includes numbered or linked citations referencing source documents
- [ ] **Document count accuracy:** Confirm the displayed document count matches a direct query of the vectors table
- [ ] **HITL at 0.7 threshold:** Submit a query expected to produce low confidence; verify HITL escalation UI appears; confirm escalation request is sent
- [ ] **Conversation history persistence:** Send messages, refresh the page, and verify previous messages are still displayed
- [ ] **Chat input and response:** Verify text input accepts messages and chatbot generates a response within 5 seconds
