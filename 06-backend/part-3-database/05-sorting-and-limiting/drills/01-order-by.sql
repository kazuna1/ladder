-- MODULE 05 · DRILL 01 — ORDER BY (sorting)
-- ---------------------------------------------------------------------------

-- TODO 1: all books sorted by title A→Z
--   SELECT title FROM books ORDER BY title;
--   (default sort is ASC = ascending: A→Z, small→big, old→new)

SELECT title FROM books ORDER BY title;

ladder_notes=# SELECT title FROM books ORDER BY title;
          title
--------------------------
 A Game of Thrones
 Atomic Habits
 Clean Code
 Dune
 Educated
 Foundation
 Neuromancer
 Project Hail Mary
 Sapiens
 The Hobbit
 The Pragmatic Programmer
 The Silent Patient
(12 rows)


ladder_notes=#
-- TODO 2: books sorted by price, cheapest first
--   SELECT title, price FROM books ORDER BY price;

SELECT title,price FROM books ORDER BY price;

ladder_notes=# SELECT title,price FROM books ORDER BY price;
          title           | price
--------------------------+-------
 Foundation               |  9.99
 Neuromancer              | 11.25
 The Hobbit               | 12.99
 The Silent Patient       | 13.99
 Dune                     | 14.00
 A Game of Thrones        | 15.50
 Educated                 | 16.50
 Project Hail Mary        | 17.99
 Sapiens                  | 18.00
 Atomic Habits            | 21.00
 Clean Code               | 33.99
 The Pragmatic Programmer | 39.99
(12 rows)


ladder_notes=#

-- TODO 3: books sorted by price, MOST EXPENSIVE first (DESC = descending)
--   SELECT title, price FROM books ORDER BY price DESC;

SELECT title,price FROM books ORDER BY price DESC;

ladder_notes=# SELECT title,price FROM books ORDER BY price DESC;
          title           | price
--------------------------+-------
 The Pragmatic Programmer | 39.99
 Clean Code               | 33.99
 Atomic Habits            | 21.00
 Sapiens                  | 18.00
 Project Hail Mary        | 17.99
 Educated                 | 16.50
 A Game of Thrones        | 15.50
 Dune                     | 14.00
 The Silent Patient       | 13.99
 The Hobbit               | 12.99
 Neuromancer              | 11.25
 Foundation               |  9.99
(12 rows)


ladder_notes=#

-- TODO 4: newest books first (highest published year first)
--   SELECT title, published FROM books ORDER BY published DESC;

SELECT title,published FROM books ORDER BY published DESC;

ladder_notes=# SELECT title,published FROM books ORDER BY published DESC;
          title           | published
--------------------------+-----------
 Project Hail Mary        |      2021
 The Silent Patient       |      2019
 Atomic Habits            |      2018
 Educated                 |      2018
 Sapiens                  |      2011
 Clean Code               |      2008
 The Pragmatic Programmer |      1999
 A Game of Thrones        |      1996
 Neuromancer              |      1984
 Dune                     |      1965
 Foundation               |      1951
 The Hobbit               |      1937
(12 rows)


ladder_notes=#
-- TODO 5: sort by TWO columns — genre A→Z, then within each genre, price high→low:
--   SELECT genre, title, price FROM books ORDER BY genre ASC, price DESC;
--   (first key groups; second key breaks ties within each group)

SELECT genre,title,price FROM books ORDER BY genre ASC, price DESC;

ladder_notes=# SELECT genre,title,price FROM books ORDER BY genre ASC, price DESC;
  genre   |          title           | price
----------+--------------------------+-------
 fantasy  | A Game of Thrones        | 15.50
 fantasy  | The Hobbit               | 12.99
 history  | Sapiens                  | 18.00
 memoir   | Educated                 | 16.50
 scifi    | Project Hail Mary        | 17.99
 scifi    | Dune                     | 14.00
 scifi    | Neuromancer              | 11.25
 scifi    | Foundation               |  9.99
 selfhelp | Atomic Habits            | 21.00
 tech     | The Pragmatic Programmer | 39.99
 tech     | Clean Code               | 33.99
 thriller | The Silent Patient       | 13.99
(12 rows)


ladder_notes=#

-- TODO 6: combine with WHERE — scifi books, cheapest first:
--   SELECT title, price FROM books WHERE genre = 'scifi' ORDER BY price;
--   (clause order:  SELECT ... FROM ... WHERE ... ORDER BY ...  — WHERE filters, THEN sort)

SELECT title,price FROM books WHERE genre = 'scifi' ORDER BY price;
ladder_notes=# SELECT title,price FROM books WHERE genre = 'scifi' ORDER BY price;
       title       | price
-------------------+-------
 Foundation        |  9.99
 Neuromancer       | 11.25
 Dune              | 14.00
 Project Hail Mary | 17.99
(4 rows)


ladder_notes=#
-- WHAT TO NOTICE:
-- - ORDER BY sorts the result. ASC (default) = up, DESC = down.
-- - Multiple sort keys: the first groups, later ones break ties.
-- - WHERE runs BEFORE ORDER BY: filter down to the rows you want, then sort them.
