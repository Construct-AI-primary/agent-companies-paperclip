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
# LangExtract Production Deployment Guide for Render

## Overview

This guide walks you through deploying the LangExtract API service to Render.com as a separate Python web service.

## Prerequisites

- Render.com account
- GitHub repository with your code
- Gemini API key from Google AI Studio (https://aistudio.google.com/apikey)
- Main app already deployed on Render

## Deployment Steps

### Step 1: Create New Web Service on Render

1. Log in to Render Dashboard: https://dashboard.render.com
2. Click **"New +"** button → Select **"Web Service"**
3. Connect your GitHub repository
4. Configure the service:
   - **Name**: `langextract-api` (or your preferred name)
   - **Region**: Same as your main app (for lower latency)
   - **Branch**: `main` (or your production branch)
   - **Root Directory**: `deep-agents` (important!)
   - **Runtime**: **Python 3**
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `python3 langextract_server.py`
   - **Plan**: **Free** (suitable for development/testing)

### Step 2: Configure Environment Variables

In the Render dashboard for your LangExtract service, add these environment variables:

#### Required:
```bash
LANGEXTRACT_API_KEY=<your-gemini-api-key-here>
```
Get your Gemini API key from: https://aistudio.google.com/apikey

#### Optional (if you want to support OpenAI):
```bash
OPENAI_API_KEY=<your-openai-api-key>
```

### Step 3: Deploy the Service

1. Click **"Create Web Service"**
2. Wait for the build to complete (~2-5 minutes)
3. Once deployed, note your service URL: `https://langextract-api-XXXXX.onrender.com`
4. Test the health endpoint: `https://your-langextract-url.onrender.com/health`

Expected response:
```json
{
  "status": "healthy",
  "langextract_installed": true,
  "service": "LangExtract API",
  "version": "1.0.0"
}
```

### Step 4: Update Main App Environment Variables

In your **main app's** Render dashboard, add/update this environment variable:

```bash
LANGEXTRACT_API_URL=https://langextract-api-XXXXX.onrender.com
```
Replace with your actual LangExtract service URL.

### Step 5: Rebuild Main App

1. Go to your main app's Render dashboard
2. Click **"Manual Deploy"** → **"Deploy latest commit"**
3. This ensures the frontend picks up the new `LANGEXTRACT_API_URL` environment variable

## Verification

### Test the Deployment:

```bash
# 1. Health check
curl https://your-langextract-url.onrender.com/health

# 2. Test extraction
curl -X POST https://your-langextract-url.onrender.com/extract \
  -H 'Content-Type: application/json' \
  -d '{
    "text": "Contract ABC123 dated 15 January 2025 for ZAR 1,000,000. Contact: john@example.com",
    "document_type": "correspondence",
    "task_id": "test-123"
  }'
```

### Test in HITL Modal:

1. Open your production app
2. Navigate to HITL review page
3. Open a task with a document
4. Check the **"LangExtract Structured Data"** section
5. Should show extracted fields and visualization

## Important Notes

### Free Tier Limitations:
- **Sleeps after 15 minutes of inactivity**
- First request after sleep takes ~30-60 seconds (cold start)
- 750 hours/month free (sufficient for development)

### Cold Start Solutions:
1. **Upgrade to Paid Plan** ($7/month) - no sleep
2. **Use a Ping Service** - Keep service awake
   - https://uptimerobot.com (free monitoring)
   - Ping every 14 minutes: `https://your-langextract-url.onrender.com/health`

### CORS Configuration:
The service is pre-configured to allow requests from:
- `http://localhost:3060` (local development)
- Your production frontend URL (automatically allowed)

If you need additional origins, update `langextract_server.py`:
```python
allow_origins=[
    "http://localhost:3060",
    "https://your-main-app.onrender.com",
    "https://your-custom-domain.com"
]
```

## Troubleshooting

### Service Won't Start:
- Check build logs for dependency errors
- Verify Python version (needs 3.11+)
- Check `requirements.txt` is in `deep-agents/` directory

### "LANGEXTRACT_API_KEY not found":
- Verify environment variable is set in Render dashboard
- Variable name must be exactly: `LANGEXTRACT_API_KEY`
- Redeploy after adding environment variable

### Frontend Shows "Service Unavailable":
- Check `LANGEXTRACT_API_URL` is set in main app environment
- Ensure URL includes `https://` protocol
- Verify service is running (check health endpoint)
- Check browser console for CORS errors

### Extraction Fails:
- Verify Gemini API key is valid
- Check Gemini API quota (free tier: 60 requests/minute)
- Review service logs in Render dashboard

## Monitoring

### View Logs:
1. Go to LangExtract service in Render dashboard
2. Click **"Logs"** tab
3. Monitor for errors or API issues

### Key Log Messages:
```
✅ Loaded environment variables from: ...
✅ Gemini API Key loaded (length: XX chars)
✅ LangExtract Library: ✅ Installed
🚀 LangExtract API Server Starting
```

## Cost Estimation

### Render Costs:
- **Free Tier**: $0/month (sleeps after 15 min)
- **Starter Plan**: $7/month (always on, 512MB RAM)
- **Standard Plan**: $25/month (2GB RAM, better performance)

### API Costs:
- **Gemini Free Tier**: 60 requests/minute, unlimited
- **Gemini Paid**: $0.00035 per 1K characters input
- **OpenAI (optional)**: $0.01 per 1K tokens input

### Recommended for Production:
- **Render**: Starter Plan ($7/month)
- **API**: Gemini Free Tier (upgrade if hitting limits)

## Local Development

Your local development setup remains unchanged:

```bash
cd /Users/_PropAI/construct_ai/deep-agents
python3 langextract_server.py
```

Frontend automatically uses `http://localhost:8000` when `LANGEXTRACT_API_URL` is not set.

## Rollback Instructions

If you need to rollback or disable LangExtract in production:

1. **Remove environment variable** from main app:
   - Delete `LANGEXTRACT_API_URL` from Render dashboard
   - Redeploy main app

2. **Result**: HITL modal shows "Service unavailable" but continues to work without LangExtract

3. **Delete service** (optional):
   - Go to LangExtract service dashboard
   - Settings → Delete Service

## Security Considerations

✅ **HTTPS Enforced**: All Render services use HTTPS by default
✅ **API Keys**: Stored securely in Render environment variables
✅ **CORS**: Restricted to your frontend domains only
✅ **No Authentication**: Service assumes trusted internal network (behind Render's infrastructure)

⚠️ **Note**: If you need public API access, add authentication middleware

## Support & Documentation

- **Render Docs**: https://render.com/docs
- **LangExtract Docs**: https://github.com/google/langextract
- **Service README**: `deep-agents/LANGEXTRACT_README.md`
- **Integration Docs**: `docs/procedures/00435_LANGEXTRACT_INTEGRATION_PROCEDURE.md`

## Quick Reference

| Environment | URL | Usage |
|-------------|-----|-------|
| **Local Dev** | `http://localhost:8000` | Development & testing |
| **Production** | `https://langextract-api-XXXXX.onrender.com` | Live deployment |

| Variable | Location | Value |
|----------|----------|-------|
| `LANGEXTRACT_API_KEY` | LangExtract service | Your Gemini API key |
| `LANGEXTRACT_API_URL` | Main app | LangExtract service URL |

---

**Deployment Complete! 🎉**

Your LangExtract service is now running in production and ready to enhance your HITL workflow with intelligent document extraction.
