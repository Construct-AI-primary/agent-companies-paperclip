# Mobile Safety Workflows List (02400)

**Date:** 2026-04-14
**Platform:** Mobile (MobileForge AI)
**Parent Discipline:** 02400 Safety
**Source Document:** `../desktop/02400-safety-workflows-list.md`

---

## Overview

This document identifies which desktop safety workflows can be enhanced by mobile capabilities, assesses current mobile app implementation status, and defines mobile-specific workflow requirements for MobileForge AI.

**Total Desktop Workflows:** 8
**Mobile-Enhanceable Workflows:** 8
**Mobile-Only Workflows:** 2
**Not Suitable for Mobile:** 0

---

## Section 1: Mobile Enhancement Assessment

### Workflow-by-Workflow Mobile Analysis

| # | Desktop Workflow | Mobile Enhancement Potential | Mobile Features | Existing Mobile Code | Gap |
|---|-----------------|---------------------------|-----------------|---------------------|-----|
| 1 | **Hazard Identification & Risk Assessment** (SAFETY-HAZARD) | ✅ HIGH | Photo hazard capture, GPS location tagging, voice notes, offline hazard reporting | ✅ HazardReportScreen.tsx exists | ⚠️ Needs camera integration, GPS tagging, offline support |
| 2 | **Incident Investigation & Reporting** (SAFETY-INCIDENT) | ✅ HIGH | Voice incident reporting, photo evidence, GPS location, offline incident creation | ✅ IncidentReportScreen.tsx, IncidentDetailScreen.tsx, SafetyDashboardScreen.tsx (397 lines) | ⚠️ Voice incident reporter exists but needs testing, no camera integration |
| 3 | **PPE Management** (SAFETY-PPE) | ✅ HIGH | PPE inspection via camera, QR code scanning for PPE tracking, expiry alerts | ❌ Not implemented | ❌ Full implementation needed |
| 4 | **Safety Training & Competency** (SAFETY-TRAINING) | ✅ HIGH | Mobile training modules, QR code certification verification, push notifications for expiry | ❌ Not implemented | ❌ Full implementation needed |
| 5 | **Emergency Preparedness & Response** (SAFETY-EMERGENCY) | ✅ HIGH | Emergency alert button, GPS evacuation routes, offline emergency procedures, voice emergency reporting | ❌ Not implemented | ❌ Full implementation needed |
| 6 | **Safety Inspection & Audit** (SAFETY-INSPECTION) | ✅ HIGH | Digital inspection checklists, photo evidence, GPS-verified inspections, offline audit forms | ❌ Not implemented | ❌ Full implementation needed |
| 7 | **Contractor Safety Management** (SAFETY-CONTRACTOR) | ✅ HIGH | On-site contractor verification, photo ID capture, GPS check-in/out, safety briefing acknowledgment | ❌ Not implemented | ❌ Full implementation needed |
| 8 | **Occupational Health Monitoring** (SAFETY-HEALTH) | ⚠️ MEDIUM | Health survey forms, push notifications for medical appointments, symptom tracking | ❌ Not implemented | ❌ Health UI needed |

---

## Section 2: Mobile-Only Workflows

### MOBILE-SAFETY-VOICE: Voice-First Safety Reporting
**Description:** Hands-free safety reporting using voice commands for incident reporting, hazard identification, and emergency alerts
**Mobile Features:**
- Voice incident report: "Report a slip hazard at Building A, Floor 2"
- Voice hazard alert: "Hazard: exposed wiring near workstation 5"
- Voice emergency: "Emergency: chemical spill in warehouse"
- Voice safety checklist completion
**Existing Mobile Code:** ✅ Voice service exists (`services/voiceService.ts`), voice buttons in SafetyDashboardScreen, VoiceIncidentReporter.tsx component
**Gap:** Voice incident reporter needs full integration and testing

### MOBILE-SAFETY-CAMERA: Camera-First Safety Documentation
**Description:** Camera-first safety workflow for photo evidence, hazard documentation, and visual inspection records
**Mobile Features:**
- Photo hazard documentation with auto-annotation
- PPE compliance photo verification
- Inspection photo evidence with timestamp/GPS
- QR code scanning for equipment/safety tags
**Existing Mobile Code:** ✅ expo-camera, expo-image-picker installed
**Gap:** No safety-specific camera UI implemented

---

## Section 3: Mobile Safety Project Structure

### Recommended Mobile Projects

| Project ID | Name | Priority | Status | Parent Desktop Workflow |
|------------|------|----------|--------|------------------------|
| MOBILE-SAFETY-INCIDENT | Incident Reporting | HIGH | ⚠️ Partial | SAFETY-INCIDENT |
| MOBILE-SAFETY-HAZARD | Hazard Management | HIGH | ⚠️ Partial | SAFETY-HAZARD |
| MOBILE-SAFETY-INSPECTION | Safety Inspections | HIGH | ❌ Missing | SAFETY-INSPECTION |
| MOBILE-SAFETY-EMERGENCY | Emergency Response | HIGH | ❌ Missing | SAFETY-EMERGENCY |
| MOBILE-SAFETY-PPE | PPE Management | MEDIUM | ❌ Missing | SAFETY-PPE |
| MOBILE-SAFETY-TRAINING | Safety Training | MEDIUM | ❌ Missing | SAFETY-TRAINING |
| MOBILE-SAFETY-CONTRACTOR | Contractor Safety | MEDIUM | ❌ Missing | SAFETY-CONTRACTOR |
| MOBILE-SAFETY-HEALTH | Health Monitoring | LOW | ❌ Missing | SAFETY-HEALTH |
| MOBILE-SAFETY-VOICE | Voice Safety Reporting | HIGH | ⚠️ Partial | Mobile-Only |
| MOBILE-SAFETY-CAMERA | Camera Safety Documentation | HIGH | ❌ Missing | Mobile-Only |

