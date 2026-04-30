---
name: Learning Forge AI
description: AI-powered learning company focused on continuous improvement from user interactions, domain knowledge (construction), and automated research for 50+ disciplines.
slug: learningforge-ai
schema: agentcompanies/v1
version: 1.0.0
license: MIT
authors:
  - name: Paperclip
  - name: Construct AI
homepage: https://construct-ai.com
tags:
  - learning
  - education
  - knowledge-management
  - construction
  - autoresearch
goals:
  - Continuously improve learning from user interactions in construction-domain applications
  - Track and learn from domain knowledge (legal precedents, materials, equipment breakthroughs)
  - Implement automated research using AutoResearch for skills enhancement
  - Manage workflows for 50+ construction disciplines
  - Ensure knowledge transfer from field findings to learning content
  - Integrate with Hermes agent runtime and Paperclip orchestration
includes:
  - ./teams/learning-curriculum/TEAM.md
  - ./teams/safety-quality/TEAM.md
  - ./teams/knowledge-flow/TEAM.md
  - ./teams/research-compliance/TEAM.md
  - ./teams/priority-disciplines/TEAM.md
requirements:
  secrets:
    - OPENROUTER_API_KEY
---

# Learning Forge AI

Learning Forge AI is a Paperclip-based agent company focused on learning from user interactions, domain knowledge, and continuous improvement through automated research.

## Mission

Continuously improve learning outcomes by:
- Analyzing user interactions with construction-domain applications
- Tracking domain knowledge (legal precedents, safety standards, material innovations)
- Implementing automated research using Karpathy's AutoResearch
- Creating adaptive learning content from field findings
- Managing standardized workflows across 50+ construction disciplines

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

## Knowledge Sources

This organisation references:

- **Internal knowledge** (`knowledge/`) — proprietary learning models and curriculum
- **External discipline knowledge** (`docs-construct-ai/disciplines/`) — 50+ construction disciplines
- **Hermes Agent** (`hermes_agent/`) — agent runtime and skills system
- **AutoResearch** — automated research for skills enhancement
- **Paperclip** — orchestration, hierarchy, and task management

## Implementation Phases

1. **Phase 1**: Company setup and division agents (Weeks 1-2)
2. **Phase 2**: Priority discipline workflows (Weeks 3-8)
3. **Phase 3**: AutoResearch integration (Weeks 9-12)
4. **Phase 4**: VFS knowledge flow (Weeks 13-16)
5. **Phase 5**: Hermes skills implementation (Weeks 17-20)
6. **Phase 6**: Cross-discipline scaling (Weeks 21-30)
