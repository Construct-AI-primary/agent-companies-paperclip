---
title: SaaSForge AI GitHub Workflow Procedure
date: 2026-04-16
status: Active
scope: GitHub repository management, branch workflows, and CI/CD automation
agents:
  - github-branch-manager
  - deployment-orchestrator
  - devops-engineer
---

# SaaSForge AI GitHub Workflow Procedure

This document defines the comprehensive procedure for managing GitHub repositories, branches, and workflows within SaaSForge AI's white-label multi-client deployment architecture.

## Overview

Each client company receives:
- **Dedicated Repository**: `github.com/{org}/{clientname}-system`
- **Protected Branch**: `main` (production)
- **Development Branch**: `dev` (staging/testing)
- **CI/CD Pipeline**: Automated testing and deployment

## Risk Assessment

**Overall Risk Level: LOW to MEDIUM**
- **Code Loss**: Branch protection prevents accidental deletion
- **Deployment Errors**: CI/CD validation gates prevent bad deploys
- **Security**: Branch protection and code review requirements

## Prerequisites

### Required Access
- [ ] GitHub organization with admin rights
- [ ] GitHub Personal Access Token configured
- [ ] Template repository available

### Agent Availability
- [ ] GitHub-Branch-Manager (`saasforge-ai-github-branch-manager`)
- [ ] Deployment-Orchestrator (`saasforge-ai-deployment-orchestrator`)
- [ ] DevOps-Engineer (`saasforge-ai-devops-engineer`)

---

## Phase 1: Repository Setup

### Step 1.1: Repository Creation
**Agent**: GitHub-Branch-Manager
**Duration**: 15-30 minutes

1. **Create from Template**
   ```bash
   # Option 1: Use GitHub API
   gh api repos/create \
     --template-owner {template-org} \
     --template-repo client-system-template \
     --name {clientname}-system \
     --org {your-org} \
     --visibility private
   ```

2. **Configure Repository Settings**
   - Set default branch to `dev`
   - Enable Issues
   - Configure PR templates
   - Set up branch protection

3. **Initial Configuration**
   - Add `.github/` workflows
   - Configure `render.yaml`
   - Set up `.env.example`
   - Add `README.md`

**Deliverables**:
- Repository created
- Initial configuration complete
- Documentation ready

### Step 1.2: Branch Structure Setup
**Agent**: GitHub-Branch-Manager
**Duration**: 10-15 minutes

1. **Create Branches**
   ```bash
   # From default branch (usually main), create dev
   git checkout -b dev
   git push origin dev
   ```

2. **Branch Protection Rules for `main`**
   ```yaml
   protection:
     required_status_checks:
       strict: true
       contexts:
         - ci/test
         - ci/lint
         - ci/build
     enforce_admins: true
     required_reviewers:
       minimum: 1
     require_code_owner_reviews: true
     dismiss_stale_reviews: true
     require_linear_history: false
     allow_force_pushes: false
     allow_deletions: false
   ```

3. **Branch Protection for `dev`**
   ```yaml
   protection:
     required_status_checks:
       contexts:
         - ci/test
     enforce_admins: false
     allow_force_pushes: true
     allow_deletions: false
   ```

**Deliverables**:
- Branches created
- Protection rules configured
- Documentation updated

### Step 1.3: Collaborator Access
**Agent**: GitHub-Branch-Manager
**Duration**: 10-15 minutes

1. **Team Access Levels**
   | Role | Permission | Access To |
   |------|------------|-----------|
   | Admin | Admin | Full repo control |
   | Maintain | Maintain | Branches, settings |
   | Push | Write | Code, PRs |
   | Triage | Triage | Issues, PRs |
   | Read | Read | View only |

2. **Configure Teams**
   ```
   {clientname}-admins: Admin
   {clientname}-developers: Push
   saasforge-automation: Admin (for deployments)
   ```

3. **Add Collaborators**
   ```bash
   # Add team
   gh api repos/{org}/{repo}/teams/{team}/repos/{owner}/{repo} \
     --method PUT \
     --field permission=push
   
   # Add individual
   gh api repos/{owner}/{repo}/collaborators/{username} \
     --method PUT \
     --field permission=push
   ```

**Deliverables**:
- Teams configured
- Collaborators added
- Access documented

---

## Phase 2: CI/CD Pipeline Setup

