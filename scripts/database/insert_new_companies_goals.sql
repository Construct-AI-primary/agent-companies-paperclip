-- Paperclip New Companies Goals Loading Script
-- Run this SQL script to load goals for 7 companies into Supabase
-- Uses SELECT-based inserts to only insert if company exists (safe for partial setup)
-- Execute this AFTER the companies have been created

-- =============================================================================
-- PRE-FLIGHT CHECK: Verify companies exist
-- Note: The companies table uses 'name' column, not 'slug'
-- =============================================================================

SELECT '=== Pre-Flight Check: Companies ===' as status;
SELECT id, name, issue_prefix, status FROM companies 
WHERE name IN ('ContentForge AI', 'ExecForge AI', 'LearningForge AI', 'MobileForge AI', 'PaperclipForge AI', 'SaaSForge AI', 'VoiceForge AI')
ORDER BY name;

-- =============================================================================
-- GOALS INSERTION FOR NEW COMPANIES
-- Using SELECT-based inserts to ensure company exists first
-- Note: The companies table uses 'name' column for identification
-- =============================================================================

-- ContentForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Revolutionize Content Creation and Website Management through Intelligent Automation',
'ContentForge AI provides AI-powered automated content creation, SEO optimization, and website performance management. Our mission is to deliver high-quality, SEO-optimized content at scale while ensuring optimal website performance and superior search engine visibility through intelligent automation.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'ContentForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Deliver Automated Content Generation and Multi-Format Content Support',
'Provide automated blog generation with SEO optimization, intelligent content scheduling, multi-format content support (blogs, articles, social media, email), and dynamic content personalization based on audience segments.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'ContentForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve Top 10 Rankings for 80% of Target Keywords with 150%+ Organic Traffic Growth',
'Deliver comprehensive SEO services including advanced keyword research, on-page SEO automation, technical SEO optimization, and intelligent link building to achieve top 10 rankings for 80% of target keywords and 150%+ year-over-year organic traffic increase.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'ContentForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve 90%+ Core Web Vitals Compliance and <2 Second Page Load Times',
'Ensure 90%+ of pages meet Core Web Vitals "Good" thresholds, maintain <2 second average page load times, achieve 95%+ mobile usability scores, and deliver 30%+ improvement in conversion rates through performance optimization.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'ContentForge AI' ON CONFLICT DO NOTHING;

-- ExecForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Revolutionize Executive Productivity through AI-Powered Personal Assistants',
'ExecForge AI provides intelligent executive assistants that seamlessly integrate with Paperclip communication and task management systems. Our mission is to enhance productivity, streamline workflows, and provide comprehensive executive support through deep AI-powered integration.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'ExecForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Deliver 40%+ Reduction in Administrative Tasks with 50%+ Meeting Productivity Improvement',
'Provide intelligent scheduling, automated email processing, intelligent task orchestration, and dynamic priority management to achieve 40%+ reduction in administrative tasks and 50%+ improvement in meeting productivity.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'ExecForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve 300%+ ROI on Executive Productivity Investments',
'Deliver workflow optimization, data-driven decision support, executive knowledge management, and productivity analytics to achieve 300%+ ROI on executive productivity investments with 4.8/5.0 executive satisfaction.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'ExecForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable Seamless Cross-Agent Task Coordination and Orchestration',
'Provide seamless message integration with Paperclip, automated status reporting, cross-agent task coordination, and a comprehensive executive dashboard for unified control and monitoring across the Paperclip ecosystem.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'ExecForge AI' ON CONFLICT DO NOTHING;

-- LearningForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Continuously Improve Learning from User Interactions and Domain Knowledge',
'LearningForge AI focuses on analyzing user interactions with construction-domain applications, tracking domain knowledge (legal precedents, safety standards, material innovations), and implementing automated research using AutoResearch for skills enhancement.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'LearningForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Manage Standardized Workflows Across 50+ Construction Disciplines',
'Implement comprehensive workflows for 50+ construction disciplines including legal, safety, procurement, engineering, and project management, ensuring knowledge transfer from field findings to learning content.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'LearningForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Implement Automated Research Using AutoResearch for Skills Enhancement',
'Integrate Karpathy AutoResearch for automated skills enhancement, enabling continuous learning and improvement of AI agent capabilities through systematic research and knowledge discovery.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'LearningForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable Knowledge Flow from Field Findings to Learning Content',
'Establish comprehensive knowledge flow systems that capture field findings, safety observations, and material innovations, transforming them into actionable learning content for continuous improvement.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'LearningForge AI' ON CONFLICT DO NOTHING;

-- MobileForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Orchestrate and Optimize the Complete Mobile Device Lifecycle',
'MobileForge AI provides comprehensive mobile device lifecycle management from development and deployment to management and security, ensuring seamless mobile experiences across all platforms and devices.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'MobileForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve <0.1% Crash Rate with <2s Cold Start Time',
'Deliver high-performance mobile applications with <0.1% crash rate across all platforms, <2 second cold start time, <100ms API response, and maintain 4.5+ app store rating.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'MobileForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Ensure 99.9% Device Availability with Zero Security Breaches',
'Provide comprehensive device management with 99.9% device availability, zero security breaches, <1% devices with performance degradation, and 95% successful OS/app update rate.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'MobileForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Deliver 30% Faster Mobile Development with 40% Cost Reduction',
'Enable rapid mobile application development with 30% faster development cycles, 40% reduction in mobile development costs, 90% user satisfaction scores, and 95% platform coverage.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'MobileForge AI' ON CONFLICT DO NOTHING;

-- PaperclipForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Revolutionize Project Management and Issue Orchestration through Intelligent Automation',
'PaperclipForge AI serves as the operational backbone of the Paperclip ecosystem, specializing in intelligent project management, issue orchestration, workflow automation, and seamless integration between all Paperclip companies.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'PaperclipForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve 95%+ Project Success Rate with 60% Reduction in Issue Resolution Time',
'Deliver end-to-end project lifecycle automation, intelligent resource allocation, proactive risk management, and comprehensive performance analytics to achieve 95%+ project success rate and 60% reduction in issue resolution time.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'PaperclipForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Generate Issues with 90%+ Relevance Accuracy and Enable 90%+ Process Automation',
'Provide AI-powered issue generation, smart agent assignment based on expertise, complex dependency tracking, and real-time progress monitoring to generate issues with 90%+ relevance accuracy.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'PaperclipForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable Seamless Cross-Company Coordination with 99.9%+ System Integration Uptime',
'Coordinate seamlessly between Paperclip companies, manage comprehensive API integration, implement continuous workflow optimization, and maintain 99.9%+ system integration uptime across the Paperclip ecosystem.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'PaperclipForge AI' ON CONFLICT DO NOTHING;

-- SaaSForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Revolutionize Customer Onboarding and SaaS Operations through Intelligent Automation',
'SaaSForge AI provides automated customer onboarding, multi-tenant SaaS operations, and customer lifecycle management. Our mission is to ensure seamless, secure, and scalable customer experiences from initial signup to full platform utilization.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'SaaSForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve >90% Onboarding Automation with <5 Minute Tenant Provisioning',
'Deliver automated tenant provisioning, API configuration, database initialization, and user account creation to achieve >90% onboarding automation with <5 minute average provisioning time.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'SaaSForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Maintain 99.9% Platform Uptime with Complete Tenant Isolation',
'Provide complete data and resource isolation between customers, auto-scaling infrastructure, efficient resource optimization, and real-time performance monitoring to maintain 99.9% uptime.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'SaaSForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve NPS >70 with >95% Customer Retention and <24 Hour Time to Value',
'Deliver guided customer onboarding, automated subscription management, usage analytics, and support integration to achieve NPS >70, >95% retention, and <24 hour time to value.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'SaaSForge AI' ON CONFLICT DO NOTHING;

-- VoiceForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Democratize Voice AI Technology with Enterprise-Grade Speech Processing',
'VoiceForge AI provides advanced voice capabilities for natural, conversational interactions across all platforms. Our mission is to make human-AI communication as natural and intuitive as human-human conversation through enterprise-grade speech processing.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'VoiceForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve <3% Word Error Rate with <300ms End-to-End Latency',
'Deliver high-accuracy speech recognition supporting 50+ languages, real-time processing with low latency, advanced noise cancellation, and accent adaptation to achieve <3% WER.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'VoiceForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve >95% Intent Recognition Accuracy with Natural, Human-Like Conversations',
'Provide natural language understanding, context awareness, advanced intent recognition, and customizable AI personality to achieve >95% intent accuracy and >4.8/5.0 user satisfaction.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'VoiceForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable Full Multimodal AI with Voice, Vision, and Gesture Integration',
'Integrate voice with computer vision, gesture recognition, and emotion detection to deliver comprehensive multimodal AI experiences with cross-modal fusion capabilities.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'VoiceForge AI' ON CONFLICT DO NOTHING;

-- =============================================================================
-- VERIFICATION QUERIES
-- =============================================================================

SELECT '=== Verification: New Companies Goals Summary ===' as status;
SELECT c.name as company, c.issue_prefix, COUNT(g.id) as goal_count
FROM companies c
LEFT JOIN goals g ON c.id = g.company_id AND g.status = 'active'
WHERE c.name IN ('ContentForge AI', 'ExecForge AI', 'LearningForge AI', 'MobileForge AI', 'PaperclipForge AI', 'SaaSForge AI', 'VoiceForge AI')
GROUP BY c.name, c.issue_prefix
ORDER BY c.name;

SELECT '=== Verification: All Goals by Company ===' as status;
SELECT c.name as company, g.level, g.title, g.status, g.created_at
FROM companies c
JOIN goals g ON c.id = g.company_id AND g.status = 'active'
WHERE c.name IN ('ContentForge AI', 'ExecForge AI', 'LearningForge AI', 'MobileForge AI', 'PaperclipForge AI', 'SaaSForge AI', 'VoiceForge AI')
ORDER BY c.name, g.level, g.title;
