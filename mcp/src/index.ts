#!/usr/bin/env node
/**
 * Paperclip MCP Server
 *
 * Interact with Paperclip instances — list companies, agents, skills, issues, and tasks.
 *
 * Configuration (environment variables):
 *   PAPERCLIP_URL       - Base URL of your Paperclip instance (required)
 *   PAPERCLIP_API_KEY   - API key for authentication (required for most endpoints)
 *   PAPERCLIP_TIMEOUT_MS - Request timeout in milliseconds (default: 30000)
 *
 * Usage:
 *   npx @construct-ai/paperclip-mcp
 *   # or install globally:
 *   npm install -g @construct-ai/paperclip-mcp
 *   paperclip-mcp
 *
 * Smithery configuration example:
 *   {
 *     "command": "npx",
 *     "args": ["@construct-ai/paperclip-mcp"],
 *     "env": {
 *       "PAPERCLIP_URL": "https://your-paperclip-instance.com",
 *       "PAPERCLIP_API_KEY": "your-api-key"
 *     }
 *   }
 */

import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { z } from "zod";

// ─── Config ───────────────────────────────────────────────────────────────────

const PAPERCLIP_URL = process.env.PAPERCLIP_URL;
const PAPERCLIP_API_KEY = process.env.PAPERCLIP_API_KEY;
const TIMEOUT_MS = Number.parseInt(process.env.PAPERCLIP_TIMEOUT_MS ?? "30000", 10);

if (!PAPERCLIP_URL) {
  console.error("Error: PAPERCLIP_URL environment variable is required.");
  console.error("Set it to the base URL of your Paperclip instance, e.g.:");
  console.error("  export PAPERCLIP_URL=https://paperclip.example.com");
  process.exit(1);
}

// ─── API Client ───────────────────────────────────────────────────────────────

interface RequestOptions {
  method?: "GET" | "POST" | "PUT" | "PATCH" | "DELETE";
  body?: unknown;
  headers?: Record<string, string>;
}

async function paperclipRequest<T>(path: string, opts: RequestOptions = {}): Promise<T> {
  const url = `${PAPERCLIP_URL.replace(/\/+$/, "")}/api${path}`;
  const headers: Record<string, string> = {
    "Content-Type": "application/json",
    "User-Agent": "paperclip-mcp/0.1.0",
    ...opts.headers,
  };

  if (PAPERCLIP_API_KEY) {
    headers["Authorization"] = `Bearer ${PAPERCLIP_API_KEY}`;
  }

  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), TIMEOUT_MS);

  try {
    const response = await fetch(url, {
      method: opts.method ?? "GET",
      headers,
      body: opts.body ? JSON.stringify(opts.body) : undefined,
      signal: controller.signal,
    });
    clearTimeout(timeout);

    if (!response.ok) {
      const text = await response.text().catch(() => "");
      throw new Error(`Paperclip API ${response.status}: ${text || response.statusText}`);
    }

    return (await response.json()) as T;
  } catch (err) {
    clearTimeout(timeout);
    if (err instanceof Error && err.name === "AbortError") {
      throw new Error(`Request to ${url} timed out after ${TIMEOUT_MS}ms`);
    }
    throw err;
  }
}

// ─── Shared Schemas ───────────────────────────────────────────────────────────

const companyIdArg = z.string().describe("Company ID (UUID)");
const paginationOpts = {
  limit: z.number().optional().default(50).describe("Max results to return"),
  offset: z.number().optional().default(0).describe("Offset for pagination"),
};

// ─── Server Setup ─────────────────────────────────────────────────────────────

const server = new McpServer({
  name: "paperclip",
  version: "0.1.0",
  description: "Paperclip control plane — manage companies, agents, skills, issues, and tasks.",
  capabilities: {
    tools: {},
    resources: {},
  },
});

// ===== Tools =====

// 1. List Companies
server.tool(
  "list_companies",
  "List all companies in the Paperclip instance.",
  {
    search: z.string().optional().describe("Search/filter companies by name (optional)"),
  },
  async ({ search }) => {
    interface Company {
      id: string;
      name: string;
      issuePrefix: string;
      status: string;
      description?: string | null;
      createdAt: string;
      updatedAt: string;
    }

    try {
      let companies = await paperclipRequest<Company[]>("/companies");
      if (search) {
        const q = search.toLowerCase();
        companies = companies.filter(
          (c) =>
            c.name.toLowerCase().includes(q) ||
            c.issuePrefix.toLowerCase().includes(q) ||
            (c.description ?? "").toLowerCase().includes(q),
        );
      }
      return {
        content: [
          {
            type: "text",
            text: JSON.stringify(companies, null, 2),
          },
        ],
      };
    } catch (err) {
      return {
        content: [
          {
            type: "text",
            text: `Error listing companies: ${err instanceof Error ? err.message : String(err)}`,
          },
        ],
        isError: true,
      };
    }
  },
);

