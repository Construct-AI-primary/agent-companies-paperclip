-- Paperclip Ecosystem Data Loading Script
-- Run this SQL script to load all goals, projects, issues, and documents into Supabase
-- Execute in order: goals -> projects -> issues -> documents

-- Note: Companies already exist in the database, so we're only adding goals, projects, issues, and documents

-- =============================================================================
-- GOALS INSERTION
-- =============================================================================

-- DevForge AI Goal
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
VALUES (
  'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
  'Deliver Intelligent Model Selection and Assessment Systems',
  'Establish DevForge AI as the global leader in AI model selection and assessment, providing intelligent systems that optimize model performance, ensure reliability, and maximize AI system effectiveness across all industries.',
  'company',
  'active',
  NOW(),
  NOW()
) ON CONFLICT DO NOTHING;

-- QualityForge AI Goal
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
VALUES (
  'f535f9bc-00be-4b6d-9f53-c53abfacacef',
  'Deliver AI-Powered Quality Assurance & Testing Services',
  'Establish QualityForge AI as the global leader in AI-powered quality assurance, providing comprehensive testing automation, quality validation, and reliability engineering that ensures AI systems perform flawlessly at scale.',
  'company',
  'active',
  NOW(),
  NOW()
) ON CONFLICT DO NOTHING;

-- DomainForge AI Goal
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
VALUES (
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'Deliver Multi-Discipline AI Engineering Solutions',
  'Establish DomainForge AI as the global leader in multi-discipline engineering AI solutions, providing intelligent systems that span engineering domains, optimize complex workflows, and deliver engineering excellence through AI-powered coordination.',
  'company',
  'active',
  NOW(),
  NOW()
) ON CONFLICT DO NOTHING;

-- InfraForge AI Goal
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
VALUES (
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'Deliver AI-Powered Infrastructure and Data Management Services',
  'Establish InfraForge AI as the global leader in AI-powered infrastructure services, providing intelligent infrastructure management, data optimization, and systems integration that powers the entire Paperclip ecosystem and enterprise customers worldwide.',
  'company',
  'active',
  NOW(),
  NOW()
) ON CONFLICT DO NOTHING;

-- PromptForge AI Goal
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
VALUES (
  'f02b83a8-e0db-4332-b507-22f85e71ebf5',
  'Provide Advanced AI Prompt Engineering and Orchestration',
  'Establish PromptForge AI as the global leader in advanced prompt engineering and AI orchestration, providing sophisticated prompt architectures, ethical AI frameworks, and orchestration capabilities that maximize AI system performance and ensure responsible AI deployment across all industries.',
  'company',
  'active',
  NOW(),
  NOW()
) ON CONFLICT DO NOTHING;

-- Loopy AI Goal
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
VALUES (
  '0a40625e-78f9-4b0a-82e4-169a8befa021',
  'Deliver Creative AI and Content Generation Solutions',
  'Establish Loopy AI as the global leader in creative AI and content generation, providing intelligent creative tools, marketing automation, and artistic applications that empower creators, marketers, and businesses to produce compelling content at scale.',
  'company',
  'active',
  NOW(),
  NOW()
) ON CONFLICT DO NOTHING;

-- =============================================================================
-- PROJECTS INSERTION
-- =============================================================================

-- DevForge AI Project
INSERT INTO projects (company_id, goal_id, name, description, status, target_date, created_at, updated_at)
SELECT
  'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
  g.id,
  'Agent Model Assessment Implementation',
  'Implement DevForge AI''s intelligent model assessment system that leverages existing testing documentation to create automated model evaluation, performance optimization, and deployment validation frameworks.',
  'planning',
  '2026-06-15'::date,
  NOW(),
  NOW()
FROM goals g
WHERE g.company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND g.title = 'Deliver Intelligent Model Selection and Assessment Systems'
ON CONFLICT DO NOTHING;

-- QualityForge AI Project
INSERT INTO projects (company_id, goal_id, name, description, status, target_date, created_at, updated_at)
SELECT
  'f535f9bc-00be-4b6d-9f53-c53abfacacef',
  g.id,
  'Production Testing Automation Framework Implementation',
  'Transform QualityForge AI''s existing testing documentation into an intelligent, automated testing framework that serves as the foundation for enterprise testing services with 90% reduction in manual testing effort.',
  'planning',
  '2026-06-15'::date,
  NOW(),
  NOW()
FROM goals g
WHERE g.company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND g.title = 'Deliver AI-Powered Quality Assurance & Testing Services'
ON CONFLICT DO NOTHING;

