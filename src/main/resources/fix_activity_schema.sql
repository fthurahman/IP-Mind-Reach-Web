-- =================================================================================
-- FIX SCRIPT: ACTIVITY MONITORING
-- =================================================================================
-- Issue: The "Completion Rates" chart is not updating because the database likely 
-- allows duplicate rows instead of updating existing ones. This happens if the table
-- was created before the UNIQUE constraint was added to the schema.
--
-- This script will:
-- 1. Clear the potentially corrupted 'activity_progress' data.
-- 2. Add the missing UNIQUE constraint to ensure data updates correctly.
-- =================================================================================

-- 1. Clear existing progress data (Start Fresh)
TRUNCATE TABLE activity_progress;

-- 2. Add the Unique Constraint (Safely)
-- This ensures that (user_email + activity_name) is unique, so "ON DUPLICATE KEY UPDATE" works.
-- If the key already exists, this might error, which is fine (means it's already fixed).
SET @exist := (SELECT COUNT(*) FROM information_schema.statistics 
    WHERE table_name = 'activity_progress' 
    AND index_name = 'unique_activity' 
    AND table_schema = DATABASE());

SET @sqlstmt := IF(@exist = 0, 
    'ALTER TABLE activity_progress ADD UNIQUE KEY unique_activity (user_email, activity_name)', 
    'SELECT "Unique constraint already exists"');

PREPARE stmt FROM @sqlstmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 3. Re-Insert Sample Data (Optional, using the fixed constraint)
INSERT INTO activity_progress (user_email, activity_name, completed_count, total_count) VALUES
('admin1@gmail.com', 'Self-Help', 0, 10),
('admin1@gmail.com', 'Resources', 0, 10),
('admin1@gmail.com', 'Forum', 0, 10),
('admin1@gmail.com', 'Counseling', 0, 10),
('admin1@gmail.com', 'Chatbot', 0, 10),
('admin1@gmail.com', 'Progress', 0, 10);
