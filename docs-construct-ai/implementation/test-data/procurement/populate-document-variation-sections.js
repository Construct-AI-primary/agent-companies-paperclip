#!/usr/bin/env node

/**
 * Document Variation Sections Data Population Script
 * Populates document variation sections for procurement workflow testing
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
  delayMs: 150,
  dryRun: process.argv.includes('--dry-run'),
  verbose: process.argv.includes('--verbose')
};

// Document variation sections test data
const DOCUMENT_VARIATION_SECTIONS = [
  // Standard Purchase Order Variation Sections
  {
    id: 'uuid-sec-001',
    variation_id: 'uuid-doc-var-001',
    section_code: 'executive_summary',
    section_name: 'Executive Summary',
    display_order: 1,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-002',
    variation_id: 'uuid-doc-var-001',
    section_code: 'scope_of_work',
    section_name: 'Scope of Work',
    display_order: 2,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-003',
    variation_id: 'uuid-doc-var-001',
    section_code: 'deliverables',
    section_name: 'Deliverables',
    display_order: 3,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-004',
    variation_id: 'uuid-doc-var-001',
    section_code: 'pricing',
    section_name: 'Pricing and Payment Terms',
    display_order: 4,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-005',
    variation_id: 'uuid-doc-var-001',
    section_code: 'appendix_a',
    section_name: 'Appendix A - Technical Specifications',
    display_order: 5,
    is_required: false,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-006',
    variation_id: 'uuid-doc-var-001',
    section_code: 'appendix_b',
    section_name: 'Appendix B - Quality Requirements',
    display_order: 6,
    is_required: false,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },

  // Service Order Variation Sections
  {
    id: 'uuid-sec-007',
    variation_id: 'uuid-doc-var-002',
    section_code: 'executive_summary',
    section_name: 'Executive Summary',
    display_order: 1,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-008',
    variation_id: 'uuid-doc-var-002',
    section_code: 'service_description',
    section_name: 'Service Description',
    display_order: 2,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-009',
    variation_id: 'uuid-doc-var-002',
    section_code: 'service_levels',
    section_name: 'Service Level Agreements',
    display_order: 3,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-010',
    variation_id: 'uuid-doc-var-002',
    section_code: 'responsibilities',
    section_name: 'Roles and Responsibilities',
    display_order: 4,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-011',
    variation_id: 'uuid-doc-var-002',
    section_code: 'appendix_c',
    section_name: 'Appendix C - Compliance Standards',
    display_order: 5,
    is_required: false,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },

  // Work Order Variation Sections
  {
    id: 'uuid-sec-012',
    variation_id: 'uuid-doc-var-003',
    section_code: 'executive_summary',
    section_name: 'Executive Summary',
    display_order: 1,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-013',
    variation_id: 'uuid-doc-var-003',
    section_code: 'work_description',
    section_name: 'Work Description',
    display_order: 2,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-014',
    variation_id: 'uuid-doc-var-003',
    section_code: 'specifications',
    section_name: 'Technical Specifications',
    display_order: 3,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-015',
    variation_id: 'uuid-doc-var-003',
    section_code: 'safety_requirements',
    section_name: 'Safety Requirements',
    display_order: 4,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-016',
    variation_id: 'uuid-doc-var-003',
    section_code: 'completion_criteria',
    section_name: 'Completion Criteria',
    display_order: 5,
    is_required: false,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },

  // Chemical Processing Variation Sections
  {
    id: 'uuid-sec-017',
    variation_id: 'uuid-doc-var-004',
    section_code: 'executive_summary',
    section_name: 'Executive Summary',
    display_order: 1,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-018',
    variation_id: 'uuid-doc-var-004',
    section_code: 'process_description',
    section_name: 'Process Description',
    display_order: 2,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-019',
    variation_id: 'uuid-doc-var-004',
    section_code: 'equipment_specs',
    section_name: 'Equipment Specifications',
    display_order: 3,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-020',
    variation_id: 'uuid-doc-var-004',
    section_code: 'safety_protocols',
    section_name: 'Safety Protocols',
    display_order: 4,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-021',
    variation_id: 'uuid-doc-var-004',
    section_code: 'environmental_compliance',
    section_name: 'Environmental Compliance',
    display_order: 5,
    is_required: false,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },

  // IT Infrastructure Variation Sections
  {
    id: 'uuid-sec-022',
    variation_id: 'uuid-doc-var-005',
    section_code: 'executive_summary',
    section_name: 'Executive Summary',
    display_order: 1,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-023',
    variation_id: 'uuid-doc-var-005',
    section_code: 'infrastructure_scope',
    section_name: 'Infrastructure Scope',
    display_order: 2,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-024',
    variation_id: 'uuid-doc-var-005',
    section_code: 'security_requirements',
    section_name: 'Security Requirements',
    display_order: 3,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-025',
    variation_id: 'uuid-doc-var-005',
    section_code: 'service_level_agreements',
    section_name: 'Service Level Agreements',
    display_order: 4,
    is_required: true,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
  },
  {
    id: 'uuid-sec-026',
    variation_id: 'uuid-doc-var-005',
    section_code: 'monitoring_reporting',
    section_name: 'Monitoring & Reporting',
    display_order: 5,
    is_required: false,
    organization_id: CONFIG.organizationId,
    created_at: '2026-01-01T10:00:00Z'
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

// Rate limiting
function delay(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

// Validate data structure
function validateSection(section) {
  const required = ['id', 'variation_id', 'section_code', 'section_name', 'organization_id'];
  const missing = required.filter(field => !section[field]);

  if (missing.length > 0) {
    throw new Error(`Missing required fields: ${missing.join(', ')}`);
  }

  if (section.id.length < 10) {
    throw new Error(`Invalid ID format: ${section.id}`);
  }

  if (typeof section.display_order !== 'number' || section.display_order < 1) {
    throw new Error(`Invalid display_order: ${section.display_order}`);
  }

  return true;
}

// Main execution
async function main() {
  try {
    console.log('🚀 Starting document variation sections population script...\n');

    validateConfig();

    const supabase = createSupabaseClient();

    // Validate all data first
    console.log('🔍 Validating data structure...');
    DOCUMENT_VARIATION_SECTIONS.forEach(section => validateSection(section));
    console.log('✅ All sections validated\n');

    const progress = new ProgressTracker(DOCUMENT_VARIATION_SECTIONS.length);

    if (CONFIG.dryRun) {
      console.log('🔍 DRY RUN MODE - No data will be modified');
      console.log(`📊 Would process ${DOCUMENT_VARIATION_SECTIONS.length} document variation sections\n`);

      // Show summary of what would be inserted
      const variationCounts = DOCUMENT_VARIATION_SECTIONS.reduce((acc, section) => {
        acc[section.variation_id] = (acc[section.variation_id] || 0) + 1;
        return acc;
      }, {});

      console.log('📊 Sections per variation:');
      Object.entries(variationCounts).forEach(([variationId, count]) => {
        console.log(`  ${variationId}: ${count} sections`);
      });

      console.log('\n✅ Dry run completed successfully');
      return;
    }

    console.log(`📊 Processing ${DOCUMENT_VARIATION_SECTIONS.length} document variation sections...\n`);

    // Process sections in batches to avoid overwhelming the API
    for (let i = 0; i < DOCUMENT_VARIATION_SECTIONS.length; i += CONFIG.batchSize) {
      const batch = DOCUMENT_VARIATION_SECTIONS.slice(i, i + CONFIG.batchSize);

      for (const section of batch) {
        try {
          // Check if section already exists
          const { data: existing } = await supabase
            .from('document_variation_sections')
            .select('id')
            .eq('id', section.id)
            .single();

          if (existing) {
            if (CONFIG.verbose) {
              console.log(`⏭️  Skipping existing section: ${section.section_name}`);
            }
            progress.increment(true);
            continue;
          }

          // Insert the section
          const { data, error } = await supabase
            .from('document_variation_sections')
            .insert([section])
            .select()
            .single();

          if (error) {
            console.error(`❌ Failed to insert section ${section.section_name}:`, error.message);
            progress.increment(false);
          } else {
            if (CONFIG.verbose) {
              console.log(`✅ Inserted section: ${section.section_name}`);
            }
            progress.increment(true);
          }

        } catch (error) {
          console.error(`💥 Error processing section ${section.section_name}:`, error.message);
          progress.increment(false);
        }

        // Rate limiting
        await delay(CONFIG.delayMs);
      }
    }

    const summary = progress.getSummary();
    console.log('\n📈 Execution Summary:');
    console.log(`✅ Successful: ${summary.completed}`);
    console.log(`❌ Errors: ${summary.errors}`);
    console.log(`⏱️  Duration: ${summary.duration}s`);
    console.log(`🚀 Rate: ${summary.rate} ops/sec`);

    if (summary.errors === 0) {
      console.log('\n🎉 Document variation sections population completed successfully!');
    } else {
      console.log('\n⚠️  Document variation sections population completed with errors. Check logs above.');
    }

  } catch (error) {
    console.error('💥 Critical error:', error);
    process.exit(1);
  }
}

// Execute
main().catch(console.error);
