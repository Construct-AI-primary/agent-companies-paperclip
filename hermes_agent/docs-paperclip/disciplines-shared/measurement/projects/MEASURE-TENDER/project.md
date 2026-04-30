---
title: "MEASURE-TENDER Project"
description: "Multi-Type Procurement Tender System - Parallel database architecture for builder sub-vendor, materials, services, and work order tendering with gov.za integration pattern"
gigabrain_tags: project, measurement, tender, subcontract, materials, services, purchase-order, work-order, builder-procurement, integration, parallel-tables
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER
last_updated: 2026-04-28
id: MEASURE-TENDER
status: planning
project_code: MEASURE-TENDER
parent_goal: MEASURE-ROOT-2026
discipline: Measurement — Procurement Tender System
lead_agents:
  - database-infraforge (InfraForge)
  - procurement-domainforge-procurement-contracts (DomainForge)
  - procurement-strategy-domainforge-procurement-strategy (DomainForge)
  - loopy-ai (Loopy AI)
cross_company:
  - company: infraforge-ai
    role: Database infrastructure, schema, API routes, RLS policies
  - company: domainforge-ai
    role: Integration service, UI domain logic, workflow orchestration, tender strategy
  - company: loopy-ai
    role: External portal public pages and admin dashboard execution
  - company: qualityforge-ai
    role: Cross-project coordination with PROCURE-TEST for UI component validation
---

# MEASURE-TENDER Project

## Overview

**Multi-Type Procurement Tender System** implementing Option B (parallel tables) for builder procurement tendering. This system supports **4 distinct procurement types**:

1. **Subcontracts** — Trade-specific subcontracts (electrical, plumbing, HVAC, structural steel, fire protection, civil works)
2. **Purchase Orders (PO)** — Materials and equipment procurement
3. **Service Orders (SO)** — Testing, inspection, commissioning, and consulting services
4. **Work Orders (WO)** — Internal labor and construction task management

Each procurement type follows the proven gov.za tender integration pattern while maintaining **strict security separation** via parallel tables.

## Project Rationale

### Why Option B (Parallel Tables)

Security analysis identified multiple risks with extending existing gov.za integration tables:

| Risk | Mitigation |
|------|------------|
| Credential bleeding between gov portals and sub-vendor portals | Separate credential storage per category |
| RLS policy leakage across tender types | Clean RLS from day 1 |
| Audit log confusion | Category-separated logging |
| Rate limit cross-contamination | Per-source metrics |
| API key scope mismatch (read-only vs read-write) | Separate encryption schemas |

## Architecture

### Reusable Components from gov.za System

The following patterns are **directly reusable** from the Multi-Source Tender Integration System (`01850_TENDER_INTEGRATION_SYSTEM.md`):

