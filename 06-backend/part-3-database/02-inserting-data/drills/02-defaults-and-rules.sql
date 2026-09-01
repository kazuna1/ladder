-- MODULE 02 · DRILL 02 — Defaults & Rules (the DB enforces your validation)
-- See how DEFAULT and auto-id fill gaps, and watch constraints reject bad data.
-- ---------------------------------------------------------------------------

-- TODO 1: insert a note with ONLY a title (no body):
--   INSERT INTO notes (title) VALUES ('No body note') RETURNING *;
--   → body comes back as '' (empty string) because of DEFAULT ''. You didn't provide
--     it; the DB filled the default. (id auto-filled too.)

INSERT INTO notes (title) VALUES ('No body note') RETURNING *;

ladder_notes=# INSERT INTO notes (title) VALUES ('No body note') RETURNING *;
 id |    title     | body
----+--------------+------
  6 | No body note |
(1 row)


INSERT 0 1
ladder_notes=#
-- TODO 2 (watch NOT NULL reject): try inserting a note with NO title:
--   INSERT INTO notes (body) VALUES ('title is missing');
--   → ERROR: null value in column "title" violates not-null constraint. 🎯
--   That's your `if (!title) return 400` guard — enforced by the DATABASE itself.
INSERT INTO notes (body) VALUES ('title is missing');

ladder_notes=# INSERT INTO notes (body) VALUES ('title is missing');
ERROR:  null value in column "title" of relation "notes" violates not-null constraint
DETAIL:  Failing row contains (7, null, title is missing).
ladder_notes=#

-- TODO 3 (watch UNIQUE reject): first make a table with a unique column:
--   CREATE TABLE accounts (
--     id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--     email TEXT NOT NULL UNIQUE
--   );
--   INSERT INTO accounts (email) VALUES ('a@x.com');   -- ok
--   INSERT INTO accounts (email) VALUES ('a@x.com');   -- ERROR: duplicate key, UNIQUE!
--   → the DB refuses two rows with the same email. No app code needed.

 CREATE TABLE accounts (
    id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     email TEXT NOT NULL UNIQUE
   );

 INSERT INTO accounts (email) VALUES ('a@x.com');  
   INSERT INTO accounts (email) VALUES ('a@x.com'); 
-- WHAT TO NOTICE:
-- - Columns you omit fall back to their DEFAULT (or auto-id, or NULL if allowed).
-- - Constraints are the database saying "no" to bad data — a safety net UNDER your
--   app's validation. Even if your code has a bug, the DB protects the data's integrity.
-- - This is WHY you define constraints: correctness that can't be bypassed.
