#!/usr/bin/env node

/**
 * Companies and Agents Data Population Script
 * Creates DomainForge AI and InfraForge AI companies with their agents
 * Uses Paperclip API to populate real database records
 */

import fetch from 'node-fetch';

// Configuration
const CONFIG = {
  paperclipApiBase: 'http://127.0.0.1:3100/api',
  delayMs: 500,
  dryRun: process.argv.includes('--dry-run'),
  verbose: process.argv.includes('--verbose')
};

// Company data
const COMPANIES = [
  {
    name: "DomainForge AI",
    description: "Multi-discipline autonomous AI company specializing in comprehensive engineering expertise across civil engineering disciplines",
    expectedId: "2d7d9c60-c02f-42a7-8f6a-7db86ecc879d",
    expectedPrefix: "DOM"
  },
  {
    name: "InfraForge AI",
    description: "Dedicated infrastructure services autonomous AI company specializing in comprehensive infrastructure management, system orchestration, data processing, security, and operational excellence",
    expectedId: "09f438a3-4041-46f2-b3cc-96fc9446e666",
    expectedPrefix: "INF"
  }
];

// DomainForge AI agents data
const DOMAINFORGE_AGENTS = [
  // Executive Leadership
  {
    name: "Orion",
    role: "ceo",
    title: "Chief Civil Engineering Orchestrator",
    capabilities: "Central nervous system for civil engineering project orchestration and coordination. Oversees multi-disciplinary engineering workflow orchestration, cross-functional team coordination, dependency management, performance monitoring, and engineering quality assurance.",
    companyName: "DomainForge AI"
  },
  {
    name: "Strategos",
    role: "general",
    title: "Strategic Planning Director",
    reportsToName: "Orion",
    capabilities: "Long-term strategic direction for civil engineering and infrastructure development. Handles infrastructure market analysis, competitive intelligence, strategic planning for large-scale construction projects, risk assessment, growth planning, technology adoption, and innovation strategy.",
    companyName: "DomainForge AI"
  },
  {
    name: "Council",
    role: "general",
    title: "Governance & Standards Director",
    reportsToName: "Orion",
    capabilities: "Collective strategic governance and policy development for engineering. Handles engineering policy development, governance frameworks, cross-disciplinary coordination, engineering standards enforcement, compliance validation, and regulatory framework development.",
    companyName: "DomainForge AI"
  },
  // Engineering Disciplines
  {
    name: "Structural",
    role: "engineer",
    title: "Structural Engineering Specialist",
    reportsToName: "Orion",
    capabilities: "Structural analysis, design, and integrity assessment. Handles structural analysis and design calculations, load analysis, foundation design, structural integrity verification, structural safety assessment, and construction documentation.",
    companyName: "DomainForge AI"
  },
  {
    name: "Geotechnical",
    role: "engineer",
    title: "Geotechnical Engineering Specialist",
    reportsToName: "Orion",
    capabilities: "Soil mechanics, foundation engineering, and ground investigation. Handles soil investigation and characterization, foundation design and bearing capacity analysis, slope stability analysis, groundwater analysis, and earthquake engineering.",
    companyName: "DomainForge AI"
  },
  {
    name: "Transportation",
    role: "engineer",
    title: "Transportation Engineering Specialist",
    reportsToName: "Orion",
    capabilities: "Highway, railway, and transportation infrastructure design. Handles geometric design and alignment, traffic engineering and capacity analysis, intersection and interchange design, and transportation safety analysis.",
    companyName: "DomainForge AI"
  },
  {
    name: "Water Resources",
    role: "engineer",
    title: "Water Resources Engineering Specialist",
    reportsToName: "Orion",
    capabilities: "Water supply, wastewater, and hydraulic engineering. Handles water distribution and wastewater collection system design, hydraulic analysis and pump station design, stormwater management, and water treatment facility design.",
    companyName: "DomainForge AI"
  },
  {
    name: "Environmental",
    role: "engineer",
    title: "Environmental Engineering Specialist",
    reportsToName: "Orion",
    capabilities: "Environmental impact assessment and sustainable engineering. Handles environmental impact assessment and mitigation planning, sustainable design and green infrastructure development, air and water quality analysis, and environmental permitting.",
    companyName: "DomainForge AI"
  },
  {
    name: "Surveying",
    role: "engineer",
    title: "Surveying and Geomatics Specialist",
    reportsToName: "Orion",
    capabilities: "Land surveying, mapping, and geospatial analysis. Handles land surveying and boundary determination, topographic mapping and GIS analysis, construction staking and layout coordination, and geodetic control.",
    companyName: "DomainForge AI"
  },
  {
    name: "Construction",
    role: "engineer",
    title: "Construction Engineering Specialist",
    reportsToName: "Orion",
    capabilities: "Construction methods, sequencing, and project management. Handles construction sequencing and methodology development, project scheduling and critical path analysis, construction safety planning, and quality assurance.",
    companyName: "DomainForge AI"
  },
  {
    name: "Project",
    role: "pm",
    title: "Project Management Specialist",
    reportsToName: "Orion",
    capabilities: "Civil engineering project management and coordination. Handles project planning and scope definition, cost estimation and budget management, stakeholder communication, and risk management.",
    companyName: "DomainForge AI"
  },
  {
    name: "Procurement",
    role: "general",
    title: "Procurement and Contracts Specialist",
    reportsToName: "Orion",
    capabilities: "Procurement management and contract administration. Handles procurement planning and strategy development, contract preparation and administration, vendor qualification, and subcontractor management.",
    companyName: "DomainForge AI"
  },
  {
    name: "Safety",
    role: "general",
    title: "Safety and Risk Management Specialist",
    reportsToName: "Orion",
    capabilities: "Construction safety, occupational health, and risk management. Handles construction safety planning and procedures development, occupational health and hazard assessment, safety training, and incident investigation.",
    companyName: "DomainForge AI"
  },
  {
    name: "Legal",
    role: "general",
    title: "Legal and Regulatory Compliance Specialist",
    reportsToName: "Orion",
    capabilities: "Legal compliance, permitting, and regulatory affairs. Handles regulatory compliance and permitting coordination, legal contract review and analysis, environmental compliance monitoring, and right-of-way acquisition.",
    companyName: "DomainForge AI"
  }
];

