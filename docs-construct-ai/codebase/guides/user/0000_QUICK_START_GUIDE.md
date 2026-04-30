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
# OpenClaw QA Integration - Quick Start Guide

## Overview

This guide provides step-by-step instructions for setting up and using OpenClaw with Construct AI QA agents for UI/UX testing on a separate device.

---

## Prerequisites

- Python 3.9+
- Git
- Access to the Construct AI repository
- A separate device for testing (recommended for safety)

---

## Option 1: Quick Export and Test (Recommended)

### Step 1: Export QA Agents

On your **development machine**:

```bash
# Navigate to the project directory
cd /Users/_General/Mar-09-1

# Run the export script
./scripts/export_qa_agents.sh

# This creates a package in ./qa_agents_package/
```

### Step 2: Transfer to Test Device

```bash
# Copy the package to your test device
scp ./qa_agents_package/construct_ai_qa_agents_*.tar.gz user@test-device:/path/to/qa/

# Or use USB/cloud storage as needed
```

### Step 3: Setup on Test Device

On your **test device**:

```bash
# Extract the package
tar -xzf construct_ai_qa_agents_*.tar.gz
cd construct_ai_qa_agents_*

# Run setup
./scripts/setup.sh

# Verify installation
./scripts/run_tests.sh --health
```

### Step 4: Run Tests

```bash
# Discover available capabilities
./scripts/run_tests.sh --discover

# Run UI integration tests
./scripts/run_tests.sh --task-type ui_integration_test

# Run in headless mode (for CI/CD)
./scripts/run_tests.sh --task-type ui_integration_test --headless

# Run full QA suite
./scripts/run_tests.sh --task-type full_qa_suite
```

---

## Option 2: Git Worktree Approach

### Step 1: Create QA Branch

```bash
# Create and switch to QA branch
git checkout -b qa-testing-branch

# Create a worktree for isolated testing
git worktree add ../construct_ai_qa qa-testing-branch
```

### Step 2: Setup QA Environment

```bash
cd ../construct_ai_qa

# Install dependencies
pip install playwright aiohttp pydantic python-dotenv
playwright install chromium

# Copy OpenClaw files
cp /path/to/openclaw_qa_agent.py .
cp /path/to/openclaw_config.json .
```

### Step 3: Run Tests

```bash
# Check agent health
python openclaw_qa_agent.py --health

# Run tests
python openclaw_qa_agent.py --task-type ui_integration_test
```

---

## Option 3: Docker Container (Most Isolated)

### Step 1: Create Dockerfile

```dockerfile
# Dockerfile.qa
FROM python:3.9-slim

WORKDIR /app

# Copy agent files
COPY deep-agents/ /app/deep-agents/
COPY openclaw_qa_agent.py /app/
COPY openclaw_config.json /app/
COPY requirements.txt /app/

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt
RUN playwright install --with-deps chromium

# Create non-root user
RUN useradd -m qauser && chown -R qauser:qauser /app
USER qauser

CMD ["python", "openclaw_qa_agent.py", "--health"]
```

### Step 2: Build and Run

```bash
# Build the image
docker build -f Dockerfile.qa -t construct-ai-qa .

# Run tests
docker run --rm construct-ai-qa python openclaw_qa_agent.py --discover
docker run --rm construct-ai-qa python openclaw_qa_agent.py --task-type ui_integration_test
```

---

## Configuration

### Basic Configuration

Edit `openclaw_config.json` to customize your testing:

```json
{
  "openclaw": {
    "agents": {
      "ui_integration_testing": {
        "config": {
          "base_url": "http://your-app-url:3000",
          "browser": "chromium",
          "headless": true,
          "slow_mo": 500
        }
      }
    }
  }
}
```

### Environment Variables

Create `.env.qa` for environment-specific settings:

```bash
# .env.qa
APP_URL=http://localhost:3000
BROWSER=chromium
HEADLESS=true
SLOW_MO=1000
SCREENSHOT_ON_FAILURE=true
```

---

## Available Test Types

### 1. UI Integration Tests
Tests complete user workflows with browser automation.

```bash
./scripts/run_tests.sh --task-type ui_integration_test
```

**Tests:**
- 01900 Procurement workflow (19 stages)
- 01700 Logistics workflow (5 stages)
- UI tab navigation
- Document downloads
- Screenshot capture on failures

### 2. Document Validation
Validates generated documents for completeness.

```bash
./scripts/run_tests.sh --task-type document_validation
```

**Validates:**
- SOW documents
- Appendix A-F
- Import/Export documentation
- CDC documentation

