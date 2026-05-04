---
title: Local Content Agent Architectural Knowledge
description: Comprehensive architectural knowledge of local content system design, database schemas, API patterns, and compliance frameworks for local content agents
author: KnowledgeForge AI
version: 1.0
memory_layer: durable_knowledge
para_section: docs_paperclip/disciplines/01600-local-content
gigabrain_tags: knowledgeforge-ai, local-content-agent, local-content-architecture, system-design, compliance-frameworks
openstinger_context: local-content-agent-architecture, local-content-system-design
last_updated: 2026-05-18
related_docs:
  - docs-construct-ai/disciplines/01600_Local_Content/agent-data/domain-knowledge/01600_DOMAIN-KNOWLEDGE.MD
  - docs-construct-ai/disciplines/01600_Local_Content/01600-local-content-page-documentation.md
  - docs-paperclip/companies/knowledgeforge-ai/skills/local-content-knowledgeforge/SKILL.md
---

# Local Content Agent Architectural Knowledge

## Overview

This document provides comprehensive architectural knowledge of the local content system design, covering local employment tracking, procurement management, enterprise development, skills transfer, and compliance reporting. The local content system ensures regulatory compliance with local content requirements, promotes local economic development, and maintains auditable records for all local content activities.

**Purpose**: Enable agents to implement local content management systems that track employment localisation, local procurement spend, enterprise development programs, skills transfer initiatives, and generate compliance reports aligned with IFC PS1 standards.

---

## Part 1: Local Content Domain Model

### 1.1 Core Domain Entities

#### Local Employment
- **LocalEmployee** — id, employeeId, name, nationality, localStatus, jobTitle, department, employmentDate, localisationTarget, mentorId, skillsMatrix, trainingRecords
- **LocalisationTarget** — id, departmentId, role, currentLocalPercentage, targetPercentage, targetDate, status
- **WorkforceRecord** — id, reportingPeriod, totalHeadcount, localHeadcount, foreignHeadcount, localPercentage, departments

#### Local Procurement
- **LocalProcurementRecord** — id, procurementId, supplierId, supplierType (local/foreign), contractValue, localSpend, category, projectId, reportingPeriod
- **LocalSupplier** — id, supplierId, name, registrationNumber, localStatus, ownershipType, certificationLevel, spendHistory
- **ProcurementSpendReport** — id, period, totalSpend, localSpend, localPercentage, categories

#### Enterprise Development
- **EnterpriseProgram** — id, programId, name, type (enterprise/supplier), startDate, endDate, budget, participants, status
- **EnterpriseParticipant** — id, programId, businessId, name, sector, stage, supportProvided, milestones
- **SupplierDevelopmentPlan** — id, supplierId, planType, objectives, timeline, kpis, status

#### Skills Transfer
- **SkillsTransferPlan** — id, planId, title, department, skillCategory, targetGroup, methodology, duration, budget
- **TrainingRecord** — id, employeeId, trainingId, completionDate, certificateId, competencyAssessment, verifiedBy
- **SkillsGapAnalysis** — id, departmentId, role, requiredSkills, currentSkills, gapScore, priority

#### Compliance & Reporting
- **LocalContentReport** — id, reportId, reportingPeriod, type (monthly/quarterly/annual), status, submittedDate, approvedBy
- **ComplianceChecklist** — id, regulationId, requirement, status, evidence, dueDate, owner
- **AuditTrail** — id, entityType, entityId, action, timestamp, userId, changes

### 1.2 Database Schema

