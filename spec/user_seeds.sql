DROP TABLE IF EXISTS users; 

-- Table Definition
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name text,
    email text,
    password text
);

TRUNCATE TABLE users RESTART IDENTITY;

INSERT INTO users ("name", "email", "password") VALUES
('Sherlock', 'sholmes@bakerst.com', 'watson'),
('Columbo', 'columbo@bakerst.com', '1MoreThing!');

