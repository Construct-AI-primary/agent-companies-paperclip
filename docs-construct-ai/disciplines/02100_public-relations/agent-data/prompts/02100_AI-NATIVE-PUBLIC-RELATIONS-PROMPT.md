---
title: 02100 Public Relations AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement Public Relations features including press release generation, media monitoring, community engagement workflows, crisis communications, stakeholder CRM, and sentiment analysis with structured data architecture
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02100_public-relations/agent-data/prompts
gigabrain_tags: disciplines, 02100_public-relations, ai-native-operations, document-generation, media-relations, community-engagement, stakeholder-communication, reputation-management, multi-agent-orchestration, sentiment-analysis, code-generation
openstinger_context: public-relations-ai-native-operations, automated-documentation, agent-integration, code-generation
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/02100_public-relations/agent-data/domain-knowledge/02100_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/02100_public-relations/agent-data/domain-knowledge/02100_GLOSSARY.MD
  - docs_construct_ai/codebase/procedures/workflow-management/0000_PROMPT_REVIEW_REMEDIATION_PROCEDURE.md
---

# 02100 Public Relations AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement Public Relations features on large-scale engineering and construction projects. It provides agents with the architectural context, automation spectrum, safety boundaries, and implementation patterns needed to generate correct, compliant PR code covering press release generation, media monitoring, community engagement workflows, crisis communications, stakeholder CRM, and sentiment analysis. Use this prompt when agents are developing PR components, workflows, APIs, or UI elements.

**Key Lessons from Safety, Civil, IT, and Inspection Domains:** The automation spectrum approach (Full Automation / Augment AI+Human / Human-Led) and structured data architecture patterns are foundational principles. Agents must understand what PR code they can generate independently vs. what requires human architect review. Communications must never be released without authorization verification.

**Important:** This prompt is for **OpenClaw coding agents operating in dev mode**. Agents use this prompt to **generate, modify, and validate code**. This prompt is NOT for the running application in production. The automation spectrum defines what **code** agents can generate independently vs. what requires human architect review.

## Implementation Action List & Progress Tracking

### Phase 1: Foundation — Text-Native vs Sentiment-Native Architecture
- [ ] **Classify all PR data sources** — Tag each input as text-native (press releases, statements, newsletters), structured data (media databases, stakeholder lists, sentiment scores), image/video-native (site photos, media footage), or human-led (interviews, meetings)
- [ ] **Implement media monitoring pipeline** — Media sources → structured data extraction → sentiment analysis → coverage report generation
- [ ] **Implement stakeholder CRM pipeline** — Stakeholder database → communication history → personalized output generation
- [ ] **Build templates per communication type** — Press releases, media statements, Q&As, newsletters, holding statements, crisis briefings
- [ ] **Implement provenance tracking** — Every communication tagged with source data, approved messages, author, approval status
- [ ] **Enforce guard rails** — LLM cannot create communications without verified facts; must flag unverified information

### Phase 2: Document Generation Pipeline Implementation
- [ ] **Create template library** — Standardize all PR document templates (press releases, media statements, Q&As, newsletters, crisis communications, stakeholder briefings)
- [ ] **Implement structured data injection** — Template engine fills placeholders from project updates, media monitoring data, stakeholder database (not raw LLM text)
- [ ] **Develop Phase 1 documents (Pre-Construction)** — Media strategy documents, stakeholder communication plans, community consultation plans, crisis communication plans
- [ ] **Develop Phase 2 documents (Construction)** — Press releases, media updates, community newsletters, stakeholder briefings, media monitoring reports
- [ ] **Develop Phase 3 documents (Crisis Response)** — Holding statements, crisis Q&A materials, media briefings, situation reports, post-crisis reports
- [ ] **Develop Phase 4 documents (Project Completion)** — Project completion announcements, final stakeholder reports, lessons learned communications
- [ ] **Add quality validation** — Automated completeness checks, tone verification, message alignment with approved positions
- [ ] **Implement approval workflow** — Document revision tracking with approval status and authorization

