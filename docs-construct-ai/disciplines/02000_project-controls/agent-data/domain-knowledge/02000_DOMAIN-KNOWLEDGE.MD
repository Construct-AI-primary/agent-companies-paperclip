---
title: Project Controls Team Domain Knowledge
description: Comprehensive domain knowledge for AI agents emulating a project controls professional on large engineering and architectural projects, covering planning, scheduling, cost control, risk analysis, and project performance reporting
author: Construct AI Memory System Team
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02000_project-controls/agent-data/domain-knowledge
gigabrain_tags: disciplines, 02000_project-controls, domain-knowledge, project-controls, planning, scheduling, cost-control, risk-analysis, performance-reporting
openstinger_context: project-controls, agent-knowledge-base
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/02000_project-controls/agent-data/README.md
  - docs_construct_ai/disciplines/02000_project-controls/agent-data/domain-knowledge/02000_GLOSSARY.MD
---

# Project Controls Team Domain Knowledge

## Purpose and Scope

This document serves as the authoritative domain knowledge reference for AI agents emulating a **Project Controls Manager / Planner** on large-scale engineering, infrastructure, mining, and architectural projects. It codifies the role, responsibilities, competencies, and decision-making frameworks characteristic of a project controls professional managing project schedules, cost control, risk analysis, and performance reporting.

---

## Part 1: Role on Large Projects
### 1.2 Project Controls Team Structure and Roles

The Project Controls team on large projects consists of multiple roles working collaboratively:

| Role | Level | Primary Focus | Reports To |
|------|-------|--------------|-----------|
| **Project Controls Manager** | Senior | Cost, schedule, risk oversight | Projects Director |
| **Planning Engineer** | Mid-level | Schedule development, progress tracking | Project Controls Manager |
| **Cost Engineer** | Mid-level | Cost estimation, tracking | Project Controls Manager |

**Note:** Director-level roles are handled separately under discipline 00895. This document focuses on the operational project controls team.


### 1.1 Executive Summary

The project controls team is responsible for establishing and maintaining the project management systems required to plan, monitor, and control project scope, schedule, cost, and risk. This includes developing and maintaining the project schedule, managing cost control systems, performing risk analysis, conducting progress measurement, and producing performance reports.

### 1.2 Key Responsibilities

**Planning and Scheduling:**
- Develop and maintain the Level 1 through Level 5 project schedules
- Establish the work breakdown structure (WBS), organization breakdown structure (OBS), and cost breakdown structure (CBS)
- Develop baseline schedule and manage baseline maintenance and revisions
- Produce look-ahead schedules for construction and engineering activities
- Analyze schedule impacts from changes, delays, and disruptions
- Perform critical path method (CPM) scheduling and schedule analysis

**Cost Control and Monitoring:**
- Establish the project cost control system and cost codes
- Monitor committed cost, actual cost, and forecast cost to complete
- Track budget vs. actual vs. forecast (S-curve analysis)
- Prepare trend analysis and early warning reports
- Manage contingency drawdown and management reserves
- Coordinate with QS/Commercial team on cost commitments and valuations

**Risk Management:**
- Develop and maintain the project risk register
- Facilitate risk identification workshops and quantitative risk analysis
- Track risk mitigations, assign owners, and monitor risk exposure
- Produce risk reports and escalate high-impact/high-probability risks
- Integrate risk analysis into schedule and cost forecasting

**Progress Measurement and Reporting:**
- Establish project performance measurement baseline (earned value management)
- Track planned vs. actual progress by work package
- Calculate schedule variance (SV), cost variance (CV), SPI, and CPI
- Produce weekly and monthly progress reports
- Prepare executive dashboards and project status presentations

### 1.3 Applicable Standards and Methods

| Standard | Subject |
|---------|---------|
| PMBOK Guide (PMI) | Project management standards |
| AACE International Recommended Practices | Cost engineering and scheduling |
| ISO 31000 | Risk management standard |
| Planning & Scheduling Professional (PSP) | AACE scheduling standards |
| Earned Value Management (EVM) | ANSI EIA-748 standard |

---

## Part 2: Scheduling

### 2.1 Schedule Hierarchy

| Level | Purpose | Detail | Example Content |
|-------|---------|--------|-----------------|
| Level 1 | Executive summary | Major phases and milestones | Project start, design complete, mechanical complete, commissioning, handover |
| Level 2 | Management summary | Major deliverables and work areas | Engineering complete, procurement complete, civil complete, mechanical complete |
| Level 3 | Control schedule | Work packages and major activities | Each area broken into engineering, procurement, construction activities |
| Level 4 | Detailed schedule | Individual tasks and sub-tasks | Individual drawing production, individual equipment orders, installation activities |
| Level 5 | Execution schedule | Daily/weekly crew assignments | Daily activities for construction crews |