// 2. Get Company
server.tool(
  "get_company",
  "Get details of a specific company by ID.",
  { companyId: companyIdArg },
  async ({ companyId }) => {
    try {
      const company = await paperclipRequest(`/companies/${encodeURIComponent(companyId)}`);
      return {
        content: [
          {
            type: "text",
            text: JSON.stringify(company, null, 2),
          },
        ],
      };
    } catch (err) {
      return {
        content: [
          {
            type: "text",
            text: `Error getting company: ${err instanceof Error ? err.message : String(err)}`,
          },
        ],
        isError: true,
      };
    }
  },
);

// 3. List Agents
server.tool(
  "list_agents",
  "List all agents for a given company, with optional status and search filters.",
  {
    companyId: companyIdArg,
    status: z.enum(["active", "paused", "error", "terminated", "all"]).optional().describe("Filter by agent status"),
    search: z.string().optional().describe("Search by agent name"),
    ...paginationOpts,
  },
  async ({ companyId, status, search, limit, offset }) => {
    try {
      interface Agent {
        id: string;
        name: string;
        role: string;
        status: string;
        issueKey?: string;
        description?: string | null;
        icon: string;
        reportsTo?: string | null;
        companyId: string;
      }

      const agents = await paperclipRequest<Agent[]>(
        `/companies/${encodeURIComponent(companyId)}/agents`,
      );

      let filtered = [...agents];
      if (status && status !== "all") {
        filtered = filtered.filter((a) => a.status === status);
      }
      if (search) {
        const q = search.toLowerCase();
        filtered = filtered.filter((a) => a.name.toLowerCase().includes(q));
      }

      const paged = filtered.slice(offset, offset + limit);
      return {
        content: [
          {
            type: "text",
            text: JSON.stringify(
              {
                total: filtered.length,
                returned: paged.length,
                offset,
                limit,
                agents: paged,
              },
              null,
              2,
            ),
          },
        ],
      };
    } catch (err) {
      return {
        content: [
          {
            type: "text",
            text: `Error listing agents: ${err instanceof Error ? err.message : String(err)}`,
          },
        ],
        isError: true,
      };
    }
  },
);

// 4. Get Agent
server.tool(
  "get_agent",
  "Get full details of a specific agent including configuration, permissions, and skills.",
  {
    companyId: companyIdArg,
    agentId: z.string().describe("Agent ID (UUID or short code)"),
  },
  async ({ companyId, agentId }) => {
    try {
      const agent = await paperclipRequest(
        `/companies/${encodeURIComponent(companyId)}/agents/${encodeURIComponent(agentId)}`,
      );
      return {
        content: [
          {
            type: "text",
            text: JSON.stringify(agent, null, 2),
          },
        ],
      };
    } catch (err) {
      return {
        content: [
          {
            type: "text",
            text: `Error getting agent: ${err instanceof Error ? err.message : String(err)}`,
          },
        ],
        isError: true,
      };
    }
  },
);

// 5. List Skills
server.tool(
  "list_skills",
  "List all skills available for a company, including file inventory count and source info.",
  {
    companyId: companyIdArg,
    search: z.string().optional().describe("Search by skill name or slug"),
    ...paginationOpts,
  },
  async ({ companyId, search, limit, offset }) => {
    try {
      interface SkillListItem {
        id: string;
        name: string;
        slug: string;
        key: string;
        sourceBadge: string;
        sourceLabel?: string | null;
        fileInventory: Array<{ path: string; kind: string }>;
        editable: boolean;
      }

      const skills = await paperclipRequest<SkillListItem[]>(
        `/companies/${encodeURIComponent(companyId)}/skills`,
      );

      let filtered = [...skills];
      if (search) {
        const q = search.toLowerCase();
        filtered = skills.filter(
          (s) =>
            s.name.toLowerCase().includes(q) ||
            s.slug.toLowerCase().includes(q) ||
            s.key.toLowerCase().includes(q),
        );
      }

      const summary = filtered.map((s) => ({
        id: s.id,
        name: s.name,
        slug: s.slug,
        key: s.key,
        source: s.sourceBadge,
        fileCount: s.fileInventory.length,
        editable: s.editable,
      }));

      const paged = summary.slice(offset, offset + limit);
      return {
        content: [
          {
            type: "text",
            text: JSON.stringify(
              {
                total: filtered.length,
                returned: paged.length,
                offset,
                limit,
                skills: paged,
              },
              null,
              2,
            ),
          },
        ],
      };
    } catch (err) {
      return {
        content: [
          {
            type: "text",
            text: `Error listing skills: ${err instanceof Error ? err.message : String(err)}`,
          },
        ],
        isError: true,
      };
    }
  },
);

