---
title: Render Deployment Troubleshooting Knowledge Base
summary: Complete guide for diagnosing and fixing Render deployment issues
---

# Render Deployment Troubleshooting Knowledge Base

## Overview

This knowledge base documents the specific deployment issues encountered during the Render deployment of the Hermes Agent system and provides systematic troubleshooting procedures for common problems.

## Current Deployment Status

**Status**: 🔴 BLOCKED - API server crashes silently on startup
**Last Deployment**: Failed with HTTP 000 (connection refused)
**Root Cause**: API server process starts but exits immediately without logs

## Critical Issues Documented

### Issue 1: Missing curl in Dockerfile (FIXED)
**Problem**: Entrypoint script couldn't check API server health
**Symptoms**:
- Container startup logs showed `/bin/sh: curl: command not found`
- Health checks failed silently
- No visibility into API server status

**Solution Applied**:
```dockerfile
# Added to Dockerfile
RUN apt-get update && apt-get install -y \
    curl \
    git \
    jq \
    build-essential \
    && rm -rf /var/lib/apt/lists/*
```

**Prevention**: Always include curl in Docker images that need health checking

### Issue 2: API Server Silent Crash (CURRENT BLOCKER)
**Problem**: Hermes serve command starts but crashes immediately
**Symptoms**:
- No `[API]` prefixed logs in container output
- Health checks return HTTP 000 (connection refused)
- Process appears to start then exit immediately
- No error messages visible

**Current Investigation**:
1. **Environment Variables**: Verify OPENROUTER_API_KEY, GITHUB_TOKEN, HERMES_MODE=both are set
2. **Command Testing**: Test `hermes serve --host 0.0.0.0 --port 8000` manually
3. **Dependencies**: Ensure hermes binary is properly installed
4. **Permissions**: Check if hermes has proper execution permissions

**Debug Steps**:
```bash
# Test the exact command that should work
hermes serve --host 0.0.0.0 --port 8000 --mode both

# Check if hermes is installed
which hermes && hermes --version

# Test with minimal environment
env -i HERMES_MODE=both hermes serve --host 0.0.0.0 --port 8000
```

### Issue 3: Health Check Timeout Issues (FIXED)
**Problem**: 30-second health check timeout was too short for slow startups
**Symptoms**:
- Health checks failed during legitimate startup delays
- Container marked as unhealthy during normal initialization
- False positive failures

**Solution Applied**:
```bash
# Extended timeout in entrypoint.sh
MAX_HEALTH_CHECK_ATTEMPTS=30
HEALTH_CHECK_INTERVAL=5
# Total timeout: 150 seconds (2.5 minutes)
```

**Prevention**: Set health check timeouts based on expected startup time + buffer

### Issue 4: Process Management in Dual-Mode Setup
**Problem**: Managing both API server and worker processes in single container
**Symptoms**:
- Background processes not properly daemonized
- Container exits when foreground process ends
- Race conditions between process startup

**Solution Applied**:
```bash
# Proper process management in entrypoint.sh
hermes serve ... &  # Background API server
API_PID=$!

# Wait for API server readiness
# Start worker process
python -m worker.main &
WORKER_PID=$!

# Trap signals for graceful shutdown
trap 'kill $API_PID $WORKER_PID' SIGTERM SIGINT

# Keep container alive
wait
```

## Systematic Troubleshooting Framework

### Phase 1: Container Startup Issues
1. **Check Build Logs**
   ```bash
   # Review Docker build output for errors
   docker build -t test-build .
   ```

2. **Verify System Dependencies**
   ```bash
   # Ensure all required packages are installed
   docker run --rm test-build which curl git jq
   ```

3. **Test Entrypoint Script**
   ```bash
   # Run entrypoint script in isolation
   docker run --rm -it test-build /bin/bash -c 'bash -n docker/entrypoint.sh'
   ```

### Phase 2: Application Startup Issues
1. **Environment Variable Validation**
   ```bash
   # Check all required env vars are present
   docker run --rm --env-file .env test-build env | grep -E '^(OPENROUTER_API_KEY|GITHUB_TOKEN|HERMES_MODE)'
   ```

2. **Command Testing**
   ```bash
   # Test the exact startup command
   docker run --rm -it test-build hermes serve --help
   ```

3. **Minimal Startup Test**
   ```bash
   # Start with minimal configuration
   docker run --rm -e HERMES_MODE=cli test-build hermes serve --host 0.0.0.0 --port 8000
   ```

### Phase 3: Runtime Issues
1. **Health Check Debugging**
   ```bash
   # Manual health check testing
   docker run -d --name test-container test-build
   sleep 10
   docker exec test-container curl -f http://localhost:8000/health
   docker logs test-container
   ```

2. **Process Inspection**
   ```bash
   # Check running processes
   docker exec test-container ps aux
   docker exec test-container netstat -tlnp
   ```