### 2.2 Schedule Development Process

1. **Scope Definition:** Define all project deliverables from the scope statement, BOQ, and drawings
2. **WBS Development:** Organize scope into work packages aligned with project execution strategy
3. **Activity Definition:** Break work packages into schedulable activities with clear start and end criteria
4. **Logical Sequencing:** Establish predecessor and successor relationships between activities
5. **Resource Loading:** Assign labour, material, and equipment resources to each activity
6. **Duration Estimation:** Estimate realistic durations based on productivity rates and resource availability
7. **Critical Path Analysis:** Identify the longest path through the network that determines minimum project duration
8. **Baseline Review and Approval:** Review with all stakeholders and establish the baseline schedule

### 2.3 Schedule Maintenance and Control

**Weekly/Monthly Update Process:**
1. **Data Collection:** Collect progress updates, actual start/finish dates, resource usage
2. **Schedule Update:** Update schedule in the scheduling tool (Primavera P6, MS Project)
3. **Critical Path Review:** Verify critical path, identify changes from previous update
4. **Variance Analysis:** Compare planned dates to baseline dates; identify delays
5. **Schedule Forecasting:** Forecast remaining work and project completion date
6. **Reporting:** Produce schedule reports with narrative analysis

### 2.4 Delay Analysis Methods

**Common Techniques:**
- **Time Impact Analysis (TIA):** Models the impact of a delaying event by inserting fragnets into the schedule
- **As-Planned vs. As-Built:** Compares the baseline programme to the actual constructed programme
- **Windows Analysis:** Analyzes schedule performance in time windows (typically monthly intervals)
- **Collapsed As-Built:** Removes delaying events from the as-built schedule to determine their impact
- **Impacted As-Planned:** Adds delaying events to the baseline to determine their effect on completion

---

## Part 3: Cost Control

### 3.1 Cost Control System

The cost control system tracks project expenditure from budget approval through final account.

| Element | Purpose |
|---------|---------|
| Budget | Approved project budget by CBS element |
| Commitments | Value of POs, subcontracts, and orders placed |
| Actual Cost | Value of work performed as invoiced or accrued |
| Commitment vs. Budget | Tracks remaining budget availability |
| Actual vs. Budget | Tracks expenditure against approved budget |
| Forecast to Complete | Estimate of remaining cost to finish each element |
| Estimate at Completion | Current budget remaining + committed + forecast to complete |

### 3.2 Earned Value Management (EVM)

**Key EVM Metrics:**
| Metric | Formula | Meaning |
|--------|---------|---------|
| Planned Value (PV) | Budgeted cost of work scheduled | Value of work planned by this date |
| Earned Value (EV) | Budgeted cost of work performed | Value of work actually completed |
| Actual Cost (AC) | Actual cost of work performed | Money spent to date |
| Schedule Variance (SV) | EV − PV | Negative = behind schedule |
| Cost Variance (CV) | EV − AC | Negative = over budget |
| Schedule Performance Index (SPI) | EV ÷ PV | < 1.0 = behind schedule |
| Cost Performance Index (CPI) | EV ÷ AC | < 1.0 = over budget |
| Estimate at Completion (EAC) | BAC ÷ CPI | Forecast final project cost |

---

## Part 4: Risk Management

### 4.1 Risk Management Process

```
1. IDENTIFY: Brainstorm and document potential risks to project objectives
2. ASSESS: Evaluate each risk for probability and impact on schedule and cost
3. QUANTIFY: Use Monte Carlo simulation or other methods to estimate overall project exposure
4. PLAN: Develop mitigation strategies (avoid, reduce, transfer, accept); assign owners
5. MONITOR: Track risk status, mitigation effectiveness, and new/emerging risks
6. REPORT: Produce risk register updates, risk reports, and escalate high-priority risks
```

### 4.2 Risk Register Structure

| Field | Description |
|-------|-------------|
| Risk ID | Unique identifier for each risk |
| Description | Clear description of the risk and potential consequences |
| Category | Risk category (design, schedule, cost, quality, HSE, commercial, external) |
| Probability | Likelihood of occurrence (1-5 scale) |
| Impact | Consequence on schedule and/or cost (1-5 scale) |
| Risk Score | Probability × Impact (risk rating) |
| Mitigation Actions | Planned measures to reduce probability or impact |
| Owner | Person responsible for managing the risk |
| Status | Current status (open, mitigated, realized, closed) |

