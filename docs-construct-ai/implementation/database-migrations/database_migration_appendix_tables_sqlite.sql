-- ================================================================
-- Appendix Components Database Migration Script (SQLite)
-- Generated: 2025-12-17T18:23:01Z
-- Purpose: Create enhanced database schema for appendix management
-- ================================================================

-- ================================================================
-- TABLE: appendix_materials
-- Purpose: Store appendix materials and content
-- ================================================================

CREATE TABLE IF NOT EXISTS appendix_materials (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  appendix_type TEXT NOT NULL CHECK (appendix_type IN ('d', 'e', 'f')),
  title TEXT NOT NULL,
  description TEXT,
  category TEXT,
  subcategory TEXT,
  priority TEXT DEFAULT 'medium' CHECK (priority IN ('low', 'medium', 'high', 'critical')),
  status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'in_review', 'approved', 'completed', 'cancelled', 'on_hold')),
  content TEXT,
  html_content TEXT,
  file_attachments TEXT DEFAULT '[]',
  estimated_hours INTEGER CHECK (estimated_hours >= 0),
  actual_hours INTEGER CHECK (actual_hours >= 0),
  due_date TEXT,
  completed_date TEXT,
  organization_id TEXT,
  project_id TEXT,
  procurement_order_id TEXT,
  created_by TEXT,
  updated_by TEXT,
  created_at TEXT DEFAULT (datetime('now')),
  updated_at TEXT DEFAULT (datetime('now'))
);

-- ================================================================
-- TABLE: appendix_assignments
-- Purpose: Manage user assignments to appendix materials
-- ================================================================

CREATE TABLE IF NOT EXISTS appendix_assignments (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  appendix_material_id TEXT NOT NULL REFERENCES appendix_materials(id) ON DELETE CASCADE,
  user_id TEXT NOT NULL REFERENCES user_management(user_id) ON DELETE CASCADE,
  assignment_type TEXT NOT NULL CHECK (assignment_type IN ('reviewer', 'contributor', 'approver', 'reviewer_lead')),
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'in_progress', 'completed', 'rejected', 'cancelled')),
  assigned_by TEXT REFERENCES user_management(user_id),
  assigned_at TEXT DEFAULT (datetime('now')),
  completed_at TEXT,
  notes TEXT,
  due_date TEXT,
  created_at TEXT DEFAULT (datetime('now')),
  updated_at TEXT DEFAULT (datetime('now')),
  UNIQUE(appendix_material_id, user_id, assignment_type)
);

-- ================================================================
-- TABLE: appendix_versions
-- Purpose: Track version history for appendix materials
-- ================================================================

CREATE TABLE IF NOT EXISTS appendix_versions (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  appendix_material_id TEXT NOT NULL REFERENCES appendix_materials(id) ON DELETE CASCADE,
  version_number INTEGER NOT NULL,
  content TEXT,
  html_content TEXT,
  change_summary TEXT,
  change_type TEXT DEFAULT 'update' CHECK (change_type IN ('create', 'update', 'approval', 'rejection')),
  created_by TEXT REFERENCES user_management(user_id),
  created_at TEXT DEFAULT (datetime('now')),
  UNIQUE(appendix_material_id, version_number)
);

-- ================================================================
-- TABLE: appendix_documents
-- Purpose: Store document references and metadata
-- ================================================================

CREATE TABLE IF NOT EXISTS appendix_documents (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  appendix_material_id TEXT NOT NULL REFERENCES appendix_materials(id) ON DELETE CASCADE,
  document_name TEXT NOT NULL,
  document_type TEXT,
  file_path TEXT,
  file_size INTEGER,
  mime_type TEXT,
  storage_bucket TEXT DEFAULT 'appendix-attachments',
  uploaded_by TEXT REFERENCES user_management(user_id),
  uploaded_at TEXT DEFAULT (datetime('now')),
  is_active BOOLEAN DEFAULT 1,
  created_at TEXT DEFAULT (datetime('now'))
);

-- ================================================================
-- ENHANCE EXISTING: sow_appendices
-- Purpose: Add missing columns to existing sow_appendices table
-- ================================================================

-- Check if sow_appendices table exists and add columns
CREATE TABLE IF NOT EXISTS sow_appendices_temp AS SELECT * FROM sow_appendices WHERE 1=0;

-- Add content columns if they don't exist
ALTER TABLE sow_appendices ADD COLUMN IF NOT EXISTS content TEXT;
ALTER TABLE sow_appendices ADD COLUMN IF NOT EXISTS html_content TEXT;
ALTER TABLE sow_appendices ADD COLUMN IF NOT EXISTS version INTEGER DEFAULT 1;
ALTER TABLE sow_appendices ADD COLUMN IF NOT EXISTS attachments TEXT DEFAULT '[]';
ALTER TABLE sow_appendices ADD COLUMN IF NOT EXISTS workflow_status TEXT DEFAULT 'draft';
ALTER TABLE sow_appendices ADD COLUMN IF NOT EXISTS completion_percentage INTEGER DEFAULT 0 CHECK (completion_percentage >= 0 AND completion_percentage <= 100);

