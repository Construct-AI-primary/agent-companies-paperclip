-- MeasureForge AI Agent Cleanup Script
-- Removes 68 extra agents from database that don't match filesystem structure
-- Follows FK deletion procedure from docs-paperclip/procedures/agents/fk-deletion-procedure.md

-- Company ID for MeasureForge AI
-- 550e8400-e29b-41d4-a716-446655440013

-- Execute as single transaction to maintain temp table scope
BEGIN;

-- Step 3: Show what will be deleted
SELECT 'Agents to delete' as info, COUNT(*) as count
FROM agents a
WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
  AND a.name NOT IN (
    -- coordinators (2)
    'measureforge-ai-cad-measurement-orchestrator',
    'measureforge-ai-measurement-coordination-specialist',

    -- creators (1)
    'measureforge-ai-atlas-agent-creator',

    -- specialists/element (11)
    'measureforge-ai-architectural-element-specialist',
    'measureforge-ai-contour-analysis-specialist',
    'measureforge-ai-cost-estimation-specialist',
    'measureforge-ai-earthwork-calculation-specialist',
    'measureforge-ai-electrical-compliance-specialist',
    'measureforge-ai-electrical-measurement-specialist',
    'measureforge-ai-mep-element-specialist',
    'measureforge-ai-quantity-surveyor-specialist',
    'measureforge-ai-structural-element-specialist',
    'measureforge-ai-traffic-signal-compliance-specialist',
    'measureforge-ai-traffic-signal-measurement-specialist',

    -- specialists/integration (1)
    'measureforge-ai-autocad-integration-specialist',

    -- specialists/procurement (2)
    'measureforge-ai-contract-tender-specialist',
    'measureforge-ai-order-generation-specialist',

    -- specialists/standards (2)
    'measureforge-ai-asaqs-standards-specialist',
    'measureforge-ai-sans-standards-specialist',

    -- validators (3)
    'measureforge-ai-electrical-qa-specialist',
    'measureforge-ai-measurement-validation-specialist',
    'measureforge-ai-visual-overlay-specialist'
  )
UNION ALL
SELECT 'Valid agents to keep', COUNT(*)
FROM agents a
WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
  AND a.name IN (
    -- coordinators (2)
    'measureforge-ai-cad-measurement-orchestrator',
    'measureforge-ai-measurement-coordination-specialist',

    -- creators (1)
    'measureforge-ai-atlas-agent-creator',

    -- specialists/element (11)
    'measureforge-ai-architectural-element-specialist',
    'measureforge-ai-contour-analysis-specialist',
    'measureforge-ai-cost-estimation-specialist',
    'measureforge-ai-earthwork-calculation-specialist',
    'measureforge-ai-electrical-compliance-specialist',
    'measureforge-ai-electrical-measurement-specialist',
    'measureforge-ai-mep-element-specialist',
    'measureforge-ai-quantity-surveyor-specialist',
    'measureforge-ai-structural-element-specialist',
    'measureforge-ai-traffic-signal-compliance-specialist',
    'measureforge-ai-traffic-signal-measurement-specialist',

    -- specialists/integration (1)
    'measureforge-ai-autocad-integration-specialist',

    -- specialists/procurement (2)
    'measureforge-ai-contract-tender-specialist',
    'measureforge-ai-order-generation-specialist',

    -- specialists/standards (2)
    'measureforge-ai-asaqs-standards-specialist',
    'measureforge-ai-sans-standards-specialist',

    -- validators (3)
    'measureforge-ai-electrical-qa-specialist',
    'measureforge-ai-measurement-validation-specialist',
    'measureforge-ai-visual-overlay-specialist'
  );

-- Step 4: Execute deletion in dependency order (following FK procedure)

