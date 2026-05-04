# e-Signing Discipline

**Discipline Code**: ESIGN  
**Type**: Shared (cross-discipline)  
**Status**: Active  

## Overview

The e-Signing discipline provides digital signature capabilities for HITL (Human-in-the-Loop) approval workflows across all disciplines. This replaces the manual "Download Draft for Manual Circulation" pattern with a fully digital signing experience, similar to DocuSign or Adobe Sign.

## Scope

- Digital signature capture (draw, type, upload, PKI)
- Signature workflow engine (sequential, parallel, hybrid)
- Document template signature field embedding
- e-Signature provider API abstraction
- Mobile native signing with biometric authentication
- Offline fallback (download-and-upload)
- Cryptographic audit trail
- Compliance reporting (eIDAS, ESIGN Act)

## Related Disciplines

- **01300 Governance** — Approval routing, compliance enforcement, audit trail
- **00900 Document Control** — Document lifecycle, version control, record approval
- **01900 Procurement** — PO approval, supplier qualification, tender evaluation
- **01700 Logistics** — Delivery approval, weighbridge sign-off
- **02400 Safety** — Safety data sheet approval, incident sign-off

## Projects

| Project | Status | Description |
|---------|--------|-------------|
| [ESIGN-INTEGRATION](projects/ESIGN-INTEGRATION/) | Planning | HITL e-Signature integration across all disciplines |