-- DomainForge AI Project
INSERT INTO projects (company_id, goal_id, name, description, status, target_date, created_at, updated_at)
SELECT
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  g.id,
  'Long-Lead Item Procurement AI Automation System',
  'Implement DomainForge AI''s intelligent procurement automation system that transforms long-lead item procurement workflows through AI-driven scheduling, supplier intelligence, and critical path optimization.',
  'planning',
  '2026-06-22'::date,
  NOW(),
  NOW()
FROM goals g
WHERE g.company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND g.title = 'Deliver Multi-Discipline AI Engineering Solutions'
ON CONFLICT DO NOTHING;

-- InfraForge AI Project
INSERT INTO projects (company_id, goal_id, name, description, status, target_date, created_at, updated_at)
SELECT
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  g.id,
  'Intelligent Supabase Schema Management and Automation Platform',
  'Create InfraForge AI''s intelligent database schema management platform that automates Supabase table creation, migration management, and performance optimization with 80% reduction in manual database operations.',
  'planning',
  '2026-06-01'::date,
  NOW(),
  NOW()
FROM goals g
WHERE g.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
  AND g.title = 'Deliver AI-Powered Infrastructure and Data Management Services'
ON CONFLICT DO NOTHING;

-- PromptForge AI Project
INSERT INTO projects (company_id, goal_id, name, description, status, target_date, created_at, updated_at)
SELECT
  'f02b83a8-e0db-4332-b507-22f85e71ebf5',
  g.id,
  'Intelligent Prompt Generation and Domain Knowledge Enhancement Platform',
  'Build PromptForge AI''s intelligent platform that generates optimized prompts for agents while enhancing domain knowledge documentation, enabling automated project and issue plan generation from comprehensive domain expertise.',
  'planning',
  '2026-06-15'::date,
  NOW(),
  NOW()
FROM goals g
WHERE g.company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND g.title = 'Provide Advanced AI Prompt Engineering and Orchestration'
ON CONFLICT DO NOTHING;

-- Loopy AI Project
INSERT INTO projects (company_id, goal_id, name, description, status, target_date, created_at, updated_at)
SELECT
  '0a40625e-78f9-4b0a-82e4-169a8befa021',
  g.id,
  'AI Native Platform LinkedIn Campaign Content Generation',
  'Create Loopy AI''s AI-powered LinkedIn campaign content generation system targeting mining executives with compelling narratives about AI native platform benefits, achieving 300%+ ROI through optimized engagement.',
  'planning',
  '2026-05-15'::date,
  NOW(),
  NOW()
FROM goals g
WHERE g.company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021'
  AND g.title = 'Deliver Creative AI and Content Generation Solutions'
ON CONFLICT DO NOTHING;

-- =============================================================================
-- ISSUES INSERTION
-- =============================================================================

-- DevForge AI Issue
INSERT INTO issues (company_id, project_id, title, description, status, priority, identifier, created_at, updated_at)
SELECT
  'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
  p.id,
  'Model Assessment Framework Architecture Design',
  'Design the core architecture for DevForge AI''s intelligent model assessment framework that integrates with existing testing documentation and provides automated model evaluation capabilities.',
  'open',
  'critical',
  'DFA-001',
  NOW(),
  NOW()
FROM projects p
WHERE p.company_id = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4'
  AND p.name = 'Agent Model Assessment Implementation'
ON CONFLICT DO NOTHING;

-- QualityForge AI Issue
INSERT INTO issues (company_id, project_id, title, description, status, priority, identifier, created_at, updated_at)
SELECT
  'f535f9bc-00be-4b6d-9f53-c53abfacacef',
  p.id,
  'Testing Framework Architecture Design',
  'Design the core architecture for QualityForge AI''s automated testing framework that transforms existing testing documentation into intelligent, automated testing systems.',
  'open',
  'critical',
  'QFA-001',
  NOW(),
  NOW()
FROM projects p
WHERE p.company_id = 'f535f9bc-00be-4b6d-9f53-c53abfacacef'
  AND p.name = 'Production Testing Automation Framework Implementation'
ON CONFLICT DO NOTHING;

-- DomainForge AI Issue
INSERT INTO issues (company_id, project_id, title, description, status, priority, identifier, created_at, updated_at)
SELECT
  '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  p.id,
  'Procurement Domain Analysis for Long-Lead Item Intelligence',
  'Conduct comprehensive analysis of procurement domain requirements and long-lead item characteristics to establish the foundation for DomainForge AI''s intelligent procurement automation system.',
  'open',
  'critical',
  'DOM-001',
  NOW(),
  NOW()
FROM projects p
WHERE p.company_id = '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d'
  AND p.name = 'Long-Lead Item Procurement AI Automation System'
