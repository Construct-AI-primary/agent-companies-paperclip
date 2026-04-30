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
# OpenClaw Memory Stack Giveaway

Portable install pack for putting a sane memory stack into another OpenClaw workspace without smashing their local setup.

This kit is built for a receiving OpenClaw that has internet access and can inspect files, install optional dependencies, patch local bootstrap files carefully, and verify the result.

## What this pack is for

This pack gives another OpenClaw enough structure and instructions to set up:

1. **Gigabrain** — automatic memory recall/capture layer
2. **lossless-claw / LCM** — current-session compaction and transcript recovery
3. **PARA** — durable truth in `~/life/`
4. **Daily notes** — `memory/YYYY-MM-DD.md`
5. **MEMORY.md** — tiny routing/index layer
6. **AGENTS.md** — durable operational rules, not a memory warehouse
7. **OpenStinger** — optional cross-session graph recall layer

The point is separation of roles. If everything becomes "memory," the whole thing gets stupid fast.

## Design stance

- **Non-destructive first.** Existing files get backups before modification.
- **Patch, don’t replace.** `AGENTS.md` and `MEMORY.md` should be updated with managed blocks, not overwritten wholesale.
- **Files are the durable layer.** PARA stays canonical for long-term truth.
- **LCM is not durable truth.** It helps with current-session recovery.
- **OpenStinger is optional.** Useful, not required.
- **Human review stays in the loop.** Hidden config changes should be proposed clearly before they are applied.

## Package contents

- `README.md` — operator guide for the whole pack
- `INSTALL_PROMPT.md` — high-signal prompt to hand to another OpenClaw
- `manifest.json` — machine-readable contract for the pack
- `docs/FIRST_VERSION_SPEC.md` — scope and design rules for v1
- `docs/RESEARCH_NOTES.md` — why the pack is shaped this way
- `templates/files/` — starter bootstrap files created when missing
- `templates/patches/` — managed append/replace blocks for existing files
- `examples/openclaw-config-snippets.md` — config guidance for Gigabrain, LCM, and optional OpenStinger
- `scripts/preflight.sh` — target inspection and readiness check
- `scripts/apply.sh` — safe scaffolding + managed patch application
- `scripts/package.sh` — rebuilds the distributable zip
- `dist/openclaw-memory-stack-giveaway.zip` — packaged artifact

## Install modes

### `core`
Create and patch only the file-backed memory foundation:
- `memory/`
- `MEMORY.md`
- `PARA.md`
- `WORKSPACE_MEMORY_SYSTEM.md`
- managed block in `AGENTS.md`

### `core-plus-guidance`
Same as `core`, plus explicit config guidance for:
- Gigabrain
- lossless-claw / LCM
- gateway restart expectations

### `core-plus-openstinger`
Same as `core-plus-guidance`, plus docs/snippets for optional OpenStinger alongside mode.

Important: this pack does **not** force-install plugins or mutate hidden config by itself. That should be reviewed in the target environment.

## Expected target environment

Minimum useful target:
- an existing OpenClaw install
- a writable workspace directory
- `bash`
- `python3`

Helpful for optional layers:
- internet access
- `docker` and `docker compose` if the recipient wants to run OpenStinger locally
- package managers appropriate to that machine if Gigabrain / lossless-claw / OpenStinger dependencies are not already installed

## What gets changed

### Files created if missing
- `memory/.gitkeep`
- `MEMORY.md`
- `PARA.md`
- `WORKSPACE_MEMORY_SYSTEM.md`
- `AGENTS.md` (only if missing entirely)
- `docs/memory-stack-local-notes.md`

### Files patched safely
- `AGENTS.md`
- `MEMORY.md`
- `PARA.md`

### Backup location
Every touched file is backed up under:

```bash
<target-workspace>/.memory-stack-backups/<timestamp>/
```

## Fast path

From this folder:

```bash
bash scripts/preflight.sh /path/to/target/workspace
bash scripts/apply.sh /path/to/target/workspace --mode core-plus-guidance
bash scripts/package.sh
```

## Recommended handoff flow

1. Give the recipient this whole folder or the zip artifact.
2. Ask their OpenClaw to read `README.md` and `INSTALL_PROMPT.md` first.
3. Run preflight against the target workspace.
4. Show the plan before any changes.
5. Apply `core` scaffolding and managed patches.
6. Review config guidance for Gigabrain + LCM.
7. If desired, add OpenStinger in alongside mode.
8. Verify the install with the checklist below.
9. Restart the OpenClaw gateway if plugin/config assignments changed.

## Verification checklist

A clean install should leave the target with:

### File layer
- `memory/` exists
- `memory/.gitkeep` exists
- `MEMORY.md` exists and contains the managed routing block
- `PARA.md` exists and contains the managed conventions block
- `WORKSPACE_MEMORY_SYSTEM.md` exists
- `AGENTS.md` contains the managed memory-stack rules block
- `.memory-stack-backups/<timestamp>/` exists if any pre-existing files were touched

### Content quality
- `MEMORY.md` stays tiny and routes instead of storing durable facts
- `AGENTS.md` stays focused on rules/operations
- PARA is documented as durable truth in `~/life/`
- LCM is documented as session memory, not canonical truth
- OpenStinger is framed as optional/additive, not a replacement for PARA

### Optional config layer
If the recipient chooses to wire plugins/config:
- config snippets were reviewed, not blindly jammed in
- Gigabrain settings point at paths appropriate for that machine
- LCM / `lossless-claw` is enabled as the context engine if desired
- gateway restart happened after config changes

## Dependency guidance for the receiving OpenClaw

This pack deliberately avoids pretending every machine looks like this one.

The receiving OpenClaw should:

1. Inspect local config and installed plugins first.
2. Reuse existing plugin names/paths if they already exist.
3. If Gigabrain / lossless-claw / OpenStinger are missing, fetch/install them using the target machine’s actual package manager and current docs.
4. Only patch local config after showing the exact diff or snippet.
5. Report blockers instead of guessing.

That matters because hardcoding one machine’s paths into somebody else’s install is how you create garbage.

## Notes on portability

The included config examples show **observed local conventions** from the source machine so the receiver knows what was intended. They are examples, not universal truth.

Anything machine-specific should be translated before use, especially:
- absolute paths
- plugin package names
- docker compose locations
- service URLs
- vault/registry file locations

## Rebuilding the artifact

```bash
bash scripts/package.sh
```

Expected output:

```bash
dist/openclaw-memory-stack-giveaway.zip
```

## Success condition

This pack is successful if another OpenClaw can:
- inspect it quickly
- understand the memory model
- patch the target workspace safely
- install missing dependencies only when actually needed
- configure Gigabrain + LCM cleanly
- optionally add OpenStinger
- verify success without guessing
