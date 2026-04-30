---
title: SaaSForge AI Multi-Client Onboarding Procedure
date: 2026-04-16
status: Active
scope: End-to-end new client company onboarding workflow
agents:
  - onbroad-master
  - github-branch-manager
  - render-service-manager
  - client-config-manager
  - onboarding-coordinator
---

# SaaSForge AI Multi-Client Onboarding Procedure

This document defines the comprehensive end-to-end procedure for onboarding new client companies into SaaSForge AI's white-label multi-tenant platform.

## Overview

The onboarding process covers:
1. **New Client Request** → Initial setup and configuration
2. **Infrastructure Provisioning** → GitHub + Render setup
3. **Configuration & Branding** → Client-specific customization
4. **Testing & Validation** → Full system verification
5. **Go-Live** → Production handover to client

## Risk Assessment

**Overall Risk Level: MEDIUM**
- **Setup Errors**: Misconfigured services, incorrect branding
- **Security**: Exposed credentials, incomplete isolation
- **Data**: Incorrect data migration, lost configuration

## Prerequisites

### Required Access
- [ ] GitHub organization admin access
- [ ] Render account with service creation rights
- [ ] Template repository access
- [ ] Domain management access
- [ ] Supabase/database provisioning (if applicable)

### Agent Team
| Agent | Role | Timeline |
|-------|------|----------|
| Onboard-Master | Orchestration, approval | Overall |
| GitHub-Branch-Manager | Repository setup | 30-45 min |
| Render-Service-Manager | Service provisioning | 30-45 min |
| Client-Config-Manager | Configuration & branding | 30-45 min |
| Onboarding-Coordinator | Testing & validation | 30-45 min |

---

## Phase 1: Client Requirements Gathering

### Step 1.1: Initial Request
**Agent**: Onboarding-Coordinator
**Duration**: 15-30 minutes

1. **Client Information Collection**
   ```
   Required Information:
   ├── Company Name: _______________
   ├── Primary Contact: _______________
   ├── Contact Email: _______________
   ├── Industry: _______________
   ├── Plan Selection: □ Starter □ Professional □ Enterprise
   ├── Custom Domain: _______________
   └── Special Requirements: _______________
   ```

2. **Requirements Analysis**
   - Determine service tier requirements
   - Identify integration needs
   - Assess compliance requirements (GDPR, HIPAA)
   - Plan resource allocation

3. **SOW Creation**
   - Create Statement of Work
   - Define project scope
   - Set timeline expectations
   - Identify stakeholders

**Deliverables**:
- Client information form
- Requirements document
- Timeline confirmation

### Step 1.2: Technical Assessment
**Agent**: Platform-Architect
**Duration**: 15-20 minutes

1. **Infrastructure Requirements**
   - Calculate expected load
   - Plan database requirements
   - Assess scaling needs
   - Identify dependencies

2. **Integration Planning**
   - Third-party API requirements
   - SSO/Auth provider
   - Analytics and tracking
   - Support system integration

3. **Security Assessment**
   - Compliance requirements
   - Data residency needs
   - Security standards
   - Audit requirements

**Deliverables**:
- Technical requirements document
- Infrastructure plan
- Security assessment

---

## Phase 2: Infrastructure Provisioning

### Step 2.1: GitHub Repository Setup
**Agent**: GitHub-Branch-Manager
**Duration**: 30-45 minutes

1. **Create Repository**
   ```bash
   # Create from template
   gh api repos/create \
     --template-owner {org} \
     --template-repo client-system-template \
     --name {clientname}-system \
     --org {org} \
     --visibility private
   ```

2. **Configure Branches**
   - Protect `main` branch
   - Create `dev` branch
   - Set branch protection rules

3. **Add Teams**
   - Create client admin team
   - Create developer team
   - Set permissions
   - Add initial collaborators

4. **Configure CI/CD**
   - Set up GitHub Actions workflows
   - Configure branch triggers
   - Add security scanning

**Deliverables**:
- Repository URL
- Branch structure confirmed
- Teams configured

### Step 2.2: Render Service Provisioning
**Agent**: Render-Service-Manager
**Duration**: 30-45 minutes

1. **Create Production Service**
   - Connect to GitHub repo
   - Select `main` branch
   - Configure build settings
   - Enable auto-deploy

2. **Create Development Service**
   - Connect to same repo
   - Select `dev` branch
   - Configure for testing
   - Set development environment

3. **Create Database**
   - Provision PostgreSQL
   - Configure region
   - Set access controls
   - Note credentials securely

