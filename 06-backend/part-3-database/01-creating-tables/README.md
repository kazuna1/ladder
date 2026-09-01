# Module 01 — Creating Tables

**The shape of your data.** Before you can store anything, you define a **table**: its
name, its **columns**, each column's **type**, and the **constraints** (rules) on them.

## What you'll learn

- `CREATE TABLE` — define a table
- **Data types** — what a column can hold (`INTEGER`, `TEXT`, `BOOLEAN`, `NUMERIC`, `DATE`...)
- **Constraints** — rules on a column (`NOT NULL`, `DEFAULT`, `UNIQUE`, `PRIMARY KEY`, auto-id)
- **Managing tables** — `DROP TABLE`, recreating, inspecting with `\d`

## The anatomy of a column (keep this in your head)

```
   column_name    data_type    [constraints...]
   ─────────────  ───────────  ────────────────────────
   title          TEXT         NOT NULL
   │              │            │
   name (pick)    type (one,   constraints (zero to many, stacked)
                  required)
```

## Drills (in order)

- **01-first-table** — your very first table, basic columns, inspect it
- **02-data-types** — a tour of the common column types
- **03-constraints** — NOT NULL, DEFAULT, UNIQUE, PRIMARY KEY, auto-id
- **04-notes-table** — build THE `notes` table (combines everything) + DROP/recreate

## How to run
Type or paste each statement at your `ladder_notes=#` prompt. After creating a table:
- `\dt` — list your tables
- `\d tablename` — see its columns + types + constraints

Say **"review"** after a drill and paste what `\d tablename` shows. Start with 01.
