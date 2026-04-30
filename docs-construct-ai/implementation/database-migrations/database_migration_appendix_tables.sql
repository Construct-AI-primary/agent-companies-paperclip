-- ================================================================
-- Appendix Components Database Migration Script
-- Generated: 2025-12-17T16:21:14Z
-- Purpose: Create enhanced database schema for appendix management
-- ================================================================

-- Enable UUID extension if not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ================================================================
-- TABLE: appendix_materials
-- Purpose: Store appendix materials and content
-- ================================================================

CREATE TABLE IF NOT EXISTS appendix_materials (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  appendix_type VARCHAR(50) NOT NULL CHECK (appendix_type IN ('d', 'e', 'f')),
  title VARCHAR(255) NOT NULL,
  description TEXT,
  category VARCHAR(100),
  subcategory VARCHAR(100),
  priority VARCHAR(20) DEFAULT 'medium' CHECK (priority IN ('low', 'medium', 'high', 'critical')),
  status VARCHAR(50) DEFAULT 'draft' CHECK (status IN ('draft', 'in_review', 'approved', 'completed', 'cancelled', 'on_hold')),
  content TEXT,
  html_content TEXT,
  file_attachments JSONB DEFAULT '[]'::jsonb,
  estimated_hours INTEGER CHECK (estimated_hours >= 0),
  actual_hours INTEGER CHECK (actual_hours >= 0),
  due_date TIMESTAMP WITH TIME ZONE,
  completed_date TIMESTAMP WITH TIME ZONE,
  organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
  project_id UUID REFERENCES projects(id) ON DELETE SET NULL,
  procurement_order_id UUID REFERENCES procurement_orders(id) ON DELETE SET NULL,
  created_by UUID REFERENCES user_management(user_id),
  updated_by UUID REFERENCES user_management(user_id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ================================================================
-- TABLE: appendix_assignments
-- Purpose: Manage user assignments to appendix materials
-- ================================================================

CREATE TABLE IF NOT EXISTS appendix_assignments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  appendix_material_id UUID REFERENCES appendix_materials(id) ON DELETE CASCADE,
  user_id UUID REFERENCES user_management(user_id) ON DELETE CASCADE,
  assignment_type VARCHAR(50) NOT NULL CHECK (assignment_type IN ('reviewer', 'contributor', 'approver', 'reviewer_lead')),
  status VARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending', 'in_progress', 'completed', 'rejected', 'cancelled')),
  assigned_by UUID REFERENCES user_management(user_id),
  assigned_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  completed_at TIMESTAMP WITH TIME ZONE,
  notes TEXT,
  due_date TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(appendix_material_id, user_id, assignment_type)
);

-- ================================================================
-- TABLE: appendix_versions
-- Purpose: Track version history for appendix materials
-- ================================================================

CREATE TABLE IF NOT EXISTS appendix_versions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  appendix_material_id UUID REFERENCES appendix_materials(id) ON DELETE CASCADE,
  version_number INTEGER NOT NULL,
  content TEXT,
  html_content TEXT,
  change_summary TEXT,
  change_type VARCHAR(50) DEFAULT 'update' CHECK (change_type IN ('create', 'update', 'approval', 'rejection')),
  created_by UUID REFERENCES user_management(user_id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(appendix_material_id, version_number)
);

-- ================================================================
-- TABLE: appendix_documents
-- Purpose: Store document references and metadata
-- ================================================================

CREATE TABLE IF NOT EXISTS appendix_documents (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  appendix_material_id UUID REFERENCES appendix_materials(id) ON DELETE CASCADE,
  document_name VARCHAR(255) NOT NULL,
  document_type VARCHAR(100),
  file_path TEXT,
  file_size INTEGER,
  mime_type VARCHAR(100),
  storage_bucket VARCHAR(100) DEFAULT 'appendix-attachments',
  uploaded_by UUID REFERENCES user_management(user_id),
  uploaded_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ================================================================
-- ENHANCE EXISTING: sow_appendices
-- Purpose: Add missing columns to existing sow_appendices table
-- ================================================================

DO $$
BEGIN
  -- Add content columns if they don't exist
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                WHERE table_name = 'sow_appendices' AND column_name = 'content') THEN
    ALTER TABLE sow_appendices ADD COLUMN content TEXT;
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                WHERE table_name = 'sow_appendices' AND column_name = 'html_content') THEN
    ALTER TABLE sow_appendices ADD COLUMN html_content TEXT;
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                WHERE table_name = 'sow_appendices' AND column_name = 'version') THEN
    ALTER TABLE sow_appendices ADD COLUMN version INTEGER DEFAULT 1;
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                WHERE table_name = 'sow_appendices' AND column_name = 'attachments') THEN
    ALTER TABLE sow_appendices ADD COLUMN attachments JSONB DEFAULT '[]'::jsonb;
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                WHERE table_name = 'sow_appendices' AND column_name = 'workflow_status') THEN
    ALTER TABLE sow_appendices ADD COLUMN workflow_status VARCHAR(50) DEFAULT 'draft';
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                WHERE table_name = 'sow_appendices' AND column_name = 'completion_percentage') THEN
    ALTER TABLE sow_appendices ADD COLUMN completion_percentage INTEGER DEFAULT 0 CHECK (completion_percentage >= 0 AND completion_percentage <= 100);
  END IF;
