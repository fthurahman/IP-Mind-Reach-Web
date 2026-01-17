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

ALTER TABLE users ADD COLUMN IF NOT EXISTS matric_number VARCHAR(50);

ALTER TABLE users
ADD COLUMN IF NOT EXISTS working_place VARCHAR(255);

ALTER TABLE users ADD COLUMN IF NOT EXISTS phone_number VARCHAR(20);

ALTER TABLE users ADD COLUMN IF NOT EXISTS address TEXT;

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

-- Seed Data (runs on every startup if using schema.sql and Spring Boot default settings, but harmless if using INSERT IGNORE or checking existence)
-- Note: schema.sql typically runs DDL. data.sql is better for DML. But here we append since user is editing schema.sql.
-- Using simple INSERTs with IDs. If table is fresh, it works. If table exists and has data, primary key constraint fails (which is fine, prevents duplication).

-- Post 1
INSERT INTO
    forum_posts (
        id,
        author,
        topic,
        content,
        status,
        reported,
        created_at
    )
SELECT 1, 'Anonymous Owl', 'Stress', 'Finals week is overwhelming ', 'visible', FALSE, '2025-12-18 10:00:00'
WHERE
    NOT EXISTS (
        SELECT 1
        FROM forum_posts
        WHERE
            id = 1
    );

INSERT INTO
    forum_comments (
        id,
        post_id,
        author,
        content,
        created_at
    )
SELECT 1, 1, 'Support', 'Hang in there!', '2025-12-18 10:05:00'
WHERE
    NOT EXISTS (
        SELECT 1
        FROM forum_comments
        WHERE
            id = 1
    );

-- Post 2
INSERT INTO
    forum_posts (
        id,
        author,
        topic,
        content,
        status,
        reported,
        created_at
    )
SELECT 2, 'Worried Student', 'Anxiety', 'I''m feeling really anxious about my grades. Any tips?', 'visible', FALSE, '2025-12-17 14:00:00'
WHERE
    NOT EXISTS (
        SELECT 1
        FROM forum_posts
        WHERE
            id = 2
    );

INSERT INTO
    forum_comments (
        id,
        post_id,
        author,
        content,
        created_at
    )
SELECT 2, 2, 'Peer Helper', 'Try deep breathing exercises. You''ve got this!', '2025-12-17 14:30:00'
WHERE
    NOT EXISTS (
        SELECT 1
        FROM forum_comments
        WHERE
            id = 2
    );

-- Post 3
INSERT INTO
    forum_posts (
        id,
        author,
        topic,
        content,
        status,
        reported,
        created_at
    )
SELECT 3, 'Sleepy Scholar', 'Sleep', 'Not getting enough sleep. How do you balance study and rest?', 'visible', FALSE, '2025-12-16 09:00:00'
WHERE
    NOT EXISTS (
        SELECT 1
        FROM forum_posts
        WHERE
            id = 3
    );

INSERT INTO
    forum_comments (
        id,
        post_id,
        author,
        content,
        created_at
    )
SELECT 3, 3, 'Wellness Buddy', 'Set a consistent sleep schedule and avoid screens before bed.', '2025-12-16 09:15:00'
WHERE
    NOT EXISTS (
        SELECT 1
        FROM forum_comments
        WHERE
            id = 3
    );

-- Post 4
INSERT INTO
    forum_posts (
        id,
        author,
        topic,
        content,
        status,
        reported,
        created_at
    )
SELECT 4, 'Motivated Learner', 'Motivation', 'How do you stay motivated during tough times?', 'visible', FALSE, '2025-12-15 16:00:00'
WHERE
    NOT EXISTS (
        SELECT 1
        FROM forum_posts
        WHERE
            id = 4
    );