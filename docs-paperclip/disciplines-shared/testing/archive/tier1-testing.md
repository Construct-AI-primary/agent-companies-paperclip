---
memory_layer: durable_knowledge
para_section: pages/tier1-testing
gigabrain_tags: testing, critical, authentication, database, navigation, ai-llm
openstinger_context: tier1-testing-documentation
last_updated: 2026-04-02
---

# 🔴 **TIER 1: CRITICAL (Test First)**

These are the most critical components for production readiness. Test thoroughly before proceeding to other tiers. Focus on functional, integration, and security tests to ensure core app stability.

### 1. **Authentication & User Management**
Prioritize this as it underpins user access; failures here block everything.

- **Login/Logout Flows**:
  - Test Cases:
    - Manual login with valid email/password (check redirect to dashboard).
    - Logout and verify session ends (e.g., access to protected routes denied, tokens invalidated).
    - Invalid credentials: Attempt login with wrong email/password; expect error message without redirect.
    - Session timeout: Wait for session expiry and confirm automatic logout.
    - Remember me: If implemented, ensure persistent login across browser restarts.
  - Edge Cases: Multi-device login, concurrent logins, network interruptions during login.
  - Testing Type: Functional UI tests (e.g., Cypress or Playwright); integration tests for auth API calls.
  - Prerequisites: Supabase auth setup, test users created.
  - Expected Outcomes: Secure access; no leaks in JWTs.

- **User Registration**:
  - Test Cases:
    - Register new user with valid details; verify email confirmation (if enabled) and DB entry.
    - Email verification: Simulate clicking confirmation link; check account activation.
    - Invalid registration: Duplicate emails, weak passwords, missing fields; expect validation errors.
  - Testing Type: End-to-end (E2E) tests.
  - Outcomes: Smooth onboarding; no duplicate accounts.

- **Password Reset**:
  - Test Cases:
    - Request reset; check email sent. Reset password successfully; verify login post-reset.
    - Invalid resets: Wrong email, expired links.
  - Testing Type: API integration tests.
  - Outcomes: Secure process without exposing credentials.

- **User Management**:
  - Test Cases:
    - CRUD ops: Create/edit/delete user profiles; admin panels if roles exist.
    - Profile updates: Avatar upload, role changes.
  - Testing Type: Database integration tests.
  - Outcomes: Data integrity.

- **Session Handling and Token Validation**:
  - Test Cases:
    - Token expiry refresh; invalid tokens block API calls.
    - Cross-origin requests (CORS) for security.
  - Testing Type: Security tests (e.g., OWASP checks).
  - Outcomes: No session hijacks.

### 2. **Database & API Connectivity (Supabase)**
Critical for data persistence; verify Supabase setup thoroughly.

- **Database Connection Stability**:
  - Test Cases:
    - Connect and perform simple queries (e.g., SELECT); handle network failures gracefully.
    - Load tests: Simulate high traffic; check for connection drops.
    - Recovery: Test reconnections on outage.
  - Testing Type: Integration tests with mocking for outages.
  - Prerequisites: Supabase project configured.
  - Outcomes: No downtime-induced errors.

- **Row Level Security (RLS) Policies**:
  - Test Cases:
    - User A accesses only their data; RLS blocks cross-user reads/writes.
    - Admin role bypasses; non-admin blocked.
  - Testing Type: Policy unit tests in Supabase.
  - Outcomes: Data privacy enforced.

- **Data Read/Write Operations**:
  - Test Cases:
    - CRUD: Insert, update, delete records via API; validate in DB.
    - Batch ops: Multiple writes; ensure atomicity.
    - Constraints: Foreign keys, validations.
  - Testing Type: API integration tests.
  - Outcomes: Accurate data handling.

- **Real-Time Subscriptions**:
  - Test Cases:
    - Subscribe to table changes; update triggers real-time UI updates (e.g., live chat).
    - Disconnect/reconnect: Maintain state.
  - Testing Type: E2E with real-time simulation.
  - Outcomes: Live features work seamlessly.

### 3. **Core Navigation & Routing**
Ensures users can move through the app; vital for UX.

- **Main Application Routing**:
  - Test Cases:
    - Navigate via menu/buttons; check URL changes match routes.
    - Private routes: Unauthenticated users redirected to login.
  - Testing Type: UI navigation tests.
  - Outcomes: No broken routes.

