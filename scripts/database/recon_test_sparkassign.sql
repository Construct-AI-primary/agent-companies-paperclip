-- ============================================================
-- TEST: Single Agent Reconciliation — SparkAssign
-- ============================================================
-- Uses Database Druid's FK-safe delete order + ON CONFLICT fix
-- Each step is isolated with exception handling so ALL steps
-- execute and we see exactly where it fails.
-- ============================================================

BEGIN;

DO $hdr$ BEGIN RAISE NOTICE '=== STEP 0: Starting transaction ==='; END; $hdr$;

-- ====================== STEP 1: FK-SAFE DELETE ======================
DO $hdr$ BEGIN RAISE NOTICE '=== STEP 1a: SET NULL for nullable FK refs ==='; END; $hdr$;

DO $a$ BEGIN
UPDATE agent_config_revisions SET created_by_agent_id = NULL WHERE created_by_agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: agent_config_revisions';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: agent_config_revisions - %', SQLERRM;
END; $a$;

DO $b$ BEGIN
UPDATE company_secret_versions SET created_by_agent_id = NULL WHERE created_by_agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: company_secret_versions';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: company_secret_versions - %', SQLERRM;
END; $b$;

DO $c$ BEGIN
UPDATE company_secrets SET created_by_agent_id = NULL WHERE created_by_agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: company_secrets';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: company_secrets - %', SQLERRM;
END; $c$;

DO $d$ BEGIN
UPDATE document_revisions SET created_by_agent_id = NULL WHERE created_by_agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: document_revisions';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: document_revisions - %', SQLERRM;
END; $d$;

DO $e$ BEGIN
UPDATE documents SET created_by_agent_id = NULL WHERE created_by_agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: documents (created)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: documents (created) - %', SQLERRM;
END; $e$;

DO $f$ BEGIN
UPDATE documents SET updated_by_agent_id = NULL WHERE updated_by_agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: documents (updated)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: documents (updated) - %', SQLERRM;
END; $f$;

DO $g$ BEGIN
UPDATE issue_approvals SET linked_by_agent_id = NULL WHERE linked_by_agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: issue_approvals';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: issue_approvals - %', SQLERRM;
END; $g$;

DO $h$ BEGIN
UPDATE issue_relations SET created_by_agent_id = NULL WHERE created_by_agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: issue_relations';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: issue_relations - %', SQLERRM;
END; $h$;

DO $i$ BEGIN
UPDATE routine_triggers SET created_by_agent_id = NULL WHERE created_by_agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: routine_triggers (created)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: routine_triggers (created) - %', SQLERRM;
END; $i$;

DO $j$ BEGIN
UPDATE routine_triggers SET updated_by_agent_id = NULL WHERE updated_by_agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: routine_triggers (updated)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: routine_triggers (updated) - %', SQLERRM;
END; $j$;

DO $k$ BEGIN
UPDATE routines SET created_by_agent_id = NULL WHERE created_by_agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: routines (created)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: routines (created) - %', SQLERRM;
END; $k$;

DO $l$ BEGIN
UPDATE routines SET updated_by_agent_id = NULL WHERE updated_by_agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: routines (updated)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: routines (updated) - %', SQLERRM;
END; $l$;

DO $m$ BEGIN
UPDATE workspace_runtime_services SET owner_agent_id = NULL WHERE owner_agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: workspace_runtime_services';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: workspace_runtime_services - %', SQLERRM;
END; $m$;

DO $n$ BEGIN
UPDATE agents SET reports_to = NULL WHERE reports_to::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: agents (reports_to)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: agents (reports_to) - %', SQLERRM;
END; $n$;

-- Phase 2: Delete heartbeat-related records (deepest deps)
DO $o$ BEGIN RAISE NOTICE '=== STEP 1b: Delete heartbeat/activity records ==='; END; $o$;

DO $p$ BEGIN
DELETE FROM activity_log WHERE agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: activity_log';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: activity_log - %', SQLERRM;
END; $p$;

