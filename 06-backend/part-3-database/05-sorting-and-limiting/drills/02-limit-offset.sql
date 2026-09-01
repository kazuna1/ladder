-- MODULE 05 · DRILL 02 — LIMIT & OFFSET (capping + pagination)
-- ---------------------------------------------------------------------------

-- TODO 1: just the first 3 books
--   SELECT title FROM books LIMIT 3;

SELECT title FROM books LIMIT 3;

ladder_notes=# SELECT title FROM books LIMIT 3;
       title
-------------------
 The Hobbit
 A Game of Thrones
 Dune
(3 rows)


ladder_notes=#
-- TODO 2: the 3 most expensive books (sort first, THEN cap)
--   SELECT title, price FROM books ORDER BY price DESC LIMIT 3;
--   (this is "top N" — sort by what matters, LIMIT to N)

SELECT title,price FROM books ORDER BY price DESC LIMIT 3;

ladder_notes=# SELECT title,price FROM books ORDER BY price DESC LIMIT 3;
          title           | price
--------------------------+-------
 The Pragmatic Programmer | 39.99
 Clean Code               | 33.99
 Atomic Habits            | 21.00
(3 rows)


ladder_notes=#

-- TODO 3: the 5 newest books
--   SELECT title, published FROM books ORDER BY published DESC LIMIT 5;

SELECT title,published FROM books ORDER BY published DESC LIMIT 5;

ladder_notes=# SELECT title,published FROM books ORDER BY published DESC LIMIT 5;
       title        | published
--------------------+-----------
 Project Hail Mary  |      2021
 The Silent Patient |      2019
 Atomic Habits      |      2018
 Educated           |      2018
 Sapiens            |      2011
(5 rows)


ladder_notes=#

-- TODO 4: OFFSET — skip rows before taking. This is how PAGE 2 works.
--   Page 1 (rows 1–4):   SELECT title FROM books ORDER BY id LIMIT 4;
--   Page 2 (rows 5–8):   SELECT title FROM books ORDER BY id LIMIT 4 OFFSET 4;
--   Page 3 (rows 9–12):  SELECT title FROM books ORDER BY id LIMIT 4 OFFSET 8;
--   → LIMIT = page size, OFFSET = (page - 1) * size. Run all three, see the pages.

SELECT title FROM books ORDER BY id LIMIT 4;

ladder_notes=# SELECT title FROM books ORDER BY id LIMIT 4;
       title
-------------------
 The Hobbit
 A Game of Thrones
 Dune
 Foundation
(4 rows)


ladder_notes=#
SELECT title FROM books ORDER BY id LIMIT 4 OFFSET 4;
ladder_notes=# SELECT title FROM books ORDER BY id LIMIT 4 OFFSET 4;
          title
--------------------------
 Neuromancer
 Clean Code
 The Pragmatic Programmer
 Sapiens
(4 rows)


ladder_notes=#
SELECT title FROM books ORDER BY id LIMIT 4 OFFSET 8;
ladder_notes=# SELECT title FROM books ORDER BY id LIMIT 4 OFFSET 8;
       title
--------------------
 Educated
 Atomic Habits
 The Silent Patient
 Project Hail Mary
(4 rows)


ladder_notes=#
-- WHAT TO NOTICE:
-- - LIMIT n = "give me at most n rows". Pair with ORDER BY for "top n" / "latest n".
-- - OFFSET n = "skip the first n". LIMIT + OFFSET = pagination (page 1, 2, 3...).
-- - Full clause order:  SELECT ... FROM ... WHERE ... ORDER BY ... LIMIT ... OFFSET ...
--   That's the complete shape of a read query. You now know every part of it.
