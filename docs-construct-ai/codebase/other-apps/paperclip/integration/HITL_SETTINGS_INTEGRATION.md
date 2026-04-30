---
memory_layer: durable_knowledge
para_section: pages/documentation/paperclip-integration
gigabrain_tags: paperclip, hitl-settings-integration, domain-expert-configuration, settings-page
openstinger_context: hitl-settings-integration
last_updated: 2026-04-04
related_docs:
  - /construct-ai-docs/codebase/other-apps/paperclip/integration/HITL_SCHEMA.sql
  - /construct-ai-docs/codebase/other-apps/paperclip/integration/HITL_APPROVAL_WORKFLOWS.md
  - /construct-ai-docs/disciplines-non/00165-ui-settings/00165-UI-SETTINGS.MD
---

# HITL Settings Integration

## Overview

This document defines how the HITL approval system discovers domain experts and leads through the Settings page (00165). The Settings page is the single source of truth for domain expert assignments.

---

## Settings Page Structure

### Settings Section: Domain Experts
Located at: Settings > Domain Experts > HITL Configuration

**Settings Schema:**
```json
{
  "hitl_settings": {
    "domain_experts": {
      "civil-engineering": {
        "primary_expert": "structural-engineer-lead",
        "backup_expert": "civil-engineer-senior",
        "escalation_path": ["engineering-director", "ceo"],
        "discipline_codes": ["00850", "00872", "00855"]
      },
      "commercial": {
        "primary_expert": "commercial-manager-senior",
        "backup_expert": "quantity-surveyor-lead",
        "escalation_path": ["commercial-director", "ceo"],
        "discipline_codes": ["00250", "02025"]
      },
      "contracts": {
        "primary_expert": "contracts-manager-lead",
        "backup_expert": "legal-advisor",
        "escalation_path": ["contracts-director", "ceo"],
        "discipline_codes": ["00400", "00425", "00435"]
      },
      "electrical-engineering": {
        "primary_expert": "electrical-engineer-lead",
        "backup_expert": "protection-engineer",
        "escalation_path": ["engineering-director", "ceo"],
        "discipline_codes": ["00860"]
      },
      "mechanical-engineering": {
        "primary_expert": "mechanical-engineer-lead",
        "backup_expert": "hvac-specialist",
        "escalation_path": ["engineering-director", "ceo"],
        "discipline_codes": ["00870"]
      },
      "process-engineering": {
        "primary_expert": "process-engineer-lead",
        "backup_expert": "chemical-engineer",
        "escalation_path": ["engineering-director", "ceo"],
        "discipline_codes": ["00871", "00835"]
      },
      "information-technology": {
        "primary_expert": "it-architect-lead",
        "backup_expert": "ml-engineer",
        "escalation_path": ["it-director", "ceo"],
        "discipline_codes": ["02050"]
      },
      "safety": {
        "primary_expert": "safety-manager-lead",
        "backup_expert": "hse-director",
        "escalation_path": ["hse-director", "ceo"],
        "discipline_codes": ["02400", "00885"]
      }
    },
    "approval_thresholds": {
      "critical": { "timeout_hours": 4, "auto_escalate": true },
      "high": { "timeout_hours": 12, "auto_escalate": true },
      "medium": { "timeout_hours": 48, "auto_escalate": false },
      "low": { "timeout_hours": 72, "auto_escalate": false }
    }
  }
}
```

---

## How HITL Discovers Experts

### 1. Settings Page API
The HITL system queries the settings page for expert assignments:

```typescript
// GET /api/settings/hitl/domain-experts
async function getDomainExperts(): Promise<DomainExpertConfig> {
  const settings = await fetch('/api/settings/hitl');
  return settings.hitl_settings.domain_experts;
}

// GET /api/settings/hitl/approval-thresholds
async function getApprovalThresholds(): Promise<ApprovalThresholds> {
  const settings = await fetch('/api/settings/hitl');
  return settings.hitl_settings.approval_thresholds;
}
```

