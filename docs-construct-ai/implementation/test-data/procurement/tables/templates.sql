-- Templates Test Data for 01900 Procurement Workflow
-- Provides comprehensive template data for procurement document generation

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
    'uuid-template-001',
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
    '["purchase_order", "service_order"]'::jsonb
),
(
    'uuid-template-002',
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
    '["supplier_evaluation", "vendor_assessment"]'::jsonb
),
(
    'uuid-template-003',
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
    '["contractor_review", "performance_evaluation", "vendor_assessment"]'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440201',
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
    '["purchase_order"]'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440202',
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
    '["service_order"]'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440203',
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
    '["work_order"]'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440204',
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
    '["purchase_order"]'::jsonb
),
(
    '550e8400-e29b-41d4-a716-446655440205',
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
    '["service_order"]'::jsonb
) ON CONFLICT (id) DO NOTHING;

-- Add template indexes
CREATE INDEX IF NOT EXISTS idx_templates_type ON templates(type);
CREATE INDEX IF NOT EXISTS idx_templates_discipline ON templates(discipline);
CREATE INDEX IF NOT EXISTS idx_templates_organization ON templates(organization_id);
CREATE INDEX IF NOT EXISTS idx_templates_active ON templates(is_active);
CREATE INDEX IF NOT EXISTS idx_templates_status ON templates(processing_status);
