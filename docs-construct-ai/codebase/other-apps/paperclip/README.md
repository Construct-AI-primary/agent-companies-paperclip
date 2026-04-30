---
memory_layer: durable_knowledge
para_section: pages/codebase/other-apps
gigabrain_tags: other-apps, codebase, integrations
documentation
openstinger_context: other-apps-practices
last_updated: 2026-03-21
related_docs:
  - codebase/other-apps/
  - disciplines/
---
# Paperclip - AI Coding Agent Browser Interface

## Overview

Paperclip is a browser-based interface for AI coding agents, providing a user-friendly web UI for interacting with AI assistants like Claude Code (Cline) and other coding agents. It serves as a bridge between terminal-based AI tools and a more accessible browser environment.

## How We Use It

### Primary Use Cases

1. **AI Agent Orchestration**: Paperclip allows us to run and manage multiple AI coding agents through a web interface, making it easier to coordinate complex development tasks across our distributed system.

2. **Multi-Device Access**: Since Paperclip runs in the browser, team members can access AI coding capabilities from any device with a web browser, including mobile devices and tablets.

3. **Workflow Integration**: We use Paperclip to integrate AI coding workflows with our broader ConstructAI ecosystem, allowing AI agents to work on construction industry-specific tasks.

4. **Documentation and Planning**: AI agents running through Paperclip help generate structured documentation, implementation plans, and specifications for our construction projects.

### Integration with Our Stack

- **Cline Integration**: Works seamlessly with Claude Code (Cline) for VS Code integration
- **OpenClaw Compatibility**: Supports OpenClaw agents for distributed computing
- **Superpowers Framework**: Integrates with our Superpowers structured development framework
- **Multi-Device Sync**: Connects with Tailscale for secure cross-device synchronization

## Architecture

Paperclip typically runs on a local development server (often on port 3123) and provides:

- Web-based terminal interface
- File system access
- AI agent management
- Workflow orchestration
- Real-time collaboration features

## Getting Started

1. Ensure you have the Paperclip server running locally
2. Open your browser to the Paperclip interface (usually `http://localhost:3123`)
3. Connect your preferred AI coding agent
4. Start developing with AI assistance

## Related Tools

- **Cline**: VS Code extension for Claude Code integration
- **OpenClaw**: Distributed AI agent system
- **Superpowers**: Structured development framework
- **Tailscale**: Secure networking for multi-device setups

## Location

This documentation is located at: `docs/other-apps/paperclip/`

## Maintenance

This folder contains documentation and configurations for our Paperclip setup within the ConstructAI ecosystem. Paperclip serves as a browser-based interface for accessing our AI coding agents and development tools.
