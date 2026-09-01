-- MODULE 07 · DRILL 02 — CRUD Capstone (the boss, no syntax hints)
-- Run a complete lifecycle on a fresh table. You know all of this now — do it from
-- memory. This mirrors exactly what your Notes API does, but in raw SQL.
-- ---------------------------------------------------------------------------

-- 1. CREATE the table: "tasks" with
--      id (auto pk), title (required text), done (boolean, default false),
--      priority (integer, default 3)

CREATE TABLE tasks (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title TEXT NOT NULL,
    done BOOLEAN DEFAULT FALSE,
    priority INT DEFAULT 3
);

-- 2. INSERT 5 tasks (varied titles, some done=true, different priorities),
--    the last one RETURNING * so you see its row.

INSERT INTO tasks (title, done, priority) VALUES
  ('Write report',  false, 1),
  ('Reply emails',  true,  3),
  ('Buy groceries', false, 3),
  ('Call dentist',  true,  2),
  ('Last task',     false, 2) RETURNING *;

-- 3. READ: select all tasks, ordered by priority (1 = highest first).

SELECT * FROM tasks ORDER BY priority ASC;

-- 4. READ filtered: select only the tasks that are NOT done.

SELECT * FROM tasks WHERE done = false;



-- 5. UPDATE: mark task id=1 as done (done = true), RETURNING *.

UPDATE tasks SET done = true WHERE id = 1 RETURNING *;

-- 6. UPDATE many: bump every priority-3 task up to priority 2.

UPDATE tasks set priority = 2 WHERE priority = 3;
-- 7. DELETE: remove all tasks that are done, RETURNING *.

DELETE FROM tasks WHERE done = true RETURNING *;
-- 8. READ: select all remaining tasks to confirm the final state.

SELECT * FROM tasks;
-- 9. CLEAN UP:  DROP TABLE tasks;

DROP TABLE tasks;
-- DONE = you built a table and ran full Create → Read (filter + sort) → Update →
-- Delete against a real database, from memory. Every step maps to a controller in
-- your Notes API. Next up (Step 3 of Part 3): wire this to Node with the `pg` driver.