// 6. Get Skill Detail
server.tool(
  "get_skill",
  "Get full details of a skill including metadata, usage, and source information.",
  {
    companyId: companyIdArg,
    skillId: z.string().describe("Skill ID (UUID)"),
  },
  async ({ companyId, skillId }) => {
    try {
      interface SkillDetail {
        id: string;
        companyId: string;
        key: string;
        name: string;
        slug: string;
        description: string | null;
        sourceType: "github" | "skills_sh" | "url" | "local" | "paperclip" | "catalog";
        sourcePath: string | null;
        sourceRef: string | null;
        sourceLabel: string | null;
        editable: boolean;
        editableReason: string | null;
        usedByAgents: Array<{ id: string; name: string; urlKey: string }>;
        fileInventory: Array<{ path: string; kind: string }>;
      }

      const skill = await paperclipRequest<SkillDetail>(
        `/companies/${encodeURIComponent(companyId)}/skills/${encodeURIComponent(skillId)}`,
      );
      return {
        content: [
          {
            type: "text",
            text: JSON.stringify(skill, null, 2),
          },
        ],
      };
    } catch (err) {
      return {
        content: [
          {
            type: "text",
            text: `Error getting skill: ${err instanceof Error ? err.message : String(err)}`,
          },
        ],
        isError: true,
      };
    }
  },
);

// 7. Get Skill File
server.tool(
  "get_skill_file",
  "Get the content of a specific file within a skill package.",
  {
    companyId: companyIdArg,
    skillId: z.string().describe("Skill ID (UUID)"),
    filePath: z
      .string()
      .describe("Relative file path within the skill package (default: SKILL.md)"),
  },
  async ({ companyId, skillId, filePath }) => {
    try {
      interface SkillFile {
        path: string;
        content: string;
        markdown: boolean;
        editable: boolean;
        sizeBytes: number;
      }

      const file = await paperclipRequest<SkillFile>(
        `/companies/${encodeURIComponent(companyId)}/skills/${encodeURIComponent(skillId)}/files?path=${encodeURIComponent(filePath)}`,
      );
      return {
        content: [
          {
            type: "text",
            text: JSON.stringify(
              {
                path: file.path,
                markdown: file.markdown,
                editable: file.editable,
                sizeBytes: file.sizeBytes,
                content: file.content,
              },
              null,
              2,
            ),
          },
        ],
      };
    } catch (err) {
      return {
        content: [
          {
            type: "text",
            text: `Error getting skill file: ${err instanceof Error ? err.message : String(err)}`,
          },
        ],
        isError: true,
      };
    }
  },
);

// 8. List Issues
server.tool(
  "list_issues",
  "List issues for a company with optional filters for status, assignee, and search.",
  {
    companyId: companyIdArg,
    status: z
      .enum(["backlog", "active", "done", "all"])
      .optional()
      .describe("Filter by issue status"),
    assigneeAgentId: z.string().optional().describe("Filter by assigned agent ID"),
    search: z.string().optional().describe("Search issue titles and bodies"),
    ...paginationOpts,
  },
  async ({ companyId, status, assigneeAgentId, search, limit, offset }) => {
    try {
      interface Issue {
        id: string;
        issueKey: string;
        title: string;
        status: string;
        assigneeAgentId?: string | null;
        assigneeAgentName?: string | null;
        description?: string | null;
        priority?: string | null;
        updatedAt: string;
      }

      const allIssues = await paperclipRequest<Issue[]>(
        `/companies/${encodeURIComponent(companyId)}/issues`,
      );

      let filtered = [...allIssues];
      if (status && status !== "all") {
        filtered = filtered.filter((i) => i.status === status);
      }
      if (assigneeAgentId) {
        filtered = filtered.filter((i) => i.assigneeAgentId === assigneeAgentId);
      }
      if (search) {
        const q = search.toLowerCase();
        filtered = filtered.filter(
          (i) =>
            i.title.toLowerCase().includes(q) ||
            (i.description ?? "").toLowerCase().includes(q),
        );
      }

      // Sort by updatedAt descending
      filtered.sort((a, b) => new Date(b.updatedAt).getTime() - new Date(a.updatedAt).getTime());

      const paged = filtered.slice(offset, offset + limit);
      return {
        content: [
          {
            type: "text",
            text: JSON.stringify(
              {
                total: filtered.length,
                returned: paged.length,
                offset,
                limit,
                issues: paged,
              },
              null,
              2,
            ),
          },
        ],
      };
    } catch (err) {
      return {
        content: [
          {
            type: "text",
            text: `Error listing issues: ${err instanceof Error ? err.message : String(err)}`,
          },
        ],
        isError: true,
      };
    }
  },
);

