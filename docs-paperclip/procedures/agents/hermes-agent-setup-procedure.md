# Hermes Agent Setup Procedure

This procedure documents the complete process for installing and configuring the Hermes AI agent in a Paperclip development environment.

## Overview

Hermes Agent is a powerful AI coding assistant with 90+ tools for development tasks. This procedure covers installation, configuration, and integration with VS Code using the Agent Client Protocol (ACP).

## Prerequisites

- macOS, Linux, or Windows development environment
- Python 3.11+ installed
- VS Code installed (for ACP integration)
- OpenRouter API key (or other LLM provider)
- Git repository access

## Installation Steps

### Step 1: Clone and Setup Hermes Agent

1. **Navigate to the hermes_agent directory:**
   ```bash
   cd /Users/_Hermes/paperclip-render/hermes_agent
   ```

2. **Verify the installation:**
   ```bash
   ls -la
   ```
   Expected output should show the hermes_agent directory with Python files, virtual environment, and configuration files.

3. **Activate the virtual environment:**
   ```bash
   source venv/bin/activate
   ```

4. **Verify Hermes is available:**
   ```bash
   which hermes
   ```
   Expected output: `/Users/_Hermes/paperclip-render/hermes_agent/venv/bin/hermes`

### Step 2: Configure API Keys

1. **Check the .env file:**
   ```bash
   cat .env
   ```

2. **Verify OpenRouter API key is configured:**
   The .env file should contain:
   ```
   OPENROUTER_API_KEY=sk-or-v1-...
   ```

3. **Test API connectivity:**
   ```bash
   ./hermes status
   ```

### Step 3: Install ACP Support (VS Code Integration)

1. **Install ACP extra dependencies:**
   ```bash
   pip install -e ".[acp]"
   ```

2. **Verify ACP registry exists:**
   ```bash
   ls -la acp_registry/
   ```
   Expected files:
   - `agent.json` - Agent configuration
   - `icon.svg` - Hermes icon

3. **Check agent.json configuration:**
   ```bash
   cat acp_registry/agent.json
   ```
   Should contain proper command path: `/Users/_Hermes/paperclip-render/hermes_agent/venv/bin/hermes`

### Step 4: Configure VS Code Integration

1. **Create VS Code workspace settings:**
   Create `.vscode/settings.json` in the workspace root:
   ```json
   {
     "acpClient.agents": [
       {
         "name": "hermes-agent",
         "registryDir": "/Users/_Hermes/paperclip-render/hermes_agent/acp_registry"
       }
     ]
   }
   ```

2. **Install ACP Client extension:**
   - Open VS Code
   - Press `Cmd+Shift+X` (Extensions)
   - Search for "ACP Client"
   - Install `anysphere.acp-client` or `formulahendry.acp-client`

3. **Restart VS Code:**
   - Quit VS Code completely (`Cmd+Q`)
   - Reopen VS Code

### Step 5: Test Hermes Functionality

#### Terminal Mode (Primary Method)

1. **Start interactive chat:**
   ```bash
   cd hermes_agent
   source venv/bin/activate
   ./hermes chat
   ```

2. **Test basic functionality:**
   Type: "List the files in the current directory"
   Expected: Hermes should execute `ls` and respond with file listing.

3. **Test quick commands:**
   ```bash
   ./hermes_agent/run.sh "analyze this codebase"
   ```

#### VS Code ACP Mode (Alternative)

1. **Open ACP panel:**
   - Look for ACP icon in VS Code sidebar
   - Click to open ACP Chat panel

2. **Connect to agent:**
   - Click "🔌 Connect to Agent"
   - Select "Hermes Agent" from dropdown
   - Or click "⚙ Add Agent" and browse to the acp_registry directory

3. **Test ACP functionality:**
   Type: "What is this project about?"
   Expected: Hermes should analyze the codebase and provide a summary.

## Configuration Options

### Environment Variables

Key environment variables in `.env`:

```bash
# LLM Provider
OPENROUTER_API_KEY=sk-or-v1-...

# Terminal Configuration
TERMINAL_ENV=local
TERMINAL_CWD=.

# Browser Tools
BROWSERBASE_API_KEY=...
BROWSERBASE_PROJECT_ID=...

# Voice Tools
VOICE_TOOLS_OPENAI_KEY=...
```

### VS Code Settings

Workspace `.vscode/settings.json`:
```json
{
  "acpClient.agents": [
    {
      "name": "hermes-agent",
      "registryDir": "/Users/_Hermes/paperclip-render/hermes_agent/acp_registry"
    }
  ]
}
```

### Hermes Configuration

User config at `~/.hermes/config.yaml`:
```yaml
model:
  default: "anthropic/claude-opus-4.6"
  provider: "openrouter"
  base_url: "https://openrouter.ai/api/v1"

terminal:
  env_type: "local"
  cwd: "."

compression:
  enabled: true
  threshold: 0.85
```

