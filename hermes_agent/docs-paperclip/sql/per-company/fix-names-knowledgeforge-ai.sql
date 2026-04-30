-- ============================================================
-- FIX NAMES FOR: knowledgeforge-ai
-- Company ID: c4d52645-a0ea-4a26-b381-baf0b3042f34
-- Agents: 44
-- Uses UPDATE to fix name field on existing agents
-- Uses human_name field when available, otherwise name
-- ============================================================

BEGIN;

UPDATE agents
SET name = 'Co Ordinator'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-coordinator'
  AND name IS DISTINCT FROM 'Co Ordinator';

UPDATE agents
SET name = 'Administrator'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-administrator'
  AND name IS DISTINCT FROM 'Administrator';

UPDATE agents
SET name = 'Ambiguityprime'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-ambiguityprime'
  AND name IS DISTINCT FROM 'Ambiguityprime';

UPDATE agents
SET name = 'Archivist'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-archivist'
  AND name IS DISTINCT FROM 'Archivist';

UPDATE agents
SET name = 'Builder'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-builder'
  AND name IS DISTINCT FROM 'Builder';

UPDATE agents
SET name = 'Buyer'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-buyer'
  AND name IS DISTINCT FROM 'Buyer';

UPDATE agents
SET name = 'Chairman'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-chairman'
  AND name IS DISTINCT FROM 'Chairman';

UPDATE agents
SET name = 'Chemist'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-chemist'
  AND name IS DISTINCT FROM 'Chemist';

UPDATE agents
SET name = 'Communicator'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-communicator'
  AND name IS DISTINCT FROM 'Communicator';

UPDATE agents
SET name = 'Concierge'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-concierge'
  AND name IS DISTINCT FROM 'Concierge';

UPDATE agents
SET name = 'Constructor'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-constructor'
  AND name IS DISTINCT FROM 'Constructor';

UPDATE agents
SET name = 'Controller'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-controller'
  AND name IS DISTINCT FROM 'Controller';

UPDATE agents
SET name = 'Counsel'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-counsel'
  AND name IS DISTINCT FROM 'Counsel';

UPDATE agents
SET name = 'Critic'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-critic'
  AND name IS DISTINCT FROM 'Critic';

UPDATE agents
SET name = 'Designer'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-designer'
  AND name IS DISTINCT FROM 'Designer';

UPDATE agents
SET name = 'Developer'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-developer'
  AND name IS DISTINCT FROM 'Developer';

UPDATE agents
SET name = 'Directors'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-directors'
  AND name IS DISTINCT FROM 'Directors';

UPDATE agents
SET name = 'Dispatcher'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-dispatcher'
  AND name IS DISTINCT FROM 'Dispatcher';

UPDATE agents
SET name = 'Electrician'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-electrician'
  AND name IS DISTINCT FROM 'Electrician';

UPDATE agents
SET name = 'Engineer'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-engineer'
  AND name IS DISTINCT FROM 'Engineer';

UPDATE agents
SET name = 'Environmentalist'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-environmentalist'
  AND name IS DISTINCT FROM 'Environmentalist';

UPDATE agents
SET name = 'Ethicist'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-ethicist'
  AND name IS DISTINCT FROM 'Ethicist';

UPDATE agents
SET name = 'Examiner'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-examiner'
  AND name IS DISTINCT FROM 'Examiner';

UPDATE agents
SET name = 'Gatekeeper'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-gatekeeper'
  AND name IS DISTINCT FROM 'Gatekeeper';

UPDATE agents
SET name = 'Generalist'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-generalist'
  AND name IS DISTINCT FROM 'Generalist';

UPDATE agents
SET name = 'Geologist'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-geologist'
  AND name IS DISTINCT FROM 'Geologist';

UPDATE agents
SET name = 'Governor'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-governor'
  AND name IS DISTINCT FROM 'Governor';

UPDATE agents
SET name = 'Greeter'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-greeter'
  AND name IS DISTINCT FROM 'Greeter';

UPDATE agents
SET name = 'Guardian'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-guardian'
  AND name IS DISTINCT FROM 'Guardian';

UPDATE agents
SET name = 'Inetrmediary'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-inetrmediary'
  AND name IS DISTINCT FROM 'Inetrmediary';

UPDATE agents
SET name = 'Inspector'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-inspector'
  AND name IS DISTINCT FROM 'Inspector';

UPDATE agents
SET name = 'Landscaper'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-landscaper'
  AND name IS DISTINCT FROM 'Landscaper';

UPDATE agents
SET name = 'Leader'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-leader'
  AND name IS DISTINCT FROM 'Leader';

UPDATE agents
SET name = 'Merchant'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-merchant'
  AND name IS DISTINCT FROM 'Merchant';

UPDATE agents
SET name = 'Negotiator'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-negotiator'
  AND name IS DISTINCT FROM 'Negotiator';

UPDATE agents
SET name = 'Optimizer'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-optimizer'
  AND name IS DISTINCT FROM 'Optimizer';

UPDATE agents
SET name = 'Physician'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-physician'
  AND name IS DISTINCT FROM 'Physician';

UPDATE agents
SET name = 'Salesperson'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-salesperson'
  AND name IS DISTINCT FROM 'Salesperson';

UPDATE agents
SET name = 'Scheduler'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-scheduler'
  AND name IS DISTINCT FROM 'Scheduler';

UPDATE agents
SET name = 'Sentinel'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-sentinel'
  AND name IS DISTINCT FROM 'Sentinel';

UPDATE agents
SET name = 'Specialist'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-specialist'
  AND name IS DISTINCT FROM 'Specialist';

UPDATE agents
SET name = 'Surveyor'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-surveyor'
  AND name IS DISTINCT FROM 'Surveyor';

UPDATE agents
SET name = 'Technician'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-technician'
  AND name IS DISTINCT FROM 'Technician';

UPDATE agents
SET name = 'Treasurer'
WHERE company_id = 'c4d52645-a0ea-4a26-b381-baf0b3042f34'
  AND title = 'knowledgeforge-ai-treasurer'
  AND name IS DISTINCT FROM 'Treasurer';

COMMIT;
