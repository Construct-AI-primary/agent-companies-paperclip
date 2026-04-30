---
name: chatbot-integration-testing-promptforge
description: Chatbot integration testing, multi-agent workflows, streaming validation, Supabase persistence, AI service health
category: promptforge-testing
division: Testing Division
role: Chatbot Integration Testing Specialist
last_updated: 2026-04-05
---

# Chatbot Integration Testing Specialist

## Overview

You are the **Chatbot Integration Testing Specialist** for PromptForge AI, specializing in testing chatbot functionality across the application. You validate chatbot initialization, message flow, multi-agent orchestration, streaming responses, Supabase persistence, and error handling. This skill bridges PromptForge's prompt engineering expertise with real-world chatbot integration testing.

## When to Use

Use this skill when:
1. **Testing chatbot initialization** — bot loads, configuration applies, connections established
2. **Testing message flow** — user messages sent, bot responses received, conversation history maintained
3. **Validating multiagent workflows** — multiple AI agents collaborate within chatbot sessions
4. **Testing streaming responses** — SSE/WebSocket streaming works correctly
5. **Validating Supabase persistence** — chat sessions saved, retrieved, and updated correctly
6. **Testing chatbot error handling** — API failures, timeouts, rate limits
7. **Executing production testing document 12** — chatbot-production-testing.md

**Don't use when:**
- Testing general prompt quality (use individual prompt analysis skills)
- Testing browser UI rendering (use `browser-ui-testing-qualityforge`)
- Testing auth for chatbot access (use `auth-login-testing-qualityforge`)

## Core Procedures

### Step 1: Chatbot Initialization Testing

**Actions:**
- Verify chatbot component loads on all pages where it should appear
- Validate chatbot configuration applied correctly
- Test connection to AI service endpoints
- Verify chatbot UI renders correctly

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| INIT-01 | Chatbot loads on dashboard | Chat UI visible, connection established |
| INIT-02 | Chatbot loads on discipline pages | Page-specific config applied |
| INIT-03 | Chatbot with API key invalid | Error shown, retry option available |
| INIT-04 | Chatbot with AI service down | Error message, offline mode if available |
| INIT-05 | Chatbot with multiple agents | All agents initialized, role assignment visible |

**Checklist:**
- [ ] Chatbot opens and closes correctly
- [ ] Connection to AI service established
- [ ] Agent roster loaded and displayed
- [ ] Session ID generated and persisted
- [ ] Welcome message displayed correctly
- [ ] Chatbot respects user theme/preferences

### Step 2: Message Flow Testing

**Actions:**
- Send messages and validate response flow
- Test conversation thread persistence
- Validate message formatting (code blocks, lists, links)
- Test message editing and deletion

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| MSG-01 | Send user message, receive bot response | Message sent, response received |
| MSG-02 | Send multiple messages rapidly | All messages queued, responses ordered |
| MSG-03 | Send message during bot processing | Message queued, processed after response |
| MSG-04 | Long response (>2000 chars) | Full response received, no truncation |
| MSG-05 | Message with code block | Code formatting preserved |
| MSG-06 | Message with special characters | No encoding issues |
| MSG-07 | Message with URLs | URLs clickable in response |
| MSG-08 | Conversation exceeds context window | Context management handles gracefully |

**Checklist:**
- [ ] User message displays immediately (optimistic update)
- [ ] Bot response received within configured timeout
- [ ] Response formatting matches expected output
- [ ] Conversation history maintains correct order
- [ ] Messages persist across page refresh
- [ ] Rate limiting messages shown when applicable

### Step 3: Multi-Agent Workflow Testing

**Actions:**
- Test conversations involving multiple AI agents
- Validate agent handoff mechanisms
- Test agent specialization routing
- Verify cross-agent context sharing

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| AGENT-01 | Question routed to specialist agent | Correct agent responds |
| AGENT-02 | Multi-agent collaboration | All agents contribute, coordinator synthesizes |
| AGENT-03 | Agent handoff during conversation | Context preserved during handoff |
| AGENT-04 | Agent unavailable/fails | Fallback agent engaged |
| AGENT-05 | Cross-company agent access blocked | 403 for unauthorized agent access |

**Checklist:**
- [ ] Agent roles clearly identified in responses
- [ ] Context shared between agents in conversation
- [ ] Agent handoff is transparent to user
- [ ] Agent permissions enforced (no cross-company access)
- [ ] Agent availability and health checked on init

### Step 4: Streaming Response Testing

**Actions:**
- Validate SSE (Server-Sent Events) streaming
- Validate WebSocket streaming (if used)
- Test streaming interruption
- Test streaming recovery on network disruption

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| STREAM-01 | Streaming message response | Text appears incrementally |
| STREAM-02 | Streaming interrupted mid-response | Clear state, retry option available |
| STREAM-03 | Streaming on slow connection | Progress indicator shown |
| STREAM-04 | Streaming connection timeout | Error shown, fallback to non-streaming |
| STREAM-05 | User cancels streaming response | Stream terminated, partial response shown |

