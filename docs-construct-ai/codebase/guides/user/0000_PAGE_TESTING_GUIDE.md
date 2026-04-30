---
memory_layer: durable_knowledge
para_section: pages/codebase/guides
gigabrain_tags: guides, codebase, documentation
documentation
openstinger_context: development-guides, implementation-guidance
last_updated: 2026-03-21
related_docs:
  - codebase/guides/
  - disciplines/
---
# Comprehensive Page Testing Guide - Construct AI

## Overview

This guide explains how to use the comprehensive page tester to test all 152+ pages in the Construct AI application.

---

## What Gets Tested

### Page Types and Counts

| Page Type | Count | Description |
|-----------|-------|-------------|
| Discipline | 27 | Engineering discipline pages with background images and navigation |
| Data Management | 20 | CRUD interfaces for data management |
| Workflow Processing | 29 | Process automation and workflow handling |
| Data Collection | 4 | Forms and onboarding pages |
| Document Processing | 10 | File and document handling |
| Time Tracking | 2 | Time management functionality |
| Scheduling | 7 | Scheduling and timeline tools |
| Reporting | 3 | Analytics and dashboards |
| Utility | 50 | Settings, tools, and configuration |
| **Total** | **152** | |

---

## What Each Test Checks

### For All Pages
- ✅ **Page Loading**: Does the page load successfully?
- ✅ **HTTP Status**: Is the response status < 400?
- ✅ **Load Time**: How fast does the page load? (warns if >3s, errors if >10s)
- ✅ **Page Title**: What is the page title?
- ✅ **Buttons**: What buttons are present on the page?
- ✅ **Forms**: What forms are present?
- ✅ **Modals**: What modal dialogs exist?
- ✅ **Tabs**: What tab elements are present?

### Page-Specific Tests

#### Discipline Pages (27 pages)
Tests for:
- Background image presence
- Navigation elements
- State buttons (Agents, Upserts, Workspace)
- Modal trigger buttons
- Chatbot container
- Logout button

Example pages:
- `/construction`
- `/civil-engineering`
- `/electrical-engineering`
- `/director-procurement`

#### Data Management Pages (20 pages)
Tests for:
- CRUD buttons (Add, Create, Edit, Delete, Save, Cancel)
- Search and filter functionality
- Data tables
- Form inputs

Example pages:
- `/procurement`
- `/logistics`
- `/safety`
- `/user-management`

#### Workflow Processing Pages (29 pages)
Tests for:
- Workflow indicators (Step, Stage, Progress)
- Navigation buttons (Next, Previous, Submit)
- Approval workflows
- Document generation

Example pages:
- `/document-ordering-management`
- `/logistics-documents/export`
- `/templates-forms-management`

#### Data Collection Pages (4 pages)
Tests for:
- Form inputs (minimum 2 expected)
- Submit buttons
- Validation messages

Example pages:
- `/user-signup`
- `/form-creation`
- `/cv-processing`

#### Document Processing Pages (10 pages)
Tests for:
- Upload functionality
- Download buttons
- Preview capabilities
- Document indicators

Example pages:
- `/document-control`
- `/technical-drawings`
- `/electrical-schematics`

---

## Usage

### Quick Start

```bash
# Test all 152 pages
python run_page_tests.py

# Quick test (first 5 pages only)
python run_page_tests.py --max-pages 5

# Test only discipline pages
python run_page_tests.py --page-type discipline

# Watch the browser work (useful for debugging)
python run_page_tests.py --no-headless
```

### Command Line Options

```
--url URL              Base URL (default: http://localhost:3000)
--no-headless          Show browser window
--max-pages N          Test only first N pages
--page-type TYPE       Test only specific page type
--slow-mo MS           Slow down actions (default: 500ms)
--timeout MS           Page load timeout (default: 30000ms)
```

### Page Types

```
discipline             27 discipline pages
data_management        20 data management pages
workflow_processing    29 workflow pages
data_collection        4 data collection pages
document_processing    10 document processing pages
time_tracking          2 time tracking pages
scheduling             7 scheduling pages
reporting              3 reporting/dashboard pages
utility                50 utility/configuration pages
```

---

## Test Reports

### Generated Files

After running tests, you'll find:

```
page_test_reports/
├── page_test_report_20260312_143022.json    # Detailed JSON report
└── page_test_summary_20260312_143022.md     # Human-readable summary

page_test_screenshots/
├── _construction_20260312_143022.png        # Screenshots on failures
├── _procurement_20260312_143023.png
└── ...
```

### JSON Report Structure

```json
{
  "title": "Comprehensive Page Test Report",
  "version": "1.0.0",
  "timestamp": "2026-03-12T14:30:22.000Z",
  "summary": {
    "total_pages": 152,
    "pages_tested": 152,
    "pages_passed": 145,
    "pages_failed": 7,
    "pass_rate": "95.4%"
  },
  "results_by_type": {
    "discipline": {
      "total": 27,
      "passed": 25,
      "failed": 2,
      "avg_load_time_ms": 1250
    },
    ...
  },
  "page_results": [
    {
      "url": "/construction",
      "page_type": "discipline",
      "status": "passed",
      "load_time_ms": 1150,
      "title": "Construction - Construct AI",
      "buttons_found": ["Agents", "Upserts", "Workspace", "Construction"],
      "forms_found": [],
      "modals_found": [],
      "tabs_found": [],
      "errors": [],
      "warnings": [],
      "screenshot": null
    },
    ...
  ]
}
```

