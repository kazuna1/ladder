-- PHASE 3 · DRILL — Notes table CRUD (run in psql)
-- Setup:  psql -U postgres  →  CREATE DATABASE notes_db;  →  \c notes_db  →  \i notes-table.sql
-- Fill in the TODOs. Each is one SQL statement.
-- ---------------------------------------------------------------------------

-- TODO 1: CREATE the notes table.
--   columns: id (identity primary key), text (TEXT not null), created_at (timestamptz default now())


-- TODO 2: INSERT two notes. Use RETURNING * to see the created rows.
--   INSERT INTO notes (text) VALUES ('first') RETURNING *;


-- TODO 3: SELECT all notes.


-- TODO 4: SELECT just the note with id = 1.


-- TODO 5: UPDATE note id = 1's text to something else. RETURNING * to confirm.
--   (Remember the WHERE — without it you edit EVERY row.)


-- TODO 6: DELETE note id = 2. RETURNING * to confirm which row went.


-- WHAT TO NOTICE:
-- - These 5 statements ARE your note app's Create/Read/Update/Delete, in SQL.
-- - In the backend, each runs through pool.query(...) with $1 params instead of literals.
