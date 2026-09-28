-- users-table.sql — run once against the auth_api database.
--   psql -U postgres
--   \c auth_api
--   \i users-table.sql
-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS users (
  id            INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  email         TEXT UNIQUE NOT NULL,   -- UNIQUE: two accounts can't share an email.
                                        --   A duplicate INSERT throws SQL error 23505
                                        --   → your controller turns that into 409 Conflict.
  password_hash TEXT NOT NULL,          -- the bcrypt hash ($2a$...), NEVER the plain password.
  created_at    TIMESTAMPTZ DEFAULT now()
);

-- Notes table comes in Module 05 (ownership). For reference, it will look like:
--
--   CREATE TABLE notes (
--     id      INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--     user_id INT NOT NULL REFERENCES users(id),   -- the owner (foreign key)
--     title   TEXT NOT NULL,
--     body    TEXT DEFAULT ''
--   );
--
-- Don't create it yet — build register/login/protection first (modules 03–04).
