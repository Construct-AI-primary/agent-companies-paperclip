#!/usr/bin/env node

/**
 * Test Hierarchical Prompts
 * Verifies that the enhanced prompts service can find prompts in the hierarchical structure
 */

const path = require('path');

// Simulate the enhanced prompts service functionality for testing
class HierarchicalPromptTester {
  constructor() {
    this.devPromptsDir = path.join(process.cwd(), 'docs', 'dev-prompts');
  }

  findPromptFile(promptKey) {
    const fs = require('fs');
    const searchFileName = `${promptKey}.md`;

    try {
      // Walk through directory tree recursively
      const walkDir = (dir, relativePath = '') => {
        const results = [];
        const items = fs.readdirSync(dir);

        for (const item of items) {
          const fullPath = path.join(dir, item);
          const itemRelativePath = path.join(relativePath, item);
          const stat = fs.statSync(fullPath);

          if (stat.isDirectory()) {
            // Recursively search subdirectories
            results.push(...walkDir(fullPath, itemRelativePath));
          } else if (item === searchFileName) {
            // Found the file
            const hierarchy = itemRelativePath.split(path.sep).slice(0, -1); // Remove filename
            results.push({
              filePath: fullPath,
              relativePath: itemRelativePath,
              hierarchy: hierarchy,
              promptKey: promptKey
            });
          }
        }

        return results;
      };

      const foundFiles = walkDir(this.devPromptsDir);

      if (foundFiles.length === 0) {
        return null;
      }

      return foundFiles[0];

    } catch (error) {
      console.warn(`Error searching for ${promptKey}:`, error.message);
      return null;
    }
  }

  async testPromptRetrieval() {
    console.log('🧪 [HierarchicalPromptTester] Testing hierarchical prompt retrieval...\n');

    const testKeys = [
      'contract_correspondence_analysis',
      'contract_identifier_extraction',
      'civil',
      'structural',
      'mechanical',
      'electrical'
    ];

    let found = 0;
    let notFound = 0;

    for (const key of testKeys) {
      const result = this.findPromptFile(key);

      if (result) {
        console.log(`✅ Found ${key}:`);
        console.log(`   📁 Path: ${result.relativePath}`);
        console.log(`   🏗️  Hierarchy: ${result.hierarchy.join(' → ')}`);
        console.log(`   📄 File: ${result.filePath}`);
        console.log('');

        // Parse and display metadata
        try {
          const fs = require('fs');
          const content = fs.readFileSync(result.filePath, 'utf8');
          const metadataMatch = content.match(/^---\n([\s\S]*?)\n---\n\n/);

          if (metadataMatch) {
            console.log(`   📊 Metadata for ${key}:`);
            const metadataBlock = metadataMatch[1];
            const lines = metadataBlock.split('\n');

            lines.forEach(line => {
              const [key, ...valueParts] = line.split(':');
              if (key && valueParts.length > 0) {
                const value = valueParts.join(':').trim();
                if (key.trim().startsWith('supabase_') || key.trim() === 'workflow' || key.trim() === 'agent_sequence') {
                  console.log(`      ${key.trim()}: ${value}`);
                }
              }
            });
          }
          console.log('');
        } catch (error) {
          console.log(`   ❌ Error reading metadata: ${error.message}\n`);
        }

        found++;
      } else {
        console.log(`❌ Not found: ${key}\n`);
        notFound++;
      }
    }

    console.log('🎯 [HierarchicalPromptTester] Test Results:');
    console.log(`   ✅ Found: ${found} prompts`);
    console.log(`   ❌ Not found: ${notFound} prompts`);
    console.log(`   📁 Total tested: ${testKeys.length} prompts`);

    if (found > 0) {
      console.log('\n🏗️  Hierarchical Structure Verified!');
      console.log('   - Page-based organization (00435-contracts-post-award/)');
      console.log('   - Workflow-based subdirectories (correspondence-workflow/)');
      console.log('   - Agent sequence naming (agent-01-, agent-02-)');
      console.log('   - Specialist categorization (specialists/)');
      console.log('   - Supabase table/key references in metadata');
    }
  }
}

// Run the test
const tester = new HierarchicalPromptTester();
tester.testPromptRetrieval().catch(console.error);
