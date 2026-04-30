#!/usr/bin/env node

/**
 * Agent Workflow Executions Data Population Script
 * Populates agent workflow executions test data using Supabase API
 * Follows JavaScript Data Population Procedure for secure, RLS-compliant data insertion
 */

import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

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

// Agent workflow executions test data
const agentWorkflowExecutionsData = [
  {
    id: 'uuid-agent-exec-001-01',
    procurement_order_id: PROC_ORDER_ID_MAP['uuid-proc-001'],
    agent_id: 'agent_procurement_01',
    agent_name: 'Template Analysis Agent',
    stage: 'template_analysis',
    status: 'completed',
    input_data: {
      template_id: 'uuid-template-001',
      order_requirements: 'CNC machines, conveyor systems, quality control stations',
      compliance_context: 'South African procurement regulations'
    },
    output_data: {
      compatibility_score: 95,
      template_suitability: 'excellent',
      identified_requirements: [
        'Technical specifications for industrial equipment',
        'Quality assurance procedures',
        'Safety compliance requirements',
        'Commercial terms and conditions'
      ],
      risk_assessment: 'low',
      recommendations: [
        'Template fully compatible with requirements',
        'All mandatory fields available',
        'Appendix structure matches order complexity'
      ]
    },
    confidence_score: 0.92,
    processing_time_ms: 2500,
    executed_at: '2026-01-01T10:05:00Z',
    quality_gate_passed: true,
    quality_score: 95,
    notifications_sent: ['chatbot', 'dashboard'],
    metadata: {
      agent_version: '1.0',
      processing_node: 'agent-orchestrator-01',
      retry_count: 0
    }
  },
  {
    id: 'uuid-agent-exec-001-02',
    procurement_order_id: PROC_ORDER_ID_MAP['uuid-proc-001'],
    agent_id: 'agent_procurement_02',
    agent_name: 'Requirement Extraction Agent',
    stage: 'requirement_extraction',
    status: 'completed',
    input_data: {
      order_description: 'Complete procurement for production line equipment including CNC machines, conveyor systems, and quality control stations',
      template_analysis: {
        compatibility_score: 95,
        identified_requirements: [
          'Technical specifications',
          'Quality assurance',
          'Safety compliance',
          'Commercial terms'
        ]
      }
    },
    output_data: {
      extracted_requirements: {
        technical: [
          'CNC machine specifications (precision, capacity, power requirements)',
          'Conveyor system specifications (load capacity, speed, safety features)',
          'Quality control station specifications (measurement accuracy, calibration)',
          'Integration requirements with existing production line'
        ],
        quality: [
          'ISO 9001 compliance requirements',
          'Quality assurance procedures',
          'Testing and validation protocols',
          'Documentation and traceability requirements'
        ],
        safety: [
          'Machine guarding requirements',
          'Emergency stop systems',
          'Safety interlock specifications',
          'Operator training requirements'
        ],
        commercial: [
          'Delivery schedule requirements',
          'Payment terms and conditions',
          'Warranty and maintenance agreements',
          'Performance guarantees'
        ]
      },
      requirement_confidence: 0.88,
      total_requirements: 12,
      categorized_requirements: 4
    },
    confidence_score: 0.88,
    processing_time_ms: 3200,
    executed_at: '2026-01-01T10:07:00Z',
    quality_gate_passed: true,
    quality_score: 92,
    notifications_sent: ['chatbot', 'dashboard'],
    metadata: {
      agent_version: '1.0',
      processing_node: 'agent-orchestrator-02',
      retry_count: 0
    }
  },
  {
    id: 'uuid-agent-exec-001-03',
    procurement_order_id: PROC_ORDER_ID_MAP['uuid-proc-001'],
    agent_id: 'agent_procurement_03',
    agent_name: 'Compliance Validation Agent',
    stage: 'compliance_validation',
    status: 'completed',
    input_data: {
      extracted_requirements: {
        technical: ['CNC specifications', 'Conveyor specs', 'Quality control specs'],
        quality: ['ISO compliance', 'Testing protocols'],
        safety: ['Machine guarding', 'Emergency stops'],
        commercial: ['Delivery schedule', 'Payment terms']
      },
      country_context: 'South Africa',
      industry_context: 'Manufacturing'
    },
    output_data: {
      compliance_validation: {
        overall_compliance_score: 94,
        gap_analysis: {
          critical_gaps: [],
          minor_gaps: ['Additional certification requirements for imported equipment'],
          recommendations: ['Include local content requirements', 'Specify BBBEE compliance level']
        },
        regulatory_requirements: [
          'OHS Act compliance (Act 85 of 1993)',
          'Environmental Impact Assessment if required',
          'Import regulations for capital equipment',
          'Local procurement preferences'
        ],
        risk_assessment: {
          compliance_risk: 'low',
          mitigation_required: 'minimal',
          monitoring_required: 'standard'
        }
      },
      validation_metadata: {
        compliance_score: 94,
        gaps_identified: 1,
        recommendations_provided: 2,
        regulatory_frameworks_checked: 4
      }
    },
    confidence_score: 0.91,
    processing_time_ms: 4100,
    executed_at: '2026-01-01T10:09:00Z',
    quality_gate_passed: true,
    quality_score: 96,
    notifications_sent: ['chatbot', 'dashboard'],
    metadata: {
      agent_version: '1.0',
      processing_node: 'agent-orchestrator-03',
      retry_count: 0
    }
  },
  {
    id: 'uuid-agent-exec-001-04',
    procurement_order_id: PROC_ORDER_ID_MAP['uuid-proc-001'],
    agent_id: 'agent_procurement_04',
    agent_name: 'Field Population Agent',
    stage: 'field_population',
    status: 'completed',
    input_data: {
      template_fields: {
        equipment_type: 'CNC machines and conveyor systems',
        rental_period: null,
        daily_rate: null,
        special_requirements: 'Production line integration'
      },
      extracted_requirements: {
        technical: ['CNC specs', 'Conveyor specs', 'Quality control specs'],
        quality: ['ISO compliance'],
        safety: ['Machine guarding'],
        commercial: ['Delivery schedule']
      },
      compliance_requirements: ['OHS Act', 'Import regulations']
    },
    output_data: {
      populated_fields: {
        equipment_type: 'Industrial CNC machining centers and automated conveyor systems',
        rental_period: null,
        daily_rate: null,
        special_requirements: 'Complete production line integration, operator training, maintenance support, and compliance with OHS Act and ISO 9001 standards',
        delivery_location: 'EPCM Engineering production facility',
        technical_specs: 'High-precision CNC machines with automated conveyor integration',
        quality_requirements: 'ISO 9001 certified equipment with full documentation',
        safety_features: 'Complete machine guarding and emergency stop systems',
        payment_terms: '50% deposit, 50% on delivery',
        warranty_period: '24 months',
        support_services: 'On-site installation, training, and maintenance'
      },
      population_metadata: {
        auto_populated_fields: 8,
        manual_review_fields: ['payment_terms', 'warranty_period'],
        field_confidence_scores: {
          equipment_type: 0.95,
          special_requirements: 0.88,
          technical_specs: 0.92
        },
        validation_status: 'passed'
      }
    },
    confidence_score: 0.89,
    processing_time_ms: 3800,
    executed_at: '2026-01-01T10:11:00Z',
    quality_gate_passed: true,
    quality_score: 93,
    notifications_sent: ['chatbot', 'dashboard'],
    metadata: {
      agent_version: '1.0',
      processing_node: 'agent-orchestrator-04',
      retry_count: 0
    }
  },
  {
    id: 'uuid-agent-exec-001-05',
    procurement_order_id: PROC_ORDER_ID_MAP['uuid-proc-001'],
    agent_id: 'agent_procurement_05',
    agent_name: 'Quality Assurance Agent',
    stage: 'quality_assurance',
    status: 'completed',
    input_data: {
      populated_template: {
        equipment_type: 'Industrial CNC machining centers and automated conveyor systems',
        special_requirements: 'Complete production line integration, operator training, maintenance support',
        payment_terms: '50% deposit, 50% on delivery'
      },
      previous_agent_outputs: [
        'Template analysis: 95% compatibility',
        'Requirements extraction: 12 requirements identified',
        'Compliance validation: 94% compliance score'
      ]
    },
    output_data: {
      quality_assessment: {
        overall_quality_score: 91,
        issues_and_corrections: {
          major_issues: [],
          minor_issues: [
            'Payment terms could be more specific',
            'Add reference to local content requirements'
          ],
          corrections_applied: [
            'Enhanced payment terms with milestone payments',
            'Added BBBEE compliance reference'
          ]
        },
        optimization_metrics: {
          error_reduction_percentage: 95,
          completeness_score: 98,
          consistency_score: 96,
          compliance_score: 94
        },
        validation_results: {
          field_validation: 'passed',
          business_rule_validation: 'passed',
          compliance_validation: 'passed',
          data_integrity_check: 'passed'
        }
      },
      quality_metadata: {
        overall_quality_score: 91,
        issues_identified: 2,
        corrections_applied: 2,
        validation_checks_passed: 4
      }
    },
    confidence_score: 0.94,
    processing_time_ms: 2900,
    executed_at: '2026-01-01T10:13:00Z',
    quality_gate_passed: true,
    quality_score: 91,
    notifications_sent: ['chatbot', 'dashboard'],
    metadata: {
      agent_version: '1.0',
      processing_node: 'agent-orchestrator-05',
      retry_count: 0
    }
  },
  {
    id: 'uuid-agent-exec-001-06',
    procurement_order_id: PROC_ORDER_ID_MAP['uuid-proc-001'],
    agent_id: 'agent_procurement_06',
    agent_name: 'Final Review Agent',
    stage: 'final_review',
    status: 'completed',
    input_data: {
      quality_assessment: {
        overall_quality_score: 91,
        issues_and_corrections: {
          major_issues: [],
          minor_issues: ['Payment terms specificity', 'Local content reference']
        }
      },
      populated_document: 'Complete procurement document with all appendices',
      agent_workflow_summary: {
        agents_executed: 5,
        average_confidence: 0.91,
        quality_gates_passed: 5,
        processing_time_total: 16500
      }
    },
    output_data: {
      final_review: {
        executive_summary: {
          document_readiness: 'approved',
          confidence_level: 'high',
          risk_assessment: 'low',
          recommendations: [
            'Document ready for procurement officer review',
            'All quality gates passed successfully',
            'Compliance requirements fully addressed'
          ]
        },
        approval_recommendation: {
          recommendation: 'approve',
          confidence_score: 0.96,
          justification: 'All agents completed successfully with high quality scores. Document meets all procurement and compliance requirements.',
          next_steps: [
            'Forward to procurement officer for final approval',
            'Initiate vendor engagement process',
            'Prepare contract negotiation documents'
          ]
        },
        final_metadata: {
          overall_confidence: 0.93,
          quality_score: 92,
          compliance_score: 95,
          completeness_score: 98
        }
      }
    },
    confidence_score: 0.96,
    processing_time_ms: 2100,
    executed_at: '2026-01-01T10:15:00Z',
    quality_gate_passed: true,
    quality_score: 96,
    notifications_sent: ['chatbot', 'dashboard', 'email'],
    metadata: {
      agent_version: '1.0',
      processing_node: 'agent-orchestrator-06',
      retry_count: 0,
      final_approval: 'granted'
    }
  },
  {
    id: 'uuid-agent-exec-002-01',
    procurement_order_id: PROC_ORDER_ID_MAP['uuid-proc-002'],
    agent_id: 'agent_procurement_01',
    agent_name: 'Template Analysis Agent',
    stage: 'template_analysis',
    status: 'completed',
    input_data: {
      template_id: 'uuid-template-sow-002',
      order_requirements: 'HVAC systems and electrical infrastructure maintenance',
      compliance_context: 'South African maintenance service regulations'
    },
    output_data: {
      compatibility_score: 89,
      template_suitability: 'good',
      identified_requirements: [
        'HVAC system specifications and maintenance scope',
        'Electrical infrastructure maintenance requirements',
        'Safety compliance for maintenance activities',
        'Service level agreements and response times'
      ],
      risk_assessment: 'low',
      recommendations: [
        'Template suitable for service agreement',
        'Additional focus on service level requirements needed',
        'Safety protocols well covered'
      ]
    },
    confidence_score: 0.87,
    processing_time_ms: 2800,
    executed_at: '2026-01-02T14:40:00Z',
    quality_gate_passed: true,
    quality_score: 89,
    notifications_sent: ['chatbot', 'dashboard'],
    metadata: {
      agent_version: '1.0',
      processing_node: 'agent-orchestrator-01',
      retry_count: 0
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
    console.log('🚀 Starting Agent Workflow Executions Data Population Script...\n');

    validateConfig();

    const supabase = createSupabaseClient();

    if (CONFIG.dryRun) {
      console.log('🔍 DRY RUN MODE - Analyzing data...\n');
      console.log(`📊 Would process ${agentWorkflowExecutionsData.length} agent workflow executions`);
      agentWorkflowExecutionsData.forEach((execution, index) => {
        console.log(`  ${index + 1}. ${execution.agent_name}: ${execution.stage} (${execution.status})`);
      });
      return;
    }

    console.log(`📊 Processing ${agentWorkflowExecutionsData.length} agent workflow executions...\n`);

    const progress = new ProgressTracker(agentWorkflowExecutionsData.length);
    let successCount = 0;
    let errorCount = 0;

    // Process each agent workflow execution
    for (const executionData of agentWorkflowExecutionsData) {
      try {
        console.log(`\n📝 Processing execution: ${executionData.agent_name} - ${executionData.stage}`);

        // Insert agent workflow execution
        const { data, error } = await supabase
          .from('agent_workflow_executions')
          .upsert(executionData, {
            onConflict: 'id',
            ignoreDuplicates: false
          })
          .select();

        if (error) {
          console.error(`❌ Failed to insert execution ${executionData.id}:`, error.message);
          errorCount++;
          progress.increment(false);
        } else {
          console.log(`✅ Successfully processed execution: ${executionData.agent_name} (${executionData.stage})`);
          successCount++;
          progress.increment(true);
        }

        // Rate limiting
        await delay(CONFIG.delayMs);

      } catch (error) {
        console.error(`💥 Unexpected error processing execution ${executionData.id}:`, error.message);
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
      console.log('\n🎉 Agent workflow executions data population completed successfully!');
      console.log('🤖 All agent workflow executions are now available for testing the 6-agent procurement system.');
    } else {
      console.log('\n⚠️  Agent workflow executions data population completed with errors.');
      console.log('🔍 Check the logs above for details on failed insertions.');
    }

  } catch (error) {
    console.error('\n💥 FATAL ERROR during agent workflow executions population:', error);
    process.exit(1);
  }
}

// Run the script
main().catch(console.error);
