#!/usr/bin/env node

/**
 * Procurement Orders Data Population Script
 * Populates procurement orders test data using Supabase API
 * Follows JavaScript Data Population Procedure for secure, RLS-compliant data insertion
 */

import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import { USER_ID_MAP } from './populate-users.js';

// Map of procurement order identifiers to proper UUIDs
const PROC_ORDER_ID_MAP = {
  'uuid-proc-001': '550e8400-e29b-41d4-a716-446655440101',
  'uuid-proc-002': '550e8400-e29b-41d4-a716-446655440102',
  'uuid-proc-003': '550e8400-e29b-41d4-a716-446655440103',
  'uuid-proc-004': '550e8400-e29b-41d4-a716-446655440104',
  'uuid-proc-005': '550e8400-e29b-41d4-a716-446655440105'
};

// Configuration
dotenv.config();

const CONFIG = {
  supabaseUrl: process.env.SUPABASE_URL,
  supabaseKey: process.env.SUPABASE_ANON_KEY || process.env.SUPABASE_SERVICE_ROLE_KEY,
  organizationId: '90cd635a-380f-4586-a3b7-a09103b6df94',
  batchSize: 5,
  delayMs: 200,
  dryRun: process.argv.includes('--dry-run'),
  verbose: process.argv.includes('--verbose')
};

