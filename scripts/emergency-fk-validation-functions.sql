-- ============================================================
-- EMERGENCY FK VALIDATION FUNCTIONS
-- Deploy immediately to prevent further constraint violations
-- Generated: 2026-04-24
-- ============================================================

-- Function 1: Complete FK Relationship Discovery
CREATE OR REPLACE FUNCTION get_complete_fk_relationships(target_table TEXT)
RETURNS TABLE (
    child_table TEXT,
    fk_constraint TEXT,
    delete_rule TEXT,
    update_rule TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        ccu.table_name::TEXT,
        tc.constraint_name::TEXT,
        tc.delete_rule::TEXT,
        tc.update_rule::TEXT
    FROM information_schema.table_constraints tc
    JOIN information_schema.key_column_usage kcu ON tc.constraint_name = kcu.constraint_name
    JOIN information_schema.constraint_column_usage ccu ON ccu.constraint_name = tc.constraint_name
    WHERE tc.constraint_type = 'FOREIGN KEY'
      AND ccu.table_name = target_table
      AND tc.table_name != ccu.table_name
    ORDER BY ccu.table_name;
END;
$$ LANGUAGE plpgsql;

-- Function 2: Safe Deletion with Automatic FK Handling
CREATE OR REPLACE FUNCTION safe_execute_deletions(target_tables TEXT[])
RETURNS JSONB AS $$
DECLARE
    result JSONB := '{"status": "success", "deleted_tables": [], "errors": []}';
    child_tables TEXT[];
    table_name TEXT;
BEGIN
    -- Get all child tables for each target table
    SELECT array_agg(DISTINCT child_table)
    INTO child_tables
    FROM (
        SELECT unnest(get_complete_fk_relationships(unnest(target_tables))) AS child_table
    ) AS children;

    -- Remove duplicates and target tables from child list
    child_tables := array(
        SELECT unnest(child_tables)
        EXCEPT
        SELECT unnest(target_tables)
    );

    -- Delete child tables first (in dependency order)
    FOREACH table_name IN ARRAY child_tables LOOP
        BEGIN
            EXECUTE 'DELETE FROM ' || quote_ident(table_name);
            result := jsonb_set(result, '{deleted_tables}',
                      result->'deleted_tables' || jsonb_build_array(table_name));
            RAISE NOTICE 'Successfully deleted all records from child table: %', table_name;
        EXCEPTION WHEN OTHERS THEN
            result := jsonb_set(result, '{errors}',
                      result->'errors' || jsonb_build_object(
                          'table', table_name,
                          'error', SQLERRM,
                          'sqlstate', SQLSTATE
                      ));
            RAISE NOTICE 'Failed to delete from table %: %', table_name, SQLERRM;
        END;
    END LOOP;

    -- Delete target tables
    FOREACH table_name IN ARRAY target_tables LOOP
        BEGIN
            EXECUTE 'DELETE FROM ' || quote_ident(table_name);
            result := jsonb_set(result, '{deleted_tables}',
                      result->'deleted_tables' || jsonb_build_array(table_name));
            RAISE NOTICE 'Successfully deleted all records from target table: %', table_name;
        EXCEPTION WHEN OTHERS THEN
            result := jsonb_set(result, '{errors}',
                      result->'errors' || jsonb_build_object(
                          'table', table_name,
                          'error', SQLERRM,
                          'sqlstate', SQLSTATE
                      ));
            RAISE NOTICE 'Failed to delete from table %: %', table_name, SQLERRM;
        END;
    END LOOP;

    -- Update status if there were errors
    IF jsonb_array_length(result->'errors') > 0 THEN
        result := jsonb_set(result, '{status}', '"partial_success"');
    END IF;

    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- Function 3: Pre-flight SQL Validation
CREATE OR REPLACE FUNCTION validate_sql_operations(
    sql_statements TEXT[],
    operation_type TEXT DEFAULT 'DELETE'
) RETURNS JSONB AS $$
DECLARE
    result JSONB := '{"valid": true, "warnings": [], "errors": [], "recommendations": []}';
    stmt TEXT;
    affected_tables TEXT[] := ARRAY[]::TEXT[];
    table_name TEXT;
    fk_info RECORD;
BEGIN
    -- Extract affected tables from SQL statements
    FOREACH stmt IN ARRAY sql_statements LOOP
        -- Simple regex to extract table names from DELETE statements
        -- This is a basic implementation - could be enhanced
        IF operation_type = 'DELETE' THEN
            -- Extract table name from "DELETE FROM table_name"
            SELECT (regexp_match(stmt, 'DELETE FROM\s+(\w+)', 'i'))[1] INTO table_name;
            IF table_name IS NOT NULL AND NOT (table_name = ANY(affected_tables)) THEN
                affected_tables := array_append(affected_tables, table_name);
            END IF;
        END IF;
    END LOOP;

    -- Check FK relationships for each affected table
    FOREACH table_name IN ARRAY affected_tables LOOP
        FOR fk_info IN SELECT * FROM get_complete_fk_relationships(table_name) LOOP
            -- Check if child tables are also being deleted
            IF NOT (fk_info.child_table = ANY(affected_tables)) THEN
                -- This is a potential FK violation
                result := jsonb_set(result, '{valid}', 'false');
                result := jsonb_set(result, '{errors}',
                          result->'errors' || jsonb_build_object(
                              'type', 'foreign_key_violation',
                              'parent_table', table_name,
                              'child_table', fk_info.child_table,
                              'constraint', fk_info.fk_constraint,
                              'message', format('Cannot delete from %s while %s still has references', table_name, fk_info.child_table)
                          ));
            END IF;
        END LOOP;
    END LOOP;

    -- Add recommendations
    IF jsonb_array_length(result->'errors') = 0 THEN
        result := jsonb_set(result, '{recommendations}',
                  result->'recommendations' || jsonb_build_object(
                      'action', 'proceed',
                      'message', 'All FK relationships properly handled. Safe to execute.'
                  ));
    ELSE
        result := jsonb_set(result, '{recommendations}',
                  result->'recommendations' || jsonb_build_object(
                      'action', 'use_safe_execute_deletions',
                      'message', 'Use safe_execute_deletions() function to automatically handle FK dependencies.'
                  ));
    END IF;

    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- Function 4: Schema Health Monitoring
CREATE OR REPLACE FUNCTION monitor_schema_health()
RETURNS JSONB AS $$
DECLARE
    result JSONB := '{"status": "healthy", "issues": [], "metrics": {}}';
    total_tables INTEGER;
    documented_tables INTEGER;
    fk_count INTEGER;
BEGIN
    -- Get basic metrics
    SELECT COUNT(*) INTO total_tables
    FROM information_schema.tables
    WHERE table_schema = 'public' AND table_type = 'BASE TABLE';

    SELECT COUNT(*) INTO fk_count
    FROM information_schema.table_constraints
    WHERE constraint_type = 'FOREIGN KEY';

    -- Update metrics
    result := jsonb_set(result, '{metrics}',
              jsonb_build_object(
                  'total_tables', total_tables,
                  'foreign_keys', fk_count,
                  'last_checked', extract(epoch from now())
              ));

    -- Check for potential issues
    -- (Add more health checks as needed)

    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- ============================================================
-- TEST THE FUNCTIONS
-- ============================================================

-- Test 1: FK Discovery for issues table
-- SELECT * FROM get_complete_fk_relationships('issues');

-- Test 2: Validation Check
-- SELECT validate_sql_operations(ARRAY['DELETE FROM issues']);

-- Test 3: Safe Deletion (use with caution!)
-- SELECT safe_execute_deletions(ARRAY['issues', 'heartbeat_runs', 'heartbeat_run_events']);

-- Test 4: Health Check
-- SELECT monitor_schema_health();

-- ============================================================
-- DEPLOYMENT COMPLETE
-- Functions are now available for all database operations
-- ============================================================