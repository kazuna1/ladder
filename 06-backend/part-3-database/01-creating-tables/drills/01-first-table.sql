-- MODULE 01 · DRILL 01 — Your First Table
-- The simplest possible table: a name + a couple of columns with types.
-- Goal: get comfortable with the CREATE TABLE shape and inspecting the result.
--
-- Run each statement at your  ladder_notes=#  prompt.
-- ---------------------------------------------------------------------------

-- TODO 1: create a table called "students" with two columns:
--   name  → TEXT
--   age   → INTEGER
--
--   shape:
--   CREATE TABLE students (
--     name  TEXT,
--     age   INTEGER
--   );
CREATE TABLE students (
    name TEXT,
    age INTEGER
);

-- TODO 2: inspect it. Run these psql commands (NOT sql — no semicolon):
--   \dt            → should list "students"
--   \d students    → should show your 2 columns and their types

postgres=# \dt
            List of tables
 Schema |   Name   | Type  |  Owner
--------+----------+-------+----------
 public | students | table | postgres
(1 row)
-- TODO 3: create a second table "books" with:
--   title   → TEXT
--   pages   → INTEGER
--   in_print → BOOLEAN

CREATE TABLE books (
    title TEXT,
    pages INTEGER,
    in_print BOOLEAN
);

-- TODO 4: \dt again → you should now see BOTH tables (students, books).

postgres=# \dt
            List of tables
 Schema |   Name   | Type  |  Owner
--------+----------+-------+----------
 public | books    | table | postgres
 public | students | table | postgres
(2 rows)
-- WHAT TO NOTICE:
-- - A table is a named shape. No data yet — you just defined the columns.
-- - Every column = a name + a type. That's the minimum. (Constraints come in drill 03.)
-- - \d <table> is your "show me the shape" command — use it constantly.