DO $q$ BEGIN
DELETE FROM heartbeat_run_events WHERE run_id IN (SELECT hr.id FROM heartbeat_runs hr WHERE hr.agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist'));
RAISE NOTICE '  OK: heartbeat_run_events';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: heartbeat_run_events - %', SQLERRM;
END; $q$;

DO $r$ BEGIN
DELETE FROM agent_task_sessions WHERE agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: agent_task_sessions';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: agent_task_sessions - %', SQLERRM;
END; $r$;

DO $s$ BEGIN
DELETE FROM cost_events WHERE agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: cost_events';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: cost_events - %', SQLERRM;
END; $s$;

DO $t$ BEGIN
DELETE FROM finance_events WHERE agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: finance_events';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: finance_events - %', SQLERRM;
END; $t$;

DO $u$ BEGIN
DELETE FROM heartbeat_runs WHERE agent_id::text IN (SELECT id::text FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: heartbeat_runs';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: heartbeat_runs - %', SQLERRM;
END; $u$;

-- Phase 3: Delete direct FK targets
DO $v$ BEGIN RAISE NOTICE '=== STEP 1c: Delete direct FK targets ==='; END; $v$;

-- agent_models.agent_id is varchar (title string), NOT uuid
DO $w$ BEGIN
DELETE FROM agent_models WHERE agent_id IN (SELECT title FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: agent_models';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: agent_models - %', SQLERRM;
END; $w$;

DO $x$ BEGIN
DELETE FROM agent_api_keys WHERE agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: agent_api_keys';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: agent_api_keys - %', SQLERRM;
END; $x$;

DO $y$ BEGIN
DELETE FROM agent_skill_assignments WHERE agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: agent_skill_assignments';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: agent_skill_assignments - %', SQLERRM;
END; $y$;

DO $z$ BEGIN
DELETE FROM agent_runtime_state WHERE agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: agent_runtime_state';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: agent_runtime_state - %', SQLERRM;
END; $z$;

DO $aa$ BEGIN
DELETE FROM agent_wakeup_requests WHERE agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: agent_wakeup_requests';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: agent_wakeup_requests - %', SQLERRM;
END; $aa$;

DO $ab$ BEGIN
DELETE FROM agent_config_revisions WHERE agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: agent_config_revisions';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: agent_config_revisions - %', SQLERRM;
END; $ab$;

DO $ac$ BEGIN
DELETE FROM approvals WHERE requested_by_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: approvals';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: approvals - %', SQLERRM;
END; $ac$;

DO $ad$ BEGIN
DELETE FROM approval_comments WHERE author_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: approval_comments';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: approval_comments - %', SQLERRM;
END; $ad$;

DO $ae$ BEGIN
DELETE FROM goals WHERE owner_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: goals';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: goals - %', SQLERRM;
END; $ae$;

DO $af$ BEGIN
DELETE FROM issue_comments WHERE author_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: issue_comments';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: issue_comments - %', SQLERRM;
END; $af$;

DO $ag$ BEGIN
DELETE FROM issues WHERE created_by_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: issues (created_by)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: issues (created_by) - %', SQLERRM;
END; $ag$;

DO $ah$ BEGIN
DELETE FROM issues WHERE assignee_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: issues (assignee)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: issues (assignee) - %', SQLERRM;
END; $ah$;

DO $ai$ BEGIN
DELETE FROM projects WHERE lead_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
RAISE NOTICE '  OK: projects';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: projects - %', SQLERRM;
END; $ai$;

DELETE FROM issue_relations WHERE created_by_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $aj$ BEGIN
RAISE NOTICE '  OK: issue_relations';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: issue_relations - %', SQLERRM;
END; $aj$;

DELETE FROM issue_execution_decisions WHERE actor_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $ak$ BEGIN
RAISE NOTICE '  OK: issue_execution_decisions';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: issue_execution_decisions - %', SQLERRM;
END; $ak$;

DELETE FROM issue_thread_interactions WHERE created_by_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $al$ BEGIN
RAISE NOTICE '  OK: issue_thread_interactions (created)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: issue_thread_interactions (created) - %', SQLERRM;
END; $al$;

DELETE FROM issue_thread_interactions WHERE resolved_by_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $am$ BEGIN
RAISE NOTICE '  OK: issue_thread_interactions (resolved)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: issue_thread_interactions (resolved) - %', SQLERRM;
END; $am$;

DELETE FROM join_requests WHERE created_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $an$ BEGIN
RAISE NOTICE '  OK: join_requests';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: join_requests - %', SQLERRM;
END; $an$;

DELETE FROM assets WHERE created_by_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $ao$ BEGIN
RAISE NOTICE '  OK: assets';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: assets - %', SQLERRM;
END; $ao$;

DELETE FROM routine_triggers WHERE created_by_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $ap$ BEGIN
RAISE NOTICE '  OK: routine_triggers (delete created)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: routine_triggers (delete created) - %', SQLERRM;
END; $ap$;

DELETE FROM routine_triggers WHERE updated_by_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $aq$ BEGIN
RAISE NOTICE '  OK: routine_triggers (delete updated)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: routine_triggers (delete updated) - %', SQLERRM;
END; $aq$;

DELETE FROM routines WHERE assignee_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $ar$ BEGIN
RAISE NOTICE '  OK: routines (assignee)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: routines (assignee) - %', SQLERRM;
END; $ar$;

DELETE FROM routines WHERE created_by_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $as$ BEGIN
RAISE NOTICE '  OK: routines (delete created)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: routines (delete created) - %', SQLERRM;
END; $as$;

DELETE FROM routines WHERE updated_by_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $at$ BEGIN
RAISE NOTICE '  OK: routines (delete updated)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: routines (delete updated) - %', SQLERRM;
END; $at$;

-- Phase 3b: Measurement/Engineering tables (a_ prefix)
DO $au$ BEGIN RAISE NOTICE '=== STEP 1d: Delete measurement/engineering records ==='; END; $au$;

DELETE FROM a_measurement_data WHERE created_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $av$ BEGIN
RAISE NOTICE '  OK: a_measurement_data (created)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_measurement_data (created) - %', SQLERRM;
END; $av$;

DELETE FROM a_measurement_data WHERE updated_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $aw$ BEGIN
RAISE NOTICE '  OK: a_measurement_data (updated)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_measurement_data (updated) - %', SQLERRM;
END; $aw$;

DELETE FROM a_measurement_standards WHERE created_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $ax$ BEGIN
RAISE NOTICE '  OK: a_measurement_standards (created)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_measurement_standards (created) - %', SQLERRM;
END; $ax$;

DELETE FROM a_measurement_standards WHERE updated_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $ay$ BEGIN
RAISE NOTICE '  OK: a_measurement_standards (updated)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_measurement_standards (updated) - %', SQLERRM;
END; $ay$;

DELETE FROM a_measurement_templates WHERE created_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $az$ BEGIN
RAISE NOTICE '  OK: a_measurement_templates (created)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_measurement_templates (created) - %', SQLERRM;
END; $az$;

DELETE FROM a_measurement_templates WHERE updated_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $ba$ BEGIN
RAISE NOTICE '  OK: a_measurement_templates (updated)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_measurement_templates (updated) - %', SQLERRM;
END; $ba$;

DELETE FROM a_measurement_validation_rules WHERE created_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $bb$ BEGIN
RAISE NOTICE '  OK: a_measurement_validation_rules (created)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_measurement_validation_rules (created) - %', SQLERRM;
END; $bb$;

DELETE FROM a_measurement_validation_rules WHERE updated_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $bc$ BEGIN
RAISE NOTICE '  OK: a_measurement_validation_rules (updated)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_measurement_validation_rules (updated) - %', SQLERRM;
END; $bc$;

DELETE FROM a_measurement_cad_integration WHERE created_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $bd$ BEGIN
RAISE NOTICE '  OK: a_measurement_cad_integration (created)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_measurement_cad_integration (created) - %', SQLERRM;
END; $bd$;

DELETE FROM a_measurement_cad_integration WHERE updated_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $be$ BEGIN
RAISE NOTICE '  OK: a_measurement_cad_integration (updated)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_measurement_cad_integration (updated) - %', SQLERRM;
END; $be$;

DELETE FROM a_measurement_approvals WHERE approver_user IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $bf$ BEGIN
RAISE NOTICE '  OK: a_measurement_approvals (approver)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_measurement_approvals (approver) - %', SQLERRM;
END; $bf$;

DELETE FROM a_measurement_approvals WHERE created_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $bg$ BEGIN
RAISE NOTICE '  OK: a_measurement_approvals (created)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_measurement_approvals (created) - %', SQLERRM;
END; $bg$;

DELETE FROM a_measurement_audit_trail WHERE user_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $bh$ BEGIN
RAISE NOTICE '  OK: a_measurement_audit_trail';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_measurement_audit_trail - %', SQLERRM;
END; $bh$;

DELETE FROM a_engineering_models WHERE created_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $bi$ BEGIN
RAISE NOTICE '  OK: a_engineering_models (created)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_engineering_models (created) - %', SQLERRM;
END; $bi$;

DELETE FROM a_engineering_models WHERE updated_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $bj$ BEGIN
RAISE NOTICE '  OK: a_engineering_models (updated)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_engineering_models (updated) - %', SQLERRM;
END; $bj$;

DELETE FROM a_engineering_analysis WHERE created_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $bk$ BEGIN
RAISE NOTICE '  OK: a_engineering_analysis';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_engineering_analysis - %', SQLERRM;
END; $bk$;

DELETE FROM a_engineering_audit_trail WHERE user_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $bl$ BEGIN
RAISE NOTICE '  OK: a_engineering_audit_trail';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_engineering_audit_trail - %', SQLERRM;
END; $bl$;

DELETE FROM a_engineering_standards WHERE created_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $bm$ BEGIN
RAISE NOTICE '  OK: a_engineering_standards (created)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_engineering_standards (created) - %', SQLERRM;
END; $bm$;

DELETE FROM a_engineering_standards WHERE updated_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $bn$ BEGIN
RAISE NOTICE '  OK: a_engineering_standards (updated)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_engineering_standards (updated) - %', SQLERRM;
END; $bn$;

DELETE FROM a_engineering_templates WHERE created_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $bo$ BEGIN
RAISE NOTICE '  OK: a_engineering_templates (created)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_engineering_templates (created) - %', SQLERRM;
END; $bo$;

DELETE FROM a_engineering_templates WHERE updated_by IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $bp$ BEGIN
RAISE NOTICE '  OK: a_engineering_templates (updated)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: a_engineering_templates (updated) - %', SQLERRM;
END; $bp$;

DELETE FROM document_revisions WHERE created_by_agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');
DO $bq$ BEGIN RAISE NOTICE '  OK: document_revisions (final)'; EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: document_revisions (final) - %', SQLERRM; END; $bq$;

-- Phase 4: Finally, delete the agent itself
DO $br$ BEGIN RAISE NOTICE '=== STEP 1e: Delete agent ==='; END; $br$;

DELETE FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist';
DO $bs$ BEGIN
RAISE NOTICE '  OK: agents (final)';
EXCEPTION WHEN OTHERS THEN RAISE WARNING '  FAIL: agents (final) - %', SQLERRM;
END; $bs$;

-- ====================== STEP 2: INSERT SPARKASSIGN ======================
DO $bt$ BEGIN RAISE NOTICE '=== STEP 2: Insert agent ==='; END; $bt$;

INSERT INTO agents (
    id, company_id, name, role, title, status, capabilities,
    adapter_type, adapter_config, runtime_config, created_at, updated_at
) VALUES (
    gen_random_uuid(),
    '550e8400-e29b-41d4-a716-446655440014',
    'SparkAssign',
    'model-assignment-specialist',
    'paperclipforge-ai-model-assignment-specialist',
    'idle',
    '["model_assignment", "model_monitoring", "skill_tracking", "model_rover"]',
    'hermes_local',
    '{"adapter": "hermes_local", "model": "deepseek/deepseek-v4-flash"}'::jsonb,
    '{}'::jsonb,
    NOW(),
    NOW()
);

-- ====================== STEP 3: INSERT MODEL ASSIGNMENT (ON CONFLICT) ======================
DO $bu$ BEGIN RAISE NOTICE '=== STEP 3: Insert model assignment (ON CONFLICT) ==='; END; $bu$;

INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT
    gen_random_uuid(),
    title,  -- agent_models.agent_id stores the title string (varchar)
    'deepseek/deepseek-v4-flash',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
FROM agents
WHERE title = 'paperclipforge-ai-model-assignment-specialist'
ON CONFLICT (agent_id, assignment_type) DO UPDATE
SET model_id = EXCLUDED.model_id,
    temperature = EXCLUDED.temperature,
    max_tokens = EXCLUDED.max_tokens,
    is_active = EXCLUDED.is_active,
    updated_at = NOW();

-- ====================== STEP 4: INSERT API KEY ======================
DO $bv$ BEGIN RAISE NOTICE '=== STEP 4: Insert API key ==='; END; $bv$;

INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT
    gen_random_uuid(),
    a.id,
    a.company_id,
    'default',
    'pcp_' || encode(gen_random_bytes(24), 'hex'),
    NOW()
FROM agents a
WHERE a.title = 'paperclipforge-ai-model-assignment-specialist'
ON CONFLICT DO NOTHING;

-- ====================== STEP 5: VERIFY RESULTS ======================
DO $bw$ BEGIN RAISE NOTICE '=== STEP 5: VERIFICATION ==='; END; $bw$;

DO $verif$
DECLARE
    v_agent_count int;
    v_model_count int;
    v_key_count int;
BEGIN
    SELECT COUNT(*) INTO v_agent_count FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist';
    SELECT COUNT(*) INTO v_model_count FROM agent_models WHERE agent_id = 'paperclipforge-ai-model-assignment-specialist';
    SELECT COUNT(*) INTO v_key_count FROM agent_api_keys ak WHERE ak.agent_id IN (SELECT id FROM agents WHERE title = 'paperclipforge-ai-model-assignment-specialist');

    RAISE NOTICE '==========================================';
    RAISE NOTICE 'VERIFICATION RESULTS:';
    RAISE NOTICE '  Agents found: %', v_agent_count;
    RAISE NOTICE '  Models found: %', v_model_count;
    RAISE NOTICE '  API keys found: %', v_key_count;
    RAISE NOTICE '==========================================';

    IF v_agent_count = 1 AND v_model_count = 1 AND v_key_count >= 1 THEN
        RAISE NOTICE '✅ TEST PASSED: SparkAssign fully reconciled';
    ELSE
        RAISE WARNING '❌ TEST ISSUE: Expected (1,1,1) got (%,%,%)', v_agent_count, v_model_count, v_key_count;
    END IF;
END;
$verif$;

DO $by$ BEGIN RAISE NOTICE '=== STEP 6: Commit transaction ==='; END; $by$;

COMMIT;