-- SQL script to log creation activity for the Paperclip Setup Specialist agent

INSERT INTO activity_logs (event_type, details, created_at) VALUES
('agent_creation', 'Created paperclip-setup-infraforge-specialist agent in InfraForge AI.', NOW());