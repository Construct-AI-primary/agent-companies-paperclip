-- =============================================================================
-- SUPABASE DATABASE SCHEMA
-- Generated: 2025-12-18T02:43:41.581Z
-- Total Tables: 428
-- Source: Supabase OpenAPI Specification
-- =============================================================================

-- Table: a_00102_admin_data
-- Administration data
CREATE TABLE IF NOT EXISTS public.a_00102_admin_data (
    id INTEGER NOT NULL,
    created_at TEXT NOT NULL
);

-- Table: a_00102_admin_vector
CREATE TABLE IF NOT EXISTS public.a_00102_admin_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    organization_id TEXT,
    user_id TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00200_commercial_vector
CREATE TABLE IF NOT EXISTS public.a_00200_commercial_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00300_construction_vector
CREATE TABLE IF NOT EXISTS public.a_00300_construction_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00435_contracts_post_data
CREATE TABLE IF NOT EXISTS public.a_00435_contracts_post_data (
    id TEXT NOT NULL,
    document_number TEXT NOT NULL,
    contract_title TEXT NOT NULL,
    contract_type TEXT,
    contractor_name TEXT,
    contract_value NUMERIC,
    currency_code TEXT,
    project_code TEXT,
    project_name TEXT,
    site_location TEXT,
    award_date TEXT,
    commencement_date TEXT,
    completion_date TEXT,
    original_value NUMERIC,
    variations NUMERIC,
    current_value NUMERIC,
    contract_status TEXT,
    progress_percentage NUMERIC,
    days_remaining INTEGER,
    required_approvals unknown,
    approval_status TEXT,
    governance_category TEXT,
    document_count INTEGER,
    last_document_date TEXT,
    template_used_id TEXT,
    created_by TEXT,
    approved_by TEXT,
    organization_id TEXT,
    tags TEXT[],
    notes TEXT,
    created_at TEXT,
    updated_at TEXT,
    signed_at TEXT
);

-- Table: a_00435_contracts_post_vector
CREATE TABLE IF NOT EXISTS public.a_00435_contracts_post_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    organisation_id TEXT,
    project_id TEXT,
    project_phase_assignment_id TEXT,
    isolation_metadata unknown,
    created_by_user_id TEXT,
    access_scope TEXT,
    shared_with_disciplines TEXT[],
    workspace_id TEXT,
    workspace_type TEXT,
    deleted_at TEXT,
    deleted_by TEXT,
    deletion_reason TEXT,
    scheduled_hard_delete_at TEXT
);

-- Table: a_00825_architectural_vector
CREATE TABLE IF NOT EXISTS public.a_00825_architectural_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00835_chemeng_vector
CREATE TABLE IF NOT EXISTS public.a_00835_chemeng_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00850_civileng_vector
CREATE TABLE IF NOT EXISTS public.a_00850_civileng_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT,
    workspace_id TEXT,
    workspace_type TEXT,
    deleted_at TEXT,
    deleted_by TEXT,
    deletion_reason TEXT,
    scheduled_hard_delete_at TEXT,
    isolation_metadata unknown
);

-- Table: a_00860_eleceng_vector
CREATE TABLE IF NOT EXISTS public.a_00860_eleceng_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00870_mecheng_vector
CREATE TABLE IF NOT EXISTS public.a_00870_mecheng_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00872_developer_vector
CREATE TABLE IF NOT EXISTS public.a_00872_developer_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00875_sales_vector
CREATE TABLE IF NOT EXISTS public.a_00875_sales_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00877_sundry_vector
CREATE TABLE IF NOT EXISTS public.a_00877_sundry_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00880_boarddir_vector
CREATE TABLE IF NOT EXISTS public.a_00880_boarddir_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00882_dirconst_vector
CREATE TABLE IF NOT EXISTS public.a_00882_dirconst_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00883_dircontracts_vector
CREATE TABLE IF NOT EXISTS public.a_00883_dircontracts_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00884_1_dirfinance_vector
CREATE TABLE IF NOT EXISTS public.a_00884_1_dirfinance_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00884_direng_vector
CREATE TABLE IF NOT EXISTS public.a_00884_direng_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00885_dirhse_vector
CREATE TABLE IF NOT EXISTS public.a_00885_dirhse_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00886_dirlogistics_vector
CREATE TABLE IF NOT EXISTS public.a_00886_dirlogistics_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00888_dirprocurement_vector
CREATE TABLE IF NOT EXISTS public.a_00888_dirprocurement_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00890_dirprojects_vector
CREATE TABLE IF NOT EXISTS public.a_00890_dirprojects_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00895_dirproject_vector
CREATE TABLE IF NOT EXISTS public.a_00895_dirproject_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_00900_doccontrol_approval_rule_steps
CREATE TABLE IF NOT EXISTS public.a_00900_doccontrol_approval_rule_steps (
    id INTEGER NOT NULL,
    rule_id INTEGER NOT NULL,
    step_order INTEGER NOT NULL,
    role_slug TEXT,
    required BOOLEAN NOT NULL,
    parallel_group_id INTEGER
);

-- Table: a_00900_doccontrol_approval_rules
CREATE TABLE IF NOT EXISTS public.a_00900_doccontrol_approval_rules (
    id INTEGER NOT NULL,
    discipline_id INTEGER,
    store_id INTEGER,
    doc_type TEXT,
    routing_mode TEXT NOT NULL,
    created_by TEXT,
    created_at TEXT NOT NULL
);

-- Table: a_00900_doccontrol_approvals
CREATE TABLE IF NOT EXISTS public.a_00900_doccontrol_approvals (
    id INTEGER NOT NULL,
    version_id INTEGER NOT NULL,
    step_order INTEGER NOT NULL,
    role_slug TEXT,
    approver_id TEXT,
    required BOOLEAN NOT NULL,
    status TEXT NOT NULL,
    acted_by TEXT,
    acted_at TEXT,
    comment TEXT,
    created_at TEXT NOT NULL
);

