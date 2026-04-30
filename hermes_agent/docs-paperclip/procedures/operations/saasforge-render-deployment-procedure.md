---
title: SaaSForge AI Render Deployment Procedure
date: 2026-04-16
status: Active
scope: Render platform service provisioning, configuration, and lifecycle management
agents:
  - render-service-manager
  - deployment-orchestrator
  - client-config-manager
---

# SaaSForge AI Render Deployment Procedure

This document defines the comprehensive procedure for managing Render platform services within SaaSForge AI's white-label multi-tenant deployment architecture.

## Overview

Each client company receives isolated Render services with:
- **Production Service**: `{client}.saasforge.ai` (client-facing)
- **Development Service**: `dev.{client}.saasforge.ai` (team only)
- **Dedicated Database**: PostgreSQL per client
- **Optional Workers**: Background job processors

## Risk Assessment

**Overall Risk Level: MEDIUM**
- **Service Disruption**: Auto-scaling failures, deployment issues
- **Cost Impact**: Over-provisioning, under-utilization
- **Security**: Exposed credentials, misconfigured access

## Prerequisites

### Required Access
- [ ] Render account with admin access
- [ ] Render API key configured
- [ ] Client repository GitHub access

### Agent Availability
- [ ] Render-Service-Manager (`saasforge-ai-render-service-manager`)
- [ ] Deployment-Orchestrator (`saasforge-ai-deployment-orchestrator`)
- [ ] Client-Config-Manager (`saasforge-ai-client-config-manager`)

---

## Phase 1: New Client Service Provisioning

### Step 1.1: Pre-Provisioning Planning
**Agent**: Render-Service-Manager
**Duration**: 10-15 minutes

1. **Client Requirements Analysis**
   - Determine service plan based on client tier:
     - Starter: Free tier, 1 instance
     - Professional: $25/mo, 3 instances
     - Enterprise: Custom, auto-scaling enabled
   - Identify region requirements (GDPR, data residency)
   - Plan database requirements

2. **Resource Naming Convention**
   ```
   Production: {clientname}-app
   Development: {clientname}-dev
   Database: {clientname}-db
   Worker: {clientname}-worker (if needed)
   ```

3. **Environment Variables Planning**
   - Identify all required environment variables
   - Determine secrets vs sync'd variables
   - Plan database and cache connections

**Deliverables**:
- Provisioning plan document
- Resource naming confirmation
- Environment variable inventory

### Step 1.2: render.yaml Configuration
**Agent**: Render-Service-Manager
**Duration**: 15-20 minutes

1. **Create render.yaml**
   ```yaml
   # See templates/client-system-template/render.yaml
   # Customize with client-specific values
   ```

2. **Validate Configuration**
   - Verify YAML syntax
   - Confirm environment variable placeholders
   - Check domain configuration
   - Validate database connections

3. **Commit to Repository**
   - Add render.yaml to client repository
   - Push to dev branch first

**Deliverables**:
- Validated render.yaml
- Repository commit confirmation

### Step 1.3: Service Creation
**Agent**: Render-Service-Manager
**Duration**: 10-30 minutes

1. **Create Production Service**
   - Connect Render to GitHub repository
   - Select production branch (main)
   - Configure build and start commands
   - Set environment variables
   - Enable auto-deploy

2. **Create Development Service**
   - Create from same repository
   - Select dev branch
   - Configure for testing
   - Set development environment variables

3. **Create Database**
   - Provision PostgreSQL database
   - Configure region
   - Set access controls
   - Note connection string

4. **Verify Services**
   - Check health endpoint
   - Verify database connectivity
   - Test basic functionality

**Deliverables**:
- Production service URL
- Development service URL
- Database connection details (secure)

---

## Phase 2: Domain & SSL Configuration

### Step 2.1: Domain Setup
**Agent**: Render-Service-Manager
**Duration**: 15-30 minutes

1. **Configure DNS**
   ```
   Production: CNAME {client}.saasforge.ai → {service}.onrender.com
   Development: CNAME dev.{client}.saasforge.ai → {service-dev}.onrender.com
   WWW Redirect: {client}.saasforge.ai → {client}.saasforge.ai
   ```

2. **Add Domains in Render**
   - Add primary domain
   - Add www redirect
   - Verify DNS propagation
   - Enable automatic SSL

3. **SSL Verification**
   - Confirm Let's Encrypt certificate
   - Test HTTPS connectivity
   - Verify secure headers

**Deliverables**:
- Domain configuration complete
- SSL certificate active
- HTTPS working

### Step 2.2: Security Hardening
**Agent**: Render-Service-Manager + Client-Config-Manager
**Duration**: 15-20 minutes

1. **Environment Variable Security**
   - Mark secrets as non-sync'd
   - Verify API keys not in code
   - Test secret rotation capability

2. **Access Controls**
   - Configure IP allowlist (if needed)
   - Set up team access
   - Remove default access

3. **Security Headers**
   - Enable HSTS
   - Configure CSP headers
   - Set up CORS policies

**Deliverables**:
- Security audit confirmation
- Configuration hardening complete

---

## Phase 3: Deployment Workflow

### Step 3.1: Development Workflow
**Agent**: Deployment-Orchestrator
**Duration**: Continuous

1. **Development Process**
   ```
   Developer → commits to dev branch
                    ↓
            GitHub webhook triggers
                    ↓
            Render rebuilds dev service
                    ↓
            Test at dev.{client}.saasforge.ai
                    ↓
            (Repeat until ready)
   ```

2. **Testing Requirements**
   - All tests passing
   - Manual QA complete
   - Stakeholder approval

