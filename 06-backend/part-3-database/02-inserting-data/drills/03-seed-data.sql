-- MODULE 02 · DRILL 03 — Seed a Practice Table
-- The reading modules (03–07) need a table with LOTS of varied rows to filter,
-- sort, and search. Build a "books" table and fill it. Keep this table around.
-- ---------------------------------------------------------------------------

-- TODO 1: create the books table (reset-safe):
--   DROP TABLE IF EXISTS books;
--   CREATE TABLE books (
--     id         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--     title      TEXT NOT NULL,
--     author     TEXT NOT NULL,
--     genre      TEXT,
--     pages      INTEGER,
--     price      NUMERIC(6,2),
--     published  INTEGER,          -- year, e.g. 1997
--     in_stock   BOOLEAN DEFAULT true
--   );

DROP TABLE IF EXISTS books;
 CREATE TABLE books (
     id         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     title      TEXT NOT NULL,
     author     TEXT NOT NULL,
     genre      TEXT,
     pages      INTEGER,
     price      NUMERIC(6,2),
     published  INTEGER,       
     in_stock   BOOLEAN DEFAULT true
   );


-- TODO 2: insert these rows (copy this whole block and run it):
--   INSERT INTO books (title, author, genre, pages, price, published, in_stock) VALUES
--     ('The Hobbit',          'Tolkien',    'fantasy', 310, 12.99, 1937, true),
--     ('A Game of Thrones',   'Martin',     'fantasy', 694, 15.50, 1996, true),
--     ('Dune',                'Herbert',    'scifi',   412, 14.00, 1965, false),
--     ('Foundation',          'Asimov',     'scifi',   244,  9.99, 1951, true),
--     ('Neuromancer',         'Gibson',     'scifi',   271, 11.25, 1984, true),
--     ('Clean Code',          'Martin',     'tech',    464, 33.99, 2008, true),
--     ('The Pragmatic Programmer','Hunt',   'tech',    352, 39.99, 1999, false),
--     ('Sapiens',             'Harari',     'history', 443, 18.00, 2011, true),
--     ('Educated',            'Westover',   'memoir',  334, 16.50, 2018, true),
--     ('Atomic Habits',       'Clear',      'selfhelp',320, 21.00, 2018, true),
--     ('The Silent Patient',  'Michaelides','thriller',336, 13.99, 2019, false),
--     ('Project Hail Mary',   'Weir',       'scifi',   476, 17.99, 2021, true);

   INSERT INTO books (title, author, genre, pages, price, published, in_stock) VALUES
     ('The Hobbit',          'Tolkien',    'fantasy', 310, 12.99, 1937, true),
     ('A Game of Thrones',   'Martin',     'fantasy', 694, 15.50, 1996, true),
     ('Dune',                'Herbert',    'scifi',   412, 14.00, 1965, false),
     ('Foundation',          'Asimov',     'scifi',   244,  9.99, 1951, true),
     ('Neuromancer',         'Gibson',     'scifi',   271, 11.25, 1984, true),
     ('Clean Code',          'Martin',     'tech',    464, 33.99, 2008, true),
     ('The Pragmatic Programmer','Hunt',   'tech',    352, 39.99, 1999, false),
     ('Sapiens',             'Harari',     'history', 443, 18.00, 2011, true),
     ('Educated',            'Westover',   'memoir',  334, 16.50, 2018, true),
     ('Atomic Habits',       'Clear',      'selfhelp',320, 21.00, 2018, true),
     ('The Silent Patient',  'Michaelides','thriller',336, 13.99, 2019, false),
     ('Project Hail Mary',   'Weir',       'scifi',   476, 17.99, 2021, true);
-- TODO 3: confirm they're all in:
--   SELECT * FROM books;
--   SELECT COUNT(*) FROM books;      -- should be 12 (COUNT is a teaser for mid-level)

ladder_notes=# select * from books
ladder_notes-# ;
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


ladder_notes=#
-- WHAT TO NOTICE:
-- - 12 rows, varied: different genres, prices, page counts, years, in/out of stock.
--   That variety is what makes the next modules' filtering & sorting interesting.
-- - KEEP this table. Modules 03–07 all read from and modify `books`.
-- - If you ever mess it up, just re-run TODO 1 + TODO 2 to reset it fresh.
