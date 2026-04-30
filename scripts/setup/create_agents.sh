#!/bin/bash

# DomainForge AI Company ID
DOMAINFORGE_ID="2d7d9c60-c02f-42a7-8f6a-7db86ecc879d"
ORION_ID="91223cfa-cf03-4f71-a5b0-c6afa1b02ac5"

# InfraForge AI Company ID
INFRAFORGE_ID="09f438a3-4041-46f2-b3cc-96fc9446e666"

# Function to create agent
create_agent() {
    local company_id=$1
    local name=$2
    local role=$3
    local title=$4
    local reports_to=$5
    local capabilities=$6

    curl -s -X POST http://127.0.0.1:3100/api/companies/$company_id/agents \
         -H "Content-Type: application/json" \
         -d "{\"name\": \"$name\", \"role\": \"$role\", \"title\": \"$title\", \"reportsTo\": \"$reports_to\", \"capabilities\": \"$capabilities\"}" | jq -r '.name + " created"'
}

echo "Creating remaining DomainForge AI agents..."

# Engineering agents for DomainForge
create_agent "$DOMAINFORGE_ID" "Water Resources" "engineer" "Water Resources Engineering Specialist" "$ORION_ID" "Water supply, wastewater, and hydraulic engineering. Handles water distribution and wastewater collection system design, hydraulic analysis and pump station design, stormwater management, and water treatment facility design."

create_agent "$DOMAINFORGE_ID" "Environmental" "engineer" "Environmental Engineering Specialist" "$ORION_ID" "Environmental impact assessment and sustainable engineering. Handles environmental impact assessment and mitigation planning, sustainable design and green infrastructure development, air and water quality analysis, and environmental permitting."

create_agent "$DOMAINFORGE_ID" "Surveying" "engineer" "Surveying and Geomatics Specialist" "$ORION_ID" "Land surveying, mapping, and geospatial analysis. Handles land surveying and boundary determination, topographic mapping and GIS analysis, construction staking and layout coordination, and geodetic control."

create_agent "$DOMAINFORGE_ID" "Construction" "engineer" "Construction Engineering Specialist" "$ORION_ID" "Construction methods, sequencing, and project management. Handles construction sequencing and methodology development, project scheduling and critical path analysis, construction safety planning, and quality assurance."

create_agent "$DOMAINFORGE_ID" "Project" "pm" "Project Management Specialist" "$ORION_ID" "Civil engineering project management and coordination. Handles project planning and scope definition, cost estimation and budget management, stakeholder communication, and risk management."

create_agent "$DOMAINFORGE_ID" "Procurement" "general" "Procurement and Contracts Specialist" "$ORION_ID" "Procurement management and contract administration. Handles procurement planning and strategy development, contract preparation and administration, vendor qualification, and subcontractor management."

create_agent "$DOMAINFORGE_ID" "Safety" "general" "Safety and Risk Management Specialist" "$ORION_ID" "Construction safety, occupational health, and risk management. Handles construction safety planning and procedures development, occupational health and hazard assessment, safety training, and incident investigation."

create_agent "$DOMAINFORGE_ID" "Legal" "general" "Legal and Regulatory Compliance Specialist" "$ORION_ID" "Legal compliance, permitting, and regulatory affairs. Handles regulatory compliance and permitting coordination, legal contract review and analysis, environmental compliance monitoring, and right-of-way acquisition."

echo "Creating InfraForge AI agents..."

# InfraForge agents
create_agent "$INFRAFORGE_ID" "Orchestrator" "ceo" "Infrastructure Orchestration Specialist" "" "Central orchestration of infrastructure services and system integration. Oversees infrastructure service orchestration and coordination, system integration and API management, service dependency management, and infrastructure performance optimization."

create_agent "$INFRAFORGE_ID" "Database" "engineer" "Database Infrastructure Specialist" "orchestrator_id_here" "Database design, optimization, and management for engineering data. Handles database architecture and schema design, performance optimization and query tuning, data backup and recovery, and database security."

create_agent "$INFRAFORGE_ID" "Compute" "engineer" "Compute Infrastructure Specialist" "orchestrator_id_here" "Compute resources management and optimization for engineering workloads. Handles compute resource provisioning and scaling, container orchestration, serverless computing, and compute cost optimization."

create_agent "$INFRAFORGE_ID" "Networking" "engineer" "Network Infrastructure Specialist" "orchestrator_id_here" "Network design, security, and performance optimization. Handles network architecture and design, network security and firewall management, load balancing, and network monitoring."

create_agent "$INFRAFORGE_ID" "Storage" "engineer" "Storage Infrastructure Specialist" "orchestrator_id_here" "Data storage solutions and management for engineering data. Handles storage architecture and capacity planning, data backup and disaster recovery, file system management, and storage security."

create_agent "$INFRAFORGE_ID" "Security" "engineer" "Infrastructure Security Specialist" "orchestrator_id_here" "Infrastructure security, compliance, and threat protection. Handles infrastructure security architecture and threat detection, incident response and automated remediation, compliance monitoring, and security auditing."

create_agent "$INFRAFORGE_ID" "Monitoring" "engineer" "Infrastructure Monitoring Specialist" "orchestrator_id_here" "System monitoring, alerting, and performance analytics. Handles system monitoring and alerting setup, performance metrics collection and analysis, log aggregation and analysis, and capacity planning."

create_agent "$INFRAFORGE_ID" "Automation" "devops" "Infrastructure Automation Specialist" "orchestrator_id_here" "Infrastructure automation, DevOps, and configuration management. Handles infrastructure as Code implementation, configuration management and automation, CI/CD pipeline development, and automated deployment."

echo "All agents created!"