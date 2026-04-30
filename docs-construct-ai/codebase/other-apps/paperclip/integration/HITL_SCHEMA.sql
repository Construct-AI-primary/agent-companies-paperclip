-- =====================================================
-- HITL Approval Workflow - Supabase Schema
-- Gold Star Enterprise - OpenClaw Integration
-- Run this file once to set up HITL approval infrastructure
-- Verified against actual Supabase schema (2026-04-04)
-- =====================================================

-- Enable UUID extension (may already exist)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =====================================================
-- HITL Queue Table
-- =====================================================

CREATE TABLE IF NOT EXISTS hitl_queue (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    request_id text UNIQUE NOT NULL DEFAULT 'hitl-' || EXTRACT(EPOCH FROM NOW())::BIGINT || '-' || gen_random_uuid()::text,
    domain text NOT NULL,
    discipline_code text,
    topic text NOT NULL,
    research_agent text NOT NULL,
    research_results jsonb DEFAULT '{}',
    requested_by text NOT NULL,
    requested_at timestamp with time zone NOT NULL DEFAULT now(),
    required_expert text NOT NULL,
    assigned_expert text,
    assigned_at timestamp with time zone,
    approval_criteria jsonb DEFAULT '{}',
    timeout_hours integer DEFAULT 48,
    escalation_path text[] DEFAULT ARRAY['engineering-director', 'ceo'],
    priority text DEFAULT 'medium' CHECK (priority IN ('critical', 'high', 'medium', 'low')),
    status text DEFAULT 'pending' CHECK (status IN ('pending', 'in_review', 'assigned', 'approved', 'rejected', 'integrated', 'resubmitted', 'timed_out', 'escalated')),
    expert_response jsonb,
    expert_response_at timestamp with time zone,
    integration_status text DEFAULT 'pending' CHECK (integration_status IN ('pending', 'in_progress', 'completed', 'failed')),
    integration_completed_at timestamp with time zone,
    knowledge_path text,
    audit_trail jsonb DEFAULT '[]',
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_hitl_queue_status ON hitl_queue(status);
CREATE INDEX IF NOT EXISTS idx_hitl_queue_priority ON hitl_queue(priority);
CREATE INDEX IF NOT EXISTS idx_hitl_queue_domain ON hitl_queue(domain);
CREATE INDEX IF NOT EXISTS idx_hitl_queue_assigned_expert ON hitl_queue(assigned_expert);
CREATE INDEX IF NOT EXISTS idx_hitl_queue_requested_at ON hitl_queue(requested_at);
CREATE INDEX IF NOT EXISTS idx_hitl_queue_discipline ON hitl_queue(discipline_code);

-- =====================================================
-- HITL Audit Log Table
-- =====================================================

CREATE TABLE IF NOT EXISTS hitl_audit_log (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    log_id text UNIQUE NOT NULL DEFAULT 'audit-' || EXTRACT(EPOCH FROM NOW())::BIGINT || '-' || gen_random_uuid()::text,
    request_id text NOT NULL,
    domain text,
    topic text,
    research_agent text,
    expert text,
    action text NOT NULL CHECK (action IN ('created', 'assigned', 'expert_review_started', 'approved', 'rejected', 'resubmitted', 'escalated', 'timed_out', 'integrated', 'integration_failed')),
    timestamp timestamp with time zone NOT NULL DEFAULT now(),
    review_duration interval,
    confidence numeric(3,2),
    comments text,
    created_at timestamp with time zone DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_hitl_audit_log_request_id ON hitl_audit_log(request_id);
CREATE INDEX IF NOT EXISTS idx_hitl_audit_log_action ON hitl_audit_log(action);
CREATE INDEX IF NOT EXISTS idx_hitl_audit_log_expert ON hitl_audit_log(expert);

-- =====================================================
-- Expert Registry Table
-- =====================================================

CREATE TABLE IF NOT EXISTS hitl_experts (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    expert_id text UNIQUE NOT NULL,
    name text NOT NULL,
    email text,
    primary_domain text NOT NULL,
    specializations text[] DEFAULT '{}',
    discipline_codes text[] DEFAULT '{}',
    available boolean DEFAULT true,
    max_concurrent_reviews integer DEFAULT 5,
    current_load integer DEFAULT 0,
    escalation_to text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_hitl_experts_domain ON hitl_experts(primary_domain);
CREATE INDEX IF NOT EXISTS idx_hitl_experts_available ON hitl_experts(available);

-- =====================================================
-- Knowledge Integration Log Table
-- =====================================================

CREATE TABLE IF NOT EXISTS knowledge_integration_log (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    integration_id text UNIQUE NOT NULL DEFAULT 'knowledge-' || EXTRACT(EPOCH FROM NOW())::BIGINT || '-' || gen_random_uuid()::text,
    request_id text NOT NULL,
    domain text NOT NULL,
    discipline_code text,
    topic text NOT NULL,
    knowledge_path text NOT NULL,
    status text DEFAULT 'pending' CHECK (status IN ('pending', 'in_progress', 'completed', 'failed')),
    approved_by text,
    approved_confidence numeric(3,2),
    git_commit_hash text,
    git_branch text DEFAULT 'main',
    integrated_at timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_knowledge_integration_request_id ON knowledge_integration_log(request_id);
CREATE INDEX IF NOT EXISTS idx_knowledge_integration_domain ON knowledge_integration_log(domain);
CREATE INDEX IF NOT EXISTS idx_knowledge_integration_status ON knowledge_integration_log(status);

-- =====================================================
-- Monitoring Views
-- =====================================================

CREATE OR REPLACE VIEW v_hitl_queue_dashboard AS
SELECT 
    domain,
    priority,
    status,
    COUNT(*) as request_count,
    AVG(EXTRACT(EPOCH FROM (COALESCE(expert_response_at, NOW()) - requested_at))/3600) as avg_hours_pending
FROM hitl_queue
WHERE status NOT IN ('integrated', 'failed')
GROUP BY domain, priority, status
ORDER BY request_count DESC;

CREATE OR REPLACE VIEW v_expert_workload AS
SELECT 
    assigned_expert,
    h.primary_domain,
    COUNT(CASE WHEN hq.status IN ('pending', 'in_review', 'assigned') THEN 1 END) as active_reviews,
    COUNT(CASE WHEN hq.status = 'approved' THEN 1 END) as completed_approvals,
    COUNT(CASE WHEN hq.status = 'rejected' THEN 1 END) as completed_rejections,
    AVG(EXTRACT(EPOCH FROM (hq.expert_response_at - hq.assigned_at))/3600) as avg_review_hours
FROM hitl_experts h
LEFT JOIN hitl_queue hq ON hq.assigned_expert = h.expert_id AND hq.created_at >= NOW() - INTERVAL '30 days'
GROUP BY assigned_expert, h.primary_domain;

CREATE OR REPLACE VIEW v_approval_time_metrics AS
SELECT 
    domain,
    discipline_code,
    priority,
    COUNT(*) as total_requests,
    AVG(EXTRACT(EPOCH FROM (expert_response_at - requested_at))/3600) as avg_approval_hours,
    MIN(EXTRACT(EPOCH FROM (expert_response_at - requested_at))/3600) as min_approval_hours,
    MAX(EXTRACT(EPOCH FROM (expert_response_at - requested_at))/3600) as max_approval_hours,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY EXTRACT(EPOCH FROM (expert_response_at - requested_at))/3600) as median_approval_hours,
    PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY EXTRACT(EPOCH FROM (expert_response_at - requested_at))/3600) as p90_approval_hours,
    SUM(CASE WHEN status = 'approved' THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0) as approval_rate
FROM hitl_queue
WHERE expert_response_at IS NOT NULL
  AND requested_at >= NOW() - INTERVAL '90 days'
GROUP BY domain, discipline_code, priority
ORDER BY total_requests DESC;

CREATE OR REPLACE VIEW v_first_pass_approval_rate AS
SELECT 
    domain,
    discipline_code,
    COUNT(*) as total_requests,
    SUM(CASE WHEN status = 'approved' AND (expert_response->>'rejectionReason') IS NULL THEN 1 ELSE 0 END) as first_pass_approved,
    ROUND(100.0 * SUM(CASE WHEN status = 'approved' AND (expert_response->>'rejectionReason') IS NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) as first_pass_rate_percent
FROM hitl_queue
WHERE requested_at >= NOW() - INTERVAL '90 days'
GROUP BY domain, discipline_code
ORDER BY first_pass_rate_percent DESC;

CREATE OR REPLACE VIEW v_timeout_rate AS
SELECT 
    priority,
    COUNT(*) as total_requests,
    SUM(CASE WHEN status = 'timed_out' THEN 1 ELSE 0 END) as timed_out,
    ROUND(100.0 * SUM(CASE WHEN status = 'timed_out' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) as timeout_rate_percent
FROM hitl_queue
WHERE requested_at >= NOW() - INTERVAL '90 days'
GROUP BY priority
ORDER BY total_requests DESC;

CREATE OR REPLACE VIEW v_knowledge_integration_tracking AS
SELECT 
    k.domain,
    k.discipline_code,
    k.topic,
    k.knowledge_path,
    k.status,
    k.approved_by,
    k.approved_confidence,
    k.integrated_at,
    h.request_id,
    h.research_agent,
    h.expert_response
FROM knowledge_integration_log k
JOIN hitl_queue h ON h.request_id = k.request_id
ORDER BY k.integrated_at DESC;

-- =====================================================
-- Triggers for Audit Logging
-- =====================================================

CREATE OR REPLACE FUNCTION fn_hitl_audit_log()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status IS DISTINCT FROM NEW.status THEN
        INSERT INTO hitl_audit_log (request_id, domain, topic, research_agent, expert, action, timestamp, review_duration, confidence)
        VALUES (
            NEW.request_id, NEW.domain, NEW.topic, NEW.research_agent,
            COALESCE(NEW.assigned_expert, OLD.assigned_expert), NEW.status, NOW(),
            CASE WHEN NEW.expert_response_at IS NOT NULL AND NEW.assigned_at IS NOT NULL THEN NEW.expert_response_at - NEW.assigned_at ELSE NULL END,
            CASE WHEN NEW.expert_response IS NOT NULL THEN (NEW.expert_response->>'approvalConfidence')::numeric ELSE NULL END
        );
    END IF;
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_hitl_queue_audit ON hitl_queue;
CREATE TRIGGER trg_hitl_queue_audit AFTER UPDATE ON hitl_queue FOR EACH ROW EXECUTE FUNCTION fn_hitl_audit_log();

-- =====================================================
-- Functions for Queue Management
-- =====================================================

CREATE OR REPLACE FUNCTION fn_assign_next_expert(p_domain text, p_discipline_code text, p_topic text)
RETURNS TABLE (expert_id text, name text, available boolean, current_load integer) AS $$
BEGIN
    RETURN QUERY
    SELECT h.expert_id, h.name, h.available, h.current_load
    FROM hitl_experts h
    WHERE (h.primary_domain = p_domain OR h.specializations @> ARRAY[p_topic])
      AND (h.discipline_codes = '{}' OR h.discipline_codes @> ARRAY[p_discipline_code])
    ORDER BY h.available DESC, h.current_load ASC, RANDOM()
    LIMIT 1;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_update_expert_workload(p_expert_id text, p_increment integer)
RETURNS VOID AS $$
BEGIN
    UPDATE hitl_experts
    SET current_load = GREATEST(0, current_load + p_increment),
        available = CASE WHEN current_load + p_increment >= 10 THEN false ELSE available END
    WHERE expert_id = p_expert_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_escalate_timed_out_requests()
RETURNS integer AS $$
DECLARE v_count integer;
BEGIN
    UPDATE hitl_queue
    SET status = 'timed_out',
        audit_trail = jsonb_set(COALESCE(audit_trail, '[]'::jsonb), ARRAY[jsonb_array_length(COALESCE(audit_trail, '[]'::jsonb))], jsonb_build_object('action', 'timeout', 'timestamp', NOW(), 'timeout_hours', timeout_hours))
    WHERE status IN ('pending', 'assigned', 'in_review')
      AND requested_at < NOW() - (timeout_hours || ' hours')::interval;
    GET DIAGNOSTICS v_count = ROW_COUNT;
    RETURN v_count;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_get_expert_pending_requests(p_expert_id text)
RETURNS TABLE (request_id text, domain text, discipline_code text, topic text, priority text, requested_at timestamp with time zone, timeout_hours integer, hours_remaining numeric(10,2)) AS $$
BEGIN
    RETURN QUERY
    SELECT h.request_id, h.domain, h.discipline_code, h.topic, h.priority, h.requested_at, h.timeout_hours,
           EXTRACT(EPOCH FROM (h.requested_at + (h.timeout_hours || ' hours')::interval - NOW()))/3600 as hours_remaining
    FROM hitl_queue h
    WHERE h.assigned_expert = p_expert_id AND h.status IN ('pending', 'assigned', 'in_review')
    ORDER BY CASE h.priority WHEN 'critical' THEN 1 WHEN 'high' THEN 2 WHEN 'medium' THEN 3 WHEN 'low' THEN 4 ELSE 5 END, h.requested_at ASC;
END;
$$ LANGUAGE plpgsql;

-- =====================================================
-- Seed Data: Default Expert Registry
-- =====================================================

INSERT INTO hitl_experts (expert_id, name, primary_domain, specializations, discipline_codes) VALUES
('structural-engineer-lead', 'Lead Structural Engineer', 'civil-engineering', ARRAY['structural design', 'foundation design', 'seismic analysis'], ARRAY['00850', '00872']),
('civil-engineer-senior', 'Senior Civil Engineer', 'civil-engineering', ARRAY['site assessment', 'drainage design', 'road design', 'environmental impact'], ARRAY['00850']),
('geotechnical-engineer-lead', 'Lead Geotechnical Engineer', 'civil-engineering', ARRAY['soil analysis', 'foundation design', 'slope stability'], ARRAY['00855']),
('commercial-manager-senior', 'Senior Commercial Manager', 'commercial', ARRAY['cost estimation', 'risk assessment', 'market analysis'], ARRAY['00250']),
('quantity-surveyor-lead', 'Lead Quantity Surveyor', 'commercial', ARRAY['measurement', 'valuation', 'cost control'], ARRAY['02025']),
('contracts-manager-lead', 'Lead Contracts Manager', 'contracts', ARRAY['contract drafting', 'claims management', 'dispute resolution'], ARRAY['00400', '00425', '00435']),
('legal-advisor', 'Legal Advisor', 'legal', ARRAY['contract review', 'regulatory compliance', 'dispute resolution'], ARRAY['01750']),
('claims-manager', 'Claims Manager', 'contracts', ARRAY['claims evaluation', 'documentation', 'dispute support'], ARRAY['00435']),
('dispute-resolution-lead', 'Dispute Resolution Lead', 'contracts', ARRAY['mediation', 'arbitration', 'adjudication'], ARRAY['00435']),
('electrical-engineer-lead', 'Lead Electrical Engineer', 'electrical-engineering', ARRAY['power systems', 'distribution', 'control systems'], ARRAY['00860']),
('protection-engineer', 'Protection Engineer', 'electrical-engineering', ARRAY['relay coordination', 'short circuit', 'arc flash'], ARRAY['00860']),
('mechanical-engineer-lead', 'Lead Mechanical Engineer', 'mechanical-engineering', ARRAY['HVAC design', 'piping design', 'equipment sizing'], ARRAY['00870']),
('hvac-specialist', 'HVAC Specialist', 'mechanical-engineering', ARRAY['air conditioning', 'ventilation', 'heating systems'], ARRAY['00870']),
('piping-engineer', 'Piping Engineer', 'mechanical-engineering', ARRAY['stress analysis', 'material selection', 'piping design'], ARRAY['00870']),
('process-engineer-lead', 'Lead Process Engineer', 'process-engineering', ARRAY['process design', 'P&ID review', 'mass balance'], ARRAY['00871']),
('chemical-engineer', 'Chemical Engineer', 'process-engineering', ARRAY['Hazard analysis', 'equipment specification', 'safety cases'], ARRAY['00835', '00871']),
('hazop-lead', 'HAZOP Lead', 'process-engineering', ARRAY['HAZOP facilitation', 'risk identification', 'safety review'], ARRAY['00871']),
('it-architect-lead', 'Lead IT Architect', 'information-technology', ARRAY['system architecture', 'API integration', 'data pipelines'], ARRAY['02050']),
('ml-engineer', 'ML Engineer', 'information-technology', ARRAY['AI/LLM integration', 'model deployment', 'data pipelines'], ARRAY['02050']),
('data-engineer-lead', 'Lead Data Engineer', 'information-technology', ARRAY['data pipelines', 'ETL design', 'data warehouse'], ARRAY['02050']),
('safety-manager-lead', 'Lead Safety Manager', 'safety', ARRAY['risk assessment', 'incident investigation', 'safety procedures'], ARRAY['02400']),
('hse-director', 'HSE Director', 'safety', ARRAY['environmental compliance', 'safety governance', 'incident procedures'], ARRAY['00885', '02400']),
('design-coordinator', 'Design Coordinator', 'design', ARRAY['BIM coordination', 'clash detection', 'design review'], ARRAY['00800']),
('environmental-engineer', 'Environmental Engineer', 'environmental', ARRAY['environmental impact', 'monitoring', 'compliance'], ARRAY['01000']),
('engineering-director', 'Engineering Director', 'engineering', ARRAY['engineering oversight', 'technical direction', 'escalation'], ARRAY['00884']),
('commercial-director', 'Commercial Director', 'commercial', ARRAY['commercial oversight', 'contract strategy', 'escalation'], ARRAY['00889']),
('contracts-director', 'Contracts Director', 'contracts', ARRAY['contracts oversight', 'claim strategy', 'escalation'], ARRAY['00883']),
('ceo', 'Chief Executive Officer', 'executive', ARRAY['final escalation', 'strategic decisions', 'enterprise oversight'], ARRAY[]::text[])
ON CONFLICT (expert_id) DO NOTHING;

-- =====================================================
-- Row Level Security (RLS) Policies
-- =====================================================

ALTER TABLE hitl_queue ENABLE ROW LEVEL SECURITY;
ALTER TABLE hitl_audit_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE hitl_experts ENABLE ROW LEVEL SECURITY;
ALTER TABLE knowledge_integration_log ENABLE ROW LEVEL SECURITY;

-- Allow authenticated users full access
CREATE POLICY "hitl_queue_all" ON hitl_queue FOR ALL USING (auth.role() = 'authenticated') WITH CHECK (auth.role() = 'authenticated');
CREATE POLICY "hitl_audit_log_all" ON hitl_audit_log FOR ALL USING (auth.role() = 'authenticated') WITH CHECK (auth.role() = 'authenticated');
CREATE POLICY "hitl_experts_all" ON hitl_experts FOR ALL USING (auth.role() = 'authenticated') WITH CHECK (auth.role() = 'authenticated');
CREATE POLICY "knowledge_integration_all" ON knowledge_integration_log FOR ALL USING (auth.role() = 'authenticated') WITH CHECK (auth.role() = 'authenticated');

-- =====================================================
-- Completion Message
-- =====================================================

DO $$
BEGIN
    RAISE NOTICE 'HITL Approval Workflow schema created successfully.';
    RAISE NOTICE 'Tables: hitl_queue, hitl_audit_log, hitl_experts, knowledge_integration_log';
    RAISE NOTICE 'Views: v_hitl_queue_dashboard, v_expert_workload, v_approval_time_metrics, v_first_pass_approval_rate, v_timeout_rate, v_knowledge_integration_tracking';
    RAISE NOTICE 'Functions: fn_assign_next_expert, fn_update_expert_workload, fn_escalate_timed_out_requests, fn_get_expert_pending_requests';
    RAISE NOTICE 'Seed data: 28 domain experts inserted';
END $$;