// InfraForge AI agents data
const INFRAFORGE_AGENTS = [
  {
    name: "Orchestrator",
    role: "ceo",
    title: "Infrastructure Orchestration Specialist",
    capabilities: "Central orchestration of infrastructure services and system integration. Oversees infrastructure service orchestration and coordination, system integration and API management, service dependency management, and infrastructure performance optimization.",
    companyName: "InfraForge AI"
  },
  {
    name: "Database",
    role: "engineer",
    title: "Database Infrastructure Specialist",
    reportsToName: "Orchestrator",
    capabilities: "Database design, optimization, and management for engineering data. Handles database architecture and schema design, performance optimization and query tuning, data backup and recovery, and database security.",
    companyName: "InfraForge AI"
  },
  {
    name: "Compute",
    role: "engineer",
    title: "Compute Infrastructure Specialist",
    reportsToName: "Orchestrator",
    capabilities: "Compute resources management and optimization for engineering workloads. Handles compute resource provisioning and scaling, container orchestration, serverless computing, and compute cost optimization.",
    companyName: "InfraForge AI"
  },
  {
    name: "Networking",
    role: "engineer",
    title: "Network Infrastructure Specialist",
    reportsToName: "Orchestrator",
    capabilities: "Network design, security, and performance optimization. Handles network architecture and design, network security and firewall management, load balancing, and network monitoring.",
    companyName: "InfraForge AI"
  },
  {
    name: "Storage",
    role: "engineer",
    title: "Storage Infrastructure Specialist",
    reportsToName: "Orchestrator",
    capabilities: "Data storage solutions and management for engineering data. Handles storage architecture and capacity planning, data backup and disaster recovery, file system management, and storage security.",
    companyName: "InfraForge AI"
  },
  {
    name: "Security",
    role: "engineer",
    title: "Infrastructure Security Specialist",
    reportsToName: "Orchestrator",
    capabilities: "Infrastructure security, compliance, and threat protection. Handles infrastructure security architecture and threat detection, incident response and automated remediation, compliance monitoring, and security auditing.",
    companyName: "InfraForge AI"
  },
  {
    name: "Monitoring",
    role: "engineer",
    title: "Infrastructure Monitoring Specialist",
    reportsToName: "Orchestrator",
    capabilities: "System monitoring, alerting, and performance analytics. Handles system monitoring and alerting setup, performance metrics collection and analysis, log aggregation and analysis, and capacity planning.",
    companyName: "InfraForge AI"
  },
  {
    name: "Automation",
    role: "devops",
    title: "Infrastructure Automation Specialist",
    reportsToName: "Orchestrator",
    capabilities: "Infrastructure automation, DevOps, and configuration management. Handles infrastructure as Code implementation, configuration management and automation, CI/CD pipeline development, and automated deployment.",
    companyName: "InfraForge AI"
  }
];

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

// API helper functions
async function createCompany(companyData) {
  const response = await fetch(`${CONFIG.paperclipApiBase}/companies`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(companyData)
  });

  if (!response.ok) {
    const error = await response.text();
    throw new Error(`Failed to create company ${companyData.name}: ${response.status} ${error}`);
  }

  return await response.json();
}

async function createAgent(companyId, agentData) {
  const response = await fetch(`${CONFIG.paperclipApiBase}/companies/${companyId}/agents`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(agentData)
  });

  if (!response.ok) {
    const error = await response.text();
    throw new Error(`Failed to create agent ${agentData.name}: ${response.status} ${error}`);
  }

  return await response.json();
}

