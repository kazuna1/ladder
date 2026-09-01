-- MODULE 06 · DRILL 02 — UPDATE with Expressions
-- SET can use the column's CURRENT value to compute the new one.
-- ---------------------------------------------------------------------------

-- TODO 1: give every book a 10% price increase (price becomes price * 1.1):
--   UPDATE books SET price = price * 1.1;
--   → each row's new price is based on ITS OWN old price. (Here we DO want all rows,
--     so no WHERE is intentional — a rare case. Usually you want WHERE.)
--   Check:  SELECT title, price FROM books ORDER BY price;
--   (prices may now have extra decimals — that's fine for practice.)

UPDATE books SET price = price *1.1;
-- TODO 2: discount only expensive books — 20% off books over 30:
--   UPDATE books SET price = price * 0.8 WHERE price > 30 RETURNING title, price;

UPDATE books SET price = price*0.8 WHERE price >30 RETURNING title,price;
-- TODO 3: add 50 pages to every fantasy book:
--   UPDATE books SET pages = pages + 50 WHERE genre = 'fantasy' RETURNING title, pages;

UPDATE books SET pages = pages +50 WHERE genre = 'fantasy' RETURNING title,pages;
-- TODO 4 (reset if you like): re-seed to clean numbers by re-running
--   Module 02 · drill 03 (DROP + CREATE + INSERT). Good habit: reset when practice
--   data gets messy.


-- WHAT TO NOTICE:
-- - SET price = price * 1.1 reads the old value and writes the new one, per row. The
--   right side can be any expression using the row's columns.
-- - "10% off items over $30" is one line of SQL. In your array code that was a loop +
--   condition + reassign. SQL does the loop for you.
-- - Still: WHERE controls which rows. Expression controls the new value.
ladder_notes=# UPDATE books SET price = price *1.1;
UPDATE 12
ladder_notes=# UPDATE books SET price = price*0.8 WHERE price >30 RETURNING title,price;
          title           | price
--------------------------+-------
 Clean Code               | 29.91
 The Pragmatic Programmer | 35.19
(2 rows)


UPDATE 2
ladder_notes=# UPDATE books SET pages = pages +50 WHERE genre = 'fantasy' RETURNING title,pages;
       title       | pages
-------------------+-------
 A Game of Thrones |   744
 The Hobbit        |   360
(2 rows)


UPDATE 2