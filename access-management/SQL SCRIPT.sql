CREATE DATABASE access_management;


CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    role TEXT CHECK (role IN ('Employee', 'Manager', 'Admin')) NOT NULL
);

CREATE TABLE software (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    access_levels TEXT CHECK (access_levels IN ('Read', 'Write', 'Admin'))
);

CREATE TABLE requests (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    software_id INT REFERENCES software(id) ON DELETE CASCADE,
    access_type TEXT CHECK (access_type IN ('Read', 'Write', 'Admin')),
    reason TEXT NOT NULL,
    status TEXT CHECK (status IN ('Pending', 'Approved', 'Rejected')) NOT NULL DEFAULT 'Pending'
);
