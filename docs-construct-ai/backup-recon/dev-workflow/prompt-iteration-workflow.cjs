#!/usr/bin/env node

/**
 * Prompt Iteration Workflow Script
 * Demonstrates rapid prompt development and debugging workflow
 * Based on 0000_PROMPT_MANAGEMENT_PROCEDURE.md development enhancements
 */

const fs = require('fs');
const path = require('path');

class PromptIterationWorkflow {
  constructor() {
    this.devPromptsDir = path.join(process.cwd(), 'docs', 'dev-prompts');
    this.ensureDevPromptsDir();
    console.log('🎯 [PromptIterationWorkflow] Initialized development workflow');
    console.log(`📁 Dev prompts directory: ${this.devPromptsDir}`);
  }

  ensureDevPromptsDir() {
    if (!fs.existsSync(this.devPromptsDir)) {
      fs.mkdirSync(this.devPromptsDir, { recursive: true });
      console.log('📁 Created dev-prompts directory');
    }
  }

  /**
   * Create a development prompt override for rapid iteration
   */
  createDevOverride(promptKey, content, options = {}) {
    try {
      console.log(`🔧 [Workflow] Creating dev override for: ${promptKey}`);

      // Add development metadata
      const devMetadata = {
        dev_mode: true,
        created: new Date().toISOString(),
        author: options.author || 'developer',
        purpose: options.purpose || 'rapid_iteration',
        iteration: options.iteration || 1,
        notes: options.notes || 'Rapid development iteration'
      };

      const metadataBlock = `---\n${Object.entries(devMetadata)
        .map(([key, value]) => `${key}: ${value}`)
        .join('\n')}\n---\n\n`;

      const fullContent = metadataBlock + content;
      const filePath = path.join(this.devPromptsDir, `${promptKey}.md`);

      fs.writeFileSync(filePath, fullContent, 'utf8');

      console.log(`💾 [Workflow] Created override: ${filePath}`);
      console.log(`📏 [Workflow] Content length: ${fullContent.length} characters`);

      return {
        success: true,
        filePath,
        promptKey,
        metadata: devMetadata
      };
    } catch (error) {
      console.error(`❌ [Workflow] Failed to create override:`, error.message);
      return { success: false, error: error.message };
    }
  }

  /**
   * Show current development overrides
   */
  listDevOverrides() {
    try {
      if (!fs.existsSync(this.devPromptsDir)) {
        console.log('📁 No dev-prompts directory found');
        return [];
      }

      const files = fs.readdirSync(this.devPromptsDir)
        .filter(file => file.endsWith('.md'))
        .map(file => {
          const filePath = path.join(this.devPromptsDir, file);
          const stats = fs.statSync(filePath);
          const promptKey = file.replace('.md', '');

          // Parse metadata
          const content = fs.readFileSync(filePath, 'utf8');
          const metadata = this.parseMetadata(content);

          return {
            promptKey,
            filePath,
            size: stats.size,
            modified: stats.mtime.toISOString(),
            metadata
          };
        });

      console.log(`📋 [Workflow] Found ${files.length} development overrides:`);
      files.forEach(file => {
        console.log(`   🔧 ${file.promptKey} (${file.size} bytes, ${file.metadata?.purpose || 'unknown'})`);
      });

      return files;
    } catch (error) {
      console.error(`❌ [Workflow] Failed to list overrides:`, error.message);
      return [];
    }
  }

  /**
   * Compare local override with what would be in database
   */
  async compareWithDatabase(promptKey) {
    try {
      console.log(`⚖️ [Workflow] Comparing ${promptKey} with database version`);

      const localPath = path.join(this.devPromptsDir, `${promptKey}.md`);
      if (!fs.existsSync(localPath)) {
        console.log(`❌ [Workflow] No local override found for ${promptKey}`);
        return null;
      }

      const localContent = fs.readFileSync(localPath, 'utf8');
      const cleanLocal = this.removeMetadata(localContent);

      // In a real implementation, this would query the database
      // For demo purposes, we'll simulate database content
      const dbContent = await this.simulateDatabaseLookup(promptKey);

      if (!dbContent) {
        console.log(`⚠️ [Workflow] No database version found for ${promptKey}`);
        return {
          promptKey,
          localExists: true,
          dbExists: false,
          comparison: 'local_only'
        };
      }

      const differences = this.calculateDifferences(cleanLocal, dbContent);

      console.log(`📊 [Workflow] Comparison results:`);
      console.log(`   Local: ${cleanLocal.length} characters`);
      console.log(`   Database: ${dbContent.length} characters`);
      console.log(`   Differences: ${differences.length}`);

      if (differences.length > 0) {
        console.log(`   🔄 Changes detected:`);
        differences.slice(0, 5).forEach(diff => {
          console.log(`      Line ${diff.line}: ${diff.type} (${diff.local?.substring(0, 50) || 'empty'}...)`);
        });
        if (differences.length > 5) {
          console.log(`      ... and ${differences.length - 5} more changes`);
        }
      }

      return {
        promptKey,
        localExists: true,
        dbExists: true,
        differences: differences.length,
        canSync: differences.length > 0,
        localLength: cleanLocal.length,
        dbLength: dbContent.length
      };

    } catch (error) {
      console.error(`❌ [Workflow] Comparison failed:`, error.message);
      return null;
    }
  }

