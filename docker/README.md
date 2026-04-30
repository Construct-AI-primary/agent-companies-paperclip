# Docker Configuration

This directory contains all Docker-related configuration files for the Paperclip project.

## Files

### `Dockerfile`

Main production Dockerfile for building the Paperclip application.

**Usage:**
```bash
docker build -f docker/Dockerfile -t paperclip:latest .
```

### `Dockerfile.onboard-smoke`

Dockerfile for onboarding smoke tests.

**Usage:**
```bash
docker build -f docker/Dockerfile.onboard-smoke -t paperclip-onboard-smoke .
```

### `docker-compose.yml`

Main Docker Compose configuration for local development.

**Usage:**
```bash
docker compose -f docker/docker-compose.yml up
```

**Services:**
- PostgreSQL database
- Paperclip server
- UI development server

### `docker-compose.quickstart.yml`

Quickstart Docker Compose configuration for rapid setup.

**Usage:**
```bash
docker compose -f docker/docker-compose.quickstart.yml up
```

**Features:**
- Minimal configuration
- Embedded PostgreSQL
- Single-command startup

### `docker-compose.untrusted-review.yml`

Docker Compose configuration for untrusted PR review environment.

**Usage:**
```bash
docker compose -f docker/docker-compose.untrusted-review.yml up
```

**Security:**
- Isolated environment
- Restricted permissions
- Safe for reviewing untrusted code

### `.dockerignore`

Specifies files and directories to exclude from Docker build context.

**Purpose:**
- Reduces build context size
- Improves build performance
- Excludes unnecessary files

### `RENDER-DOCKER-DEPLOYMENT.md`

Documentation for deploying Paperclip to Render using Docker.

**Contents:**
- Render deployment configuration
- Environment variable setup
- Docker deployment best practices

## Common Tasks

### Local Development

```bash
# Start all services
docker compose -f docker/docker-compose.yml up

# Start in detached mode
docker compose -f docker/docker-compose.yml up -d

# View logs
docker compose -f docker/docker-compose.yml logs -f

# Stop services
docker compose -f docker/docker-compose.yml down
```

### Production Build

```bash
# Build production image
docker build -f docker/Dockerfile -t paperclip:latest .

# Run production container
docker run -p 3100:3100 \
  -e DATABASE_URL="your-database-url" \
  paperclip:latest
```

### Quickstart

```bash
# One-command startup
docker compose -f docker/docker-compose.quickstart.yml up

# Access at http://localhost:3100
```

### Untrusted PR Review

```bash
# Start isolated review environment
docker compose -f docker/docker-compose.untrusted-review.yml up

# Review changes safely
# Environment is isolated and restricted
```

## Directory Structure

```
docker/
├── README.md                              # This file
├── .dockerignore                          # Docker build exclusions
├── Dockerfile                             # Production Dockerfile
├── Dockerfile.onboard-smoke              # Onboarding smoke test Dockerfile
├── docker-compose.yml                    # Main development compose
├── docker-compose.quickstart.yml         # Quickstart compose
├── docker-compose.untrusted-review.yml   # Untrusted review compose
├── RENDER-DOCKER-DEPLOYMENT.md           # Render deployment guide
├── openclaw-smoke/                       # Openclaw smoke test configs
└── untrusted-review/                     # Untrusted review configs
```

## Environment Variables

### Required

- `DATABASE_URL` - PostgreSQL connection string
- `NODE_ENV` - Environment (development, production)

### Optional

- `PORT` - Server port (default: 3100)
- `PAPERCLIP_SECRETS_MASTER_KEY` - Secrets encryption key
- `PAPERCLIP_SECRETS_STRICT_MODE` - Enable strict secrets mode

## Best Practices

1. **Use docker-compose for development** - Easier service orchestration
2. **Use Dockerfile for production** - Optimized builds
3. **Keep .dockerignore updated** - Exclude unnecessary files
4. **Use multi-stage builds** - Reduce image size
5. **Pin base image versions** - Ensure reproducible builds

## Troubleshooting

### "Cannot connect to database"

Check DATABASE_URL environment variable:
```bash
docker compose -f docker/docker-compose.yml config
```

### "Port already in use"

Stop conflicting services or change port:
```bash
# Stop all Docker containers
docker compose -f docker/docker-compose.yml down

# Or change port in docker-compose.yml
```

### "Build context too large"

Update .dockerignore to exclude large directories:
```
node_modules/
.git/
dist/
```

## Related Documentation

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Paperclip Deployment Guide](../doc/DOCKER.md)
- [Render Deployment](RENDER-DOCKER-DEPLOYMENT.md)
