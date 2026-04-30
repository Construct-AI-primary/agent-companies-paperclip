-- Document Variations Test Data for 01900 Procurement Workflow
-- Provides document ordering variations for procurement templates

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
    'uuid-user-proc-001',
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
    'uuid-user-proc-001',
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
    'uuid-user-proc-001',
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
    'uuid-user-proc-001',
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
    'uuid-user-proc-001',
    '2026-01-01T10:00:00Z',
    '2026-01-01T10:00:00Z'
) ON CONFLICT (id) DO NOTHING;

-- Add indexes for document variations
CREATE INDEX IF NOT EXISTS idx_document_variations_discipline ON document_variations(discipline_code);
CREATE INDEX IF NOT EXISTS idx_document_variations_organization ON document_variations(organization_id);
CREATE INDEX IF NOT EXISTS idx_document_variations_template ON document_variations(template_variation);
