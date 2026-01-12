CREATE TABLE IF NOT EXISTS users (
    email VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'active'
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
    status VARCHAR(20) DEFAULT 'upcoming', -- upcoming, completed, cancelled
    summary TEXT,
    recommendations TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_email) REFERENCES users (email) ON DELETE CASCADE,
    FOREIGN KEY (counselor_email) REFERENCES users (email) ON DELETE CASCADE
);