#!/usr/bin/env node

/**
 * Update Prompt Metadata Script
 * Adds Supabase table references and hierarchical metadata to all prompts
 */

const fs = require('fs');
const path = require('path');

class PromptMetadataUpdater {
  constructor() {
    this.devPromptsDir = path.join(process.cwd(), 'docs', 'dev-prompts');
  }

  async updateAllPrompts() {
    console.log('🔄 [MetadataUpdater] Updating all prompt metadata...\n');

    const promptMappings = {
      // Correspondence Workflow Agents
      '00435-contracts-post-award/correspondence-workflow/agent-01-document-analysis.md': {
        supabase_key: 'contract_correspondence_analysis',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '01',
        category: 'contracts',
        agent_type: 'correspondence'
      },
      '00435-contracts-post-award/correspondence-workflow/agent-02-information-extraction.md': {
        supabase_key: 'contract_identifier_extraction',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '02',
        category: 'contracts',
        agent_type: 'correspondence'
      },

      // Discipline Specialists
      '00435-contracts-post-award/correspondence-workflow/specialists/civil.md': {
        supabase_key: 'civil',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      },
      '00435-contracts-post-award/correspondence-workflow/specialists/structural.md': {
        supabase_key: 'structural',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      },
      '00435-contracts-post-award/correspondence-workflow/specialists/mechanical.md': {
        supabase_key: 'mechanical',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      },
      '00435-contracts-post-award/correspondence-workflow/specialists/electrical.md': {
        supabase_key: 'electrical',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      },
      '00435-contracts-post-award/correspondence-workflow/specialists/process.md': {
        supabase_key: 'process',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      },
      '00435-contracts-post-award/correspondence-workflow/specialists/instrumentation.md': {
        supabase_key: 'instrumentation',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      },
      '00435-contracts-post-award/correspondence-workflow/specialists/geotechnical.md': {
        supabase_key: 'geotechnical',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      },
      '00435-contracts-post-award/correspondence-workflow/specialists/environmental.md': {
        supabase_key: 'environmental',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      },
      '00435-contracts-post-award/correspondence-workflow/specialists/safety.md': {
        supabase_key: 'safety',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      },
      '00435-contracts-post-award/correspondence-workflow/specialists/architectural.md': {
        supabase_key: 'architectural',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      },
      '00435-contracts-post-award/correspondence-workflow/specialists/logistics.md': {
        supabase_key: 'logistics',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      },
      '00435-contracts-post-award/correspondence-workflow/specialists/construction.md': {
        supabase_key: 'construction',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      },
      '00435-contracts-post-award/correspondence-workflow/specialists/quality_control.md': {
        supabase_key: 'quality_control',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      },
      '00435-contracts-post-award/correspondence-workflow/specialists/quantity_surveying.md': {
        supabase_key: 'quantity_surveying',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      },
      '00435-contracts-post-award/correspondence-workflow/specialists/scheduling.md': {
        supabase_key: 'scheduling',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      },
      '00435-contracts-post-award/correspondence-workflow/specialists/inspection.md': {
        supabase_key: 'inspection',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      },
      '00435-contracts-post-award/correspondence-workflow/specialists/health.md': {
        supabase_key: 'health',
        workflow: '00435-correspondence-orchestration',
        agent_sequence: '04',
        category: 'contracts',
        agent_type: 'specialist'
      }
    };

    let updated = 0;
    let skipped = 0;

    for (const [relativePath, metadata] of Object.entries(promptMappings)) {
      const fullPath = path.join(this.devPromptsDir, relativePath);

      if (!fs.existsSync(fullPath)) {
        console.log(`⏭️  Skipping ${relativePath} (file not found)`);
        skipped++;
        continue;
      }

      try {
        const content = fs.readFileSync(fullPath, 'utf8');

        // Check if already has Supabase metadata
        if (content.includes('supabase_table:')) {
          console.log(`⏭️  Skipping ${relativePath} (already has metadata)`);
          skipped++;
          continue;
        }

        // Parse existing metadata
        const existingMetadata = this.parseExistingMetadata(content);

        // Create updated metadata block
        const updatedMetadata = {
          ...existingMetadata,
          supabase_table: 'prompts',
          supabase_key: metadata.supabase_key,
          workflow: metadata.workflow,
          agent_sequence: metadata.agent_sequence,
          page_id: metadata.workflow.split('-')[0],
          category: metadata.category,
          agent_type: metadata.agent_type
        };

        // Replace metadata block
        const updatedContent = this.updateMetadataBlock(content, updatedMetadata);

        // Write back to file
        fs.writeFileSync(fullPath, updatedContent, 'utf8');

        console.log(`✅ Updated ${relativePath} (${metadata.supabase_key})`);
        updated++;

      } catch (error) {
        console.error(`❌ Failed to update ${relativePath}:`, error.message);
        skipped++;
      }
    }

    console.log(`\n🎉 Metadata update complete!`);
    console.log(`📄 Updated: ${updated} prompts`);
    console.log(`⏭️  Skipped: ${skipped} prompts`);
  }

  parseExistingMetadata(content) {
    const metadata = {};

    const metadataMatch = content.match(/^---\n([\s\S]*?)\n---\n\n/);
    if (metadataMatch) {
      const metadataBlock = metadataMatch[1];
      const lines = metadataBlock.split('\n');

      lines.forEach(line => {
        const [key, ...valueParts] = line.split(':');
        if (key && valueParts.length > 0) {
          metadata[key.trim()] = valueParts.join(':').trim();
        }
      });
    }

    return metadata;
  }

  updateMetadataBlock(content, newMetadata) {
    // Remove existing metadata block
    const contentWithoutMetadata = content.replace(/^---\n[\s\S]*?\n---\n\n/, '');

    // Create new metadata block
    const metadataLines = Object.entries(newMetadata)
      .map(([key, value]) => `${key}: ${value}`)
      .join('\n');

    const newMetadataBlock = `---\n${metadataLines}\n---\n\n`;

    return newMetadataBlock + contentWithoutMetadata;
  }
}

// CLI Interface
function main() {
  const args = process.argv.slice(2);
  const updater = new PromptMetadataUpdater();

  if (args.length === 0) {
    console.log('Prompt Metadata Updater');
    console.log('Usage: node update-prompt-metadata.cjs <command>');
    console.log('');
    console.log('Commands:');
    console.log('  update    - Update all prompt metadata with Supabase references');
    console.log('');
    console.log('This will add Supabase table and key references to all prompts in the hierarchical structure.');
    return;
  }

  const command = args[0];

  switch (command) {
    case 'update':
      updater.updateAllPrompts().catch(console.error);
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

module.exports = PromptMetadataUpdater;
