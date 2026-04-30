-- Chat History Feature Migration
-- Adds user preferences and extends chat sessions for history functionality

-- Create user_chat_preferences table for personalized chat history settings
CREATE TABLE IF NOT EXISTS user_chat_preferences (
  user_id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  auto_save_sessions boolean DEFAULT true,
  session_retention_days integer DEFAULT 90 CHECK (session_retention_days >= 7),
  max_sessions integer DEFAULT 50 CHECK (max_sessions >= 10),
  show_history_sidebar boolean DEFAULT true,
  default_session_view text DEFAULT 'recent' CHECK (default_session_view IN ('recent', 'alphabetical', 'importance')),
  enable_session_sharing boolean DEFAULT false,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now()
);

-- Add RLS policy for user isolation
ALTER TABLE user_chat_preferences ENABLE ROW LEVEL SECURITY;

CREATE POLICY "user_chat_preferences_access" ON user_chat_preferences
FOR ALL USING (auth.uid() = user_id);

-- Add metadata columns to existing chat_sessions table
ALTER TABLE chat_sessions 
ADD COLUMN IF NOT EXISTS user_generated_title text,
ADD COLUMN IF NOT EXISTS auto_generated_title text,
ADD COLUMN IF NOT EXISTS category text DEFAULT 'general',
ADD COLUMN IF NOT EXISTS importance_level text DEFAULT 'normal' CHECK (importance_level IN ('low', 'normal', 'high', 'critical')),
ADD COLUMN IF NOT EXISTS tags text[] DEFAULT ARRAY[]::text[],
ADD COLUMN IF NOT EXISTS is_archived boolean DEFAULT false,
ADD COLUMN IF NOT EXISTS archived_at timestamp with time zone,
ADD COLUMN IF NOT EXISTS shared_with uuid[] DEFAULT ARRAY[]::uuid[],
ADD COLUMN IF NOT EXISTS last_activity_at timestamp with time zone DEFAULT now(),
ADD COLUMN IF NOT EXISTS total_tokens_used integer DEFAULT 0;

-- Create index for performance
CREATE INDEX IF NOT EXISTS idx_chat_sessions_user_archived ON chat_sessions(user_id, is_archived, last_activity_at DESC);
CREATE INDEX IF NOT EXISTS idx_chat_sessions_category ON chat_sessions(category);
CREATE INDEX IF NOT EXISTS idx_chat_sessions_importance ON chat_sessions(importance_level, last_activity_at DESC);

-- Update trigger for last_activity_at
CREATE OR REPLACE FUNCTION update_chat_session_activity()
RETURNS trigger AS 13251
BEGIN
  NEW.last_activity_at = now();
  RETURN NEW;
END;
13251 LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_chat_session_activity ON chat_sessions;
CREATE TRIGGER trigger_chat_session_activity
  BEFORE UPDATE ON chat_sessions
  FOR EACH ROW EXECUTE FUNCTION update_chat_session_activity();

-- Add comments for documentation
COMMENT ON TABLE user_chat_preferences IS 'User-specific preferences for chat history and session management';
COMMENT ON COLUMN user_chat_preferences.auto_save_sessions IS 'Whether to automatically save chat sessions';
COMMENT ON COLUMN user_chat_preferences.session_retention_days IS 'How long to keep chat sessions (days)';
COMMENT ON COLUMN user_chat_preferences.max_sessions IS 'Maximum number of sessions per user';
COMMENT ON COLUMN chat_sessions.user_generated_title IS 'User-provided title for the chat session';
COMMENT ON COLUMN chat_sessions.auto_generated_title IS 'AI-generated title based on conversation content';
COMMENT ON COLUMN chat_sessions.category IS 'Category classification (general, procurement, technical, etc.)';
COMMENT ON COLUMN chat_sessions.importance_level IS 'Importance level for prioritization';
COMMENT ON COLUMN chat_sessions.tags IS 'User-defined tags for organization';
COMMENT ON COLUMN chat_sessions.shared_with IS 'Array of user IDs this session is shared with';
