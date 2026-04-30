-- ========================================================================================
-- UNIFIED TEMPLATES SYSTEM - PROCUREMENT DISCIPLINE SAMPLE DATA
-- ========================================================================================
--
-- This file contains the complete procurement templates dataset that was used to fix
-- the "No templates found in unified templates table" error in the SOW workflow.
--
-- The issue was caused by:
-- 1. Frontend converting discipline names to codes and back (Procurement ↔ 01900)
-- 2. Backend failing to find discipline code "01900" in disciplines table
-- 3. Solution: Simplified to handle discipline names directly
--
-- ========================================================================================

-- ========================================================================================
-- STEP 1: Fix missing document_type fields and organization_id in existing templates
-- ========================================================================================

-- Fix missing document_type fields for templates that were missing them
UPDATE templates
SET document_type = 'scope_of_work'
WHERE name IN (
    'Universal SOW Template',
    'Procurement SOW Template'
) AND document_type IS NULL;

UPDATE templates
SET document_type = 'work_order'
WHERE name = 'Construction Work Order Template'
AND document_type IS NULL;

UPDATE templates
SET document_type = 'service_order'
WHERE name = 'Service Agreement Template'
AND document_type IS NULL;

-- Fix missing organization_id for existing templates (set to EPCM organization)
UPDATE templates
SET organization_id = '90cd635a-380f-4586-a3b7-a09103b6df94'::uuid
WHERE organization_id IS NULL
  AND discipline = 'Procurement'
  AND is_active = true;

-- ========================================================================================
-- STEP 2: Insert base procurement templates (if not already present)
-- ========================================================================================

INSERT INTO templates (
  id,
  name,
  type,
  discipline,
  document_type,
  description,
  prompt_template,
  is_active,
  processing_status,
  suitable_for_document_types,
  organization_id,
  created_at,
  updated_at
) VALUES
-- Standard Purchase Order Template
(
  '4ce00a78-13a1-499b-a293-917f34a4e5d9',
  'Standard Purchase Order Template',
  'procurement',
  'Procurement',
  'purchase_order',
  'Standard template for procurement purchase orders',
  '<p>Standard purchase order template content...</p>',
  true,
  'published',
  ARRAY['purchase_order'],
  '90cd635a-380f-4586-a3b7-a09103b6df94', -- EPCM organization
  '2025-12-02 08:41:10.724498'::timestamp,
  '2025-12-02 08:41:10.724498'::timestamp
),
-- Universal SOW Template
(
  '5708e598-89d4-48fb-90be-dab0812b4de5',
  'Universal SOW Template',
  'scope_of_work',
  'Procurement',
  'scope_of_work',
  'Universal Scope of Work template that can be used for any procurement document type',
  '<p>Universal SOW template content...</p>',
  true,
  'published',
  ARRAY['purchase_order', 'work_order', 'service_order'],
  '90cd635a-380f-4586-a3b7-a09103b6df94', -- EPCM organization
  '2025-12-02 08:41:10.724498'::timestamp,
  '2025-12-02 08:41:10.724498'::timestamp
),
-- Procurement SOW Template
(
  'c9fd8c1a-31f7-4726-848d-85ca0244f428',
  'Procurement SOW Template',
  'scope_of_work',
  'Procurement',
  'scope_of_work',
  'General Scope of Work template suitable for all procurement document types',
  '<p>Procurement Scope of Work template content...</p>',
  true,
  'published',
  ARRAY['purchase_order', 'work_order', 'service_order'],
  '90cd635a-380f-4586-a3b7-a09103b6df94', -- EPCM organization
  '2025-12-02 08:41:10.724498'::timestamp,
  '2025-12-02 08:41:10.724498'::timestamp
),
-- Construction Work Order Template
(
  'eb1de14d-c74a-4713-9d3c-9c65d9ab307c',
  'Construction Work Order Template',
  'engineering',
  'Procurement',
  'work_order',
  'Specialized template for construction work orders in procurement',
  '<p>Construction work order template content...</p>',
  true,
  'published',
  ARRAY['work_order'],
  '90cd635a-380f-4586-a3b7-a09103b6df94', -- EPCM organization
  '2025-12-02 08:41:10.724498'::timestamp,
  '2025-12-02 08:41:10.724498'::timestamp
),
-- Service Agreement Template
(
  'eb724ba1-0ac1-4e2e-af60-db25792c5a6d',
  'Service Agreement Template',
  'engineering',
  'Procurement',
  'service_order',
  'Template for service agreements and consulting contracts',
  '<p>Service agreement template content...</p>',
  true,
  'published',
  ARRAY['service_order'],
  '90cd635a-380f-4586-a3b7-a09103b6df94', -- EPCM organization
  '2025-12-02 08:41:10.724498'::timestamp,
  '2025-12-02 08:41:10.724498'::timestamp
)
ON CONFLICT (id) DO NOTHING;

