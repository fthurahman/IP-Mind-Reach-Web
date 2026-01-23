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

        System.out.println("DEBUG: updateResourceActivityProgress for " + email);
        System.out.println("DEBUG: Unique Count from DB: " + uniqueCount);

        // Upsert into activity_progress
        // ...
        String activityName = "Resources";

        String updateSql = "UPDATE activity_progress SET completed_count = ? WHERE user_email = ? AND activity_name = ?";
        int rowsUpdated = jdbcTemplate.update(updateSql, uniqueCount, email, activityName);
        System.out.println("DEBUG: Rows updated in activity_progress: " + rowsUpdated);

        if (rowsUpdated == 0) {
            String insertSql = "INSERT INTO activity_progress (user_email, activity_name, completed_count, total_count) VALUES (?, ?, ?, ?)";
            try {
                int total = 10;
                if ("Resources".equals(activityName)) {
                    total = Resource.mockResources().size();
                }
                jdbcTemplate.update(insertSql, email, activityName, uniqueCount, total);
                System.out.println("DEBUG: Inserted new row into activity_progress. Total: " + total);
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

        if (rowsUpdated == 0) {
            String insertSql = "INSERT INTO activity_progress (user_email, activity_name, completed_count, total_count) VALUES (?, ?, 1, ?)";
            try {
                int total = 10;
                if ("Resources".equals(activityName)) {
                    total = Resource.mockResources().size();
                }
                jdbcTemplate.update(insertSql, email, activityName, total);
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
            String insertSql = "INSERT INTO activity_progress (user_email, activity_name, completed_count, total_count) VALUES (?, ?, ?, 5)";
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
        // 1. Generate last 7 days map (date -> data)
        Map<String, Map<String, Object>> dateMap = new java.util.LinkedHashMap<>();
        java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("MM/dd");
        java.time.LocalDate today = java.time.LocalDate.now();

        // Populate with zeros
        for (int i = 6; i >= 0; i--) {
            String dateStr = today.minusDays(i).format(formatter);
            Map<String, Object> data = new HashMap<>();
            data.put("date", dateStr);
            data.put("users", 0);
            data.put("sessions", 0);
            dateMap.put(dateStr, data);
        }

        // 2. Query DB
        String sql = "SELECT DATE_FORMAT(start_time, '%m/%d') as dateStr, " +
                "COUNT(DISTINCT user_email) as users, " +
                "COUNT(*) as sessions " +
                "FROM analytics_sessions " +
                "WHERE start_time >= DATE_SUB(NOW(), INTERVAL 7 DAY) " +
                "GROUP BY DATE_FORMAT(start_time, '%m/%d')";

        jdbcTemplate.query(sql, (rs) -> {
            String dateStr = rs.getString("dateStr");
            if (dateMap.containsKey(dateStr)) {
                Map<String, Object> data = dateMap.get(dateStr);
                data.put("users", rs.getInt("users"));
                data.put("sessions", rs.getInt("sessions"));
            }
        });

        return new java.util.ArrayList<>(dateMap.values());
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

    public List<Map<String, Object>> getGlobalMoodTrends() {
        // Daily average mood last 7 days
        String sql = "SELECT entry_date, AVG(mood_value) as avg_mood FROM mood_entries GROUP BY entry_date ORDER BY entry_date DESC LIMIT 7";
        List<Map<String, Object>> trends = jdbcTemplate.query(sql, (rs, rowNum) -> {
            Map<String, Object> map = new HashMap<>();
            map.put("date", new java.text.SimpleDateFormat("MMM dd").format(rs.getDate("entry_date")));
            map.put("value", String.format("%.1f", rs.getDouble("avg_mood")));
            return map;
        });
        // Reverse to show oldest to newest
        java.util.Collections.reverse(trends);
        return trends;
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
                    rs.getString("status"),
                    rs.getObject("post_id") != null ? String.valueOf(rs.getInt("post_id")) : null);
        });
    }

    public void updateReportStatus(int id, String action) {
        String status = "resolved";
        if ("remove".equals(action)) {
            status = "removed";
        } else if ("hide".equals(action)) {
            status = "hidden";
        } else if ("approve".equals(action)) {
            status = "approved";
        }

        String sql = "UPDATE moderation_reports SET status = ? WHERE id = ?";
        try {
            jdbcTemplate.update(sql, status, id);
            System.out.println("DEBUG: Updated report " + id + " to " + status);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