3. **Log Analysis**
   ```bash
   # Comprehensive logging
   docker logs --follow test-container
   ```

## Common Error Patterns

### Pattern 1: Missing Dependencies
**Error**: `command not found`
**Cause**: System dependencies not installed in Docker image
**Fix**: Add dependencies to Dockerfile RUN command

### Pattern 2: Environment Variable Issues
**Error**: Silent crash or "invalid configuration"
**Cause**: Required environment variables missing or malformed
**Fix**: Validate all required env vars in entrypoint script

### Pattern 3: Port Binding Issues
**Error**: "address already in use" or connection refused
**Cause**: Port conflicts or incorrect host binding
**Fix**: Use `0.0.0.0` for all interfaces, verify port availability

### Pattern 4: Permission Issues
**Error**: "permission denied"
**Cause**: File permissions or user context issues
**Fix**: Ensure proper file permissions and user setup

### Pattern 5: Resource Constraints
**Error**: "out of memory" or slow performance
**Cause**: Insufficient memory/CPU allocation
**Fix**: Adjust Render service resource allocation

## Monitoring and Alerting Setup

### Container Health Monitoring
```yaml
# render.yaml health check configuration
services:
  - type: web
    name: paperclip-app
    healthCheckPath: /health
    healthCheckTimeout: 300  # 5 minutes for slow startups
    restartPolicy: on_failure
```

### Log Aggregation
```bash
# Structured logging in application
import logging
import json

# JSON structured logging
logger = logging.getLogger('paperclip')
handler = logging.StreamHandler()
formatter = logging.Formatter(
    '{"timestamp": "%(asctime)s", "level": "%(levelname)s", "message": "%(message)s"}'
)
handler.setFormatter(formatter)
logger.addHandler(handler)
```

### Alert Configuration
```python
# Alert on critical failures
def alert_on_failure(error_message, context):
    # Send alert to monitoring system
    alert_data = {
        'service': 'paperclip-render',
        'severity': 'critical',
        'message': error_message,
        'context': context,
        'timestamp': datetime.utcnow().isoformat()
    }

    # Send to alerting endpoint
    requests.post(ALERT_WEBHOOK_URL, json=alert_data)
```

## Prevention Measures

### Dockerfile Best Practices
1. **Multi-stage builds** for smaller images
2. **Non-root user** for security
3. **Minimal base images** (alpine/slim variants)
4. **Security scanning** of base images
5. **Dependency pinning** to prevent breaking changes

### Deployment Best Practices
1. **Blue-green deployments** for zero-downtime updates
2. **Health checks** that validate actual functionality
3. **Graceful shutdown** handling
4. **Resource limits** to prevent resource exhaustion
5. **Monitoring integration** from deployment start

### Configuration Management
1. **Environment validation** at startup
2. **Configuration schema validation**
3. **Secret management** for sensitive data
4. **Configuration versioning** and rollback capability

## Recovery Procedures

### Emergency Rollback
```bash
# Immediate rollback to previous deployment
curl -X POST \
  -H "Authorization: Bearer $RENDER_API_KEY" \
  "https://api.render.com/v1/services/$SERVICE_ID/rollbacks" \
  -d '{"deployId": "'$PREVIOUS_DEPLOY_ID'"}'
```

### Data Recovery
1. **Database backup restoration**
2. **Configuration rollback**
3. **Environment variable restoration**
4. **Dependency version rollback**

### Service Restoration
1. **Container restart** with fixed configuration
2. **Load balancer draining** during maintenance
3. **Gradual traffic restoration** after verification
4. **Monitoring validation** before full restoration

## Lessons Learned

### Technical Lessons
1. **Always include curl** in Docker images needing health checks
2. **Set appropriate timeouts** based on actual startup times
3. **Validate environment variables** early in startup process
4. **Use structured logging** for better debugging
5. **Test startup commands** in isolation before deployment

### Process Lessons
1. **Implement comprehensive monitoring** from day one
2. **Have rollback procedures** ready before deployment
3. **Document all configuration changes** and their rationale
4. **Test deployments** in staging before production
5. **Maintain deployment runbooks** for common issues

### Team Lessons
1. **Communicate issues** clearly and immediately
2. **Document troubleshooting steps** as you discover them
3. **Share knowledge** across team members
4. **Review deployments** as a team before going live
5. **Celebrate successes** and learn from failures

## Future Improvements

### Automated Testing
- **Container testing** before deployment
- **Integration testing** in staging environment
- **Performance testing** under load
- **Chaos engineering** for resilience testing

### Deployment Automation
- **Infrastructure as Code** for all configurations
- **Automated rollbacks** on failure detection
- **Canary deployments** for gradual rollouts
- **Feature flags** for controlled releases

### Monitoring Enhancements
- **Distributed tracing** across services
- **Custom metrics** for business logic
- **Predictive alerting** based on trends
- **Automated incident response**

This knowledge base will be updated as new issues are discovered and resolved during the Render deployment process.