---
memory_layer: durable_knowledge
para_section: pages/codebase/other-apps
gigabrain_tags: other-apps, codebase, integrations
documentation
openstinger_context: other-apps-practices
last_updated: 2026-03-21
related_docs:
  - codebase/other-apps/
  - disciplines/
---
# Nanobot Implementation Plan for Bulk Email Campaigns

## Overview
Implement Nanobot (HKU's open-source AI personal assistant) as a submodule to handle bulk organizational email sending (>1000 emails) across all ConstructAI disciplines. This adaptable system supports procurement, contracts, HR, safety, construction, and other departments with form issuance and personalized communications. The lightweight alternative provides 90-99% of OpenClaw's functionality in 4,000 lines of Python code.

## Implementation Status

**Last Updated**: March 17, 2026, 7:00 AM (Africa/Johannesburg, UTC+2:00)

### Overall Progress: 🟢 Database Implementation Complete - Separate Tables Created

| Phase | Status | Progress | Notes |
|-------|--------|----------|-------|
| **Phase 1: Setup and Integration** | 🟢 Partially Complete | 67% | Submodule added ✅, SQL schema created ✅, email config pending |
| **Phase 2: Supabase Database Enhancement** | 🟢 Complete | 100% | All schemas designed and implemented ✅, separate tables created ✅ |
| **Phase 3: Email Campaign Management** | 🟡 Not Started | 0% | Template system and orchestration pending |
| **Phase 4: Testing and Deployment** | 🟡 Not Started | 0% | Standards compliance framework ready |
| **Phase 5: Maintenance and Contribution** | 🟡 Not Started | 0% | Monitoring and analytics framework defined |

### Component Status

#### Database Schema Components
| Component | Status | Details |
|-----------|--------|---------|
| Email Campaign Tables | ✅ Designed | 10 tables with full schema definitions |
| HITL Response System | ✅ Designed | Version control, approvals, audit trail |
| Procurement Categories (4-level) | ✅ Designed | Enhanced hierarchy with Level 4 goods descriptions |
| Supplier Goods Selections | ✅ Designed | Extended with category links and specifications |
| Form Attachments System | ✅ Designed | Version control and storage management |
| Access Token Management | ✅ Designed | Secure JWT-based token system |

#### Frontend Components
| Component | Status | Details |
|-----------|--------|---------|
| Dynamic Form Renderer | ✅ Designed | Multi-field types, conditional logic, validation |
| Supplier Goods Selection Form | ✅ Designed | Checkbox selection, filtering, comments, attachments |
| HITL Response Dashboard | ✅ Designed | Verification, editing, approval workflow |
| Audit Trail Viewer | ✅ Designed | Version history and change tracking |
| File Upload Components | ✅ Designed | Drag & drop, progress indicators, validation |

#### Backend Components
| Component | Status | Details |
|-----------|--------|---------|
| Multi-Disciplinary Tool | ✅ Designed | Dynamic recipient table mapping |
| Governance Integration | ✅ Designed | `@with_governance` decorator compliance |
| Access Token Generation | ✅ Designed | JWT-based secure token system |
| Email Template System | ✅ Designed | Discipline-specific templates with HITL integration |

### Key Design Decisions Implemented

1. **4-Level Procurement Hierarchy**: Extended from 3 to 4 levels to support detailed goods descriptions
2. **Comprehensive HITL System**: Full response management with version control and audit trails
3. **Customizable Form Interface**: Dynamic rendering with document attachment capabilities
4. **Supplier Goods Selection**: Checkbox-based selection with filtering and justification fields
5. **Standards Compliance**: Full integration with ConstructAI coding and naming standards
6. **Organized SQL Schema**: Database tables organized into logical phases with separate SQL files for easy deployment and maintenance

### SQL File Organization

The database schema has been organized into separate SQL files by implementation phase, located in `/Users/_General/Mar-16-1/sql/email-other-parties/`:

```
sql/email-other-parties/
├── nanobot_complete_schema.sql          # Complete combined schema (recommended)
├── phase_1_existing_enhancements/
│   └── enhance_procurement_categories.sql
├── phase_2_email_templates/
│   └── create_email_templates.sql
├── phase_3_email_campaigns/
│   └── create_email_campaign_tables.sql
├── phase_4_access_tokens/
│   └── create_access_token_tables.sql
├── phase_5_hitl_responses/
│   └── create_hitl_response_tables.sql
├── phase_6_supplier_form_responses/
│   └── create_supplier_form_response_tables.sql
├── phase_7_form_attachments/
│   └── create_form_attachment_tables.sql
└── phase_8_existing_enhancements/
    └── enhance_existing_tables.sql
```

**Recommended Deployment**: Use `nanobot_complete_schema.sql` for a single comprehensive deployment.

**Alternative Deployment**: Execute individual phase files in order (1-8) to respect foreign key dependencies. Each phase is self-contained and can be deployed independently once previous phases are complete.

### Next Steps for Implementation

1. **Immediate Actions**:
   - [ ] Fork and add Nanobot submodule
   - [ ] Configure email platform (SMTP/IMAP)
   - [ ] Create Supabase tables in order of dependencies (see SQL script below)
   - [ ] Implement multi-disciplinary tool with governance integration

## Phase 3: Email Campaign Management Development

### 3.1 Contractor and Consultant Service Categorization

#### Contractor Categories Table
Following the procurement_categories structure, create a hierarchical categorization system for contractor services:

```sql
-- Contractor service categories (similar to procurement_categories)
CREATE TABLE contractor_categories (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  parent_id uuid NULL,
  hierarchy_level integer NOT NULL CHECK (hierarchy_level IN (1, 2, 3, 4)),
  code character varying(10) NOT NULL,
  name character varying(255) NOT NULL,
  name_fr character varying(255) NULL,
  description text NULL,
  requires_sow boolean NULL DEFAULT false,
  requires_cdc boolean NULL DEFAULT false,
  display_order integer NULL DEFAULT 0,
  is_active boolean NULL DEFAULT true,
  organization_id uuid NULL,
  created_at timestamp with time zone NULL DEFAULT now(),
  updated_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT contractor_categories_pkey PRIMARY KEY (id),
  CONSTRAINT contractor_categories_parent_id_fkey FOREIGN KEY (parent_id)
    REFERENCES contractor_categories(id) ON DELETE CASCADE,
  CONSTRAINT contractor_categories_hierarchy_check CHECK (
    (hierarchy_level = 1 AND parent_id IS NULL) OR
    (hierarchy_level IN (2, 3, 4) AND parent_id IS NOT NULL)
  ),
  CONSTRAINT contractor_categories_code_key UNIQUE (code, organization_id)
) TABLESPACE pg_default;

-- Indexes for contractor_categories
CREATE INDEX idx_contractor_categories_parent ON contractor_categories(parent_id);
CREATE INDEX idx_contractor_categories_level ON contractor_categories(hierarchy_level);
CREATE INDEX idx_contractor_categories_active ON contractor_categories(is_active);
CREATE INDEX idx_contractor_categories_org ON contractor_categories(organization_id);
```

#### Consultant Categories Table
Create a hierarchical categorization system for consultant expertise:

```sql
-- Consultant expertise categories
CREATE TABLE consultant_categories (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  parent_id uuid NULL,
  hierarchy_level integer NOT NULL CHECK (hierarchy_level IN (1, 2, 3, 4)),
  code character varying(10) NOT NULL,
  name character varying(255) NOT NULL,
  name_fr character varying(255) NULL,
  description text NULL,
  requires_sow boolean NULL DEFAULT false,
  requires_cdc boolean NULL DEFAULT false,
  display_order integer NULL DEFAULT 0,
  is_active boolean NULL DEFAULT true,
  organization_id uuid NULL,
  created_at timestamp with time zone NULL DEFAULT now(),
  updated_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT consultant_categories_pkey PRIMARY KEY (id),
  CONSTRAINT consultant_categories_parent_id_fkey FOREIGN KEY (parent_id)
    REFERENCES consultant_categories(id) ON DELETE CASCADE,
  CONSTRAINT consultant_categories_hierarchy_check CHECK (
    (hierarchy_level = 1 AND parent_id IS NULL) OR
    (hierarchy_level IN (2, 3, 4) AND parent_id IS NOT NULL)
  ),
  CONSTRAINT consultant_categories_code_key UNIQUE (code, organization_id)
) TABLESPACE pg_default;

-- Indexes for consultant_categories
CREATE INDEX idx_consultant_categories_parent ON consultant_categories(parent_id);
CREATE INDEX idx_consultant_categories_level ON consultant_categories(hierarchy_level);
CREATE INDEX idx_consultant_categories_active ON consultant_categories(is_active);
CREATE INDEX idx_consultant_categories_org ON consultant_categories(organization_id);
```

#### Contractor-Company Capability Linking
Link contractors to their service capabilities:

```sql
-- Contractor capabilities (linking contractors to service categories)
CREATE TABLE contractor_capabilities (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  contractor_id uuid NOT NULL,
  category_id uuid NOT NULL,
  approval_status character varying(20) NULL DEFAULT 'pending',
  approved_by uuid NULL,
  approved_at timestamp with time zone NULL,
  capacity_details jsonb NULL DEFAULT '{}'::jsonb,
  geographic_coverage jsonb NULL DEFAULT '[]'::jsonb,
  certifications jsonb NULL DEFAULT '[]'::jsonb,
  experience_years integer NULL,
  project_references jsonb NULL DEFAULT '[]'::jsonb,
  is_primary_capability boolean NULL DEFAULT false,
  created_at timestamp with time zone NULL DEFAULT now(),
  updated_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT contractor_capabilities_pkey PRIMARY KEY (id),
  CONSTRAINT contractor_capabilities_contractor_id_fkey FOREIGN KEY (contractor_id)
    REFERENCES contractors(id) ON DELETE CASCADE,
  CONSTRAINT contractor_capabilities_category_id_fkey FOREIGN KEY (category_id)
    REFERENCES contractor_categories(id) ON DELETE CASCADE,
  CONSTRAINT contractor_capabilities_unique UNIQUE (contractor_id, category_id)
) TABLESPACE pg_default;

-- Indexes for contractor_capabilities
CREATE INDEX idx_contractor_capabilities_contractor ON contractor_capabilities(contractor_id);
CREATE INDEX idx_contractor_capabilities_category ON contractor_capabilities(category_id);
CREATE INDEX idx_contractor_capabilities_approval ON contractor_capabilities(approval_status);
```

#### Consultant-Company Capability Linking
Link consultants to their expertise areas:

```sql
-- Consultant capabilities (linking consultants to expertise categories)
CREATE TABLE consultant_capabilities (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  consultant_id uuid NOT NULL,
  category_id uuid NOT NULL,
  approval_status character varying(20) NULL DEFAULT 'pending',
  approved_by uuid NULL,
  approved_at timestamp with time zone NULL,
  qualifications jsonb NULL DEFAULT '[]'::jsonb,
  certifications jsonb NULL DEFAULT '[]'::jsonb,
  experience_years integer NULL,
  project_references jsonb NULL DEFAULT '[]'::jsonb,
  geographic_coverage jsonb NULL DEFAULT '[]'::jsonb,
  languages jsonb NULL DEFAULT '["English"]'::jsonb,
  is_primary_expertise boolean NULL DEFAULT false,
  created_at timestamp with time zone NULL DEFAULT now(),
  updated_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT consultant_capabilities_pkey PRIMARY KEY (id),
  CONSTRAINT consultant_capabilities_consultant_id_fkey FOREIGN KEY (consultant_id)
    REFERENCES consultants(id) ON DELETE CASCADE,
  CONSTRAINT consultant_capabilities_category_id_fkey FOREIGN KEY (category_id)
    REFERENCES consultant_categories(id) ON DELETE CASCADE,
  CONSTRAINT consultant_capabilities_unique UNIQUE (consultant_id, category_id)
) TABLESPACE pg_default;

-- Indexes for consultant_capabilities
CREATE INDEX idx_consultant_capabilities_consultant ON consultant_capabilities(consultant_id);
CREATE INDEX idx_consultant_capabilities_category ON consultant_capabilities(category_id);
CREATE INDEX idx_consultant_capabilities_approval ON consultant_capabilities(approval_status);
```

### 3.2 Enhanced Recipient Selection by Service Categories

#### Service-Based Contractor Filtering
```javascript
// Enhanced contractor filtering by service categories
const filterContractorsByServices = async (requiredServices, approvalStatus = 'approved') => {
  const contractors = await db
    .from('contractors')
    .select(`
      *,
      contractor_capabilities!inner(
        category_id,
        approval_status,
        capacity_details,
        geographic_coverage,
        certifications
      ),
      contractor_categories!contractor_capabilities(
        id,
        name,
        code,
        hierarchy_level,
        description
      )
    `)
    .eq('contractor_capabilities.approval_status', approvalStatus);

  // Filter contractors that provide required services
  return contractors.filter(contractor => {
    const contractorServices = contractor.contractor_capabilities.map(cap => cap.category_id);
    return requiredServices.some(serviceId => contractorServices.includes(serviceId));
  });
};
```

#### Expertise-Based Consultant Filtering
```javascript
// Enhanced consultant filtering by expertise categories
const filterConsultantsByExpertise = async (requiredExpertise, approvalStatus = 'approved') => {
  const consultants = await db
    .from('consultants')
    .select(`
      *,
      consultant_capabilities!inner(
        category_id,
        approval_status,
        qualifications,
        certifications,
        experience_years,
        languages
      ),
      consultant_categories!consultant_capabilities(
        id,
        name,
        code,
        hierarchy_level,
        description
      )
    `)
    .eq('consultant_capabilities.approval_status', approvalStatus);

  // Filter consultants with required expertise
  return consultants.filter(consultant => {
    const consultantExpertise = consultant.consultant_capabilities.map(cap => cap.category_id);
    return requiredExpertise.some(expertiseId => consultantExpertise.includes(expertiseId));
  });
};
```

### 3.3 Service Category Search Interface

#### Category Browser Component
```jsx
const ServiceCategoryBrowser = ({ partyType, onCategoriesSelected }) => {
  const [categories, setCategories] = useState([]);
  const [selectedCategories, setSelectedCategories] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [expandedNodes, setExpandedNodes] = useState(new Set());

  useEffect(() => {
    loadCategories();
  }, [partyType]);

  const loadCategories = async () => {
    const tableName = partyType === 'contractors' ? 'contractor_categories' : 'consultant_categories';
    const data = await db.from(tableName).select('*').eq('is_active', true).order('hierarchy_level', 'display_order');
    setCategories(buildCategoryTree(data));
  };

  const buildCategoryTree = (flatCategories) => {
    const tree = [];
    const categoryMap = new Map();

    // Create nodes
    flatCategories.forEach(cat => {
      categoryMap.set(cat.id, {
        ...cat,
        children: [],
        providers: 0 // Will be populated with provider counts
      });
    });

    // Build hierarchy
    flatCategories.forEach(cat => {
      if (cat.parent_id) {
        const parent = categoryMap.get(cat.parent_id);
        if (parent) {
          parent.children.push(categoryMap.get(cat.id));
        }
      } else {
        tree.push(categoryMap.get(cat.id));
      }
    });

    return tree;
  };

  const toggleNode = (categoryId) => {
    const newExpanded = new Set(expandedNodes);
    if (newExpanded.has(categoryId)) {
      newExpanded.delete(categoryId);
    } else {
      newExpanded.add(categoryId);
    }
    setExpandedNodes(newExpanded);
  };

  const handleCategorySelect = (category, isSelected) => {
    if (isSelected) {
      setSelectedCategories(prev => [...prev, category]);
    } else {
      setSelectedCategories(prev => prev.filter(c => c.id !== category.id));
    }
  };

  const renderCategoryNode = (category, level = 0) => {
    const isExpanded = expandedNodes.has(category.id);
    const isSelected = selectedCategories.some(c => c.id === category.id);
    const hasChildren = category.children && category.children.length > 0;

    return (
      <CategoryNode key={category.id} level={level}>
        <CategoryHeader onClick={() => hasChildren && toggleNode(category.id)}>
          {hasChildren && (
            <ExpandIcon expanded={isExpanded}>
              {isExpanded ? '▼' : '▶'}
            </ExpandIcon>
          )}
          <CategoryCheckbox
            checked={isSelected}
            onChange={(e) => handleCategorySelect(category, e.target.checked)}
          />
          <CategoryInfo>
            <CategoryCode>{category.code}</CategoryCode>
            <CategoryName>{category.name}</CategoryName>
            {category.providers > 0 && (
              <ProviderCount>({category.providers} providers)</ProviderCount>
            )}
          </CategoryInfo>
        </CategoryHeader>

        {isExpanded && hasChildren && (
          <CategoryChildren>
            {category.children.map(child => renderCategoryNode(child, level + 1))}
          </CategoryChildren>
        )}
      </CategoryNode>
    );
  };

  return (
    <CategoryBrowserContainer>
      <SearchBar
        value={searchTerm}
        onChange={setSearchTerm}
        placeholder={`Search ${partyType} service categories...`}
      />

      <CategoryTree>
        {categories
          .filter(cat => 
            !searchTerm || 
            cat.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
            cat.code.toLowerCase().includes(searchTerm.toLowerCase())
          )
          .map(cat => renderCategoryNode(cat))
        }
      </CategoryTree>

      {selectedCategories.length > 0 && (
        <SelectedCategoriesSummary>
          <h4>Selected Categories ({selectedCategories.length})</h4>
          <SelectedCategoryTags>
            {selectedCategories.map(cat => (
              <CategoryTag key={cat.id}>
                {cat.code}: {cat.name}
                <RemoveButton onClick={() => handleCategorySelect(cat, false)}>×</RemoveButton>
              </CategoryTag>
            ))}
          </SelectedCategoryTags>
          <FindProvidersButton onClick={() => onCategoriesSelected(selectedCategories)}>
            Find {partyType} providing these services
          </FindProvidersButton>
        </SelectedCategoriesSummary>
      )}
    </CategoryBrowserContainer>
  );
};
```

### 3.4 Provider Search and Matching

#### Service-Based Provider Search
```javascript
// Find providers by service categories
const findProvidersByServices = async (categoryIds, partyType, approvalStatus = 'approved') => {
  const capabilityTable = partyType === 'contractors' ? 'contractor_capabilities' : 'consultant_capabilities';
  const partyTable = partyType;
  const categoryTable = partyType === 'contractors' ? 'contractor_categories' : 'consultant_categories';

  const providers = await db
    .from(partyTable)
    .select(`
      *,
      ${capabilityTable}!inner(
        approval_status,
        capacity_details,
        qualifications,
        certifications,
        experience_years,
        geographic_coverage
      ),
      ${categoryTable}!${capabilityTable}(
        id,
        name,
        code,
        hierarchy_level
      )
    `)
    .in(`${capabilityTable}.category_id`, categoryIds)
    .eq(`${capabilityTable}.approval_status`, approvalStatus);

  // Group by provider and aggregate capabilities
  const providerMap = new Map();

  providers.forEach(record => {
    const providerId = record.id;
    if (!providerMap.has(providerId)) {
      providerMap.set(providerId, {
        ...record,
        capabilities: [],
        matchedCategories: new Set()
      });
    }

    const provider = providerMap.get(providerId);
    provider.capabilities.push(record[capabilityTable]);
    provider.matchedCategories.add(record[categoryTable].id);
  });

  return Array.from(providerMap.values()).map(provider => ({
    ...provider,
    matchScore: calculateMatchScore(provider, categoryIds),
    matchedCategoriesCount: provider.matchedCategories.size,
    totalRequestedCategories: categoryIds.length
  }));
};
```

#### Match Score Calculation
```javascript
const calculateMatchScore = (provider, requestedCategoryIds) => {
  const matchedCategories = provider.matchedCategories.size;
  const totalRequested = requestedCategoryIds.length;
  const matchPercentage = (matchedCategories / totalRequested) * 100;

  // Bonus for primary capabilities
  const primaryCapabilities = provider.capabilities.filter(cap => cap.is_primary_capability || cap.is_primary_expertise);
  const primaryBonus = primaryCapabilities.length * 10;

  // Experience bonus
  const experienceBonus = Math.min(provider.capabilities.reduce((sum, cap) => 
    sum + (cap.experience_years || 0), 0) / provider.capabilities.length * 2, 50);

  return Math.min(matchPercentage + primaryBonus + experienceBonus, 100);
};
```

### 3.5 Integration with Campaign Creation

#### Service-Based Campaign Targeting
```jsx
const ServiceBasedCampaignCreation = () => {
  const [selectedPartyType, setSelectedPartyType] = useState('contractors');
  const [selectedServices, setSelectedServices] = useState([]);
  const [matchingProviders, setMatchingProviders] = useState([]);
  const [campaignSettings, setCampaignSettings] = useState({
    approvalStatus: 'approved',
    includeProspective: false,
    geographicFilter: [],
    experienceMinimum: 0
  });

  const handleServiceSelection = async (categories) => {
    setSelectedServices(categories);
    
    // Find matching providers
    const providers = await findProvidersByServices(
      categories.map(c => c.id),
      selectedPartyType,
      campaignSettings.approvalStatus
    );

    // Apply additional filters
    const filteredProviders = providers.filter(provider => {
      // Geographic filter
      if (campaignSettings.geographicFilter.length > 0) {
        const providerLocations = provider.capabilities.flatMap(cap => cap.geographic_coverage || []);
        const hasMatchingLocation = campaignSettings.geographicFilter.some(loc => 
          providerLocations.includes(loc)
        );
        if (!hasMatchingLocation) return false;
      }

      // Experience filter
      if (campaignSettings.experienceMinimum > 0) {
        const avgExperience = provider.capabilities.reduce((sum, cap) => 
          sum + (cap.experience_years || 0), 0) / provider.capabilities.length;
        if (avgExperience < campaignSettings.experienceMinimum) return false;
      }

      return true;
    });

    setMatchingProviders(filteredProviders.sort((a, b) => b.matchScore - a.matchScore));
  };

  return (
    <ServiceBasedCampaignContainer>
      <PartyTypeSelector>
        <h3>Target Service Providers</h3>
        <RadioGroup
          value={selectedPartyType}
          onChange={setSelectedPartyType}
          options={[
            { value: 'contractors', label: 'Contractors' },
            { value: 'consultants', label: 'Consultants' }
          ]}
        />
      </PartyTypeSelector>

      <ServiceCategoryBrowser
        partyType={selectedPartyType}
        onCategoriesSelected={handleServiceSelection}
      />

      <CampaignFilters>
        <FilterSection>
          <h4>Provider Filters</h4>
          <ApprovalStatusFilter
            value={campaignSettings.approvalStatus}
            onChange={(value) => setCampaignSettings(prev => ({ ...prev, approvalStatus: value }))}
          />
          <ProspectiveProvidersToggle
            checked={campaignSettings.includeProspective}
            onChange={(checked) => setCampaignSettings(prev => ({ ...prev, includeProspective: checked }))}
          />
        </FilterSection>

        <FilterSection>
          <h4>Additional Criteria</h4>
          <GeographicFilter
            selected={campaignSettings.geographicFilter}
            onChange={(locations) => setCampaignSettings(prev => ({ ...prev, geographicFilter: locations }))}
          />
          <ExperienceFilter
            value={campaignSettings.experienceMinimum}
            onChange={(years) => setCampaignSettings(prev => ({ ...prev, experienceMinimum: years }))}
          />
        </FilterSection>
      </CampaignFilters>

      <MatchingProvidersList>
        <ResultsHeader>
          <h4>Matching {selectedPartyType} ({matchingProviders.length})</h4>
          <SortOptions>
            <SortButton onClick={() => sortProviders('matchScore')}>By Match Score</SortButton>
            <SortButton onClick={() => sortProviders('experience')}>By Experience</SortButton>
            <SortButton onClick={() => sortProviders('name')}>By Name</SortButton>
          </SortOptions>
        </ResultsHeader>

        <ProviderGrid>
          {matchingProviders.map(provider => (
            <ProviderCard
              key={provider.id}
              provider={provider}
              matchScore={provider.matchScore}
              matchedCategories={provider.matchedCategoriesCount}
              totalCategories={selectedServices.length}
              onSelect={() => handleProviderSelection(provider)}
            />
          ))}
        </ProviderGrid>

        {matchingProviders.length > 0 && (
          <CampaignActions>
            <CreateCampaignButton
              onClick={() => createServiceBasedCampaign(matchingProviders, selectedServices)}
            >
              Create Campaign for {matchingProviders.length} providers
            </CreateCampaignButton>
          </CampaignActions>
        )}
      </MatchingProvidersList>
    </ServiceBasedCampaignContainer>
  );
};
```

### 3.6 Benefits of Service Category System

#### For Procurement Teams:
- **Targeted Outreach**: Find contractors/consultants with specific service capabilities
- **Prospective Provider Identification**: Discover companies not yet approved for needed services
- **Capability Matching**: Ensure providers have required certifications and experience
- **Geographic Coverage**: Target providers operating in specific regions

#### For Contractors/Consultants:
- **Service Visibility**: Showcase specific service offerings and capabilities
- **Approval Tracking**: Monitor approval status for different service categories
- **Opportunity Matching**: Receive campaigns for services they provide
- **Capability Expansion**: Identify new service areas to develop

#### For Campaign Management:
- **Precision Targeting**: Send highly relevant campaigns to qualified providers
- **Compliance Assurance**: Only target approved providers for regulated services
- **Performance Tracking**: Monitor response rates by service category
- **Market Intelligence**: Understand service provider landscape

This service category system transforms NANOBOT from a generic email tool into a sophisticated procurement and service provider engagement platform, enabling precise targeting based on actual service capabilities and requirements.

### Consolidated SQL Table Creation Script

Execute the following SQL script in order to create all required tables with proper dependencies:

**Note**: The `procurement_categories` table already exists. This script creates all NEW tables required for NANOBOT functionality and enhances the existing table with Level 4 support.

```sql
-- =====================================================
-- NANOBOT IMPLEMENTATION - SUPABASE TABLE CREATION
-- Execute in this exact order to respect dependencies
-- NOTE: procurement_categories table already exists
-- =====================================================

-- Enable UUID extension if not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =====================================================
-- PHASE 1: ENHANCE EXISTING PROCUREMENT_CATEGORIES TABLE
-- Add Level 4 support to existing table
-- =====================================================

-- 1.1 Update existing procurement_categories table to support Level 4
ALTER TABLE public.procurement_categories
DROP CONSTRAINT IF EXISTS procurement_categories_hierarchy_level_check;

ALTER TABLE public.procurement_categories
ADD CONSTRAINT procurement_categories_hierarchy_level_check
CHECK (hierarchy_level = ANY (ARRAY[1, 2, 3, 4]));

-- Update valid_hierarchy constraint to include Level 4
ALTER TABLE public.procurement_categories
DROP CONSTRAINT IF EXISTS valid_hierarchy;

ALTER TABLE public.procurement_categories
ADD CONSTRAINT valid_hierarchy CHECK (
  (hierarchy_level = 1 AND parent_id IS NULL) OR
  (hierarchy_level IN (2, 3, 4) AND parent_id IS NOT NULL)
);

-- Add composite index for hierarchical queries if not exists
CREATE INDEX IF NOT EXISTS idx_procurement_categories_hierarchy
  ON public.procurement_categories USING btree (parent_id, hierarchy_level, display_order)
  TABLESPACE pg_default;

-- =====================================================
-- PHASE 2: EMAIL TEMPLATE TABLES
-- =====================================================

-- 2.1 Email Templates
CREATE TABLE IF NOT EXISTS public.email_templates (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  name character varying(255) NOT NULL,
  discipline character varying(100) NOT NULL,
  subject character varying(255) NOT NULL,
  html_content text NULL,
  text_content text NULL,
  category character varying(100) NULL,
  variables jsonb NULL,
  form_attachment_url text NULL,
  created_by uuid NULL,
  created_at timestamp with time zone NULL DEFAULT now(),
  updated_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT email_templates_pkey PRIMARY KEY (id)
) TABLESPACE pg_default;

-- 2.2 Form Templates
CREATE TABLE IF NOT EXISTS public.form_templates (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  name character varying(255) NOT NULL,
  discipline character varying(100) NOT NULL,
  form_type character varying(100) NOT NULL,
  template_data jsonb NULL,
  pdf_template_url text NULL,
  submission_deadline_days integer NULL,
  auto_reminders boolean NULL DEFAULT true,
  reminder_schedule jsonb NULL,
  created_by uuid NULL,
  created_at timestamp with time zone NULL DEFAULT now(),
  updated_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT form_templates_pkey PRIMARY KEY (id)
) TABLESPACE pg_default;

-- =====================================================
-- PHASE 3: EMAIL CAMPAIGN TABLES
-- =====================================================

-- 3.1 Email Campaigns
CREATE TABLE IF NOT EXISTS public.email_campaigns (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  name character varying(255) NOT NULL,
  description text NULL,
  discipline character varying(100) NOT NULL,
  template_id uuid NULL,
  form_template_id uuid NULL,
  status character varying(50) NULL DEFAULT 'draft',
  campaign_type character varying(50) NULL DEFAULT 'email',
  scheduled_at timestamp with time zone NULL,
  sent_at timestamp with time zone NULL,
  completed_at timestamp with time zone NULL,
  total_recipients integer NULL DEFAULT 0,
  sent_count integer NULL DEFAULT 0,
  delivered_count integer NULL DEFAULT 0,
  bounced_count integer NULL DEFAULT 0,
  opened_count integer NULL DEFAULT 0,
  clicked_count integer NULL DEFAULT 0,
  form_responses_count integer NULL DEFAULT 0,
  created_by uuid NULL,
  created_at timestamp with time zone NULL DEFAULT now(),
  updated_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT email_campaigns_pkey PRIMARY KEY (id),
  CONSTRAINT email_campaigns_template_id_fkey FOREIGN KEY (template_id)
    REFERENCES email_templates(id) ON DELETE SET NULL,
  CONSTRAINT email_campaigns_form_template_id_fkey FOREIGN KEY (form_template_id)
    REFERENCES form_templates(id) ON DELETE SET NULL
) TABLESPACE pg_default;

-- Indexes for email_campaigns
CREATE INDEX IF NOT EXISTS idx_email_campaigns_discipline
  ON public.email_campaigns USING btree (discipline) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_email_campaigns_status
  ON public.email_campaigns USING btree (status) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_email_campaigns_created_by
  ON public.email_campaigns USING btree (created_by) TABLESPACE pg_default;

-- 3.2 Email Recipients
CREATE TABLE IF NOT EXISTS public.email_recipients (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  campaign_id uuid NOT NULL,
  email character varying(255) NOT NULL,
  name character varying(255) NULL,
  contact_type character varying(100) NULL,
  contact_id uuid NULL,
  department character varying(100) NULL,
  role character varying(100) NULL,
  status character varying(50) NULL DEFAULT 'pending',
  sent_at timestamp with time zone NULL,
  delivered_at timestamp with time zone NULL,
  opened_at timestamp with time zone NULL,
  clicked_at timestamp with time zone NULL,
  bounced_at timestamp with time zone NULL,
  bounce_reason text NULL,
  unsubscribe_token character varying(255) NULL,
  custom_data jsonb NULL,
  created_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT email_recipients_pkey PRIMARY KEY (id),
  CONSTRAINT email_recipients_campaign_id_fkey FOREIGN KEY (campaign_id)
    REFERENCES email_campaigns(id) ON DELETE CASCADE,
  CONSTRAINT email_recipients_unsubscribe_token_key UNIQUE (unsubscribe_token)
) TABLESPACE pg_default;

-- Indexes for email_recipients
CREATE INDEX IF NOT EXISTS idx_email_recipients_campaign
  ON public.email_recipients USING btree (campaign_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_email_recipients_email
  ON public.email_recipients USING btree (email) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_email_recipients_status
  ON public.email_recipients USING btree (status) TABLESPACE pg_default;

-- 3.3 Email Tracking
CREATE TABLE IF NOT EXISTS public.email_tracking (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  recipient_id uuid NOT NULL,
  event_type character varying(50) NOT NULL,
  event_data jsonb NULL,
  ip_address inet NULL,
  user_agent text NULL,
  occurred_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT email_tracking_pkey PRIMARY KEY (id),
  CONSTRAINT email_tracking_recipient_id_fkey FOREIGN KEY (recipient_id)
    REFERENCES email_recipients(id) ON DELETE CASCADE
) TABLESPACE pg_default;

-- Indexes for email_tracking
CREATE INDEX IF NOT EXISTS idx_email_tracking_recipient
  ON public.email_tracking USING btree (recipient_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_email_tracking_event_type
  ON public.email_tracking USING btree (event_type) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_email_tracking_occurred_at
  ON public.email_tracking USING btree (occurred_at) TABLESPACE pg_default;

-- =====================================================
-- PHASE 4: ACCESS TOKEN TABLES
-- =====================================================

-- 4.1 Access Tokens
CREATE TABLE IF NOT EXISTS public.access_tokens (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  token_hash character varying(255) NOT NULL,
  recipient_id uuid NOT NULL,
  campaign_id uuid NOT NULL,
  expires_at timestamp with time zone NOT NULL,
  used_at timestamp with time zone NULL,
  created_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT access_tokens_pkey PRIMARY KEY (id),
  CONSTRAINT access_tokens_recipient_id_fkey FOREIGN KEY (recipient_id)
    REFERENCES email_recipients(id) ON DELETE CASCADE,
  CONSTRAINT access_tokens_campaign_id_fkey FOREIGN KEY (campaign_id)
    REFERENCES email_campaigns(id) ON DELETE CASCADE,
  CONSTRAINT access_tokens_token_hash_key UNIQUE (token_hash)
) TABLESPACE pg_default;

-- Indexes for access_tokens
CREATE INDEX IF NOT EXISTS idx_access_tokens_recipient
  ON public.access_tokens USING btree (recipient_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_access_tokens_campaign
  ON public.access_tokens USING btree (campaign_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_access_tokens_expires_at
  ON public.access_tokens USING btree (expires_at) TABLESPACE pg_default;

-- =====================================================
-- PHASE 5: HITL RESPONSE TABLES
-- =====================================================

-- 5.1 HITL Responses
CREATE TABLE IF NOT EXISTS public.hitl_responses (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  access_token_id uuid NOT NULL,
  recipient_id uuid NOT NULL,
  campaign_id uuid NOT NULL,
  response_type character varying(50) NOT NULL,
  response_data jsonb NULL,
  supplier_selections jsonb NULL,
  status character varying(50) NULL DEFAULT 'submitted',
  processed_at timestamp with time zone NULL,
  follow_up_sent_at timestamp with time zone NULL,
  ip_address inet NULL,
  user_agent text NULL,
  created_at timestamp with time zone NULL DEFAULT now(),
  updated_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT hitl_responses_pkey PRIMARY KEY (id),
  CONSTRAINT hitl_responses_access_token_id_fkey FOREIGN KEY (access_token_id)
    REFERENCES access_tokens(id) ON DELETE CASCADE,
  CONSTRAINT hitl_responses_recipient_id_fkey FOREIGN KEY (recipient_id)
    REFERENCES email_recipients(id) ON DELETE CASCADE,
  CONSTRAINT hitl_responses_campaign_id_fkey FOREIGN KEY (campaign_id)
    REFERENCES email_campaigns(id) ON DELETE CASCADE
) TABLESPACE pg_default;

-- Indexes for hitl_responses
CREATE INDEX IF NOT EXISTS idx_hitl_responses_access_token
  ON public.hitl_responses USING btree (access_token_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_hitl_responses_recipient
  ON public.hitl_responses USING btree (recipient_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_hitl_responses_campaign
  ON public.hitl_responses USING btree (campaign_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_hitl_responses_status
  ON public.hitl_responses USING btree (status) TABLESPACE pg_default;

-- 5.2 HITL Response Versions (Audit Trail)
CREATE TABLE IF NOT EXISTS public.hitl_response_versions (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  hitl_response_id uuid NOT NULL,
  version_number integer NOT NULL,
  response_data jsonb NULL,
  supplier_selections jsonb NULL,
  changed_by uuid NULL,
  change_reason text NULL,
  change_type character varying(50) NULL DEFAULT 'edit',
  created_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT hitl_response_versions_pkey PRIMARY KEY (id),
  CONSTRAINT hitl_response_versions_hitl_response_id_fkey FOREIGN KEY (hitl_response_id)
    REFERENCES hitl_responses(id) ON DELETE CASCADE
) TABLESPACE pg_default;

-- Indexes for hitl_response_versions
CREATE INDEX IF NOT EXISTS idx_hitl_response_versions_response
  ON public.hitl_response_versions USING btree (hitl_response_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_hitl_response_versions_version
  ON public.hitl_response_versions USING btree (version_number) TABLESPACE pg_default;

-- 5.3 HITL Response Approvals
CREATE TABLE IF NOT EXISTS public.hitl_response_approvals (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  hitl_response_id uuid NOT NULL,
  approved_by uuid NULL,
  approval_status character varying(50) NULL DEFAULT 'pending',
  approval_notes text NULL,
  approval_level character varying(50) NULL DEFAULT 'standard',
  approved_at timestamp with time zone NULL,
  created_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT hitl_response_approvals_pkey PRIMARY KEY (id),
  CONSTRAINT hitl_response_approvals_hitl_response_id_fkey FOREIGN KEY (hitl_response_id)
    REFERENCES hitl_responses(id) ON DELETE CASCADE
) TABLESPACE pg_default;

-- Indexes for hitl_response_approvals
CREATE INDEX IF NOT EXISTS idx_hitl_response_approvals_response
  ON public.hitl_response_approvals USING btree (hitl_response_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_hitl_response_approvals_status
  ON public.hitl_response_approvals USING btree (approval_status) TABLESPACE pg_default;

-- 5.4 HITL Dashboard Stats
CREATE TABLE IF NOT EXISTS public.hitl_dashboard_stats (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  campaign_id uuid NOT NULL,
  total_responses integer NULL DEFAULT 0,
  pending_review integer NULL DEFAULT 0,
  approved_responses integer NULL DEFAULT 0,
  rejected_responses integer NULL DEFAULT 0,
  overdue_responses integer NULL DEFAULT 0,
  average_response_time interval NULL,
  last_updated timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT hitl_dashboard_stats_pkey PRIMARY KEY (id),
  CONSTRAINT hitl_dashboard_stats_campaign_id_fkey FOREIGN KEY (campaign_id)
    REFERENCES email_campaigns(id) ON DELETE CASCADE
) TABLESPACE pg_default;

-- Indexes for hitl_dashboard_stats
CREATE INDEX IF NOT EXISTS idx_hitl_dashboard_stats_campaign
  ON public.hitl_dashboard_stats USING btree (campaign_id) TABLESPACE pg_default;

-- =====================================================
-- PHASE 6: SUPPLIER AND FORM RESPONSE TABLES
-- =====================================================

-- 6.1 Form Responses
CREATE TABLE IF NOT EXISTS public.form_responses (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  campaign_id uuid NOT NULL,
  recipient_id uuid NOT NULL,
  form_template_id uuid NOT NULL,
  response_data jsonb NULL,
  status character varying(50) NULL DEFAULT 'pending',
  submitted_at timestamp with time zone NULL,
  last_reminded_at timestamp with time zone NULL,
  reminder_count integer NULL DEFAULT 0,
  created_at timestamp with time zone NULL DEFAULT now(),
  updated_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT form_responses_pkey PRIMARY KEY (id),
  CONSTRAINT form_responses_campaign_id_fkey FOREIGN KEY (campaign_id)
    REFERENCES email_campaigns(id) ON DELETE CASCADE,
  CONSTRAINT form_responses_recipient_id_fkey FOREIGN KEY (recipient_id)
    REFERENCES email_recipients(id) ON DELETE CASCADE,
  CONSTRAINT form_responses_form_template_id_fkey FOREIGN KEY (form_template_id)
    REFERENCES form_templates(id) ON DELETE CASCADE
) TABLESPACE pg_default;

-- Indexes for form_responses
CREATE INDEX IF NOT EXISTS idx_form_responses_campaign
  ON public.form_responses USING btree (campaign_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_form_responses_recipient
  ON public.form_responses USING btree (recipient_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_form_responses_status
  ON public.form_responses USING btree (status) TABLESPACE pg_default;

-- 6.2 Supplier Goods Selections
CREATE TABLE IF NOT EXISTS public.supplier_goods_selections (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  hitl_response_id uuid NOT NULL,
  procurement_category_id uuid NULL,
  goods_service_name character varying(255) NOT NULL,
  goods_description text NULL,
  unit_of_measure text NULL,
  estimated_quantity numeric NULL,
  quality_specifications jsonb NULL,
  quantity_capacity character varying(100) NULL,
  quality_level character varying(50) NULL,
  contact_frequency character varying(50) NULL,
  selected_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT supplier_goods_selections_pkey PRIMARY KEY (id),
  CONSTRAINT supplier_goods_selections_hitl_response_id_fkey FOREIGN KEY (hitl_response_id)
    REFERENCES hitl_responses(id) ON DELETE CASCADE,
  CONSTRAINT supplier_goods_selections_procurement_category_id_fkey FOREIGN KEY (procurement_category_id)
    REFERENCES procurement_categories(id) ON DELETE SET NULL
) TABLESPACE pg_default;

-- Indexes for supplier_goods_selections
CREATE INDEX IF NOT EXISTS idx_supplier_goods_selections_response
  ON public.supplier_goods_selections USING btree (hitl_response_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_supplier_goods_selections_category
  ON public.supplier_goods_selections USING btree (procurement_category_id) TABLESPACE pg_default;

-- =====================================================
-- PHASE 7: FORM ATTACHMENT TABLES
-- =====================================================

-- 7.1 Form Attachments
CREATE TABLE IF NOT EXISTS public.form_attachments (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  hitl_response_id uuid NOT NULL,
  field_id character varying(255) NOT NULL,
  file_name character varying(255) NOT NULL,
  file_size integer NOT NULL,
  mime_type character varying(100) NOT NULL,
  storage_path text NOT NULL,
  uploaded_by uuid NULL,
  upload_source character varying(50) NULL DEFAULT 'external',
  created_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT form_attachments_pkey PRIMARY KEY (id),
  CONSTRAINT form_attachments_hitl_response_id_fkey FOREIGN KEY (hitl_response_id)
    REFERENCES hitl_responses(id) ON DELETE CASCADE
) TABLESPACE pg_default;

-- Indexes for form_attachments
CREATE INDEX IF NOT EXISTS idx_form_attachments_response
  ON public.form_attachments USING btree (hitl_response_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_form_attachments_field
  ON public.form_attachments USING btree (field_id) TABLESPACE pg_default;

-- 7.2 Attachment Versions
CREATE TABLE IF NOT EXISTS public.attachment_versions (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  attachment_id uuid NOT NULL,
  version_number integer NOT NULL,
  storage_path text NOT NULL,
  changed_by uuid NULL,
  change_reason text NULL,
  created_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT attachment_versions_pkey PRIMARY KEY (id),
  CONSTRAINT attachment_versions_attachment_id_fkey FOREIGN KEY (attachment_id)
    REFERENCES form_attachments(id) ON DELETE CASCADE
) TABLESPACE pg_default;

-- Indexes for attachment_versions
CREATE INDEX IF NOT EXISTS idx_attachment_versions_attachment
  ON public.attachment_versions USING btree (attachment_id) TABLESPACE pg_default;
CREATE INDEX IF NOT EXISTS idx_attachment_versions_version
  ON public.attachment_versions USING btree (version_number) TABLESPACE pg_default;

-- =====================================================
-- PHASE 8: ENHANCE EXISTING TABLES (Optional)
-- =====================================================

-- 8.1 Add email columns to procurement_contacts (if table exists)
DO $$
BEGIN
  IF EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'procurement_contacts') THEN
    ALTER TABLE procurement_contacts
    ADD COLUMN IF NOT EXISTS email_preferences jsonb DEFAULT '{"marketing": true, "procurement": true}',
    ADD COLUMN IF NOT EXISTS last_email_sent_at timestamp with time zone,
    ADD COLUMN IF NOT EXISTS email_bounce_count integer DEFAULT 0,
    ADD COLUMN IF NOT EXISTS unsubscribed_at timestamp with time zone;
  END IF;
END $$;

-- 8.2 Add email columns to vendors (if table exists)
DO $$
BEGIN
  IF EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'vendors') THEN
    ALTER TABLE vendors
    ADD COLUMN IF NOT EXISTS email_campaign_opt_in boolean DEFAULT true,
    ADD COLUMN IF NOT EXISTS preferred_contact_email character varying(255),
    ADD COLUMN IF NOT EXISTS email_communication_history jsonb;
  END IF;
END $$;

-- =====================================================
-- COMPLETION MESSAGE
-- =====================================================
DO $$
BEGIN
  RAISE NOTICE 'NANOBOT database schema creation completed successfully!';
  RAISE NOTICE 'Tables created: 15 new tables + enhancements to existing tables';
  RAISE NOTICE 'All indexes and constraints have been applied.';
END $$;
```

**Execution Notes:**
1. Run this script in your Supabase SQL Editor
2. The script uses `IF NOT EXISTS` to be idempotent
3. Tables are created in dependency order to avoid foreign key errors
4. The script includes conditional logic for enhancing existing tables
5. All performance indexes are created automatically

2. **Short-term Goals** (Week 1-2):
   - [ ] Deploy basic email sending functionality
   - [ ] Implement dynamic form renderer
   - [ ] Create supplier goods selection interface
   - [ ] Set up HITL response dashboard

3. **Medium-term Goals** (Week 3-4):
   - [ ] Full testing with standards compliance validation
   - [ ] Production deployment with monitoring
   - [ ] User training and documentation
   - [ ] Performance optimization

### Dependencies and Blockers

| Dependency | Status | Impact |
|------------|--------|--------|
| Supabase Project Access | 🟡 Pending | Required for database implementation |
| SMTP/IMAP Credentials | 🟡 Pending | Required for email functionality |
| Nanobot Submodule Fork | 🟡 Pending | Required for core functionality |
| Governance Framework Integration | ✅ Available | Deep agents governance system ready |

### Risk Assessment

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| SMTP Provider Limits | Medium | High | Implement warm-up strategies and backup providers |
| Database Performance | Low | Medium | Optimized indexes and query patterns designed |
| Security Vulnerabilities | Low | High | Comprehensive security standards and validation |
| User Adoption | Medium | Medium | Intuitive UI design and comprehensive training |

## Prerequisites
- Python 3.8+
- SMTP/IMAP email credentials (Gmail/Outlook/Custom)
- Supabase project for procurement data
- Local LLM (Mistral/Ollama) for privacy-focused operations

## Standards Compliance

### File Naming Standards (0000_FILE_NAMING_STANDARDS.md)
All files and directories in the NANOBOT implementation MUST adhere to:
- **Lowercase filenames** with underscore separation
- **Numeric prefixes** for logical ordering
- **Descriptive names** clearly indicating content and purpose
- **No special characters** or emojis

### Agent Coding Standards (0000_AGENT_CODING_STANDARDS.md)
All NANOBOT components MUST implement:
- **Governance Swarm Integration** with `@with_governance` decorator
- **Structured logging** with correlation IDs and performance metrics
- **Prompt key validation** using standardized naming conventions
- **Security compliance** with input validation and authentication
- **Error handling** with comprehensive logging and recovery

### Python Module Naming Standards (0000_PYTHON_MODULE_NAMING_STANDARDS.md)
All Python modules MUST use:
- **Lowercase with underscores** (no hyphens)
- **Valid Python identifiers** for import compatibility
- **Standard naming patterns** for packages and modules

### Workflow Optimization Standards (0000_WORKFLOW_OPTIMIZATION_STANDARDS.md)
Implementation MUST include:
- **Performance monitoring** with response time tracking
- **Quality assurance** with automated testing and validation
- **Security standards** with input sanitization and audit trails
- **Accessibility compliance** (WCAG 2.1)
- **Comprehensive documentation** following API standards

## Phase 1: Setup and Integration

### 1.1 Fork and Add Nanobot Submodule
```bash
# Fork HKUDS/nanobot to yourorg/nanobot-procurement
git submodule add https://github.com/yourorg/nanobot-procurement services/nanobot
git submodule update --init --recursive
```

### 1.2 Configure Email Platform
- Set up IMAP polling for incoming messages
- Configure SMTP for outgoing bulk sends
- Implement rate limiting and warm-up strategies
- Add Gmail/Outlook SMTP credentials to environment

### 1.3 Deploy on Preferred Stack
- **Render/Runpod/Supabase**: One-click deployment
- **Local Development**: Python virtual environment
- **Docker**: Containerized deployment for production

## Phase 2: Supabase Database Enhancement

### 2.1 Create Email Campaign Tables
Create new Supabase tables for email campaign management:

**email_campaigns**
```sql
CREATE TABLE email_campaigns (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  description TEXT,
  discipline VARCHAR(100) NOT NULL, -- procurement, contracts, hr, safety, construction, etc.
  template_id UUID REFERENCES email_templates(id),
  form_template_id UUID, -- Link to form templates for form issuance
  status VARCHAR(50) DEFAULT 'draft', -- draft, scheduled, sending, completed, paused
  campaign_type VARCHAR(50) DEFAULT 'email', -- email, form_issuance, combined
  scheduled_at TIMESTAMPTZ,
  sent_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  total_recipients INTEGER DEFAULT 0,
  sent_count INTEGER DEFAULT 0,
  delivered_count INTEGER DEFAULT 0,
  bounced_count INTEGER DEFAULT 0,
  opened_count INTEGER DEFAULT 0,
  clicked_count INTEGER DEFAULT 0,
  form_responses_count INTEGER DEFAULT 0,
  created_by UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

**email_recipients**
```sql
CREATE TABLE email_recipients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id UUID REFERENCES email_campaigns(id) ON DELETE CASCADE,
  email VARCHAR(255) NOT NULL,
  name VARCHAR(255),
  contact_type VARCHAR(100), -- employee, vendor, contractor, stakeholder, etc.
  contact_id UUID, -- Generic foreign key to various contact tables
  department VARCHAR(100), -- Link to organizational department
  role VARCHAR(100), -- Job role or relationship type
  status VARCHAR(50) DEFAULT 'pending', -- pending, sent, delivered, bounced, opened, clicked
  sent_at TIMESTAMPTZ,
  delivered_at TIMESTAMPTZ,
  opened_at TIMESTAMPTZ,
  clicked_at TIMESTAMPTZ,
  bounced_at TIMESTAMPTZ,
  bounce_reason TEXT,
  unsubscribe_token VARCHAR(255) UNIQUE,
  custom_data JSONB, -- For personalization tokens and discipline-specific data
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

**email_templates**
```sql
CREATE TABLE email_templates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  discipline VARCHAR(100) NOT NULL, -- procurement, contracts, hr, safety, construction, etc.
  subject VARCHAR(255) NOT NULL,
  html_content TEXT,
  text_content TEXT,
  category VARCHAR(100), -- questionnaire, notification, reminder, compliance, etc.
  variables JSONB, -- Available personalization variables
  form_attachment_url TEXT, -- Link to form template for combined campaigns
  created_by UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

**form_templates**
```sql
CREATE TABLE form_templates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  discipline VARCHAR(100) NOT NULL, -- procurement, contracts, hr, safety, construction, etc.
  form_type VARCHAR(100) NOT NULL, -- questionnaire, application, assessment, etc.
  template_data JSONB, -- Form structure and fields
  pdf_template_url TEXT, -- Link to PDF template if applicable
  submission_deadline_days INTEGER, -- Days to complete after issuance
  auto_reminders BOOLEAN DEFAULT true,
  reminder_schedule JSONB, -- Reminder timing configuration
  created_by UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

**form_responses**
```sql
CREATE TABLE form_responses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id UUID REFERENCES email_campaigns(id) ON DELETE CASCADE,
  recipient_id UUID REFERENCES email_recipients(id) ON DELETE CASCADE,
  form_template_id UUID REFERENCES form_templates(id),
  response_data JSONB, -- Form field responses
  status VARCHAR(50) DEFAULT 'pending', -- pending, in_progress, submitted, overdue
  submitted_at TIMESTAMPTZ,
  last_reminded_at TIMESTAMPTZ,
  reminder_count INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

**email_tracking**
```sql
CREATE TABLE email_tracking (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  recipient_id UUID REFERENCES email_recipients(id) ON DELETE CASCADE,
  event_type VARCHAR(50) NOT NULL, -- sent, delivered, opened, clicked, bounced, unsubscribed
  event_data JSONB,
  ip_address INET,
  user_agent TEXT,
  occurred_at TIMESTAMPTZ DEFAULT NOW()
);
```

**hitl_responses**
```sql
CREATE TABLE hitl_responses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  access_token_id UUID REFERENCES access_tokens(id) ON DELETE CASCADE,
  recipient_id UUID REFERENCES email_recipients(id) ON DELETE CASCADE,
  campaign_id UUID REFERENCES email_campaigns(id) ON DELETE CASCADE,
  response_type VARCHAR(50) NOT NULL, -- supplier_selection, form_response, feedback, etc.
  response_data JSONB, -- Structured response data (selected goods, form answers, etc.)
  supplier_selections JSONB, -- For procurement: selected goods/services with preferences
  status VARCHAR(50) DEFAULT 'submitted', -- submitted, processed, rejected
  processed_at TIMESTAMPTZ,
  follow_up_sent_at TIMESTAMPTZ,
  ip_address INET,
  user_agent TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

**supplier_goods_selections**
```sql
CREATE TABLE supplier_goods_selections (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  hitl_response_id UUID REFERENCES hitl_responses(id) ON DELETE CASCADE,
  procurement_category_id UUID, -- Links to procurement_categories table
  goods_service_name VARCHAR(255) NOT NULL,
  quantity_capacity VARCHAR(100), -- e.g., "100 units/month", "unlimited"
  quality_level VARCHAR(50), -- high, medium, standard
  contact_frequency VARCHAR(50), -- daily, weekly, monthly, as_needed
  selected_at TIMESTAMPTZ DEFAULT NOW()
);
```

**hitl_response_versions**
```sql
CREATE TABLE hitl_response_versions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  hitl_response_id UUID REFERENCES hitl_responses(id) ON DELETE CASCADE,
  version_number INTEGER NOT NULL,
  response_data JSONB, -- Complete response data at this version
  supplier_selections JSONB, -- Supplier selections at this version
  changed_by UUID REFERENCES auth.users(id), -- Who made the change
  change_reason TEXT, -- Reason for the change
  change_type VARCHAR(50) DEFAULT 'edit', -- edit, approve, reject, submit
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

**hitl_response_approvals**
```sql
CREATE TABLE hitl_response_approvals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  hitl_response_id UUID REFERENCES hitl_responses(id) ON DELETE CASCADE,
  approved_by UUID REFERENCES auth.users(id),
  approval_status VARCHAR(50) DEFAULT 'pending', -- pending, approved, rejected, requires_changes
  approval_notes TEXT,
  approval_level VARCHAR(50) DEFAULT 'standard', -- standard, senior, executive
  approved_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

**hitl_dashboard_stats**
```sql
CREATE TABLE hitl_dashboard_stats (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id UUID REFERENCES email_campaigns(id) ON DELETE CASCADE,
  total_responses INTEGER DEFAULT 0,
  pending_review INTEGER DEFAULT 0,
  approved_responses INTEGER DEFAULT 0,
  rejected_responses INTEGER DEFAULT 0,
  overdue_responses INTEGER DEFAULT 0,
  average_response_time INTERVAL,
  last_updated TIMESTAMPTZ DEFAULT NOW()
);
```

### 2.2 Enhance Existing Procurement Tables
Add email-related columns to existing tables:

**procurement_contacts** (if exists)
```sql
ALTER TABLE procurement_contacts
ADD COLUMN email_preferences JSONB DEFAULT '{"marketing": true, "procurement": true}',
ADD COLUMN last_email_sent_at TIMESTAMPTZ,
ADD COLUMN email_bounce_count INTEGER DEFAULT 0,
ADD COLUMN unsubscribed_at TIMESTAMPTZ;
```

**vendors** (if exists)
```sql
ALTER TABLE vendors
ADD COLUMN email_campaign_opt_in BOOLEAN DEFAULT true,
ADD COLUMN preferred_contact_email VARCHAR(255),
ADD COLUMN email_communication_history JSONB;
```

### 2.3 Create Multi-Disciplinary Supabase Integration Tool
Location: `services/nanobot/tools/supabase_multi_discipline.py`

**Standards Compliance:**
- **File Naming**: `supabase_multi_discipline.py` (lowercase, underscores, descriptive)
- **Governance Integration**: All functions must use `@with_governance` decorator
- **Logging**: Implement structured logging with correlation IDs
- **Security**: Input validation and parameterized queries
- **Performance**: Response time monitoring and memory usage tracking

Features:
- Dynamic discipline-based table querying with configurable recipient sources
- Generic recipient list generation from discipline-specific contact tables
- Discipline-specific personalization and content generation
- Form issuance and response tracking across departments
- CSV export/import for bulk operations
- Sync email and form campaign data back to Supabase
- Role-based access control for different disciplines

#### Dynamic Recipient Table Mapping
The tool dynamically determines recipient tables based on the user's active discipline:

```python
DISCIPLINE_RECIPIENT_MAPPING = {
    "procurement": ["suppliers", "consultants", "contacts"],
    "contracts": ["contractors", "consultants", "contacts"],
    "hr": ["user_management", "cv_applications", "contacts"],
    "safety": ["contractor_vetting", "a_02400_safety_data", "contacts"],
    "construction": ["contractors", "consultants", "contacts"],
    "engineering": ["consultants", "contractors", "contacts"],
    "finance": ["suppliers", "consultants", "contacts"],
    "logistics": ["suppliers", "contractors", "contacts"],
    "it": ["user_management", "consultants", "contacts"],
    "legal": ["contractors", "consultants", "contacts"],
    "environmental": ["consultants", "contractors", "contacts"],
    "quality": ["suppliers", "contractors", "contacts"]
}
```

The system queries the user's active discipline from their session/profile and automatically selects the appropriate recipient tables for email campaigns.

#### Discipline Detection and Table Selection
The multi-disciplinary tool implements the following logic for recipient table selection:

1. **User Discipline Detection**: Query the user's current discipline from:
   - User session data (`user_discipline_access` table)
   - Active project context (`project_phase_assignments` table)
   - User role assignments (`user_role_assignments` with department codes)

2. **Dynamic Table Resolution**: Based on the detected discipline, the system:
   - Maps the discipline to appropriate recipient tables using `DISCIPLINE_RECIPIENT_MAPPING`
   - Validates table existence in the current Supabase schema
   - Falls back to generic contact tables if discipline-specific tables don't exist
   - Supports multiple recipient sources per discipline for comprehensive coverage

3. **Query Construction**: Builds dynamic SQL queries that:
   - UNION data from multiple recipient tables
   - Include discipline-specific fields (e.g., vendor status for procurement, safety certifications for safety)
   - Filter by active status, email preferences, and opt-in status
   - Support pagination for large recipient lists

Example implementation with governance integration:
```python
from deep_agents.agents.shared.governance import with_governance, GovernedAgentMixin
from typing import List
import logging

class NanobotMultiDisciplineTool(GovernedAgentMixin):
    """Multi-disciplinary Supabase integration tool with governance compliance."""

    @with_governance(jurisdiction='FI', strict_mode=True)
    def get_recipient_tables_for_discipline(self, discipline: str, correlation_id: str = None) -> List[str]:
        """Get recipient tables for a given discipline with governance validation."""
        logger = logging.getLogger(__name__)

        try:
            logger.info("Retrieving recipient tables for discipline",
                       extra={
                           'discipline': discipline,
                           'correlation_id': correlation_id,
                           'operation': 'get_recipient_tables'
                       })

            mapping = config.get('recipient_table_mapping', {})
            tables = mapping.get(discipline, [])

            # Validate tables exist in schema
            existing_tables = [table for table in tables if self._validate_table_exists(table)]

            # Fallback to generic contacts if no discipline-specific tables
            if not existing_tables:
                existing_tables = ['contacts']
                logger.warning("No discipline-specific tables found, using fallback",
                             extra={'discipline': discipline, 'fallback_tables': existing_tables})

            logger.info("Recipient tables resolved successfully",
                       extra={
                           'discipline': discipline,
                           'tables_found': len(existing_tables),
                           'correlation_id': correlation_id
                       })

            return existing_tables

        except Exception as e:
            logger.error("Failed to get recipient tables",
                        extra={
                            'discipline': discipline,
                            'error': str(e),
                            'correlation_id': correlation_id
                        },
                        exc_info=True)
            raise

    def _validate_table_exists(self, table_name: str) -> bool:
        """Validate table exists in Supabase schema with security checks."""
        # Implementation with parameterized queries and input validation
        pass
```

### 2.4 Add Multi-Disciplinary Templates with HITL Integration
Location: `services/nanobot/templates/`

Discipline-specific template directories:
- `procurement/`: Questionnaire emails, vendor notifications, compliance reminders
- `contracts/`: Form issuance, contract proposal notifications, deadline reminders
- `hr/`: Employee onboarding, policy updates, training notifications
- `safety/`: Safety questionnaire forms, incident reporting, compliance alerts
- `construction/`: Project updates, subcontractor communications, quality assurance forms

Each discipline includes:
- Email templates with personalization variables and access links
- Form templates with dynamic fields and document attachment capabilities
- Automated reminder sequences
- Compliance tracking workflows
- HITL (Human-in-the-Loop) integration for external party responses

#### Advanced Form Template System
The system supports multiple customizable form types per discipline with document attachment capabilities:

**Form Types by Discipline:**
- **Procurement**: Vendor questionnaires, compliance forms, capability assessments, document submissions
- **Contracts**: NDA forms, contract proposals, compliance checklists, document reviews
- **HR**: Application forms, background checks, compliance acknowledgments, document uploads
- **Safety**: Incident reports, safety audits, training confirmations, certification uploads
- **Construction**: Quality assurance forms, progress reports, compliance submissions, document approvals

**Form Template Features:**
- **Dynamic Field Types**: Text, number, date, select, checkbox, radio, file upload
- **Conditional Logic**: Show/hide fields based on previous responses
- **Validation Rules**: Required fields, format validation, file type restrictions
- **Document Attachments**: Multiple file uploads with size/type limits
- **Custom Styling**: Discipline-specific branding and layouts

#### HITL Workflow Integration
The email templates include secure access links that direct recipients to the HITL page for external parties:

1. **Access Link Generation**: Each email campaign generates unique, time-limited access tokens
2. **HITL Page Routing**: Recipients are directed to `/hitl/external-parties` with their access token
3. **Modal Trigger**: Page displays relevant modal based on recipient type and campaign purpose
4. **Response Collection**: Recipients complete forms, select options, or provide feedback
5. **Supplier Selection**: For procurement campaigns, suppliers select goods/services from categorized lists

Example email template with access link:
```
Subject: [Organization] Request for Information - {Campaign Name}

Dear {Recipient Name},

We are conducting a survey regarding {campaign_purpose}.

To provide your response, please click the following secure link:
{access_link}

This link will expire in 30 days and can only be used once.

Best regards,
{Organization Name}
```

#### Supplier Goods Selection
For procurement discipline campaigns, the HITL modal includes:

- **Categorized Goods/Services**: Organized by procurement categories
- **Multi-select Interface**: Suppliers can select multiple items they can provide
- **Quantity/Quality Preferences**: Optional fields for capacity and quality levels
- **Contact Preferences**: Preferred communication methods and frequency
- **Submission Tracking**: Automatic confirmation and follow-up scheduling

### 2.5 Implement Bulk Email Logic with Access Token Generation
- Batch processing for 1000+ emails
- Personalization via dynamic tokens
- Scheduling and automation
- Bounce handling and retry logic
- Secure access token generation for HITL responses

#### Access Token Management
The system generates secure, time-limited access tokens for each recipient:

```python
def generate_access_token(recipient_id: str, campaign_id: str, expiry_days: int = 30) -> str:
    """Generate secure access token for HITL responses."""
    payload = {
        'recipient_id': recipient_id,
        'campaign_id': campaign_id,
        'exp': datetime.utcnow() + timedelta(days=expiry_days),
        'iat': datetime.utcnow(),
        'type': 'hitl_access'
    }
    token = jwt.encode(payload, config['jwt_secret'], algorithm='HS256')
    return token
```

**Access Token Table**:
```sql
CREATE TABLE access_tokens (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  token_hash VARCHAR(255) UNIQUE NOT NULL,
  recipient_id UUID REFERENCES email_recipients(id) ON DELETE CASCADE,
  campaign_id UUID REFERENCES email_campaigns(id) ON DELETE CASCADE,
  expires_at TIMESTAMPTZ NOT NULL,
  used_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

### 2.6 NANOBOT Campaign Management UI
Location: `client/src/pages/nanobot/campaign-management/`

#### Campaign Creation Workflow
The campaign management interface provides a comprehensive workflow for creating, configuring, and managing bulk email campaigns across all disciplines:

**Campaign Builder Interface**:
```jsx
// Main Campaign Builder Component
const CampaignBuilder = () => {
  const [campaign, setCampaign] = useState({
    name: '',
    description: '',
    discipline: '',
    campaignType: 'email', // email, form_issuance, combined
    template: null,
    formTemplate: null,
    recipients: [],
    schedule: null,
    settings: {}
  });

  const [currentStep, setCurrentStep] = useState(0);

  const steps = [
    { id: 'basics', title: 'Campaign Basics', component: CampaignBasicsStep },
    { id: 'discipline', title: 'Discipline & Type', component: DisciplineSelectionStep },
    { id: 'content', title: 'Content & Templates', component: ContentTemplateStep },
    { id: 'recipients', title: 'Recipient Selection', component: RecipientSelectionStep },
    { id: 'schedule', title: 'Schedule & Settings', component: ScheduleSettingsStep },
    { id: 'preview', title: 'Preview & Launch', component: PreviewLaunchStep }
  ];

  return (
    <CampaignWizard>
      <WizardHeader>
        <ProgressIndicator steps={steps} currentStep={currentStep} />
        <CampaignTitle>{campaign.name || 'New Campaign'}</CampaignTitle>
      </WizardHeader>

      <WizardContent>
        {React.createElement(steps[currentStep].component, {
          campaign,
          onUpdate: setCampaign,
          onNext: () => setCurrentStep(prev => prev + 1),
          onPrevious: () => setCurrentStep(prev => prev - 1)
        })}
      </WizardContent>

      <WizardActions>
        <Button
          disabled={currentStep === 0}
          onClick={() => setCurrentStep(prev => prev - 1)}
        >
          Previous
        </Button>
        <SaveDraftButton onClick={() => saveDraft(campaign)}>
          Save Draft
        </SaveDraftButton>
        <Button
          primary
          onClick={() => currentStep === steps.length - 1 ?
            launchCampaign(campaign) :
            setCurrentStep(prev => prev + 1)
          }
        >
          {currentStep === steps.length - 1 ? 'Launch Campaign' : 'Next'}
        </Button>
      </WizardActions>
    </CampaignWizard>
  );
};
```

**Step-by-Step Campaign Creation**:

1. **Campaign Basics**:
   - Campaign name and description
   - Campaign purpose/objective
   - Target audience description
   - Success metrics definition

2. **Discipline & Type Selection**:
   - Discipline dropdown (procurement, contracts, HR, safety, construction, etc.)
   - Campaign type selection:
     - **Email Only**: Simple notification or announcement
     - **Form Issuance**: Request form completion from recipients
     - **Combined**: Email with embedded form link
   - Discipline-specific configuration options

3. **Content & Template Selection**:
   - **Template Library**: Browse existing templates by discipline
   - **Template Editor**: Rich text editor for email content
   - **Variable Insertion**: Dynamic personalization tokens
   - **Form Template Association**: Link to form templates for combined campaigns
   - **A/B Testing Setup**: Multiple content variations

4. **Recipient Selection**:
   - **Dynamic Recipient Source**: Auto-populate based on discipline
   - **Manual Recipient Addition**: Upload CSV or add individual contacts
   - **Recipient Filtering**: Filter by role, department, location, etc.
   - **Opt-in Verification**: Ensure recipients have consented to communication
   - **Duplicate Prevention**: Automatic deduplication of recipient lists

5. **Schedule & Settings**:
   - **Send Timing**: Immediate, scheduled, or drip campaign
   - **Rate Limiting**: Control sending speed to avoid spam filters
   - **Reminder Schedule**: Automated follow-up sequences
   - **Compliance Settings**: CAN-SPAM compliance, unsubscribe handling
   - **Tracking Preferences**: Open/click tracking configuration

6. **Preview & Launch**:
   - **Content Preview**: Render email as recipient will see it
   - **Test Send**: Send test emails to verify content and delivery
   - **Recipient Count Validation**: Confirm total recipients and segments
   - **Budget/Cost Estimation**: For paid email services
   - **Final Approval**: Require manager approval for large campaigns

#### Template Management Interface
Comprehensive template creation and management system:

**Template Library**:
```jsx
const TemplateLibrary = ({ discipline, onSelectTemplate }) => {
  const [templates, setTemplates] = useState([]);
  const [filters, setFilters] = useState({
    category: '',
    searchTerm: '',
    sortBy: 'recent'
  });

  return (
    <TemplateLibraryContainer>
      <LibraryHeader>
        <SearchBar
          value={filters.searchTerm}
          onChange={(value) => setFilters(prev => ({ ...prev, searchTerm: value }))}
          placeholder="Search templates..."
        />
        <FilterDropdown
          value={filters.category}
          onChange={(value) => setFilters(prev => ({ ...prev, category: value }))}
          options={['All', 'Questionnaire', 'Notification', 'Compliance', 'Reminder']}
        />
        <CreateTemplateButton onClick={() => openTemplateEditor()}>
          Create New Template
        </CreateTemplateButton>
      </LibraryHeader>

      <TemplateGrid>
        {templates.map(template => (
          <TemplateCard
            key={template.id}
            template={template}
            onSelect={() => onSelectTemplate(template)}
            onEdit={() => openTemplateEditor(template)}
            onDuplicate={() => duplicateTemplate(template)}
          />
        ))}
      </TemplateGrid>
    </TemplateLibraryContainer>
  );
};
```

**Rich Text Template Editor**:
- **Visual Editor**: Drag-and-drop email builder
- **HTML Source View**: Direct HTML editing for advanced users
- **Variable System**: Insert dynamic personalization tokens
- **Responsive Preview**: Mobile and desktop preview modes
- **Template Versioning**: Track changes and rollbacks

### 2.7 Customizable Form Interface System
Location: `client/src/components/forms/dynamic-form-renderer.jsx`

#### Dynamic Form Rendering Engine
The system provides a fully customizable form interface that supports multiple form types per discipline with document attachment capabilities:

**Form Field Types:**
- **Text Input**: Single-line and multi-line text fields
- **Number Input**: Numeric fields with validation and formatting
- **Date/Time Pickers**: Date selection with configurable formats
- **Select Dropdowns**: Single and multi-select options
- **Radio Buttons**: Exclusive choice selections
- **Checkboxes**: Multiple choice selections
- **File Upload**: Document attachment with type/size validation
- **Signature Fields**: Digital signature capture
- **Rich Text Editor**: Formatted text input for detailed responses

## HITL Procedure Alignment

### **HITL Task Types vs Workflow Summaries**

Following the established HITL procedure (`0000_WORKFLOW_HITL_PROCEDURE.md`), NANOBOT implements a two-tier HITL system:

#### **1. Individual HITL Tasks (Simple Modal)**
- **Purpose**: Focused review of specific response submissions
- **UI**: Simple HITL modal in response management dashboard
- **Scope**: Individual response verification, editing, and approval
- **Examples**:
  - Supplier goods selection reviews
  - Form response validations
  - Document attachment approvals
  - Response editing and corrections

#### **2. Workflow Summaries (AgentWorkflowReview Modal)**
- **Purpose**: Comprehensive overview of entire campaign workflows
- **UI**: AgentWorkflowReview modal with detailed campaign analytics
- **Scope**: Complete campaign performance, multiple response analyses, final campaign outcomes
- **Examples**:
  - Campaign performance summaries
  - Bulk response analytics
  - Multi-discipline response overviews

### **HITL Trigger Conditions**

#### **Response-Based HITL Escalation**
NANOBOT responses trigger HITL based on predefined criteria:

```javascript
// HITL escalation assessment for responses
const assessHITLEligibility = (response, campaign) => {
  let shouldEscalate = false;
  let reason = '';
  let priority = 'standard';

  // Business value assessment
  if (campaign.discipline === 'procurement' && response.supplierSelections?.length > 10) {
    shouldEscalate = true;
    reason = 'High-value supplier with extensive capabilities';
    priority = 'high';
  }

  // Complexity assessment
  if (response.attachments?.length > 5) {
    shouldEscalate = true;
    reason = 'Complex response with multiple document attachments';
    priority = 'high';
  }

  // Risk assessment
  if (campaign.discipline === 'safety' && response.criticalIncidents) {
    shouldEscalate = true;
    reason = 'Safety-critical response requiring specialist review';
    priority = 'urgent';
  }

  return { shouldEscalate, reason, priority };
};
```

### **HITL Task Assignment (Aligned with Procedure)**

#### **HITL Assignment Service Integration**
Following the HITL procedure requirements, NANOBOT integrates with the `hitlAssignmentService`:

```javascript
// HITL Assignment Service Integration (aligned with procedure)
class NANOBOTHITLAssignmentService {
  async assignHITLTask(responseId, campaign) {
    console.log(`👤 [NANOBOT-HITL] Assigning HITL task for response ${responseId}`);

    // Get available specialists for campaign discipline
    const specialists = await this.findAvailableSpecialists(campaign.discipline);

    if (specialists.length === 0) {
      console.warn(`⚠️ [NANOBOT-HITL] No specialists available for ${campaign.discipline}`);
      return { assigned: false, reason: 'no_specialists_available' };
    }

    // Select optimal specialist based on workload and expertise
    const selectedSpecialist = await this.selectOptimalSpecialist(specialists, campaign);

    // Create HITL task using procedure-compliant API
    const hitlTask = await this.createHITLTask({
      title: `Review: ${campaign.name} Response`,
      business_object_type: 'nanobot_response',
      business_object_id: responseId,
      discipline: campaign.discipline,
      assigned_to: selectedSpecialist.id,
      intervention_type: this.determineInterventionType(campaign),
      priority: this.calculatePriority(campaign),
      metadata: {
        campaign_id: campaign.id,
        response_type: 'supplier_selection',
        created_by_system: 'nanobot'
      }
    });

    return {
      assigned: true,
      taskId: hitlTask.id,
      specialist: selectedSpecialist,
      assignment_type: 'automated'
    };
  }

  determineInterventionType(campaign) {
    // Aligned with HITL procedure intervention types
    if (campaign.discipline === 'safety') return 'approval_required';
    if (campaign.discipline === 'procurement' && campaign.value > 50000) return 'complex_decision';
    return 'clarification_needed';
  }
}
```

### **HITL Resolution Workflow (Aligned with Procedure)**

#### **Resolution Types (Following Procedure)**
```javascript
const resolutionTypes = {
  APPROVED: {
    value: 'approved',
    description: 'Response approved as-is',
    workflow_action: 'proceed_to_next_step',
    audit_category: 'positive_decision'
  },
  REJECTED: {
    value: 'rejected',
    description: 'Response rejected - alternative required',
    workflow_action: 'block_and_redirect',
    audit_category: 'blocking_decision'
  },
  REVISION_REQUIRED: {
    value: 'revision_required',
    description: 'Response requires modifications',
    workflow_action: 'request_changes',
    audit_category: 'modification_decision'
  },
  ESCALATED: {
    value: 'escalated',
    description: 'Escalated to higher authority',
    workflow_action: 'escalate_to_supervisor',
    audit_category: 'escalation_decision'
  }
};
```

#### **Decision Propagation (Aligned with Procedure)**
```javascript
// Decision propagation to original campaign/response
async propagateHITLDecision(hitlTaskId, decision) {
  const hitlTask = await getHITLTask(hitlTaskId);
  const response = await getNANOBOTResponse(hitlTask.business_object_id);

  switch (decision.action) {
    case 'approved':
      await updateResponseStatus(response.id, 'approved');
      await triggerCampaignContinuation(hitlTask.campaign_id);
      break;

    case 'rejected':
      await updateResponseStatus(response.id, 'rejected');
      await notifyResponseRejection(response, decision.notes);
      break;

    case 'revision_required':
      await updateResponseStatus(response.id, 'revision_required');
      await sendRevisionRequest(response, decision.notes);
      break;

    case 'escalated':
      await createEscalatedHITLTask(hitlTask, decision);
      break;
  }
}
```

### **HITL Performance Monitoring (Aligned with Procedure)**

#### **Real-time Metrics Tracking**
NANOBOT provides HITL performance metrics aligned with the procedure:

```javascript
// HITL Performance Service (aligned with procedure)
class NANOBOTHITLPerformanceService {
  async getHITLPerformanceMetrics(campaignId) {
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

    const hitlTasks = await getHITLTasksForCampaign(campaignId, thirtyDaysAgo);

    return {
      totalTasks: hitlTasks.length,
      completedTasks: hitlTasks.filter(t => t.status === 'completed').length,
      completionRate: this.calculateCompletionRate(hitlTasks),
      averageResolutionTime: this.calculateAverageResolutionTime(hitlTasks),
      interventionTypes: this.categorizeInterventionTypes(hitlTasks),
      assignmentRate: this.calculateAssignmentRate(hitlTasks),
      overdueTasks: this.calculateOverdueTasks(hitlTasks),
      averageQualityScore: this.calculateAverageQualityScore(hitlTasks),
      decisionAlignmentRate: this.calculateDecisionAlignment(hitlTasks)
    };
  }

  calculateCompletionRate(tasks) {
    const completed = tasks.filter(t => t.status === 'completed').length;
    return tasks.length > 0 ? (completed / tasks.length) * 100 : 0;
  }

  calculateAverageResolutionTime(tasks) {
    const resolvedTasks = tasks.filter(t => t.resolved_at && t.created_at);
    if (resolvedTasks.length === 0) return 0;

    const totalTime = resolvedTasks.reduce((sum, task) => {
      return sum + (new Date(task.resolved_at) - new Date(task.created_at));
    }, 0);

    return Math.round((totalTime / resolvedTasks.length) / (1000 * 60 * 60)); // hours
  }
}
```

### **Chatbot Integration for HITL Resolution**

#### **HITL Task Activation in Chatbot**
Following the HITL procedure, NANOBOT integrates with chatbot for natural language resolution:

```javascript
// Chatbot HITL integration (aligned with procedure)
async activateHITLInChatbot(hitlTaskId, userId) {
  const hitlTask = await getHITLTask(hitlTaskId);

  // Initialize chatbot session with HITL context
  const session = await chatbot.createSession({
    taskId: hitlTaskId,
    interventionType: hitlTask.intervention_type,
    businessObjectType: 'nanobot_response',
    businessObjectId: hitlTask.business_object_id,
    userId: userId,
    context: {
      campaign: await getCampaign(hitlTask.campaign_id),
      response: await getNANOBOTResponse(hitlTask.business_object_id),
      discipline: hitlTask.discipline
    }
  });

  // Send initial HITL context to user
  await chatbot.sendMessage(session.id,
    `HITL Review Required: ${hitlTask.title}\n\n` +
    `Please review the ${hitlTask.discipline} response and provide your decision.`
  );

  return session;
}
```

### **Quality Assurance and Audit Trails**

#### **Comprehensive Audit Trail System**
Following the HITL procedure, NANOBOT maintains detailed audit trails:

```javascript
// Audit trail creation (aligned with procedure)
async createHITLAuditTrail(hitlTaskId, action, details) {
  const auditEntries = [
    // Main action entry
    {
      task_id: hitlTaskId,
      action: action,
      action_type: 'hitl_decision',
      notes: `HITL ${action}: ${details.decision}`,
      old_value: { status: details.previousStatus },
      new_value: { status: details.newStatus, decision: details.decision },
      metadata: {
        quality_rating: details.qualityRating,
        time_spent_minutes: details.timeSpent,
        decision_alignment: details.decisionAlignment
      }
    },
    // Decision justification
    {
      task_id: hitlTaskId,
      action: 'decision_justification',
      action_type: 'justification',
      notes: details.justification || 'Decision justification provided',
      metadata: { justification_length: details.justification?.length || 0 }
    },
    // Workflow continuation
    {
      task_id: hitlTaskId,
      action: 'workflow_continuation',
      action_type: 'continuation',
      notes: `Workflow continued based on ${details.decision} decision`
    }
  ];

  await insertAuditEntries(auditEntries);
}
```

### **Success Metrics (Aligned with Procedure)**

- [ ] < 4 hours average HITL resolution time for NANOBOT responses
- [ ] > 95% HITL task completion rate
- [ ] < 5% HITL escalation rate (responses requiring further escalation)
- [ ] > 90% user satisfaction with HITL resolution process
- [ ] > 85% decision alignment between AI assessment and human review
- [ ] Continuous improvement in response quality metrics

**Form Configuration Schema:**
```json
{
  "formId": "procurement_vendor_questionnaire",
  "discipline": "procurement",
  "title": "Vendor Capability Assessment",
  "description": "Please provide information about your company's capabilities",
  "sections": [
    {
      "id": "company_info",
      "title": "Company Information",
      "fields": [
        {
          "id": "company_name",
          "type": "text",
          "label": "Company Name",
          "required": true,
          "validation": {
            "minLength": 2,
            "maxLength": 100
          }
        },
        {
          "id": "registration_docs",
          "type": "file",
          "label": "Company Registration Documents",
          "required": true,
          "accept": ".pdf,.doc,.docx",
          "maxSize": "10MB",
          "multiple": true
        }
      ]
    },
    {
      "id": "capabilities",
      "title": "Service Capabilities
