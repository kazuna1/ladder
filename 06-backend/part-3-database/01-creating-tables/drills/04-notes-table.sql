-- MODULE 01 · DRILL 04 — The notes Table (the real one)
-- Combine everything into the table your Notes API will actually use.
-- Also learn to DROP (delete) a table and recreate it.
-- ---------------------------------------------------------------------------

-- TODO 1: create the "notes" table:
--   id     → auto-numbered primary key   (INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY)
--   title  → required text               (TEXT NOT NULL)
--   body   → optional text, default ''   (TEXT DEFAULT '')

CREATE TABLE notes (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT
);
-- TODO 2: \d notes → confirm all 3 columns + the id primary key.

ladder_notes=# \d notes
                          Table "public.notes"
 Column |  Type   | Collation | Nullable |           Default
--------+---------+-----------+----------+------------------------------
 id     | integer |           | not null | generated always as identity
 title  | text    |           | not null |
 body   | text    |           |          |
Indexes:
    "notes_pkey" PRIMARY KEY, btree (id)


ladder_notes=#
-- TODO 3: managing tables — DROP and recreate.
--   Say you want to change the shape. You remove the table first:
--     DROP TABLE notes;
--   (⚠️ DROP deletes the table AND all its data — permanent. Fine here, it's empty.)
--   Then create it again (paste TODO 1 again). \dt to confirm it's back.

ladder_notes=# DROP TABLE notes;
DROP TABLE
ladder_notes=# \d notes
Did not find any relation named "notes".
ladder_notes=#
-- TODO 4 (safe recreate pattern): a common trick to avoid "already exists" errors:
--   DROP TABLE IF EXISTS notes;          -- only drops if it's there, no error if not
--   CREATE TABLE notes ( ... );          -- then recreate fresh
--   Run this pair — it's how you "reset" a table while experimenting.
ladder_notes=# \d notes
                          Table "public.notes"
 Column |  Type   | Collation | Nullable |           Default
--------+---------+-----------+----------+------------------------------
 id     | integer |           | not null | generated always as identity
 title  | text    |           | not null |
 body   | text    |           |          |
Indexes:
    "notes_pkey" PRIMARY KEY, btree (id)


ladder_notes=#

-- WHAT TO NOTICE:
-- - This is the notes shape from your API — id/title/body — now permanent, on disk.
-- - CREATE TABLE = define the shape. DROP TABLE = destroy it (and its data). You'll
--   DROP + recreate a lot while learning; `DROP TABLE IF EXISTS x;` is the safe reset.
-- - Next module: put actual rows INTO this table with INSERT.