ON CONFLICT DO NOTHING;

-- InfraForge AI Issue
INSERT INTO issues (company_id, project_id, title, description, status, priority, identifier, created_at, updated_at)
SELECT
  '09f438a3-4041-46f2-b3cc-96fc9446e666',
  p.id,
  'Schema Intelligence Engine Architecture Design',
  'Design the core architecture for InfraForge AI''s Schema Intelligence Engine that powers intelligent Supabase schema management and automation platform.',
  'open',
  'critical',
  'INF-001',
  NOW(),
  NOW()
FROM projects p
WHERE p.company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'
  AND p.name = 'Intelligent Supabase Schema Management and Automation Platform'
ON CONFLICT DO NOTHING;

-- PromptForge AI Issue
INSERT INTO issues (company_id, project_id, title, description, status, priority, identifier, created_at, updated_at)
SELECT
  'f02b83a8-e0db-4332-b507-22f85e71ebf5',
  p.id,
  'Prompt Intelligence Engine Architecture Design',
  'Design the core architecture for PromptForge AI''s Prompt Intelligence Engine that powers intelligent prompt generation and domain knowledge enhancement platform.',
  'open',
  'critical',
  'PFA-001',
  NOW(),
  NOW()
FROM projects p
WHERE p.company_id = 'f02b83a8-e0db-4332-b507-22f85e71ebf5'
  AND p.name = 'Intelligent Prompt Generation and Domain Knowledge Enhancement Platform'
ON CONFLICT DO NOTHING;

-- Loopy AI Issue
INSERT INTO issues (company_id, project_id, title, description, status, priority, identifier, created_at, updated_at)
SELECT
  '0a40625e-78f9-4b0a-82e4-169a8befa021',
  p.id,
  'Mining Executive Persona Analysis for AI Native Platform Campaign',
  'Conduct comprehensive research and analysis of mining executive personas to understand their motivations, pain points, and technology adoption patterns for effective LinkedIn campaign content creation.',
  'open',
  'critical',
  'LPA-001',
  NOW(),
  NOW()
FROM projects p
WHERE p.company_id = '0a40625e-78f9-4b0a-82e4-169a8befa021'
  AND p.name = 'AI Native Platform LinkedIn Campaign Content Generation'
ON CONFLICT DO NOTHING;

-- =============================================================================
-- DOCUMENTS INSERTION
-- =============================================================================