### 3. Test Discovery
Discovers available tests in the codebase.

```bash
./scripts/run_tests.sh --task-type test_discovery
```

### 4. Full QA Suite
Runs all test types in sequence.

```bash
./scripts/run_tests.sh --task-type full_qa_suite
```

---

## Understanding Test Results

### Console Output

```
============================================================================
OpenClaw QA Agent - Executing Task: task_20260312_143022
Task Type: ui_integration_test
============================================================================

Starting UI integration tests for workflows: ['01900_procurement', '01700_logistics']

📊 Test Results Summary:
  Workflows Tested: 2
  Tests Executed: 4
  Tests Passed: 4
  Tests Failed: 0
  Documents Downloaded: 24
```

### Generated Reports

- `ui_integration_test_report.json` - Detailed JSON report
- `ui_integration_test_summary.md` - Human-readable summary
- `./ui_test_screenshots/` - Screenshots on failures
- `./downloads/` - Downloaded documents

---

## Safety Features

### Isolation Mode
- ✅ Separate database for QA testing
- ✅ Mock external API calls
- ✅ Test data only (no production data)
- ✅ Network isolation

### Access Control
- ✅ Separate credentials for QA environment
- ✅ Read-only access to production data (if needed)
- ✅ Audit logging for all QA activities

### Code Safety
- ✅ Never run QA agents against production
- ✅ Feature flags for test mode
- ✅ Circuit breakers for external calls

---

## Troubleshooting

### Issue: Browser Not Found

```bash
# Install Playwright browsers
playwright install chromium
```

### Issue: Application Not Running

```bash
# Start the application first
npm run dev  # or your start command
```

### Issue: Selector Not Found

- Check that UI selectors match the actual application
- Update selectors in the agent code if UI changes
- Use browser developer tools to inspect elements

### Issue: Timeout Errors

- Increase timeout values in config
- Check application performance
- Ensure stable network connection

### Issue: Import Errors

```bash
# Make sure you're in the correct directory
cd construct_ai_qa_agents_*

# Verify Python path
python -c "import sys; print(sys.path)"

# Reinstall dependencies
pip install -r requirements.txt
```

---

## Advanced Usage

### Custom Test Scenarios

Create custom test scenarios in Python:

```python
from openclaw_qa_agent import OpenClawQAAgent
import asyncio

async def run_custom_tests():
    agent = OpenClawQAAgent()
    
    # Custom procurement scenario
    task = {
        "type": "ui_integration_test",
        "workflows": ["01900_procurement"],
        "scenarios": [
            {
                "name": "High-Value Equipment Procurement",
                "workflow": "01900_procurement",
                "procurement_data": {
                    "group": "2",
                    "category": "5",
                    "items": "5 x Mining Excavators CAT 320",
                    "destination": "Guinea",
                    "value": "1200000",
                    "type": "1",
                    "requirements": "ISO 9001 certification required",
                    "timeline": "2"
                }
            }
        ],
        "config": {
            "headless": False,
            "slow_mo": 1000
        }
    }
    
    results = await agent.execute_qa_task(task)
    print(results)

asyncio.run(run_custom_tests())
```

### CI/CD Integration

Add to your CI/CD pipeline:

```yaml
# .github/workflows/qa-tests.yml
name: QA Tests

on: [push, pull_request]

jobs:
  qa-tests:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.9'
      
      - name: Install dependencies
        run: |
          pip install playwright aiohttp pydantic python-dotenv
          playwright install --with-deps chromium
      
      - name: Run QA tests
        run: |
          python openclaw_qa_agent.py --task-type full_qa_suite --headless
      
      - name: Upload test artifacts
        uses: actions/upload-artifact@v3
        if: always()
        with:
          name: qa-test-results
          path: |
            ui_integration_test_report.json
            ui_integration_test_summary.md
            ui_test_screenshots/
```

---

## Next Steps

1. **Run Initial Tests**: Start with `--discover` to verify setup
2. **Configure Workflows**: Customize which workflows to test
3. **Set Up CI/CD**: Integrate into your development pipeline
4. **Expand Coverage**: Add more test scenarios as needed
5. **Monitor Results**: Review reports and screenshots regularly

---

## Support

For issues or questions:
- Check the troubleshooting section above
- Review `OPENCLAW_QA_INTEGRATION_PLAN.md` for detailed documentation
- Examine test artifacts for debugging
- Verify browser and application compatibility

---

**Last Updated**: March 12, 2026
**Version**: 1.0.0