### Step 2.1: GitHub Actions Workflows
**Agent**: DevOps-Engineer
**Duration**: 30-45 minutes

1. **CI Workflow** (`.github/workflows/ci.yml`)
   ```yaml
   name: CI
   
   on:
     push:
       branches: [main, dev]
     pull_request:
       branches: [main, dev]
   
   jobs:
     test:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         - uses: actions/setup-node@v4
           with:
             node-version: '20'
         - run: npm ci
         - run: npm test
         - run: npm run lint
   
     build:
       needs: test
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         - run: npm ci
         - run: npm run build
         - uses: actions/upload-artifact@v4
           with:
             name: build
             path: dist/
   ```

2. **Deploy Workflow** (`.github/workflows/deploy.yml`)
   ```yaml
   name: Deploy
   
   on:
     push:
       branches:
         main: {client}.saasforge.ai
         dev: dev.{client}.saasforge.ai
   
   jobs:
     deploy-prod:
       if: github.ref == 'refs/heads/main'
       runs-on: ubuntu-latest
       steps:
         - name: Deploy to Production
           run: |
             curl -X POST $RENDER_DEPLOY_HOOK
             echo "Production deploy triggered"
   
     deploy-dev:
       if: github.ref == 'refs/heads/dev'
       runs-on: ubuntu-latest
       steps:
         - name: Deploy to Development
           run: |
             curl -X POST $RENDER_DEV_DEPLOY_HOOK
             echo "Development deploy triggered"
   ```

3. **Security Scanning**
   ```yaml
   name: Security Scan
   
   on:
     push:
       branches: [main, dev]
   
   jobs:
     security:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         - uses: snyk/actions/node@master
           env:
             SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
   ```

**Deliverables**:
- CI workflow configured
- Deploy workflow configured
- Security scanning enabled

### Step 2.2: Required Status Checks
**Agent**: GitHub-Branch-Manager
**Duration**: 10-15 minutes

1. **Configure Branch Protection**
   - Require status checks before merge
   - List required checks:
     - `ci/test`
     - `ci/lint`
     - `ci/build` (for main only)
     - `security/scan` (optional)

2. **Require Recent Checks**
   - Dismiss stale approvals
   - Require re-review after changes
   - Block force-push to main

3. **Code Owner Review**
   - Add CODEOWNERS file
   - Require code owner for sensitive areas
   ```yaml
   # .github/CODEOWNERS
   * @saasforge/admins
   /src/security/ @saasforge/security
   /infra/ @saasforge/devops
   ```

**Deliverables**:
- Status checks configured
- Code owners set up
- Protection enforced

---

## Phase 3: Development Workflow

### Step 3.1: Feature Development
**Agent**: Developer (human or agent)
**Duration**: Per feature

1. **Create Feature Branch**
   ```bash
   git checkout dev
   git pull origin dev
   git checkout -b feature/{feature-name}
   ```

2. **Develop & Commit**
   ```bash
   # Make changes
   git add .
   git commit -m "feat: add new feature"
   git push origin feature/{feature-name}
   ```

3. **Open Pull Request**
   ```bash
   gh pr create \
     --title "feat: new feature" \
     --body "## Description\n\nAdds new feature.\n\n## Testing\n\n- [ ] Tests added\n- [ ] Manual QA complete" \
     --base dev
   ```

4. **Code Review**
   - Reviewer approves
   - CI checks pass
   - Squash and merge

**Deliverables**:
- Feature branch created
- PR opened and approved
- Changes merged to dev

### Step 3.2: Staging Validation
**Agent**: QA (human or agent)
**Duration**: Per feature

1. **Automatic Deployment**
   - Push to dev triggers auto-deploy
   - Service deploys to `dev.{client}.saasforge.ai`
   - Automated smoke tests run

2. **Manual Testing**
   - Test new feature functionality
   - Verify no regressions
   - Check performance impact

3. **Sign-Off**
   - QA approves feature
   - Mark PR ready for production
   - Create merge to main PR

**Deliverables**:
- Staging validation complete
- Feature approved for production

### Step 3.3: Production Deployment
**Agent**: Deployment-Orchestrator
**Duration**: Per deployment

1. **Merge to Main**
   ```bash
   # Create PR from dev to main
   gh pr create --base main --head dev
   
   # Or merge if all checks pass
   gh pr merge --squash
   ```

