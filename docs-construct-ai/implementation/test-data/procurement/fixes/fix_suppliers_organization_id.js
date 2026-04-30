#!/usr/bin/env node

/**
 * Fix Suppliers Organization ID - JavaScript Data Population Script
 *
 * Purpose: Update suppliers table to set proper organization_id for approved suppliers
 * Tables: suppliers
 * Dependencies: None (uses existing data)
 * Environment: Supabase with RLS
 * Re-runnable: Yes (idempotent)
 *
 * Usage:
 *   node fix_suppliers_organization_id.js --dry-run  # Test mode
 *   node fix_suppliers_organization_id.js --verbose  # Detailed logging
 *   node fix_suppliers_organization_id.js            # Production run
 */

import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

// Configuration
dotenv.config({ path: './server/.env.dev' });

const CONFIG = {
  supabaseUrl: process.env.SUPABASE_URL,
  supabaseKey: process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY,
  organizationId: '90cd635a-380f-4586-a3b7-a09103b6df94', // EPCM Engineering org
  delayMs: 200,
  dryRun: process.argv.includes('--dry-run'),
  verbose: process.argv.includes('--verbose')
};

// Validate configuration
function validateConfig() {
  const required = ['supabaseUrl', 'supabaseKey', 'organizationId'];
  const missing = required.filter(key => !CONFIG[key]);

  if (missing.length > 0) {
    throw new Error(`Missing required configuration: ${missing.join(', ')}`);
  }

  console.log('✅ Configuration validated');
}

// Create Supabase client with organization context
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

    if (CONFIG.verbose || this.completed % 5 === 0) {
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

// Delay utility for rate limiting
function delay(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

// Main execution
async function main() {
  try {
    console.log('🚀 Starting supplier organization ID fix...\n');

    validateConfig();

    const supabase = createSupabaseClient();

    // Step 1: Find suppliers with empty/null organization_id but approved status
    console.log('🔍 Finding suppliers that need organization_id updates...');

    const { data: allApprovedSuppliers, error: findError } = await supabase
      .from('suppliers')
      .select('id, name, approval_status, organization_id')
      .eq('approval_status', 'approved');

    if (findError) {
      throw new Error(`Failed to find suppliers: ${findError.message}`);
    }

    if (!allApprovedSuppliers || allApprovedSuppliers.length === 0) {
      console.log('✅ No approved suppliers found');
      return;
    }

    // Filter for suppliers with null, empty, or invalid organization_id
    const suppliersToUpdate = allApprovedSuppliers.filter(supplier =>
      !supplier.organization_id ||
      supplier.organization_id === '' ||
      supplier.organization_id === '00000000-0000-0000-0000-000000000000'
    );

    if (suppliersToUpdate.length === 0) {
      console.log('✅ No suppliers need organization_id updates');
      return;
    }

    console.log(`📋 Found ${suppliersToUpdate.length} suppliers to update:`);
    suppliersToUpdate.forEach(supplier => {
      console.log(`  - ${supplier.name} (ID: ${supplier.id}, Current org: ${supplier.organization_id || 'null'})`);
    });

    if (CONFIG.dryRun) {
      console.log('\n🔍 DRY RUN MODE - No changes will be made');
      console.log(`📊 Would update ${suppliersToUpdate.length} suppliers with organization_id: ${CONFIG.organizationId}`);
      return;
    }

    // Step 2: Update suppliers with proper organization_id
    console.log(`\n📝 Updating ${suppliersToUpdate.length} suppliers...`);

    const progress = new ProgressTracker(suppliersToUpdate.length);
    let successCount = 0;
    let errorCount = 0;

    for (const supplier of suppliersToUpdate) {
      try {
        const { error: updateError } = await supabase
          .from('suppliers')
          .update({
            organization_id: CONFIG.organizationId,
            updated_at: new Date().toISOString()
          })
          .eq('id', supplier.id);

        if (updateError) {
          console.error(`❌ Failed to update supplier ${supplier.name}:`, updateError.message);
          errorCount++;
        } else {
          console.log(`✅ Updated supplier: ${supplier.name}`);
          successCount++;
        }

        progress.increment(updateError === null);

        // Rate limiting
        await delay(CONFIG.delayMs);
      } catch (error) {
        console.error(`💥 Exception updating supplier ${supplier.name}:`, error.message);
        errorCount++;
        progress.increment(false);
      }
    }

    // Step 3: Verification
    console.log('\n🔍 Verifying updates...');

    const { data: verifiedSuppliers, error: verifyError } = await supabase
      .from('suppliers')
      .select('id, name, approval_status, organization_id')
      .eq('approval_status', 'approved')
      .eq('organization_id', CONFIG.organizationId);

    if (verifyError) {
      console.warn('⚠️ Verification failed:', verifyError.message);
    } else {
      console.log(`✅ Verification: ${verifiedSuppliers?.length || 0} suppliers now have correct organization_id`);
    }

    // Summary
    const summary = progress.getSummary();
    console.log('\n📈 Execution Summary:');
    console.log(`✅ Successful updates: ${successCount}`);
    console.log(`❌ Errors: ${errorCount}`);
    console.log(`⏱️  Duration: ${summary.duration}s`);
    console.log(`🚀 Rate: ${summary.rate} ops/sec`);

    if (errorCount === 0) {
      console.log('\n🎉 Supplier organization ID fix completed successfully!');
      console.log('📋 Summary: All approved suppliers now have the correct organization_id');
    } else {
      console.log(`\n⚠️  Supplier organization ID fix completed with ${errorCount} errors.`);
      console.log('💡 Check the error messages above for details.');
    }

  } catch (error) {
    console.error('💥 Critical error:', error);
    console.error('Stack trace:', error.stack);
    process.exit(1);
  }
}

// Execute
main().catch(console.error);