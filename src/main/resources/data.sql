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
        '12345678',
        'admin',
        'active'
    );