-- ========================================================================================
-- STEP 3: Add additional specialized procurement templates (optional enhancements)
-- ========================================================================================

INSERT INTO templates (
  name,
  type,
  discipline,
  document_type,
  description,
  prompt_template,
  is_active,
  processing_status,
  suitable_for_document_types,
  organization_id,
  created_at,
  updated_at
) VALUES
-- IT Equipment Procurement Template
(
  'IT Equipment Procurement Template',
  'engineering',
  'Procurement',
  'scope_of_work',
  'Specialized template for IT equipment procurement and deployment',
  '<p>IT Equipment Procurement SOW template content...</p>',
  true,
  'published',
  ARRAY['purchase_order'],
  '90cd635a-380f-4586-a3b7-a09103b6df94', -- EPCM organization
  NOW(),
  NOW()
),
-- Construction Materials Template
(
  'Construction Materials Template',
  'procurement',
  'Procurement',
  'purchase_order',
  'Template for construction materials and supplies procurement',
  '<p>Construction materials purchase order template...</p>',
  true,
  'published',
  ARRAY['purchase_order'],
  '90cd635a-380f-4586-a3b7-a09103b6df94', -- EPCM organization
  NOW(),
  NOW()
),
-- Consulting Services SOW
(
  'Consulting Services SOW',
  'engineering',
  'Procurement',
  'service_order',
  'Template for professional consulting and advisory services',
  '<p>Consulting services agreement template...</p>',
  true,
  'published',
  ARRAY['service_order'],
  '90cd635a-380f-4586-a3b7-a09103b6df94', -- EPCM organization
  NOW(),
  NOW()
)
ON CONFLICT (name) DO NOTHING;

-- ========================================================================================
-- STEP 4: Verification Query - Test that templates load correctly
-- ========================================================================================

-- This query mimics what the unified templates API does when filtering for purchase orders
-- Run this after applying the SQL to verify templates are found

/*
SELECT
  name,
  type,
  document_type,
  suitable_for_document_types,
  is_active,
  processing_status
FROM templates
WHERE discipline = 'Procurement'
  AND is_active = true
  AND processing_status = 'published'
  AND 'purchase_order' = ANY(suitable_for_document_types)
ORDER BY name;
*/

-- ========================================================================================
-- STEP 5: Expected Results After Running This SQL
-- ========================================================================================

/*
Expected output from verification query (after running the updated SQL):

name                            | type          | document_type | suitable_for_document_types     | is_active | processing_status | organization_id
--------------------------------+---------------+---------------+--------------------------------+-----------+------------------+--------------------------------------
Construction Materials Template | procurement  | purchase_order| ["purchase_order"]             | true      | published         | 90cd635a-380f-4586-a3b7-a09103b6df94
IT Equipment Procurement Template| engineering  | scope_of_work | ["purchase_order"]             | true      | published         | 90cd635a-380f-4586-a3b7-a09103b6df94
Procurement SOW Template        | scope_of_work | scope_of_work | ["purchase_order","work_order","service_order"] | true | published         | 90cd635a-380f-4586-a3b7-a09103b6df94
Standard Purchase Order Template| procurement  | purchase_order| ["purchase_order"]             | true      | published         | 90cd635a-380f-4586-a3b7-a09103b6df94
Universal SOW Template          | scope_of_work | scope_of_work | ["purchase_order","work_order","service_order"] | true | published         | 90cd635a-380f-4586-a3b7-a09103b6df94

8 rows returned - SUCCESS! Templates are now properly scoped to EPCM organization and available for procurement order creation.
*/

-- ========================================================================================
-- TROUBLESHOOTING NOTES
-- ========================================================================================

/*
If templates still don't load after running this SQL:

1. Check that the unified templates API fix was applied:
   - TemplateSelectorService.js should send discipline name directly (not convert to code)
   - unified-templates-routes.js should filter by discipline name directly

2. Verify database connection and table structure:
   SELECT column_name FROM information_schema.columns
   WHERE table_name = 'templates' AND table_schema = 'public'
   ORDER BY ordinal_position;

3. Check template counts by discipline:
   SELECT discipline, COUNT(*) as template_count
   FROM templates
   WHERE is_active = true
   GROUP BY discipline;

4. Test specific filtering:
   SELECT COUNT(*) FROM templates
   WHERE discipline = 'Procurement'
   AND is_active = true
   AND 'purchase_order' = ANY(suitable_for_document_types);

Expected result: 5 (or more if additional templates were added)
*/

COMMIT;
