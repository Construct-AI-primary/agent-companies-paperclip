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
# LangExtract API Server

## Overview

This directory contains the LangExtract API server for structured document extraction in HITL workflows. The server provides REST endpoints for extracting entities, dates, amounts, and other structured data from unstructured correspondence and contract documents.

**📖 Related Documentation:**
- **Integration Procedure**: `/Users/_PropAI/construct_ai/docs/procedures/00435_LANGEXTRACT_INTEGRATION_PROCEDURE.md` - Comprehensive LangExtract integration guide for the entire Construct AI platform
- **Correspondence Workflow**: `/Users/_PropAI/construct_ai/docs/workflows/00435_WORKFLOW_CORRESPONDENCE_AGENT_ORCHESTRATION/00435_CORRESPONDENCE_WORKFLOW_USER_GUIDE.md` - How LangExtract fits into the correspondence agent workflow
- **HITL Procedure**: `/Users/_PropAI/construct_ai/docs/procedures/0000_WORKFLOW_HITL_PROCEDURE.md` - HITL workflow integration

**Note:** This README focuses specifically on running the LangExtract API server. For client-side integration patterns, vector store integration, and broader system architecture, please refer to `00435_LANGEXTRACT_INTEGRATION_PROCEDURE.md`.

## Quick Start

### 1. Automatic Setup (Recommended)

The project now includes automatic setup scripts that work across different machines:

```bash
# From the project root directory
npm run setup-langextract
```

This script will:
- Check for Python installation
- Install required dependencies (fastapi, uvicorn, pydantic)
- Test server startup
- Provide fallback mode if LangExtract library is unavailable

### 2. Manual Setup (Alternative)

If you prefer manual setup:

```bash
cd deep-agents

# Install required Python packages
pip install fastapi uvicorn pydantic python-multipart

# Install LangExtract library (optional - server works in fallback mode without it)
pip install langextract
```

### 2. Start the Server

```bash
# Make the script executable (first time only)
chmod +x langextract_server.py

# Start the server
python langextract_server.py
```

The server will start on `http://localhost:8000`

### 3. Verify It's Running

Open your browser or use curl:

```bash
# Health check
curl http://localhost:8000/health

# Expected response:
# {
#   "status": "healthy",
#   "langextract_installed": true,
#   "service": "LangExtract API",
#   "version": "1.0.0"
# }
```

### 4. Test the API

```bash
# Test extraction
curl -X POST http://localhost:8000/extract \
  -H "Content-Type: application/json" \
  -d '{
    "text": "Contract ABC123 dated 15 January 2025 for ZAR 1,000,000. Contact: john@example.com",
    "document_type": "correspondence"
  }'
```

## API Endpoints

### POST /extract
Extract structured data from documents.

**Request:**
```json
{
  "text": "Your document text here...",
  "document_type": "correspondence",  // or "contract", "specification"
  "task_id": "optional-task-id"
}
```

**Response:**
```json
{
  "success": true,
  "extractions": [
    {
      "type": "date",
      "value": "15 January 2025",
      "attributes": {"context": "contract date"}
    },
    {
      "type": "currency_amount",
      "value": "ZAR 1,000,000",
      "attributes": {"context": "contract value"}
    }
  ],
  "summary": {
    "date": ["15 January 2025"],
    "currency_amount": ["ZAR 1,000,000"]
  },
  "visualization_html": "<div>...</div>",
  "metadata": {
    "extracted_at": "2025-01-15T10:30:00",
    "extraction_count": 2
  }
}
```

### GET /health
Check service health and LangExtract library status.

### GET /
Service information and endpoint documentation.

### GET /docs
Interactive API documentation (Swagger UI) - Open in browser.

## Integration with Frontend

The HITL review modal (`client/src/pages/01300-hitl-review/components/01300-hitl-review-page.js`) is already configured to use this API:

1. When a HITL task is opened, the modal automatically calls `/extract`
2. Extracted data is displayed in an interactive visualization
3. If the service is unavailable, a user-friendly error message is shown

**Frontend expects:**
- Server running on `http://localhost:8000`
- CORS enabled for `http://localhost:3060`
- Response format as shown above

## Document Types

The service supports three extraction types:

