---
memory_layer: durable_knowledge
para_section: atlas-builder-procurement-agents
gigabrain_tags: atlas, agent-creation, builder-procurement, procurement-agents, skill-mapping, agent-capabilities
openstinger_context: agent-creation-atlas, procurement-agent-skills, builder-workflow-agents
last_updated: 2026-04-22
related_docs:
  - docs-paperclip/companies/measureforge-ai/knowledge/2026-04-22-measureforge-ai-platform-knowledge-atlas.md
  - docs-paperclip/companies/measureforge-ai/business/2026-04-22-builder-direct-procurement-integration.md
---

# Atlas: Builder Procurement Agents - Agent Creation Guide

## Overview

This Atlas entry provides comprehensive guidance for creating and configuring agents that support builder direct procurement workflows in the MeasureForge AI platform. These agents enable construction builders to extract material quantities directly from CAD drawings and interface with procurement systems like Candy, bypassing traditional Quantity Surveying processes.

## Agent Architecture for Builder Procurement

### Primary Agent Types

#### 1. Builder Measurement Agent
**Purpose**: Simplified quantity extraction for non-QS professionals

**Agent Configuration:**
```yaml
agent_type: builder_measurement_specialist
name: "Builder Measurement Assistant"
description: "Streamlined CAD measurement extraction for construction builders"

model_assignment:
  primary_model: "anthropic/claude-sonnet-3.5"
  fallback_model: "openai/gpt-4-turbo"
  temperature: 0.2
  max_tokens: 4096

skills:
  - cad_file_processing
  - material_recognition
  - quantity_estimation
  - budget_validation
  - measurement_simplification

capabilities:
  - cad_drawing_ingestion
  - automated_quantity_takeoff
  - material_classification
  - cost_estimation_integration
  - budget_variance_alerts
  - simplified_reporting

integration_points:
  - measureforge_cad_api
  - procurement_budget_system
  - material_database
  - builder_dashboard
```

**Skill Definitions:**
- **cad_file_processing**: Handle DWG, DXF, and other CAD formats with builder-friendly error handling
- **material_recognition**: AI-powered identification of construction materials from CAD entities
- **quantity_estimation**: Simplified measurement calculations with ±5-10% accuracy tolerance
- **budget_validation**: Real-time comparison against project budgets with variance alerts
- **measurement_simplification**: Convert complex QS measurements to builder-understandable formats

#### 2. Cost Estimation Agent
**Purpose**: Budget analysis and procurement cost optimization

**Agent Configuration:**
```yaml
agent_type: procurement_cost_estimator
name: "Procurement Cost Optimizer"
description: "Cost estimation and budget analysis for builder procurement"

model_assignment:
  primary_model: "anthropic/claude-haiku-3.5"
  fallback_model: "openai/gpt-4-turbo"
  temperature: 0.1
  max_tokens: 2048

skills:
  - cost_rate_application
  - budget_analysis
  - variance_calculation
  - supplier_pricing
  - procurement_optimization

capabilities:
  - rate_schedule_integration
  - budget_variance_analysis
  - supplier_price_comparison
  - procurement_recommendations
  - cost_trend_analysis

integration_points:
  - supplier_price_databases
  - procurement_budget_system
  - historical_cost_data
  - builder_portal
```

**Skill Definitions:**
- **cost_rate_application**: Apply builder-specific rate schedules to extracted quantities
- **budget_analysis**: Compare estimated costs against project budgets
- **variance_calculation**: Calculate and report budget variances with recommendations
- **supplier_pricing**: Access and compare current supplier pricing data
- **procurement_optimization**: Suggest optimal procurement timing and quantities

#### 3. Candy Integration Agent
**Purpose**: Direct interface with Candy procurement management system

**Agent Configuration:**
```yaml
agent_type: candy_procurement_interface
name: "Candy Procurement Connector"
description: "Direct integration with Candy procurement management system"

model_assignment:
  primary_model: "anthropic/claude-haiku-3.5"
  fallback_model: "anthropic/claude-sonnet-3.5"
  temperature: 0.05
  max_tokens: 1024

skills:
  - api_integration
  - data_transformation
  - order_processing
  - status_monitoring
  - error_handling

capabilities:
  - candy_api_connection
  - material_data_mapping
  - purchase_order_creation
  - order_status_tracking
  - delivery_scheduling

integration_points:
  - candy_rest_api
  - procurement_workflow_engine
  - supplier_management_system
  - delivery_tracking_system
```

**Skill Definitions:**
- **api_integration**: Establish and maintain secure connections to Candy API
- **data_transformation**: Convert MeasureForge data formats to Candy specifications
- **order_processing**: Create and submit purchase orders with proper validation
- **status_monitoring**: Track order status and provide real-time updates
- **error_handling**: Manage API errors and provide user-friendly error messages

#### 4. Supplier Management Agent
**Purpose**: Supplier selection, performance tracking, and relationship management

