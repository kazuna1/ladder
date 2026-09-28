// api.js — the ONLY file that talks to the backend.
// Every component imports these; nobody else writes fetch() calls.
const API = "http://localhost:3001";

// GET /notes → the array of all notes
export async function getNotes() {
  const res = await fetch(`${API}/notes`);
  if (!res.ok) throw new Error("Failed to load notes");
  return res.json();
}

// POST /notes → create one, returns the created note (with its new id)
export async function createNote(note) {
  const res = await fetch(`${API}/notes`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(note),
  });
  if (!res.ok) throw new Error("Failed to create note");
  return res.json();
}

// DELETE /notes/:id → remove one (no body needed back)
export async function deleteNote(id) {
  const res = await fetch(`${API}/notes/${id}`, { method: "DELETE" });
  if (!res.ok) throw new Error("Failed to delete note");
}