-- Cross-Company Coordination Framework Document
INSERT INTO documents (company_id, title, format, latest_body, created_at, updated_at)
VALUES (
  'f97b30e8-b022-4350-b4b0-30d43e2ebcf4', -- DevForge AI as the "owning" company
  'Cross-Company Coordination Framework',
  'markdown',
  '# Cross-Company Coordination Framework

## Overview

This framework establishes the coordination mechanisms, interdependencies, and collaboration protocols across the Paperclip AI ecosystem. It ensures that individual company goals align with ecosystem-wide objectives while maximizing synergies and minimizing conflicts.

## Company Interdependency Matrix

### Primary Dependencies

| Company | Provides | Depends On | Key Integration Points |
|---------|----------|------------|----------------------|
| **DevForge AI** | AI Models & APIs | QualityForge (testing), InfraForge (infrastructure), PromptForge (prompts) | Model deployment, API integration, performance monitoring |
| **QualityForge AI** | Testing & QA | DevForge (models), InfraForge (infrastructure), KnowledgeForge (documentation) | Automated testing pipelines, quality metrics, validation frameworks |
| **DomainForge AI** | Engineering Solutions | DevForge (AI capabilities), InfraForge (infrastructure), PromptForge (prompts) | Multi-discipline workflows, critical path optimization, procurement intelligence |
| **InfraForge AI** | Infrastructure & Data | All companies (infrastructure needs), DevForge (AI optimization) | Database management, cloud infrastructure, performance monitoring |
| **PromptForge AI** | Prompt Engineering | KnowledgeForge (domain knowledge), All companies (prompt needs) | Agent prompt optimization, domain knowledge enhancement, ethical frameworks |
| **Loopy AI** | Content Generation | All companies (content subjects), KnowledgeForge (industry knowledge) | Marketing content, campaign materials, executive communications |

## Shared Goal Dependencies

### Ecosystem-Wide Objectives

#### 1. AI Excellence Foundation
**Primary Owner:** DevForge AI
**Supporting Companies:** QualityForge AI, InfraForge AI, PromptForge AI
**Shared Metrics:**
- Model performance and accuracy
- System reliability and uptime
- AI capability advancement
- Ethical AI implementation

#### 2. Operational Excellence
**Primary Owner:** InfraForge AI
**Supporting Companies:** QualityForge AI, DevForge AI, DomainForge AI
**Shared Metrics:**
- Infrastructure uptime and performance
- System scalability and efficiency
- Cost optimization
- Security and compliance

#### 3. Quality & Reliability
**Primary Owner:** QualityForge AI
**Supporting Companies:** All companies
**Shared Metrics:**
- Test coverage and success rates
- System reliability metrics
- User satisfaction scores
- Defect prevention rates

#### 4. Knowledge & Intelligence
**Primary Owner:** KnowledgeForge AI
**Supporting Companies:** PromptForge AI, DomainForge AI, Loopy AI
**Shared Metrics:**
- Knowledge base completeness
- Information accuracy and timeliness
- User adoption and engagement
- Knowledge utilization rates

## Communication Protocols

### Regular Coordination Meetings

#### Weekly Cross-Company Sync
- **Attendees:** All CEOs and project leads
- **Frequency:** Weekly on Mondays
- **Purpose:** Project status, dependency updates, issue resolution
- **Format:** 60-minute structured review

#### Bi-Weekly Technical Coordination
- **Attendees:** Technical leads from interdependent companies
- **Frequency:** Bi-weekly on Wednesdays
- **Purpose:** Technical integration, API coordination, dependency management
- **Format:** 45-minute technical deep-dive

#### Monthly Strategic Alignment
- **Attendees:** All CEOs and key stakeholders
- **Frequency:** Monthly on first Friday
- **Purpose:** Strategic goal alignment, resource allocation, priority setting
- **Format:** 90-minute strategic review

## Success Metrics

### Coordination Effectiveness
- **Dependency Success Rate:** >95% of dependencies delivered on time
- **Communication Satisfaction:** >90% satisfaction with cross-company communication
- **Conflict Resolution Time:** <48 hours for critical conflicts
- **Resource Utilization:** >85% efficient use of shared resources

### Ecosystem Performance
- **Project Success Rate:** >90% of projects delivered on time and budget
- **Cross-Company Synergies:** >30% efficiency improvement from collaboration
- **Innovation Rate:** >25% increase in innovation through cross-company collaboration
- **Employee Satisfaction:** >85% satisfaction with cross-company collaboration',
  NOW(),
  NOW()
) ON CONFLICT DO NOTHING;

