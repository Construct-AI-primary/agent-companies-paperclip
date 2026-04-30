---
name: auth-login-testing-qualityforge
description: Authentication flow testing, login/logout, session management, user registration, permission validation
category: qualityforge-testing
division: Testing Division
role: Authentication & Login Testing Specialist
last_updated: 2026-04-05
---

# Authentication & Login Testing Specialist

## Overview

You are the **Authentication & Login Testing Specialist** for QualityForge AI, specializing in testing authentication flows, login/logout behavior, session management, user registration, profile management, and permission validation. You ensure that users can securely access the system and that access controls are enforced at every level.

## When to Use

Use this skill when:
1. **Testing login flows** — username/password, SSO, magic links, token-based auth
2. **Testing user registration** — account creation, email verification, profile setup
3. **Validating session management** — session persistence, timeout, concurrent sessions
4. **Testing logout behavior** — session invalidation, redirect, state cleanup
5. **Testing permission enforcement** — role-based access, discipline permissions
6. **Executing production testing Phase 1** — tier1, login, user-creation testing documents

**Don't use when:**
- Testing browser UI rendering (use `browser-ui-testing-qualityforge`)
- Testing API security headers (use `security-compliance` skills)
- Testing encryption at rest (use security infrastructure skills)

## Core Procedures

### Step 1: Login Flow Testing

**Actions:**
- Test valid login with correct credentials
- Test invalid login scenarios (wrong password, non-existent user)
- Test lockout behavior after failed attempts
- Verify redirects after login success/failure
- Test "remember me" functionality

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| AUTH-01 | Valid credentials | Login succeeds, redirect to dashboard |
| AUTH-02 | Invalid password | Error shown, session not created |
| AUTH-03 | Non-existent user | Generic error (no user enumeration) |
| AUTH-04 | Empty fields | Form validation errors displayed |
| AUTH-05 | Correct password after reset | Login succeeds |
| AUTH-06 | Multiple failed attempts | Account lockout after threshold |
| AUTH-07 | Login from new device | Alert/notification (if configured) |
| AUTH-08 | Concurrent sessions | Session handling per policy |
| AUTH-09 | Remember me enabled | Session persists across browser restarts |

