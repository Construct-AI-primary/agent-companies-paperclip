#!/usr/bin/env node

/**
 * MeasureForge AI Agents Population Script
 * Populates all 23 MeasureForge AI measurement platform agents into Supabase
 * Uses Chinese models (Qwen Max, ERNIE 4.0 Turbo, Hunyuan Turbo, Spark Max)
 */

import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

// Configuration
const CONFIG = {
  supabaseUrl: process.env.SUPABASE_URL,
  supabaseKey: process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY,
  organizationId: '90cd635a-380f-4586-a3b7-a09103b6df94', // EPCM Engineering org
  delayMs: 500,
  dryRun: process.argv.includes('--dry-run'),
  verbose: process.argv.includes('--verbose')
};

// MeasureForge AI Company ID (needs to be created first)
const MEASUREFORGE_COMPANY_ID = '550e8400-e29b-41d4-a716-446655440013'; // Placeholder - update with actual ID

// Agent data for all 23 MeasureForge AI agents
const AGENTS_DATA = [
  // Core Measurement Agents (6)
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-measurement-validation',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'measurement-validation-specialist',
    role: 'specialist',
    title: 'Measurement Validation Specialist',
    status: 'idle',
    capabilities: 'Measurement validation specialist ensuring accuracy, compliance, and quality of measurements across civil, electrical, mechanical, and structural engineering disciplines. Expert in automated validation, tolerance checking, standards compliance, and error detection.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'qwen-max',
      temperature: 0.1,
      max_tokens: 6144,
      skills: ['measurement-validation', 'standards-compliance', 'quality-assurance'],
      endpoints: { primary: 'hermes_local', fallback: 'ernie-4.0-turbo' }
    },
    runtime_config: {
      max_concurrent_tasks: 5,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 10, burst_limit: 20 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['measurement-validation', 'standards-compliance', 'quality-assurance', 'cad-validation'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai', 'knowledgeforge-ai'], max_parallel_workflows: 3 },
      access: { read_company_data: true, write_company_data: false, admin_functions: false }
    },
    budget_monthly_cents: 60000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['measurement-validation', 'standards-compliance', 'quality-assurance'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-measurement-standards',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'measurement-standards-specialist',
    role: 'specialist',
    title: 'Measurement Standards Specialist',
    status: 'idle',
    capabilities: 'Regulatory compliance and standards interpretation specialist. Expert in multi-jurisdictional compliance, standards interpretation, audit preparation, and regulatory updates.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'qwen-max',
      temperature: 0.1,
      max_tokens: 6144,
      skills: ['standards-management', 'compliance-validation', 'regulatory-knowledge'],
      endpoints: { primary: 'hermes_local', fallback: 'hunyuan-turbo' }
    },
    runtime_config: {
      max_concurrent_tasks: 5,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 10, burst_limit: 20 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['standards-management', 'compliance-validation', 'regulatory-updates'] },
      orchestrate: { company_projects: ['measureforge-ai', 'knowledgeforge-ai'], max_parallel_workflows: 2 },
      access: { read_company_data: true, write_company_data: false, admin_functions: false }
    },
    budget_monthly_cents: 55000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['standards-management', 'compliance-validation', 'regulatory-knowledge'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-measurement-coordination',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'measurement-coordination-specialist',
    role: 'specialist',
    title: 'Measurement Coordination Specialist',
    status: 'idle',
    capabilities: 'Workflow orchestration and stakeholder coordination specialist. Expert in interdisciplinary communication, technical translation, conflict mediation, and integration planning.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'ernie-4.0-turbo',
      temperature: 0.2,
      max_tokens: 6144,
      skills: ['project-coordination', 'workflow-management', 'stakeholder-engagement'],
      endpoints: { primary: 'hermes_local', fallback: 'spark-max' }
    },
    runtime_config: {
      max_concurrent_tasks: 8,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 15, burst_limit: 30 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['project-coordination', 'workflow-management', 'stakeholder-coordination'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai', 'knowledgeforge-ai'], max_parallel_workflows: 5 },
      access: { read_company_data: true, write_company_data: true, admin_functions: false }
    },
    budget_monthly_cents: 65000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['project-coordination', 'workflow-management', 'stakeholder-engagement'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-advanced-engineering',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'advanced-engineering-analysis',
    role: 'specialist',
    title: 'Advanced Engineering Analysis Specialist',
    status: 'idle',
    capabilities: 'Advanced engineering analysis specialist with expertise in structural analysis, FEA simulation, thermal analysis, and fluid dynamics.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'qwen-max',
      temperature: 0.1,
      max_tokens: 8192,
      skills: ['engineering-analysis', 'simulation-modeling', 'technical-computation'],
      endpoints: { primary: 'hermes_local', fallback: 'hunyuan-turbo' }
    },
    runtime_config: {
      max_concurrent_tasks: 3,
      timeout_seconds: 3600,
      retry_attempts: 2,
      rate_limiting: { requests_per_minute: 5, burst_limit: 10 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['engineering-analysis', 'simulation-modeling', 'fea-analysis'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai'], max_parallel_workflows: 2 },
      access: { read_company_data: true, write_company_data: false, admin_functions: false }
    },
    budget_monthly_cents: 75000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['engineering-analysis', 'simulation-modeling', 'technical-computation'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-cross-discipline',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'cross-discipline-coordination',
    role: 'specialist',
    title: 'Cross-Discipline Coordination Specialist',
    status: 'idle',
    capabilities: 'Cross-discipline coordination specialist facilitating interdisciplinary communication, technical translation, conflict mediation, and integration planning.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'ernie-4.0-turbo',
      temperature: 0.2,
      max_tokens: 6144,
      skills: ['interdisciplinary-coordination', 'technical-translation', 'conflict-resolution'],
      endpoints: { primary: 'hermes_local', fallback: 'qwen-max' }
    },
    runtime_config: {
      max_concurrent_tasks: 6,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 12, burst_limit: 25 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['interdisciplinary-coordination', 'technical-translation', 'conflict-mediation'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai', 'knowledgeforge-ai'], max_parallel_workflows: 4 },
      access: { read_company_data: true, write_company_data: true, admin_functions: false }
    },
    budget_monthly_cents: 60000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['interdisciplinary-coordination', 'technical-translation', 'conflict-resolution'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-engineering-ui',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'engineering-ui-specialist',
    role: 'specialist',
    title: 'Engineering UI Specialist',
    status: 'idle',
    capabilities: 'Engineering user interface specialist focused on interface design, user experience, accessibility compliance, and responsive layout for technical applications.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'spark-max',
      temperature: 0.3,
      max_tokens: 6144,
      skills: ['ui-ux-design', 'accessibility', 'user-experience'],
      endpoints: { primary: 'hermes_local', fallback: 'hunyuan-turbo' }
    },
    runtime_config: {
      max_concurrent_tasks: 4,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 8, burst_limit: 15 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['ui-ux-design', 'accessibility', 'user-experience'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai'], max_parallel_workflows: 3 },
      access: { read_company_data: true, write_company_data: false, admin_functions: false }
    },
    budget_monthly_cents: 55000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['ui-ux-design', 'accessibility', 'user-experience'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },

  // Document & Data Processing Agents (4)
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-document-intelligence',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'document-intelligence-specialist',
    role: 'specialist',
    title: 'Document Intelligence Specialist',
    status: 'idle',
    capabilities: 'Document intelligence specialist for analysis, specification extraction, cross-document correlation, knowledge synthesis, and compliance matrix generation.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'qwen-max',
      temperature: 0.1,
      max_tokens: 8192,
      skills: ['document-processing', 'information-extraction', 'knowledge-synthesis'],
      endpoints: { primary: 'hermes_local', fallback: 'hunyuan-turbo' }
    },
    runtime_config: {
      max_concurrent_tasks: 4,
      timeout_seconds: 2400,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 8, burst_limit: 15 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['document-processing', 'information-extraction', 'knowledge-synthesis'] },
      orchestrate: { company_projects: ['measureforge-ai', 'knowledgeforge-ai'], max_parallel_workflows: 3 },
      access: { read_company_data: true, write_company_data: false, admin_functions: false }
    },
    budget_monthly_cents: 60000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['document-processing', 'information-extraction', 'knowledge-synthesis'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-data-processing',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'data-processing-specialist',
    role: 'specialist',
    title: 'Data Processing Specialist',
    status: 'idle',
    capabilities: 'Data processing specialist for document ecosystem processing, multi-format file handling, data normalization, information extraction, and knowledge graph construction.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'qwen-max',
      temperature: 0.1,
      max_tokens: 6144,
      skills: ['data-processing', 'file-format-handling', 'data-normalization'],
      endpoints: { primary: 'hermes_local', fallback: 'hunyuan-turbo' }
    },
    runtime_config: {
      max_concurrent_tasks: 6,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 12, burst_limit: 25 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['data-processing', 'file-format-handling', 'data-normalization'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai'], max_parallel_workflows: 4 },
      access: { read_company_data: true, write_company_data: true, admin_functions: false }
    },
    budget_monthly_cents: 55000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['data-processing', 'file-format-handling', 'data-normalization'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-integration-orchestration',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'integration-orchestration-specialist',
    role: 'specialist',
    title: 'Integration Orchestration Specialist',
    status: 'idle',
    capabilities: 'Integration orchestration specialist for cross-system integration, API orchestration, workflow coordination, dependency management, and error handling.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'ernie-4.0-turbo',
      temperature: 0.2,
      max_tokens: 6144,
      skills: ['system-integration', 'api-orchestration', 'workflow-coordination'],
      endpoints: { primary: 'hermes_local', fallback: 'spark-max' }
    },
    runtime_config: {
      max_concurrent_tasks: 8,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 15, burst_limit: 30 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['system-integration', 'api-orchestration', 'workflow-coordination'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai', 'infraforge-ai'], max_parallel_workflows: 6 },
      access: { read_company_data: true, write_company_data: true, admin_functions: false }
    },
    budget_monthly_cents: 65000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['system-integration', 'api-orchestration', 'workflow-coordination'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-communication-coordination',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'communication-coordination-specialist',
    role: 'specialist',
    title: 'Communication Coordination Specialist',
    status: 'idle',
    capabilities: 'Communication coordination specialist for stakeholder communication, progress reporting, issue escalation, collaboration facilitation, and feedback collection.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'ernie-4.0-turbo',
      temperature: 0.3,
      max_tokens: 6144,
      skills: ['stakeholder-communication', 'progress-reporting', 'collaboration-management'],
      endpoints: { primary: 'hermes_local', fallback: 'spark-max' }
    },
    runtime_config: {
      max_concurrent_tasks: 10,
      timeout_seconds: 1200,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 20, burst_limit: 40 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['stakeholder-communication', 'progress-reporting', 'collaboration-management'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai', 'knowledgeforge-ai'], max_parallel_workflows: 8 },
      access: { read_company_data: true, write_company_data: true, admin_functions: false }
    },
    budget_monthly_cents: 55000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['stakeholder-communication', 'progress-reporting', 'collaboration-management'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },

  // Visual & Spatial Intelligence Agents (3)
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-visual-overlay',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'visual-overlay-specialist',
    role: 'specialist',
    title: 'Visual Overlay Specialist',
    status: 'idle',
    capabilities: 'Visual overlay specialist for element tagging, overlay management, visual filtering, measurement visualization, and user interface overlay.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'ernie-4.0-turbo',
      temperature: 0.2,
      max_tokens: 6144,
      skills: ['visual-processing', 'overlay-management', 'measurement-visualization'],
      endpoints: { primary: 'hermes_local', fallback: 'spark-max' }
    },
    runtime_config: {
      max_concurrent_tasks: 5,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 10, burst_limit: 20 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['visual-processing', 'overlay-management', 'measurement-visualization'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai'], max_parallel_workflows: 4 },
      access: { read_company_data: true, write_company_data: false, admin_functions: false }
    },
    budget_monthly_cents: 60000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['visual-processing', 'overlay-management', 'measurement-visualization'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-spatial-analysis',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'spatial-analysis-specialist',
    role: 'specialist',
    title: 'Spatial Analysis Specialist',
    status: 'idle',
    capabilities: 'Spatial analysis specialist for 3D duplicate detection, spatial conflict resolution, geometric validation, coordinate system management, and tolerance analysis.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'qwen-max',
      temperature: 0.1,
      max_tokens: 8192,
      skills: ['spatial-analysis', 'geometric-validation', 'coordinate-management'],
      endpoints: { primary: 'hermes_local', fallback: 'hunyuan-turbo' }
    },
    runtime_config: {
      max_concurrent_tasks: 4,
      timeout_seconds: 2400,
      retry_attempts: 2,
      rate_limiting: { requests_per_minute: 8, burst_limit: 15 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['spatial-analysis', 'geometric-validation', 'coordinate-management'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai'], max_parallel_workflows: 3 },
      access: { read_company_data: true, write_company_data: false, admin_functions: false }
    },
    budget_monthly_cents: 65000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['spatial-analysis', 'geometric-validation', 'coordinate-management'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-performance-monitoring',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'performance-monitoring-specialist',
    role: 'specialist',
    title: 'Performance Monitoring Specialist',
    status: 'idle',
    capabilities: 'Performance monitoring specialist for system performance tracking, resource utilization monitoring, bottleneck identification, optimization recommendations, and capacity planning.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'spark-max',
      temperature: 0.2,
      max_tokens: 6144,
      skills: ['performance-monitoring', 'system-optimization', 'capacity-planning'],
      endpoints: { primary: 'hermes_local', fallback: 'ernie-4.0-turbo' }
    },
    runtime_config: {
      max_concurrent_tasks: 6,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 12, burst_limit: 25 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['performance-monitoring', 'system-optimization', 'capacity-planning'] },
      orchestrate: { company_projects: ['measureforge-ai', 'infraforge-ai'], max_parallel_workflows: 4 },
      access: { read_company_data: true, write_company_data: false, admin_functions: false }
    },
    budget_monthly_cents: 60000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['performance-monitoring', 'system-optimization', 'capacity-planning'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },

  // Procurement & Compliance Agents (4)
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-procurement-integration',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'procurement-integration-specialist',
    role: 'specialist',
    title: 'Procurement Integration Specialist',
    status: 'idle',
    capabilities: 'Procurement integration specialist for CANDY system integration, procurement workflow automation, material cost analysis, supplier management, and contract tender preparation.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'ernie-4.0-turbo',
      temperature: 0.2,
      max_tokens: 6144,
      skills: ['procurement-integration', 'supplier-management', 'contract-preparation'],
      endpoints: { primary: 'hermes_local', fallback: 'spark-max' }
    },
    runtime_config: {
      max_concurrent_tasks: 5,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 10, burst_limit: 20 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['procurement-integration', 'supplier-management', 'contract-preparation'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai'], max_parallel_workflows: 4 },
      access: { read_company_data: true, write_company_data: true, admin_functions: false }
    },
    budget_monthly_cents: 55000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['procurement-integration', 'supplier-management', 'contract-preparation'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-standards-compliance',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'standards-compliance-specialist',
    role: 'specialist',
    title: 'Standards Compliance Specialist',
    status: 'idle',
    capabilities: 'Standards compliance specialist for multi-jurisdictional compliance, standards interpretation, regulatory updates, compliance reporting, and audit preparation.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'qwen-max',
      temperature: 0.1,
      max_tokens: 6144,
      skills: ['standards-compliance', 'regulatory-compliance', 'audit-preparation'],
      endpoints: { primary: 'hermes_local', fallback: 'hunyuan-turbo' }
    },
    runtime_config: {
      max_concurrent_tasks: 4,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 8, burst_limit: 15 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['standards-compliance', 'regulatory-compliance', 'audit-preparation'] },
      orchestrate: { company_projects: ['measureforge-ai', 'knowledgeforge-ai'], max_parallel_workflows: 3 },
      access: { read_company_data: true, write_company_data: false, admin_functions: false }
    },
    budget_monthly_cents: 60000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['standards-compliance', 'regulatory-compliance', 'audit-preparation'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-security-compliance',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'security-compliance-specialist',
    role: 'specialist',
    title: 'Security Compliance Specialist',
    status: 'idle',
    capabilities: 'Security compliance specialist for data security enforcement, compliance monitoring, access control management, audit trail maintenance, and regulatory reporting.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'qwen-max',
      temperature: 0.1,
      max_tokens: 6144,
      skills: ['security-compliance', 'access-control', 'audit-trail-management'],
      endpoints: { primary: 'hermes_local', fallback: 'hunyuan-turbo' }
    },
    runtime_config: {
      max_concurrent_tasks: 4,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 8, burst_limit: 15 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['security-compliance', 'access-control', 'audit-trail-management'] },
      orchestrate: { company_projects: ['measureforge-ai', 'infraforge-ai'], max_parallel_workflows: 3 },
      access: { read_company_data: true, write_company_data: false, admin_functions: false }
    },
    budget_monthly_cents: 65000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['security-compliance', 'access-control', 'audit-trail-management'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-quality-assurance',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'quality-assurance-specialist',
    role: 'specialist',
    title: 'Quality Assurance Specialist',
    status: 'idle',
    capabilities: 'Quality assurance specialist for measurement accuracy validation, error pattern analysis, quality control automation, statistical process control, and continuous improvement.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'ernie-4.0-turbo',
      temperature: 0.1,
      max_tokens: 6144,
      skills: ['quality-assurance', 'error-analysis', 'statistical-process-control'],
      endpoints: { primary: 'hermes_local', fallback: 'spark-max' }
    },
    runtime_config: {
      max_concurrent_tasks: 6,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 12, burst_limit: 25 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['quality-assurance', 'error-analysis', 'statistical-process-control'] },
      orchestrate: { company_projects: ['measureforge-ai', 'qualityforge-ai'], max_parallel_workflows: 4 },
      access: { read_company_data: true, write_company_data: false, admin_functions: false }
    },
    budget_monthly_cents: 55000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['quality-assurance', 'error-analysis', 'statistical-process-control'],
      source: 'platform-expansion-2026',
      chinese_models: true
    }
  },

  // Specialized Measurement Domain Agents (6)
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-solar-measurement',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'solar-measurement-specialist',
    role: 'specialist',
    title: 'Solar Measurement Specialist',
    status: 'idle',
    capabilities: 'Solar measurement specialist for PV layout optimization, roof geometry analysis, shading obstruction mapping, electrical stringing design, tilt angle optimization, inter-row spacing calculation, and structural clearance verification.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'qwen-max',
      temperature: 0.1,
      max_tokens: 8192,
      skills: ['solar-measurement', 'pv-layout-optimization', 'shading-analysis'],
      endpoints: { primary: 'hermes_local', fallback: 'hunyuan-turbo' }
    },
    runtime_config: {
      max_concurrent_tasks: 4,
      timeout_seconds: 2400,
      retry_attempts: 2,
      rate_limiting: { requests_per_minute: 8, burst_limit: 15 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['solar-measurement', 'pv-layout-optimization', 'shading-analysis'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai'], max_parallel_workflows: 3 },
      access: { read_company_data: true, write_company_data: false, admin_functions: false }
    },
    budget_monthly_cents: 70000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['solar-measurement', 'pv-layout-optimization', 'shading-analysis'],
      source: 'platform-expansion-2026',
      chinese_models: true,
      domain: 'solar-energy'
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-traffic-signal',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'traffic-signal-specialist',
    role: 'specialist',
    title: 'Traffic Signal Specialist',
    status: 'idle',
    capabilities: 'Traffic signal specialist for NEMA TS standards compliance, FHWA signal design, electrical distribution layout, safety critical analysis, arc flash hazard mapping, grounding system design, and power quality monitoring.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'ernie-4.0-turbo',
      temperature: 0.1,
      max_tokens: 6144,
      skills: ['traffic-signal-measurement', 'electrical-distribution', 'safety-analysis'],
      endpoints: { primary: 'hermes_local', fallback: 'spark-max' }
    },
    runtime_config: {
      max_concurrent_tasks: 4,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 8, burst_limit: 15 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['traffic-signal-measurement', 'electrical-distribution', 'safety-analysis'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai'], max_parallel_workflows: 3 },
      access: { read_company_data: true, write_company_data: false, admin_functions: false }
    },
    budget_monthly_cents: 65000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['traffic-signal-measurement', 'electrical-distribution', 'safety-analysis'],
      source: 'platform-expansion-2026',
      chinese_models: true,
      domain: 'traffic-infrastructure'
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-sustainability-analysis',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'sustainability-analysis-specialist',
    role: 'specialist',
    title: 'Sustainability Analysis Specialist',
    status: 'idle',
    capabilities: 'Sustainability analysis specialist for environmental impact assessment, carbon footprint calculation, energy efficiency analysis, waste management optimization, sustainable material selection, regulatory compliance monitoring, and lifecycle cost analysis.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'qwen-max',
      temperature: 0.1,
      max_tokens: 8192,
      skills: ['sustainability-analysis', 'environmental-impact', 'lifecycle-costing'],
      endpoints: { primary: 'hermes_local', fallback: 'hunyuan-turbo' }
    },
    runtime_config: {
      max_concurrent_tasks: 4,
      timeout_seconds: 2400,
      retry_attempts: 2,
      rate_limiting: { requests_per_minute: 8, burst_limit: 15 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['sustainability-analysis', 'environmental-impact', 'lifecycle-costing'] },
      orchestrate: { company_projects: ['measureforge-ai', 'knowledgeforge-ai'], max_parallel_workflows: 3 },
      access: { read_company_data: true, write_company_data: false, admin_functions: false }
    },
    budget_monthly_cents: 60000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['sustainability-analysis', 'environmental-impact', 'lifecycle-costing'],
      source: 'platform-expansion-2026',
      chinese_models: true,
      domain: 'sustainability'
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-risk-assessment',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'risk-assessment-specialist',
    role: 'specialist',
    title: 'Risk Assessment Specialist',
    status: 'idle',
    capabilities: 'Risk assessment specialist for project risk evaluation, measurement uncertainty analysis, cost overrun prediction, schedule delay identification, quality defect prevention, compliance risk assessment, and mitigation strategy development.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'ernie-4.0-turbo',
      temperature: 0.1,
      max_tokens: 6144,
      skills: ['risk-assessment', 'uncertainty-analysis', 'mitigation-planning'],
      endpoints: { primary: 'hermes_local', fallback: 'spark-max' }
    },
    runtime_config: {
      max_concurrent_tasks: 4,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 8, burst_limit: 15 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['risk-assessment', 'uncertainty-analysis', 'mitigation-planning'] },
      orchestrate: { company_projects: ['measureforge-ai', 'knowledgeforge-ai'], max_parallel_workflows: 3 },
      access: { read_company_data: true, write_company_data: false, admin_functions: false }
    },
    budget_monthly_cents: 65000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['risk-assessment', 'uncertainty-analysis', 'mitigation-planning'],
      source: 'platform-expansion-2026',
      chinese_models: true,
      domain: 'risk-management'
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-training-documentation',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'training-documentation-specialist',
    role: 'specialist',
    title: 'Training Documentation Specialist',
    status: 'idle',
    capabilities: 'Training documentation specialist for user onboarding content creation, interactive tutorial design, knowledge base maintenance, documentation automation, training material generation, user feedback analysis, and continuous improvement.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'spark-max',
      temperature: 0.3,
      max_tokens: 6144,
      skills: ['training-development', 'documentation-automation', 'user-feedback-analysis'],
      endpoints: { primary: 'hermes_local', fallback: 'ernie-4.0-turbo' }
    },
    runtime_config: {
      max_concurrent_tasks: 6,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 12, burst_limit: 25 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['training-development', 'documentation-automation', 'user-feedback-analysis'] },
      orchestrate: { company_projects: ['measureforge-ai', 'knowledgeforge-ai'], max_parallel_workflows: 4 },
      access: { read_company_data: true, write_company_data: true, admin_functions: false }
    },
    budget_monthly_cents: 55000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['training-development', 'documentation-automation', 'user-feedback-analysis'],
      source: 'platform-expansion-2026',
      chinese_models: true,
      domain: 'training-education'
    }
  },

  // Builder-Specific Agents (4)
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-builder-procurement',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'builder-procurement-specialist',
    role: 'specialist',
    title: 'Builder Procurement Specialist',
    status: 'idle',
    capabilities: 'Builder procurement specialist for direct procurement workflow, builder material requirements, supplier network management, cost comparison automation, order tracking integration, delivery schedule coordination, and quality specification matching.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'ernie-4.0-turbo',
      temperature: 0.2,
      max_tokens: 6144,
      skills: ['builder-procurement', 'supplier-network-management', 'order-tracking'],
      endpoints: { primary: 'hermes_local', fallback: 'spark-max' }
    },
    runtime_config: {
      max_concurrent_tasks: 6,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 12, burst_limit: 25 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['builder-procurement', 'supplier-network-management', 'order-tracking'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai'], max_parallel_workflows: 4 },
      access: { read_company_data: true, write_company_data: true, admin_functions: false }
    },
    budget_monthly_cents: 55000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['builder-procurement', 'supplier-network-management', 'order-tracking'],
      source: 'platform-expansion-2026',
      chinese_models: true,
      domain: 'builder-procurement'
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-builder-cost-estimation',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'builder-cost-estimation-specialist',
    role: 'specialist',
    title: 'Builder Cost Estimation Specialist',
    status: 'idle',
    capabilities: 'Builder cost estimation specialist for material cost calculation, labor cost estimation, equipment cost analysis, overhead cost allocation, profit margin application, budget variance tracking, and cash flow projection.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'qwen-max',
      temperature: 0.1,
      max_tokens: 6144,
      skills: ['cost-estimation', 'budget-management', 'cash-flow-projection'],
      endpoints: { primary: 'hermes_local', fallback: 'hunyuan-turbo' }
    },
    runtime_config: {
      max_concurrent_tasks: 5,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 10, burst_limit: 20 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['cost-estimation', 'budget-management', 'cash-flow-projection'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai'], max_parallel_workflows: 3 },
      access: { read_company_data: true, write_company_data: true, admin_functions: false }
    },
    budget_monthly_cents: 60000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['cost-estimation', 'budget-management', 'cash-flow-projection'],
      source: 'platform-expansion-2026',
      chinese_models: true,
      domain: 'builder-costing'
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-builder-material-tracking',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'builder-material-tracking-specialist',
    role: 'specialist',
    title: 'Builder Material Tracking Specialist',
    status: 'idle',
    capabilities: 'Builder material tracking specialist for material inventory management, delivery tracking automation, quality inspection coordination, waste reduction optimization, supplier performance monitoring, material substitution analysis, and sustainability compliance tracking.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'spark-max',
      temperature: 0.2,
      max_tokens: 6144,
      skills: ['material-tracking', 'inventory-management', 'supplier-performance'],
      endpoints: { primary: 'hermes_local', fallback: 'ernie-4.0-turbo' }
    },
    runtime_config: {
      max_concurrent_tasks: 7,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 14, burst_limit: 28 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['material-tracking', 'inventory-management', 'supplier-performance'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai'], max_parallel_workflows: 5 },
      access: { read_company_data: true, write_company_data: true, admin_functions: false }
    },
    budget_monthly_cents: 55000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['material-tracking', 'inventory-management', 'supplier-performance'],
      source: 'platform-expansion-2026',
      chinese_models: true,
      domain: 'builder-materials'
    }
  },
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-builder-site-integration',
    company_id: MEASUREFORGE_COMPANY_ID,
    name: 'builder-site-integration-specialist',
    role: 'specialist',
    title: 'Builder Site Integration Specialist',
    status: 'idle',
    capabilities: 'Builder site integration specialist for construction site integration, progress monitoring automation, workforce productivity tracking, equipment utilization optimization, safety compliance monitoring, quality control field verification, and change order processing.',
    adapter_type: 'hermes_local',
    adapter_config: {
      model: 'ernie-4.0-turbo',
      temperature: 0.2,
      max_tokens: 6144,
      skills: ['site-integration', 'progress-monitoring', 'change-order-processing'],
      endpoints: { primary: 'hermes_local', fallback: 'spark-max' }
    },
    runtime_config: {
      max_concurrent_tasks: 8,
      timeout_seconds: 1800,
      retry_attempts: 3,
      rate_limiting: { requests_per_minute: 16, burst_limit: 32 },
      error_handling: { auto_retry: true, escalation_enabled: true }
    },
    permissions: {
      execute: { automation_engine: 'hermes_local', allowed_domains: ['site-integration', 'progress-monitoring', 'change-order-processing'] },
      orchestrate: { company_projects: ['measureforge-ai', 'integrateforge-ai'], max_parallel_workflows: 6 },
      access: { read_company_data: true, write_company_data: true, admin_functions: false }
    },
    budget_monthly_cents: 65000,
    created_at: '2026-04-22T11:00:00.000Z',
    updated_at: '2026-04-22T11:00:00.000Z',
    metadata: {
      team: 'MeasureForge AI',
      skills: ['site-integration', 'progress-monitoring', 'change-order-processing'],
      source: 'platform-expansion-2026',
      chinese_models: true,
      domain: 'builder-site-management'
    }
  }
];