2. **Automatic Deployment**
   ```
   Push to main
           ↓
   CI runs tests
           ↓
   Deploy workflow triggers
           ↓
   Render deploys to production
           ↓
   Health checks pass
           ↓
   Client sees update
   ```

3. **Post-Deployment**
   - Monitor for issues
   - Verify functionality
   - Close feature branch

**Deliverables**:
- Production deployed
- Monitoring active
- Client notified

---

## Phase 4: Hotfix Procedures

### Step 4.1: Emergency Fix
**Agent**: Deployment-Orchestrator
**Duration**: 15-30 minutes

1. **Create Hotfix Branch**
   ```bash
   git checkout main
   git pull origin main
   git checkout -b hotfix/{issue-name}
   ```

2. **Quick Fix**
   ```bash
   # Make minimal fix
   git add .
   git commit -m "hotfix: urgent fix"
   git push origin hotfix/{issue-name}
   ```

3. **Fast-Track Review**
   ```bash
   # Create PR directly to main
   gh pr create --base main --head hotfix/{issue-name}
   
   # Request expedited review
   gh pr review --approve
   gh pr merge --squash
   ```

4. **Deploy Hotfix**
   - Auto-deploy to production
   - Monitor closely
   - Document issue and fix

**Deliverables**:
- Hotfix deployed
- Issue documented
- Post-mortem scheduled

### Step 4.2: Rollback via Git
**Agent**: GitHub-Branch-Manager
**Duration**: 10-15 minutes

1. **Identify Good Commit**
   ```bash
   git log --oneline
   # Find last good commit hash
   ```

2. **Revert or Reset**
   ```bash
   # Option 1: Revert (creates new commit)
   git revert {bad-commit-hash}
   git push origin main
   
   # Option 2: Reset (only if safe)
   git checkout main
   git reset --hard {good-commit-hash}
   git push --force-with-lease origin main
   ```

3. **Verify**
   - Check CI passes
   - Verify deployment
   - Monitor for issues

**Deliverables**:
- Code rolled back
- Service healthy
- Issue resolved

---

## Phase 5: Repository Maintenance

### Step 5.1: Dependency Updates
**Agent**: Dependabot (automated) or DevOps-Engineer
**Duration**: Weekly

1. **Automated Updates**
   - Dependabot creates PRs for:
     - npm dependencies
     - GitHub Actions
     - Docker images
   - Run security updates automatically

2. **Review & Merge**
   ```bash
   # Check pending updates
   gh pr list --label dependencies
   
   # Batch merge safe updates
   gh pr merge --admin --squash
   ```

3. **Test in Dev**
   - Verify updates work
   - Check for breaking changes
   - Merge to production

**Deliverables**:
- Dependencies updated
- No breaking changes
- Security patches applied

### Step 5.2: Repository Archival
**Agent**: GitHub-Branch-Manager
**Duration**: 30-60 minutes

1. **Archive Process**
   ```bash
   # Archive repository
   gh api repos/{owner}/{repo} \
     --method PATCH \
     --field archived=true
   
   # Or delete after retention
   gh api repos/{owner}/{repo} \
     --method DELETE
   ```

2. **Preserve History**
   - Export issues and PRs
   - Save wiki content
   - Archive deployment history

3. **Update Documentation**
   - Mark as archived
   - Update links
   - Notify stakeholders

**Deliverables**:
- Repository archived
- Data preserved
- Documentation updated

---

## Troubleshooting

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| CI failing | Test errors | Fix tests, update snapshots |
| PR blocked | Missing reviews | Request review, bypass if urgent |
| Webhook not firing | GitHub outage | Manual deploy trigger |
| Merge conflict | Concurrent changes | Rebase, resolve conflicts |
| Lost code | Force push | Use reflog, restore from backup |

### Emergency Contacts

- **GitHub-Branch-Manager**: Repository configuration issues
- **Deployment-Orchestrator**: CI/CD failures
- **DevOps-Engineer**: Build and security problems

---

## Version History

- **v1.0** (2026-04-16): Initial GitHub workflow procedure
- Repository creation and configuration
- CI/CD pipeline setup
- Development and hotfix workflows

---

**Document Owner**: SaaSForge AI Operations Team
**Review Cycle**: Quarterly
**Last Updated**: 2026-04-16
