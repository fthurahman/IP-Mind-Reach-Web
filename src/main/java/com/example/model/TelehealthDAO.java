package com.example.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class TelehealthDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private static final RowMapper<AppointmentTelehealth> appointmentMapper = new RowMapper<AppointmentTelehealth>() {
        @Override
        public AppointmentTelehealth mapRow(ResultSet rs, int rowNum) throws SQLException {
            AppointmentTelehealth appt = new AppointmentTelehealth();
            appt.setId(String.valueOf(rs.getInt("id")));
            appt.setCounselorId(rs.getString("counselor_email"));
            appt.setCounselorName(rs.getString("counselor_name")); // Joined column
            appt.setStudentName(rs.getString("student_name")); // Joined column
            appt.setDate(rs.getString("session_date"));
            appt.setTime(rs.getString("session_time"));
            appt.setStatus(rs.getString("status"));
            appt.setSummary(rs.getString("summary"));
            appt.setRecommendations(rs.getString("recommendations"));
            return appt;
        }
    };

    public void bookSession(String studentEmail, String counselorEmail, String date, String time) {
        String sql = "INSERT INTO telehealth_sessions (student_email, counselor_email, session_date, session_time, status) VALUES (?, ?, ?, ?, 'upcoming')";
        jdbcTemplate.update(sql, studentEmail, counselorEmail, date, time);
    }

    public List<AppointmentTelehealth> getSessionsByStudent(String studentEmail) {
        String sql = "SELECT ts.*, c.name as counselor_name, s.name as student_name " +
                "FROM telehealth_sessions ts " +
                "JOIN users c ON ts.counselor_email = c.email " +
                "JOIN users s ON ts.student_email = s.email " +
                "WHERE ts.student_email = ? " +
                "ORDER BY ts.session_date DESC, ts.session_time DESC";
        return jdbcTemplate.query(sql, appointmentMapper, studentEmail);
    }

    public List<AppointmentTelehealth> getSessionsByCounselor(String counselorEmail) {
        String sql = "SELECT ts.*, c.name as counselor_name, s.name as student_name " +
                "FROM telehealth_sessions ts " +
                "JOIN users c ON ts.counselor_email = c.email " +
                "JOIN users s ON ts.student_email = s.email " +
                "WHERE ts.counselor_email = ? " +
                "ORDER BY ts.session_date DESC, ts.session_time DESC";
        return jdbcTemplate.query(sql, appointmentMapper, counselorEmail);
    }

    // Fetch all counselors (users with role 'mhprofessional' and status 'active')
    public List<CounselorTelehealth> getAllActiveCounselors() {
        String sql = "SELECT * FROM users WHERE role = 'mhprofessional' AND status = 'active'";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            CounselorTelehealth c = new CounselorTelehealth();
            c.setId(rs.getString("email")); // Use email as ID
            c.setName(rs.getString("name"));
            c.setSpecialty("General Counselor"); // Default, could be added to users table later
            c.setBio("Experienced mental health professional."); // Default
            // c.setProfileImage("...");
            return c;
        });
    }

    // Start a session (set status to in_progress)
    public void startSession(int sessionId) {
        String sql = "UPDATE telehealth_sessions SET status = 'in_progress' WHERE id = ?";
        jdbcTemplate.update(sql, sessionId);
    }

    // Complete a session and save notes/recommendations
    public void completeSession(int sessionId, String summary, String recommendations) {
        String sql = "UPDATE telehealth_sessions SET status = 'completed', summary = ?, recommendations = ? WHERE id = ?";
        jdbcTemplate.update(sql, summary, recommendations, sessionId);
    }

    // Update session notes/recommendations only (for already completed sessions)
    public void updateSessionNotes(int sessionId, String summary, String recommendations) {
        String sql = "UPDATE telehealth_sessions SET summary = ?, recommendations = ? WHERE id = ?";
        jdbcTemplate.update(sql, summary, recommendations, sessionId);
    }

    // Get a single session by ID
    public AppointmentTelehealth getSessionById(int sessionId) {
        String sql = "SELECT ts.*, c.name as counselor_name, s.name as student_name " +
                "FROM telehealth_sessions ts " +
                "JOIN users c ON ts.counselor_email = c.email " +
                "JOIN users s ON ts.student_email = s.email " +
                "WHERE ts.id = ?";
        List<AppointmentTelehealth> results = jdbcTemplate.query(sql, appointmentMapper, sessionId);
        return results.isEmpty() ? null : results.get(0);
    }
}