// Validation
function validateConfig() {
  const required = ['supabaseUrl', 'supabaseKey', 'organizationId'];
  const missing = required.filter(key => !CONFIG[key]);

  if (missing.length > 0) {
    throw new Error(`Missing required configuration: ${missing.join(', ')}`);
  }
}

// Supabase client with proper configuration
function createSupabaseClient() {
  return createClient(CONFIG.supabaseUrl, CONFIG.supabaseKey, {
    auth: { persistSession: false },
    global: {
      headers: { 'x-organization-id': CONFIG.organizationId }
    }
  });
}

// Progress tracking
class ProgressTracker {
  constructor(total) {
    this.total = total;
    this.completed = 0;
    this.errors = 0;
    this.startTime = Date.now();
  }

  increment(success = true) {
    this.completed++;
    if (!success) this.errors++;

    if (CONFIG.verbose || this.completed % 3 === 0) {
      const percent = Math.round((this.completed / this.total) * 100);
      const elapsed = (Date.now() - this.startTime) / 1000;
      const rate = this.completed / elapsed;

      console.log(`📊 Progress: ${this.completed}/${this.total} (${percent}%) - ${rate.toFixed(1)} ops/sec`);
    }
  }

  getSummary() {
    const duration = (Date.now() - this.startTime) / 1000;
    return {
      total: this.total,
      completed: this.completed,
      errors: this.errors,
      duration: duration.toFixed(1),
      rate: (this.completed / duration).toFixed(1)
    };
  }
}

