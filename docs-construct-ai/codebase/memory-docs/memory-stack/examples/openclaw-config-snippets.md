---
memory_layer: durable_knowledge
para_section: pages/codebase/docs
gigabrain_tags: docs, codebase, documentation
documentation
openstinger_context: technical-documentation, knowledge-base
last_updated: 2026-03-21
related_docs:
  - codebase/docs/
  - disciplines/
---
# OpenClaw Config Snippets

These are **review-first examples** based on the source machine’s current setup.

Do not copy them blind into another install. Translate paths, plugin names, and connection details to the target machine first.

## What these snippets are trying to achieve

- **Gigabrain** handles automatic recall/capture
- **lossless-claw / LCM** handles current-session compaction and recovery
- **PARA** remains the durable truth layer in `~/life/`
- **OpenStinger** is optional alongside recall, not a replacement for PARA

## Example: lossless-claw as context engine

```json
{
  "plugins": {
    "slots": {
      "contextEngine": "lossless-claw"
    },
    "enabled": {
      "lossless-claw": true
    }
  }
}
```

Use this only if the target install actually has the `lossless-claw` plugin available under that name.

## Example: Gigabrain enabled

```json
{
  "plugins": {
    "enabled": {
      "gigabrain": true
    }
  }
}
```

Depending on the target install, Gigabrain may also require machine-specific settings such as:
- registry/database path
- vault directory
- workspace root
- plugin-specific capture/recall options

## Observed source-machine conventions

These values were observed on the source machine and are included so the receiver can inspect intent:

- registry path: `/home/lucas/.openclaw/workspace/memory/registry.sqlite`
- vault subdir: `Gigabrain`
- workspace root: `/home/lucas/.openclaw/workspace`

Treat those as examples, not defaults.

## Optional: OpenStinger alongside mode

Start OpenStinger in additive mode. Don’t make it the only memory path on day one.

### Example SSE connection

```json
{
  "connections": {
    "openstinger": {
      "type": "sse",
      "url": "http://localhost:8766/sse"
    }
  }
}
```

Before using this:
- confirm the service is actually running
- confirm the port/path match the local deployment
- confirm auth requirements if any

### Example prompt / rules guidance

```md
When searching memory or recalling past conversations, decisions, or facts:
1. Query OpenStinger first if available.
2. If it returns useful results, use those.
3. If it returns empty, fall back to the native memory path.
4. PARA remains the durable source of truth.
```

## Suggested dependency handling

The receiving OpenClaw should do this in order:

1. Inspect currently installed plugins and config.
2. Reuse what already exists if it matches intent.
3. If a dependency is missing, fetch/install it using the target machine’s actual package manager and current docs.
4. Only then wire config to it.

## After config changes

If plugin assignment or config changed, do a full gateway restart:

```bash
openclaw gateway restart
```

Observed local behavior: plugin assignment changes may not take effect until restart.
