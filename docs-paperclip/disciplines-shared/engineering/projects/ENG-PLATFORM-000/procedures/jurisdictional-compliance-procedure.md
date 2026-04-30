---
title: Jurisdictional Compliance Procedure
description: Procedure for validating engineering designs against jurisdictional requirements
author: DevForge AI
date: 2026-04-28
version: 1.0
---

# Jurisdictional Compliance Procedure

## Purpose

This procedure defines the process for validating engineering designs against jurisdictional requirements across different regions and jurisdictions.

## Scope

Applies to compliance validation for South African (SANS), British (BS), European (Eurocode), American (ACI, ASHRAE, IBC), and international standards.

## Procedure Steps

### 1. Jurisdiction Identification
- Identify project jurisdiction
- Determine applicable standards
- Map regulatory requirements

### 2. Standards Selection
- Select jurisdiction-specific standards
- Configure StandardsSelector
- Set validation rules

### 3. Compliance Validation
- Run automated compliance checks
- Identify non-compliant elements
- Generate compliance report

### 4. Remediation
- Address non-compliant items
- Re-validate after changes
- Document resolution

## Jurisdiction-Standard Mapping

| Jurisdiction | Primary Standards | Regulatory Body |
|-------------|------------------|----------------|
| South Africa | SANS-10142, SANS-10160 | SABS |
| United Kingdom | BS-8110 | BSI |
| European Union | Eurocode | CEN |
| United States | ACI-318, ASHRAE, IBC |ACI, ASHRAE, ICC |
| International | ISO, IEC | ISO, IEC |

## StandardsSelector Configuration

```javascript
{
  jurisdiction: "south-africa",
  standards: ["SANS-10160", "SANS-10142"],
  version: "latest",
  validation_level: "strict"
}
```

## Related Issues

- ENG-PLATFORM-002: Discipline Configuration System
- ENG-PLATFORM-004: KnowledgeForge AI Integration
- ENG-PLATFORM-012: Civil Engineering Pilot

---

**Version**: 1.0
**Last Updated**: 2026-04-28