-- Table: a_00900_doccontrol_data
CREATE TABLE IF NOT EXISTS public.a_00900_doccontrol_data (
    id TEXT NOT NULL,
    document_id TEXT NOT NULL,
    transmittal_number TEXT,
    revision_code TEXT,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: a_00900_doccontrol_document_embeddings
-- Stores text chunks and their vector embeddings for semantic search
CREATE TABLE IF NOT EXISTS public.a_00900_doccontrol_document_embeddings (
    id TEXT NOT NULL,
    document_id TEXT NOT NULL,
    chunk_index INTEGER NOT NULL,
    chunk_text TEXT NOT NULL,
    chunk_metadata unknown,
    embedding TEXT,
    embedding_model TEXT NOT NULL,
    embedding_provider TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: a_00900_doccontrol_document_versions
CREATE TABLE IF NOT EXISTS public.a_00900_doccontrol_document_versions (
    id INTEGER NOT NULL,
    document_id TEXT NOT NULL,
    version_number INTEGER NOT NULL,
    file_path TEXT NOT NULL,
    status TEXT NOT NULL,
    submitted_at TEXT,
    approved_at TEXT,
    uploaded_at TEXT NOT NULL,
    uploaded_by TEXT,
    changes_summary TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    organization_id TEXT,
    user_id TEXT
);

-- Table: a_00900_doccontrol_documents
CREATE TABLE IF NOT EXISTS public.a_00900_doccontrol_documents (
    id TEXT NOT NULL,
    file_path TEXT NOT NULL,
    file_name TEXT NOT NULL,
    file_extension TEXT,
    uploaded_by TEXT,
    uploaded_at TEXT,
    discipline TEXT NOT NULL,
    page_number TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT,
    status TEXT,
    metadata_table_id TEXT,
    flowise_store_id TEXT,
    flowise_loader_id TEXT,
    flowise_doc_id TEXT,
    flowise_file_id TEXT,
    total_chunks INTEGER,
    total_characters INTEGER,
    flowise_status TEXT,
    size INTEGER,
    original_filename TEXT,
    storage_url TEXT,
    category_id TEXT,
    embedding_details unknown,
    is_embedded BOOLEAN,
    metadata unknown,
    storage_type TEXT,
    flowise_document_id TEXT,
    storage_path TEXT,
    store_id TEXT,
    title TEXT,
    company_id TEXT,
    organization_id TEXT,
    langchain_metadata unknown,
    langchain_loader_type TEXT,
    langchain_processing_status TEXT,
    langchain_trace_id TEXT,
    langchain_chunk_count INTEGER,
    langchain_embedding_model TEXT,
    langchain_embedding_provider TEXT,
    langchain_processed_at TEXT,
    user_id TEXT
);

-- Table: a_00900_doccontrol_langchain_jobs
-- Manages async LangChain processing jobs for documents
CREATE TABLE IF NOT EXISTS public.a_00900_doccontrol_langchain_jobs (
    id TEXT NOT NULL,
    document_id TEXT NOT NULL,
    job_type TEXT NOT NULL,
    status TEXT NOT NULL,
    priority INTEGER,
    job_config unknown,
    started_at TEXT,
    completed_at TEXT,
    error_message TEXT,
    retry_count INTEGER,
    max_retries INTEGER,
    trace_id TEXT,
    langsmith_run_id TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: a_00900_doccontrol_vector
CREATE TABLE IF NOT EXISTS public.a_00900_doccontrol_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT,
    workspace_id TEXT,
    workspace_type TEXT,
    deleted_at TEXT,
    deleted_by TEXT,
    deletion_reason TEXT,
    scheduled_hard_delete_at TEXT,
    isolation_metadata unknown
);

-- Table: a_00900_user_langchain_settings
-- Stores user-specific LangChain configuration settings
CREATE TABLE IF NOT EXISTS public.a_00900_user_langchain_settings (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    organization_id TEXT,
    llm_provider TEXT,
    llm_model TEXT,
    llm_api_key_encrypted TEXT,
    llm_base_url TEXT,
    llm_temperature NUMERIC,
    llm_max_tokens INTEGER,
    llm_timeout INTEGER,
    embedding_provider TEXT,
    embedding_model TEXT,
    embedding_api_key_encrypted TEXT,
    embedding_base_url TEXT,
    embedding_dimensions INTEGER,
    embedding_batch_size INTEGER,
    text_chunk_size INTEGER,
    text_chunk_overlap INTEGER,
    text_separators unknown,
    text_keep_separator BOOLEAN,
    text_length_function TEXT,
    enable_embeddings BOOLEAN,
    enable_summarization BOOLEAN,
    enable_keyword_extraction BOOLEAN,
    enable_entity_extraction BOOLEAN,
    batch_processing BOOLEAN,
    max_concurrent_jobs INTEGER,
    retry_attempts INTEGER,
    retry_delay INTEGER,
    langsmith_enabled BOOLEAN,
    langsmith_api_key_encrypted TEXT,
    langsmith_project_name TEXT,
    langsmith_endpoint TEXT,
    langsmith_tracing_enabled BOOLEAN,
    langsmith_evaluation_enabled BOOLEAN,
    vector_store_provider TEXT,
    vector_store_connection_string_encrypted TEXT,
    vector_store_table_name TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: a_00test
CREATE TABLE IF NOT EXISTS public.a_00test (
    id TEXT NOT NULL,
    content TEXT NOT NULL,
    metadata unknown,
    embedding TEXT
);

-- Table: a_01000_environmental_vector
CREATE TABLE IF NOT EXISTS public.a_01000_environmental_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_01100_ethics_vector
CREATE TABLE IF NOT EXISTS public.a_01100_ethics_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_01200_finance_vector
CREATE TABLE IF NOT EXISTS public.a_01200_finance_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_01300_governance_vector
CREATE TABLE IF NOT EXISTS public.a_01300_governance_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_01400_health_vector
CREATE TABLE IF NOT EXISTS public.a_01400_health_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_01500_hr_candidate_evaluation
CREATE TABLE IF NOT EXISTS public.a_01500_hr_candidate_evaluation (
    id TEXT NOT NULL,
    submission_date TEXT,
    first_name TEXT,
    surname TEXT,
    phone TEXT,
    city TEXT,
    province_state TEXT,
    country TEXT,
    job_reference_no TEXT,
    discipline TEXT,
    email TEXT,
    educational TEXT,
    job_history TEXT,
    skills TEXT,
    summarize TEXT,
    vote NUMERIC,
    consideration TEXT,
    full_name TEXT
);

-- Table: a_01500_hr_vector
CREATE TABLE IF NOT EXISTS public.a_01500_hr_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    organisation_id TEXT,
    project_id TEXT,
    project_phase_assignment_id TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    shared_with_disciplines TEXT
);

-- Table: a_01600_localcontent_vector
CREATE TABLE IF NOT EXISTS public.a_01600_localcontent_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_01700_logistics_vector
CREATE TABLE IF NOT EXISTS public.a_01700_logistics_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_01750_legal_vector
CREATE TABLE IF NOT EXISTS public.a_01750_legal_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_01800_operations_vector
CREATE TABLE IF NOT EXISTS public.a_01800_operations_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_01850_otherparties_vector
CREATE TABLE IF NOT EXISTS public.a_01850_otherparties_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_01900_procurement_vector
CREATE TABLE IF NOT EXISTS public.a_01900_procurement_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id TEXT,
    access_scope TEXT,
    organisation_id TEXT,
    shared_with_disciplines TEXT,
    workspace_id TEXT,
    workspace_type TEXT,
    deleted_at TEXT,
    deleted_by TEXT,
    deletion_reason TEXT,
    scheduled_hard_delete_at TEXT,
    isolation_metadata unknown,
    discipline_code TEXT
);

-- Table: a_02025_invoice_processing
CREATE TABLE IF NOT EXISTS public.a_02025_invoice_processing (
    id TEXT NOT NULL,
    invoice_no TEXT NOT NULL,
    amount NUMERIC NOT NULL,
    due_date TEXT NOT NULL,
    supplier_name TEXT NOT NULL,
    category TEXT,
    company TEXT,
    project TEXT,
    contract_type TEXT,
    contractor TEXT,
    contract TEXT,
    created_at TEXT,
    updated_at TEXT,
    description TEXT
);

-- Table: a_02025_qs_data
-- QuantUM Quantity Surveying Data Table - Stores drawings and measurements with full audit trails and compliance tracking
CREATE TABLE IF NOT EXISTS public.a_02025_qs_data (
    id INTEGER NOT NULL,
    created_at TEXT NOT NULL,
    company_id TEXT,
    project_id TEXT,
    contract_type TEXT,
    contractor_id TEXT,
    contract_id TEXT,
    identifier TEXT,
    allocation_values TEXT[],
    selected_storage_id TEXT,
    data_storage_update_mode TEXT,
    doc_type_value TEXT,
    doc_type_values TEXT[],
    text_input TEXT,
    selected_file TEXT,
    text_class_value TEXT,
    data_type TEXT,
    title TEXT,
    scale TEXT,
    approval_status TEXT,
    measurement_type TEXT,
    value NUMERIC,
    unit TEXT,
    status TEXT,
    element_type TEXT,
    element_identifier TEXT,
    asaqs_compliant BOOLEAN,
    sans_compliant BOOLEAN,
    measured_by TEXT,
    recorded_by TEXT
);

-- Table: a_02025_qs_vector
CREATE TABLE IF NOT EXISTS public.a_02025_qs_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_02035_scheduling_vector
CREATE TABLE IF NOT EXISTS public.a_02035_scheduling_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_02050_it_vector
CREATE TABLE IF NOT EXISTS public.a_02050_it_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_02050_logistics_data
CREATE TABLE IF NOT EXISTS public.a_02050_logistics_data (
    id INTEGER NOT NULL,
    created_at TEXT NOT NULL
);

-- Table: a_02075_inspection_data
CREATE TABLE IF NOT EXISTS public.a_02075_inspection_data (
    id TEXT NOT NULL,
    inspection_date TEXT NOT NULL,
    inspector_name TEXT,
    inspection_type TEXT,
    location TEXT,
    status TEXT,
    findings TEXT,
    recommendations TEXT,
    company TEXT,
    project TEXT,
    contract_type TEXT,
    contractor TEXT,
    contract TEXT,
    attachments unknown,
    metadata unknown,
    category TEXT,
    processing_status TEXT,
    error_message TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: a_02075_inspection_vector
CREATE TABLE IF NOT EXISTS public.a_02075_inspection_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_02075_knowledge_base
CREATE TABLE IF NOT EXISTS public.a_02075_knowledge_base (
    doc_types TEXT,
    type_equipment TEXT,
    type_component TEXT,
    type_item TEXT,
    revision_date TEXT,
    media TEXT,
    research_frequency TEXT,
    last_search_date TEXT,
    time TEXT,
    external_sources TEXT,
    id TEXT NOT NULL,
    next_search_date TEXT,
    comments TEXT,
    knowledge_type unknown,
    knowledge_owner TEXT,
    owner_email TEXT,
    owner_first_name TEXT,
    owner_last_name TEXT,
    source_url TEXT
);

-- Table: a_02075_knowledge_base_data
CREATE TABLE IF NOT EXISTS public.a_02075_knowledge_base_data (
    id TEXT NOT NULL,
    url TEXT,
    original_search_result TEXT,
    original_search_summary TEXT,
    search_intent TEXT,
    writing_style TEXT,
    writing_tone TEXT,
    hidden_insight TEXT,
    target_audience TEXT,
    goal_of_article TEXT,
    semantic_analysis TEXT,
    common_subtopics TEXT,
    related_questions TEXT,
    keywords TEXT,
    primary_keyword TEXT,
    secondary_keywords TEXT,
    semantic_keywords TEXT,
    long_tail_keywords TEXT,
    re_written_article TEXT
);

-- Table: a_02100_pr_media
-- Table storing platform content data including video metrics and related content
CREATE TABLE IF NOT EXISTS public.a_02100_pr_media (
    id INTEGER NOT NULL,
    platform TEXT NOT NULL,
    channel_name TEXT,
    channel_url TEXT,
    views INTEGER,
    likes INTEGER,
    comments INTEGER,
    video_url TEXT,
    video_description TEXT,
    video_title TEXT,
    video_tags TEXT[],
    video_summary TEXT,
    script_summary TEXT,
    transcript TEXT,
    created_at TEXT,
    updated_at TEXT,
    image_title TEXT
);

-- Table: a_02100_publicrel_vector
CREATE TABLE IF NOT EXISTS public.a_02100_publicrel_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_02200_qa_vector
CREATE TABLE IF NOT EXISTS public.a_02200_qa_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_02250_qc_vector
CREATE TABLE IF NOT EXISTS public.a_02250_qc_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_02400_contractor_vetting_data
-- Contractor vetting specific metadata
CREATE TABLE IF NOT EXISTS public.a_02400_contractor_vetting_data (
    id TEXT NOT NULL,
    document_id TEXT NOT NULL,
    contractor_name TEXT,
    evaluation_score INTEGER,
    confidence_level INTEGER,
    commentary TEXT,
    extracted_data unknown,
    ai_analysis unknown,
    created_at TEXT,
    updated_at TEXT
);

-- Table: a_02400_contractor_vetting_document_versions
-- Version history for contractor vetting documents
CREATE TABLE IF NOT EXISTS public.a_02400_contractor_vetting_document_versions (
    id TEXT NOT NULL,
    document_id TEXT NOT NULL,
    version_number INTEGER NOT NULL,
    file_path TEXT NOT NULL,
    uploaded_at TEXT,
    uploaded_by TEXT,
    changes_summary TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: a_02400_contractor_vetting_documents
-- Contractor vetting documents integrated with 00900 document control system
CREATE TABLE IF NOT EXISTS public.a_02400_contractor_vetting_documents (
    id TEXT NOT NULL,
    file_path TEXT NOT NULL,
    file_name TEXT NOT NULL,
    file_extension TEXT,
    uploaded_by TEXT,
    uploaded_at TEXT,
    current_version_id TEXT,
    discipline TEXT NOT NULL,
    page_number TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT,
    status TEXT,
    metadata_table_id TEXT,
    vetting_id INTEGER,
    section_id INTEGER,
    document_type TEXT,
    processing_status TEXT,
    processing_result TEXT,
    document_hash TEXT,
    content_hash TEXT,
    storage_path TEXT,
    department_id TEXT,
    version_number TEXT,
    retention_policy TEXT,
    legal_hold BOOLEAN
);

-- Table: a_02400_safety_data
-- RLS disabled for testing
CREATE TABLE IF NOT EXISTS public.a_02400_safety_data (
    id INTEGER NOT NULL,
    filename TEXT NOT NULL,
    originalname TEXT NOT NULL,
    filetype TEXT NOT NULL,
    companyid INTEGER NOT NULL,
    projectid INTEGER NOT NULL,
    contractid INTEGER NOT NULL,
    contracttypeid INTEGER NOT NULL,
    mimetype TEXT NOT NULL,
    filesize INTEGER NOT NULL,
    filepath TEXT NOT NULL,
    uploaddate TEXT NOT NULL,
    userrole TEXT NOT NULL,
    created_at TEXT
);

-- Table: a_02400_safety_vector
-- RLS disabled for testing
CREATE TABLE IF NOT EXISTS public.a_02400_safety_vector (
    id INTEGER NOT NULL,
    content TEXT NOT NULL,
    safetydataid INTEGER,
    companyid INTEGER NOT NULL,
    projectid INTEGER NOT NULL,
    contractid INTEGER NOT NULL,
    contracttypeid INTEGER NOT NULL,
    embedding TEXT,
    userrole TEXT NOT NULL,
    created_at TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_02500_security_vector
CREATE TABLE IF NOT EXISTS public.a_02500_security_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_03000_landscaping_vector
CREATE TABLE IF NOT EXISTS public.a_03000_landscaping_vector (
    id TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    content TEXT,
    created_by_user_id INTEGER,
    access_scope TEXT,
    organisation_id INTEGER,
    shared_with_disciplines TEXT
);

-- Table: a_performance_docs_vector
CREATE TABLE IF NOT EXISTS public.a_performance_docs_vector (
    id TEXT NOT NULL,
    discipline_code TEXT,
    document_type TEXT,
    title TEXT,
    content TEXT,
    embedding TEXT,
    metadata unknown,
    tags TEXT[],
    last_updated TEXT
);

-- Table: accordion_options
CREATE TABLE IF NOT EXISTS public.accordion_options (
    id INTEGER NOT NULL,
    name TEXT NOT NULL,
    parent_id INTEGER,
    menu_level INTEGER NOT NULL,
    display_order INTEGER NOT NULL
);

-- Table: accordion_sections
CREATE TABLE IF NOT EXISTS public.accordion_sections (
    id TEXT NOT NULL,
    section_key TEXT NOT NULL,
    title TEXT NOT NULL,
    option_id INTEGER NOT NULL,
    sector TEXT NOT NULL,
    parent_section_key TEXT,
    display_order INTEGER NOT NULL,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    hierarchy_level INTEGER,
    is_virtual BOOLEAN,
    description TEXT,
    icon_class TEXT,
    organization_id TEXT
);

-- Table: accordion_sections_directors_backup_20250726
CREATE TABLE IF NOT EXISTS public.accordion_sections_directors_backup_20250726 (
    id TEXT,
    section_key TEXT,
    title TEXT,
    option_id INTEGER,
    sector TEXT,
    parent_section_key TEXT,
    display_order INTEGER,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: accordion_structure
-- Complete view of accordion structure using existing section_organization_mapping
CREATE TABLE IF NOT EXISTS public.accordion_structure (
    section_id TEXT,
    section_key TEXT,
    section_name TEXT,
    section_description TEXT,
    section_icon TEXT,
    organization_id TEXT,
    project_id TEXT,
    phase_id TEXT,
    section_display_order INTEGER,
    is_visible BOOLEAN,
    page_id TEXT,
    page_name TEXT,
    page_slug TEXT,
    page_display_order INTEGER,
    is_subsection BOOLEAN,
    parent_page_id TEXT,
    organization_name TEXT,
    project_name TEXT,
    phase_name TEXT
);

-- Table: active_entities
CREATE TABLE IF NOT EXISTS public.active_entities (
    id TEXT NOT NULL,
    user_id TEXT,
    company_id TEXT,
    organisation_id TEXT,
    project_id TEXT,
    project_phase_id TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    organization_id TEXT
);

-- Table: active_security_alerts
CREATE TABLE IF NOT EXISTS public.active_security_alerts (
    id TEXT,
    alert_type TEXT,
    severity TEXT,
    title TEXT,
    description TEXT,
    user_id TEXT,
    api_config_id TEXT,
    ip_address TEXT,
    user_agent TEXT,
    metadata unknown,
    acknowledged BOOLEAN,
    acknowledged_by TEXT,
    acknowledged_at TEXT,
    resolved BOOLEAN,
    resolved_at TEXT,
    created_at TEXT
);

-- Table: active_templates
CREATE TABLE IF NOT EXISTS public.active_templates (
    id TEXT,
    type TEXT,
    name TEXT,
    description TEXT,
    version TEXT,
    prompt_template TEXT,
    validation_config unknown,
    ui_config unknown,
    is_active BOOLEAN,
    is_public BOOLEAN,
    created_by TEXT,
    updated_by TEXT,
    usage_count INTEGER,
    success_rate NUMERIC,
    average_generation_time INTEGER,
    tags TEXT[],
    created_at TEXT,
    updated_at TEXT,
    discipline_code TEXT,
    document_type TEXT,
    discipline TEXT,
    copied_from_template_id TEXT,
    template_scope TEXT,
    target_discipline TEXT,
    copy_metadata unknown,
    processing_status TEXT,
    organization_id TEXT,
    suitable_for_document_types TEXT[],
    category TEXT,
    deleted_at TEXT,
    deleted_by TEXT,
    deletion_reason TEXT
);

-- Table: active_users_travel_docs
CREATE TABLE IF NOT EXISTS public.active_users_travel_docs (
    user_id TEXT,
    email TEXT,
    full_name TEXT,
    passport_number TEXT,
    passport_expiry_date TEXT,
    passport_issuing_country TEXT,
    alternative_travel_docs unknown,
    nationality TEXT,
    residence_country TEXT,
    emergency_contact unknown,
    active BOOLEAN,
    updated_at TEXT
);

-- Table: agent_activity_log
CREATE TABLE IF NOT EXISTS public.agent_activity_log (
    id TEXT NOT NULL,
    agent_id TEXT NOT NULL,
    human_user_id TEXT,
    session_id TEXT,
    action_type TEXT NOT NULL,
    resource_type TEXT NOT NULL,
    resource_id TEXT,
    action_details unknown,
    safety_metrics unknown,
    ip_address TEXT,
    user_agent TEXT,
    confidence_score NUMERIC,
    processing_time_ms INTEGER,
    created_at TEXT
);

-- Table: agent_context_boundaries
CREATE TABLE IF NOT EXISTS public.agent_context_boundaries (
    id TEXT NOT NULL,
    agent_id TEXT NOT NULL,
    boundary_type TEXT NOT NULL,
    boundary_id TEXT NOT NULL,
    access_level TEXT,
    created_by TEXT NOT NULL,
    created_at TEXT
);

-- Table: agent_modal_assignments
CREATE TABLE IF NOT EXISTS public.agent_modal_assignments (
    id INTEGER NOT NULL,
    modal_configuration_id TEXT NOT NULL,
    page_id TEXT NOT NULL,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    last_used TEXT,
    agent_name TEXT NOT NULL
);

-- Table: agent_permissions
-- Manages role-based access control for AI agents
CREATE TABLE IF NOT EXISTS public.agent_permissions (
    id TEXT NOT NULL,
    agent_id TEXT NOT NULL,
    role_id INTEGER NOT NULL,
    has_access BOOLEAN NOT NULL,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    updated_by TEXT
);

-- Table: agent_profiles
CREATE TABLE IF NOT EXISTS public.agent_profiles (
    id TEXT NOT NULL,
    user_type TEXT,
    agent_metadata unknown,
    created_at TEXT,
    updated_at TEXT
);

-- Table: agent_roles
CREATE TABLE IF NOT EXISTS public.agent_roles (
    id TEXT NOT NULL,
    role_name TEXT NOT NULL,
    description TEXT,
    capabilities unknown,
    safety_restrictions unknown,
    max_requests_per_hour INTEGER,
    context_isolation_level TEXT,
    audit_level TEXT,
    created_at TEXT
);

-- Table: agent_sequence_operations
CREATE TABLE IF NOT EXISTS public.agent_sequence_operations (
    id TEXT NOT NULL,
    organization_id TEXT,
    agent_id TEXT NOT NULL,
    agent_version TEXT,
    operation TEXT NOT NULL,
    resource_type TEXT NOT NULL,
    resource_id TEXT,
    disciplines unknown,
    input_data unknown,
    output_data unknown,
    processing_time_ms INTEGER,
    confidence_score NUMERIC,
    success BOOLEAN,
    error_message TEXT,
    ip_address TEXT,
    user_agent TEXT,
    created_at TEXT
);

-- Table: agent_sessions
CREATE TABLE IF NOT EXISTS public.agent_sessions (
    id TEXT NOT NULL,
    agent_id TEXT NOT NULL,
    human_user_id TEXT,
    session_context unknown,
    started_at TEXT,
    expires_at TEXT,
    is_active BOOLEAN,
    safety_metrics unknown
);

-- Table: agent_template_integrations
CREATE TABLE IF NOT EXISTS public.agent_template_integrations (
    id TEXT NOT NULL,
    form_template_id TEXT,
    agent_id TEXT,
    integration_type TEXT NOT NULL,
    trigger_fields unknown,
    agent_actions unknown,
    is_active BOOLEAN,
    priority INTEGER,
    error_handling TEXT
);

-- Table: agents_tracking
-- Tracks AI agents by company, sector, organization, phase, and page assignments
CREATE TABLE IF NOT EXISTS public.agents_tracking (
    id TEXT NOT NULL,
    agent_name TEXT NOT NULL,
    company TEXT,
    sector TEXT,
    organization TEXT,
    phase TEXT,
    page_id TEXT,
    page_name TEXT,
    page_prefix TEXT,
    contributor_id TEXT,
    created_at TEXT,
    updated_at TEXT,
    is_active BOOLEAN,
    notes TEXT,
    last_used TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: agents_unified
CREATE TABLE IF NOT EXISTS public.agents_unified (
    id TEXT,
    agent_name TEXT,
    company TEXT,
    sector TEXT,
    organization TEXT,
    phase TEXT,
    page_name TEXT,
    page_prefix TEXT,
    is_active BOOLEAN,
    notes TEXT,
    created_at TEXT,
    updated_at TEXT,
    last_used TEXT,
    modal_assignments INTEGER
);

-- Table: alert_configurations
CREATE TABLE IF NOT EXISTS public.alert_configurations (
    id TEXT NOT NULL,
    alert_type TEXT NOT NULL,
    threshold_value NUMERIC NOT NULL,
    threshold_operator TEXT NOT NULL,
    enabled BOOLEAN NOT NULL,
    notification_channels TEXT[],
    discipline_code TEXT,
    created_by TEXT,
    created_at TEXT
);

-- Table: api_health_checks
-- Automated health monitoring results for API endpoints
CREATE TABLE IF NOT EXISTS public.api_health_checks (
    id TEXT NOT NULL,
    api_config_id TEXT NOT NULL,
    check_type TEXT NOT NULL,
    status TEXT NOT NULL,
    response_time INTEGER,
    status_code INTEGER,
    error_message TEXT,
    metadata unknown,
    checked_at TEXT NOT NULL,
    next_check_at TEXT
);

-- Table: api_usage_metrics
-- Detailed usage metrics and performance data for API configurations
CREATE TABLE IF NOT EXISTS public.api_usage_metrics (
    id TEXT NOT NULL,
    api_config_id TEXT NOT NULL,
    user_id TEXT,
    discipline_code TEXT,
    request_count INTEGER NOT NULL,
    success_count INTEGER NOT NULL,
    error_count INTEGER NOT NULL,
    average_response_time INTEGER,
    total_tokens_used INTEGER,
    cost_estimate NUMERIC,
    rate_limit_hits INTEGER NOT NULL,
    last_request_at TEXT,
    period_start TEXT NOT NULL,
    period_end TEXT NOT NULL,
    metadata unknown,
    created_at TEXT NOT NULL
);

-- Table: api_usage_summary
CREATE TABLE IF NOT EXISTS public.api_usage_summary (
    api_config_id TEXT,
    discipline_code TEXT,
    total_requests INTEGER,
    total_success INTEGER,
    total_errors INTEGER,
    avg_response_time NUMERIC,
    last_request TEXT
);

-- Table: approval_cover_sheets
-- Generated approval cover sheets for procurement orders
CREATE TABLE IF NOT EXISTS public.approval_cover_sheets (
    id TEXT NOT NULL,
    procurement_order_id TEXT NOT NULL,
    html_content TEXT NOT NULL,
    approval_matrix unknown,
    generated_at TEXT,
    status TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: approval_delegations
-- Approval delegation management for when users are unavailable
CREATE TABLE IF NOT EXISTS public.approval_delegations (
    id TEXT NOT NULL,
    delegator_user_id TEXT,
    delegate_user_id TEXT,
    role_filter TEXT,
    department_filter TEXT,
    start_date TEXT,
    end_date TEXT,
    is_active BOOLEAN,
    reason TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: approval_document_links
CREATE TABLE IF NOT EXISTS public.approval_document_links (
    id TEXT NOT NULL,
    approval_instance_id TEXT NOT NULL,
    document_id TEXT,
    document_source TEXT,
    version_number TEXT,
    file_path TEXT,
    created_at TEXT
);

-- Table: approval_history_log
-- Complete audit trail of all approval actions
CREATE TABLE IF NOT EXISTS public.approval_history_log (
    id TEXT NOT NULL,
    approval_instance_id TEXT,
    approval_step_id TEXT,
    action TEXT NOT NULL,
    actor_user_id TEXT,
    target_user_id TEXT,
    old_values unknown,
    new_values unknown,
    comments TEXT,
    ip_address TEXT,
    user_agent TEXT,
    created_at TEXT
);

-- Table: approval_instances
-- Individual approval instances for specific documents
CREATE TABLE IF NOT EXISTS public.approval_instances (
    id TEXT NOT NULL,
    workflow_template_id TEXT,
    document_id TEXT,
    document_type TEXT NOT NULL,
    document_reference TEXT NOT NULL,
    document_title TEXT,
    current_step INTEGER,
    total_steps INTEGER,
    status TEXT,
    priority TEXT,
    initiated_by TEXT NOT NULL,
    initiated_at TEXT,
    due_date TEXT,
    completed_at TEXT,
    metadata unknown,
    notes TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: approval_steps
-- Individual approval steps within an approval workflow
CREATE TABLE IF NOT EXISTS public.approval_steps (
    id TEXT NOT NULL,
    approval_instance_id TEXT,
    step_order INTEGER NOT NULL,
    step_name TEXT,
    approver_role TEXT NOT NULL,
    approver_user_id TEXT,
    assigned_at TEXT,
    status TEXT,
    decision_date TEXT,
    comments TEXT,
    rejection_reason TEXT,
    esignature_data unknown,
    escalation_date TEXT,
    escalated_at TEXT,
    escalated_to TEXT,
    is_required BOOLEAN,
    is_parallel BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: approval_workflow_templates
-- Governance-managed approval workflow templates for different document types
CREATE TABLE IF NOT EXISTS public.approval_workflow_templates (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    department TEXT NOT NULL,
    document_type TEXT NOT NULL,
    approval_matrix unknown NOT NULL,
    conditions unknown,
    requires_esignature BOOLEAN,
    escalation_hours INTEGER,
    is_active BOOLEAN,
    created_by TEXT,
    updated_by TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: approval_workflows
CREATE TABLE IF NOT EXISTS public.approval_workflows (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    department TEXT,
    role TEXT,
    approvers unknown,
    escalation_rules unknown,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: audit_log
CREATE TABLE IF NOT EXISTS public.audit_log (
    id INTEGER NOT NULL,
    action TEXT NOT NULL,
    table_name TEXT,
    user_id TEXT,
    record_id TEXT,
    details unknown,
    created_at TEXT
);

-- Table: available_companies
CREATE TABLE IF NOT EXISTS public.available_companies (
    company_name TEXT,
    source TEXT
);

-- Table: button_options
CREATE TABLE IF NOT EXISTS public.button_options (
    id INTEGER NOT NULL,
    name TEXT NOT NULL,
    button_id TEXT NOT NULL,
    page_id TEXT NOT NULL,
    display_order INTEGER NOT NULL,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: chat_analytics
-- Analytics data for IT dashboard and usage monitoring
CREATE TABLE IF NOT EXISTS public.chat_analytics (
    id TEXT NOT NULL,
    session_id TEXT,
    user_id TEXT,
    discipline_code TEXT NOT NULL,
    chatbot_type TEXT NOT NULL,
    company_id TEXT,
    company_name TEXT,
    organisation_id TEXT,
    organisation_name TEXT,
    project_id TEXT,
    project_name TEXT,
    project_phase_id TEXT,
    project_phase_name TEXT,
    query_type TEXT,
    query_category TEXT,
    response_quality_score NUMERIC,
    user_satisfaction_rating INTEGER,
    response_time_ms INTEGER,
    documents_found INTEGER,
    documents_relevant INTEGER,
    session_duration_minutes INTEGER,
    messages_in_session INTEGER,
    time_of_day INTEGER,
    day_of_week INTEGER,
    user_feedback TEXT,
    improvement_suggestions TEXT,
    error_occurred BOOLEAN,
    error_type TEXT,
    created_at TEXT,
    metadata unknown
);

-- Table: chat_messages
-- Stores individual chat messages with AI processing metadata
CREATE TABLE IF NOT EXISTS public.chat_messages (
    id TEXT NOT NULL,
    session_id TEXT,
    role TEXT NOT NULL,
    content TEXT NOT NULL,
    citations unknown,
    document_count INTEGER,
    documents_accessed unknown,
    ai_model_used TEXT,
    processing_time_ms INTEGER,
    token_count INTEGER,
    search_query TEXT,
    search_results_count INTEGER,
    vector_similarity_scores unknown,
    user_rating INTEGER,
    user_feedback TEXT,
    was_helpful BOOLEAN,
    created_at TEXT,
    metadata unknown
);

-- Table: chat_sessions
-- Stores chat sessions with full project context from active_entities
CREATE TABLE IF NOT EXISTS public.chat_sessions (
    id TEXT NOT NULL,
    user_id TEXT,
    discipline_code TEXT NOT NULL,
    chatbot_type TEXT NOT NULL,
    company_id TEXT,
    company_name TEXT,
    organisation_id TEXT,
    organisation_name TEXT,
    project_id TEXT,
    project_name TEXT,
    project_phase_id TEXT,
    project_phase_name TEXT,
    session_title TEXT,
    session_summary TEXT,
    total_messages INTEGER,
    total_documents_referenced INTEGER,
    created_at TEXT,
    updated_at TEXT,
    last_activity_at TEXT,
    is_active BOOLEAN,
    is_archived BOOLEAN,
    metadata unknown,
    avg_response_time_ms INTEGER,
    total_processing_time_ms INTEGER
);

-- Table: chatbot_audit_logs
-- Comprehensive audit trail for all chatbot and API access activities
CREATE TABLE IF NOT EXISTS public.chatbot_audit_logs (
    id TEXT NOT NULL,
    user_id TEXT,
    user_email TEXT,
    action TEXT NOT NULL,
    resource_type TEXT NOT NULL,
    resource_id TEXT,
    discipline_code TEXT,
    ip_address TEXT,
    user_agent TEXT,
    success BOOLEAN NOT NULL,
    error_message TEXT,
    metadata unknown,
    created_at TEXT NOT NULL
);

-- Table: chatbot_interactions
CREATE TABLE IF NOT EXISTS public.chatbot_interactions (
    interaction_id TEXT NOT NULL,
    session_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    page_id TEXT NOT NULL,
    interaction_type TEXT NOT NULL,
    content TEXT NOT NULL,
    metadata unknown,
    created_at TEXT NOT NULL
);

-- Table: chatbot_pages
CREATE TABLE IF NOT EXISTS public.chatbot_pages (
    id TEXT NOT NULL,
    page_id TEXT NOT NULL,
    page_name TEXT NOT NULL,
    category TEXT NOT NULL,
    chatbot_type TEXT NOT NULL,
    has_chatbot BOOLEAN NOT NULL,
    vector_table_name TEXT,
    description TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);

-- Table: chatbot_performance_metrics
CREATE TABLE IF NOT EXISTS public.chatbot_performance_metrics (
    metric_id TEXT NOT NULL,
    page_id TEXT NOT NULL,
    user_id TEXT,
    session_id TEXT,
    metric_type TEXT NOT NULL,
    metric_value NUMERIC,
    metadata unknown,
    recorded_at TEXT NOT NULL
);

-- Table: chatbot_performance_summary
CREATE TABLE IF NOT EXISTS public.chatbot_performance_summary (
    page_id TEXT,
    metric_type TEXT,
    metric_count INTEGER,
    avg_value NUMERIC,
    min_value NUMERIC,
    max_value NUMERIC,
    hour_recorded TEXT
);

-- Table: chatbot_permissions
-- Fine-grained permissions for chatbot access by page and role
CREATE TABLE IF NOT EXISTS public.chatbot_permissions (
    id TEXT NOT NULL,
    page_id TEXT NOT NULL,
    role_id INTEGER NOT NULL,
    has_access BOOLEAN NOT NULL,
    granted_by TEXT,
    granted_at TEXT NOT NULL,
    expires_at TEXT,
    metadata unknown,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);

-- Table: chatbot_sessions
CREATE TABLE IF NOT EXISTS public.chatbot_sessions (
    session_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    page_id TEXT NOT NULL,
    discipline_code TEXT NOT NULL,
    chat_type TEXT NOT NULL,
    current_state TEXT,
    session_data unknown,
    started_at TEXT NOT NULL,
    ended_at TEXT,
    total_interactions INTEGER,
    last_activity_at TEXT
);

-- Table: chatbot_usage_analytics
CREATE TABLE IF NOT EXISTS public.chatbot_usage_analytics (
    page_id TEXT,
    total_sessions INTEGER,
    unique_users INTEGER,
    total_interactions INTEGER,
    avg_session_minutes NUMERIC,
    chat_type TEXT,
    discipline_code TEXT,
    session_date TEXT
);

-- Table: chatbot_vector_configs
CREATE TABLE IF NOT EXISTS public.chatbot_vector_configs (
    config_id TEXT NOT NULL,
    page_id TEXT NOT NULL,
    vector_table_name TEXT NOT NULL,
    search_enabled BOOLEAN,
    search_threshold NUMERIC,
    max_results INTEGER,
    filters unknown,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);

-- Table: chatbots
-- Stores configurations for chatbots, mapping pages and states to Flowise flow IDs.
CREATE TABLE IF NOT EXISTS public.chatbots (
    page TEXT NOT NULL,
    state TEXT NOT NULL,
    flow_id TEXT NOT NULL,
    input_placeholder TEXT,
    sector TEXT,
    sector_id TEXT,
    updated_at TEXT
);

-- Table: chatbots_backup
CREATE TABLE IF NOT EXISTS public.chatbots_backup (
    page TEXT,
    state TEXT,
    flow_id TEXT,
    input_placeholder TEXT,
    sector TEXT,
    sector_id TEXT,
    updated_at TEXT
);

-- Table: civil_engineering_document_links
-- Junction table for linking civil engineering documents to other documents and references
CREATE TABLE IF NOT EXISTS public.civil_engineering_document_links (
    id TEXT NOT NULL,
    document_id TEXT NOT NULL,
    linked_document_id TEXT,
    linked_document_type TEXT,
    reference_type TEXT,
    link_description TEXT,
    link_created_by TEXT,
    link_created_at TEXT,
    project_phase TEXT,
    document_section TEXT,
    organization_id TEXT
);

-- Table: civil_engineering_documents
-- Dedicated table for civil engineering technical documents (adapted from procurement orders workflow)
CREATE TABLE IF NOT EXISTS public.civil_engineering_documents (
    id TEXT NOT NULL,
    document_number TEXT,
    document_type TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    discipline TEXT,
    priority TEXT,
    engineering_standard TEXT,
    design_code TEXT,
    project_phase TEXT,
    project_id TEXT,
    project_location TEXT,
    project_scale TEXT,
    template_id TEXT,
    linked_documents unknown,
    approval_status TEXT,
    issue_date TEXT,
    revision_date TEXT,
    review_deadline TEXT,
    technical_requirements TEXT,
    compliance_requirements TEXT,
    quality_standards TEXT,
    created_by TEXT NOT NULL,
    organization_id TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: companies
CREATE TABLE IF NOT EXISTS public.companies (
    name TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT,
    active BOOLEAN,
    id TEXT NOT NULL,
    organization_id TEXT,
    user_id TEXT
);

-- Table: complete_epcm_accordion
CREATE TABLE IF NOT EXISTS public.complete_epcm_accordion (
    section_key TEXT,
    title TEXT,
    option_id INTEGER,
    sector TEXT,
    parent_section_key TEXT,
    display_order INTEGER,
    organization_id TEXT,
    is_visible BOOLEAN,
    organization_name TEXT,
    section_type TEXT,
    page_number INTEGER
);

-- Table: compliance_checks
-- Compliance monitoring results for various regulatory frameworks
CREATE TABLE IF NOT EXISTS public.compliance_checks (
    id TEXT NOT NULL,
    check_type TEXT NOT NULL,
    resource_type TEXT NOT NULL,
    resource_id TEXT,
    status TEXT NOT NULL,
    check_result unknown NOT NULL,
    checked_by TEXT,
    checked_at TEXT NOT NULL,
    next_check_at TEXT,
    remediation_required BOOLEAN NOT NULL,
    remediation_notes TEXT,
    metadata unknown
);

-- Table: compliance_reports
CREATE TABLE IF NOT EXISTS public.compliance_reports (
    id INTEGER NOT NULL,
    report_id TEXT NOT NULL,
    project_id TEXT NOT NULL,
    inspection_id TEXT,
    report_period TEXT,
    compliance_rate NUMERIC,
    inspections_completed INTEGER,
    total_inspections INTEGER,
    defects_found INTEGER,
    critical_findings INTEGER,
    recommendations unknown,
    regulations unknown,
    status TEXT,
    generated_at TEXT,
    created_by TEXT,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: consolidated_documents
-- Unified view of document embeddings with store and processing information
CREATE TABLE IF NOT EXISTS public.consolidated_documents (
    embedding_id INTEGER,
    source TEXT,
    content TEXT,
    metadata unknown,
    discipline_code TEXT,
    embedding_created_at TEXT,
    document_store_uuid TEXT,
    document_store_name TEXT,
    document_store_description TEXT,
    security_level TEXT,
    access_roles unknown,
    flowise_document_id TEXT,
    document_name TEXT,
    original_filename TEXT,
    file_size INTEGER,
    mime_type TEXT,
    total_chunks INTEGER,
    total_characters INTEGER,
    processing_status TEXT,
    uploaded_at TEXT,
    processed_at TEXT
);

-- Table: consultants
-- Consultants table with procurement entity fields for approval workflow
CREATE TABLE IF NOT EXISTS public.consultants (
    id INTEGER NOT NULL,
    name TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT,
    address TEXT,
    email TEXT,
    phone TEXT,
    contact_person TEXT,
    project_id TEXT,
    consultant_type TEXT,
    organization_id TEXT,
    services_offered TEXT,
    license_number TEXT,
    insurance_status TEXT,
    registration_date TEXT,
    approval_status TEXT,
    compliance_status TEXT,
    last_activity TEXT,
    scraped_at TEXT
);

-- Table: contacts
CREATE TABLE IF NOT EXISTS public.contacts (
    contact_id TEXT NOT NULL,
    users_name TEXT,
    email TEXT,
    first_name TEXT,
    last_name TEXT,
    phone_number TEXT,
    company TEXT,
    job_title TEXT,
    address TEXT,
    city TEXT,
    province TEXT,
    postal_code TEXT,
    country TEXT,
    created_at TEXT,
    updated_at TEXT,
    notes TEXT,
    organization_id TEXT
);

-- Table: containers
-- Stores container information and tracking data
CREATE TABLE IF NOT EXISTS public.containers (
    id TEXT NOT NULL,
    container_number TEXT NOT NULL,
    container_type TEXT,
    container_size TEXT,
    iso_code TEXT,
    tare_weight NUMERIC,
    max_payload NUMERIC,
    current_status TEXT,
    current_location TEXT,
    current_latitude NUMERIC,
    current_longitude NUMERIC,
    vessel_id TEXT,
    vessel_name TEXT,
    cargo_description TEXT,
    cargo_weight NUMERIC,
    cargo_value NUMERIC,
    cargo_currency TEXT,
    booking_reference TEXT,
    bill_of_lading TEXT,
    shipper_name TEXT,
    consignee_name TEXT,
    notify_party TEXT,
    port_of_loading TEXT,
    port_of_discharge TEXT,
    final_destination TEXT,
    estimated_arrival TEXT,
    actual_arrival TEXT,
    container_tracking_id TEXT,
    last_tracking_update TEXT,
    api_data unknown,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    is_active BOOLEAN,
    company_id TEXT,
    organisation_id TEXT,
    project_id TEXT,
    organization_id TEXT
);

-- Table: contractor_evaluation_results
-- Evaluation results for contractor vetting display
CREATE TABLE IF NOT EXISTS public.contractor_evaluation_results (
    id INTEGER NOT NULL,
    vetting_id INTEGER,
    document_id INTEGER,
    contractor_name TEXT,
    document_type TEXT,
    document_path TEXT,
    processing_status TEXT,
    score INTEGER,
    confidence INTEGER,
    commentary TEXT,
    created_at TEXT,
    updated_at TEXT,
    questions unknown,
    answers unknown,
    document_name TEXT,
    form_submission_data unknown
);

-- Table: contractor_evaluations
CREATE TABLE IF NOT EXISTS public.contractor_evaluations (
    id TEXT NOT NULL,
    contractor_name TEXT NOT NULL,
    document_name TEXT,
    evaluation_type TEXT NOT NULL,
    answers unknown,
    score INTEGER,
    confidence INTEGER,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT
);

-- Table: contractor_vetting
-- Main table for contractor vetting information and status tracking
CREATE TABLE IF NOT EXISTS public.contractor_vetting (
    id INTEGER NOT NULL,
    contractor_id INTEGER,
    company_name TEXT NOT NULL,
    contact_person TEXT,
    phone TEXT,
    email TEXT,
    business_address TEXT,
    created_at TEXT,
    updated_at TEXT,
    vetting_status TEXT,
    overall_score INTEGER,
    notes TEXT,
    organization_id TEXT
);

-- Table: contractor_vetting_chat_messages
-- Chat messages for contractor vetting assistance
CREATE TABLE IF NOT EXISTS public.contractor_vetting_chat_messages (
    id INTEGER NOT NULL,
    vetting_id INTEGER,
    message_type TEXT,
    sender TEXT,
    message_text TEXT NOT NULL,
    timestamp TEXT,
    session_id TEXT,
    organization_id TEXT
);

-- Table: contractor_vetting_dashboard_stats
-- Dashboard statistics for contractor vetting
CREATE TABLE IF NOT EXISTS public.contractor_vetting_dashboard_stats (
    id INTEGER NOT NULL,
    stat_date TEXT,
    total_contractors INTEGER,
    average_score INTEGER,
    high_scores_count INTEGER,
    pending_reviews_count INTEGER,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT
);

-- Table: contractor_vetting_document_hashes
-- Document hashes for deduplication and incremental ingestion per 1300_00220
CREATE TABLE IF NOT EXISTS public.contractor_vetting_document_hashes (
    id TEXT NOT NULL,
    document_id TEXT,
    version TEXT NOT NULL,
    document_hash TEXT NOT NULL,
    content_hash TEXT NOT NULL,
    chunk_id TEXT,
    file_size INTEGER,
    mime_type TEXT,
    created_at TEXT,
    updated_at TEXT,
    source_path TEXT,
    department_id TEXT,
    organization_id TEXT
);

-- Table: contractor_vetting_document_parts
-- Document parts for discrete additions per 1300_00220
CREATE TABLE IF NOT EXISTS public.contractor_vetting_document_parts (
    id TEXT NOT NULL,
    document_id TEXT,
    part_number TEXT NOT NULL,
    part_title TEXT,
    content_hash TEXT NOT NULL,
    part_content TEXT,
    start_page INTEGER,
    end_page INTEGER,
    word_count INTEGER,
    character_count INTEGER,
    created_at TEXT,
    updated_at TEXT,
    version TEXT,
    parent_part_id TEXT,
    organization_id TEXT
);

-- Table: contractor_vetting_documents
-- Uploaded documents for contractor vetting
CREATE TABLE IF NOT EXISTS public.contractor_vetting_documents (
    id INTEGER NOT NULL,
    vetting_id INTEGER,
    section_id INTEGER,
    file_name TEXT NOT NULL,
    original_file_name TEXT,
    file_path TEXT,
    file_size INTEGER,
    mime_type TEXT,
    upload_timestamp TEXT,
    document_type TEXT,
    processing_status TEXT,
    processing_result TEXT,
    extracted_data unknown,
    organization_id TEXT
);

-- Table: contractor_vetting_ingestion_registry
-- Registry for tracking document ingestion status per 1300_00220
CREATE TABLE IF NOT EXISTS public.contractor_vetting_ingestion_registry (
    id TEXT NOT NULL,
    document_hash TEXT NOT NULL,
    content_hash TEXT NOT NULL,
    ingestion_status TEXT,
    ingestion_timestamp TEXT,
    completion_timestamp TEXT,
    error_message TEXT,
    retry_count INTEGER,
    vector_store_id TEXT,
    metadata unknown,
    department_id TEXT
);

-- Table: contractor_vetting_sections
-- Individual sections of the contractor vetting process
CREATE TABLE IF NOT EXISTS public.contractor_vetting_sections (
    id INTEGER NOT NULL,
    vetting_id INTEGER,
    section_name TEXT NOT NULL,
    section_title TEXT NOT NULL,
    status TEXT,
    score INTEGER,
    analysis_text TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: contractors
-- Table to store contractor information for projects
CREATE TABLE IF NOT EXISTS public.contractors (
    name TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT,
    address TEXT,
    email TEXT,
    phone TEXT,
    contact_person TEXT,
    project_id TEXT,
    contractor_type TEXT,
    construction_type TEXT,
    sector TEXT,
    id TEXT NOT NULL,
    organization_id TEXT,
    user_id TEXT
);

-- Table: contractors_backup_before_uuid_migration
CREATE TABLE IF NOT EXISTS public.contractors_backup_before_uuid_migration (
    id INTEGER,
    name TEXT,
    created_at TEXT,
    updated_at TEXT,
    address TEXT,
    email TEXT,
    phone TEXT,
    contact_person TEXT,
    project_id TEXT,
    contractor_type TEXT,
    construction_type TEXT,
    sector TEXT
);

-- Table: contracts
-- Contracts associated with contractors on projects
CREATE TABLE IF NOT EXISTS public.contracts (
    id INTEGER NOT NULL,
    contractor_id INTEGER,
    contract_number TEXT NOT NULL,
    contract_type TEXT,
    created_at TEXT,
    updated_at TEXT,
    contract_type_id TEXT,
    category TEXT,
    working_zones TEXT[],
    project_id TEXT,
    organization_id TEXT,
    user_id TEXT,
    assigned_to TEXT
);

-- Table: contracts_post_summary
CREATE TABLE IF NOT EXISTS public.contracts_post_summary (
    contract_status TEXT,
    contract_count INTEGER,
    total_value NUMERIC,
    avg_progress NUMERIC,
    total_documents INTEGER,
    latest_contract TEXT
);

-- Table: contributor_assignments
CREATE TABLE IF NOT EXISTS public.contributor_assignments (
    id TEXT NOT NULL,
    contributor_id TEXT,
    page_id TEXT,
    branch_name TEXT,
    status TEXT,
    assigned_at TEXT,
    completed_at TEXT,
    modal_configuration_id TEXT,
    github_branch_url TEXT,
    auto_generated_files unknown,
    notes TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: contributors
-- Enhanced contributors table with full GitHub integration
CREATE TABLE IF NOT EXISTS public.contributors (
    name TEXT NOT NULL,
    github_username TEXT,
    email TEXT,
    avatar_url TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    id TEXT NOT NULL,
    bio TEXT,
    github_id INTEGER,
    github_login TEXT,
    display_name TEXT,
    company TEXT,
    location TEXT,
    blog TEXT,
    twitter_username TEXT,
    public_repos INTEGER,
    public_gists INTEGER,
    followers INTEGER,
    following INTEGER,
    hireable BOOLEAN,
    github_created_at TEXT,
    github_updated_at TEXT,
    organization_id TEXT
);

-- Table: credential_rotation_logs
-- Audit trail for API credential rotation activities
CREATE TABLE IF NOT EXISTS public.credential_rotation_logs (
    id TEXT NOT NULL,
    api_config_id TEXT NOT NULL,
    rotation_type TEXT NOT NULL,
    old_key_hash TEXT,
    new_key_hash TEXT,
    rotated_by TEXT,
    rotated_at TEXT NOT NULL,
    reason TEXT,
    success BOOLEAN NOT NULL,
    error_message TEXT,
    metadata unknown
);

-- Table: custom_document_types
CREATE TABLE IF NOT EXISTS public.custom_document_types (
    id TEXT NOT NULL,
    organization_id TEXT,
    discipline_code TEXT NOT NULL,
    document_type TEXT NOT NULL,
    document_type_code TEXT NOT NULL,
    category TEXT,
    description TEXT,
    is_active BOOLEAN,
    created_by TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: customized
-- App-wide dropdown options shared across multiple modals
CREATE TABLE IF NOT EXISTS public.customized (
    id TEXT NOT NULL,
    dropdown_id TEXT NOT NULL,
    options TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT
);

-- Table: cv_analyses
CREATE TABLE IF NOT EXISTS public.cv_analyses (
    id TEXT NOT NULL,
    candidate_name TEXT,
    position_applied TEXT,
    experience_level TEXT,
    years_experience INTEGER,
    job_title TEXT,
    job_department TEXT,
    overall_rating NUMERIC,
    analysis_data unknown,
    ai_model TEXT,
    created_at TEXT
);

-- Table: cv_application_stats
CREATE TABLE IF NOT EXISTS public.cv_application_stats (
    total_applications INTEGER,
    pending_count INTEGER,
    under_review_count INTEGER,
    interview_scheduled_count INTEGER,
    approved_count INTEGER,
    rejected_count INTEGER,
    on_hold_count INTEGER,
    average_rating NUMERIC,
    applications_this_week INTEGER,
    applications_this_month INTEGER
);

-- Table: cv_applications
-- Stores CV/job application data for HR CV Processing system
CREATE TABLE IF NOT EXISTS public.cv_applications (
    id TEXT NOT NULL,
    applicant_name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT,
    position_applied TEXT NOT NULL,
    status TEXT NOT NULL,
    years_experience INTEGER,
    education_level TEXT,
    skills TEXT[],
    certifications TEXT[],
    salary_expectation NUMERIC,
    currency TEXT,
    availability_date TEXT,
    employment_type TEXT,
    location TEXT,
    remote_work_preference TEXT,
    cv_file_url TEXT,
    cover_letter_url TEXT,
    portfolio_url TEXT,
    additional_documents_urls TEXT[],
    interview_stage TEXT,
    interview_date TEXT,
    interview_notes TEXT,
    interviewer_id TEXT,
    technical_score INTEGER,
    communication_score INTEGER,
    culture_fit_score INTEGER,
    overall_rating NUMERIC,
    hr_notes TEXT,
    feedback TEXT,
    rejection_reason TEXT,
    application_source TEXT,
    referral_source TEXT,
    priority_level TEXT,
    created_at TEXT,
    updated_at TEXT,
    applied_date TEXT,
    last_contact_date TEXT,
    created_by TEXT,
    updated_by TEXT,
    organization_id TEXT,
    additional_info unknown,
    custom_fields unknown,
    discipline TEXT,
    address TEXT,
    scoring_details unknown,
    analysis_type TEXT,
    analysis_timestamp TEXT,
    original_notes TEXT,
    openai_feedback TEXT,
    date_of_birth TEXT,
    professional_summary TEXT,
    work_experience unknown,
    education unknown,
    projects unknown,
    extracted_emails TEXT,
    extracted_phones TEXT,
    application_date TEXT,
    linkedin TEXT,
    cv_file TEXT,
    availability TEXT,
    cover_letter TEXT,
    experience_level TEXT,
    notes TEXT,
    rating NUMERIC,
    opennai_feedback TEXT
);

-- Table: data_sheet_specifications
CREATE TABLE IF NOT EXISTS public.data_sheet_specifications (
    id TEXT NOT NULL,
    template_id TEXT,
    spec_type TEXT,
    spec_code TEXT,
    spec_name TEXT,
    specifications unknown,
    compliance_standards TEXT[],
    safety_requirements TEXT[],
    supplier_name TEXT,
    manufacturer TEXT,
    model_number TEXT,
    serial_number TEXT,
    issue_date TEXT,
    expiry_date TEXT,
    revision_number INTEGER,
    procurement_code TEXT,
    created_by TEXT,
    created_at TEXT
);

-- Table: defects
CREATE TABLE IF NOT EXISTS public.defects (
    id INTEGER NOT NULL,
    defect_id TEXT NOT NULL,
    inspection_item_id TEXT NOT NULL,
    defect_type TEXT NOT NULL,
    severity TEXT,
    description TEXT NOT NULL,
    location TEXT,
    assigned_to TEXT,
    status TEXT,
    priority TEXT,
    due_date TEXT,
    resolved_date TEXT,
    resolution_notes TEXT,
    cost_estimate NUMERIC,
    media_urls unknown,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    updated_by TEXT
);

-- Table: discipline_document_paths
CREATE TABLE IF NOT EXISTS public.discipline_document_paths (
    id TEXT NOT NULL,
    organisation_id TEXT NOT NULL,
    discipline_id TEXT NOT NULL,
    document_type_id TEXT NOT NULL,
    path_configuration unknown NOT NULL,
    path_template TEXT NOT NULL,
    is_active BOOLEAN,
    is_default BOOLEAN,
    created_by TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT
);

-- Table: discipline_document_sections
CREATE TABLE IF NOT EXISTS public.discipline_document_sections (
    id TEXT NOT NULL,
    discipline_code TEXT NOT NULL,
    organization_id TEXT NOT NULL,
    section_code TEXT NOT NULL,
    section_name TEXT NOT NULL,
    section_type TEXT NOT NULL,
    display_order INTEGER NOT NULL,
    required BOOLEAN,
    allows_multiple_types BOOLEAN,
    available_document_types unknown,
    created_at TEXT,
    updated_at TEXT,
    contract_type TEXT,
    default_document_type TEXT,
    parent_template_id TEXT
);

-- Table: discipline_evaluation_weights
CREATE TABLE IF NOT EXISTS public.discipline_evaluation_weights (
    id TEXT NOT NULL,
    organization_id TEXT,
    evaluation_context TEXT NOT NULL,
    discipline_code TEXT NOT NULL,
    discipline_name TEXT NOT NULL,
    weight_percentage NUMERIC NOT NULL,
    scoring_criteria unknown,
    max_score INTEGER,
    passing_score INTEGER,
    is_active BOOLEAN,
    created_at TEXT,
    created_by TEXT,
    updated_at TEXT,
    updated_by TEXT
);

-- Table: discipline_template_config
CREATE TABLE IF NOT EXISTS public.discipline_template_config (
    discipline TEXT NOT NULL,
    allowed_template_types TEXT[] NOT NULL,
    requires_approval BOOLEAN,
    max_templates_per_user INTEGER,
    description TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: discipline_template_constraints
CREATE TABLE IF NOT EXISTS public.discipline_template_constraints (
    id TEXT NOT NULL,
    discipline_name TEXT NOT NULL,
    table_name TEXT NOT NULL,
    allowed_template_types TEXT[],
    description TEXT,
    is_active INTEGER,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT
);

-- Table: disciplines
CREATE TABLE IF NOT EXISTS public.disciplines (
    id TEXT NOT NULL,
    page_id TEXT NOT NULL,
    name TEXT NOT NULL,
    code TEXT NOT NULL,
    slug TEXT,
    organization_id TEXT NOT NULL,
    organization_name TEXT,
    sector_id TEXT,
    sector_name TEXT,
    parent_discipline_id TEXT,
    hierarchy_level INTEGER,
    display_order INTEGER,
    is_active BOOLEAN,
    is_standard_link BOOLEAN,
    is_virtual BOOLEAN,
    organization_ids TEXT[],
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    updated_by TEXT
);

-- Table: document_access_logs
CREATE TABLE IF NOT EXISTS public.document_access_logs (
    id TEXT NOT NULL,
    document_id TEXT NOT NULL,
    user_id TEXT,
    tender_id TEXT NOT NULL,
    access_type TEXT NOT NULL,
    accessed_at TEXT
);

-- Table: document_ai_analysis
-- Stores AI analysis results for uploaded documents including confidence scores and human corrections
CREATE TABLE IF NOT EXISTS public.document_ai_analysis (
    id TEXT NOT NULL,
    document_id TEXT,
    analysis_results unknown NOT NULL,
    confidence_scores unknown NOT NULL,
    human_corrections unknown,
    processing_status TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: document_analysis_feedback
-- Tracks AI learning from user corrections and feedback
CREATE TABLE IF NOT EXISTS public.document_analysis_feedback (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    original_analysis unknown,
    user_correction unknown,
    document_content TEXT,
    feedback_type TEXT,
    confidence_score NUMERIC,
    created_at TEXT,
    organization_id TEXT
);

-- Table: document_analysis_prompts
CREATE TABLE IF NOT EXISTS public.document_analysis_prompts (
    id TEXT NOT NULL,
    prompt_type TEXT NOT NULL,
    document_type TEXT NOT NULL,
    discipline_id TEXT,
    prompt_text TEXT NOT NULL,
    model_parameters unknown,
    is_active BOOLEAN,
    created_by TEXT,
    updated_by TEXT,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT
);

-- Table: document_categories
CREATE TABLE IF NOT EXISTS public.document_categories (
    id TEXT NOT NULL,
    category_code TEXT NOT NULL,
    category_name TEXT NOT NULL,
    description TEXT,
    is_active BOOLEAN,
    created_at TEXT,
    organization_id TEXT
);

-- Table: document_comparisons
-- Table for storing document comparison results
CREATE TABLE IF NOT EXISTS public.document_comparisons (
    id TEXT NOT NULL,
    document_ids TEXT[] NOT NULL,
    mode TEXT NOT NULL,
    result unknown,
    created_at TEXT,
    created_by TEXT,
    options unknown
);

-- Table: document_download_queue
CREATE TABLE IF NOT EXISTS public.document_download_queue (
    id TEXT NOT NULL,
    tender_id TEXT NOT NULL,
    document_url TEXT NOT NULL,
    document_type TEXT NOT NULL,
    source_name TEXT,
    priority INTEGER,
    status TEXT,
    queue_order INTEGER,
    download_options unknown,
    expected_file_size INTEGER,
    retry_count INTEGER,
    max_retries INTEGER,
    error_message TEXT,
    started_at TEXT,
    scheduled_at TEXT,
    completed_at TEXT,
    created_at TEXT,
    created_by TEXT,
    user_ip TEXT,
    user_agent TEXT,
    document_name TEXT,
    source TEXT,
    organization_id TEXT
);

-- Table: document_embeddings
-- Direct embeddings storage bypassing Flowise document store system
CREATE TABLE IF NOT EXISTS public.document_embeddings (
    id INTEGER NOT NULL,
    content TEXT NOT NULL,
    embedding TEXT,
    metadata unknown,
    source TEXT,
    page INTEGER,
    section TEXT,
    chunk_id TEXT,
    created_at TEXT,
    updated_at TEXT,
    document_store_id TEXT,
    discipline_code TEXT,
    flowise_store_id TEXT
);

-- Table: document_hashes
-- Table for storing document content hashes to prevent duplication during ingestion
CREATE TABLE IF NOT EXISTS public.document_hashes (
    id TEXT NOT NULL,
    doc_id TEXT NOT NULL,
    version TEXT NOT NULL,
    hash TEXT NOT NULL,
    chunk_id TEXT,
    timestamp TEXT,
    source_path TEXT,
    department_id TEXT
);

-- Table: document_hierarchy_definitions
-- Defines hierarchical structures for different document types (Part/Section/Clause/etc.)
CREATE TABLE IF NOT EXISTS public.document_hierarchy_definitions (
    id TEXT NOT NULL,
    discipline_id TEXT NOT NULL,
    document_type TEXT NOT NULL,
    hierarchy_levels unknown NOT NULL,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    organization_id TEXT
);

-- Table: document_number_audit_log
CREATE TABLE IF NOT EXISTS public.document_number_audit_log (
    id INTEGER NOT NULL,
    discipline_code TEXT NOT NULL,
    document_type TEXT NOT NULL,
    organization_id TEXT NOT NULL,
    company_id INTEGER NOT NULL,
    generated_number TEXT NOT NULL,
    sequence_number INTEGER NOT NULL,
    context unknown,
    generated_at TEXT,
    created_at TEXT,
    user_id TEXT
);

-- Table: document_number_sequences
CREATE TABLE IF NOT EXISTS public.document_number_sequences (
    discipline_code TEXT NOT NULL,
    document_type TEXT NOT NULL,
    organization_id TEXT NOT NULL,
    current_value INTEGER NOT NULL
);

-- Table: document_numbering_methodologies
CREATE TABLE IF NOT EXISTS public.document_numbering_methodologies (
    id TEXT NOT NULL,
    organization_id TEXT NOT NULL,
    company_id INTEGER,
    methodology_name TEXT NOT NULL,
    methodology_description TEXT,
    default_pattern TEXT NOT NULL,
    pattern_variables unknown,
    is_default BOOLEAN,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT
);

-- Table: document_numbering_sequences
CREATE TABLE IF NOT EXISTS public.document_numbering_sequences (
    id TEXT NOT NULL,
    document_type_id TEXT,
    sequence_key TEXT NOT NULL,
    current_number INTEGER,
    last_generated_at TEXT,
    created_at TEXT
);

-- Table: document_processing_history
CREATE TABLE IF NOT EXISTS public.document_processing_history (
    id TEXT NOT NULL,
    tender_id TEXT NOT NULL,
    document_id TEXT,
    document_url TEXT NOT NULL,
    operation_type TEXT NOT NULL,
    status TEXT NOT NULL,
    error_message TEXT,
    processing_time_ms INTEGER,
    file_size_processed INTEGER,
    metadata_collected unknown,
    created_at TEXT
);

-- Table: document_processing_log
CREATE TABLE IF NOT EXISTS public.document_processing_log (
    id TEXT NOT NULL,
    instance_id TEXT,
    template_id TEXT,
    file_name TEXT NOT NULL,
    file_type TEXT,
    organization_name TEXT,
    discipline_name TEXT,
    processing_type TEXT NOT NULL,
    processing_status TEXT NOT NULL,
    processing_message TEXT,
    processing_details unknown,
    processing_time_ms INTEGER,
    file_size INTEGER,
    extracted_fields_count INTEGER,
    error_details unknown,
    stack_trace TEXT,
    user_agent TEXT,
    user_ip TEXT,
    created_by TEXT,
    created_at TEXT,
    organization_id TEXT
);

-- Table: document_processing_queue
-- Queue for tracking document processing status and progress
CREATE TABLE IF NOT EXISTS public.document_processing_queue (
    id TEXT NOT NULL,
    file_id TEXT NOT NULL,
    document_id TEXT,
    status TEXT,
    progress INTEGER,
    metadata unknown,
    ai_analysis unknown,
    error_message TEXT,
    created_at TEXT,
    processed_at TEXT
);

-- Table: document_references
CREATE TABLE IF NOT EXISTS public.document_references (
    id TEXT NOT NULL,
    identifier TEXT NOT NULL,
    document_type_id TEXT NOT NULL,
    title TEXT NOT NULL,
    file_path TEXT,
    metadata unknown,
    vector_doc_ids TEXT[],
    organization_id TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT,
    user_id TEXT
);

-- Table: document_routing_history
CREATE TABLE IF NOT EXISTS public.document_routing_history (
    id INTEGER NOT NULL,
    workflow_id INTEGER,
    document_id TEXT,
    version_id INTEGER,
    action_type TEXT NOT NULL,
    action_description TEXT,
    actor_id TEXT,
    actor_role TEXT,
    old_status TEXT,
    new_status TEXT,
    step_name TEXT,
    action_metadata unknown,
    created_at TEXT
);

-- Table: document_routing_templates
CREATE TABLE IF NOT EXISTS public.document_routing_templates (
    id INTEGER NOT NULL,
    template_name TEXT NOT NULL,
    template_description TEXT,
    document_type TEXT,
    organization_id INTEGER,
    creator_id TEXT,
    is_active BOOLEAN,
    is_default BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    user_id TEXT
);

-- Table: document_routing_workflows
CREATE TABLE IF NOT EXISTS public.document_routing_workflows (
    id INTEGER NOT NULL,
    document_id TEXT,
    version_id INTEGER,
    template_id INTEGER,
    workflow_name TEXT,
    workflow_status TEXT,
    current_step_order INTEGER,
    initiated_by TEXT,
    deadline TEXT,
    completed_at TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: document_sections
-- Stores detailed section content within hierarchical document structures
CREATE TABLE IF NOT EXISTS public.document_sections (
    id TEXT NOT NULL,
    structure_id TEXT NOT NULL,
    section_path TEXT NOT NULL,
    level_name TEXT NOT NULL,
    level_number TEXT NOT NULL,
    title TEXT,
    content unknown,
    metadata unknown,
    parent_section_id TEXT,
    sort_order INTEGER,
    is_required BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: document_stores
-- Logical grouping for documents to be managed and upserted via Flowise
CREATE TABLE IF NOT EXISTS public.document_stores (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    created_at TEXT,
    updated_at TEXT,
    metadata unknown,
    is_active BOOLEAN,
    flowise_id TEXT,
    discipline_code TEXT,
    security_level TEXT,
    access_roles unknown,
    store_type TEXT,
    doc_id TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: document_type_relationships
-- Defines relationships between document types (e.g., scope_of_work can be part of purchase_order)
CREATE TABLE IF NOT EXISTS public.document_type_relationships (
    id TEXT NOT NULL,
    child_type TEXT NOT NULL,
    parent_type TEXT NOT NULL,
    relationship_type TEXT NOT NULL,
    is_common BOOLEAN,
    created_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: document_types
CREATE TABLE IF NOT EXISTS public.document_types (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    code TEXT NOT NULL,
    discipline_code TEXT NOT NULL,
    category TEXT NOT NULL,
    description TEXT,
    is_active BOOLEAN,
    created_at TEXT
);

-- Table: document_types_by_discipline
CREATE TABLE IF NOT EXISTS public.document_types_by_discipline (
    id TEXT NOT NULL,
    discipline_code TEXT NOT NULL,
    discipline_name TEXT NOT NULL,
    document_type TEXT NOT NULL,
    document_type_code TEXT NOT NULL,
    numbering_pattern TEXT NOT NULL,
    numbering_explanation TEXT NOT NULL,
    organization_id TEXT NOT NULL,
    is_active BOOLEAN,
    auto_increment_start INTEGER,
    auto_increment_current INTEGER,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    company_id TEXT,
    supported_file_types TEXT[],
    template_categories TEXT[],
    notification_templates unknown,
    workflow_rules unknown,
    ui_labels unknown,
    validation_rules unknown
);

-- Table: document_variation_sections
CREATE TABLE IF NOT EXISTS public.document_variation_sections (
    id TEXT NOT NULL,
    variation_id TEXT NOT NULL,
    section_code TEXT NOT NULL,
    section_name TEXT NOT NULL,
    section_type TEXT NOT NULL,
    display_order INTEGER NOT NULL,
    required BOOLEAN,
    organization_id TEXT NOT NULL,
    created_at TEXT
);

-- Table: document_variations
CREATE TABLE IF NOT EXISTS public.document_variations (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    discipline_code TEXT NOT NULL,
    contract_type TEXT,
    template_variation TEXT,
    organization_id TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT
);

-- Table: document_versions
-- Tracks all versions of documents for version control system
CREATE TABLE IF NOT EXISTS public.document_versions (
    id TEXT NOT NULL,
    document_id TEXT NOT NULL,
    version_number TEXT NOT NULL,
    previous_version_id TEXT,
    author_id TEXT,
    author_name TEXT,
    version_notes TEXT,
    change_summary TEXT,
    status TEXT,
    file_path TEXT,
    file_hash TEXT,
    file_size INTEGER,
    content_type TEXT,
    metadata unknown,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT
);

-- Table: dropdown_options
-- Modal-specific dropdown options
CREATE TABLE IF NOT EXISTS public.dropdown_options (
    id TEXT NOT NULL,
    modal_id TEXT NOT NULL,
    type TEXT NOT NULL,
    value TEXT NOT NULL,
    company_id INTEGER,
    contractor_id INTEGER,
    field_label TEXT,
    project TEXT,
    modal_name TEXT,
    created_at TEXT,
    updated_at TEXT,
    type_contract TEXT,
    language TEXT,
    project_id TEXT
);

-- Table: email_access_logs
CREATE TABLE IF NOT EXISTS public.email_access_logs (
    id TEXT NOT NULL,
    email_send_id TEXT NOT NULL,
    doc_id TEXT NOT NULL,
    actor_id TEXT,
    accessed_at TEXT NOT NULL,
    ip TEXT,
    user_agent TEXT
);

-- Table: email_ai_processing_queue
-- Queue for AI processing tasks on emails with user and organization-based access control
CREATE TABLE IF NOT EXISTS public.email_ai_processing_queue (
    id TEXT NOT NULL,
    email_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    processing_type TEXT NOT NULL,
    priority INTEGER,
    status TEXT,
    result unknown,
    confidence_score NUMERIC,
    attempts INTEGER,
    max_attempts INTEGER,
    started_at TEXT,
    completed_at TEXT,
    error_message TEXT,
    last_error_at TEXT,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT
);

-- Table: email_attachments
-- Stores email attachment metadata and references to Supabase storage
CREATE TABLE IF NOT EXISTS public.email_attachments (
    id TEXT NOT NULL,
    email_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    filename TEXT NOT NULL,
    content_type TEXT,
    file_size INTEGER,
    attachment_id TEXT,
    storage_path TEXT,
    storage_bucket TEXT,
    is_inline BOOLEAN,
    content_id TEXT,
    is_safe BOOLEAN,
    virus_scan_result TEXT,
    virus_scan_at TEXT,
    download_count INTEGER,
    last_downloaded_at TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: email_content_storage
CREATE TABLE IF NOT EXISTS public.email_content_storage (
    id TEXT NOT NULL,
    email_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    content_type TEXT NOT NULL,
    original_size INTEGER NOT NULL,
    compressed_size INTEGER,
    compression_type TEXT,
    storage_bucket TEXT NOT NULL,
    storage_path TEXT NOT NULL,
    encoding TEXT,
    language TEXT,
    access_count INTEGER,
    last_accessed_at TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: email_drafts
-- Draft emails that haven't been sent yet
CREATE TABLE IF NOT EXISTS public.email_drafts (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    account_id TEXT NOT NULL,
    to_emails TEXT[] NOT NULL,
    cc_emails TEXT[],
    bcc_emails TEXT[],
    subject TEXT NOT NULL,
    body_text TEXT,
    body_html TEXT,
    is_reply BOOLEAN,
    is_forward BOOLEAN,
    original_email_id TEXT,
    priority TEXT,
    scheduled_send_at TEXT,
    is_scheduled BOOLEAN,
    auto_saved_at TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: email_notification_queue
CREATE TABLE IF NOT EXISTS public.email_notification_queue (
    id TEXT NOT NULL,
    approval_instance_id TEXT,
    user_id TEXT,
    email_type TEXT NOT NULL,
    email_subject TEXT,
    email_body TEXT,
    send_after TEXT,
    sent_at TEXT,
    created_at TEXT
);

-- Table: email_providers
-- Supported email providers (Gmail, Outlook, IMAP, etc.)
CREATE TABLE IF NOT EXISTS public.email_providers (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    display_name TEXT NOT NULL,
    provider_type TEXT NOT NULL,
    is_active BOOLEAN,
    configuration unknown,
    created_at TEXT,
    updated_at TEXT
);

-- Table: email_search_history
-- User search history for analytics and quick access
CREATE TABLE IF NOT EXISTS public.email_search_history (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    search_query TEXT NOT NULL,
    search_type TEXT,
    search_filters unknown,
    results_count INTEGER,
    execution_time_ms INTEGER,
    ai_interpretation TEXT,
    ai_confidence NUMERIC,
    created_at TEXT
);

-- Table: email_send_attachments
CREATE TABLE IF NOT EXISTS public.email_send_attachments (
    id TEXT NOT NULL,
    email_send_id TEXT NOT NULL,
    doc_id TEXT NOT NULL,
    version_id TEXT,
    file_key TEXT,
    delivery_mode TEXT NOT NULL,
    signed_url TEXT,
    expires_at TEXT,
    size_bytes INTEGER,
    created_at TEXT NOT NULL
);

-- Table: email_sends
CREATE TABLE IF NOT EXISTS public.email_sends (
    id TEXT NOT NULL,
    actor_id TEXT NOT NULL,
    recipients_json unknown NOT NULL,
    lists_json unknown NOT NULL,
    template_id TEXT,
    subject TEXT NOT NULL,
    mode TEXT NOT NULL,
    sent_at TEXT,
    provider_message_id TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);

-- Table: email_signatures
CREATE TABLE IF NOT EXISTS public.email_signatures (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    content TEXT NOT NULL,
    is_default BOOLEAN,
    type TEXT NOT NULL,
    created_at TEXT
);

-- Table: email_sync_log
-- Logs of email synchronization operations
CREATE TABLE IF NOT EXISTS public.email_sync_log (
    id TEXT NOT NULL,
    account_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    sync_type TEXT NOT NULL,
    sync_status TEXT NOT NULL,
    emails_fetched INTEGER,
    emails_processed INTEGER,
    emails_failed INTEGER,
    new_emails INTEGER,
    updated_emails INTEGER,
    started_at TEXT NOT NULL,
    completed_at TEXT,
    duration_seconds INTEGER,
    error_message TEXT,
    error_details unknown,
    provider_response unknown,
    created_at TEXT
);

-- Table: email_templates
-- Email templates for quick composition
CREATE TABLE IF NOT EXISTS public.email_templates (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    category TEXT,
    subject_template TEXT,
    body_template TEXT,
    variables unknown,
    usage_count INTEGER,
    last_used_at TEXT,
    is_public BOOLEAN,
    is_system_template BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT
);

-- Table: email_threads
-- Groups related emails into conversation threads
CREATE TABLE IF NOT EXISTS public.email_threads (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    thread_id TEXT NOT NULL,
    subject TEXT NOT NULL,
    participants TEXT[],
    message_count INTEGER,
    unread_count INTEGER,
    has_attachments BOOLEAN,
    priority TEXT,
    labels TEXT[],
    last_activity_at TEXT,
    is_archived BOOLEAN,
    is_deleted BOOLEAN,
    ai_summary TEXT,
    ai_sentiment TEXT,
    ai_priority_score NUMERIC,
    ai_action_items TEXT[],
    ai_processed_at TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: email_vector
CREATE TABLE IF NOT EXISTS public.email_vector (
    id TEXT NOT NULL,
    embedding TEXT NOT NULL,
    metadata unknown,
    content TEXT
);

-- Table: emails
-- Main table storing all email messages with full content and metadata
CREATE TABLE IF NOT EXISTS public.emails (
    id TEXT NOT NULL,
    user_id TEXT,
    account_id TEXT,
    thread_id TEXT,
    message_id TEXT,
    provider_thread_id TEXT,
    subject TEXT NOT NULL,
    sender_email TEXT NOT NULL,
    sender_name TEXT,
    recipient_email TEXT NOT NULL,
    recipient_name TEXT,
    cc_emails TEXT[],
    bcc_emails TEXT[],
    reply_to_email TEXT,
    body_text TEXT,
    body_html TEXT,
    snippet TEXT,
    sent_date TEXT NOT NULL,
    received_date TEXT,
    is_read BOOLEAN,
    is_flagged BOOLEAN,
    is_important BOOLEAN,
    is_draft BOOLEAN,
    is_sent BOOLEAN,
    is_archived BOOLEAN,
    is_deleted BOOLEAN,
    is_spam BOOLEAN,
    has_attachments BOOLEAN,
    attachment_count INTEGER,
    priority TEXT,
    labels TEXT[],
    ai_summary TEXT,
    ai_sentiment TEXT,
    ai_priority_score NUMERIC,
    ai_action_items TEXT[],
    ai_entities unknown,
    ai_processed_at TEXT,
    provider_data unknown,
    search_vector TEXT,
    created_at TEXT,
    updated_at TEXT,
    sender_email_normalized TEXT,
    recipient_email_normalized TEXT,
    resolution_debug unknown
);

-- Table: equipment_documentation
CREATE TABLE IF NOT EXISTS public.equipment_documentation (
    id TEXT NOT NULL,
    equipment_id TEXT NOT NULL,
    storage_service TEXT NOT NULL,
    storage_url TEXT NOT NULL,
    document_id TEXT NOT NULL,
    sections unknown NOT NULL,
    compliance_standards TEXT[],
    created_at TEXT,
    updated_at TEXT
);

-- Table: error_implementations
CREATE TABLE IF NOT EXISTS public.error_implementations (
    id TEXT NOT NULL,
    error_tracking_id TEXT NOT NULL,
    implementation_type TEXT NOT NULL,
    status TEXT NOT NULL,
    priority TEXT,
    code_example TEXT,
    technical_notes TEXT,
    developer_assigned TEXT,
    qa_validation_status TEXT,
    deployment_status TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: error_metrics
CREATE TABLE IF NOT EXISTS public.error_metrics (
    id TEXT NOT NULL,
    error_tracking_id TEXT NOT NULL,
    metric_type TEXT NOT NULL,
    value NUMERIC NOT NULL,
    unit TEXT,
    measured_at TEXT,
    measurement_context TEXT,
    created_at TEXT
);

-- Table: error_trackings
CREATE TABLE IF NOT EXISTS public.error_trackings (
    id TEXT NOT NULL,
    error_id TEXT NOT NULL,
    title TEXT NOT NULL,
    category TEXT NOT NULL,
    severity TEXT NOT NULL,
    status TEXT NOT NULL,
    description TEXT,
    root_cause TEXT,
    solution TEXT,
    impact_assessment TEXT,
    error_pattern TEXT,
    affected_system TEXT,
    resolution_timestamp TEXT,
    created_at TEXT,
    updated_at TEXT,
    resolved_at TEXT,
    fingerprint TEXT,
    batch_id TEXT
);

-- Table: esignature_audit
-- Complete audit trail for all e-signatures
CREATE TABLE IF NOT EXISTS public.esignature_audit (
    id TEXT NOT NULL,
    approval_step_id TEXT,
    approval_instance_id TEXT,
    signer_user_id TEXT,
    signature_method TEXT NOT NULL,
    signature_data unknown NOT NULL,
    signature_hash TEXT,
    ip_address TEXT,
    user_agent TEXT,
    location_data unknown,
    signed_at TEXT,
    document_hash TEXT NOT NULL,
    document_version TEXT,
    certificate_data unknown,
    is_valid BOOLEAN,
    invalidated_at TEXT,
    invalidation_reason TEXT
);

-- Table: evaluation_packages
CREATE TABLE IF NOT EXISTS public.evaluation_packages (
    id TEXT NOT NULL,
    package_context TEXT NOT NULL,
    context_reference_id TEXT,
    package_name TEXT NOT NULL,
    package_description TEXT,
    party_email TEXT NOT NULL,
    party_name TEXT,
    party_org_name TEXT,
    party_type TEXT,
    party_id TEXT,
    organization_id TEXT,
    overall_status TEXT,
    discipline_scores unknown,
    final_weighted_score NUMERIC,
    final_weighted_percentage NUMERIC,
    scoring_calculation unknown,
    final_decision TEXT,
    final_decision_by TEXT,
    final_decision_at TEXT,
    final_decision_comments TEXT,
    context_metadata unknown,
    created_by TEXT,
    created_at TEXT,
    due_date TEXT,
    completed_at TEXT,
    updated_at TEXT,
    updated_by TEXT
);

-- Table: external_api_configurations
CREATE TABLE IF NOT EXISTS public.external_api_configurations (
    id TEXT NOT NULL,
    api_name TEXT NOT NULL,
    api_type TEXT NOT NULL,
    endpoint_url TEXT NOT NULL,
    api_key TEXT NOT NULL,
    organization_id TEXT,
    is_active BOOLEAN,
    description TEXT,
    metadata unknown,
    created_at TEXT,
    updated_at TEXT
);

-- Table: external_party_document_instances
-- Standardized External Party Documents - HTML content in html_content TEXT, schema in content_schema JSONB
CREATE TABLE IF NOT EXISTS public.external_party_document_instances (
    id TEXT NOT NULL,
    document_context TEXT NOT NULL,
    context_reference_id TEXT,
    source_table TEXT NOT NULL,
    source_template_id TEXT NOT NULL,
    template_snapshot unknown NOT NULL,
    discipline_code TEXT NOT NULL,
    discipline_owner_id TEXT,
    organization_id TEXT,
    document_name TEXT NOT NULL,
    document_description TEXT,
    document_type TEXT,
    assigned_to_party_id TEXT,
    assigned_to_party_email TEXT NOT NULL,
    assigned_to_party_name TEXT,
    assigned_to_party_org_name TEXT,
    assigned_to_party_type TEXT,
    created_by TEXT,
    created_at TEXT,
    reviewed_before_issue_by TEXT,
    reviewed_before_issue_at TEXT,
    pre_issue_review_notes TEXT,
    issued_by TEXT,
    issued_at TEXT,
    due_date TEXT,
    assignment_instructions TEXT,
    html_content TEXT NOT NULL,
    form_schema unknown,
    party_responses unknown,
    response_metadata unknown,
    started_at TEXT,
    last_saved_at TEXT,
    submitted_at TEXT,
    reviewed_after_submission_by TEXT,
    reviewed_after_submission_at TEXT,
    post_submission_review_notes TEXT,
    review_decision TEXT,
    discipline_score INTEGER,
    discipline_max_score INTEGER,
    discipline_score_percentage NUMERIC,
    score_breakdown unknown,
    scoring_comments TEXT,
    scored_by TEXT,
    scored_at TEXT,
    revision_count INTEGER,
    revision_history unknown,
    status TEXT,
    access_token TEXT,
    access_expires_at TEXT,
    access_revoked BOOLEAN,
    evaluation_package_id TEXT,
    evaluation_package_name TEXT,
    context_metadata unknown,
    version TEXT,
    is_active BOOLEAN,
    updated_at TEXT,
    updated_by TEXT,
    content_schema unknown
);

-- Table: financial_records
-- Financial records management table for invoices, payments, expenses, contracts, budgets, and assets
CREATE TABLE IF NOT EXISTS public.financial_records (
    id TEXT NOT NULL,
    type TEXT NOT NULL,
    reference TEXT NOT NULL,
    description TEXT NOT NULL,
    amount NUMERIC NOT NULL,
    currency TEXT,
    date TEXT NOT NULL,
    due_date TEXT,
    status TEXT,
    vendor TEXT,
    project TEXT,
    category TEXT,
    created_by TEXT,
    updated_by TEXT,
    created_at TEXT,
    updated_at TEXT,
    active BOOLEAN,
    notes TEXT,
    organization_id TEXT
);

-- Table: flowise_documents
-- Local tracking of individual documents and loaders within Flowise document stores
CREATE TABLE IF NOT EXISTS public.flowise_documents (
    id TEXT NOT NULL,
    document_store_id TEXT NOT NULL,
    flowise_loader_id TEXT NOT NULL,
    flowise_file_id TEXT,
    document_name TEXT NOT NULL,
    original_filename TEXT,
    file_size INTEGER,
    mime_type TEXT,
    loader_name TEXT,
    loader_type TEXT,
    splitter_name TEXT,
    total_chunks INTEGER,
    total_characters INTEGER,
    status TEXT,
    uploaded_at TEXT,
    processed_at TEXT,
    loader_config unknown,
    document_metadata unknown,
    splitter_config unknown,
    created_at TEXT,
    updated_at TEXT,
    last_synced_at TEXT
);

-- Table: flowise_documents_with_stores
-- View combining Flowise documents with their document store information
CREATE TABLE IF NOT EXISTS public.flowise_documents_with_stores (
    id TEXT,
    document_store_id TEXT,
    flowise_loader_id TEXT,
    flowise_file_id TEXT,
    document_name TEXT,
    original_filename TEXT,
    file_size INTEGER,
    mime_type TEXT,
    loader_name TEXT,
    loader_type TEXT,
    splitter_name TEXT,
    total_chunks INTEGER,
    total_characters INTEGER,
    status TEXT,
    uploaded_at TEXT,
    processed_at TEXT,
    loader_config unknown,
    document_metadata unknown,
    splitter_config unknown,
    created_at TEXT,
    updated_at TEXT,
    last_synced_at TEXT,
    store_name TEXT,
    store_description TEXT,
    store_metadata unknown
);

-- Table: flowise_record_manager
-- Record Manager table for Flowise Document Store to track document chunks and prevent duplicates
CREATE TABLE IF NOT EXISTS public.flowise_record_manager (
    uuid TEXT NOT NULL,
    key TEXT NOT NULL,
    group_id TEXT,
    updated_at TEXT,
    created_at TEXT,
    metadata unknown
);

-- Table: form_completions
CREATE TABLE IF NOT EXISTS public.form_completions (
    id TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    template_type TEXT,
    status TEXT NOT NULL,
    priority TEXT,
    project_id TEXT,
    project_name TEXT,
    assigned_to TEXT,
    created_at TEXT,
    updated_at TEXT,
    completed_date TEXT,
    created_by TEXT,
    updated_by TEXT,
    reference_number TEXT,
    tags TEXT[],
    form_data unknown,
    comments TEXT
);

-- Table: form_instances
CREATE TABLE IF NOT EXISTS public.form_instances (
    id TEXT NOT NULL,
    template_id TEXT,
    organization_name TEXT,
    instance_name TEXT NOT NULL,
    instance_slug TEXT,
    source_file_name TEXT NOT NULL,
    source_file_type TEXT,
    source_file_size INTEGER,
    processed_data unknown,
    submission_data unknown,
    html_form TEXT,
    json_form unknown,
    processing_status TEXT,
    version INTEGER,
    is_submitted BOOLEAN,
    submitted_by TEXT,
    submitted_at TEXT,
    created_by TEXT,
    updated_by TEXT,
    created_at TEXT,
    updated_at TEXT,
    deleted_at TEXT,
    organization_id TEXT
);

-- Table: form_templates
CREATE TABLE IF NOT EXISTS public.form_templates (
    id TEXT NOT NULL,
    template_name TEXT NOT NULL,
    html_content TEXT,
    json_schema unknown,
    processing_status TEXT,
    organization_name TEXT,
    discipline_id TEXT,
    discipline_name TEXT,
    created_by TEXT,
    created_at TEXT,
    updated_at TEXT,
    form_metadata unknown,
    organization_id TEXT
);

-- Table: form_templates_audit
CREATE TABLE IF NOT EXISTS public.form_templates_audit (
    id TEXT NOT NULL,
    form_template_id TEXT,
    action TEXT NOT NULL,
    old_data unknown,
    new_data unknown,
    changed_by TEXT,
    changed_at TEXT,
    user_role TEXT,
    organization_id TEXT,
    is_dev_mode BOOLEAN,
    user_id TEXT
);

-- Table: fuel_lubricants
-- ✅ MASTER GUIDE COMPLIANT: Organization-isolated fuel/lubricants management
with creator ownership, audit trails, and approval workflow patterns.
Reference: procurement_templates table standard.
CREATE TABLE IF NOT EXISTS public.fuel_lubricants (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    product_code TEXT,
    category TEXT NOT NULL,
    subtype TEXT,
    supplier_id INTEGER,
    supplier_name TEXT,
    supplier_contact TEXT,
    supplier_email TEXT,
    viscosity TEXT,
    viscosity_class TEXT,
    grade TEXT,
    specification_standard TEXT,
    specifications unknown,
    current_stock_quantity NUMERIC,
    minimum_stock_level NUMERIC,
    maximum_stock_level NUMERIC,
    unit_of_measure TEXT,
    reorder_quantity NUMERIC,
    quality_status TEXT,
    compliance_certificate TEXT,
    batch_number TEXT,
    expiry_date TEXT,
    production_date TEXT,
    purchase_price NUMERIC,
    selling_price NUMERIC,
    purchase_date TEXT,
    purchase_order_number TEXT,
    invoice_number TEXT,
    consumption_rate NUMERIC,
    last_used_date TEXT,
    total_consumed NUMERIC,
    approval_status TEXT,
    approved_by TEXT,
    approval_date TEXT,
    rejection_reason TEXT,
    equipment_assigned unknown,
    project_assigned TEXT,
    storage_location TEXT,
    storage_temperature TEXT,
    storage_conditions TEXT,
    scheduled_changes unknown,
    last_change_date TEXT,
    change_frequency_days INTEGER,
    hazard_classification TEXT,
    sds_url TEXT,
    environmental_impact TEXT,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    updated_by TEXT,
    active BOOLEAN,
    archived BOOLEAN,
    critical_item BOOLEAN,
    organization_id TEXT
);

-- Table: governance_approval_instances
CREATE TABLE IF NOT EXISTS public.governance_approval_instances (
    id TEXT NOT NULL,
    matrix_id TEXT,
    document_id TEXT,
    document_title TEXT NOT NULL,
    document_number TEXT,
    department_code TEXT NOT NULL,
    requester_id TEXT,
    requester_name TEXT NOT NULL,
    current_level INTEGER,
    status TEXT,
    started_at TEXT,
    deadline_at TEXT,
    escalated_at TEXT,
    approved_at TEXT,
    approved_by TEXT,
    rejection_reason TEXT,
    created_at TEXT,
    updated_at TEXT,
    document_version_major INTEGER,
    document_version_minor INTEGER,
    document_version_revision TEXT,
    organization_id TEXT,
    created_by TEXT
);

-- Table: governance_approval_matrices
CREATE TABLE IF NOT EXISTS public.governance_approval_matrices (
    id TEXT NOT NULL,
    organization_id TEXT,
    department_code TEXT NOT NULL,
    document_type TEXT NOT NULL,
    approval_levels unknown NOT NULL,
    auto_approval_threshold NUMERIC,
    deadline_days INTEGER,
    escalation_rules unknown,
    email_templates unknown,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT
);

-- Table: governance_approval_steps
CREATE TABLE IF NOT EXISTS public.governance_approval_steps (
    id TEXT NOT NULL,
    approval_instance_id TEXT NOT NULL,
    step_number INTEGER NOT NULL,
    approver_role TEXT NOT NULL,
    approver_user_id TEXT,
    approver_name TEXT,
    status TEXT,
    action_taken TEXT,
    action_timestamp TEXT,
    notified_at TEXT,
    reminder_sent_at TEXT,
    comments TEXT,
    attachment_urls TEXT[],
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    created_by TEXT
);

-- Table: governance_document_templates
-- Standardized Governance Form Templates - HTML content in html_content TEXT, schema in content_schema JSONB
CREATE TABLE IF NOT EXISTS public.governance_document_templates (
    id TEXT NOT NULL,
    organization_id TEXT,
    organization_name TEXT,
    discipline_id TEXT,
    discipline_name TEXT,
    template_name TEXT NOT NULL,
    template_slug TEXT,
    html_content TEXT,
    json_schema unknown,
    form_metadata unknown,
    source_file_name TEXT,
    source_file_type TEXT,
    extracted_fields_count INTEGER,
    extraction_method TEXT,
    processing_status TEXT,
    version INTEGER,
    parent_template_id TEXT,
    is_default BOOLEAN,
    is_active BOOLEAN,
    created_by TEXT,
    updated_by TEXT,
    created_at TEXT,
    updated_at TEXT,
    deleted_at TEXT,
    content_schema unknown,
    processing_method TEXT,
    document_type TEXT,
    document_type_label TEXT,
    source_governance_template_id TEXT
);

-- Table: governance_document_templates_backup_20251121
CREATE TABLE IF NOT EXISTS public.governance_document_templates_backup_20251121 (
    id TEXT,
    organization_id TEXT,
    organization_name TEXT,
    discipline_id TEXT,
    discipline_name TEXT,
    template_name TEXT,
    template_slug TEXT,
    html_content TEXT,
    json_schema unknown,
    form_metadata unknown,
    source_file_name TEXT,
    source_file_type TEXT,
    extracted_fields_count INTEGER,
    extraction_method TEXT,
    processing_status TEXT,
    version INTEGER,
    parent_template_id TEXT,
    is_default BOOLEAN,
    is_active BOOLEAN,
    created_by TEXT,
    updated_by TEXT,
    created_at TEXT,
    updated_at TEXT,
    deleted_at TEXT,
    content_schema unknown,
    processing_method TEXT,
    document_type TEXT,
    document_type_label TEXT,
    source_governance_template_id TEXT
);

-- Table: governance_document_templates-old
CREATE TABLE IF NOT EXISTS public.governance_document_templates-old (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    category TEXT NOT NULL,
    template_type TEXT,
    fields unknown,
    settings unknown,
    content TEXT,
    status TEXT,
    version INTEGER,
    usage_count INTEGER,
    created_by TEXT,
    updated_by TEXT,
    created_at TEXT,
    updated_at TEXT,
    organizations unknown,
    disciplines unknown,
    sectors unknown,
    metadata unknown
);

-- Table: governance_template_usage
CREATE TABLE IF NOT EXISTS public.governance_template_usage (
    id TEXT NOT NULL,
    template_id TEXT,
    user_id TEXT,
    action TEXT NOT NULL,
    metadata unknown,
    used_at TEXT
);

-- Table: imported_emails_with_placeholder_users
CREATE TABLE IF NOT EXISTS public.imported_emails_with_placeholder_users (
    email_id TEXT,
    subject TEXT,
    sender_email TEXT,
    recipient_email TEXT,
    sent_date TEXT,
    user_id TEXT,
    user_email TEXT,
    user_active BOOLEAN,
    is_placeholder_user BOOLEAN
);

-- Table: inspection_items
CREATE TABLE IF NOT EXISTS public.inspection_items (
    id INTEGER NOT NULL,
    inspection_id TEXT NOT NULL,
    item_id TEXT NOT NULL,
    item_type TEXT NOT NULL,
    description TEXT,
    location TEXT,
    status TEXT,
    priority TEXT,
    assigned_to TEXT,
    due_date TEXT,
    completed_date TEXT,
    notes TEXT,
    media_urls unknown,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: inspection_media
CREATE TABLE IF NOT EXISTS public.inspection_media (
    id INTEGER NOT NULL,
    media_id TEXT NOT NULL,
    inspection_id TEXT,
    inspection_item_id TEXT,
    defect_id TEXT,
    file_name TEXT NOT NULL,
    file_type TEXT NOT NULL,
    file_size INTEGER,
    file_url TEXT NOT NULL,
    storage_path TEXT,
    description TEXT,
    tags unknown,
    uploaded_by TEXT,
    upload_date TEXT,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT
);

-- Table: inspections
CREATE TABLE IF NOT EXISTS public.inspections (
    id INTEGER NOT NULL,
    inspection_id TEXT NOT NULL,
    project_id TEXT NOT NULL,
    inspection_type TEXT NOT NULL,
    scheduled_date TEXT NOT NULL,
    completed_date TEXT,
    inspector_id TEXT,
    facility TEXT,
    status TEXT,
    priority TEXT,
    notes TEXT,
    findings_count INTEGER,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    updated_by TEXT,
    organization_id TEXT
);

-- Table: integration_sources
CREATE TABLE IF NOT EXISTS public.integration_sources (
    id TEXT NOT NULL,
    source_id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    base_url TEXT,
    api_key_encrypted TEXT,
    username_encrypted TEXT,
    password_encrypted TEXT,
    integration_type TEXT NOT NULL,
    status TEXT,
    config unknown,
    last_sync_at TEXT,
    last_successful_sync_at TEXT,
    last_error TEXT,
    sync_interval_minutes INTEGER,
    rate_limit_per_minute INTEGER,
    timeout_seconds INTEGER,
    retry_attempts INTEGER,
    created_at TEXT,
    updated_at TEXT
);

-- Table: integration_sync_history
CREATE TABLE IF NOT EXISTS public.integration_sync_history (
    id TEXT NOT NULL,
    integration_source_id TEXT,
    sync_type TEXT,
    status TEXT NOT NULL,
    records_processed INTEGER,
    records_created INTEGER,
    records_updated INTEGER,
    records_failed INTEGER,
    start_time TEXT NOT NULL,
    end_time TEXT,
    duration_seconds INTEGER,
    error_message TEXT,
    sync_metadata unknown,
    created_at TEXT
);

-- Table: internal_notifications
-- Internal notification system to avoid email dependency
CREATE TABLE IF NOT EXISTS public.internal_notifications (
    id TEXT NOT NULL,
    user_id TEXT,
    type TEXT NOT NULL,
    category TEXT,
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    approval_instance_id TEXT,
    approval_step_id TEXT,
    priority TEXT,
    is_read BOOLEAN,
    read_at TEXT,
    action_required BOOLEAN,
    action_url TEXT,
    created_at TEXT,
    expires_at TEXT
);

-- Table: job_descriptions
CREATE TABLE IF NOT EXISTS public.job_descriptions (
    id TEXT NOT NULL,
    title TEXT NOT NULL,
    location TEXT,
    employment_type TEXT,
    salary_range_min NUMERIC,
    salary_range_max NUMERIC,
    job_description TEXT,
    requirements TEXT,
    responsibilities TEXT,
    benefits TEXT,
    application_deadline TEXT,
    contact_person TEXT,
    status TEXT,
    created_by TEXT,
    updated_by TEXT,
    created_at TEXT,
    updated_at TEXT,
    discipline TEXT
);

-- Table: legal_reviews
-- Legal reviews and compliance checks for contracts and documents
CREATE TABLE IF NOT EXISTS public.legal_reviews (
    id TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    review_type TEXT,
    document_type TEXT,
    urgency TEXT,
    status TEXT,
    assigned_to TEXT,
    organization_id TEXT,
    project_id TEXT,
    due_date TEXT,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    updated_by TEXT
);

-- Table: limits_of_authority
-- Defines organizational limits of authority for document approvals
CREATE TABLE IF NOT EXISTS public.limits_of_authority (
    id TEXT NOT NULL,
    organization_id TEXT NOT NULL,
    department_code TEXT,
    document_type TEXT NOT NULL,
    min_amount NUMERIC,
    max_amount NUMERIC,
    required_approvals unknown NOT NULL,
    conditions unknown,
    is_active BOOLEAN,
    created_by TEXT,
    created_at TEXT,
    updated_at TEXT,
    updated_by TEXT
);

-- Table: llm_configurations
CREATE TABLE IF NOT EXISTS public.llm_configurations (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    provider TEXT NOT NULL,
    model TEXT NOT NULL,
    api_key TEXT,
    status TEXT NOT NULL,
    usage_count INTEGER,
    last_used TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    created_by TEXT,
    updated_by TEXT,
    purposes TEXT[]
);

-- Table: llm_document_type_mappings
CREATE TABLE IF NOT EXISTS public.llm_document_type_mappings (
    id INTEGER NOT NULL,
    llm_configuration_id TEXT,
    document_type TEXT NOT NULL,
    analysis_type TEXT NOT NULL,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    file_format TEXT,
    default_format BOOLEAN,
    organization_id TEXT,
    user_id TEXT
);

-- Table: llm_functions
CREATE TABLE IF NOT EXISTS public.llm_functions (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    function_type TEXT NOT NULL,
    model_name TEXT NOT NULL,
    api_config unknown NOT NULL,
    is_active BOOLEAN,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    created_by TEXT
);

-- Table: logistics_alerts
-- System-generated alerts and notifications
CREATE TABLE IF NOT EXISTS public.logistics_alerts (
    id TEXT NOT NULL,
    alert_type TEXT NOT NULL,
    severity TEXT NOT NULL,
    shipment_id TEXT,
    vessel_id TEXT,
    container_id TEXT,
    alert_title TEXT NOT NULL,
    alert_description TEXT,
    alert_timestamp TEXT,
    status TEXT,
    acknowledged_at TEXT,
    acknowledged_by TEXT,
    resolved_at TEXT,
    resolved_by TEXT,
    action_required BOOLEAN,
    action_description TEXT,
    due_date TEXT,
    created_at TEXT,
    updated_at TEXT,
    company_id TEXT,
    organisation_id TEXT,
    project_id TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: logistics_shipments
-- High-level shipment records
CREATE TABLE IF NOT EXISTS public.logistics_shipments (
    id TEXT NOT NULL,
    shipment_number TEXT NOT NULL,
    shipment_name TEXT,
    shipment_type TEXT,
    shipper_name TEXT,
    shipper_address TEXT,
    consignee_name TEXT,
    consignee_address TEXT,
    freight_forwarder TEXT,
    origin_port TEXT,
    destination_port TEXT,
    transit_ports TEXT[],
    booking_date TEXT,
    planned_departure_date TEXT,
    actual_departure_date TEXT,
    planned_arrival_date TEXT,
    actual_arrival_date TEXT,
    total_value NUMERIC,
    currency TEXT,
    incoterms TEXT,
    payment_terms TEXT,
    shipment_status TEXT,
    priority_level TEXT,
    documents_complete BOOLEAN,
    customs_cleared BOOLEAN,
    insurance_reference TEXT,
    notes TEXT,
    special_instructions TEXT,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    is_active BOOLEAN,
    company_id TEXT,
    organisation_id TEXT,
    project_id TEXT,
    organization_id TEXT
);

-- Table: maintenance_assets
-- Equipment and plant assets for maintenance tracking
CREATE TABLE IF NOT EXISTS public.maintenance_assets (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    manufacturer TEXT,
    model TEXT,
    serial_number TEXT,
    year INTEGER,
    location TEXT,
    status TEXT,
    description TEXT,
    purchase_date TEXT,
    purchase_cost NUMERIC,
    warranty_expiry TEXT,
    last_maintenance TEXT,
    next_due TEXT,
    user_id TEXT,
    project_id TEXT,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT
);

-- Table: maintenance_history
-- Historical record of completed maintenance
CREATE TABLE IF NOT EXISTS public.maintenance_history (
    id TEXT NOT NULL,
    asset_id TEXT,
    work_order_id TEXT,
    schedule_id TEXT,
    maintenance_type TEXT NOT NULL,
    description TEXT NOT NULL,
    performed_by TEXT,
    performed_by_name TEXT,
    performed_date TEXT NOT NULL,
    hours_spent NUMERIC,
    cost NUMERIC,
    parts_used TEXT,
    notes TEXT,
    project_id TEXT,
    created_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: maintenance_schedules
-- Scheduled maintenance for assets
CREATE TABLE IF NOT EXISTS public.maintenance_schedules (
    id TEXT NOT NULL,
    asset_id TEXT,
    asset_name TEXT NOT NULL,
    maintenance_type TEXT NOT NULL,
    frequency INTEGER NOT NULL,
    frequency_unit TEXT,
    description TEXT NOT NULL,
    last_completed TEXT,
    next_due TEXT,
    status TEXT,
    assigned_to TEXT,
    assigned_to_name TEXT,
    created_by TEXT,
    estimated_hours NUMERIC,
    cost_per_service NUMERIC,
    instructions TEXT,
    project_id TEXT,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT
);

-- Table: maintenance_work_orders
-- Work orders for maintenance tasks
CREATE TABLE IF NOT EXISTS public.maintenance_work_orders (
    id TEXT NOT NULL,
    asset_id TEXT,
    asset_name TEXT NOT NULL,
    type TEXT NOT NULL,
    priority TEXT,
    status TEXT,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    assigned_to TEXT,
    assigned_to_name TEXT,
    created_by TEXT,
    due_date TEXT,
    start_date TEXT,
    completion_date TEXT,
    estimated_hours NUMERIC,
    actual_hours NUMERIC,
    cost NUMERIC,
    parts_used TEXT,
    notes TEXT,
    project_id TEXT,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT
);

-- Table: master_engineering_templates
CREATE TABLE IF NOT EXISTS public.master_engineering_templates (
    id TEXT NOT NULL,
    template_name TEXT NOT NULL,
    template_description TEXT,
    discipline TEXT NOT NULL,
    template_category TEXT NOT NULL,
    template_type TEXT NOT NULL,
    risk_level TEXT,
    status TEXT,
    html_content TEXT,
    json_content unknown,
    file_attachments unknown,
    tags TEXT[],
    version INTEGER,
    is_active BOOLEAN,
    is_latest BOOLEAN,
    project_id TEXT,
    approval_required BOOLEAN,
    approved_by TEXT,
    approved_at TEXT,
    published_to_procurement_at TEXT,
    dcs_document_id TEXT,
    dcs_version TEXT,
    organization_id TEXT NOT NULL,
    company_id TEXT NOT NULL,
    created_by TEXT,
    updated_by TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: master_templates
-- Approved organizational template standards for procurement documents
CREATE TABLE IF NOT EXISTS public.master_templates (
    id TEXT NOT NULL,
    template_name TEXT NOT NULL,
    template_type TEXT NOT NULL,
    procurement_category TEXT NOT NULL,
    category_code TEXT,
    status TEXT NOT NULL,
    content unknown,
    approval_workflow unknown,
    version INTEGER,
    is_active BOOLEAN,
    tags TEXT[],
    language_support TEXT[],
    created_at TEXT,
    updated_at TEXT
);

-- Table: match_all_documents
CREATE TABLE IF NOT EXISTS public.match_all_documents (
    source_table TEXT,
    id TEXT,
    content TEXT,
    similarity NUMERIC
);

-- Table: materials
CREATE TABLE IF NOT EXISTS public.materials (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    specifications unknown,
    created_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: migration_rename_log
CREATE TABLE IF NOT EXISTS public.migration_rename_log (
    id INTEGER NOT NULL,
    old_table_name TEXT,
    new_table_name TEXT,
    rename_status TEXT,
    error_message TEXT,
    renamed_at TEXT
);

-- Table: migration_validation_results
CREATE TABLE IF NOT EXISTS public.migration_validation_results (
    id INTEGER NOT NULL,
    check_name TEXT,
    check_type TEXT,
    status TEXT,
    details TEXT,
    checked_at TEXT
);

-- Table: modal_configurations
CREATE TABLE IF NOT EXISTS public.modal_configurations (
    id TEXT NOT NULL,
    modal_key TEXT,
    display_name TEXT,
    component_path TEXT,
    description TEXT,
    target_page_prefix TEXT,
    chatbot_id TEXT,
    integration_type TEXT NOT NULL,
    interaction_style TEXT NOT NULL,
    is_legacy BOOLEAN NOT NULL,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    target_state TEXT,
    sector TEXT,
    sector_id TEXT,
    created_by TEXT,
    updated_by TEXT,
    is_active BOOLEAN,
    is_deleted BOOLEAN,
    sort_order INTEGER,
    tags TEXT[],
    metadata unknown,
    modal_type TEXT,
    page_name TEXT,
    page_prefix TEXT
);

-- Table: monthly_documents_created
CREATE TABLE IF NOT EXISTS public.monthly_documents_created (
    month_year TEXT,
    documents_created INTEGER
);

-- Table: multi_source_tenders
CREATE TABLE IF NOT EXISTS public.multi_source_tenders (
    id TEXT NOT NULL,
    tender_id TEXT,
    source_id TEXT,
    external_id TEXT NOT NULL,
    source_system TEXT NOT NULL,
    source_data unknown NOT NULL,
    transformed_data unknown,
    data_quality_score NUMERIC,
    conflict_resolution TEXT,
    last_conflict_at TEXT,
    conflict_notes TEXT,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: notifications
-- User notifications for tender opportunities and system alerts
CREATE TABLE IF NOT EXISTS public.notifications (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    type TEXT,
    title TEXT,
    message TEXT,
    data unknown,
    is_read BOOLEAN,
    read_at TEXT,
    created_at TEXT,
    organization_id TEXT
);

-- Table: numbering_config
CREATE TABLE IF NOT EXISTS public.numbering_config (
    organization_id TEXT NOT NULL,
    config unknown NOT NULL,
    created_at TEXT,
    updated_at TEXT
);

-- Table: numbering_methodologies
CREATE TABLE IF NOT EXISTS public.numbering_methodologies (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    organization_id TEXT NOT NULL,
    pattern_template TEXT NOT NULL,
    is_default BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: numbering_patterns
CREATE TABLE IF NOT EXISTS public.numbering_patterns (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    organization_id TEXT NOT NULL,
    pattern TEXT NOT NULL,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: operations_equipment
CREATE TABLE IF NOT EXISTS public.operations_equipment (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    specifications unknown,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: organisations_backup
CREATE TABLE IF NOT EXISTS public.organisations_backup (
    id INTEGER,
    name TEXT,
    sector_id TEXT,
    is_active BOOLEAN,
    is_template BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    uuid TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: organization_collaborations
-- Defines collaborations between organizations for cross-organizational accordion sharing
CREATE TABLE IF NOT EXISTS public.organization_collaborations (
    id TEXT NOT NULL,
    primary_organization_id TEXT NOT NULL,
    collaborating_organization_id TEXT NOT NULL,
    shared_sections TEXT[],
    agent_sharing_permissions TEXT[],
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    primary_org_supabase_config unknown,
    context_mapping unknown,
    page_precedence TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: organization_db_configs
-- View of organizations with valid Supabase database configurations for multi-database context switching
CREATE TABLE IF NOT EXISTS public.organization_db_configs (
    id TEXT,
    name TEXT,
    supabase_url TEXT,
    supabase_anon_key TEXT,
    supabase_service_key TEXT,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: organization_users
CREATE TABLE IF NOT EXISTS public.organization_users (
    id TEXT NOT NULL,
    organization_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    discipline_id TEXT NOT NULL,
    role TEXT,
    status TEXT,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    updated_by TEXT
);

-- Table: organizations
CREATE TABLE IF NOT EXISTS public.organizations (
    name TEXT NOT NULL,
    sector_id TEXT,
    is_active BOOLEAN,
    is_template BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    id TEXT NOT NULL,
    supabase_url TEXT,
    supabase_anon_key TEXT,
    supabase_service_key TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: page_permissions
CREATE TABLE IF NOT EXISTS public.page_permissions (
    id TEXT NOT NULL,
    page_path TEXT NOT NULL,
    role_id INTEGER NOT NULL,
    has_access BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    updated_by TEXT
);

-- Table: pages
CREATE TABLE IF NOT EXISTS public.pages (
    page_id TEXT NOT NULL,
    page_prefix TEXT NOT NULL,
    page_name TEXT NOT NULL,
    page_slug TEXT NOT NULL,
    sector_id TEXT,
    organization_id TEXT,
    organisation_name TEXT,
    sector_name TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    display_order INTEGER,
    parent_page_id TEXT,
    organisation_id TEXT,
    sector_uuid TEXT,
    is_active BOOLEAN,
    hierarchy_level INTEGER,
    is_standard_link BOOLEAN,
    is_virtual BOOLEAN,
    organisation_ids TEXT[]
);

-- Table: pages_directors_backup_20250726
CREATE TABLE IF NOT EXISTS public.pages_directors_backup_20250726 (
    page_id TEXT,
    page_prefix TEXT,
    page_name TEXT,
    page_slug TEXT,
    sector_id TEXT,
    organization_id TEXT,
    organisation_name TEXT,
    sector_name TEXT,
    created_at TEXT,
    updated_at TEXT,
    display_order INTEGER,
    parent_page_id TEXT,
    organisation_id TEXT,
    sector_uuid TEXT,
    is_active BOOLEAN
);

-- Table: pages_with_clear_columns
CREATE TABLE IF NOT EXISTS public.pages_with_clear_columns (
    page_id TEXT,
    page_prefix TEXT,
    page_name TEXT,
    page_slug TEXT,
    sector_id TEXT,
    organization_id TEXT,
    sector_uuid TEXT,
    old_sector_id TEXT,
    organisation_name TEXT,
    sector_name TEXT,
    created_at TEXT,
    updated_at TEXT,
    display_order INTEGER,
    parent_page_id TEXT,
    data_consistency TEXT
);

-- Table: pages_with_organization_mapping
CREATE TABLE IF NOT EXISTS public.pages_with_organization_mapping (
    page_id TEXT,
    page_prefix TEXT,
    page_name TEXT,
    page_slug TEXT,
    sector_id TEXT,
    organization_id TEXT,
    sector_uuid TEXT,
    old_sector_id TEXT,
    organisation_name TEXT,
    sector_name TEXT,
    created_at TEXT,
    updated_at TEXT,
    display_order INTEGER,
    parent_page_id TEXT,
    organization_name TEXT,
    sector_name_clear TEXT
);

-- Table: path_configurations
-- Template configurations for generating document storage paths per organization
CREATE TABLE IF NOT EXISTS public.path_configurations (
    id TEXT NOT NULL,
    organization_id TEXT,
    name TEXT NOT NULL,
    components unknown NOT NULL,
    is_default BOOLEAN,
    created_by TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: performance_alerts
CREATE TABLE IF NOT EXISTS public.performance_alerts (
    id TEXT NOT NULL,
    alert_type TEXT NOT NULL,
    severity TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    metadata unknown,
    is_active BOOLEAN NOT NULL,
    discipline_code TEXT,
    created_by TEXT,
    created_at TEXT,
    resolved_at TEXT,
    resolved_by TEXT
);

-- Table: performance_metrics
CREATE TABLE IF NOT EXISTS public.performance_metrics (
    id TEXT NOT NULL,
    metric_type TEXT NOT NULL,
    value NUMERIC,
    metadata unknown,
    user_id TEXT,
    discipline_code TEXT,
    created_at TEXT
);

-- Table: personnel_records
CREATE TABLE IF NOT EXISTS public.personnel_records (
    id TEXT NOT NULL,
    user_id TEXT,
    employee_id TEXT,
    department TEXT,
    position TEXT,
    hire_date TEXT,
    termination_date TEXT,
    manager_id TEXT,
    salary NUMERIC,
    employment_type TEXT,
    location TEXT,
    phone TEXT,
    emergency_contact_name TEXT,
    emergency_contact_phone TEXT,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT
);

-- Table: petty_cash
-- Petty cash reimbursement requests with approval workflow
CREATE TABLE IF NOT EXISTS public.petty_cash (
    id TEXT NOT NULL,
    project_id TEXT,
    user_id TEXT,
    date TEXT NOT NULL,
    amount NUMERIC NOT NULL,
    category TEXT NOT NULL,
    description TEXT NOT NULL,
    receipt_url TEXT,
    receipt_filename TEXT,
    status TEXT,
    submitted_at TEXT,
    approved_at TEXT,
    rejected_at TEXT,
    approver_id TEXT,
    rejection_reason TEXT,
    created_at TEXT,
    updated_at TEXT,
    project_name TEXT,
    user_name TEXT,
    phase_id TEXT,
    organization_id TEXT
);

-- Table: ports
-- Reference table for ports and terminals
CREATE TABLE IF NOT EXISTS public.ports (
    id TEXT NOT NULL,
    port_code TEXT NOT NULL,
    port_name TEXT NOT NULL,
    country_code TEXT,
    country_name TEXT,
    latitude NUMERIC,
    longitude NUMERIC,
    time_zone TEXT,
    port_type TEXT,
    facilities TEXT[],
    max_vessel_length NUMERIC,
    max_vessel_beam NUMERIC,
    max_draft NUMERIC,
    working_hours TEXT,
    customs_hours TEXT,
    services TEXT[],
    created_at TEXT,
    updated_at TEXT,
    is_active BOOLEAN,
    organization_id TEXT,
    user_id TEXT
);

-- Table: processing_statistics
CREATE TABLE IF NOT EXISTS public.processing_statistics (
    organization_name TEXT,
    processing_type TEXT,
    processing_status TEXT,
    file_type TEXT,
    total_count INTEGER,
    avg_processing_time NUMERIC,
    avg_extracted_fields NUMERIC,
    earliest_entry TEXT,
    latest_entry TEXT
);

-- Table: procurement_approvals
CREATE TABLE IF NOT EXISTS public.procurement_approvals (
    id TEXT NOT NULL,
    procurement_order_id TEXT NOT NULL,
    approver_role TEXT NOT NULL,
    user_id TEXT,
    status TEXT,
    approval_level INTEGER NOT NULL,
    comments TEXT,
    approved_at TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: procurement_categories
-- Hierarchical procurement categories system with i18n support (English/French)
CREATE TABLE IF NOT EXISTS public.procurement_categories (
    id TEXT NOT NULL,
    level1_code TEXT,
    level1_name TEXT,
    level1_name_fr TEXT,
    level2_code TEXT,
    level2_name TEXT,
    level2_name_fr TEXT,
    level3_code TEXT,
    level3_name TEXT,
    level3_name_fr TEXT,
    is_active BOOLEAN,
    display_order INTEGER,
    created_at TEXT,
    organization_id TEXT
);

-- Table: procurement_contributions
CREATE TABLE IF NOT EXISTS public.procurement_contributions (
    id TEXT NOT NULL,
    procurement_order_id TEXT NOT NULL,
    appendix_key TEXT NOT NULL,
    discipline_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    content TEXT,
    status TEXT,
    assigned_at TEXT,
    completed_at TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: procurement_order_documents
CREATE TABLE IF NOT EXISTS public.procurement_order_documents (
    id TEXT NOT NULL,
    procurement_order_id TEXT NOT NULL,
    document_id TEXT NOT NULL,
    document_type TEXT NOT NULL,
    reference_type TEXT NOT NULL,
    project_phase TEXT,
    procurement_category TEXT,
    added_at TEXT,
    added_by TEXT NOT NULL,
    notes TEXT,
    organization_id TEXT,
    user_id TEXT,
    template_reference_id TEXT,
    appendix_order INTEGER,
    generated_html TEXT,
    version_number INTEGER
);

-- Table: procurement_orders
-- Dedicated table for actual procurement orders (separate from reusable templates)
CREATE TABLE IF NOT EXISTS public.procurement_orders (
    id TEXT NOT NULL,
    order_number TEXT,
    order_type TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    department TEXT,
    priority TEXT,
    estimated_value NUMERIC,
    currency TEXT,
    supplier_name TEXT,
    supplier_contact TEXT,
    project_id TEXT,
    project_phase TEXT,
    template_id TEXT,
    linked_documents unknown,
    approval_status TEXT,
    delivery_date TEXT,
    special_requirements TEXT,
    created_by TEXT NOT NULL,
    organization_id TEXT,
    created_at TEXT,
    updated_at TEXT,
    sow_id TEXT,
    sow_template_id TEXT,
    appendix_a_content TEXT,
    appendix_b_content TEXT,
    appendix_c_content TEXT,
    appendix_d_content TEXT,
    appendix_e_content TEXT,
    appendix_f_content TEXT,
    approval_cover_content TEXT,
    main_order_content TEXT,
    discipline_assignments unknown,
    contribution_status unknown,
    approval_matrix unknown,
    approval_routing_type TEXT,
    approval_config unknown,
    user_assignments unknown,
    task_sequence unknown,
    template_variation TEXT,
    sequence_override_id TEXT,
    estimated_completion_time TEXT,
    sequence_execution_id TEXT
);

-- Table: procurement_signatures
CREATE TABLE IF NOT EXISTS public.procurement_signatures (
    id TEXT NOT NULL,
    contract_id TEXT,
    signature_document_id TEXT,
    procurement_phase TEXT NOT NULL,
    procurement_stage TEXT NOT NULL,
    required_signatories INTEGER NOT NULL,
    collected_signatures INTEGER,
    deadline TEXT,
    status TEXT,
    completed_at TEXT,
    expired_at TEXT,
    initiated_by TEXT,
    business_case TEXT,
    special_conditions TEXT,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    created_by TEXT
);

-- Table: procurement_templates
CREATE TABLE IF NOT EXISTS public.procurement_templates (
    id TEXT NOT NULL,
    document_id TEXT,
    organization_id TEXT,
    created_by TEXT,
    updated_by TEXT,
    template_name TEXT NOT NULL,
    template_description TEXT,
    template_type TEXT NOT NULL,
    template_category TEXT,
    level1_code TEXT,
    level2_code TEXT,
    level3_code TEXT,
    template_content unknown,
    field_protection unknown,
    protection_enabled BOOLEAN,
    is_latest BOOLEAN,
    version_number INTEGER,
    approval_status TEXT,
    approved_by TEXT,
    approved_at TEXT,
    related_documents unknown,
    compliance_requirements unknown,
    lifecycle_stage TEXT,
    tags TEXT[],
    created_at TEXT,
    updated_at TEXT,
    access_level TEXT,
    discipline TEXT,
    allowed_roles unknown,
    component_type TEXT,
    mandatory BOOLEAN,
    approval_workflow unknown,
    html_content TEXT,
    document_type TEXT,
    document_type_label TEXT,
    discipline_code TEXT,
    appendix_letter TEXT,
    sow_integration_enabled BOOLEAN,
    organization_name TEXT,
    discipline_name TEXT,
    source_governance_template_id TEXT
);

-- Table: procurement_templates_backup_20251121
CREATE TABLE IF NOT EXISTS public.procurement_templates_backup_20251121 (
    id TEXT,
    document_id TEXT,
    organization_id TEXT,
    created_by TEXT,
    updated_by TEXT,
    template_name TEXT,
    template_description TEXT,
    template_type TEXT,
    template_category TEXT,
    level1_code TEXT,
    level2_code TEXT,
    level3_code TEXT,
    template_content unknown,
    field_protection unknown,
    protection_enabled BOOLEAN,
    is_latest BOOLEAN,
    version_number INTEGER,
    approval_status TEXT,
    approved_by TEXT,
    approved_at TEXT,
    related_documents unknown,
    compliance_requirements unknown,
    lifecycle_stage TEXT,
    tags TEXT[],
    created_at TEXT,
    updated_at TEXT,
    access_level TEXT,
    discipline TEXT,
    allowed_roles unknown,
    component_type TEXT,
    mandatory BOOLEAN,
    approval_workflow unknown,
    html_content TEXT,
    document_type TEXT,
    document_type_label TEXT,
    discipline_code TEXT,
    appendix_letter TEXT,
    sow_integration_enabled BOOLEAN,
    organization_name TEXT,
    discipline_name TEXT,
    source_governance_template_id TEXT
);

-- Table: project_engineering_templates
CREATE TABLE IF NOT EXISTS public.project_engineering_templates (
    id TEXT NOT NULL,
    template_id TEXT NOT NULL,
    project_id TEXT NOT NULL,
    custom_name TEXT,
    custom_description TEXT,
    custom_html_content TEXT,
    custom_json_content unknown,
    is_required BOOLEAN,
    required_by TEXT,
    completed_at TEXT,
    completed_by TEXT,
    project_approval_status TEXT,
    project_approved_by TEXT,
    project_approved_at TEXT,
    organization_id TEXT NOT NULL,
    company_id TEXT NOT NULL,
    created_by TEXT,
    created_at TEXT
);

-- Table: project_permissions
-- User-based project access control with phase-level permissions
CREATE TABLE IF NOT EXISTS public.project_permissions (
    project_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    has_access BOOLEAN NOT NULL,
    phases_access unknown,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    updated_by TEXT
);

-- Table: project_phase_assignments
CREATE TABLE IF NOT EXISTS public.project_phase_assignments (
    id TEXT NOT NULL,
    project_id TEXT,
    phase_id TEXT,
    custom_name TEXT,
    is_active BOOLEAN,
    start_date TEXT,
    end_date TEXT,
    sort_order INTEGER,
    created_at TEXT,
    updated_at TEXT
);

-- Table: project_phases
-- Standard project phases used across all projects
CREATE TABLE IF NOT EXISTS public.project_phases (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    phase_code TEXT,
    sort_order INTEGER,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    updated_by TEXT,
    organization_id TEXT
);

-- Table: project_procurement_templates
CREATE TABLE IF NOT EXISTS public.project_procurement_templates (
    id TEXT NOT NULL,
    document_id TEXT,
    organization_id TEXT,
    created_by TEXT,
    updated_by TEXT,
    template_name TEXT NOT NULL,
    template_description TEXT,
    template_type TEXT NOT NULL,
    template_category TEXT,
    level1_code TEXT,
    level2_code TEXT,
    level3_code TEXT,
    template_content unknown,
    field_protection unknown,
    protection_enabled BOOLEAN,
    is_latest BOOLEAN,
    version_number INTEGER,
    approval_status TEXT,
    approved_by TEXT,
    approved_at TEXT,
    related_documents unknown,
    compliance_requirements unknown,
    lifecycle_stage TEXT,
    tags TEXT[],
    created_at TEXT,
    updated_at TEXT,
    access_level TEXT,
    discipline TEXT,
    allowed_roles unknown,
    component_type TEXT,
    mandatory BOOLEAN,
    project_id TEXT NOT NULL,
    prepared_by TEXT,
    prepared_at TEXT,
    template_scope TEXT,
    approval_workflow unknown,
    html_content TEXT,
    document_type TEXT,
    document_type_label TEXT,
    discipline_code TEXT,
    appendix_letter TEXT,
    sow_integration_enabled BOOLEAN,
    organization_name TEXT,
    discipline_name TEXT,
    source_governance_template_id TEXT
);

-- Table: project_template_preparation
CREATE TABLE IF NOT EXISTS public.project_template_preparation (
    project_id TEXT NOT NULL,
    prepared_at TEXT,
    prepared_by TEXT,
    disciplines_prepared TEXT[],
    total_templates INTEGER,
    status TEXT,
    agent_notifications_sent BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: project_templates
-- Project-specific template copies with auto-populated data from SOW
CREATE TABLE IF NOT EXISTS public.project_templates (
    id TEXT NOT NULL,
    project_id TEXT NOT NULL,
    master_template_id TEXT,
    template_name TEXT NOT NULL,
    template_type TEXT NOT NULL,
    category TEXT,
    status TEXT,
    content unknown,
    populated_data unknown,
    sow_reference TEXT,
    auto_populated_at TEXT,
    reviewed_at TEXT,
    approved_at TEXT,
    executed_at TEXT,
    total_value NUMERIC,
    currency TEXT,
    vendor_id TEXT,
    contract_number TEXT,
    notes TEXT,
    priority TEXT,
    requires_technical_review BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    form_template_id TEXT,
    customized_content unknown,
    deployment_rules unknown,
    deployed_to_doc_control BOOLEAN,
    deployed_at TEXT,
    created_by TEXT,
    updated_by TEXT
);

-- Table: projects
-- Projects belonging to companies
CREATE TABLE IF NOT EXISTS public.projects (
    company_id INTEGER,
    name TEXT NOT NULL,
    project_type TEXT,
    created_at TEXT,
    updated_at TEXT,
    id TEXT NOT NULL,
    project_number TEXT,
    project_description TEXT,
    site_location TEXT,
    delivery_date TEXT,
    completion_date TEXT,
    cost_center TEXT,
    budget_code TEXT,
    workflow_status TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: prompt_usage_audit
-- Detailed audit trail of prompt usage by scripts and services for analytics and debugging
CREATE TABLE IF NOT EXISTS public.prompt_usage_audit (
    id TEXT NOT NULL,
    prompt_id TEXT NOT NULL,
    script_name TEXT NOT NULL,
    operation_type TEXT,
    metadata unknown,
    response_time_ms INTEGER,
    success BOOLEAN,
    created_at TEXT
);

-- Table: prompt_usage_summary
CREATE TABLE IF NOT EXISTS public.prompt_usage_summary (
    prompt_name TEXT,
    prompt_id TEXT,
    is_active BOOLEAN,
    total_calls INTEGER,
    successful_calls INTEGER,
    avg_response_time_ms NUMERIC,
    last_used TEXT,
    unique_scripts INTEGER,
    scripts_using TEXT
);

-- Table: prompts
-- Stores AI prompts and templates used throughout the system for various AI-powered features
CREATE TABLE IF NOT EXISTS public.prompts (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    content TEXT NOT NULL,
    description TEXT,
    organization_id TEXT,
    sector_id TEXT,
    type TEXT,
    category TEXT,
    tags TEXT[],
    is_active BOOLEAN,
    metadata unknown,
    created_at TEXT,
    updated_at TEXT,
    key TEXT,
    role_type TEXT,
    access_permissions unknown,
    created_by TEXT,
    cross_reference_id TEXT,
    pages_used TEXT[],
    date_added TEXT,
    date_modified TEXT,
    script_usage unknown,
    usage_statistics unknown,
    workflow_context unknown,
    performance_requirements unknown,
    agent_capabilities unknown,
    integration_points unknown,
    success_criteria unknown,
    prompt_version TEXT,
    last_tested TEXT,
    test_results unknown
);

-- Table: prompts_enhanced
CREATE TABLE IF NOT EXISTS public.prompts_enhanced (
    id TEXT,
    name TEXT,
    content TEXT,
    description TEXT,
    organization_id TEXT,
    sector_id TEXT,
    type TEXT,
    category TEXT,
    tags TEXT[],
    is_active BOOLEAN,
    metadata unknown,
    created_at TEXT,
    updated_at TEXT,
    key TEXT,
    role_type TEXT,
    access_permissions unknown,
    created_by TEXT,
    cross_reference_id TEXT,
    pages_used TEXT[],
    date_added TEXT,
    date_modified TEXT,
    script_usage unknown,
    usage_statistics unknown,
    workflow_context unknown,
    performance_requirements unknown,
    agent_capabilities unknown,
    integration_points unknown,
    success_criteria unknown,
    prompt_version TEXT,
    last_tested TEXT,
    test_results unknown,
    workflow_triggers TEXT,
    workflow_dependencies TEXT,
    workflow_outputs TEXT,
    target_accuracy NUMERIC,
    max_processing_time INTEGER,
    expected_field_count INTEGER,
    supported_disciplines TEXT,
    supported_document_types TEXT,
    supports_multi_agent BOOLEAN,
    integrated_pages TEXT,
    integrated_apis TEXT,
    integrated_databases TEXT,
    accuracy_threshold NUMERIC,
    quality_score_min NUMERIC,
    last_success_rate NUMERIC,
    avg_processing_time NUMERIC,
    total_tests_run INTEGER
);

-- Table: prompts_with_rbac
CREATE TABLE IF NOT EXISTS public.prompts_with_rbac (
    id TEXT,
    name TEXT,
    content TEXT,
    description TEXT,
    organization_id TEXT,
    sector_id TEXT,
    type TEXT,
    category TEXT,
    tags TEXT[],
    is_active BOOLEAN,
    metadata unknown,
    created_at TEXT,
    updated_at TEXT,
    key TEXT,
    role_type TEXT,
    access_permissions unknown,
    created_by TEXT,
    role_description TEXT,
    dev_can_access BOOLEAN,
    user_can_edit BOOLEAN,
    user_can_create BOOLEAN,
    user_can_delete BOOLEAN
);

-- Table: quality_checks
-- Quality inspection and validation tasks across projects
CREATE TABLE IF NOT EXISTS public.quality_checks (
    id TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    check_type TEXT,
    severity TEXT,
    location TEXT,
    status TEXT,
    assigned_to TEXT,
    organization_id TEXT,
    project_id TEXT,
    due_date TEXT,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    updated_by TEXT
);

-- Table: rate_limits
-- Rate limiting data to prevent abuse and ensure fair usage
CREATE TABLE IF NOT EXISTS public.rate_limits (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    api_config_id TEXT,
    discipline_code TEXT,
    limit_type TEXT NOT NULL,
    request_count INTEGER NOT NULL,
    limit_value INTEGER NOT NULL,
    window_start TEXT NOT NULL,
    window_end TEXT NOT NULL,
    blocked_until TEXT,
    metadata unknown,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);

-- Table: recent_audit_activity
CREATE TABLE IF NOT EXISTS public.recent_audit_activity (
    id TEXT,
    user_id TEXT,
    user_email TEXT,
    action TEXT,
    resource_type TEXT,
    resource_id TEXT,
    discipline_code TEXT,
    ip_address TEXT,
    user_agent TEXT,
    success BOOLEAN,
    error_message TEXT,
    metadata unknown,
    created_at TEXT
);

-- Table: record _manager
-- to manage records within the database
CREATE TABLE IF NOT EXISTS public.record _manager (
    id INTEGER NOT NULL,
    created_at TEXT NOT NULL,
    group_id TEXT,
    source_id_key TEXT
);

-- Table: resource_documentation
CREATE TABLE IF NOT EXISTS public.resource_documentation (
    id TEXT NOT NULL,
    resource_id TEXT NOT NULL,
    resource_type TEXT NOT NULL,
    storage_service TEXT NOT NULL,
    storage_url TEXT NOT NULL,
    document_id TEXT NOT NULL,
    sections unknown NOT NULL,
    created_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: resource_prompts
CREATE TABLE IF NOT EXISTS public.resource_prompts (
    resource_id TEXT NOT NULL,
    resource_type TEXT NOT NULL,
    prompt_id TEXT NOT NULL,
    applicable_sections TEXT[],
    created_at TEXT
);

-- Table: risk_assessments
CREATE TABLE IF NOT EXISTS public.risk_assessments (
    id INTEGER NOT NULL,
    risk_id TEXT NOT NULL,
    inspection_id TEXT NOT NULL,
    project_id TEXT NOT NULL,
    risk_level TEXT NOT NULL,
    probability NUMERIC,
    impact NUMERIC,
    description TEXT,
    mitigation_plan TEXT,
    assigned_to TEXT,
    status TEXT,
    review_date TEXT,
    closed_date TEXT,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    updated_by TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: role_definitions
CREATE TABLE IF NOT EXISTS public.role_definitions (
    id INTEGER NOT NULL,
    role_name TEXT NOT NULL,
    permissions unknown NOT NULL,
    created_at TEXT,
    updated_at TEXT,
    description TEXT,
    is_active BOOLEAN
);

-- Table: routing_notifications
CREATE TABLE IF NOT EXISTS public.routing_notifications (
    id INTEGER NOT NULL,
    workflow_id INTEGER,
    routing_step_id INTEGER,
    recipient_id TEXT,
    recipient_role TEXT,
    notification_type TEXT NOT NULL,
    notification_priority TEXT,
    subject TEXT,
    message TEXT,
    notification_data unknown,
    sent BOOLEAN,
    sent_at TEXT,
    read_at TEXT,
    response_url TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: routing_step_actions
CREATE TABLE IF NOT EXISTS public.routing_step_actions (
    id INTEGER NOT NULL,
    routing_step_id INTEGER,
    participant_id TEXT,
    participant_role TEXT,
    action_type TEXT NOT NULL,
    action_status TEXT,
    action_comment TEXT,
    action_data unknown,
    deadline TEXT,
    reminded_at TEXT,
    completed_at TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: routing_step_participants
CREATE TABLE IF NOT EXISTS public.routing_step_participants (
    id INTEGER NOT NULL,
    step_id INTEGER,
    participant_type TEXT NOT NULL,
    participant_identifier TEXT,
    required BOOLEAN,
    notification_enabled BOOLEAN,
    notification_priority TEXT,
    created_at TEXT
);

-- Table: routing_template_steps
CREATE TABLE IF NOT EXISTS public.routing_template_steps (
    id INTEGER NOT NULL,
    template_id INTEGER,
    step_order INTEGER NOT NULL,
    step_name TEXT NOT NULL,
    step_description TEXT,
    step_type TEXT NOT NULL,
    routing_mode TEXT NOT NULL,
    required_approvals INTEGER,
    deadline_hours INTEGER,
    escalate_after_hours INTEGER,
    escalate_to_role TEXT,
    is_optional BOOLEAN,
    auto_advance BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: safety_incidents
-- Safety incidents requiring investigation and resolution
CREATE TABLE IF NOT EXISTS public.safety_incidents (
    id TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    incident_type TEXT,
    severity TEXT,
    location TEXT,
    status TEXT,
    assigned_to TEXT,
    organization_id TEXT,
    project_id TEXT,
    reported_by TEXT,
    incident_date TEXT,
    due_date TEXT,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    updated_by TEXT
);

-- Table: safety_template_categories
-- Categorization system for safety templates
CREATE TABLE IF NOT EXISTS public.safety_template_categories (
    id TEXT NOT NULL,
    category_code TEXT NOT NULL,
    category_name TEXT NOT NULL,
    category_description TEXT,
    parent_category_id TEXT,
    is_active BOOLEAN,
    sort_order INTEGER,
    created_at TEXT
);

-- Table: safety_template_dependencies
-- Relationships and dependencies between safety templates
CREATE TABLE IF NOT EXISTS public.safety_template_dependencies (
    id TEXT NOT NULL,
    parent_template_id TEXT,
    dependent_template_id TEXT,
    dependency_type TEXT NOT NULL,
    description TEXT,
    applies_to_sites TEXT[],
    is_active BOOLEAN,
    valid_from TEXT,
    valid_to TEXT,
    created_by TEXT,
    created_at TEXT
);

-- Table: safety_template_usage
-- Audit trail and analytics for safety template usage
CREATE TABLE IF NOT EXISTS public.safety_template_usage (
    id TEXT NOT NULL,
    template_id TEXT,
    user_id TEXT,
    action_type TEXT NOT NULL,
    site_location TEXT,
    contractor_name TEXT,
    session_id TEXT,
    user_agent TEXT,
    ip_address TEXT,
    timestamp TEXT
);

-- Table: safety_templates
-- Standardized HSE Safety Templates - HTML content in html_content TEXT, schema in content_schema JSONB
CREATE TABLE IF NOT EXISTS public.safety_templates (
    id TEXT NOT NULL,
    organization_id TEXT,
    discipline_id TEXT,
    template_name TEXT NOT NULL,
    template_description TEXT,
    template_type TEXT NOT NULL,
    template_category TEXT,
    template_content unknown,
    form_schema unknown,
    html_content TEXT,
    risk_level TEXT,
    applicable_sites TEXT[],
    required_certifications TEXT[],
    review_frequency TEXT,
    status TEXT,
    is_active BOOLEAN,
    approval_status TEXT,
    version TEXT,
    is_latest BOOLEAN,
    created_by TEXT,
    created_at TEXT,
    updated_by TEXT,
    updated_at TEXT,
    approved_by TEXT,
    approved_at TEXT,
    content_schema unknown,
    content_metadata unknown,
    document_type TEXT,
    document_type_label TEXT,
    organization_name TEXT,
    discipline_name TEXT,
    source_governance_template_id TEXT
);

-- Table: safety_templates_backup_20251121
CREATE TABLE IF NOT EXISTS public.safety_templates_backup_20251121 (
    id TEXT,
    organization_id TEXT,
    discipline_id TEXT,
    template_name TEXT,
    template_description TEXT,
    template_type TEXT,
    template_category TEXT,
    template_content unknown,
    form_schema unknown,
    html_content TEXT,
    risk_level TEXT,
    applicable_sites TEXT[],
    required_certifications TEXT[],
    review_frequency TEXT,
    status TEXT,
    is_active BOOLEAN,
    approval_status TEXT,
    version TEXT,
    is_latest BOOLEAN,
    created_by TEXT,
    created_at TEXT,
    updated_by TEXT,
    updated_at TEXT,
    approved_by TEXT,
    approved_at TEXT,
    content_schema unknown,
    content_metadata unknown,
    document_type TEXT,
    document_type_label TEXT,
    organization_name TEXT,
    discipline_name TEXT,
    source_governance_template_id TEXT
);

-- Table: schema_migrations
CREATE TABLE IF NOT EXISTS public.schema_migrations (
    version INTEGER NOT NULL,
    applied_at TEXT,
    description TEXT
);

-- Table: scope_of_work
CREATE TABLE IF NOT EXISTS public.scope_of_work (
    id TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    project_id TEXT,
    status TEXT,
    priority TEXT,
    estimated_cost NUMERIC,
    target_completion_date TEXT,
    assigned_to TEXT,
    scope_type TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT,
    additional_context TEXT,
    project_specifications TEXT,
    compliance_requirements TEXT,
    reference_urls TEXT,
    reference_documents TEXT,
    content TEXT,
    draft_saved BOOLEAN,
    category TEXT,
    discipline_id TEXT,
    organization_id TEXT
);

-- Table: scope_of_work_relationships
CREATE TABLE IF NOT EXISTS public.scope_of_work_relationships (
    id TEXT NOT NULL,
    scope_of_work_id TEXT,
    related_document_id TEXT,
    relationship_type TEXT,
    procurement_code TEXT,
    description TEXT,
    is_active BOOLEAN,
    created_by TEXT,
    created_at TEXT
);

-- Table: section_hierarchy
CREATE TABLE IF NOT EXISTS public.section_hierarchy (
    id TEXT NOT NULL,
    parent_section_key TEXT,
    child_section_key TEXT,
    display_order INTEGER,
    is_virtual BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: section_organization_mapping
CREATE TABLE IF NOT EXISTS public.section_organization_mapping (
    id TEXT NOT NULL,
    section_key TEXT NOT NULL,
    organization_id TEXT NOT NULL,
    is_visible BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: section_pages
-- Maps pages to sections using section_key
CREATE TABLE IF NOT EXISTS public.section_pages (
    id TEXT NOT NULL,
    section_key TEXT NOT NULL,
    page_id TEXT NOT NULL,
    display_order INTEGER NOT NULL,
    is_subsection BOOLEAN,
    parent_page_id TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: sections
-- Defines accordion sections with metadata, linked by section_key
CREATE TABLE IF NOT EXISTS public.sections (
    id TEXT NOT NULL,
    section_key TEXT NOT NULL,
    section_name TEXT NOT NULL,
    section_description TEXT,
    section_icon TEXT,
    display_order INTEGER NOT NULL,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: sectors
CREATE TABLE IF NOT EXISTS public.sectors (
    sector_id TEXT NOT NULL,
    sector_name TEXT NOT NULL,
    is_active BOOLEAN NOT NULL,
    page_number_prefix_start INTEGER NOT NULL,
    page_number_prefix_end INTEGER NOT NULL,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);

-- Table: security_alerts
-- Security alerts and incidents requiring attention
CREATE TABLE IF NOT EXISTS public.security_alerts (
    id TEXT NOT NULL,
    alert_type TEXT NOT NULL,
    severity TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    user_id TEXT,
    api_config_id TEXT,
    ip_address TEXT,
    user_agent TEXT,
    metadata unknown,
    acknowledged BOOLEAN NOT NULL,
    acknowledged_by TEXT,
    acknowledged_at TEXT,
    resolved BOOLEAN NOT NULL,
    resolved_at TEXT,
    created_at TEXT NOT NULL
);

-- Table: security_audit_log
CREATE TABLE IF NOT EXISTS public.security_audit_log (
    id TEXT NOT NULL,
    audit_type TEXT NOT NULL,
    audit_date TEXT NOT NULL,
    results unknown NOT NULL,
    execution_time TEXT,
    tables_scanned INTEGER,
    policies_found INTEGER,
    critical_issues INTEGER,
    created_at TEXT
);

-- Table: sequence_overrides
CREATE TABLE IF NOT EXISTS public.sequence_overrides (
    id TEXT NOT NULL,
    organization_id TEXT,
    procurement_order_id TEXT,
    template_variation_id TEXT,
    original_sequence unknown NOT NULL,
    overridden_sequence unknown NOT NULL,
    override_reason TEXT NOT NULL,
    override_type TEXT NOT NULL,
    overridden_by TEXT,
    approval_status TEXT,
    approved_by TEXT,
    approved_at TEXT,
    approval_notes TEXT,
    validation_results unknown,
    created_at TEXT,
    updated_at TEXT
);

-- Table: shipment_containers
-- Junction table linking shipments to containers
CREATE TABLE IF NOT EXISTS public.shipment_containers (
    id TEXT NOT NULL,
    shipment_id TEXT,
    container_id TEXT,
    sequence_number INTEGER,
    loading_order INTEGER,
    created_at TEXT,
    created_by TEXT,
    organization_id TEXT
);

-- Table: signature_audit_trail
CREATE TABLE IF NOT EXISTS public.signature_audit_trail (
    id TEXT NOT NULL,
    signature_document_id TEXT,
    signature_request_id TEXT,
    action_type TEXT NOT NULL,
    action_description TEXT,
    actor_id TEXT,
    actor_email TEXT,
    actor_ip_address TEXT,
    actor_user_agent TEXT,
    previous_status TEXT,
    new_status TEXT,
    additional_data unknown,
    compliance_flags unknown,
    blockchain_hash TEXT,
    performed_at TEXT
);

-- Table: signature_documents
CREATE TABLE IF NOT EXISTS public.signature_documents (
    id TEXT NOT NULL,
    document_id TEXT,
    documenso_document_id TEXT NOT NULL,
    status TEXT,
    workflow_type TEXT,
    document_name TEXT NOT NULL,
    document_url TEXT,
    file_path TEXT,
    created_by TEXT,
    created_at TEXT,
    expires_at TEXT,
    updated_at TEXT,
    organization_id INTEGER,
    contract_id INTEGER,
    procurement_phase TEXT
);

-- Table: signature_requests
CREATE TABLE IF NOT EXISTS public.signature_requests (
    id TEXT NOT NULL,
    signature_document_id TEXT,
    signer_email TEXT NOT NULL,
    signer_name TEXT,
    signer_role TEXT,
    signing_order INTEGER,
    signature_status TEXT,
    signed_at TEXT,
    declined_at TEXT,
    decline_reason TEXT,
    documenso_recipient_id TEXT,
    signature_field_id TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: signature_templates
CREATE TABLE IF NOT EXISTS public.signature_templates (
    id TEXT NOT NULL,
    organization_id INTEGER,
    template_name TEXT NOT NULL,
    template_description TEXT,
    applicable_msic_codes TEXT[],
    applicable_contract_types TEXT[],
    applicable_procurement_phases TEXT[],
    required_signers unknown,
    default_deadline_hours INTEGER,
    is_active BOOLEAN,
    is_default_for_msic TEXT[],
    created_by TEXT,
    version TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: signature_webhooks
CREATE TABLE IF NOT EXISTS public.signature_webhooks (
    id TEXT NOT NULL,
    webhook_provider TEXT,
    webhook_event_type TEXT,
    webhook_id TEXT,
    webhook_data unknown,
    processed BOOLEAN,
    processed_at TEXT,
    processing_errors unknown,
    signature_document_id TEXT,
    contract_id TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: sow_appendices
-- SOW appendices that require contribution and review from different disciplines
CREATE TABLE IF NOT EXISTS public.sow_appendices (
    id TEXT NOT NULL,
    sow_id TEXT,
    appendix_type TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    status TEXT,
    assigned_to TEXT,
    organization_id TEXT,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    updated_by TEXT
);

-- Table: sow_document_transfers
CREATE TABLE IF NOT EXISTS public.sow_document_transfers (
    id TEXT NOT NULL,
    scope_of_work_id TEXT NOT NULL,
    document_type TEXT NOT NULL,
    document_title TEXT NOT NULL,
    document_version TEXT,
    html_content TEXT,
    css_styles TEXT,
    generated_pdf_url TEXT,
    cloud_storage_url TEXT,
    generated_at TEXT,
    last_modified_at TEXT,
    generated_by TEXT,
    approved_by TEXT,
    approval_status TEXT,
    routed_for_signature BOOLEAN,
    signature_status TEXT,
    route_id TEXT,
    transfer_status TEXT,
    processing_errors TEXT,
    file_size_bytes INTEGER,
    content_hash TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: sow_templates
CREATE TABLE IF NOT EXISTS public.sow_templates (
    id TEXT NOT NULL,
    template_name TEXT NOT NULL,
    description TEXT,
    order_type TEXT NOT NULL,
    appendix_definitions unknown NOT NULL,
    discipline_defaults unknown,
    is_active BOOLEAN,
    organization_id TEXT,
    created_by TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: sql_file_tracking
-- Tracks SQL files and their corresponding Supabase table versions
CREATE TABLE IF NOT EXISTS public.sql_file_tracking (
    file_path TEXT NOT NULL,
    supabase_table TEXT NOT NULL,
    last_validated TEXT,
    schema_hash TEXT NOT NULL
);

-- Table: supplier_verifications
CREATE TABLE IF NOT EXISTS public.supplier_verifications (
    id TEXT NOT NULL,
    supplier_id INTEGER,
    source_id TEXT,
    external_supplier_id TEXT NOT NULL,
    source_system TEXT NOT NULL,
    verification_data unknown NOT NULL,
    verification_status TEXT,
    bbbee_level TEXT,
    tax_compliant BOOLEAN,
    bbbee_compliant BOOLEAN,
    cidb_registered BOOLEAN,
    expiry_date TEXT,
    last_verified_at TEXT,
    verification_certificate_url TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: suppliers
-- Table to store supplier information for procurement
CREATE TABLE IF NOT EXISTS public.suppliers (
    id INTEGER NOT NULL,
    name TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT,
    address TEXT,
    email TEXT,
    phone TEXT,
    contact_person TEXT,
    project_id TEXT,
    supplier_type TEXT,
    website TEXT,
    approval_status TEXT,
    goods_services TEXT,
    rating NUMERIC,
    completed_projects INTEGER,
    registration_date TEXT,
    last_activity TEXT,
    tax_number TEXT,
    compliance_status TEXT,
    source_url TEXT,
    scrape_method TEXT,
    scraped_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: sync_history
-- History of synchronization activities with external tender sources
CREATE TABLE IF NOT EXISTS public.sync_history (
    id TEXT NOT NULL,
    source TEXT,
    sync_type TEXT,
    sync_completed_at TEXT,
    tenders_found INTEGER,
    tenders_new INTEGER,
    errors unknown,
    metadata unknown
);

-- Table: task_attachments
-- File attachments associated with tasks
CREATE TABLE IF NOT EXISTS public.task_attachments (
    id TEXT NOT NULL,
    task_id TEXT NOT NULL,
    filename TEXT NOT NULL,
    file_path TEXT NOT NULL,
    file_size INTEGER,
    mime_type TEXT,
    uploaded_by TEXT NOT NULL,
    created_at TEXT
);

-- Table: task_comments
-- Comments and notes added to tasks for collaboration
CREATE TABLE IF NOT EXISTS public.task_comments (
    id TEXT NOT NULL,
    task_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    comment TEXT NOT NULL,
    is_internal BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: task_history
-- Audit trail of all changes made to tasks
CREATE TABLE IF NOT EXISTS public.task_history (
    id TEXT NOT NULL,
    task_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    action TEXT NOT NULL,
    old_value unknown,
    new_value unknown,
    notes TEXT,
    created_at TEXT
);

-- Table: task_sequence_execution
CREATE TABLE IF NOT EXISTS public.task_sequence_execution (
    id TEXT NOT NULL,
    organization_id TEXT,
    procurement_order_id TEXT,
    template_variation TEXT NOT NULL,
    template_variation_id TEXT,
    planned_sequence unknown NOT NULL,
    actual_sequence unknown,
    sequence_adherence NUMERIC,
    total_tasks INTEGER,
    completed_tasks INTEGER,
    current_task_position INTEGER,
    parallel_groups_active INTEGER,
    estimated_completion_time TEXT,
    actual_completion_time TEXT,
    deviations unknown,
    bottlenecks unknown,
    performance_metrics unknown,
    status TEXT,
    started_at TEXT,
    completed_at TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: tasks
-- Central repository for all tasks across the procurement and project management system
CREATE TABLE IF NOT EXISTS public.tasks (
    id TEXT NOT NULL,
    organization_id TEXT NOT NULL,
    task_type TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    business_object_type TEXT,
    business_object_id TEXT,
    assigned_to TEXT,
    assigned_by TEXT,
    discipline TEXT,
    priority TEXT,
    status TEXT,
    due_date TEXT,
    is_hitl BOOLEAN,
    intervention_type TEXT,
    chatbot_session_id TEXT,
    created_at TEXT,
    updated_at TEXT,
    completed_at TEXT,
    escalated_at TEXT,
    metadata unknown,
    sequence_position INTEGER,
    sequence_group TEXT,
    sequence_dependencies unknown,
    sequence_execution_id TEXT,
    estimated_duration_minutes INTEGER,
    actual_duration_minutes INTEGER
);

-- Table: technical_document_categories
CREATE TABLE IF NOT EXISTS public.technical_document_categories (
    id TEXT NOT NULL,
    category_code TEXT NOT NULL,
    category_name TEXT NOT NULL,
    category_description TEXT,
    discipline TEXT NOT NULL,
    document_type TEXT NOT NULL,
    template_count INTEGER,
    is_active BOOLEAN,
    sort_order INTEGER,
    created_at TEXT,
    updated_at TEXT
);

-- Table: template_analytics
CREATE TABLE IF NOT EXISTS public.template_analytics (
    id TEXT NOT NULL,
    template_id TEXT,
    date TEXT NOT NULL,
    total_uses INTEGER,
    successful_uses INTEGER,
    failed_uses INTEGER,
    unique_users INTEGER,
    average_generation_time NUMERIC,
    total_tokens_used INTEGER,
    created_at TEXT,
    updated_at TEXT
);

-- Table: template_approval_rules
-- Workflow rules for template approvals based on type and value
CREATE TABLE IF NOT EXISTS public.template_approval_rules (
    id TEXT NOT NULL,
    template_type TEXT NOT NULL,
    category TEXT,
    value_threshold NUMERIC,
    required_roles TEXT[],
    requires_technical_review BOOLEAN,
    requires_legal_review BOOLEAN,
    approval_order TEXT,
    is_active BOOLEAN,
    created_at TEXT
);

-- Table: template_approval_workflows
-- Approval workflow instances for procurement templates
CREATE TABLE IF NOT EXISTS public.template_approval_workflows (
    id TEXT NOT NULL,
    template_id TEXT,
    workflow_type unknown,
    status TEXT,
    current_step INTEGER,
    created_by TEXT,
    updated_by TEXT,
    approved_at TEXT,
    rejected_at TEXT,
    required_approvals unknown,
    metadata unknown,
    created_at TEXT,
    updated_at TEXT
);

-- Table: template_assignments
CREATE TABLE IF NOT EXISTS public.template_assignments (
    id TEXT NOT NULL,
    template_id TEXT NOT NULL,
    assigned_to_type TEXT NOT NULL,
    assigned_to_id TEXT NOT NULL,
    assigned_by TEXT,
    assigned_at TEXT,
    status TEXT,
    due_date TEXT,
    priority TEXT,
    submitted_data unknown,
    submitted_at TEXT,
    contractor_comments TEXT,
    reviewed_by TEXT,
    reviewed_at TEXT,
    review_status TEXT,
    reviewer_comments TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: template_categories
CREATE TABLE IF NOT EXISTS public.template_categories (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    count INTEGER,
    category_type TEXT,
    parent_category_id TEXT,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: template_customization_rules
CREATE TABLE IF NOT EXISTS public.template_customization_rules (
    id TEXT NOT NULL,
    template_category TEXT NOT NULL,
    customization_type TEXT NOT NULL,
    field_name TEXT NOT NULL,
    field_type TEXT NOT NULL,
    is_required BOOLEAN,
    validation_rules unknown,
    auto_populate_from TEXT,
    created_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: template_dependencies
CREATE TABLE IF NOT EXISTS public.template_dependencies (
    id TEXT NOT NULL,
    template_id TEXT,
    parent_template_id TEXT,
    dependent_template_id TEXT,
    dependency_type TEXT,
    dependency_condition unknown,
    is_required BOOLEAN,
    created_at TEXT
);

-- Table: template_deployments
CREATE TABLE IF NOT EXISTS public.template_deployments (
    id TEXT NOT NULL,
    project_template_id TEXT,
    deployment_type TEXT NOT NULL,
    source_system TEXT NOT NULL,
    target_system TEXT NOT NULL,
    status TEXT,
    error_message TEXT,
    executed_at TEXT
);

-- Table: template_document_structures
-- Links templates to their hierarchical document structures
CREATE TABLE IF NOT EXISTS public.template_document_structures (
    id TEXT NOT NULL,
    template_id TEXT NOT NULL,
    discipline_table TEXT NOT NULL,
    hierarchy_definition_id TEXT,
    structure_data unknown,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    organization_id TEXT
);

-- Table: template_relationships
-- Links templates together for complex document assemblies
CREATE TABLE IF NOT EXISTS public.template_relationships (
    id TEXT NOT NULL,
    parent_template_id TEXT NOT NULL,
    child_template_id TEXT NOT NULL,
    relationship_type TEXT NOT NULL,
    section_path TEXT,
    is_required BOOLEAN,
    sort_order INTEGER,
    created_at TEXT,
    created_by TEXT,
    organization_id TEXT
);

-- Table: template_reviews
CREATE TABLE IF NOT EXISTS public.template_reviews (
    id TEXT NOT NULL,
    template_id TEXT,
    user_id TEXT,
    rating INTEGER,
    review_text TEXT,
    is_helpful BOOLEAN,
    created_at TEXT
);

-- Table: template_usage_logs
CREATE TABLE IF NOT EXISTS public.template_usage_logs (
    id TEXT NOT NULL,
    template_id TEXT,
    template_type TEXT NOT NULL,
    user_id TEXT,
    session_id TEXT,
    generation_time INTEGER,
    success BOOLEAN,
    error_message TEXT,
    metadata unknown,
    created_at TEXT
);

-- Table: template_usage_stats
-- Analytics and usage statistics for templates
CREATE TABLE IF NOT EXISTS public.template_usage_stats (
    id TEXT NOT NULL,
    template_type TEXT NOT NULL,
    category TEXT,
    usage_count INTEGER,
    last_used TEXT,
    average_population_time TEXT,
    success_rate NUMERIC,
    common_populations unknown,
    created_at TEXT,
    updated_at TEXT
);

-- Table: template_usage_tracking
CREATE TABLE IF NOT EXISTS public.template_usage_tracking (
    id TEXT NOT NULL,
    user_id TEXT,
    template_id TEXT,
    action_type TEXT NOT NULL,
    procurement_code TEXT,
    department_code TEXT,
    session_id TEXT,
    user_agent TEXT,
    ip_address TEXT,
    created_at TEXT
);

-- Table: template_variation_sequences
CREATE TABLE IF NOT EXISTS public.template_variation_sequences (
    id TEXT NOT NULL,
    organization_id TEXT,
    discipline_code TEXT NOT NULL,
    template_variation TEXT NOT NULL,
    variation_name TEXT NOT NULL,
    description TEXT,
    complexity_level TEXT NOT NULL,
    sequence_definition unknown NOT NULL,
    parallel_groups unknown,
    dependencies unknown,
    estimated_duration_minutes INTEGER,
    estimated_duration_display TEXT,
    appendices_included unknown,
    skip_tasks unknown,
    business_rules unknown,
    is_default BOOLEAN,
    is_active BOOLEAN,
    created_by TEXT,
    updated_by TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: template_versions
-- Version history for master template changes
CREATE TABLE IF NOT EXISTS public.template_versions (
    id TEXT NOT NULL,
    template_id TEXT,
    version_number INTEGER NOT NULL,
    changes TEXT NOT NULL,
    content unknown,
    created_at TEXT
);

-- Table: templates
CREATE TABLE IF NOT EXISTS public.templates (
    id TEXT NOT NULL,
    type TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    version TEXT,
    prompt_template TEXT NOT NULL,
    validation_config unknown,
    ui_config unknown,
    is_active BOOLEAN,
    is_public BOOLEAN,
    created_by TEXT,
    updated_by TEXT,
    usage_count INTEGER,
    success_rate NUMERIC,
    average_generation_time INTEGER,
    tags TEXT[],
    created_at TEXT,
    updated_at TEXT,
    discipline_code TEXT,
    document_type TEXT,
    discipline TEXT,
    copied_from_template_id TEXT,
    template_scope TEXT,
    target_discipline TEXT,
    copy_metadata unknown,
    processing_status TEXT,
    organization_id TEXT,
    suitable_for_document_types TEXT[],
    category TEXT,
    deleted_at TEXT,
    deleted_by TEXT,
    deletion_reason TEXT
);

-- Table: temporary_uploads
CREATE TABLE IF NOT EXISTS public.temporary_uploads (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    organization_id TEXT,
    company_id TEXT,
    file_name TEXT NOT NULL,
    file_path TEXT NOT NULL,
    file_size INTEGER NOT NULL,
    file_type TEXT NOT NULL,
    document_type TEXT,
    created_at TEXT,
    expires_at TEXT NOT NULL
);

-- Table: tender_approvals
CREATE TABLE IF NOT EXISTS public.tender_approvals (
    id TEXT NOT NULL,
    tender_id TEXT NOT NULL,
    approval_level INTEGER NOT NULL,
    approver_id TEXT,
    approver_name TEXT,
    approver_role TEXT,
    approval_status TEXT,
    approval_date TEXT,
    comments TEXT,
    approval_document_url TEXT,
    delegation_to TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: tender_documents
CREATE TABLE IF NOT EXISTS public.tender_documents (
    id TEXT NOT NULL,
    tender_id TEXT NOT NULL,
    document_type TEXT NOT NULL,
    document_name TEXT NOT NULL,
    document_category TEXT,
    file_path TEXT NOT NULL,
    file_url TEXT,
    file_size INTEGER,
    mime_type TEXT,
    original_url TEXT,
    original_filename TEXT,
    download_status TEXT,
    checksum_hash TEXT,
    processing_status TEXT,
    metadata unknown,
    created_by TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: tender_evaluation
CREATE TABLE IF NOT EXISTS public.tender_evaluation (
    id TEXT NOT NULL,
    tender_id TEXT NOT NULL,
    criterion_name TEXT NOT NULL,
    criterion_description TEXT,
    weightage NUMERIC NOT NULL,
    max_score NUMERIC NOT NULL,
    evaluation_method TEXT,
    is_mandatory BOOLEAN,
    created_at TEXT
);

-- Table: tender_items
CREATE TABLE IF NOT EXISTS public.tender_items (
    id TEXT NOT NULL,
    tender_id TEXT NOT NULL,
    item_number TEXT NOT NULL,
    description TEXT NOT NULL,
    quantity NUMERIC NOT NULL,
    unit TEXT NOT NULL,
    estimated_unit_price NUMERIC,
    estimated_total_price NUMERIC,
    specifications TEXT,
    delivery_timeline TEXT,
    quality_standards TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: tender_monitors
-- Stores automated tender monitoring configurations with filter criteria
CREATE TABLE IF NOT EXISTS public.tender_monitors (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    frequency TEXT,
    filters unknown,
    is_active BOOLEAN,
    created_by_user_id TEXT,
    user_ids unknown,
    created_at TEXT,
    updated_at TEXT
);

-- Table: tender_notification_logs
-- Logs all notifications sent to users about new tenders
CREATE TABLE IF NOT EXISTS public.tender_notification_logs (
    id TEXT NOT NULL,
    monitor_id TEXT,
    tender_id TEXT,
    tender_title TEXT,
    tender_number TEXT,
    issuing_organization TEXT,
    estimated_value NUMERIC,
    currency TEXT,
    location TEXT,
    notification_sent_at TEXT
);

-- Table: tender_suppliers
CREATE TABLE IF NOT EXISTS public.tender_suppliers (
    id TEXT NOT NULL,
    tender_id TEXT NOT NULL,
    supplier_id TEXT,
    supplier_name TEXT NOT NULL,
    contact_person TEXT,
    contact_email TEXT,
    contact_phone TEXT,
    bid_amount NUMERIC,
    bid_currency TEXT,
    bid_validity_period INTEGER,
    technical_score NUMERIC,
    financial_score NUMERIC,
    overall_score NUMERIC,
    bid_status TEXT,
    submission_date TEXT,
    bid_document_url TEXT,
    technical_proposal TEXT,
    financial_proposal TEXT,
    clarifications_requested TEXT[],
    clarifications_provided TEXT[],
    evaluation_notes TEXT,
    ranking INTEGER,
    is_preferred BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: tenders
CREATE TABLE IF NOT EXISTS public.tenders (
    id TEXT NOT NULL,
    tender_number TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    tender_type TEXT NOT NULL,
    procurement_method TEXT NOT NULL,
    status TEXT NOT NULL,
    priority TEXT NOT NULL,
    estimated_value NUMERIC,
    currency TEXT,
    budget_allocated NUMERIC,
    issue_date TEXT NOT NULL,
    pre_bid_meeting_date TEXT,
    bid_submission_deadline TEXT NOT NULL,
    bid_opening_date TEXT,
    evaluation_completion_date TEXT,
    award_date TEXT,
    contract_start_date TEXT,
    contract_end_date TEXT,
    location TEXT,
    scope_of_work TEXT,
    technical_specifications TEXT,
    evaluation_criteria TEXT,
    procurement_officer_id TEXT,
    project_id TEXT,
    department_id TEXT,
    approval_status TEXT,
    approval_workflow_id TEXT,
    current_approval_level INTEGER,
    number_of_bids INTEGER,
    awarded_supplier_id TEXT,
    awarded_supplier_name TEXT,
    contract_value NUMERIC,
    created_by TEXT,
    created_at TEXT,
    updated_by TEXT,
    updated_at TEXT,
    version INTEGER,
    eligibility_requirements TEXT,
    bid_security_amount NUMERIC,
    bid_security_currency TEXT,
    performance_security_percentage NUMERIC,
    payment_terms TEXT,
    delivery_timeline TEXT,
    warranty_requirements TEXT,
    tender_document_url TEXT,
    addendum_urls unknown,
    clarification_responses unknown,
    compliance_requirements TEXT,
    legal_requirements TEXT,
    is_active BOOLEAN,
    tags TEXT[],
    notes TEXT,
    organization_id TEXT
);

-- Table: timesheet_amendments
-- Amendments to timesheet entries
CREATE TABLE IF NOT EXISTS public.timesheet_amendments (
    id TEXT NOT NULL,
    timesheet_id TEXT,
    requested_by TEXT,
    reason TEXT NOT NULL,
    status TEXT,
    approved_by TEXT,
    approved_at TEXT,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: timesheet_audit_logs
-- Audit logs for timesheet changes
CREATE TABLE IF NOT EXISTS public.timesheet_audit_logs (
    id TEXT NOT NULL,
    timesheet_id TEXT,
    user_id TEXT,
    action TEXT NOT NULL,
    old_values unknown,
    new_values unknown,
    ip_address TEXT,
    user_agent TEXT,
    created_at TEXT,
    organization_id TEXT
);

-- Table: timesheet_descriptions
-- Timesheet task descriptions and codes per project
CREATE TABLE IF NOT EXISTS public.timesheet_descriptions (
    id TEXT NOT NULL,
    project_id TEXT,
    code TEXT NOT NULL,
    description TEXT NOT NULL,
    category TEXT,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    updated_by TEXT
);

-- Table: timesheet_entries
-- Timesheet entries for user work hours tracking (new implementation)
CREATE TABLE IF NOT EXISTS public.timesheet_entries (
    id TEXT NOT NULL,
    user_id TEXT,
    week_start_date TEXT NOT NULL,
    description TEXT NOT NULL,
    project TEXT,
    monday_hours NUMERIC,
    tuesday_hours NUMERIC,
    wednesday_hours NUMERIC,
    thursday_hours NUMERIC,
    friday_hours NUMERIC,
    saturday_hours NUMERIC,
    sunday_hours NUMERIC,
    total_hours NUMERIC,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT
);

-- Table: timesheet_submissions
-- Timesheet submissions for approval workflow
CREATE TABLE IF NOT EXISTS public.timesheet_submissions (
    id TEXT NOT NULL,
    user_id TEXT,
    week_key TEXT NOT NULL,
    week_start_date TEXT NOT NULL,
    week_end_date TEXT NOT NULL,
    tasks unknown NOT NULL,
    total_hours NUMERIC,
    status TEXT,
    submitted_at TEXT,
    approved_at TEXT,
    rejected_at TEXT,
    approver_id TEXT,
    rejection_reason TEXT,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT
);

-- Table: timesheet_templates
-- Templates for creating timesheet entries
CREATE TABLE IF NOT EXISTS public.timesheet_templates (
    id TEXT NOT NULL,
    user_id TEXT,
    name TEXT NOT NULL,
    tasks unknown,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT
);

-- Table: timesheets
-- Timesheet entries for employee work hours tracking
CREATE TABLE IF NOT EXISTS public.timesheets (
    id TEXT NOT NULL,
    employee_id TEXT NOT NULL,
    date TEXT NOT NULL,
    hours NUMERIC NOT NULL,
    project TEXT NOT NULL,
    task TEXT,
    client TEXT,
    comments TEXT,
    currency TEXT,
    status TEXT,
    template_id TEXT,
    approved_by TEXT,
    approved_at TEXT,
    created_at TEXT,
    updated_at TEXT,
    locked BOOLEAN,
    locked_at TEXT,
    user_id TEXT,
    organization_id TEXT
);

-- Table: tracking_events
-- Historical tracking events for vessels and containers
CREATE TABLE IF NOT EXISTS public.tracking_events (
    id TEXT NOT NULL,
    event_type TEXT NOT NULL,
    event_category TEXT NOT NULL,
    vessel_id TEXT,
    container_id TEXT,
    event_timestamp TEXT NOT NULL,
    event_description TEXT,
    event_location TEXT,
    latitude NUMERIC,
    longitude NUMERIC,
    status_code TEXT,
    status_description TEXT,
    port_code TEXT,
    port_name TEXT,
    facility_name TEXT,
    event_data unknown,
    data_source TEXT,
    api_reference TEXT,
    created_at TEXT,
    created_by TEXT,
    company_id TEXT,
    organisation_id TEXT,
    project_id TEXT
);

-- Table: travel_airports
-- List of airports for travel routing
CREATE TABLE IF NOT EXISTS public.travel_airports (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    code TEXT NOT NULL,
    hazards TEXT[],
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: travel_equipment_filters
-- Equipment filters for travel routes
CREATE TABLE IF NOT EXISTS public.travel_equipment_filters (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    required_for TEXT[],
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: travel_ground_routes
-- List of ground routes for travel routing
CREATE TABLE IF NOT EXISTS public.travel_ground_routes (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    hazards TEXT[],
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: travel_hazard_alerts
-- Hazard alerts for travel routes
CREATE TABLE IF NOT EXISTS public.travel_hazard_alerts (
    id TEXT NOT NULL,
    type TEXT NOT NULL,
    message TEXT NOT NULL,
    routes TEXT[],
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: travel_helipads
-- List of helipads for travel routing
CREATE TABLE IF NOT EXISTS public.travel_helipads (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    coordinates TEXT,
    equipment TEXT[],
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: travel_requests
-- Travel requests submitted by users
CREATE TABLE IF NOT EXISTS public.travel_requests (
    id TEXT NOT NULL,
    user_id TEXT,
    purpose TEXT NOT NULL,
    destination TEXT NOT NULL,
    start_date TEXT NOT NULL,
    end_date TEXT NOT NULL,
    travelers TEXT[],
    transport_mode TEXT NOT NULL,
    domestic_transport TEXT,
    international_transport TEXT,
    project_transport TEXT,
    accommodation TEXT,
    special_requirements TEXT,
    citizenship TEXT,
    security_clearance TEXT,
    frequent_traveler BOOLEAN,
    frequent_flyer_numbers TEXT[],
    project_site TEXT,
    visa_required BOOLEAN,
    visa_check_completed BOOLEAN,
    departure_location TEXT,
    arrival_location TEXT,
    route_preferences TEXT[],
    status TEXT,
    submitted_at TEXT,
    approved_at TEXT,
    created_at TEXT,
    updated_at TEXT,
    flight_segments unknown,
    has_return_leg BOOLEAN,
    return_segments unknown,
    health_check_required BOOLEAN,
    health_check_passed BOOLEAN,
    organization_id TEXT
);

-- Table: travel_templates
CREATE TABLE IF NOT EXISTS public.travel_templates (
    id TEXT NOT NULL,
    user_id TEXT,
    name TEXT NOT NULL,
    purpose TEXT,
    destination TEXT,
    travelers TEXT[],
    transport_mode TEXT,
    domestic_transport TEXT,
    international_transport TEXT,
    project_transport TEXT,
    accommodation TEXT,
    special_requirements TEXT,
    citizenship TEXT,
    security_clearance TEXT,
    frequent_traveler BOOLEAN,
    frequent_flyer_numbers TEXT[],
    project_site TEXT,
    visa_required BOOLEAN,
    visa_check_completed BOOLEAN,
    departure_location TEXT,
    arrival_location TEXT,
    route_preferences TEXT[],
    flight_segments unknown,
    has_return_leg BOOLEAN,
    return_segments unknown,
    created_at TEXT,
    updated_at TEXT,
    health_check_required BOOLEAN,
    health_check_passed BOOLEAN,
    organization_id TEXT
);

-- Table: ui_button_settings
CREATE TABLE IF NOT EXISTS public.ui_button_settings (
    id INTEGER NOT NULL,
    company_id INTEGER NOT NULL,
    button_option_id INTEGER,
    is_visible BOOLEAN,
    user_type TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    user_id TEXT
);

-- Table: ui_display_settings
CREATE TABLE IF NOT EXISTS public.ui_display_settings (
    id INTEGER NOT NULL,
    company_id INTEGER NOT NULL,
    accordion_option_id INTEGER,
    is_visible BOOLEAN,
    user_type TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT
);

-- Table: user_accordion_settings
CREATE TABLE IF NOT EXISTS public.user_accordion_settings (
    id INTEGER NOT NULL,
    user_id TEXT NOT NULL,
    user_type TEXT NOT NULL,
    accordion_id INTEGER,
    is_visible BOOLEAN,
    contractor_name TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: user_companies
-- Maps users to their assigned companies
CREATE TABLE IF NOT EXISTS public.user_companies (
    user_id TEXT NOT NULL,
    company_id INTEGER NOT NULL,
    created_at TEXT,
    organization_id TEXT
);

-- Table: user_company_access
CREATE TABLE IF NOT EXISTS public.user_company_access (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    company_id TEXT NOT NULL,
    role TEXT NOT NULL,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: user_department_access
CREATE TABLE IF NOT EXISTS public.user_department_access (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    department_code TEXT NOT NULL,
    role_level TEXT,
    created_at TEXT,
    organization_id TEXT
);

-- Table: user_discipline_access
CREATE TABLE IF NOT EXISTS public.user_discipline_access (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    organization_id TEXT,
    discipline_code TEXT NOT NULL,
    access_level TEXT,
    is_active BOOLEAN,
    created_at TEXT,
    created_by TEXT,
    updated_at TEXT,
    updated_by TEXT
);

-- Table: user_email_accounts
-- User email account configurations and credentials
CREATE TABLE IF NOT EXISTS public.user_email_accounts (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    provider_id TEXT NOT NULL,
    email_address TEXT NOT NULL,
    display_name TEXT,
    is_primary BOOLEAN,
    is_active BOOLEAN,
    access_token TEXT,
    refresh_token TEXT,
    token_expires_at TEXT,
    imap_host TEXT,
    imap_port INTEGER,
    imap_username TEXT,
    imap_password_encrypted TEXT,
    smtp_host TEXT,
    smtp_port INTEGER,
    smtp_username TEXT,
    smtp_password_encrypted TEXT,
    last_sync_at TEXT,
    sync_enabled BOOLEAN,
    sync_frequency_minutes INTEGER,
    settings unknown,
    created_at TEXT,
    updated_at TEXT
);

-- Table: user_email_aliases
CREATE TABLE IF NOT EXISTS public.user_email_aliases (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    email TEXT NOT NULL,
    normalized_email TEXT NOT NULL,
    created_at TEXT NOT NULL,
    organization_id TEXT
);

-- Table: user_emails
CREATE TABLE IF NOT EXISTS public.user_emails (
    id INTEGER NOT NULL,
    created_at TEXT NOT NULL,
    thread_id TEXT,
    cc_recipients TEXT[],
    bcc_recipients TEXT[],
    body_html TEXT,
    status TEXT,
    is_starred BOOLEAN,
    is_important BOOLEAN,
    folder TEXT,
    attachments unknown,
    raw_headers TEXT,
    in_reply_to TEXT,
    message_references TEXT[],
    user_id TEXT,
    organization_id TEXT
);

-- Table: user_langchain_settings
-- Secure storage for user-specific LangChain AI configurations with encrypted API keys
CREATE TABLE IF NOT EXISTS public.user_langchain_settings (
    id TEXT NOT NULL,
    user_id TEXT,
    organization_id TEXT,
    openai_api_key TEXT,
    anthropic_api_key TEXT,
    cohere_api_key TEXT,
    llm_provider TEXT,
    llm_model TEXT,
    embeddings_provider TEXT,
    embeddings_model TEXT,
    temperature NUMERIC,
    max_tokens INTEGER,
    dimensions INTEGER,
    chunk_size INTEGER,
    chunk_overlap INTEGER,
    langsmith_enabled BOOLEAN,
    langsmith_project TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: user_management
-- Comprehensive user management table with profile, contact, auth, and business fields
CREATE TABLE IF NOT EXISTS public.user_management (
    user_id TEXT NOT NULL,
    email TEXT NOT NULL,
    role TEXT,
    active BOOLEAN,
    status TEXT,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    updated_by TEXT,
    employer TEXT,
    first_name TEXT,
    last_name TEXT,
    display_name TEXT,
    full_name TEXT,
    preferred_name TEXT,
    phone TEXT,
    mobile TEXT,
    address TEXT,
    city TEXT,
    state_province TEXT,
    postal_code TEXT,
    country TEXT,
    job_title TEXT,
    department TEXT,
    division TEXT,
    cost_center TEXT,
    manager_id TEXT,
    employee_id TEXT,
    hire_date TEXT,
    employment_type TEXT,
    security_clearance TEXT,
    password_hash TEXT,
    password_salt TEXT,
    last_login TEXT,
    login_count INTEGER,
    failed_login_attempts INTEGER,
    account_locked_until TEXT,
    password_reset_token TEXT,
    password_reset_expires TEXT,
    email_verified BOOLEAN,
    email_verification_token TEXT,
    two_factor_enabled BOOLEAN,
    two_factor_secret TEXT,
    avatar_url TEXT,
    bio TEXT,
    timezone TEXT,
    locale TEXT,
    theme_preference TEXT,
    notification_preferences unknown,
    user_preferences unknown,
    last_activity TEXT,
    session_token TEXT,
    session_expires TEXT,
    terms_accepted_at TEXT,
    privacy_policy_accepted_at TEXT,
    data_retention_policy TEXT,
    account_deletion_requested_at TEXT,
    contractor_company TEXT,
    consultant_rate NUMERIC,
    billing_currency TEXT,
    project_access_level TEXT,
    disciplines unknown,
    certifications unknown,
    emergency_contact unknown,
    passport_number TEXT,
    passport_expiry_date TEXT,
    passport_issue_date TEXT,
    passport_issuing_country TEXT,
    alternative_travel_docs unknown,
    date_of_birth TEXT,
    gender TEXT,
    nationality TEXT,
    residence_country TEXT,
    title TEXT,
    visa_requirements unknown,
    frequent_flyer_programs unknown,
    medical_info unknown,
    dietary_restrictions TEXT[],
    special_assistance TEXT,
    organization_id TEXT
);

-- Table: user_organization_access
CREATE TABLE IF NOT EXISTS public.user_organization_access (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    organization_id TEXT NOT NULL,
    is_primary BOOLEAN,
    created_at TEXT
);

-- Table: user_organizations
CREATE TABLE IF NOT EXISTS public.user_organizations (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    organization_id TEXT NOT NULL,
    role TEXT,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: user_profiles
-- User profile data for SOW Association Modal and user management
CREATE TABLE IF NOT EXISTS public.user_profiles (
    user_id TEXT NOT NULL,
    name TEXT,
    role TEXT,
    project_site TEXT,
    citizenship TEXT,
    security_clearance TEXT,
    frequent_traveler BOOLEAN,
    frequent_flyer_numbers TEXT[],
    created_at TEXT,
    updated_at TEXT,
    organization_id TEXT,
    email TEXT,
    first_name TEXT,
    last_name TEXT,
    avatar_url TEXT,
    id TEXT,
    company_id TEXT,
    settings unknown,
    last_login TEXT
);

-- Table: user_project_access
CREATE TABLE IF NOT EXISTS public.user_project_access (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    project_id TEXT NOT NULL,
    role TEXT NOT NULL,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: user_project_assignments
CREATE TABLE IF NOT EXISTS public.user_project_assignments (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    project_id TEXT NOT NULL,
    assigned_role TEXT NOT NULL,
    phases_access unknown,
    assigned_by TEXT,
    assigned_at TEXT,
    expires_at TEXT,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: user_role_assignments
CREATE TABLE IF NOT EXISTS public.user_role_assignments (
    id INTEGER NOT NULL,
    user_id TEXT NOT NULL,
    role_name TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT,
    company_id TEXT,
    assigned_at TEXT,
    assigned_by TEXT,
    is_active BOOLEAN,
    organization_id TEXT
);

-- Table: user_roles
CREATE TABLE IF NOT EXISTS public.user_roles (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    role TEXT NOT NULL,
    department_code TEXT,
    level INTEGER,
    created_at TEXT,
    organization_id TEXT
);

-- Table: user_vetting_permissions
-- Cached user permissions to improve performance and reduce database load. Auto-expires after 1 hour.
CREATE TABLE IF NOT EXISTS public.user_vetting_permissions (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    permissions unknown NOT NULL,
    last_updated TEXT,
    expires_at TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: v_chat_issues
-- Identifies chat sessions with performance or satisfaction issues
CREATE TABLE IF NOT EXISTS public.v_chat_issues (
    session_id TEXT,
    discipline_code TEXT,
    chatbot_type TEXT,
    company_name TEXT,
    project_name TEXT,
    created_at TEXT,
    performance_issue TEXT,
    avg_response_time_ms INTEGER,
    total_messages INTEGER,
    avg_rating NUMERIC,
    error_message_count INTEGER
);

-- Table: v_chat_session_summary
-- Summary of chat sessions with project context for IT dashboard
CREATE TABLE IF NOT EXISTS public.v_chat_session_summary (
    id TEXT,
    user_id TEXT,
    discipline_code TEXT,
    chatbot_type TEXT,
    company_name TEXT,
    organisation_name TEXT,
    project_name TEXT,
    project_phase_name TEXT,
    session_title TEXT,
    total_messages INTEGER,
    total_documents_referenced INTEGER,
    avg_response_time_ms INTEGER,
    created_at TEXT,
    last_activity_at TEXT,
    is_active BOOLEAN,
    session_duration_minutes NUMERIC,
    latest_message TEXT,
    avg_user_rating NUMERIC
);

-- Table: v_company_project_chat_usage
-- Chat usage analytics grouped by company and project
CREATE TABLE IF NOT EXISTS public.v_company_project_chat_usage (
    company_name TEXT,
    organisation_name TEXT,
    project_name TEXT,
    project_phase_name TEXT,
    discipline_code TEXT,
    chatbot_type TEXT,
    total_sessions INTEGER,
    total_messages INTEGER,
    total_documents_referenced INTEGER,
    avg_response_time_ms NUMERIC,
    unique_users INTEGER,
    last_activity TEXT,
    sessions_last_7_days INTEGER,
    sessions_previous_7_days INTEGER
);

-- Table: v_daily_chat_stats
-- Daily aggregated chat statistics by discipline and project
CREATE TABLE IF NOT EXISTS public.v_daily_chat_stats (
    date TEXT,
    discipline_code TEXT,
    chatbot_type TEXT,
    company_name TEXT,
    organisation_name TEXT,
    project_name TEXT,
    sessions_count INTEGER,
    total_messages INTEGER,
    total_documents_referenced INTEGER,
    avg_response_time_ms NUMERIC,
    unique_users INTEGER
);

-- Table: v_discipline_performance
-- Performance metrics for each discipline chatbot type
CREATE TABLE IF NOT EXISTS public.v_discipline_performance (
    discipline_code TEXT,
    chatbot_type TEXT,
    total_sessions INTEGER,
    total_messages INTEGER,
    avg_messages_per_session NUMERIC,
    total_documents_referenced INTEGER,
    avg_documents_per_session NUMERIC,
    avg_response_time_ms NUMERIC,
    unique_users INTEGER,
    unique_companies INTEGER,
    unique_projects INTEGER,
    avg_user_satisfaction NUMERIC,
    last_activity TEXT,
    active_today INTEGER,
    active_this_week INTEGER
);

-- Table: v_document_types_lookup
CREATE TABLE IF NOT EXISTS public.v_document_types_lookup (
    id TEXT,
    document_type_code TEXT,
    document_type TEXT,
    numbering_pattern TEXT,
    description TEXT,
    discipline_code TEXT,
    discipline_name TEXT,
    company_id TEXT
);

-- Table: v_document_usage_analytics
-- Analytics on which documents are most referenced in chats
CREATE TABLE IF NOT EXISTS public.v_document_usage_analytics (
    discipline_code TEXT,
    company_name TEXT,
    project_name TEXT,
    document_reference TEXT,
    reference_count INTEGER,
    sessions_referencing INTEGER,
    users_referencing INTEGER,
    avg_rating_when_referenced NUMERIC,
    last_referenced TEXT
);

-- Table: v_financial_overdue
CREATE TABLE IF NOT EXISTS public.v_financial_overdue (
    id TEXT,
    reference TEXT,
    description TEXT,
    amount NUMERIC,
    due_date TEXT,
    vendor TEXT,
    project TEXT,
    category TEXT,
    days_overdue INTEGER
);

-- Table: v_financial_summary
CREATE TABLE IF NOT EXISTS public.v_financial_summary (
    type TEXT,
    status TEXT,
    record_count INTEGER,
    total_amount NUMERIC,
    avg_amount NUMERIC,
    min_amount NUMERIC,
    max_amount NUMERIC,
    categories TEXT,
    earliest_date TEXT,
    latest_date TEXT
);

-- Table: v_realtime_chat_activity
-- Real-time view of active chat sessions
CREATE TABLE IF NOT EXISTS public.v_realtime_chat_activity (
    session_id TEXT,
    user_id TEXT,
    discipline_code TEXT,
    chatbot_type TEXT,
    company_name TEXT,
    project_name TEXT,
    session_title TEXT,
    last_activity_at TEXT,
    minutes_since_last_activity NUMERIC,
    activity_status TEXT,
    latest_message_role TEXT,
    latest_message_preview TEXT,
    total_messages INTEGER,
    avg_response_time_ms INTEGER
);

-- Table: vector_deletion_audit
CREATE TABLE IF NOT EXISTS public.vector_deletion_audit (
    id TEXT NOT NULL,
    vector_id TEXT NOT NULL,
    table_name TEXT NOT NULL,
    deleted_by TEXT,
    deletion_reason TEXT,
    deletion_type TEXT,
    restored_at TEXT,
    restored_by TEXT,
    created_at TEXT
);

-- Table: vector_deletion_policies
CREATE TABLE IF NOT EXISTS public.vector_deletion_policies (
    id TEXT NOT NULL,
    policy_name TEXT NOT NULL,
    applies_to_scope TEXT,
    retention_period TEXT,
    auto_delete BOOLEAN,
    requires_approval BOOLEAN,
    created_by TEXT,
    created_at TEXT
);

-- Table: vector_search_criteria
-- Stores dynamic search criteria for vector similarity searches across all disciplines
CREATE TABLE IF NOT EXISTS public.vector_search_criteria (
    id TEXT NOT NULL,
    discipline TEXT NOT NULL,
    table_name TEXT NOT NULL,
    search_name TEXT NOT NULL,
    description TEXT,
    filter_criteria unknown NOT NULL,
    is_active BOOLEAN,
    created_at TEXT,
    updated_at TEXT
);

-- Table: vector_workspaces
CREATE TABLE IF NOT EXISTS public.vector_workspaces (
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    workspace_type TEXT,
    created_by TEXT,
    organisation_id TEXT,
    project_id TEXT,
    discipline_restrictions TEXT[],
    auto_cleanup_after TEXT,
    created_at TEXT,
    expires_at TEXT,
    is_active BOOLEAN
);

-- Table: vessels
-- Stores vessel/ship information from VesselFinder API
CREATE TABLE IF NOT EXISTS public.vessels (
    id TEXT NOT NULL,
    imo TEXT,
    mmsi TEXT,
    vessel_name TEXT NOT NULL,
    call_sign TEXT,
    vessel_type TEXT,
    vessel_class TEXT,
    flag_country TEXT,
    gross_tonnage INTEGER,
    deadweight_tonnage INTEGER,
    length_overall NUMERIC,
    beam NUMERIC,
    draught NUMERIC,
    built_year INTEGER,
    latitude NUMERIC,
    longitude NUMERIC,
    speed_knots NUMERIC,
    course NUMERIC,
    heading NUMERIC,
    status TEXT,
    destination TEXT,
    eta TEXT,
    vesselfinder_id TEXT,
    last_position_update TEXT,
    api_data unknown,
    created_at TEXT,
    updated_at TEXT,
    created_by TEXT,
    is_active BOOLEAN,
    company_id TEXT,
    organisation_id TEXT,
    project_id TEXT,
    organization_id TEXT
);

-- Table: vetting_access_log
-- Audit log for all user access attempts to contractor vetting functionality. Used for security compliance and monitoring.
CREATE TABLE IF NOT EXISTS public.vetting_access_log (
    id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    contractor_id TEXT,
    action TEXT NOT NULL,
    resource TEXT NOT NULL,
    access_granted BOOLEAN,
    reason_denied TEXT,
    discipline TEXT,
    company_count INTEGER,
    project_count INTEGER,
    ip_address TEXT,
    user_agent TEXT,
    session_id TEXT,
    created_at TEXT,
    expires_at TEXT
);

-- Table: vetting_access_summary
CREATE TABLE IF NOT EXISTS public.vetting_access_summary (
    access_date TEXT,
    discipline TEXT,
    action TEXT,
    access_granted BOOLEAN,
    access_count INTEGER,
    unique_users INTEGER
);

-- Table: vetting_evaluation_audit
-- Detailed audit trail for vetting evaluation actions, linking evaluations with user permissions at time of action.
CREATE TABLE IF NOT EXISTS public.vetting_evaluation_audit (
    id TEXT NOT NULL,
    evaluation_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    action TEXT NOT NULL,
    section TEXT,
    changes unknown,
    user_discipline TEXT,
    user_company_affiliations INTEGER,
    created_at TEXT,
    ip_address TEXT,
    session_id TEXT
);

-- Table: workflow_routing_steps
CREATE TABLE IF NOT EXISTS public.workflow_routing_steps (
    id INTEGER NOT NULL,
    workflow_id INTEGER,
    step_id INTEGER,
    step_order INTEGER NOT NULL,
    step_name TEXT NOT NULL,
    step_status TEXT,
    routing_mode TEXT,
    required_actions INTEGER,
    completed_actions INTEGER,
    deadline TEXT,
    started_at TEXT,
    completed_at TEXT,
    esculated_at TEXT,
    escalated_to TEXT,
    created_at TEXT,
    updated_at TEXT
);

-- Table: workspace_members
CREATE TABLE IF NOT EXISTS public.workspace_members (
    workspace_id TEXT NOT NULL,
    user_id TEXT NOT NULL,
    access_level TEXT,
    added_by TEXT,
    added_at TEXT,
    expires_at TEXT
);

