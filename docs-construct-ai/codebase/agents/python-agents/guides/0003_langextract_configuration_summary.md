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
# LangExtract Configuration Fix Summary

## Problem Statement

The LangExtract service in the HITL review modal was displaying the error:
```
Gemini models require either:
- An API key via api_key parameter or LANGEXTRACT_API_KEY env var
- Vertex AI configuration with vertexai=True, project, and location
```

**Root Causes:**
1. LangExtract service defaulted to Gemini model instead of OpenAI
2. Server wasn't loading OpenAI API key from `.env.dev` file
3. User has OpenAI API key but service was configured for Gemini

## Architecture Clarification

### Port Usage
- **Port 3060/3001**: Frontend React application (user interface)
- **Port 8000**: Backend LangExtract API service (Python FastAPI microservice)
  - This is a separate microservice for document extraction
  - Runs independently from the frontend
  - Frontend makes HTTP requests to `http://localhost:8000/extract`

### Why Separate Port?
The LangExtract service is a Python-based microservice that:
- Uses Google's LangExtract library for structured extraction
- Requires Python dependencies (langextract, fastapi, uvicorn)
- Provides REST API endpoints for the frontend to consume
- Can be scaled independently from the main application

## Changes Made

### 1. Changed Default Model from Gemini to OpenAI
**File:** `deep-agents/deep_agents/services/00435_langextract_service.py`

```python
# BEFORE (Line 272)
def extract_structured_data(
    text_or_documents: Union[str, List[str]],
    extraction_type: str = "correspondence",
    model_provider: str = "gemini",  # ❌ Defaulted to Gemini
    ...
)

# AFTER
def extract_structured_data(
    text_or_documents: Union[str, List[str]],
    extraction_type: str = "correspondence",
    model_provider: str = "openai",  # ✅ Now defaults to OpenAI
    ...
)
```

### 2. Added Environment Variable Loading
**File:** `deep-agents/langextract_server.py`

Added manual `.env.dev` file parser (no external dependencies needed):

```python
# Manually load environment variables from .env.dev
def load_env_file(filepath):
    """Load environment variables from a file without requiring python-dotenv."""
    if not os.path.exists(filepath):
        return False
    
    with open(filepath, 'r') as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith('#') and '=' in line:
                key, value = line.split('=', 1)
                os.environ[key.strip()] = value.strip()
    return True

# Load environment variables from .env.dev
env_path = os.path.join(os.path.dirname(__file__), '..', '.env.dev')
if load_env_file(env_path):
    print(f"✅ Loaded environment variables from: {env_path}")
else:
    print(f"⚠️  .env.dev not found at: {env_path}")

# Verify OpenAI API key is loaded
openai_key = os.getenv('OPENAI_API_KEY')
if openai_key:
    print(f"✅ OpenAI API Key loaded (length: {len(openai_key)} chars)")
else:
    print("⚠️  WARNING: OPENAI_API_KEY not found in environment!")
```

## How to Restart the Server

### Step 1: Stop Current Server (if running)
```bash
# Find the process on port 8000
lsof -ti:8000 | xargs kill -9
```

### Step 2: Start the Server with New Configuration
```bash
cd /Users/_PropAI/construct_ai/deep-agents
python3 langextract_server.py
```

### Step 3: Verify Server Started Successfully
You should see:
```
============================================================
🚀 Starting LangExtract API Server
============================================================
✅ Loaded environment variables from: /Users/_PropAI/construct_ai/.env.dev
✅ OpenAI API Key loaded (length: 164 chars)
📍 Server URL: http://localhost:8000
📋 API Docs: http://localhost:8000/docs
🏥 Health Check: http://localhost:8000/health
🔧 LangExtract: ✅ Available
============================================================
```

### Step 4: Test the Service
```bash
# Health check
curl http://localhost:8000/health

# Test extraction
curl -X POST http://localhost:8000/extract \
  -H 'Content-Type: application/json' \
  -d '{
    "text": "Contract ABC123 dated 15 January 2025 for ZAR 1,000,000. Contact: john@example.com",
    "document_type": "correspondence"
  }'
```

## Expected Behavior

### Before Fix
- ❌ Service tried to use Gemini API
- ❌ Error: "Gemini models require API key"
- ❌ Modal showed "LangExtract service unavailable"

### After Fix
- ✅ Service uses OpenAI API (gpt-4o model)
- ✅ OpenAI API key loaded from `.env.dev`
- ✅ Extractions work correctly
- ✅ Modal displays structured data with visualization

## Model Configuration

The service now supports both models but defaults to OpenAI:

```python
MODEL_CONFIGS = {
    "gemini": {
        "model_id": "gemini-2.5-flash",
        "provider": "google"
    },
    "openai": {
        "model_id": "gpt-4o",  # ✅ Default model
        "provider": "openai"
    }
}
```

To explicitly use Gemini, you would need to:
1. Set `LANGEXTRACT_API_KEY` environment variable
2. Pass `model_provider="gemini"` parameter to the extraction function

## Frontend Integration

The HITL review page (`01300-hitl-review-page.js`) calls the LangExtract service:

```javascript
const response = await fetch('http://localhost:8000/extract', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    text: documentText,
    document_type: 'correspondence',
    task_id: selectedTask?.id
  }),
  signal: AbortSignal.timeout(10000)
});
```

## Troubleshooting

### If service still shows Gemini error:
1. **Restart the server** - Old process may be cached
2. **Check .env.dev** - Verify `OPENAI_API_KEY` is set
3. **Check console** - Look for "✅ OpenAI API Key loaded" message

### If modal doesn't display:
1. **Check server is running** - Visit http://localhost:8000/health
2. **Check browser console** - Look for fetch errors
3. **Check CORS** - Server allows ports 3060, 3000, 3001

### If extraction fails:
1. **Check OpenAI API quota** - Verify your API key has credits
2. **Check API key validity** - Test with OpenAI API directly
3. **Check document text** - Ensure it's not empty or too large

## Documentation References

- **Service Implementation**: `deep-agents/deep_agents/services/00435_langextract_service.py`
- **Server Implementation**: `deep-agents/langextract_server.py`
- **Server README**: `deep-agents/LANGEXTRACT_README.md`
- **Integration Procedure**: `docs/procedures/00435_LANGEXTRACT_INTEGRATION_PROCEDURE.md`
- **HITL Procedure**: `docs/procedures/0000_WORKFLOW_HITL_PROCEDURE.md`

## Next Steps

1. ✅ **Restart server** with new configuration
2. ✅ **Test health endpoint** to verify service is running
3. ✅ **Test extraction** with sample document
4. ✅ **Open HITL modal** in frontend and verify visualization displays
5. ✅ **Monitor logs** for any OpenAI API errors

## Summary

The issue was that LangExtract defaulted to Gemini (Google's model) but you're using OpenAI. The fix changes the default to OpenAI and ensures your OpenAI API key from `.env.dev` is properly loaded into the server environment. Port 8000 is used because this is a separate Python microservice that provides extraction capabilities to your main React frontend.
