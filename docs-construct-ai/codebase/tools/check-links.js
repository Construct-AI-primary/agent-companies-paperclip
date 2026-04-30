#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const glob = require('glob');

class LinkChecker {
    constructor(docsPath = './docs') {
        this.docsPath = path.resolve(docsPath);
        this.errors = [];
        this.warnings = [];
    }

    async checkAllLinks() {
        console.log('🔍 Checking internal links...');

        const mdFiles = glob.sync('**/*.md', {
            cwd: this.docsPath,
            absolute: true
        });

        for (const file of mdFiles) {
            await this.checkFileLinks(file);
        }

        this.reportResults();
        return this.errors.length === 0;
    }

    async checkFileLinks(filePath) {
        const content = fs.readFileSync(filePath, 'utf8');
        const lines = content.split('\n');
        const fileDir = path.dirname(filePath);

        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];
            const links = this.extractLinks(line);

            for (const link of links) {
                if (this.isInternalLink(link)) {
                    this.validateInternalLink(link, filePath, fileDir, i + 1);
                }
            }
        }
    }

    extractLinks(line) {
        const linkRegex = /\[([^\]]+)\]\(([^)]+)\)/g;
        const links = [];
        let match;

        while ((match = linkRegex.exec(line)) !== null) {
            links.push({
                text: match[1],
                url: match[2]
            });
        }

        return links;
    }

    isInternalLink(link) {
        const url = link.url;
        // Check for relative links (not starting with http/https/mailto/etc)
        return !url.startsWith('http') &&
               !url.startsWith('https') &&
               !url.startsWith('mailto') &&
               !url.startsWith('#') &&
               !url.startsWith('ftp') &&
               url.trim() !== '';
    }

    validateInternalLink(link, filePath, fileDir, lineNumber) {
        const url = link.url;
        let targetPath;

        try {
            if (url.startsWith('/')) {
                // Absolute path from docs root
                targetPath = path.join(this.docsPath, url.substring(1));
            } else {
                // Relative path
                targetPath = path.resolve(fileDir, url);
            }

            // Remove fragment identifiers
            targetPath = targetPath.split('#')[0];

            // Check if target exists
            if (!fs.existsSync(targetPath)) {
                // Try adding .md extension if not present
                if (!targetPath.endsWith('.md') && !path.extname(targetPath)) {
                    const withMd = targetPath + '.md';
                    if (!fs.existsSync(withMd)) {
                        this.errors.push({
                            file: path.relative(process.cwd(), filePath),
                            line: lineNumber,
                            link: url,
                            target: targetPath,
                            message: `Broken link: ${url} (file not found)`
                        });
                    }
                } else {
                    this.errors.push({
                        file: path.relative(process.cwd(), filePath),
                        line: lineNumber,
                        link: url,
                        target: targetPath,
                        message: `Broken link: ${url} (file not found)`
                    });
                }
            }
        } catch (error) {
            this.errors.push({
                file: path.relative(process.cwd(), filePath),
                line: lineNumber,
                link: url,
                message: `Invalid link format: ${url} (${error.message})`
            });
        }
    }

    reportResults() {
        if (this.errors.length === 0 && this.warnings.length === 0) {
            console.log('✅ All internal links are valid!');
            return;
        }

        if (this.errors.length > 0) {
            console.log(`❌ Found ${this.errors.length} broken links:`);
            this.errors.forEach(error => {
                console.log(`  ${error.file}:${error.line} - ${error.message}`);
            });
        }

        if (this.warnings.length > 0) {
            console.log(`⚠️  Found ${this.warnings.length} warnings:`);
            this.warnings.forEach(warning => {
                console.log(`  ${warning.file}:${warning.line} - ${warning.message}`);
            });
        }
    }
}

// Run the link checker
if (require.main === module) {
    const checker = new LinkChecker();
    checker.checkAllLinks().then(success => {
        process.exit(success ? 0 : 1);
    }).catch(error => {
        console.error('Error checking links:', error);
        process.exit(1);
    });
}

module.exports = LinkChecker;