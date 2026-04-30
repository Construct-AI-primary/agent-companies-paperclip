#!/usr/bin/env node

/**
 * Supabase Agents Data Population Script
 * Populates DomainForge AI and InfraForge AI agent data into Supabase tables
 * Follows JavaScript Data Population Procedure for secure, RLS-compliant data insertion
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

// Company mappings (these should match the actual company IDs in Supabase)
const COMPANY_MAP = {
  'DomainForge AI': '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d', // From Paperclip system
  'InfraForge AI': '09f438a3-4041-46f2-b3cc-96fc9446e666'    // From Paperclip system
};

// Agent data for Supabase tables
const AGENTS_DATA = [
  // DomainForge AI Agents
  {
    id: '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5', // Orion
    company_id: COMPANY_MAP['DomainForge AI'],
    name: 'Orion',
    role: 'ceo',
    title: 'Chief Civil Engineering Orchestrator',
    capabilities: 'Central nervous system for civil engineering project orchestration and coordination. Oversees multi-disciplinary engineering workflow orchestration, cross-functional team coordination, dependency management, performance monitoring, and engineering quality assurance.',
    status: 'active',
    reports_to: null,
    created_at: '2026-03-30T15:53:36.729Z',
    updated_at: '2026-03-30T15:53:36.729Z',
    metadata: {
      team: 'DomainForge AI',
      specialization: 'Civil Engineering Orchestration',
      permissions: ['can_create_agents', 'can_assign_tasks']
    }
  },
  {
    id: 'b03a9911-2a30-4c48-b501-35a42eb7e933', // Strategos
    company_id: COMPANY_MAP['DomainForge AI'],
    name: 'Strategos',
    role: 'general',
    title: 'Strategic Planning Director',
    capabilities: 'Long-term strategic direction for civil engineering and infrastructure development. Handles infrastructure market analysis, competitive intelligence, strategic planning for large-scale construction projects, risk assessment, growth planning, technology adoption, and innovation strategy.',
    status: 'active',
    reports_to: '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5', // Orion
    created_at: '2026-03-30T15:53:51.580Z',
    updated_at: '2026-03-30T15:53:51.580Z',
    metadata: {
      team: 'DomainForge AI',
      specialization: 'Strategic Planning'
    }
  },
  {
    id: 'f9e4dcab-bef2-407d-920a-9beab25d5aad', // Council
    company_id: COMPANY_MAP['DomainForge AI'],
    name: 'Council',
    role: 'general',
    title: 'Governance & Standards Director',
    capabilities: 'Collective strategic governance and policy development for engineering. Handles engineering policy development, governance frameworks, cross-disciplinary coordination, engineering standards enforcement, compliance validation, and regulatory framework development.',
    status: 'active',
    reports_to: '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5', // Orion
    created_at: '2026-03-30T15:53:55.244Z',
    updated_at: '2026-03-30T15:53:55.244Z',
    metadata: {
      team: 'DomainForge AI',
      specialization: 'Governance & Standards'
    }
  },
  {
    id: '73e8b756-f623-471d-afc2-6c60f8e95faa', // Structural
    company_id: COMPANY_MAP['DomainForge AI'],
    name: 'Structural',
    role: 'engineer',
    title: 'Structural Engineering Specialist',
    capabilities: 'Structural analysis, design, and integrity assessment. Handles structural analysis and design calculations, load analysis, foundation design, structural integrity verification, structural safety assessment, and construction documentation.',
    status: 'active',
    reports_to: '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5', // Orion
    created_at: '2026-03-30T15:53:59.867Z',
    updated_at: '2026-03-30T15:53:59.867Z',
    metadata: {
      team: 'DomainForge AI',
      discipline: 'Structural Engineering'
    }
  },
  {
    id: '5171c41d-e021-4565-a7cd-e572ddbb9d72', // Geotechnical
    company_id: COMPANY_MAP['DomainForge AI'],
    name: 'Geotechnical',
    role: 'engineer',
    title: 'Geotechnical Engineering Specialist',
    capabilities: 'Soil mechanics, foundation engineering, and ground investigation. Handles soil investigation and characterization, foundation design and bearing capacity analysis, slope stability analysis, groundwater analysis, and earthquake engineering.',
    status: 'active',
    reports_to: '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5', // Orion
    created_at: '2026-03-30T15:54:03.544Z',
    updated_at: '2026-03-30T15:54:03.544Z',
    metadata: {
      team: 'DomainForge AI',
      discipline: 'Geotechnical Engineering'
    }
  },
  {
    id: '241c2581-7296-4d7f-b5bb-9fae8cb1c3cb', // Transportation
    company_id: COMPANY_MAP['DomainForge AI'],
    name: 'Transportation',
    role: 'engineer',
    title: 'Transportation Engineering Specialist',
    capabilities: 'Highway, railway, and transportation infrastructure design. Handles geometric design and alignment, traffic engineering and capacity analysis, intersection and interchange design, and transportation safety analysis.',
    status: 'active',
    reports_to: '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5', // Orion
    created_at: '2026-03-30T15:54:10.681Z',
    updated_at: '2026-03-30T15:54:10.681Z',
    metadata: {
      team: 'DomainForge AI',
      discipline: 'Transportation Engineering'
    }
  },
  // InfraForge AI Agents
  {
    id: '2876f20c-220c-4bf7-9baf-6ea668f85ef6', // Orchestrator
    company_id: COMPANY_MAP['InfraForge AI'],
    name: 'Orchestrator',
    role: 'ceo',
    title: 'Infrastructure Orchestration Specialist',
    capabilities: 'Central orchestration of infrastructure services and system integration. Oversees infrastructure service orchestration and coordination, system integration and API management, service dependency management, and infrastructure performance optimization.',
    status: 'active',
    reports_to: null,
    created_at: '2026-03-30T15:54:36.134Z',
    updated_at: '2026-03-30T15:54:36.134Z',
    metadata: {
      team: 'InfraForge AI',
      specialization: 'Infrastructure Orchestration',
      permissions: ['can_create_agents', 'can_assign_tasks']
    }
  },
  {
    id: '45c97946-2bdc-44f9-8d05-f3a19d15ea4c', // Database
    company_id: COMPANY_MAP['InfraForge AI'],
    name: 'Database',
    role: 'engineer',
    title: 'Database Infrastructure Specialist',
    capabilities: 'Database design, optimization, and management for engineering data. Handles database architecture and schema design, performance optimization and query tuning, data backup and recovery, and database security.',
    status: 'active',
    reports_to: '2876f20c-220c-4bf7-9baf-6ea668f85ef6', // Orchestrator
    created_at: '2026-03-30T15:54:44.386Z',
    updated_at: '2026-03-30T15:54:44.386Z',
    metadata: {
      team: 'InfraForge AI',
      specialization: 'Database Infrastructure'
    }
  }
];

// Agent permissions data
const AGENT_PERMISSIONS_DATA = [
  {
    agent_id: '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5', // Orion
    permission_key: 'agents:create',
    granted_by_user_id: null,
    granted_at: '2026-03-30T15:53:36.729Z'
  },
  {
    agent_id: '91223cfa-cf03-4f71-a5b0-c6afa1b02ac5', // Orion
    permission_key: 'tasks:assign',
    granted_by_user_id: null,
    granted_at: '2026-03-30T15:53:36.729Z'
  },
  {
    agent_id: '2876f20c-220c-4bf7-9baf-6ea668f85ef6', // InfraForge Orchestrator
    permission_key: 'agents:create',
    granted_by_user_id: null,
    granted_at: '2026-03-30T15:54:36.134Z'
  },
  {
    agent_id: '2876f20c-220c-4bf7-9baf-6ea668f85ef6', // InfraForge Orchestrator
    permission_key: 'tasks:assign',
    granted_by_user_id: null,
    granted_at: '2026-03-30T15:54:36.134Z'
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
    console.log('🚀 Starting Supabase Agents Data Population Script...\n');

    validateConfig();

    const supabase = createSupabaseClient();

    if (CONFIG.dryRun) {
      console.log('🔍 DRY RUN MODE - Analyzing data...\n');
      console.log(`📊 Would create ${AGENTS_DATA.length} agents in Supabase`);
      console.log(`📊 Would create ${AGENT_PERMISSIONS_DATA.length} agent permissions in Supabase`);

      AGENTS_DATA.forEach((agent, index) => {
        const companyName = Object.keys(COMPANY_MAP).find(key => COMPANY_MAP[key] === agent.company_id);
        console.log(`  ${index + 1}. ${agent.name} (${agent.title}) - ${companyName}`);
      });

      console.log('\n🔗 Agent Permissions:');
      AGENT_PERMISSIONS_DATA.forEach((perm, index) => {
        const agent = AGENTS_DATA.find(a => a.id === perm.agent_id);
        console.log(`  ${index + 1}. ${agent?.name}: ${perm.permission_key}`);
      });

      return;
    }

    console.log(`📊 Populating ${AGENTS_DATA.length} agents and ${AGENT_PERMISSIONS_DATA.length} permissions into Supabase...\n`);

    const totalOperations = AGENTS_DATA.length + AGENT_PERMISSIONS_DATA.length;
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

    // Insert agent permissions
    console.log('\n🔐 Inserting agent permissions...');
    for (const permissionData of AGENT_PERMISSIONS_DATA) {
      try {
        const agent = AGENTS_DATA.find(a => a.id === permissionData.agent_id);
        console.log(`🔑 Processing permission for ${agent?.name}: ${permissionData.permission_key}`);

        const { data, error } = await supabase
          .from('agent_permissions')
          .upsert(permissionData, {
            onConflict: 'agent_id,permission_key',
            ignoreDuplicates: false
          })
          .select();

        if (error) {
          console.error(`❌ Failed to insert permission for ${agent?.name}:`, error.message);
          errorCount++;
          progress.increment(false);
        } else {
          console.log(`✅ Successfully inserted permission for ${agent?.name}`);
          successCount++;
          progress.increment(true);
        }

        await delay(CONFIG.delayMs);

      } catch (error) {
        const agent = AGENTS_DATA.find(a => a.id === permissionData.agent_id);
        console.error(`💥 Unexpected error processing permission for ${agent?.name}:`, error.message);
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
      console.log('\n🎉 Supabase agents data population completed successfully!');
      console.log('🏢 Companies:');
      Object.entries(COMPANY_MAP).forEach(([name, id]) => {
        const agentCount = AGENTS_DATA.filter(a => a.company_id === id).length;
        console.log(`   - ${name} (${id}): ${agentCount} agents`);
      });
      console.log(`🤖 Total agents: ${AGENTS_DATA.length}`);
      console.log(`🔐 Total permissions: ${AGENT_PERMISSIONS_DATA.length}`);
    } else {
      console.log('\n⚠️  Supabase agents data population completed with errors.');
      console.log('🔍 Check the logs above for details on failed insertions.');
    }

  } catch (error) {
    console.error('\n💥 FATAL ERROR during Supabase agents population:', error);
    process.exit(1);
  }
}

// Run the script
main().catch(console.error);