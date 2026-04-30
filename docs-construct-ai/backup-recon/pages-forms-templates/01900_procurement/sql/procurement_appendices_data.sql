-- ========================================================================================
-- PROCUREMENT APPENDICES DATA - TEMPLATES TABLE INSERTION
-- ========================================================================================
--
-- This file contains the procurement appendices templates that should be inserted
-- into the templates table to provide detailed specifications in the DocumentBrowser.
--
-- The appendices are detailed technical templates that complement the SOW workflow.
--
-- ========================================================================================

-- ========================================================================================
-- STEP 1: Insert Procurement Appendices into templates table
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
-- Appendix A: Product Specification Sheets
(
  'appendix-a-001',
  'Appendix A: Product Specification Sheets',
  'procurement_appendix',
  'Procurement',
  'scope_of_work',
  'Detailed product specifications for lubricants and consumables including technical specifications, performance standards, quality requirements, and application guidelines.',
  '<p>Detailed product specifications template content...</p>',
  true,
  'published',
  ARRAY['purchase_order', 'work_order', 'service_order'],
  '90cd635a-380f-4586-a3b7-a09103b6df94',
  NOW(),
  NOW()
),
-- Appendix B: Safety Data Sheets
(
  'appendix-b-001',
  'Appendix B: Safety Data Sheets',
  'procurement_appendix',
  'Procurement',
  'scope_of_work',
  'Comprehensive safety data sheets and hazard communication including GHS compliance, emergency response procedures, and regulatory requirements.',
  '<p>Safety data sheets template content...</p>',
  true,
  'published',
  ARRAY['purchase_order', 'work_order', 'service_order'],
  '90cd635a-380f-4586-a3b7-a09103b6df94',
  NOW(),
  NOW()
),
-- Appendix C: Delivery Schedule
(
  'appendix-c-001',
  'Appendix C: Delivery Schedule',
  'procurement_appendix',
  'Procurement',
  'scope_of_work',
  'Supply chain logistics and delivery management including scheduling requirements, transportation specifications, and quality control procedures.',
  '<p>Delivery schedule template content...</p>',
  true,
  'published',
  ARRAY['purchase_order', 'work_order', 'service_order'],
  '90cd635a-380f-4586-a3b7-a09103b6df94',
  NOW(),
  NOW()
),
-- Appendix D: Training Materials
(
  'appendix-d-001',
  'Appendix D: Training Materials',
  'procurement_appendix',
  'Procurement',
  'scope_of_work',
  'Personnel training and competency development including training programs, certification requirements, safety training, and technical training.',
  '<p>Training materials template content...</p>',
  true,
  'published',
  ARRAY['purchase_order', 'work_order', 'service_order'],
  '90cd635a-380f-4586-a3b7-a09103b6df94',
  NOW(),
  NOW()
),
-- Appendix E: Logistics Documents Specification
(
  'appendix-e-001',
  'Appendix E: Logistics Documents Specification',
  'procurement_appendix',
  'Procurement',
  'scope_of_work',
  'Documentation standards and record keeping including document types, traceability systems, electronic systems, and compliance reporting.',
  '<p>Logistics documents template content...</p>',
  true,
  'published',
  ARRAY['purchase_order', 'work_order', 'service_order'],
  '90cd635a-380f-4586-a3b7-a09103b6df94',
  NOW(),
  NOW()
),
-- Appendix F: Packing and Marking Specification
(
  'appendix-f-001',
  'Appendix F: Packing and Marking Specification',
  'procurement_appendix',
  'Procurement',
  'scope_of_work',
  'Packaging standards and preservation requirements including packaging specifications, preservation standards, environmental compliance, and testing procedures.',
  '<p>Packing and marking template content...</p>',
  true,
  'published',
  ARRAY['purchase_order', 'work_order', 'service_order'],
  '90cd635a-380f-4586-a3b7-a09103b6df94',
  NOW(),
  NOW()
)
ON CONFLICT (id) DO NOTHING;

-- ========================================================================================
-- STEP 2: Verification Query - Test that appendices load correctly
-- ========================================================================================

-- This query mimics what the DocumentBrowser does when loading appendices
-- Run this after applying the SQL to verify appendices are found

/*
SELECT
  id,
  name,
  type,
  discipline,
  document_type,
  processing_status
FROM templates
WHERE organization_id = '90cd635a-380f-4586-a3b7-a09103b6df94'
  AND type = 'procurement_appendix'
  AND processing_status = 'published'
  AND is_active = true
ORDER BY name;
*/

-- ========================================================================================
-- STEP 3: Expected Results After Running This SQL
-- ========================================================================================

/*
Expected output from verification query:

id              | name                                      | type                  | discipline | document_type | processing_status
----------------+-------------------------------------------+-----------------------+------------+---------------+------------------
appendix-a-001 | Appendix A: Product Specification Sheets   | procurement_appendix  | Procurement| scope_of_work | published
appendix-b-001 | Appendix B: Safety Data Sheets            | procurement_appendix  | Procurement| scope_of_work | published
appendix-c-001 | Appendix C: Delivery Schedule             | procurement_appendix  | Procurement| scope_of_work | published
appendix-d-001 | Appendix D: Training Materials            | procurement_appendix  | Procurement| scope_of_work | published
appendix-e-001 | Appendix E: Logistics Documents Specification | procurement_appendix| Procurement| scope_of_work | published
appendix-f-001 | Appendix F: Packing and Marking Specification | procurement_appendix| Procurement| scope_of_work | published

6 rows returned - SUCCESS! Procurement appendices are now available in the DocumentBrowser.
*/

-- ========================================================================================
-- STEP 4: Full Content Addition (Optional Future Enhancement)
-- ========================================================================================

/*
To add the full detailed content from the markdown files to the documents table,
you would need to:

1. Read the content from each appendix markdown file
2. Convert markdown to HTML (if needed)
3. Update the documents table with full content in a 'content' field
4. Add appropriate metadata for search and filtering

Example for Appendix A:
UPDATE documents
SET content = '<full HTML content from 01900_appendix_a_product_specification_sheets.md>'
WHERE id = 'appendix-a-001';
*/

-- ========================================================================================
-- TROUBLESHOOTING NOTES
-- ========================================================================================

/*
If appendices don't load after running this SQL:

1. Check DocumentBrowser query:
   - organization_id should match active organization
   - type should be 'procurement_appendix'
   - processing_status should be 'published'
   - is_active should be true

2. Verify table structure:
   SELECT column_name FROM information_schema.columns
   WHERE table_name = 'templates' AND table_schema = 'public'
   ORDER BY ordinal_position;

3. Check appendices count:
   SELECT type, COUNT(*) as count
   FROM templates
   WHERE type = 'procurement_appendix'
   GROUP BY type;

Expected result: procurement_appendix | 6

4. Test specific organization:
   SELECT COUNT(*) FROM templates
   WHERE organization_id = '90cd635a-380f-4586-a3b7-a09103b6df94'
   AND type = 'procurement_appendix'
   AND is_active = true;

Expected result: 6
*/

COMMIT;