### 4.3 Quantitative Risk Analysis

**Monte Carlo Simulation:**
- Runs thousands of iterations using probability distributions for uncertain activities
- Produces probability distributions for project completion date and total cost
- Outputs: P10 (10% confidence), P50 (50% confidence), P80 (80% confidence) date/cost
- Identifies activities with highest sensitivity to project objectives

---

## Part 5: Progress Measurement and Reporting

### 5.1 Progress Reporting Process

| Report | Frequency | Audience | Content |
|--------|-----------|----------|---------|
| Daily Progress | Daily | Construction team, project manager | Work completed, resources on site, issues |
| Weekly Status | Weekly | Project manager, discipline leads | Planned vs. actual, upcoming priorities, key issues |
| Monthly Report | Monthly | Client, senior management | Executive summary, schedule, cost, risk, HSE, quality, issues |
| S-Curve Report | Monthly | Project management, client | Cumulative planned value, earned value, actual cost curves |
| Dashboard | Weekly/Monthly | Executive and operational levels | KPIs, RAG status, key metrics |

### 5.2 Schedule Performance Reporting

**Schedule Health Indicators:**
- Critical path activities and near-critical activities with <10 days float
- Activities delayed from baseline and their impact on completion
- Look-ahead activities for the coming period (3-week, 6-week)
- Overdue activities or activities with negative float
- Milestone status (on time, at risk, delayed)

### 5.3 S-Curve Analysis

The S-curve shows cumulative values of planned work, earned work, and actual cost over time.

**Components:**
- **Planned Value (PV) Curve:** Shows cumulative budgeted cost of work scheduled over time
- **Earned Value (EV) Curve:** Shows cumulative budgeted cost of work performed
- **Actual Cost (AC) Curve:** Shows cumulative actual expenditure
- **Variance Bars:** Shows schedule variance (EV − PV) and cost variance (EV − AC)
- **Forecast:** Shows estimated cost to complete and estimated completion date

---

## Part 6: AI Agent Persona Definition

### 6.1 Core Identity

```
You are a Project Controls Manager with 10+ years of experience on large-scale engineering
and construction projects. You specialize in project scheduling, cost control, risk analysis,
earned value management, and project performance reporting.

Your primary goals are: ACCURATE PLANNING, PROACTIVE VARIANCE DETECTION, RELIABLE FORECASTING,
and EFFECTIVE COMMUNICATION OF PROJECT STATUS. You ensure the project is properly planned,
monitored, and controlled so that performance issues are identified and addressed early.
```

### 6.2 Key Behaviors

**The agent should:**
- Maintain the baseline schedule and track all changes through formal revision processes
- Calculate and report earned value metrics accurately each reporting period
- Identify schedule and cost variances early and escalate for corrective action
- Analyze the critical path and alert the project team of any changes
- Ensure risk register is current and high-priority risks have mitigation owners
- Produce clear, actionable schedule and cost reports for decision-makers

**The agent should NOT:**
- Allow the baseline schedule to be changed without formal approval
- Report progress that does not reflect actual verified work completed
- Ignore or conceal variances or delays
- Forecast completion without considering current performance trends
- Maintain a risk register with no mitigation actions or owners

### 6.3 Probing Questions

- "What activities are on the critical path and are any of them delayed from baseline?"
- "What is the current CPI and SPI, and what do they indicate about project performance?"
- "Are there any high-priority risks without assigned mitigation owners?"
- "What is the forecasted completion date based on current performance?"
- "Has the schedule been updated with actual progress this reporting period?"
- "Is there negative float on any milestone, and what is the recovery plan?"

---

## Part 7: Appendices

### Appendix A: Common Project Controls Abbreviations

| Abbreviation | Full Term |
|-------------|-----------|
| AC | Actual Cost |
| BCWP | Budgeted Cost of Work Performed (Earned Value) |
| BCWS | Budgeted Cost of Work Scheduled (Planned Value) |
| CBS | Cost Breakdown Structure |
| CPM | Critical Path Method |
| CPI | Cost Performance Index |
| CV | Cost Variance |
| EAC | Estimate at Completion |
| ETC | Estimate to Complete |
| EVM | Earned Value Management |
| OBS | Organization Breakdown Structure |
| PV | Planned Value |
| SPI | Schedule Performance Index |
| SV | Schedule Variance |
| TIA | Time Impact Analysis |
| WBS | Work Breakdown Structure |

---

*Project Controls Team Domain Knowledge — Version 1.0*
*Last Updated: 2026-03-31*