### Phase 3: Multi-Agent PR Orchestration
- [ ] **Implement Media Inquiry Agent** — Classify incoming media inquiries, route to appropriate response workflow
- [ ] **Implement Press Release Agent** — Auto-generate press releases from project milestone data
- [ ] **Implement Media Monitoring Agent** — Track media coverage, analyze sentiment, generate coverage reports
- [ ] **Implement Community Feedback Agent** — Process community feedback, categorize concerns, track response status
- [ ] **Implement Crisis Communications Agent** — Prepare holding statements, Q&A materials, situation reports during incidents
- [ ] **Implement Stakeholder Communication Agent** — Generate personalized stakeholder updates from CRM data
- [ ] **Implement Sentiment Analysis Agent** — Analyze media and community sentiment, generate trend reports
- [ ] **Implement agent coordination layer** — Media inquiry → Classification → Response preparation → Approval → Release → Monitoring workflow

### Phase 4: Sentiment & Media Intelligence
- [ ] **Implement media sentiment analysis** — Analyze tone, sentiment, and framing in media coverage
- [ ] **Develop community sentiment tracking** — Process community feedback for sentiment trends
- [ ] **Implement social media monitoring** — Track social media sentiment, engagement metrics
- [ ] **Develop reputation risk assessment** — Identify emerging reputation risks from media and community trends
- [ ] **Implement media attention prediction** — Predict which topics will receive media attention

### Phase 5: Natural Language PR Interface
- [ ] **Implement Message Development Assistant** — "Draft a press release for [milestone]" → structured press release draft
- [ ] **Develop Media Monitoring Query** — "Show me coverage this week" → filtered media monitoring report
- [ ] **Implement Crisis Q&A Generator** — "Prepare Q&A for [incident]" → draft holding statement and Q&A materials
- [ ] **Develop Community Feedback Analysis** — "What are the top community concerns this month?" → categorized feedback report
- [ ] **Implement chatbot with PR boundaries** — Cannot release unverified information, cannot authorize media statements

### Phase 6: Stakeholder CRM Intelligence
- [ ] **Implement stakeholder communication history** — Track all stakeholder communications by contact
- [ ] **Develop personalized outreach** — Generate tailored communications based on stakeholder profile and history
- [ ] **Implement feedback trend analysis** — Identify patterns in stakeholder concerns over time
- [ ] **Develop stakeholder engagement tracking** — Track engagement events, responses, follow-ups
- [ ] **Implement stakeholder dashboard** — Real-time stakeholder engagement visualization with trend analysis

### Phase 7: Crisis Communications Readiness
- [ ] **Implement crisis protocol activation** — Activate crisis communications protocol from incident data
- [ ] **Develop holding statement generation** — Auto-draft holding statements from incident facts
- [ ] **Implement crisis Q&A development** — Generate anticipated questions and approved responses
- [ ] **Develop spokesperson briefing preparation** — Compile briefing packages from available information
- [ ] **Implement post-crisis review generation** — Compile post-incident review communications

### Phase 8: AI Safety Boundaries & Governance
- [ ] **Implement authorization verification** — All communications must have verified approval status before release
- [ ] **Develop uncertainty disclosure** — AI must disclose when information unverified, guidance exceeds available facts
- [ ] **Implement immutable audit trail** — Log all communications drafted with provenance tags
- [ ] **Develop human review gates** — All external communications require human authorization before release
- [ ] **Implement data privacy compliance** — Stakeholder CRM data handled per privacy policy

## Discipline Context

### 02100 Public Relations Scope
The 02100 Public Relations discipline encompasses:
- **AI-Native Operations**: Automating PR documentation from press releases to crisis communications
- **Media Monitoring Pipeline**: Coverage tracking, sentiment analysis, reporting
- **Press Release Pipeline**: Project milestone → structured data → press release generation
- **Stakeholder CRM**: Personalized communication, engagement tracking
- **Crisis Communications**: Holding statements, Q&A, briefings, post-crisis reports
- **Sentiment Intelligence**: Media, community, and social media sentiment tracking
- **Community Engagement**: Feedback processing, response tracking, reporting
- **PR Governance**: Authorization verification, approval workflows, audit trails

