CREATE TABLE IF NOT EXISTS items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

INSERT INTO items (name) VALUES ('Item1'), ('Item2'), ('Item3');
