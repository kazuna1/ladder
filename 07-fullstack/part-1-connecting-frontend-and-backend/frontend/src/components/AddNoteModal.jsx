// AddNoteModal — the popup form for creating a note.
// A modal is just: render this only when the parent decides to (App does
// `{isModalOpen && <AddNoteModal .../>}`). It holds its OWN input state,
// and when submitted it calls onAdd (create) then onClose (hide).
import { useState } from "react";

function AddNoteModal({ onAdd, onClose }) {
  const [title, setTitle] = useState("");
  const [body, setBody] = useState("");

  function handleSubmit(e) {
    e.preventDefault();          // stop the form from reloading the page
    if (!title.trim()) return;   // require a title
    onAdd({ title, body });      // tell App to create it (event UP)
    onClose();                   // close the modal
  }

  return (
    // overlay = the dark backdrop; clicking it closes the modal
    <div className="overlay" onClick={onClose}>
      {/* stopPropagation = clicks INSIDE the box don't bubble to the backdrop */}
      <div className="modal" onClick={(e) => e.stopPropagation()}>
        <h2>Add a note</h2>
        <form onSubmit={handleSubmit} className="modal-form">
          <input
            placeholder="Title"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            autoFocus
          />
          <input
            placeholder="Body (optional)"
            value={body}
            onChange={(e) => setBody(e.target.value)}
          />
          <div className="modal-buttons">
            <button type="submit">Add</button>
            <button type="button" onClick={onClose}>Cancel</button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default AddNoteModal;
