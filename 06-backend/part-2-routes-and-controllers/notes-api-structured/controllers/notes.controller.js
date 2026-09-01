// CONTROLLERS — the actual logic. One exported function per endpoint.
// This is where you MOVE the bodies of your handlers from project-01-notes-api.js.
// Nothing new — same find/push/filter/respond code, just named and exported.
//
// The data lives here for now (later, Phase 5b, this becomes a real database).
//
// ---------------------------------------------------------------------------

let notes = []; // the "database" for now

// Each controller is your old handler, turned into a NAMED, EXPORTED function.
// The (req, res) => {...} body is IDENTICAL to what you already wrote — just
// pasted inside these named functions.

// TODO: write and export these 5 functions (move the logic from your one-file version):

// export function getAllNotes(req, res) {
//   ...res.json(notes)...
// }

export function getAllNotes(req, res) {
  res.json(notes);
}

// export function getNote(req, res) {
//   ...find by Number(req.params.id), 404 if missing, else res.json(note)...
// }
export function getNote(req, res) {
  const id = req.params.id;
  const note = notes.find((n) => n.id === Number(id));
  if (!note) {
    return res.status(404).json({ error: "Note doesnt exist" });
  }
  res.status(200).json(note);
}
// export function createNote(req, res) {
//   ...destructure title/body, validate, build newNote, push, 201...
// }

export function createNote(req, res) {
  const { title, body } = req.body;

  if (!title) {
    return res.status(400).json({ error: "title required" });
  }
  const newNote = { id: Date.now(), title, body: body || "" };
  notes.push(newNote);

  res.status(201).json(newNote);
}

// export function updateNote(req, res) {
//   ...find, 404, validate, mutate note.title/body, res.json(note)...
// }
export function updateNote(req, res) {
  const id = req.params.id;
  const note = notes.find((n) => n.id === Number(id));

  if (!note) {
    return res.status(404).json({ error: "This item does not exist" });
  }

  const { title, body } = req.body;

  if (!title) {
    return res.status(400).json({ error: "Title required" });
  }

  note.title = title;
  note.body = body;

  res.status(200).json(note);
}
// export function deleteNote(req, res) {
//   ...find, 404, notes = notes.filter(...), res.json({ deleted: true, note })...
// }
export function deleteNote(req, res) {
  const id = req.params.id;
  const note = notes.find((n) => n.id === Number(id));
  if (!note) {
    return res.status(404).json({ error: "Note doesnt exist" });
  }
  notes = notes.filter((n) => n.id !== Number(id));
  res.status(200).json({ deleted: true, note });
}
// WHAT TO NOTICE:
// - The logic is EXACTLY your project-01 code. You're only moving it into named,
//   exported functions so the router can reference them by name.
// - `notes` lives here now — the controller owns the data. When you switch to a
//   database later, ONLY this file changes; routes and server stay untouched.
// - `export function name(req, res) {}` — the router imports these names.
