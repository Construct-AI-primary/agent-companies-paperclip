---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation
documentation
openstinger_context: general-documentation
last_updated: 2026-03-30
related_docs:
  - docs/
---

# Worktree Workflow Procedure

**Version:** 1.0  
**Date:** 2026-02-18  
**Based on:** Overstory merge resolution system (adapted for human developer + Cline workflow)  
**Scripts:** `scripts/wt-*.sh`

---

## Overview

We run multiple git worktrees simultaneously — typically 3 per day, on date-named branches. This procedure defines the systematic approach for managing them: isolation rules, merge order, conflict resolution, and session handoffs.

**Current worktree pattern:**
```
/Users/proc-docs/construct_ai  → Feb-18    (main worktree — receives merges)
/Users/_General/proc-doc-1     → Feb-18-1  (worktree 2)
/Users/_General/proc-doc-2     → Feb-18-2  (worktree 3)
```

---

## Quick Reference

| Command | When to use |
|---------|-------------|
| `./scripts/wt-status.sh` | Any time — see all worktree states |
| `./scripts/wt-add.sh <path> <branch>` | Add a new worktree (handles plain folders) |
| `./scripts/wt-handoff.sh` | End of session — write handoff record |
| `./scripts/wt-merge.sh` | From main worktree — merge all branches |
| `./scripts/wt-sync.sh` | After merge — push changes back to all worktrees |

---

## Session Start Protocol

1. **Declare your focus area** — decide what this worktree will work on
2. **Check status** — run `./scripts/wt-status.sh` to see what other worktrees are doing
3. **Avoid overlap** — don't edit files that another worktree is actively changing
4. **Sync if behind** — if your worktree is behind main, run `git merge <main-branch>` first

**Worktree focus assignment (suggested):**

| Worktree | Suggested Focus |
|----------|----------------|
| Main (`Feb-18`) | Integration, merging, shared config, docs |
| Worktree 1 (`Feb-18-1`) | One discipline area (e.g. procurement, correspondence) |
| Worktree 2 (`Feb-18-2`) | Another discipline area (e.g. contractor vetting, UI) |

---

## Session End Protocol

1. **Commit all changes** — `git add . && git commit -m "description"`
2. **Write handoff** — run `./scripts/wt-handoff.sh` (auto-generates the file, opens in VS Code)
3. **Fill in the handoff** — add focus area, what was completed, conflicts to watch for
4. **Signal ready** — check all boxes in the "Merge readiness" section

---

## Merge Protocol (run from main worktree)

### Step 1 — Check status
```bash
./scripts/wt-status.sh
```
Verify all worktrees are committed and have handoffs written.

### Step 2 — Merge all worktrees
```bash
./scripts/wt-merge.sh
```
This runs the 4-tier merge protocol automatically:
- **Tier 1:** Clean merge — no action needed
- **Tier 2:** Auto-resolve known-safe files (lock files, generated JSON)
- **Tier 3:** Pauses and asks you to resolve with Cline
- **Tier 4:** If Tier 3 fails — discard and rewrite with Cline

Or merge a specific branch only:
```bash
./scripts/wt-merge.sh Feb-18-2
```

### Step 3 — Sync back to all worktrees
```bash
./scripts/wt-sync.sh
```
Pushes the merged main branch back into all other worktrees so they're up to date.

---

## Conflict Resolution — 4-Tier Protocol

### Tier 1: Clean merge
```bash
git merge Feb-18-2
# No conflicts → done
```

### Tier 2: Auto-resolve known-safe files
Files that are always safe to take the incoming (worker) version:

| File | Strategy |
|------|----------|
| `package-lock.json` | `git checkout --theirs package-lock.json` |
| `yarn.lock` | `git checkout --theirs yarn.lock` |
| New files in `sql/creations/` | Keep both (additive) |
| New files in `sql/migrations/` | Keep both (additive) |
| Generated `*.json` data files | `git checkout --theirs <file>` |

