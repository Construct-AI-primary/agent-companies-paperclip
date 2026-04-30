---
title: SaaSForge AI Master Procedure Index
date: 2026-04-16
status: Active
scope: Master index of all SaaSForge AI operational procedures
---

# SaaSForge AI Master Procedure Index

This document serves as the master index for all SaaSForge AI operational procedures. Each procedure is linked and cross-referenced for easy navigation.

## Overview

SaaSForge AI operates a white-label multi-tenant SaaS platform with:
- **Multiple clients**, each with isolated infrastructure
- **GitHub + Render** deployment architecture
- **Paperclip agents** for automated operations

---

## Procedure Index

### 1. Core Production Preparation

**`saasforge-production-preparation-procedure.md`**
- **Purpose**: Master procedure for preparing applications for production
- **Scope**: Supabase DB operations, API key management, multi-tenant environment setup
- **Agents**: DevOps-Engineer, Tenant-Manager, Data-Guardian
- **Phases**: 5 phases covering infrastructure to go-live
- **Link**: [View Procedure](saasforge-production-preparation-procedure.md)

---

### 2. Deployment Infrastructure

#### 2.1 Render Deployment
**`saasforge-render-deployment-procedure.md`**
- **Purpose**: Render platform service provisioning and management
- **Scope**: Service creation, domain/SSL config, auto-scaling, rollback
- **Agents**: Render-Service-Manager, Deployment-Orchestrator
- **Key Topics**:
  - Service provisioning workflow
  - Domain & SSL setup
  - Auto-scaling configuration
  - Rollback procedures
- **Link**: [View Procedure](saasforge-render-deployment-procedure.md)

#### 2.2 GitHub Workflow
**`saasforge-github-workflow-procedure.md`**
- **Purpose**: GitHub repository management and CI/CD
- **Scope**: Repository setup, branch protection, GitHub Actions, hotfixes
- **Agents**: GitHub-Branch-Manager, DevOps-Engineer
- **Key Topics**:
  - Repository creation
  - CI/CD pipeline setup
  - Development workflow
  - Hotfix procedures
- **Link**: [View Procedure](saasforge-github-workflow-procedure.md)

---

### 3. Client Operations

#### 3.1 Multi-Client Onboarding
**`saasforge-multi-client-onboarding-procedure.md`**
- **Purpose**: End-to-end new client company onboarding
- **Scope**: From requirements gathering to go-live
- **Agents**: Onboard-Master, GitHub-Branch-Manager, Render-Service-Manager, Client-Config-Manager
- **Key Topics**:
  - Requirements gathering
  - Infrastructure provisioning
  - Configuration & branding
  - Testing & validation
  - Go-live preparation
- **Link**: [View Procedure](saasforge-multi-client-onboarding-procedure.md)

#### 3.2 Client Management (Future)
- Ongoing client management procedures
- Subscription changes
- Plan upgrades/downgrades
- Client offboarding

---

### 4. Operations & Maintenance

#### 4.1 Production Operations
**`../production-operations.md`**
- **Purpose**: Day-to-day production operations
- **Scope**: Monitoring, incident response, maintenance
- **Link**: [View Procedure](../production-operations.md)

#### 4.2 Backup & Recovery
**`../database/database-backup-recovery-procedure.md`**
- **Purpose**: Database backup and recovery procedures
- **Scope**: Backup scheduling, recovery testing, disaster recovery
- **Link**: [View Procedure](../database/database-backup-recovery-procedure.md)

---

## Procedure Relationship Diagram

