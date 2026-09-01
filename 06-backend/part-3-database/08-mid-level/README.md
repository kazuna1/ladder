# Module 08 — Mid-Level (roadmap — built when you get here)

Once Modules 01–07 feel comfortable (all of single-table CRUD), this is where SQL
gets *powerful*. I'll flesh these out into full drills when you finish the
fundamentals — listing them now so you can see the road ahead.

## What's coming

### 08a — Aggregations (summarizing data)
Answer questions ABOUT the whole set, not row-by-row:
- `COUNT(*)` — how many rows?
- `SUM`, `AVG`, `MIN`, `MAX` — totals, averages, extremes
- `GROUP BY` — per-group summaries ("average price *per genre*")
- `HAVING` — filter groups ("genres with more than 2 books")

### 08b — Relationships & Foreign Keys (the "relational" in relational DB)
The whole reason it's called a *relational* database:
- splitting data across tables (e.g. `authors` and `books`)
- `REFERENCES` — a foreign key linking one table to another
- why you don't repeat data (normalization, in plain words)

### 08c — JOINs (combining tables)
Read from multiple related tables at once:
- `INNER JOIN` — rows that match in both tables
- `LEFT JOIN` — all of one side + matches from the other
- joining `books` to `authors` to show author details per book

### 08d — Handy extras
- `NULL` handling (`COALESCE`)
- `CASE` (SQL's if/else)
- subqueries (a query inside a query)

## Then: back to Node

After mid-level SQL, we return to your Notes API:
- `npm install pg` (the Postgres driver)
- port your controllers to real SQL (they become `async`)
- parameterized queries (`$1`) — the SQL-injection safety rule

**For now:** finish Modules 01–07. When the capstone (07 · drill 02) feels easy, say
so and I'll build out 08a → 08d as full drills. 🚀
