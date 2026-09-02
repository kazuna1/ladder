# What Is "Full-Stack"? — The Big Picture

Read this first. It's short — most of it you already know. The goal is to see how your
separate pieces become ONE app, and to understand the one genuinely new thing: **CORS**.

## Full-stack = your frontend and backend, talking

You've built both halves. "Full-stack" just means running them **together** so they
communicate:

```
┌─────────────────────────────┐         ┌──────────────────────────────┐
│  FRONTEND                    │         │  BACKEND                     │
│  React app in the browser    │  fetch  │  Express API                 │
│  http://localhost:5175       │ ──────▶ │  http://localhost:3001       │
│                              │ ◀────── │        │                     │
│  shows notes, forms, buttons │  JSON   │        ▼                     │
└─────────────────────────────┘         │  PostgreSQL (your data)      │
                                        └──────────────────────────────┘
```

- The **frontend** (React, port 5175) shows the UI and handles clicks.
- The **backend** (Express, port 3001) answers requests and talks to Postgres.
- They talk over **HTTP** with `fetch` — the exact skill from Phase 4, but now pointed
  at **your own** API instead of GitHub's.

**Two separate programs, two separate ports.** This is normal and realistic — most
real companies run the frontend and backend as separate apps that communicate over
HTTP. You already have both; now you connect them.

## Nothing here is new... except one thing

| Piece | You already know it from |
| --- | --- |
| React components, state, `useEffect` | Phase 3 |
| `fetch`, async/await, loading/error | Phase 4 |
| The Express API, routes, controllers | Phase 5 |
| PostgreSQL + pg | Part 3 |
| **CORS** | ⬅️ **the ONE new concept** |

## CORS — the one new thing (and why it exists)

When your React app (`localhost:5175`) tries to `fetch` from your backend
(`localhost:3001`), the **browser blocks it** by default. You'll see an error like:

```
Access to fetch at 'http://localhost:3001/notes' from origin
'http://localhost:5175' has been blocked by CORS policy.
```

### What's happening
An **origin** = protocol + host + port. `localhost:5175` and `localhost:3001` are
**different origins** (different ports). Browsers have a security rule — the
**same-origin policy** — that says: *"by default, a web page can only call its OWN
origin. Calling a different origin is blocked."*

### Why this rule exists (it's protecting users)
Imagine you're logged into your bank in one tab. Without this rule, a *malicious* site
in another tab could quietly `fetch` your bank's API using your logged-in session and
steal your data. The same-origin policy stops that: a page can't just call any other
site's backend. Good — but it also blocks *your own* frontend from calling *your own*
backend, because they're on different ports.

### CORS = the backend saying "these origins are allowed"
**CORS** (Cross-Origin Resource Sharing) is how the **backend** grants permission. Your
Express server adds a header that says *"I allow requests from other origins."* Then the
browser lets your React app through.

In Express, it's basically **one line** (with the `cors` package):
```js
import cors from "cors";
app.use(cors());          // "allow requests from other origins" (fine for local dev)
```

> **CORS is the backend's permission slip.** The browser blocks cross-origin calls for
> safety; the backend uses CORS to say "these origins are OK." One line unblocks your
> own frontend.

(In production you'd restrict it to *your* frontend's domain, e.g.
`cors({ origin: "https://myapp.com" })`. For local dev, plain `cors()` is fine.)

## The request round-trip (the whole app in one flow)

```
1. React:    useEffect → fetch("http://localhost:3001/notes")
2. Browser:  checks CORS → backend allows it → request goes through
3. Express:  route → controller → pool.query("SELECT * FROM notes")
4. Postgres: returns the rows
5. Express:  res.json(rows)
6. Browser:  hands the JSON back to React
7. React:    setNotes(data) → re-render → notes appear on screen
```

Steps 1, 6, 7 = React + fetch (yours). Steps 3–5 = your backend + DB. **Step 2 (CORS)
is the only new gate** — and one line opens it.

## What you'll build in Part 1

A small React **notes app** that:
- **loads** your notes from the database (`GET /notes`) and lists them
- has a **form** to add a note (`POST /notes`) — it appears *and persists*
- has **delete** buttons (`DELETE /notes/:id`) — gone from the UI *and* the database

Refresh the page, restart everything — the notes are still there, because they live in
Postgres. **That permanence, driven from a UI you built, is a real full-stack app.**

**Next:** read [cors-and-fetch-cheatsheet.md](./cors-and-fetch-cheatsheet.md), then the
[README.md](./README.md) to run both servers and start building. 🚀
