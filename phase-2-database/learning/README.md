# Phase 2 — Database (v2) 🗄️

**What v2 adds:** a **real database** (PostgreSQL). In v1 the notes lived in a server
variable (`let notes = []`) — gone on every restart. Now they live in Postgres, so they
**survive restarts, crashes, and deploys**. This is what makes it a real app.

## The one idea: swap the array for a table

```
v1:  let notes: Note[] = []  →  notes.find/push/filter
v2:  a `notes` table         →  SELECT / INSERT / DELETE  (via Prisma or raw SQL)
```

Your controller **shape stays identical** (`find → bail → act → respond`). Only the storage
line changes.

## Two layers — learn both, use the top one

```
UNDERNEATH:  raw SQL + the `pg` driver   ← understand this (what's really happening)
ON TOP:      Prisma (TypeScript ORM)     ← what startups actually use day-to-day
```
You'll grasp the raw layer (so Prisma is never magic), then use **Prisma** for the build —
type-safe, fast, and the modern startup default.

## Concepts in this version
- **SQL CRUD** — `CREATE TABLE`, `INSERT`, `SELECT`, `UPDATE`, `DELETE`
- **Relational basics** — a `notes` table, columns, types, primary key
- **Prisma** — `schema.prisma` (model Note), `prisma migrate`, `prisma.note.findMany/create/delete`
- **(under the hood)** the `pg` driver — `pool.query`, parameterized `$1` (anti SQL-injection)
- **Secrets** — `DATABASE_URL` in `.env` (gitignored)

## Build plan for `note-app-v2-database`
```
1. Install + spin up Postgres; create a notes_db.
2. (understand) write the raw SQL CRUD once in psql — see what Prisma generates.
3. Add Prisma: npm i prisma @prisma/client ; npx prisma init
      - define model Note in schema.prisma
      - npx prisma migrate dev  (creates the table)
4. Rewrite v1's controllers to use prisma.note.* instead of the in-memory array.
```

## Drills
- [drills/notes-table.sql](./drills/notes-table.sql) — the raw SQL CRUD (run in psql, to see the real layer).
- [drills/wire-pg.js](./drills/wire-pg.js) — one array op → one real `pool.query` (the raw driver).

Refresher pace (you did a full SQL curriculum before). See [sql-pg-cheatsheet.md](./sql-pg-cheatsheet.md).
Say **"deepen phase 2"** for a Prisma-focused drill set, or **"let's build v2"** to start.