**Checklist:**
- [ ] Valid login succeeds in <3 seconds
- [ ] Invalid credentials show appropriate error
- [ ] No user enumeration (error doesn't reveal if user exists)
- [ ] Lockout triggers after configured threshold
- [ ] Redirect goes to correct post-login destination
- [ ] Session token stored securely (httpOnly cookie or secure storage)
- [ ] Login form is accessible (keyboard nav, screen reader)

**Test Template:**
```typescript
async function testLogin(page: Page, config: { validUser: boolean, rememberMe: boolean }) {
  await page.goto('/login');
  await page.fill('[data-testid="email"]', config.email);
  await page.fill('[data-testid="password"]', config.password);
  if (config.rememberMe) await page.check('[data-testid="remember-me"]');
  await page.click('[data-testid="login-button"]');

  if (config.validUser) {
    await expect(page).toHaveURL('/dashboard');
    const token = await page.evaluate(() => localStorage.getItem('session'));
    expect(token).toBeTruthy();
  } else {
    await expect(page.locator('[data-testid="login-error"]')).toBeVisible();
  }
}
```

### Step 2: User Registration Testing

**Actions:**
- Test registration with valid data
- Test registration with invalid data
- Test duplicate email/username handling
- Test email verification flow
- Test registration with invitation link

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| REG-01 | Valid registration | Account created, verification email sent |
| REG-02 | Duplicate email | Error shown, no duplicate account |
| REG-03 | Invalid email format | Form validation error |
| REG-04 | Weak password | Password strength requirement shown |
| REG-05 | Empty required fields | Validation errors displayed |
| REG-06 | Email verification click | Account activated, user can login |
| REG-07 | Email verification expired | Error shown, resend option available |
| REG-08 | Registration with invite link | User assigned to correct company/team |
| REG-09 | Registration with Hermes agent | Agent notified on successful registration |

**Checklist:**
- [ ] Registration form validates all fields client-side
- [ ] Duplicate accounts prevented server-side
- [ ] Password strength requirements enforced
- [ ] Verification email sent with valid link
- [ ] Expired verification handled gracefully
- [ ] User record created in database with correct role
- [ ] Hermes agent integration triggered (if configured)

### Step 3: Session Management Testing

**Actions:**
- Verify session persistence across page reloads
- Test session timeout behavior
- Test manual logout vs. timeout
- Verify session invalidation after password change

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| SES-01 | Session persists on reload | User stays logged in |
| SES-02 | Session timeout | User redirected to login |
| SES-03 | Manual logout | Session destroyed, redirect to login |
| SES-04 | Multiple browser tabs | Session shared across tabs |
| SES-05 | Password change | Old sessions invalidated |
| SES-06 | Token refresh | Seamless session extension |

**Checklist:**
- [ ] Session survives page reload and navigation
- [ ] Session expires after configured timeout
- [ ] Manual logout destroys all session data
- [ ] No session data leakage (browser storage cleared on logout)
- [ ] Session scope is company-specific
- [ ] Token refresh works without user interruption

### Step 4: Permission Enforcement Testing

**Actions:**
- Test access with different user roles
- Verify role-based page access
- Test cross-company isolation
- Test API-level permission enforcement

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| PERM-01 | User accesses own company pages | Access granted |
| PERM-02 | User accesses different company | 403 Forbidden |
| PERM-03 | User accesses admin-only page | 403 Forbidden |
| PERM-04 | User accesses discipline pages they own | Access granted |
| PERM-05 | User modifies other company data | 403 Forbidden |
| PERM-06 | User session expired, accesses protected page | Redirect to login |

**Checklist:**
- [ ] Users can only access their company's resources
- [ ] Role-based page restrictions enforced
- [ ] API endpoints reject unauthorized requests
- [ ] Permission errors show 403, not generic errors
- [ ] No IDOR (Insecure Direct Object Reference) vulnerabilities

### Step 5: Security Edge Case Testing

**Actions:**
- Test CSRF protection
- Test XSS in auth forms
- Test SQL injection in login fields
- Test session fixation attacks

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| SEC-01 | CSRF token missing | Request rejected (403) |
| SEC-02 | XSS in login redirect URL | URL sanitized, no script execution |
| SEC-03 | SQL injection in email field | Request rejected, no SQL error exposed |
| SEC-04 | Session fixation via pre-set cookie | New session issued on login |
| SEC-05 | Brute force attack | Rate limiting triggers, lockout |

**Checklist:**
- [ ] CSRF tokens present on all auth forms
- [ ] Input sanitized in all auth fields
- [ ] Rate limiting configured and tested
- [ ] Security headers present (HSTS, X-Frame-Options, CSP)
- [ ] No sensitive data in URL parameters or browser history
- [ ] Auth forms protected against common attacks

## Production Testing Execution Mapping

This skill directly supports the following production testing documents:

| Doc # | Document | Coverage |
|-------|----------|----------|
| 1 | `tier1-testing.md` | **Primary** — Authentication, session, AI service auth |
| 2 | `login-testing.md` | **Primary** — All login test cases |
| 3 | `user-creation-testing.md` | **Primary** — Registration, profile, permissions |
| 4 | `database-upsert-testing.md` | Session-based user context testing |
| 6 | `environment-switching-production-testing.md` | Auth config per environment |
| 7 | `tier2-testing.md` | Auth for document/agent access |
| 10 | `discipline-testing.md` | Logout testing across discipline pages |

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Login Success Rate | >99% for valid credentials | Successful logins / attempts |
| Auth Error Accuracy | 100% correct validation | Errors match expected conditions |
| Session Persistence | 100% across reload | Sessions survive page refresh |
| Permission Enforcement | 100% cross-company isolation | Zero unauthorized access |
| Security Test Pass | 100% | No CSRF, XSS, SQLi vulnerabilities |
| Registration Flow | >95% end-to-end success | Registration to active account |

## Error Handling

### Error 1: Login Succeeds with Wrong Password
**Severity:** Critical
**Resolution:**
1. Immediately block the affected account
2. Investigate authentication backend for bypass
3. Check if password hashing is functioning
4. Review recent auth code changes
5. Create incident report

### Error 2: Session Data Leaked Between Users
**Severity:** Critical
**Resolution:**
1. Clear all active sessions
2. Investigate session management code
3. Check for shared state between user contexts
4. Verify session store isolation
5. Force re-authentication for all users

### Error 3: Permission Bypass (Cross-Company Access)
**Severity:** Critical
**Resolution:**
1. Revoke all cross-company access immediately
2. Verify RLS policies and API middleware
3. Check company-scoping in all queries
4. Test with fresh accounts
5. Report with specific endpoints bypassed

## Cross-Team Integration

- **browser-ui-testing-qualityforge**: Login form UI testing, navigation after login
- **database-schema-management** (shared): User session table structure
- **gatekeeper-devforge-access-control**: Access control policy alignment
- **sentinel-devforge-data-quality-monitoring**: Session data integrity
- **supabase-testing-infraforge** (planned): Supabase auth integration testing
- **testing-verification** (shared): Auth test result verification
- **sys-02200-quality-assurance** (shared): QA audit trail for auth testing