# Triggers

**Status**: ✅ Active — Dispatch system operational via Discord bot.

## Purpose

This directory defines automation triggers for the Construct AI agent ecosystem. Triggers determine how and when agents are dispatched to work on issues, based on Discord commands, issue status changes, or scheduled events.

## Trigger Architecture

```
User types "@agent work on {issue-id}" in #ai-work
  → Discord bot (agent-vps#0729) receives the command
  → Bot looks up issue in ISSUE_DISPATCH_MAP (scripts/bot.js)
  → Bot creates #work-{issue-id} channel
  → Bot dispatches to the correct agent per issue assignee:
       - Creates agent config in ~/.openclaw/agents/{company}-{issue}/
       - Writes TASK.md with task payload in workspace
       - Registers agent in openclaw.json
  → Bot updates channel topic with dispatch info
  → Bot posts to #project-log and issue channel
  → Agent executes task and reports results
```

## Active Triggers

All trigger documents are now located in their respective discipline/project directories:

### Wave 1 Triggers (Ready for Execution)
| Project | Discipline | Trigger Location | Issues | Server |
|---------|-----------|-----------------|--------|--------|
| PROCURE-TEST | 01900 Procurement | `agent-companies-paperclip/docs-paperclip/disciplines/01900-procurement/trigger/PROCURE-TEST-trigger.md` | 16 | PROCURE-TEST |
| PROD-TEST | Cross-Discipline | `agent-companies-paperclip/docs-paperclip/disciplines-shared/testing/projects/PROD-TEST/trigger/PROD-TEST-trigger.md` | 15 | ALL-DISCIPLINES |
| MOBILE-TEST | Mobile | `agent-companies-paperclip/docs-paperclip/disciplines-shared/testing/projects/MOBILE-TEST/trigger/MOBILE-TEST-trigger.md` | 6 | ALL-DISCIPLINES |

### Wave 2 Triggers (Ready for Execution)
| Project | Discipline | Trigger Location | Issues | Server |
|---------|-----------|-----------------|--------|--------|
| CONTRACT-LIFECYCLE | 00400 Contracts | `agent-companies-paperclip/docs-paperclip/disciplines/00400-contracts/trigger/CONTRACT-LIFECYCLE-trigger.md` | 15 | CONTRACTS-QS |
| PREAWARD | 00425 Pre-Award | `agent-companies-paperclip/docs-paperclip/disciplines/00425-contracts-pre-award/trigger/PREAWARD-trigger.md` | 15 | PROCUREMENT-BIDDING |
| POSTAWARD | 00435 Post-Award | `agent-companies-paperclip/docs-paperclip/disciplines/00435-contracts-post-award/trigger/POSTAWARD-trigger.md` | 15 | PROCUREMENT-BIDDING |

### Wave 3 Triggers (Ready for Execution)
| Project | Discipline | Trigger Location | Issues | Server |
|---------|-----------|-----------------|--------|--------|
| ELECTRICAL | 00860 Electrical | `agent-companies-paperclip/docs-paperclip/disciplines/00860-electrical-engineering/trigger/ELECTRICAL-trigger.md` | 15 | ELEC-TEST |
| LOGISTICS | 01700 Logistics | `agent-companies-paperclip/docs-paperclip/disciplines/01700-logistics/trigger/LOGISTICS-trigger.md` | 15 | LOGISTICS |
| DOCUMENT-CONTROL | 00900 Document Control | `agent-companies-paperclip/docs-paperclip/disciplines/00900-document-control/trigger/DOCUMENT-CONTROL-trigger.md` | 15 | ENGINEERING |
| GOVERNANCE | 01300 Governance | `agent-companies-paperclip/docs-paperclip/disciplines/01300-governance/trigger/GOVERNANCE-trigger.md` | 15 | ENGINEERING |
| SAFETY | 02400 Safety | `agent-companies-paperclip/docs-paperclip/disciplines/02400-safety/trigger/SAFETY-trigger.md` | 15 | SAFETY |
| ESIGN-INTEGRATION | e-signing | `agent-companies-paperclip/docs-paperclip/disciplines-shared/e-signing/projects/ESIGN-INTEGRATION/trigger/ESIGN-INTEGRATION-trigger.md` | 11 | ALL-DISCIPLINES |

