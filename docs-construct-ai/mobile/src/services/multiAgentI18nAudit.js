/**
 * Multi-Agent I18N Audit System
 * Comprehensive audit of all language files to identify missing translations
 * Following the i18n translation file organization procedure
 */

const fs = require('fs').promises;
const path = require('path');

class MultiAgentI18nAudit {
  constructor() {
    this.localesPath = path.join(__dirname, '../../assets/locales');
    this.supportedLanguages = ['en', 'ar', 'pt', 'es', 'fr', 'zu', 'xh', 'sw', 'de'];
    this.auditResults = {
      missingFiles: [],
      missingKeys: {},
      inconsistentKeys: {},
      orphanedKeys: {},
      summary: {}
    };
  }

  async runComprehensiveAudit() {
    console.log('🚀 Starting Multi-Agent I18N Audit System...');
    console.log(`📍 Scanning locales directory: ${this.localesPath}`);

    try {
      // Phase 1: File Structure Audit
      await this.auditFileStructure();

      // Phase 2: Translation Key Consistency Audit
      await this.auditTranslationConsistency();

      // Phase 3: Orphaned Keys Detection
      await this.detectOrphanedKeys();

      // Phase 4: Generate Reports
      await this.generateAuditReports();

      console.log('✅ Multi-Agent I18N Audit completed successfully');
      return this.auditResults;

    } catch (error) {
      console.error('❌ Multi-Agent I18N Audit failed:', error);
      throw error;
    }
  }

  async auditFileStructure() {
    console.log('📁 Phase 1: Auditing file structure...');

    const missingFiles = [];

    // Check if all language directories exist
    for (const lang of this.supportedLanguages) {
      const langPath = path.join(this.localesPath, lang);
      try {
        await fs.access(langPath);
      } catch {
        missingFiles.push(`${lang} directory`);
      }
    }

    // Get all English files as reference
    const enPath = path.join(this.localesPath, 'en');
    const enFiles = await this.getJsonFiles(enPath);

    // Check if all translation files exist for each language
    for (const lang of this.supportedLanguages.slice(1)) { // Skip English
      const langPath = path.join(this.localesPath, lang);

      for (const file of enFiles) {
        const filePath = path.join(langPath, file);
        try {
          await fs.access(filePath);
        } catch {
          missingFiles.push(`${lang}/${file}`);
        }
      }
    }

    this.auditResults.missingFiles = missingFiles;
    console.log(`📁 Found ${missingFiles.length} missing files/directories`);
  }

  async auditTranslationConsistency() {
    console.log('🔍 Phase 2: Auditing translation key consistency...');

    const enPath = path.join(this.localesPath, 'en');
    const enFiles = await this.getJsonFiles(enPath);

    const missingKeys = {};
    const inconsistentKeys = {};

    for (const file of enFiles) {
      const enFilePath = path.join(enPath, file);
      const enContent = await this.loadJsonFile(enFilePath);
      const enKeys = this.extractKeys(enContent);

      missingKeys[file] = {};
      inconsistentKeys[file] = {};

      for (const lang of this.supportedLanguages.slice(1)) {
        const langFilePath = path.join(this.localesPath, lang, file);

        try {
          const langContent = await this.loadJsonFile(langFilePath);
          const langKeys = this.extractKeys(langContent);

          // Find missing keys
          const missing = enKeys.filter(key => !langKeys.includes(key));
          if (missing.length > 0) {
            missingKeys[file][lang] = missing;
          }

          // Find extra keys (inconsistent)
          const extra = langKeys.filter(key => !enKeys.includes(key));
          if (extra.length > 0) {
            inconsistentKeys[file][lang] = extra;
          }

        } catch (error) {
          // File doesn't exist - already caught in file structure audit
          missingKeys[file][lang] = enKeys;
        }
      }
    }

    this.auditResults.missingKeys = missingKeys;
    this.auditResults.inconsistentKeys = inconsistentKeys;

    const totalMissing = Object.values(missingKeys).reduce((sum, file) =>
      sum + Object.values(file).reduce((fileSum, keys) => fileSum + keys.length, 0), 0
    );

    console.log(`🔍 Found ${totalMissing} missing translation keys`);
  }

  async detectOrphanedKeys() {
    console.log('🗑️ Phase 3: Detecting orphaned keys...');

    const orphanedKeys = {};

    // This would require scanning the codebase for used translation keys
    // For now, we'll implement a basic check

    // Get all translation keys across all languages
    const allTranslationKeys = new Set();

    for (const lang of this.supportedLanguages) {
      const langPath = path.join(this.localesPath, lang);
      const files = await this.getJsonFiles(langPath);

      for (const file of files) {
        const filePath = path.join(langPath, file);
        try {
          const content = await this.loadJsonFile(filePath);
          const keys = this.extractKeys(content);
          keys.forEach(key => allTranslationKeys.add(`${file}:${key}`));
        } catch (error) {
          // Skip files that can't be loaded
        }
      }
    }

    // TODO: Scan React components for actual usage
    // For now, we'll mark this as a placeholder
    this.auditResults.orphanedKeys = orphanedKeys;
    console.log('🗑️ Orphaned key detection completed (basic implementation)');
  }