### Related Disciplines
- **01750 Legal**: Media inquiry legal review, statement clearance
- **01300 Governance**: Communication policy compliance, crisis escalation
- **02400 Safety**: Incident communication coordination, safety briefings
- **01850 Other Parties**: Community organization engagement, government liaison
- **02500 Security**: Incident notification coordination

## Core Template Structure

```
[TASK DESCRIPTION]

Using the Construct AI memory system with Gigabrain for 02100 Public Relations AI-Native Operations:

**PARA Navigation:**
- Access docs_construct_ai/disciplines/02100_public-relations/agent-data/domain-knowledge/
- Reference AI-native operations documentation (Part 7 in DOMAIN-KNOWLEDGE.MD)
- Reference related areas: [additional PARA paths based on task]

**Gigabrain Search:**
- Search gigabrain tags for "disciplines, 02100_public-relations", "ai-native-operations", "[specific-capability]"
- Filter by tags: "media-relations", "community-engagement", "stakeholder-communication", "reputation-management", "sentiment-analysis", "multi-agent-orchestration"

**Memory Context:**
- Include memory headers showing related_docs, para_section, and gigabrain_tags
- Cross-reference with PR domain knowledge and glossary
- Check memory for recent PR AI implementation patterns

**Public Relations AI-Native Context:**
- Reference text-native, structured data, and image-native input classification
- Apply structured data pipeline (media data → analysis → output generation)
- Follow document generation pipeline principles (template-based structured data injection)
- Respect authorization requirements (no release without verified approval)

**Knowledge Integration:**
- Follow cross-references in memory headers
- Identify patterns across similar PR AI implementations
- Build on established PR organizational knowledge
- Ensure compliance with communication policies and audit requirements

[SPECIFIC REQUIREMENTS OR QUESTIONS]
```

## PR AI-Native Use Case Templates

### Press Release Generation Pipeline
```
Generate Press Release for [PROJECT_MILESTONE]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02100_public-relations/agent-data/domain-knowledge/02100_DOMAIN-KNOWLEDGE.MD
- Reference press release generation: Part 7, Phase 2
- Check approved messaging and key facts: Part 2.2

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02100_public-relations", "media-relations", "[milestone-type]"
- Filter by tags: "press-release", "media-statement", "approved-messaging"

Memory Context:
- Include memory headers with press release generation gigabrain_tags
- Cross-reference with project milestone data and approved messages
- Reference historical press release templates for similar milestones

PR AI-NATIVE CONTEXT:
- Apply press release template with structured data injection from milestone data
- Include approved key facts, messaging, and boilerplate
- Set approval status to "pending review" — do not release
- Include quotes from appropriate spokesperson (pending confirmation)

Provide press release generation with:
- Project milestone data extraction and verification
- Template structure with headline, dateline, body, quotes, boilerplate
- Media contact information from stakeholder database
- Approval status verification (must be "pending" until authorized)
- Provenance tracking: source data, template version, draft date
```

### Media Monitoring and Analysis
```
Generate Media Coverage Report for [TIME_PERIOD]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02100_public-relations/agent-data/domain-knowledge/
- Reference media monitoring: Part 7D Sentiment Intelligence
- Check media outlets and journalists database: Part 2.1

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02100_public-relations", "media-relations", "media-monitoring"
- Filter by tags: "sentiment-analysis", "coverage-report", "media-trends"

Memory Context:
- Include memory headers with media monitoring gigabrain_tags
- Cross-reference with media coverage database
- Reference historical media monitoring trends

PR AI-NATIVE CONTEXT:
- Apply media monitoring pipeline: Sources → Structured extraction → Sentiment analysis → Coverage report
- Aggregate coverage from all monitored sources for the time period
- Analyze sentiment, tone, framing, and prominence
- Generate report with trends compared to previous period

Provide media monitoring analysis with:
- Coverage volume metrics (number of articles, broadcast segments, social mentions)
- Sentiment analysis results (positive, negative, neutral percentages)
- Key themes and topics identified
- Comparative trends versus previous periods
- Flagged items requiring management attention
- Provenance tracking: sources analyzed, analysis date, methodology
```

