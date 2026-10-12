// PHASE 2 · DRILL — Note operations as logic (in-memory)
// Run:  node note-controllers.js   (setup: npm init -y && npm pkg set type=module)
// Goal: build the 4 core note operations against an in-memory array. This is the exact
//       logic your Express controllers will wrap — get it right here, plumbing comes later.
// ---------------------------------------------------------------------------

let notes = [{ id: 1, text: "first note" }];
let nextId = 2;

// TODO 1: getAllNotes()  → return the whole notes array.

// TODO 2: getNote(id)  → return the note with that id, or { error: "not found" } if none.
//   HINT: notes.find(n => n.id === id)

// TODO 3: createNote(text)  → validate text is non-empty (else { error }); push
//   { id: nextId++, text }; return the created note.

// TODO 4: deleteNote(id)  → if no note with that id → { error: "not found" };
//   else notes = notes.filter(...) and return { ok: true }.

// ---- test (uncomment once built) ----
// console.log(getAllNotes());
// console.log(createNote("second note"));
// console.log(getNote(2));
// console.log(deleteNote(1));
// console.log(getAllNotes());
// console.log(getNote(999));   // → { error: "not found" }

// WHAT TO NOTICE:
// - This is pure CRUD logic on an array. In Express, each becomes a controller:
//     getNote(req,res) → const n = getNote(Number(req.params.id)); n.error ? 404 : res.json(n)
// - v3 swaps the array for Postgres — the SHAPE stays the same, the storage changes.