**Agent Configuration:**
```yaml
agent_type: supplier_performance_manager
name: "Supplier Performance Analyst"
description: "Supplier evaluation, selection, and performance monitoring"

model_assignment:
  primary_model: "anthropic/claude-sonnet-3.5"
  fallback_model: "openai/gpt-4-turbo"
  temperature: 0.3
  max_tokens: 3072

skills:
  - supplier_evaluation
  - performance_analysis
  - risk_assessment
  - relationship_management
  - alternative_sourcing

capabilities:
  - supplier_score_calculation
  - delivery_performance_tracking
  - quality_incident_analysis
  - risk_assessment_reporting
  - alternative_supplier_identification

integration_points:
  - supplier_database
  - performance_tracking_system
  - quality_management_system
  - procurement_analytics
```

**Skill Definitions:**
- **supplier_evaluation**: Assess supplier capabilities, reliability, and pricing
- **performance_analysis**: Analyze delivery times, quality metrics, and cost trends
- **risk_assessment**: Evaluate supplier risks and recommend mitigation strategies
- **relationship_management**: Track supplier interactions and relationship health
- **alternative_sourcing**: Identify backup suppliers and alternative sourcing options

#### 5. Quality Assurance Agent
**Purpose**: Validate builder measurements and ensure procurement quality

**Agent Configuration:**
```yaml
agent_type: builder_quality_validator
name: "Builder Quality Assurance"
description: "Validation and quality control for builder procurement processes"

model_assignment:
  primary_model: "anthropic/claude-opus-4.6"
  fallback_model: "anthropic/claude-sonnet-3.5"
  temperature: 0.1
  max_tokens: 2048

skills:
  - measurement_validation
  - quality_assessment
  - compliance_checking
  - risk_evaluation
  - approval_workflow

capabilities:
  - measurement_accuracy_verification
  - quality_standard_enforcement
  - procurement_risk_assessment
  - approval_recommendations
  - audit_trail_generation

integration_points:
  - quality_management_system
  - procurement_approval_workflow
  - audit_trail_database
  - compliance_monitoring
```

**Skill Definitions:**
- **measurement_validation**: Verify builder measurements against quality standards
- **quality_assessment**: Evaluate material quality and supplier capabilities
- **compliance_checking**: Ensure adherence to procurement and quality policies
- **risk_evaluation**: Assess procurement risks and recommend controls
- **approval_workflow**: Guide procurement approvals through appropriate channels

## Agent Creation Templates

### Builder Measurement Agent Template
```yaml
# Template for creating Builder Measurement Agent
template_name: builder_measurement_agent_v1
base_agent: measurement_specialist

customizations:
  ui_simplification: true
  accuracy_tolerance: 0.10  # ±10% tolerance for builder use
  cad_formats: ['dwg', 'dxf', 'pdf']  # Include PDF for builder convenience
  reporting_format: simplified
  integration_mode: procurement_direct

required_skills:
  - cad_file_processing
  - material_recognition
  - quantity_estimation
  - budget_validation

optional_enhancements:
  - supplier_pricing_integration
  - historical_cost_comparison
  - procurement_recommendations
```

### Procurement Integration Agent Template
```yaml
# Template for creating Procurement Integration Agent
template_name: procurement_integration_agent_v1
base_agent: api_integration_specialist

customizations:
  target_system: candy
  authentication_method: oauth2
  data_mapping_mode: automatic
  error_handling: user_friendly
  retry_logic: exponential_backoff

required_skills:
  - api_integration
  - data_transformation
  - order_processing
  - status_monitoring

system_specific_config:
  candy_api_version: v2.1
  supported_endpoints: ['orders', 'suppliers', 'materials', 'deliveries']
  rate_limiting: 100_requests_per_minute
```

## Skill Mapping and Dependencies

### Core Skill Dependencies
```
Builder Measurement Agent
├── cad_file_processing (core)
├── material_recognition (core)
├── quantity_estimation (core)
└── budget_validation (core)

Cost Estimation Agent
├── cost_rate_application (core)
├── budget_analysis (core)
├── variance_calculation (core)
└── supplier_pricing (optional)

Candy Integration Agent
├── api_integration (core)
├── data_transformation (core)
├── order_processing (core)
└── status_monitoring (core)

Supplier Management Agent
├── supplier_evaluation (core)
├── performance_analysis (core)
├── risk_assessment (core)
└── relationship_management (optional)

Quality Assurance Agent
├── measurement_validation (core)
├── quality_assessment (core)
├── compliance_checking (core)
└── risk_evaluation (core)
```

### Skill Level Requirements
- **Beginner Level**: Basic functionality, simple workflows
- **Intermediate Level**: Enhanced features, multi-system integration
- **Advanced Level**: Predictive analytics, optimization algorithms

## Integration Patterns

### Agent Communication Protocols
```yaml
# Builder Procurement Agent Swarm Communication
communication_protocol:
  primary_channel: measureforge_internal_bus
  message_format: json_schema_v2
  encryption: aes256
  authentication: jwt_tokens

agent_interactions:
  builder_measurement → cost_estimation:
    trigger: measurement_complete
    data: quantities_and_materials
    response: cost_analysis_and_budget_check

  cost_estimation → candy_integration:
    trigger: budget_approved
    data: approved_quantities_and_costs
    response: order_creation_status

  candy_integration → supplier_management:
    trigger: order_submitted
    data: order_details_and_supplier_info
    response: supplier_performance_assessment

  supplier_management → quality_assurance:
    trigger: delivery_scheduled
    data: supplier_and_delivery_details
    response: quality_requirements_and_checks
```