### Crisis Communications Pipeline
```
Prepare Crisis Communications for [INCIDENT]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02100_public-relations/agent-data/domain-knowledge/02100_DOMAIN-KNOWLEDGE.MD
- Reference crisis communications: Part 4, Part 7 Phase 3
- Check crisis protocol and approved messaging: Part 7F

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02100_public-relations", "crisis-communications", "[incident-type]"
- Filter by tags: "holding-statement", "crisis-qa", "spokesperson-briefing"

Memory Context:
- Include memory headers with crisis communications gigabrain_tags
- Cross-reference with crisis protocol and incident facts
- Reference approved crisis messaging templates

PR AI-NATIVE CONTEXT:
- Apply crisis communications pipeline: Incident facts → Holding statement → Q&A → Spokesperson briefing
- Use only verified incident facts — flag any unconfirmed information
- All materials generated with approval status "draft" — require authorization
- Show appropriate empathy and concern for those affected

Provide crisis communications materials with:
- Holding statement (based on verified facts, appropriate empathy, commit to updates)
- Anticipated media questions with approved responses (based on available facts)
- Spokesperson briefing notes (key messages, Q&A, background facts)
- Media monitoring setup for incident-related coverage
- Provenance tracking: incident data source, materials generated, review status
```

### Multi-Agent PR Orchestration
```
Coordinate PR Workflow for [MEDIA_INQUIRY]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02100_public-relations/agent-data/domain-knowledge/
- Reference multi-agent orchestration: Part 7D
- Check agent definitions and capabilities documentation

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02100_public-relations", "multi-agent-orchestration", "[inquiry-type]"
- Filter by tags: "agent-handoff", "data-flow", "workflow-automation"

Memory Context:
- Include memory headers with agent orchestration gigabrain_tags
- Cross-reference with agent capabilities and PR workflows
- Reference completed implementations of similar media inquiry workflows

PR AI-NATIVE CONTEXT:
- Apply standard orchestration pattern: Media inquiry received → Classify inquiry → Assess urgency → Prepare response materials → Obtain authorization → Issue response → Monitor coverage
- Define data formats passed between agents (structured JSON, not free text)
- Implement PR boundaries: no agent can authorize media statements, no agent can release unverified information

Provide agent orchestration implementation with:
- Agent coordination sequence with trigger conditions
- Data schema passed between agents (inquiry data, draft materials, approval status)
- Error handling and escalation when agent cannot process (urgent inquiry, sensitive topic)
- Quality validation checkpoints between agent handoffs
- Human authorization points in the workflow (all statement releases)
- Audit trail tracking for all communications drafted and approved
```

## Automation Spectrum for PR Operations Tasks

### Fully Automatable Tasks (Human-Free Generation)
The AI can independently execute these tasks with structured data input, requiring only final human review before distribution:

| Output | Trigger | Input Data | Quality Gate |
|--------|---------|-----------|--------------|
| **Press Release Draft** | Project milestone achieved | Milestone data, approved messaging | Auto-validation: facts verified, messaging aligned |
| **Media Monitoring Report** | Scheduled or coverage spike | Media coverage database | Auto-validation: sources checked, sentiment analyzed |
| **Community Newsletter Draft** | Publication schedule | Project updates, community events | Auto-validation: events verified, tone appropriate |
| **Community Feedback Summary** | Scheduled or feedback threshold | Community feedback register | Auto-validation: all feedback categorized, trends identified |
| **Stakeholder Communication Schedule** | Communication plan activated | Stakeholder contact list, schedule | Auto-validation: contacts valid, schedule current |
| **Media Coverage Analysis** | Time period complete | Media monitoring database | Auto-validation: all sources included, trends calculated |

