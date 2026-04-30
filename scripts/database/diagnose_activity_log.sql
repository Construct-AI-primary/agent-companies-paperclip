-- Diagnostic query to see what failed operations actually exist
SELECT 
    id,
    action,
    details::text as full_details,
    created_at
FROM activity_log 
WHERE details::text ILIKE '%strategos%'
   OR details::text ILIKE '%openclaw%'
   OR details::text ILIKE '%gateway%'
   OR details::text ILIKE '%missing%'
   OR details::text ILIKE '%url%'
ORDER BY created_at DESC
LIMIT 10;

-- Also check for any entries with "failed" in action or details
SELECT 
    id,
    action,
    LEFT(details::text, 200) as details_preview,
    created_at
FROM activity_log 
WHERE action ILIKE '%failed%'
   OR details::text ILIKE '%failed%'
ORDER BY created_at DESC
LIMIT 10;