-- 1. Delete heartbeat events (direct FK to agents + chained via heartbeat_runs)
DELETE FROM heartbeat_run_events
WHERE agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
)
   OR run_id::TEXT IN (
       SELECT hr.id::TEXT FROM heartbeat_runs hr
       WHERE hr.agent_id::TEXT IN (
         SELECT a.id::TEXT
         FROM agents a
         WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
           AND a.name NOT IN (
             'measureforge-ai-cad-measurement-orchestrator',
             'measureforge-ai-measurement-coordination-specialist',
             'measureforge-ai-atlas-agent-creator',
             'measureforge-ai-architectural-element-specialist',
             'measureforge-ai-contour-analysis-specialist',
             'measureforge-ai-cost-estimation-specialist',
             'measureforge-ai-earthwork-calculation-specialist',
             'measureforge-ai-electrical-compliance-specialist',
             'measureforge-ai-electrical-measurement-specialist',
             'measureforge-ai-mep-element-specialist',
             'measureforge-ai-quantity-surveyor-specialist',
             'measureforge-ai-structural-element-specialist',
             'measureforge-ai-traffic-signal-compliance-specialist',
             'measureforge-ai-traffic-signal-measurement-specialist',
             'measureforge-ai-autocad-integration-specialist',
             'measureforge-ai-contract-tender-specialist',
             'measureforge-ai-order-generation-specialist',
             'measureforge-ai-asaqs-standards-specialist',
             'measureforge-ai-sans-standards-specialist',
             'measureforge-ai-electrical-qa-specialist',
             'measureforge-ai-measurement-validation-specialist',
             'measureforge-ai-visual-overlay-specialist'
           )
       )
   );

-- 2. Delete heartbeat runs
DELETE FROM heartbeat_runs
WHERE agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);

-- 3. Delete agent task sessions
DELETE FROM agent_task_sessions
WHERE agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);

-- 5. Delete agent runtime state
DELETE FROM agent_runtime_state
WHERE agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);

-- 6. Delete agent wakeup requests
DELETE FROM agent_wakeup_requests
WHERE agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);

-- 7. Delete agent config revisions (both FKs)
DELETE FROM agent_config_revisions
WHERE agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
)
   OR created_by_agent_id::TEXT IN (
     SELECT a.id::TEXT
     FROM agents a
     WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
       AND a.name NOT IN (
         'measureforge-ai-cad-measurement-orchestrator',
         'measureforge-ai-measurement-coordination-specialist',
         'measureforge-ai-atlas-agent-creator',
         'measureforge-ai-architectural-element-specialist',
         'measureforge-ai-contour-analysis-specialist',
         'measureforge-ai-cost-estimation-specialist',
         'measureforge-ai-earthwork-calculation-specialist',
         'measureforge-ai-electrical-compliance-specialist',
         'measureforge-ai-electrical-measurement-specialist',
         'measureforge-ai-mep-element-specialist',
         'measureforge-ai-quantity-surveyor-specialist',
         'measureforge-ai-structural-element-specialist',
         'measureforge-ai-traffic-signal-compliance-specialist',
         'measureforge-ai-traffic-signal-measurement-specialist',
         'measureforge-ai-autocad-integration-specialist',
         'measureforge-ai-contract-tender-specialist',
         'measureforge-ai-order-generation-specialist',
         'measureforge-ai-asaqs-standards-specialist',
         'measureforge-ai-sans-standards-specialist',
         'measureforge-ai-electrical-qa-specialist',
         'measureforge-ai-measurement-validation-specialist',
         'measureforge-ai-visual-overlay-specialist'
       )
   );

-- 8. Delete agent API keys
DELETE FROM agent_api_keys
WHERE agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);

-- 8.5. Delete agent skill assignments (production table not in schema)
DELETE FROM agent_skill_assignments
WHERE agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);

-- 9. Clear nullable FKs (set to NULL before deleting parent)
UPDATE issues SET assignee_agent_id = NULL WHERE assignee_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE agents SET reports_to = NULL WHERE reports_to::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);

-- Additional nullable FKs from CSV analysis
UPDATE agent_config_revisions SET created_by_agent_id = NULL WHERE created_by_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE approval_comments SET author_agent_id = NULL WHERE author_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE approvals SET requested_by_agent_id = NULL WHERE requested_by_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE assets SET created_by_agent_id = NULL WHERE created_by_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE company_secret_versions SET created_by_agent_id = NULL WHERE created_by_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE company_secrets SET created_by_agent_id = NULL WHERE created_by_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE document_revisions SET created_by_agent_id = NULL WHERE created_by_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE documents SET created_by_agent_id = NULL, updated_by_agent_id = NULL WHERE created_by_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
) OR updated_by_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE goals SET owner_agent_id = NULL WHERE owner_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE issue_approvals SET linked_by_agent_id = NULL WHERE linked_by_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE issue_comments SET author_agent_id = NULL WHERE author_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE issue_execution_decisions SET actor_agent_id = NULL WHERE actor_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE issue_relations SET created_by_agent_id = NULL WHERE created_by_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE issue_thread_interactions SET created_by_agent_id = NULL, resolved_by_agent_id = NULL WHERE created_by_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
) OR resolved_by_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE join_requests SET created_agent_id = NULL WHERE created_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE projects SET lead_agent_id = NULL WHERE lead_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE routine_triggers SET created_by_agent_id = NULL, updated_by_agent_id = NULL WHERE created_by_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
) OR updated_by_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE routines SET assignee_agent_id = NULL, created_by_agent_id = NULL, updated_by_agent_id = NULL WHERE assignee_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
) OR created_by_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
) OR updated_by_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
UPDATE workspace_runtime_services SET owner_agent_id = NULL WHERE owner_agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);

