---
memory_layer: durable_knowledge
para_section: pages/tier2-testing
gigabrain_tags: testing, high-priority, document-management, procurement, agents, discipline-pages
openstinger_context: tier2-testing-documentation
last_updated: 2026-04-02
---

# 🟡 **TIER 2: HIGH PRIORITY (Test Second)**

After core systems are solid, focus on primary workflows and modules that handle key business logic.

### 5. **Document Management System**
Essential for content-centric workflows; test file handling thoroughly.

- **Document Upload, Storage, and Retrieval**:
  - Test Cases:
    - Upload PDFs/images; verify storage in Supabase/FileStore.
    - Retrieve: Access via UI; download works.
    - Permissions: Non-owners blocked.
  - Edge Cases: Large files (>100MB), corrupted uploads.
  - Testing Type: File handling E2E tests.
  - Prerequisites: File storage configured.
  - Outcomes: Reliable uploads/downloads.

- **Document Version Control**:
  - Test Cases:
    - Upload new version; check history/tracking.
    - Rollback: Revert to older version.
  - Testing Type: Versioning API tests.
  - Outcomes: Historical integrity.

- **PDF Generation and Viewing**:
  - Test Cases: Generate/export PDFs; viewer renders correctly.
  - Viewing: Zoom, search in embeds.
  - Outcomes: Full PDF lifecycle.

- **OCR Processing**:
  - Test Cases: Upload scanned doc; extract text accurately.
  - Accuracy checks: Compare against sample text.
  - Testing Type: OCR library unit tests.
  - Outcomes: High-fidelity text extraction.

### 6. **Procurement & Contracts**
Core to project management; test end-to-end workflows.

- **Pre-Award Contracts**:
  - Test Cases:
    - Create draft contracts; review stages.
    - Approval workflows: Submit for review, approvals.
  - Testing Type: Workflow E2E.
  - Outcomes: Contracts progress smoothly.

- **Post-Award Contracts**:
  - Test Cases: Execution phases; milestones tracking.
  - Amendments: Edit post-award; version control.

- **Procurement Workflows**:
  - Test Cases: RFPs, bids; automate notifications.
  - Edge Cases: Bid deadlines, rejections.

- **Supplier Management and Vetting**:
  - Test Cases:
    - Add vet suppliers; check vetting scores.
    - Search/filter: Find vetted suppliers.
  - Testing Type: CRUD tests.
  - Outcomes: Procured items quality-assured.

### 7. **Agent System & Automation**
Advanced AI features; test for automation reliability.

- **Agent Creation and Execution**:
  - Test Cases:
    - Create agents; run tasks (e.g., data analysis).
    - Execution: Monitor outputs; errors handled.
  - Testing Type: Agent simulation tests.
  - Outcomes: Autonomous tasks succeed.

- **Workflow Execution**:
  - Test Cases: Chain agents; end-to-end flows.
  - Dependencies: Agent A completes for Agent B.

- **HITL (Human-in-the-Loop) Review Process**:
  - Test Cases: Flag for human review; human input integrates.
  - Notifications: Alerts sent/received.

- **Agent Monitoring Dashboard**:
  - Test Cases: View logs, metrics; alerts on failures.
  - Testing Type: Dashboard UI tests.
  - Outcomes: Transparency in automation.

### 8. **Discipline-Specific Pages**
Test key domains to ensure module usability.

- **Engineering Modules (Civil, Electrical, Mechanical, etc.)**:
  - Test Cases:
    - Load modules; specific tools (e.g., Civil drawings).
    - Cross-module data shared correctly.
  - Edge Cases: Module-specific errors.

- **Safety & HSSE**:
  - Test Cases: Hazard reporting, compliance checks.
  - Workflows: Incident escalations.

- **Quality Assurance/Quality Control**:
  - Test Cases: QC checklists, approvals.

- **Project Controls & Scheduling**:
  - Test Cases: Gantt charts, resource allocation.
  - Testing Type: Module-specific E2E.
  - Outcomes: Discipline pages functional and integrated.

## 📋 **Recommended Testing Sequence for TIER 2**
| Sub-Step | Component | Estimated Effort | Notes |
|----------|-----------|------------------|-------|
| 2A | Document Management | 45-60 min | Core content ops. |
| 2B | Procurement + Contracts | 45-60 min | Business-critical. |
| 2C | Agent System | 45-60 min | AI automation. |
## Error Reporting and Tracking

If any tests in this tier fail:

- Immediately halt further testing in this tier (optional, but recommended) or note failures.
- Create a new MD document in `/Users/chadferguson/Documents/construct_ai/docs-construct-ai/error-tracking/`
- Use filename convention: `error-tier2-[component]-[timestamp].md` e.g., `error-tier2-docs-2026-04-02T120000.md`
- Content structure (format it as below in the new doc):

---
memory_layer: durable_knowledge
para_section: pages/error-tracking
gigabrain_tags: error, tier2, [component], fix-needed
openstinger_context: error-documentation
last_updated: [current-date]
---

## Error Details

- **Tier**: TIER 2 (High Priority)
- **Component**: [Specific component where error occurred, e.g., Document Management System]
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
| 2D | Discipline Pages (spot check Civil, Electrical, HSSE) | 60-90 min | Key modules only. |