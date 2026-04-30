#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const glob = require('glob');

class IndexGenerator {
    constructor(docsPath = './docs') {
        this.docsPath = path.resolve(docsPath);
        this.repoRoot = path.resolve('.');
    }

    async generateAllIndexes() {
        console.log('📚 Generating documentation indexes...');

        // Generate master index
        await this.generateMasterIndex();

        // Generate category-specific indexes
        await this.generateCategoryIndexes();

        // Generate discipline-specific indexes
        await this.generateDisciplineIndexes();

        // Generate agent documentation index
        await this.generateAgentIndex();

        console.log('✅ All indexes generated successfully!');
    }

    async generateMasterIndex() {
        console.log('  Generating master index...');

        const indexPath = path.join(this.repoRoot, 'INDEX.md');
        let content = '# Construct AI Documentation Index\n\n';
        content += '## 📚 Documentation Categories\n\n';

        // Get file counts for each category
        const categories = ['disciplines', 'procedures', 'guides', 'workflows', 'standards', 'archive', 'projects'];
        for (const category of categories) {
            const categoryPath = path.join(this.docsPath, category);
            if (fs.existsSync(categoryPath)) {
                const fileCount = glob.sync('**/*.md', { cwd: categoryPath }).length;
                content += `- [${category}](./docs/${category}/) - ${fileCount} files\n`;
            }
        }

        content += '\n## 🔍 Quick Access\n\n';
        content += '- [Agent Documentation](./docs/agents/) - All agent-related docs\n';
        content += '- [API References](./docs/guides/api-reference/) - Technical references\n';
        content += '- [Troubleshooting](./docs/guides/troubleshooting/) - Common issues\n\n';

        // Add statistics
        const totalFiles = glob.sync('docs/**/*.md', { cwd: this.repoRoot }).length;
        content += '## 📊 Statistics\n\n';
        content += `- Total files: ${totalFiles}\n`;
        content += `- Last updated: ${new Date().toISOString().split('T')[0]}\n`;
        content += `- Repository: construct_ai_docs\n`;

        fs.writeFileSync(indexPath, content);
    }

    async generateCategoryIndexes() {
        console.log('  Generating category indexes...');

        const categories = [
            { name: 'disciplines', title: 'Discipline Documentation Index', description: 'Engineering and technical discipline documentation' },
            { name: 'procedures', title: 'Procedures Documentation Index', description: 'Implementation procedures and workflows' },
            { name: 'guides', title: 'Guides Documentation Index', description: 'User manuals and developer guides' },
            { name: 'workflows', title: 'Workflows Documentation Index', description: 'Process and workflow documentation' },
            { name: 'standards', title: 'Standards Documentation Index', description: 'Coding and operational standards' },
            { name: 'archive', title: 'Archive Documentation Index', description: 'Deprecated and historical documentation' }
        ];

        for (const category of categories) {
            await this.generateCategoryIndex(category);
        }
    }

    async generateCategoryIndex(category) {
        const categoryPath = path.join(this.docsPath, category.name);
        if (!fs.existsSync(categoryPath)) {
            return;
        }

        const readmePath = path.join(categoryPath, 'README.md');
        let content = `# ${category.title}\n\n`;
        content += `> ${category.description}\n\n`;

        // Special handling for disciplines
        if (category.name === 'disciplines') {
            content += '## Engineering Disciplines\n\n';
            const disciplines = this.getDisciplineList();
            for (const discipline of disciplines) {
                content += `- [${discipline.title}](./${discipline.code}/)\n`;
            }
            content += '\n## Business Disciplines\n\n';
            // Add business disciplines as needed
        } else {
            // Generate file listing for other categories
            const files = this.getCategoryFiles(category.name);
            if (files.length > 0) {
                content += '## Files\n\n';
                for (const file of files) {
                    const title = this.extractTitle(file.path) || path.basename(file.path, '.md');
                    content += `- [${title}](${file.relativePath})\n`;
                }
                content += '\n';
            }
        }

        content += '## Related Documentation\n\n';
        content += `- [Parent Directory](../) - Higher level documentation\n`;
        content += `- [Main Index](../../) - Repository index\n\n`;

        content += '---\n\n';
        content += `*Generated: ${new Date().toISOString()}*`;

        fs.writeFileSync(readmePath, content);
    }

    async generateDisciplineIndexes() {
        console.log('  Generating discipline indexes...');

        const disciplinesPath = path.join(this.docsPath, 'disciplines');
        if (!fs.existsSync(disciplinesPath)) {
            return;
        }

        const disciplineDirs = fs.readdirSync(disciplinesPath, { withFileTypes: true })
            .filter(dirent => dirent.isDirectory())
            .map(dirent => dirent.name);

        for (const disciplineCode of disciplineDirs) {
            await this.generateDisciplineIndex(disciplineCode);
        }
    }

