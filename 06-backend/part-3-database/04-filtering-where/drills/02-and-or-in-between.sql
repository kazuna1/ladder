-- MODULE 04 · DRILL 02 — AND / OR / NOT / IN / BETWEEN
-- Combine conditions to ask precise questions.
-- ---------------------------------------------------------------------------

-- TODO 1: AND — both conditions must be true.
--   scifi books that are cheaper than 15:
--   SELECT title, genre, price FROM books WHERE genre = 'scifi' AND price < 15;

SELECT title,genre,price FROM books WHERE genre = 'scifi' AND price <15;

ladder_notes=# SELECT title,genre,price FROM books WHERE genre = 'scifi' AND price <15;
    title    | genre | price
-------------+-------+-------
 Dune        | scifi | 14.00
 Foundation  | scifi |  9.99
 Neuromancer | scifi | 11.25
(3 rows)


ladder_notes=#
-- TODO 2: OR — either condition true.
--   books that are fantasy OR thriller:
--   SELECT title, genre FROM books WHERE genre = 'fantasy' OR genre = 'thriller';

SELECT title,genre FROM books WHERE genre = 'fantasy' OR genre = 'thriller';

ladder_notes=# SELECT title,genre FROM books WHERE genre = 'fantasy' OR genre = 'thriller';
       title        |  genre
--------------------+----------
 The Hobbit         | fantasy
 A Game of Thrones  | fantasy
 The Silent Patient | thriller
(3 rows)


ladder_notes=#
-- TODO 3: NOT — negate a condition.
--   books that are NOT in stock:
--   SELECT title FROM books WHERE NOT in_stock;
--   (in_stock is boolean, so `NOT in_stock` = "in_stock is false")

SELECT title FROM books WHERE NOT in_stock;

ladder_notes=# SELECT title FROM books WHERE NOT in_stock;
          title
--------------------------
 Dune
 The Pragmatic Programmer
 The Silent Patient
(3 rows)


ladder_notes=#
-- TODO 4: IN — match ANY value in a list (cleaner than lots of ORs).
--   books in scifi, fantasy, or tech:
--   SELECT title, genre FROM books WHERE genre IN ('scifi', 'fantasy', 'tech');
--   (this replaces:  genre = 'scifi' OR genre = 'fantasy' OR genre = 'tech')

SELECT title,genre FROM books WHERE genre IN ('scifi', 'fantasy', 'tech');

ladder_notes=# SELECT title,genre FROM books WHERE genre IN ('scifi', 'fantasy', 'tech');
          title           |  genre
--------------------------+---------
 The Hobbit               | fantasy
 A Game of Thrones        | fantasy
 Dune                     | scifi
 Foundation               | scifi
 Neuromancer              | scifi
 Clean Code               | tech
 The Pragmatic Programmer | tech
 Project Hail Mary        | scifi
(8 rows)


ladder_notes=#

-- TODO 5: BETWEEN — a range (inclusive of both ends).
--   books priced between 10 and 20:
--   SELECT title, price FROM books WHERE price BETWEEN 10 AND 20;

SELECT title,price FROM books WHERE price BETWEEN 10 AND 20;

-- TODO 6: combine several. Longer books (>300 pages) that are scifi OR fantasy:
--   SELECT title, genre, pages FROM books
--   WHERE pages > 300 AND genre IN ('scifi', 'fantasy');

SELECT title,genre,pages FROM books WHERE pages > 300 AND genre IN ('scifi', 'fantasy');

ladder_notes=# SELECT title,genre,pages FROM books WHERE pages > 300 AND genre IN ('scifi', 'fantasy');
       title       |  genre  | pages
-------------------+---------+-------
 The Hobbit        | fantasy |   310
 A Game of Thrones | fantasy |   694
 Dune              | scifi   |   412
 Project Hail Mary | scifi   |   476
(4 rows)


ladder_notes=#
-- WHAT TO NOTICE:
-- - AND = all must be true. OR = at least one. NOT = flip it.
-- - IN (...) is shorthand for many ORs on the same column — much cleaner.
-- - BETWEEN a AND b includes both a and b. Great for price/date/number ranges.
-- - You can stack these to ask very specific questions — exactly what a real
--   "search with filters" endpoint does.
