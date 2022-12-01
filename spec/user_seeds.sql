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
('Sherlock', 'sholmes@bakerst.com', '$2a$12$cTbNlrgoNGpvE2IgNyhWfuoxEnblsXSgKNAdVwJeqD7Z8sHP4mxES'),
('Clouseau', 'jc@clouseau.com', '$2a$12$gNATEf2vbl7m3DX6yngs7egLm5SCE4SCntikMqCOD2T.X0B/GRocq'),
('Columbo', 'columbo@bakerst.com', '$2a$12$a4fVCE8BWPZuhFfNdDcUje8Z965k2y5xqXLdTLtM00Nlu4HdXDJDm');
-- All passwords are hashed from "TheButlerDidIt"

