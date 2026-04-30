# Paperclip MCP Server

[![npm](https://img.shields.io/npm/v/@alantennant/paperclip-mcp.svg)](https://www.npmjs.com/package/@alantennant/paperclip-mcp)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

MCP (Model Context Protocol) server for [Paperclip](https://github.com/construct-ai/paperclip) - interact with your Paperclip instance programmatically from any MCP-compatible AI client.

## Features

### Tools
| Tool | Description |
|------|-------------|
| `list_companies` | List all companies (with optional search) |
| `get_company` | Get details of a specific company |
| `list_agents` | List agents for a company (filter by status/search) |
| `get_agent` | Get full agent details |
| `list_skills` | List skills for a company |
| `get_skill` | Get skill details (metadata, usage, source info) |
| `get_skill_file` | Get content of a specific skill file |
| `list_issues` | List issues (filter by status/assignee/search) |
| `get_issue` | Get full issue details |

### Resources
| URI Pattern | Description |
|-------------|-------------|
| `paperclip://companies` | All companies |
| `paperclip://companies/{id}/agents` | Agents for a specific company |
| `paperclip://companies/{id}/skills` | Skills for a specific company |

## Installation

### Via npx (recommended)
No install required:
```bash
npx @alantennant/paperclip-mcp
```

### Global install
```bash
npm install -g @alantennant/paperclip-mcp
paperclip-mcp
```

## Configuration

| Environment Variable | Required | Description |
|---------------------|----------|-------------|
| `PAPERCLIP_URL` | Yes | Base URL of your Paperclip instance |
| `PAPERCLIP_API_KEY` | Yes (for auth) | Bearer API key for authentication |
| `PAPERCLIP_TIMEOUT_MS` | No | Request timeout (default: 30000) |

### Generate an API Key
1. Open Paperclip UI - **Instance Settings** - **API Keys**
2. Click **Generate Key**
3. Copy the key (it won't be shown again)
4. Set it as `PAPERCLIP_API_KEY`

## Usage

### Claude Desktop
Add to your Claude Desktop config (`claude_desktop_config.json`):

```json
{
  "mcpServers": {
    "paperclip": {
      "command": "npx",
      "args": ["@alantennant/paperclip-mcp"],
      "env": {
        "PAPERCLIP_URL": "https://your-paperclip-instance.com",
        "PAPERCLIP_API_KEY": "your-api-key-here"
      }
    }
  }
}
```

### Smithery

Use with npx for Smithery deployments:
```bash
npx @smithery/cli run @alantennant/paperclip-mcp --key YOUR_SMITHERY_KEY
```

### Cursor
Add to `.cursor/mcp.json`:
```json
{
  "mcpServers": {
    "paperclip": {
      "command": "npx",
      "args": ["@alantennant/paperclip-mcp"],
      "env": {
        "PAPERCLIP_URL": "https://your-paperclip-instance.com",
        "PAPERCLIP_API_KEY": "your-api-key"
      }
    }
  }
}
```

### Windsurf
Add to your MCP config similarly.

## Example Prompts

- "List all companies in my Paperclip instance"
- "Show me the active agents for company QFA"
- "Get the SKILL.md file for skill 20333f85-97d9-4afb-bfce-817649eeec51 in company QFA"
- "Show me all active issues assigned to agent X"
- "What skills are available for company DEV?"

## Development

```bash
cd mcp
npm install
npm run dev
```

## Publishing

```bash
npm run build
npm publish --access public
```

## Contributing

See [CONTRIBUTING.md](../CONTRIBUTING.md) in the main Paperclip repo for general contribution guidelines.

When submitting a PR to this package, please include a **Thinking Path** at the top:

```
> - Paperclip orchestrates AI agents for zero-human companies
> - The MCP server lets AI clients interact with Paperclip instances
> - [explain what you changed and why from the top down]
```

This is a separate package in the `mcp/` directory — changes here should not affect the core UI or API.

## License

MIT
