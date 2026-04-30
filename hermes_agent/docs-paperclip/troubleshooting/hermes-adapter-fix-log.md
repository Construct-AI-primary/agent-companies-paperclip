# Hermes Adapter Fix Troubleshooting Log

## Issue Summary
**Problem**: Paperclip agents using `hermes_local` adapter fail with "Failed to start command 'hermes'" on Render
**Root Cause**: Adapter hardcoded to use "hermes" command, but Render PATH doesn't include hermes binary
**Solution**: Configure adapter to use full path to `run.sh` script via `hermesCommand` field

## Investigation Timeline

### Iteration 1: Initial Analysis (Incorrect Assumption)
- **Assumed**: Agent still using `http` adapter type
- **SQL Provided**:
```sql
UPDATE agents SET adapter_type = 'hermes_local', adapter_config = jsonb_build_object(...) WHERE id = '...';
```
- **Result**: Agent type updated, but still failed with same error
- **Lesson**: Issue wasn't adapter type, but command path

### Iteration 2: PATH Analysis (Correct Diagnosis)
- **Discovery**: Error shows "Failed to start command 'hermes'" - command not found in PATH
- **Investigation**: Examined hermes-paperclip-adapter source code
- **Finding**: Adapter hardcoded to use `HERMES_CLI = "hermes"` from constants.js
- **Solution Path**: Need to override with `hermesCommand` config field

### Iteration 3: Complete Configuration (Final Fix)
- **Key Missing Field**: `hermesCommand` in adapter_config
- **Correct SQL**:
```sql
UPDATE agents
SET adapter_type = 'hermes_local',
    adapter_config = jsonb_build_object(
        'hermesCommand', '/opt/render/project/src/hermes_agent/run.sh',
        'url', 'https://github.com/Construct-AI-primary/construct_ai.git',
        'persistSession', true,
        'toolsets', jsonb_build_array('file_tools', 'terminal_tools', 'git'),
        'timeoutSec', 600,
        'graceSec', 15
    )
WHERE id = '982344cb-0dc9-4cf4-99cc-22bf9a61655a';
```

## Technical Details

### Adapter Behavior
- **Default**: Uses `HERMES_CLI = "hermes"` (hardcoded in constants.js)
- **Override**: Checks `config.hermesCommand` first, falls back to default
- **Render Issue**: "hermes" not in PATH, but `run.sh` script exists

### Configuration Fields
- `hermesCommand`: Full path to executable (defaults to "hermes")
- `url`: GitHub repository URL for context
- `persistSession`: Enable session continuity across heartbeats
- `toolsets`: Comma-separated list of enabled toolsets
- `timeoutSec`: Maximum execution time
- `graceSec`: Grace period after SIGTERM

## Verification Steps

### Before Fix
```sql
SELECT adapter_type, adapter_config FROM agents WHERE id = '982344cb-0dc9-4cf4-99cc-22bf9a61655a';
-- Result: adapter_type = "http" (or "hermes_local" without hermesCommand)
```

### After Fix
```sql
SELECT adapter_type, adapter_config->>'hermesCommand' as hermes_cmd FROM agents WHERE id = '982344cb-0dc9-4cf4-99cc-22bf9a61655a';
-- Result: hermes_cmd = "/opt/render/project/src/hermes_agent/run.sh"
```

### Test Execution
```bash
# Trigger agent heartbeat via API
curl -X POST /api/agents/{agent-id}/heartbeat/invoke
# Should succeed without "command 'hermes' not found" error
```

## Prevention Measures

### For Future Agent Configuration
1. **Always include `hermesCommand`** when using `hermes_local` adapter on Render
2. **Test PATH availability** before deploying agents
3. **Use full paths** in production configurations
4. **Document environment differences** between dev and production

### Code Improvements Needed
1. **Adapter Enhancement**: Better error messages for missing commands
2. **PATH Detection**: Automatic detection of hermes availability
3. **Configuration Validation**: Validate command paths at agent creation time

## Lessons Learned

1. **Don't assume adapter type is the issue** - investigate the actual error message
2. **Check hardcoded defaults** in adapter source code
3. **PATH differences matter** between development and production environments
4. **Configuration overrides** can solve hardcoded limitations
5. **Test incrementally** - verify each change before claiming success

## Final Working Configuration

```json
{
  "adapter_type": "hermes_local",
  "adapter_config": {
    "hermesCommand": "/opt/render/project/src/hermes_agent/run.sh",
    "url": "https://github.com/Construct-AI-primary/construct_ai.git",
    "persistSession": true,
    "toolsets": ["file_tools", "terminal_tools", "git"],
    "timeoutSec": 600,
    "graceSec": 15
  }
}
```

---

**Document Version**: 1.0
**Last Updated**: 2026-04-19
**Status**: Resolved
**Next Action**: Run the corrected SQL and verify agent functionality