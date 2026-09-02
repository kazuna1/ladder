# Part 1 — Connecting Frontend & Backend (the Notes App)

Build a **React notes app** that reads and writes real data in your PostgreSQL
database, through your Express API. Your first true full-stack app.

## Read first

1. **[what-is-fullstack.md](./what-is-fullstack.md)** — the big picture + CORS (the one
   new concept).
2. **[cors-and-fetch-cheatsheet.md](./cors-and-fetch-cheatsheet.md)** — the code
   patterns (CORS on the backend, fetch on the frontend).

## The two pieces

```
BACKEND  (already built)                 FRONTEND (build here)
06-backend/part-3-database/               07-fullstack/.../notes-client/
  notes_project_real/                       (React + Vite, scaffolded)
  Express + pg → Postgres                   fetches the backend
  runs on :3001                             runs on :5175
```

Your backend already exists and works — you built it. Here you build the **React UI**
that talks to it. Two separate apps, connected over HTTP.

## Step 1 — Prep the backend (2 small changes)

In `06-backend/part-3-database/notes_project_real/`:

1. **Add CORS** so the browser lets your frontend in:
   ```bash
   npm install cors
   ```
   Then in `server.js`: `import cors from "cors";` and `app.use(cors());` (before routes).
2. **Confirm the port is 3001** (3000 is taken by your other app) — `const PORT = 3001;`.

Start it: `npm start` → `API on http://localhost:3001`. Leave it running.

## Step 2 — Build the frontend (here)

The React app is scaffolded in **`notes-client/`**. Start it in a *second* terminal:
```bash
cd notes-client
npm run dev
```
→ opens `http://localhost:5175`. Now build the UI in `src/App.jsx`:

**Build order (each is a fetch you know, pointed at :3001):**
1. **Load & list** — `useEffect` → `GET /notes` → `setNotes` → render the list
2. **Add** — a form → `POST /notes` → add the returned note to state
3. **Delete** — a button per note → `DELETE /notes/:id` → remove from state

`src/App.jsx` has guided TODOs. Lean on the cheatsheet. Say **"review"** as you go.

## Running the whole app (two terminals)

```
Terminal 1 (backend):   cd 06-backend/part-3-database/notes_project_real  →  npm start   (:3001)
Terminal 2 (frontend):  cd 07-fullstack/.../notes-client                  →  npm run dev (:5175)
```
Open `http://localhost:5175`, and your React UI is talking to your database. 🎉

## Definition of done

- The page loads and shows notes from the database
- Adding a note through the form saves it to Postgres and shows it
- Deleting removes it from the UI *and* the database
- **Refresh the page / restart everything → the notes are still there** (they live in
  the DB, not memory). That permanence, driven from your UI, is a real full-stack app.

## The one big idea

```
React (fetch) → CORS gate → Express → Postgres → JSON back → React renders
```

Everything you know (React, fetch, Express, SQL), plus one line of CORS, assembled into
one app. Start the backend, start the frontend, and wire them together. 🚀