```
┌─────────────────────────────────────────────────────────────────────┐
│                    SaaSForge AI Operations                          │
└─────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────┐
│  1. PRODUCTION PREPARATION (Core Entry Point)                       │
│     saasforge-production-preparation-procedure.md                    │
│     ├── Supabase operations                                          │
│     ├── API key management                                           │
│     └── Multi-tenant environment setup                              │
└─────────────────────────────────────────────────────────────────────┘
                                    │
                    ┌───────────────┴───────────────┐
                    │                               │
                    ▼                               ▼
┌─────────────────────────────────────┐ ┌─────────────────────────────────────┐
│  2. DEPLOYMENT INFRASTRUCTURE        │ │  3. CLIENT OPERATIONS               │
│                                     │ │                                     │
│  2.1 Render Deployment              │ │  3.1 Multi-Client Onboarding        │
│  2.2 GitHub Workflow                │ │  (uses 2.1 and 2.2 for each client) │
│                                     │ │                                     │
│  ┌──────────────────────────────┐  │ │  ┌──────────────────────────────┐   │
│  │ Render-Service-Manager        │  │ │  │ Onboard-Master               │   │
│  │ • Service provisioning       │  │ │  │ GitHub-Branch-Manager         │   │
│  │ • Domain/SSL setup           │  │ │  │ Render-Service-Manager        │   │
│  │ • Auto-scaling               │  │ │  │ Client-Config-Manager         │   │
│  └──────────────────────────────┘  │ │  │ Onboarding-Coordinator        │   │
│                                     │ │  └──────────────────────────────┘   │
│  ┌──────────────────────────────┐  │ │                                     │
│  │ GitHub-Branch-Manager         │  │ │                                     │
│  │ • Repository setup           │  │ │                                     │
│  │ • Branch protection          │  │ │                                     │
│  │ • CI/CD pipelines            │  │ │                                     │
│  └──────────────────────────────┘  │ │                                     │
│                                     │ │                                     │
└─────────────────────────────────────┘ └─────────────────────────────────────┘
                    │                               │
                    └───────────────┬───────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────┐
│  4. OPERATIONS & MAINTENANCE                                        │
│                                                                     │
│  • Monitoring & Observability                                       │
│  • Incident Response                                                │
│  • Backup & Recovery                                                │
│  • Security Audits                                                  │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Agent-to-Procedure Mapping

| Agent | Primary Procedures | Secondary Procedures |
|-------|-------------------|---------------------|
| **Onboard-Master** | Multi-Client Onboarding | Production Preparation (approval) |
| **GitHub-Branch-Manager** | GitHub Workflow | Multi-Client Onboarding |
| **Render-Service-Manager** | Render Deployment | Multi-Client Onboarding |
| **Client-Config-Manager** | Configuration (all) | Multi-Client Onboarding |
| **Deployment-Orchestrator** | Render Deployment | GitHub Workflow |
| **DevOps-Engineer** | GitHub Workflow | Production Preparation |
| **Tenant-Manager** | Production Preparation | Multi-Client Onboarding |
| **Data-Guardian** | Production Preparation | - |
| **Onboarding-Coordinator** | Multi-Client Onboarding | - |
| **Security-Specialist** | Security Audits | - |
| **Analytics-Specialist** | Performance Testing | - |

---

## Quick Reference: Starting Points

| Scenario | Start With | Procedure |
|----------|-----------|----------|
| New client onboarding | Multi-Client Onboarding | `saasforge-multi-client-onboarding-procedure.md` |
| Setting up Render for existing client | Render Deployment | `saasforge-render-deployment-procedure.md` |
| Setting up GitHub for new client | GitHub Workflow | `saasforge-github-workflow-procedure.md` |
| Preparing an app for production | Production Preparation | `saasforge-production-preparation-procedure.md` |
| Managing deployments | Render Deployment | `saasforge-render-deployment-procedure.md` |
| Handling incidents | Production Operations | `../production-operations.md` |

---

## Document Maintenance

### Version Control
- All procedures include version history
- Quarterly review cycle
- Updates tracked with date and change summary

### Cross-Reference Updates
When updating a procedure:
1. Update version history
2. Check cross-references in this index
3. Update related procedure sections
4. Notify affected teams

### Review Schedule
| Procedure | Review Cycle | Owner |
|-----------|-------------|-------|
| Production Preparation | Quarterly | DevOps-Engineer |
| Render Deployment | Quarterly | Render-Service-Manager |
| GitHub Workflow | Quarterly | GitHub-Branch-Manager |
| Multi-Client Onboarding | Quarterly | Onboarding-Coordinator |
| Master Index | Monthly | Onboard-Master |

---

## Support & Escalation

### Questions
- **Operations**: Post in `#saasforge-operations` Slack channel
- **Technical**: Post in `#saasforge-technical` Slack channel
- **Urgent**: Page on-call engineer via PagerDuty

### Procedure Updates
- Propose changes via GitHub PR
- Review by procedure owner
- Approval by Onboard-Master
- Merge and notify teams

---

**Document Owner**: SaaSForge AI Operations Team
**Review Cycle**: Monthly
**Last Updated**: 2026-04-16
**Version**: 1.0
