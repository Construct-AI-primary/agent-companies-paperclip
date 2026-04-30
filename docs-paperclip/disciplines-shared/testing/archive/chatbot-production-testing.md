| TC-7-3: Data Consistency | 1. Force page refresh during send<br>2. Check message recovery<br>3. Verify integrity | No message loss, consistency maintained | |

### 8. LangChain Integration
**Priority**: High  
**Prerequisites**: LangChain backend services

#### Test Cases
| Test Case | Steps | Expected Result | Pass/Fail/N/A |
|-----------|-------|-----------------|---------------|
| TC-8-1: Agent Selection | 1. Send query requiring specific agent<br>2. Check agent routing<br>3. Verify agent selection | Correct agent chosen based on query type | |
| TC-8-2: Multi-agent Orchestration | 1. Complex query requiring coordination<br>2. Monitor agent interactions<br>3. Check final response | Multiple agents coordinate effectively | |
| TC-8-3: Response Quality | 1. Send standardized test queries<br>2. Evaluate response quality<br>3. Check consistency | Responses meet quality thresholds (>=4/5) | |

### 9. WebSocket Streaming
**Priority**: High  
**Prerequisites**: WebSocket server, streaming capabilities

#### Test Cases
| Test Case | Steps | Expected Result | Pass/Fail/N/A |
|-----------|-------|-----------------|---------------|
| TC-9-1: Connection Establishment | 1. Open chat widget<br>2. Monitor network tab<br>3. Verify WebSocket connection | WebSocket connected without errors | |
| TC-9-2: Real-time Updates | 1. Start agent workflow<br>2. Monitor stream display<br>3. Check message timing | Messages appear in real-time as generated | |
| TC-9-3: Streaming Reliability | 1. Interrupt connection<br>2. Monitor reconnection logic<br>3. Verify message continuity | System handles disconnections gracefully | |

### 10. HITL Feedback System
**Priority**: Medium  
**Prerequisites**: HITL system enabled

#### Test Cases
| Test Case | Steps | Expected Result | Pass/Fail/N/A |
|-----------|-------|-----------------|---------------|
| TC-10-1: Escalation Trigger | 1. Send complex query<br>2. Check confidence threshold<br>3. Verify HITL activation | Query escalates when confidence < configured threshold | |
| TC-10-2: Task Creation | 1. HITL triggered<br>2. Check task creation<br>3. Verify assignment logic | HITL task created with correct metadata | |
| TC-10-3: Feedback Integration | 1. Complete HITL task<br>2. Check learning integration<br>3. Verify system improvement | Feedback improves future responses | |

### 11. Supabase Connection Tests
**Priority**: Critical  
**Prerequisites**: Supabase credentials and schema

#### Test Cases
| Test Case | Steps | Expected Result | Pass/Fail/N/A |
|-----------|-------|-----------------|---------------|
| TC-11-1: Authentication | 1. Verify Supabase connection<br>2. Test auth credentials<br>3. Check API accessibility | Successful authentication established | |
| TC-11-2: Data Read Operations | 1. Execute sample query: `SELECT * FROM chat_sessions WHERE user_id = 'test-user-001'`<br>2. Verify response<br>3. Check performance | Query returns expected results in <500ms | |
| TC-11-3: Data Write Operations | 1. Insert test message: `INSERT INTO chat_messages (session_id, content) VALUES ('test-session', 'Test message')`<br>2. Verify insertion<br>3. Check constraints | Record created successfully with proper validation | |

### 12. Error Handling
**Priority**: High  
**Prerequisites**: Error simulation capabilities

#### Test Cases
| Test Case | Steps | Expected Result | Pass/Fail/N/A |
|-----------|-------|-----------------|---------------|
| TC-12-1: Network Failures | 1. Disconnect network during send<br>2. Check error handling<br>3. Verify retry logic | Graceful error display, optional retry | |
| TC-12-2: Supabase Errors | 1. Simulate Supabase outage<br>2. Test offline mode<br>3. Check data sync on recovery | Local storage fallback, sync on reconnection | |
| TC-12-3: Invalid Data Handling | 1. Send malformed content<br>2. Check validation<br>3. Verify sanitization | Invalid data rejected, user notified | |

### 13. External Control Integration
**Priority**: Medium
**Prerequisites**: External system integrations

#### Test Cases
| Test Case | Steps | Expected Result | Pass/Fail/N/A |
|-----------|-------|-----------------|---------------|
| TC-13-1: API Integration | 1. Trigger external data fetch<br>2. Check chatbot response<br>3. Verify data incorporation | External data properly integrated into responses | |
| TC-13-2: Webhook Handling | 1. Simulate webhook event<br>2. Monitor chatbot update<br>3. Check real-time display | Webhook data triggers appropriate chatbot response | |
| TC-13-3: Cross-system Coordination | 1. Action in external system<br>2. Check chatbot awareness<br>3. Verify context sharing | Chatbot maintains awareness of external state | |

