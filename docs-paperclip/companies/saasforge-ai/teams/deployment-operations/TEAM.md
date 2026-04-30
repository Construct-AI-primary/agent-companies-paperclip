---
name: Deployment Operations
description: Multi-client deployment automation, Render service management, and GitHub workflow coordination
slug: deployment-operations
manager: ../agents/saasforge-ai-Deployment-Orchestrator/AGENTS.md
tags:
  - team
  - deployment
  - infrastructure
---

# Deployment Operations Team

Responsible for managing multi-client deployments, Render infrastructure, and GitHub workflow automation across all SaaSForge AI client instances.

## Team Members

- **Deployment-Orchestrator** - Multi-instance deployment coordination
- **Render-Service-Manager** - Render service provisioning and lifecycle
- **GitHub-Branch-Manager** - Version control and repository management
- **Client-Config-Manager** - Per-company configuration management

## Responsibilities

### Multi-Client Deployment
- Coordinate deployments across all client instances
- Manage deployment queues and priorities
- Implement staged rollouts and canary deployments
- Execute rollback procedures when needed

### Infrastructure Management
- Create and provision new client Render services
- Configure render.yaml files per client
- Set up auto-scaling and monitoring
- Manage service lifecycles

### Version Control
- Set up GitHub repositories for new clients
- Configure branch protection rules
- Manage GitHub Actions CI/CD workflows
- Coordinate dev-to-main merge workflows

### Configuration Management
- Manage per-company environment variables
- Handle client branding configurations
- Manage feature flags per client
- Deploy configuration changes

## Workflow

```
New Client Onboarding:
1. GitHub-Branch-Manager creates repository from template
2. GitHub-Branch-Manager sets up dev/main branches
3. Render-Service-Manager creates production & dev services
4. Client-Config-Manager configures environment variables
5. Client-Config-Manager sets up branding
6. Onboarding complete

Standard Deployment Flow:
1. Team works on dev branch
2. Test on dev.{client}.saasforge.ai
3. Merge to main branch
4. Deployment-Orchestrator triggers production deploy
5. Client sees update on {client}.saasforge.ai
```

## Integration

- Reports to: **Onboard Master** (CEO)
- Coordinates with: **DevOps Engineer** (CI/CD pipelines)
- Supports: **Tenant Manager** (new tenant provisioning)