  /**
   * Sync local override to database (simulation)
   */
  async syncToDatabase(promptKey, options = {}) {
    try {
      console.log(`⬆️ [Workflow] Syncing ${promptKey} to database...`);

      const comparison = await this.compareWithDatabase(promptKey);
      if (!comparison || !comparison.canSync) {
        console.log(`⚠️ [Workflow] Nothing to sync for ${promptKey}`);
        return { success: false, reason: 'no_changes' };
      }

      // In real implementation, this would update the database
      const localPath = path.join(this.devPromptsDir, `${promptKey}.md`);
      const content = fs.readFileSync(localPath, 'utf8');
      const cleanContent = this.removeMetadata(content);

      const newVersion = options.version || this.generateVersion();

      console.log(`✅ [Workflow] Would sync ${promptKey} v${newVersion} to database`);
      console.log(`📝 [Workflow] Content: ${cleanContent.substring(0, 100)}...`);

      // Simulate database update
      await new Promise(resolve => setTimeout(resolve, 1000));

      if (options.deleteLocalAfterSync) {
        fs.unlinkSync(localPath);
        console.log(`🗑️ [Workflow] Removed local override after sync`);
      }

      return {
        success: true,
        promptKey,
        version: newVersion,
        synced: true
      };

    } catch (error) {
      console.error(`❌ [Workflow] Sync failed:`, error.message);
      return { success: false, error: error.message };
    }
  }

  /**
   * Clean up development overrides
   */
  cleanup(confirm = false) {
    try {
      if (!confirm) {
        console.log(`⚠️ [Workflow] Cleanup requires confirmation. Use --confirm flag.`);
        console.log(`📋 [Workflow] This would delete all files in: ${this.devPromptsDir}`);
        this.listDevOverrides();
        return;
      }

      if (!fs.existsSync(this.devPromptsDir)) {
        console.log(`📁 [Workflow] No dev-prompts directory to clean`);
        return;
      }

      const files = fs.readdirSync(this.devPromptsDir);
      let deleted = 0;

      files.forEach(file => {
        if (file.endsWith('.md')) {
          fs.unlinkSync(path.join(this.devPromptsDir, file));
          deleted++;
        }
      });

      console.log(`🧹 [Workflow] Cleaned up ${deleted} development override files`);

    } catch (error) {
      console.error(`❌ [Workflow] Cleanup failed:`, error.message);
    }
  }

  /**
   * Generate sample prompt for testing
   */
  generateSamplePrompt(type = 'basic') {
    const samples = {
      basic: `# Basic Agent Prompt

You are a helpful AI assistant.

## Instructions
Provide clear and accurate responses to user queries.

## Guidelines
- Be helpful and accurate
- Keep responses concise
- Use clear language

## Output Format
Provide direct answers with supporting information when needed.`,

      correspondence: `# Contract Correspondence Analysis Agent

You are a specialized Contract Correspondence Analysis Agent with expertise in analyzing contractual correspondence and extracting key information for decision-making.

## Context & Guidelines
You will receive correspondence related to contracts, agreements, and legal documents. Your task is to analyze the content, extract relevant information, and provide structured insights for further processing.

## Task Instructions
1. Read and analyze the provided correspondence
2. Extract key information including parties, dates, amounts, and requirements
3. Identify the type and purpose of the correspondence
4. Assess urgency and priority level
5. Provide clear, actionable insights

## Output Format
Return a JSON object with the following structure:
{
  "analysis": {
    "type": "string",
    "purpose": "string",
    "urgency": "high|medium|low"
  },
  "confidence": "number between 0-1"
}

## Quality Standards
- Accuracy: Extract information with high precision
- Completeness: Capture all relevant details
- Clarity: Provide clear, unambiguous analysis`,
    };

    return samples[type] || samples.basic;
  }

