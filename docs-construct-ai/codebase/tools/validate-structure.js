#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const glob = require('glob');

class StructureValidator {
    constructor(docsPath = './docs') {
        this.docsPath = path.resolve(docsPath);
        this.errors = [];
        this.warnings = [];
        this.requiredCategories = [
            'disciplines',
            'procedures',
            'guides',
            'workflows',
            'standards',
            'archive'
        ];
    }

    async validateStructure() {
        console.log('🔍 Validating documentation structure...');

        // Check required directory structure
        this.validateRequiredDirectories();

        // Check for orphaned files
        this.validateNoOrphanedFiles();

        // Check README files exist
        this.validateReadmeFiles();

        // Check file naming conventions
        this.validateFileNaming();

        this.reportResults();
        return this.errors.length === 0;
    }

    validateRequiredDirectories() {
        console.log('  Checking required directories...');

        for (const category of this.requiredCategories) {
            const categoryPath = path.join(this.docsPath, category);
            if (!fs.existsSync(categoryPath)) {
                this.errors.push({
                    type: 'missing_directory',
                    path: categoryPath,
                    message: `Required directory missing: ${category}`
                });
            } else {
                const stat = fs.statSync(categoryPath);
                if (!stat.isDirectory()) {
                    this.errors.push({
                        type: 'not_directory',
                        path: categoryPath,
                        message: `Required path is not a directory: ${category}`
                    });
                }
            }
        }
    }

    validateNoOrphanedFiles() {
        console.log('  Checking for orphaned files...');

        const mdFiles = glob.sync('**/*.md', {
            cwd: this.docsPath,
            absolute: true
        });

        for (const file of mdFiles) {
            const relativePath = path.relative(this.docsPath, file);
            const parts = relativePath.split(path.sep);

            // Check if file is in a recognized category
            if (parts.length > 0) {
                const topLevel = parts[0];
                if (!this.requiredCategories.includes(topLevel) && topLevel !== 'projects') {
                    // Allow files in root docs directory for now
                    if (parts.length === 1) {
                        continue;
                    }

                    this.warnings.push({
                        type: 'orphaned_file',
                        file: relativePath,
                        message: `File in unrecognized category: ${topLevel}`
                    });
                }
            }
        }
    }

    validateReadmeFiles() {
        console.log('  Checking README files...');

        // Check for README in docs root
        const docsReadme = path.join(this.docsPath, 'README.md');
        if (!fs.existsSync(docsReadme)) {
            this.warnings.push({
                type: 'missing_readme',
                path: 'docs/README.md',
                message: 'Missing README.md in docs root'
            });
        }

        // Check for READMEs in category directories
        for (const category of this.requiredCategories) {
            const categoryPath = path.join(this.docsPath, category);
            if (fs.existsSync(categoryPath)) {
                const readmePath = path.join(categoryPath, 'README.md');
                if (!fs.existsSync(readmePath)) {
                    this.warnings.push({
                        type: 'missing_readme',
                        path: path.relative(this.docsPath, readmePath),
                        message: `Missing README.md in ${category}/`
                    });
                }
            }
        }
    }

    validateFileNaming() {
        console.log('  Checking file naming conventions...');

        const mdFiles = glob.sync('**/*.md', {
            cwd: this.docsPath,
            absolute: true
        });

        for (const file of mdFiles) {
            const filename = path.basename(file);

            // Check for problematic characters
            if (filename.includes(' ')) {
                this.warnings.push({
                    type: 'filename_spaces',
                    file: path.relative(this.docsPath, file),
                    message: 'Filename contains spaces (use hyphens or underscores)'
                });
            }

            // Check for uppercase (prefer lowercase)
            if (filename !== filename.toLowerCase() && filename !== 'README.md') {
                this.warnings.push({
                    type: 'filename_case',
                    file: path.relative(this.docsPath, file),
                    message: 'Filename contains uppercase (prefer lowercase)'
                });
            }

            // Check for special characters
            if (/[^a-zA-Z0-9._-]/.test(filename.replace('.md', ''))) {
                this.errors.push({
                    type: 'filename_special_chars',
                    file: path.relative(this.docsPath, file),
                    message: 'Filename contains special characters'
                });
            }
        }
    }

    reportResults() {
        if (this.errors.length === 0 && this.warnings.length === 0) {
            console.log('✅ Documentation structure is valid!');
            return;
        }

        if (this.errors.length > 0) {
            console.log(`❌ Found ${this.errors.length} structure errors:`);
            this.errors.forEach(error => {
                console.log(`  ${error.message}`);
            });
        }

        if (this.warnings.length > 0) {
            console.log(`⚠️  Found ${this.warnings.length} structure warnings:`);
            this.warnings.forEach(warning => {
                console.log(`  ${warning.message}`);
            });
        }
    }
}

// Run the structure validator
if (require.main === module) {
    const validator = new StructureValidator();
    validator.validateStructure().then(success => {
        process.exit(success ? 0 : 1);
    }).catch(error => {
        console.error('Error validating structure:', error);
        process.exit(1);
    });
}

module.exports = StructureValidator;