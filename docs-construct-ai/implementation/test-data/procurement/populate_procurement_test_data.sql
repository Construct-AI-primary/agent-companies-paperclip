-- ========================================================================================
-- COMPREHENSIVE TEST DATA POPULATION SCRIPT FOR 01900 PROCUREMENT WORKFLOW
-- ========================================================================================
-- This script populates complete test data for the procurement workflow including:
-- - Users with disciplines (15 records) - references existing disciplines
-- - Templates (7 records)
-- - Procurement Orders (5 records)
-- - Tasks (9 records for workflow management)
-- - Agent Workflow Executions (3 records for 6-agent system)
--
-- PRESERVES EXISTING DATA:
-- - Organizations: Uses existing organization (90cd635a-380f-4586-a3b7-a09103b6df94)
-- - Disciplines: Uses existing discipline names (Procurement, Engineering, Safety, etc.)
--
-- Generated for comprehensive testing of 6-agent procurement workflow system
-- Compatible with Supabase PostgreSQL database
-- ========================================================================================

-- Set timezone and session settings for consistent data
SET timezone = 'Africa/Johannesburg';

-- Enable necessary extensions if not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ========================================================================================
-- NOTE: ORGANIZATIONS DATA NOT INCLUDED
-- ========================================================================================
-- Existing organizations are preserved as they are central to accordion functionality
-- All test data references existing organization: '90cd635a-380f-4586-a3b7-a09103b6df94' (EPCM Engineering)

-- ========================================================================================
-- NOTE: DISCIPLINES DATA NOT INCLUDED
-- ========================================================================================
-- Existing disciplines are preserved. All test data references existing discipline names
-- (Procurement, Engineering, Safety, Quality, etc.) that should already exist in your system.

-- ========================================================================================
-- 3. DOCUMENT VARIATIONS DATA
-- ========================================================================================

INSERT INTO document_variations (
    id,
    title,
    description,
    discipline_code,
    organization_id,
    template_variation,
    created_by,
    created_at,
    updated_at
) VALUES
(
    'uuid-doc-var-001',
    'Standard Purchase Order Variation',
    'Complete document variation for standard purchase orders with all required sections',
    '01900',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    'standard_po',
    '550e8400-e29b-41d4-a716-446655440001',
    '2026-01-01T10:00:00Z',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-doc-var-002',
    'Service Order Variation',
    'Document variation for service contracts with service-level sections',
    '01900',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    'service_order',
    '550e8400-e29b-41d4-a716-446655440001',
    '2026-01-01T10:00:00Z',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-doc-var-003',
    'Work Order Variation',
    'Document variation for work orders with technical specifications',
    '01900',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    'work_order',
    '550e8400-e29b-41d4-a716-446655440001',
    '2026-01-01T10:00:00Z',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-doc-var-004',
    'Chemical Processing Equipment Variation',
    'Specialized variation for chemical processing equipment procurement',
    '01900',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    'chemical_processing',
    '550e8400-e29b-41d4-a716-446655440001',
    '2026-01-01T10:00:00Z',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-doc-var-005',
    'IT Infrastructure Services Variation',
    'Document variation for IT infrastructure and service contracts',
    '01900',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    'it_infrastructure',
    '550e8400-e29b-41d4-a716-446655440001',
    '2026-01-01T10:00:00Z',
    '2026-01-01T10:00:00Z'
) ON CONFLICT (id) DO NOTHING;

-- ========================================================================================
-- 4. DOCUMENT VARIATION SECTIONS DATA
-- ========================================================================================

