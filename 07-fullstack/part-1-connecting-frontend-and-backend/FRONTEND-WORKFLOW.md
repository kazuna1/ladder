# Frontend Development Workflow (the standard way)

The backend workflow you mastered goes **data-first**: design the schema → entities →
controllers → routes. The frontend workflow goes the **opposite direction — UI-first**:
you start from *what the user sees* and work inward to the data.

This is React's official method, called **"Thinking in React"** — the industry standard.
Follow these steps in order; each has a clear job.

---

## The mindset shift

```
BACKEND  = data-first   → "what data exists? how is it shaped? who can change it?"
FRONTEND = UI-first      → "what does the user SEE? what changes? where does that live?"
```

You already know the *pieces* (components, props, state, lifting, fetch — Phases 3 & 4).
This is the **order to assemble them in** so you don't write spaghetti.

---

## The 7 steps

### Step 1 — Sketch the UI (what does the user see?)
Before any code, picture the screen. A rough sketch on paper or in your head: what
boxes, buttons, lists, forms are on the page? This is your target — like designing the
schema before writing SQL.

### Step 2 — Break the UI into a component hierarchy
Draw boxes around each piece of the UI. Each box = a **component**. Components that sit
*inside* others become **children**. This gives you a tree.
> Rule of thumb: one component = one job (a single responsibility). If a box does two
> unrelated things, split it.

### Step 3 — Build a STATIC version first (no interactivity)
Build all the components with **hardcoded/dummy data**, passing it down as **props**.
**No state, no events, no fetch yet** — just get the *look and structure* right.
> Why: it's far easier to build the skeleton first, then add behavior. You separate
> "what it looks like" from "what it does." (This is the step most beginners skip and
> regret.)

### Step 4 — Find the minimal state
Ask: **what data CHANGES over time?** That, and only that, is **state**. Everything
that can be *computed* from other data, or *passed in* as a prop, is **not** state.
> The test: "Does it change? Can I derive it from something else? Is it passed in?"
> If it changes and can't be derived → it's state.

### Step 5 — Decide WHERE the state lives
For each piece of state, find the **closest common parent** of all the components that
use it, and put the state there. Then pass it **down** as props.
> This is **lifting state up** (Phase 3). State lives as high as it needs to — and no
> higher.

### Step 6 — Add interactivity (one-way data flow)
Now wire it up: `useState` for the state, event handlers (`onClick`, `onSubmit`,
`onChange`) that call the setters. Remember the golden rule:
```
DATA flows DOWN (props)      ·      EVENTS flow UP (function props)
```
A child never changes a parent's state directly — it calls a function the parent gave it.

### Step 7 — Connect to real data (the API)
Replace the dummy data with **`fetch`** to your backend (Phase 4): `useEffect` to load
on mount, `useState` to hold it, and the three states — **loading → error → data**.
Then wire create/delete/update to `POST`/`DELETE`/`PUT`.
> The backend is the source of truth; React state is a copy. After each successful
> write, update state so the screen matches.

*(Then: **style & polish** — CSS last, once it works.)*

---

## The workflow, memorized

```
SEE      → sketch the UI
SPLIT    → break into a component tree
STATIC   → build it with dummy data + props (no state)
STATE    → find the minimal changing data
PLACE    → put state at the closest common parent (lift up)
WIRE     → useState + events (data down, events up)
CONNECT  → fetch the real API (loading → error → data)
```

**UI-first, then data.** You work from the screen inward — the mirror image of backend's
data-first flow.

---

## Applied to YOUR notes app (concrete)

```
Step 1 SEE:     a title, an "add note" form, a list of note cards (each with delete)
Step 2 SPLIT:   <App>
                 ├─ <NoteForm>       (title + body inputs + add button)
                 └─ <NoteList>       (maps notes → <NoteCard>)
                     └─ <NoteCard>   (shows one note + a delete button)
Step 3 STATIC:  render <NoteList> from a hardcoded array of notes, no buttons working yet
Step 4 STATE:   the notes array (changes), form inputs (change), loading/error
Step 5 PLACE:   notes + loading/error live in <App> (NoteList reads them, NoteForm adds)
Step 6 WIRE:    form onSubmit → addNote; card button onClick → removeNote
Step 7 CONNECT: useEffect → GET /notes; addNote → POST; removeNote → DELETE
```

For a small app you can collapse this — even build it all in `App.jsx` first, then
split into components once it works. But the *order of thinking* stays: **see → split →
static → state → place → wire → connect.**

---

## The daily dev loop (once you know the shape)

```
1. build/change a component with dummy data      (see it render)
2. run `npm run dev`, look at localhost:5175      (tight feedback loop)
3. add state + events                             (make it interactive)
4. connect to the API                             (make it real)
5. adjust, refresh, repeat
```

Frontend development is **visual and iterative** — you change code, glance at the
browser, adjust. Keep the dev server running and let the page reload guide you.

---

## Sources
- [Thinking in React — react.dev (official)](https://react.dev/learn/thinking-in-react)
- [React Basics: Thinking in React — Telerik](https://www.telerik.com/blogs/react-basics-thinking-react)
- [My approach to React app architecture in 2025 — LaunchDarkly](https://launchdarkly.com/docs/blog/react-architecture-2025)
- [React State Management in 2025 — Developer Way](https://www.developerway.com/posts/react-state-management-2025)
