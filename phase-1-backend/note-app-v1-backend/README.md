# Note App v1 — Backend API (TypeScript) 🔌

**Yours to build.** (You create files, install deps, write all code.)

**Goal:** a backend API for notes — Express + **TypeScript**, notes in an in-memory array,
full CRUD over HTTP. Test it with Thunder Client / curl. No DB yet (that's v2).

Build plan (see [`../learning/`](../learning/)):
```
npm i express cors ; npm i -D typescript tsx @types/node @types/express ; npx tsc --init
src/server.ts            — app + cors + json + router + listen(3001)
src/routes/notes.ts      — GET / , GET /:id , POST / , DELETE /:id
src/controllers/notes.ts — logic (in-memory Note[])
```

When ready, say **"let's build v1"** and I'll give build order + hints (not the code).
