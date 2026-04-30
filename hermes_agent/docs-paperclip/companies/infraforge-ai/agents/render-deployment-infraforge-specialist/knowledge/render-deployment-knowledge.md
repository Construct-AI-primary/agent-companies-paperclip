---
title: Render Deployment Knowledge Base
summary: Complete guide for deploying Paperclip applications on Render cloud platform
---

# Render Deployment Knowledge Base

## Overview

This knowledge base contains comprehensive information for deploying Paperclip applications on the Render cloud platform, including environment configuration, networking setup, and desktop communication integration.

## Environment Variables Configuration

### Current Render Environment Setup

Based on the provided environment variables, the following configuration is active:

```bash
# GitHub Integration
GITHUB_TOKEN=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

# Hermes Mode Configuration
HERMES_MODE=both

# AI Provider Keys
OPENROUTER_API_KEY=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

# Database Configuration
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb3JhcmhpYmlwdHZjcm52cnBpIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3MzI4MzI0OSwiZXhwIjoyMDg4ODU5MjQ5fQ.LMTbfUtyurnJDfn_aW4UIXiyMLwTUMhc70jjRAZRpIQ
SUPABASE_URL=https://gmorarhibiptvcrnvrpi.supabase.co
```

## Paperclip Deployment Modes

### Local Trusted Mode (Default)
- **Host Binding**: `127.0.0.1:3100` (loopback only)
- **Authentication**: No login required
- **Best For**: Solo development and experimentation
- **Startup**: Fastest local startup

### Authenticated + Private Mode
- **Host Binding**: `0.0.0.0:*` (all interfaces)
- **Authentication**: Login required via Better Auth
- **Network Access**: Available on Tailscale/VPN/LAN
- **Best For**: Team access over private networks

### Authenticated + Public Mode
- **Host Binding**: `0.0.0.0:*` (all interfaces)
- **Authentication**: Login required
- **URL**: Explicit public URL required
- **Security**: Stricter validation checks
- **Best For**: Cloud hosting, internet-facing deployment

## Render-Specific Deployment Steps

### 1. Service Configuration

**Web Service Setup:**
```yaml
# render.yaml
services:
  - type: web
    name: paperclip-app
    runtime: node
    buildCommand: "pnpm install && pnpm build"
    startCommand: "pnpm start"
    envVars:
      - key: NODE_ENV
        value: production
      - key: PORT
        value: 10000
      - key: DATABASE_URL
        fromSecret: paperclip_database_url
      - key: PAPERCLIP_DEPLOYMENT_MODE
        value: authenticated
      - key: PAPERCLIP_SECRETS_MASTER_KEY
        fromSecret: paperclip_master_key
```

### 2. Environment Variables Setup

**Required Secrets:**
- `PAPERCLIP_SECRETS_MASTER_KEY`: 32-byte encryption key (base64/hex/raw)
- `DATABASE_URL`: PostgreSQL connection string
- `GITHUB_TOKEN`: For GitHub integrations
- `OPENROUTER_API_KEY`: For AI model access
- `SUPABASE_SERVICE_ROLE_KEY`: For database operations
- `SUPABASE_URL`: Supabase instance URL

### 3. Database Configuration

**Supabase Integration:**
```bash
# Environment variables for Supabase
SUPABASE_URL=https://gmorarhibiptvcrnvrpi.supabase.co
SUPABASE_SERVICE_ROLE_KEY=<service-role-key>
SUPABASE_ANON_KEY=<anon-key> # If needed for client-side access
```

### 4. Networking and Security

**Firewall Configuration:**
- Allow inbound traffic on configured PORT (default: 3100)
- Restrict database access to Render service IPs
- Configure CORS for dashboard access

**SSL/TLS Setup:**
- Render provides automatic SSL certificates
- Custom domains supported
- HTTP to HTTPS redirection enabled

## Desktop Communication Setup

### Hermes Integration

**Hermes Mode Configuration:**
```bash
HERMES_MODE=both  # Supports both CLI and gateway modes
```

**Hermes Environment Variables:**
```bash
# Required for Hermes operation
OPENROUTER_API_KEY=<api-key>
HERMES_HOME=~/.hermes
HERMES_MODE=both
```

### Network Tunneling Options

#### Option 1: ngrok Integration
```bash
# Install ngrok
npm install -g ngrok

# Start tunnel
ngrok http 3100

# Configure webhook URLs
ngrok_url=$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')
```

#### Option 2: Tailscale Integration
```bash
# Install Tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# Join network
sudo tailscale up --auth-key=<auth-key>

# Get Tailscale IP
tailscale_ip=$(tailscale ip -4)
```

#### Option 3: Cloudflare Tunnel
```bash
# Install cloudflared
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
chmod +x cloudflared-linux-amd64

# Configure tunnel
./cloudflared tunnel --url http://localhost:3100
```

## Deployment Verification