  async generateAuditReports() {
    console.log('📊 Phase 4: Generating audit reports...');

    const summary = {
      totalLanguages: this.supportedLanguages.length,
      missingFilesCount: this.auditResults.missingFiles.length,
      totalMissingKeys: Object.values(this.auditResults.missingKeys).reduce((sum, file) =>
        sum + Object.values(file).reduce((fileSum, keys) => fileSum + keys.length, 0), 0
      ),
      totalInconsistentKeys: Object.values(this.auditResults.inconsistentKeys).reduce((sum, file) =>
        sum + Object.values(file).reduce((fileSum, keys) => fileSum + keys.length, 0), 0
      ),
      auditTimestamp: new Date().toISOString(),
      overallHealth: 'unknown'
    };

    // Calculate overall health score
    const healthScore = this.calculateHealthScore(summary);
    summary.overallHealth = healthScore > 80 ? 'excellent' :
                           healthScore > 60 ? 'good' :
                           healthScore > 40 ? 'fair' : 'poor';

    this.auditResults.summary = summary;

    // Generate JSON report
    const jsonReport = {
      auditResults: this.auditResults,
      recommendations: this.generateRecommendations(summary)
    };

    await fs.writeFile(
      path.join(this.localesPath, '../i18n_audit_report.json'),
      JSON.stringify(jsonReport, null, 2)
    );

    // Generate human-readable report
    const humanReport = this.generateHumanReadableReport(jsonReport);
    await fs.writeFile(
      path.join(this.localesPath, '../i18n_audit_report_human.md'),
      humanReport
    );

    console.log('📊 Audit reports generated successfully');
    console.log(`📈 Overall translation health: ${summary.overallHealth} (${healthScore.toFixed(1)}%)`);
  }

  calculateHealthScore(summary) {
    const totalPossibleKeys = summary.totalLanguages * 1000; // Estimate
    const actualMissingKeys = summary.totalMissingKeys;
    const actualInconsistentKeys = summary.totalInconsistentKeys;

    const missingPenalty = (actualMissingKeys / totalPossibleKeys) * 100;
    const inconsistentPenalty = (actualInconsistentKeys / totalPossibleKeys) * 50;
    const filePenalty = summary.missingFilesCount * 5;

    const healthScore = Math.max(0, 100 - missingPenalty - inconsistentPenalty - filePenalty);
    return healthScore;
  }

  generateRecommendations(summary) {
    const recommendations = [];

    if (summary.missingFilesCount > 0) {
      recommendations.push(`Create ${summary.missingFilesCount} missing translation files`);
    }

    if (summary.totalMissingKeys > 0) {
      recommendations.push(`Add ${summary.totalMissingKeys} missing translation keys`);
    }

    if (summary.totalInconsistentKeys > 0) {
      recommendations.push(`Remove ${summary.totalInconsistentKeys} inconsistent translation keys`);
    }

    if (summary.overallHealth === 'poor') {
      recommendations.push('Consider running automated translation agent to populate missing keys');
      recommendations.push('Review translation file organization and maintenance procedures');
    }

    return recommendations;
  }

  generateHumanReadableReport(jsonReport) {
    let report = '# I18N Translation Audit Report\n\n';
    report += `**Audit Date:** ${new Date().toLocaleString()}\n\n`;

    const summary = jsonReport.auditResults.summary;
    report += '## Summary\n\n';
    report += `- **Overall Health:** ${summary.overallHealth} (${this.calculateHealthScore(summary).toFixed(1)}%)\n`;
    report += `- **Languages:** ${summary.totalLanguages}\n`;
    report += `- **Missing Files:** ${summary.missingFilesCount}\n`;
    report += `- **Missing Keys:** ${summary.totalMissingKeys}\n`;
    report += `- **Inconsistent Keys:** ${summary.totalInconsistentKeys}\n\n`;

    if (jsonReport.auditResults.missingFiles.length > 0) {
      report += '## Missing Files\n\n';
      jsonReport.auditResults.missingFiles.forEach(file => {
        report += `- ${file}\n`;
      });
      report += '\n';
    }

    if (jsonReport.recommendations.length > 0) {
      report += '## Recommendations\n\n';
      jsonReport.recommendations.forEach(rec => {
        report += `- ${rec}\n`;
      });
      report += '\n';
    }

    return report;
  }

  async getJsonFiles(dirPath) {
    try {
      const files = await fs.readdir(dirPath);
      return files.filter(file => file.endsWith('.json'));
    } catch {
      return [];
    }
  }

  async loadJsonFile(filePath) {
    const content = await fs.readFile(filePath, 'utf8');
    return JSON.parse(content);
  }

  extractKeys(obj, prefix = '') {
    const keys = [];

    for (const [key, value] of Object.entries(obj)) {
      const fullKey = prefix ? `${prefix}.${key}` : key;

      if (typeof value === 'object' && value !== null) {
        keys.push(...this.extractKeys(value, fullKey));
      } else {
        keys.push(fullKey);
      }
    }

    return keys;
  }
}

// CLI runner
async function runAudit() {
  const audit = new MultiAgentI18nAudit();
  try {
    const results = await audit.runComprehensiveAudit();
    console.log('\n🎉 Audit completed! Check the generated report files.');
    return results;
  } catch (error) {
    console.error('Audit failed:', error);
    process.exit(1);
  }
}

// Export for use as module
module.exports = { MultiAgentI18nAudit, runAudit };

// Run if called directly
if (require.main === module) {
  runAudit();
}