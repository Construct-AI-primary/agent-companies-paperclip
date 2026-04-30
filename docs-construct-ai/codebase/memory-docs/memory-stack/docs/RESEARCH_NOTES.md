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
# Research Notes Behind This Kit

## Local conventions observed

- File memory architecture is already documented in `WORKSPACE_MEMORY_SYSTEM.md`.
- Durable truth is PARA in `~/life/`.
- `MEMORY.md` is intentionally tiny and used as routing/index layer.
- OpenStinger is documented as semantic + temporal recall, not durable file truth.
- `lossless-claw` is documented as session-local compaction/recovery.
- Gigabrain is documented and configured as the memory slot plugin.
- Existing OpenClaw config backup shows:
  - `plugins.slots.contextEngine = lossless-claw`
  - Gigabrain registry path under `workspace/memory/registry.sqlite`
  - vault subdir `Gigabrain`

## Install posture chosen for v1

- Non-destructive.
- Scaffold files and patch blocks only.
- Do not auto-install dependencies.
- Do not auto-edit hidden OpenClaw config in v1.
- Leave a clear prompt + scripts so OpenClaw can perform the install safely.

## Why this shape

Because the clean move is not “one memory system.” It’s a stack with role boundaries:
- bootstrap routing
- session recovery
- durable knowledge
- daily residue
- automatic recall
- optional graph recall
