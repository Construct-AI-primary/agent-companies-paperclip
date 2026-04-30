# agent-companies-paperclip

**Paperclip + Hermes orchestration for AI agent companies.**

This repository contains the full Paperclip application stack (server, UI, packages, Docker) plus platform-specific orchestration artifacts for running the Construct AI agent ecosystem on Paperclip. Platform-agnostic agent companies, skills, and domain knowledge are consumed from the `agent-companies-core` submodule.

## Repository Structure

```
├── agent-companies-core/      ← Submodule: platform-agnostic agent definitions
├── docs-construct-ai/          ← Submodule: Construct AI documentation
├── docs-paperclip/             ← Submodule: Paperclip documentation
├── hermes_agent/               ← Submodule: Hermes AI agent runtime
├── server/                     ← Express REST API
├── ui/                         ← React + Vite board UI
├── packages/                   ← db, shared, adapters, plugins
├── docker/                     ← Docker build files
├── tests/                      ← Test suites
├── scripts/                    ← Database and operational utilities
├── doc/                        ← Architecture, dev guides, specs
├── releases/                   ← Release changelogs
└── docs-paperclip/
    ├── sql/                    ← Paperclip DB schemas and migrations
    ├── professions/            ← Paperclip orchestration docs
    └── companies/              ← Company/team/agent definitions (via submodule)
```

## Core Architecture

| Layer | Location | Description |
|-------|----------|-------------|
| Orchestrator | Paperclip app + Hermes | Board UI, API, agent runtime |
| Agent definitions | `agent-companies-core/` | 16 companies, 449 agents, 1,123 skills |
| Domain knowledge | `agent-companies-core/` | 50+ disciplines, PARA knowledge base |
| Projects & issues | `agent-companies-core/` | ~70 project charters, ~479 issue descriptions |
| SPEC database | `packages/db/` | Schema + migrations |

## Setup

```bash
pnpm install
pnpm dev          # Starts API (port 3100) + UI (served by API)
```

Quick check:
```bash
curl http://localhost:3100/api/health
curl http://localhost:3100/api/companies
```

## Origin

Extracted from `paperclip-render` (Construct AI fork) as part of the Agent Companies repo restructure. Platform-agnostic content moved to `agent-companies-core`; this repo retains the full Paperclip application stack and Paperclip-specific orchestration.

## License

See parent project licensing.