### 2. Expert Assignment Flow
When a HITL request is created:

```
1. HITL request created with domain + discipline_code
2. System queries Settings page for domain expert config
3. System matches discipline_code to domain
4. System assigns primary expert (or backup if unavailable)
5. System sets escalation_path from settings
6. System sets timeout from approval_thresholds
```

### 3. Settings Page UI Component

```tsx
// Settings > Domain Experts > HITL Configuration
export function HITLExpertSettings() {
  const [experts, setExperts] = useState<DomainExpertConfig>({});
  
  return (
    <div className="hitl-expert-settings">
      <h2>HITL Domain Expert Configuration</h2>
      {Object.entries(experts).map(([domain, config]) => (
        <DomainExpertCard key={domain} domain={domain} config={config} />
      ))}
    </div>
  );
}

function DomainExpertCard({ domain, config }) {
  return (
    <div className="domain-expert-card">
      <h3>{domain}</h3>
      <select value={config.primary_expert} onChange={...}>
        <option value="">Select Primary Expert</option>
        {/* Options from hitl_experts table */}
      </select>
      <select value={config.backup_expert} onChange={...}>
        <option value="">Select Backup Expert</option>
      </select>
      <div className="discipline-codes">
        {config.discipline_codes.map(code => (
          <Badge key={code}>{code}</Badge>
        ))}
      </div>
    </div>
  );
}
```

---

## Database Sync

### Settings to HITL Queue Sync
When settings are updated, sync to `hitl_experts` table:

```typescript
// POST /api/settings/hitl/sync
async function syncSettingsToHITL() {
  const settings = await getDomainExperts();
  
  for (const [domain, config] of Object.entries(settings)) {
    // Update hitl_experts table
    await db.hitl_experts.upsert({
      where: { expert_id: config.primary_expert },
      data: {
        primary_domain: domain,
        discipline_codes: config.discipline_codes,
        escalation_to: config.escalation_path[0]
      }
    });
  }
}
```

### Expert Availability Check
```typescript
// GET /api/hitl/experts/:expertId/availability
async function checkExpertAvailability(expertId: string): Promise<boolean> {
  const expert = await db.hitl_experts.findUnique({
    where: { expert_id: expertId }
  });
  
  return expert.available && expert.current_load < expert.max_concurrent_reviews;
}
```

---

## Settings Page Integration Points

### 1. Settings Page Location
- **Path**: `/settings/hitl`
- **Navigation**: Settings > Domain Experts > HITL Configuration
- **Access**: Admin users only

### 2. Settings Data Flow
```
Settings Page → API → hitl_experts table → HITL Queue Assignment
```

### 3. Real-time Updates
- Settings changes trigger webhook to HITL system
- HITL system refreshes expert cache
- Pending requests re-evaluated for expert assignment

---

## Default Expert Assignments

These are seeded in `HITL_SCHEMA.sql` but can be overridden via Settings:

| Domain | Primary Expert | Backup Expert | Escalation Path |
|--------|---------------|---------------|-----------------|
| civil-engineering | structural-engineer-lead | civil-engineer-senior | engineering-director → ceo |
| commercial | commercial-manager-senior | quantity-surveyor-lead | commercial-director → ceo |
| contracts | contracts-manager-lead | legal-advisor | contracts-director → ceo |
| electrical-engineering | electrical-engineer-lead | protection-engineer | engineering-director → ceo |
| mechanical-engineering | mechanical-engineer-lead | hvac-specialist | engineering-director → ceo |
| process-engineering | process-engineer-lead | chemical-engineer | engineering-director → ceo |
| information-technology | it-architect-lead | ml-engineer | it-director → ceo |
| safety | safety-manager-lead | hse-director | hse-director → ceo |

---

*HITL Settings Integration - Ready for implementation*