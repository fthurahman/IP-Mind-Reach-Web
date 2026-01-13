CREATE TABLE IF NOT EXISTS users (
    email VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    reset_token VARCHAR(255),
    reset_token_expiry TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dass_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_email VARCHAR(255) NOT NULL,
    depression_score INT,
    anxiety_score INT,
    stress_score INT,
    level_depression VARCHAR(50),
    level_anxiety VARCHAR(50),
    level_stress VARCHAR(50),
    assessment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_email) REFERENCES users (email) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS phq_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_email VARCHAR(255) NOT NULL,
    total_score INT,
    severity VARCHAR(50),
    flagged_suicide BOOLEAN DEFAULT FALSE,
    assessment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_email) REFERENCES users (email) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS telehealth_sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_email VARCHAR(255) NOT NULL,
    counselor_email VARCHAR(255) NOT NULL,
    session_date DATE NOT NULL,
    session_time VARCHAR(20) NOT NULL,
    status VARCHAR(20) DEFAULT 'upcoming', -- upcoming, inprogress, completed
    summary TEXT,
    recommendations TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_email) REFERENCES users (email) ON DELETE CASCADE,
    FOREIGN KEY (counselor_email) REFERENCES users (email) ON DELETE CASCADE
);

-- Ensure users table has reset_token columns (for existing databases)
-- Note: 'IF NOT EXISTS' requires MySQL 8.0.12+ or MariaDB 10.2.1+
-- If using an older version, these might fail if columns exist, but standard practice suggests keeping schema up to date.
ALTER TABLE users ADD COLUMN IF NOT EXISTS reset_token VARCHAR(255);

ALTER TABLE users
ADD COLUMN IF NOT EXISTS reset_token_expiry TIMESTAMP;

ALTER TABLE users
ADD COLUMN IF NOT EXISTS current_streak INT DEFAULT 0;

CREATE TABLE IF NOT EXISTS mood_entries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_email VARCHAR(255) NOT NULL,
    mood_value INT NOT NULL,
    emoji VARCHAR(10),
    entry_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_daily_entry (user_email, entry_date),
    FOREIGN KEY (user_email) REFERENCES users (email) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS activity_progress (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_email VARCHAR(255) NOT NULL,
    activity_name VARCHAR(50) NOT NULL, -- 'Self-Help', 'Resources', 'Forum Posts'
    full_name VARCHAR(100),
    completed_count INT DEFAULT 0,
    total_count INT DEFAULT 10,
    UNIQUE KEY unique_activity (user_email, activity_name),
    FOREIGN KEY (user_email) REFERENCES users (email) ON DELETE CASCADE
);

-- Analytics Tables

CREATE TABLE IF NOT EXISTS analytics_sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_email VARCHAR(255),
    start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_time TIMESTAMP NULL,
    FOREIGN KEY (user_email) REFERENCES users (email) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS resource_views (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resource_name VARCHAR(255) NOT NULL,
    viewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_email VARCHAR(255),
    FOREIGN KEY (user_email) REFERENCES users (email) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS moderation_reports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT,
    author VARCHAR(255),
    reason VARCHAR(255),
    reported_by VARCHAR(255),
    status VARCHAR(50) DEFAULT 'pending', -- pending, resolved, hidden, removed
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reported_by) REFERENCES users (email) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS forum_posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    author VARCHAR(255),
    topic VARCHAR(255),
    content TEXT,
    status VARCHAR(50),
    reported BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS forum_comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    author VARCHAR(255),
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES forum_posts (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS resources (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    type VARCHAR(50),
    topic VARCHAR(100),
    content TEXT,
    duration VARCHAR(50),
    video_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
