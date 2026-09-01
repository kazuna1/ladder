-- MODULE 03 · DRILL 02 — Expressions & DISTINCT
-- SELECT can COMPUTE values, not just fetch stored ones. And DISTINCT removes dupes.
-- ---------------------------------------------------------------------------

-- TODO 1: compute a value in the SELECT — a 10% discount price:
--   SELECT title, price, price * 0.9 AS sale_price FROM books;
--   → "sale_price" is CALCULATED on the fly, not stored. AS names the computed column.

SELECT title,price,price*0.9 AS sale_price FROM books;

ladder_notes=# SELECT title,price,price*0.9 AS sale_price FROM books;
          title           | price | sale_price
--------------------------+-------+------------
 The Hobbit               | 12.99 |     11.691
 A Game of Thrones        | 15.50 |     13.950
 Dune                     | 14.00 |     12.600
 Foundation               |  9.99 |      8.991
 Neuromancer              | 11.25 |     10.125
 Clean Code               | 33.99 |     30.591
 The Pragmatic Programmer | 39.99 |     35.991
 Sapiens                  | 18.00 |     16.200
 Educated                 | 16.50 |     14.850
 Atomic Habits            | 21.00 |     18.900
 The Silent Patient       | 13.99 |     12.591
 Project Hail Mary        | 17.99 |     16.191
(12 rows)


ladder_notes=#
-- TODO 2: combine text (concatenation with ||):
--   SELECT title || ' by ' || author AS label FROM books;
--   → produces "The Hobbit by Tolkien" etc. (|| glues strings together)

SELECT title || ' by ' || author AS label FROM books;

ladder_notes=# SELECT title || 'by' || author AS label FROM books;
              label
---------------------------------
 The HobbitbyTolkien
 A Game of ThronesbyMartin
 DunebyHerbert
 FoundationbyAsimov
 NeuromancerbyGibson
 Clean CodebyMartin
 The Pragmatic ProgrammerbyHunt
 SapiensbyHarari
 EducatedbyWestover
 Atomic HabitsbyClear
 The Silent PatientbyMichaelides
 Project Hail MarybyWeir
(12 rows)


ladder_notes=#
-- TODO 3: DISTINCT — list each genre only ONCE (no duplicates):
--   SELECT DISTINCT genre FROM books;
--   → even though many books share a genre, you get each genre a single time.
--   (Compare:  SELECT genre FROM books;  → shows duplicates.)

SELECT DISTINCT genre FROM books;

ladder_notes=# SELECT DISTINCT genre FROM books;
  genre
----------
 fantasy
 memoir
 thriller
 tech
 history
 scifi
 selfhelp
(7 rows)


ladder_notes=#

-- TODO 4: how many DISTINCT authors are there? (a COUNT + DISTINCT teaser)
--   SELECT COUNT(DISTINCT author) FROM books;
--   (COUNT is aggregation — the mid-level module goes deep on this. Just a taste.)

SELECT COUNT(DISTINCT author) FROM books;

ladder_notes=# SELECT COUNT(DISTINCT author) FROM books;
 count
-------
    11
(1 row)


ladder_notes=#
-- WHAT TO NOTICE:
-- - SELECT isn't only "fetch columns" — it can transform: math (price * 0.9), text
--   (||), and more. The result is computed per row.
-- - DISTINCT = "unique values only". Great for "what genres exist?" type questions.
-- - Nothing here changes the stored data — SELECT only READS. Computed columns exist
--   only in the result you're looking at.
