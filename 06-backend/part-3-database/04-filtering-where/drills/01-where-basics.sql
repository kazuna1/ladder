-- MODULE 04 · DRILL 01 — WHERE Basics (= .find / .filter)
-- Pick WHICH rows. Exact match and comparisons.
-- ---------------------------------------------------------------------------

-- TODO 1: the one book with id = 1  (this is GET /books/:id)
--   SELECT * FROM books WHERE id = 1;

SELECT * FROM books WHERE id=1;

ladder_notes=# SELECT * FROM books WHERE id=1;
 id |   title    | author  |  genre  | pages | price | published | in_stock
----+------------+---------+---------+-------+-------+-----------+----------
  1 | The Hobbit | Tolkien | fantasy |   310 | 12.99 |      1937 | t
(1 row)


ladder_notes=#
-- TODO 2: all books in the 'scifi' genre  (string → single quotes!)
--   SELECT * FROM books WHERE genre = 'scifi';

SELECT * FROM books WHERE genre = 'scifi';

ladder_notes=# SELECT * FROM books WHERE genre = 'scifi';
 id |       title       | author  | genre | pages | price | published | in_stock
----+-------------------+---------+-------+-------+-------+-----------+----------
  3 | Dune              | Herbert | scifi |   412 | 14.00 |      1965 | f
  4 | Foundation        | Asimov  | scifi |   244 |  9.99 |      1951 | t
  5 | Neuromancer       | Gibson  | scifi |   271 | 11.25 |      1984 | t
 12 | Project Hail Mary | Weir    | scifi |   476 | 17.99 |      2021 | t
(4 rows)


ladder_notes=#

-- TODO 3: comparison operators. Try each:
--   SELECT title, pages FROM books WHERE pages > 400;      -- more than 400 pages
--   SELECT title, price FROM books WHERE price <= 15;      -- 15 or cheaper
--   SELECT title, published FROM books WHERE published >= 2000;  -- year 2000 or later

SELECT title,pages FROM books WHERE pages>400;

ladder_notes=# SELECT title,pages FROM books WHERE pages>400;
       title       | pages
-------------------+-------
 A Game of Thrones |   694
 Dune              |   412
 Clean Code        |   464
 Sapiens           |   443
 Project Hail Mary |   476
(5 rows)


ladder_notes=#

SELECT title, price FROM books WHERE price <= 15;

ladder_notes=# SELECT title, price FROM books WHERE price <= 15;
       title        | price
--------------------+-------
 The Hobbit         | 12.99
 Dune               | 14.00
 Foundation         |  9.99
 Neuromancer        | 11.25
 The Silent Patient | 13.99
(5 rows)


ladder_notes=#

SELECT title, published FROM books WHERE published >= 2000;

ladder_notes=# SELECT title, published FROM books WHERE published >= 2000;
       title        | published
--------------------+-----------
 Clean Code         |      2008
 Sapiens            |      2011
 Educated           |      2018
 Atomic Habits      |      2018
 The Silent Patient |      2019
 Project Hail Mary  |      2021
(6 rows)


ladder_notes=#


-- TODO 4: "not equal" — everything EXCEPT tech books
--   SELECT title, genre FROM books WHERE genre <> 'tech';
--   (<> means "not equal". Some databases also allow != — <> is the standard.)

SELECT title,genre FROM books WHERE genre <> 'tech';

ladder_notes=# SELECT title,genre FROM books WHERE genre <> 'tech';
       title        |  genre
--------------------+----------
 The Hobbit         | fantasy
 A Game of Thrones  | fantasy
 Dune               | scifi
 Foundation         | scifi
 Neuromancer        | scifi
 Sapiens            | history
 Educated           | memoir
 Atomic Habits      | selfhelp
 The Silent Patient | thriller
 Project Hail Mary  | scifi
(10 rows)


ladder_notes=#
-- TODO 5: boolean column — books that are out of stock
--   SELECT title FROM books WHERE in_stock = false;

SELECT title FROM books WHERE in_stock = false;

ladder_notes=# SELECT title FROM books WHERE in_stock = false;
          title
--------------------------
 Dune
 The Pragmatic Programmer
 The Silent Patient
(3 rows)


ladder_notes=#
-- WHAT TO NOTICE:
-- - WHERE is the filter that decides which rows come back. = for exact, >/</>=/<= for
--   ranges, <> for "not". Strings need single quotes; numbers/booleans don't.
-- - This is the SAME idea as notes.find(n => n.id === id) — just SQL syntax.
-- - No WHERE = every row. WHERE narrows it. Next: combine multiple conditions.