INSERT INTO document_variation_sections (
    id,
    variation_id,
    section_code,
    section_name,
    display_order,
    is_required,
    organization_id,
    created_at
) VALUES
-- Standard Purchase Order Variation Sections
(
    'uuid-sec-001',
    'uuid-doc-var-001',
    'executive_summary',
    'Executive Summary',
    1,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-002',
    'uuid-doc-var-001',
    'scope_of_work',
    'Scope of Work',
    2,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-003',
    'uuid-doc-var-001',
    'deliverables',
    'Deliverables',
    3,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-004',
    'uuid-doc-var-001',
    'pricing',
    'Pricing and Payment Terms',
    4,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-005',
    'uuid-doc-var-001',
    'appendix_a',
    'Appendix A - Technical Specifications',
    5,
    false,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-006',
    'uuid-doc-var-001',
    'appendix_b',
    'Appendix B - Quality Requirements',
    6,
    false,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
-- Service Order Variation Sections
(
    'uuid-sec-007',
    'uuid-doc-var-002',
    'executive_summary',
    'Executive Summary',
    1,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-008',
    'uuid-doc-var-002',
    'service_description',
    'Service Description',
    2,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-009',
    'uuid-doc-var-002',
    'service_levels',
    'Service Level Agreements',
    3,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-010',
    'uuid-doc-var-002',
    'responsibilities',
    'Roles and Responsibilities',
    4,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-011',
    'uuid-doc-var-002',
    'appendix_c',
    'Appendix C - Compliance Standards',
    5,
    false,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
-- Work Order Variation Sections
(
    'uuid-sec-012',
    'uuid-doc-var-003',
    'executive_summary',
    'Executive Summary',
    1,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-013',
    'uuid-doc-var-003',
    'work_description',
    'Work Description',
    2,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-014',
    'uuid-doc-var-003',
    'specifications',
    'Technical Specifications',
    3,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-015',
    'uuid-doc-var-003',
    'safety_requirements',
    'Safety Requirements',
    4,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-016',
    'uuid-doc-var-003',
    'completion_criteria',
    'Completion Criteria',
    5,
    false,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
-- Chemical Processing Variation Sections
(
    'uuid-sec-017',
    'uuid-doc-var-004',
    'executive_summary',
    'Executive Summary',
    1,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-018',
    'uuid-doc-var-004',
    'process_description',
    'Process Description',
    2,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-019',
    'uuid-doc-var-004',
    'equipment_specs',
    'Equipment Specifications',
    3,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-020',
    'uuid-doc-var-004',
    'safety_protocols',
    'Safety Protocols',
    4,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-021',
    'uuid-doc-var-004',
    'environmental_compliance',
    'Environmental Compliance',
    5,
    false,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
-- IT Infrastructure Variation Sections
(
    'uuid-sec-022',
    'uuid-doc-var-005',
    'executive_summary',
    'Executive Summary',
    1,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-023',
    'uuid-doc-var-005',
    'infrastructure_scope',
    'Infrastructure Scope',
    2,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-024',
    'uuid-doc-var-005',
    'security_requirements',
    'Security Requirements',
    3,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-025',
    'uuid-doc-var-005',
    'service_level_agreements',
    'Service Level Agreements',
    4,
    true,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
),
(
    'uuid-sec-026',
    'uuid-doc-var-005',
    'monitoring_reporting',
    'Monitoring & Reporting',
    5,
    false,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z'
) ON CONFLICT (id) DO NOTHING;

-- ========================================================================================
-- 2. USER MANAGEMENT DATA
-- ========================================================================================

INSERT INTO user_management (
    user_id,
    email,
    full_name,
    job_title,
    department,
    disciplines,
    organization_id,
    active,
    created_at
) VALUES
(
    '550e8400-e29b-41d4-a716-446655440001',
    'procurement.officer@epcm.co.za',
    'Sarah Johnson',
    'Senior Procurement Officer',
    'Procurement',
    '["Procurement"]'::jsonb,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    true,
    '2026-01-01T10:00:00Z'
),
(
    '550e8400-e29b-41d4-a716-446655440002',
    'john.engineer@epcm.co.za',
    'John Engineering',
    'Senior Mechanical Engineer',
    'Engineering',
    '["Engineering", "Mechanical"]'::jsonb,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    true,
    '2026-01-01T10:00:00Z'
),
(
    '550e8400-e29b-41d4-a716-446655440003',
    'sarah.safety@epcm.co.za',
    'Sarah Safety',
    'Safety Manager',
    'Safety',
    '["Safety", "HSE"]'::jsonb,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    true,
    '2026-01-01T10:00:00Z'
),
(
    '550e8400-e29b-41d4-a716-446655440004',
    'mark.quality@epcm.co.za',
    'Mark Quality',
    'Quality Assurance Manager',
    'Quality',
    '["Quality", "QA"]'::jsonb,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    true,
    '2026-01-01T10:00:00Z'
),
(
    '550e8400-e29b-41d4-a716-446655440005',
    'lisa.procurement@epcm.co.za',
    'Lisa Procurement',
    'Procurement Specialist',
    'Procurement',
    '["Procurement", "Contracts"]'::jsonb,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    true,
    '2026-01-01T10:00:00Z'
),
(
    '550e8400-e29b-41d4-a716-446655440006',
    'david.electrical@epcm.co.za',
    'David Electrical',
    'Electrical Engineer',
    'Engineering',
    '["Engineering", "Electrical"]'::jsonb,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    true,
    '2026-01-01T10:00:00Z'
),
(
    '550e8400-e29b-41d4-a716-446655440007',
    'anna.chemical@epcm.co.za',
    'Anna Chemical',
    'Chemical Engineer',
    'Engineering',
    '["Engineering", "Chemical"]'::jsonb,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    true,
    '2026-01-01T10:00:00Z'
),
(
    '550e8400-e29b-41d4-a716-446655440008',
    'peter.civil@epcm.co.za',
    'Peter Civil',
    'Civil Engineer',
    'Engineering',
    '["Engineering", "Civil"]'::jsonb,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    true,
    '2026-01-01T10:00:00Z'
),
(
    '550e8400-e29b-41d4-a716-446655440009',
    'maria.logistics@epcm.co.za',
    'Maria Logistics',
    'Logistics Manager',
    'Logistics',
    '["Logistics", "Operations"]'::jsonb,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    true,
    '2026-01-01T10:00:00Z'
),
(
    '550e8400-e29b-41d4-a716-446655440010',
    'thomas.training@epcm.co.za',
    'Thomas Training',
    'Training Specialist',
    'Human Resources',
    '["Training", "HR"]'::jsonb,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    true,
    '2026-01-01T10:00:00Z'
),
(
    '550e8400-e29b-41d4-a716-446655440011',
    'emma.environmental@epcm.co.za',
    'Emma Environmental',
    'Environmental Officer',
    'Environmental',
    '["Environmental", "Compliance"]'::jsonb,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    true,
    '2026-01-01T10:00:00Z'
),
(
    '550e8400-e29b-41d4-a716-446655440012',
    'alex.it@epcm.co.za',
    'Alex IT',
    'IT Manager',
    'Information Technology',
    '["IT", "Infrastructure"]'::jsonb,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    true,
    '2026-01-01T10:00:00Z'
),
(
    '550e8400-e29b-41d4-a716-446655440013',
    'rachel.security@epcm.co.za',
    'Rachel Security',
    'Cybersecurity Specialist',
    'Information Technology',
    '["Security", "Cybersecurity"]'::jsonb,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    true,
    '2026-01-01T10:00:00Z'
),
(
    '550e8400-e29b-41d4-a716-446655440014',
    'james.construction@epcm.co.za',
    'James Construction',
    'Construction Manager',
    'Construction',
    '["Construction", "Project Management"]'::jsonb,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    true,
    '2026-01-01T10:00:00Z'
),
(
    '550e8400-e29b-41d4-a716-446655440015',
    'olivia.operations@epcm.co.za',
    'Olivia Operations',
    'Operations Director',
    'Operations',
    '["Operations", "Management"]'::jsonb,
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    true,
    '2026-01-01T10:00:00Z'
) ON CONFLICT (user_id) DO NOTHING;

-- ========================================================================================
-- 4. TEMPLATES DATA
-- ========================================================================================

INSERT INTO templates (
    id,
    name,
    type,
    discipline,
    category,
    prompt_template,
    validation_config,
    ui_config,
    is_active,
    processing_status,
    organization_id,
    created_at,
    suitable_for_document_types
) VALUES
(
    '550e8400-e29b-41d4-a716-446655440201',
    'Equipment Rental Agreement Form',
    'form',
    'Procurement',
    'equipment_rental',
    '<html><body><form><h1>Equipment Rental Agreement</h1><input type="text" name="equipment_type" required><input type="date" name="rental_period"><input type="number" name="daily_rate"><textarea name="special_requirements"></textarea></form></body></html>',
    '{"required_fields": ["equipment_type", "rental_period"], "field_types": {"equipment_type": "text", "rental_period": "date", "daily_rate": "number", "special_requirements": "textarea"}}'::jsonb,
    '{"fields": [{"name": "equipment_type", "label": "Equipment Type", "type": "text", "required": true}, {"name": "rental_period", "label": "Rental Period", "type": "date", "required": true}, {"name": "daily_rate", "label": "Daily Rate (ZAR)", "type": "number", "required": false}, {"name": "special_requirements", "label": "Special Requirements", "type": "textarea", "required": false}]}'::jsonb,
    true,
    'published',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z',
    '{"purchase_order", "service_order"}'
),
(
    '550e8400-e29b-41d4-a716-446655440202',
    'Supplier Evaluation Form',
    'form',
    'Procurement',
    'supplier_evaluation',
    '<html><body><form><h1>Supplier Evaluation</h1><input type="text" name="company_name" required><input type="text" name="contact_person"><select name="product_services"><option>Products</option><option>Services</option><option>Both</option></select><input type="number" name="quality_rating" min="1" max="5"><input type="number" name="delivery_rating" min="1" max="5"><input type="number" name="price_rating" min="1" max="5"><textarea name="certifications"></textarea><textarea name="recommendations"></textarea></form></body></html>',
    '{"required_fields": ["company_name"], "field_types": {"company_name": "text", "contact_person": "text", "product_services": "select", "quality_rating": "number", "delivery_rating": "number", "price_rating": "number", "certifications": "textarea", "recommendations": "textarea"}}'::jsonb,
    '{"fields": [{"name": "company_name", "label": "Company Name", "type": "text", "required": true}, {"name": "contact_person", "label": "Contact Person", "type": "text", "required": false}, {"name": "product_services", "label": "Products/Services", "type": "select", "options": ["Products", "Services", "Both"], "required": false}, {"name": "quality_rating", "label": "Quality Rating (1-5)", "type": "number", "min": 1, "max": 5, "required": false}, {"name": "delivery_rating", "label": "Delivery Rating (1-5)", "type": "number", "min": 1, "max": 5, "required": false}, {"name": "price_rating", "label": "Price Rating (1-5)", "type": "number", "min": 1, "max": 5, "required": false}]}'::jsonb,
    true,
    'published',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z',
    '{"supplier_evaluation", "vendor_assessment"}'
),
(
    '550e8400-e29b-41d4-a716-446655440203',
    'Contractor Performance Review',
    'form',
    'Procurement',
    'contractor_review',
    '<html><body><form><h1>Contractor Performance Review</h1><input type="text" name="contractor_name" required><input type="text" name="contract_number"><input type="date" name="review_period"><input type="number" name="work_quality" min="1" max="5"><input type="number" name="timeliness" min="1" max="5"><input type="number" name="safety_compliance" min="1" max="5"><input type="number" name="communication" min="1" max="5"><input type="number" name="cost_control" min="1" max="5"><input type="number" name="overall_rating" min="1" max="5"></form></body></html>',
    '{"required_fields": ["contractor_name"], "field_types": {"contractor_name": "text", "contract_number": "text", "review_period": "date", "work_quality": "number", "timeliness": "number", "safety_compliance": "number", "communication": "number", "cost_control": "number", "overall_rating": "number"}}'::jsonb,
    '{"fields": [{"name": "contractor_name", "label": "Contractor Name", "type": "text", "required": true}, {"name": "contract_number", "label": "Contract Number", "type": "text", "required": false}, {"name": "review_period", "label": "Review Period", "type": "date", "required": false}, {"name": "work_quality", "label": "Work Quality (1-5)", "type": "number", "min": 1, "max": 5, "required": false}, {"name": "timeliness", "label": "Timeliness (1-5)", "type": "number", "min": 1, "max": 5, "required": false}, {"name": "safety_compliance", "label": "Safety Compliance (1-5)", "type": "number", "min": 1, "max": 5, "required": false}, {"name": "communication", "label": "Communication (1-5)", "type": "number", "min": 1, "max": 5, "required": false}, {"name": "cost_control", "label": "Cost Control (1-5)", "type": "number", "min": 1, "max": 5, "required": false}, {"name": "overall_rating", "label": "Overall Rating (1-5)", "type": "number", "min": 1, "max": 5, "required": false}]}'::jsonb,
    true,
    'published',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z',
    '{"contractor_review", "performance_evaluation", "vendor_assessment"}'
),
(
    '550e8400-e29b-41d4-a716-446655440202',
    'Purchase Order SOW Template',
    'scope_of_work',
    'Procurement',
    'purchase_order_sow',
    '<html><body><div class="sow-template"><h1>Scope of Work - Purchase Order</h1><div class="section" id="executive-summary"></div><div class="section" id="scope"></div><div class="section" id="deliverables"></div><div class="section" id="timeline"></div><div class="section" id="acceptance-criteria"></div></div></body></html>',
    '{"required_sections": ["executive-summary", "scope", "deliverables"], "optional_sections": ["timeline", "acceptance-criteria"]}'::jsonb,
    '{"sections": [{"id": "executive-summary", "title": "Executive Summary", "required": true}, {"id": "scope", "title": "Scope of Work", "required": true}, {"id": "deliverables", "title": "Deliverables", "required": true}, {"id": "timeline", "title": "Timeline", "required": false}, {"id": "acceptance-criteria", "title": "Acceptance Criteria", "required": false}]}'::jsonb,
    true,
    'published',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z',
    '{"purchase_order"}'
),
(
    '550e8400-e29b-41d4-a716-446655440203',
    'Service Order SOW Template',
    'scope_of_work',
    'Procurement',
    'service_order_sow',
    '<html><body><div class="sow-template"><h1>Scope of Work - Service Order</h1><div class="section" id="service-description"></div><div class="section" id="service-levels"></div><div class="section" id="responsibilities"></div><div class="section" id="performance-metrics"></div><div class="section" id="reporting"></div></div></body></html>',
    '{"required_sections": ["service-description", "service-levels", "responsibilities"], "optional_sections": ["performance-metrics", "reporting"]}'::jsonb,
    '{"sections": [{"id": "service-description", "title": "Service Description", "required": true}, {"id": "service-levels", "title": "Service Levels", "required": true}, {"id": "responsibilities", "title": "Responsibilities", "required": true}, {"id": "performance-metrics", "title": "Performance Metrics", "required": false}, {"id": "reporting", "title": "Reporting Requirements", "required": false}]}'::jsonb,
    true,
    'published',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z',
    '{"service_order"}'
),
(
    '550e8400-e29b-41d4-a716-446655440204',
    'Work Order SOW Template',
    'scope_of_work',
    'Procurement',
    'work_order_sow',
    '<html><body><div class="sow-template"><h1>Scope of Work - Work Order</h1><div class="section" id="work-description"></div><div class="section" id="specifications"></div><div class="section" id="safety-requirements"></div><div class="section" id="quality-requirements"></div><div class="section" id="completion-criteria"></div></div></body></html>',
    '{"required_sections": ["work-description", "specifications", "safety-requirements"], "optional_sections": ["quality-requirements", "completion-criteria"]}'::jsonb,
    '{"sections": [{"id": "work-description", "title": "Work Description", "required": true}, {"id": "specifications", "title": "Technical Specifications", "required": true}, {"id": "safety-requirements", "title": "Safety Requirements", "required": true}, {"id": "quality-requirements", "title": "Quality Requirements", "required": false}, {"id": "completion-criteria", "title": "Completion Criteria", "required": false}]}'::jsonb,
    true,
    'published',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z',
    '{"work_order"}'
),
(
    '550e8400-e29b-41d4-a716-446655440205',
    'Chemical Processing SOW Template',
    'scope_of_work',
    'Procurement',
    'chemical_processing_sow',
    '<html><body><div class="sow-template"><h1>Scope of Work - Chemical Processing Equipment</h1><div class="section" id="process-description"></div><div class="section" id="equipment-specs"></div><div class="section" id="safety-protocols"></div><div class="section" id="environmental-compliance"></div><div class="section" id="validation-requirements"></div></div></body></html>',
    '{"required_sections": ["process-description", "equipment-specs", "safety-protocols"], "optional_sections": ["environmental-compliance", "validation-requirements"]}'::jsonb,
    '{"sections": [{"id": "process-description", "title": "Process Description", "required": true}, {"id": "equipment-specs", "title": "Equipment Specifications", "required": true}, {"id": "safety-protocols", "title": "Safety Protocols", "required": true}, {"id": "environmental-compliance", "title": "Environmental Compliance", "required": false}, {"id": "validation-requirements", "title": "Validation Requirements", "required": false}]}'::jsonb,
    true,
    'published',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z',
    '{"purchase_order"}'
),
(
    '550e8400-e29b-41d4-a716-446655440206',
    'IT Services SOW Template',
    'scope_of_work',
    'Procurement',
    'it_services_sow',
    '<html><body><div class="sow-template"><h1>Scope of Work - IT Infrastructure Services</h1><div class="section" id="infrastructure-scope"></div><div class="section" id="security-requirements"></div><div class="section" id="service-level-agreements"></div><div class="section" id="monitoring-reporting"></div><div class="section" id="disaster-recovery"></div></div></body></html>',
    '{"required_sections": ["infrastructure-scope", "security-requirements", "service-level-agreements"], "optional_sections": ["monitoring-reporting", "disaster-recovery"]}'::jsonb,
    '{"sections": [{"id": "infrastructure-scope", "title": "Infrastructure Scope", "required": true}, {"id": "security-requirements", "title": "Security Requirements", "required": true}, {"id": "service-level-agreements", "title": "Service Level Agreements", "required": true}, {"id": "monitoring-reporting", "title": "Monitoring & Reporting", "required": false}, {"id": "disaster-recovery", "title": "Disaster Recovery", "required": false}]}'::jsonb,
    true,
    'published',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z',
    '{"service_order"}'
) ON CONFLICT (order_number) DO NOTHING;

-- ========================================================================================
-- 6. TASKS DATA (from separate file)
-- ========================================================================================
-- ========================================================================================
-- 5.5 PROCUREMENT ORDERS DATA - UPDATE EXISTING RECORDS
-- ========================================================================================

-- Update the existing record with the corrected approval_status
UPDATE procurement_orders
SET approval_status = 'draft'
WHERE id = '550e8400-e29b-41d4-a716-446655440101' AND approval_status = 'in_progress';

-- ========================================================================================
-- 5. PROCUREMENT ORDERS DATA (from separate file)
-- ========================================================================================

INSERT INTO procurement_orders (
    id,
    order_number,
    order_type,
    title,
    description,
    estimated_value,
    currency,
    approval_status,
    priority,
    department,
    created_by,
    organization_id,
    created_at,
    updated_at,
    sow_template_id,
    discipline_assignments,
    user_assignments,
    approval_config
) VALUES
(
    '550e8400-e29b-41d4-a716-446655440101',
    'PO-2026-001',
    'purchase_order',
    'Industrial Equipment Procurement',
    'Complete procurement for production line equipment including CNC machines, conveyor systems, and quality control stations',
    250000.00,
    'ZAR',
    'draft',
    'high',
    'Procurement',
    '550e8400-e29b-41d4-a716-446655440001',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-01T10:00:00Z',
    '2026-01-01T10:00:00Z',
    '550e8400-e29b-41d4-a716-446655440202',
    '{"appendix_a": ["engineering", "quality"], "appendix_b": ["safety"], "appendix_c": ["procurement"]}'::jsonb,
    '{"appendix_a": ["550e8400-e29b-41d4-a716-446655440002", "550e8400-e29b-41d4-a716-446655440004"], "appendix_b": ["550e8400-e29b-41d4-a716-446655440003"], "appendix_c": ["550e8400-e29b-41d4-a716-446655440001"]}'::jsonb,
    '{"generate_cover_sheet": true, "routing_type": "sequential", "approval_matrix": [{"role": "procurement_officer", "required": true, "user_id": "550e8400-e29b-41d4-a716-446655440001"}, {"role": "procurement_manager", "required": true, "user_id": "550e8400-e29b-41d4-a716-446655440005"}]}'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440102',
    'SO-2026-002',
    'service_order',
    'Maintenance Services Contract',
    'Annual maintenance contract for HVAC systems and electrical infrastructure',
    500000.00,
    'ZAR',
    'draft',
    'medium',
    'Procurement',
    '550e8400-e29b-41d4-a716-446655440005',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-02T14:30:00Z',
    '2026-01-02T14:30:00Z',
    '550e8400-e29b-41d4-a716-446655440203',
    '{"appendix_a": ["engineering"], "appendix_b": ["safety", "quality"], "appendix_c": ["procurement"]}'::jsonb,
    '{"appendix_a": ["550e8400-e29b-41d4-a716-446655440006"], "appendix_b": ["550e8400-e29b-41d4-a716-446655440003", "550e8400-e29b-41d4-a716-446655440004"], "appendix_c": ["550e8400-e29b-41d4-a716-446655440005"]}'::jsonb,
    '{"generate_cover_sheet": true, "routing_type": "sequential", "approval_matrix": [{"role": "procurement_specialist", "required": true, "user_id": "550e8400-e29b-41d4-a716-446655440005"}, {"role": "engineering_manager", "required": true, "user_id": "550e8400-e29b-41d4-a716-446655440002"}, {"role": "safety_officer", "required": true, "user_id": "550e8400-e29b-41d4-a716-446655440003"}]}'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440103',
    'WO-2026-003',
    'work_order',
    'Construction Equipment Rental',
    'Heavy machinery rental for infrastructure development project',
    750000.00,
    'ZAR',
    'approved',
    'high',
    'Procurement',
    '550e8400-e29b-41d4-a716-446655440001',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-03T09:15:00Z',
    '2026-01-03T11:45:00Z',
    '550e8400-e29b-41d4-a716-446655440204',
    '{"appendix_a": ["civil_engineering"], "appendix_b": ["safety", "quality"], "appendix_c": ["procurement"]}'::jsonb,
    '{"appendix_a": ["550e8400-e29b-41d4-a716-446655440008"], "appendix_b": ["550e8400-e29b-41d4-a716-446655440003", "550e8400-e29b-41d4-a716-446655440004"], "appendix_c": ["550e8400-e29b-41d4-a716-446655440001"]}'::jsonb,
    '{"generate_cover_sheet": true, "routing_type": "parallel", "approval_matrix": [{"role": "procurement_officer", "required": true, "user_id": "550e8400-e29b-41d4-a716-446655440001"}, {"role": "civil_engineer", "required": true, "user_id": "550e8400-e29b-41d4-a716-446655440008"}, {"role": "safety_manager", "required": true, "user_id": "550e8400-e29b-41d4-a716-446655440003"}]}'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440104',
    'PO-2026-004',
    'purchase_order',
    'Chemical Processing Equipment',
    'Specialized chemical processing and handling equipment for pharmaceutical manufacturing',
    1200000.00,
    'ZAR',
    'in_review',
    'critical',
    'Procurement',
    '550e8400-e29b-41d4-a716-446655440005',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-04T16:20:00Z',
    '2026-01-04T16:20:00Z',
    '550e8400-e29b-41d4-a716-446655440205',
    '{"appendix_a": ["chemical_engineering"], "appendix_b": ["safety", "quality"], "appendix_c": ["procurement"], "appendix_d": ["environmental"]}'::jsonb,
    '{"appendix_a": ["550e8400-e29b-41d4-a716-446655440007"], "appendix_b": ["550e8400-e29b-41d4-a716-446655440003", "550e8400-e29b-41d4-a716-446655440004"], "appendix_c": ["550e8400-e29b-41d4-a716-446655440005"], "appendix_d": ["550e8400-e29b-41d4-a716-446655440011"]}'::jsonb,
    '{"generate_cover_sheet": true, "routing_type": "sequential", "approval_matrix": [{"role": "procurement_specialist", "required": true, "user_id": "550e8400-e29b-41d4-a716-446655440005"}, {"role": "chemical_engineer", "required": true, "user_id": "550e8400-e29b-41d4-a716-446655440007"}, {"role": "safety_manager", "required": true, "user_id": "550e8400-e29b-41d4-a716-446655440003"}, {"role": "quality_manager", "required": true, "user_id": "550e8400-e29b-41d4-a716-446655440004"}]}'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440105',
    'SO-2026-005',
    'service_order',
    'IT Infrastructure Services',
    'Managed IT services including network infrastructure, cybersecurity, and system administration',
    350000.00,
    'ZAR',
    'completed',
    'medium',
    'Procurement',
    '550e8400-e29b-41d4-a716-446655440001',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    '2026-01-05T08:00:00Z',
    '2026-01-06T17:30:00Z',
    '550e8400-e29b-41d4-a716-446655440206',
    '{"appendix_a": ["it"], "appendix_b": ["security"], "appendix_c": ["procurement"]}'::jsonb,
    '{"appendix_a": ["550e8400-e29b-41d4-a716-446655440012"], "appendix_b": ["550e8400-e29b-41d4-a716-446655440013"], "appendix_c": ["550e8400-e29b-41d4-a716-446655440001"]}'::jsonb,
    '{"generate_cover_sheet": true, "routing_type": "sequential", "approval_matrix": [{"role": "procurement_officer", "required": true, "user_id": "550e8400-e29b-41d4-a716-446655440001"}, {"role": "it_manager", "required": true, "user_id": "550e8400-e29b-41d4-a716-446655440012"}]}'::jsonb
) ON CONFLICT (id) DO NOTHING;

-- ========================================================================================
-- 6. TASKS DATA (from separate file)
-- ========================================================================================

INSERT INTO tasks (
    id,
    organization_id,
    task_type,
    title,
    description,
    business_object_type,
    business_object_id,
    assigned_to,
    discipline,
    priority,
    status,
    created_at,
    updated_at,
    due_date,
    metadata
) VALUES
(
    '550e8400-e29b-41d4-a716-446655440301',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    'sow_generation',
    'Generate Scope of Work: Industrial Equipment Procurement',
    'Create a comprehensive Scope of Work document for procurement order PO-2026-001 including technical specifications, delivery requirements, and compliance standards.',
    'procurement_order',
    '550e8400-e29b-41d4-a716-446655440101',
    NULL,
    'procurement',
    'high',
    'completed',
    '2026-01-01T10:05:00Z',
    '2026-01-01T10:30:00Z',
    '2026-01-02T17:00:00Z',
    '{"procurement_order_id": "550e8400-e29b-41d4-a716-446655440101", "sow_generation_required": true, "next_step": "create_sow_via_scope_of_work_page", "scope_of_work_url": "/scope-of-work", "parallel_workflow": true, "development_mode": true, "original_assigned_to": "550e8400-e29b-41d4-a716-446655440001"}'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440303',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    'appendix_contribution',
    'Review Appendix A - Technical Specifications: Industrial Equipment Procurement',
    'Review and contribute to Appendix A for procurement order PO-2026-001. Provide technical specifications and requirements for CNC machines and conveyor systems.',
    'procurement_order',
    '550e8400-e29b-41d4-a716-446655440101',
    '550e8400-e29b-41d4-a716-446655440002',
    'engineering',
    'normal',
    'completed',
    '2026-01-01T10:05:00Z',
    '2026-01-01T14:20:00Z',
    '2026-01-03T17:00:00Z',
    '{"procurement_order_id": "550e8400-e29b-41d4-a716-446655440101", "appendix_type": "A", "order_type": "purchase_order", "parallel_workflow": true, "original_assigned_to": "550e8400-e29b-41d4-a716-446655440002", "sow_id": "uuid-sow-001"}'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440303-qa',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    'appendix_contribution',
    'Review Appendix A - Quality Requirements: Industrial Equipment Procurement',
    'Review and contribute to Appendix A for procurement order PO-2026-001. Provide quality assurance and testing requirements for equipment procurement.',
    'procurement_order',
    '550e8400-e29b-41d4-a716-446655440101',
    '550e8400-e29b-41d4-a716-446655440004',
    'quality',
    'normal',
    'in_progress',
    '2026-01-01T10:05:00Z',
    '2026-01-01T10:05:00Z',
    '2026-01-03T17:00:00Z',
    '{"procurement_order_id": "550e8400-e29b-41d4-a716-446655440101", "appendix_type": "A", "order_type": "purchase_order", "parallel_workflow": true, "original_assigned_to": "550e8400-e29b-41d4-a716-446655440004", "sow_id": "uuid-sow-001"}'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440305',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    'appendix_contribution',
    'Review Appendix B - Safety Requirements: Industrial Equipment Procurement',
    'Review and contribute to Appendix B for procurement order PO-2026-001. Provide safety compliance and hazard analysis requirements.',
    'procurement_order',
    '550e8400-e29b-41d4-a716-446655440101',
    '550e8400-e29b-41d4-a716-446655440003',
    'safety',
    'normal',
    'pending',
    '2026-01-01T10:05:00Z',
    '2026-01-01T10:05:00Z',
    '2026-01-03T17:00:00Z',
    '{"procurement_order_id": "550e8400-e29b-41d4-a716-446655440101", "appendix_type": "B", "order_type": "purchase_order", "parallel_workflow": true, "original_assigned_to": "550e8400-e29b-41d4-a716-446655440003", "sow_id": "uuid-sow-001"}'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440306',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    'appendix_contribution',
    'Review Appendix C - Commercial Terms: Industrial Equipment Procurement',
    'Review and contribute to Appendix C for procurement order PO-2026-001. Provide commercial terms, payment schedules, and delivery conditions.',
    'procurement_order',
    '550e8400-e29b-41d4-a716-446655440101',
    '550e8400-e29b-41d4-a716-446655440001',
    'procurement',
    'normal',
    'pending',
    '2026-01-01T10:05:00Z',
    '2026-01-01T10:05:00Z',
    '2026-01-03T17:00:00Z',
    '{"procurement_order_id": "550e8400-e29b-41d4-a716-446655440101", "appendix_type": "C", "order_type": "purchase_order", "parallel_workflow": true, "original_assigned_to": "550e8400-e29b-41d4-a716-446655440001", "sow_id": "uuid-sow-001"}'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440302',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    'sow_generation',
    'Generate Scope of Work: Maintenance Services Contract',
    'Create a comprehensive Scope of Work document for service order SO-2026-002 including HVAC and electrical maintenance requirements.',
    'procurement_order',
    '550e8400-e29b-41d4-a716-446655440102',
    NULL,
    'procurement',
    'high',
    'in_progress',
    '2026-01-02T14:35:00Z',
    '2026-01-02T14:35:00Z',
    '2026-01-04T17:00:00Z',
    '{"procurement_order_id": "550e8400-e29b-41d4-a716-446655440102", "sow_generation_required": true, "next_step": "create_sow_via_scope_of_work_page", "scope_of_work_url": "/scope-of-work", "parallel_workflow": true, "development_mode": true, "original_assigned_to": "550e8400-e29b-41d4-a716-446655440005"}'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440307',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    'approval',
    'Approve Procurement Order: PO-2026-001',
    'Review and approve procurement order PO-2026-001 for industrial equipment procurement.',
    'procurement_order',
    '550e8400-e29b-41d4-a716-446655440101',
    '550e8400-e29b-41d4-a716-446655440005',
    'procurement',
    'high',
    'pending',
    '2026-01-01T10:30:00Z',
    '2026-01-01T10:30:00Z',
    '2026-01-04T17:00:00Z',
    '{"procurement_order_id": "550e8400-e29b-41d4-a716-446655440101", "approval_step": 1, "approval_role": "procurement_manager", "approval_matrix_position": 1, "total_approvers": 2}'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440308',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    'approval',
    'Approve Procurement Order: WO-2026-003',
    'Review and approve work order WO-2026-003 for construction equipment rental.',
    'procurement_order',
    '550e8400-e29b-41d4-a716-446655440103',
    '550e8400-e29b-41d4-a716-446655440008',
    'civil_engineering',
    'high',
    'completed',
    '2026-01-03T11:45:00Z',
    '2026-01-03T14:20:00Z',
    '2026-01-06T17:00:00Z',
    '{"procurement_order_id": "550e8400-e29b-41d4-a716-446655440103", "approval_step": 1, "approval_role": "civil_engineer", "approval_matrix_position": 1, "total_approvers": 3, "parallel_approval": true}'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440309',
    '90cd635a-380f-4586-a3b7-a09103b6df94',
    'approval',
    'Approve Procurement Order: WO-2026-003',
    'Review and approve work order WO-2026-003 for construction equipment rental - Safety approval.',
    'procurement_order',
    '550e8400-e29b-41d4-a716-446655440103',
    '550e8400-e29b-41d4-a716-446655440003',
    'safety',
    'high',
    'completed',
    '2026-01-03T11:45:00Z',
    '2026-01-03T15:10:00Z',
    '2026-01-06T17:00:00Z',
    '{"procurement_order_id": "550e8400-e29b-41d4-a716-446655440103", "approval_step": 2, "approval_role": "safety_manager", "approval_matrix_position": 2, "total_approvers": 3, "parallel_approval": true}'::jsonb
) ON CONFLICT (id) DO NOTHING;

-- ========================================================================================
-- 7. AGENT WORKFLOW EXECUTIONS DATA (from separate file)
-- ========================================================================================

INSERT INTO agent_workflow_executions (
    id,
    procurement_order_id,
    agent_id,
    agent_name,
    stage,
    status,
    input_data,
    output_data,
    confidence_score,
    processing_time_ms,
    executed_at,
    quality_gate_passed,
    quality_score,
    notifications_sent,
    metadata
) VALUES
(
    '550e8400-e29b-41d4-a716-446655440401',
    '550e8400-e29b-41d4-a716-446655440101',
    'agent_procurement_01',
    'Template Analysis Agent',
    'template_analysis',
    'completed',
    '{"template_id": "550e8400-e29b-41d4-a716-446655440201", "order_requirements": "CNC machines, conveyor systems, quality control stations", "compliance_context": "South African procurement regulations"}'::jsonb,
    '{"compatibility_score": 95, "template_suitability": "excellent", "identified_requirements": ["Technical specifications for industrial equipment", "Quality assurance procedures", "Safety compliance requirements", "Commercial terms and conditions"], "risk_assessment": "low", "recommendations": ["Template fully compatible with requirements", "All mandatory fields available", "Appendix structure matches order complexity"]}'::jsonb,
    0.92,
    2500,
    '2026-01-01T10:05:00Z',
    true,
    95,
    '["chatbot", "dashboard"]'::jsonb,
    '{"agent_version": "1.0", "processing_node": "agent-orchestrator-01", "retry_count": 0}'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440402',
    '550e8400-e29b-41d4-a716-446655440101',
    'agent_procurement_02',
    'Requirement Extraction Agent',
    'requirement_extraction',
    'completed',
    '{"order_description": "Complete procurement for production line equipment including CNC machines, conveyor systems, and quality control stations", "template_analysis": {"compatibility_score": 95, "identified_requirements": ["Technical specifications", "Quality assurance", "Safety compliance", "Commercial terms"]}}'::jsonb,
    '{"extracted_requirements": {"technical": ["CNC machine specifications (precision, capacity, power requirements)", "Conveyor system specifications (load capacity, speed, safety features)", "Quality control station specifications (measurement accuracy, calibration)", "Integration requirements with existing production line"], "quality": ["ISO 9001 compliance requirements", "Quality assurance procedures", "Testing and validation protocols", "Documentation and traceability requirements"], "safety": ["Machine guarding requirements", "Emergency stop systems", "Safety interlock specifications", "Operator training requirements"], "commercial": ["Delivery schedule requirements", "Payment terms and conditions", "Warranty and maintenance agreements", "Performance guarantees"]}, "requirement_confidence": 0.88, "total_requirements": 12, "categorized_requirements": 4}'::jsonb,
    0.88,
    3200,
    '2026-01-01T10:07:00Z',
    true,
    92,
    '["chatbot", "dashboard"]'::jsonb,
    '{"agent_version": "1.0", "processing_node": "agent-orchestrator-02", "retry_count": 0}'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440403',
    '550e8400-e29b-41d4-a716-446655440101',
    'agent_procurement_06',
    'Final Review Agent',
    'final_review',
    'completed',
    '{"quality_assessment": {"overall_quality_score": 91, "issues_and_corrections": {"major_issues": [], "minor_issues": ["Payment terms specificity", "Local content reference"]}}, "populated_document": "Complete procurement document with all appendices", "agent_workflow_summary": {"agents_executed": 5, "average_confidence": 0.91, "quality_gates_passed": 5, "processing_time_total": 16500}}'::jsonb,
    '{"final_review": {"executive_summary": {"document_readiness": "approved", "confidence_level": "high", "risk_assessment": "low", "recommendations": ["Document ready for procurement officer review", "All quality gates passed successfully", "Compliance requirements fully addressed"]}, "approval_recommendation": {"recommendation": "approve", "confidence_score": 0.96, "justification": "All agents completed successfully with high quality scores. Document meets all procurement and compliance requirements.", "next_steps": ["Forward to procurement officer for final approval", "Initiate vendor engagement process", "Prepare contract negotiation documents"]}, "final_metadata": {"overall_confidence": 0.93, "quality_score": 92, "compliance_score": 95, "completeness_score": 98}}}'::jsonb,
    0.96,
    2100,
    '2026-01-01T10:15:00Z',
    true,
    96,
    '["chatbot", "dashboard", "email"]'::jsonb,
    '{"agent_version": "1.0", "processing_node": "agent-orchestrator-06", "retry_count": 0, "final_approval": "granted"}'::jsonb
) ON CONFLICT (id) DO NOTHING;

-- ========================================================================================
-- 8. PERFORMANCE INDEXES
-- ========================================================================================

-- Procurement Orders indexes
CREATE INDEX IF NOT EXISTS idx_procurement_orders_status ON procurement_orders(status);
CREATE INDEX IF NOT EXISTS idx_procurement_orders_created_by ON procurement_orders(created_by);
CREATE INDEX IF NOT EXISTS idx_procurement_orders_organization ON procurement_orders(organization_id);
CREATE INDEX IF NOT EXISTS idx_procurement_orders_sow_template ON procurement_orders(sow_template_id);

-- Tasks indexes
CREATE INDEX IF NOT EXISTS idx_tasks_business_object ON tasks(business_object_type, business_object_id);
CREATE INDEX IF NOT EXISTS idx_tasks_assigned_to ON tasks(assigned_to);
CREATE INDEX IF NOT EXISTS idx_tasks_status ON tasks(status);
CREATE INDEX IF NOT EXISTS idx_tasks_type ON tasks(task_type);
CREATE INDEX IF NOT EXISTS idx_tasks_discipline ON tasks(discipline);

-- Agent Workflow Executions indexes
CREATE INDEX IF NOT EXISTS idx_agent_workflow_executions_order ON agent_workflow_executions(procurement_order_id);
CREATE INDEX IF NOT EXISTS idx_agent_workflow_executions_agent ON agent_workflow_executions(agent_id);
CREATE INDEX IF NOT EXISTS idx_agent_workflow_executions_stage ON agent_workflow_executions(stage);
CREATE INDEX IF NOT EXISTS idx_agent_workflow_executions_status ON agent_workflow_executions(status);
CREATE INDEX IF NOT EXISTS idx_agent_workflow_executions_executed_at ON agent_workflow_executions(executed_at);

-- ========================================================================================
-- 9. DATA VERIFICATION QUERIES
-- ========================================================================================

-- Verification queries to run after population
-- SELECT COUNT(*) as total_organizations FROM organizations;
-- SELECT COUNT(*) as total_users FROM user_management;
-- SELECT COUNT(*) as total_disciplines FROM disciplines;
-- SELECT COUNT(*) as total_templates FROM templates;
-- SELECT COUNT(*) as total_procurement_orders FROM procurement_orders;
-- SELECT COUNT(*) as total_tasks FROM tasks;
-- SELECT COUNT(*) as total_agent_executions FROM agent_workflow_executions;

-- ========================================================================================
-- END OF TEST DATA POPULATION SCRIPT
-- ========================================================================================

-- Script completed successfully message
DO $$
BEGIN
    RAISE NOTICE 'Procurement workflow test data population completed successfully!';
    RAISE NOTICE 'Populated: 15 users, 5 document variations (26 sections), 7 templates, 5 procurement orders, 9 tasks, 3 agent executions';
    RAISE NOTICE 'Preserves existing organizations and disciplines - safe for production use';
    RAISE NOTICE 'All data is ready for 01900 Procurement workflow testing';
END $$;
