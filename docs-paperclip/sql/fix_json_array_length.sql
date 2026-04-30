-- Fix for PGlite compatibility: Add json_array_length function
-- This function is missing in PGlite but used by some queries

CREATE OR REPLACE FUNCTION json_array_length(json)
RETURNS integer
LANGUAGE sql
IMMUTABLE
AS $$
  SELECT jsonb_array_length($1::jsonb);
$$;

-- Also ensure jsonb_array_length works for json inputs
CREATE OR REPLACE FUNCTION jsonb_array_length(json)
RETURNS integer
LANGUAGE sql
IMMUTABLE
AS $$
  SELECT jsonb_array_length($1::jsonb);
$$;