// Main execution
async function main() {
  try {
    console.log('🚀 Starting Companies and Agents Data Population Script...\n');

    if (CONFIG.dryRun) {
      console.log('🔍 DRY RUN MODE - Analyzing data...\n');
      console.log(`📊 Would create ${COMPANIES.length} companies`);
      COMPANIES.forEach((company, index) => {
        console.log(`  ${index + 1}. ${company.name} (${company.expectedPrefix})`);
      });

      const totalAgents = DOMAINFORGE_AGENTS.length + INFRAFORGE_AGENTS.length;
      console.log(`🤖 Would create ${totalAgents} agents`);
      console.log(`   - DomainForge AI: ${DOMAINFORGE_AGENTS.length} agents`);
      console.log(`   - InfraForge AI: ${INFRAFORGE_AGENTS.length} agents`);

      return;
    }

    console.log(`📊 Creating ${COMPANIES.length} companies...\n`);

    const progress = new ProgressTracker(COMPANIES.length + DOMAINFORGE_AGENTS.length + INFRAFORGE_AGENTS.length);
    const companies = new Map();

    // Create companies
    for (const companyData of COMPANIES) {
      try {
        console.log(`\n🏢 Creating company: ${companyData.name}`);

        const company = await createCompany({
          name: companyData.name,
          description: companyData.description
        });

        console.log(`✅ Successfully created company: ${company.name} (${company.issuePrefix})`);
        companies.set(companyData.name, company);
        progress.increment(true);

        // Rate limiting
        await delay(CONFIG.delayMs);

      } catch (error) {
        console.error(`❌ Failed to create company ${companyData.name}:`, error.message);
        progress.increment(false);
      }
    }

    // Create agents for each company
    for (const [companyName, company] of companies) {
      const agents = companyName === "DomainForge AI" ? DOMAINFORGE_AGENTS : INFRAFORGE_AGENTS;
      const agentReportsToMap = new Map();

      console.log(`\n🤖 Creating ${agents.length} agents for ${companyName}...\n`);

      // First pass: create agents without reportsTo to establish the hierarchy
      for (const agentData of agents) {
        try {
          console.log(`👤 Creating agent: ${agentData.name} (${agentData.title})`);

          const agentPayload = {
            name: agentData.name,
            role: agentData.role,
            title: agentData.title,
            capabilities: agentData.capabilities
          };

          const agent = await createAgent(company.id, agentPayload);
          agentReportsToMap.set(agentData.name, agent.id);

          console.log(`✅ Successfully created agent: ${agent.name}`);
          progress.increment(true);

          // Rate limiting
          await delay(CONFIG.delayMs);

        } catch (error) {
          console.error(`❌ Failed to create agent ${agentData.name}:`, error.message);
          progress.increment(false);
        }
      }

      // Second pass: update reportsTo relationships
      for (const agentData of agents) {
        if (agentData.reportsToName) {
          try {
            const agentId = agentReportsToMap.get(agentData.name);
            const reportsToId = agentReportsToMap.get(agentData.reportsToName);

            if (agentId && reportsToId) {
              console.log(`🔗 Updating reportsTo for ${agentData.name} -> ${agentData.reportsToName}`);

              const updateResponse = await fetch(`${CONFIG.paperclipApiBase}/agents/${agentId}`, {
                method: 'PATCH',
                headers: {
                  'Content-Type': 'application/json',
                },
                body: JSON.stringify({ reportsTo: reportsToId })
              });

              if (!updateResponse.ok) {
                const error = await updateResponse.text();
                console.error(`⚠️  Failed to update reportsTo for ${agentData.name}: ${updateResponse.status} ${error}`);
              } else {
                console.log(`✅ Successfully updated reportsTo for ${agentData.name}`);
              }
            }
          } catch (error) {
            console.error(`⚠️  Error updating reportsTo for ${agentData.name}:`, error.message);
          }

          await delay(CONFIG.delayMs);
        }
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
      console.log('\n🎉 Companies and agents data population completed successfully!');
      console.log('🏢 Companies created:');
      for (const [name, company] of companies) {
        console.log(`   - ${name} (${company.issuePrefix}: ${company.id})`);
      }
      console.log(`🤖 Total agents created: ${DOMAINFORGE_AGENTS.length + INFRAFORGE_AGENTS.length}`);
      console.log(`   - DomainForge AI: ${DOMAINFORGE_AGENTS.length} agents`);
      console.log(`   - InfraForge AI: ${INFRAFORGE_AGENTS.length} agents`);
    } else {
      console.log('\n⚠️  Companies and agents data population completed with errors.');
      console.log('🔍 Check the logs above for details on failed operations.');
    }

  } catch (error) {
    console.error('\n💥 FATAL ERROR during companies and agents population:', error);
    process.exit(1);
  }
}

// Run the script
main().catch(console.error);