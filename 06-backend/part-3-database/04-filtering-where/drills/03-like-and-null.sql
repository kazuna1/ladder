-- MODULE 04 · DRILL 03 — LIKE (text search) & NULL (the empty value)
-- Pattern-matching on text, and the special rules for "no value".
-- ---------------------------------------------------------------------------

-- === LIKE — search within text using % as a wildcard (% = "anything here") ===

-- TODO 1: titles that CONTAIN 'the' anywhere:
--   SELECT title FROM books WHERE title LIKE '%The%';
--   (%The% = anything, then "The", then anything. This is your .includes() search.)

SELECT title FROM books WHERE title LIKE '%The%';

ladder_notes=# SELECT title FROM books WHERE title LIKE '%The%';
          title
--------------------------
 The Hobbit
 The Pragmatic Programmer
 The Silent Patient
(3 rows)


ladder_notes=#
-- TODO 2: titles that START WITH 'The ':
--   SELECT title FROM books WHERE title LIKE 'The %';
--   (no leading % = must start here. Trailing % = anything after.)

SELECT title FROM books WHERE title LIKE 'The %';

ladder_notes=# SELECT title FROM books WHERE title LIKE 'The %';
          title
--------------------------
 The Hobbit
 The Pragmatic Programmer
 The Silent Patient
(3 rows)


ladder_notes=#


-- TODO 3: titles that END WITH 'Code':
--   SELECT title FROM books WHERE title LIKE '%Code';

SELECT title FROM books WHERE title LIKE '%Code';

ladder_notes=# SELECT title FROM books WHERE title LIKE '%Code';
   title
------------
 Clean Code
(1 row)


ladder_notes=#

-- TODO 4: LIKE is case-SENSITIVE. ILIKE is case-INSENSITIVE (Postgres extension):
--   SELECT title FROM books WHERE title ILIKE '%dune%';   -- matches "Dune"
--   (compare:  WHERE title LIKE '%dune%'  → matches nothing, wrong case)
--   → for user search, ILIKE is usually what you want.

SELECT title FROM books WHERE title ILIKE "%Dune%";
SELECT title FROM books WHERE title ILIKE '%dune%'; 

ladder_notes=# SELECT title FROM books WHERE title ILIKE "%dune%";
ERROR:  column "%dune%" does not exist
LINE 1: SELECT title FROM books WHERE title ILIKE "%dune%";
                                                  ^
ladder_notes=# SELECT title FROM books WHERE title ILIKE "%Dune%";
ERROR:  column "%Dune%" does not exist
LINE 1: SELECT title FROM books WHERE title ILIKE "%Dune%";
                                                  ^
ladder_notes=# SELECT title FROM books WHERE title LIKE "%Dune%";
ERROR:  column "%Dune%" does not exist
LINE 1: SELECT title FROM books WHERE title LIKE "%Dune%";
                                                 ^
ladder_notes=# SELECT title FROM books WHERE title ILIKE "%dune%";
ERROR:  column "%dune%" does not exist
LINE 1: SELECT title FROM books WHERE title ILIKE "%dune%";
                                                  ^
ladder_notes=#

-- === NULL — the special "no value" (different from '' or 0) ===

-- TODO 5: NULL is NOT the same as empty string or zero — it means "unknown/missing".
--   You CANNOT test it with = . This does NOT work:
--     SELECT * FROM books WHERE genre = NULL;   -- returns nothing (wrong!)
--   You MUST use IS NULL / IS NOT NULL:
--     SELECT * FROM books WHERE genre IS NULL;      -- rows with no genre
--     SELECT * FROM books WHERE genre IS NOT NULL;  -- rows that HAVE a genre
--   (all our books have a genre, so IS NULL returns 0 rows — that's correct.)

SELECT * FROM books WHERE genre = NULL;

ladder_notes=# SELECT * FROM books WHERE genre = NULL;
 id | title | author | genre | pages | price | published | in_stock
----+-------+--------+-------+-------+-------+-----------+----------
(0 rows)


ladder_notes=#

-- WHAT TO NOTICE:
-- - LIKE '%x%' = contains, 'x%' = starts with, '%x' = ends with. % is the wildcard.
-- - ILIKE = case-insensitive LIKE. Use it for human search boxes.
-- - NULL means "no value" and is special: test it with IS NULL / IS NOT NULL, never
--   with = . This trips up EVERYONE once — now you know.
