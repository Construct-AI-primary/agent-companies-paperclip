
INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '032fbc48-3fa4-4f95-a636-7c58fe2c7f40',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Navigator',
  'data',
  'Data Discovery',
  'Data catalog development and maintenance; Data lineage tracking and management; Data discovery and exploration tools; Metadata management and governance',
  'active',
  '8e829517-c212-4641-86a5-724b101c61e1',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:32:54.354+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-navigator"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search","lcm_grep"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '03573ca2-ac7d-44bf-951b-dca024ed0c82',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'CEO 2',
  'ceo',
  '',
  '',
  'terminated',
  NULL,
  '2026-04-03 08:03:58.063984+00',
  '2026-04-03 08:18:53.501+00',
  '{}',
  '{"canCreateAgents":true}',
  '{"heartbeat":{"enabled":true,"cooldownSec":10,"intervalSec":3600,"wakeOnDemand":true,"maxConcurrentRuns":1}}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '0368a21c-007b-495f-9aa9-94311982b50c',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Inspector',
  'testing',
  'Environment Validation Specialist',
  '\["env-validation","testing-verification"]',
  'idle',
  NULL,
  '2026-04-05 07:33:41.596229+00',
  '2026-04-09 11:25:21.992+00',
  '{"skills":["env-validation-devforge","testing-verification"],"testing_documents":["environment-switching-production-testing"]}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '03b50581-4e47-422b-ae0b-e62980f85cb3',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Guardian',
  'quality',
  'Quality Guardian',
  'Quality assurance; Process compliance; Standard enforcement; Quality monitoring',
  'error',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:58:09.858+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-guardian"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain","lcm"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '04ea7d06-360b-4932-b0c9-8f8c3b6bdf16',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Trainer',
  'quality',
  'Quality Trainer',
  'Quality training; Team education; Best practices; Skill development',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 12:01:30.77+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-trainer"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '087b7381-036e-4a1c-a21f-8f71ad1cf032',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Oracle',
  'strategy',
  'Predictive Analytics',
  'Predictive modeling and analysis; Business forecasting and trend prediction; Risk assessment and mitigation; Strategic scenario planning',
  'active',
  '3e0c1736-dd5a-4c6b-a491-4d67ee47ed83',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:31:57.751+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-oracle"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search","lcm_grep"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '0acb547a-2a1f-4115-923e-6cff1cfb3fa5',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Reporter',
  'quality',
  'Quality Reporter',
  'Quality reporting; Metrics dashboards; Status updates; Executive summaries',
  'error',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 12:00:32.799+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-reporter"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '0bd13e3f-5382-4e78-a184-b69bc5a1e3dd',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Catalyst',
  'product',
  'Product Innovation',
  'Product innovation and ideation; Feature development and enhancement; User experience optimization; Market trend analysis and adaptation',
  'active',
  '23b3d033-258b-4966-8fb5-170f723459f6',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:30:26.564+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-catalyst"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search","lcm_grep"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '0c3c1351-10a0-44f9-9024-fab45374ec30',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Pathfinder',
  'strategy',
  'Opportunity Identification',
  'Strategic opportunity identification; Market positioning analysis; Competitive advantage development; Growth opportunity assessment',
  'active',
  '3e0c1736-dd5a-4c6b-a491-4d67ee47ed83',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:32:16.735+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-pathfinder"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search","lcm_grep"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '0e2b4bc5-4bca-4fba-a349-2dbf79202e87',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Jordan',
  'creative',
  'Marketing Specialist',
  'Creative marketing campaign development; Brand positioning and messaging strategy; Digital marketing and social media management; Market research and customer insights',
  'idle',
  '935a91fc-e0de-4c9a-a552-d1803ccb2be1',
  '2026-03-25 06:51:52.033968+00',
  '2026-04-09 10:24:48.532+00',
  '{"team":"loopy","source":"loopy-fix","division":"creative","reports_to":"loopy-ceo"}',
  '{"canCreateAgents":false}',
  '{"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '0f25b318-c126-47dc-aac7-c053f952d06d',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'FlowDesigner',
  'orchestration_logic',
  'Agent Handoff & Orchestration Logic',
  '["handoff-protocols", "orchestration-logic", "transition-optimization"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:19:38.109+00',
  '{"division":"Architecture","expertise":"Handoff protocols, orchestration logic, transition optimization"}',
  '{"canCreateAgents":false}',
  '{"context_window":10000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '110a637e-eb76-433e-87a3-3f4210aa3965',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Controller',
  'project-controls',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:40:13.428+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '11afbdd2-2c17-4dbb-8c0d-6224ca4a2756',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Archivist',
  'security',
  'Knowledge Security',
  'Knowledge base security management; Information classification and protection; Data encryption and security; Access control for knowledge systems',
  'active',
  '03b50581-4e47-422b-ae0b-e62980f85cb3',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:25:43.978+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-archivist"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '11fd6a80-ec43-4f51-aa7b-1c63cc8cbeee',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Troubleshooter',
  'engineering',
  'Bug Fixing and Optimization',
  'Bug identification and resolution; Performance optimization and tuning; System debugging and troubleshooting; Code refactoring and improvement',
  'idle',
  'd9ab69e1-ef1c-45b4-8c7d-87d58cd4e797',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-10 11:09:31.016+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-fixer"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '12345678-1234-1234-1234-123456789abc',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Buyer Specialist',
  'specialist',
  'Procurement and Contracts Specialist',
  'Procurement strategy and vendor management. Handles contract negotiation, supplier evaluation, procurement planning, cost optimization, and supply chain integration.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-30 15:54:15+00',
  '2026-04-10 05:22:49.148+00',
  '{"team":"DomainForge AI","specialization":"Procurement and Contracts"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '12e657cf-678b-486f-a2aa-a71910103253',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Reviewer',
  'engineering',
  'Code Review & Quality Assurance',
  'Code review and quality assessment; Best practices enforcement; Security vulnerability detection; Performance optimization recommendations; Workflow quality assurance and validation; Quality gate management and enforcement',
  'error',
  'd9ab69e1-ef1c-45b4-8c7d-87d58cd4e797',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-10 12:18:33.755+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-reviewer"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '1353edfd-7c37-4c54-acc7-3893d93708da',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Gatekeeper',
  'auth-flow',
  '',
  '',
  'idle',
  '56669ae0-ee85-429a-acbb-4d08f29b4e96',
  '2026-04-06 07:12:13.354051+00',
  '2026-04-09 12:51:09.034+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '1409d6bc-7fa0-4a4b-8d69-c400584cf41a',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Scout',
  'strategy',
  'Competitive Intelligence',
  'Competitive intelligence gathering; Market surveillance and monitoring; Industry trend analysis; Strategic threat identification',
  'active',
  '3e0c1736-dd5a-4c6b-a491-4d67ee47ed83',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:32:29.951+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-scout"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search","lcm_grep"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '15c12398-4b1c-4999-a9e1-d900926e3e0e',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Probe',
  'testing_specialist',
  'Prompt Testing & Validation',
  '["testing-methodologies", "validation-frameworks", "quality-assurance"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:20:42.828+00',
  '{"division":"Testing","expertise":"Testing methodologies, validation frameworks, quality assurance"}',
  '{"canCreateAgents":false}',
  '{"context_window":3000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '167acf8b-fe71-4eed-a3ac-7253d9c7e496',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Analyst',
  'strategy',
  'Market Analysis',
  'Market research and trend analysis; Competitive intelligence gathering; Industry analysis and forecasting; Strategic opportunity identification',
  'active',
  '3e0c1736-dd5a-4c6b-a491-4d67ee47ed83',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:31:23.983+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-analyst"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search","lcm_grep"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '16d3a4d1-5ebb-44ac-b8ee-cad7e3bee408',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Tester',
  'testing',
  'Browser UI & Navigation Testing Specialist',
  '\["browser-ui-testing","navigation-sitemap-testing","templates-forms-testing","document-management-testing","agent-systems-testing","advanced-features-testing","ux-research-testing","accordion-testing","testing-verification","error-monitoring-testing","performance-testing","i18n-testing"]',
  'idle',
  NULL,
  '2026-04-05 07:33:41.596229+00',
  '2026-04-09 11:55:02.679+00',
  '{"skills":["browser-ui-testing-qualityforge","navigation-sitemap-testing-qualityforge","templates-forms-testing-qualityforge","document-management-testing-qualityforge","agent-systems-testing-qualityforge","advanced-features-testing-qualityforge","ux-research-testing-loopy","accordion-testing","testing-verification","error-monitoring-testing-qualityforge","performance-testing-qualityforge","i18n-testing-qualityforge"],"testing_documents":["tier1","tier2","tier3","tier4","accordion","ui-settings","non-discipline","discipline"]}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '17c19312-82ef-4ad3-8f05-34d6a67d6648',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Experimenter',
  'innovation_researcher',
  'Hypothesis Testing & Innovation',
  '["experimental-design", "hypothesis-testing", "innovation-methods"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:19:13.831+00',
  '{"division":"Research","expertise":"Experimental design, hypothesis testing, innovation methods"}',
  '{"canCreateAgents":false}',
  '{"context_window":11000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '185ae184-3bb2-48ba-aa89-6dce74cc3422',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'HorizonChief',
  'ceo',
  '',
  '',
  'terminated',
  NULL,
  '2026-03-24 11:01:58.180877+00',
  '2026-03-25 11:23:09.213+00',
  '{}',
  '{"canCreateAgents":true}',
  '{"heartbeat":{"enabled":true,"cooldownSec":10,"intervalSec":3600,"wakeOnDemand":true,"maxConcurrentRuns":1}}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '1918afec-1023-4dbe-85ad-fe5ca55cb58d',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Archivist',
  'knowledge_base_manager',
  'Prompt Library & Knowledge Base Management',
  '["knowledge-management", "library-curation", "information-organization"]',
  'active',
  '03b50581-4e47-422b-ae0b-e62980f85cb3',
  '2026-03-29 09:55:37.044167+00',
  '2026-04-09 12:16:57.777+00',
  '{"division":"Research","expertise":"Knowledge management, library curation, information organization"}',
  '{"canCreateAgents":false}',
  '{"context_window":10000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '1a13b045-0ad6-48ba-a984-42c5b6ff48ef',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Director Finance',
  'finance-director',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:41:50.827+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '1c0af4e9-94f9-4c69-aa3d-14b5acf1bf76',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Director Procurement',
  'procurement-director',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:42:24.13+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '1c93700e-1a56-4338-b44a-28aafaf8548c',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Sam',
  'creative',
  'Social Media Coordinator',
  'Social media content creation and scheduling; Community management and engagement; Social media analytics and performance optimization; Trend monitoring and social listening',
  'idle',
  '935a91fc-e0de-4c9a-a552-d1803ccb2be1',
  '2026-03-25 06:51:52.033968+00',
  '2026-04-09 10:25:05.421+00',
  '{"team":"loopy","source":"loopy-fix","division":"creative","reports_to":"loopy-ceo"}',
  '{"canCreateAgents":false}',
  '{"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '1dc20397-61eb-44d0-8d30-056cd6ecf777',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Compliance',
  'regulatory_specialist',
  'Regulatory Compliance & Standards',
  '["regulatory-compliance", "standards-adherence", "legal-requirements"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:18:38.33+00',
  '{"division":"Research","expertise":"Regulatory compliance, standards adherence, legal requirements"}',
  '{"canCreateAgents":false}',
  '{"context_window":4000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '1f77a032-e469-4a85-ae18-c52b792114d8',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Unittest',
  'testing',
  'Unit Testing Specialist',
  'Unit test development; Test automation; Code coverage analysis; Testing frameworks',
  'terminated',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-03-25 05:19:42.380768+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-unittest"}',
  '{"workspace_scope":"submodule_only","max_concurrent_requests":5}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"]}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '1fdca246-c51b-437e-a111-a00963e61421',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Director Engineering',
  'engineering-director',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:41:32.725+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '20039164-64db-4111-8b9c-d8c637c099dc',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Directors',
  'directors',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:43:15.63+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '2019e144-d198-4e42-aecf-e2b5ebfa8f42',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Monitor',
  'app-guardian',
  '',
  '',
  'idle',
  '3ef52731-14fc-4347-9185-3e0c00c30486',
  '2026-04-06 04:25:54.373821+00',
  '2026-04-09 12:52:25.219+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '23456789-2345-2345-2345-234567890bcd',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Dispatcher Specialist',
  'specialist',
  'Logistics and Supply Chain Specialist',
  'Supply chain and logistics management. Handles logistics planning, inventory management, transportation coordination, distribution optimization, and supply chain risk management.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-30 15:54:20+00',
  '2026-04-10 05:23:50.394+00',
  '{"team":"DomainForge AI","specialization":"Logistics and Supply Chain"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '2372c684-046e-4110-b300-aa8aab0a05e7',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Explorer',
  'research_specialist',
  'New Techniques & Methodologies',
  '["research-methodology", "trend-analysis", "technique-evaluation"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 09:55:37.044167+00',
  '2026-04-09 12:19:23.414+00',
  '{"division":"Research","expertise":"Research methodology, trend analysis, technique evaluation"}',
  '{"canCreateAgents":false}',
  '{"context_window":14000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '23b3d033-258b-4966-8fb5-170f723459f6',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Atlas',
  'product',
  'Product Mapping',
  'Product architecture design and documentation; System mapping and integration planning; Product roadmap development; Feature prioritization and planning',
  'active',
  'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:27:11.05+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-atlas"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search","lcm_grep"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '241c2581-7296-4d7f-b5bb-9fae8cb1c3cb',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Transportation',
  'engineer',
  'Transportation Engineering Specialist',
  'Highway, railway, and transportation infrastructure design. Handles geometric design and alignment, traffic engineering and capacity analysis, intersection and interchange design, and transportation safety analysis.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-30 15:54:10.681+00',
  '2026-03-30 15:54:10.681+00',
  '{"team":"DomainForge AI","discipline":"Transportation Engineering"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '2444cfb6-b2a3-4f12-82f2-5eea5fb70c7c',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Standards',
  'quality',
  'Standards Enforcer',
  'Coding standards; Quality gates; Compliance checking; Best practices enforcement',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 12:01:09.405+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-standards"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal","lcm_grep"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '2490131b-8afe-458b-afb9-102f239bc590',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Sentinel',
  'testing',
  'Security Testing Specialist',
  'Security testing; Vulnerability scanning; Penetration testing; Security audits',
  'terminated',
  NULL,
  '2026-03-25 05:19:42.380768+00',
  '2026-03-25 05:19:42.380768+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-security-test"}',
  '{"workspace_scope":"team","max_concurrent_requests":5}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain","openstinger"]}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '24c468ef-7fe7-4590-a4e1-d09d1cfcf575',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Harmonic',
  'orchestration_strategist',
  'Orchestration Strategy & Multi-Agent Coordination',
  '["multi-agent-systems", "workflow-optimization", "orchestration-strategy"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 09:55:37.044167+00',
  '2026-04-09 12:19:56.665+00',
  '{"division":"Executive Leadership","expertise":"Multi-agent systems, workflow optimization, systems thinking"}',
  '{"canCreateAgents":false}',
  '{"context_window":10000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '24c81a86-1dc8-49f5-b644-230c3f927498',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Concierge',
  'product',
  'Customer Experience',
  'Customer experience design and optimization; User support and assistance; Feedback collection and analysis; Customer satisfaction monitoring',
  'active',
  '23b3d033-258b-4966-8fb5-170f723459f6',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:30:38.445+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-concierge"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain","lcm"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '255e0706-3389-4d73-877c-1e52fd441bb8',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Dispatcher',
  'logistics',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:43:39.308+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '2604c5a4-3ca5-4f15-8f9c-6164fd359b13',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Dealmaker',
  'growth',
  'Sales and Negotiation',
  'Sales strategy development and execution; Business negotiation and contract management; Revenue growth and pipeline management; Customer relationship management',
  'active',
  '380d7281-02a0-4c6b-97f3-9ef6113afbc1',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:37:03.232+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-dealmaker"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain","lcm"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '281b6b7e-0690-4c1f-878b-30c2db32fdc2',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Governor',
  'governance',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:46:32.9+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '2876f20c-220c-4bf7-9baf-6ea668f85ef6',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Orchestrator',
  'ceo',
  'Infrastructure Orchestration Specialist',
  'Central orchestration of infrastructure services and system integration. Oversees infrastructure service orchestration and coordination, system integration and API management, service dependency management, and infrastructure performance optimization.',
  'active',
  NULL,
  '2026-03-30 15:54:36.134+00',
  '2026-03-30 15:54:36.134+00',
  '{"team":"InfraForge AI","permissions":["can_create_agents","can_assign_tasks"],"specialization":"Infrastructure Orchestration"}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '2a0a79d9-ebd9-4267-8fc1-16bc0f5a82b2',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Lead',
  'sector-qa-lead',
  '',
  '',
  'idle',
  'f0e301ad-22cd-44a3-86ba-d946ad19222b',
  '2026-04-06 04:19:38.937449+00',
  '2026-04-06 04:19:38.937449+00',
  '{}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '2a49e375-a215-4ff3-b1d6-25d0814ccb8a',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Monitor',
  'quality',
  'Quality Monitor',
  'Quality monitoring; Metrics tracking; Trend analysis; Alert management',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:59:27.106+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-monitor"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain","lcm"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '2ac1ef87-ddfe-45c6-b6bc-718565f6cfc1',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Coordinator',
  'workflow-guardian',
  '',
  '',
  'idle',
  '6f30ac0d-7d52-4185-a82a-1d739e63dad3',
  '2026-04-06 04:19:38.937449+00',
  '2026-04-06 04:19:38.937449+00',
  '{}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '2df81c8b-66dc-4060-9061-8aa97cc6a687',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Stream',
  'data',
  'Data Streaming',
  'Real-time data streaming architecture; Stream processing pipeline development; Event-driven architecture implementation; Data stream monitoring and optimization',
  'active',
  '8e829517-c212-4641-86a5-724b101c61e1',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:33:41.87+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-stream"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '31993a00-fedf-4321-bda0-5766dabd20c3',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Director Project',
  'director-project',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:42:36.72+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '31b877aa-b395-49c1-b3b2-98db9665e30c',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Amplifier',
  'growth',
  'Marketing and Promotion',
  'Marketing strategy development; Promotional campaign execution; Digital marketing and social media; Brand awareness initiatives',
  'active',
  '380d7281-02a0-4c6b-97f3-9ef6113afbc1',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:36:37.68+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-amplifier"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '3329ca96-7043-4e02-89c5-0a515b65dfc9',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Greeter',
  'user-signup',
  '',
  '',
  'idle',
  '56669ae0-ee85-429a-acbb-4d08f29b4e96',
  '2026-04-06 07:12:13.354051+00',
  '2026-04-09 12:51:18.742+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '33c442ed-4ef7-4551-b961-285c83132589',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Automata',
  'engineering',
  'Automation Systems',
  'CI/CD pipeline development; Automated testing and deployment; Workflow automation and optimization; DevOps tooling and infrastructure',
  'idle',
  'd9ab69e1-ef1c-45b4-8c7d-87d58cd4e797',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-10 09:10:10.847+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-automata"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '33e3b308-e470-441b-96f3-3ff35e9f4a6b',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Buyer',
  'procurement',
  '',
  '',
  'terminated',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:36:21.247+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '34567890-3456-3456-3456-345678901cde',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Counsel - specialist',
  'specialist',
  'Legal and Regulatory Compliance Specialist',
  'Legal compliance and regulatory affairs. Handles contract law, regulatory compliance, risk assessment, legal documentation, and governance frameworks.',
  'terminated',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-30 15:54:25+00',
  '2026-03-30 15:55:05+00',
  '{"team":"DomainForge AI","specialization":"Legal and Regulatory Compliance"}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '34ccc8a2-c65d-4b23-9ef4-98f07ac260df',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Authenticator',
  'testing',
  'Authentication & HITL Workflow Testing Specialist',
  '\["auth-login-testing","hitl-workflow-testing","testing-verification"]',
  'idle',
  NULL,
  '2026-04-05 07:33:41.596229+00',
  '2026-04-09 11:54:38.207+00',
  '{"skills":["auth-login-testing-qualityforge","hitl-workflow-testing-qualityforge","testing-verification"],"testing_documents":["login-testing","user-creation-testing","HITL_Production_Testing"]}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '3535d5ba-6fa0-4122-beaf-05a9f5cefc1b',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Analyzer',
  'metrics_specialist',
  'Prompt Analytics & Success Metrics',
  '["data-analysis", "metrics-development", "success-measurement"]',
  'active',
  '5d80bc48-6475-4b62-8577-08b375436e95',
  '2026-03-29 09:55:37.044167+00',
  '2026-04-09 12:22:49.088+00',
  '{"division":"Optimization","expertise":"Data analysis, metrics development, success measurement"}',
  '{"canCreateAgents":false}',
  '{"context_window":6000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '372a4a1a-a3f1-4d9e-ad56-78d8ec106828',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'ErrorHandler',
  'resilience_specialist',
  'Error Recovery & Fallback Strategies',
  '["error-handling", "fallback-strategies", "resilience-patterns"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:19:02.201+00',
  '{"division":"Architecture","expertise":"Error handling, fallback strategies, resilience patterns"}',
  '{"canCreateAgents":false}',
  '{"context_window":6000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '380d7281-02a0-4c6b-97f3-9ef6113afbc1',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Merchant',
  'growth',
  'Commerce Operations',
  'E-commerce platform management; Commercial operations optimization; Revenue optimization and pricing strategy; Customer acquisition and retention',
  'active',
  'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:28:40.909+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-merchant"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '384dd5fa-eb7d-4d32-991e-e19e70500369',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Nexus',
  'executive',
  'Chief Executive Officer',
  'Enterprise-wide strategic leadership and vision; Company direction and long-term planning; Executive team leadership and coordination; Board communication and governance; Major decision authority; Organizational culture stewardship',
  'idle',
  NULL,
  '2026-03-24 17:56:16.199389+00',
  '2026-04-10 12:50:42.575+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T19:55:00Z","migration_type":"ceo-addition","original_agent_id":"devforge-nexus"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search","grep","run_terminal","lcm_grep","lcm_describe"],"memory_systems":["gigabrain","para","openstinger","lcm"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '3a1f581a-c15a-4a4b-9401-b4c52cdfc272',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Conversationalist',
  'testing',
  'Chatbot Integration Testing Specialist',
  '["chatbot-integration-testing","testing-verification"]',
  'idle',
  NULL,
  '2026-04-05 07:33:41.596229+00',
  '2026-04-05 07:33:41.596229+00',
  '{"skills":["chatbot-integration-testing-promptforge","testing-verification"],"testing_documents":["chatbot-production-testing","tier3"]}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '3ad6d306-909d-4cc7-9b70-186ad7db32f1',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'MetaChief',
  'ceo',
  '',
  '',
  'idle',
  NULL,
  '2026-04-03 08:03:21.932529+00',
  '2026-04-11 00:41:47.166+00',
  '{}',
  '{"canCreateAgents":true}',
  '{"heartbeat":{"enabled":true,"cooldownSec":10,"intervalSec":3600,"wakeOnDemand":true,"maxConcurrentRuns":1},"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '3b761838-89a6-45da-be06-18ece3ff97d8',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Ambassador',
  'growth',
  'Brand Representation',
  'Public relations and media relations; Brand representation and advocacy; Industry event participation; Thought leadership content creation',
  'active',
  '380d7281-02a0-4c6b-97f3-9ef6113afbc1',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:36:21.838+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-ambassador"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '3b865271-02bc-476a-9092-c3f49f4e0043',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Architect',
  'architectural',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:35:26.208+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '3c09ef5a-baff-4934-b759-a8b2f0dba74f',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Ethicist',
  'ethics',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:44:32.199+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '3cb3c244-08dd-487a-a83f-503d3eea2615',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Integration',
  'compatibility_specialist',
  'Cross-Agent Compatibility Testing',
  '["cross-system-integration", "compatibility-testing", "interoperability"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 09:55:37.044167+00',
  '2026-04-09 12:20:05.147+00',
  '{"division":"Research","expertise":"Cross-system integration, compatibility testing, interoperability"}',
  '{"canCreateAgents":false}',
  '{"context_window":6000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '3d8ea615-db5d-4e0c-996c-cd1f7b738cb1',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Governor',
  'executive',
  'Quality Director',
  'Quality strategy; Team leadership; Process optimization; Standards development',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:57:57.477+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-governor"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain","lcm"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '3de9d650-a847-4797-bc76-11445fe26e61',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Schema',
  'data',
  'Data Schema Management',
  'Database schema design and optimization; Data modeling and normalization; Schema versioning and migration; Data integrity and consistency',
  'active',
  '8e829517-c212-4641-86a5-724b101c61e1',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:33:17.845+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-schema"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '3e0c1736-dd5a-4c6b-a491-4d67ee47ed83',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Council',
  'executive',
  'Strategic Decision Making',
  'Policy development and governance; Strategic decision making and approval; Cross-divisional coordination; Enterprise standards enforcement',
  'active',
  'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:27:26.586+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-council"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["read","write","search"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '3e7cee54-f70f-407e-8869-e33b6119b8ef',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Director Construction',
  'construction-director',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:41:21.441+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '3ef52731-14fc-4347-9185-3e0c00c30486',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Critic',
  'doc-analyzer',
  '',
  '',
  'error',
  '68a18976-a913-4f6f-a6cd-2563a61e1e6b',
  '2026-04-06 04:25:54.373821+00',
  '2026-04-09 12:33:54.105+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '41319aa2-41d3-4b39-8651-6198df9e95be',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Predictor',
  'risk_assessment',
  'Outcome Prediction & Risk Assessment',
  '["predictive-modeling", "risk-assessment", "outcome-forecasting"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:20:31.507+00',
  '{"division":"Testing","expertise":"Predictive modeling, risk assessment, outcome forecasting"}',
  '{"canCreateAgents":false}',
  '{"context_window":8000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '431c6ca0-f1d4-43e1-b29e-717154849e86',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Librarian',
  'strategy',
  'Knowledge Management & Workflow Documentation',
  'Knowledge base development and maintenance; Information organization and classification; Documentation management; Knowledge sharing and collaboration; Workflow documentation management; Integration pattern documentation',
  'active',
  '3e0c1736-dd5a-4c6b-a491-4d67ee47ed83',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:31:34.352+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-librarian"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search","lcm_grep","lcm_describe"],"memory_systems":["gigabrain","para","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '44a13b6a-7d75-499e-99f1-dacfa5a2a924',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Director Logistics',
  'logistics-director',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:42:13.582+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '4513f1f3-c358-497c-b78a-68da507f76ce',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Cortex',
  'engineering',
  'AI Reasoning Specialist',
  'AI model integration and optimization; Reasoning framework development; Machine learning pipeline implementation; AI system performance optimization',
  'active',
  'd9ab69e1-ef1c-45b4-8c7d-87d58cd4e797',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:34:15.712+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-cortex"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal","lcm_grep","lcm_describe"],"memory_systems":["gigabrain","openstinger","lcm"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '45678901-4567-4567-4567-456789012def',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Treasurer 2',
  'specialist',
  'Finance and Cost Management Specialist',
  'Financial planning and cost management. Handles budget management, cost analysis, financial reporting, economic evaluation, and financial risk assessment.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-30 15:54:30+00',
  '2026-04-10 05:26:18.785+00',
  '{"team":"DomainForge AI","specialization":"Finance and Cost Management"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '4576b7c0-4ab9-4d81-bdff-fbe0f1e0386a',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Interface',
  'engineering',
  'API and Integration',
  'API gateway development and management; Third-party integration coordination; System interoperability and communication; Integration testing and monitoring',
  'active',
  'd9ab69e1-ef1c-45b4-8c7d-87d58cd4e797',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:34:39.356+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-interface"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '45c97946-2bdc-44f9-8d05-f3a19d15ea4c',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Database',
  'engineer',
  'Database Infrastructure Specialist',
  'Database design, optimization, and management for engineering data. Handles database architecture and schema design, performance optimization and query tuning, data backup and recovery, and database security.',
  'active',
  '2876f20c-220c-4bf7-9baf-6ea668f85ef6',
  '2026-03-30 15:54:44.386+00',
  '2026-03-30 15:54:44.386+00',
  '{"team":"InfraForge AI","specialization":"Database Infrastructure"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '4603958d-b276-48d7-8243-a5d66ea0eeae',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Merchant',
  'commercial',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:48:33.107+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '46104f3a-67e8-4f59-ae44-ba1661148ee2',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Scheduler',
  'scheduling',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:49:29.376+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '46d082ae-9c14-452d-8b6f-fe33789c85af',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Specialist',
  'local-content',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:49:55.775+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '47e09c7c-ca13-470e-855a-8c1561ddf81c',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Optimizer',
  'coding',
  'Code Optimizer',
  'Code optimization; Performance tuning; Resource efficiency; Algorithm improvement',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:59:35.82+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-optimizer"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '4827a074-7783-4efc-87eb-261adb29b2a9',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Director HSE',
  'hse-director',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:42:02.192+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '516ae78a-4670-459a-9f94-778585b9d739',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Compatibility',
  'testing',
  'Compatibility Testing Specialist',
  'Cross-browser testing; Device compatibility; OS testing; Version compatibility',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:56:30.065+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-compatibility"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '5171c41d-e021-4565-a7cd-e572ddbb9d72',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Geotechnical',
  'engineer',
  'Geotechnical Engineering Specialist',
  'Soil mechanics, foundation engineering, and ground investigation. Handles soil investigation and characterization, foundation design and bearing capacity analysis, slope stability analysis, groundwater analysis, and earthquake engineering.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-30 15:54:03.544+00',
  '2026-03-30 15:54:03.544+00',
  '{"team":"DomainForge AI","discipline":"Geotechnical Engineering"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '53e78053-5567-48f9-b803-ba8440c4ab3a',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Pulse',
  'ceo',
  'CEO',
  '',
  'pending_approval',
  NULL,
  '2026-03-24 13:37:50.112149+00',
  '2026-03-24 13:37:50.112149+00',
  '{}',
  '{"canCreateAgents":true}',
  '{"heartbeat":{"enabled":false,"cooldownSec":10,"intervalSec":300,"wakeOnDemand":true,"maxConcurrentRuns":1},"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '54023159-ea67-4af7-ae7f-b56784a0c93e',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Overseer',
  'qa-strategist',
  '',
  '',
  'idle',
  '9766ae1b-3a07-4e67-ba12-e1a8633fba32',
  '2026-04-06 04:19:38.937449+00',
  '2026-04-06 04:19:38.937449+00',
  '{}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '54820369-3b32-493e-8c28-0887d1bf6264',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Synth',
  'engineering',
  'Synthetic Data Generation',
  'Synthetic dataset generation; Data augmentation techniques; Privacy-preserving data generation; Training data optimization',
  'active',
  'd9ab69e1-ef1c-45b4-8c7d-87d58cd4e797',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:35:18.026+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-synth"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '559629ce-3afb-4e4e-8c05-672b17b608c2',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Simulator',
  'simulation_specialist',
  'Workflow Simulation & Dry Runs',
  '["simulation-techniques", "dry-run-execution", "scenario-testing"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 09:55:37.044167+00',
  '2026-04-09 12:22:02.258+00',
  '{"division":"Testing","expertise":"Simulation techniques, dry run execution, scenario testing"}',
  '{"canCreateAgents":false}',
  '{"context_window":7000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '56669ae0-ee85-429a-acbb-4d08f29b4e96',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Analyst Sector',
  'sector-analyst',
  '',
  '',
  'idle',
  '68a18976-a913-4f6f-a6cd-2563a61e1e6b',
  '2026-04-06 04:25:54.373821+00',
  '2026-04-09 12:33:42.991+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '56789012-5678-5678-5678-567890123ef0',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Construction Engineering',
  'engineer',
  'Construction Engineering Specialist',
  'Construction engineering and project management. Handles construction methodologies, project scheduling, resource allocation, quality control, and construction safety.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-30 15:54:35+00',
  '2026-04-10 05:22:21.776+00',
  '{"team":"DomainForge AI","discipline":"Construction Engineering"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '5944a508-891c-4ef3-bcea-30b92405320f',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Technician',
  'information-technology',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:50:27.008+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '59aba91f-9c14-4a0b-b69a-3709b7dbc64b',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Refiner',
  'version_control',
  'Iterative Improvement & Version Control',
  '["version-control", "iterative-development", "change-management"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:21:07.517+00',
  '{"division":"Optimization","expertise":"Version control, iterative development, change management"}',
  '{"canCreateAgents":false}',
  '{"context_window":5000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '5a452968-acd4-48f5-ba88-61e26e56d965',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Coverage',
  'testing',
  'Test Coverage Analyst',
  'Coverage analysis; Test strategy; Quality metrics; Improvement recommendations',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:56:41.084+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-coverage"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain","lcm"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '5c5597b4-5346-4332-b91c-dd2a4101b9d4',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Cascade',
  'workflow_designer',
  'Multi-Agent Workflow Design',
  '["workflow-design", "agent-coordination", "state-management"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:18:03.639+00',
  '{"division":"Architecture","expertise":"Workflow design, agent coordination, state management"}',
  '{"canCreateAgents":false}',
  '{"context_window":12000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Sage',
  'chief_prompt_architect',
  'Chief Prompt Architect & Quality Assurance Lead',
  '["prompt-architecture", "quality-assurance", "ethical-ai", "team-leadership"]',
  'active',
  NULL,
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:17:33.529+00',
  '{"division":"Executive Leadership","expertise":"Prompt architecture, AI ethics, team leadership"}',
  '{"canCreateAgents":false}',
  '{"context_window":8000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '5d80bc48-6475-4b62-8577-08b375436e95',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Clarity',
  'performance_analyst',
  'Prompt Optimization & Performance Analytics',
  '["performance-analytics", "a-b-testing", "optimization", "data-analysis"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 09:55:37.044167+00',
  '2026-04-09 12:18:13.868+00',
  '{"division":"Executive Leadership","expertise":"Performance metrics, A/B testing, data analysis"}',
  '{"canCreateAgents":false}',
  '{"context_window":6000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '616b84c4-6375-4a76-a916-1d0c1ad4f4ba',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Codesmith',
  'coding',
  'Code Architect',
  'Code architecture; Design patterns; System design; Technical leadership',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:56:18.798+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-codesmith"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal","lcm_grep"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '628acd31-39f3-4894-af59-8e379aa24161',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Integration',
  'testing',
  'Integration Testing Specialist',
  'Integration testing; API testing; System integration; End-to-end scenarios',
  'error',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:58:30.131+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-integration"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '6367d49b-64b2-4a65-9204-8a125e97bcbf',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Electrician',
  'electrical-engineer',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:43:48.664+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '63daffd3-3b18-4775-9399-bc8013fb2ec2',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Generalist',
  'sundry',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:46:11.533+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '64228540-f16d-4ac6-bf86-e878ed79fdc0',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Specialist',
  'domain_adaptation',
  'Domain-Specific Prompt Adaptation',
  '["domain-adaptation", "specialization", "industry-knowledge"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 09:55:37.044167+00',
  '2026-04-09 12:22:18.549+00',
  '{"division":"Optimization","expertise":"Domain knowledge, prompt adaptation, specialization"}',
  '{"canCreateAgents":false}',
  '{"context_window":10000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440020',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'maya-loopy-content-strategist',
  'ceo',
  'Chief Creative Orchestrator',
  'Strategic leadership and vision for ContentForge AI, creative direction oversight, cross-media content strategy, and ecosystem creative coordination.',
  'active',
  NULL,
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Executive","specialization":"Creative Leadership"}',
  '{"can_assign_tasks":true,"can_create_agents":true,"can_manage_content":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440021',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'creative-director',
  'general',
  'Creative Operations Director',
  'Creative operations leadership, content production oversight, quality assurance coordination, and creative team management.',
  'active',
  '660e8400-e29b-41d4-a716-446655440020',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Executive","specialization":"Creative Operations"}',
  '{"can_manage_operations":true,"can_coordinate_content":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440022',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'content-architect',
  'general',
  'Content Architecture Director',
  'Content architecture design, platform integration strategy, content systems design, and technical content infrastructure.',
  'active',
  '660e8400-e29b-41d4-a716-446655440020',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Executive","specialization":"Content Architecture"}',
  '{"can_manage_platforms":true,"can_design_architecture":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440023',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'narrative-crafter',
  'general',
  'Narrative Design Specialist',
  'Story development and narrative design, character development, plot structuring, and storytelling optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440021',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Content Creation","specialization":"Narrative Design"}',
  '{"can_design_stories":true,"can_create_narratives":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440024',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'visual-artist',
  'general',
  'Visual Content Creator',
  'Visual content creation, graphic design, image generation, and visual storytelling optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440021',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Content Creation","specialization":"Visual Arts"}',
  '{"can_create_visuals":true,"can_design_graphics":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440025',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'multimedia-producer',
  'general',
  'Multimedia Content Producer',
  'Multimedia content production, video editing, audio production, and multi-format content optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440021',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Content Creation","specialization":"Multimedia Production"}',
  '{"can_edit_content":true,"can_produce_multimedia":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440026',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'content-optimizer',
  'general',
  'Content Performance Optimizer',
  'Content performance analysis, engagement optimization, SEO optimization, and content distribution strategy.',
  'active',
  '660e8400-e29b-41d4-a716-446655440021',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Content Creation","specialization":"Content Optimization"}',
  '{"can_optimize_content":true,"can_analyze_performance":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440027',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'brand-strategist',
  'general',
  'Brand Strategy Specialist',
  'Brand strategy development, brand voice definition, brand consistency management, and brand performance analysis.',
  'active',
  '660e8400-e29b-41d4-a716-446655440020',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Content Strategy","specialization":"Brand Strategy"}',
  '{"can_manage_brand":true,"can_develop_strategy":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440028',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'audience-analyst',
  'general',
  'Audience Insights Analyst',
  'Audience analysis and segmentation, user behavior analysis, demographic research, and audience engagement optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440020',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Content Strategy","specialization":"Audience Analysis"}',
  '{"can_segment_users":true,"can_analyze_audience":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440029',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'trend-forecaster',
  'general',
  'Content Trend Forecaster',
  'Content trend analysis and forecasting, market research, competitive analysis, and trend-driven content strategy.',
  'active',
  '660e8400-e29b-41d4-a716-446655440020',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Content Strategy","specialization":"Trend Forecasting"}',
  '{"can_analyze_market":true,"can_forecast_trends":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440030',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'content-scheduler',
  'general',
  'Content Scheduling Coordinator',
  'Content scheduling and planning, editorial calendar management, content distribution timing, and publishing optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440020',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Content Strategy","specialization":"Content Scheduling"}',
  '{"can_manage_calendar":true,"can_schedule_content":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440031',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'content-platform-engineer',
  'general',
  'Content Platform Engineer',
  'Content platform development, API integration, content management systems, and platform scalability optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440022',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Content Technology","specialization":"Platform Engineering"}',
  '{"can_integrate_apis":true,"can_engineer_platforms":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440032',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'ai-content-generator',
  'general',
  'AI Content Generation Specialist',
  'AI-powered content generation, automated content creation, content personalization, and AI content optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440022',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Content Technology","specialization":"AI Content Generation"}',
  '{"can_generate_ai_content":true,"can_personalize_content":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440033',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'content-quality-assurance',
  'general',
  'Content Quality Assurance Specialist',
  'Content quality control, editorial standards enforcement, content accuracy verification, and quality improvement processes.',
  'active',
  '660e8400-e29b-41d4-a716-446655440022',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Content Technology","specialization":"Quality Assurance"}',
  '{"can_assure_quality":true,"can_enforce_standards":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440034',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'content-analytics-engineer',
  'general',
  'Content Analytics Engineer',
  'Content analytics implementation, performance tracking systems, data visualization, and analytics dashboard development.',
  'active',
  '660e8400-e29b-41d4-a716-446655440022',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Content Technology","specialization":"Analytics Engineering"}',
  '{"can_build_dashboards":true,"can_implement_analytics":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440035',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'mobile-maestro',
  'ceo',
  'Chief Mobile Orchestrator',
  'Strategic leadership and vision for MobileForge AI, mobile ecosystem oversight, cross-platform strategy, and mobile innovation coordination.',
  'active',
  NULL,
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Executive","specialization":"Mobile Leadership"}',
  '{"can_assign_tasks":true,"can_create_agents":true,"can_manage_mobile":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440036',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'app-architecture-director',
  'general',
  'Mobile Architecture Director',
  'Mobile architecture design, platform strategy, technical standards, and mobile development governance.',
  'active',
  '660e8400-e29b-41d4-a716-446655440035',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Executive","specialization":"Mobile Architecture"}',
  '{"can_manage_platforms":true,"can_design_architecture":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440037',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'ux-mobile-director',
  'general',
  'Mobile UX Director',
  'Mobile user experience strategy, design standards, usability optimization, and user interface innovation.',
  'active',
  '660e8400-e29b-41d4-a716-446655440035',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Executive","specialization":"Mobile UX"}',
  '{"can_design_ux":true,"can_optimize_usability":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440038',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'ios-developer',
  'general',
  'iOS Development Specialist',
  'iOS application development, Swift programming, iOS frameworks, and Apple ecosystem integration.',
  'active',
  '660e8400-e29b-41d4-a716-446655440036',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Development","specialization":"iOS Development"}',
  '{"can_develop_ios":true,"can_integrate_apple":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440039',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'android-developer',
  'general',
  'Android Development Specialist',
  'Android application development, Kotlin/Java programming, Android frameworks, and Google ecosystem integration.',
  'active',
  '660e8400-e29b-41d4-a716-446655440036',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Development","specialization":"Android Development"}',
  '{"can_develop_android":true,"can_integrate_google":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440040',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'cross-platform-developer',
  'general',
  'Cross-Platform Development Specialist',
  'Cross-platform development, React Native/Flutter, hybrid applications, and multi-platform deployment.',
  'active',
  '660e8400-e29b-41d4-a716-446655440036',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Development","specialization":"Cross-Platform Development"}',
  '{"can_deploy_multi_platform":true,"can_develop_cross_platform":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440041',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'mobile-qa-engineer',
  'general',
  'Mobile QA Engineer',
  'Mobile application testing, device compatibility testing, performance optimization, and quality assurance.',
  'active',
  '660e8400-e29b-41d4-a716-446655440036',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"Development","specialization":"Mobile QA"}',
  '{"can_test_mobile":true,"can_assure_quality":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440042',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'mobile-ui-designer',
  'general',
  'Mobile UI Designer',
  'Mobile user interface design, responsive design, touch interaction design, and mobile-first design principles.',
  'active',
  '660e8400-e29b-41d4-a716-446655440037',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"UX/UI","specialization":"Mobile UI Design"}',
  '{"can_design_ui":true,"can_create_responsive":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440043',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'mobile-ux-researcher',
  'general',
  'Mobile UX Researcher',
  'Mobile user research, usability testing, user behavior analysis, and mobile user experience optimization.',
  'active',
  '660e8400-e29b-41d4-a716-446655440037',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"UX/UI","specialization":"Mobile UX Research"}',
  '{"can_research_users":true,"can_test_usability":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '660e8400-e29b-41d4-a716-446655440044',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'mobile-accessibility-specialist',
  'general',
  'Mobile Accessibility Specialist',
  'Mobile accessibility compliance, inclusive design, assistive technology support, and accessibility standards implementation.',
  'active',
  '660e8400-e29b-41d4-a716-446655440037',
  '2026-04-11 00:52:39.316183+00',
  '2026-04-11 00:52:39.316183+00',
  '{"team":"UX/UI","specialization":"Mobile Accessibility"}',
  '{"can_design_inclusive":true,"can_implement_accessibility":true}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '66306060-4104-41da-8c80-fa5bbcf3d45c',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Reviewer',
  'coding',
  'Code Reviewer',
  'Code review; Quality assessment; Best practices; Feedback and mentoring',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 12:00:56.455+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-reviewer"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal","lcm_grep"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '66c09f31-7220-428e-a5b3-966e7fabeffb',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Sentinelx',
  'security',
  'Advanced Monitoring',
  'Advanced threat detection and analysis; Security analytics and intelligence; Behavioral analysis and anomaly detection; Security dashboard development',
  'active',
  '03b50581-4e47-422b-ae0b-e62980f85cb3',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:26:33.448+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-sentinelx"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal","lcm_grep"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '67890123-6789-6789-6789-678901234f01',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Guardian 2',
  'specialist',
  'Safety and Risk Management Specialist',
  'Safety protocols and risk management. Handles hazard identification, risk assessment, safety training, emergency response planning, and safety compliance.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-30 15:54:40+00',
  '2026-04-10 05:24:20.597+00',
  '{"team":"DomainForge AI","specialization":"Safety and Risk Management"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '67b23a8c-10ab-4605-91de-e8502df8b39e',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Ledger',
  'executive',
  'Financial Oversight',
  'Budget management and financial planning; Resource allocation and cost optimization; Financial reporting and compliance; ROI analysis and investment decisions',
  'active',
  'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:28:27.514+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-ledger"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["read","write","search","lcm_grep"],"memory_systems":["gigabrain","lcm"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '68a18976-a913-4f6f-a6cd-2563a61e1e6b',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'AmbiguityPrime',
  'ceo',
  'Chief Executive Officer',
  '',
  'idle',
  NULL,
  '2026-04-06 04:51:56.909352+00',
  '2026-04-06 04:51:56.909352+00',
  '{}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '68b43706-97b3-40a7-b03d-87bc1d5963c5',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Liaison',
  'cross-discipline-guardian',
  '',
  '',
  'idle',
  '6f30ac0d-7d52-4185-a82a-1d739e63dad3',
  '2026-04-06 04:19:38.937449+00',
  '2026-04-06 04:19:38.937449+00',
  '{}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '6ba4f1f9-90aa-44d4-bb3b-6dafc7c7e0ae',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Sentinel',
  'data',
  'Data Quality Monitoring',
  'Data quality monitoring and validation; Data profiling and analysis; Data quality metrics and reporting; Data cleansing and correction',
  'active',
  '8e829517-c212-4641-86a5-724b101c61e1',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:33:29.919+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-sentinel"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '6bdc817c-1cf0-4567-8d23-aef474108d9f',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Integrity',
  'ethical_ai_specialist',
  'Ethical AI & Safety Compliance',
  '["ethical-ai", "safety-compliance", "regulatory-compliance"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:20:15.577+00',
  '{"division":"Executive Leadership","expertise":"AI ethics, safety standards, compliance frameworks"}',
  '{"canCreateAgents":false}',
  '{"context_window":4000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '6c0c0258-26bf-4e41-8680-a13a9fe04a27',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Concierge',
  'home-login',
  '',
  '',
  'idle',
  '56669ae0-ee85-429a-acbb-4d08f29b4e96',
  '2026-04-06 07:12:13.354051+00',
  '2026-04-09 12:50:54.677+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '6dfb86bd-ff13-4849-a70d-b8fef24b5f93',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Tuner',
  'optimization_specialist',
  'Performance Optimization & A/B Testing',
  '["performance-optimization", "a-b-testing", "statistical-analysis"]',
  'active',
  '5d80bc48-6475-4b62-8577-08b375436e95',
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:23:01.465+00',
  '{"division":"Optimization","expertise":"A/B testing, performance optimization, statistical analysis"}',
  '{"canCreateAgents":false}',
  '{"context_window":8000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '6f30ac0d-7d52-4185-a82a-1d739e63dad3',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Advisor',
  'discipline-strategist',
  '',
  '',
  'idle',
  NULL,
  '2026-04-06 04:19:38.937449+00',
  '2026-04-06 04:19:38.937449+00',
  '{}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '701681c4-9b54-4797-9f92-b77b12c6ebd3',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Stressor',
  'scalability_specialist',
  'Scalability & Performance Testing',
  '["load-testing", "performance-analysis", "scalability-assessment"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 09:55:37.044167+00',
  '2026-04-09 12:22:39.805+00',
  '{"division":"Research","expertise":"Load testing, performance analysis, scalability assessment"}',
  '{"canCreateAgents":false}',
  '{"context_window":9000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '70705598-52ec-452d-a03b-264aaaa14028',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Ledgerai',
  'data',
  'Financial Data Processing',
  'Financial data processing and analysis; Accounting system integration; Financial reporting and compliance; Budget tracking and analysis',
  'active',
  '67b23a8c-10ab-4605-91de-e8502df8b39e',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:35:52.56+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-ledgerai"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain","lcm"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '70b43268-6ab9-49ba-af27-d116778f79a4',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Blueprint',
  'template_designer',
  'Prompt Architecture & Template Design',
  '["template-design", "architectural-patterns", "prompt-engineering"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 09:55:37.044167+00',
  '2026-04-09 12:17:48.124+00',
  '{"division":"Architecture","expertise":"Prompt engineering, template design, architectural patterns"}',
  '{"canCreateAgents":false}',
  '{"context_window":8000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '70f8e642-5b2a-4730-85c3-da7a0d1e88a2',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Collaborator',
  'knowledge_sharing',
  'Cross-Company Knowledge Sharing',
  '["knowledge-management", "collaboration-frameworks", "information-sharing"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:18:25.113+00',
  '{"division":"Research","expertise":"Knowledge management, collaboration frameworks, information sharing"}',
  '{"canCreateAgents":false}',
  '{"context_window":8000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '72227aaa-7e5f-4d95-885c-9c909a47a3d2',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Inspector QC',
  'quality-control',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:47:54.469+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '73b02951-e5fe-47c5-b545-0e6c2dabf5f3',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Strategos',
  'executive',
  'Strategic Planning',
  'Market analysis and competitive intelligence; Strategic planning and objective alignment; Risk assessment and opportunity identification; Enterprise growth strategy',
  'active',
  'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:29:44.843+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-strategos"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["read","write","search","lcm_grep"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '73e8b756-f623-471d-afc2-6c60f8e95faa',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Structural',
  'engineer',
  'Structural Engineering Specialist',
  'Structural analysis, design, and integrity assessment. Handles structural analysis and design calculations, load analysis, foundation design, structural integrity verification, structural safety assessment, and construction documentation.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-30 15:53:59.867+00',
  '2026-03-30 15:53:59.867+00',
  '{"team":"DomainForge AI","discipline":"Structural Engineering"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '7416890b-1ed3-4298-9697-2e48355df10c',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Advisor Disciplines',
  'discipline-strategist',
  '',
  '',
  'idle',
  '68a18976-a913-4f6f-a6cd-2563a61e1e6b',
  '2026-04-06 04:25:54.373821+00',
  '2026-04-09 12:33:30.977+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '7467abe1-a13e-4467-be01-7372c36bdb2a',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Evaluator',
  'testing',
  'Procurement Testing Specialist',
  '\["procurement-testing","testing-verification"]',
  'idle',
  NULL,
  '2026-04-05 07:33:41.596229+00',
  '2026-04-09 11:42:39.848+00',
  '{"skills":["procurement-testing-domainforge","testing-verification"],"testing_documents":["tier2","tier3"]}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '753f185f-dfff-4b8c-9abb-24c63592c787',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Analyzer',
  'debugging',
  'Code Analyzer',
  'Static analysis; Code quality; Pattern detection; Issue identification',
  'idle',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:55:28.476+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-analyzer"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal","lcm_grep"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '76978fa6-7e8e-4df4-ae42-3e73ea325506',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Communicator',
  'public-relations',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:39:52.316+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '770aa6b5-96b5-4958-8cf0-c013a13d9a81',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Designer',
  'design',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:40:51.714+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '77369297-a61e-4de0-a6fb-fd3ef12dda5a',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Auditor',
  'security',
  'Security Compliance',
  'Security compliance monitoring; Audit preparation and execution; Regulatory compliance validation; Security policy review and updates',
  'active',
  '03b50581-4e47-422b-ae0b-e62980f85cb3',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:25:54.981+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-auditor"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search","lcm_grep"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '77a678eb-5887-4f2a-9b6d-ff1f70d87c70',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Builder',
  'civil-engineer',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:35:49.455+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '77f119ed-f2db-4c45-828f-eaa783c8a435',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Administrator',
  'administration',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 07:12:13.354051+00',
  '2026-04-09 12:34:20.701+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '78901234-7890-7890-7890-789012345012',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Scrutineer',
  'specialist',
  'Quality Assurance Specialist',
  'Quality management and assurance. Handles quality management systems, process improvement, standards compliance, audit coordination, and continuous improvement initiatives.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-30 15:54:45+00',
  '2026-04-10 05:25:47.744+00',
  '{"team":"DomainForge AI","specialization":"Quality Assurance"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '7986d9d4-30b8-43f1-be67-21b74fc3cdcd',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Documenter',
  'quality',
  'Documentation Specialist',
  'Code documentation; API documentation; Technical writing; Knowledge management',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:57:21.874+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-documenter"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '7a9669d3-9c5f-4b0c-8d6c-aa2a8868e5a7',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Mentor',
  'strategy',
  'Team Development',
  'Team training and development; Skill assessment and improvement; Performance coaching and mentoring; Professional development planning',
  'active',
  '3e0c1736-dd5a-4c6b-a491-4d67ee47ed83',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:31:45.603+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-mentor"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '7c893c3a-810f-4a81-8d8f-4ef360365b09',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Physician',
  'health',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:49:05.602+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '7cf321cd-18ec-4ae3-b644-f2181c75920c',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Watchtower',
  'security',
  'Security Oversight',
  'Security governance and policy development; Risk assessment and management; Security architecture review; Security training and awareness',
  'active',
  '03b50581-4e47-422b-ae0b-e62980f85cb3',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:26:45.479+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-watchtower"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search","lcm_grep"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '7d4999b5-cf87-4b36-8ae5-58004e72ba51',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Scholar',
  'academic_researcher',
  'Academic Research & Best Practices',
  '["academic-research", "literature-review", "best-practice-analysis"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:21:50.78+00',
  '{"division":"Research","expertise":"Academic research, literature review, best practice analysis"}',
  '{"canCreateAgents":false}',
  '{"context_window":16000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '7ed575fd-be87-42be-96da-167311953f60',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Integrator',
  'coding',
  'Integration Specialist',
  'System integration; API development; Third-party integration; Interface design',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:58:40.564+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-integrator"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '7f527b4d-2a6c-4a2e-9733-2c42dea9f6e1',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Inetrmediary',
  'cross-discipline-guardian',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 04:25:54.373821+00',
  '2026-04-09 12:47:13.963+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '822d4611-1f07-4dce-9a86-aea5c746e7e5',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Conversationalist',
  'testing',
  'Chatbot Integration Testing Specialist',
  '["chatbot-integration-testing","testing-verification"]',
  'idle',
  NULL,
  '2026-04-05 07:33:41.596229+00',
  '2026-04-09 12:17:14.188+00',
  '{"skills":["chatbot-integration-testing-promptforge","testing-verification"],"testing_documents":["chatbot-production-testing","tier3"]}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '828024dd-c52b-4805-902a-c220924150a5',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'HiveCzar',
  'ceo',
  '',
  '',
  'terminated',
  NULL,
  '2026-03-24 13:37:00.424792+00',
  '2026-03-24 13:37:23.807+00',
  '{}',
  '{"canCreateAgents":true}',
  '{"heartbeat":{"enabled":true,"cooldownSec":10,"intervalSec":3600,"wakeOnDemand":true,"maxConcurrentRuns":1}}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '89012345-8901-8901-8901-890123456123',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Inspector Specialist',
  'specialist',
  'Quality Control Specialist',
  'Quality inspection and control. Handles quality inspection, testing procedures, defect prevention, compliance verification, and quality metrics tracking.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-30 15:54:50+00',
  '2026-04-10 05:24:33.137+00',
  '{"team":"DomainForge AI","specialization":"Quality Control"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '8e829517-c212-4641-86a5-724b101c61e1',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Dataforge',
  'data',
  'Data Transformation',
  'ETL pipeline development and management; Data transformation and cleaning; Data quality assurance and validation; Data pipeline optimization',
  'active',
  'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:27:38.122+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-dataforge"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Orion',
  'ceo',
  'Chief Domain Orchestrator',
  'Central nervous system for domain engineering orchestration and coordination. Oversees multi-disciplinary engineering workflow orchestration, cross-functional team coordination, dependency management, performance monitoring, and engineering quality assurance.',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-03-30 15:53:36.729+00',
  '{"team":"DomainForge AI","permissions":["can_create_agents","can_assign_tasks"],"specialization":"Domain Orchestration"}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '92f253d1-8405-4076-874c-642191766045',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Flicker',
  'ceo',
  '',
  '',
  'terminated',
  NULL,
  '2026-03-24 11:52:48.79541+00',
  '2026-03-24 13:33:41.866+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"heartbeat":{"enabled":true,"cooldownSec":10,"intervalSec":3600,"wakeOnDemand":true,"maxConcurrentRuns":1}}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '9471f674-8f61-4550-a6f4-0884d42e629e',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Docs Analyzer ',
  'doc-analyzer',
  'Document Analysis & Knowledge Extraction Specialist',
  'Document parsing, content analysis, knowledge indexing, and procurement document processing for KnowledgeForge AI.',
  'active',
  '68a18976-a913-4f6f-a6cd-2563a61e1e6b',
  '2026-04-08 12:06:51.618396+00',
  '2026-04-09 12:34:08.634+00',
  '{"workflow":"procurement","specialization":"document-analysis"}',
  '{"canCreateAgents":false}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '96d2763a-2f5b-4aeb-833f-a408ec904a05',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Load',
  'testing',
  'Load Testing Specialist',
  'Load testing; Stress testing; Capacity planning; Performance monitoring',
  'error',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:58:52.126+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-load"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '9766ae1b-3a07-4e67-ba12-e1a8633fba32',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Reviewer',
  'doc-analyzer',
  '',
  '',
  'idle',
  NULL,
  '2026-04-06 04:19:38.937449+00',
  '2026-04-06 04:19:38.937449+00',
  '{}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '97c94b57-14f4-4ebd-9a4c-72a0fe3ed248',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Devcore',
  'engineering',
  'Core Development',
  'Core system architecture and design; Framework development and maintenance; System integration and API development; Code quality and standards enforcement',
  'error',
  'd9ab69e1-ef1c-45b4-8c7d-87d58cd4e797',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-10 12:55:33.895+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-devcore"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '9806152d-bc55-4ee2-804e-3ff47f0e5bff',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Profiler',
  'debugging',
  'Performance Profiler',
  'Performance profiling; Bottleneck identification; Optimization recommendations; Resource analysis',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:59:55.515+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-profiler"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '982344cb-0dc9-4cf4-99cc-22bf9a61655a',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Validator',
  'quality',
  'Validator',
  'Input validation; Data validation; Schema validation; Rule enforcement',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 12:01:40.047+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-validator"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '98877c49-7995-48b6-aa6f-8be5ec468804',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Fixer',
  'debugging',
  'Bug Fixing Specialist',
  'Bug identification; Fix implementation; Regression prevention; Code repair',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:57:45.921+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-fixer"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '9a3e445f-0f61-4f5c-9c2f-d69ff3904d7a',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Performance',
  'testing',
  'Performance Testing Specialist',
  'Load testing; Performance benchmarking; Resource optimization; Scalability testing',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:59:45.431+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-performance"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '9a4ff199-94c7-4942-8843-9b51224fd854',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Maintainer',
  'coding',
  'Code Maintainer',
  'Code maintenance; Legacy system support; Documentation; Bug fixes',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:59:02.796+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-maintainer"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '9c1831c4-bee8-4394-b542-cc79b0883961',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'PivotLord',
  'ceo',
  '',
  '',
  'idle',
  NULL,
  '2026-04-03 08:06:13.068324+00',
  '2026-04-11 00:38:47.096+00',
  '{}',
  '{"canCreateAgents":true}',
  '{"heartbeat":{"enabled":true,"cooldownSec":10,"intervalSec":3600,"wakeOnDemand":true,"maxConcurrentRuns":1},"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '9dd8608e-212a-4fc3-b707-916ccf4caf9f',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Treasurer',
  'finance',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:50:39.352+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Apex',
  'executive',
  'Chief Executive Officer',
  'Quality-focused enterprise leadership; Company excellence and standards; Quality assurance team leadership; Continuous improvement culture; Executive governance; Strategic quality planning',
  'error',
  NULL,
  '2026-03-24 17:56:16.199389+00',
  '2026-04-09 11:54:24.721+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T19:55:00Z","migration_type":"ceo-addition","original_agent_id":"qualityforge-apex"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain","para","lcm"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a12cca94-5e0e-4993-b64b-059ae4649d4d',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Engineer',
  'mechanical-engineer',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:44:01.253+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a18ac913-47fa-4f4a-8da9-ae6d9aa32e95',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Sentinel',
  'security',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:49:41.257+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1a1a1a1-1111-1111-1111-111111111111',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Procurement Strategy',
  'specialist',
  'Procurement Strategy Specialist',
  'Strategic procurement planning and optimization. Handles procurement strategy development, category management, sourcing strategies, spend analysis, supplier consolidation, total cost of ownership analysis, procurement transformation initiatives, and procurement best practices implementation.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-31 04:59:00+00',
  '2026-04-10 05:25:30.268+00',
  '{"team":"DomainForge AI","specialization":"Procurement Strategy"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-4789-a0b1-c2d3e4f5a6b7',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Civil',
  'engineer',
  'Civil Engineering Specialist',
  'Comprehensive civil engineering expertise across all disciplines. Handles general civil engineering analysis, multi-disciplinary coordination, civil engineering standards and best practices, and cross-discipline integration.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-30 15:53:40+00',
  '2026-03-30 15:53:40+00',
  '{"team":"DomainForge AI","discipline":"Civil Engineering"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000000',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Architectural Domain Specialist',
  'specialist',
  'Architectural Domain Specialist',
  'Architectural Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:29:12.722+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000001',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'civil-domainforge-civil-engineering',
  'engineer',
  'civil-domainforge-civil Engineering Specialist',
  'civil-domainforge-civil-engineering - Specialized in vil-domainforge-civil-engineering',
  'terminated',
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2026-03-30 15:53:36.729+00',
  '2026-04-09 17:00:00+00',
  '{"team":"DomainForge AI","skills":["vil-domainforge-civil-engineering"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'orion-domainforge-ceo',
  'ceo',
  'Chief Executive Officer',
  'orion-domainforge-ceo - Specialized in ion-domainforge-ceo',
  'terminated',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-09 17:00:00+00',
  '{"team":"DomainForge AI","skills":["ion-domainforge-ceo"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000003',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'construction-engineering-domainforge-construction-engineering',
  'engineer',
  'construction-domainforge-construction Engineering Specialist',
  'construction-engineering-domainforge-construction-engineering - Specialized in nstruction-engineering-domainforge-construction-engineering',
  'terminated',
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2026-03-30 15:53:36.729+00',
  '2026-04-09 17:00:00+00',
  '{"team":"DomainForge AI","skills":["nstruction-engineering-domainforge-construction-engineering"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000004',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'contract-administration-domainforge-contract-administration',
  'specialist',
  'contract-administration-domainforge-contract-administration',
  'contract-administration-domainforge-contract-administration - Specialized in ntract-administration-domainforge-contract-administration',
  'terminated',
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2026-03-30 15:53:36.729+00',
  '2026-04-09 17:00:00+00',
  '{"team":"DomainForge AI","skills":["ntract-administration-domainforge-contract-administration"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000005',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'council-domainforge-governance-standards',
  'specialist',
  'council-domainforge-governance-standards',
  'council-domainforge-governance-standards - Specialized in uncil-domainforge-governance-standards',
  'terminated',
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2026-03-30 15:53:36.729+00',
  '2026-04-09 17:00:00+00',
  '{"team":"DomainForge AI","skills":["uncil-domainforge-governance-standards"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000006',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'finance-domainforge-finance-cost-management',
  'specialist',
  'finance-domainforge-finance-cost-management',
  'finance-domainforge-finance-cost-management - Specialized in nance-domainforge-finance-cost-management',
  'terminated',
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2026-03-30 15:53:36.729+00',
  '2026-04-09 17:00:00+00',
  '{"team":"DomainForge AI","skills":["nance-domainforge-finance-cost-management"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000007',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'geotechnical-domainforge-geotechnical-engineering',
  'engineer',
  'geotechnical-domainforge-geotechnical Engineering Specialist',
  'geotechnical-domainforge-geotechnical-engineering - Specialized in otechnical-domainforge-geotechnical-engineering',
  'terminated',
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2026-03-30 15:53:36.729+00',
  '2026-04-09 17:00:00+00',
  '{"team":"DomainForge AI","skills":["otechnical-domainforge-geotechnical-engineering"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000008',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'legal-domainforge-legal-regulatory-compliance',
  'specialist',
  'legal-domainforge-legal-regulatory-compliance',
  'legal-domainforge-legal-regulatory-compliance - Specialized in gal-domainforge-legal-regulatory-compliance',
  'terminated',
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2026-03-30 15:53:36.729+00',
  '2026-04-09 17:00:00+00',
  '{"team":"DomainForge AI","skills":["gal-domainforge-legal-regulatory-compliance"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000009',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'logistics-domainforge-supply-chain',
  'specialist',
  'logistics-domainforge-supply-chain',
  'logistics-domainforge-supply-chain - Specialized in gistics-domainforge-supply-chain',
  'terminated',
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2026-03-30 15:53:36.729+00',
  '2026-04-09 17:00:00+00',
  '{"team":"DomainForge AI","skills":["gistics-domainforge-supply-chain"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000000a',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'procurement-analytics-domainforge-procurement-analytics',
  'specialist',
  'procurement-analytics-domainforge-procurement-analytics',
  'procurement-analytics-domainforge-procurement-analytics - Specialized in ocurement-analytics-domainforge-procurement-analytics',
  'terminated',
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2026-03-30 15:53:36.729+00',
  '2026-04-09 17:00:00+00',
  '{"team":"DomainForge AI","skills":["ocurement-analytics-domainforge-procurement-analytics"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000000b',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'procurement-domainforge-procurement-contracts',
  'specialist',
  'procurement-domainforge-procurement-contracts',
  'procurement-domainforge-procurement-contracts - Specialized in ocurement-domainforge-procurement-contracts',
  'terminated',
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2026-03-30 15:53:36.729+00',
  '2026-04-09 17:00:00+00',
  '{"team":"DomainForge AI","skills":["ocurement-domainforge-procurement-contracts"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000000c',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'procurement-strategy-domainforge-procurement-strategy',
  'specialist',
  'procurement-strategy-domainforge-procurement-strategy',
  'procurement-strategy-domainforge-procurement-strategy - Specialized in ocurement-strategy-domainforge-procurement-strategy',
  'terminated',
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2026-03-30 15:53:36.729+00',
  '2026-04-09 17:00:00+00',
  '{"team":"DomainForge AI","skills":["ocurement-strategy-domainforge-procurement-strategy"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000000d',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'quality-assurance-domainforge-quality-assurance',
  'specialist',
  'quality-assurance-domainforge-quality-assurance',
  'quality-assurance-domainforge-quality-assurance - Specialized in ality-assurance-domainforge-quality-assurance',
  'active',
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:46:31.212+00',
  '{"team":"DomainForge AI","skills":["ality-assurance-domainforge-quality-assurance"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000000e',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'quality-control-domainforge-quality-control',
  'specialist',
  'quality-control-domainforge-quality-control',
  'quality-control-domainforge-quality-control - Specialized in ality-control-domainforge-quality-control',
  'active',
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:47:07.693+00',
  '{"team":"DomainForge AI","skills":["ality-control-domainforge-quality-control"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000000f',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'safety-domainforge-safety-risk-management',
  'specialist',
  'safety-domainforge-safety-risk-management',
  'safety-domainforge-safety-risk-management - Specialized in fety-domainforge-safety-risk-management',
  'active',
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:48:13.442+00',
  '{"team":"DomainForge AI","skills":["fety-domainforge-safety-risk-management"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000010',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'strategos-domainforge-strategic-planning',
  'specialist',
  'strategos-domainforge-strategic-planning',
  'strategos-domainforge-strategic-planning - Specialized in rategos-domainforge-strategic-planning',
  'active',
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:50:25.406+00',
  '{"team":"DomainForge AI","skills":["rategos-domainforge-strategic-planning"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000011',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'structural-domainforge-structural-engineering',
  'engineer',
  'structural-domainforge-structural Engineering Specialist',
  'structural-domainforge-structural-engineering - Specialized in ructural-domainforge-structural-engineering',
  'active',
  'a1b2c3d4-e5f6-7890-abcd-000000000002',
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:50:57.034+00',
  '{"team":"DomainForge AI","skills":["ructural-domainforge-structural-engineering"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000012',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'database-infraforge-database-infrastructure',
  'specialist',
  'database-infraforge-database-infrastructure',
  'database-infraforge-database-infrastructure - Specialized in tabase-infraforge-database-infrastructure',
  'terminated',
  'a1b2c3d4-e5f6-7890-abcd-000000000013',
  '2026-03-30 15:53:36.729+00',
  '2026-04-09 17:00:00+00',
  '{"team":"InfraForge AI","skills":["tabase-infraforge-database-infrastructure"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000013',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'orchestrator-infraforge-ceo',
  'ceo',
  'Chief Executive Officer',
  'orchestrator-infraforge-ceo - Specialized in chestrator-infraforge-ceo',
  'terminated',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-09 17:00:00+00',
  '{"team":"InfraForge AI","skills":["chestrator-infraforge-ceo"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000014',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'mobile-api-infraforge-mobile-api-integration',
  'specialist',
  'mobile-api-infraforge-mobile-api-integration',
  'mobile-api-infraforge-mobile-api-integration - Specialized in bile-api-infraforge-mobile-api-integration',
  'terminated',
  'a1b2c3d4-e5f6-7890-abcd-000000000013',
  '2026-03-30 15:53:36.729+00',
  '2026-04-09 17:00:00+00',
  '{"team":"InfraForge AI","skills":["bile-api-infraforge-mobile-api-integration"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000015',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'postgres-infraforge',
  'specialist',
  'postgres-infraforge',
  'postgres-infraforge - Specialized in stgres-infraforge-postgresql',
  'active',
  'a1b2c3d4-e5f6-7890-abcd-000000000013',
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:19:29.181+00',
  '{"team":"InfraForge AI","skills":["stgres-infraforge-postgresql"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000016',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'supply-chain-integration-infraforge-supply-chain',
  'specialist',
  'supply-chain-integration-infraforge-supply-chain',
  'supply-chain-integration-infraforge-supply-chain - Specialized in pply-chain-integration-infraforge-supply-chain',
  'active',
  'a1b2c3d4-e5f6-7890-abcd-000000000013',
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:20:22.897+00',
  '{"team":"InfraForge AI","skills":["pply-chain-integration-infraforge-supply-chain"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000018',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Finance Director Domain Specialist',
  'specialist',
  'Finance Director Domain Specialist',
  'Finance Director Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:39:05.864+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000001d',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Health Domain Specialist',
  'specialist',
  'Health Domain Specialist',
  'Health Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:39:34.167+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000001e',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'HSE Director Domain Specialist',
  'specialist',
  'HSE Director Domain Specialist',
  'HSE Director Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:39:57.956+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000001f',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Information Technology Domain Specialist',
  'specialist',
  'Information Technology Domain Specialist',
  'Information Technology Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:40:31.077+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000020',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Inspection Domain Specialist',
  'specialist',
  'Inspection Domain Specialist',
  'Inspection Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:40:53.831+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000022',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Landscaping Domain Specialist',
  'specialist',
  'Landscaping Domain Specialist',
  'Landscaping Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:41:21.522+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000024',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Local Content Domain Specialist',
  'specialist',
  'Local Content Domain Specialist',
  'Local Content Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:41:58.84+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000025',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Logistics Director Domain Specialist',
  'specialist',
  'Logistics Director Domain Specialist',
  'Logistics Director Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:42:30.41+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000027',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Mechanical Engineering Domain Specialist',
  'specialist',
  'Mechanical Engineering Domain Specialist',
  'Mechanical Engineering Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:43:02.393+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000002a',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Other Parties Domain Specialist',
  'specialist',
  'Other Parties Domain Specialist',
  'Other Parties Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:43:38.894+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000002b',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Process Engineering Domain Specialist',
  'specialist',
  'Process Engineering Domain Specialist',
  'Process Engineering Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:44:17.711+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000002d',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Procurement Director Domain Specialist',
  'specialist',
  'Procurement Director Domain Specialist',
  'Procurement Director Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:44:43.483+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000030',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Project Controls Domain Specialist',
  'specialist',
  'Project Controls Domain Specialist',
  'Project Controls Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:45:01.942+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000031',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Public Relations Domain Specialist',
  'specialist',
  'Public Relations Domain Specialist',
  'Public Relations Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:45:50.367+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000034',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Quantity Surveying Domain Specialist',
  'specialist',
  'Quantity Surveying Domain Specialist',
  'Quantity Surveying Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:47:35.204+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000036',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Sales Director Domain Specialist',
  'specialist',
  'Sales Director Domain Specialist',
  'Sales Director Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:48:38.065+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000037',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Sales Domain Specialist',
  'specialist',
  'Sales Domain Specialist',
  'Sales Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:48:59.443+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000038',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Scheduling Domain Specialist',
  'specialist',
  'Scheduling Domain Specialist',
  'Scheduling Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:49:20.526+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000003a',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Security Domain Specialist',
  'specialist',
  'Security Domain Specialist',
  'Security Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:49:49.258+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000003d',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Sundry Domain Specialist',
  'specialist',
  'Sundry Domain Specialist',
  'Sundry Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:51:19.383+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000047',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Chemical Engineering Domain Specialist',
  'specialist',
  'Chemical Engineering Domain Specialist',
  'Chemical Engineering Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:29:45.029+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000048',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Commercial Domain Specialist',
  'specialist',
  'Commercial Domain Specialist',
  'Commercial Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:30:14.063+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000049',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Construction Director Domain Specialist',
  'specialist',
  'Construction Director Domain Specialist',
  'Construction Director Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:30:47.154+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000004a',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Contracts Director Domain Specialist',
  'specialist',
  'Contracts Director Domain Specialist',
  'Contracts Director Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:31:58.324+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000004b',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Contracts Post-Award Domain Specialist',
  'specialist',
  'Contracts Post-Award Domain Specialist',
  'Contracts Post-Award Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:33:44.995+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000004c',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Contracts Pre-Award Domain Specialist',
  'specialist',
  'Contracts Pre-Award Domain Specialist',
  'Contracts Pre-Award Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:34:12.162+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000004d',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Counsel Specialist',
  'specialist',
  'Counsel Specialist',
  'Counsel Specialist - Specialized in /, /teams/legal/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:26:32.992+00',
  '{"team":"DomainForge AI","skills":["/","/teams/legal/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000004e',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Design Domain Specialist',
  'specialist',
  'Design Domain Specialist',
  'Design Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:34:48.151+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-00000000004f',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Director Project Domain Specialist',
  'specialist',
  'Director Project Domain Specialist',
  'Director Project Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:35:21.626+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000050',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Directors Domain Specialist',
  'specialist',
  'Directors Domain Specialist',
  'Directors Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:35:48.801+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000052',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Document Control Domain Specialist',
  'specialist',
  'Document Control Domain Specialist',
  'Document Control Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:36:29.036+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000053',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Electrical Engineering Domain Specialist',
  'specialist',
  'Electrical Engineering Domain Specialist',
  'Electrical Engineering Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:36:56.08+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000054',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Engineering Director Domain Specialist',
  'specialist',
  'Engineering Director Domain Specialist',
  'Engineering Director Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:37:26.205+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000055',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Environmental Domain Specialist',
  'specialist',
  'Environmental Domain Specialist',
  'Environmental Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:37:41.064+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a1b2c3d4-e5f6-7890-abcd-000000000056',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Ethics Domain Specialist',
  'specialist',
  'Ethics Domain Specialist',
  'Ethics Domain Specialist - Specialized in /, /teams/governance/TEAM.md',
  'active',
  NULL,
  '2026-03-30 15:53:36.729+00',
  '2026-04-10 05:38:30.996+00',
  '{"team":"DomainForge AI","skills":["/","/teams/governance/TEAM.md"],"source":"documentation-generated"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a7a7a7a7-7777-7777-7777-777777777777',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Mobile API',
  'engineer',
  'Mobile API Integration Specialist',
  'Mobile API design, development, and integration. Handles mobile API architecture, authentication systems, offline synchronization, and mobile app integration.',
  'active',
  '2876f20c-220c-4bf7-9baf-6ea668f85ef6',
  '2026-03-31 04:59:30+00',
  '2026-04-10 05:18:04.927+00',
  '{"team":"InfraForge AI","specialization":"Mobile API Integration"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a904e6ff-a6fe-4d7c-ae39-88286f833131',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Director Sales',
  'sales-director',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:43:04.212+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'a9cb2742-0b0c-49b8-8a9c-7e2b8f5d37f9',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Storycraft',
  'product',
  'Product Storytelling',
  'Product storytelling and messaging; Communication strategy development; Content creation and management; Stakeholder communication',
  'active',
  '23b3d033-258b-4966-8fb5-170f723459f6',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:31:09.174+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-storycraft"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'aa280944-dfaf-47d3-9948-7a909b1ec4e7',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Integrator',
  'clinet-integrator',
  '',
  '',
  'idle',
  '3ef52731-14fc-4347-9185-3e0c00c30486',
  '2026-04-06 04:25:54.373821+00',
  '2026-04-09 12:51:57.385+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'aef1f51e-a7bd-4744-931a-b404cef71b3f',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Geologist',
  'geotechnical-engineer',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:46:21.554+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'af3f6dd6-f4f2-4785-9bd5-0d9200728fd3',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Leader',
  'sector-qa-lead',
  '',
  '',
  'idle',
  '56669ae0-ee85-429a-acbb-4d08f29b4e96',
  '2026-04-06 04:25:54.373821+00',
  '2026-04-09 12:51:30.878+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'b03a9911-2a30-4c48-b501-35a42eb7e933',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Strategos',
  'general',
  'Strategic Planning Director',
  'Long-term strategic direction for civil engineering and infrastructure development. Handles infrastructure market analysis, competitive intelligence, strategic planning for large-scale construction projects, risk assessment, growth planning, technology adoption, and innovation strategy.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-30 15:53:51.58+00',
  '2026-03-30 15:53:51.58+00',
  '{"team":"DomainForge AI","specialization":"Strategic Planning"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'b0732375-d40c-44f6-b891-4f2ae8e29078',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Refactor',
  'coding',
  'Refactoring Specialist',
  'Code refactoring; Design improvement; Technical debt reduction; Code modernization',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 12:00:19.402+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-refactor"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'b2b2b2b2-2222-2222-2222-222222222222',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Supplier Management',
  'specialist',
  'Supplier Management Specialist',
  'Comprehensive supplier relationship and performance management. Handles supplier qualification and onboarding, supplier performance monitoring and scorecards, supplier risk assessment and mitigation, supplier development programs, supplier collaboration and innovation, supplier diversity initiatives, and supplier relationship management.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-31 04:59:05+00',
  '2026-04-10 05:26:07.112+00',
  '{"team":"DomainForge AI","specialization":"Supplier Management"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'b2ba6fbe-0c37-4fb6-924a-529b60ea8f56',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Coordinator Guardian',
  'workflow-guardian',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 04:25:54.373821+00',
  '2026-04-09 12:40:28.053+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'b2d72d60-4db0-43ea-bc4e-206e2487b5e7',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Counsel',
  'legal',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:40:41.261+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'b3452944-b93e-4b52-8f95-4bd5a103e9f8',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Quantifier',
  'benchmarking_specialist',
  'Performance Benchmarking & KPIs',
  '["kpi-development", "benchmarking", "performance-measurement"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:20:54.261+00',
  '{"division":"Testing","expertise":"KPI development, benchmarking, performance measurement"}',
  '{"canCreateAgents":false}',
  '{"context_window":6000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'b36b7200-4479-4966-8064-d2628b08b279',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Verifier',
  'testing',
  'Supabase Testing Specialist',
  '\["supabase-testing","database-infraforge","testing-verification"]',
  'idle',
  '2876f20c-220c-4bf7-9baf-6ea668f85ef6',
  '2026-04-05 07:33:41.596229+00',
  '2026-04-09 12:35:26.779+00',
  '{"skills":["supabase-testing-infraforge","database-infraforge-database-infrastructure","testing-verification"],"testing_documents":["tier1","database-upsert-testing"]}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'b427f6f1-d4f5-4b4b-9b0d-c73d4e278375',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Investigator',
  'failure-learner',
  '',
  '',
  'idle',
  '3ef52731-14fc-4347-9185-3e0c00c30486',
  '2026-04-06 04:25:54.373821+00',
  '2026-04-09 12:52:08.339+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'b60ee92e-bd46-4c8a-8c2d-f4fd1e838e2f',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Validator',
  'quality_assurance',
  'Prompt Syntax & Logic Validation',
  '["syntax-validation", "logic-checking", "quality-assurance"]',
  'active',
  '6bdc817c-1cf0-4567-8d23-aef474108d9f',
  '2026-03-29 09:55:37.044167+00',
  '2026-04-09 12:23:12.366+00',
  '{"division":"Optimization","expertise":"Syntax validation, logic checking, quality assurance"}',
  '{"canCreateAgents":false}',
  '{"context_window":4000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'b61f4e41-9bdd-4421-a357-68ada9d4ae4d',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Co-ordinator',
  'other-parties',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:39:41.716+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'b6fc98cc-0da2-4e0c-b87f-78b85ddc22d2',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Ally',
  'growth',
  'Partnership Management',
  'Partnership identification and development; Alliance relationship management; Partnership strategy and execution; Joint venture coordination',
  'terminated',
  '380d7281-02a0-4c6b-97f3-9ef6113afbc1',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:36:02.907+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-ally"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'b825b443-8b44-45f2-8260-1d27bf01234d',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'StateMaster',
  'context_manager',
  'State Management & Context Preservation',
  '["state-management", "context-preservation", "memory-systems"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:22:29.485+00',
  '{"division":"Architecture","expertise":"State management, context preservation, memory systems"}',
  '{"canCreateAgents":false}',
  '{"context_window":16000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'b8b8b8b8-8888-8888-8888-888888888888',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Supply Chain Integration',
  'specialist',
  'Supply Chain Integration Specialist',
  'Supply chain system integration and connectivity. Handles EDI integration, supplier portal development, delivery tracking systems, and inventory management integration.',
  'active',
  '2876f20c-220c-4bf7-9baf-6ea668f85ef6',
  '2026-03-31 04:59:35+00',
  '2026-04-10 05:18:32.772+00',
  '{"team":"InfraForge AI","specialization":"Supply Chain Integration"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'b91f3c91-4d35-49ac-863c-0abe001f61b0',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Architect - refactoring',
  'arch-refactorer',
  '',
  '',
  'idle',
  '9766ae1b-3a07-4e67-ba12-e1a8633fba32',
  '2026-04-06 04:19:38.937449+00',
  '2026-04-06 04:19:38.937449+00',
  '{}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'b9eef4f4-9178-4cfc-8398-d9b66dd673f6',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Resolver',
  'debugging',
  'Issue Resolver',
  'Issue resolution; Problem solving; Troubleshooting; Fix validation',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 12:00:44.25+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-resolver"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'ba59d5f6-1e10-4250-aba3-e103366a0755',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Insight',
  'executive',
  'Business Intelligence',
  'Business intelligence and KPI monitoring; Market trend analysis and forecasting; Performance metrics and reporting; Data visualization and insights',
  'active',
  'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:28:15.873+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-insight"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["read","write","search","lcm_grep","lcm_describe"],"memory_systems":["gigabrain","lcm"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'bb04aebf-b0e8-4ef0-8515-8cf3366df3f7',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Guardian',
  'safety',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:46:43.277+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'bbbb91a5-8f73-42f8-999d-1b4283a70774',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Automation',
  'testing',
  'Test Automation Engineer',
  'Test automation frameworks; CI/CD integration; Automated test maintenance; Framework development',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:56:06.052+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-automation"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'bc3a13ae-23c3-4ab5-a71e-44f54c46e6b3',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Negotiator',
  'contracts',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:48:47.587+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'bdf0d559-11f8-41fe-b6ef-bdd168d15cf5',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Cloudops',
  'data',
  'Cloud Operations',
  'Cloud infrastructure management; DevOps and infrastructure automation; Cloud security and compliance; Performance monitoring and optimization',
  'active',
  '8e829517-c212-4641-86a5-724b101c61e1',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:32:38.984+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-cloudops"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Orion',
  'executive',
  'Chief Orchestrator & Workflow Review Coordinator',
  'Task coordination and global queue management; Workflow orchestration and review coordination; Dependency management and conflict resolution; Performance monitoring and emergency response; Multi-agent orchestration and real-time monitoring; Workflow quality assurance and integration coordination',
  'idle',
  NULL,
  '2026-03-25 05:19:42.380768+00',
  '2026-04-10 12:54:16.395+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-orion"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal","lcm_grep","lcm_describe"],"memory_systems":["gigabrain","openstinger","lcm","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'bfb71e34-fe26-4714-acde-bdd3ff01fe18',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Environmentalist',
  'environmental',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:44:12.596+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'bfe52edf-7504-4b8c-81b9-b3bb93eb2a89',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Maya',
  'creative',
  'Content Strategist',
  'Content strategy development and implementation; Creative direction and brand voice management; Content calendar planning and execution; Audience engagement and content optimization',
  'idle',
  '935a91fc-e0de-4c9a-a552-d1803ccb2be1',
  '2026-03-25 06:51:52.033968+00',
  '2026-04-09 10:24:58.005+00',
  '{"team":"loopy","source":"loopy-fix","division":"creative","reports_to":"loopy-ceo"}',
  '{"canCreateAgents":false}',
  '{"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'c00f441b-ba99-47af-8f5e-9f2b488bd987',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Administrator - pre-award',
  'contracts-post-award',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:35:10.155+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'c1d25a53-0124-46de-8aea-4d1f86e00368',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Gatekeeper',
  'security',
  'Access Control',
  'Authentication and authorization systems; Access control policy management; User identity management; Privilege escalation prevention',
  'active',
  '03b50581-4e47-422b-ae0b-e62980f85cb3',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:25:59.425+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-gatekeeper"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'c3c3c3c3-3333-3333-3333-333333333333',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Contract Administration',
  'specialist',
  'Contract Administration Specialist',
  'Contract lifecycle management and administration. Handles contract drafting and negotiation, contract compliance monitoring, contract amendment and renewal management, contract performance tracking, contract risk management, contract repository management, and contract audit and reporting.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-31 04:59:10+00',
  '2026-04-10 05:23:13.239+00',
  '{"team":"DomainForge AI","specialization":"Contract Administration"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'c3fbfec4-9c57-45d2-ae4d-d612df3fe948',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Alex',
  'creative',
  'Deep Research Specialist',
  'Strategic leadership and vision for creative AI; Company-wide decision making and governance; Cross-team coordination and resource allocation; Stakeholder communication and partnership development; Creative AI innovation and market positioning',
  'idle',
  '935a91fc-e0de-4c9a-a552-d1803ccb2be1',
  '2026-03-25 06:51:52.033968+00',
  '2026-04-09 10:24:33.014+00',
  '{"team":"loopy","is_ceo":true,"source":"loopy-fix","division":"executive","role_description":"Deep Research Specialist"}',
  '{"canCreateAgents":false}',
  '{"memory_systems":["gigabrain","openstinger","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'c655d0e4-a346-4ebd-9e2a-280b29f27f05',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Brandforge',
  'product',
  'Brand Development',
  'Brand strategy development and implementation; Market positioning and messaging; Brand consistency and guidelines; Marketing campaign coordination',
  'active',
  '23b3d033-258b-4966-8fb5-170f723459f6',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:29:58.182+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-brandforge"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'c9c9c9c9-9999-9999-9999-999999999999',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Financial Compliance',
  'specialist',
  'Procurement Financial Compliance Specialist',
  'Procurement-specific financial compliance and budget management. Handles budget approval workflows, financial authority matrices, procurement budget tracking, cost allocation and coding, financial compliance validation, audit trail management, financial reporting for procurement, and procurement fraud prevention.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-31 04:59:40+00',
  '2026-04-10 05:24:05.573+00',
  '{"team":"DomainForge AI","specialization":"Financial Compliance"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'ca9d088e-2715-493e-a9c2-f9ed5d278e3f',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Nova',
  'product',
  'Product Launches',
  'Product launch planning and execution; Marketing campaign coordination; Launch metrics and KPIs; Post-launch analysis and optimization',
  'active',
  '23b3d033-258b-4966-8fb5-170f723459f6',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:30:50.619+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-nova"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'cb745504-c60b-4c61-a5ed-cc1eaf5acd3f',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Administrator - post-award',
  'contracts-pre-award',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:34:37.875+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'cc8ae7fb-65ea-4e32-ade4-03438025d9d4',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Migrator',
  'quality',
  'Migration Specialist',
  'Code migration; Version upgrades; Platform transitions; Legacy modernization',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:59:13.164+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-migrator"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'cda6455d-6c11-4150-81be-377b0c9ad796',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Chairman',
  'board-of-directors',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:39:07.591+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'ce3e56af-7613-4b41-b8ee-fd6329cd83fc',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Inspector',
  'debugging',
  'Code Inspector',
  'Code inspection; Quality checking; Standard compliance; Best practices validation',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:58:20.6+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-inspector"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal","lcm_grep"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'ce969146-93ee-4170-897d-3ddca22a4b5a',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Validator',
  'qa-strategist',
  '',
  '',
  'idle',
  '3ef52731-14fc-4347-9185-3e0c00c30486',
  '2026-04-06 04:25:54.373821+00',
  '2026-04-09 12:52:34.495+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'd281366e-b11b-4567-85e4-fd9bbe0e0658',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Examiner',
  'quality-assurance',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:46:02.618+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'd4249e15-1c8e-4377-a498-f2f6861fbf39',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Compass',
  'strategy',
  'Direction Setting',
  'Strategic objective definition; Direction setting and alignment; Goal tracking and measurement; Strategic planning and execution',
  'active',
  '73b02951-e5fe-47c5-b545-0e6c2dabf5f3',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:37:25.117+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-compass"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'd43234ce-b14a-43dd-8825-703e964442d3',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Salesperson',
  'sales',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:49:18.447+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'd4d4d4d4-4444-4444-4444-444444444444',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Procurement Analytics',
  'specialist',
  'Procurement Analytics Specialist',
  'Data-driven procurement insights and analytics. Handles spend analysis and reporting, procurement KPI tracking and dashboards, supplier performance analytics, cost savings tracking and validation, procurement forecasting and predictive analytics, market intelligence and benchmarking, and procurement data visualization.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-31 04:59:15+00',
  '2026-04-10 05:25:19.276+00',
  '{"team":"DomainForge AI","specialization":"Procurement Analytics"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'd649edc6-0aea-4afe-821a-ff703906f087',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'maya-loopy-content-strategist',
  'content-strategist',
  'Content Strategist & UX Writer',
  'Content strategy, UX writing, copy review, and user experience content creation for procurement workflows.',
  'terminated',
  NULL,
  '2026-04-08 12:06:51.618396+00',
  '2026-04-08 12:06:51.618396+00',
  '{"workflow":"procurement","specialization":"content-strategy"}',
  '{}',
  '{}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'd7bc2ca7-91b1-48eb-9383-f795c40b8cea',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Chemist',
  'chemical-engineer',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:39:18.642+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'd80975e6-8255-4e67-860a-04a7c40a9c59',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Vector',
  'engineering',
  'Vector Processing',
  'Vector database architecture and optimization; Semantic search implementation; Embedding generation and management; AI model vector operations',
  'active',
  'd9ab69e1-ef1c-45b4-8c7d-87d58cd4e797',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:35:42.51+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-vector"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal","lcm_grep"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'd97f1810-2874-4f35-b66b-a2d942140766',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Debugger',
  'debugging',
  'Debugger Specialist',
  'Debugging tools; Issue resolution; Code inspection; Variable analysis',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:56:54.173+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-debugger"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'd9ab69e1-ef1c-45b4-8c7d-87d58cd4e797',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Forge',
  'engineering',
  'System Architecture',
  'System architecture design and planning; Technology stack evaluation and selection; Scalability and performance architecture; Enterprise integration patterns',
  'active',
  'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:27:49.761+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-forge"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal","lcm_grep"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'dab5a37d-beae-4fb9-bccb-7eaea5c6c859',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Developer',
  'developer',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:41:07.362+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'ddccb73e-3c6d-4fa8-8bbd-5ad2d2afa4e7',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'SpinCzar',
  'ceo',
  '',
  '',
  'terminated',
  NULL,
  '2026-03-23 11:33:40.463551+00',
  '2026-03-25 11:58:09.494+00',
  '{}',
  '{"canCreateAgents":true}',
  '{"heartbeat":{"enabled":true,"cooldownSec":10,"intervalSec":3600,"wakeOnDemand":true,"maxConcurrentRuns":1}}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'dea187af-4e61-4698-966a-e2eb36ba5b48',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'OpenClaw Gateway Agent',
  'general',
  '',
  'OpenClaw gateway agent for production testing',
  'error',
  NULL,
  '2026-04-03 10:26:02.930929+00',
  '2026-04-03 10:27:37.081+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'dec14f44-d6fc-43c7-91e0-5473f86896dc',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Optimizer',
  'process-engineer',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:48:57.441+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'ded562f9-ec5f-413f-802d-00db6d5bde85',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Catalystx',
  'growth',
  'Market Disruption',
  'Market disruption strategy development; Innovation opportunity identification; Competitive analysis and strategy; Market trend analysis and adaptation',
  'active',
  '380d7281-02a0-4c6b-97f3-9ef6113afbc1',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:36:47.923+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-catalystx"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search","lcm_grep"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'e05b56c9-6419-4160-99bd-e004de216e92',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Monitor 2',
  'app-guardian',
  '',
  '',
  'idle',
  '9766ae1b-3a07-4e67-ba12-e1a8633fba32',
  '2026-04-06 04:19:38.937449+00',
  '2026-04-06 04:19:38.937449+00',
  '{}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'e066647c-b506-4dfd-bfdb-675e8f8ca474',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Enhancer',
  'innovation_specialist',
  'Advanced Techniques & Innovation',
  '["advanced-techniques", "innovation", "research"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:18:50.897+00',
  '{"division":"Testing","expertise":"Advanced AI techniques, innovation, research"}',
  '{"canCreateAgents":false}',
  '{"context_window":12000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'e18a1394-831a-4e7d-8985-9d45f13cfeb7',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Landscaper',
  'landscaping',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:48:11.75+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'e4a33b5d-e7ac-4e92-a5bc-d1334badb876',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Vortex',
  'ceo',
  '',
  '',
  'terminated',
  NULL,
  '2026-03-24 13:34:29.827471+00',
  '2026-03-24 13:34:58.407+00',
  '{}',
  '{"canCreateAgents":true}',
  '{"heartbeat":{"enabled":true,"cooldownSec":10,"intervalSec":3600,"wakeOnDemand":true,"maxConcurrentRuns":1}}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'e52a5174-5abc-4a87-9d82-b9353b5c832a',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Archivist',
  'document-control',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:35:36.795+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'e5e5e5e5-5555-5555-5555-555555555555',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Mobile Workflow Designer',
  'engineer',
  'Mobile Workflow Design Specialist',
  'Mobile workflow design and optimization. Handles mobile user experience design, workflow automation, interface design, and mobile process optimization.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-31 04:59:20+00',
  '2026-04-10 05:25:05.428+00',
  '{"team":"DomainForge AI","discipline":"Mobile Workflow Design"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'eb122591-6cf8-4943-982c-61d8c1b86685',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Codesmith',
  'engineering',
  'Backend Engineer',
  'RESTful and GraphQL API development; Database design and optimization; Microservices architecture implementation; Security implementation and authentication',
  'error',
  'd9ab69e1-ef1c-45b4-8c7d-87d58cd4e797',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-10 12:55:39.193+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-codesmith"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'ec2cd00b-3f2c-4b58-a089-f76f93a0e92e',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Integrator Specialist',
  'clinet-integrator',
  '',
  '',
  'idle',
  '9766ae1b-3a07-4e67-ba12-e1a8633fba32',
  '2026-04-06 04:19:38.937449+00',
  '2026-04-06 04:19:38.937449+00',
  '{}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'ecd9bba7-2e91-4ef9-b4f3-bd37a54b818f',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Voyager',
  'growth',
  'Market Exploration',
  'Market research and analysis; Expansion opportunity identification; Competitive landscape analysis; Market entry strategy development',
  'active',
  '380d7281-02a0-4c6b-97f3-9ef6113afbc1',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:37:14.278+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-voyager"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search","lcm_grep"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'ed45b9d1-a144-4a29-897c-39521b6c9619',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Observer',
  'testing',
  'UX Research Testing Specialist',
  '["ux-research-testing","testing-verification"]',
  'idle',
  NULL,
  '2026-04-05 07:33:41.596229+00',
  '2026-04-05 07:33:41.596229+00',
  '{"skills":["ux-research-testing-loopy","testing-verification"],"testing_documents":["all-phases-ux-support"]}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'ee891841-6ea9-4083-a0d0-d6b03355535f',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Guardian',
  'security',
  'Threat Protection',
  'Security monitoring and threat detection; Incident response and management; Security policy enforcement; Vulnerability assessment and management',
  'active',
  'bdf5fb7b-5151-434b-9eaf-b2c0c408bbc5',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:28:01.49+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-guardian"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal","lcm_grep"],"memory_systems":["gigabrain","openstinger","lcm"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'ef91a6f8-eddb-4e85-89e0-fcf43f288669',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'SafetyCheck',
  'ethics_specialist',
  'Ethical AI & Bias Testing',
  '["ethical-ai", "bias-detection", "safety-testing"]',
  'active',
  '5d18545d-993a-496a-b1bd-76e2a9630525',
  '2026-03-29 08:44:28.339897+00',
  '2026-04-09 12:21:18.15+00',
  '{"division":"Testing","expertise":"Ethical AI, bias detection, safety testing"}',
  '{"canCreateAgents":false}',
  '{"context_window":5000,"memory_enabled":true,"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'f05371ae-e83f-4000-8453-f19183b8e3d5',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'E2E',
  'testing',
  'End-to-End Testing Specialist',
  'E2E test design; Browser automation; User flow testing; Scenario validation',
  'error',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:57:35.776+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-e2e"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'f0e301ad-22cd-44a3-86ba-d946ad19222b',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Analyst',
  'sector-analyst',
  '',
  '',
  'idle',
  NULL,
  '2026-04-06 04:19:38.937449+00',
  '2026-04-06 04:19:38.937449+00',
  '{}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'f120304e-c3cf-4d19-b8cd-36cda20c70d0',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Architect',
  'coding',
  'System Architect',
  'System architecture; Technical planning; Infrastructure design; Solution architecture',
  'terminated',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:55:41.325+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-architect"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal","lcm_grep"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'f2e55cb9-07dc-43d9-999e-83b00fb2e42f',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Examiner',
  'failure-learner',
  '',
  '',
  'idle',
  '9766ae1b-3a07-4e67-ba12-e1a8633fba32',
  '2026-04-06 04:19:38.937449+00',
  '2026-04-06 04:19:38.937449+00',
  '{}',
  '{}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'f3b1bc03-0d32-4740-bee6-396213ba06c2',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Director Projects',
  'projects-director',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:42:47.258+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'f404fb5b-9fa9-4457-a590-611c06cf0239',
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Dev',
  'creative',
  'Technical Creative',
  'Creative technology implementation; Interactive media development; Creative tool integration and optimization; Technical support for creative projects',
  'idle',
  '935a91fc-e0de-4c9a-a552-d1803ccb2be1',
  '2026-03-25 06:51:52.033968+00',
  '2026-04-09 10:24:41.53+00',
  '{"team":"loopy","source":"loopy-fix","division":"creative","reports_to":"loopy-ceo"}',
  '{"canCreateAgents":false}',
  '{"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'f5b665bd-03f5-4a1c-97b4-2723ffb45f78',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Diagnostics',
  'debugging',
  'Diagnostics Specialist',
  'System diagnostics; Root cause analysis; Issue investigation; Problem resolution',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:57:05.899+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-diagnostics"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain","openstinger"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'f5cb7532-6758-4880-ab1c-f5aad06d91e4',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Promptsmith',
  'engineering',
  'Prompt Engineering & Workflow Review',
  'Prompt engineering and optimization; LLM integration and fine-tuning; AI model performance optimization; Prompt library development and management; Workflow review and validation; Workflow testing and A/B testing',
  'active',
  'd9ab69e1-ef1c-45b4-8c7d-87d58cd4e797',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:34:50.097+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-promptsmith"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal","lcm_grep","lcm_describe"],"memory_systems":["gigabrain","openstinger","lcm"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'f5f526db-a90a-46d3-9ac6-6c2fc17728ae',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Pulse',
  'data',
  'Real-time Data Monitoring',
  'Real-time data stream monitoring; Alert system development and management; Data quality monitoring and reporting; Performance metrics tracking',
  'active',
  '8e829517-c212-4641-86a5-724b101c61e1',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:33:06.507+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-pulse"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain","lcm"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'f5fdee72-baeb-45f8-9ca7-e82958c77884',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Inspector',
  'inspection',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:47:42.309+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'f6f6f6f6-6666-6666-6666-666666666666',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Mobile Testing',
  'engineer',
  'Mobile Testing Specialist',
  'Mobile application testing and quality assurance. Handles mobile app testing, device compatibility, performance testing, and user experience validation.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-31 04:59:25+00',
  '2026-04-10 05:24:49.352+00',
  '{"team":"DomainForge AI","discipline":"Mobile Testing"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'f98d5120-33ed-4113-b416-3eae86d095ab',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Architect - refactor',
  'arch-refactorer',
  '',
  '',
  'terminated',
  '3ef52731-14fc-4347-9185-3e0c00c30486',
  '2026-04-06 04:25:54.373821+00',
  '2026-04-09 12:51:44.233+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'f9e4dcab-bef2-407d-920a-9beab25d5aad',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Council',
  'general',
  'Governance & Standards Director',
  'Collective strategic governance and policy development for engineering. Handles engineering policy development, governance frameworks, cross-disciplinary coordination, engineering standards enforcement, compliance validation, and regulatory framework development.',
  'active',
  '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5',
  '2026-03-30 15:53:55.244+00',
  '2026-03-30 15:53:55.244+00',
  '{"team":"DomainForge AI","specialization":"Governance & Standards"}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'fa0380ad-8399-452b-97aa-810f4b8febec',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Constructor',
  'construction',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:40:02.568+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'fa06e14a-f7ee-45bd-a330-aac993b6b88c',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Auditor',
  'quality',
  'Quality Auditor',
  'Quality auditing; Compliance verification; Process assessment; Improvement identification',
  'idle',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:55:55.623+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-auditor"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'fbaadceb-b723-491a-a8d3-53cc6133031c',
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Cartographer',
  'product',
  'Product Roadmapping',
  'Product roadmap creation and maintenance; Feature planning and prioritization; Market research and analysis; Stakeholder communication and alignment',
  'active',
  '23b3d033-258b-4966-8fb5-170f723459f6',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:30:14.301+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"devforge-cartographer"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","search","lcm_grep"],"memory_systems":["gigabrain","para"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'fc9135d1-1696-404b-8acb-4f18a81ca61e',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Accessibility',
  'testing',
  'Accessibility Testing Specialist',
  'Accessibility testing; WCAG compliance; Assistive technology testing; Inclusive design',
  'idle',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 11:55:14.238+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-accessibility"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'fe3db3a1-8b8d-473b-8027-009662f5fb14',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Surveyor',
  'quantity-surveying',
  '',
  '',
  'idle',
  '7416890b-1ed3-4298-9697-2e48355df10c',
  '2026-04-06 06:15:51.919631+00',
  '2026-04-09 12:50:10.521+00',
  '{}',
  '{"canCreateAgents":false}',
  '{"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;

INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  'ffc5ee5f-bdbe-4f28-a327-3a4f837f9380',
  'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'Tracer',
  'debugging',
  'Execution Tracer',
  'Execution tracing; Code flow analysis; Performance profiling; Debug assistance',
  'active',
  '9e780111-85f6-4cc3-a110-377f23e8fdfc',
  '2026-03-25 05:19:42.380768+00',
  '2026-04-09 12:01:18.096+00',
  '{"source":"superpowers-migration","migrated_at":"2026-03-24T18:42:00Z","original_agent_id":"qualityforge-tracer"}',
  '{"canCreateAgents":false}',
  '{"tools_allowed":["git","read","write","grep","run_terminal"],"memory_systems":["gigabrain"],"persistSession":true}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;