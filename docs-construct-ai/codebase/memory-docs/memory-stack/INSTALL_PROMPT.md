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
# Install Prompt for OpenClaw

Use this prompt with another OpenClaw while this folder is attached, mounted, or present in its workspace.

---

Install the memory stack kit from this folder into my target OpenClaw workspace.

Work like an operator, not a bulldozer.

## Goal
Set up a portable layered memory stack with:
- Gigabrain for automatic recall/capture
- lossless-claw / LCM for current-session recovery
- PARA in `~/life/` for durable truth
- `memory/YYYY-MM-DD.md` for daily residue
- `MEMORY.md` as a tiny routing layer
- `AGENTS.md` as a durable rules layer
- optional OpenStinger as an additive cross-session recall layer

## Hard requirements
- Be non-destructive.
- Inspect this pack before making changes.
- Create backups before touching existing files.
- Do **not** overwrite `AGENTS.md` or `MEMORY.md` wholesale.
- Prefer append-only managed blocks for durable patches.
- Keep bootstrap files small.
- Treat PARA as durable truth.
- Treat LCM as session memory, not canonical truth.
- Treat OpenStinger as optional.
- If machine-specific values differ, adapt them instead of copying blindly.

## Execution order
1. Read `README.md`, `manifest.json`, and `examples/openclaw-config-snippets.md`.
2. Run `bash scripts/preflight.sh <target-workspace>`.
3. Summarize what exists already, what is missing, and what dependencies look available.
4. Propose an install plan, including chosen mode:
   - `core`
   - `core-plus-guidance`
   - `core-plus-openstinger`
5. After showing the plan, run `bash scripts/apply.sh <target-workspace> --mode <chosen-mode>`.
6. Show exactly which files were created, patched, or skipped.
7. Show where backups were written.
8. Review config guidance for Gigabrain + lossless-claw.
9. If Gigabrain / lossless-claw / OpenStinger are missing, identify the right install path for this machine and ask before applying config that depends on them.
10. If OpenStinger is requested, set it up in **alongside mode first**, not as a hard replacement for PARA.
11. Provide a verification report using the checklist from `README.md`.
12. If config changes were applied, remind me to run `openclaw gateway restart`.

## Safety rules
- Never claim success without checking resulting files.
- Never invent plugin/package names if the local machine differs.
- Never assume absolute paths from this pack are correct on the target machine.
- If hidden config needs edits, show the exact proposed change before doing it.
- If a dependency cannot be installed cleanly, leave docs/snippets in place and report the blocker.

## Desired output
Return a structured summary with:
- selected mode
- preflight findings
- files created
- files patched
- files skipped
- backup directory
- dependency blockers or follow-ups
- config recommendations
- verification result

---