## Troubleshooting

### Common Issues

#### "ACP client not started" Error

**Symptoms:** VS Code ACP panel shows connection error.

**Solutions:**
1. **Start ACP server manually:**
   ```bash
   cd hermes_agent && source venv/bin/activate && ./hermes acp
   ```
   Leave this terminal running, then try connecting in VS Code.

2. **Check agent.json path:**
   Verify the command path in `acp_registry/agent.json` points to the correct hermes binary.

3. **Restart VS Code:**
   Sometimes a complete restart is needed for settings to take effect.

#### "UnboundLocalError: cannot access local variable 'ctx_len'" Error

**Symptoms:** Hermes crashes on startup with variable error.

**Solution:** This bug has been fixed in the current installation. If encountered:
1. The error occurs in `cli.py` line 2201
2. Move the `ctx_len = None` initialization before the if/else block
3. Restart Hermes

#### API Key Issues

**Symptoms:** "No valid credentials" or authentication errors.

**Solutions:**
1. **Check .env file:**
   ```bash
   grep OPENROUTER_API_KEY .env
   ```

2. **Test API key:**
   ```bash
   ./hermes status
   ```

3. **Alternative providers:**
   Configure other LLM providers in `.env`:
   ```bash
   GLM_API_KEY=...
   KIMI_API_KEY=...
   ```

#### Virtual Environment Issues

**Symptoms:** "hermes command not found" or import errors.

**Solutions:**
1. **Activate virtual environment:**
   ```bash
   source venv/bin/activate
   ```

2. **Check Python path:**
   ```bash
   which python
   which hermes
   ```

3. **Reinstall if needed:**
   ```bash
   pip install -e .
   ```

### Performance Optimization

1. **Enable context compression:**
   ```yaml
   compression:
     enabled: true
     threshold: 0.85
   ```

2. **Configure model routing:**
   ```yaml
   smart_model_routing:
     enabled: true
     cheap_model: "anthropic/claude-haiku-3.5"
   ```

3. **Set appropriate timeouts:**
   ```bash
   TERMINAL_TIMEOUT=60
   ```

## Verification Checklist

- [ ] Hermes agent directory exists and is accessible
- [ ] Virtual environment is active (`venv/bin/activate`)
- [ ] API key is configured in `.env`
- [ ] `hermes status` works without errors
- [ ] ACP extra is installed (`pip install -e ".[acp]"`)
- [ ] VS Code ACP Client extension is installed
- [ ] `.vscode/settings.json` contains agent configuration
- [ ] Terminal mode works (`./hermes chat`)
- [ ] ACP mode works (after manual server start if needed)

## Usage Examples

### Code Analysis
```
./hermes_agent/run.sh "analyze the database schema and explain the relationships"
```

### Debugging
```
./hermes_agent/run.sh "help me debug this TypeScript error: [paste error]"
```

### Documentation
```
./hermes_agent/run.sh "generate documentation for this API endpoint"
```

### Interactive Development
```bash
cd hermes_agent
source venv/bin/activate
./hermes chat
# Now you can have ongoing conversations about your codebase
```

## Maintenance

### Updating Hermes

1. **Pull latest changes:**
   ```bash
   cd hermes_agent
   git pull
   ```

2. **Update dependencies:**
   ```bash
   source venv/bin/activate
   pip install -e .
   pip install -e ".[acp]"
   ```

3. **Test functionality:**
   ```bash
   ./hermes status
   ./hermes chat  # Quick test
   ```

### Backup Configuration

1. **Backup .env file:**
   ```bash
   cp .env .env.backup
   ```

2. **Backup VS Code settings:**
   ```bash
   cp .vscode/settings.json .vscode/settings.json.backup
   ```

3. **Backup user config:**
   ```bash
   cp ~/.hermes/config.yaml ~/.hermes/config.yaml.backup
   ```

## Security Considerations

1. **API Keys:** Never commit `.env` files to version control
2. **File Permissions:** Set restrictive permissions on config files
3. **Network Access:** Be aware that Hermes makes external API calls
4. **Command Execution:** Hermes can run terminal commands - review before approving

## Support

If issues persist:

1. **Check logs:**
   ```bash
   ./hermes --verbose status
   ```

2. **Test basic functionality:**
   ```bash
   python -c "import hermes_cli; print('Import OK')"
   ```

3. **Verify environment:**
   ```bash
   source venv/bin/activate
   python --version
   pip list | grep hermes
   ```

## Related Documentation

- [Hermes Agent README](https://github.com/NousResearch/hermes-agent)
- [ACP Specification](https://github.com/anysphere/acp)
- [Paperclip Database Schema](../schema/)
- [VS Code ACP Client](https://marketplace.visualstudio.com/items?itemName=anysphere.acp-client)

---

**Procedure Version:** 1.0
**Last Updated:** 2026-04-11
**Applicable Hermes Version:** 0.6.0
**Contact:** Development Team