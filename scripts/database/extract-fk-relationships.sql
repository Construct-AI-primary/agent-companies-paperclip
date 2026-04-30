-- Extract Foreign Key Relationships Script
-- Generates comprehensive FK relationship information from PostgreSQL system catalogs
-- Useful for understanding database dependencies and creating safe deletion procedures

-- 1. Basic FK Relationships (from information_schema)
SELECT
    tc.table_schema,
    tc.table_name,
    kcu.column_name,
    ccu.table_schema AS foreign_table_schema,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name,
    tc.constraint_name,
    tc.constraint_type,
    rc.update_rule,
    rc.delete_rule
FROM
    information_schema.table_constraints AS tc
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
      AND tc.table_schema = kcu.table_schema
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
      AND ccu.table_schema = tc.table_schema
    LEFT JOIN information_schema.referential_constraints AS rc
      ON tc.constraint_name = rc.constraint_name
      AND tc.table_schema = rc.constraint_schema
WHERE
    tc.constraint_type = 'FOREIGN KEY'
    AND tc.table_schema NOT IN ('information_schema', 'pg_catalog')
ORDER BY
    tc.table_schema,
    tc.table_name,
    tc.constraint_name,
    kcu.ordinal_position;

-- 2. FK Relationships with NULL handling info
SELECT
    'FK Relationship' as relationship_type,
    CONCAT(tc.table_schema, '.', tc.table_name, '.', kcu.column_name) as from_column,
    '→' as arrow,
    CONCAT(ccu.table_schema, '.', ccu.table_name, '.', ccu.column_name) as to_column,
    CASE
        WHEN rc.delete_rule = 'CASCADE' THEN 'CASCADE'
        WHEN rc.delete_rule = 'SET NULL' THEN 'SET NULL'
        WHEN rc.delete_rule = 'RESTRICT' THEN 'RESTRICT'
        WHEN rc.delete_rule = 'NO ACTION' THEN 'NO ACTION'
        ELSE 'UNKNOWN'
    END as delete_rule,
    CASE
        WHEN EXISTS (
            SELECT 1 FROM information_schema.columns c
            WHERE c.table_schema = tc.table_schema
              AND c.table_name = tc.table_name
              AND c.column_name = kcu.column_name
              AND c.is_nullable = 'YES'
        ) THEN 'NULLABLE'
        ELSE 'NOT NULL'
    END as nullable
FROM
    information_schema.table_constraints AS tc
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
      AND tc.table_schema = kcu.table_schema
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
      AND ccu.table_schema = tc.table_schema
    LEFT JOIN information_schema.referential_constraints AS rc
      ON tc.constraint_name = rc.constraint_name
      AND tc.table_schema = rc.constraint_schema
WHERE
    tc.constraint_type = 'FOREIGN KEY'
    AND tc.table_schema NOT IN ('information_schema', 'pg_catalog')
ORDER BY
    tc.table_schema,
    tc.table_name,
    kcu.ordinal_position;

-- 3. Tables with FKs pointing TO each table (reverse lookup)
SELECT
    ccu.table_schema AS referenced_schema,
    ccu.table_name AS referenced_table,
    ccu.column_name AS referenced_column,
    COUNT(*) as incoming_fk_count,
    STRING_AGG(
        DISTINCT CONCAT(tc.table_schema, '.', tc.table_name, '.', kcu.column_name),
        '; '
    ) as referencing_columns
FROM
    information_schema.table_constraints AS tc
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
      AND tc.table_schema = kcu.table_schema
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
      AND ccu.table_schema = tc.table_schema
WHERE
    tc.constraint_type = 'FOREIGN KEY'
    AND tc.table_schema NOT IN ('information_schema', 'pg_catalog')
GROUP BY
    ccu.table_schema,
    ccu.table_name,
    ccu.column_name
ORDER BY
    ccu.table_schema,
    ccu.table_name,
    incoming_fk_count DESC;

-- 4. Tables with FKs pointing FROM each table (forward lookup)
SELECT
    tc.table_schema AS referencing_schema,
    tc.table_name AS referencing_table,
    COUNT(*) as outgoing_fk_count,
    STRING_AGG(
        DISTINCT CONCAT(ccu.table_schema, '.', ccu.table_name, '.', ccu.column_name),
        '; '
    ) as referenced_columns
FROM
    information_schema.table_constraints AS tc
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
      AND tc.table_schema = kcu.table_schema
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
      AND ccu.table_schema = tc.table_schema
WHERE
    tc.constraint_type = 'FOREIGN KEY'
    AND tc.table_schema NOT IN ('information_schema', 'pg_catalog')
GROUP BY
    tc.table_schema,
    tc.table_name
ORDER BY
    tc.table_schema,
    tc.table_name;

