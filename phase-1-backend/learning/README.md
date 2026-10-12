# Phase 1 — Backend API (v1) 🔌

**What v1 is:** the first version of the note app is a **backend API** — an Express server
(in **TypeScript**) that stores notes and exposes them over HTTP. No frontend in this ladder
(that's AI-assisted separately). No database yet — notes live in an in-memory array; the
database comes in **v2**.

This is the foundation: a real server you can hit with Thunder Client / curl.

## The one idea: an API is a set of HTTP endpoints over some data

```
GET    /notes       → list all notes
GET    /notes/:id   → one note
POST   /notes       → create a note        (JSON body)
DELETE /notes/:id   → delete a note
```

The server owns the notes (in-memory for now) and answers these requests with JSON.

## Stack for this ladder (decided)

```
TypeScript + Node   — the language + runtime (TS = JS + types; safer, employable)
Express             — the web framework (you know it; we add TS on top)
→ later: NestJS     — the structured, scalable framework (your real "expert" weapon)
→ v2: PostgreSQL + Prisma
```

## Concepts in this version
- **TypeScript basics for backend** — typing `req`/`res`, a `Note` type, `tsx` to run TS directly
- **Express** — `app`, `Router`, controllers, `express.json()`, `cors()`
- **REST** — methods → actions; **status codes** 200/201/400/404/500
- **Request shape** — `req.params`, `req.query`, `req.body`
- **The skeleton** — `find → bail (404) → act → respond`

## Build plan for `note-app-v1-backend` (TypeScript)
```
npm init -y ; npm i express cors ; npm i -D typescript tsx @types/node @types/express
npx tsc --init                         # tsconfig
src/
  server.ts            — express app, cors, json, mount router, listen(3001)
  routes/notes.ts      — GET / , GET /:id , POST / , DELETE /:id
  controllers/notes.ts — the logic (in-memory array, typed as Note[])
# run:  "dev": "tsx watch src/server.ts"
```

## Drills
- [drills/note-controllers.js](./drills/note-controllers.js) — the 4 note operations as logic (in-memory). Written in JS for the refresher; the exact same logic, typed, becomes your TS controllers.

Refresher pace (you know Express). See [express-cheatsheet.md](./express-cheatsheet.md).
Say **"deepen phase 1"** for more drills (incl. a TypeScript setup walkthrough), or
**"let's build v1"** to start the real thing in TypeScript.
