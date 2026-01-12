package com.example.model;

public class User{
	private String name;
	private String email;
	private String password;
	private String role;
	private String status;
	
	//Constructors
	public User() {}
	public User(String name, String email, String password, String role, String status) {
		this.name = name;
		this.email = email;
		this.password = password;
		this.role = role;
		this.status = status;
	}
	
	//getter
	public String getName() {
		return name;
	}
	public String getEmail() {
		return email;
	}
	public String getPassword() {
		return password;
	}
	public String getRole() {
		return role;
	}
	public String getStatus() {
		return status;
	}
	
	//setter
	public void setName(String name) {
		this.name = name;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public void setStatus(String status) {
		this.status = status;
	}

    // Reset Token Fields
    private String resetToken;
    private java.sql.Timestamp resetTokenExpiry;

    public String getResetToken() {
        return resetToken;
    }

    public void setResetToken(String resetToken) {
        this.resetToken = resetToken;
    }

    public java.sql.Timestamp getResetTokenExpiry() {
        return resetTokenExpiry;
    }

    public void setResetTokenExpiry(java.sql.Timestamp resetTokenExpiry) {
        this.resetTokenExpiry = resetTokenExpiry;
    }
}
