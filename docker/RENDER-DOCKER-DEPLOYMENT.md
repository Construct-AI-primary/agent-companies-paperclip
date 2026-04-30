# Paperclip Docker Deployment on Render

## Overview
This guide covers deploying Paperclip to Render using Docker, which simplifies the build process by handling all monorepo dependencies automatically.

## Prerequisites
- GitHub repository: https://github.com/Construct-AI-primary/paperclip-render
- Render account
- Supabase PostgreSQL database

## Configuration Files

### 1. render.yaml
The `render.yaml` file configures the Render service to use Docker:
- **Runtime**: `docker`
- **Dockerfile**: `./Dockerfile`
- **Port**: 3100
- **Persistent Storage**: 10GB disk mounted at `/paperclip`

### 2. config.json
Located at the root of the repository, this file configures Paperclip to use external services:
```json
{
  "database": {
    "mode": "postgres"
  },
  "storage": {
    "mode": "s3"
  },
  "secrets": {
    "mode": "env"
  }
}
```

## Environment Variables to Configure in Render Dashboard

You need to set these environment variables in the Render dashboard:

### Required Variables:
1. **DATABASE_URL**
   ```
   postgresql://postgres:eBmrthjpeiqLA6LX@db.gmorarhibiptvcrnvrpi.supabase.co:5432/postgres
   ```

2. **PAPERCLIP_AGENT_JWT_SECRET**
   ```
   7b5a8e2e79a6d16da7f7d0d2fed81b6b13e49a69462dcdeef4bfa8b3d380195a
   ```

### Optional AWS S3 Variables (if using S3 storage):
3. **AWS_ACCESS_KEY_ID** - Your AWS access key
4. **AWS_SECRET_ACCESS_KEY** - Your AWS secret key
5. **AWS_REGION** - AWS region (e.g., `us-east-1`)
6. **S3_BUCKET** - S3 bucket name for file storage

## Deployment Steps

### Step 1: Configure Environment Variables in Render
1. Go to your Render dashboard: https://dashboard.render.com
2. Navigate to your Paperclip service
3. Go to **Environment** section
4. Add the required environment variables:
   - `DATABASE_URL` (set as secret)
   - `PAPERCLIP_AGENT_JWT_SECRET` (set as secret)
   - Add AWS variables if using S3 storage

### Step 2: Trigger Deployment
The deployment will automatically trigger when you push to the master branch, or you can manually trigger it from the Render dashboard.

### Step 3: Monitor Build
The Docker build process will:
1. Install all dependencies with `pnpm install --frozen-lockfile`
2. Build the UI package
3. Build the server package
4. Create a production image with all necessary components

### Step 4: Verify Deployment
Once deployed, access your Paperclip instance at:
```
https://paperclip-z044.onrender.com
```

## Docker Build Process

The Dockerfile uses a multi-stage build:

1. **Base Stage**: Sets up Node.js and enables corepack for pnpm
2. **Deps Stage**: Installs all dependencies from the monorepo
3. **Build Stage**: Builds UI and server packages
4. **Production Stage**: Creates minimal production image with:
   - Built application files
   - Global AI tools (claude-code, codex, opencode-ai)
   - Persistent volume at `/paperclip`
   - Non-root user for security

## Advantages of Docker Deployment

1. **Simplified Build**: Docker handles all monorepo complexity automatically
2. **Consistent Environment**: Same environment locally and in production
3. **Dependency Management**: All workspace dependencies resolved correctly
4. **Faster Debugging**: Can test locally with `docker build` before deploying

## Troubleshooting

### Build Fails
- Check Render build logs for specific errors
- Verify all environment variables are set correctly
- Ensure the Dockerfile builds successfully locally:
  ```bash
  cd ~/paperclip-render
  docker build -t paperclip-test .
  ```

### Database Connection Issues
- Verify DATABASE_URL is correct
- Check Supabase database is accessible
- Ensure database has been migrated (run `migrate-to-supabase.sh` if needed)

### Application Not Starting
- Check Render logs for startup errors
- Verify PORT environment variable is set to 3100
- Ensure persistent disk is properly mounted

## Testing Locally with Docker

To test the Docker build locally before deploying:

```bash
cd ~/paperclip-render

# Build the image
docker build -t paperclip-local .

# Run the container
docker run -p 3100:3100 \
  -e DATABASE_URL="postgresql://postgres:eBmrthjpeiqLA6LX@db.gmorarhibiptvcrnvrpi.supabase.co:5432/postgres" \
  -e PAPERCLIP_AGENT_JWT_SECRET="7b5a8e2e79a6d16da7f7d0d2fed81b6b13e49a69462dcdeef4bfa8b3d380195a" \
  -v paperclip-data:/paperclip \
  paperclip-local
```

Then access at: http://localhost:3100

## Next Steps

1. Configure environment variables in Render dashboard
2. Wait for automatic deployment to complete
3. Access your Paperclip instance
4. Set up user authentication
5. Test multi-user access
6. Configure AWS S3 for file storage (optional)

## Support

- Render Documentation: https://render.com/docs
- Paperclip GitHub: https://github.com/paperclipai/paperclip
- Supabase Dashboard: https://gmorarhibiptvcrnvrpi.supabase.co
