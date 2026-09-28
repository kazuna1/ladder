// NoteItem — ONE note card. "Dumb": shows the note it's given, and calls
// onDelete (a function from the parent) when its delete button is clicked.
function NoteItem({ note, onDelete }) {
  return (
    <div className="note-item">
      <div>
        <strong>{note.title}</strong>
        {note.body && <p className="note-body">{note.body}</p>}
      </div>
      <button onClick={() => onDelete(note.id)}>delete</button>
    </div>
  );
}

export default NoteItem;