```sql
-- Core local employment table
CREATE TABLE local_employees (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  employee_id VARCHAR(20) UNIQUE NOT NULL,
  full_name VARCHAR(255) NOT NULL,
  nationality VARCHAR(100) NOT NULL,
  local_status VARCHAR(20) NOT NULL CHECK (local_status IN ('local', 'expat', 'regional')),
  job_title VARCHAR(255),
  department VARCHAR(255),
  employment_date DATE NOT NULL,
  localisation_target_id UUID REFERENCES localisation_targets(id),
  mentor_id UUID REFERENCES local_employees(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  company_id UUID REFERENCES companies(id)
);

-- Localisation targets
CREATE TABLE localisation_targets (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  department VARCHAR(255) NOT NULL,
  role VARCHAR(255) NOT NULL,
  current_local_percentage DECIMAL(5,2) NOT NULL,
  target_percentage DECIMAL(5,2) NOT NULL,
  target_date DATE NOT NULL,
  status VARCHAR(20) DEFAULT 'active',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Local procurement records
CREATE TABLE local_procurement_records (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  procurement_id VARCHAR(20) UNIQUE NOT NULL,
  supplier_id UUID REFERENCES local_suppliers(id),
  supplier_type VARCHAR(20) NOT NULL CHECK (supplier_type IN ('local', 'foreign', 'joint_venture')),
  contract_value DECIMAL(15,2) NOT NULL,
  local_spend DECIMAL(15,2) NOT NULL,
  category VARCHAR(255),
  project_id UUID REFERENCES projects(id),
  reporting_period DATE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enterprise development programs
CREATE TABLE enterprise_programs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  program_id VARCHAR(20) UNIQUE NOT NULL,
  name VARCHAR(255) NOT NULL,
  program_type VARCHAR(50) NOT NULL CHECK (program_type IN ('enterprise_development', 'supplier_development', 'skills_transfer')),
  start_date DATE NOT NULL,
  end_date DATE,
  budget DECIMAL(15,2),
  status VARCHAR(20) DEFAULT 'active',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Skills transfer records
CREATE TABLE skills_transfer_records (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  employee_id UUID REFERENCES local_employees(id),
  skill_category VARCHAR(100) NOT NULL,
  training_program VARCHAR(255) NOT NULL,
  completion_date DATE,
  certificate_id VARCHAR(50),
  competency_score DECIMAL(5,2),
  verified_by UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Compliance reports
CREATE TABLE local_content_reports (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  report_id VARCHAR(20) UNIQUE NOT NULL,
  reporting_period DATE NOT NULL,
  report_type VARCHAR(20) NOT NULL CHECK (report_type IN ('monthly', 'quarterly', 'annual')),
  status VARCHAR(20) DEFAULT 'draft',
  submitted_date TIMESTAMPTZ,
  approved_by UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Row Level Security
ALTER TABLE local_employees ENABLE ROW LEVEL SECURITY;
ALTER TABLE localisation_targets ENABLE ROW LEVEL SECURITY;
ALTER TABLE local_procurement_records ENABLE ROW LEVEL SECURITY;
ALTER TABLE enterprise_programs ENABLE ROW LEVEL SECURITY;
ALTER TABLE skills_transfer_records ENABLE ROW LEVEL SECURITY;
ALTER TABLE local_content_reports ENABLE ROW LEVEL SECURITY;

-- RLS Policies
CREATE POLICY "local_employees_company_access" ON local_employees
  FOR ALL USING (company_id IN (
    SELECT company_id FROM user_company_access WHERE user_id = auth.uid()
  ));
```

### 1.3 Key Business Rules

- Local employment percentage must meet or exceed regulatory targets per department
- Local procurement spend must be tracked and reported as percentage of total procurement
- Enterprise development programs must have measurable KPIs and milestone tracking
- Skills transfer plans must include competency verification and certification
- Compliance reports must be submitted within regulatory deadlines
- All local content data must be auditable with complete change history

---

## Part 2: Local Content API Architecture

### 2.1 RESTful API Design

**Base URL**: `/api/local-content`
**Authentication**: JWT Bearer tokens with role-based permissions
**Versioning**: URL-based versioning (`/api/v1/local-content`)

#### Core API Endpoints

**Employment Management**:
```
GET    /api/v1/local-content/employees           — List local employees with filtering
POST   /api/v1/local-content/employees           — Create employee record
PUT    /api/v1/local-content/employees/{id}      — Update employee details
GET    /api/v1/local-content/localisation-targets — List localisation targets
POST   /api/v1/local-content/localisation-targets — Create localisation target
GET    /api/v1/local-content/workforce-stats     — Workforce localisation statistics
```