```
┌─────────────────────────────────────────────────────────────────────┐
│ REUSABLE PATTERNS (Same Architecture, Parallel Tables)              │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌──────────────┐      ┌──────────────┐      ┌──────────────┐      │
│  │ integration_ │ ──── │ sync_       │ ──── │ error_      │      │
│  │ sources      │      │ history      │      │ logs         │      │
│  └──────────────┘      └──────────────┘      └──────────────┘      │
│         │                     │                     │                 │
│         ▼                     ▼                     ▼                 │
│  ┌──────────────┐      ┌──────────────┐      ┌──────────────┐      │
│  │ integration_ │      │ metrics      │      │ notifications│      │
│  │ health       │      │              │      │              │      │
│  └──────────────┘      └──────────────┘      └──────────────┘      │
│                                                                     │
│  Service Layer: tender-integration-service.js pattern               │
│  API Routes: RESTful endpoints (/api/tender-integration/*)         │
│  Dashboard: React management interface                                │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│ NEW SUBCONTRACTOR TABLES (Parallel Architecture)                    │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌──────────────────┐   ┌─────────────────┐   ┌────────────────┐     │
│  │ subcontract_     │   │ subcontract_rfq_ │   │ subcontract_   │     │
│  │ portal_sources   │   │ sync_history    │   │ rfq_error_logs│     │
│  └──────────────────┘   └─────────────────┘   └────────────────┘     │
│         │                    │                    │                 │
│         ▼                    ▼                    ▼                 │
│  ┌──────────────────┐   ┌─────────────────┐   ┌────────────────┐     │
│  │ subcontract_rfqs │   │ subcontractor_   │   │ quotation_      │     │
│  │                  │   │ prequalification│   │ comparisons    │     │
│  └──────────────────┘   └─────────────────┘   └────────────────┘     │
│                                                                     │
│  Service Layer: subcontract-integration-service.js (NEW)             │
│  API Routes: /api/subcontract-rfq/* (NEW)                           │
│  Dashboard: Sub-vendor Portal Manager (NEW)                           │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### Procurement Type Architecture

Each procurement type uses the same table structure with `tender_type` discriminator:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        PROCUREMENT TYPE FLOW                             │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │              MEASURE-TENDER UNIFIED PLATFORM                     │    │
│  └─────────────────────────────────────────────────────────────────┘    │
│                                    │                                      │
│            ┌───────────────────────┼───────────────────────┐            │
│            │                       │                       │            │
│            ▼                       ▼                       ▼            │
│  ┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐   │
│  │   SUBCONTRACTS   │    │  PURCHASE ORDERS │    │  SERVICE ORDERS  │   │
│  │   (BUILDER-MEAS- │    │   (BUILDER-MEAS- │    │   (BUILDER-MEAS- │   │
│  │    009 to 013)   │    │    001 to 004)   │    │    003)         │   │
│  └────────┬─────────┘    └────────┬─────────┘    └────────┬─────────┘   │
│           │                        │                        │            │
│           └────────────────────────┼────────────────────────┘            │
│                                    ▼                                     │
│                         ┌──────────────────┐                            │
│                         │ WORK ORDERS (WO)  │                            │
│                         │ (BUILDER-MEAS-004) │                           │
│                         └──────────────────┘                            │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### Procurement Type Definitions

| Type | Code | Description | BUILDER-MEAS | Key Fields |
|------|------|-------------|--------------|------------|
| **Subcontracts** | `SUBCON` | Trade-specific works (electrical, plumbing, HVAC, steel, fire, civil) | 009, 010, 011, 012, 013 | `trade_category`, `cidb_grading`, `scope_of_works` |
| **Purchase Orders** | `PO` | Materials and equipment procurement | 001, 002, 003, 004 | `material_category`, `supplier_type`, `delivery_terms` |
| **Service Orders** | `SO` | Testing, inspection, commissioning, consulting | 003 | `service_type`, `provider_category`, `certification_required` |
| **Work Orders** | `WO` | Internal labor and construction tasks | 004 | `task_type`, `labor_category`, `internal_resource` |

### Tender Type Codes

All RFQs include a `tender_type` field to discriminate between procurement types:

```javascript
const TENDER_TYPES = {
  SUBCON: 'subcontract',  // Trade subcontracts (electrical, plumbing, HVAC, etc.)
  PO: 'purchase_order',    // Materials and equipment
  SO: 'service_order',      // Testing, inspection, commissioning
  WO: 'work_order'          // Internal labor and tasks
};

const TRADE_CATEGORIES = {
  SUBCON: ['electrical', 'plumbing', 'hvac', 'structural_steel', 'fire_protection', 'civil_works', 'landscaping', 'painting', 'glazing', 'acoustic'],
  PO: ['structural_materials', 'architectural_finishes', 'mep_equipment', 'civil_materials', 'specialty_products', 'consumables'],
  SO: ['testing_services', 'inspection_services', 'commissioning_services', 'consulting_services', 'maintenance_services'],
  WO: ['site_preparation', 'concrete_works', 'steel_works', 'finishing_works', 'general_labour']
};
```

### Database Schema

#### Parallel Tables (Security-Separated)

```sql
-- =====================================================================
-- MULTI-TYPE PROCUREMENT TENDER TABLES (Option B - Parallel)
-- Security-segregated from gov.za integration tables
-- Supports: SUBCON, PO, SO, WO tender types
-- =====================================================================

