package com.example;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import java.util.Properties;

public class EmailTester {
    public static void main(String[] args) {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost("smtp.gmail.com");
        mailSender.setPort(587);
        mailSender.setUsername("asilahrazak123@gmail.com");
        mailSender.setPassword("quvb sadx olcv cfme");

        Properties props = mailSender.getJavaMailProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.debug", "true");

        try {
            System.out.println("Attempting to send test email...");
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("asilahrazak123@gmail.com");
            message.setTo("asilahrazak123@gmail.com");
            message.setSubject("Test Email from Debugger (Attempt 2)");
            message.setText("If you see this, email sending is working with the new credentials!");

            mailSender.send(message);
            System.out.println("Email sent successfully!");
        } catch (Exception e) {
            System.err.println("FAILED to send email:");
            e.printStackTrace();
        }
    }
}
