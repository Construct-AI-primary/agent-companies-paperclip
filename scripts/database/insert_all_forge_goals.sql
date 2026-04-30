-- Comprehensive SQL to add goals for ALL Forge companies
-- Each company gets 4 goals: 1 company-level and 3 team-level

-- ContentForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable Efficient Content Generation at Scale for Construction Industry',
'ContentForge AI specializes in AI-powered content generation for the construction industry, creating technical documentation, project specifications, safety guidelines, and compliance documentation at scale.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'ContentForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Generate Technical Documentation with 95%+ Accuracy',
'Implement AI-powered technical documentation generation with 95%+ accuracy, covering construction specifications, material specifications, and engineering standards.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'ContentForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Automate Safety Guidelines and Compliance Documentation',
'Create comprehensive safety guidelines and compliance documentation automatically, ensuring regulatory adherence and reducing manual documentation workload.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'ContentForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Integrate with DevForge AI and PaperclipForge AI for Seamless Workflow',
'Enable seamless integration with DevForge AI for development content and PaperclipForge AI for project management, creating a unified content ecosystem.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'ContentForge AI' ON CONFLICT DO NOTHING;

-- DevForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Deliver High-Quality Software Development Across Paperclip Ecosystem',
'DevForge AI serves as the primary development company in the Paperclip ecosystem, delivering high-quality software development, code generation, and technical architecture across all companies.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'DevForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve 95%+ Code Quality and 80%+ Test Coverage',
'Maintain 95%+ code quality standards and 80%+ test coverage across all projects, ensuring reliable and maintainable software delivery.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'DevForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Reduce Development Cycle Time by 50% with AI-Assisted Development',
'Implement AI-assisted development tools and practices to reduce development cycle time by 50% while maintaining high quality standards.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'DevForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable Cross-Company Development Collaboration',
'Facilitate seamless development collaboration across all Paperclip companies, ensuring consistent coding standards and shared best practices.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'DevForge AI' ON CONFLICT DO NOTHING;

-- DomainForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Build Engineering Platform Across 50+ Construction Disciplines',
'DomainForge AI delivers the Engineering Platform managing workflows across 50+ construction disciplines, from legal and procurement to engineering and project management.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'DomainForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Manage Standardized Workflows Across All Construction Disciplines',
'Implement comprehensive workflow management across all construction disciplines, ensuring consistency and best practices across legal, safety, procurement, and engineering domains.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'DomainForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable Knowledge Flow from Field Findings to Domain Expertise',
'Establish systems for capturing field findings, safety observations, and material innovations, transforming them into actionable domain expertise.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'DomainForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Integrate with PaperclipForge AI for Project Orchestration',
'Provide seamless integration with PaperclipForge AI for project orchestration, ensuring domain expertise flows into project planning and execution.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'DomainForge AI' ON CONFLICT DO NOTHING;

-- ExecForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Deliver Executive Decision Support and Strategic Planning Solutions',
'ExecForge AI specializes in executive decision support, strategic planning, and board-level governance solutions for construction industry organizations.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'ExecForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable 50%+ Reduction in Executive Decision Time',
'Provide AI-powered decision support that reduces executive decision time by 50% through automated analysis and scenario planning.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'ExecForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve 95%+ Strategic Alignment Across Organizations',
'Ensure 95%+ strategic alignment across all organizational levels through comprehensive governance frameworks and decision tracking.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'ExecForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Integrate with All Paperclip Companies for Holistic Executive View',
'Provide comprehensive integration with all Paperclip companies, delivering a holistic executive view of operations, projects, and performance.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'ExecForge AI' ON CONFLICT DO NOTHING;

-- InfraForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Provide World-Class Infrastructure for Paperclip Ecosystem',
'InfraForge AI delivers world-class infrastructure services including database management, cloud infrastructure, and technical operations for the entire Paperclip ecosystem.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'InfraForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Maintain 99.99%+ Infrastructure Uptime Across All Services',
'Ensure 99.99%+ uptime across all infrastructure services, implementing robust monitoring, failover, and disaster recovery solutions.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'InfraForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Reduce Infrastructure Costs by 40% Through Optimization',
'Achieve 40% infrastructure cost reduction through cloud optimization, resource right-sizing, and automated scaling.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'InfraForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable Zero-Trust Security Across All Systems',
'Implement zero-trust security architecture across all Paperclip systems, ensuring comprehensive protection and compliance.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'InfraForge AI' ON CONFLICT DO NOTHING;

-- KnowledgeForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Build Centralized Knowledge Management for Paperclip Ecosystem',
'KnowledgeForge AI provides centralized knowledge management, documentation, and information architecture for the entire Paperclip ecosystem.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'KnowledgeForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve 90%+ Knowledge Retrieval Accuracy',
'Implement AI-powered knowledge retrieval achieving 90%+ accuracy, enabling fast and reliable access to organizational knowledge.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'KnowledgeForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable Seamless Knowledge Flow Across All Companies',
'Facilitate seamless knowledge flow across all Paperclip companies, breaking down information silos and enabling collaborative learning.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'KnowledgeForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Maintain 99%+ Documentation Quality Standards',
'Ensure 99%+ documentation quality across all knowledge assets, implementing comprehensive review and quality assurance processes.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'KnowledgeForge AI' ON CONFLICT DO NOTHING;

-- MobileForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Deliver Mobile-First Solutions for Construction Industry',
'MobileForge AI specializes in mobile-first solutions for the construction industry, providing field-ready applications and real-time data access.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'MobileForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve 90%+ Field Worker Adoption Rate',
'Drive 90%+ adoption rate among field workers through intuitive mobile interfaces and offline-first capabilities.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'MobileForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable Real-Time Data Sync with 99%+ Reliability',
'Implement real-time data synchronization with 99%+ reliability, ensuring field data is always up-to-date with central systems.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'MobileForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Reduce Field Data Entry Time by 60%',
'Achieve 60% reduction in field data entry time through voice input, photo capture, and intelligent form automation.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'MobileForge AI' ON CONFLICT DO NOTHING;

-- PromptForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Optimize AI Agent Performance Through Advanced Prompt Engineering',
'PromptForge AI specializes in AI agent prompt optimization, fine-tuning, and performance enhancement for the entire Paperclip ecosystem.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'PromptForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve 40%+ Token Cost Reduction Without Quality Loss',
'Implement prompt optimization strategies achieving 40%+ token cost reduction while maintaining or improving output quality.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'PromptForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable 80%+ Agent Task Success Rate',
'Optimize prompts to achieve 80%+ task success rate across all AI agents, ensuring reliable and consistent performance.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'PromptForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Provide Prompt Templates for All Paperclip Agent Types',
'Create and maintain a comprehensive library of prompt templates covering all Paperclip agent types and use cases.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'PromptForge AI' ON CONFLICT DO NOTHING;

-- QualityForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Ensure Quality Standards Across Paperclip Ecosystem',
'QualityForge AI provides comprehensive quality assurance, testing, and validation services across the entire Paperclip ecosystem.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'QualityForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve 95%+ Test Coverage Across All Projects',
'Implement comprehensive testing strategies achieving 95%+ code coverage and thorough validation across all Paperclip projects.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'QualityForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Reduce Bug Escape Rate to <1%',
'Achieve less than 1% bug escape rate through comprehensive testing, automated quality gates, and continuous validation.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'QualityForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable 99%+ Security Compliance Across All Systems',
'Ensure 99%+ security compliance across all systems through automated security scanning, penetration testing, and compliance validation.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'QualityForge AI' ON CONFLICT DO NOTHING;

-- SaaSForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Deliver Scalable SaaS Solutions for Construction Industry',
'SaaSForge AI specializes in cloud-native SaaS solutions for the construction industry, providing scalable, reliable, and secure software delivery.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'SaaSForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve 99.95%+ Service Availability',
'Deliver 99.95%+ service availability across all SaaS offerings through robust infrastructure, automated failover, and proactive monitoring.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'SaaSForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable 10x Faster Onboarding for New Customers',
'Implement streamlined onboarding processes achieving 10x faster time-to-value for new customers.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'SaaSForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Reduce Customer Churn to <5% Annually',
'Achieve less than 5% annual customer churn through exceptional service quality, proactive support, and continuous value delivery.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'SaaSForge AI' ON CONFLICT DO NOTHING;

-- VoiceForge AI Goals
INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable Voice-First Interactions for Construction Operations',
'VoiceForge AI specializes in voice-first solutions for construction operations, enabling hands-free interaction for field workers and project managers.',
'company', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'VoiceForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Achieve 95%+ Voice Recognition Accuracy in Noisy Environments',
'Implement advanced voice recognition achieving 95%+ accuracy even in challenging construction site environments with high background noise.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'VoiceForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Enable 70%+ Reduction in Manual Data Entry',
'Drive 70%+ reduction in manual data entry through voice-to-text automation and intelligent voice commands.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'VoiceForge AI' ON CONFLICT DO NOTHING;

INSERT INTO goals (company_id, title, description, level, status, created_at, updated_at)
SELECT c.id, 'Integrate with MobileForge AI for Comprehensive Field Solutions',
'Provide seamless integration with MobileForge AI for comprehensive mobile and voice solutions across construction operations.',
'team', 'active', NOW(), NOW()
FROM companies c WHERE c.name = 'VoiceForge AI' ON CONFLICT DO NOTHING;

-- Verification
SELECT '=== Final Verification: All Companies Goal Counts ===' as status;
SELECT c.name as company, COUNT(g.id) as goal_count
FROM companies c
LEFT JOIN goals g ON c.id = g.company_id AND g.status = 'active'
GROUP BY c.name
ORDER BY c.name;