### Markdown Report Example

```markdown
# Comprehensive Page Test Report

**Generated**: 2026-03-12T14:30:22.000Z
**Version**: 1.0.0

## Summary

| Metric | Value |
|--------|-------|
| Total Pages | 152 |
| Pages Tested | 152 |
| Pages Passed | 145 ✓ |
| Pages Failed | 7 ✗ |
| Pass Rate | 95.4% |

## Results by Page Type

| Page Type | Total | Passed | Failed | Avg Load Time |
|-----------|-------|--------|--------|---------------|
| discipline | 27 | 25 | 2 | 1250ms |
| data_management | 20 | 20 | 0 | 980ms |
| workflow_processing | 29 | 28 | 1 | 1450ms |
...

## Failed Pages

### /construction
- **Type**: discipline
- **Errors**: HTTP 500
- **Screenshot**: ./page_test_screenshots/_construction_20260312_143022.png

## Slow Pages (>3s load time)

- **/document-ordering-management**: 4500ms
- **/logistics-documents/export**: 3200ms
```

---

## Understanding Test Results

### Status Values

- **passed**: Page loaded successfully with no errors
- **failed**: Page had errors (HTTP error, slow load, or exception)
- **skipped**: Page was skipped (not tested)

### Common Warnings

- "No background image found" - Discipline page missing background
- "No navigation found" - Page missing navigation elements
- "No CRUD buttons found" - Data management page missing CRUD buttons
- "Slow load: Xms" - Page took longer than 3 seconds to load
- "Only N form inputs found" - Data collection page has few inputs

### Common Errors

- "HTTP 500" - Server error
- "HTTP 404" - Page not found
- "Slow load: Xms" - Page took longer than 10 seconds
- "TimeoutError" - Page didn't load within timeout period
- "Connection refused" - Application not running

---

## Troubleshooting

### Issue: All tests fail with "Connection refused"

**Solution**: Make sure your application is running:
```bash
npm run dev
# or
yarn dev
```

### Issue: Tests are very slow

**Solution**: Reduce slow-mo or run in headless mode:
```bash
python run_page_tests.py --slow-mo 100
python run_page_tests.py  # headless by default
```

### Issue: Want to see what's happening

**Solution**: Run with visible browser:
```bash
python run_page_tests.py --no-headless --slow-mo 1000
```

### Issue: Only want to test specific pages

**Solution**: Use max-pages or page-type:
```bash
python run_page_tests.py --max-pages 10
python run_page_tests.py --page-type discipline
```

### Issue: Screenshots not being captured

**Solution**: Check that the screenshots directory is writable:
```bash
mkdir -p page_test_screenshots
chmod 755 page_test_screenshots
```

---

## Integration with CI/CD

### GitHub Actions Example

```yaml
name: Page Tests

on: [push, pull_request]

jobs:
  page-tests:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.9'
      
      - name: Install dependencies
        run: |
          pip install playwright
          playwright install --with-deps chromium
      
      - name: Start application
        run: |
          npm install
          npm run dev &
          sleep 10
      
      - name: Run page tests
        run: |
          python run_page_tests.py --max-pages 20
      
      - name: Upload test artifacts
        uses: actions/upload-artifact@v3
        if: always()
        with:
          name: page-test-results
          path: |
            page_test_reports/
            page_test_screenshots/
```

---

## Best Practices

1. **Run regularly**: Include in your CI/CD pipeline
2. **Start small**: Use `--max-pages 5` for quick feedback
3. **Check screenshots**: Review failure screenshots for debugging
4. **Monitor trends**: Track pass rate over time
5. **Update selectors**: If UI changes, update test selectors
6. **Use staging**: Test against staging environment before production

---

## Advanced Usage

### Custom Configuration

Create a custom config file:

```python
from comprehensive_page_tester import ComprehensivePageTester

config = {
    "base_url": "http://staging.construct-ai.com",
    "headless": True,
    "slow_mo": 200,
    "timeout": 60000,
    "screenshots": {
        "on_failure": True,
        "on_success": True,  # Capture all screenshots
        "directory": "./custom_screenshots"
    },
    "test_options": {
        "max_pages": 50,
        "check_buttons": True,
        "check_forms": True,
        "check_modals": True,
        "check_tabs": True,
    }
}

async with ComprehensivePageTester(config) as tester:
    results = await tester.test_all_pages()
```

### Testing Specific Page Types

```bash
# Test only discipline pages (27 pages)
python run_page_tests.py --page-type discipline

# Test only data management pages (20 pages)
python run_page_tests.py --page-type data_management

# Test only workflow pages (29 pages)
python run_page_tests.py --page-type workflow_processing
```

---

## Summary

The comprehensive page tester provides:

- ✅ **152 pages** tested systematically
- ✅ **10 page types** with specific tests
- ✅ **Performance monitoring** with load time tracking
- ✅ **Element detection** for buttons, forms, modals, tabs
- ✅ **Screenshot capture** on failures
- ✅ **Detailed reports** in JSON and Markdown
- ✅ **CI/CD ready** for automated testing

Use it to ensure all your pages are working correctly and performing well!