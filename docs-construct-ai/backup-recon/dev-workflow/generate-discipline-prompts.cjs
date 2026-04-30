#!/usr/bin/env node

/**
 * Generate Discipline Specialist Prompts Script
 * Creates all 17 discipline specialist prompts for the correspondence workflow
 */

const fs = require('fs');
const path = require('path');

class DisciplinePromptGenerator {
  constructor() {
    this.devPromptsDir = path.join(process.cwd(), 'docs', 'dev-prompts');
    this.ensureDevPromptsDir();
  }

  ensureDevPromptsDir() {
    if (!fs.existsSync(this.devPromptsDir)) {
      fs.mkdirSync(this.devPromptsDir, { recursive: true });
      console.log('📁 Created dev-prompts directory');
    }
  }

  generateAllPrompts() {
    console.log('🚀 Generating all discipline specialist prompts...\n');

    const disciplines = [
      // Core Engineering Disciplines (1-7)
      {
        key: 'civil',
        name: 'Civil Engineering Specialist',
        expertise: 'site development, concrete structures, foundations, earthworks, grading, drainage, underground utilities',
        focus: 'Site preparation, concrete work, foundations, drainage systems'
      },
      {
        key: 'structural',
        name: 'Structural Engineering Specialist',
        expertise: 'steel/concrete design, seismic analysis, load calculations, reinforcement, framing, connections',
        focus: 'Structural integrity, steel/concrete specifications, load-bearing systems'
      },
      {
        key: 'mechanical',
        name: 'Mechanical Engineering Specialist',
        expertise: 'HVAC systems, plumbing, ventilation, heating, mechanical equipment, system integration',
        focus: 'Building services, mechanical systems, equipment specifications'
      },
      {
        key: 'electrical',
        name: 'Electrical Engineering Specialist',
        expertise: 'power systems, lighting, communications, cabling, switchgear, equipment grounding',
        focus: 'Electrical distribution, lighting, safety systems, power requirements'
      },
      {
        key: 'process',
        name: 'Process Engineering Specialist',
        expertise: 'industrial processes, equipment design, process optimization, system integration',
        focus: 'Process systems, industrial equipment, operational requirements'
      },
      {
        key: 'instrumentation',
        name: 'Instrumentation Engineering Specialist',
        expertise: 'control systems, automation, instrumentation, SCADA, PLC programming',
        focus: 'Process control, automation systems, instrumentation specifications'
      },
      {
        key: 'geotechnical',
        name: 'Geotechnical Engineering Specialist',
        expertise: 'soil mechanics, foundation design, borehole analysis, ground investigation, slope stability',
        focus: 'Soil conditions, foundation recommendations, ground stability'
      },

      // Additional Specialties (8-17)
      {
        key: 'environmental',
        name: 'Environmental Engineering Specialist',
        expertise: 'environmental impact assessment, pollution control, waste management, environmental compliance',
        focus: 'Environmental regulations, impact assessments, pollution prevention'
      },
      {
        key: 'safety',
        name: 'Safety Engineering Specialist',
        expertise: 'occupational safety, risk assessment, hazard identification, safety procedures, PPE',
        focus: 'Safety compliance, risk mitigation, occupational health'
      },
      {
        key: 'architectural',
        name: 'Architectural Specialist',
        expertise: 'building design, space planning, architectural standards, building codes, aesthetics',
        focus: 'Building design, space utilization, architectural requirements'
      },
      {
        key: 'logistics',
        name: 'Logistics Specialist',
        expertise: 'supply chain management, material procurement, transportation, warehousing, inventory',
        focus: 'Material logistics, procurement coordination, supply chain optimization'
      },
      {
        key: 'construction',
        name: 'Construction Specialist',
        expertise: 'construction methods, site management, sequencing, construction planning, methodologies',
        focus: 'Construction techniques, project execution, site coordination'
      },
      {
        key: 'quality_control',
        name: 'Quality Control Specialist',
        expertise: 'quality assurance, testing protocols, inspection procedures, compliance verification',
        focus: 'Quality systems, inspection regimes, compliance verification'
      },
      {
        key: 'quantity_surveying',
        name: 'Quantity Surveying Specialist',
        expertise: 'cost estimation, quantity takeoffs, valuation, cost planning, contract pricing',
        focus: 'Cost management, quantity calculations, commercial viability'
      },
      {
        key: 'scheduling',
        name: 'Scheduling Specialist',
        expertise: 'project scheduling, timeline management, critical path analysis, resource allocation',
        focus: 'Project timelines, scheduling optimization, delay analysis'
      },
      {
        key: 'inspection',
        name: 'Inspection Specialist',
        expertise: 'field inspection, compliance verification, quality audits, deficiency identification',
        focus: 'Field verification, compliance checking, quality audits'
      },
      {
        key: 'health',
        name: 'Health & Safety Specialist',
        expertise: 'occupational health, safety protocols, risk management, emergency planning, HSE compliance',
        focus: 'Health and safety compliance, risk management, emergency procedures'
      }
    ];

    let generated = 0;
    let skipped = 0;

    for (const discipline of disciplines) {
      const filePath = path.join(this.devPromptsDir, `${discipline.key}.md`);

      // Skip if already exists (like civil.md we created manually)
      if (fs.existsSync(filePath)) {
        console.log(`⏭️  Skipping ${discipline.key} (already exists)`);
        skipped++;
        continue;
      }

      const promptContent = this.generatePromptContent(discipline);

      try {
        fs.writeFileSync(filePath, promptContent, 'utf8');
        console.log(`✅ Generated ${discipline.key}.md - ${discipline.name}`);
        generated++;
      } catch (error) {
        console.error(`❌ Failed to generate ${discipline.key}:`, error.message);
      }
    }

    console.log(`\n🎉 Generation complete!`);
    console.log(`📄 Generated: ${generated} prompts`);
    console.log(`⏭️  Skipped: ${skipped} existing prompts`);
    console.log(`📁 Total available: ${generated + skipped} discipline specialists`);
  }