    async generateDisciplineIndex(disciplineCode) {
        const disciplinePath = path.join(this.docsPath, 'disciplines', disciplineCode);
        const readmePath = path.join(disciplinePath, 'README.md');

        const disciplineInfo = this.getDisciplineInfo(disciplineCode);
        let content = `# ${disciplineInfo.title}\n\n`;
        content += `> Documentation for ${disciplineInfo.description}\n\n`;

        // Get files in this discipline
        const files = glob.sync('**/*.md', { cwd: disciplinePath })
            .filter(file => !file.endsWith('README.md'))
            .map(file => ({
                path: path.join(disciplinePath, file),
                relativePath: file
            }));

        if (files.length > 0) {
            content += '## Documentation Files\n\n';
            for (const file of files) {
                const title = this.extractTitle(file.path) || path.basename(file.path, '.md').replace(/-/g, ' ');
                content += `- [${title}](${file.relativePath})\n`;
            }
            content += '\n';
        }

        // Add subdirectories
        const subdirs = fs.readdirSync(disciplinePath, { withFileTypes: true })
            .filter(dirent => dirent.isDirectory())
            .map(dirent => dirent.name);

        if (subdirs.length > 0) {
            content += '## Subdirectories\n\n';
            for (const subdir of subdirs) {
                content += `- [${subdir}](${subdir}/)\n`;
            }
            content += '\n';
        }

        content += '## Related Documentation\n\n';
        content += `- [All Disciplines](../) - Other discipline documentation\n`;
        content += `- [Main Index](../../) - Repository index\n\n`;

        content += '---\n\n';
        content += `*Generated: ${new Date().toISOString()}*`;

        fs.writeFileSync(readmePath, content);
    }

    async generateAgentIndex() {
        console.log('  Generating agent documentation index...');

        const agentsPath = path.join(this.docsPath, 'agents');
        if (!fs.existsSync(agentsPath)) {
            fs.mkdirSync(agentsPath, { recursive: true });
        }

        const readmePath = path.join(agentsPath, 'README.md');
        let content = '# Agent Documentation Index\n\n';
        content += '> Comprehensive index of all agent-related documentation\n\n';

        content += '## Agent Categories\n\n';
        content += '- [Main Agents](./main-agents/) - Core workflow agents (320 agents)\n';
        content += '- [Specialist Agents](./specialist-agents/) - Domain experts (139 agents)\n';
        content += '- [Coordinator Agents](./coordinator-agents/) - Workflow coordinators (13 agents)\n\n';

        content += '## By Discipline\n\n';
        const disciplines = this.getDisciplineList();
        for (const discipline of disciplines.slice(0, 10)) { // Limit to first 10
            content += `- [${discipline.title} Agents](../disciplines/${discipline.code}/)\n`;
        }
        content += '\n## Agent Development\n\n';
        content += '- [Agent Architecture](../guides/agent-architecture/)\n';
        content += '- [Agent Testing](../procedures/agent-testing/)\n';
        content += '- [Agent Deployment](../procedures/agent-deployment/)\n\n';

        content += '---\n\n';
        content += `*Generated: ${new Date().toISOString()}*`;

        fs.writeFileSync(readmePath, content);
    }

    getDisciplineList() {
        return [
            { code: '00850', title: 'Civil Engineering', description: 'civil engineering documentation' },
            { code: '00860', title: 'Electrical Engineering', description: 'electrical engineering documentation' },
            { code: '00870', title: 'Mechanical Engineering', description: 'mechanical engineering documentation' },
            { code: '00871', title: 'Process Engineering', description: 'process engineering documentation' },
            { code: '00835', title: 'Chemical Engineering', description: 'chemical engineering documentation' },
            { code: '00300', title: 'Construction', description: 'construction documentation' },
            { code: '00825', title: 'Architectural', description: 'architectural documentation' },
            { code: '01200', title: 'Finance', description: 'finance documentation' },
            { code: '01300', title: 'Governance', description: 'governance documentation' },
            { code: '01900', title: 'Procurement', description: 'procurement documentation' }
        ];
    }

    getDisciplineInfo(code) {
        const disciplines = this.getDisciplineList();
        return disciplines.find(d => d.code === code) || {
            title: `${code} Documentation`,
            description: `${code} discipline documentation`
        };
    }

    getCategoryFiles(category) {
        const categoryPath = path.join(this.docsPath, category);
        if (!fs.existsSync(categoryPath)) {
            return [];
        }

        return glob.sync('**/*.md', { cwd: categoryPath })
            .filter(file => !file.endsWith('README.md'))
            .map(file => ({
                path: path.join(categoryPath, file),
                relativePath: file
            }));
    }

    extractTitle(filePath) {
        try {
            const content = fs.readFileSync(filePath, 'utf8');
            const lines = content.split('\n');
            const titleLine = lines.find(line => line.startsWith('# '));
            return titleLine ? titleLine.substring(2).trim() : null;
        } catch (error) {
            return null;
        }
    }
}

// Run the index generator
if (require.main === module) {
    const generator = new IndexGenerator();
    generator.generateAllIndexes().then(() => {
        console.log('Index generation completed successfully!');
    }).catch(error => {
        console.error('Error generating indexes:', error);
        process.exit(1);
    });
}

module.exports = IndexGenerator;