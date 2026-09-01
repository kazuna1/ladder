# Phase 6 — Part 3: Database (PostgreSQL)

Your data currently dies on restart (`let notes = []` in RAM). This part fixes that:
a real **PostgreSQL** database. Raw SQL, no ORM, no Supabase — the fundamental.

SQL is big and new, so we climb it **slowly**, in small steps, with lots of reps.
Each module below is a focused sub-topic with its own drills. Do them **in order** —
each builds on the last.

## Read first (concept → setup → syntax)

1. **[what-is-a-database.md](./what-is-a-database.md)** — what a database is, why it exists.
2. **[installing-postgresql.md](./installing-postgresql.md)** — the setup, deeply.
3. **[sql-cheatsheet.md](./sql-cheatsheet.md)** — the global SQL reference (keep it open).

## The learning path (slow, progressive)

```
FUNDAMENTALS (all of CRUD, in tiny steps)
  01 · creating-tables      CREATE TABLE, data types, constraints        (the shape)
  02 · inserting-data       INSERT, multiple rows, RETURNING, defaults   (Create)
  03 · reading-select       SELECT columns, aliases, DISTINCT            (Read)
  04 · filtering-where      WHERE, comparisons, AND/OR, LIKE, IN, NULL   (Read, precise)
  05 · sorting-and-limiting ORDER BY, LIMIT, OFFSET (pagination)         (Read, shaped)
  06 · updating             UPDATE, SET, expressions                     (Update)
  07 · deleting             DELETE, TRUNCATE, the WHERE-or-disaster rule (Delete)

MID-LEVEL (prepared when you finish the fundamentals)
  08 · mid-level            aggregations (COUNT/SUM/GROUP BY), JOINs, relationships
```

**Modules 01–07 are built and ready.** Module 08 (mid-level) I'll flesh out with drills
when you reach it — no point overwhelming you now.

## How each module works

Each `NN-topic/` folder has:
- a **`README.md`** — what the module teaches + the order of its drills
- a **`drills/`** folder — small `.sql` files, each with several exercises (TODOs)

**Run drills** by typing/pasting the SQL at your `ladder_notes=#` prompt (recommended
while learning — you see each result), or `\i path/to/file.sql` to run a whole file.

Say **"review"** after a drill (or a batch) and I'll check your SQL + explain.

## The one anchor idea

You already know CRUD — you built it over HTTP for weeks. **SQL is those same four
operations, one layer down:**

```
Create → INSERT · Read → SELECT · Update → UPDATE · Delete → DELETE
```

New syntax, concepts you already own. Start with **[01-creating-tables](./01-creating-tables/)**. 🚀
