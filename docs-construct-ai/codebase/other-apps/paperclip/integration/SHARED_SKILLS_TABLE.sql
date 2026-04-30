-- =====================================================
-- Shared Skills Table
-- For skills that are not company-specific
-- =====================================================

-- Create the shared_skills table
CREATE TABLE IF NOT EXISTS shared_skills (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  key text NOT NULL,
  slug text NOT NULL,
  name text NOT NULL,
  description text,
  markdown text NOT NULL,
  source_type text NOT NULL DEFAULT 'local_path',
  source_locator text,
  trust_level text NOT NULL DEFAULT 'markdown_only',
  compatibility text NOT NULL DEFAULT 'compatible',
  file_inventory jsonb NOT NULL DEFAULT '[]'::jsonb,
  metadata jsonb,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  updated_at timestamp with time zone NOT NULL DEFAULT now(),
  PRIMARY KEY (id),
  UNIQUE (key)
);

-- Disable RLS for service_role access
ALTER TABLE shared_skills DISABLE ROW LEVEL SECURITY;

-- Grant permissions
GRANT ALL ON shared_skills TO service_role;
GRANT ALL ON shared_skills TO authenticated;
GRANT ALL ON shared_skills TO anon;

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_shared_skills_key ON shared_skills(key);
CREATE INDEX IF NOT EXISTS idx_shared_skills_slug ON shared_skills(slug);