-- 1. Portal Sources Configuration
CREATE TABLE procurement_portal_sources (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  source_id VARCHAR(50) UNIQUE NOT NULL,
  name VARCHAR(100) NOT NULL,
  tender_type VARCHAR(20) NOT NULL,  -- 'subcontract', 'purchase_order', 'service_order', 'work_order'
  integration_type VARCHAR(20) NOT NULL,  -- 'api', 'email', 'portal', 'manual'
  base_url TEXT,
  credentials_encrypted TEXT,  -- Separate encryption from gov portals
  sync_interval_minutes INT DEFAULT 60,
  rate_limit_per_minute INT DEFAULT 30,
  timeout_seconds INT DEFAULT 30,
  last_sync_at TIMESTAMP,
  last_sync_status VARCHAR(20),
  status VARCHAR(20) DEFAULT 'active',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- 2. RFQ Sync History
CREATE TABLE subcontract_rfq_sync_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  source_id VARCHAR(50) NOT NULL,
  sync_type VARCHAR(20) NOT NULL,  -- 'full', 'incremental', 'manual'
  records_processed INT DEFAULT 0,
  records_added INT DEFAULT 0,
  records_updated INT DEFAULT 0,
  records_failed INT DEFAULT 0,
  duration_seconds INT,
  status VARCHAR(20) NOT NULL,  -- 'success', 'partial', 'failed'
  error_message TEXT,
  started_at TIMESTAMP NOT NULL,
  completed_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);

-- 3. RFQ Error Logs
CREATE TABLE subcontract_rfq_error_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  source_id VARCHAR(50),
  operation VARCHAR(50) NOT NULL,
  error_type VARCHAR(50),
  error_message TEXT,
  stack_trace TEXT,
  retry_count INT DEFAULT 0,
  resolved_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);

