// NoteList — takes the notes array and renders one NoteItem per note.
// Passes onDelete straight down to each item (App owns the real logic).
import NoteItem from "./NoteItem.jsx";

function NoteList({ notes, onDelete }) {
  if (notes.length === 0) {
    return <p className="empty">No notes yet — add one!</p>;
  }
  return (
    <div className="note-list">
      {notes.map((note) => (
        <NoteItem key={note.id} note={note} onDelete={onDelete} />
      ))}
    </div>
  );
}

export default NoteList;