### 14. Performance and Load Testing
**Priority**: Medium
**Prerequisites**: Load testing tools, performance monitoring

#### Test Cases
| Test Case | Steps | Expected Result | Pass/Fail/N/A |
|-----------|-------|-----------------|---------------|
| TC-14-1: Concurrent Users | 1. Simulate 50 concurrent chats<br>2. Monitor server performance<br>3. Check response times | Performance degradation <10% over baseline | |
| TC-14-2: Message Throughput | 1. Send 1000 messages/minute<br>2. Monitor database writes<br>3. Check persistence reliability | All messages persisted, rate >900/minute | |
| TC-14-3: Memory Usage | 1. Long-running chat session<br>2. Monitor client memory<br>3. Check for leaks | Memory usage remains stable over time | |

### 15. Cross-Platform Compatibility
**Priority**: Medium
**Prerequisites**: Multiple device/browser combinations

#### Test Cases
| Test Case | Steps | Expected Result | Pass/Fail/N/A |
|-----------|-------|-----------------|---------------|
| TC-15-1: Mobile Responsiveness | 1. Access on mobile device<br>2. Test touch interactions<br>3. Check layout adaptation | Chat widget functional on mobile screens | |
| TC-15-2: Browser Compatibility | 1. Test on supported browsers<br>2. Check feature parity<br>3. Verify UI consistency | Consistent behavior across browsers | |
| TC-15-3: Accessibility | 1. Test with screen readers<br>2. Check keyboard navigation<br>3. Verify compliance | Meets WCAG 2.1 AA standards | |

### 16. Security and Compliance
**Priority**: Critical
**Prerequisites**: Security testing tools, compliance requirements

#### Test Cases
| Test Case | Steps | Expected Result | Pass/Fail/N/A |
|-----------|-------|-----------------|---------------|
| TC-16-1: Data Encryption | 1. Monitor network traffic<br>2. Check HTTPS usage<br>3. Verify end-to-end encryption | All chat data transmitted securely | |
| TC-16-2: Authentication Bypass | 1. Attempt unauthorized access<br>2. Test session hijacking<br>3. Verify role-based access | Proper authentication required, roles enforced | |
| TC-16-3: Data Sanitization | 1. Send potentially unsafe content<br>2. Check input validation<br>3. Verify output sanitization | All inputs sanitized, safe from XSS/CSRF | |

## Testing Sequence

1. **Setup Phase** - Environment configuration and test data preparation
2. **Critical Path Testing** - Chatbot initialization, authentication, and basic messaging
3. **Integration Testing** - Supabase connections, LangChain processing, WebSocket streaming
4. **Advanced Feature Testing** - HITL workflows, multi-agent orchestration, filtering
5. **Performance Testing** - Load testing, memory usage, concurrent user handling
6. **Security Testing** - Authentication, data protection, compliance validation
7. **Cross-platform Testing** - Browser compatibility, mobile responsiveness
8. **Regression Testing** - Re-execute critical tests after updates

## API Endpoints

### Chat Management Endpoints
| Endpoint | Method | Purpose | Expected Response |
|----------|--------|---------|-------------------|
| `/api/chat/sessions` | GET | Retrieve user's chat sessions | Array of session objects |
| `/api/chat/sessions` | POST | Create new chat session | New session object with ID |
| `/api/chat/messages` | GET | Get messages for session | Paginated message array |
| `/api/chat/messages` | POST | Send new message | Message object with AI response |

### Agent Endpoints
| Endpoint | Method | Purpose | Expected Response |
|----------|--------|---------|-------------------|
| `/api/agents/${type}` | POST | Execute specific agent | Agent execution stream |
| `/api/agents/stream` | GET | WebSocket streaming endpoint | Real-time updates |
| `/api/agents/config` | GET | Agent configuration | Agent capabilities and settings |

### HITL Endpoints
| Endpoint | Method | Purpose | Expected Response |
|----------|--------|---------|-------------------|
| `/api/hitl/tasks` | GET | Retrieve HITL tasks | Task array with status |
| `/api/hitl/tasks/${id}` | PUT | Update task status | Updated task object |
| `/api/hitl/feedback` | POST | Submit human feedback | Confirmation and integration status |

## Supabase Configuration

### Connection Settings
```json
{
  "supabaseUrl": "https://your-project.supabase.co",
  "supabaseKey": "${{ secrets.SUPABASE_ANON_KEY }}",
  "chatTables": ["chat_sessions", "chat_messages", "chat_history"],
  "rlspolicies": true,
  "realtime": true
}
```

### Query Examples

**Retrieve recent chat sessions:**
```sql
SELECT id, page_id, created_at, updated_at,
       (SELECT COUNT(*) FROM chat_messages WHERE session_id = chat_sessions.id) as message_count
FROM chat_sessions
WHERE user_id = $1 AND created_at >= $2::timestamp
ORDER BY updated_at DESC
LIMIT 50;
```

