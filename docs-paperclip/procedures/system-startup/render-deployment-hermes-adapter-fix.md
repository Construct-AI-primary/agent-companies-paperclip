---
title: Render Deployment - Hermes Adapter Command Fix
summary: Fix for "Failed to start command 'hermes'" error in Render deployments
---

# Render Deployment - Hermes Adapter Command Fix

## Problem

Agents fail to execute in Render deployment with error:
```
Failed to start command "hermes" in ".". Verify adapter command, working directory, and PATH
```

## Root Cause

The agent adapter configuration specifies `"hermes"` as the command, but the hermes binary is not available in the Render deployment environment's PATH.

## Solutions

### Option 1: Install Hermes in Render Environment (Recommended)

#### Step 1: Update render.yaml
Add hermes installation to your Render deployment:

```yaml
# render.yaml
services:
  - type: web
    name: paperclip
    envVars:
      - key: PYTHON_VERSION
        value: 3.11
    buildCommand: |
      # Install system dependencies
      apt-get update && apt-get install -y python3 python3-pip python3-venv

      # Install hermes-agent
      pip install hermes-agent

      # Your existing build commands...
      npm ci
      npm run build
```

#### Step 2: Verify Installation
Add to your start command or Dockerfile:

```bash
# Verify hermes is available
which hermes || echo "Hermes not found in PATH"
hermes --version || echo "Hermes installation failed"
```

### Option 2: Update Adapter Configuration Path

#### Step 1: Find Current Adapter Config
```sql
-- Check current adapter configurations
SELECT
    id,
    name,
    adapter_config
FROM agents
WHERE adapter_config::text LIKE '%hermes%'
ORDER BY name;
```

#### Step 2: Update to Full Path
```sql
-- Update adapter command to full path
UPDATE agents
SET adapter_config = jsonb_set(
    adapter_config,
    '{command}',
    '"./hermes_agent/run.sh"'
)
WHERE adapter_config->>'command' = 'hermes';

-- Or if using absolute path in container:
UPDATE agents
SET adapter_config = jsonb_set(
    adapter_config,
    '{command}',
    '"/opt/render/project/src/hermes_agent/run.sh"'
)
WHERE adapter_config->>'command' = 'hermes';
```

### Option 3: Environment-Specific Adapter Config

#### Step 1: Create Environment Variable
Set in Render dashboard or render.yaml:
```
ADAPTER_COMMAND=./hermes_agent/run.sh
```

#### Step 2: Update Adapter Config to Use Variable
```sql
-- Use environment variable for command
UPDATE agents
SET adapter_config = jsonb_set(
    adapter_config,
    '{command}',
    concat('"', current_setting('ADAPTER_COMMAND', true), '"')::jsonb
)
WHERE adapter_config->>'command' = 'hermes';
```

## Verification Steps

### 1. Check Adapter Configuration
```sql
SELECT
    id,
    name,
    adapter_config->>'command' as command,
    adapter_config->>'workingDirectory' as working_dir
FROM agents
WHERE adapter_config IS NOT NULL;
```

### 2. Test Command Availability
```bash
# In Render shell or build process
cd /opt/render/project/src
ls -la hermes_agent/run.sh
./hermes_agent/run.sh --help 2>/dev/null || echo "Script not executable"
```

### 3. Verify Agent Execution
After applying fix, trigger a test run:

```bash
curl -X POST \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"agentId": "AGENT_ID"}' \
  http://your-render-url.com/api/agents/AGENT_ID/heartbeat/invoke
```

## Troubleshooting

### Command Not Found
**Symptoms:** Still getting "command not found"
**Solutions:**
1. Verify the script exists: `ls -la hermes_agent/run.sh`
2. Check execute permissions: `chmod +x hermes_agent/run.sh`
3. Use absolute path instead of relative

### Working Directory Issues
**Symptoms:** "No such file or directory" for relative paths
**Solutions:**
1. Set `workingDirectory` in adapter config: `{"workingDirectory": "/opt/render/project/src"}`
2. Use absolute paths for all commands
3. Ensure hermes_agent directory is in the correct location

### Python/Environment Issues
**Symptoms:** Python import errors or virtual environment issues
**Solutions:**
1. Ensure hermes_agent/.env has correct API keys
2. Check Python path: `python3 -c "import sys; print(sys.path)"`
3. Verify virtual environment activation in run.sh

## Prevention

### 1. Build Verification
Add to your build process:

```bash
# build.sh or render.yaml buildCommand
echo "Verifying hermes installation..."
if ! command -v hermes >/dev/null 2>&1 && [ ! -x "./hermes_agent/run.sh" ]; then
    echo "ERROR: Neither hermes command nor run.sh script available"
    exit 1
fi
echo "✓ Adapter command available"
```

### 2. Configuration Validation
Create a startup check:

```bash
# In your application startup
node -e "
const config = require('./check-adapter-config.js');
// Validate all agent adapter configs
// Exit with error if any are misconfigured
"
```

### 3. Environment-Specific Configs
Use different adapter configurations per environment:

```javascript
// config/adapters.js
const adapters = {
  development: {
    command: 'hermes',
    workingDirectory: '.'
  },
  production: {
    command: './hermes_agent/run.sh',
    workingDirectory: '/opt/render/project/src'
  }
};

module.exports = adapters[process.env.NODE_ENV || 'development'];
```

## Related Procedures

- [System Startup Procedure](../system-startup/paperclip-service-startup-and-documentation-loading-procedure.md)
- [Adapter URL Migration](../adapters/adapter-url-migration-procedure.md)

## Emergency Fix

If agents are failing immediately, temporarily disable heartbeats:

```sql
-- Temporarily disable failing agents
UPDATE agents
SET runtime_config = jsonb_set(
    runtime_config,
    '{heartbeat,enabled}',
    'false'
)
WHERE adapter_config->>'command' = 'hermes';
```

Then re-enable after applying the fix above.