// Procurement orders test data
const procurementOrdersData = [
  {
    id: PROC_ORDER_ID_MAP['uuid-proc-001'],
    order_number: 'PO-2026-001',
    order_type: 'purchase_order',
    title: 'Industrial Equipment Procurement',
    description: 'Complete procurement for production line equipment including CNC machines, conveyor systems, and quality control stations',
    estimated_value: 250000.00,
    currency: 'ZAR',
    approval_status: 'draft', // Fixed: was 'in_progress'
    priority: 'high',
    department: 'Procurement',
    created_by: USER_ID_MAP['uuid-user-001'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    created_at: '2026-01-01T10:00:00Z',
    updated_at: '2026-01-01T10:00:00Z',
    sow_template_id: 'a4b49645-2ab4-47b7-a507-c73676bc67d8', // Equipment Procurement SOW
    discipline_assignments: {
      appendix_a: ['engineering', 'quality'],
      appendix_b: ['safety'],
      appendix_c: ['procurement']
    },
    user_assignments: {
      appendix_a: [USER_ID_MAP['uuid-user-002'], USER_ID_MAP['uuid-user-004']],
      appendix_b: [USER_ID_MAP['uuid-user-003']],
      appendix_c: [USER_ID_MAP['uuid-user-001']]
    },
    approval_config: {
      generate_cover_sheet: true,
      routing_type: 'sequential',
      approval_matrix: [
        { role: 'procurement_officer', required: true, user_id: USER_ID_MAP['uuid-user-001'] },
        { role: 'procurement_manager', required: true, user_id: USER_ID_MAP['uuid-user-005'] }
      ]
    }
  },
  {
    id: PROC_ORDER_ID_MAP['uuid-proc-002'],
    order_number: 'SO-2026-002',
    order_type: 'service_order',
    title: 'Maintenance Services Contract',
    description: 'Annual maintenance contract for HVAC systems and electrical infrastructure',
    estimated_value: 500000.00,
    currency: 'ZAR',
    approval_status: 'draft',
    priority: 'medium',
    department: 'Procurement',
    created_by: USER_ID_MAP['uuid-user-005'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    created_at: '2026-01-02T14:30:00Z',
    updated_at: '2026-01-02T14:30:00Z',
    sow_template_id: '92641278-60b4-4a70-8d83-e98f43f74bbd', // Professional Services SOW
    discipline_assignments: {
      appendix_a: ['engineering'],
      appendix_b: ['safety', 'quality'],
      appendix_c: ['procurement']
    },
    user_assignments: {
      appendix_a: [USER_ID_MAP['uuid-user-006']],
      appendix_b: [USER_ID_MAP['uuid-user-003'], USER_ID_MAP['uuid-user-004']],
      appendix_c: [USER_ID_MAP['uuid-user-005']]
    },
    approval_config: {
      generate_cover_sheet: true,
      routing_type: 'sequential',
      approval_matrix: [
        { role: 'procurement_specialist', required: true, user_id: USER_ID_MAP['uuid-user-005'] },
        { role: 'engineering_manager', required: true, user_id: USER_ID_MAP['uuid-user-002'] },
        { role: 'safety_officer', required: true, user_id: USER_ID_MAP['uuid-user-003'] }
      ]
    }
  },
  {
    id: PROC_ORDER_ID_MAP['uuid-proc-003'],
    order_number: 'WO-2026-003',
    order_type: 'work_order',
    title: 'Construction Equipment Rental',
    description: 'Heavy machinery rental for infrastructure development project',
    estimated_value: 750000.00,
    currency: 'ZAR',
    approval_status: 'approved',
    priority: 'high',
    department: 'Procurement',
    created_by: USER_ID_MAP['uuid-user-001'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    created_at: '2026-01-03T09:15:00Z',
    updated_at: '2026-01-03T11:45:00Z',
    sow_template_id: 'a4b49645-2ab4-47b7-a507-c73676bc67d8', // Equipment Procurement SOW
    discipline_assignments: {
      appendix_a: ['civil_engineering'],
      appendix_b: ['safety', 'quality'],
      appendix_c: ['procurement']
    },
    user_assignments: {
      appendix_a: [USER_ID_MAP['uuid-user-008']],
      appendix_b: [USER_ID_MAP['uuid-user-003'], USER_ID_MAP['uuid-user-004']],
      appendix_c: [USER_ID_MAP['uuid-user-001']]
    },
    approval_config: {
      generate_cover_sheet: true,
      routing_type: 'parallel',
      approval_matrix: [
        { role: 'procurement_officer', required: true, user_id: USER_ID_MAP['uuid-user-001'] },
        { role: 'civil_engineer', required: true, user_id: USER_ID_MAP['uuid-user-008'] },
        { role: 'safety_manager', required: true, user_id: USER_ID_MAP['uuid-user-003'] }
      ]
    }
  },
  {
    id: PROC_ORDER_ID_MAP['uuid-proc-004'],
    order_number: 'PO-2026-004',
    order_type: 'purchase_order',
    title: 'Chemical Processing Equipment',
    description: 'Specialized chemical processing and handling equipment for pharmaceutical manufacturing',
    estimated_value: 1200000.00,
    currency: 'ZAR',
    approval_status: 'draft',
    priority: 'high',
    department: 'Procurement',
    created_by: USER_ID_MAP['uuid-user-005'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    created_at: '2026-01-04T16:20:00Z',
    updated_at: '2026-01-04T16:20:00Z',
    sow_template_id: null,
    discipline_assignments: {
      appendix_a: ['chemical_engineering'],
      appendix_b: ['safety', 'quality'],
      appendix_c: ['procurement'],
      appendix_d: ['environmental']
    },
    user_assignments: {
      appendix_a: [USER_ID_MAP['uuid-user-007']],
      appendix_b: [USER_ID_MAP['uuid-user-003'], USER_ID_MAP['uuid-user-004']],
      appendix_c: [USER_ID_MAP['uuid-user-005']],
      appendix_d: [USER_ID_MAP['uuid-user-011']]
    },
    approval_config: {
      generate_cover_sheet: true,
      routing_type: 'sequential',
      approval_matrix: [
        { role: 'procurement_specialist', required: true, user_id: USER_ID_MAP['uuid-user-005'] },
        { role: 'chemical_engineer', required: true, user_id: USER_ID_MAP['uuid-user-007'] },
        { role: 'safety_manager', required: true, user_id: USER_ID_MAP['uuid-user-003'] },
        { role: 'quality_manager', required: true, user_id: USER_ID_MAP['uuid-user-004'] }
      ]
    }
  },
  {
    id: PROC_ORDER_ID_MAP['uuid-proc-005'],
    order_number: 'SO-2026-005',
    order_type: 'service_order',
    title: 'IT Infrastructure Services',
    description: 'Managed IT services including network infrastructure, cybersecurity, and system administration',
    estimated_value: 350000.00,
    currency: 'ZAR',
    approval_status: 'completed',
    priority: 'medium',
    department: 'Procurement',
    created_by: USER_ID_MAP['uuid-user-001'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    created_at: '2026-01-05T08:00:00Z',
    updated_at: '2026-01-06T17:30:00Z',
    sow_template_id: null,
    discipline_assignments: {
      appendix_a: ['it'],
      appendix_b: ['security'],
      appendix_c: ['procurement']
    },
    user_assignments: {
      appendix_a: [USER_ID_MAP['uuid-user-012']],
      appendix_b: [USER_ID_MAP['uuid-user-013']],
      appendix_c: [USER_ID_MAP['uuid-user-001']]
    },
    approval_config: {
      generate_cover_sheet: true,
      routing_type: 'sequential',
      approval_matrix: [
        { role: 'procurement_officer', required: true, user_id: USER_ID_MAP['uuid-user-001'] },
        { role: 'it_manager', required: true, user_id: USER_ID_MAP['uuid-user-012'] }
      ]
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

    if (CONFIG.verbose || this.completed % 2 === 0) {
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
    console.log('🚀 Starting Procurement Orders Data Population Script...\n');

    validateConfig();

    const supabase = createSupabaseClient();

    if (CONFIG.dryRun) {
      console.log('🔍 DRY RUN MODE - Analyzing data...\n');
      console.log(`📊 Would process ${procurementOrdersData.length} procurement orders`);
      procurementOrdersData.forEach((order, index) => {
        console.log(`  ${index + 1}. ${order.order_number}: ${order.title} (${order.approval_status})`);
      });
      return;
    }

    console.log(`📊 Processing ${procurementOrdersData.length} procurement orders...\n`);

    const progress = new ProgressTracker(procurementOrdersData.length);
    let successCount = 0;
    let errorCount = 0;

    // Process each procurement order
    for (const orderData of procurementOrdersData) {
      try {
        console.log(`\n📝 Processing order: ${orderData.order_number} - ${orderData.title}`);

        // Insert procurement order
        const { data, error } = await supabase
          .from('procurement_orders')
          .upsert(orderData, {
            onConflict: 'order_number',
            ignoreDuplicates: false
          })
          .select();

        if (error) {
          console.error(`❌ Failed to insert order ${orderData.order_number}:`, error.message);
          errorCount++;
          progress.increment(false);
        } else {
          console.log(`✅ Successfully processed order: ${orderData.order_number}`);
          successCount++;
          progress.increment(true);
        }

        // Rate limiting
        await delay(CONFIG.delayMs);

      } catch (error) {
        console.error(`💥 Unexpected error processing order ${orderData.order_number}:`, error.message);
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
      console.log('\n🎉 Procurement orders data population completed successfully!');
      console.log('📋 All procurement orders are now available for testing the procurement workflow.');
    } else {
      console.log('\n⚠️  Procurement orders data population completed with errors.');
      console.log('🔍 Check the logs above for details on failed insertions.');
    }

  } catch (error) {
    console.error('\n💥 FATAL ERROR during procurement orders population:', error);
    process.exit(1);
  }
}

// Run the script
main().catch(console.error);