3. **Merge to Production**
   ```
   PR: dev → main
            ↓
      Code review approval
            ↓
      Merge to main branch
            ↓
      GitHub webhook triggers
            ↓
      Render deploys to production
            ↓
      Client sees at {client}.saasforge.ai
   ```

**Deliverables**:
- Development workflow documented
- Deployment triggers configured

### Step 3.2: Monitoring & Health Checks
**Agent**: Render-Service-Manager
**Duration**: 10-15 minutes

1. **Health Check Endpoint**
   ```javascript
   app.get('/health', (req, res) => {
     const db = await checkDatabase();
     const cache = await checkCache();
     res.json({
       status: db && cache ? 'healthy' : 'degraded',
       timestamp: new Date().toISOString()
     });
   });
   ```

2. **Monitoring Setup**
   - Configure error rate alerts
   - Set up latency thresholds
   - Enable deployment notifications
   - Set up Slack/email alerts

3. **Logging Configuration**
   - Enable structured logging
   - Configure log retention
   - Set up error tracking (Sentry)

**Deliverables**:
- Health check endpoint active
- Monitoring alerts configured
- Logging enabled

---

## Phase 4: Scaling & Optimization

### Step 4.1: Auto-Scaling Configuration
**Agent**: Render-Service-Manager
**Duration**: 15-20 minutes

1. **Plan-Based Scaling**
   | Plan | Instances | Auto-Scale |
   |------|----------|------------|
   | Starter | 1 | No |
   | Professional | 3 | No |
   | Enterprise | 10+ | Yes |

2. **Auto-Scaling Rules**
   ```yaml
   autoScaling:
     minInstances: 1
     maxInstances: 10
     targetCPUPercent: 70
     targetMemoryPercent: 80
     scaleUpCooldownSeconds: 300
     scaleDownCooldownSeconds: 600
   ```

3. **Performance Tuning**
   - Analyze usage patterns
   - Optimize instance sizing
   - Configure connection pooling
   - Enable caching strategies

**Deliverables**:
- Scaling configuration complete
- Performance baseline established

### Step 4.2: Cost Optimization
**Agent**: Resource-Optimizer
**Duration**: Ongoing

1. **Usage Monitoring**
   - Track resource utilization
   - Identify over-provisioning
   - Monitor database connections

2. **Cost Alerts**
   - Set budget thresholds
   - Alert on unusual spend
   - Monthly cost reviews

3. **Optimization Actions**
   - Downgrade unused capacity
   - Enable sleep mode (staging)
   - Use Reserved instances (if available)

**Deliverables**:
- Cost monitoring dashboard
- Optimization recommendations

---

## Phase 5: Lifecycle Management

### Step 5.1: Service Updates
**Agent**: Deployment-Orchestrator
**Duration**: Per deployment

1. **Pre-Update Checklist**
   - [ ] All tests passing
   - [ ] Change log updated
   - [ ] Backup created
   - [ ] Rollback plan ready
   - [ ] Client notified (if needed)

2. **Update Process**
   ```
   Push to main branch
           ↓
   Render detects change
           ↓
   Blue-green deploy begins
           ↓
   Health checks pass
           ↓
   Traffic switches to new version
           ↓
   Old version stays for rollback
   ```

3. **Post-Update Verification**
   - Monitor error rates
   - Check latency
   - Verify functionality

**Deliverables**:
- Update complete
- Monitoring confirms health

### Step 5.2: Rollback Procedures
**Agent**: Deployment-Orchestrator
**Duration**: 5-15 minutes

1. **Rollback Triggers**
   - Health check failure
   - Error rate > 5%
   - Latency spike > 100%
   - Critical bug discovered

2. **Rollback Process**
   ```
   Detect issue
          ↓
   Trigger rollback (one-click)
          ↓
   Render switches to previous version
          ↓
   Health checks verify
          ↓
   Investigate root cause
   ```

3. **Post-Rollback Actions**
   - Notify stakeholders
   - Document incident
   - Plan permanent fix
   - Test fix in dev

**Deliverables**:
- Service restored
- Incident documented

### Step 5.3: Service Decommissioning
**Agent**: Render-Service-Manager
**Duration**: 30-60 minutes

1. **Pre-Decommission Checklist**
   - [ ] All data exported
   - [ ] Final backup created
   - [ ] Clients migrated
   - [ ] Domain DNS updated
   - [ ] SSL certificates noted

2. **Decommission Process**
   ```
   Export all client data
           ↓
   Create final backup
           ↓
   Update DNS records
           ↓
   Suspend services
           ↓
   Remove domains
           ↓
   Delete services (after retention)
   ```

3. **Post-Decommission**
   - Remove from monitoring
   - Archive logs
   - Update documentation
   - Mark as decommissioned

**Deliverables**:
- Data export complete
- Services terminated
- Documentation archived

---

## Troubleshooting

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Build failure | Dependency issue | Check build logs, verify Node version |
| Slow response | Under-provisioned | Upgrade plan or enable auto-scaling |
| Health check failing | App crash | Check logs, restart service |
| SSL error | DNS not propagated | Wait for propagation, verify DNS |
| Deployment stuck | GitHub webhook issue | Check webhook delivery, manual redeploy |

### Emergency Contacts

- **Render-Service-Manager**: Service provisioning issues
- **Deployment-Orchestrator**: Deployment failures
- **Client-Config-Manager**: Configuration problems

---

## Version History

- **v1.0** (2026-04-16): Initial Render deployment procedure
- Multi-tenant service provisioning
- Domain and SSL configuration
- Deployment and rollback workflows

---

**Document Owner**: SaaSForge AI Operations Team
**Review Cycle**: Quarterly
**Last Updated**: 2026-04-16
