# The Full-Stack Map — How It All Connects

You've built every layer separately. This is the big picture: how they fit into **one
system**, and where each thing you learned lives. Read this to see the whole machine.

---

## The whole system in one diagram

```
┌─────────────────────────────────────────────────────────────────────────┐
│  1. BROWSER  — your React app (the CLIENT)                                │
│     • components, state, useEffect                                        │
│     • fetch("http://localhost:3000/notes")                               │
│                                    │                                      │
│                                    │  HTTP request (GET/POST/PUT/DELETE)  │
│                                    ▼                                      │
│  2. EXPRESS SERVER  — your backend (Node)                                 │
│     • server.js      → boots, mounts routers                             │
│     • routes/        → which URL → which controller                      │
│     • controllers/   → the logic                                         │
│                                    │                                      │
│                                    │  SQL query via the `pg` driver       │
│                                    ▼                                      │
│  3. POSTGRESQL  — the database (a separate server)                        │
│     • tables on disk (your `notes` table)                                │
│     • runs SQL, returns rows                                             │
│                                    │                                      │
│         rows ──────────────────────┘  travel back up:                    │
│         DB → controller → res.json() → HTTP response → React → screen     │
└─────────────────────────────────────────────────────────────────────────┘
```

**Three programs, talking to each other.** Data flows down (request) and back up
(response). You've built all three boxes — now you connect box 2 to box 3.

---

## Where everything you learned lives

| You learned... | ...and it lives in this box |
| --- | --- |
| components, props, state, `useEffect` | **1. Browser** (React) |
| `fetch`, async/await, loading/error states | **1 → 2** (browser calling the server) |
| Express routes, `req`/`res`, params, body, status codes | **2. Express server** |
| routes/ + controllers/ structure | **2. Express server** (organized) |
| SQL: CREATE/INSERT/SELECT/UPDATE/DELETE | **3. PostgreSQL** |
| the `pg` driver (NEW) | **2 → 3** (server talking to the database) |

Nothing here is new *knowledge* — it's your existing pieces, assembled. The only new
part is the **`pg` driver**: the arrow from your Express controllers to Postgres.

---

## The request lifecycle, end to end (follow one request)

A user opens your app and it loads their notes. Watch the whole journey:

```
1. React:      useEffect → fetch("http://localhost:3000/notes")
2. (network):  a GET request travels to your server
3. Express:    app.use("/notes", notesRouter) → router.get("/", getAllNotes)
4. Controller: getAllNotes(req, res) runs
5. pg driver:  await pool.query("SELECT * FROM notes")   ← the NEW arrow
6. Postgres:   runs the SQL, returns the rows
7. Controller: res.json(result.rows)   ← sends rows back as JSON
8. (network):  the JSON response travels back to the browser
9. React:      setNotes(data) → re-render → notes appear on screen
```

Steps 1–2 = Phase 4. Steps 3–4, 7 = Parts 1–2. Step 6 = Part 3. **Step 5 is the one
new line** — and it turns three separate things into one working app.

---

## What changes when you add the database

Your controllers currently use an array in memory:

```js
// BEFORE — the array version (data dies on restart)
export function getAllNotes(req, res) {
  res.json(notes);                    // `notes` is a let [] in memory
}
```

```js
// AFTER — the database version (data survives, async)
export async function getAllNotes(req, res) {
  const result = await pool.query("SELECT * FROM notes");
  res.json(result.rows);              // real rows from Postgres
}
```

Two changes, and they're the whole lesson of this step:
1. **Controllers become `async`** — talking to a database takes time, so you `await`
   the query (exactly your Phase-4 async skills, now on the server side).
2. **The array becomes SQL** — `notes.find(...)` → `SELECT ... WHERE`, `notes.push(...)`
   → `INSERT`, etc. (the CRUD↔SQL mapping you already know).

**Routes and server.js don't change at all.** Remember why you structured the backend
in Part 2? *So the storage could be swapped without touching anything else.* This is
that payoff, live.

---

## The mental model to carry forward

```
FRONTEND  (what the user sees)     →  React        →  "the face"
BACKEND   (the rules + traffic)    →  Express      →  "the brain"
DATABASE  (where data lives)       →  PostgreSQL   →  "the memory"
```

- The **face** (React) shows things and takes clicks.
- The **brain** (Express) decides what to do and enforces rules.
- The **memory** (Postgres) remembers everything, permanently.

A "full-stack app" is just these three, wired together. You're about to wire the last
connection — and then you can build *anything*: the pattern is always face → brain →
memory, and back.

**Next:** read [pg-cheatsheet.md](./pg-cheatsheet.md), then build the wired-up Notes
API in [notes-api-db/](./notes-api-db/). 🚀
