#!/usr/bin/env node

/**
 * User Management Data Population Script
 * Populates user management test data using Supabase API
 * Generates proper UUIDs for users referenced by procurement data
 */

import { createClient } from '@supabase/supabase-js';
import crypto from 'crypto';

// Configuration
const CONFIG = {
  supabaseUrl: process.env.SUPABASE_URL,
  supabaseKey: process.env.SUPABASE_ANON_KEY || process.env.SUPABASE_SERVICE_ROLE_KEY,
  organizationId: '90cd635a-380f-4586-a3b7-a09103b6df94',
  delayMs: 200,
  dryRun: process.argv.includes('--dry-run'),
  verbose: process.argv.includes('--verbose')
};

// Map of user identifiers to proper UUIDs
const USER_ID_MAP = {
  'uuid-user-001': '550e8400-e29b-41d4-a716-446655440001',
  'uuid-user-002': '550e8400-e29b-41d4-a716-446655440002',
  'uuid-user-003': '550e8400-e29b-41d4-a716-446655440003',
  'uuid-user-004': '550e8400-e29b-41d4-a716-446655440004',
  'uuid-user-005': '550e8400-e29b-41d4-a716-446655440005',
  'uuid-user-006': '550e8400-e29b-41d4-a716-446655440006',
  'uuid-user-007': '550e8400-e29b-41d4-a716-446655440007',
  'uuid-user-008': '550e8400-e29b-41d4-a716-446655440008',
  'uuid-user-009': '550e8400-e29b-41d4-a716-446655440009',
  'uuid-user-010': '550e8400-e29b-41d4-a716-446655440010',
  'uuid-user-011': '550e8400-e29b-41d4-a716-446655440011',
  'uuid-user-012': '550e8400-e29b-41d4-a716-446655440012',
  'uuid-user-013': '550e8400-e29b-41d4-a716-446655440013',
  'uuid-user-014': '550e8400-e29b-41d4-a716-446655440014',
  'uuid-user-015': '550e8400-e29b-41d4-a716-446655440015'
};