END $$;

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
-- ROW LEVEL SECURITY (RLS) POLICIES
-- ================================================================

-- Enable RLS on all new tables
ALTER TABLE appendix_materials ENABLE ROW LEVEL SECURITY;
ALTER TABLE appendix_assignments ENABLE ROW LEVEL SECURITY;
ALTER TABLE appendix_versions ENABLE ROW LEVEL SECURITY;
ALTER TABLE appendix_documents ENABLE ROW LEVEL SECURITY;

-- RLS Policies for appendix_materials
CREATE POLICY "Users can view appendix materials for their organization" ON appendix_materials
  FOR SELECT USING (
    organization_id IN (
      SELECT organization_id FROM user_organizations 
      WHERE user_id = auth.uid()
    )
  );

CREATE POLICY "Users can insert appendix materials for their organization" ON appendix_materials
  FOR INSERT WITH CHECK (
    organization_id IN (
      SELECT organization_id FROM user_organizations 
      WHERE user_id = auth.uid()
    )
    AND auth.uid() = created_by
  );

CREATE POLICY "Users can update appendix materials they created or are assigned to" ON appendix_materials
  FOR UPDATE USING (
    created_by = auth.uid() OR
    id IN (
      SELECT appendix_material_id FROM appendix_assignments 
      WHERE user_id = auth.uid()
    )
  );

CREATE POLICY "Users can delete appendix materials they created" ON appendix_materials
  FOR DELETE USING (created_by = auth.uid());

-- RLS Policies for appendix_assignments
CREATE POLICY "Users can view assignments for their organization" ON appendix_assignments
  FOR SELECT USING (
    appendix_material_id IN (
      SELECT id FROM appendix_materials WHERE organization_id IN (
        SELECT organization_id FROM user_organizations WHERE user_id = auth.uid()
      )
    )
  );

CREATE POLICY "Users can create assignments for materials in their organization" ON appendix_assignments
  FOR INSERT WITH CHECK (
    appendix_material_id IN (
      SELECT id FROM appendix_materials WHERE organization_id IN (
        SELECT organization_id FROM user_organizations WHERE user_id = auth.uid()
      )
    )
  );

CREATE POLICY "Users can update their own assignments" ON appendix_assignments
  FOR UPDATE USING (user_id = auth.uid() OR assigned_by = auth.uid());

-- RLS Policies for appendix_versions
CREATE POLICY "Users can view version history for materials they can access" ON appendix_versions
  FOR SELECT USING (
    appendix_material_id IN (
      SELECT id FROM appendix_materials WHERE organization_id IN (
        SELECT organization_id FROM user_organizations WHERE user_id = auth.uid()
      )
    )
  );

CREATE POLICY "Users can create versions for materials they can access" ON appendix_versions
  FOR INSERT WITH CHECK (
    appendix_material_id IN (
      SELECT id FROM appendix_materials WHERE organization_id IN (
        SELECT organization_id FROM user_organizations WHERE user_id = auth.uid()
      )
    )
  );

-- RLS Policies for appendix_documents
CREATE POLICY "Users can view documents for materials they can access" ON appendix_documents
  FOR SELECT USING (
    appendix_material_id IN (
      SELECT id FROM appendix_materials WHERE organization_id IN (
        SELECT organization_id FROM user_organizations WHERE user_id = auth.uid()
      )
    )
  );

