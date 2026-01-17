package com.example.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.annotation.PostConstruct;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Repository
public class ProgressDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @PostConstruct
    public void init() {
        try {
            // Ensure mood_entries table exists
            jdbcTemplate.execute("CREATE TABLE IF NOT EXISTS mood_entries (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_email VARCHAR(255) NOT NULL, " +
                    "mood_value INT NOT NULL, " +
                    "emoji VARCHAR(10), " +
                    "entry_date DATE NOT NULL, " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "UNIQUE KEY unique_daily_entry (user_email, entry_date), " +
                    "FOREIGN KEY (user_email) REFERENCES users (email) ON DELETE CASCADE)");

            // Ensure activity_progress table exists
            jdbcTemplate.execute("CREATE TABLE IF NOT EXISTS activity_progress (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_email VARCHAR(255) NOT NULL, " +
                    "activity_name VARCHAR(50) NOT NULL, " +
                    "full_name VARCHAR(100), " +
                    "completed_count INT DEFAULT 0, " +
                    "total_count INT DEFAULT 10, " +
                    "UNIQUE KEY unique_activity (user_email, activity_name), " +
                    "FOREIGN KEY (user_email) REFERENCES users (email) ON DELETE CASCADE)");

            // Ensure current_streak column exists in users table
            try {
                jdbcTemplate.execute("ALTER TABLE users ADD COLUMN current_streak INT DEFAULT 0");
            } catch (Exception e) {
                // Ignore if column already exists (Duplicate column name)
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static final RowMapper<MoodEntry> moodEntryMapper = new RowMapper<MoodEntry>() {
        @Override
        public MoodEntry mapRow(ResultSet rs, int rowNum) throws SQLException {
            MoodEntry entry = new MoodEntry();
            entry.setDate(rs.getString("entry_date"));
            entry.setMood(rs.getInt("mood_value"));
            entry.setEmoji(rs.getString("emoji"));
            return entry;
        }
    };

    // --- Mood Operations ---

    public List<MoodEntry> getRecentMoodEntries(String email, int limit) {
        // Fetch latest N entries (DESC) and then order them ASC for the chart
        String sql = "SELECT * FROM (SELECT * FROM mood_entries WHERE user_email = ? ORDER BY entry_date DESC LIMIT ?) AS sub ORDER BY entry_date ASC";
        List<MoodEntry> entries = jdbcTemplate.query(sql, moodEntryMapper, email, limit);

        // Convert YYYY-MM-DD to MM/DD for display
        for (MoodEntry entry : entries) {
            try {
                LocalDate date = LocalDate.parse(entry.getDate());
                entry.setDate(date.format(java.time.format.DateTimeFormatter.ofPattern("MM/dd")));
            } catch (Exception e) {
                // ignore
            }
        }
        return entries;
    }

    public String getLastMoodDate(String email) {
        try {
            String sql = "SELECT MAX(entry_date) FROM mood_entries WHERE user_email = ?";
            return jdbcTemplate.queryForObject(sql, String.class, email);
        } catch (Exception e) {
            return null;
        }
    }

    private void seedInitialMoodData(String email) {
        // Method kept but unused, or can be removed.
        // User requested removal of mock data usage.
    }

    public int getCurrentStreak(String email) {
        String sql = "SELECT current_streak FROM users WHERE email = ?";
        Integer streak = jdbcTemplate.queryForObject(sql, Integer.class, email);
        return streak != null ? streak : 0;
    }

    public void logMood(String email, int moodValue, String emoji, String date) {
        // Upsert logic (ON DUPLICATE KEY UPDATE)
        String sql = "INSERT INTO mood_entries (user_email, mood_value, emoji, entry_date) VALUES (?, ?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE mood_value = ?, emoji = ?";
        jdbcTemplate.update(sql, email, moodValue, emoji, date, moodValue, emoji);

        // Increment user streak (Simple presentation logic)
        String streakSql = "UPDATE users SET current_streak = current_streak + 1 WHERE email = ?";
        jdbcTemplate.update(streakSql, email);
    }

    public double calculateAverageMood(String email) {
        // Last 30 days average
        String sql = "SELECT AVG(mood_value) FROM mood_entries WHERE user_email = ? AND entry_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)";
        Double avg = jdbcTemplate.queryForObject(sql, Double.class, email);
        return avg != null ? avg : 0.0;
    }

    public int getTotalActivities(String email) {
        int total = 0;

        // 1. Counseling sessions count
        String counselingSql = "SELECT COUNT(*) FROM telehealth_sessions WHERE student_email = ? AND status = 'completed'";
        Integer counselingCount = jdbcTemplate.queryForObject(counselingSql, Integer.class, email);
        total += (counselingCount != null ? counselingCount : 0);

        // 2. Self-Help, Resources, Forum Posts (from activity_progress)
        String[] predefinedActivities = { "Self-Help", "Resources", "Forum Posts" };
        for (String activityName : predefinedActivities) {
            String sql = "SELECT completed_count FROM activity_progress WHERE user_email = ? AND activity_name = ?";
            try {
                Integer count = jdbcTemplate.queryForObject(sql, Integer.class, email, activityName);
                total += (count != null ? count : 0);
            } catch (Exception e) {
                // Activity doesn't exist yet, contributes 0
            }
        }

        return total;
    }

    // --- Activity Operations ---

    public List<Activity> getUserActivities(String email) {
        List<Activity> activities = new ArrayList<>();

        // 1. Counseling (from telehealth_sessions)
        String counselingSql = "SELECT COUNT(*) FROM telehealth_sessions WHERE student_email = ? AND status = 'completed'";
        Integer counselingCompleted = jdbcTemplate.queryForObject(counselingSql, Integer.class, email);
        activities.add(new Activity("👤", "Counseling", counselingCompleted != null ? counselingCompleted : 0, 5)); // Goal:
                                                                                                                    // 5
                                                                                                                    // sessions

        // 2. Others (from activity_progress)
        String[] predefinedActivities = { "Self-Help", "Resources", "Forum Posts" };
        String[] emojis = { "❤️", "📚", "💬" };
        int[] defaultTotals = { 15, 10, 5 };

        for (int i = 0; i < predefinedActivities.length; i++) {
            String actName = predefinedActivities[i];
            final int index = i;

            // Check if exists, if not create default
            String checkSql = "SELECT * FROM activity_progress WHERE user_email = ? AND activity_name = ?";
            try {
                // Return mapped object
                Activity act = jdbcTemplate.queryForObject(checkSql, (rs, rowNum) -> {
                    return new Activity(emojis[index], rs.getString("activity_name"), rs.getInt("completed_count"),
                            rs.getInt("total_count"));
                }, email, actName);

                // Fix emoji as it is not stored in DB currently (or we can store it)
                act.setName(emojis[i]);
                act.setFullName(actName); // Ensure fullName is set correctly
                activities.add(act);

            } catch (EmptyResultDataAccessException e) {
                // Create default entry with 0 completed
                String insertSql = "INSERT INTO activity_progress (user_email, activity_name, full_name, completed_count, total_count) VALUES (?, ?, ?, 0, ?)";
                jdbcTemplate.update(insertSql, email, actName, actName, defaultTotals[i]);
                activities.add(new Activity(emojis[i], actName, 0, defaultTotals[i]));
            }
        }

        return activities;
    }
}
