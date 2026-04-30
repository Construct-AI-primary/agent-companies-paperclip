-- Document Variation Sections Test Data for 01900 Procurement Workflow
-- Defines which sections are included in each document variation

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

-- Add indexes for document variation sections
CREATE INDEX IF NOT EXISTS idx_document_variation_sections_variation ON document_variation_sections(variation_id);
CREATE INDEX IF NOT EXISTS idx_document_variation_sections_order ON document_variation_sections(variation_id, display_order);
