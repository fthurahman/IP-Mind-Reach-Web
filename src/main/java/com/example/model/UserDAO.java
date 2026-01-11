package com.example.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class UserDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	// RowMapper to map DB rows to User objects
	private static final RowMapper<User> userRowMapper = new RowMapper<User>() {
		@Override
		public User mapRow(@org.springframework.lang.NonNull ResultSet rs, int rowNum) throws SQLException {
			return new User(
					rs.getString("name"),
					rs.getString("email"),
					rs.getString("password"),
					rs.getString("role"));
		}
	};

	public void save(User user) {
		// Check if user exists (optional, but good practice, though controller might
		// handle it too)
		// Usually, we rely on duplicate key exception or check before insert.
		// For simplicity matching previous logic which checked in controller:
		String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
		jdbcTemplate.update(sql, user.getName(), user.getEmail(), user.getPassword(), user.getRole());
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
		String sql = "UPDATE users SET name = ?, password = ?, role = ? WHERE email = ?";
		jdbcTemplate.update(sql, user.getName(), user.getPassword(), user.getRole(), user.getEmail());
	}

	public void delete(String email) {
		String sql = "DELETE FROM users WHERE email = ?";
		jdbcTemplate.update(sql, email);
	}

	public List<User> findAll() {
		String sql = "SELECT * FROM users";
		return jdbcTemplate.query(sql, userRowMapper);
	}
}
