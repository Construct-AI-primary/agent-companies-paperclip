---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation
documentation
openstinger_context: general-documentation
last_updated: 2026-03-30
related_docs:
  - docs/
---

# Superpowers Service Integration Guide

**Deployment and integration configuration for Superpowers service in the Construct AI stack**

---

## 📋 Overview

This document provides the deployment configuration and integration steps for the Superpowers service within the Paperclip + OpenClaw + Supabase architecture.

---

## 🏗️ Service Architecture

### Service Components

```
superpowers-service/
├── api/                    # REST API endpoints
├── core/                   # Core workflow engine
├── skills/                 # Skill implementations
├── integrations/           # External service integrations
├── config/                 # Configuration files
└── deploy/                 # Deployment scripts
```

### Technology Stack

- **Runtime**: Node.js 20+ or Python 3.11+
- **Framework**: Express.js (Node) or FastAPI (Python)
- **Database**: Supabase (PostgreSQL)
- **Queue**: Redis or BullMQ
- **Container**: Docker
- **Orchestration**: Kubernetes or Docker Compose

---

## 🔧 Configuration

### Environment Variables

```bash
# Service Configuration
SUPERPOWERS_PORT=3000
SUPERPOWERS_HOST=0.0.0.0
SUPERPOWERS_ENV=production

# Supabase Integration
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_SERVICE_KEY=your-service-key
SUPABASE_ANON_KEY=your-anon-key

# OpenClaw Integration
OPENCLAW_API_URL=http://openclaw-service:3001
OPENCLAW_API_KEY=your-openclaw-key

# Paperclip Integration
PAPERCLIP_API_URL=http://paperclip-service:3002
PAPERCLIP_API_KEY=your-paperclip-key

# Redis Configuration (for job queue)
REDIS_URL=redis://redis:6379

# Logging
LOG_LEVEL=info
LOG_FORMAT=json

# Security
JWT_SECRET=your-jwt-secret
API_RATE_LIMIT=100
```

### Configuration File (`config/default.json`)

```json
{
  "service": {
    "name": "superpowers",
    "version": "1.0.0",
    "port": 3000
  },
  "supabase": {
    "url": "${SUPABASE_URL}",
    "serviceKey": "${SUPABASE_SERVICE_KEY}"
  },
  "integrations": {
    "openclaw": {
      "url": "${OPENCLAW_API_URL}",
      "timeout": 30000
    },
    "paperclip": {
      "url": "${PAPERCLIP_API_URL}",
      "timeout": 30000
    }
  },
  "skills": {
    "enabledCategories": ["coding", "testing", "review", "planning"],
    "maxConcurrentExecutions": 10,
    "executionTimeout": 300000
  },
  "queue": {
    "redis": "${REDIS_URL}",
    "defaultJobOptions": {
      "attempts": 3,
      "backoff": {
        "type": "exponential",
        "delay": 1000
      }
    }
  }
}
```

---

## 🚀 Deployment

### Docker Deployment

#### Dockerfile

```dockerfile
FROM node:20-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1

# Start service
CMD ["node", "src/index.js"]
```

#### Docker Compose

```yaml
version: '3.8'

services:
  superpowers:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - SUPABASE_URL=${SUPABASE_URL}
      - SUPABASE_SERVICE_KEY=${SUPABASE_SERVICE_KEY}
      - REDIS_URL=redis://redis:6379
    depends_on:
      - redis
    restart: unless-stopped
    networks:
      - construct-ai-network

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis-data:/data
    restart: unless-stopped
    networks:
      - construct-ai-network

volumes:
  redis-data:

networks:
  construct-ai-network:
    external: true
```

### Kubernetes Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: superpowers-service
  namespace: construct-ai
