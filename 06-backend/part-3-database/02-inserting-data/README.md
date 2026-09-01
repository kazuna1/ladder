# Module 02 — Inserting Data (Create)

Now that tables exist, put **rows** in them. `INSERT` is the SQL for
`notes.push(newNote)` — the **C** in CRUD.

## What you'll learn

- `INSERT INTO ... VALUES ...` — add a row
- Insert **multiple rows** at once
- `RETURNING *` — get the new row back (with its auto-id)
- How **DEFAULT** and **auto-id** fill columns you don't provide
- Watching **constraints reject bad data** (NOT NULL, UNIQUE)
- **Seeding** — inserting many rows to practice reading on

## Drills (in order)

- **01-insert-basics** — one row, many rows, RETURNING
- **02-defaults-and-rules** — omit optional columns; watch the DB reject bad rows
- **03-seed-data** — load a practice table full of rows (for the reading modules)

## Prereq
You need the `notes` table from Module 01, drill 04. If you dropped it, recreate it.

Say **"review"** after a drill. Start with 01.
