-- Fix agent company assignments to match current company IDs
-- This script updates agent company_id values to use the correct existing company IDs

BEGIN;

-- Update agents assigned to old QualityForge ID to new QualityForge ID
UPDATE agents
SET company_id = 'a4f9d4c6-33f5-4552-b32d-054552144edf'
WHERE company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef';

-- Update agents assigned to old DevForge ID to DomainForge ID (since DevForge doesn't exist)
UPDATE agents
SET company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
WHERE company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- Update agents assigned to unknown company IDs to appropriate existing companies
-- Map c4d52645-a0ea-4a26-b381-baf0b3042f34 to QualityForge (most agents)
UPDATE agents
SET company_id = 'a4f9d4c6-33f5-4552-b32d-054552144edf'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34';

-- Map f02b83a8-e0db-4332-b507-22f85e71ebf5 to DomainForge
UPDATE agents
SET company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
WHERE company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5';

-- Map other unknown company IDs to InfraForge as fallback
UPDATE agents
SET company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
WHERE company_id NOT IN (
    '09f438a3-4041-46f2-b3cc-96fc9446e666',
    'a4f9d4c6-33f5-4552-b32d-054552144edf',
    '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
);

COMMIT;

-- Verify the results
SELECT company_id, COUNT(*) as agent_count
FROM agents
GROUP BY company_id
ORDER BY company_id;