- **Page Navigation Across All Discipline Modules**:
  - Test Cases:
    - Switch to Civil, Electrical, etc., modules; verify content loads.
    - Deep links: Direct URL access to a submodule.
  - Testing Type: E2E navigation flows.
  - Outcomes: Module isolation intact.

- **Broken Links and 404 Handling**:
  - Test Cases:
    - Bad URLs: Expect custom 404 page.
    - Link clicks: Scan for dead links in static/dynamic content.
  - Testing Type: Automated link crawlers (e.g., Lighthouse).
  - Outcomes: Graceful error pages.

- **Cross-Page Data Persistence**:
  - Test Cases:
    - Data survives page refreshes; form state maintained during nav.
    - Session storage/localStorage consistency.
  - Testing Type: State management tests (e.g., Redux if used).
### 4. **AI/LLM Services**
High-stakes due to external APIs; test for reliability and errors.

- **OpenAI API Integration**:
  - Test Cases:
    - Send prompts; verify responses in chatbot.
    - Rate limits: Handle 429 errors; retries.
    - API key rotations: Secure handling.
  - Testing Type: API mocking for offline tests.
  - Prerequisites: OpenAI key configured.
  - Outcomes: Reliable generations.

- **OpenRouter/Kimi K2.5 Integration**:
  - Similar to above: Test multi-model switching, fallbacks.
  - Test Cases: Model selection; error on unsupported queries.
  - Outcomes: Fallbacks work.

- **Chatbot Functionality**:
  - Test Cases:
    - User inputs; AI responds; conversation history.
    - Interruptions: Network drops during chat.
  - Testing Type: UI interaction tests.
  - Outcomes: Responsive bot.

- **Document Processing with AI (Drawing Analysis, Scope of Work Generation)**:
  - Test Cases:
    - Upload drawing; AI analyzes/extracts data.
    - Generate SOW; check accuracy against sample docs.
  - Testing Type: File upload E2E.
  - Outcomes: Accurate AI processing.

- **Vision API for Drawing Analysis (Fireworks AI)**:
  - Test Cases: Image OCR; marking detections.
  - Edge Cases: Low-quality images, unsupported formats.
  - Outcomes: Vision features functional.

## 📋 **Recommended Testing Sequence for TIER 1**
| Sub-Step | Component | Estimated Effort | Notes |
|----------|-----------|------------------|-------|
| 1A | Auth + Session Handling | 30-45 min | Start here; block other tests if fails. |
| 1B | Supabase Database | 45-60 min | Verify data layer. |
| 1C | Navigation + Routing | 30-45 min | Ensure app structure. |
| 1D | AI Services | 45-60 min | Test integrations heavily. |
## Error Reporting and Tracking

If any tests in this tier fail:

- Immediately halt further testing in this tier (optional, but recommended) or note failures.
- Create a new MD document in `/Users/chadferguson/Documents/construct_ai/docs-construct-ai/error-tracking/`
- Use filename convention: `error-tier1-[component]-[timestamp].md` e.g., `error-tier1-auth-2026-04-02T120000.md`
- Content structure (format it as below in the new doc):

---
memory_layer: durable_knowledge
para_section: pages/error-tracking
gigabrain_tags: error, tier1, [component], fix-needed
openstinger_context: error-documentation
last_updated: [current-date]
---

## Error Details

- **Tier**: TIER 1 (Critical)
- **Component**: [Specific component where error occurred, e.g., Authentication & User Management]
- **Failed Test/Symptom**: [Describe the test or feature that failed]
- **Error Message/Logs**: [Paste any error messages, stack traces, browser console logs, API response errors, etc.]
- **Steps to Reproduce**:
  1. Step 1
  2. Step 2
- **Expected Behavior**: [Describe what should happen]
- **Actual Behavior**: [Describe what actually happened]
- **Screenshots/Artifacts**: [Links to screenshots, files, or other evidence if available]
- **Environment**: [Browser version, OS, app version, Supabase config, etc.]
- **Severity**: [Critical, High, Medium, Low] (Based on impact: Critical if blocks login, High if data loss, etc.)
- **Notes**: [Any additional context from the testing agent]

## Recommended Fix Steps

- [Placeholder for initial suggestions; the fixing agent will analyze and add resolution steps]

The fixing agent will read this document and attempt to resolve the issue.
  - Outcomes: No data loss on nav.