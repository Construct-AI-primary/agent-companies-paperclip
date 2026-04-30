-- ============================================================
-- FIX NAMES FOR: voiceforge-ai
-- Company ID: 550e8400-e29b-41d4-a716-446655440012
-- Agents: 12
-- Uses UPDATE to fix name field on existing agents
-- Handles malformed YAML with regex extraction
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'API Architect'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440012'
  AND title = 'voiceforge-ai-apiarchitect'
  AND name IS DISTINCT FROM 'API Architect';

UPDATE agents
SET name = 'Audio Engineer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440012'
  AND title = 'voiceforge-ai-audioengineer'
  AND name IS DISTINCT FROM 'Audio Engineer';

UPDATE agents
SET name = 'Context Coordinator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440012'
  AND title = 'voiceforge-ai-contextcoordinator'
  AND name IS DISTINCT FROM 'Context Coordinator';

UPDATE agents
SET name = 'Conversation Manager'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440012'
  AND title = 'voiceforge-ai-conversationmanager'
  AND name IS DISTINCT FROM 'Conversation Manager';

UPDATE agents
SET name = 'Intent Analyst'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440012'
  AND title = 'voiceforge-ai-intentanalyst'
  AND name IS DISTINCT FROM 'Intent Analyst';

UPDATE agents
SET name = 'Language Specialist'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440012'
  AND title = 'voiceforge-ai-languagespecialist'
  AND name IS DISTINCT FROM 'Language Specialist';

UPDATE agents
SET name = 'Personality Designer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440012'
  AND title = 'voiceforge-ai-personalitydesigner'
  AND name IS DISTINCT FROM 'Personality Designer';

UPDATE agents
SET name = 'Platform Integrator'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440012'
  AND title = 'voiceforge-ai-platformintegrator'
  AND name IS DISTINCT FROM 'Platform Integrator';

UPDATE agents
SET name = 'Quality Assurance'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440012'
  AND title = 'voiceforge-ai-qualityassurance'
  AND name IS DISTINCT FROM 'Quality Assurance';

UPDATE agents
SET name = 'Speech Processor'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440012'
  AND title = 'voiceforge-ai-speechprocessor'
  AND name IS DISTINCT FROM 'Speech Processor';

UPDATE agents
SET name = 'Voice Maestro'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440012'
  AND title = 'voiceforge-ai-voicemaestro'
  AND name IS DISTINCT FROM 'Voice Maestro';

UPDATE agents
SET name = 'Voice Synthesizer'
WHERE company_id = '550e8400-e29b-41d4-a716-446655440012'
  AND title = 'voiceforge-ai-voicesynthesizer'
  AND name IS DISTINCT FROM 'Voice Synthesizer';

COMMIT;