### 1. Correspondence
Extracts:
- Dates (contract dates, deadlines)
- Currency amounts
- Contact details (names, phone, email)
- Time periods (payment terms, notice periods)
- Parties involved

### 2. Contract
Extracts:
- Parties (contractor, client, roles)
- Contract value
- Important dates (start, completion, milestones)
- Financial terms (retention, penalties)
- Obligation deadlines

### 3. Specification
Extracts:
- Material grades (concrete, steel)
- Strength requirements (MPa values)
- Dimensions and tolerances
- Ratios and proportions
- Coverage requirements

## Troubleshooting

### Server won't start

**Issue:** Import error for `langextract`
```bash
# Install the library
pip install langextract
```

**Issue:** Import error for `fastapi` or `uvicorn`
```bash
# Install dependencies
pip install fastapi uvicorn pydantic
```

**Issue:** Port 8000 already in use
```bash
# Find and kill the process
lsof -ti:8000 | xargs kill -9

# Or use a different port by editing langextract_server.py
# Change: uvicorn.run(app, host="0.0.0.0", port=8001, ...)
```

### Frontend can't connect

**Issue:** CORS errors in browser console
- Ensure server is running on port 8000
- Check CORS origins in `langextract_server.py` include your frontend URL
- Try restarting both frontend and backend

**Issue:** "Failed to fetch" error
```bash
# Verify server is running
curl http://localhost:8000/health

# Check firewall settings
# Ensure port 8000 is not blocked
```

### LangExtract not working

**Issue:** Library installed but not working
```bash
# Check if LangExtract can import
python -c "import langextract; print('OK')"

# If fails, reinstall
pip uninstall langextract
pip install langextract
```

**Issue:** API Key required
- Some LangExtract features may require Google Gemini or OpenAI API keys
- Set environment variables:
```bash
export GOOGLE_API_KEY="your-key-here"
# or
export OPENAI_API_KEY="your-key-here"
```

## Development

### Running in Development Mode

```bash
# With auto-reload (for development)
uvicorn langextract_server:app --reload --port 8000

# With verbose logging
uvicorn langextract_server:app --log-level debug --port 8000
```

### Testing

```bash
# Run health check
curl http://localhost:8000/health

# Test extraction with sample data
curl -X POST http://localhost:8000/extract \
  -H "Content-Type: application/json" \
  -d @test_data.json

# View interactive docs
open http://localhost:8000/docs
```

### Logging

Logs are written to stdout/stderr. View them in the terminal where you started the server.

```bash
# Start with custom log level
LOG_LEVEL=debug python langextract_server.py
```

## Production Deployment

### Using systemd (Linux)

Create `/etc/systemd/system/langextract.service`:

```ini
[Unit]
Description=LangExtract API Server
After=network.target

[Service]
Type=simple
User=your-user
WorkingDirectory=/Users/_PropAI/construct_ai/deep-agents
ExecStart=/usr/bin/python3 /Users/_PropAI/construct_ai/deep-agents/langextract_server.py
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

Then:
```bash
sudo systemctl daemon-reload
sudo systemctl enable langextract
sudo systemctl start langextract
sudo systemctl status langextract
```

### Using Docker

```dockerfile
FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY deep_agents ./deep_agents
COPY langextract_server.py .

EXPOSE 8000

CMD ["python", "langextract_server.py"]
```

```bash
docker build -t langextract-api .
docker run -p 8000:8000 langextract-api
```

### Using PM2 (Node.js process manager)

```bash
# Install PM2
npm install -g pm2

# Start with PM2
pm2 start langextract_server.py --name langextract-api --interpreter python3

# View logs
pm2 logs langextract-api

# Make it start on boot
pm2 startup
pm2 save
```

## Architecture

```
Frontend (React)
    ↓
    ↓ HTTP POST /extract
    ↓
LangExtract API Server (FastAPI)
    ↓
    ↓ Function call
    ↓
LangExtract Service (Python)
    ↓
    ↓ API call
    ↓
Google Gemini / OpenAI
```

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Review the API documentation at `/docs`
3. Check server logs for error messages
4. Refer to LangExtract documentation: https://github.com/google/langextract

## License

See main project LICENSE file.