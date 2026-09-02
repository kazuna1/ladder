# CORS + Fetching Your Own API — Cheatsheet

Everything you need to connect the React frontend to your Express backend. Two sides:
the **backend** allows the frontend (CORS), and the **frontend** calls the backend (fetch).

---

## BACKEND side — enable CORS (one-time, in your Express app)

Your backend lives in `06-backend/part-3-database/notes_project_real`. Two steps:

**1. Install the `cors` package** (in the backend folder):
```bash
npm install cors
```

**2. Use it in `server.js`** (before your routes):
```js
import express from "express";
import cors from "cors";
import notesRouter from "./routes/notes.routes.js";

const app = express();
app.use(cors());              // ← allow cross-origin requests (the new line)
app.use(express.json());
app.use("/notes", notesRouter);

app.listen(3001, () => console.log("API on http://localhost:3001"));
```

That's it. `app.use(cors())` adds the header that tells browsers "requests from other
origins are allowed." Your React app can now reach the API.

> ⚠️ Also make sure your backend `PORT` is **3001** (3000 is taken by your other app).

---

## FRONTEND side — fetch from your own API (React)

Exactly the Phase-4 pattern, pointed at `http://localhost:3001`.

### GET (load notes on mount)
```jsx
const [notes, setNotes] = useState([]);

useEffect(() => {
  async function load() {
    const res = await fetch("http://localhost:3001/notes");
    const data = await res.json();
    setNotes(data);
  }
  load();
}, []);
```

### POST (create a note)
```jsx
async function addNote(title, body) {
  const res = await fetch("http://localhost:3001/notes", {
    method: "POST",
    headers: { "Content-Type": "application/json" },   // ← tell the server it's JSON
    body: JSON.stringify({ title, body }),             // ← the data, as a JSON string
  });
  const created = await res.json();
  setNotes([...notes, created]);                       // add it to the list in state
}
```

### DELETE (remove a note)
```jsx
async function removeNote(id) {
  await fetch(`http://localhost:3001/notes/${id}`, { method: "DELETE" });
  setNotes(notes.filter((n) => n.id !== id));          // drop it from state
}
```

### The `fetch` options object (the only new fetch detail)
For GET you just pass the URL. For POST/PUT/DELETE you pass a **second argument** — an
options object:
```js
fetch(url, {
  method: "POST",                                    // GET (default) / POST / PUT / DELETE
  headers: { "Content-Type": "application/json" },   // required when sending a JSON body
  body: JSON.stringify({ ... }),                     // the data (a STRING, not an object)
})
```
- **`method`** — which HTTP verb (matches your route)
- **`headers`** — `Content-Type: application/json` so the backend's `express.json()` parses it
- **`body`** — `JSON.stringify(...)` your data (the body must be a string)

---

## Keeping the UI in sync with the database

The golden rule: **the database is the truth; React state is a copy.** After every
successful write, update state so the screen matches:

| Action | After the fetch succeeds |
| --- | --- |
| create | `setNotes([...notes, created])` — add the returned note |
| delete | `setNotes(notes.filter(n => n.id !== id))` — remove it |
| update | replace that note in the array with the returned one |

(Simpler-but-heavier alternative: just re-fetch the whole list after any change —
`await load()`. Fine for small apps.)

---

## The two errors you'll probably hit (and fixes)

**1. CORS error** in the browser console:
```
blocked by CORS policy
```
→ You forgot `app.use(cors())` on the backend (or the backend isn't running). Add it, restart the backend.

**2. `Failed to fetch` / connection refused:**
→ The backend isn't running, or you used the wrong port. Make sure the backend is up on
**3001** and your fetch URLs say `http://localhost:3001`.

---

## The mental model

```
BACKEND:  app.use(cors())            → "I allow other origins"
FRONTEND: fetch("http://localhost:3001/notes", { method, headers, body })
             → browser checks CORS → allowed → request reaches Express
                → controller → Postgres → rows → JSON back → setState → UI updates
```

Two servers, one line of CORS to connect them, and your Phase-4 fetch skills doing the
rest. That's full-stack.