-- 5. FK Dependency Chain Analysis (potential circular references)
WITH fk_relationships AS (
    SELECT
        CONCAT(tc.table_schema, '.', tc.table_name) as from_table,
        CONCAT(ccu.table_schema, '.', ccu.table_name) as to_table,
        CONCAT(tc.table_schema, '.', tc.table_name, '.', kcu.column_name) as from_column,
        CONCAT(ccu.table_schema, '.', ccu.table_name, '.', ccu.column_name) as to_column
    FROM
        information_schema.table_constraints AS tc
        JOIN information_schema.key_column_usage AS kcu
          ON tc.constraint_name = kcu.constraint_name
          AND tc.table_schema = kcu.table_schema
        JOIN information_schema.constraint_column_usage AS ccu
          ON ccu.constraint_name = tc.constraint_name
          AND ccu.table_schema = tc.table_schema
    WHERE
        tc.constraint_type = 'FOREIGN KEY'
        AND tc.table_schema NOT IN ('information_schema', 'pg_catalog')
)
SELECT
    'Dependency Chain' as analysis_type,
    fr.from_table,
    '→' as arrow1,
    fr.to_table,
    CASE
        WHEN fr.from_table = fr.to_table THEN 'SELF-REFERENCE'
        WHEN EXISTS (
            SELECT 1 FROM fk_relationships fr2
            WHERE fr2.from_table = fr.to_table
              AND fr2.to_table = fr.from_table
        ) THEN 'BIDIRECTIONAL'
        ELSE 'ONE-WAY'
    END as relationship_type,
    fr.from_column,
    fr.to_column
FROM fk_relationships fr
ORDER BY
    CASE
        WHEN fr.from_table = fr.to_table THEN 1 -- self-references first
        WHEN EXISTS (
            SELECT 1 FROM fk_relationships fr2
            WHERE fr2.from_table = fr.to_table
              AND fr2.to_table = fr.from_table
        ) THEN 2 -- bidirectional second
        ELSE 3 -- one-way last
    END,
    fr.from_table,
    fr.to_table;

-- 6. Tables with no FK relationships
SELECT
    t.table_schema,
    t.table_name,
    'No FK relationships' as relationship_status
FROM
    information_schema.tables t
WHERE
    t.table_schema NOT IN ('information_schema', 'pg_catalog')
    AND t.table_type = 'BASE TABLE'
    AND NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints tc
        WHERE tc.table_schema = t.table_schema
          AND tc.table_name = t.table_name
          AND tc.constraint_type = 'FOREIGN KEY'
    )
    AND NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints tc
        JOIN information_schema.constraint_column_usage ccu
          ON tc.constraint_name = ccu.constraint_name
          AND tc.table_schema = ccu.table_schema
        WHERE ccu.table_schema = t.table_schema
          AND ccu.table_name = t.table_name
          AND tc.constraint_type = 'FOREIGN KEY'
    )
ORDER BY
    t.table_schema,
    t.table_name;

-- 7. FK Relationships by table (summary view)
SELECT
    COALESCE(tc.table_schema, ccu.table_schema) as schema_name,
    COALESCE(tc.table_name, ccu.table_name) as table_name,
    COUNT(DISTINCT CASE WHEN tc.constraint_type = 'FOREIGN KEY' THEN tc.constraint_name END) as outgoing_fks,
    COUNT(DISTINCT CASE WHEN tc2.constraint_type = 'FOREIGN KEY' THEN tc2.constraint_name END) as incoming_fks,
    CASE
        WHEN COUNT(DISTINCT CASE WHEN tc.constraint_type = 'FOREIGN KEY' THEN tc.constraint_name END) > 0
         AND COUNT(DISTINCT CASE WHEN tc2.constraint_type = 'FOREIGN KEY' THEN tc2.constraint_name END) > 0
        THEN 'BIDIRECTIONAL'
        WHEN COUNT(DISTINCT CASE WHEN tc.constraint_type = 'FOREIGN KEY' THEN tc.constraint_name END) > 0
        THEN 'REFERENCING'
        WHEN COUNT(DISTINCT CASE WHEN tc2.constraint_type = 'FOREIGN KEY' THEN tc2.constraint_name END) > 0
        THEN 'REFERENCED'
        ELSE 'ISOLATED'
    END as table_role
FROM
    information_schema.tables t
    LEFT JOIN information_schema.table_constraints tc
      ON t.table_schema = tc.table_schema
      AND t.table_name = tc.table_name
      AND tc.constraint_type = 'FOREIGN KEY'
    LEFT JOIN information_schema.constraint_column_usage ccu
      ON t.table_schema = ccu.table_schema
      AND t.table_name = ccu.table_name
    LEFT JOIN information_schema.table_constraints tc2
      ON ccu.constraint_name = tc2.constraint_name
      AND ccu.table_schema = tc2.constraint_schema
      AND tc2.constraint_type = 'FOREIGN KEY'
WHERE
    t.table_schema NOT IN ('information_schema', 'pg_catalog')
    AND t.table_type = 'BASE TABLE'
GROUP BY
    COALESCE(tc.table_schema, ccu.table_schema),
    COALESCE(tc.table_name, ccu.table_name)
ORDER BY
    schema_name,
    table_name;

-- 8. Export as CSV-ready format
SELECT
    'Table' as type,
    tc.table_schema || '.' || tc.table_name as table_name,
    'has FK to' as relationship,
    ccu.table_schema || '.' || ccu.table_name as referenced_table,
    kcu.column_name as local_column,
    ccu.column_name as referenced_column,
    COALESCE(rc.delete_rule, 'NO ACTION') as delete_rule,
    COALESCE(rc.update_rule, 'NO ACTION') as update_rule
FROM
    information_schema.table_constraints AS tc
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
      AND tc.table_schema = kcu.table_schema
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
      AND ccu.table_schema = tc.table_schema
    LEFT JOIN information_schema.referential_constraints AS rc
      ON tc.constraint_name = rc.constraint_name
      AND tc.table_schema = rc.constraint_schema
WHERE
    tc.constraint_type = 'FOREIGN KEY'
    AND tc.table_schema NOT IN ('information_schema', 'pg_catalog')
ORDER BY
    tc.table_schema,
    tc.table_name,
    tc.constraint_name,
    kcu.ordinal_position;