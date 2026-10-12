# Note App v2 — with Database 🗄️

**Yours to build.** (You create files, install deps, write all code.)

**Goal:** make notes survive restarts by storing them in **PostgreSQL**. Understand the raw
SQL/`pg` layer, then use **Prisma** (TypeScript ORM) for the actual build. Take v1's
controllers and swap the in-memory array for `prisma.note.*` calls.

Build plan (see [`../learning/`](../learning/)):
```
Create notes_db → add Prisma (schema.prisma model Note) → npx prisma migrate dev
Rewrite controllers: prisma.note.findMany / create / delete  (replacing the array)
.env: DATABASE_URL (gitignored!)
```

The routes/server barely change — only the controllers' storage lines do. When ready, say
**"let's build v2"** and I'll give build order + hints.
