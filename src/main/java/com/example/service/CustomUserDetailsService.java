package com.example.service;

import com.example.model.User;
import com.example.model.UserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserDAO userDAO;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        System.out.println("DEBUG: Authenticating email: " + email);
        User user = userDAO.findByEmail(email);
        if (user == null) {
            System.out.println("DEBUG: User not found in DB!");
            throw new UsernameNotFoundException("User not found: " + email);
        }
        System.out.println("DEBUG: User found. Role: " + user.getRole() + ", Password Hash: " + user.getPassword());

        // Check active status
        boolean isActive = "active".equalsIgnoreCase(user.getStatus());
        
        String roleName = user.getRole().toUpperCase();
        
        // If not active (e.g. pending), assign a restricted role so they can't access protected pages
        if (!isActive) {
            roleName = "PENDING";
        }

        // Map application role to Spring Security role with "ROLE_" prefix
        String role = "ROLE_" + roleName;

        return org.springframework.security.core.userdetails.User.builder()
                .username(user.getEmail())
                .password(user.getPassword())
                .authorities(role)
                .disabled(false) // Always enable so we can handle redirection
                .build();
    }
}
