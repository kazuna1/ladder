// SERVER — the thin entry point.
// Its ONLY jobs: set up the app, plug in middleware, mount the router(s), listen.
// NO route logic lives here. Notice how short this file should stay.
//
// RUN:  node server.js   (from inside the notes-api-structured/ folder)
//
// ---------------------------------------------------------------------------

import express from "express";
// TODO 1: import your notes router (you'll build it in routes/notes.routes.js)
//   import notesRouter from "./routes/notes.routes.js";
import noteRouters from "./routes/notes.routes.js";

const app = express();
const PORT = 3000;

app.use(express.json());

// TODO 2: mount the router — every request starting with "/notes" goes to it:
//   app.use("/notes", notesRouter);
//   (this is the ONE place "/notes" is written — inside the router, paths are relative)

app.use("/notes", noteRouters);

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});

// WHAT TO NOTICE:
// - This file has NO find/push/filter. It just boots and wires. That's the point.
// - To add a new resource later (users, posts), you'd import its router and add
//   one more app.use(...) line here. server.js shows the whole app at a glance.