// Rate limiting
function delay(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

// Main execution
async function main() {
  try {
    console.log('🚀 Starting MeasureForge AI Agents Population Script...\n');

    validateConfig();

    const supabase = createSupabaseClient();

    if (CONFIG.dryRun) {
      console.log('🔍 DRY RUN MODE - Analyzing data...\n');
      console.log(`📊 Would create ${AGENTS_DATA.length} agents in Supabase`);

      AGENTS_DATA.forEach((agent, index) => {
        console.log(`  ${index + 1}. ${agent.name} (${agent.title}) - ${agent.adapter_config.model}`);
      });

      return;
    }

    console.log(`📊 Populating ${AGENTS_DATA.length} MeasureForge AI agents into Supabase...\n`);

    const totalOperations = AGENTS_DATA.length;
    const progress = new ProgressTracker(totalOperations);
    let successCount = 0;
    let errorCount = 0;

    // Insert agents
    console.log('\n🤖 Inserting agents...');
    for (const agentData of AGENTS_DATA) {
      try {
        console.log(`👤 Processing agent: ${agentData.name} (${agentData.title})`);

        const { data, error } = await supabase
          .from('agents')
          .upsert(agentData, {
            onConflict: 'id',
            ignoreDuplicates: false
          })
          .select();

        if (error) {
          console.error(`❌ Failed to insert agent ${agentData.name}:`, error.message);
          errorCount++;
          progress.increment(false);
        } else {
          console.log(`✅ Successfully inserted agent: ${agentData.name}`);
          successCount++;
          progress.increment(true);
        }

        await delay(CONFIG.delayMs);

      } catch (error) {
        console.error(`💥 Unexpected error processing agent ${agentData.name}:`, error.message);
        errorCount++;
        progress.increment(false);
      }
    }

    const summary = progress.getSummary();
    console.log('\n📈 Execution Summary:');
    console.log('====================');
    console.log(`✅ Successful: ${summary.completed - summary.errors}`);
    console.log(`❌ Errors: ${summary.errors}`);
    console.log(`⏱️  Duration: ${summary.duration}s`);
    console.log(`🚀 Rate: ${summary.rate} ops/sec`);

    if (summary.errors === 0) {
      console.log('\n🎉 MeasureForge AI agents population completed successfully!');
      console.log('🏢 Company: MeasureForge AI');
      console.log(`🤖 Total agents: ${AGENTS_DATA.length}`);
      console.log('🇨🇳 All agents configured with Chinese models (Qwen Max, ERNIE 4.0 Turbo, Hunyuan Turbo, Spark Max)');
      console.log('📋 Agent categories:');
      console.log('   • Core Measurement Agents (6)');
      console.log('   • Document & Data Processing Agents (4)');
      console.log('   • Visual & Spatial Intelligence Agents (3)');
      console.log('   • Procurement & Compliance Agents (4)');
      console.log('   • Specialized Measurement Domain Agents (6)');
      console.log('   • Builder-Specific Agents (4)');
      console.log('\n🚀 Ready for platform deployment!');
    } else {
      console.log('\n⚠️  MeasureForge AI agents population completed with errors.');
      console.log('🔍 Check the logs above for details on failed insertions.');
    }

  } catch (error) {
    console.error('\n💥 FATAL ERROR during MeasureForge AI agents population:', error);
    process.exit(1);
  }
}

// Run the script
main().catch(console.error);
