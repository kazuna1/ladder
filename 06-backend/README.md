# Phase 5 — Backend

**The other side of the counter.** For months you've *called* APIs. Now you *build*
them. You become the server that receives a request and decides what to send back.

## Folder layout — organized by PART (do them in order)

Each part is a self-contained folder — open one and focus only on it.

```
06-backend/
├─ part-1-server-basics/          ← Express fundamentals + your first API
│   ├─ what-is-a-server.md            (concept: what a server is)
│   ├─ express-cheatsheet.md          (syntax reference)
│   ├─ drills/                        (8 guided drills, 01–08)
│   └─ project-01-notes-api/          (the single-file Notes API you built)
├─ part-2-routes-and-controllers/ ← structuring a real backend
│   ├─ backend-structure-cheatsheet.md
│   └─ notes-api-structured/          (same API split into routes/ + controllers/)
└─ part-3-database/               ← PostgreSQL: data that survives restarts
    ├─ what-is-a-database.md
    ├─ sql-cheatsheet.md
    └─ drills/                        (8 guided SQL drills, 01–08)
```

## Start with Part 1 → read these FIRST (10 minutes)

1. **[part-1-server-basics/what-is-a-server.md](./part-1-server-basics/what-is-a-server.md)**
   — what a server even *is*, from the inside (the kitchen, not the customer).
2. **[part-1-server-basics/express-cheatsheet.md](./part-1-server-basics/express-cheatsheet.md)**
   — the syntax: routes, `req`, `res`, params, body, status codes.

Read both, then do the drills. They'll make total sense.

## The plan (slow and gradual — no database, no React yet)

We isolate the backend by itself first, exactly like we split async into "Node first,
then React." Master the server alone → add a database → *then* connect your React app.

```
Part 1 (NOW):  Express drills → in-memory data only. Learn the server.
Part 2 (soon): Mini project — build a Notes API by hand.
Phase 5b:      Add a real DATABASE (data survives restarts).
Phase 5c:      Wire your React frontend to your backend = FULL-STACK. 🏆
```

## Part 1 — the drills (do in order)

Run each with `node <file>`, then test in your browser (GET) or curl/Thunder Client
(POST/PUT/DELETE). Each is a guided template — the structure's there, you write the
key lines.

- **01 hello-server** — your first running server (one route)
- **02 json-response** — send JSON objects & arrays (`res.json`)
- **03 multiple-routes** — many endpoints on one server (the switchboard)
- **04 route-params** — `/users/:id` — get one specific thing
- **05 query-params** — `/search?q=...` — filters & options
- **06 post-and-body** — CREATE data; `req.body` + `express.json()`
- **07 in-memory-crud** — full Create/Read/Update/Delete (the big one)
- **08 status-and-errors** — status codes + validating input (polish)

Say **"review"** after a batch (or when one won't work) and I'll check it + explain.

## Part 2 — the mini project (after the drills)

**Notes API** — a real REST API you build by hand: create a note, list all notes,
read one, edit one, delete one. Everything from the drills, assembled into one clean
server. See **[part-1-server-basics/project-01-notes-api/](./part-1-server-basics/project-01-notes-api/)**
(single-file version), then **[part-2-routes-and-controllers/](./part-2-routes-and-controllers/)**
for the routes/controllers refactor.

## How to run

```
node part-1-server-basics/drills/01-hello-server.js
```
The server stays alive (that's the point) — stop it with **Ctrl+C**. Change code →
stop → re-run to see it. (We'll add auto-restart with `node --watch` once you're
comfortable.)

## Testing POST/PUT/DELETE (browsers only do GET)

- **GET** → just open the URL in your browser.
- **POST/PUT/DELETE** → use one of:
  - **Thunder Client** or **REST Client** (VS Code extensions — easiest), or
  - terminal `curl` (examples are in each drill file).

## The one big idea

```
A request comes in (req)  →  your code decides  →  you send a response (res)
```

Match a route → read the request → send the answer. That's the entire job of a
backend. Everything else — params, body, status codes, later a database — hangs off
that one loop. You already know the JavaScript; you're just learning to sit on the
other side of the `fetch`.
