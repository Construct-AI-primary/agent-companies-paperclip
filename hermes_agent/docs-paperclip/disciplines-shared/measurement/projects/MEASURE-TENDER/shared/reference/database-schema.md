---
title: "MEASURE-TENDER Database Schema Reference"
description: "Complete database schema for multi-type procurement tender system - parallel tables for SUBCON, PO, SO, WO"
gigabrain_tags: reference, measurement, tender, database-schema, supabase, rls, parallel-tables
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER/shared/reference
last_updated: 2026-04-25
---

# MEASURE-TENDER Database Schema Reference

Complete SQL schema for the 6 parallel tables supporting all 4 procurement types (SUBCON, PO, SO, WO).

## Table Overview

| Table | Purpose | RLS Policy |
|-------|---------|-----------|
| `procurement_portal_sources` | Portal/source configuration | Full CRUD (org) |
| `subcontract_rfq_sync_history` | Sync audit trail | Read-only (org) |
| `subcontract_rfq_error_logs` | Error tracking | Read-only (org) |
| `subcontract_rfqs` | Main RFQ tender data | Full CRUD (org) |
| `subcontractor_prequalification` | Subcontractor prequal records | Full CRUD (org) |
| `quotation_comparisons` | Bid comparison matrix | Read-only (org) |

## Full Schema

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

## Tender Type Codes

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

## RFQ Status Flow

```
draft → published → closed → awarded
  ↓        ↓          ↓         ↓
cancelled notifying evaluating active contract
```

---

**Reference Version**: 1.0
**Last Updated**: 2026-04-25
