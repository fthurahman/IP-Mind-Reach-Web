package com.example.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Repository
public class UserDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	// RowMapper to map DB rows to User objects
	private static final RowMapper<User> userRowMapper = new RowMapper<User>() {
		@Override
		public User mapRow(@org.springframework.lang.NonNull ResultSet rs, int rowNum) throws SQLException {
			User user = new User(
					rs.getString("name"),
					rs.getString("email"),
					rs.getString("password"),
					rs.getString("role"),
					rs.getString("status"));
			user.setResetToken(rs.getString("reset_token"));
			user.setResetTokenExpiry(rs.getTimestamp("reset_token_expiry"));
			return user;
		}
	};

	public void save(User user) {
		// Check if user exists (optional, but good practice, though controller might
		// handle it too)
		// Usually, we rely on duplicate key exception or check before insert.
		// For simplicity matching previous logic which checked in controller:
		String sql = "INSERT INTO users (name, email, password, role, status, reset_token, reset_token_expiry) VALUES (?, ?, ?, ?, ?, ?, ?)";
		jdbcTemplate.update(sql, user.getName(), user.getEmail(), user.getPassword(), user.getRole(), user.getStatus(), user.getResetToken(), user.getResetTokenExpiry());
	}

	public User findByEmail(String email) {
		String sql = "SELECT * FROM users WHERE email = ?";
		try {
			return jdbcTemplate.queryForObject(sql, userRowMapper, email);
		} catch (Exception e) {
			// EmptyResultDataAccessException or similar
			return null;
		}
	}

	public void update(User user) {
		String sql = "UPDATE users SET name = ?, password = ?, role = ?, status = ?, reset_token = ?, reset_token_expiry = ? WHERE email = ?";
		jdbcTemplate.update(sql, user.getName(), user.getPassword(), user.getRole(), user.getStatus(), user.getResetToken(), user.getResetTokenExpiry(), user.getEmail());
	}
    
    public User findByResetToken(String token) {
        String sql = "SELECT * FROM users WHERE reset_token = ?";
        try {
            return jdbcTemplate.queryForObject(sql, userRowMapper, token);
        } catch (Exception e) {
            return null;
        }
    }

	public void delete(String email) {
		String sql = "DELETE FROM users WHERE email = ?";
		jdbcTemplate.update(sql, email);
	}

	public List<User> findAll() {
		String sql = "SELECT * FROM users";
		return jdbcTemplate.query(sql, userRowMapper);
	}

    // Fetch all students with their latest assessment results
    public List<StudentAssessmentDTO> getAllStudentAssessments() {
        String sql = "SELECT u.name, u.email, " +
                     "d.depression_score, d.anxiety_score, d.stress_score, " +
                     "d.level_depression, d.level_anxiety, d.level_stress, d.assessment_date as dass_date, " +
                     "p.total_score, p.severity, p.flagged_suicide, p.assessment_date as phq_date " +
                     "FROM users u " +
                     "LEFT JOIN (SELECT * FROM dass_results WHERE assessment_date IN (SELECT MAX(assessment_date) FROM dass_results GROUP BY user_email)) d ON u.email = d.user_email " +
                     "LEFT JOIN (SELECT * FROM phq_results WHERE assessment_date IN (SELECT MAX(assessment_date) FROM phq_results GROUP BY user_email)) p ON u.email = p.user_email " +
                     "WHERE u.role = 'student'";

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            StudentAssessmentDTO dto = new StudentAssessmentDTO();
            dto.setName(rs.getString("name"));
            dto.setEmail(rs.getString("email"));
            
            // DASS
            dto.setDepressionScore(rs.getInt("depression_score"));
            dto.setAnxietyScore(rs.getInt("anxiety_score"));
            dto.setStressScore(rs.getInt("stress_score"));
            dto.setLevelDepression(rs.getString("level_depression"));
            dto.setLevelAnxiety(rs.getString("level_anxiety"));
            dto.setLevelStress(rs.getString("level_stress"));
            dto.setDassDate(rs.getTimestamp("dass_date"));
            
            // PHQ
            dto.setPhqScore(rs.getInt("total_score"));
            dto.setPhqSeverity(rs.getString("severity"));
            dto.setPhqFlagged(rs.getBoolean("flagged_suicide"));
            dto.setPhqDate(rs.getTimestamp("phq_date"));
            return dto;
        });
    }

    // Fetch all student assessment results (DASS) with optional search
    public List<Map<String, Object>> getAllDassResults(String search) {
        String sql = "SELECT u.name, u.email, d.* " +
                     "FROM dass_results d " +
                     "JOIN users u ON d.user_email = u.email ";
        
        if (search != null && !search.trim().isEmpty()) {
            sql += "WHERE u.name LIKE ? ";
            sql += "ORDER BY d.assessment_date DESC";
            return jdbcTemplate.queryForList(sql, "%" + search.trim() + "%");
        } else {
            sql += "ORDER BY d.assessment_date DESC";
            return jdbcTemplate.queryForList(sql);
        }
    }

    // Fetch all student assessment results (PHQ) with optional search
    public List<Map<String, Object>> getAllPhqResults(String search) {
        String sql = "SELECT u.name, u.email, p.* " +
                     "FROM phq_results p " +
                     "JOIN users u ON p.user_email = u.email ";
                     
        if (search != null && !search.trim().isEmpty()) {
            sql += "WHERE u.name LIKE ? ";
            sql += "ORDER BY p.assessment_date DESC";
            return jdbcTemplate.queryForList(sql, "%" + search.trim() + "%");
        } else {
            sql += "ORDER BY p.assessment_date DESC";
            return jdbcTemplate.queryForList(sql);
        }
    }
}
