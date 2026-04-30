FROM node:lts-trixie-slim AS base
ARG USER_UID=1000
ARG USER_GID=1000
RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates gosu curl git wget ripgrep python3 \
  && mkdir -p -m 755 /etc/apt/keyrings \
  && wget -nv -O/etc/apt/keyrings/githubcli-archive-keyring.gpg https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  && echo "20e0125d6f6e077a9ad46f03371bc26d90b04939fb95170f5a1905099cc6bcc0  /etc/apt/keyrings/githubcli-archive-keyring.gpg" | sha256sum -c - \
  && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && mkdir -p -m 755 /etc/apt/sources.list.d \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends gh \
  && rm -rf /var/lib/apt/lists/*
RUN corepack enable && corepack prepare pnpm@9.15.4 --activate

# Modify the existing node user/group to have the specified UID/GID to match host user
RUN usermod -u $USER_UID --non-unique node \
  && groupmod -g $USER_GID --non-unique node \
  && usermod -g $USER_GID -d /paperclip node

FROM base AS deps
WORKDIR /app
COPY package.json pnpm-workspace.yaml pnpm-lock.yaml .npmrc ./
COPY cli/package.json cli/
COPY server/package.json server/
COPY ui/package.json ui/
COPY packages/shared/package.json packages/shared/
COPY packages/db/package.json packages/db/
COPY packages/adapter-utils/package.json packages/adapter-utils/
COPY packages/mcp-server/package.json packages/mcp-server/
COPY packages/adapters/claude-local/package.json packages/adapters/claude-local/
COPY packages/adapters/codex-local/package.json packages/adapters/codex-local/
COPY packages/adapters/cursor-local/package.json packages/adapters/cursor-local/
COPY packages/adapters/gemini-local/package.json packages/adapters/gemini-local/
COPY packages/adapters/openclaw-gateway/package.json packages/adapters/openclaw-gateway/
COPY packages/adapters/opencode-local/package.json packages/adapters/opencode-local/
COPY packages/adapters/pi-local/package.json packages/adapters/pi-local/
COPY packages/plugins/sdk/package.json packages/plugins/sdk/
COPY packages/plugins/create-paperclip-plugin/package.json packages/plugins/create-paperclip-plugin/
COPY packages/plugins/examples/plugin-hello-world-example/package.json packages/plugins/examples/plugin-hello-world-example/
COPY packages/plugins/examples/plugin-file-browser-example/package.json packages/plugins/examples/plugin-file-browser-example/
COPY packages/plugins/examples/plugin-authoring-smoke-example/package.json packages/plugins/examples/plugin-authoring-smoke-example/
COPY packages/plugins/examples/plugin-kitchen-sink-example/package.json packages/plugins/examples/plugin-kitchen-sink-example/
COPY patches/ patches/

RUN pnpm install --frozen-lockfile

FROM base AS build
WORKDIR /app
COPY --from=deps /app /app
COPY . .
ARG VITE_WS_BASE_URL
ENV VITE_WS_BASE_URL=$VITE_WS_BASE_URL
RUN echo "Building with VITE_WS_BASE_URL=${VITE_WS_BASE_URL}"
# Build order: shared first, then adapter-utils (depended on by others)
RUN pnpm --filter @paperclipai/shared build
RUN pnpm --filter @paperclipai/adapter-utils build
RUN pnpm --filter @paperclipai/adapter-claude-local build
RUN pnpm --filter @paperclipai/adapter-codex-local build
RUN pnpm --filter @paperclipai/adapter-cursor-local build
RUN pnpm --filter @paperclipai/adapter-gemini-local build
RUN pnpm --filter @paperclipai/adapter-openclaw-gateway build
RUN pnpm --filter @paperclipai/adapter-opencode-local build
RUN pnpm --filter @paperclipai/adapter-pi-local build
# Then packages that depend on adapter-utils
RUN pnpm --filter @paperclipai/db build
# Diagnostic: log what TypeScript sees for workspaceRuntimeServices columns
# Using `|| true` to prevent build failures from diagnostic commands
RUN echo "=== WORKSPACE_RUNTIME SERVICES DIAGNOSTICS ==="; \
    echo "--- d.ts readonly field count ---"; \
    grep -c 'readonly ' packages/db/dist/schema/workspace_runtime_services.d.ts || true; \
    echo "--- Compiled JS line count ---"; \
    wc -l packages/db/dist/schema/workspace_runtime_services.js || true; \
    echo "--- Symlink resolution for @paperclipai/db ---"; \
    ls -la server/node_modules/@paperclipai/db 2>/dev/null || echo "No symlink found"; \
    echo "--- dist/ existence check ---"; \
    if [ -d packages/db/dist ]; then echo "dist/ EXISTS"; else echo "dist/ MISSING"; fi; \
    echo "--- index.d.ts exports ---"; \
    grep 'workspaceRuntimeServices' packages/db/dist/index.d.ts 2>/dev/null || echo "Not found in index.d.ts"; \
    echo "--- All columns in db/$inferInsert type ---"; \
    grep -A 50 'declare const workspaceRuntimeServices' packages/db/dist/schema/workspace_runtime_services.d.ts | head -40 || true
# Pre-build diagnostic: show exactly what TypeScript sees for workspaceRuntimeServices
RUN echo "=== COLUMN PRESENCE CHECK ==="; \
    for col in companyId projectId projectWorkspaceId executionWorkspaceId issueId scopeType scopeId serviceName status lifecycle reuseKey command cwd port url provider providerRef ownerAgentId startedByRunId lastUsedAt startedAt stoppedAt stopPolicy healthStatus updatedAt createdAt; do \
      if grep -q "readonly ${col}:" packages/db/dist/schema/workspace_runtime_services.d.ts 2>/dev/null; then \
        echo "OK: $col found"; \
      else \
        echo "MISSING: $col NOT found in d.ts"; \
      fi; \
    done; \
    echo "=== END DIAGNOSTICS ==="
RUN pnpm --filter @paperclipai/plugin-sdk build
RUN pnpm --filter @paperclipai/ui build
RUN pnpm --filter @paperclipai/plugin-sdk build
# Verbose server build: capture full TypeScript error output
RUN pnpm --filter @paperclipai/server build 2>&1 | tee /tmp/server-build.log || (echo "=== SERVER BUILD FAILED ===" && cat /tmp/server-build.log && exit 1)
RUN test -f server/dist/index.js || (echo "ERROR: server build output missing" && exit 1)

FROM base AS production
ARG USER_UID=1000
ARG USER_GID=1000
WORKDIR /app
COPY --chown=node:node --from=build /app /app

# Install system dependencies for Hermes agent
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 python3-pip python3-venv make && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --break-system-packages uv && \
    mkdir -p /paperclip && \
    chown node:node /paperclip

# Copy company skills from docs into the instance skills directory
# Try both doc/ and docs-paperclip/ locations (repo may have renamed the docs dir)
RUN mkdir -p /paperclip/instances/default/skills && \
    COMPANIES_DIR=""; \
    if [ -d "doc/companies" ]; then COMPANIES_DIR="doc/companies"; \
    elif [ -d "docs-paperclip/companies" ]; then COMPANIES_DIR="docs-paperclip/companies"; \
    fi && \
    if [ -n "$COMPANIES_DIR" ]; then \
      for company_dir in ${COMPANIES_DIR}/*/; do \
        company_name=$(basename "$company_dir"); \
        if [ -d "${company_dir}skills" ]; then \
          target_dir="/paperclip/instances/default/skills/${company_name}"; \
          mkdir -p "$target_dir"; \
          cp -r "${company_dir}skills"/* "$target_dir"/ 2>/dev/null || true; \
          echo "Copied skills for ${company_name} from ${company_dir}"; \
        fi; \
      done; \
    fi && \
    chown -R node:node /paperclip/instances/default/skills

# Install hermes-agent from GitHub (avoids submodule issues)
RUN git clone --depth 1 https://github.com/tennantalistair/hermes-agent.git /tmp/hermes-agent && \
    cd /tmp/hermes-agent && \
    pip install --break-system-packages --no-cache-dir ".[dev]" && \
    which hermes && which hermes-agent && \
    rm -rf /tmp/hermes-agent

RUN npm install --global --omit=dev @anthropic-ai/claude-code@latest @openai/codex@latest opencode-ai
# Copy UI dist into server/ui-dist for static serving
RUN cd /app/server && pnpm run prepare:ui-dist

COPY scripts/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENV NODE_ENV=production \
  HOME=/paperclip \
  HOST=0.0.0.0 \
  SERVE_UI=true \
  PAPERCLIP_HOME=/paperclip \
  PAPERCLIP_INSTANCE_ID=default \
  USER_UID=${USER_UID} \
  USER_GID=${USER_GID} \
  PAPERCLIP_CONFIG=/paperclip/instances/default/config.json \
  PAPERCLIP_DEPLOYMENT_MODE=authenticated \
  PAPERCLIP_DEPLOYMENT_EXPOSURE=private \
  BETTER_AUTH_BASE_URL=https://paperclip-render.onrender.com \
  BETTER_AUTH_SECRET=8+88M/iQjAZWtCQy4lI+wY1NZAI/yAWimVwiHeBHVGU= \
  PAPERCLIP_AGENT_JWT_SECRET=8+88M/iQjAZWtCQy4lI+wY1NZAI/yAWimVwiHeBHVGU= \
  OPENCODE_ALLOW_ALL_MODELS=true

VOLUME ["/paperclip"]
EXPOSE 3100

CMD ["node", "./server/dist/index.js"]