### Augmented Tasks (AI + Human Co-Creation)
The AI drafts, suggests, or analyses — human specialist reviews and finalizes:

| Output | AI Contribution | Human Role | Decision Authority |
|--------|----------------|-----------|---------------------|
| **Crisis Holding Statement** | Draft from verified incident facts | PR lead reviews, approves, authorizes release | Human |
| **Media Q&A Materials** | Draft anticipated questions with responses | PR lead reviews, adjusts, approves | Human |
| **Spokesperson Briefing Notes** | Compile facts, questions, talking points | Spokesperson reviews, adjusts, uses | Human |
| **Stakeholder Personalized Update** | Draft from CRM data and project updates | Account manager reviews, personalizes, sends | Human |
| **Social Media Content** | Draft post from project updates | Social media manager reviews, schedules | Human |
| **Community Consultation Summary** | Compile feedback, prepare response summary | Community liaison reviews, finalizes | Human |

### Human-Led Tasks (AI Informs, Human Decides)
The AI provides data, context, and recommendations — human makes the final decision or action:

| Task | AI Support | Human Decision |
|------|-----------|----------------|
| **Media Inquiry Response** | Classify inquiry, draft response | PR professional authorizes timing and content |
| **Crisis Communication Strategy** | Compile facts, suggest talking points | Crisis team decides strategy and spokesperson |
| **Sensitive Community Concern** | Prepare background, suggest approach | Community relations lead decides response |
| **Media Relationship Engagement** | Provide coverage analysis, suggestions | PR lead decides engagement strategy |
| **Reputation Risk Response** | Analyze trends, suggest actions | Communications director decides action |
| **Commercial Communication** | Prepare draft from verified facts | Communications lead approves, legal clearance |

## Document Generation Pipeline

### Pipeline Architecture
All AI-generated communications flow through a consistent pipeline with quality gates at each stage:

```
INPUT DATA COLLECTION (project updates, media monitoring, stakeholder CRM, incident facts)
    ↓
STRUCTURED DATA VALIDATION (facts verified, sources confirmed, completeness checked)
    ↓
TEMPLATE SELECTION & CONFIGURATION (document type, audience, situation, severity)
    ↓
DATA INJECTION INTO TEMPLATE PLACEHOLDERS (structured data, not raw LLM)
    ↓
QUALITY VALIDATION (fact checking, tone verification, message alignment)
    ↓
DRAFT COMMUNICATION GENERATED
    ↓
HUMAN AUTHORIZATION (where required — all external communications)
    ↓
APPROVAL STATUS UPDATED
    ↓
OUTPUT GENERATION (press release, email, social media, newsletter, briefing)
    ↓
VERSION CONTROL & AUDIT LOG
    ↓
DISTRIBUTION & ARCHIVAL
```

### Template Design Principles
1. **Structured Data Injection, Not Raw Generation**: All templates use placeholders filled from verified structured data sources (project updates, media monitoring, stakeholder CRM, incident facts). The LLM structures and formats, but does not invent facts or quotes.
2. **Provenance Tracking**: Every fact, figure, and quote injected into a communication is tagged with its source (e.g., "project milestone data from [SOURCE], verified: [DATE], by [NAME]").
3. **Conditional Logic**: Templates include logic to add or omit sections based on situation (e.g., "if no casualties, omit casualty section"; "if media interest low, adjust tone").
4. **Tone and Accuracy**: All communications must be verified for factual accuracy and appropriate tone for the audience and situation.
5. **Multi-Format Output**: Communications must be adaptable to multiple channels (press release, email, social media, newsletter, briefing notes).
6. **Approval Required**: All external communications must have verified authorization before release — the system must enforce this boundary.

## AI-Native PR Capabilities Beyond Automation

### Sentiment Intelligence
- **Media Sentiment Analysis**: Automated analysis of tone, sentiment, and framing across media coverage with trend tracking
- **Community Sentiment Tracking**: Process and categorize community feedback for sentiment trends and emerging concerns
- **Social Media Sentiment**: Track social media sentiment about the project, identify viral content, respond appropriately
- **Stakeholder Feedback Analysis**: Categorize and analyze stakeholder communications for sentiment and priorities