  generatePromptContent(discipline) {
    const metadata = {
      dev_mode: true,
      created: new Date().toISOString(),
      author: 'discipline_prompt_generator',
      purpose: 'discipline_specialist',
      iteration: 1,
      notes: `${discipline.name} for domain consultation - ${discipline.expertise}`,
      category: 'contracts',
      agent_type: 'specialist'
    };

    const metadataBlock = `---\n${Object.entries(metadata)
      .map(([key, value]) => `${key}: ${value}`)
      .join('\n')}\n---\n\n`;

    const promptContent = `# ${discipline.name}

You are a specialized ${discipline.name} with expertise in ${discipline.expertise} in construction and engineering projects.

## Role Definition
You are one of 17 discipline specialists in a parallel processing workflow. Your expertise covers ${discipline.focus}. You provide technical consultation on ${discipline.key}-related matters in contractual correspondence.

## Context & Guidelines
You receive correspondence that has been pre-analyzed and categorized. Your task is to provide specialist ${discipline.key} analysis, focusing on technical accuracy, compliance with standards, and practical implementation considerations.

## Expertise Areas
Your specialist knowledge includes:
${this.generateExpertiseList(discipline)}

## Task Instructions
When consulted on correspondence, provide analysis covering:

1. **Technical Compliance**: Assess compliance with ${discipline.key} standards and requirements
2. **Best Practices**: Evaluate alignment with industry best practices
3. **Quality Requirements**: Identify specific quality control measures
4. **Safety Considerations**: Highlight ${discipline.key}-specific safety requirements
5. **Cost Implications**: Assess cost impacts of ${discipline.key} decisions
6. **Schedule Impacts**: Evaluate timeline implications
7. **Risk Assessment**: Identify ${discipline.key}-specific risks and mitigation

## Analysis Framework

### Technical Assessment
${this.generateTechnicalAssessment(discipline)}

### Risk Evaluation
${this.generateRiskEvaluation(discipline)}

### Recommendation Structure
Provide actionable recommendations for ${discipline.key} aspects.

## Output Format
Return a structured analysis in JSON format with discipline-specific analysis fields.

## Quality Standards
- **Technical Accuracy**: Recommendations based on established ${discipline.key} principles
- **Code Compliance**: Reference appropriate standards and regulations
- **Practicality**: Recommendations must be implementable and cost-effective
- **Safety First**: Safety considerations prioritized in all recommendations

## Integration Notes
- Your analysis contributes to the parallel specialist consultation process
- Technical recommendations inform contract management decisions
- Risk assessments feed into overall project risk management
- Cost and schedule impacts influence contract variations

## Performance Requirements
- Provide analysis within parallel processing timeframes (< 60 seconds)
- Maintain >90% technical accuracy in recommendations
- Support concurrent consultation with other discipline specialists
- Enable HITL escalation for complex technical decisions`;

    return metadataBlock + promptContent;
  }