4. **Configure Domains**
   ```
   Production: {clientname}.saasforge.ai
   Development: dev.{clientname}.saasforge.ai
   ```

**Deliverables**:
- Production service URL
- Development service URL
- Database credentials (secure)

---

## Phase 3: Configuration & Branding

### Step 3.1: Core Configuration
**Agent**: Client-Config-Manager
**Duration**: 30-45 minutes

1. **Environment Variables**
   ```bash
   # Required Variables
   CLIENT_NAME={clientname}
   CLIENT_SUBDOMAIN={clientname}
   CLIENT_PLAN={plan}
   CLIENT_DISPLAY_NAME={Display Name}
   
   # Database (from Render)
   DATABASE_URL={connection_string}
   
   # Branding
   BRAND_LOGO_URL={logo_url}
   BRAND_PRIMARY_COLOR={#hex}
   BRAND_SECONDARY_COLOR={#hex}
   ```

2. **Feature Flags**
   - Enable based on plan
   - Configure beta features
   - Set up gradual rollouts

3. **Third-Party Integration**
   - Configure API keys
   - Set up webhooks
   - Configure analytics
   - Add support integration

**Deliverables**:
- Configuration complete
- Feature flags set
- Integrations configured

### Step 3.2: Branding Setup
**Agent**: Client-Config-Manager
**Duration**: 20-30 minutes

1. **Visual Identity**
   - Upload client logo
   - Set brand colors
   - Configure fonts
   - Apply custom CSS

2. **Communication Templates**
   - Email templates
   - Invoice templates
   - Notification templates
   - Support templates

3. **Custom Domain**
   - Verify DNS ownership
   - Configure SSL
   - Set up redirects
   - Test HTTPS

**Deliverables**:
- Branding applied
- Domain configured
- SSL active

### Step 3.3: User & Access Setup
**Agent**: Access-Controller
**Duration**: 15-20 minutes

1. **Admin Account**
   - Create primary admin
   - Set permissions
   - Configure MFA
   - Send welcome email

2. **Initial Users**
   - Pre-provision test users
   - Configure roles
   - Set up groups
   - Document access levels

3. **SSO Configuration** (if applicable)
   - Configure SSO provider
   - Set up SAML/OIDC
   - Test authentication
   - Document SSO process

**Deliverables**:
- Admin account active
- User list ready
- SSO configured (if applicable)

---

## Phase 4: Testing & Validation

### Step 4.1: System Testing
**Agent**: Onboarding-Coordinator
**Duration**: 30-45 minutes

1. **Infrastructure Tests**
   ```
   Test Checklist:
   □ Production service responding
   □ Development service responding
   □ Database connectivity verified
   □ Health check endpoint working
   □ SSL certificate valid
   □ Domain DNS resolved
   ```

2. **Configuration Tests**
   ```
   □ Environment variables loaded
   □ Branding applied correctly
   □ Feature flags working
   □ Third-party integrations active
   □ Email sending verified
   ```

3. **Integration Tests**
   ```
   □ User creation working
   □ Authentication functional
   □ API endpoints responding
   □ Webhooks triggering
   □ Analytics tracking
   ```

**Deliverables**:
- Test results report
- Issues identified
- Fixes applied

### Step 4.2: Security Validation
**Agent**: Security-Specialist
**Duration**: 20-30 minutes

1. **Security Audit**
   - Verify tenant isolation
   - Check encryption in transit
   - Validate access controls
   - Review audit logging

2. **Compliance Check**
   - GDPR requirements met
   - Data residency confirmed
   - Consent mechanisms in place
   - Privacy policy linked

3. **Vulnerability Scan**
   - Run security scan
   - Check for exposed secrets
   - Verify no default credentials
   - Test authentication

**Deliverables**:
- Security audit report
- Compliance checklist
- Vulnerabilities remediated

### Step 4.3: Performance Testing
**Agent**: Analytics-Specialist
**Duration**: 20-30 minutes

1. **Load Testing**
   - Test concurrent users
   - Measure response times
   - Check resource usage
   - Verify scaling behavior

2. **Database Testing**
   - Test query performance
   - Check connection pooling
   - Verify backup procedures
   - Test recovery

**Deliverables**:
- Performance report
- Bottlenecks identified
- Optimizations applied

---

## Phase 5: Go-Live Preparation

### Step 5.1: Documentation
**Agent**: Onboarding-Coordinator
**Duration**: 20-30 minutes

1. **Client Documentation**
   - Platform guide
   - User manual
   - Admin guide
   - API documentation

