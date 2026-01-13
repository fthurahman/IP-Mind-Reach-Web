INSERT IGNORE INTO
    users (
        email,
        name,
        password,
        role,
        status
    )
VALUES (
        'admin1@gmail.com',
        'Admin',
        '$2a$10$wMLcvSMXjcAHXoxVss9s1eJEsJ1V2B961M3rWw/tTI1GAXI46AjOG',
        'admin',
        'active'
    );