CREATE POLICY "Users can upload documents for materials they can access" ON appendix_documents
  FOR INSERT WITH CHECK (
    appendix_material_id IN (
      SELECT id FROM appendix_materials WHERE organization_id IN (
        SELECT organization_id FROM user_organizations WHERE user_id = auth.uid()
      )
    )
    AND auth.uid() = uploaded_by
  );

-- ================================================================
-- TRIGGERS FOR UPDATED_AT TIMESTAMP
-- ================================================================

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply updated_at triggers
CREATE TRIGGER update_appendix_materials_updated_at 
  BEFORE UPDATE ON appendix_materials 
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_appendix_assignments_updated_at 
  BEFORE UPDATE ON appendix_assignments 
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ================================================================
-- INITIAL DATA SEEDING (OPTIONAL)
-- ================================================================

-- Insert sample appendix categories for each type
INSERT INTO appendix_materials (appendix_type, title, description, category, priority, status, organization_id, created_by) 
SELECT 
  'd' as appendix_type,
  'Training Program Template' as title,
  'Standard training program template for new employees' as description,
  'Training Programs' as category,
  'high' as priority,
  'draft' as status,
  o.id as organization_id,
  u.user_id as created_by
FROM organizations o, user_management u 
WHERE o.name = 'Organisations - EPCM' 
LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO appendix_materials (appendix_type, title, description, category, priority, status, organization_id, created_by) 
SELECT 
  'e' as appendix_type,
  'Shipping Documentation Template' as title,
  'Standard shipping documentation template' as description,
  'Shipping Documents' as category,
  'medium' as priority,
  'draft' as status,
  o.id as organization_id,
  u.user_id as created_by
FROM organizations o, user_management u 
WHERE o.name = 'Organisations - EPCM' 
LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO appendix_materials (appendix_type, title, description, category, priority, status, organization_id, created_by) 
SELECT 
  'f' as appendix_type,
  'Packaging Specification Template' as title,
  'Standard packaging specification template' as description,
  'Packaging Requirements' as category,
  'medium' as priority,
  'draft' as status,
  o.id as organization_id,
  u.user_id as created_by
FROM organizations o, user_management u 
WHERE o.name = 'Organisations - EPCM' 
LIMIT 1
ON CONFLICT DO NOTHING;

-- ================================================================
-- COMMENTS FOR DOCUMENTATION
-- ================================================================

COMMENT ON TABLE appendix_materials IS 'Main table for storing appendix materials and content';
COMMENT ON TABLE appendix_assignments IS 'User assignments to appendix materials with roles and status';
COMMENT ON TABLE appendix_versions IS 'Version history tracking for appendix materials';
COMMENT ON TABLE appendix_documents IS 'Document references and file attachments for appendix materials';

COMMENT ON COLUMN appendix_materials.appendix_type IS 'Type of appendix: d=Training Materials, e=Logistics Documents, f=Packing and Marking';
COMMENT ON COLUMN appendix_materials.category IS 'Category within the appendix type (e.g., Training Programs, Shipping Documents)';
COMMENT ON COLUMN appendix_materials.status IS 'Workflow status of the appendix material';
COMMENT ON COLUMN appendix_materials.file_attachments IS 'JSON array of attached files with metadata';

COMMENT ON COLUMN appendix_assignments.assignment_type IS 'Type of assignment: reviewer, contributor, approver, reviewer_lead';
COMMENT ON COLUMN appendix_assignments.status IS 'Status of the assignment: pending, in_progress, completed, rejected';

COMMENT ON COLUMN appendix_versions.change_type IS 'Type of change: create, update, approval, rejection';

-- ================================================================
-- MIGRATION COMPLETE
-- ================================================================

DO $$
BEGIN
  RAISE NOTICE 'Appendix components database migration completed successfully!';
  RAISE NOTICE 'Tables created: appendix_materials, appendix_assignments, appendix_versions, appendix_documents';
  RAISE NOTICE 'Enhanced: sow_appendices table';
  RAISE NOTICE 'RLS policies applied';
  RAISE NOTICE 'Indexes created for performance';
  RAISE NOTICE 'Sample data inserted (if organizations exist)';
END $$;
