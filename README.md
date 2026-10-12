# The Note App Ladder 🪜📝

**One project, scaled version by version — my startup warm-up.**

Instead of scattered mini-apps, this repo grows a *single* product — a Note app — one
layer at a time, exactly like a real startup codebase evolves. Each version adds a new
capability (backend → database → auth → real-time → AI → scale…), so by the end I've
lived through the whole journey of building and scaling a real system.

## How each phase works

Every phase has **two folders**:

```
phase-N-topic/
  learning/            ← the lesson: READMEs, drills, cheatsheets, concept maps, homework
  note-app-vN-topic/   ← the build: I apply the lesson to the Note app, by hand
```

- **`learning/`** — guided material (navigator gives hints, I write every line myself).
- **`note-app-vN/`** — the actual product at that version. I own the structure, deps, and code.

## The versions

**Stack:** TypeScript + Node + PostgreSQL + Prisma — Express first, graduating to NestJS.
(Pure backend ladder — frontend is AI-assisted, not part of this.)

| Phase | Version | Adds | Learning | Build |
|---|---|---|---|---|
| [phase-1-backend](./phase-1-backend/) | v1 | backend API (Express/TS, note CRUD) | ✅ ready | ⬜ to build |
| [phase-2-database](./phase-2-database/) | v2 | database (Postgres + Prisma) | ✅ ready | ⬜ to build |
| [phase-3-auth](./phase-3-auth/) | v3 | auth & security (hashing, JWT, protected routes) | 🔵 in progress | ⬜ to build |
| — | v4+ | validation · testing · NestJS · caching · real-time · scale … | decided as I get there | |

> The old scattered learning (data structures, DOM, React, async, raw backend/DB) is done
> and lives in git history — this repo is now the focused **backend** Note-app ladder.
> v1–v2 learning folders are **refreshers** (concept + cheatsheet + a few drills), since the
> material is already known; v3 (auth) is the full deep treatment.

## Where I am

**Phase 4 — Auth.** Learning the auth layer (password hashing ✅, JWT ✅, register/login
logic ✅; protected routes + ownership next), then building it into the Note app.
→ [phase-4-auth/learning/](./phase-4-auth/learning/)

## The goal

Become the person who can **own the whole technical side of a startup** — architecture,
system design, security, infra, deployment — good enough to build, ship, and scale my own
SaaS. This ladder is the training for exactly that.
