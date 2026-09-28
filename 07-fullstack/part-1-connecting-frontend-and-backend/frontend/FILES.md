# Frontend Files — Quick Reference

The whole app, file by file. Read this alongside the code to reverse-engineer it.

## The tree
```
src/
├─ main.jsx                    (entry — mounts <App> into the HTML)  [Vite made it]
├─ App.jsx                     (the BRAIN — state + actions + wiring)
├─ api.js                      (the ONLY file that talks to the backend)
├─ index.css                   (minimal plain styling)
└─ components/
    ├─ NoteList.jsx            (renders the list of notes)
    ├─ NoteItem.jsx            (one note card + delete button)
    └─ AddNoteModal.jsx        (the add-note popup form)
```

## What each file does + what's inside

### `main.jsx`  (don't touch)
Entry point. Mounts `<App />` into `<div id="root">` in index.html. Vite generated it.

### `api.js`  — talks to the backend
The only place `fetch` lives. Exports 3 functions:
- `getNotes()` → GET /notes → array of notes
- `createNote(note)` → POST /notes → the created note
- `deleteNote(id)` → DELETE /notes/:id
(`API` const points at `http://localhost:3001`.)

### `App.jsx`  — the brain (owns everything)
Holds the **state**: `notes`, `loading`, `error`, `isModalOpen`.
Holds the **actions**: `handleAdd`, `handleDelete`, and the `useEffect` that loads notes on mount.
**Renders** and **wires** the components — passes data down (`notes`) and functions down
(`onDelete`, `onAdd`). The `{isModalOpen && <AddNoteModal/>}` line shows the modal only
when open. **This is the only "smart" component; the rest are dumb.**

### `components/NoteList.jsx`  — the list
Takes `notes` + `onDelete` props. `notes.map(...)` → one `<NoteItem>` per note (with
`key={note.id}`). Shows "No notes yet" when the list is empty. No logic of its own —
just passes `onDelete` down to each item.

### `components/NoteItem.jsx`  — one card
Takes `note` + `onDelete` props. Shows the title + body, and a delete button that calls
`onDelete(note.id)`. Pure display — it doesn't delete anything itself, it just *asks* App to.

### `components/AddNoteModal.jsx`  — the popup form
Takes `onAdd` + `onClose` props. Holds its **own** `title`/`body` input state. On submit:
validates the title → calls `onAdd({title, body})` → calls `onClose()`. The overlay
(dark backdrop) closes on click; `stopPropagation` keeps clicks inside the box from closing it.

### `index.css`  — plain styling
Minimal, functional CSS: a mobile-ish card container (`.app`), note cards (`.note-item`),
the modal overlay/box (`.overlay`, `.modal`), the bottom add button. Not "designed" —
that's a later Tailwind pass.

## The data flow (the pattern to notice)
```
App (state + actions)
  │  props DOWN:  notes={notes}   onDelete={handleDelete}   onAdd={handleAdd}
  ▼
NoteList → NoteItem  (delete button) ─── event UP ──▶ App.handleDelete → api.deleteNote → setNotes
AddNoteModal (submit form)           ─── event UP ──▶ App.handleAdd    → api.createNote → setNotes
```
**One rule:** App owns the state and the API calls; children display props and fire events up.
That's "lifting state up" — the same lesson from React basics, in a real app.

## Run it
Backend on :3001, then `npm run dev` here → open http://localhost:5175.
