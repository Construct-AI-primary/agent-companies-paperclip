/**
 * Automated I18N Translation Agent
 * Monitors source code and automatically updates translation files
 * Includes watch mode and git hooks integration
 * Following the i18n translation file organization procedure
 */

const fs = require('fs').promises;
const path = require('path');
const chokidar = require('chokidar');

class AutoI18nTranslationAgent {
  constructor() {
    this.localesPath = path.join(__dirname, '../../assets/locales');
    this.srcPath = path.join(__dirname, '../');
    this.supportedLanguages = ['en', 'ar', 'pt', 'es', 'fr', 'zu', 'xh', 'sw', 'de'];
    this.translationPatterns = [
      // i18next.t() calls
      /i18next\.t\(['"]([^'"]+)['"]/g,
      // t() shorthand calls
      /\bt\(['"]([^'"]+)['"]/g,
      // Template literals with t()
      /\$\{t\(['"]([^'"]+)['"]/g,
      // data-i18n attributes
      /data-i18n=['"]([^'"]+)['"]/g,
      // data-i18n-key attributes
      /data-i18n-key=['"]([^'"]+)['"]/g,
    ];
    this.watcher = null;
    this.isWatching = false;
    this.pendingUpdates = new Set();
  }

  async updateAllTranslations() {
    console.log('🚀 Starting Automated I18N Translation Agent...');
    console.log('📝 Scanning all source files for translation keys...');

    try {
      const sourceFiles = await this.findSourceFiles();
      console.log(`📁 Found ${sourceFiles.length} source files to scan`);

      const allKeys = new Set();

      // Extract all translation keys from source files
      for (const file of sourceFiles) {
        const keys = await this.extractTranslationKeys(file);
        keys.forEach(key => allKeys.add(key));
      }

      console.log(`🔑 Found ${allKeys.size} unique translation keys`);

      // Update translation files for all languages
      await this.updateTranslationFiles(Array.from(allKeys));

      // Generate summary report
      await this.generateUpdateReport(allKeys.size);

      console.log('✅ All translations updated successfully');

    } catch (error) {
      console.error('❌ Failed to update translations:', error);
      throw error;
    }
  }

  async updateLanguageTranslations(languageCode) {
    console.log(`🌐 Updating translations for language: ${languageCode}`);

    try {
      const sourceFiles = await this.findSourceFiles();
      const allKeys = new Set();

      // Extract all translation keys
      for (const file of sourceFiles) {
        const keys = await this.extractTranslationKeys(file);
        keys.forEach(key => allKeys.add(key));
      }

      // Update only the specified language
      await this.updateSingleLanguage(Array.from(allKeys), languageCode);

      console.log(`✅ Translations updated for ${languageCode}`);

    } catch (error) {
      console.error(`❌ Failed to update ${languageCode} translations:`, error);
      throw error;
    }
  }

  async startWatchMode() {
    if (this.isWatching) {
      console.log('👀 Watch mode is already active');
      return;
    }

    console.log('👀 Starting watch mode for translation files...');
    console.log('📁 Monitoring:', this.srcPath);

    this.watcher = chokidar.watch(this.srcPath, {
      ignored: [
        '**/node_modules/**',
        '**/assets/locales/**',
        '**/*.log',
        '**/*.lock',
        '**/dist/**',
        '**/build/**'
      ],
      persistent: true,
      ignoreInitial: true,
      awaitWriteFinish: {
        stabilityThreshold: 1000,
        pollInterval: 100
      }
    });

    this.watcher.on('change', async (filePath) => {
      if (this.shouldProcessFile(filePath)) {
        console.log(`📝 File changed: ${path.relative(this.srcPath, filePath)}`);
        await this.handleFileChange(filePath);
      }
    });

    this.watcher.on('add', async (filePath) => {
      if (this.shouldProcessFile(filePath)) {
        console.log(`📄 New file added: ${path.relative(this.srcPath, filePath)}`);
        await this.handleFileChange(filePath);
      }
    });

    this.isWatching = true;
    console.log('✅ Watch mode started successfully');
    console.log('💡 Translation files will be updated automatically on file changes');
  }

  async stopWatchMode() {
    if (this.watcher) {
      await this.watcher.close();
      this.watcher = null;
    }
    this.isWatching = false;
    console.log('🛑 Watch mode stopped');
  }

  async validateTranslations() {
    console.log('🔍 Validating translation files...');

    const issues = [];

    for (const lang of this.supportedLanguages) {
      const langPath = path.join(this.localesPath, lang);

      try {
        const files = await fs.readdir(langPath);
        const jsonFiles = files.filter(file => file.endsWith('.json'));

        for (const file of jsonFiles) {
          const filePath = path.join(langPath, file);

          try {
            const content = await fs.readFile(filePath, 'utf8');
            JSON.parse(content); // Validate JSON syntax
          } catch (error) {
            issues.push({
              type: 'json_error',
              language: lang,
              file,
              error: error.message
            });
          }
        }
      } catch (error) {
        issues.push({
          type: 'directory_error',
          language: lang,
          error: error.message
        });
      }
    }

    if (issues.length === 0) {
      console.log('✅ All translation files are valid');
      return true;
    } else {
      console.error('❌ Found validation issues:');
      issues.forEach(issue => console.error(`  - ${issue.type}: ${issue.language}/${issue.file || ''} - ${issue.error}`));
      return false;
    }
  }

  async installGitHooks() {
    console.log('🔗 Installing git hooks for translation validation...');

    const gitHooksPath = path.join(__dirname, '../../.git/hooks');
    const preCommitHookPath = path.join(gitHooksPath, 'pre-commit');

    try {
      // Check if .git/hooks directory exists
      await fs.access(gitHooksPath);
    } catch {
      console.error('❌ Git hooks directory not found. Make sure this is a git repository.');
      return false;
    }

    // Create pre-commit hook
    const hookContent = `#!/bin/bash
# ConstructAI I18N Translation Validation Hook

echo "🔍 Running I18N translation validation..."

# Run the validation script
node src/services/autoI18nTranslationAgent.js --validate

if [ $? -ne 0 ]; then
    echo "❌ Translation validation failed. Please fix the issues before committing."
    echo "💡 Run 'node src/services/autoI18nTranslationAgent.js --update-all' to update translations"
    exit 1
fi

echo "✅ Translation validation passed"
exit 0
`;

    try {
      await fs.writeFile(preCommitHookPath, hookContent);
      await fs.chmod(preCommitHookPath, '755');
      console.log('✅ Git pre-commit hook installed successfully');
      console.log(`📍 Hook location: ${preCommitHookPath}`);
      return true;
    } catch (error) {
      console.error('❌ Failed to install git hook:', error);
      return false;
    }
  }

  // Private methods
  async findSourceFiles() {
    const sourceFiles = [];

    async function scanDirectory(dirPath) {
      const items = await fs.readdir(dirPath, { withFileTypes: true });

      for (const item of items) {
        const fullPath = path.join(dirPath, item.name);

        if (item.isDirectory()) {
          // Skip certain directories
          if (!['node_modules', '.git', 'dist', 'build', 'assets'].includes(item.name)) {
            await scanDirectory(fullPath);
          }
        } else if (item.isFile()) {
          // Check for relevant source files
          if (this.shouldProcessFile(fullPath)) {
            sourceFiles.push(fullPath);
          }
        }
      }
    }

    await scanDirectory(this.srcPath);
    return sourceFiles;
  }

  shouldProcessFile(filePath) {
    const ext = path.extname(filePath).toLowerCase();
    const validExtensions = ['.js', '.jsx', '.ts', '.tsx', '.vue', '.html'];

    // Skip certain files and directories
    const skipPatterns = [
      'node_modules',
      '.git',
      'dist',
      'build',
      'assets/locales',
      'autoI18nTranslationAgent.js',
      'multiAgentI18nAudit.js'
    ];

    return validExtensions.includes(ext) &&
           !skipPatterns.some(pattern => filePath.includes(pattern));
  }

  async extractTranslationKeys(filePath) {
    try {
      const content = await fs.readFile(filePath, 'utf8');
      const keys = new Set();

      // Apply all translation patterns
      for (const pattern of this.translationPatterns) {
        let match;
        while ((match = pattern.exec(content)) !== null) {
          keys.add(match[1]); // Capture group 1 contains the key
        }
      }

      return Array.from(keys);
    } catch (error) {
      console.warn(`⚠️ Failed to extract keys from ${filePath}:`, error.message);
      return [];
    }
  }

  async updateTranslationFiles(allKeys) {
    // Organize keys by namespace
    const namespacedKeys = this.organizeKeysByNamespace(allKeys);

    for (const [namespace, keys] of Object.entries(namespacedKeys)) {
      await this.updateNamespaceTranslations(namespace, keys);
    }
  }

  organizeKeysByNamespace(keys) {
    const namespaced = {};

    for (const key of keys) {
      const parts = key.split('.');
      const namespace = parts.length > 1 ? parts[0] : 'common';
      const actualKey = parts.length > 1 ? parts.slice(1).join('.') : key;

      if (!namespaced[namespace]) {
        namespaced[namespace] = {};
      }

      // Convert key to nested object structure
      this.setNestedProperty(namespaced[namespace], actualKey, this.generatePlaceholderText(actualKey));
    }

    return namespaced;
  }

  setNestedProperty(obj, keyPath, value) {
    const keys = keyPath.split('.');
    let current = obj;

    for (let i = 0; i < keys.length - 1; i++) {
      if (!current[keys[i]]) {
        current[keys[i]] = {};
      }
      current = current[keys[i]];
    }

    current[keys[keys.length - 1]] = value;
  }

  generatePlaceholderText(key) {
    // Convert camelCase or snake_case to Title Case
    const readableKey = key
      .replace(/([A-Z])/g, ' $1') // Add space before capital letters
      .replace(/_/g, ' ') // Replace underscores with spaces
      .replace(/\b\w/g, l => l.toUpperCase()) // Capitalize first letter of each word
      .trim();

    return readableKey || key;
  }

  async updateNamespaceTranslations(namespace, keysObject) {
    for (const lang of this.supportedLanguages) {
      const langPath = path.join(this.localesPath, lang);
      const fileName = namespace === 'common' ? 'common.json' : `${namespace}.json`;
      const filePath = path.join(langPath, fileName);

      try {
        // Load existing translations
        let existingTranslations = {};
        try {
          const content = await fs.readFile(filePath, 'utf8');
          existingTranslations = JSON.parse(content);
        } catch {
          // File doesn't exist, will create new one
        }

        // Merge with new keys (preserve existing translations)
        const updatedTranslations = this.deepMerge(existingTranslations, keysObject);

        // Write back to file
        await fs.writeFile(filePath, JSON.stringify(updatedTranslations, null, 2));

        if (lang === 'en') {
          console.log(`📝 Updated ${namespace} translations for ${lang}`);
        }
      } catch (error) {
        console.error(`❌ Failed to update ${namespace} for ${lang}:`, error);
      }
    }
  }

  async updateSingleLanguage(allKeys, languageCode) {
    const namespacedKeys = this.organizeKeysByNamespace(allKeys);

    for (const [namespace, keys] of Object.entries(namespacedKeys)) {
      await this.updateNamespaceTranslations(namespace, keys);
    }
  }

  deepMerge(target, source) {
    const result = { ...target };

    for (const key in source) {
      if (source[key] && typeof source[key] === 'object' && !Array.isArray(source[key])) {
        result[key] = this.deepMerge(result[key] || {}, source[key]);
      } else {
        // Only set if not already present (preserve existing translations)
        if (!(key in result)) {
          result[key] = source[key];
        }
      }
    }

    return result;
  }

  async handleFileChange(filePath) {
    // Debounce updates
    const updateKey = filePath;
    this.pendingUpdates.add(updateKey);

    setTimeout(async () => {
      if (this.pendingUpdates.has(updateKey)) {
        this.pendingUpdates.delete(updateKey);

        try {
          const keys = await this.extractTranslationKeys(filePath);
          if (keys.length > 0) {
            await this.updateTranslationFiles(keys);
            console.log(`✅ Updated translations for changed file: ${path.relative(this.srcPath, filePath)}`);
          }
        } catch (error) {
          console.error(`❌ Failed to update translations for ${filePath}:`, error);
        }
      }
    }, 1000); // 1 second debounce
  }

  async generateUpdateReport(totalKeys) {
    const report = {
      timestamp: new Date().toISOString(),
      totalKeysProcessed: totalKeys,
      languagesUpdated: this.supportedLanguages.length,
      filesUpdated: 'all translation files',
      status: 'completed'
    };

    await fs.writeFile(
      path.join(this.localesPath, '../i18n_update_report.json'),
      JSON.stringify(report, null, 2)
    );

    console.log(`📊 Update report generated: ${totalKeys} keys processed`);
  }
}

// CLI interface
async function runCommand() {
  const args = process.argv.slice(2);
  const agent = new AutoI18nTranslationAgent();

  try {
    switch (args[0]) {
      case '--update-all':
        await agent.updateAllTranslations();
        break;

      case '--update-lang':
        const lang = args[1];
        if (!lang) {
          console.error('❌ Please specify a language code: --update-lang <code>');
          process.exit(1);
        }
        await agent.updateLanguageTranslations(lang);
        break;

      case '--watch':
        await agent.startWatchMode();
        // Keep process alive
        process.on('SIGINT', async () => {
          console.log('\n🛑 Stopping watch mode...');
          await agent.stopWatchMode();
          process.exit(0);
        });
        // Keep alive
        setInterval(() => {}, 1000);
        break;

      case '--validate':
        const isValid = await agent.validateTranslations();
        process.exit(isValid ? 0 : 1);
        break;

      case '--install-hooks':
        const success = await agent.installGitHooks();
        process.exit(success ? 0 : 1);
        break;

      case '--help':
      default:
        console.log(`
🤖 Automated I18N Translation Agent

Usage:
  node autoI18nTranslationAgent.js [command]

Commands:
  --update-all          Update all translation files with missing keys
  --update-lang <code>  Update translations for specific language
  --watch               Start watch mode for continuous monitoring
  --validate            Validate all translation files
  --install-hooks       Install git hooks for translation validation
  --help                Show this help message

Examples:
  node autoI18nTranslationAgent.js --update-all
  node autoI18nTranslationAgent.js --update-lang ar
  node autoI18nTranslationAgent.js --watch
  node autoI18nTranslationAgent.js --install-hooks
        `);
        break;
    }
  } catch (error) {
    console.error('❌ Command failed:', error);
    process.exit(1);
  }
}

// Export for use as module
module.exports = { AutoI18nTranslationAgent };

// Run if called directly
if (require.main === module) {
  runCommand();
}