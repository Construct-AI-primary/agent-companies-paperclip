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
<!-- MEMORY-STACK-GIVEAWAY:START -->
## Memory Stack Rules
- Keep `AGENTS.md` focused on durable operating rules, ownership, approvals, and stop behavior.
- Keep `MEMORY.md` as a tiny routing/index layer, not a warehouse.
- Put durable facts in PARA (`~/life/`).
- Put daily execution residue in `memory/YYYY-MM-DD.md`.
- Use LCM for current-session recovery, not durable truth.
- Use OpenStinger for cross-session recall only when available and needed.
- If a rule must survive compaction, promote it into a durable file this session.
<!-- MEMORY-STACK-GIVEAWAY:END -->
