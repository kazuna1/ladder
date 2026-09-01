-- MODULE 02 · DRILL 01 — INSERT Basics (= POST / push)
-- Add rows to your notes table.
-- ---------------------------------------------------------------------------

-- TODO 1: insert ONE note (title 'Buy milk', body '2 liters')
--   shape:  INSERT INTO notes (title, body) VALUES ('Buy milk', '2 liters');
--   ⚠️ strings use SINGLE quotes. Don't provide id — the DB auto-fills it.

INSERT INTO notes (title,body) VALUES (
    'Buy milk', '2 liters'
);
-- TODO 2: check it landed:  SELECT * FROM notes;
--   Notice the id is filled in (1) even though you never typed it.
ladder_notes=# select * from notes
ladder_notes-# ;
 id |  title   |   body
----+----------+----------
  1 | Buy milk | 2 liters
(1 row)



-- TODO 3: insert MULTIPLE notes in one statement (rows separated by commas):
--   INSERT INTO notes (title, body) VALUES
--     ('Call mom', 'birthday'),
--     ('Ship code', 'push to main'),
--     ('Water plants', '');

INSERT INTO notes (title,body) VALUES 
('Call mom', 'birthday'),
('Ship code', 'push to main'),
('Water plants', '');
-- TODO 4: insert one more, but add RETURNING * so the DB hands the new row BACK
--   (this is your res.json(newNote) — get the created row, id and all):
--   INSERT INTO notes (title, body) VALUES ('Read book', 'chapter 3') RETURNING *;

INSERT INTO notes (title, body) VALUES ('Read book', 'chapter 3') RETURNING *;
-- CHECK:  SELECT * FROM notes;  → all your notes, each with an auto-incrementing id.
ladder_notes=# INSERT INTO notes (title, body) VALUES ('Read book', 'chapter 3') RETURNING *;
 id |   title   |   body
----+-----------+-----------
  5 | Read book | chapter 3
(1 row)


INSERT 0 1
ladder_notes=#

ladder_notes=# select * from notes
ladder_notes-# ;
 id |    title     |     body
----+--------------+--------------
  1 | Buy milk     | 2 liters
  2 | Call mom     | birthday
  3 | Ship code    | push to main
  4 | Water plants |
  5 | Read book    | chapter 3
(5 rows)


ladder_notes=#
-- WHAT TO NOTICE:
-- - You list the columns you're filling, then VALUES in the same order.
-- - Multiple rows = comma-separated tuples, one INSERT. Fewer round-trips.
-- - RETURNING * = "and give me back what you just made" — no separate SELECT needed.