  /**
   * Demonstrate complete workflow
   */
  async demonstrateWorkflow() {
    console.log('🚀 [Workflow] Demonstrating complete prompt iteration workflow...\n');

    // Step 1: Create initial override
    console.log('Step 1: Creating initial development override');
    const promptKey = 'demo_correspondence_analysis';
    const initialPrompt = this.generateSamplePrompt('correspondence');

    this.createDevOverride(promptKey, initialPrompt, {
      purpose: 'initial_development',
      iteration: 1,
      notes: 'Initial version for workflow demonstration'
    });

    // Step 2: List current overrides
    console.log('\nStep 2: Listing current development overrides');
    this.listDevOverrides();

    // Step 3: Simulate comparison (would compare with DB in real scenario)
    console.log('\nStep 3: Comparing with database version');
    await this.compareWithDatabase(promptKey);

    // Step 4: Create improved version
    console.log('\nStep 4: Creating improved version');
    const improvedPrompt = initialPrompt + '\n\n## Additional Guidelines\n- Always include confidence scores\n- Flag any ambiguous information\n- Suggest follow-up actions';

    this.createDevOverride(promptKey, improvedPrompt, {
      purpose: 'improved_version',
      iteration: 2,
      notes: 'Added confidence scoring and follow-up suggestions'
    });

    // Step 5: Compare again
    console.log('\nStep 5: Comparing improved version');
    await this.compareWithDatabase(promptKey);

    // Step 6: Sync to database (simulation)
    console.log('\nStep 6: Syncing to database');
    await this.syncToDatabase(promptKey, {
      version: '1.1.0',
      deleteLocalAfterSync: false
    });

    console.log('\n🎉 [Workflow] Demonstration complete!');
    console.log('💡 [Workflow] In real development:');
    console.log('   - Edit prompts in your IDE with hot reload');
    console.log('   - Test changes immediately in the application');
    console.log('   - Sync approved changes to database');
    console.log('   - Repeat iteration cycle as needed');
  }

  // Helper methods
  parseMetadata(content) {
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

  removeMetadata(content) {
    return content.replace(/^---\n(?:[\s\S]*?)\n---\n\n/, '');
  }

  calculateDifferences(text1, text2) {
    const lines1 = text1.split('\n');
    const lines2 = text2.split('\n');
    const differences = [];
    const maxLines = Math.max(lines1.length, lines2.length);

    for (let i = 0; i < maxLines; i++) {
      if (lines1[i] !== lines2[i]) {
        differences.push({
          line: i + 1,
          local: lines1[i] || '',
          database: lines2[i] || '',
          type: !lines1[i] ? 'addition' : !lines2[i] ? 'deletion' : 'modification'
        });
      }
    }

    return differences;
  }

  async simulateDatabaseLookup(promptKey) {
    // Simulate database delay
    await new Promise(resolve => setTimeout(resolve, 200));

    // Return different content for demonstration
    if (promptKey === 'demo_correspondence_analysis') {
      return `# Contract Correspondence Analysis Agent

You are a specialized Contract Correspondence Analysis Agent.

## Instructions
1. Analyze correspondence
2. Extract key information
3. Provide insights

## Output Format
JSON structure with analysis results.`;
    }

    return null; // Simulate not found
  }

  generateVersion() {
    const now = new Date();
    return `1.${now.getMonth() + 1}.${now.getDate()}`;
  }
}

// CLI Interface
function main() {
  const args = process.argv.slice(2);
  const workflow = new PromptIterationWorkflow();

  if (args.length === 0) {
    console.log('Prompt Iteration Workflow Tool');
    console.log('Usage: node prompt-iteration-workflow.js <command> [options]');
    console.log('');
    console.log('Commands:');
    console.log('  demo              - Run complete workflow demonstration');
    console.log('  list              - List current development overrides');
    console.log('  create <key>      - Create a new development override');
    console.log('  compare <key>     - Compare local override with database');
    console.log('  sync <key>        - Sync local override to database');
    console.log('  cleanup [--confirm] - Clean up all development overrides');
    console.log('');
    console.log('Examples:');
    console.log('  node prompt-iteration-workflow.js demo');
    console.log('  node prompt-iteration-workflow.js create agent_test');
    console.log('  node prompt-iteration-workflow.js compare agent_correspondence_01');
    return;
  }

  const command = args[0];

  switch (command) {
    case 'demo':
      workflow.demonstrateWorkflow().catch(console.error);
      break;

    case 'list':
      workflow.listDevOverrides();
      break;

    case 'create':
      if (!args[1]) {
        console.error('❌ Please specify a prompt key');
        process.exit(1);
      }
      const samplePrompt = workflow.generateSamplePrompt('correspondence');
      const result = workflow.createDevOverride(args[1], samplePrompt, {
        purpose: 'cli_created',
        notes: 'Created via CLI tool'
      });
      if (result.success) {
        console.log(`✅ Created development override for: ${args[1]}`);
      }
      break;

    case 'compare':
      if (!args[1]) {
        console.error('❌ Please specify a prompt key');
        process.exit(1);
      }
      workflow.compareWithDatabase(args[1]).catch(console.error);
      break;

    case 'sync':
      if (!args[1]) {
        console.error('❌ Please specify a prompt key');
        process.exit(1);
      }
      workflow.syncToDatabase(args[1], { deleteLocalAfterSync: false }).catch(console.error);
      break;

    case 'cleanup':
      const confirm = args.includes('--confirm');
      workflow.cleanup(confirm);
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

module.exports = PromptIterationWorkflow;
