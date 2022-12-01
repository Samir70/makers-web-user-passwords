DROP TABLE IF EXISTS users; 

-- Table Definition
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name text,
    email text,
    password text
);

TRUNCATE TABLE albums RESTART IDENTITY;

INSERT INTO albums ("name", "email", "password") VALUES
('Sherlock', 'sholmes@bakerst.com', 'watson')
('Columbo', 'columbo@bakerst.com', '1MoreThing!')

