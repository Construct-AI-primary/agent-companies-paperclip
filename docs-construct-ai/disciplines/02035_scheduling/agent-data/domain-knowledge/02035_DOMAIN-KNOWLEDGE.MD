---
title: Scheduling Team Domain Knowledge
description: Comprehensive domain knowledge for AI agents emulating a project scheduler on large engineering and architectural projects, covering CPM scheduling, progress updating, delay analysis, and schedule reporting
author: Construct AI Memory System Team
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02035_scheduling/agent-data/domain-knowledge
gigabrain_tags: disciplines, 02035_scheduling, domain-knowledge, scheduling, planning, cpm, delay-analysis, progress-tracking
openstinger_context: scheduling, agent-knowledge-base
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/02035_scheduling/agent-data/README.md
  - docs_construct_ai/disciplines/02035_scheduling/agent-data/domain-knowledge/02035_GLOSSARY.MD
---

# Scheduling Team Domain Knowledge

## Purpose and Scope

This document serves as the authoritative domain knowledge reference for AI agents emulating a **Project Scheduler / Planning Engineer** on large-scale engineering, infrastructure, mining, and architectural projects. It codifies the role, responsibilities, competencies, and decision-making frameworks characteristic of a scheduling professional managing project schedules using Critical Path Method (CPM), progress tracking, and delay analysis techniques.

---

## Part 1: Role on Large Projects
### 1.2 Scheduling Team Structure and Roles

The Scheduling team on large projects consists of multiple roles working collaboratively:

| Role | Level | Primary Focus | Reports To |
|------|-------|--------------|-----------|
| **Planning Manager** | Senior | Master schedule, resource planning | Project Controls Manager |
| **Scheduler** | Mid-level | Schedule updates, progress tracking | Planning Manager |

**Note:** Director-level roles are handled separately under discipline 00895. This document focuses on the operational scheduling team.


### 1.1 Executive Summary

The scheduling team develops, maintains, and analyzes project schedules from project inception through completion. They use Critical Path Method (CPM) scheduling to plan work sequences, track progress, identify schedule risks, and support claims management. The scheduler works closely with project management, engineering, procurement, and construction teams to ensure the project schedule accurately reflects the planned and actual progress.

### 1.2 Key Responsibilities

**Schedule Development and Baseline:**
- Develop the project schedule using CPM methodology in scheduling software (Primavera P6, MS Project)
- Establish the Work Breakdown Structure (WBS) and activity coding structure
- Define activity durations based on productivity rates, quantities, and resource availability
- Establish logical relationships between activities (FS, SS, FF, SF) with appropriate lag
- Identify and maintain the critical path
- Develop resource-loaded schedules (labour, materials, equipment by activity)
- Establish the schedule baseline and obtain client approval

**Schedule Maintenance and Updating:**
- Collect progress data from engineering, procurement, construction, and commissioning teams
- Update the schedule with actual start/finish dates and remaining durations
- Re-sequence activities as required to reflect changing site conditions or priorities
- Analyze changes to the critical path and near-critical paths
- Forecast the impact of current performance on project completion

**Delay Analysis and Claims Support:**
- Identify and document schedule delays and their causes
- Perform delay analysis using Time Impact Analysis (TIA), Windows Analysis, or As-Planned vs. As-Built methods
- Support the contracts/QS team in Extension of Time (EOT) claims preparation
- Assess the impact of variations, site instructions, and unforeseen conditions on the schedule

**Reporting and Communication:**
- Produce weekly and monthly schedule reports with narrative analysis
- Generate look-ahead schedules (3-week, 6-week, 3-month)
- Produce S-curves for planned and actual progress
- Present schedule status and critical issues to project management
- Maintain schedule change logs and revision history

### 1.3 Applicable Standards

| Standard | Subject |
|---------|---------|
| AACE International Recommended Practice 29R-03 | Forensic Schedule Analysis |
| AACE International Recommended Practice 98R-10 | Scheduling of Construction and Engineering Projects |
| PMI Practice Standard for Scheduling | Scheduling principles and best practices |
| SCL Delay and Disruption Protocol | UK guidance on schedule delay analysis |

---

## Part 2: Critical Path Method (CPM)

### 2.1 CPM Fundamentals

**Activity Relationships:**
- **Finish-to-Start (FS):** Successor cannot start until predecessor finishes (most common)
- **Start-to-Start (SS):** Successor cannot start until predecessor starts
- **Finish-to-Finish (FF):** Successor cannot finish until predecessor finishes
- **Start-to-Finish (SF):** Successor cannot finish until predecessor starts (rare)

**Float Types:**
- **Total Float:** Amount of time an activity can be delayed without delaying the project completion
- **Free Float:** Amount of time an activity can be delayed without delaying the early start of its successor
- **Negative Float:** Indicates the project is behind schedule

### 2.2 Critical Path Identification

The critical path is the longest sequence of activities through the network that determines the project completion date. Activities on the critical path have zero or negative total float.

**Critical Path Management:**
- Monitor critical path activities weekly
- Track near-critical activities (<10-14 days float) as they may become critical
- Alert the project team when the critical path changes
- Develop recovery schedules when the critical path shows delays

### 2.3 Schedule Quality Assessment

A quality schedule should meet these criteria:
- All activities have predecessors and successors (no open ends)
- Relationships use correct logic types with minimal use of lags
- Constraints are minimized and used only when justified
- The critical path is complete and makes logical sense
- Durations are realistic and resource-supported
- The schedule is resource-loaded where appropriate
- Float is managed and not artificially constrained

---

## Part 3: Schedule Updates and Progress Tracking

### 3.1 Schedule Update Process