### Predictive Intelligence
- **Media Attention Prediction**: Predict which project topics will receive media attention based on trends, news cycles
- **Community Concern Forecasting**: Predict emerging community concerns from feedback patterns and project milestones
- **Reputation Risk Prediction**: Identify potential reputation risks from media coverage trends, community sentiment
- **Crisis Probability Assessment**: Assess probability of communications crisis from incident trends, media interest

### Natural Language PR Interface
- **Message Development**: "Draft a press release for project milestone" → structured press release draft
- **Media Monitoring Query**: "Show me coverage this week" → filtered media monitoring report
- **Crisis Q&A Development**: "Prepare Q&A for [incident]" → draft holding statements, Q&A, briefing notes
- **Community Feedback Analysis**: "What are the top community concerns this month?" → categorized feedback report
- **Stakeholder History**: "Show all communications with [stakeholder]" → complete communication history

## AI Safety Boundaries — What Must NOT Be Automated

Certain decisions and actions must remain under human control for legal, ethical, and reputation reasons:

**Non-Delegable Human Decisions:**
1. Authorization of media releases and public statements
2. Crisis communication strategy and spokesperson selection
3. Response to sensitive community concerns
4. Media relationship strategy and priority outlet engagement
5. Communication regarding commercial or confidential matters
6. Final approval of all external communications
7. Escalation decisions during communications crises

**AI Must Always Disclose:**
1. When information has not been verified for accuracy
2. When crisis communication guidance exceeds available information
3. When community concerns may require human empathy and personal response
4. When media inquiries may be sensitive, legally consequential, or commercial
5. When tone or messaging recommendations conflict with approved positions
6. What information requires authorization before release
7. What communications involve personal relationships that require human interaction
8. What media statements involve unconfirmed or developing facts

## Technical Architecture Recommendations

| Component | Recommended Approach |
|-----------|---------------------|
| **Document generation** | Template engine with structured data injection from project updates, incident facts, CRM |
| **Media monitoring** | Media monitoring API integration; LLM analyzes coverage and generates reports |
| **Sentiment analysis** | Dedicated sentiment analysis models for media, social media, community feedback |
| **Crisis communications** | Pre-approved template library with situation-specific customization |
| **Stakeholder CRM** | Integration with stakeholder database; LLM generates personalized communications |
| **Knowledge retrieval** | RAG pattern for approved messages, communication policies, crisis protocols |
| **Audit trail** | Immutable log of all communications drafted with provenance tags and approval status |
| **Natural Language Interface** | Natural language query interface for media monitoring, community feedback, CRM history |

## AI Agent Coordination Workflow

```
Trigger Event Received (media inquiry, milestone achieved, incident reported, community feedback)
    → Classification Agent categorizes event type and urgency
    → If media inquiry: Media Inquiry Agent classifies outlet, journalist, topic, urgency
    → If project milestone: Press Release Agent drafts release from milestone data
    → If incident reported: Crisis Communications Agent activates protocol
    → If community feedback: Community Feedback Agent categorizes and logs
    → Response Preparation Agent drafts communication materials
    → Authorization Check Agent verifies approval status
    → If authorized: Communications distributed through appropriate channels
    → If not authorized: Escalated to human for review and authorization
    → Media Monitoring Agent tracks coverage and sentiment
    → Feedback Agent processes community and stakeholder responses
    → Knowledge Base Agent updates records and trends
```

## Implementation Best Practices

### Agent Coordination Guidelines
1. **Start with data quality** — garbage in, garbage out applies doubly for PR communications
2. **Implement one agent/pipeline** at a time, validate, then add next
3. **Engage QualityForge AI** for all validation and quality assurance before deployment
4. **Define clear agent boundaries** in prompts and tools from day one
5. **Document all communications drafted** with approval status and authorization
6. **Never let LLM process unverified information** as confirmed facts

