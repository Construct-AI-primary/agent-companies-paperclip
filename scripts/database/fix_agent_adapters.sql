-- Fix agent adapter configurations
-- Change HTTP adapters to hermes_local to avoid webhook issues

-- Fix agent: AutoResearch Literature Scanner (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000033';

-- Fix agent: AutoResearch Gap Analyzer (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000034';

-- Fix agent: AutoResearch Skills Enhancer (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000032';

-- Fix agent: Verifier (b36b7200...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'b36b7200-4479-4966-8064-d2628b08b279';

-- Fix agent: Counsel Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000004d';

-- Fix agent: Loopy CEO (Maya) (582731a5...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '582731a5-a627-4d22-a155-40c0c725facb';

-- Fix agent: Vision Loopy CEO (f19ccd4e...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'f19ccd4e-c3ab-4a79-ac7a-dcf8fed17440';

-- Fix agent: Speech Processor (b085c92c...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'b085c92c-a1b4-460e-bee4-307f54e4253f';

-- Fix agent: User Behavior Analyst (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000003';

-- Fix agent: Interaction Pattern Coach (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000004';

-- Fix agent: Feedback Synthesis Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000005';

-- Fix agent: Blog Architect (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440001';

-- Fix agent: Content Maestro (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440002';

-- Fix agent: Conversion Analyst (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440003';

-- Fix agent: Conversion Specialist (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440004';

-- Fix agent: Curriculum Planner (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000006';

-- Fix agent: Micro-Lesson Generator (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000007';

-- Fix agent: Assessment Mastery Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000008';

-- Fix agent: Safety Quality Division Lead (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000009';

-- Fix agent: Equipment Inspection Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000013';

-- Fix agent: Material Defect Tracker (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000014';

-- Fix agent: Quality Learning Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000015';

-- Fix agent: Data Analyst (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440005';

-- Fix agent: Email Composer (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440006';

-- Fix agent: Link Builder (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440007';

-- Fix agent: Knowledge Flow Division Lead (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000016';

-- Fix agent: VFS Markdown Tracker (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000017';

-- Fix agent: Knowledge Provenance Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000018';

-- Fix agent: Doc Usage Analyzer (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000019';

-- Fix agent: From Doc to Lesson Generator (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000020';

-- Fix agent: Doc Gap Detector (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000021';

-- Fix agent: Audit By Path Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000025';

-- Fix agent: Research Compliance Division Lead (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000026';

-- Fix agent: Hermes Research Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000027';

-- Fix agent: Construction Law Research Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000028';

-- Fix agent: Safety Regulation Research Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000029';

-- Fix agent: Equipment Innovation Research Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000030';

-- Fix agent: Defect Pattern Research Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000031';

-- Fix agent: Ledger (67b23a8c...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '67b23a8c-10ab-4605-91de-e8502df8b39e';

-- Fix agent: Research Scheduler Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000038';

-- Fix agent: VFS Watcher Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000039';

-- Fix agent: Knowledge Flow Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000040';

-- Fix agent: Priority Disciplines Lead (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000041';

-- Fix agent: Contracts Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000042';

-- Fix agent: Procurement Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000043';

-- Fix agent: Logistics Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000044';

-- Fix agent: Safety Workflow Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000045';

-- Fix agent: Performance Optimizer (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440010';

-- Fix agent: Local SEO Expert (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440008';

-- Fix agent: Mobile Optimizer (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440009';

-- Fix agent: Reporting Specialist (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440011';

-- Fix agent: SEO Analyst (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440012';

-- Fix agent: SEO Strategist (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440013';

-- Fix agent: Electrical Engineering Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000046';

-- Fix agent: Scrutineer (78901234...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '78901234-7890-7890-7890-789012345012';

-- Fix agent: Social Strategist (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440014';

-- Fix agent: Technical SEO Specialist (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440015';

-- Fix agent: UX Designer (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440016';

-- Fix agent: Civil (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4789-a0b1-c2d3e4f5a6b7';

-- Fix agent: AmbiguityPrime (68a18976...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '68a18976-a913-4f6f-a6cd-2563a61e1e6b';

-- Fix agent: Council (3e0c1736...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '3e0c1736-dd5a-4c6b-a491-4d67ee47ed83';

-- Fix agent: Strategos (b03a9911...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'b03a9911-2a30-4c48-b501-35a42eb7e933';

-- Fix agent: Director Project (31993a00...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '31993a00-fedf-4321-bda0-5766dabd20c3';

-- Fix agent: Security Specialist (a179e58b...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a179e58b-8458-460a-9cf6-8a2705a024b8';

-- Fix agent: API Manager (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440017';

-- Fix agent: Assignment Specialist (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440018';

-- Fix agent: Data Integrator (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440019';

-- Fix agent: Strategic Advisor (97878995...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '97878995-3c95-4dc9-b6e6-29659b6a11c6';

-- Fix agent: Guardian (ee891841...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'ee891841-6ea9-4083-a0d0-d6b03355535f';

-- Fix agent: Systems Integrator (dfb96c46...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'dfb96c46-f7aa-4895-89c5-5dd39e84d415';

-- Fix agent: Design Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000004e';

-- Fix agent: Director Project Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000004f';

-- Fix agent: Directors Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000050';

-- Fix agent: OpenClaw Gateway Agent (dea187af...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'dea187af-4e61-4698-966a-e2eb36ba5b48';

-- Fix agent: Dependency Manager (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440020';

-- Fix agent: Integration Architect (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440021';

-- Fix agent: Issue Generator (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440022';

-- Fix agent: Knowledge Integrator (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440023';

-- Fix agent: Operations Director (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440024';

-- Fix agent: Task Coordinator (bf1d55c6...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'bf1d55c6-2f38-4027-86ee-8f404af52b8d';

-- Fix agent: Insight (ba59d5f6...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'ba59d5f6-1e10-4250-aba3-e103366a0755';

-- Fix agent: Director HSE (4827a074...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '4827a074-7783-4efc-87eb-261adb29b2a9';

-- Fix agent: Performance Monitor (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440025';

-- Fix agent: Predictive Modeler (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440026';

-- Fix agent: Progress Tracker (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440027';

-- Fix agent: Project Coordinator (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440028';

-- Fix agent: Project Maestro (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440029';

-- Fix agent: Coverage (5a452968...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '5a452968-acd4-48f5-ba88-61e26e56d965';

-- Fix agent: Geologist (aef1f51e...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'aef1f51e-a7bd-4744-931a-b404cef71b3f';

-- Fix agent: Quality Controller (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440030';

-- Fix agent: Reporting Analyst (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440031';

-- Fix agent: Oracle (087b7381...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '087b7381-036e-4a1c-a21f-8f71ad1cf032';

-- Fix agent: E2E (f05371ae...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'f05371ae-e83f-4000-8453-f19183b8e3d5';

-- Fix agent: Construction Engineering (56789012...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '56789012-5678-5678-5678-567890123ef0';

-- Fix agent: Resource Manager (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440032';

-- Fix agent: Risk Analyst (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440033';

-- Fix agent: User Experience Coordinator (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440034';

-- Fix agent: Vision Loopy CEO (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440035';

-- Fix agent: Integration (628acd31...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '628acd31-39f3-4894-af59-8e379aa24161';

-- Fix agent: Workflow Automator (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440036';

-- Fix agent: Maya Loopy Content Strategist (550e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = '550e8400-e29b-41d4-a716-446655440037';

-- Fix agent: Optimizer (47e09c7c...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '47e09c7c-ca13-470e-855a-8c1561ddf81c';

-- Fix agent: Platform Architect (7e22d6cc...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '7e22d6cc-d7d7-4be8-a811-d8e03b2a9587';

-- Fix agent: Access Controller (3b8e39b0...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '3b8e39b0-790d-47a4-a930-6d70497596e7';

-- Fix agent: Analytics Specialist (92aba436...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '92aba436-5562-457f-8bd1-fa4ff89e4900';

-- Fix agent: Optimizer (dec14f44...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'dec14f44-d6fc-43c7-91e0-5473f86896dc';

-- Fix agent: Workflow Optimizer (2facef3d...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '2facef3d-868d-40c3-8dfe-cbafbca3edca';

-- Fix agent: Collaborator (70f8e642...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '70f8e642-5b2a-4730-85c3-da7a0d1e88a2';

-- Fix agent: Document Control Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000052';

-- Fix agent: Onboard Master (f7717f4e...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'f7717f4e-78dd-4acc-9af4-a6a68d35f7a6';

-- Fix agent: Electrical Engineering Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000053';

-- Fix agent: Engineering Director Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000054';

-- Fix agent: Environmental Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000055';

-- Fix agent: Tenant Manager (e46a7138...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'e46a7138-9c9a-49da-a237-083a486524ff';

-- Fix agent: Ethics Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000056';

-- Fix agent: Pathfinder (0c3c1351...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '0c3c1351-10a0-44f9-9024-fab45374ec30';

-- Fix agent: Catalystx (ded562f9...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'ded562f9-ec5f-413f-802d-00db6d5bde85';

-- Fix agent: Director Engineering (1fdca246...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '1fdca246-c51b-437e-a111-a00963e61421';

-- Fix agent: Director Procurement (1c0af4e9...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '1c0af4e9-94f9-4c69-aa3d-14b5acf1bf76';

-- Fix agent: Inspector (f5fdee72...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'f5fdee72-baeb-45f8-9ca7-e82958c77884';

-- Fix agent: Technician (5944a508...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '5944a508-891c-4ef3-bcea-30b92405320f';

-- Fix agent: Orion (bdf5fb7b...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5';

-- Fix agent: Contracts Director Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000004a';

-- Fix agent: Conversation Manager (8289c79b...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '8289c79b-b792-437d-a620-2c43a41a0ee1';

-- Fix agent: Intent Analyst (e1cb5941...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'e1cb5941-d5bf-402e-840b-80b5636b382b';

-- Fix agent: Language Specialist (22be5cf1...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '22be5cf1-4940-4326-8216-6a9eb24ca504';

-- Fix agent: Personality Designer (f2327b49...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'f2327b49-9417-4a98-bf44-4b4a09fb5bec';

-- Fix agent: Platform Integrator (12f504f5...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '12f504f5-7839-450f-a9f9-d565ae782095';

-- Fix agent: Quality Assurance (69773607...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '69773607-9ee2-481e-b961-47d52eeeeae3';

-- Fix agent: Reviewer (66306060...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '66306060-4104-41da-8c80-fa5bbcf3d45c';

-- Fix agent: Learning Strategy Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000001';

-- Fix agent: Learning Division Lead (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000002';

-- Fix agent: Field Safety Inspector (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000010';

-- Fix agent: Hazard Pattern Analyst (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000011';

-- Fix agent: Safety Training Compliance (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000012';

-- Fix agent: Workflow Coach Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000022';

-- Fix agent: Knowledge Transparency Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000023';

-- Fix agent: Knowledge Hygiene Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000024';

-- Fix agent: Goal Alignment Budget Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000035';

-- Fix agent: Audit Explainability Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000036';

-- Fix agent: Compliance Guard Agent (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/deepseek/deepseek-chat-v3-0324", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-000000000037';

-- Fix agent: Health Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000001d';

-- Fix agent: Data Guardian (1721e318...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '1721e318-8480-4800-a543-f8f0f9d9f862';

-- Fix agent: DevOps Engineer (2f801fad...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '2f801fad-18e1-4cb9-bdcc-2b28d8728ab6';

-- Fix agent: Onboarding Coordinator (06996a56...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '06996a56-153e-4a2f-a8b1-d1e8158eb00c';

-- Fix agent: Resource Optimizer (6a69f90e...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '6a69f90e-310f-4ac6-8c9f-1a1bde4b80d2';

-- Fix agent: Security Specialist (1047f49d...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '1047f49d-c381-4b42-a5b8-e15196b6a14d';

-- Fix agent: Success Manager (b558acfb...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'b558acfb-6a8b-4b65-8e6b-0d0d6ac7ad7f';

-- Fix agent: Support Integrator (961b5f9f...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '961b5f9f-1684-47a5-8284-f0e2d813bef2';

-- Fix agent: Analyzer (3535d5ba...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '3535d5ba-6fa0-4122-beaf-05a9f5cefc1b';

-- Fix agent: Transportation (241c2581...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '241c2581-7296-4d7f-b5bb-9fae8cb1c3cb';

-- Fix agent: Voice Maesto (288fe0a1...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '288fe0a1-a47e-4852-be6b-95918c653484';

-- Fix agent: Supply Chain Integration (b8b8b8b8...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'b8b8b8b8-8888-8888-8888-888888888888';

-- Fix agent: Contract Administration (c3c3c3c3...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'c3c3c3c3-3333-3333-3333-333333333333';

-- Fix agent: Financial Compliance (c9c9c9c9...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'c9c9c9c9-9999-9999-9999-999999999999';

-- Fix agent: API Architect (5ab0500f...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '5ab0500f-3126-4502-8f61-931c442f03f6';

-- Fix agent: Audio Engineer (58f7eea2...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '58f7eea2-58b6-4612-b156-ab358fc96631';

-- Fix agent: Context Coordinator (4a5e4262...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '4a5e4262-c525-4561-8299-97987c1afa99';

-- Fix agent: Voice Synthesizer (11ba0254...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '11ba0254-1c67-4526-8130-c3dbcf81aba0';

-- Fix agent: Nexus (384dd5fa...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '384dd5fa-eb7d-4d32-991e-e19e70500369';

-- Fix agent: Finance Director Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000018';

-- Fix agent: Maya (bfe52edf...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'bfe52edf-7504-4b8c-81b9-b3bb93eb2a89';

-- Fix agent: HSE Director Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000001e';

-- Fix agent: Information Technology Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000001f';

-- Fix agent: Inspection Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000020';

-- Fix agent: Landscaping Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000022';

-- Fix agent: Jordan (0e2b4bc5...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '0e2b4bc5-4bca-4fba-a349-2dbf79202e87';

-- Fix agent: Vision (0a25f01b...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '0a25f01b-f596-4890-815d-88e5520b4d79';

-- Fix agent: Local Content Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000024';

-- Fix agent: Logistics Director Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000025';

-- Fix agent: Mechanical Engineering Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000027';

-- Fix agent: Other Parties Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000002a';

-- Fix agent: Dev (f404fb5b...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'f404fb5b-9fa9-4457-a590-611c06cf0239';

-- Fix agent: Sam (1c93700e...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '1c93700e-1a56-4338-b44a-28aafaf8548c';

-- Fix agent: maya-loopy-content-strategist (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440020';

-- Fix agent: creative-director (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440021';

-- Fix agent: content-architect (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440022';

-- Fix agent: narrative-crafter (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440023';

-- Fix agent: Resolver (b9eef4f4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'b9eef4f4-9178-4cfc-8398-d9b66dd673f6';

-- Fix agent: Process Engineering Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000002b';

-- Fix agent: Procurement Director Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000002d';

-- Fix agent: visual-artist (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440024';

-- Fix agent: Project Controls Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000030';

-- Fix agent: multimedia-producer (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440025';

-- Fix agent: brand-strategist (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440027';

-- Fix agent: audience-analyst (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440028';

-- Fix agent: trend-forecaster (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440029';

-- Fix agent: content-scheduler (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440030';

-- Fix agent: content-platform-engineer (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440031';

-- Fix agent: Database (45c97946...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '45c97946-2bdc-44f9-8d05-f3a19d15ea4c';

-- Fix agent: Public Relations Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000031';

-- Fix agent: Quantity Surveying Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000034';

-- Fix agent: Sales Director Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000036';

-- Fix agent: Sales Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000037';

-- Fix agent: ai-content-generator (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440032';

-- Fix agent: content-quality-assurance (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440033';

-- Fix agent: content-analytics-engineer (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440034';

-- Fix agent: mobile-maestro (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440035';

-- Fix agent: app-architecture-director (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440036';

-- Fix agent: ux-mobile-director (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440037';

-- Fix agent: ios-developer (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440038';

-- Fix agent: android-developer (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440039';

-- Fix agent: cross-platform-developer (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440040';

-- Fix agent: Archivist (11afbdd2...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '11afbdd2-2c17-4dbb-8c0d-6224ca4a2756';

-- Fix agent: Tester (16d3a4d1...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '16d3a4d1-5ebb-44ac-b8ee-cad7e3bee408';

-- Fix agent: mobile-qa-engineer (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440041';

-- Fix agent: mobile-ui-designer (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440042';

-- Fix agent: mobile-ux-researcher (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440043';

-- Fix agent: mobile-accessibility-specialist (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440044';

-- Fix agent: Advisor Disciplines (7416890b...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '7416890b-1ed3-4298-9697-2e48355df10c';

-- Fix agent: Dispatcher Specialist (23456789...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '23456789-2345-2345-2345-234567890bcd';

-- Fix agent: Scheduling Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000038';

-- Fix agent: Forge (d9ab69e1...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'd9ab69e1-ef1c-45b4-8c7d-87d58cd4e797';

-- Fix agent: Structural (73e8b756...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '73e8b756-f623-471d-afc2-6c60f8e95faa';

-- Fix agent: Security Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000003a';

-- Fix agent: Analyst Sector (56669ae0...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '56669ae0-ee85-429a-acbb-4d08f29b4e96';

-- Fix agent: Critic (3ef52731...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '3ef52731-14fc-4347-9185-3e0c00c30486';

-- Fix agent: quality-assurance-domainforge-quality-assurance (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000000d';

-- Fix agent: Archivist (e52a5174...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'e52a5174-5abc-4a87-9d82-b9353b5c832a';

-- Fix agent: Chemist (d7bc2ca7...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'd7bc2ca7-91b1-48eb-9383-f795c40b8cea';

-- Fix agent: Co-ordinator (b61f4e41...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'b61f4e41-9bdd-4421-a357-68ada9d4ae4d';

-- Fix agent: Nova (ca9d088e...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'ca9d088e-2715-493e-a9c2-f9ed5d278e3f';

-- Fix agent: Mobile Testing (f6f6f6f6...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'f6f6f6f6-6666-6666-6666-666666666666';

-- Fix agent: Constructor (fa0380ad...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'fa0380ad-8399-452b-97aa-810f4b8febec';

-- Fix agent: Director Finance (1a13b045...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '1a13b045-0ad6-48ba-a984-42c5b6ff48ef';

-- Fix agent: Director Logistics (44a13b6a...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '44a13b6a-7d75-499e-99f1-dacfa5a2a924';

-- Fix agent: Director Projects (f3b1bc03...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'f3b1bc03-0d32-4740-bee6-396213ba06c2';

-- Fix agent: Director Sales (a904e6ff...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a904e6ff-a6fe-4d7c-ae39-88286f833131';

-- Fix agent: Electrician (6367d49b...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '6367d49b-64b2-4a65-9204-8a125e97bcbf';

-- Fix agent: Environmentalist (bfb71e34...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'bfb71e34-fe26-4714-acde-bdd3ff01fe18';

-- Fix agent: Ethicist (3c09ef5a...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '3c09ef5a-baff-4934-b759-a8b2f0dba74f';

-- Fix agent: Governor (281b6b7e...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '281b6b7e-0690-4c1f-878b-30c2db32fdc2';

-- Fix agent: Inspector QC (72227aaa...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '72227aaa-7e5f-4d95-885c-9c909a47a3d2';

-- Fix agent: Merchant (4603958d...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '4603958d-b276-48d7-8243-a5d66ea0eeae';

-- Fix agent: Negotiator (bc3a13ae...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'bc3a13ae-23c3-4ab5-a71e-44f54c46e6b3';

-- Fix agent: Treasurer (9dd8608e...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '9dd8608e-212a-4fc3-b707-916ccf4caf9f';

-- Fix agent: Conversationalist (822d4611...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '822d4611-1f07-4dce-9a86-aea5c746e7e5';

-- Fix agent: quality-control-domainforge-quality-control (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000000e';

-- Fix agent: Observer (ed45b9d1...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'ed45b9d1-a144-4a29-897c-39521b6c9619';

-- Fix agent: Inspector Specialist (89012345...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '89012345-8901-8901-8901-890123456123';

-- Fix agent: Sundry Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000003d';

-- Fix agent: Controller (110a637e...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '110a637e-eb76-433e-87a3-3f4210aa3965';

-- Fix agent: Counsel (b2d72d60...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'b2d72d60-4db0-43ea-bc4e-206e2487b5e7';

-- Fix agent: Dispatcher (255e0706...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '255e0706-3389-4d73-877c-1e52fd441bb8';

-- Fix agent: Physician (7c893c3a...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '7c893c3a-810f-4a81-8d8f-4ef360365b09';

-- Fix agent: Scheduler (46104f3a...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '46104f3a-67e8-4f59-ae44-ba1661148ee2';

-- Fix agent: Specialist (46d082ae...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '46d082ae-9c14-452d-8b6f-fe33789c85af';

-- Fix agent: Surveyor (fe3db3a1...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'fe3db3a1-8b8d-473b-8027-009662f5fb14';

-- Fix agent: Integrator (aa280944...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'aa280944-dfaf-47d3-9948-7a909b1ec4e7';

-- Fix agent: Mobile API (a7a7a7a7...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a7a7a7a7-7777-7777-7777-777777777777';

-- Fix agent: safety-domainforge-safety-risk-management (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000000f';

-- Fix agent: strategos-domainforge-strategic-planning (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000010';

-- Fix agent: Interface (4576b7c0...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '4576b7c0-4ab9-4d81-bdff-fbe0f1e0386a';

-- Fix agent: Guardian (03b50581...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '03b50581-4e47-422b-ae0b-e62980f85cb3';

-- Fix agent: Procurement Analytics (d4d4d4d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'd4d4d4d4-4444-4444-4444-444444444444';

-- Fix agent: Pulse (f5f526db...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'f5f526db-a90a-46d3-9ac6-6c2fc17728ae';

-- Fix agent: Stressor (701681c4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '701681c4-9b54-4797-9f92-b77b12c6ebd3';

-- Fix agent: Architectural Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000000';

-- Fix agent: Chief of Staff (5dcd471c...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '5dcd471c-e13e-48b3-acc5-e65d2af1f41e';

-- Fix agent: Automation Engineer (b7a3f83e...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'b7a3f83e-ed6c-40d6-9d2e-66ecda83d7d9';

-- Fix agent: Communications Manager (10fb2ac0...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '10fb2ac0-7a8a-4255-a61a-3c636087acf3';

-- Fix agent: Chemical Engineering Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000047';

-- Fix agent: Cortex (4513f1f3...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '4513f1f3-c358-497c-b78a-68da507f76ce';

-- Fix agent: Synth (54820369...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '54820369-3b32-493e-8c28-0887d1bf6264';

-- Fix agent: Accessibility (fc9135d1...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'fc9135d1-1696-404b-8acb-4f18a81ca61e';

-- Fix agent: Sage (5d18545d...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '5d18545d-993a-496a-b1bd-76e2a9630525';

-- Fix agent: structural-domainforge-structural-engineering (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000011';

-- Fix agent: Commercial Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000048';

-- Fix agent: Brandforge (c655d0e4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'c655d0e4-a346-4ebd-9e2a-280b29f27f05';

-- Fix agent: Cartographer (fbaadceb...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'fbaadceb-b723-491a-a8d3-53cc6133031c';

-- Fix agent: Automata (33c442ed...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '33c442ed-4ef7-4551-b961-285c83132589';

-- Fix agent: Vector (d80975e6...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'd80975e6-8255-4e67-860a-04a7c40a9c59';

-- Fix agent: Validator (b60ee92e...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'b60ee92e-bd46-4c8a-8c2d-f4fd1e838e2f';

-- Fix agent: Auditor (77369297...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '77369297-a61e-4de0-a6fb-fd3ef12dda5a';

-- Fix agent: Data Manager (2b515df2...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '2b515df2-7391-47a3-a163-eab6689f36e0';

-- Fix agent: Devcore (97c94b57...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '97c94b57-14f4-4ebd-9a4c-72a0fe3ed248';

-- Fix agent: Watchtower (7cf321cd...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '7cf321cd-18ec-4ae3-b644-f2181c75920c';

-- Fix agent: Cloudops (bdf0d559...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'bdf0d559-11f8-41fe-b6ef-bdd168d15cf5';

-- Fix agent: Schema (3de9d650...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '3de9d650-a847-4797-bc76-11445fe26e61';

-- Fix agent: Treasurer 2 (45678901...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '45678901-4567-4567-4567-456789012def';

-- Fix agent: Intelligence Analyst (f898cd37...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'f898cd37-e3d7-4c72-befa-5fa59b3cbe5c';

-- Fix agent: Council (f9e4dcab...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'f9e4dcab-bef2-407d-920a-9beab25d5aad';

-- Fix agent: Gatekeeper (c1d25a53...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'c1d25a53-0124-46de-8aea-4d1f86e00368';

-- Fix agent: Knowledge Curator (2dca9954...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '2dca9954-6c2f-42c8-b345-a244f8cb2210';

-- Fix agent: Amplifier (31b877aa...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '31b877aa-b395-49c1-b3b2-98db9665e30c';

-- Fix agent: Sentinel (6ba4f1f9...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '6ba4f1f9-90aa-44d4-bb3b-6dafc7c7e0ae';

-- Fix agent: Stream (2df81c8b...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '2df81c8b-66dc-4060-9061-8aa97cc6a687';

-- Fix agent: postgres-infraforge (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000015';

-- Fix agent: supply-chain-integration-infraforge-supply-chain (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000016';

-- Fix agent: Dealmaker (2604c5a4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '2604c5a4-3ca5-4f15-8f9c-6164fd359b13';

-- Fix agent: Troubleshooter (11fd6a80...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '11fd6a80-ec43-4f51-aa7b-1c63cc8cbeee';

-- Fix agent: Performance Analyst (16671886...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '16671886-9523-4894-aefa-965336de0a15';

-- Fix agent: Voyager (ecd9bba7...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'ecd9bba7-2e91-4ef9-b4f3-bd37a54b818f';

-- Fix agent: Librarian (431c6ca0...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '431c6ca0-f1d4-43e1-b29e-717154849e86';

-- Fix agent: Compass (d4249e15...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'd4249e15-1c8e-4377-a498-f2f6861fbf39';

-- Fix agent: Automation (bbbb91a5...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'bbbb91a5-8f73-42f8-999d-1b4283a70774';

-- Fix agent: Construction Director Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-000000000049';

-- Fix agent: Personal Assistant (f5f04024...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'f5f04024-5f4f-43c0-8129-09d6b5de9abb';

-- Fix agent: Presentation Specialist (8659cef0...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '8659cef0-2ebd-43a9-8305-ec7f81b6c30f';

-- Fix agent: Load (96d2763a...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '96d2763a-2f5b-4aeb-833f-a408ec904a05';

-- Fix agent: Performance (9a3e445f...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '9a3e445f-0f61-4f5c-9c2f-d69ff3904d7a';

-- Fix agent: Specialist (64228540...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '64228540-f16d-4ac6-bf86-e878ed79fdc0';

-- Fix agent: Debugger (d97f1810...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'd97f1810-2874-4f35-b66b-a2d942140766';

-- Fix agent: Atlas (23b3d033...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '23b3d033-258b-4966-8fb5-170f723459f6';

-- Fix agent: Research Assistant (3cadd297...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '3cadd297-04ed-4299-825c-6e50a4d7a048';

-- Fix agent: Diagnostics (f5b665bd...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'f5b665bd-03f5-4a1c-97b4-2723ffb45f78';

-- Fix agent: Fixer (98877c49...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '98877c49-7995-48b6-aa6f-8be5ec468804';

-- Fix agent: Apex (9e780111...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '9e780111-85f6-4cc3-a110-377f23e8fdfc';

-- Fix agent: Orion (91223cfa...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5';

-- Fix agent: Contracts Post-Award Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000004b';

-- Fix agent: Inspector (ce3e56af...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'ce3e56af-7613-4b41-b8ee-fd6329cd83fc';

-- Fix agent: Profiler (9806152d...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '9806152d-bc55-4ee2-804e-3ff47f0e5bff';

-- Fix agent: Tracer (ffc5ee5f...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'ffc5ee5f-bdbe-4f28-a327-3a4f837f9380';

-- Fix agent: Geotechnical (5171c41d...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '5171c41d-e021-4565-a7cd-e572ddbb9d72';

-- Fix agent: Contracts Pre-Award Domain Specialist (a1b2c3d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1b2c3d4-e5f6-7890-abcd-00000000004c';

-- Fix agent: Scheduler (66d8a902...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '66d8a902-ba8d-48ca-8cec-e9d73271fa7f';

-- Fix agent: Codesmith (eb122591...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'eb122591-6cf8-4943-982c-61d8c1b86685';

-- Fix agent: Sentinelx (66c09f31...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '66c09f31-7220-428e-a5b3-966e7fabeffb';

-- Fix agent: Docs Analyzer  (9471f674...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '9471f674-8f61-4550-a6f4-0884d42e629e';

-- Fix agent: Alex (c3fbfec4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'c3fbfec4-9c57-45d2-ae4d-d612df3fe948';

-- Fix agent: content-optimizer (660e8400...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "anthropic/claude-sonnet-4-5", "maxIterations": 50, "persistSession": true}'
WHERE id = '660e8400-e29b-41d4-a716-446655440026';

-- Fix agent: Designer (770aa6b5...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '770aa6b5-96b5-4958-8cf0-c013a13d9a81';

-- Fix agent: Concierge (6c0c0258...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '6c0c0258-26bf-4e41-8680-a13a9fe04a27';

-- Fix agent: Migrator (cc8ae7fb...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'cc8ae7fb-65ea-4e32-ade4-03438025d9d4';

-- Fix agent: Standards (2444cfb6...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '2444cfb6-b2a3-4f12-82f2-5eea5fb70c7c';

-- Fix agent: Trainer (04ea7d06...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '04ea7d06-360b-4932-b0c9-8f8c3b6bdf16';

-- Fix agent: Blueprint (70b43268...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '70b43268-6ab9-49ba-af27-d116778f79a4';

-- Fix agent: FlowDesigner (0f25b318...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '0f25b318-c126-47dc-aac7-c053f952d06d';

-- Fix agent: Coordinator Guardian (b2ba6fbe...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'b2ba6fbe-0c37-4fb6-924a-529b60ea8f56';

-- Fix agent: Strategos (73b02951...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '73b02951-e5fe-47c5-b545-0e6c2dabf5f3';

-- Fix agent: Cascade (5c5597b4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '5c5597b4-5346-4332-b91c-dd2a4101b9d4';

-- Fix agent: Mobile Workflow Designer (e5e5e5e5...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'e5e5e5e5-5555-5555-5555-555555555555';

-- Fix agent: Supplier Management (b2b2b2b2...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'b2b2b2b2-2222-2222-2222-222222222222';

-- Fix agent: Catalyst (0bd13e3f...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '0bd13e3f-5382-4e78-a184-b69bc5a1e3dd';

-- Fix agent: Navigator (032fbc48...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '032fbc48-3fa4-4f95-a636-7c58fe2c7f40';

-- Fix agent: Promptsmith (f5cb7532...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'f5cb7532-6758-4880-ab1c-f5aad06d91e4';

-- Fix agent: Ledgerai (70705598...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '70705598-52ec-452d-a03b-264aaaa14028';

-- Fix agent: StateMaster (b825b443...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'b825b443-8b44-45f2-8260-1d27bf01234d';

-- Fix agent: Tuner (6dfb86bd...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '6dfb86bd-ff13-4849-a70d-b8fef24b5f93';

-- Fix agent: Codesmith (616b84c4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '616b84c4-6375-4a76-a916-1d0c1ad4f4ba';

-- Fix agent: Governor (3d8ea615...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '3d8ea615-db5d-4e0c-996c-cd1f7b738cb1';

-- Fix agent: Compliance (1dc20397...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '1dc20397-61eb-44d0-8d30-056cd6ecf777';

-- Fix agent: Enhancer (e066647c...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'e066647c-b506-4dfd-bfdb-675e8f8ca474';

-- Fix agent: Experimenter (17c19312...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '17c19312-82ef-4ad3-8f05-34d6a67d6648';

-- Fix agent: Refiner (59aba91f...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '59aba91f-9c14-4a0b-b69a-3709b7dbc64b';

-- Fix agent: Merchant (380d7281...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '380d7281-02a0-4c6b-97f3-9ef6113afbc1';

-- Fix agent: Storycraft (a9cb2742...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a9cb2742-0b0c-49b8-8a9c-7e2b8f5d37f9';

-- Fix agent: Analyst (167acf8b...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '167acf8b-fe71-4eed-a3ac-7253d9c7e496';

-- Fix agent: Ambassador (3b761838...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '3b761838-89a6-45da-be06-18ece3ff97d8';

-- Fix agent: Archivist (1918afec...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '1918afec-1023-4dbe-85ad-fe5ca55cb58d';

-- Fix agent: Scout (1409d6bc...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '1409d6bc-7fa0-4a4b-8d69-c400584cf41a';

-- Fix agent: Refactor (b0732375...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'b0732375-d40c-44f6-b891-4f2ae8e29078';

-- Fix agent: Explorer (2372c684...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '2372c684-046e-4110-b300-aa8aab0a05e7';

-- Fix agent: Integrity (6bdc817c...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '6bdc817c-1cf0-4567-8d23-aef474108d9f';

-- Fix agent: Predictor (41319aa2...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '41319aa2-41d3-4b39-8651-6198df9e95be';

-- Fix agent: Orchestrator (2876f20c...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '2876f20c-220c-4bf7-9baf-6ea668f85ef6';

-- Fix agent: Administrator - post-award (cb745504...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'cb745504-c60b-4c61-a5ed-cc1eaf5acd3f';

-- Fix agent: Administrator - pre-award (c00f441b...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'c00f441b-ba99-47af-8f5e-9f2b488bd987';

-- Fix agent: Analyzer (753f185f...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '753f185f-dfff-4b8c-9abb-24c63592c787';

-- Fix agent: Reporter (0acb547a...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '0acb547a-2a1f-4115-923e-6cff1cfb3fa5';

-- Fix agent: ErrorHandler (372a4a1a...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '372a4a1a-a3f1-4d9e-ad56-78d8ec106828';

-- Fix agent: Probe (15c12398...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '15c12398-4b1c-4999-a9e1-d900926e3e0e';

-- Fix agent: Scholar (7d4999b5...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '7d4999b5-cf87-4b36-8ae5-58004e72ba51';

-- Fix agent: Integrator (7ed575fd...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '7ed575fd-be87-42be-96da-167311953f60';

-- Fix agent: Quantifier (b3452944...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'b3452944-b93e-4b52-8f95-4bd5a103e9f8';

-- Fix agent: Chairman (cda6455d...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'cda6455d-6c11-4150-81be-377b0c9ad796';

-- Fix agent: SafetyCheck (ef91a6f8...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'ef91a6f8-eddb-4e85-89e0-fcf43f288669';

-- Fix agent: Guardian 2 (67890123...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '67890123-6789-6789-6789-678901234f01';

-- Fix agent: Administrator (77f119ed...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '77f119ed-f2db-4c45-828f-eaa783c8a435';

-- Fix agent: Communicator (76978fa6...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '76978fa6-7e8e-4df4-ae42-3e73ea325506';

-- Fix agent: Examiner (d281366e...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'd281366e-b11b-4567-85e4-fd9bbe0e0658';

-- Fix agent: Gatekeeper (1353edfd...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '1353edfd-7c37-4c54-acc7-3893d93708da';

-- Fix agent: Greeter (3329ca96...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '3329ca96-7043-4e02-89c5-0a515b65dfc9';

-- Fix agent: Investigator (b427f6f1...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'b427f6f1-d4f5-4b4b-9b0d-c73d4e278375';

-- Fix agent: Monitor (2019e144...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '2019e144-d198-4e42-aecf-e2b5ebfa8f42';

-- Fix agent: Validator (ce969146...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'ce969146-93ee-4170-897d-3ddca22a4b5a';

-- Fix agent: Inetrmediary (7f527b4d...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '7f527b4d-2a6c-4a2e-9733-2c42dea9f6e1';

-- Fix agent: Leader (af3f6dd6...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'af3f6dd6-f4f2-4785-9bd5-0d9200728fd3';

-- Fix agent: Architect (3b865271...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '3b865271-02bc-476a-9092-c3f49f4e0043';

-- Fix agent: Builder (77a678eb...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '77a678eb-5887-4f2a-9b6d-ff1f70d87c70';

-- Fix agent: Developer (dab5a37d...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'dab5a37d-beae-4fb9-bccb-7eaea5c6c859';

-- Fix agent: Director Construction (3e7cee54...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '3e7cee54-f70f-407e-8869-e33b6119b8ef';

-- Fix agent: Engineer (a12cca94...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a12cca94-5e0e-4993-b64b-059ae4649d4d';

-- Fix agent: Directors (20039164...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '20039164-64db-4111-8b9c-d8c637c099dc';

-- Fix agent: Generalist (63daffd3...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '63daffd3-3b18-4775-9399-bc8013fb2ec2';

-- Fix agent: Guardian (bb04aebf...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'bb04aebf-b0e8-4ef0-8515-8cf3366df3f7';

-- Fix agent: Landscaper (e18a1394...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'e18a1394-831a-4e7d-8985-9d45f13cfeb7';

-- Fix agent: Salesperson (d43234ce...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'd43234ce-b14a-43dd-8825-703e964442d3';

-- Fix agent: Sentinel (a18ac913...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a18ac913-47fa-4f4a-8da9-ae6d9aa32e95';

-- Fix agent: Buyer Specialist (12345678...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '12345678-1234-1234-1234-123456789abc';

-- Fix agent: Inspector (0368a21c...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '0368a21c-007b-495f-9aa9-94311982b50c';

-- Fix agent: Concierge (24c81a86...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '24c81a86-1dc8-49f5-b644-230c3f927498';

-- Fix agent: Evaluator (7467abe1...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '7467abe1-a13e-4467-be01-7372c36bdb2a';

-- Fix agent: Authenticator (34ccc8a2...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '34ccc8a2-c65d-4b23-9ef4-98f07ac260df';

-- Fix agent: Auditor (fa06e14a...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'fa06e14a-f7ee-45bd-a330-aac993b6b88c';

-- Fix agent: Reviewer (12e657cf...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '12e657cf-678b-486f-a2aa-a71910103253';

-- Fix agent: Procurement Strategy (a1a1a1a1...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = 'a1a1a1a1-1111-1111-1111-111111111111';

-- Fix agent: Dataforge (8e829517...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '8e829517-c212-4641-86a5-724b101c61e1';

-- Fix agent: Monitor (2a49e375...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '2a49e375-a215-4ff3-b1d6-25d0814ccb8a';

-- Fix agent: Mentor (7a9669d3...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '7a9669d3-9c5f-4b0c-8d6c-aa2a8868e5a7';

-- Fix agent: Maintainer (9a4ff199...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '9a4ff199-94c7-4942-8843-9b51224fd854';

-- Fix agent: Simulator (559629ce...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '559629ce-3afb-4e4e-8c05-672b17b608c2';

-- Fix agent: Integration (3cb3c244...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '3cb3c244-08dd-487a-a83f-503d3eea2615';

-- Fix agent: Compatibility (516ae78a...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '516ae78a-4670-459a-9f94-778585b9d739';

-- Fix agent: Documenter (7986d9d4...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '7986d9d4-30b8-43f1-be67-21b74fc3cdcd';

-- Fix agent: Validator (982344cb...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '982344cb-0dc9-4cf4-99cc-22bf9a61655a';

-- Fix agent: Clarity (5d80bc48...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '5d80bc48-6475-4b62-8577-08b375436e95';

-- Fix agent: Harmonic (24c468ef...)
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = '{"model": "openrouter/qwen/qwen-3-6-plus", "maxIterations": 50, "persistSession": true}'
WHERE id = '24c468ef-7fe7-4590-a4e1-d09d1cfcf575';