**Checklist:**
- [ ] Stream connection established
- [ ] Content appears incrementally (not all at once)
- [ ] Progress indicator shown during streaming
- [ ] Stream completes with final message
- [ ] User can cancel streaming mid-response
- [ ] Network interruption handled gracefully

### Step 5: Supabase Persistence Testing

**Actions:**
- Verify chat sessions saved to Supabase
- Test session retrieval and restoration
- Validate message count and accuracy in DB
- Test concurrent session writes

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| DB-01 | Session created in Supabase | Record created in sessions table |
| DB-02 | Messages saved to Supabase | All messages persisted with correct metadata |
| DB-03 | Session restored after page refresh | Conversation history loaded from Supabase |
| DB-04 | Multiple sessions per user | Each session independent |
| DB-05 | RLS policy blocks cross-user access | Users see only their own sessions |

**Checklist:**
- [ ] Session record created on chatbot init
- [ ] Each message saved with correct user/bot attribution
- [ ] Timestamps accurate and in correct timezone
- [ ] Session retrieval returns complete history
- [ ] RLS policies prevent cross-user data access
- [ ] Session metadata (agent, model) recorded

### Step 6: Error Handling Testing

**Actions:**
- Simulate API failures
- Test timeout handling
- Validate rate limit behavior
- Test invalid input handling

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| ERR-01 | AI service returns 500 | Error shown, retry option available |
| ERR-02 | Request times out | Timeout message, not frozen UI |
| ERR-03 | Rate limit exceeded | Rate limit message, countdown shown |
| ERR-04 | Invalid API key | Auth error, configuration option shown |
| ERR-05 | Network offline | Offline message, queue messages |
| ERR-06 | Malformed response from AI | Parse error handled, raw response logged |

**Checklist:**
- [ ] All error types show user-friendly messages
- [ ] No frozen UI on any error condition
- [ ] Retry mechanisms available where appropriate
- [ ] Error details logged for debugging
- [ ] Sensitive error info not exposed to user
- [ ] Error recovery tested for each condition

## Production Testing Execution Mapping

| Doc # | Document | Coverage |
|-------|----------|----------|
| 1 | `tier1-testing.md` | AI service connectivity validation |
| 7 | `tier2-testing.md` | AI agent functionality spot-check |
| 10 | `discipline-testing.md` | Chatbot on discipline pages |
| 11 | `tier3-testing.md` | Error handling in chatbot |
| 12 | `chatbot-production-testing.md` | **Primary** — Complete chatbot testing |
| 13 | `tier4-testing.md` | Multi-agent swarm controls testing |
| 14 | `HITL_Production_Testing_Hermes_Agent.md` | HITL chatbot integration |

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Message Success Rate | >99% | Messages sent/received without error |
| Streaming Success | >95% | Streams complete without interruption |
| Multi-Agent Routing | >90% | Correct agent responds to domain questions |
| Session Persistence | 100% | All sessions persist across refresh |
| Error Handling Coverage | 100% | All error types handled gracefully |
| Average Response Time | <10s first token | Time to first token received |

## Error Handling

### Error 1: Chatbot Fails to Initialize
**Severity:** High
**Resolution:**
1. Check AI service API key configuration
2. Verify network connectivity to API endpoint
3. Check if API endpoint is accessible (health check)
4. Review browser console for CSP/CORS errors
5. Verify Supabase connectivity for session creation

### Error 2: Streaming Responses Fail
**Severity:** Medium
**Resolution:**
1. Check SSE endpoint availability and format
2. Verify Content-Type header is text/event-stream
3. Test with curl/wget to isolate client vs server issue
4. Check if model supports streaming (some don't)
5. Verify connection isn't blocked by proxy/firewall

### Error 3: Messages Not Persisting to Supabase
**Severity:** High
**Resolution:**
1. Check Supabase connection and API key
2. Verify RLS policies allow write access
3. Check message schema matches table structure
4. Verify batch insert isn't hitting row limits
5. Test manual insert with Supabase client

## Cross-Team Integration

- **browser-ui-testing-qualityforge**: Chatbot UI rendering and interaction
- **hitl-workflow-testing-qualityforge**: HITL workflow with chatbot
- **integration-promptforge-cross-agent-compatibility**: Cross-agent compatibility
- **analyzer-promptforge-prompt-analytics**: Prompt/response quality analytics
- **cascade-promptforge-workflow-designer**: Multi-agent workflow validation
- **testing-verification** (shared): Chatbot test result verification
- **chat-ui-workflow-interaction** (shared): Chat UI workflow coordination