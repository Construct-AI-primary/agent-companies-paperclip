#!/usr/bin/env node

/**
 * Document Variations Data Population Script
 * Populates document variations for procurement workflow testing
 * Follows JavaScript Data Population Procedure for API-based operations
 */

import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

// Configuration
dotenv.config();

const CONFIG = {
  supabaseUrl: process.env.SUPABASE_URL,
  supabaseKey: process.env.SUPABASE_ANON_KEY,
  organizationId: '90cd635a-380f-4586-a3b7-a09103b6df94',
  batchSize: 5,
  delayMs: 200,
  dryRun: process.argv.includes('--dry-run'),
  verbose: process.argv.includes('--verbose')
};

// Document variations test data
const DOCUMENT_VARIATIONS = [
  {
    id: 'uuid-doc-var-001',
    title: 'Standard Purchase Order Variation',
    description: 'Complete document variation for standard purchase orders with all required sections',
    discipline_code: '01900',
    organization_id: CONFIG.organizationId,
    template_variation: 'standard_po',
    created_by: '550e8400-e29b-41d4-a716-446655440001',
    created_at: '2026-01-01T10:00:00Z',
    updated_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-doc-var-002',
    title: 'Service Order Variation',
    description: 'Document variation for service contracts with service-level sections',
    discipline_code: '01900',
    organization_id: CONFIG.organizationId,
    template_variation: 'service_order',
    created_by: '550e8400-e29b-41d4-a716-446655440001',
    created_at: '2026-01-01T10:00:00Z',
    updated_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-doc-var-003',
    title: 'Work Order Variation',
    description: 'Document variation for work orders with technical specifications',
    discipline_code: '01900',
    organization_id: CONFIG.organizationId,
    template_variation: 'work_order',
    created_by: '550e8400-e29b-41d4-a716-446655440001',
    created_at: '2026-01-01T10:00:00Z',
    updated_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-doc-var-004',
    title: 'Chemical Processing Equipment Variation',
    description: 'Specialized variation for chemical processing equipment procurement',
    discipline_code: '01900',
    organization_id: CONFIG.organizationId,
    template_variation: 'chemical_processing',
    created_by: '550e8400-e29b-41d4-a716-446655440001',
    created_at: '2026-01-01T10:00:00Z',
    updated_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-doc-var-005',
    title: 'IT Infrastructure Services Variation',
    description: 'Document variation for IT infrastructure and service contracts',
    discipline_code: '01900',
    organization_id: CONFIG.organizationId,
    template_variation: 'it_infrastructure',
    created_by: '550e8400-e29b-41d4-a716-446655440001',
    created_at: '2026-01-01T10:00:00Z',
    updated_at: '2026-01-01T10:00:00Z'
  }
];

// Validation
function validateConfig() {
  const required = ['supabaseUrl', 'supabaseKey', 'organizationId'];
  const missing = required.filter(key => !CONFIG[key.replace('supabase', 'SUPABASE').toUpperCase()]);

  if (missing.length > 0) {
    throw new Error(`Missing required environment variables: ${missing.join(', ')}`);
  }
}

// Supabase client with organization context
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

    if (CONFIG.verbose || this.completed % 1 === 0) {
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

// Validate data structure
function validateVariation(variation) {
  const required = ['id', 'title', 'discipline_code', 'organization_id', 'template_variation'];
  const missing = required.filter(field => !variation[field]);

  if (missing.length > 0) {
    throw new Error(`Missing required fields: ${missing.join(', ')}`);
  }

  if (variation.id.length < 10) {
    throw new Error(`Invalid ID format: ${variation.id}`);
  }

  return true;
}

// Main execution
async function main() {
  try {
    console.log('🚀 Starting document variations population script...\n');

    validateConfig();

    const supabase = createSupabaseClient();

    // Validate all data first
    console.log('🔍 Validating data structure...');
    DOCUMENT_VARIATIONS.forEach(variation => validateVariation(variation));
    console.log('✅ All variations validated\n');

    const progress = new ProgressTracker(DOCUMENT_VARIATIONS.length);

    if (CONFIG.dryRun) {
      console.log('🔍 DRY RUN MODE - No data will be modified');
      console.log(`📊 Would process ${DOCUMENT_VARIATIONS.length} document variations\n`);

      // Show what would be inserted
      DOCUMENT_VARIATIONS.forEach((variation, index) => {
        console.log(`${index + 1}. ${variation.title} (${variation.template_variation})`);
      });

      console.log('\n✅ Dry run completed successfully');
      return;
    }

    console.log(`📊 Processing ${DOCUMENT_VARIATIONS.length} document variations...\n`);

    // Process each variation
    for (const variation of DOCUMENT_VARIATIONS) {
      try {
        // Check if variation already exists
        const { data: existing } = await supabase
          .from('document_variations')
          .select('id')
          .eq('id', variation.id)
          .single();

        if (existing) {
          if (CONFIG.verbose) {
            console.log(`⏭️  Skipping existing variation: ${variation.title}`);
          }
          progress.increment(true);
          continue;
        }

        // Insert the variation
        const { data, error } = await supabase
          .from('document_variations')
          .insert([variation])
          .select()
          .single();

        if (error) {
          console.error(`❌ Failed to insert variation ${variation.title}:`, error.message);
          progress.increment(false);
        } else {
          if (CONFIG.verbose) {
            console.log(`✅ Inserted variation: ${variation.title}`);
          }
          progress.increment(true);
        }

      } catch (error) {
        console.error(`💥 Error processing variation ${variation.title}:`, error.message);
        progress.increment(false);
      }

      // Rate limiting
      await delay(CONFIG.delayMs);
    }

    const summary = progress.getSummary();
    console.log('\n📈 Execution Summary:');
    console.log(`✅ Successful: ${summary.completed}`);
    console.log(`❌ Errors: ${summary.errors}`);
    console.log(`⏱️  Duration: ${summary.duration}s`);
    console.log(`🚀 Rate: ${summary.rate} ops/sec`);

    if (summary.errors === 0) {
      console.log('\n🎉 Document variations population completed successfully!');
    } else {
      console.log('\n⚠️  Document variations population completed with errors. Check logs above.');
    }

  } catch (error) {
    console.error('💥 Critical error:', error);
    process.exit(1);
  }
}

// Execute
main().catch(console.error);