  generateExpertiseList(discipline) {
    const expertiseAreas = {
      civil: [
        'Site preparation and grading',
        'Concrete mix design and specifications',
        'Foundation systems and design',
        'Drainage and utility systems',
        'Earthworks and compaction'
      ],
      structural: [
        'Structural steel design and specifications',
        'Concrete structural elements',
        'Load calculations and analysis',
        'Connection design and detailing',
        'Seismic and wind analysis'
      ],
      mechanical: [
        'HVAC system design',
        'Plumbing and drainage systems',
        'Mechanical equipment specifications',
        'System integration and coordination',
        'Energy efficiency considerations'
      ],
      electrical: [
        'Power distribution systems',
        'Lighting design and controls',
        'Communication systems',
        'Equipment grounding and safety',
        'System commissioning and testing'
      ],
      process: [
        'Process system design',
        'Equipment specifications',
        'Process optimization',
        'System integration',
        'Operational requirements'
      ],
      instrumentation: [
        'Control system design',
        'Instrumentation specifications',
        'SCADA system integration',
        'Automation programming',
        'System calibration and testing'
      ],
      geotechnical: [
        'Soil investigation and analysis',
        'Foundation recommendations',
        'Groundwater assessment',
        'Slope stability analysis',
        'Geotechnical reporting'
      ],
      environmental: [
        'Environmental impact assessment',
        'Pollution prevention plans',
        'Waste management systems',
        'Environmental monitoring',
        'Regulatory compliance'
      ],
      safety: [
        'Hazard identification and assessment',
        'Risk management planning',
        'Safety procedure development',
        'PPE requirements and specifications',
        'Safety training programs'
      ],
      architectural: [
        'Building design principles',
        'Space planning and utilization',
        'Building code compliance',
        'Aesthetic considerations',
        'Accessibility requirements'
      ],
      logistics: [
        'Supply chain management',
        'Material procurement planning',
        'Transportation and delivery',
        'Inventory management',
        'Logistics coordination'
      ],
      construction: [
        'Construction methodology',
        'Site management practices',
        'Construction sequencing',
        'Quality control procedures',
        'Safety management'
      ],
      quality_control: [
        'Quality management systems',
        'Inspection and testing protocols',
        'Non-conformance management',
        'Quality documentation',
        'Continuous improvement'
      ],
      quantity_surveying: [
        'Cost estimation and planning',
        'Quantity takeoff procedures',
        'Contract pricing analysis',
        'Cost control and monitoring',
        'Value engineering'
      ],
      scheduling: [
        'Project scheduling techniques',
        'Critical path analysis',
        'Resource allocation planning',
        'Schedule optimization',
        'Delay analysis and mitigation'
      ],
      inspection: [
        'Field inspection procedures',
        'Quality verification methods',
        'Compliance checking protocols',
        'Deficiency identification',
        'Corrective action planning'
      ],
      health: [
        'Occupational health management',
        'Safety protocol development',
        'Emergency response planning',
        'HSE compliance monitoring',
        'Risk assessment and control'
      ]
    };

    const areas = expertiseAreas[discipline.key] || ['General specialist analysis'];
    return areas.map(area => `- ${area}`).join('\n');
  }

  generateTechnicalAssessment(discipline) {
    const assessments = {
      civil: 'Evaluate foundation design, concrete specifications, site preparation methods, and drainage system adequacy.',
      structural: 'Assess structural integrity, load-carrying capacity, material specifications, and connection details.',
      mechanical: 'Review system design, equipment specifications, installation requirements, and maintenance considerations.',
      electrical: 'Evaluate power requirements, system design, equipment specifications, and safety compliance.',
      process: 'Assess process design, equipment integration, operational requirements, and efficiency considerations.',
      instrumentation: 'Review control system design, instrumentation specifications, calibration requirements, and integration.',
      geotechnical: 'Evaluate soil conditions, foundation recommendations, groundwater considerations, and stability analysis.',
      environmental: 'Assess environmental impacts, regulatory compliance, mitigation measures, and monitoring requirements.',
      safety: 'Evaluate hazard identification, risk controls, safety procedures, and emergency preparedness.',
      architectural: 'Review design compliance, space utilization, building codes, and aesthetic considerations.',
      logistics: 'Assess supply chain efficiency, procurement strategies, transportation requirements, and inventory management.',
      construction: 'Evaluate construction methods, sequencing, quality control, and site management practices.',
      quality_control: 'Review quality systems, inspection protocols, documentation requirements, and compliance verification.',
      quantity_surveying: 'Assess cost estimates, quantity calculations, pricing accuracy, and value for money.',
      scheduling: 'Evaluate project timelines, critical path dependencies, resource allocation, and schedule optimization.',
      inspection: 'Review inspection procedures, compliance verification, deficiency management, and quality assurance.',
      health: 'Assess health management, safety protocols, emergency planning, and HSE compliance monitoring.'
    };

    return assessments[discipline.key] || 'Provide comprehensive technical assessment for the discipline.';
  }