1. **Data Collection:** Collect actual progress and status updates from all disciplines
2. **Input Data:** Enter actual start/finish dates and update remaining durations
3. **Schedule Calculation:** Run the schedule to recalculate early/late dates and float
4. **Critical Path Review:** Verify the critical path and identify changes from the previous update
5. **Variance Analysis:** Compare against the baseline; identify variances and their causes
6. **Forecast:** Forecast remaining work and project completion based on current performance
7. **Reporting:** Produce schedule reports with narrative commentary

### 3.2 Progress Measurement

| Method | Application |
|--------|-------------|
| 0/100 Rule | Activity earns 0% EV until complete, then 100% (short activities) |
| 50/50 Rule | 50% EV on start, remaining 50% on completion (medium activities) |
| Weighted Milestones | EV assigned to reaching specific milestones within the activity |
| Quantity-Based | EV proportional to measured quantities installed |
| Expert Judgment | EV based on inspector/planner assessment of work completeness |

### 3.3 Look-Ahead Schedules

**3-Week Lookahead:**
- Detailed short-term schedule for construction crews
- Shows actual planned daily activities
- Confirms material, equipment, and labour availability for each activity
- Identifies upcoming inspections and hold points

**6-Week Lookahead:**
- Intermediate planning horizon
- Shows activities starting or finishing in the next six weeks
- Identifies long-lead material deliveries required
- Highlights resource requirements and potential conflicts

---

## Part 4: Delay Analysis

### 4.1 Types of Delay

| Delay Type | Description | Responsibility |
|-----------|-------------|---------------|
| Excusable, Compensable | Caused by the employer; contractor entitled to EOT and costs | Employer |
| Excusable, Non-Compensable | Caused by neutral events (force majeure, exceptional weather); EOT only | Neither party |
| Non-Excusable | Caused by the contractor; no EOT or cost entitlement | Contractor |
| Concurrent | Two or more overlapping delays, each caused by a different party | Depends on contract |

### 4.2 Delay Analysis Methods

| Method | Description | When Used |
|--------|-------------|-----------|
| Time Impact Analysis (TIA) | Inserts delaying events into the schedule at the time of occurrence and measures the impact on completion | Prospective or contemporary analysis; preferred method |
| Windows Analysis | Analyzes schedule performance in time windows (usually monthly) to identify causes of delay in each window | Retrospective analysis using contemporaneous schedules |
| As-Planned vs. As-Built | Compares the baseline schedule to the actual constructed sequence | Retrospective analysis; less preferred |
| Collapsed As-Built | Removes delaying events from the as-built to determine what would have happened | Retrospective analysis |
| Impacted As-Planned | Adds delaying events to the baseline | Retrospective analysis; least preferred |

---

## Part 5: Schedule Reporting

### 5.1 Types of Schedule Reports

| Report | Frequency | Audience | Content |
|--------|-----------|----------|---------|
| Schedule Update Report | Monthly | Project team, client | Updated schedule, critical path, variances, forecast |
| Look-Ahead Schedule | Weekly | Construction team | 3-6 week detail activities, resources, prerequisites |
| Milestone Status Report | Monthly | Senior management | Milestone list, planned vs. actual dates, status |
| S-Curve Report | Monthly | Project management, client | Cumulative planned vs. actual progress |
| Delay/Claim Report | As required | Commercial team | Detailed delay analysis with supporting schedule data |

### 5.2 Schedule Reporting Elements

- **Critical Path Summary:** Current critical path activities and any changes since last update
- **Float Analysis:** Activities with negative or low float and their causes
- **Variance Summary:** Activities delayed from baseline with root cause and impact assessment
- **Recovery Plan:** Actions to recover delays and bring the schedule back on track
- **Forecast:** Earliest expected completion date based on current performance
- **Key Issues:** Outstanding matters affecting the schedule (RFIs, variations, material delays)

---

## Part 6: AI Agent Persona Definition

### 6.1 Core Identity

```
You are a Project Scheduler with 10+ years of experience on large-scale engineering
and construction projects. You specialize in CPM scheduling, schedule updating,
progress tracking, delay analysis, and schedule reporting.

Your primary goals are: ACCURATE PLANNING, RELIABLE PROGRESS REPORTING, EARLY DELAY DETECTION,
and SUPPORT FOR RECOVERY PLANNING. You ensure the schedule reflects the true status
of the project and supports timely decision-making.
```

### 6.2 Key Behaviors

**The agent should:**
- Maintain accurate logical relationships between all activities
- Identify and report critical path changes immediately
- Ensure all schedule updates reflect verified actual progress
- Analyze delays systematically and document findings
- Produce look-ahead schedules with material and resource availability confirmed

**The agent should NOT:**
- Change the baseline schedule without formal approval
- Report progress that is not verified by site teams
- Mask delays through artificial constraints or out-of-sequence progress
- Allow open-end activities in the schedule without justification

### 6.3 Probing Questions

- "Has the critical path changed since the last update?"
- "Are there any activities with negative float, and what is causing them?"
- "Has actual progress been verified for all reported activities?"
- "What is the forecasted project completion based on current performance?"
- "Are there any upcoming activities that are blocked by prerequisites?"

---

## Part 7: Appendices

### Appendix A: Common Scheduling Abbreviations

| Abbreviation | Full Term |
|-------------|-----------|
| CPM | Critical Path Method |
| EOT | Extension of Time |
| ES | Early Start |
| EF | Early Finish |
| LS | Late Start |
| LF | Late Finish |
| TF | Total Float |
| FF | Free Float |
| FS | Finish-to-Start |
| SS | Start-to-Start |
| FF | Finish-to-Finish |
| SF | Start-to-Finish |
| TIA | Time Impact Analysis |
| WBS | Work Breakdown Structure |

---

*Scheduling Team Domain Knowledge — Version 1.0*
*Last Updated: 2026-03-31*