2. **Operations Documentation**
   - Deployment procedures
   - Backup procedures
   - Incident response
   - Support escalation

3. **Transfer Documentation**
   - System architecture
   - Access credentials
   - Contact information
   - SLA documentation

**Deliverables**:
- Client documentation package
- Operations runbook
- Handover checklist

### Step 5.2: Training
**Agent**: Onboarding-Coordinator
**Duration**: 30-60 minutes

1. **Admin Training**
   - Platform overview
   - User management
   - Configuration options
   - Troubleshooting

2. **User Training**
   - Basic platform usage
   - Common workflows
   - Getting help
   - FAQ

3. **Dev Team Handoff**
   - Repository walkthrough
   - Deployment process
   - Monitoring tools
   - On-call procedures

**Deliverables**:
- Training sessions completed
- Q&A addressed
- Team confident on platform

### Step 5.3: Go-Live Checklist
**Agent**: Onboard-Master
**Duration**: 15-20 minutes

```
Go-Live Approval Checklist:
=========================

Infrastructure:
□ GitHub repository created
□ Production service deployed
□ Development service deployed
□ Database provisioned
□ Domains configured
□ SSL active

Configuration:
□ Environment variables set
□ Branding applied
□ Feature flags configured
□ Integrations active

Security:
□ Tenant isolation verified
□ Access controls configured
□ Security scan passed
□ Compliance requirements met

Testing:
□ System tests passed
□ Security validation complete
□ Performance acceptable
□ User acceptance testing passed

Documentation:
□ Client documentation delivered
□ Operations runbook complete
□ Training completed
□ Contacts documented

Approval: _________________ Date: _____________
```

**Deliverables**:
- Signed go-live checklist
- Stakeholder approval
- Handover complete

---

## Phase 6: Post-Go-Live

### Step 6.1: Monitoring Setup
**Agent**: Onboarding-Coordinator
**Duration**: 15-20 minutes

1. **Set Up Monitoring**
   - Configure dashboards
   - Set up alerts
   - Enable log aggregation
   - Configure uptime monitoring

2. **Define SLAs**
   - Uptime requirements
   - Response time targets
   - Support availability
   - Escalation paths

3. **Create Clients**
   - Add to client monitoring
   - Set up billing
   - Configure support ticket routing
   - Schedule check-ins

**Deliverables**:
- Monitoring active
- SLAs documented
- Support configured

### Step 6.2: Handover
**Agent**: Onboard-Master
**Duration**: 15-30 minutes

1. **Handover Meeting**
   - Present system overview
   - Review documentation
   - Introduce support team
   - Q&A session

2. **Transfer Access**
   - Transfer domain management
   - Provide admin credentials
   - Document recovery procedures
   - Set up communication channel

3. **Post-Onboarding Review**
   - Schedule 1-week check-in
   - Schedule 30-day review
   - Set up feedback mechanism
   - Document lessons learned

**Deliverables**:
- Handover complete
- Client operational
- Support relationship established

---

## Timeline Summary

| Phase | Duration | Owner |
|-------|----------|-------|
| Phase 1: Requirements | 30-50 min | Onboarding-Coordinator, Platform-Architect |
| Phase 2: Infrastructure | 60-90 min | GitHub-Branch-Manager, Render-Service-Manager |
| Phase 3: Configuration | 65-95 min | Client-Config-Manager, Access-Controller |
| Phase 4: Testing | 80-105 min | Onboarding-Coordinator, Security-Specialist, Analytics-Specialist |
| Phase 5: Go-Live | 65-110 min | Onboarding-Coordinator, Onboard-Master |
| Phase 6: Post-Go-Live | 30-50 min | Onboarding-Coordinator, Onboard-Master |
| **Total** | **5.5-8.5 hours** | |

---

## Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| Domain verification fails | Check DNS propagation, verify CNAME records |
| CI/CD failing | Review build logs, check environment variables |
| Database connection error | Verify DATABASE_URL, check network access |
| Branding not applying | Clear cache, check variable names |
| SSL certificate issue | Wait for propagation, verify domain ownership |

### Emergency Rollback

If issues persist during onboarding:
1. Pause deployment
2. Rollback to previous state
3. Investigate root cause
4. Fix and re-test
5. Resume onboarding

---

## Version History

- **v1.0** (2026-04-16): Initial multi-client onboarding procedure
- End-to-end onboarding workflow
- Testing and validation phases
- Go-live preparation and handover

---

**Document Owner**: SaaSForge AI Operations Team
**Review Cycle**: Quarterly
**Last Updated**: 2026-04-16