### PR Boundary Enforcement
1. **Never allow AI to authorize communications** — always require human authorization
2. **Never allow release of unverified information** — always verify facts first
3. **Never allow AI to handle sensitive community concerns** — always escalate to human
4. **Always disclose AI limitations** — fact coverage, information currency, sentiment accuracy
5. **Always maintain immutable audit trail** — all communications with provenance
6. **Always tag communications data** with approval status, authorization, and provenance

## Success Metrics

### Document Generation Metrics
- **Accuracy**: 99%+ factual accuracy in generated communications vs verified data
- **Timeliness**: 80%+ reduction in communication drafting time vs manual methods
- **Review Efficiency**: 50%+ reduction in human review cycles through pre-validation
- **Compliance**: 100% of external communications have verified authorization before release

### Media Monitoring Metrics
- **Coverage Capture**: 95%+ of relevant media coverage captured and recorded
- **Sentiment Accuracy**: 85%+ accuracy in automated sentiment classification
- **Report Generation**: 90%+ reduction in media monitoring report preparation time
- **Trend Detection**: 90%+ of media attention spikes and sentiment shifts detected

### Crisis Communications Metrics
- **Response Time**: 90%+ of holding statements drafted within 30 minutes of incident notification
- **Authorization Compliance**: 100% of crisis communications have verified authorization before release
- **Material Completeness**: 100% of crisis communications include all required elements
- **Post-Crisis Review**: 100% of post-crisis communication reviews completed within 72 hours

### Multi-Agent Orchestration Metrics
- **Completion Rate**: 95%+ of PR workflow sequences complete without failure
- **Latency**: End-to-end agent handoff <5 seconds for each transition
- **Error Recovery**: 100% of failed agent executions recovered or escalated to human
- **Audit Trail Integrity**: 100% of agent actions logged with source, timestamp, and decision

## Version History

- **v1.0** (2026-04-01): Initial AI-Native Public Relations Operations Prompt Template
- Added structured metadata header following established pattern
- Incorporated lessons learned from Safety, Civil Engineering, IT, and Inspection domains
- Created PR-specific use case templates for press release generation, media monitoring, crisis communications, and agent orchestration
- Defined automation spectrum for all PR operations tasks (Full, Augmented, Human-Led)
- Built comprehensive document generation pipeline with quality gates and template design principles
- Detailed success metrics for all AI capabilities
- Added implementation best practices and PR boundary enforcement

## Public Relations AI Agent Behavioral Rules

### Non-Negotiable Rules for All PR AI Agents

1. **Accuracy First Rule:** Never release unverified or inaccurate information. If information cannot be verified, the agent must flag it as "unverified — requires confirmation."

2. **Authorization Required Rule:** No external communication can be released without verified authorization. Always check approval status before distributing any communication.

3. **No Information Fabrication Rule:** Never invent facts, quotes, or statistics. Only use data from verified sources (project updates, verified incident facts, stakeholder CRM).

4. **Provenance Tracking Rule:** All communication content must carry provenance tags (source facts, verification date, approval status). Never present facts without their source attribution.

5. **No Empathy Substitution Rule:** When community concerns require human empathy, personal relationships, or sensitive responses, escalate to human. AI cannot substitute for human empathy.

6. **Crisis Protocol Adherence Rule:** During a communications crisis, follow the established crisis protocol. Do not improvise. Use approved templates and verified facts only.

7. **Appropriate Tone Rule:** Ensure tone is appropriate for the audience, situation, and organizational policy. If tone may be sensitive, escalate to human for determination.

8. **Documentation Rule:** All communications should be structured for formal PR standards. Use professional, approved language that meets project communication policies.

9. **Respect Non-Delegable Decisions:** Never authorize media releases, make crisis strategy decisions, or approve commercial communications. These require human communication authority.

10. **Audit Trail Rule:** All communications drafted, reviewed, or generated must be recorded with full audit trail for media accountability, crisis review, and organizational learning.