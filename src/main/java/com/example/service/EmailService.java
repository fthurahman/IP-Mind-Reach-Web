package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendEmail(String to, String subject, String text) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("asilahrazak123@gmail.com"); // Must match the authenticated user
        message.setTo(to);
        message.setSubject(subject);
        message.setText(text);
        
        try {
            System.out.println("Attempting to send email to: " + to);
            mailSender.send(message);
            System.out.println("Email sent successfully!");
        } catch (Exception e) {
            System.err.println("EMAIL SENDING FAILED: " + e.getMessage());
            e.printStackTrace();
            // Don't throw exception to avoid breaking the user flow, just log it.
        }
    }
}
