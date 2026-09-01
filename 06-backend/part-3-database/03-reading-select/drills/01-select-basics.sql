-- MODULE 03 · DRILL 01 — SELECT Basics (= GET)
-- Ask the books table for data.
-- ---------------------------------------------------------------------------

-- TODO 1: select EVERYTHING (all columns, all rows)
--   SELECT * FROM books;
--   (* = all columns. This is your GET /books returning the whole list.)

SELECT * FROM books;

ladder_notes=# SELECT * FROM books;
 id |          title           |   author    |  genre   | pages | price | published | in_stock
----+--------------------------+-------------+----------+-------+-------+-----------+----------
  1 | The Hobbit               | Tolkien     | fantasy  |   310 | 12.99 |      1937 | t
  2 | A Game of Thrones        | Martin      | fantasy  |   694 | 15.50 |      1996 | t
  3 | Dune                     | Herbert     | scifi    |   412 | 14.00 |      1965 | f
  4 | Foundation               | Asimov      | scifi    |   244 |  9.99 |      1951 | t
  5 | Neuromancer              | Gibson      | scifi    |   271 | 11.25 |      1984 | t
  6 | Clean Code               | Martin      | tech     |   464 | 33.99 |      2008 | t
  7 | The Pragmatic Programmer | Hunt        | tech     |   352 | 39.99 |      1999 | f
  8 | Sapiens                  | Harari      | history  |   443 | 18.00 |      2011 | t
  9 | Educated                 | Westover    | memoir   |   334 | 16.50 |      2018 | t
 10 | Atomic Habits            | Clear       | selfhelp |   320 | 21.00 |      2018 | t
 11 | The Silent Patient       | Michaelides | thriller |   336 | 13.99 |      2019 | f
 12 | Project Hail Mary        | Weir        | scifi    |   476 | 17.99 |      2021 | t
(12 rows)
-- TODO 2: select only the title and author columns
--   SELECT title, author FROM books;
--   (pick exactly the fields you want back — often you don't need every column)

SELECT title, author FROM books;

ladder_notes=# SELECT title, author FROM books;
          title           |   author
--------------------------+-------------
 The Hobbit               | Tolkien
 A Game of Thrones        | Martin
 Dune                     | Herbert
 Foundation               | Asimov
 Neuromancer              | Gibson
 Clean Code               | Martin
 The Pragmatic Programmer | Hunt
 Sapiens                  | Harari
 Educated                 | Westover
 Atomic Habits            | Clear
 The Silent Patient       | Michaelides
 Project Hail Mary        | Weir
(12 rows)


ladder_notes=#

-- TODO 3: select only title, price, and pages

SELECT title,price,pages FROM books;

ladder_notes=# SELECT title,price,pages FROM books;
          title           | price | pages
--------------------------+-------+-------
 The Hobbit               | 12.99 |   310
 A Game of Thrones        | 15.50 |   694
 Dune                     | 14.00 |   412
 Foundation               |  9.99 |   244
 Neuromancer              | 11.25 |   271
 Clean Code               | 33.99 |   464
 The Pragmatic Programmer | 39.99 |   352
 Sapiens                  | 18.00 |   443
 Educated                 | 16.50 |   334
 Atomic Habits            | 21.00 |   320
 The Silent Patient       | 13.99 |   336
 Project Hail Mary        | 17.99 |   476
(12 rows)


ladder_notes=#
-- TODO 4: aliases — rename a column in the OUTPUT using AS
--   SELECT title AS book_name, price AS cost FROM books;
--   → the result's headers now say "book_name" and "cost" instead of title/price.
--   (Handy for cleaner output or renaming computed columns — see next drill.)

SELECT title AS book_name, price AS cost FROM books;

ladder_notes=# SELECT title AS book_name, price AS cost FROM books;
        book_name         | cost
--------------------------+-------
 The Hobbit               | 12.99
 A Game of Thrones        | 15.50
 Dune                     | 14.00
 Foundation               |  9.99
 Neuromancer              | 11.25
 Clean Code               | 33.99
 The Pragmatic Programmer | 39.99
 Sapiens                  | 18.00
 Educated                 | 16.50
 Atomic Habits            | 21.00
 The Silent Patient       | 13.99
 Project Hail Mary        | 17.99
(12 rows)


ladder_notes=#
-- WHAT TO NOTICE:
-- - `*` grabs all columns; listing columns picks specific ones (like choosing which
--   fields to send back in an API response).
-- - AS only changes the LABEL in the result — it doesn't rename the actual column in
--   the table. It's cosmetic, for the output.
-- - No WHERE yet = ALL rows come back. Module 04 adds "which rows".
