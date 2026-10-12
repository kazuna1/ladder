# Express v2 Cheatsheet

## Setup
```bash
npm init -y && npm install express cors && npm pkg set type=module
# start script:  "start": "node server.js"
```

## Minimal server
```js
import express from "express";
import cors from "cors";
import notesRouter from "./routes/notes.js";

const app = express();
app.use(cors());              // allow the browser frontend to call this API
app.use(express.json());      // parse JSON request bodies into req.body
app.use("/notes", notesRouter);
app.listen(3001, () => console.log("API on http://localhost:3001"));
```
> Mounting with a prefix (`app.use("/notes", router)`) STRIPS the prefix — inside the router
> paths are relative (`/`, `/:id`), not `/notes/...`.

## Router + routes
```js
import { Router } from "express";
const router = Router();
router.get("/", getAllNotes);
router.get("/:id", getNote);
router.post("/", createNote);
router.delete("/:id", deleteNote);
export default router;
```

## Where request data comes from
```js
req.params.id    // from the URL path  /notes/:id
req.query.q      // from ?q=... in the URL
req.body         // from a JSON POST/PUT body (needs express.json())
```

## Responses & status codes
```js
res.json(data);                      // 200 + JSON
res.status(201).json(created);       // created
res.status(400).json({ error });     // bad input
res.status(404).json({ error });     // not found
res.status(500).json({ error });     // server crashed (use in catch)
```

## The controller skeleton
```js
export function getNote(req, res) {
  const note = notes.find(n => n.id === Number(req.params.id));
  if (!note) return res.status(404).json({ error: "not found" });  // bail early
  res.json(note);                                                   // act + respond
}
```

## CORS in one line
Browser blocks cross-origin fetches (frontend :5173 → API :3001) by default. `app.use(cors())`
tells the API "it's OK, allow it." In production you lock it to your real frontend origin.
