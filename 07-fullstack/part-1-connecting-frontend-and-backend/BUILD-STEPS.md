# Notes App — Build Steps (by hand, from zero)

Follow the phases in order: **Database → Backend → Frontend → Run**. Build the
foundation first, then the thing that serves it, then the thing that shows it.

Project layout you're building toward:
```
notes-fullstack/
├─ server/    (backend — Express + pg)
└─ client/    (frontend — React + Vite)
```

---

## Phase 1: Database Setup

1. Connect to Postgres (to the `postgres` admin DB, so you can drop/create others):
   ```bash
   psql -U postgres
   ```
2. Drop the old database and make a fresh one, then connect into it:
   ```sql
   DROP DATABASE IF EXISTS ladder_notes;
   CREATE DATABASE ladder_notes;
   \c ladder_notes
   ```
3. Create the `notes` table:
   ```sql
   CREATE TABLE notes (
     id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     title TEXT NOT NULL,
     body  TEXT DEFAULT ''
   );
   ```
4. Verify: `\dt` (see `notes`), `\d notes` (see the columns). `\q` to quit.

✅ **Done when:** `\dt` shows the `notes` table.

---

## Phase 2: Backend Setup

1. Make and enter the server folder:
   ```bash
   mkdir -p notes-fullstack/server
   cd notes-fullstack/server
   ```
2. Initialize npm (creates `package.json`):
   ```bash
   npm init -y
   ```
3. Enable ES modules — add to `package.json`:  `"type": "module",`
4. Install the libraries:
   ```bash
   npm install express pg cors
   ```
5. Create `.gitignore`:
   ```
   node_modules/
   .env
   ```
6. Create `.env` (your DB password):
   ```
   PGPASSWORD=your_postgres_password
   ```
7. Create `db.js` (the connection pool):
   ```js
   import pg from "pg";
   const { Pool } = pg;
   export const pool = new Pool({
     host: "localhost", port: 5432, user: "postgres",
     password: process.env.PGPASSWORD, database: "ladder_notes",
   });
   ```
8. Create the app files:
   - `controllers/notes.controller.js` — 5 async functions using `pool.query` + `$1` params
   - `routes/notes.routes.js` — wire the 5 routes to the controllers
   - `server.js`:
     ```js
     import express from "express";
     import cors from "cors";
     import notesRouter from "./routes/notes.routes.js";
     const app = express();
     app.use(cors());              // let the frontend (other origin) in
     app.use(express.json());
     app.use("/notes", notesRouter);
     app.listen(3001, () => console.log("API on http://localhost:3001"));
     ```
9. Add a run script to `package.json`:
   ```json
   "scripts": { "start": "node --env-file=.env server.js" }
   ```
10. Run and test:
    ```bash
    npm start
    ```
    → open `http://localhost:3001/notes` (browser for GET; Postman for POST/PUT/DELETE).

✅ **Done when:** the API reads/writes the database on port 3001.

---

## Phase 3: Frontend Setup

1. From `notes-fullstack/`, create the React app:
   ```bash
   npm create vite@latest client -- --template react
   cd client
   npm install
   ```
2. Set the port in `vite.config.js` (avoid collisions):
   ```js
   server: { port: 5175 },
   ```
3. Build the UI in `src/App.jsx` (fetch your API — see `cors-and-fetch-cheatsheet.md`):
   1. **Load & list** — `useEffect` → `GET http://localhost:3001/notes` → `setNotes` → render
   2. **Add** — a form → `POST /notes` (headers + `JSON.stringify` body) → add to state
   3. **Delete** — a button → `DELETE /notes/:id` → filter out of state
4. Run it:
   ```bash
   npm run dev
   ```
   → open `http://localhost:5175`.

✅ **Done when:** the UI shows notes, and add/delete work.

---

## Phase 4: Run It All Together

Two terminals, both running at once:
```
Terminal 1:  cd notes-fullstack/server   →  npm start      (backend  :3001)
Terminal 2:  cd notes-fullstack/client   →  npm run dev    (frontend :5175)
```
Open `http://localhost:5175`. Add a note → refresh the page → it's still there (it
lives in Postgres). 🎉

✅ **Done when:** you create/delete notes in the browser and they persist in the database.

---

## The workflow, memorized

```
DATABASE  → create db + table         (data has a home)
BACKEND   → init, install, db.js, routes/controllers/server, CORS, :3001
FRONTEND  → create vite, fetch the API, render, :5175
RUN       → both servers, two terminals, over HTTP
```

Foundation → serve → show. That order never changes. Master it once, reuse it forever.