**Store chat message:**
```sql
INSERT INTO chat_messages (session_id, role, content, agent_name, timestamp)
VALUES ($1, $2, $3, $4, NOW())
RETURNING id, timestamp;
```

**Update session metadata:**
```sql
UPDATE chat_sessions
SET updated_at = NOW(),
    last_message = $1,
    message_count = message_count + 1
WHERE id = $2;
```

### Performance Optimization Queries
```sql
-- Create index for session retrieval
CREATE INDEX idx_chat_sessions_user_page ON chat_sessions(user_id, page_id, updated_at DESC);

-- Create index for message pagination
CREATE INDEX idx_chat_messages_session_ts ON chat_messages(session_id, timestamp ASC);

-- Optimize history queries
CREATE INDEX idx_chat_history_user_archived ON chat_history(user_id, archived_at DESC);
```

## Test Matrix

### Priority Distribution
- Critical (7 areas): 1,2,3,4,7,11,16 - Core functionality
- High (4 areas): 5,6,8,9 - Advanced features
- Medium (5 areas): 10,12,13,14,15 - Enhancement features

### Status Key
- **Pass**: All test cases meet expected results
- **Fail**: One or more test cases failed
- **N/A**: Test not applicable in current context

### Coverage Metrics
- Functional Coverage: 100% of chatbot functionality
- Integration Coverage: All external system interactions
- Performance Coverage: Load and stress testing scenarios
- Security Coverage: Authentication and data protection

## Test Execution Summary

### Execution Checklist
- [ ] Environment setup completed
- [ ] Test data populated
- [ ] Prerequisites verified
- [ ] Test cases executed systematically
- [ ] Results documented
- [ ] Issues logged and tracked
- [ ] Follow-up testing scheduled

### Results Template
```
Test Area: [Area Name]
Total Tests: [X]
Passed: [X]
Failed: [X]
N/A: [X]
Pass Rate: [XX%]
Execution Time: [XX minutes]
Issues Found: [X major, X minor]
Next Steps: [Actions required]
```

## Links to Sources

### Documentation References
- [Chatbot Architecture Overview](/docs-construct-ai/pages-chatbots/1300_PAGES_CHATBOT_MASTER_GUIDE.md)
- [Implementation Summary](/docs-construct-ai/disciplines/02050_information-technology/chatbot/plan/01500_chatbot_implementation_summary.md)
- [Streaming Implementation](/docs-construct-ai/codebase/workflows/chatbot/CHATBOT_WORKFLOW_STREAMING_IMPLEMENTATION_UPDATE_SUMMARY.md)

### Code References
- [ChatbotBase Component](client/src/components/chatbots/base/ChatbotBase.js)
- [HITL Manager Hook](.clinerules/hooks/useHITLManager.js)
- [Add Chatbot Workflow](.clinerules/workflows/add-chatbot-to-page.js)

### Database Schema
- [Chat Tables Schema](server/config/supabase-chat-schema.sql)
- [HITL Tables Schema](server/config/hitl-schema.sql)

## Error Reporting Procedure

Errors encountered during testing should be documented using the following format and stored in:
/Users/chadferguson/Documents/construct_ai/docs-construct-ai/error-tracking/chatbot-errors-{timestamp}.md

Timestamp format: YYYYMMDD_HHMMSS (e.g., 20260402_143522)

Error Report Format:
```markdown
# Chatbot Testing Error Report
**Timestamp:** 2026-04-02 14:35:22
**Tester:** [Your Name]
**Test Case:** TC-X-X: [Test Case Name]

## Error Details
**Error Type:** [Functional | Integration | Performance | Security]
**Severity:** [Critical | Major | Minor | Cosmetic]

## Description
[Clear description of what went wrong]

## Steps to Reproduce
1. [Step 1]
2. [Step 2]
3. [Step etc]

## Expected Result
[What should have happened]

## Actual Result
[What actually happened]

## Environment Details
- Browser: [Chrome/Firefox/Safari/Edge]
- Version: [XX.X.X]
- OS: [macOS/Windows/Linux]
- User Context: [User role/discipline]

## Supporting Data
[Screenshots, console errors, network requests, etc]

## Root Cause Analysis
[Suspected cause if known]

## Impact Assessment
- User Impact: [High/Medium/Low]
- System Impact: [Critical/Major/Minor]
- Business Impact: [Affects revenue/features/usability]

## Resolution Steps
[What needs to be fixed]

## Prevention Measures
[Suggestions to prevent similar issues]

## Related Issues
- [Link to similar issues if any]
- [GitHub issue/PR links]
```

### Error Classification
- **Critical**: System breaking, no-workaround issues
- **Major**: Significant functionality impairment
- **Minor**: Limited impact, acceptable workarounds
- **Cosmetic**: UI/UX issues without functional impact

### Notification Process
1. Create error report using format above
2. Notify development team immediately for critical issues
3. Schedule follow-up testing after fixes
4. Update test matrix with new findings

---

*This document is maintained by the AI Assistant for comprehensive Hermes Agent chatbot testing. Last updated: 2026-04-02*