-- ================================================================
-- INDEXES FOR PERFORMANCE
-- ================================================================

-- appendix_materials indexes
CREATE INDEX IF NOT EXISTS idx_appendix_materials_type ON appendix_materials(appendix_type);
CREATE INDEX IF NOT EXISTS idx_appendix_materials_status ON appendix_materials(status);
CREATE INDEX IF NOT EXISTS idx_appendix_materials_priority ON appendix_materials(priority);
CREATE INDEX IF NOT EXISTS idx_appendix_materials_organization ON appendix_materials(organization_id);
CREATE INDEX IF NOT EXISTS idx_appendix_materials_project ON appendix_materials(project_id);
CREATE INDEX IF NOT EXISTS idx_appendix_materials_procurement_order ON appendix_materials(procurement_order_id);
CREATE INDEX IF NOT EXISTS idx_appendix_materials_created_by ON appendix_materials(created_by);
CREATE INDEX IF NOT EXISTS idx_appendix_materials_due_date ON appendix_materials(due_date);
CREATE INDEX IF NOT EXISTS idx_appendix_materials_created_at ON appendix_materials(created_at);

-- appendix_assignments indexes
CREATE INDEX IF NOT EXISTS idx_appendix_assignments_material ON appendix_assignments(appendix_material_id);
CREATE INDEX IF NOT EXISTS idx_appendix_assignments_user ON appendix_assignments(user_id);
CREATE INDEX IF NOT EXISTS idx_appendix_assignments_type ON appendix_assignments(assignment_type);
CREATE INDEX IF NOT EXISTS idx_appendix_assignments_status ON appendix_assignments(status);
CREATE INDEX IF NOT EXISTS idx_appendix_assignments_due_date ON appendix_assignments(due_date);

-- appendix_versions indexes
CREATE INDEX IF NOT EXISTS idx_appendix_versions_material ON appendix_versions(appendix_material_id);
CREATE INDEX IF NOT EXISTS idx_appendix_versions_created_at ON appendix_versions(created_at);

-- appendix_documents indexes
CREATE INDEX IF NOT EXISTS idx_appendix_documents_material ON appendix_documents(appendix_material_id);
CREATE INDEX IF NOT EXISTS idx_appendix_documents_type ON appendix_documents(document_type);
CREATE INDEX IF NOT EXISTS idx_appendix_documents_uploaded_by ON appendix_documents(uploaded_by);

-- ================================================================
-- TRIGGERS FOR UPDATED_AT TIMESTAMP
-- ================================================================

-- Create function to update updated_at timestamp
CREATE TRIGGER IF NOT EXISTS update_appendix_materials_updated_at 
  AFTER UPDATE ON appendix_materials 
  FOR EACH ROW 
  BEGIN 
    UPDATE appendix_materials SET updated_at = datetime('now') WHERE id = NEW.id;
  END;

CREATE TRIGGER IF NOT EXISTS update_appendix_assignments_updated_at 
  AFTER UPDATE ON appendix_assignments 
  FOR EACH ROW 
  BEGIN 
    UPDATE appendix_assignments SET updated_at = datetime('now') WHERE id = NEW.id;
  END;

-- ================================================================
-- INITIAL DATA SEEDING (OPTIONAL)
-- ================================================================

-- Insert sample appendix categories for each type
INSERT OR IGNORE INTO appendix_materials (
  id, appendix_type, title, description, category, priority, status, organization_id, created_by
) VALUES (
  lower(hex(randomblob(16))), 'd', 'Training Program Template', 
  'Standard training program template for new employees', 'Training Programs', 'high', 'draft', 
  '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001'
);

INSERT OR IGNORE INTO appendix_materials (
  id, appendix_type, title, description, category, priority, status, organization_id, created_by
) VALUES (
  lower(hex(randomblob(16))), 'e', 'Shipping Documentation Template', 
  'Standard shipping documentation template', 'Shipping Documents', 'medium', 'draft',
  '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001'
);

INSERT OR IGNORE INTO appendix_materials (
  id, appendix_type, title, description, category, priority, status, organization_id, created_by
) VALUES (
  lower(hex(randomblob(16))), 'f', 'Packaging Specification Template', 
  'Standard packaging specification template', 'Packaging Requirements', 'medium', 'draft',
  '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001'
);

-- ================================================================
-- MIGRATION COMPLETE
-- ================================================================

-- Create a summary table to track migrations
CREATE TABLE IF NOT EXISTS migration_history (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  migration_name TEXT NOT NULL,
  executed_at TEXT DEFAULT (datetime('now')),
  status TEXT DEFAULT 'completed',
  notes TEXT
);

INSERT INTO migration_history (migration_name, status, notes) 
VALUES ('appendix_components_tables', 'completed', 'Created appendix_materials, appendix_assignments, appendix_versions, appendix_documents tables with indexes and triggers');