-- 4. Subcontractor RFQs (Main Tender Data)
CREATE TABLE subcontract_rfqs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  source_id VARCHAR(50),
  rfq_number VARCHAR(50) UNIQUE NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  trade_category VARCHAR(50) NOT NULL,  -- 'electrical', 'plumbing', 'hvac', etc.
  scope_of_works TEXT,
  specifications TEXT,
  cidb_grading_required VARCHAR(10),
  estimated_value DECIMAL(15,2),
  currency VARCHAR(3) DEFAULT 'ZAR',
  closing_date TIMESTAMP,
  validity_period_days INT DEFAULT 30,
  status VARCHAR(30) DEFAULT 'draft',  -- 'draft', 'published', 'closed', 'awarded', 'cancelled'
  bids_received INT DEFAULT 0,
  best_bid_id UUID,
  procurement_officer_id UUID REFERENCES users(id),
  project_reference VARCHAR(100),
  boq_reference_id UUID,  -- Links to BOQ from BUILDER-MEAS-009
  external_reference TEXT,  -- Sub-vendor portal reference
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- 5. Subcontractor Prequalification
CREATE TABLE subcontractor_prequalification (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  subcontractor_name VARCHAR(200) NOT NULL,
  trade_categories TEXT[] NOT NULL,  -- Array of trade categories
  cidb_grading VARCHAR(10),
  bbbee_level VARCHAR(5),
  insurance_expiry DATE,
  safety_certification VARCHAR(50),
  tax_clearance VARCHAR(50),
  bank_details_encrypted TEXT,
  contact_email VARCHAR(255),
  contact_phone VARCHAR(50),
  status VARCHAR(20) DEFAULT 'pending',  -- 'pending', 'approved', 'suspended', 'rejected'
  prequalified_by UUID REFERENCES users(id),
  prequalified_at TIMESTAMP,
  expiry_date DATE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- 6. Quotation Comparisons
CREATE TABLE quotation_comparisons (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  rfq_id UUID NOT NULL REFERENCES subcontract_rfqs(id),
  subcontractor_id UUID NOT NULL REFERENCES subcontractor_prequalification(id),
  quoted_amount DECIMAL(15,2),
  quoted_currency VARCHAR(3) DEFAULT 'ZAR',
  validity_period_days INT,
  programme_commitment TEXT,
  technical_score DECIMAL(5,2),
  commercial_score DECIMAL(5,2),
  overall_score DECIMAL(5,2),
  compliance_status VARCHAR(20),  -- 'compliant', 'non_compliant', 'partial'
  evaluation_notes TEXT,
  recommended_for_award BOOLEAN DEFAULT FALSE,
  evaluated_by UUID REFERENCES users(id),
  evaluated_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- =====================================================================
-- INDEXES
-- =====================================================================

CREATE INDEX idx_subcontract_portal_sources_org ON subcontract_portal_sources(organization_id);
CREATE INDEX idx_subcontract_portal_sources_status ON subcontract_portal_sources(status);
CREATE INDEX idx_subcontract_rfq_sync_history_org ON subcontract_rfq_sync_history(organization_id);
CREATE INDEX idx_subcontract_rfq_sync_history_source ON subcontract_rfq_sync_history(source_id);
CREATE INDEX idx_subcontract_rfq_error_logs_org ON subcontract_rfq_error_logs(organization_id);
CREATE INDEX idx_subcontract_rfq_error_logs_source ON subcontract_rfq_error_logs(source_id);
CREATE INDEX idx_subcontract_rfqs_org ON subcontract_rfqs(organization_id);
CREATE INDEX idx_subcontract_rfqs_status ON subcontract_rfqs(status);
CREATE INDEX idx_subcontract_rfqs_trade ON subcontract_rfqs(trade_category);
CREATE INDEX idx_subcontract_rfqs_boq_ref ON subcontract_rfqs(boq_reference_id);
CREATE INDEX idx_subcontractor_prequal_org ON subcontractor_prequalification(organization_id);
CREATE INDEX idx_subcontractor_prequal_status ON subcontractor_prequalification(status);
CREATE INDEX idx_subcontractor_prequal_trades ON subcontractor_prequalification USING GIN(trade_categories);
CREATE INDEX idx_quotation_comparisons_rfq ON quotation_comparisons(rfq_id);
CREATE INDEX idx_quotation_comparisons_sub ON quotation_comparisons(subcontractor_id);

-- =====================================================================
-- RLS POLICIES (Clean from Day 1 - No Cross-Contamination)
-- =====================================================================

ALTER TABLE subcontract_portal_sources ENABLE ROW LEVEL SECURITY;
ALTER TABLE subcontract_rfq_sync_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE subcontract_rfq_error_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE subcontract_rfqs ENABLE ROW LEVEL SECURITY;
ALTER TABLE subcontractor_prequalification ENABLE ROW LEVEL SECURITY;
ALTER TABLE quotation_comparisons ENABLE ROW LEVEL SECURITY;

-- Organization-scoped access only
CREATE POLICY "Users can manage their organization's portal sources"
  ON subcontract_portal_sources FOR ALL
  USING (organization_id = current_user_org());

CREATE POLICY "Users can view their organization's sync history"
  ON subcontract_rfq_sync_history FOR SELECT
  USING (organization_id = current_user_org());

CREATE POLICY "Users can view their organization's error logs"
  ON subcontract_rfq_error_logs FOR SELECT
  USING (organization_id = current_user_org());

CREATE POLICY "Users can manage their organization's RFQs"
  ON subcontract_rfqs FOR ALL
  USING (organization_id = current_user_org());

CREATE POLICY "Users can manage prequalified subcontractors"
  ON subcontractor_prequalification FOR ALL
  USING (organization_id = current_user_org());

CREATE POLICY "Users can view quotation comparisons"
  ON quotation_comparisons FOR SELECT
  USING (organization_id = current_user_org());
```

## Project Issues

### Project Structure

```
projects/MEASURE-TENDER/
├── project.md                    # This file
├── MEASURE-TENDER-implementation.md  # Consolidated implementation document
├── plan.md                       # 4-phase execution plan
├── knowledge/                    # Knowledge files
│   ├── AGENT-DELEGATION-MAP.md
│   ├── CROSS-COMPANY-RACI.md
│   └── HEARTBEAT-MONITORING-CONFIG.md
├── desktop/
│   └── issues/
│       ├── ISSUE-GENERATION-STATUS.md
│       └── MEASURE-TENDER-004-ui-dashboard.md
├── mobile/
│   └── issues/
├── web/
│   └── issues/
│       ├── MEASURE-TENDER-006-external-tender-portal.md
│       ├── MEASURE-TENDER-006a-public-portal.md
│       └── MEASURE-TENDER-006b-admin-dashboard.md
├── trigger/
│   └── issues/
└── shared/
    ├── .gitkeep
    └── issues/
        ├── MEASURE-TENDER-001-database-schema.md
        ├── MEASURE-TENDER-002-integration-service.md
        ├── MEASURE-TENDER-003-api-routes.md
        └── MEASURE-TENDER-005-workflow-integration.md
```

### Issue Summary

| Issue | Title | Platform | Priority | Story Points | Status |
|-------|-------|----------|----------|--------------|--------|
| [MEASURE-TENDER-001](./shared/issues/MEASURE-TENDER-001-database-schema.md) | Database Schema & RLS Policies | Shared | Critical | 13 | Backlog |
| [MEASURE-TENDER-002](./shared/issues/MEASURE-TENDER-002-integration-service.md) | Subcontract Integration Service | Shared | High | 21 | Backlog |
| [MEASURE-TENDER-003](./shared/issues/MEASURE-TENDER-003-api-routes.md) | API Routes & Authentication | Shared | High | 13 | Backlog |
| [MEASURE-TENDER-004](./desktop/issues/MEASURE-TENDER-004-ui-dashboard.md) | Sub-vendor Portal Manager UI | Desktop | Medium | 13 | Backlog |
| [MEASURE-TENDER-005](./shared/issues/MEASURE-TENDER-005-workflow-integration.md) | BUILDER-MEAS Workflow Integration | Shared | Critical | 21 | Backlog |
| [MEASURE-TENDER-006a](./web/issues/MEASURE-TENDER-006a-public-portal.md) | External Portal — Public Pages | Web | High | 13 | Backlog |
| [MEASURE-TENDER-006b](./web/issues/MEASURE-TENDER-006b-admin-dashboard.md) | External Portal — Admin Dashboard | Web | High | 21 | Backlog |

**Total Story Points**: 115

## Integration Points

### Links to Existing gov.za Tender Integration

| Component | Gov.za System | Subcontractor System |
|-----------|---------------|---------------------|
| Service Pattern | `tender-integration-service.js` | `subcontract-integration-service.js` |
| API Pattern | `/api/tender-integration/*` | `/api/subcontract-rfq/*` |
| Health Check | `/health` | `/health` |
| Sync Endpoint | `/sync` | `/sync` |
| Sources Config | `integration_sources` | `subcontract_portal_sources` |
| Sync History | `integration_sync_history` | `subcontract_rfq_sync_history` |
| Error Logs | `integration_error_logs` | `subcontract_rfq_error_logs` |

### Links to BUILDER-MEAS Workflows

| Workflow | Integration Point |
|----------|------------------|
| BUILDER-MEAS-009 | BOQ Disaggregation → `subcontract_rfqs.boq_reference_id` |
| BUILDER-MEAS-010 | Trade Package → `subcontract_rfqs.trade_category` |
| BUILDER-MEAS-011 | RFQ Generation → `subcontract_rfqs` (INSERT) |
| BUILDER-MEAS-012 | Quotation Collection → `quotation_comparisons` |
| BUILDER-MEAS-013 | Subcontract Award → `subcontract_rfqs.best_bid_id` |

## Security Principles

1. **Credential Isolation**: Subcontractor portal credentials encrypted separately from gov portal credentials
2. **RLS Enforced**: All tables have organization-scoped RLS policies
3. **Audit Trail**: Complete sync history with status tracking
4. **Error Recovery**: Retry logic with exponential backoff
5. **No Cross-Contamination**: Separate tables, separate metrics, separate logs

## Success Metrics

- [ ] All 6 parallel tables created with RLS policies
- [ ] Integration service operational with health monitoring
- [ ] API routes functional with authentication
- [ ] UI dashboard for portal source management
- [ ] Integration with BUILDER-MEAS workflows complete
- [ ] Security audit passed (no cross-tenant access)
- [ ] Performance targets met (<5s sync time per source)
- [ ] Cross-project coordination with PROCURE-TEST completed
- [ ] Parent goal MEASURE-ROOT-2026 closed successfully

---

**Document Version**: 1.1
**Last Updated**: 2026-04-28
**Project Lead**: MeasureForge AI / DomainForge AI
**Status**: Planning