  generateRiskEvaluation(discipline) {
    const evaluations = {
      civil: 'Identify foundation failure risks, concrete quality issues, drainage problems, and site preparation concerns.',
      structural: 'Assess structural failure risks, material quality issues, design errors, and construction defects.',
      mechanical: 'Evaluate system failure risks, equipment malfunction, installation errors, and maintenance issues.',
      electrical: 'Identify electrical safety risks, power quality issues, equipment failure, and compliance concerns.',
      process: 'Assess process failure risks, equipment breakdown, operational errors, and efficiency problems.',
      instrumentation: 'Review control system risks, calibration errors, integration issues, and monitoring failures.',
      geotechnical: 'Evaluate ground stability risks, foundation settlement, groundwater issues, and soil conditions.',
      environmental: 'Assess environmental impact risks, regulatory non-compliance, pollution incidents, and remediation costs.',
      safety: 'Identify safety hazard risks, accident potential, PPE failures, and emergency response issues.',
      architectural: 'Review design compliance risks, space utilization problems, code violations, and aesthetic issues.',
      logistics: 'Assess supply chain disruption risks, procurement delays, transportation issues, and inventory problems.',
      construction: 'Evaluate construction risk factors, sequencing problems, quality issues, and safety concerns.',
      quality_control: 'Review quality failure risks, inspection oversights, non-conformance issues, and compliance gaps.',
      quantity_surveying: 'Assess cost overrun risks, estimation errors, pricing issues, and contract value concerns.',
      scheduling: 'Evaluate schedule delay risks, critical path issues, resource constraints, and milestone failures.',
      inspection: 'Review inspection failure risks, oversight issues, compliance gaps, and quality assurance problems.',
      health: 'Assess health and safety risks, regulatory compliance issues, emergency response failures, and incident potential.'
    };

    return evaluations[discipline.key] || 'Identify and assess discipline-specific risks and mitigation measures.';
  }
}

// CLI Interface
function main() {
  const args = process.argv.slice(2);
  const generator = new DisciplinePromptGenerator();

  if (args.length === 0) {
    console.log('Discipline Prompt Generator');
    console.log('Usage: node generate-discipline-prompts.js <command>');
    console.log('');
    console.log('Commands:');
    console.log('  generate    - Generate all discipline specialist prompts');
    console.log('  list        - List existing discipline prompts');
    console.log('');
    console.log('This will create prompts for all 17 discipline specialists in docs/dev-prompts/');
    return;
  }

  const command = args[0];

  switch (command) {
    case 'generate':
      generator.generateAllPrompts();
      break;

    case 'list':
      const disciplines = [
        'civil', 'structural', 'mechanical', 'electrical', 'process', 'instrumentation', 'geotechnical',
        'environmental', 'safety', 'architectural', 'logistics', 'construction', 'quality_control',
        'quantity_surveying', 'scheduling', 'inspection', 'health'
      ];

      console.log('📋 Discipline Specialist Prompts:');
      disciplines.forEach((discipline, index) => {
        const filePath = path.join(generator.devPromptsDir, `${discipline}.md`);
        const exists = fs.existsSync(filePath);
        console.log(`${(index + 1).toString().padStart(2, ' ')}. ${discipline.padEnd(15)} ${exists ? '✅' : '❌'}`);
      });
      break;

    default:
      console.error(`❌ Unknown command: ${command}`);
      process.exit(1);
  }
}

// Run CLI if called directly
if (require.main === module) {
  main();
}

module.exports = DisciplinePromptGenerator;