### Workflow Orchestration
```yaml
# Builder Procurement Workflow Definition
workflow_name: builder_direct_procurement
version: 1.0
description: "End-to-end builder procurement from CAD to delivery"

stages:
  1. measurement:
     agent: builder_measurement_agent
     inputs: [cad_files, project_budget]
     outputs: [quantities, preliminary_costs]
     timeout: 300_seconds
     retry_policy: 3_attempts

  2. cost_analysis:
     agent: cost_estimation_agent
     inputs: [quantities, budget_constraints]
     outputs: [detailed_costs, budget_variance]
     timeout: 180_seconds
     approval_required: budget_exceeds_10_percent

  3. procurement:
     agent: candy_integration_agent
     inputs: [approved_costs, supplier_preferences]
     outputs: [purchase_orders, tracking_numbers]
     timeout: 120_seconds
     error_handling: manual_intervention

  4. supplier_engagement:
     agent: supplier_management_agent
     inputs: [purchase_orders, supplier_history]
     outputs: [supplier_assignments, delivery_schedules]
     timeout: 240_seconds
     parallel_processing: true

  5. quality_control:
     agent: quality_assurance_agent
     inputs: [supplier_assignments, quality_requirements]
     outputs: [quality_checklists, approval_status]
     timeout: 180_seconds
     final_approval: required
```

## Agent Testing and Validation

### Unit Testing Requirements
```yaml
# Agent Testing Specifications
testing_framework: jest_with_agent_mocks
coverage_requirement: 85_percent

test_categories:
  skill_functionality:
    - cad_file_processing_accuracy
    - material_recognition_precision
    - cost_calculation_correctness
    - api_integration_reliability

  integration_testing:
    - agent_to_agent_communication
    - external_system_integration
    - error_handling_and_recovery
    - performance_under_load

  user_acceptance:
    - builder_workflow_efficiency
    - procurement_process_accuracy
    - system_reliability_and_availability
    - user_satisfaction_metrics
```

### Performance Benchmarks
- **Response Time**: <5 seconds for measurement extraction
- **Accuracy**: >90% for material recognition and quantity estimation
- **Integration Reliability**: >99.5% API success rate
- **User Satisfaction**: >4.0/5 builder satisfaction score

## Deployment and Scaling

### Environment Configuration
```yaml
# Production Environment Setup
environment: production
scaling_mode: horizontal_pod_autoscaling
min_replicas: 3
max_replicas: 10
cpu_threshold: 70_percent
memory_threshold: 80_percent

monitoring:
  metrics: [response_time, error_rate, throughput]
  alerts: [high_error_rate, performance_degradation]
  logging: structured_json_with_correlation_ids
```

### Agent Lifecycle Management
```yaml
# Agent Deployment and Maintenance
deployment_strategy: rolling_update
health_checks:
  readiness: /health/ready
  liveness: /health/live
  startup: /health/startup

maintenance_windows:
  patching: weekly_tuesdays_0200_0400_utc
  scaling_events: automatic_based_on_load
  backup_windows: daily_0100_0200_utc

rollback_procedures:
  automatic_rollback: on_error_rate_above_5_percent
  manual_rollback: on_severe_performance_issues
  data_recovery: point_in_time_restore_available
```

## Agent Evolution and Improvement

### Continuous Learning Integration
```yaml
# Agent Improvement Framework
learning_mechanisms:
  supervised_learning:
    - user_feedback_incorporation
    - accuracy_improvement_training
    - error_pattern_analysis

  unsupervised_learning:
    - usage_pattern_recognition
    - performance_optimization
    - workflow_efficiency_analysis

  reinforcement_learning:
    - procurement_outcome_optimization
    - supplier_selection_improvement
    - cost_reduction_algorithms

improvement_cycles:
  weekly: performance_metric_analysis
  monthly: user_feedback_review
  quarterly: major_feature_updates
  annually: architecture_reviews
```

### Version Management
```yaml
# Agent Version Control
versioning_strategy: semantic_versioning
compatibility_matrix:
  v1.x: backward_compatible
  v2.x: breaking_changes_allowed
  v3.x: major_architecture_updates

deprecation_policy:
  warning_period: 6_months
  support_period: 12_months
  end_of_life: 18_months_post_deprecation
```

---

**Atlas Entry**: Builder Procurement Agents
**Purpose**: Agent creation and configuration guidance for builder direct procurement workflows
**Skill Focus**: CAD processing, cost estimation, procurement integration, supplier management, quality assurance
**Integration**: MeasureForge AI platform with Candy procurement system
**Target Users**: Agent developers and platform administrators
**Update Frequency**: Quarterly with new agent capabilities and improvements