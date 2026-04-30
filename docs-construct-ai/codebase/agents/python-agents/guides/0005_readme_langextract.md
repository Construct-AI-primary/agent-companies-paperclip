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
# LangExtract Service Setup & Usage

## Overview
LangExtract is an AI-powered document extraction service that provides structured data extraction from construction documents, correspondence, and specifications. It uses Gemini AI to intelligently detect engineering disciplines and extract relevant information.

## Permanent Setup ✅

### 1. Virtual Environment (PERMANENT)
A Python virtual environment has been created at `deep-agents/venv/` with all required dependencies:
- FastAPI (web framework)
- Uvicorn (ASGI server)
- LangExtract (AI extraction library)
- Pydantic (data validation)
- All other dependencies from `requirements.txt`

**Location**: `/Users/_PropAI/construct_ai/deep-agents/venv/`

### 2. Frontend Timeout Fixed (PERMANENT)
The following files have been permanently modified with a 120-second timeout:

**File**: `client/src/pages/01300-hitl-review/components/hitl-review-modal.jsx`
- **Line 268**: `signal: AbortSignal.timeout(120000)` (2 minutes)
- **Error messaging**: Enhanced with helpful context about AI processing time

**File**: `client/src/pages/01300-hitl-review/components/LangExtractDisplay.jsx`
- **Loading message**: "Processing document with AI... This may take up to 2 minutes"

These changes are permanent and included in the built client code.

## Starting the Server

### Method 1: Using the Startup Script (RECOMMENDED)
```bash
cd deep-agents
./start_langextract.sh
```

This script:
- Checks if the virtual environment exists (creates if missing)
- Activates the virtual environment
- Kills any existing process on port 8000
- Starts the LangExtract server

### Method 2: Manual Start
```bash
cd deep-agents
source venv/bin/activate
python langextract_server.py
```

### Method 3: Background Process
```bash
cd deep-agents
source venv/bin/activate
nohup python langextract_server.py > /tmp/langextract.log 2>&1 &
```

## Verifying the Server

### Health Check
```bash
curl http://localhost:8000/health
```

Expected response:
```json
{
  "status": "healthy",
  "langextract_installed": true,
  "service": "LangExtract API",
  "version": "1.0.0"
}
```

### API Documentation
Open in browser: http://localhost:8000/docs

This provides an interactive Swagger UI for testing the API.

### Test Extraction
```bash
curl -X POST http://localhost:8000/extract \
  -H "Content-Type: application/json" \
  -d '{
    "text": "Contract ABC123 dated 2025-01-15 for ZAR 1,000,000. Contact: john@example.com",
    "document_type": "correspondence"
  }'
```

## Server Configuration

- **Port**: 8000
- **Host**: 0.0.0.0 (accessible from all interfaces)
- **Timeout**: Client-side 120 seconds (2 minutes)
- **CORS**: Enabled for localhost:3060 and localhost:3000
- **API Key**: Loads from `.env.dev` in project root

## Troubleshooting

### Server Not Starting
```bash
# Check if port is in use
lsof -ti:8000

# Kill existing process
kill -9 $(lsof -ti:8000)

# Restart server
./start_langextract.sh
```

### Dependencies Missing
```bash
cd deep-agents
source venv/bin/activate
pip install -r requirements.txt
```

### Virtual Environment Corrupt
```bash
cd deep-agents
rm -rf venv
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

## System Integration

### Starting with Main Application
Add to your main startup script:
```bash
# Start LangExtract server in background
cd deep-agents && ./start_langextract.sh &

# Wait for server to be ready
sleep 5

# Start main application
npm start
```

### Monitoring
Check server logs:
```bash
tail -f /tmp/langextract.log
```

### Auto-start on System Boot (macOS)
Create a LaunchAgent plist file at:
`~/Library/LaunchAgents/com.constructai.langextract.plist`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.constructai.langextract</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Users/_PropAI/construct_ai/deep-agents/start_langextract.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/langextract.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/langextract_error.log</string>
</dict>
</plist>
```

Then run:
```bash
launchctl load ~/Library/LaunchAgents/com.constructai.langextract.plist
```

## Performance Notes

### Processing Time
- **Simple documents** (< 500 chars): 5-15 seconds
- **Medium documents** (500-2000 chars): 15-45 seconds
- **Complex documents** (> 2000 chars): 45-120 seconds

The processing time includes:
1. Discipline detection (5-10 seconds)
2. Specialized prompt building (2-5 seconds)
3. Gemini AI extraction (10-90 seconds)
4. Result formatting (1-3 seconds)

### Concurrent Requests
When multiple HITL modals open simultaneously (as in your logs showing 4 concurrent requests), processing times may increase due to:
- Rate limiting on Gemini API
- CPU/memory constraints
- Sequential processing of AI requests

The 120-second timeout accommodates this scenario.

## Architecture

```
Frontend (React)
    ↓ HTTP POST /extract
LangExtract Server (FastAPI)
    ↓ calls
langextract_service.py
    ↓ detects disciplines
    ↓ builds specialized prompts
    ↓ calls
Gemini AI (Google)
    ↓ returns
Structured Data
    ↓ formats
JSON Response → Frontend
```

## Files Modified (Permanent Changes)

1. ✅ `client/src/pages/01300-hitl-review/components/hitl-review-modal.jsx`
2. ✅ `client/src/pages/01300-hitl-review/components/LangExtractDisplay.jsx`
3. ✅ `deep-agents/venv/` (directory with all dependencies)
4. ✅ `deep-agents/start_langextract.sh` (startup script)
5. ✅ `deep-agents/README_LANGEXTRACT.md` (this file)

## Support

For issues or questions:
1. Check server logs: `tail -f /tmp/langextract.log`
2. Verify health: `curl http://localhost:8000/health`
3. Review API docs: http://localhost:8000/docs
4. Check Gemini API key in `.env.dev`

Last updated: January 12, 2026