spec:
  replicas: 3
  selector:
    matchLabels:
      app: superpowers
  template:
    metadata:
      labels:
        app: superpowers
    spec:
      containers:
      - name: superpowers
        image: construct-ai/superpowers:latest
        ports:
        - containerPort: 3000
        env:
        - name: NODE_ENV
          value: "production"
        - name: SUPABASE_URL
          valueFrom:
            secretKeyRef:
              name: supabase-secrets
              key: url
        - name: SUPABASE_SERVICE_KEY
          valueFrom:
            secretKeyRef:
              name: supabase-secrets
              key: service-key
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 3000
          initialDelaySeconds: 5
          periodSeconds: 5
---
apiVersion: v1
kind: Service
metadata:
  name: superpowers-service
  namespace: construct-ai
spec:
  selector:
    app: superpowers
  ports:
  - port: 3000
    targetPort: 3000
  type: ClusterIP
```

---

## 🔌 API Endpoints

### Health Check

```
GET /health
Response: { "status": "healthy", "version": "1.0.0" }
```

### Execute Skill

```
POST /api/v1/skills/:skillName/execute
Body: {
  "input": { ... },
  "context": {
    "agentId": "string",
    "issueId": "uuid"
  }
}
Response: {
  "success": true,
  "data": { ... },
  "executionTime": "2.5s"
}
```

### List Skills

```
GET /api/v1/skills
Response: {
  "skills": [
    {
      "name": "superpowers.run_coding_workflow",
      "category": "coding",
      "version": "1.0.0"
    }
  ]
}
```

### Get Skill Details

```
GET /api/v1/skills/:skillName
Response: {
  "name": "superpowers.run_coding_workflow",
  "description": "...",
  "inputSchema": { ... },
  "outputSchema": { ... }
}
```

---

## 🔗 Integration Points

### OpenClaw Integration

Superpowers integrates with OpenClaw agents through:

1. **Skill Invocation**: Agents call Superpowers skills via API
2. **Context Sharing**: Shared memory through Supabase
3. **Event Broadcasting**: Real-time updates via Redis pub/sub

### Paperclip Integration

Superpowers integrates with Paperclip through:

1. **Issue Tracking**: Updates issue status in Paperclip
2. **Artifact Storage**: Stores generated code in Supabase
3. **Agent Routing**: Receives task assignments from Paperclip

### Supabase Integration

Superpowers uses Supabase for:

1. **Skill Registry**: Stores skill definitions and metadata
2. **Usage Logging**: Tracks skill execution metrics
3. **Agent Memory**: Stores context and learning data
4. **Artifact Storage**: Stores generated code and tests

---

## 📊 Monitoring

### Health Metrics

- Service uptime
- Request latency
- Error rates
- Skill execution times

### Logging

Structured JSON logging with:
- Request/response logging
- Skill execution logs
- Error tracking
- Performance metrics

### Alerting

Alerts for:
- Service downtime
- High error rates
- Slow response times
- Resource exhaustion

---

## 🔒 Security

### Authentication

- JWT-based authentication
- API key validation
- Role-based access control

### Authorization

- Skill-level permissions
- Agent-level restrictions
- Company-level isolation

### Data Protection

- Encryption at rest (Supabase)
- Encryption in transit (TLS)
- Input validation
- Output sanitization

---

## 🔄 CI/CD Pipeline

### Build Pipeline

```yaml
name: Build and Deploy Superpowers

on:
  push:
    branches: [main]
    paths:
      - 'services/superpowers/**'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Build Docker image
        run: docker build -t superpowers:${{ github.sha }} .
      - name: Push to registry
        run: docker push superpowers:${{ github.sha }}
      
  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to Kubernetes
        run: kubectl set image deployment/superpowers superpowers=superpowers:${{ github.sha }}
```

---

## 📝 Deployment Checklist

- [ ] Environment variables configured
- [ ] Supabase schema deployed
- [ ] Redis instance running
- [ ] Docker image built
- [ ] Service deployed
- [ ] Health checks passing
- [ ] API endpoints responding
- [ ] Integration tests passing
- [ ] Monitoring configured
- [ ] Alerts set up

---

**Last Updated**: 2026-03-30
**Maintainer**: Construct AI DevOps Team
**Version**: 1.0