---

## Section 4: Current Mobile Code Assessment

### Existing Safety-Related Mobile Code

| File | Purpose | Status | Issues |
|------|---------|--------|--------|
| `screens/safety/SafetyDashboardScreen.tsx` | Safety dashboard with incident/hazard stats | ✅ Complete | Voice integration exists, needs camera |
| `screens/safety/IncidentReportScreen.tsx` | Incident reporting form | ✅ Complete | Needs camera, GPS, offline |
| `screens/safety/IncidentDetailScreen.tsx` | Incident detail view | ✅ Complete | — |
| `screens/safety/HazardReportScreen.tsx` | Hazard reporting form | ✅ Complete | Needs camera, GPS |
| `screens/safety/IncidentManagementScreen.tsx` | Incident management | ⚠️ Partial | Not fully integrated |
| `screens/safety/AISettingsScreen.tsx` | AI settings | ✅ Complete | — |
| `components/SafetyChatbot.tsx` | AI safety chatbot | ⚠️ Partial | Needs integration |
| `components/VoiceIncidentReporter.tsx` | Voice incident reporting | ⚠️ Partial | Needs testing |
| `store/slices/safetySlice.ts` | Redux state for safety | ✅ Complete | — |
| `e2e/safetyWorkflow.test.js` | E2E tests | ✅ Configured | — |

### Missing Mobile Components

| Component | Required For | Priority |
|-----------|-------------|----------|
| InspectionChecklistScreen | Digital safety inspections | HIGH |
| EmergencyResponseScreen | Emergency alerts and procedures | HIGH |
| PPEInventoryScreen | PPE tracking and inspection | MEDIUM |
| TrainingModuleScreen | Safety training delivery | MEDIUM |
| ContractorCheckInScreen | Contractor safety verification | MEDIUM |
| HealthSurveyScreen | Occupational health monitoring | LOW |
| SafetyCameraScreen | Photo evidence capture | HIGH |

---

## Section 5: Mobile-Specific Requirements

### MOBILE-SAFETY-INCIDENT (Priority: HIGH)
- [ ] Add camera integration for photo evidence
- [ ] Add GPS location tagging for incident location
- [ ] Add offline incident creation with sync queue
- [ ] Integrate voice incident reporter fully
- [ ] Add push notifications for incident status updates

### MOBILE-SAFETY-HAZARD (Priority: HIGH)
- [ ] Add camera integration for hazard photos
- [ ] Add GPS location tagging
- [ ] Add hazard severity photo annotation
- [ ] Add offline hazard reporting
- [ ] Add hazard resolution workflow

### MOBILE-SAFETY-INSPECTION (Priority: HIGH)
- [ ] Create InspectionChecklistScreen
- [ ] Implement digital checklist with photo evidence
- [ ] Add GPS-verified inspection locations
- [ ] Add offline inspection forms
- [ ] Add inspection result notifications

### MOBILE-SAFETY-EMERGENCY (Priority: HIGH)
- [ ] Create EmergencyResponseScreen with SOS button
- [ ] Add GPS evacuation route display
- [ ] Add offline emergency procedures access
- [ ] Add emergency contact quick-dial
- [ ] Add emergency alert broadcasting

---

## Section 6: Implementation Priority

### Phase 1: Complete Existing (Weeks 1-2)
1. **MOBILE-SAFETY-INCIDENT** — Add camera, GPS, offline to existing screens
2. **MOBILE-SAFETY-HAZARD** — Add camera, GPS to existing screens
3. **MOBILE-SAFETY-VOICE** — Complete voice incident reporter integration

### Phase 2: Core Workflows (Weeks 3-6)
4. **MOBILE-SAFETY-INSPECTION** — Digital inspection checklists
5. **MOBILE-SAFETY-EMERGENCY** — Emergency response system
6. **MOBILE-SAFETY-CAMERA** — Camera-first safety documentation

### Phase 3: Extended Workflows (Weeks 7-10)
7. **MOBILE-SAFETY-PPE** — PPE management
8. **MOBILE-SAFETY-TRAINING** — Safety training modules
9. **MOBILE-SAFETY-CONTRACTOR** — Contractor safety

### Phase 4: Advanced (Weeks 11-12)
10. **MOBILE-SAFETY-HEALTH** — Health monitoring

---

## Section 7: Dependencies

### Desktop Dependencies
- Safety incident API endpoints
- Hazard management backend
- Inspection scheduling system

### Mobile Dependencies
- Camera permissions and expo-camera integration
- GPS location services (expo-location)
- Voice service AI backend integration
- Push notification setup

### Cross-Company Dependencies
- **InfraForge AI**: Safety API endpoints, offline sync
- **DevForge AI**: Mobile safety UI components
- **QualityForge AI**: Safety workflow testing

---

*This mobile safety workflows list serves as the roadmap for MobileForge AI safety implementation.*