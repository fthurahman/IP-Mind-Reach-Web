package com.example.config;

import com.example.service.CustomUserDetailsService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final CustomUserDetailsService userDetailsService;

    public SecurityConfig(CustomUserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authConfig) throws Exception {
        return authConfig.getAuthenticationManager();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf().disable() // Disabling CSRF for now to simplify testing, enable in production!
            .authorizeRequests()
                .antMatchers("/resources/**", "/css/**", "/js/**", "/images/**", "/webjars/**").permitAll()
                .antMatchers("/register", "/login", "/forgot-password", "/check-email", "/reset-password", "/WEB-INF/views/**").permitAll() // Allow views if direct access needed (though usually behind controller)
                .antMatchers("/homeStudent/**").hasRole("STUDENT")
                .antMatchers("/homeAdmin/**", "/user-management/**").hasRole("ADMIN")
                .antMatchers("/homeMProfessional/**", "/counselor/**").hasRole("MHPROFESSIONAL")
                .anyRequest().authenticated()
            .and()
            .formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/login") // Spring Security intercepts POST to this URL
                .usernameParameter("email")   // Our form uses 'email' not 'username'
                .passwordParameter("password")
                .successHandler(myAuthenticationSuccessHandler())
                .failureUrl("/login?error=true")
                .permitAll()
            .and()
            .logout()
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout=true")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .permitAll();
        
        return http.build();
    }

    @Bean
    public AuthenticationSuccessHandler myAuthenticationSuccessHandler(){
        return (request, response, authentication) -> {
            System.out.println("DEBUG: Authentication Successful!");
            var authorities = authentication.getAuthorities();
            System.out.println("DEBUG: User Authorities: " + authorities);
            
            String redirectUrl = "/login";
            
            if (authorities.stream().anyMatch(a -> a.getAuthority().equals("ROLE_STUDENT"))) {
                redirectUrl = "/homeStudent";
            } else if (authorities.stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
                redirectUrl = "/homeAdmin";
            } else if (authorities.stream().anyMatch(a -> a.getAuthority().equals("ROLE_MHPROFESSIONAL"))) {
                redirectUrl = "/homeMProfessional";
            }
            
            System.out.println("DEBUG: Redirecting to: " + redirectUrl);
            response.sendRedirect(request.getContextPath() + redirectUrl);
        };
    }
}
