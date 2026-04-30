# Setup Scripts

This directory contains scripts for setting up and populating Paperclip companies and agents.

## Files

### `create_companies_and_agents.js`

Node.js script for creating companies and agents via the Paperclip API.

**Usage:**
```bash
node scripts/setup/create_companies_and_agents.js
```

**Options:**
- `--dry-run` - Preview what would be created without making changes
- `--verbose` - Show detailed progress information

**Features:**
- Creates DomainForge AI and InfraForge AI companies
- Populates agents for each company
- Establishes hierarchical reporting relationships
- Rate-limited API calls to avoid overwhelming the server

**Prerequisites:**
- Paperclip server running at `http://127.0.0.1:3100`
- Node.js installed
- `node-fetch` package available

### `create_agents.sh`

Shell script for agent creation (legacy).

**Usage:**
```bash
./scripts/setup/create_agents.sh
```

## Related Documentation

- [Adding Companies and Agents Procedure](../../docs-paperclip/procedures/adding-companies-and-agents.md)
- [Database Scripts](../database/README.md)
