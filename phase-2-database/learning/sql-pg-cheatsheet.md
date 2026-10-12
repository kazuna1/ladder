# SQL + pg Cheatsheet (v3)

## The 4 operations = your CRUD, one layer down
```sql
INSERT INTO notes (text) VALUES ('hello') RETURNING *;   -- Create
SELECT * FROM notes;                                      -- Read (all)
SELECT * FROM notes WHERE id = 1;                         -- Read (one)
UPDATE notes SET text = 'edited' WHERE id = 1 RETURNING *;-- Update
DELETE FROM notes WHERE id = 1 RETURNING *;               -- Delete
```
> `RETURNING *` hands the affected row back — perfect for responding with the created/updated note.
> `WHERE` is the most important word: forget it on UPDATE/DELETE and you hit EVERY row. 💀

## The notes table
```sql
CREATE TABLE notes (
  id         INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  text       TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);
```

## psql basics
```
psql -U postgres          connect
\c notes_db               switch database
\dt                       list tables
\i path/to/file.sql       run a .sql file
\q                        quit
```

## The pg driver (Node)
```bash
npm install pg && npm pkg set type=module
# start:  "start": "node --env-file=.env server.js"
```
```js
import pg from "pg";
const { Pool } = pg;
export const pool = new Pool({
  host: "localhost", port: 5432, user: "postgres",
  password: process.env.PGPASSWORD, database: "notes_db",
});
```

## Parameterized queries (ALWAYS — anti SQL-injection)
```js
// ✅ safe: values go through $1, $2 — never string-concatenated
const result = await pool.query("SELECT * FROM notes WHERE id = $1", [id]);
const note = result.rows[0];          // one row
const all  = result.rows;             // many rows

// ❌ NEVER: `SELECT * FROM notes WHERE id = ${id}`  → injection hole
```

## Async controller shape (array → query)
```js
export async function getNote(req, res) {
  try {
    const r = await pool.query("SELECT * FROM notes WHERE id = $1", [req.params.id]);
    if (r.rows.length === 0) return res.status(404).json({ error: "not found" });
    res.json(r.rows[0]);
  } catch (err) {
    console.error(err);                // real error → server log
    res.status(500).json({ error: "database error" });  // generic → client
  }
}
```

## Secrets
`.env` holds `PGPASSWORD=...`, is **gitignored**, loaded with `node --env-file=.env`.
Never commit it.
