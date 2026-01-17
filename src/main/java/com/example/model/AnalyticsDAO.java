package com.example.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class AnalyticsDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // --- Actions ---

    public void logSession(String email) {
        String sql = "INSERT INTO analytics_sessions (user_email, start_time) VALUES (?, NOW())";
        try {
            jdbcTemplate.update(sql, email);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void logResourceView(String resourceName, String email) {
        String sql = "INSERT INTO resource_views (resource_name, user_email, viewed_at) VALUES (?, ?, NOW())";
        try {
            jdbcTemplate.update(sql, resourceName, email);

            // NEW: After logging view, update valid activity progress based on unique count
            updateResourceActivityProgress(email);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void updateResourceActivityProgress(String email) {
        // Count distinct resources viewed by this user
        String countSql = "SELECT COUNT(DISTINCT resource_name) FROM resource_views WHERE user_email = ?";
        Integer uniqueCount = jdbcTemplate.queryForObject(countSql, Integer.class, email);
        if (uniqueCount == null)
            uniqueCount = 0;

        // Upsert into activity_progress
        // We use ON DUPLICATE KEY UPDATE logic manually via SELECT/UPDATE/INSERT or
        // MySQL specific syntax.
        // Since we are using standard JDBC here and to match logActivityProgress style:

        String activityName = "Resources";

        String updateSql = "UPDATE activity_progress SET completed_count = ? WHERE user_email = ? AND activity_name = ?";
        int rowsUpdated = jdbcTemplate.update(updateSql, uniqueCount, email, activityName);

        if (rowsUpdated == 0) {
            String insertSql = "INSERT INTO activity_progress (user_email, activity_name, completed_count, total_count) VALUES (?, ?, ?, 10)";
            try {
                jdbcTemplate.update(insertSql, email, activityName, uniqueCount);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void logActivityProgress(String activityName, String email) {
        System.out.println("DEBUG: Analytics Logging - " + activityName + " for " + email);

        // 1. Try to increment existing entry
        String updateSql = "UPDATE activity_progress SET completed_count = completed_count + 1 WHERE user_email = ? AND activity_name = ?";
        int rowsUpdated = jdbcTemplate.update(updateSql, email, activityName);

        // 2. If no row existed, insert a new one
        if (rowsUpdated == 0) {
            String insertSql = "INSERT INTO activity_progress (user_email, activity_name, completed_count, total_count) VALUES (?, ?, 1, 10)";
            try {
                jdbcTemplate.update(insertSql, email, activityName);
            } catch (Exception e) {
                // In case race condition or unique key actually exists now
                e.printStackTrace();
            }
        }
    }

    public void updateSelfHelpActivityProgress(String email) {
        // Count total DASS assessments for this user
        String countDassSql = "SELECT COUNT(*) FROM dass_results WHERE user_email = ?";
        Integer dassCount = jdbcTemplate.queryForObject(countDassSql, Integer.class, email);
        if (dassCount == null)
            dassCount = 0;

        // Count total PHQ assessments for this user
        String countPhqSql = "SELECT COUNT(*) FROM phq_results WHERE user_email = ?";
        Integer phqCount = jdbcTemplate.queryForObject(countPhqSql, Integer.class, email);
        if (phqCount == null)
            phqCount = 0;

        // Total Self-Help activities = DASS + PHQ
        int totalCount = dassCount + phqCount;

        String activityName = "Self-Help";

        String updateSql = "UPDATE activity_progress SET completed_count = ? WHERE user_email = ? AND activity_name = ?";
        int rowsUpdated = jdbcTemplate.update(updateSql, totalCount, email, activityName);

        if (rowsUpdated == 0) {
            String insertSql = "INSERT INTO activity_progress (user_email, activity_name, completed_count, total_count) VALUES (?, ?, ?, 15)";
            try {
                jdbcTemplate.update(insertSql, email, activityName, totalCount);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void updateForumActivityProgress(String email) {
        // Increment "Forum Posts" by 1
        logActivityProgress("Forum Posts", email);
    }

    // --- Key Metrics ---

    public int getWeeklyActiveUsers() {
        String sql = "SELECT COUNT(DISTINCT user_email) FROM analytics_sessions WHERE start_time >= DATE_SUB(NOW(), INTERVAL 7 DAY)";
        try {
            Integer result = jdbcTemplate.queryForObject(sql, Integer.class);
            return result != null ? result : 0;
        } catch (Exception e) {
            return 0;
        }
    }

    public int getTotalSessionsLastWeek() {
        String sql = "SELECT COUNT(*) FROM analytics_sessions WHERE start_time >= DATE_SUB(NOW(), INTERVAL 7 DAY)";
        try {
            Integer result = jdbcTemplate.queryForObject(sql, Integer.class);
            return result != null ? result : 0;
        } catch (Exception e) {
            return 0;
        }
    }

    public int getCounselingBookingsLastWeek() {
        String sql = "SELECT COUNT(*) FROM telehealth_sessions WHERE created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)";
        try {
            Integer result = jdbcTemplate.queryForObject(sql, Integer.class);
            return result != null ? result : 0;
        } catch (Exception e) {
            return 0;
        }
    }

    public int getPendingReportsCount() {
        String sql = "SELECT COUNT(*) FROM moderation_reports WHERE status = 'pending'";
        try {
            Integer result = jdbcTemplate.queryForObject(sql, Integer.class);
            return result != null ? result : 0;
        } catch (Exception e) {
            return 0;
        }
    }

    // --- Charts Data ---

    public List<Map<String, Object>> getEngagementTrend() {
        String sql = "SELECT DATE_FORMAT(start_time, '%m/%d') as dateStr, " +
                "COUNT(DISTINCT user_email) as users, " +
                "COUNT(*) as sessions " +
                "FROM analytics_sessions " +
                "WHERE start_time >= DATE_SUB(NOW(), INTERVAL 7 DAY) " +
                "GROUP BY DATE_FORMAT(start_time, '%m/%d') " +
                "ORDER BY MIN(start_time) ASC";

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Map<String, Object> map = new HashMap<>();
            map.put("date", rs.getString("dateStr"));
            map.put("users", rs.getInt("users"));
            map.put("sessions", rs.getInt("sessions"));
            return map;
        });
    }

    public List<Map<String, Object>> getModuleUsage() {
        String sql = "SELECT activity_name, SUM(completed_count) as total_usage FROM activity_progress GROUP BY activity_name";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Map<String, Object> map = new HashMap<>();
            map.put("name", rs.getString("activity_name"));
            map.put("value", rs.getInt("total_usage"));
            return map;
        });
    }

    public List<Map<String, Object>> getCompletionRates() {
        // Fix for integer division: Multiply by 100.0 first to force float calculation
        String sql = "SELECT activity_name, AVG((completed_count * 100.0) / total_count) as avg_rate FROM activity_progress GROUP BY activity_name";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Map<String, Object> map = new HashMap<>();
            map.put("name", rs.getString("activity_name"));
            map.put("value", Math.round(rs.getDouble("avg_rate")));
            return map;
        });
    }

    public List<Map<String, Object>> getTopResources() {
        String sql = "SELECT resource_name, COUNT(*) as views FROM resource_views GROUP BY resource_name ORDER BY views DESC LIMIT 5";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Map<String, Object> map = new HashMap<>();
            map.put("title", rs.getString("resource_name"));
            map.put("views", rs.getInt("views"));
            return map;
        });
    }

    public List<ReportedPost> getReportedPosts() {
        String sql = "SELECT * FROM moderation_reports ORDER BY created_at DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            return new ReportedPost(
                    String.valueOf(rs.getInt("id")),
                    rs.getString("content"),
                    rs.getString("author"),
                    rs.getString("reason"),
                    rs.getString("reported_by"),
                    rs.getTimestamp("created_at"),
                    rs.getString("status"));
        });
    }
}