### Discord Command Triggers
| Trigger | Source | Command | Status |
|---------|--------|---------|--------|
| Discord Work Command | `#ai-work` control channel | `@agent work on {issue-id(s)}` | ✅ Active |
| Discord Plan Command | `#ai-work` control channel | `@agent plan {issue-id}` | ✅ Active |
| Work Completion | `#work-{issue-id}` work channel | `@agent done` or `@agent complete` | ✅ Active |
| Issue Channel Cross-Reference | Any issue channel | User mentions `@agent` | ✅ Active |

## Issue Dispatch Map

The `ISSUE_DISPATCH_MAP` in `scripts/bot.js` covers **all disciplines** with issue channels:

| Discipline | Server | Issues | Assigned Agents |
|------------|--------|--------|-----------------|
| 01900 Procurement | PROCURE-TEST | PROCURE-001 to -016 | DevForge, InfraForge, DomainForge, QualityForge |
| 00860 Electrical | ELEC-TEST | ELEC-TEST-001 to -016 | DevForge, InfraForge, DomainForge, QualityForge |
| 02025 QS | QS-TEST | QS-TEST-001 to -016 | DevForge, InfraForge, DomainForge, QualityForge |
| 01700 Logistics | LOGIS-TEST | LOGIS-TEST-001 to -016 | DevForge, InfraForge, DomainForge, QualityForge |
| 02400 Safety | SAFETY | SAFETY-* (10 issues) | DevForge, KnowledgeForge, VoiceForge |
| 00400/425/435 Procurement | PROCUREMENT-BIDDING | PROC-*, BTND-* (17 issues) | DevForge, PaperclipForge, KnowledgeForge, QualityForge, VoiceForge |
| 00800-872 Engineering | ENGINEERING | ENG-* (3 issues) | PaperclipForge, DevForge, VoiceForge |
| Shared disciplines | ALL-DISCIPLINES | 24 issues | DomainForge, VoiceForge, IntegrateForge, DevForge, SaaSForge, MobileForge, QualityForge |
| Voice comm | VOICE-COMM | VOICE-COMM-* (6 issues) | DevForge, MobileForge |
| Contracts/QS | CONTRACTS-QS | CON-*, CPOST-*, CPRE-*, QS-* (5 issues) | DomainForge, PaperclipForge, MeasureForge |
| Measurement | MEASUREMENT | MEASURE-* (6 issues) | MeasureForge, KnowledgeForge |
| Electrical projects | ELEC-PROJECTS | ELEC-* (2 issues) | DevForge, DomainForge |
| Logistics | LOGISTICS | LOG-*, LOGISTICS-* (2 issues) | VoiceForge, DevForge |

## How to Add a New Trigger

1. Add the issue ID and dispatch info to `ISSUE_DISPATCH_MAP` in `scripts/bot.js`
2. Add the issue channel to `ISSUE_CHANNELS` with the correct Discord channel ID
3. Deploy: `cat scripts/bot.js | ssh ... "cat > /opt/openclaw-discord-bot/bot.js"`
4. Restart: `ssh ... "systemctl restart openclaw-discord-bot"`

## Future Enhancements

- [ ] **Scheduled triggers**: Time-based dispatch (e.g., "run PROCURE-001 every Monday")
- [ ] **Status-based triggers**: Auto-dispatch when issue status changes to "ready"
- [ ] **Dependency chain triggers**: Auto-dispatch dependent issues when parent completes
- [ ] **Heartbeat monitoring**: 15-min polling loop for stalled agents
- [ ] **OpenClaw native triggers**: When CLI `agents add` and `agents bind` bugs are fixed

## Reference

- `scripts/bot.js` — Main bot with ISSUE_DISPATCH_MAP and dispatchToAgent()
- `orchestration/EXECUTION-TRACKER.md` — Execution status tracking
- `orchestration/DISCORD-CHANNEL-TAXONOMY.md` — Channel type definitions
- `agent-companies-paperclip/docs-paperclip/procedures/projects/batched-execution-plan.md` — Batch execution plan