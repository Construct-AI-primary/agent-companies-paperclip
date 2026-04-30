-- User Management Test Data for 01900 Procurement Workflow
-- Provides comprehensive user data with discipline assignments for workflow testing

INSERT INTO user_management (
    user_id,
    email,
    full_name,
    job_title,
    department,
    disciplines,
    organization_id,
    is_active,
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

-- Add user management indexes
CREATE INDEX IF NOT EXISTS idx_user_management_email ON user_management(email);
CREATE INDEX IF NOT EXISTS idx_user_management_organization ON user_management(organization_id);
CREATE INDEX IF NOT EXISTS idx_user_management_active ON user_management(is_active);
CREATE INDEX IF NOT EXISTS idx_user_management_department ON user_management(department);
