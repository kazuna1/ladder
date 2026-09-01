-- MODULE 07 · DRILL 01 — DELETE Basics (= DELETE / filter-out)
-- Remove rows. WHERE decides which. (Re-seed books first if it's messy.)
-- ---------------------------------------------------------------------------

-- TODO 1: delete the book with id = 12
--   DELETE FROM books WHERE id = 12;
--   Check:  SELECT * FROM books;  → id 12 is gone, the rest remain.

DELETE FROM books WHERE id=12;
-- TODO 2: RETURNING * — see what you removed
--   DELETE FROM books WHERE id = 11 RETURNING *;

DELETE FROM books WHERE id = 11 RETURNING *;


-- TODO 3: delete MANY rows with a condition — remove all out-of-stock books:
--   DELETE FROM books WHERE in_stock = false;
--   → every matching row is deleted. WHERE controls how many, same as UPDATE.

DELETE FROM books WHERE in_stock = false;
-- TODO 4: TRUNCATE — empty an ENTIRE table instantly (all rows, keeps the table):
--   Make a throwaway table to test on (don't truncate books yet):
--     CREATE TABLE temp_test (id INT, name TEXT);
--     INSERT INTO temp_test VALUES (1, 'a'), (2, 'b');
--     TRUNCATE temp_test;          -- all rows gone, table still exists
--     SELECT * FROM temp_test;     -- empty
--     DROP TABLE temp_test;        -- clean up
--   → TRUNCATE = "empty the table" (fast, all rows). DELETE = "remove matching rows".
--     DROP = "destroy the table itself". Three different levels.

CREATE TABLE temp_test(id INT,name TEXT);
INSERT INTO temp_test VALUES (1, 'a'), (2, 'b');
TRUNCATE temp_test;

-- 🚨 TODO 5 (understand the danger — do NOT run without WHERE):
--   DELETE FROM books;      -- NO WHERE = deletes EVERY book. Empty table.
--   Like UPDATE, the WHERE is the only thing making it "just these rows".

DELETE FROM books;
-- WHAT TO NOTICE:
-- - DELETE ... WHERE = remove matching rows. RETURNING * shows what left.
-- - DELETE (some rows) vs TRUNCATE (all rows, fast) vs DROP (the whole table + shape).
-- - The golden rule for UPDATE and DELETE: WHERE first, always. No WHERE = whole table.

ladder_notes=# DELETE FROM books WHERE id=12;
DELETE 1
ladder_notes=#
ladder_notes=# DELETE FROM books WHERE id = 11 RETURNING *;
 id |       title        |   author    |  genre   | pages | price | published | in_stock
----+--------------------+-------------+----------+-------+-------+-----------+----------
 11 | The Silent Patient | Michaelides | thriller |   336 | 15.39 |      2019 | f
(1 row)


DELETE 1
ladder_notes=# DELETE FROM books WHERE in_stock = false;
DELETE 2
ladder_notes=# CREATE TABLE temp_test(id INT,name TEXT);
CREATE TABLE
ladder_notes=# INSERT INTO temp_test VALUES (1, 'a'), (2, 'b');
INSERT 0 2
ladder_notes=# TRUNCATE temp_test;
TRUNCATE TABLE
ladder_notes=# DELETE FROM books;
DELETE 8
ladder_notes=#