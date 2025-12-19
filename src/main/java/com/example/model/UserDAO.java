package com.example.model;

import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.ArrayList;

@Repository
public class UserDAO {
	private List<User> users = new ArrayList<>();

	public UserDAO() {
		// Pre-seed Admins
		users.add(new User("Aman", "aman@utm.my", "12345678", "admin"));
		users.add(new User("Harith", "harith@utm.my", "12345678", "admin"));
		users.add(new User("Mustaqim", "mustaqim@utm.my", "12345678", "admin"));
		users.add(new User("Asilah", "asilah@utm.my", "12345678", "admin"));

		// Pre-seed Counselors
		users.add(new User("Aman", "aman@gmail.com", "12345678", "mhprofessional"));
		users.add(new User("Harith", "harith@gmail.com", "12345678", "mhprofessional"));
		users.add(new User("Mustaqim", "mustaqim@gmail.com", "12345678", "mhprofessional"));
		users.add(new User("Asilah", "asilah@gmail.com", "12345678", "mhprofessional"));

		// Pre-seed Student (Demo)
		users.add(new User("Ali", "ali_student@graduate.utm.my", "12345678", "student"));
	}

	public void save(User user) {
		// check duplicate emails
		for (User u : users) {
			if (user.getEmail().equals(u.getEmail()))
				throw new RuntimeException("Email already exists");
		}
		users.add(user);
	}

	// find user by email
	public User findByEmail(String email) {
		for (User u : users) {
			if (u.getEmail().equals(email)) {
				return u;
			}
		}
		return null;
	}

	// update existing user
	public void update(User user) {
		for (int i = 0; i < users.size(); i++) {
			if (users.get(i).getEmail().equals(user.getEmail())) {
				users.set(i, user);
				return;
			}
		}
		throw new RuntimeException("User not found");
	}

	// delete user by email
	public void delete(String email) {
		users.removeIf(u -> u.getEmail().equals(email));
	}

	// return all users
	public List<User> findAll() {
		return users;
	}
}
