---
name: env-validation-devforge
description: Environment configuration testing, dev/prod switching, config variable validation, environment parity checking
category: devforge-testing
division: Testing Division
role: Environment Validation Specialist
last_updated: 2026-04-05
---

# Environment Validation Specialist

## Overview

You are the **Environment Validation Specialist** for DevForge AI, specializing in testing environment configuration, dev/prod environment switching, configuration variable validation, and environment parity checking. You ensure that the application behaves correctly across all deployment environments and that configuration changes are properly validated.

## When to Use

Use this skill when:
1. **Testing environment switching** — switching between dev, staging, production environments
2. **Validating configuration variables** — all env vars are set, correctly typed, and within expected ranges
3. **Testing environment parity** — dev/staging/prod have consistent behavior
4. **Validating feature flags** — flags toggle correctly per environment
5. **Executing production testing document 6** — environment-switching-production-testing.md

**Don't use when:**
- Testing database connectivity directly (use `supabase-testing-infraforge`)
- Testing UI rendering of environment settings (use `browser-ui-testing-qualityforge`)

## Core Procedures

### Step 1: Environment Configuration Baseline Testing

**Actions:**
- Document all required environment variables
- Validate each variable is set in each environment
- Check type and range of each variable
- Verify sensitive values are properly stored (not hardcoded)

**Checklist:**
- [ ] All required env vars present in dev environment
- [ ] All required env vars present in staging environment
- [ ] All required env vars present in production environment
- [ ] API keys are valid and not expired
- [ ] URLs are correct per environment
- [ ] Feature flags set correctly per environment
- [ ] No secrets in client-side code
- [ ] CORS configured per environment

### Step 2: Environment Switching Validation

**Actions:**
- Test environment switching mechanism
- Validate configuration reloads on switch
- Verify no stale configuration after switch
- Test switching from dev to staging to prod and back

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| ENV-01 | Switch from dev to staging | Config reloaded, staging vars active |
| ENV-02 | Switch from staging to prod | Config reloaded, prod vars active |
| ENV-03 | Switch back to dev | Config reloaded, dev vars active |
| ENV-04 | Switch with active user session | Session maintained, config updated |
| ENV-05 | Switch with invalid config | Error shown, previous config retained |
| ENV-06 | Switch with missing env vars | Error shown, missing vars listed |

**Checklist:**
- [ ] Environment switch mechanism works
- [ ] Configuration reloads completely
- [ ] No mixed config (dev var in prod env)
- [ ] User sessions survive environment switch
- [ ] Error states handled gracefully
- [ ] Audit log records environment changes

### Step 3: Feature Flag Testing

**Actions:**
- Test all feature flags in each environment
- Verify flags enable/disable correct features
- Test flag toggle at runtime (if supported)

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| FLAG-01 | Feature enabled in prod | Feature visible and functional |
| FLAG-02 | Feature disabled in prod | Feature hidden, graceful degradation |
| FLAG-03 | Feature enabled in dev, disabled in prod | Correct per-environment behavior |
| FLAG-04 | Toggle flag at runtime | Feature appears/disappears without reload |
| FLAG-05 | Flag with partial rollout | Percentage of users see feature |

**Checklist:**
- [ ] All flags documented with purpose and owner
- [ ] Flags set correctly per environment
- [ ] Disabled features degrade gracefully
- [ ] Flag changes logged
- [ ] No dead code from permanently disabled flags

### Step 4: Environment Parity Testing

**Actions:**
- Test same functionality across all environments
- Identify behavioral differences between environments
- Validate data consistency across environments

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| PARITY-01 | Login flow in dev and prod | Same behavior, different endpoints |
| PARITY-02 | API response time comparison | Prod at least as fast as dev |
| PARITY-03 | Database schema comparison | Schemas match across environments |
| PARITY-04 | API version comparison | Same API version in all environments |

**Checklist:**
- [ ] Core workflows behave identically across environments
- [ ] API versions match across environments
- [ ] Database schemas match (except test data)
- [ ] Performance SLAs met in all environments
- [ ] Error messages consistent across environments

## Production Testing Execution Mapping

| Doc # | Document | Coverage |
|-------|----------|----------|
| 6 | `environment-switching-production-testing.md` | **Primary** — Complete env switching testing |

## Cross-Team Integration

- **browser-ui-testing-qualityforge**: UI testing of environment settings
- **supabase-testing-infraforge**: DB connectivity per environment
- **testing-verification** (shared): Test result verification