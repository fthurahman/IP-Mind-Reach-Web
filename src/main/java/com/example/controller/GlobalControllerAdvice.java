package com.example.controller;

import com.example.model.User;
import com.example.model.UserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

    @Autowired
    private UserDAO userDAO;

    @ModelAttribute("loggedUser")
    public User populateLoggedUser() {
        System.out.println("DEBUG: GlobalControllerAdvice - Populating loggedUser");
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
             System.out.println("DEBUG: Auth found: " + auth.getName() + ", Authenticated: " + auth.isAuthenticated());
        } else {
             System.out.println("DEBUG: No Auth in SecurityContext");
        }
        
        if (auth != null && auth.isAuthenticated() && !auth.getPrincipal().equals("anonymousUser")) {
            // In CustomUserDetailsService, we set the username as the email
            String email = ((org.springframework.security.core.userdetails.UserDetails) auth.getPrincipal()).getUsername();
            User user = userDAO.findByEmail(email);
            System.out.println("DEBUG: Found User for Model: " + (user != null ? user.getEmail() : "null"));
            return user;
        }
        return null;
    }
}