// 9. Get Issue
server.tool(
  "get_issue",
  "Get full details of a specific issue including comments and assignment info.",
  {
    companyId: companyIdArg,
    issueId: z.string().describe("Issue ID (UUID)"),
  },
  async ({ companyId, issueId }) => {
    try {
      const issue = await paperclipRequest(
        `/companies/${encodeURIComponent(companyId)}/issues/${encodeURIComponent(issueId)}`,
      );
      return {
        content: [
          {
            type: "text",
            text: JSON.stringify(issue, null, 2),
          },
        ],
      };
    } catch (err) {
      return {
        content: [
          {
            type: "text",
            text: `Error getting issue: ${err instanceof Error ? err.message : String(err)}`,
          },
        ],
        isError: true,
      };
    }
  },
);

// ===== Resources =====

// Companies resource
server.resource(
  "companies",
  "paperclip://companies",
  async () => {
    interface Company {
      id: string;
      name: string;
      issuePrefix: string;
      status: string;
    }

    try {
      const companies = await paperclipRequest<Company[]>("/companies");
      return {
        contents: [
          {
            uri: "paperclip://companies",
            mimeType: "application/json",
            text: JSON.stringify(companies, null, 2),
          },
        ],
      };
    } catch (err) {
      return {
        contents: [
          {
            uri: "paperclip://companies",
            mimeType: "application/json",
            text: JSON.stringify({ error: err instanceof Error ? err.message : String(err) }),
          },
        ],
      };
    }
  },
);

// Agents resource (per company)
server.resource(
  "agents",
  "paperclip://companies/{companyId}/agents",
  async (uri) => {
    const match = uri.pathname.match(/^\/companies\/([^/]+)\/agents$/);
    if (!match) {
      return {
        contents: [
          {
            uri: uri.href,
            mimeType: "application/json",
            text: JSON.stringify({ error: "Invalid path. Use paperclip://companies/{id}/agents" }),
          },
        ],
      };
    }
    const [, companyId] = match;
    try {
      const agents = await paperclipRequest(`/companies/${encodeURIComponent(companyId)}/agents`);
      return {
        contents: [
          {
            uri: uri.href,
            mimeType: "application/json",
            text: JSON.stringify(agents, null, 2),
          },
        ],
      };
    } catch (err) {
      return {
        contents: [
          {
            uri: uri.href,
            mimeType: "application/json",
            text: JSON.stringify({ error: err instanceof Error ? err.message : String(err) }),
          },
        ],
      };
    }
  },
);

// Skills resource (per company)
server.resource(
  "skills",
  "paperclip://companies/{companyId}/skills",
  async (uri) => {
    const match = uri.pathname.match(/^\/companies\/([^/]+)\/skills$/);
    if (!match) {
      return {
        contents: [
          {
            uri: uri.href,
            mimeType: "application/json",
            text: JSON.stringify({ error: "Invalid path. Use paperclip://companies/{id}/skills" }),
          },
        ],
      };
    }
    const [, companyId] = match;
    try {
      const skills = await paperclipRequest(`/companies/${encodeURIComponent(companyId)}/skills`);
      // Return lightweight listing
      const summary = skills.map((s: { id: string; name: string; slug: string; fileInventory?: unknown[] }) => ({
        id: s.id,
        name: s.name,
        slug: s.slug,
        fileCount: s.fileInventory?.length ?? 0,
      }));
      return {
        contents: [
          {
            uri: uri.href,
            mimeType: "application/json",
            text: JSON.stringify(summary, null, 2),
          },
        ],
      };
    } catch (err) {
      return {
        contents: [
          {
            uri: uri.href,
            mimeType: "application/json",
            text: JSON.stringify({ error: err instanceof Error ? err.message : String(err) }),
          },
        ],
      };
    }
  },
);

// ─── Run Server ───────────────────────────────────────────────────────────────

async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
}

main().catch((err) => {
  console.error("Paperclip MCP server failed to start:", err);
  process.exit(1);
});