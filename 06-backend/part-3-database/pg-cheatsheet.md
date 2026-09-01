# The `pg` Driver — Simple Cheatsheet

`pg` is the **bridge** between your Node/Express code and PostgreSQL. It lets your
controllers send SQL and get rows back. This is the one new tool for going full-stack.

## The setup: a connection Pool (do this once)

A **Pool** is a set of reusable connections to your database. You make it once and
share it everywhere.

```js
// db.js
import pg from "pg";
const { Pool } = pg;

export const pool = new Pool({
  host: "localhost",
  port: 5432,
  user: "postgres",
  password: process.env.PGPASSWORD,   // your postgres password (from env — see README)
  database: "ladder_notes",
});
```

Then any file can `import { pool } from "./db.js"` and run queries.

> **Why a "pool"?** Opening a fresh DB connection per request is slow. A pool keeps a
> few connections open and hands them out as needed. You don't manage this — just use
> `pool.query(...)`.

## Running a query

```js
const result = await pool.query("SELECT * FROM notes");
console.log(result.rows);   // ← the ROWS are in result.rows (an array of objects)
```

- `pool.query(...)` returns a **promise** → you `await` it (your Phase-4 skill).
- The result is an **object**; your data is in **`result.rows`** — an array of objects,
  exactly the shape React already knows how to render.

```js
result.rows        // array of row objects: [{id:1, title:"..."}, ...]
result.rows[0]     // the first row (use for "get one")
result.rowCount    // how many rows matched/changed
```

## ⚠️ THE most important rule: parameterized queries (`$1`)

**NEVER build SQL by gluing strings together.** This is a security hole called SQL
injection — a malicious value can rewrite your query and wipe your database.

```js
// ❌ NEVER DO THIS — string interpolation = SQL injection hole
await pool.query(`SELECT * FROM notes WHERE id = ${id}`);

// ✅ ALWAYS DO THIS — placeholders + a values array
await pool.query("SELECT * FROM notes WHERE id = $1", [id]);
```

- Write **`$1`, `$2`, `$3`** as placeholders in the SQL.
- Pass the real values as a **separate array**: `[id]`, `[title, body]`.
- `pg` sends them separately, so a value can NEVER become part of the SQL command. Safe.

```js
// two values → $1 and $2, array in the same order:
await pool.query(
  "INSERT INTO notes (title, body) VALUES ($1, $2) RETURNING *",
  [title, body]
);
```

**This is a day-one, non-negotiable rule.** `$1` placeholders, always.

## The CRUD patterns (your Notes API, in pg)

```js
// GET all
const result = await pool.query("SELECT * FROM notes ORDER BY id");
res.json(result.rows);

// GET one (result.rows[0], or 404 if none)
const result = await pool.query("SELECT * FROM notes WHERE id = $1", [id]);
if (result.rows.length === 0) return res.status(404).json({ error: "not found" });
res.json(result.rows[0]);

// CREATE (RETURNING * → the new row)
const result = await pool.query(
  "INSERT INTO notes (title, body) VALUES ($1, $2) RETURNING *",
  [title, body]
);
res.status(201).json(result.rows[0]);

// UPDATE (RETURNING * → the updated row)
const result = await pool.query(
  "UPDATE notes SET title = $1, body = $2 WHERE id = $3 RETURNING *",
  [title, body, id]
);
if (result.rows.length === 0) return res.status(404).json({ error: "not found" });
res.json(result.rows[0]);

// DELETE (RETURNING * → what was removed)
const result = await pool.query("DELETE FROM notes WHERE id = $1 RETURNING *", [id]);
if (result.rows.length === 0) return res.status(404).json({ error: "not found" });
res.json({ deleted: true });
```

Notice: the "find → bail(404) → act → respond" skeleton is **exactly the same** — you
just check `result.rows.length === 0` instead of `!note`.

## Controllers become `async` + try/catch

DB calls can fail (bad SQL, connection lost), so wrap them:

```js
export async function getAllNotes(req, res) {
  try {
    const result = await pool.query("SELECT * FROM notes ORDER BY id");
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "database error" });
  }
}
```

Same `try/catch` you used for `fetch` in Phase 4 — now on the server side.

## Quick reference

| Piece | Job |
| --- | --- |
| `new Pool({...})` | connect to the database (once) |
| `await pool.query(sql)` | run SQL, get a result |
| `result.rows` | the rows (array of objects) — your data |
| `result.rows[0]` | the first row (for "get one") |
| `$1, $2` + `[values]` | **parameterized query — always, for safety** |
| `async` + `try/catch` | because DB calls take time and can fail |

## The mental model

```
controller (async)
   → await pool.query("SELECT ... WHERE id = $1", [id])   ← ask Postgres
      → Postgres runs it, returns rows
         → result.rows  ← your data
            → res.json(result.rows)   ← send to the client
```

Your controller stops using a JS array and starts asking a real database — one
`await pool.query(...)` at a time. That's the whole leap to full-stack.
