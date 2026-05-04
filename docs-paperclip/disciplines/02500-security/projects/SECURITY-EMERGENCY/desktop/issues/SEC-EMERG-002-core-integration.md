# SEC-EMERG-002 — Emergency Response Core — Mass Notification, Muster Point Management & Roll Call

- **id:** SEC-EMERG-002
- **title:** Emergency Response Core — Mass Notification, Muster Point Management & Roll Call
- **labels:** ["security", "emergency", "2 — Core Integration"]
- **phase:** "2 — Core Integration"
- **status:** todo
- **priority:** High
- **story_points:** 13
- **due_date:** "2026-07-31"
- **assignee:** devforge-ai
- **company:** devforge-ai
- **blocked_by:** [SEC-EMERG-001]
- **estimated:** 6 weeks

## Description

Build the core emergency response functionality including mass notification system, muster point management, roll call tracking, and the real-time web dashboard. This phase transforms the foundation data model into operational emergency response capabilities.

## Technical Requirements

### Mass Notification System

- Multi-channel notification dispatch: push notifications, SMS, email, in-app alerts, PA system integration
- Notification priority levels with escalation rules (critical alerts bypass quiet hours)
- Delivery confirmation tracking with automatic retry logic (3 retries with exponential backoff)
- Notification template engine supporting dynamic variables (person name, location, alert type)
- Notification history with full audit log (who sent, when, to whom, delivery status)
- Rate limiting and throttling to prevent notification floods

### Muster Point Management

- Muster point assignment algorithm: nearest available, capacity-balanced distribution
- Real-time muster point status dashboard: current headcount, capacity utilization, wait times
- Check-in methods: manual entry, NFC tag scanning, QR code scanning, geofence auto-check-in
- Muster point override and reassignment during active emergencies
- Muster point capacity alerts when approaching limits

### Roll Call Tracking

- Roll call initiation workflow (automatic on alert, manual by commander)
- Person-level check-in tracking with timestamp and location
- Missing persons alerting with escalation to search teams
- Roll call reconciliation with HR/personnel database for accurate headcount
- Roll call reporting: completion rate, missing persons list, average response time
- Historical roll call data for drill analysis and compliance

### Real-Time Updates

- WebSocket-based real-time status updates for all emergency events
- Server-sent events for dashboard live feed
- Presence detection for connected devices and personnel
- Automatic reconnection with last-known-state recovery

## Acceptance Criteria

- [ ] Mass notification delivers alerts via all configured channels within 30 seconds
- [ ] Notification retry logic successfully delivers after transient failures
- [ ] Muster point assignment correctly distributes evacuees based on capacity
- [ ] Check-in via NFC, QR code, and geofence all function correctly
- [ ] Roll call tracking accurately reports present, absent, and unaccounted persons
- [ ] Missing persons alert triggers within 5 minutes of roll call deadline
- [ ] Real-time dashboard updates within 2 seconds of event occurrence
- [ ] Load test passes for 10,000+ concurrent notification recipients
- [ ] All integration tests pass for notification dispatch and check-in flows
- [ ] E2E tests pass for web dashboard scenarios

## Dependencies

- SEC-EMERG-001: Foundation data model and alert system
- Notification infrastructure provider (push, SMS, email gateways)
- Mapping services for muster point visualization

## Notes

This is the largest issue in the project (13 story points, 6 weeks). Consider splitting into parallel workstreams: (a) mass notification, (b) muster point + roll call, (c) web dashboard. Coordinate with infrastructure team for notification gateway access.
