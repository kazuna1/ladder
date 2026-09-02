# Phase 7 — Full-Stack 🔌

You've built every layer separately — React (frontend), Express + PostgreSQL (backend).
This phase **wires them together** into one working application: a UI that reads and
writes real data in your database, through your own API.

This is where it all becomes *an app*.

## The parts (in order)

```
Part 1 · connecting-frontend-and-backend   → React ⇄ your Notes API ⇄ Postgres
                                              (the wiring + CORS + the notes app)
Part 2 · auth (later)                        → signup/login, hashed passwords, JWT,
                                              protected routes — make it multi-user
Part 3 · deployment (later)                  → put it live on the internet
```

**Part 1 is built and ready.** Later parts get set up when you reach them.

## The big idea

```
   React app (browser, :5175)
        │  fetch()  ── HTTP ──▶
        ▼
   Express API (:3001)  ──SQL──▶  PostgreSQL
        ▲
        └── JSON back ── to React ── renders on screen
```

Two separate programs (frontend + backend) talking over HTTP — exactly how real
companies structure things. Everything you already know (React, fetch, Express, SQL)
stays the same; the new part is **connecting your own two halves** — and the one new
concept that makes it work: **CORS**.

Start with **[part-1-connecting-frontend-and-backend/](./part-1-connecting-frontend-and-backend/)**.
