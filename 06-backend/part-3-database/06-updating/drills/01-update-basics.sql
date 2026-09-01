-- MODULE 06 · DRILL 01 — UPDATE Basics (= PUT)
-- Change existing rows. WHERE decides which ones.
-- ---------------------------------------------------------------------------

-- TODO 1: change the price of book id=1 to 10.99
--   UPDATE books SET price = 10.99 WHERE id = 1;
--   (SET = which column to change, WHERE = which row. This is note.title = title.)
--   Check:  SELECT title, price FROM books WHERE id = 1;

UPDATE books SET price = 10.99 WHERE id = 1;
-- TODO 2: change TWO columns at once (comma-separated) for book id=3:
--   UPDATE books SET price = 12.50, in_stock = true WHERE id = 3;

UPDATE books SET price = 12.50, in_stock = true WHERE id = 3;

-- TODO 3: RETURNING * — see the row you just changed:
--   UPDATE books SET price = 8.99 WHERE id = 4 RETURNING *;
--   (this is your res.json(updatedRow) — get the result back)

UPDATE books SET price = 8.99 WHERE id = 4 RETURNING*;
-- TODO 4: update MANY rows with one condition — mark all 'tech' books out of stock:
--   UPDATE books SET in_stock = false WHERE genre = 'tech';
--   → WHERE genre='tech' matches multiple rows; ALL of them get updated. That's fine
--     and intentional. WHERE controls how many.

UPDATE books SET in_stock = false WHERE genre = 'tech';
-- 🚨 TODO 5 (understand the danger — do NOT actually run without WHERE):
--   UPDATE books SET price = 0;      -- NO WHERE = sets EVERY book's price to 0!
--   The WHERE is the ONLY thing limiting the change. Forget it, and you hit every row.

UPDATE books SET price = 0;

-- WHAT TO NOTICE:
-- - SET changes columns; WHERE picks rows. One row or many — WHERE decides.
-- - Missing WHERE = you change the WHOLE table. This is the #1 SQL accident. Always
--   write the WHERE first, THEN the SET, as a habit.
ladder_notes=# UPDATE books SET price = 10.99 WHERE id = 1;
UPDATE 1
ladder_notes=# UPDATE books SET price = 12.50, in_stock = true WHERE id = 3;
UPDATE 1
ladder_notes=# UPDATE books SET price = 8.99 WHERE id = 4 RETURNING*;
 id |   title    | author | genre | pages | price | published | in_stock
----+------------+--------+-------+-------+-------+-----------+----------
  4 | Foundation | Asimov | scifi |   244 |  8.99 |      1951 | t
(1 row)


UPDATE 1
ladder_notes=# UPDATE books SET in_stock = false WHERE genre = 'tech';
UPDATE 2
ladder_notes=#