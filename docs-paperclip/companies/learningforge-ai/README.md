# Learning Forge AI

AI-powered learning company focused on continuous improvement from user interactions, domain knowledge (construction), and automated research for 50+ disciplines.

## Overview

Learning Forge AI is a Paperclip-based agent company that uses Hermes Agent runtime and Karpathy's AutoResearch to create a self-improving learning system.

## Division Structure

```
Learning Forge AI
├── EXECUTIVE DIVISION
│   └── Learning Strategy Agent (CEO)
│       ├── Learning & Curriculum Division
│       ├── Safety & Quality Division
│       ├── Knowledge-Flow & Docs Division
│       ├── Research & Compliance Division
│       └── Priority Disciplines Division
```

## Quick Start

1. Import this company into Paperclip:
   ```sh
   paperclip companies import docs-paperclip/companies/learningforge-ai/
   ```

2. Set up environment variables:
   ```sh
   export OPENROUTER_API_KEY=your_api_key
   ```

3. Clone and configure AutoResearch:
   ```sh
   git clone https://github.com/karpathy/autoresearch.git
   ```

## Documentation

- [Company Configuration](COMPANY.md) - Full company specification
- [Agent Configuration](.paperclip.yaml) - Paperclip agent configuration
- [Teams](teams/) - Division team definitions
- [Agents](agents/) - Individual agent definitions

## Implementation Status

| Phase | Description | Duration | Status |
|-------|-------------|----------|--------|
| 1 | Company setup and division agents | Weeks 1-2 | ✅ In Progress |
| 2 | Priority discipline workflows | Weeks 3-8 | 🚧 Planned |
| 3 | AutoResearch integration | Weeks 9-12 | 🚧 Planned |
| 4 | VFS knowledge flow | Weeks 13-16 | 🚧 Planned |
| 5 | Hermes skills implementation | Weeks 17-20 | 🚧 Planned |
| 6 | Cross-discipline scaling | Weeks 21-30 | 🚧 Planned |

## Technology Stack

- **Paperclip**: Orchestration, hierarchy, task management
- **Hermes Agent**: Agent runtime and skills system
- **AutoResearch**: Automated research for skills enhancement
- **VFS (LangChain)**: Knowledge storage and document management

## Priority Disciplines

1. **Contracts (00400)** - Contract creation, compliance, negotiation
2. **Procurement (01900)** - Order workflows, supplier management
3. **Logistics (01700)** - Transportation, warehouse, shipping
4. **Safety (02400)** - Incident reporting, training compliance
5. **Electrical Engineering (00860)** - Design, code compliance, commissioning

## Key Metrics

- **50+ disciplines** with standardized workflows
- **100+ agent skills** enhanced via AutoResearch
- **Weekly automated research** for all priority disciplines
- **100% knowledge traceability** from field findings to learning content

## License

MIT