**Procurement Management**:
```
GET    /api/v1/local-content/procurement         — List local procurement records
POST   /api/v1/local-content/procurement         — Create procurement record
GET    /api/v1/local-content/suppliers           — List local suppliers
POST   /api/v1/local-content/suppliers           — Register local supplier
GET    /api/v1/local-content/procurement-spend   — Procurement spend analytics
```

**Enterprise Development**:
```
GET    /api/v1/local-content/enterprise-programs  — List enterprise programs
POST   /api/v1/local-content/enterprise-programs  — Create enterprise program
GET    /api/v1/local-content/participants         — List program participants
POST   /api/v1/local-content/participants         — Add participant to program
GET    /api/v1/local-content/supplier-development — List supplier development plans
```

**Skills Transfer**:
```
GET    /api/v1/local-content/skills-plans         — List skills transfer plans
POST   /api/v1/local-content/skills-plans         — Create skills transfer plan
GET    /api/v1/local-content/training-records     — List training records
POST   /api/v1/local-content/training-records     — Record training completion
GET    /api/v1/local-content/skills-gap-analysis  — Skills gap analysis
```

**Compliance & Reporting**:
```
GET    /api/v1/local-content/reports              — List compliance reports
POST   /api/v1/local-content/reports              — Generate compliance report
GET    /api/v1/local-content/compliance-checklist — Compliance checklist
POST   /api/v1/local-content/compliance-verify    — Verify compliance item
GET    /api/v1/local-content/audit-trail          — Query audit trail
```

### 2.2 API Security

- JWT authentication with role-based access control
- Roles: local_content_admin, local_content_manager, local_content_viewer
- Rate limiting: 100 requests per minute per user
- Input validation using Zod schemas
- SQL injection prevention via parameterized queries

---

## Part 3: Compliance & Regulatory Framework

### 3.1 IFC PS1 Compliance

- Environmental and Social Management System (ESMS) integration
- Stakeholder engagement and grievance mechanism
- Local content performance monitoring and reporting
- Community health, safety, and security considerations

### 3.2 Reporting Requirements

- Monthly local content reports: employment numbers, procurement spend, enterprise development progress
- Quarterly compliance reports: localisation targets vs actual, skills transfer metrics
- Annual local content performance review: comprehensive analysis with improvement plans
- Regulatory submissions: formatted per local content authority requirements

### 3.3 Audit Trail Requirements

- All local content data modifications must be logged with before/after values
- Audit logs must be tamper-proof with cryptographic verification
- Retention period: minimum 7 years per regulatory requirements
- Audit trail must support regulatory inspection and external audit

---

## Part 4: UI/UX Design Principles

### 4.1 Color Scheme

| Role | Color | Hex | Usage |
|------|-------|-----|-------|
| Primary | Local Blue | `#1565c0` | Headers, primary buttons, navigation |
| Success | Development Green | `#2e7d32` | Local content targets met, compliance passed |
| Warning | Compliance Gold | `#f9a825` | Pending compliance items, approaching targets |
| Danger | Alert Red | `#d32f2f` | Missed targets, compliance failures |
| Info | Skills Teal | `#00838f` | Skills transfer data, training information |

### 4.2 Screen States

Every local content screen supports four states:
1. **Loading** — Skeleton screens with local content themed placeholders
2. **Empty** — "No data" illustrations with guidance for first-time setup
3. **Error** — Error state with retry action and fallback procedures
4. **Data** — Full data presentation with real-time updates

### 4.3 Design Principles

1. **Compliance First** — Regulatory requirements drive UI priorities and data visibility
2. **Target Tracking** — Clear visual indicators of localisation targets vs actual performance
3. **Audit Ready** — All data presented with source verification and audit trail access
4. **Multi-Platform** — Consistent experience across desktop, mobile, and web
5. **Role-Based Views** — Tailored interfaces for local content officers, managers, and administrators
