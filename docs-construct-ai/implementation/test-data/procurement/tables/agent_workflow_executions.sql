-- Agent Workflow Executions Test Data for 01900 Procurement Workflow
-- Generated for comprehensive testing of 6-agent workflow system

INSERT INTO agent_workflow_executions (
    id,
    procurement_order_id,
    agent_id,
    agent_name,
    stage,
    status,
    input_data,
    output_data,
    confidence_score,
    processing_time_ms,
    executed_at,
    quality_gate_passed,
    quality_score,
    notifications_sent,
    metadata
) VALUES
-- Agent 1: Template Analysis for Order 001
(
    'uuid-agent-exec-001-01',
    '550e8400-e29b-41d4-a716-446655440101',
    'agent_procurement_01',
    'Template Analysis Agent',
    'template_analysis',
    'completed',
    '{"template_id": "uuid-template-001", "order_requirements": "CNC machines, conveyor systems, quality control stations", "compliance_context": "South African procurement regulations"}'::jsonb,
    '{"compatibility_score": 95, "template_suitability": "excellent", "identified_requirements": ["Technical specifications for industrial equipment", "Quality assurance procedures", "Safety compliance requirements", "Commercial terms and conditions"], "risk_assessment": "low", "recommendations": ["Template fully compatible with requirements", "All mandatory fields available", "Appendix structure matches order complexity"]}'::jsonb,
    0.92,
    2500,
    '2026-01-01T10:05:00Z',
    true,
    95,
    '["chatbot", "dashboard"]'::jsonb,
    '{"agent_version": "1.0", "processing_node": "agent-orchestrator-01", "retry_count": 0}'::jsonb
),
-- Agent 2: Requirement Extraction for Order 001
(
    'uuid-agent-exec-001-02',
    '550e8400-e29b-41d4-a716-446655440101',
    'agent_procurement_02',
    'Requirement Extraction Agent',
    'requirement_extraction',
    'completed',
    '{"order_description": "Complete procurement for production line equipment including CNC machines, conveyor systems, and quality control stations", "template_analysis": {"compatibility_score": 95, "identified_requirements": ["Technical specifications", "Quality assurance", "Safety compliance", "Commercial terms"]}}'::jsonb,
    '{"extracted_requirements": {"technical": ["CNC machine specifications (precision, capacity, power requirements)", "Conveyor system specifications (load capacity, speed, safety features)", "Quality control station specifications (measurement accuracy, calibration)", "Integration requirements with existing production line"], "quality": ["ISO 9001 compliance requirements", "Quality assurance procedures", "Testing and validation protocols", "Documentation and traceability requirements"], "safety": ["Machine guarding requirements", "Emergency stop systems", "Safety interlock specifications", "Operator training requirements"], "commercial": ["Delivery schedule requirements", "Payment terms and conditions", "Warranty and maintenance agreements", "Performance guarantees"]}, "requirement_confidence": 0.88, "total_requirements": 12, "categorized_requirements": 4}'::jsonb,
    0.88,
    3200,
    '2026-01-01T10:07:00Z',
    true,
    92,
    '["chatbot", "dashboard"]'::jsonb,
    '{"agent_version": "1.0", "processing_node": "agent-orchestrator-02", "retry_count": 0}'::jsonb
),
-- Agent 3: Compliance Validation for Order 001
(
    'uuid-agent-exec-001-03',
    '550e8400-e29b-41d4-a716-446655440101',
    'agent_procurement_03',
    'Compliance Validation Agent',
    'compliance_validation',
    'completed',
    '{"extracted_requirements": {"technical": ["CNC specifications", "Conveyor specs", "Quality control specs"], "quality": ["ISO compliance", "Testing protocols"], "safety": ["Machine guarding", "Emergency stops"], "commercial": ["Delivery schedule", "Payment terms"]}, "country_context": "South Africa", "industry_context": "Manufacturing"}'::jsonb,
    '{"compliance_validation": {"overall_compliance_score": 94, "gap_analysis": {"critical_gaps": [], "minor_gaps": ["Additional certification requirements for imported equipment"], "recommendations": ["Include local content requirements", "Specify BBBEE compliance level"]}, "regulatory_requirements": ["OHS Act compliance (Act 85 of 1993)", "Environmental Impact Assessment if required", "Import regulations for capital equipment", "Local procurement preferences"], "risk_assessment": {"compliance_risk": "low", "mitigation_required": "minimal", "monitoring_required": "standard"}}, "validation_metadata": {"compliance_score": 94, "gaps_identified": 1, "recommendations_provided": 2, "regulatory_frameworks_checked": 4}}'::jsonb,
    0.91,
    4100,
    '2026-01-01T10:09:00Z',
    true,
    96,
    '["chatbot", "dashboard"]'::jsonb,
    '{"agent_version": "1.0", "processing_node": "agent-orchestrator-03", "retry_count": 0}'::jsonb
),
-- Agent 4: Field Population for Order 001
(
    'uuid-agent-exec-001-04',
    '550e8400-e29b-41d4-a716-446655440101',
    'agent_procurement_04',
    'Field Population Agent',
    'field_population',
    'completed',
    '{"template_fields": {"equipment_type": "CNC machines and conveyor systems", "rental_period": null, "daily_rate": null, "special_requirements": "Production line integration"}, "extracted_requirements": {"technical": ["CNC specs", "Conveyor specs", "Quality control specs"], "quality": ["ISO compliance"], "safety": ["Machine guarding"], "commercial": ["Delivery schedule"]}, "compliance_requirements": ["OHS Act", "Import regulations"]}'::jsonb,
    '{"populated_fields": {"equipment_type": "Industrial CNC machining centers and automated conveyor systems", "rental_period": null, "daily_rate": null, "special_requirements": "Complete production line integration, operator training, maintenance support, and compliance with OHS Act and ISO 9001 standards", "delivery_location": "EPCM Engineering production facility", "technical_specs": "High-precision CNC machines with automated conveyor integration", "quality_requirements": "ISO 9001 certified equipment with full documentation", "safety_features": "Complete machine guarding and emergency stop systems", "payment_terms": "50% deposit, 50% on delivery", "warranty_period": "24 months", "support_services": "On-site installation, training, and maintenance"}, "population_metadata": {"auto_populated_fields": 8, "manual_review_fields": ["payment_terms", "warranty_period"], "field_confidence_scores": {"equipment_type": 0.95, "special_requirements": 0.88, "technical_specs": 0.92}, "validation_status": "passed"}}'::jsonb,
    0.89,
    3800,
    '2026-01-01T10:11:00Z',
    true,
    93,
    '["chatbot", "dashboard"]'::jsonb,
    '{"agent_version": "1.0", "processing_node": "agent-orchestrator-04", "retry_count": 0}'::jsonb
),
-- Agent 5: Quality Assurance for Order 001
(
    'uuid-agent-exec-001-05',
    '550e8400-e29b-41d4-a716-446655440101',
    'agent_procurement_05',
    'Quality Assurance Agent',
    'quality_assurance',
    'completed',
    '{"populated_template": {"equipment_type": "Industrial CNC machining centers and automated conveyor systems", "special_requirements": "Complete production line integration, operator training, maintenance support", "payment_terms": "50% deposit, 50% on delivery"}, "previous_agent_outputs": ["Template analysis: 95% compatibility", "Requirements extraction: 12 requirements identified", "Compliance validation: 94% compliance score"]}'::jsonb,
    '{"quality_assessment": {"overall_quality_score": 91, "issues_and_corrections": {"major_issues": [], "minor_issues": ["Payment terms could be more specific", "Add reference to local content requirements"], "corrections_applied": ["Enhanced payment terms with milestone payments", "Added BBBEE compliance reference"]}, "optimization_metrics": {"error_reduction_percentage": 95, "completeness_score": 98, "consistency_score": 96, "compliance_score": 94}, "validation_results": {"field_validation": "passed", "business_rule_validation": "passed", "compliance_validation": "passed", "data_integrity_check": "passed"}}, "quality_metadata": {"overall_quality_score": 91, "issues_identified": 2, "corrections_applied": 2, "validation_checks_passed": 4}}'::jsonb,
    0.94,
    2900,
    '2026-01-01T10:13:00Z',
    true,
    91,
    '["chatbot", "dashboard"]'::jsonb,
    '{"agent_version": "1.0", "processing_node": "agent-orchestrator-05", "retry_count": 0}'::jsonb
),
-- Agent 6: Final Review for Order 001
(
    'uuid-agent-exec-001-06',
    '550e8400-e29b-41d4-a716-446655440101',
    'agent_procurement_06',
    'Final Review Agent',
    'final_review',
    'completed',
    '{"quality_assessment": {"overall_quality_score": 91, "issues_and_corrections": {"major_issues": [], "minor_issues": ["Payment terms specificity", "Local content reference"]}}, "populated_document": "Complete procurement document with all appendices", "agent_workflow_summary": {"agents_executed": 5, "average_confidence": 0.91, "quality_gates_passed": 5, "processing_time_total": 16500}}'::jsonb,
    '{"final_review": {"executive_summary": {"document_readiness": "approved", "confidence_level": "high", "risk_assessment": "low", "recommendations": ["Document ready for procurement officer review", "All quality gates passed successfully", "Compliance requirements fully addressed"]}, "approval_recommendation": {"recommendation": "approve", "confidence_score": 0.96, "justification": "All agents completed successfully with high quality scores. Document meets all procurement and compliance requirements.", "next_steps": ["Forward to procurement officer for final approval", "Initiate vendor engagement process", "Prepare contract negotiation documents"]}, "final_metadata": {"overall_confidence": 0.93, "quality_score": 92, "compliance_score": 95, "completeness_score": 98}}}'::jsonb,
    0.96,
    2100,
    '2026-01-01T10:15:00Z',
    true,
    96,
    '["chatbot", "dashboard", "email"]'::jsonb,
    '{"agent_version": "1.0", "processing_node": "agent-orchestrator-06", "retry_count": 0, "final_approval": "granted"}'::jsonb
),
-- Agent 1: Template Analysis for Order 002
(
    'uuid-agent-exec-002-01',
    '550e8400-e29b-41d4-a716-446655440102',
    'agent_procurement_01',
    'Template Analysis Agent',
    'template_analysis',
    'completed',
    '{"template_id": "550e8400-e29b-41d4-a716-446655440202", "order_requirements": "HVAC systems and electrical infrastructure maintenance", "compliance_context": "South African maintenance service regulations"}'::jsonb,
    '{"compatibility_score": 89, "template_suitability": "good", "identified_requirements": ["HVAC system specifications and maintenance scope", "Electrical infrastructure maintenance requirements", "Safety compliance for maintenance activities", "Service level agreements and response times"], "risk_assessment": "low", "recommendations": ["Template suitable for service agreement", "Additional focus on service level requirements needed", "Safety protocols well covered"]}'::jsonb,
    0.87,
    2800,
    '2026-01-02T14:40:00Z',
    true,
    89,
    '["chatbot", "dashboard"]'::jsonb,
    '{"agent_version": "1.0", "processing_node": "agent-orchestrator-01", "retry_count": 0}'::jsonb
);

-- Add indexes for performance
CREATE INDEX IF NOT EXISTS idx_agent_workflow_executions_order ON agent_workflow_executions(procurement_order_id);
CREATE INDEX IF NOT EXISTS idx_agent_workflow_executions_agent ON agent_workflow_executions(agent_id);
CREATE INDEX IF NOT EXISTS idx_agent_workflow_executions_stage ON agent_workflow_executions(stage);
CREATE INDEX IF NOT EXISTS idx_agent_workflow_executions_status ON agent_workflow_executions(status);
CREATE INDEX IF NOT EXISTS idx_agent_workflow_executions_executed_at ON agent_workflow_executions(executed_at);
