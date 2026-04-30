#!/usr/bin/env node

/**
 * User Management Data Population Script
 * Converted from: user_management.sql
 * Environment: Supabase with RLS
 * Dependencies: Organizations must exist
 * Re-runnable: Yes (upsert with conflict resolution)
 *
 * Usage:
 *   node populate-user-management.js --dry-run  # Test mode
 *   node populate-user-management.js --verbose  # Detailed logging
 *   node populate-user-management.js            # Production run
 */

import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

// Configuration with environment validation
dotenv.config({ path: './server/.env.dev' });
const CONFIG = {
  supabaseUrl: process.env.SUPABASE_URL,
  supabaseKey: process.env.SUPABASE_SERVICE_ROLE_KEY,
  organizationId: '90cd635a-380f-4586-a3b7-a09103b6df94',
  delayMs: 200,
  dryRun: process.argv.includes('--dry-run'),
  verbose: process.argv.includes('--verbose')
};

// User management test data (converted from SQL)
const tableData = [
  {
    user_id: '550e8400-e29b-41d4-a716-446655440001',
    email: 'procurement.officer@epcm.co.za',
    full_name: 'Sarah Johnson',
    job_title: 'Senior Procurement Officer',
    department: 'Procurement',
    disciplines: ['Procurement'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    is_active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: '550e8400-e29b-41d4-a716-446655440002',
    email: 'john.engineer@epcm.co.za',
    full_name: 'John Engineering',
    job_title: 'Senior Mechanical Engineer',
    department: 'Engineering',
    disciplines: ['Engineering', 'Mechanical'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    is_active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: '550e8400-e29b-41d4-a716-446655440003',
    email: 'sarah.safety@epcm.co.za',
    full_name: 'Sarah Safety',
    job_title: 'Safety Manager',
    department: 'Safety',
    disciplines: ['Safety', 'HSE'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    is_active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: '550e8400-e29b-41d4-a716-446655440004',
    email: 'mark.quality@epcm.co.za',
    full_name: 'Mark Quality',
    job_title: 'Quality Assurance Manager',
    department: 'Quality',
    disciplines: ['Quality', 'QA'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    is_active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: '550e8400-e29b-41d4-a716-446655440005',
    email: 'lisa.procurement@epcm.co.za',
    full_name: 'Lisa Procurement',
    job_title: 'Procurement Specialist',
    department: 'Procurement',
    disciplines: ['Procurement', 'Contracts'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    is_active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: '550e8400-e29b-41d4-a716-446655440006',
    email: 'david.electrical@epcm.co.za',
    full_name: 'David Electrical',
    job_title: 'Electrical Engineer',
    department: 'Engineering',
    disciplines: ['Engineering', 'Electrical'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    is_active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: '550e8400-e29b-41d4-a716-446655440007',
    email: 'anna.chemical@epcm.co.za',
    full_name: 'Anna Chemical',
    job_title: 'Chemical Engineer',
    department: 'Engineering',
    disciplines: ['Engineering', 'Chemical'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    is_active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: '550e8400-e29b-41d4-a716-446655440008',
    email: 'peter.civil@epcm.co.za',
    full_name: 'Peter Civil',
    job_title: 'Civil Engineer',
    department: 'Engineering',
    disciplines: ['Engineering', 'Civil'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    is_active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: '550e8400-e29b-41d4-a716-446655440009',
    email: 'maria.logistics@epcm.co.za',
    full_name: 'Maria Logistics',
    job_title: 'Logistics Manager',
    department: 'Logistics',
    disciplines: ['Logistics', 'Operations'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    is_active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: '550e8400-e29b-41d4-a716-446655440010',
    email: 'thomas.training@epcm.co.za',
    full_name: 'Thomas Training',
    job_title: 'Training Specialist',
    department: 'Human Resources',
    disciplines: ['Training', 'HR'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    is_active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: '550e8400-e29b-41d4-a716-446655440011',
    email: 'emma.environmental@epcm.co.za',
    full_name: 'Emma Environmental',
    job_title: 'Environmental Officer',
    department: 'Environmental',
    disciplines: ['Environmental', 'Compliance'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    is_active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: '550e8400-e29b-41d4-a716-446655440012',
    email: 'alex.it@epcm.co.za',
    full_name: 'Alex IT',
    job_title: 'IT Manager',
    department: 'Information Technology',
    disciplines: ['IT', 'Infrastructure'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    is_active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: '550e8400-e29b-41d4-a716-446655440013',
    email: 'rachel.security@epcm.co.za',
    full_name: 'Rachel Security',
    job_title: 'Cybersecurity Specialist',
    department: 'Information Technology',
    disciplines: ['Security', 'Cybersecurity'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    is_active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: '550e8400-e29b-41d4-a716-446655440014',
    email: 'james.construction@epcm.co.za',
    full_name: 'James Construction',
    job_title: 'Construction Manager',
    department: 'Construction',
    disciplines: ['Construction', 'Project Management'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    is_active: true,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    user_id: '550e8400-e29b-41d4-a716-446655440015',
    email: 'olivia.operations@epcm.co.za',
    full_name: 'Olivia Operations',
    job_title: 'Operations Director',
    department: 'Operations',
    disciplines: ['Operations', 'Management'],
    organization_id: '90cd635a-380f-4586-a3b7-a09103b6df94',
    is_active: true,
    created_at: '2026-01-01T10:00:00Z'
  }
];

// Main execution with comprehensive error handling
async function main() {
  const startTime = Date.now();

  try {
    console.log('🚀 Starting user management population...\n');

    // Validate environment
    if (!CONFIG.supabaseUrl || !CONFIG.supabaseKey) {
      throw new Error('Missing required environment variables: SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY');
    }

    // Create Supabase client with organization context for RLS compliance
    const supabase = createClient(CONFIG.supabaseUrl, CONFIG.supabaseKey, {
      global: { headers: { 'x-organization-id': CONFIG.organizationId } }
    });

    if (CONFIG.dryRun) {
      console.log('🔍 DRY RUN MODE - Previewing changes...');
      console.log(`📊 Would process ${tableData.length} user records`);
      console.log('📋 Sample record:');
      console.log(JSON.stringify(tableData[0], null, 2));
      return;
    }

    // Progress tracking
    let successCount = 0;
    let errorCount = 0;

    console.log(`📝 Processing ${tableData.length} user records...\n`);

    // Process each user record
    for (let i = 0; i < tableData.length; i++) {
      try {
        const user = tableData[i];

        // Use upsert for safe updates (handles conflicts gracefully)
        const { error } = await supabase
          .from('user_management')
          .upsert(user, {
            onConflict: 'user_id',  // Primary key conflict resolution
            ignoreDuplicates: false
          });

        if (error) throw error;

        successCount++;

        if (CONFIG.verbose || (i + 1) % 5 === 0) {
          console.log(`✅ Processed ${i + 1}/${tableData.length} users - ${user.full_name}`);
        }

        // Rate limiting to prevent API throttling
        await new Promise(resolve => setTimeout(resolve, CONFIG.delayMs));

      } catch (error) {
        console.error(`❌ Failed to process user ${i + 1} (${tableData[i].full_name}):`, error.message);
        errorCount++;
      }
    }

    // Create indexes (equivalent to SQL CREATE INDEX statements)
    console.log('\n📊 Creating database indexes...');
    try {
      // Note: In production, these would be created via migration scripts
      // For now, we document that they should exist
      const indexes = [
        'idx_user_management_email',
        'idx_user_management_organization',
        'idx_user_management_active',
        'idx_user_management_department'
      ];

      console.log(`📋 Required indexes: ${indexes.join(', ')}`);
      console.log('ℹ️  Indexes should be created via database migration scripts');
    } catch (indexError) {
      console.warn('⚠️ Index creation note:', indexError.message);
    }

    // Summary
    const duration = ((Date.now() - startTime) / 1000).toFixed(1);
    console.log('\n📈 Population Summary:');
    console.log(`✅ Successful: ${successCount}`);
    console.log(`❌ Errors: ${errorCount}`);
    console.log(`⏱️  Duration: ${duration}s`);
    console.log(`🚀 Rate: ${(successCount / (Date.now() - startTime) * 1000).toFixed(1)} ops/sec`);

    if (errorCount === 0) {
      console.log('\n🎉 User management population completed successfully!');
      console.log('📋 All users now available for procurement workflow testing');
    } else {
      console.log(`\n⚠️  User management population completed with ${errorCount} errors.`);
      console.log('💡 Check the error messages above for details.');
      console.log('🔄 Script is re-runnable - failed records can be retried');
    }

  } catch (error) {
    console.error('💥 Critical error:', error);
    console.error('Stack trace:', error.stack);
    process.exit(1);
  }
}

// Execute
main().catch(console.error);