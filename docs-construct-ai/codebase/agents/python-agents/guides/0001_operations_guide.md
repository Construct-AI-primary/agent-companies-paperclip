---
memory_layer: durable_knowledge
para_section: pages/codebase/agents
gigabrain_tags: agents, codebase, ai-automation
documentation
openstinger_context: agent-development, ai-systems
last_updated: 2026-03-21
related_docs:
  - codebase/agents/
  - disciplines/
---
# Construction Correspondence Deep Agent - Operations Guide

## Table of Contents
1. [System Overview](#system-overview)
2. [File Structure](#file-structure)
3. [Architecture](#architecture)
4. [Deployment](#deployment)
5. [Monitoring](#monitoring)
6. [Maintenance](#maintenance)
7. [Troubleshooting](#troubleshooting)
8. [Performance Tuning](#performance-tuning)
9. [Backup and Recovery](#backup-and-recovery)
10. [Security](#security)
11. [Emergency Procedures](#emergency-procedures)

## System Overview

The Construction Correspondence Deep Agent is an enterprise-grade AI system designed to process construction correspondence with comprehensive multi-disciplinary analysis capabilities.

### Key Features
- **24 Specialized Agents**: 7 main agents + 17 specialist agents covering all construction disciplines
- **Intelligent Orchestration**: Parallel processing with hierarchical coordination
- **Enterprise Security**: SOC 2 compliant with comprehensive audit trails
- **High Availability**: 99.9% uptime with automatic failover
- **Scalable Architecture**: Horizontal scaling with load balancing

### System Requirements
- **Python**: 3.9+
- **Memory**: 2GB minimum, 8GB recommended
- **Storage**: 10GB minimum, 50GB recommended
- **Network**: 100Mbps minimum, 1Gbps recommended
- **OS**: Linux (Ubuntu 20.04+), macOS, Windows Server

## File Structure

The deep-agents codebase has been reorganized with the following structure:

```
deep-agents/
├── README.md                           # Main documentation
├── requirements.txt                    # Python dependencies
├── langextract_server.py               # LangExtract FastAPI service (root level)
├── start_langextract.sh                # LangExtract startup script
│
├── deep_agents/                        # Main Python package
│   ├── __init__.py                     # Package initialization
│   │
│   ├── agents/                         # Agent implementations
│   │   ├── pages/                      # Page-specific agents
│   │   └── shared/                     # Shared agent utilities
│   │       ├── builders/               # Agent builder agents
│   │       ├── governance/             # Security & governance agents
│   │       ├── orchestrators/          # Workflow orchestrators
│   │       └── it_specialists/         # IT Specialist Swarm
│   │
│   ├── core/                           # Core frameworks
│   ├── services/                       # Page pattern services
│   └── utils/                          # Utilities
│
├── scripts/                            # Utility scripts
│   ├── agent_discovery.py
│   ├── migrate_agents_to_registry.py
│   ├── staging_deployment.py
│   └── test_system_validation.py
│
└── docs/                               # Documentation
```

### Key Agent Locations

- **Orchestrators**: `deep_agents/agents/shared/orchestrators/`
- **Governance**: `deep_agents/agents/shared/governance/`
- **Builders**: `deep_agents/agents/shared/builders/`
- **Core Utils**: `deep_agents/core/` and `deep_agents/utils/`

## Architecture

### Component Architecture
```
┌─────────────────────────────────────────────────────────────┐
│                  API Gateway (FastAPI)                       │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │         Orchestration Layer (Supervisor Agent)         │ │
│  │  ┌─────────────────────────────────────────────────────┐ │ │
│  │  │         Agent Pool (24 Specialized Agents)         │ │ │
│  │  │  ┌─────────────────────────────────────────────────┐ │ │ │
│  │  │  │       Core Services (Cache, Config, DB)        │ │ │ │
│  │  │  └─────────────────────────────────────────────────┘ │ │ │
│  │  └─────────────────────────────────────────────────────┘ │ │
│  └─────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

### Agent Hierarchy
1. **Main Agents** (Sequential Processing):
   - Document Analysis Agent
   - Information Extraction Agent
   - Document Retrieval Agent
   - Contract Management Agent
   - Human Review Agent
   - Professional Formatting Agent

2. **Specialist Agents** (Parallel Processing):
   - **Engineering**: Civil, Structural, Mechanical, Electrical, Process, Instrumentation, Geotechnical, Environmental
   - **Management**: Architectural, Construction, Quality Control, Scheduling, Inspection
   - **Support**: Logistics, Quantity Surveying, Health, Safety

## Deployment

### Environment Setup

#### 1. Prerequisites Installation
```bash
# System dependencies
sudo apt update
sudo apt install python3.9 python3.9-venv postgresql redis-server nginx

# Python environment
python3.9 -m venv /opt/constructai/venv
source /opt/constructai/venv/bin/activate
pip install --upgrade pip
```

#### 2. Database Setup
```bash
# PostgreSQL setup
sudo -u postgres createdb constructai_prod
sudo -u postgres createuser constructai_user --createdb --login
sudo -u postgres psql -c "ALTER USER constructai_user PASSWORD 'secure_password';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE constructai_prod TO constructai_user;"

# Redis setup
sudo systemctl enable redis-server
sudo systemctl start redis-server
```

#### 3. Application Deployment
```bash
# Clone and setup
cd /opt/constructai
git clone https://github.com/construct-ai/deep-agents.git .
pip install -r requirements.txt

# Environment configuration
cp .env.example .env.prod
nano .env.prod  # Configure production settings

# Database migration
alembic upgrade head

# Start services
sudo systemctl enable constructai-api
sudo systemctl start constructai-api
```

### Configuration Management

#### Environment Variables
```bash
# Core settings
ENVIRONMENT=production
DEBUG=false
LOG_LEVEL=INFO

# Database
DATABASE_URL=postgresql://constructai_user:password@localhost:5432/constructai_prod

# AI Services
OPENAI_API_KEY=sk-prod-...
ANTHROPIC_API_KEY=sk-ant-prod-...

# Security
JWT_SECRET_KEY=your-256-bit-secret
ENCRYPTION_KEY=your-32-byte-key

# Monitoring
SENTRY_DSN=https://...
PROMETHEUS_PORT=9090
```

#### Feature Flags Configuration
```json
{
  "feature_flags": {
    "deep_agent_system": {
      "enabled": true,
      "rollout_percentage": 100
    },
    "parallel_specialists": {
      "enabled": true,
      "rollout_percentage": 100
    },
    "result_caching": {
      "enabled": true,
      "rollout_percentage": 75
    }
  }
}
```

### Health Checks

#### Application Health
```bash
# API health check
curl -f http://localhost:8000/health

# Detailed health check
curl http://localhost:8000/health/detailed

# Readiness check
curl http://localhost:8000/health/ready
```

#### System Health
```bash
# Memory usage
free -h

# Disk usage
df -h

# Process status
ps aux | grep constructai

# Service status
sudo systemctl status constructai-api
```

## Monitoring

### Metrics Collection

#### Key Performance Indicators
- **Response Time**: API response time (target: <2 seconds)
- **Throughput**: Requests per second (target: 50 RPS)
- **Error Rate**: Percentage of failed requests (target: <1%)
- **Agent Performance**: Individual agent success rates
- **Cache Hit Rate**: Cache effectiveness (target: >80%)
- **Memory Usage**: System memory utilization (target: <80%)

#### Monitoring Stack
```
Prometheus → Metrics Collection
Grafana    → Dashboards & Visualization
AlertManager → Alert Management
Elasticsearch → Log Aggregation
Kibana    → Log Analysis
```

### Alert Configuration

#### Critical Alerts
```yaml
# Response time degradation
- alert: HighResponseTime
  expr: histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m])) > 5
  for: 5m
  labels:
    severity: critical

# Error rate spike
- alert: HighErrorRate
  expr: rate(http_requests_total{status=~"5.."}[5m]) / rate(http_requests_total[5m]) > 0.05
  for: 5m
  labels:
    severity: critical

# Agent failure
- alert: AgentFailure
  expr: increase(agent_failures_total[10m]) > 5
  for: 2m
  labels:
    severity: warning
```

#### Warning Alerts
```yaml
# Memory usage high
- alert: HighMemoryUsage
  expr: (1 - node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes) > 0.85
  for: 5m
  labels:
    severity: warning

# Cache miss rate high
- alert: HighCacheMissRate
  expr: rate(cache_misses_total[5m]) / (rate(cache_hits_total[5m]) + rate(cache_misses_total[5m])) > 0.3
  for: 10m
  labels:
    severity: warning
```

### Log Management

#### Log Levels
- **ERROR**: System errors requiring immediate attention
- **WARN**: Potential issues or degraded performance
- **INFO**: Normal operational messages
- **DEBUG**: Detailed diagnostic information

#### Log Rotation
```bash
# Daily log rotation
/var/log/constructai/*.log {
    daily
    rotate 30
    compress
    missingok
    notifempty
    create 644 constructai constructai
    postrotate
        systemctl reload constructai-api
    endscript
}
```

## Maintenance

### Regular Tasks

#### Daily Maintenance
```bash
# Health checks
curl http://localhost:8000/health

# Log review
tail -f /var/log/constructai/api.log | grep ERROR

# Cache statistics
curl http://localhost:8000/cache/stats

# Database connection check
psql -h localhost -U constructai_user -d constructai_prod -c "SELECT 1;"
```

#### Weekly Maintenance
```bash
# Database vacuum
psql -h localhost -U constructai_user -d constructai_prod -c "VACUUM ANALYZE;"

# Cache cleanup
curl -X POST http://localhost:8000/cache/cleanup

# Log archive
tar -czf /backup/logs/$(date +%Y%m%d).tar.gz /var/log/constructai/

# Performance review
curl http://localhost:9090/metrics | grep constructai
```

#### Monthly Maintenance
```bash
# Security updates
sudo apt update && sudo apt upgrade

# Database maintenance
pg_dump constructai_prod > /backup/db/$(date +%Y%m%d)_monthly.sql

# Feature flag review
curl http://localhost:8000/feature-flags | jq '.'

# User analytics review
curl http://localhost:8000/analytics/monthly-report
```

### Performance Optimization

#### Cache Management
```python
from deep_agents.core.caching_system import get_cache_stats, perform_memory_optimization

# Check cache performance
stats = get_cache_stats()
print(f"Cache hit rate: {stats['hit_rate_percentage']}%")

# Optimize memory if needed
if stats['memory_usage_percentage'] > 80:
    result = perform_memory_optimization()
    print(f"Memory optimized: {result['memory_saved_mb']} MB saved")
```

#### Database Optimization
```sql
-- Analyze query performance
EXPLAIN ANALYZE SELECT * FROM correspondence WHERE created_at > '2024-01-01';

-- Index maintenance
REINDEX INDEX CONCURRENTLY idx_correspondence_created_at;

-- Table statistics update
ANALYZE correspondence;

-- Archive old data
INSERT INTO correspondence_archive SELECT * FROM correspondence WHERE created_at < '2023-01-01';
DELETE FROM correspondence WHERE created_at < '2023-01-01';
```

## Troubleshooting

### Common Issues

#### 1. High Memory Usage
**Symptoms**: System slowdown, OOM errors
**Diagnosis**:
```bash
# Check memory usage
ps aux --sort=-%mem | head -10

# Check cache stats
curl http://localhost:8000/cache/stats

# Review agent performance
curl http://localhost:8000/metrics/agents
```

**Resolution**:
```python
# Force garbage collection
from deep_agents.core.caching_system import perform_memory_optimization
result = perform_memory_optimization()

# Reduce cache size
from deep_agents.core.caching_system import get_main_cache
cache = get_main_cache()
cache.max_memory_bytes = int(cache.max_memory_bytes * 0.8)
```

#### 2. Slow Response Times
**Symptoms**: API responses >5 seconds
**Diagnosis**:
```bash
# Check system load
uptime
iostat -x 1 5

# Review slow queries
tail -f /var/log/constructai/api.log | grep "duration"

# Check agent performance
curl http://localhost:8000/metrics/agents | jq '.[] | select(.avg_duration > 30)'
```

**Resolution**:
```python
# Enable result caching for slow agents
from deep_agents.core.feature_flags import get_feature_flag_manager
ff_manager = get_feature_flag_manager()
ff_manager.set_flag_percentage('result_caching', 90)

# Optimize agent configurations
# Reduce specialist parallelism if needed
```

#### 3. Agent Failures
**Symptoms**: Agent execution errors, incomplete analyses
**Diagnosis**:
```bash
# Check agent error logs
grep "Agent.*failed" /var/log/constructai/api.log

# Review agent health
curl http://localhost:8000/health/agents

# Check AI service connectivity
curl -H "Authorization: Bearer $OPENAI_API_KEY" https://api.openai.com/v1/models
```

**Resolution**:
```python
# Restart failed agents
from deep_agents.core.agent_registry import get_agent_registry
registry = get_agent_registry()
failed_agents = registry.get_failed_agents()
for agent in failed_agents:
    registry.restart_agent(agent.id)

# Update AI service configurations
# Check API rate limits and quotas
```

#### 4. Database Connection Issues
**Symptoms**: Database connection errors, slow queries
**Diagnosis**:
```bash
# Check database connectivity
psql -h localhost -U constructai_user -d constructai_prod -c "SELECT 1;"

# Review connection pool
psql -h localhost -U constructai_user -d constructai_prod -c "SELECT * FROM pg_stat_activity;"

# Check disk space
df -h /var/lib/postgresql
```

**Resolution**:
```sql
-- Increase connection pool size if needed
ALTER SYSTEM SET max_connections = '200';

-- Optimize slow queries
CREATE INDEX CONCURRENTLY idx_correspondence_status ON correspondence(status);

-- Clear connection pool
SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE state = 'idle in transaction';
```

### Diagnostic Tools

#### Health Check Endpoints
```bash
# System health
curl http://localhost:8000/health

# Detailed diagnostics
curl http://localhost:8000/diagnostics/full

# Agent status
curl http://localhost:8000/health/agents

# Database status
curl http://localhost:8000/health/database
```

#### Log Analysis
```bash
# Search for errors
grep "ERROR" /var/log/constructai/api.log | tail -20

# Performance analysis
grep "duration" /var/log/constructai/api.log | awk '{sum+=$2; count++} END {print "Avg:", sum/count, "Count:", count}'

# Agent failure analysis
grep "failed" /var/log/constructai/api.log | grep -E "(civil|structural|mechanical)" | head -10
```

## Performance Tuning

### Optimization Strategies

#### 1. Caching Optimization
```python
# Adjust cache TTL based on data volatility
agent_cache_ttl = {
    'document_analysis': 7200,  # 2 hours
    'specialist_analysis': 3600,  # 1 hour
    'contract_review': 1800,  # 30 minutes
}

# Implement cache warming for frequently accessed data
def warm_cache():
    # Pre-load common specialist analyses
    common_queries = ["civil engineering", "structural analysis", "contract terms"]
    for query in common_queries:
        # Trigger cache population
        pass
```

#### 2. Agent Parallelization Tuning
```python
# Dynamic agent allocation based on load
def optimize_agent_allocation(current_load):
    if current_load < 0.3:
        return {'parallel_groups': 3, 'max_concurrent': 8}
    elif current_load < 0.7:
        return {'parallel_groups': 2, 'max_concurrent': 6}
    else:
        return {'parallel_groups': 1, 'max_concurrent': 4}

# Specialist prioritization based on relevance
specialist_priority = {
    'contract_management': 1,
    'civil_engineering': 2,
    'structural_engineering': 2,
    'safety_engineering': 3,
    'quality_control': 4
}
```

#### 3. Memory Management
```python
# Implement memory-aware processing
class MemoryAwareProcessor:
    def __init__(self):
        self.memory_threshold = 0.8  # 80% memory usage
        self.batch_size = 10

    def process_with_memory_limits(self, items):
        for i in range(0, len(items), self.batch_size):
            batch = items[i:i + self.batch_size]

            # Check memory before processing
            memory_usage = psutil.virtual_memory().percent / 100
            if memory_usage > self.memory_threshold:
                self.perform_memory_cleanup()

            # Process batch
            self.process_batch(batch)
```

### Scaling Strategies

#### Horizontal Scaling
```yaml
# Kubernetes deployment configuration
apiVersion: apps/v1
kind: Deployment
metadata:
  name: constructai-api
spec:
  replicas: 3
  selector:
    matchLabels:
      app: constructai-api
  template:
    metadata:
      labels:
        app: constructai-api
    spec:
      containers:
      - name: api
        image: constructai/deep-agents:latest
        resources:
          requests:
            memory: "1Gi"
            cpu: "500m"
          limits:
            memory: "2Gi"
            cpu: "1000m"
        env:
        - name: ENVIRONMENT
          value: "production"
```

#### Database Scaling
```sql
-- Read replica configuration
-- Create read replica for analytics queries
CREATE PUBLICATION constructai_pub FOR ALL TABLES;
CREATE SUBSCRIPTION constructai_sub
    CONNECTION 'host=primary-db port=5432 user=replica dbname=constructai_prod'
    PUBLICATION constructai_pub;

-- Partition large tables
CREATE TABLE correspondence_y2024 PARTITION OF correspondence
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
```

## Backup and Recovery

### Backup Strategy

#### Database Backups
```bash
# Daily full backup
pg_dump constructai_prod > /backup/db/daily/$(date +%Y%m%d_%H%M%S).sql

# Hourly incremental backup
pg_dump --data-only --inserts constructai_prod > /backup/db/hourly/$(date +%Y%m%d_%H).sql

# WAL archiving for point-in-time recovery
archive_command = 'cp %p /backup/wal/%f'
```

#### Application Backups
```bash
# Configuration backup
tar -czf /backup/config/$(date +%Y%m%d).tar.gz /opt/constructai/config/

# Model and cache backup
tar -czf /backup/models/$(date +%Y%m%d).tar.gz /opt/constructai/models/

# Feature flags backup
curl http://localhost:8000/feature-flags > /backup/config/feature_flags_$(date +%Y%m%d).json
```

### Recovery Procedures

#### Database Recovery
```bash
# Stop application
sudo systemctl stop constructai-api

# Restore from backup
createdb constructai_prod_new
psql constructai_prod_new < /backup/db/daily/20241201_020000.sql

# Switch databases
psql -c "ALTER DATABASE constructai_prod RENAME TO constructai_prod_old;"
psql -c "ALTER DATABASE constructai_prod_new RENAME TO constructai_prod;"

# Start application
sudo systemctl start constructai-api
```

#### Application Recovery
```bash
# Deploy from backup
cd /opt/constructai
tar -xzf /backup/config/20241201.tar.gz -C /opt/constructai/

# Restore feature flags
curl -X POST http://localhost:8000/feature-flags/restore \
    -H "Content-Type: application/json" \
    -d @/backup/config/feature_flags_20241201.json

# Validate recovery
curl http://localhost:8000/health
```

### Disaster Recovery

#### Failover Strategy
```yaml
# Multi-region deployment
regions:
  - primary: us-east-1
    standby: us-west-2
    rto: 4 hours  # Recovery Time Objective
    rpo: 15 minutes  # Recovery Point Objective

# Automated failover script
#!/bin/bash
PRIMARY_STATUS=$(curl -f http://primary-region/health)
if [ $? -ne 0 ]; then
    echo "Primary region failed, initiating failover"
    # Route traffic to standby region
    aws route53 change-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --change-batch file://failover.json
fi
```

## Security

### Access Control

#### Authentication
```python
# JWT token validation
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from jose import jwt, JWTError

security = HTTPBearer()

async def get_current_user(credentials: HTTPAuthorizationCredentials = Depends(security)):
    try:
        payload = jwt.decode(credentials.credentials, SECRET_KEY, algorithms=["HS256"])
        user_id = payload.get("sub")
        return await get_user(user_id)
    except JWTError:
        raise HTTPException(status_code=401, detail="Invalid authentication")
```

#### Authorization
```python
# Role-based access control
user_permissions = {
    'admin': ['read', 'write', 'delete', 'admin'],
    'analyst': ['read', 'write'],
    'viewer': ['read']
}

def check_permission(user_role: str, required_permission: str) -> bool:
    return required_permission in user_permissions.get(user_role, [])
```

### Data Protection

#### Encryption
```python
# Database field encryption
from cryptography.fernet import Fernet

class EncryptedField:
    def __init__(self, key: bytes):
        self.cipher = Fernet(key)

    def encrypt(self, data: str) -> str:
        return self.cipher.encrypt(data.encode()).decode()

    def decrypt(self, encrypted_data: str) -> str:
        return self.cipher.decrypt(encrypted_data.encode()).decode()
```

#### Audit Logging
```python
# Comprehensive audit trail
def log_audit_event(event_type: str, user_id: str, resource: str, action: str, details: dict):
    audit_entry = {
        'timestamp': datetime.utcnow(),
        'event_type': event_type,
        'user_id': user_id,
        'resource': resource,
        'action': action,
        'ip_address': get_client_ip(),
        'user_agent': get_user_agent(),
        'details': details
    }

    # Store in audit database
    audit_collection.insert_one(audit_entry)

    # Send to security monitoring
    send_to_siem(audit_entry)
```

## Emergency Procedures

### Critical Incident Response

#### System Down Procedure
1. **Assess Impact**
   ```bash
   # Check system status
   curl http://localhost:8000/health || echo "System unreachable"

   # Check affected services
   sudo systemctl status constructai-api postgresql redis-server
   ```

2. **Initial Response**
   ```bash
   # Restart services
   sudo systemctl restart constructai-api

   # Check logs for errors
   journalctl -u constructai-api -n 50 --no-pager

   # Verify database connectivity
   psql -h localhost -U constructai_user -d constructai_prod -c "SELECT 1;"
   ```

3. **Escalation**
   - If system doesn't recover: Contact on-call engineer
   - If data corruption suspected: Initiate backup recovery
   - If security breach suspected: Follow security incident procedure

#### Data Loss Incident
1. **Stop Processing**
   ```bash
   sudo systemctl stop constructai-api
   ```

2. **Assess Data Loss**
   ```bash
   # Check backup integrity
   pg_restore --list /backup/db/daily/latest.dump > /dev/null

   # Identify affected data range
   # Review transaction logs
   ```

3. **Recovery Execution**
   ```bash
   # Restore from backup
   pg_restore -d constructai_prod /backup/db/daily/latest.dump

   # Validate data integrity
   psql -d constructai_prod -c "SELECT count(*) FROM correspondence;"

   # Resume processing
   sudo systemctl start constructai-api
   ```

### Communication Plan

#### Internal Communication
- **Slack Channel**: #constructai-incidents
- **Email Distribution**: critical-incidents@constructai.com
- **Phone Bridge**: Emergency conference line

#### External Communication
- **Client Notification**: Template for service disruption communication
- **Status Page**: Automated status page updates
- **Social Media**: Coordinated messaging for major incidents

### Post-Incident Review

#### Incident Report Structure
```markdown
# Incident Report: [Incident Title]

## Executive Summary
- Date/Time: [Timestamp]
- Duration: [Duration]
- Impact: [Business impact description]
- Root Cause: [Technical root cause]

## Timeline
- T0: Incident detection
- T+5min: Initial assessment
- T+15min: Mitigation started
- T+30min: Service restored

## Actions Taken
- [List of actions taken during incident]

## Lessons Learned
- [What went well]
- [What could be improved]
- [Preventive measures to implement]

## Follow-up Actions
- [List of action items with owners and deadlines]
```

#### Continuous Improvement
- Weekly incident review meetings
- Monthly trend analysis and prevention planning
- Quarterly system resilience testing
- Annual disaster recovery testing

---

## Support Contacts

### Technical Support
- **Primary**: support@constructai.com
- **Emergency**: +27-21-123-4567 (24/7)
- **Slack**: #tech-support

### Development Team
- **Lead Developer**: dev-lead@constructai.com
- **DevOps Engineer**: devops@constructai.com
- **Security Officer**: security@constructai.com

### Management
- **Operations Manager**: ops-manager@constructai.com
- **CTO**: cto@constructai.com
- **CEO**: ceo@constructai.com

---

*This operations guide should be reviewed and updated quarterly to reflect system changes and lessons learned.*