// User management test data with proper UUIDs
const userManagementData = [
  {
    user_id: USER_ID_MAP['uuid-user-001'],
    email: 'procurement.officer@epcm.co.za',
    full_name: 'Sarah Johnson',
    job_title: 'Senior Procurement Officer',
    department: 'Procurement',
    disciplines: ['Procurement'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: USER_ID_MAP['uuid-user-002'],
    email: 'john.engineer@epcm.co.za',
    full_name: 'John Engineering',
    job_title: 'Senior Mechanical Engineer',
    department: 'Engineering',
    disciplines: ['Engineering', 'Mechanical'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: USER_ID_MAP['uuid-user-003'],
    email: 'sarah.safety@epcm.co.za',
    full_name: 'Sarah Safety',
    job_title: 'Safety Manager',
    department: 'Safety',
    disciplines: ['Safety', 'HSE'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: USER_ID_MAP['uuid-user-004'],
    email: 'mark.quality@epcm.co.za',
    full_name: 'Mark Quality',
    job_title: 'Quality Assurance Manager',
    department: 'Quality',
    disciplines: ['Quality', 'QA'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: USER_ID_MAP['uuid-user-005'],
    email: 'lisa.procurement@epcm.co.za',
    full_name: 'Lisa Procurement',
    job_title: 'Procurement Specialist',
    department: 'Procurement',
    disciplines: ['Procurement', 'Contracts'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: USER_ID_MAP['uuid-user-006'],
    email: 'david.electrical@epcm.co.za',
    full_name: 'David Electrical',
    job_title: 'Electrical Engineer',
    department: 'Engineering',
    disciplines: ['Engineering', 'Electrical'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: USER_ID_MAP['uuid-user-007'],
    email: 'anna.chemical@epcm.co.za',
    full_name: 'Anna Chemical',
    job_title: 'Chemical Engineer',
    department: 'Engineering',
    disciplines: ['Engineering', 'Chemical'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: USER_ID_MAP['uuid-user-008'],
    email: 'peter.civil@epcm.co.za',
    full_name: 'Peter Civil',
    job_title: 'Civil Engineer',
    department: 'Engineering',
    disciplines: ['Engineering', 'Civil'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: USER_ID_MAP['uuid-user-009'],
    email: 'maria.logistics@epcm.co.za',
    full_name: 'Maria Logistics',
    job_title: 'Logistics Manager',
    department: 'Logistics',
    disciplines: ['Logistics', 'Operations'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: USER_ID_MAP['uuid-user-010'],
    email: 'thomas.training@epcm.co.za',
    full_name: 'Thomas Training',
    job_title: 'Training Specialist',
    department: 'Human Resources',
    disciplines: ['Training', 'HR'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: USER_ID_MAP['uuid-user-011'],
    email: 'emma.environmental@epcm.co.za',
    full_name: 'Emma Environmental',
    job_title: 'Environmental Officer',
    department: 'Environmental',
    disciplines: ['Environmental', 'Compliance'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: USER_ID_MAP['uuid-user-012'],
    email: 'alex.it@epcm.co.za',
    full_name: 'Alex IT',
    job_title: 'IT Manager',
    department: 'Information Technology',
    disciplines: ['IT', 'Infrastructure'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: USER_ID_MAP['uuid-user-013'],
    email: 'rachel.security@epcm.co.za',
    full_name: 'Rachel Security',
    job_title: 'Cybersecurity Specialist',
    department: 'Information Technology',
    disciplines: ['Security', 'Cybersecurity'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: USER_ID_MAP['uuid-user-014'],
    email: 'james.construction@epcm.co.za',
    full_name: 'James Construction',
    job_title: 'Construction Manager',
    department: 'Construction',
    disciplines: ['Construction', 'Project Management'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: USER_ID_MAP['uuid-user-015'],
    email: 'olivia.operations@epcm.co.za',
    full_name: 'Olivia Operations',
    job_title: 'Operations Director',
    department: 'Operations',
    disciplines: ['Operations', 'Management'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    active: true,
    created_at: '2026-01-01T10:00:00Z'
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
    console.log('🚀 Starting User Management Data Population Script...\n');

    validateConfig();

    const supabase = createSupabaseClient();

    if (CONFIG.dryRun) {
      console.log('🔍 DRY RUN MODE - Analyzing data...\n');
      console.log(`📊 Would process ${userManagementData.length} users`);
      userManagementData.forEach((user, index) => {
        console.log(`  ${index + 1}. ${user.full_name}: ${user.email} (${user.user_id})`);
      });
      console.log('\n🔗 User ID Mapping:');
      Object.entries(USER_ID_MAP).forEach(([oldId, newId]) => {
        console.log(`  ${oldId} → ${newId}`);
      });
      return;
    }

    console.log(`📊 Processing ${userManagementData.length} users...\n`);

    const progress = new ProgressTracker(userManagementData.length);
    let successCount = 0;
    let errorCount = 0;

    // Process each user
    for (const userData of userManagementData) {
      try {
        console.log(`\n👤 Processing user: ${userData.full_name} (${userData.email})`);

        // Insert user
        const { data, error } = await supabase
          .from('user_management')
          .upsert(userData, {
            onConflict: 'user_id',
            ignoreDuplicates: false
          })
          .select();

        if (error) {
          console.error(`❌ Failed to insert user ${userData.email}:`, error.message);
          errorCount++;
          progress.increment(false);
        } else {
          console.log(`✅ Successfully processed user: ${userData.full_name}`);
          successCount++;
          progress.increment(true);
        }

        // Rate limiting
        await delay(CONFIG.delayMs);

      } catch (error) {
        console.error(`💥 Unexpected error processing user ${userData.email}:`, error.message);
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
      console.log('\n🎉 User management data population completed successfully!');
      console.log('👥 All users are now available for procurement workflow testing.');
      console.log('\n🔗 User ID Mapping for Reference:');
      Object.entries(USER_ID_MAP).forEach(([oldId, newId]) => {
        console.log(`  ${oldId} → ${newId}`);
      });
    } else {
      console.log('\n⚠️  User management data population completed with errors.');
      console.log('🔍 Check the logs above for details on failed insertions.');
    }

  } catch (error) {
    console.error('\n💥 FATAL ERROR during user management population:', error);
    process.exit(1);
  }
}

// Export the USER_ID_MAP for use in other scripts
export { USER_ID_MAP };

// Run the script
main().catch(console.error);
