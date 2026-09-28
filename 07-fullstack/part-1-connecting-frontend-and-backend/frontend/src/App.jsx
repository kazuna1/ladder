// App — the BRAIN. Holds all state (notes, loading, error, modal open/closed)
// and all the actions (load / add / delete). It passes data DOWN to the
// components as props, and functions DOWN that the components call to send
// events UP. The components themselves are "dumb" — they just display + trigger.
import { useEffect, useState } from "react";
import { getNotes, createNote, deleteNote } from "./api.js";
import NoteList from "./components/NoteList.jsx";
import AddNoteModal from "./components/AddNoteModal.jsx";

function App() {
  const [notes, setNotes] = useState([]);          // the data (from the DB)
  const [loading, setLoading] = useState(true);    // true while first fetch runs
  const [error, setError] = useState(null);        // set if the fetch fails
  const [isModalOpen, setIsModalOpen] = useState(false); // add-note popup open?

  // load notes once, when the app mounts
  useEffect(() => {
    async function load() {
      try {
        const data = await getNotes();
        setNotes(data);
      } catch (err) {
        console.error(err);
        setError("Could not load notes. Is the backend running on :3001?");
      } finally {
        setLoading(false);
      }
    }
    load();
  }, []);

  // CREATE: save to DB, then add the returned note to the list on screen
  async function handleAdd(note) {
    const created = await createNote(note);
    setNotes((prev) => [...prev, created]);
  }

  // DELETE: remove from DB, then remove from the list on screen
  async function handleDelete(id) {
    await deleteNote(id);
    setNotes((prev) => prev.filter((n) => n.id !== id));
  }

  return (
    <div className="app">
      <h1>My Notes</h1>

      {loading && <p>Loading...</p>}
      {error && <p className="error">{error}</p>}
      {!loading && !error && <NoteList notes={notes} onDelete={handleDelete} />}

      <button className="add-btn" onClick={() => setIsModalOpen(true)}>
        + Add note
      </button>

      {/* the modal renders ONLY when isModalOpen is true (conditional render) */}
      {isModalOpen && (
        <AddNoteModal
          onAdd={handleAdd}
          onClose={() => setIsModalOpen(false)}
        />
      )}
    </div>
  );
}

export default App;
