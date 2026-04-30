# CROSS-COMPANY RACI MATRIX — MEASURE-AI

## Overview

This document defines the Responsible, Accountable, Consulted, and Informed (RACI) assignments for the MEASURE-AI project across all participating companies.

## RACI Key

- **R** — Responsible (does the work)
- **A** — Accountable (answers for the outcome)
- **C** — Consulted (provides input before decision)
- **I** — Informed (notified after decision)

## RACI Matrix

| Activity | qualityforge-ai | domainforge-ai | devforge-ai | measureforge-ai | loopy-ai | paperclipforge-ai |
|----------|----------------|----------------|-------------|-----------------|----------|-------------------|
| **MEASURE-AI-001: Model Assignments** | | | | | | |
| Primary model selection framework | R/A | C | C | C | - | I |
| Fallback model configuration | R/A | C | C | C | - | I |
| Performance parameter optimization | R/A | - | C | C | - | I |
| Model assignment SQL scripts | R/A | - | R | - | - | I |
| Cross-platform model validation | R/A | C | C | C | - | I |
| **MEASURE-AI-002: Agent Activation** | | | | | | |
| Agent activation procedures | R/A | C | C | C | - | I |
| Activation sequencing | R/A | C | C | C | - | I |
| Status tracking integration | R/A | - | C | - | - | I |
| Error handling & rollback | R/A | C | C | C | - | I |
| **MEASURE-AI-003: Testing Protocols** | | | | | | |
| Test case development | R/A | C | C | C | - | I |
| Automated test execution | R/A | - | R | - | - | I |
| Performance benchmarking | R/A | C | C | C | - | I |
| Regression testing | R/A | - | C | C | - | I |
| **MEASURE-AI-004: Performance Monitoring** | | | | | | |
| Monitoring dashboard | R/A | - | R | C | C | I |
| Alert configuration | R/A | C | C | C | - | I |
| Metric collection pipeline | R/A | - | R | - | - | I |
| Reporting automation | R/A | - | C | C | - | I |

## Company Roles

| Company | Primary Role | Issues Assigned |
|---------|-------------|-----------------|
| **qualityforge-ai** | AI model assignments, agent activation, testing, performance monitoring | MEASURE-AI-001, MEASURE-AI-002, MEASURE-AI-003, MEASURE-AI-004 |
| **domainforge-ai** | Domain expertise, discipline-specific validation | Supporting (all issues) |
| **devforge-ai** | Technical implementation, SQL scripts, automation | Supporting (all issues) |
| **measureforge-ai** | Measurement domain expertise, model validation | Supporting (all issues) |
| **loopy-ai** | UI/UX for monitoring dashboard | Supporting (MEASURE-AI-004) |
| **paperclipforge-ai** | Cross-platform coordination | Informed (all issues) |