-- CEO Approval Workflows Document
INSERT INTO documents (company_id, title, format, latest_body, created_at, updated_at)
VALUES (
  'f97b30e8-b022-4350-b4b0-30d43e2ebcf4', -- DevForge AI as the "owning" company
  'CEO Approval Workflows for Strategic Goal Changes',
  'markdown',
  '# CEO Approval Workflows for Strategic Goal Changes

## Overview

This document establishes the formal workflows and approval processes for strategic goal changes within the Paperclip AI ecosystem. It ensures that all strategic modifications are properly evaluated, approved, and communicated to maintain ecosystem alignment and stability.

## Strategic Goal Change Categories

### Category 1: Minor Adjustments (Fast Track)
- **Scope:** Minor wording changes, metric adjustments, timeline extensions <30 days
- **Approval Level:** Individual CEO approval
- **Review Time:** <24 hours
- **Examples:** KPI target adjustments, minor timeline shifts, clarification updates

### Category 2: Moderate Changes (Standard Review)
- **Scope:** New sub-goals, resource reallocation <20%, timeline changes 30-90 days
- **Approval Level:** Individual CEO approval with cross-company notification
- **Review Time:** 3-5 business days
- **Examples:** Adding supporting objectives, moderate budget adjustments, partnership additions

### Category 3: Major Changes (Full Review)
- **Scope:** Fundamental goal changes, budget changes >20%, strategic pivot, new market entry
- **Approval Level:** Individual CEO + Board of Directors approval
- **Review Time:** 7-14 business days
- **Examples:** Complete goal restructuring, major strategic shifts, significant resource changes

### Category 4: Ecosystem Impact (Board Review)
- **Scope:** Changes affecting multiple companies, ecosystem architecture changes
- **Approval Level:** All affected CEOs + Board of Directors
- **Review Time:** 14-21 business days
- **Examples:** Cross-company goal dependencies, shared resource changes, ecosystem restructuring

## Goal Change Proposal Process

### Step 1: Change Identification and Initial Assessment
**Responsible:** Company CEO or Strategic Planning Lead
**Duration:** 1-2 days
**Deliverables:**
- Change proposal document
- Impact assessment
- Category classification
- Initial stakeholder identification

### Step 2: Internal Company Review
**Responsible:** Company leadership team
**Duration:** 1-3 days (depending on category)
**Participants:**
- CEO
- Key executives
- Department heads
- Project leads affected by change

### Step 3: Cross-Company Impact Assessment
**Responsible:** CEO with support from affected companies
**Duration:** 1-5 days (depending on category)
**Participants:**
- CEOs of affected companies
- Cross-company coordination team
- Technical leads for integration points

### Step 4: Formal Approval Process
**Responsible:** Designated approvers based on category
**Duration:** 1-14 days (depending on category)

## Approval Decision Framework

### Approval Criteria
1. **Strategic Alignment:** Change supports company mission and ecosystem goals
2. **Business Case:** Clear benefits outweigh costs and risks
3. **Feasibility:** Technical and operational feasibility demonstrated
4. **Resource Availability:** Required resources available or obtainable
5. **Risk Management:** Acceptable risk level with mitigation strategies
6. **Stakeholder Impact:** Negative impacts minimized and communicated

### Conditional Approval
- **Modifications Required:** Change approved with specified modifications
- **Pilot Implementation:** Change approved for limited pilot before full rollout
- **Phased Implementation:** Change approved with phased rollout plan
- **Monitoring Requirements:** Change approved with enhanced monitoring requirements

## Communication and Documentation

### Internal Communication
- **Proposal Submission:** Notification to company leadership
- **Approval Status:** Regular updates on approval progress
- **Final Decision:** Communication of approval/rejection with rationale
- **Implementation:** Communication of implementation plan and timeline

### Cross-Company Communication
- **Dependency Notification:** Notification to affected companies
- **Coordination Requirements:** Communication of required coordination
- **Implementation Impact:** Communication of implementation impacts
- **Status Updates:** Regular updates on implementation progress

## Escalation and Appeals Process

### Escalation Process
1. **Level 1:** Company CEO reconsideration (for Category 1-2)
2. **Level 2:** Cross-company CEO mediation (for Category 2-3)
3. **Level 3:** Board of Directors appeal (for all categories)
4. **Level 4:** External arbitration (for Category 4 only)

### Appeal Criteria
- **New Information:** Significant new information not available during initial review
- **Process Violation:** Original approval process not followed correctly
- **Changed Circumstances:** Significant changes in business environment
- **Implementation Issues:** Unforeseen implementation challenges

## Success Metrics

### Process Effectiveness
- **Approval Timeline Compliance:** >90% of approvals within target timeline
- **Stakeholder Satisfaction:** >85% satisfaction with approval process
- **Implementation Success:** >95% of approved changes successfully implemented
- **Appeal Rate:** <5% of decisions appealed

### Strategic Alignment
- **Goal Achievement:** >90% of approved changes contribute to goal achievement
- **Ecosystem Impact:** Positive ecosystem impact from approved changes
- **Risk Management:** <2% of approved changes result in major issues
- **Value Creation:** Measurable value creation from strategic changes

## Emergency Change Process

### Emergency Criteria
- **Critical Business Impact:** Immediate threat to business operations
- **Security Threat:** Immediate security or compliance risk
- **Legal Requirement:** Immediate legal or regulatory requirement
- **Market Opportunity:** Time-sensitive market opportunity

### Emergency Process
1. **Emergency Declaration:** CEO declaration with justification
2. **Immediate Implementation:** Implementation with documentation
3. **Post-Implementation Review:** Formal review within 48 hours
4. **Regular Approval Process:** Retroactive completion of regular approval process',
  NOW(),
  NOW()
) ON CONFLICT DO NOTHING;

-- =============================================================================
-- VERIFICATION QUERIES
-- =============================================================================

-- Verify data was loaded correctly
SELECT 'Goals Count' as metric, COUNT(*) as value FROM goals WHERE status = 'active'
UNION ALL
SELECT 'Projects Count', COUNT(*) FROM projects WHERE status = 'planning'
UNION ALL
SELECT 'Issues Count', COUNT(*) FROM issues WHERE status = 'open'
UNION ALL
SELECT 'Documents Count', COUNT(*) FROM documents WHERE title LIKE '%Framework%' OR title LIKE '%Approval%';

-- Show company-goal relationships
SELECT
  c.name as company,
  g.title as goal,
  p.name as project,
  i.title as issue
FROM companies c
LEFT JOIN goals g ON c.id = g.company_id AND g.status = 'active'
LEFT JOIN projects p ON c.id = p.company_id AND p.status = 'planning'
LEFT JOIN issues i ON c.id = i.company_id AND i.status = 'open'
ORDER BY c.name;