### Tier 3: Manual resolution with Cline
For logic files (Python agents, React components, SQL with logic):
1. Open the conflicting file in VS Code
2. Ask Cline: *"Resolve this merge conflict — keep the intent of both versions"*
3. Review the result carefully
4. `git add <file> && git commit -m "Merge ... [Tier 3: manual]"`
5. Log in `docs/worktree-handoffs/CONFLICT_LOG.md`

### Tier 4: Reimagine (if Tier 3 fails)
1. `git checkout HEAD -- <file>` — discard the conflict entirely
2. Ask Cline to rewrite the section from scratch, incorporating both sets of changes
3. `git add <file> && git commit -m "Merge ... [Tier 4: reimagine]"`

---

## Conflict History Log

Record every Tier 2+ conflict in `docs/worktree-handoffs/CONFLICT_LOG.md`.

After a few weeks, patterns emerge:
- Files that conflict repeatedly → assign to one worktree only
- File types always safe to auto-resolve → add to Tier 2 list in `wt-merge.sh`

---

## Handoff Records

Stored in `docs/worktree-handoffs/<branch>-<date>.md`.

Generated automatically by `./scripts/wt-handoff.sh`. Fill in:
- **Focus area** — what this worktree was responsible for
- **What was completed** — what actually got done
- **State at end** — done / in progress / not started
- **Conflicts to watch for** — files that may conflict on merge
- **Next steps** — what should happen next in this branch

---

## Adding a New Worktree

### Scenario A: Fresh path (nothing there yet)
```bash
# From any existing worktree of the repo:
./scripts/wt-add.sh /Users/_General/proc-doc-3 Feb-19
```
This creates a new branch `Feb-19` and checks it out at the new path.

### Scenario B: Plain folder already exists (e.g. you copied or extracted files there)

**Important:** A plain folder (no `.git`) is NOT a git worktree. You cannot just "convert" it — git worktrees must be created by the main repo. The folder must be removed and replaced.

```bash
# From any existing worktree of the repo:
./scripts/wt-add.sh /Users/_Feb-19/construct_ai Feb-19
```

The script will:
1. Detect that `/Users/_Feb-19/construct_ai` exists but has no `.git`
2. Show you how many files are in the folder
3. Ask for confirmation before deleting
4. Remove the plain folder
5. Create a proper git worktree at that path on branch `Feb-19`

**What about my files?** If the plain folder contains work you want to keep:
- The files are identical to what's in the repo (since you copied from it) — no data loss
- If you made changes in the plain folder that aren't committed anywhere, copy them out first before running `wt-add.sh`

### Scenario C: Checkout an existing branch into a new path
```bash
# If branch Feb-19 already exists:
./scripts/wt-add.sh /Users/_Feb-19/construct_ai Feb-19
# The script detects the branch exists and checks it out (no new branch created)
```

### Manual equivalent (without the script)
```bash
# Remove the plain folder if it exists
rm -rf /Users/_Feb-19/construct_ai

# From the main repo, create the worktree
cd /Users/proc-docs/construct_ai
git worktree add -b Feb-19 /Users/_Feb-19/construct_ai

# Verify
git worktree list
```

## Removing a Worktree

```bash
# After merging and syncing:
git worktree remove /Users/_General/proc-doc-2
git branch -d Feb-18-2
```

---

## Files

| File | Purpose |
|------|---------|
| `scripts/wt-status.sh` | Show all worktree states |
| `scripts/wt-add.sh <path> <branch>` | Add a new worktree; handles plain folders safely |
| `scripts/wt-merge.sh` | Merge all worktrees into main (4-tier protocol) |
| `scripts/wt-handoff.sh` | Generate session handoff record |
| `scripts/wt-sync.sh` | Sync all worktrees from main after merge |
| `docs/worktree-handoffs/CONFLICT_LOG.md` | Conflict history log |
| `docs/worktree-handoffs/HANDOFF_TEMPLATE.md` | Manual handoff template |
| `docs/worktree-handoffs/<branch>-<date>.md` | Individual session handoffs |

---

*Procedure by: Cline — adapted from Overstory merge resolution system*  
*Overstory source: https://github.com/anthropics/overstory (MIT license)*
