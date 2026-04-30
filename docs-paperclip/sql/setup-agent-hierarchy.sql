-- Set up proper reporting hierarchy for DevForge AI agents
-- Orion is the CEO, and other agents report to him or to department leads

-- First, set Orion as CEO (no reportsTo)
UPDATE agents
SET "reportsTo" = NULL
WHERE id = 'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5' AND company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- Set up department leads reporting directly to Orion
-- Core Engineering team
UPDATE agents SET "reportsTo" = 'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5' WHERE id IN (
  'eb122591-6cf8-4943-982c-61d8c1b86685', -- Codesmith
  '97c94b57-14f4-4ebd-9a4c-72a0fe3ed248', -- Devcore
  '032fbc48-3fa4-4f95-a636-7c58fe2c7f40'  -- Navigator
) AND company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- Operations & Infrastructure team
UPDATE agents SET "reportsTo" = 'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5' WHERE id IN (
  '77369297-a61e-4de0-a6fb-fd3ef12dda5a', -- Auditor
  'f5f526db-a90a-46d3-9ac6-6c2fc17728ae', -- Pulse
  '11afbdd2-2c17-4dbb-8c0d-6224ca4a2756'  -- Archivist
) AND company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- Business & Strategy team
UPDATE agents SET "reportsTo" = 'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5' WHERE id IN (
  '2604c5a4-3ca5-4f15-8f9c-6164fd359b13', -- Dealmaker
  '380d7281-02a0-4c6b-97f3-9ef6113afbc1', -- Merchant
  '3e0c1736-dd5a-4c6b-a491-4d67ee47ed83'  -- Council - CEO
) AND company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- Research & Analysis team
UPDATE agents SET "reportsTo" = 'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5' WHERE id IN (
  '167acf8b-fe71-4eed-a3ac-7253d9c7e496', -- Analyst
  '73b02951-e5fe-47c5-b545-0e6c2dabf5f3', -- Strategos
  '4513f1f3-c358-497c-b78a-68da507f76ce'  -- Cortex
) AND company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- Set remaining agents to report to department leads
-- Report to Codesmith (Engineering)
UPDATE agents SET "reportsTo" = 'eb122591-6cf8-4943-982c-61d8c1b86685' WHERE id IN (
  '23b3d033-258b-4966-8fb5-170f723459f6', -- Atlas
  '33c442ed-4ef7-4551-b961-285c83132589', -- Automata
  '384dd5fa-eb7d-4d32-991e-e19e70500369', -- Nexus
  '11fd6a80-ec43-4f51-aa7b-1c63cc8cbeee', -- Troubleshooter
  '3de9d650-a847-4797-bc76-11445fe26e61'  -- Schema
) AND company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- Report to Devcore (Engineering)
UPDATE agents SET "reportsTo" = '97c94b57-14f4-4ebd-9a4c-72a0fe3ed248' WHERE id IN (
  '4576b7c0-4ab9-4d81-bdff-fbe0f1e0386a', -- Interface
  '3b761838-89a6-45da-be06-18ece3ff97d8', -- Ambassador
  '31b877aa-b395-49c1-b3b2-98db9665e30c'  -- Amplifier
) AND company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- Report to Auditor (Operations)
UPDATE agents SET "reportsTo" = '77369297-a61e-4de0-a6fb-fd3ef12dda5a' WHERE id IN (
  'd61348bd-e155-441e-b326-8e643d53ea4d', -- Audit
  '4fb09148-b2a9-40fd-b1f2-f237494edf71', -- Bridge
  '66c09f31-7220-428e-a5b3-966e7fabeffb', -- Sentinelx
  'c1d25a53-0124-46de-8aea-4d1f86e00368'  -- Gatekeeper
) AND company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- Report to Pulse (Operations)
UPDATE agents SET "reportsTo" = 'f5f526db-a90a-46d3-9ac6-6c2fc17728ae' WHERE id IN (
  'ba59d5f6-1e10-4250-aba3-e103366a0755', -- Insight
  'ca9d088e-2715-493e-a9c2-f9ed5d278e3f', -- Nova
  '0c3c1351-10a0-44f9-9024-fab45374ec30', -- Pathfinder
  '6ba4f1f9-90aa-44d4-bb3b-6dafc7c7e0ae'  -- Sentinel
) AND company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- Report to Archivist (Operations)
UPDATE agents SET "reportsTo" = '11afbdd2-2c17-4dbb-8c0d-6224ca4a2756' WHERE id IN (
  '431c6ca0-f1d4-43e1-b29e-717154849e86', -- Librarian
  '60f2161d-0fd5-412d-a531-9ae551a985c3', -- Scribe
  '92746d00-aaaa-4abd-9b86-ecf289956e78'  -- Sage
) AND company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- Report to Dealmaker (Business)
UPDATE agents SET "reportsTo" = '2604c5a4-3ca5-4f15-8f9c-6164fd359b13' WHERE id IN (
  'd4249e15-1c8e-4377-a498-f2f6861fbf39', -- Compass
  'ded562f9-ec5f-413f-802d-00db6d5bde85', -- Catalystx
  '0bd13e3f-5382-4e78-a184-b69bc5a1e3dd'  -- Catalyst
) AND company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- Report to Merchant (Business)
UPDATE agents SET "reportsTo" = '380d7281-02a0-4c6b-97f3-9ef6113afbc1' WHERE id IN (
  'fbaadceb-b723-491a-a8d3-53cc6133031c', -- Cartographer
  'a9cb2742-0b0c-49b8-8a9c-7e2b8f5d37f9'  -- Storycraft
) AND company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- Report to Analyst (Research)
UPDATE agents SET "reportsTo" = '167acf8b-fe71-4eed-a3ac-7253d9c7e496' WHERE id IN (
  '1409d6bc-7fa0-4a4b-8d69-c400584cf41a', -- Scout
  '933c5223-0540-48ea-8476-5632b9916939', -- Quantum
  '633d48cb-8f00-4549-854d-4673554c7a38'  -- Query
) AND company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- Report to Strategos (Research)
UPDATE agents SET "reportsTo" = '73b02951-e5fe-47c5-b545-0e6c2dabf5f3' WHERE id IN (
  'ee891841-6ea9-4083-a0d0-d6b03355535f', -- Guardian
  'ecd9bba7-2e91-4ef9-b4f3-bd37a54b818f', -- Voyager
  '2df81c8b-66dc-4060-9061-8aa97cc6a687'  -- Stream
) AND company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- Report to Cortex (Research)
UPDATE agents SET "reportsTo" = '4513f1f3-c358-497c-b78a-68da507f76ce' WHERE id IN (
  'f5cb7532-6758-4880-ab1c-f5aad06d91e4', -- Promptsmith
  'd9ab69e1-ef1c-45b4-8c7d-87d58cd4e797', -- Forge
  '087b7381-036e-4a1c-a21f-8f71ad1cf032'  -- Oracle
) AND company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';

-- Remaining agents report to Orion directly
UPDATE agents SET "reportsTo" = 'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5' WHERE "reportsTo" IS NULL AND id != 'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5' AND company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';