-- 10. Delete activity log entries (nullable)
DELETE FROM activity_log WHERE actor_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);

-- Delete non-nullable agent FKs (must be deleted before agents)
DELETE FROM cost_events WHERE agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);
DELETE FROM finance_events WHERE agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);

-- 11. Delete the agents
DELETE FROM agents WHERE id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
);

-- Step 5: Verification
SELECT 'Verification - Agents remaining to delete' as check_type, COUNT(*) as count
FROM agents WHERE id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
)
UNION ALL
SELECT 'Verification - Orphaned heartbeat_runs', COUNT(*)
FROM heartbeat_runs WHERE agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
)
UNION ALL
SELECT 'Verification - Orphaned agent_task_sessions', COUNT(*)
FROM agent_task_sessions WHERE agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
)
UNION ALL
SELECT 'Verification - Orphaned agent_api_keys', COUNT(*)
FROM agent_api_keys WHERE agent_id::TEXT IN (
  SELECT a.id::TEXT
  FROM agents a
  WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
    AND a.name NOT IN (
      'measureforge-ai-cad-measurement-orchestrator',
      'measureforge-ai-measurement-coordination-specialist',
      'measureforge-ai-atlas-agent-creator',
      'measureforge-ai-architectural-element-specialist',
      'measureforge-ai-contour-analysis-specialist',
      'measureforge-ai-cost-estimation-specialist',
      'measureforge-ai-earthwork-calculation-specialist',
      'measureforge-ai-electrical-compliance-specialist',
      'measureforge-ai-electrical-measurement-specialist',
      'measureforge-ai-mep-element-specialist',
      'measureforge-ai-quantity-surveyor-specialist',
      'measureforge-ai-structural-element-specialist',
      'measureforge-ai-traffic-signal-compliance-specialist',
      'measureforge-ai-traffic-signal-measurement-specialist',
      'measureforge-ai-autocad-integration-specialist',
      'measureforge-ai-contract-tender-specialist',
      'measureforge-ai-order-generation-specialist',
      'measureforge-ai-asaqs-standards-specialist',
      'measureforge-ai-sans-standards-specialist',
      'measureforge-ai-electrical-qa-specialist',
      'measureforge-ai-measurement-validation-specialist',
      'measureforge-ai-visual-overlay-specialist'
    )
)
UNION ALL
SELECT 'Verification - Valid agents remaining', COUNT(*)
FROM agents a
WHERE a.company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013'
  AND a.name IN (
    'measureforge-ai-cad-measurement-orchestrator',
    'measureforge-ai-measurement-coordination-specialist',
    'measureforge-ai-atlas-agent-creator',
    'measureforge-ai-architectural-element-specialist',
    'measureforge-ai-contour-analysis-specialist',
    'measureforge-ai-cost-estimation-specialist',
    'measureforge-ai-earthwork-calculation-specialist',
    'measureforge-ai-electrical-compliance-specialist',
    'measureforge-ai-electrical-measurement-specialist',
    'measureforge-ai-mep-element-specialist',
    'measureforge-ai-quantity-surveyor-specialist',
    'measureforge-ai-structural-element-specialist',
    'measureforge-ai-traffic-signal-compliance-specialist',
    'measureforge-ai-traffic-signal-measurement-specialist',
    'measureforge-ai-autocad-integration-specialist',
    'measureforge-ai-contract-tender-specialist',
    'measureforge-ai-order-generation-specialist',
    'measureforge-ai-asaqs-standards-specialist',
    'measureforge-ai-sans-standards-specialist',
    'measureforge-ai-electrical-qa-specialist',
    'measureforge-ai-measurement-validation-specialist',
    'measureforge-ai-visual-overlay-specialist'
  );

-- Step 6: Show final state
SELECT 'Final state - Total MeasureForge agents' as info, COUNT(*) as count
FROM agents WHERE company_id::TEXT = '550e8400-e29b-41d4-a716-446655440013';

COMMIT;