### Health Checks

**Application Health:**
```bash
# Check application health
curl https://your-app.onrender.com/api/health

# Expected response: {"status": "ok"}
```

**Database Connectivity:**
```bash
# Test database connection
curl https://your-app.onrender.com/api/companies

# Should return company list without errors
```

### Performance Monitoring

**Render Metrics:**
- Response times
- Error rates
- CPU/Memory usage
- Request throughput

**Custom Monitoring:**
```bash
# Application metrics endpoint
curl https://your-app.onrender.com/api/metrics
```

## Troubleshooting Common Issues

### Database Connection Issues
```
Error: Can't reach database server
Solution: Verify DATABASE_URL format and network connectivity
```

### Authentication Failures
```
Error: Invalid credentials
Solution: Check PAPERCLIP_SECRETS_MASTER_KEY configuration
```

### Network Connectivity
```
Error: Connection refused
Solution: Verify PORT configuration and firewall rules
```

### Environment Variable Issues
```
Error: Missing required environment variable
Solution: Check Render environment variable configuration
```

## Agent Execution Troubleshooting

### Agents Not Cloning Repositories
**Symptoms:** Agent runs but outputs "nice" instead of cloning and testing
**Root Causes:**
- WORKSPACE_DIR not set, agents have no place to clone repos
- GIT_TERMINAL_PROMPT not disabled, git hangs on authentication
- GITHUB_TOKEN not passed to agent environment

**Fix (render.yaml):**
```yaml
envVars:
  - key: WORKSPACE_DIR
    value: /opt/data/workspace
  - key: GIT_TERMINAL_PROMPT
    value: "0"
```

### Agents Not Writing Files or Running Tests
**Symptoms:** Agent completes without creating files or test results
**Root Causes:**
- No persistent workspace directory
- Code execution tool not available
- Test environment not accessible

**Fix (Dockerfile):**
```dockerfile
RUN mkdir -p /opt/data/workspace && chmod 777 /opt/data/workspace
```

### Tool Availability Failures
**Symptoms:** "Unknown tool" errors even though tool exists
**Root Causes:**
- TERMINAL_ENV not set, terminal tool fails availability check
- File tools depend on terminal tool availability

**Fix (render.yaml):**
```yaml
envVars:
  - key: TERMINAL_ENV
    value: local
```

### Comprehensive Testing Tasks Timing Out
**Symptoms:** Tier 1 testing tasks fail or produce minimal output
**Root Causes:**
- Default HERMES_TIMEOUT too short (60s)
- Agent needs more time for multi-step testing

**Fix (render.yaml):**
```yaml
envVars:
  - key: HERMES_TIMEOUT
    value: "600"  # 10 minutes
```

### Task Delegation Failures
**Symptoms:** Agent runs but doesn't delegate to supporting agents
**Root Causes:**
- delegate_task tool not in hermes-api-server toolset
- Inter-agent communication not configured
- Supporting agents not registered/running

**Fix:** Verify toolsets.py includes "delegate_task" in hermes-api-server toolset

### Debugging Agent Execution

**Step 1: Check Environment Variables**
```bash
env | grep -E 'TERMINAL|WORKSPACE|GIT_TERMINAL|HERMES_TIMEOUT'
```

**Step 2: Verify Workspace Directory**
```bash
ls -la /opt/data/workspace
```

**Step 3: Test Git Access**
```bash
cd /opt/data/workspace && git clone <repo_url>
```

**Step 4: Check Tool Availability**
- Verify TERMINAL_ENV=local is set
- Verify terminal tool passes availability check
- Check toolsets.py for hermes-api-server

## Scaling Considerations

### Horizontal Scaling
- Render supports multiple instances
- Load balancer automatically configured
- Session affinity considerations

### Database Scaling
- Supabase handles connection pooling
- Monitor connection limits
- Consider read replicas for high traffic

### Cost Optimization
- Monitor usage patterns
- Adjust instance sizes based on load
- Use Render's auto-scaling features

## Security Best Practices

### Secret Management
- Use Render's secret management for sensitive keys
- Rotate keys regularly
- Never commit secrets to version control

### Network Security
- Configure proper firewall rules
- Use HTTPS for all communications
- Implement rate limiting

### Access Control
- Configure authentication properly
- Use role-based access control
- Monitor access logs

## Backup and Recovery

### Database Backups
- Supabase provides automatic backups
- Configure backup retention policies
- Test backup restoration procedures

### Application Backups
- Use Render's deployment history
- Maintain configuration backups
- Document recovery procedures

## Integration Points

### GitHub Integration
- Automated deployments on push
- PR-based deployments for testing
- Rollback capabilities

### External Services
- Supabase for database operations
- OpenRouter for AI model access
- GitHub for source control and CI/CD

This knowledge base provides the foundation for deploying and maintaining Paperclip applications on Render with full desktop communication capabilities.