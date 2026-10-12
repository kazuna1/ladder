// PHASE 3 · DRILL — Turn array ops into real pg queries
// Run:  node --env-file=.env wire-pg.js
// Setup: npm install pg && npm pkg set type=module ; have a `notes_db` + notes table (see notes-table.sql);
//        a .env with PGPASSWORD=...
// Goal: feel the ONE line that changes from v2 → v3: array operation → pool.query.
// ---------------------------------------------------------------------------
import pg from "pg";
const { Pool } = pg;

const pool = new Pool({
  host: "localhost", port: 5432, user: "postgres",
  password: process.env.PGPASSWORD, database: "notes_db",
});

// TODO 1: getAllNotes — SELECT * FROM notes, return result.rows.
//   HINT: const r = await pool.query("SELECT * FROM notes"); return r.rows;

// TODO 2: createNote(text) — INSERT with a PARAMETERIZED query ($1) + RETURNING *,
//   return the created row (result.rows[0]).
//   HINT: await pool.query("INSERT INTO notes (text) VALUES ($1) RETURNING *", [text])

// TODO 3: deleteNote(id) — DELETE WHERE id = $1 RETURNING *; return whether a row came back.

// ---- test (uncomment once built) ----
// console.log(await createNote("from node!"));
// console.log(await getAllNotes());
// await pool.end();   // close the pool so the script exits

// WHAT TO NOTICE:
// - Compare to v2's note-controllers.js: the SHAPE is identical, only the storage line
//   changed (array method → pool.query with $1). That's the whole v2→v3 upgrade.
// - $1 keeps user input OUT of the SQL text → no SQL injection. Never use `${...}` in SQL.
