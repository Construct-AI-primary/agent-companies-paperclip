---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation
documentation
openstinger_context: general-documentation
last_updated: 2026-03-30
related_docs:
  - docs/
---

# Construct AI Documentation

**Welcome to the Construct AI Documentation Repository**

This repository contains all documentation for the Construct AI system, organized for optimal discoverability and maintenance.

## 📚 Documentation Categories

- **[Disciplines](./docs/disciplines/)** - Discipline-specific documentation organized by specialty codes
- **[Procedures](./docs/procedures/)** - Implementation procedures and workflows
- **[Guides](./docs/guides/)** - User manuals and developer guides
- **[Workflows](./docs/workflows/)** - Process documentation and agent workflows
- **[Standards](./docs/standards/)** - Coding standards and operational guidelines
- **[Projects](./docs/projects/)** - Project-specific documentation
- **[Archive](./docs/archive/)** - Deprecated and historical documentation

## 🔍 Quick Access

- [Agent Documentation](./docs/agents/) - All agent-related documentation
- [API References](./docs/guides/api-reference/) - Technical API documentation
- [Troubleshooting](./docs/guides/troubleshooting/) - Common issues and solutions

## 📊 Repository Statistics

- **Total Files:** 2,774+ Markdown documents
- **Last Updated:** $(date)
- **Repository:** construct_ai_docs
- **Main Repository:** [construct_ai](https://github.com/Construct-AI-primary/construct_ai)

## 🚀 Getting Started

### For Documentation Contributors

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Construct-AI-primary/construct_ai_docs.git
   cd construct_ai_docs
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Create or edit documentation** following the [contribution guidelines](./CONTRIBUTING.md)

4. **Validate changes:**
   ```bash
   npm run validate
   ```

### For Documentation Consumers

- **Browse by category** using the links above
- **Use search** within GitHub or your IDE
- **Check indexes** in each directory for detailed file listings
- **Access via submodule** in the main repository

## 🏗️ Repository Structure

```
construct_ai_docs/
├── .github/                 # GitHub Actions and templates
│   ├── workflows/          # CI/CD workflows
│   └── ISSUE_TEMPLATE/     # Issue templates
├── docs/                   # Main documentation
│   ├── disciplines/        # Discipline-specific docs
│   ├── procedures/         # Implementation procedures
│   ├── guides/            # User and developer guides
│   ├── workflows/         # Process workflows
│   ├── standards/         # Standards and guidelines
│   ├── projects/          # Project documentation
│   └── archive/           # Historical documentation
├── tools/                  # Documentation tooling
├── .markdownlint.jsonc     # Markdown linting rules
├── .prettierrc            # Code formatting
├── package.json           # Node.js dependencies
├── README.md              # This file
└── CONTRIBUTING.md        # Contribution guidelines
```

## 🔧 Development Tools

### Available Scripts

- `npm run lint` - Lint all markdown files
- `npm run validate` - Validate documentation structure and links
- `npm run build` - Build documentation for publishing
- `npm run generate-indexes` - Generate documentation indexes
- `npm run check-links` - Check for broken internal links

### GitHub Actions

- **Documentation Validation** - Runs on every push/PR to validate markdown and links
- **Index Generation** - Automatically updates documentation indexes
- **Publishing** - Deploys documentation to GitHub Pages

## 🤝 Contributing

We welcome contributions to improve our documentation! Please see our [Contributing Guidelines](./CONTRIBUTING.md) for details on:

- Documentation standards and style
- How to propose changes
- Review process
- Code of conduct

### Quick Contribution Steps

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement-name`)
3. Make your changes
4. Run validation (`npm run validate`)
5. Commit and push
6. Create a Pull Request

## 📞 Support

- **Issues:** [GitHub Issues](https://github.com/Construct-AI-primary/construct_ai_docs/issues)
- **Discussions:** [GitHub Discussions](https://github.com/Construct-AI-primary/construct_ai_docs/discussions)
- **Documentation:** Check the [troubleshooting guide](./docs/guides/troubleshooting/)

## 📄 License

This documentation is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Generated:** $(date)
**Version:** 1.0.0
**Status:** Active Development