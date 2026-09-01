# How to Initialize a Node + Express + PostgreSQL Project (from zero)

A complete, standalone recipe. Follow it top to bottom to spin up a backend that talks
to Postgres — no AI needed. Every step says WHAT you run and WHY.

Assumes: Node 18+ and PostgreSQL are installed, and you have a database + your
`postgres` password. (You have `ladder_notes` and Node 22.)

---

## Step 1 — Make/enter the project folder

```bash
cd "d:\tugu programs\code\ladder\06-backend\part-3-database\notes-api-db"
```
(If starting elsewhere: `mkdir my-api` then `cd my-api`.)
**Why:** every project lives in its own folder.

---

## Step 2 — Initialize npm → creates `package.json`

```bash
npm init -y
```
**Why:** `package.json` is the project's manifest — its name, dependencies, and scripts.
`-y` accepts all defaults (you can edit it after). This file is what makes a folder "a
Node project."

---

## Step 3 — Turn on ES Modules (`import`/`export`)

Open `package.json` and add this line (anywhere in the top object):
```json
"type": "module",
```
**Why:** without it, Node uses the old `require(...)` syntax. `"type": "module"` lets
you use modern `import ... from ...` (the same syntax you've used since Phase 2 and React).

---

## Step 4 — Install the dependencies

```bash
npm install express pg
```
**Why:**
- **express** — the web-server framework (routes, req/res).
- **pg** — the PostgreSQL driver (lets your code send SQL to the database).

This creates `node_modules/` (the actual library code), `package-lock.json` (exact
versions), and adds both to `"dependencies"` in `package.json`.

---

## Step 5 — Create `.gitignore`

Make a file named `.gitignore` with:
```
node_modules/
.env
```
**Why:** never commit `node_modules/` (huge, regenerable with `npm install`) or `.env`
(it holds your password — secrets must stay out of git).

---

## Step 6 — Store your DB password safely in `.env`

Make a file named `.env` (note the leading dot) with:
```
PGPASSWORD=your_postgres_password_here
```
**Why:** hardcoding a password in code is a leak waiting to happen. You keep it in
`.env` (which is gitignored) and read it from `process.env`. Node 18+ can load `.env`
itself with a flag (Step 9) — no extra library needed.

---

## Step 7 — Create the folder structure

```
notes-api-db/
├─ .env                 (your password — Step 6)
├─ .gitignore           (Step 5)
├─ package.json         (Step 2–4)
├─ db.js                ← the database connection
├─ server.js            ← boots the app, mounts routes, listens
├─ routes/
│   └─ notes.routes.js  ← URL → controller wiring
└─ controllers/
    └─ notes.controller.js  ← the logic (SQL via pg)
```
Create the empty files/folders now; you'll fill them next.
**Why:** same routes/controllers split you learned in Part 2 — plus `db.js` for the
one shared database connection.

---

## Step 8 — Write the database connection (`db.js`)

```js
import pg from "pg";
const { Pool } = pg;

export const pool = new Pool({
  host: "localhost",      // the DB is on this machine
  port: 5432,             // Postgres's default door
  user: "postgres",       // the superuser
  password: process.env.PGPASSWORD,   // read from .env (Step 6)
  database: "ladder_notes",           // the database you created
});
```
**Why:** a **Pool** is a set of reusable connections to Postgres. You make it once here
and `import { pool }` wherever you need to run a query. (See `../pg-cheatsheet.md`.)

---

## Step 9 — Add a run script + run it

In `package.json`, set the `"scripts"` section:
```json
"scripts": {
  "start": "node --env-file=.env server.js"
}
```
**Why:** `--env-file=.env` tells Node to load your `.env` before running (so
`process.env.PGPASSWORD` is filled). Then you start the whole thing with:
```bash
npm start
```

---

## Step 10 — Verify the connection works

Before building all the routes, prove `db.js` can reach Postgres. Temporarily put this
at the bottom of `server.js` (or a scratch file):
```js
import { pool } from "./db.js";
const result = await pool.query("SELECT NOW()");   // asks Postgres for the current time
console.log("DB connected:", result.rows[0]);
```
Run `npm start`. If you see a timestamp printed → **your Node app is talking to your
database.** 🎉 If you get an auth error → check the password in `.env`.

---

## The whole recipe, in one glance

```
1. cd into folder
2. npm init -y                         → package.json
3. add "type": "module"                → modern import syntax
4. npm install express pg              → the libraries
5. .gitignore  (node_modules/, .env)   → don't commit junk/secrets
6. .env  (PGPASSWORD=...)               → password, safely
7. make db.js / server.js / routes/ / controllers/
8. db.js → new Pool({...})             → the connection
9. "start": "node --env-file=.env server.js"  → npm start
10. test with SELECT NOW()             → confirm it connects
```

That's the birth of every Node+Postgres backend. Memorize the shape; the details you
can always look up. Once it connects, you write the routes and controllers (the CRUD
via pg) — that's the fun part.
