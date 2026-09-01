# What Is a Database? — The Big Picture

Read this **before** the SQL cheatsheet. Concept first, syntax second.

---

## Go feel the wall first (do this now)

Start your Notes API, create a few notes in Postman, then **stop the server**
(`Ctrl+C`) and start it again. Now `GET /notes`:

```json
[]
```

**Everything's gone.** Every note you ever created — destroyed. Why? Because
`let notes = []` is a variable in your program's **memory (RAM)**, and memory is
wiped every time the program stops. Your data was never actually *saved* anywhere.

That emptiness is the entire reason databases exist. It's the backend version of the
manual-DOM-syncing pain that made you want React — a wall you feel, then the tool that
fixes it.

---

## The one-line answer

**A database is a separate program whose whole job is to store your data on disk
(permanently), and let you ask for exactly the data you want.**

Two words matter: **permanently** (survives restarts, crashes, reboots — it's on the
hard drive, not in RAM) and **ask** (you query it with a language called SQL).

---

## What a database actually looks like (you already know this shape)

A database stores data in **tables**. And a table is just... an **array of objects**.
You already think in this shape. Look:

**Your Notes API, right now (JavaScript in memory):**
```js
let notes = [
  { id: 1, title: "Buy milk", body: "2 liters" },
  { id: 2, title: "Call mom", body: "" },
];
```

**The same data, as a database table:**
```
                    TABLE: notes
   ┌──────┬─────────────┬────────────┐
   │  id  │   title     │    body    │   ← COLUMNS (the fields)
   ├──────┼─────────────┼────────────┤
   │  1   │ Buy milk    │ 2 liters   │   ← a ROW (one note)
   │  2   │ Call mom    │            │   ← another ROW
   └──────┴─────────────┴────────────┘
```

The mapping is direct — you already own this mental model:

| JavaScript | Database | 
| --- | --- |
| the `notes` **array** | a **table** named `notes` |
| one note **object** `{...}` | one **row** |
| a **property** (`title`) | a **column** |
| the array lives in **RAM** (dies) | the table lives on **disk** (survives) |

> **A table is an array of objects that lives on disk instead of in memory. That's the
> whole leap.** Same shape you've used since Phase 1 — now permanent.

---

## Why not just save to a file myself?

Fair question — you *could* write `notes` to a `.json` file and read it back. People
do for tiny things. But databases exist because that breaks down fast:

- **Speed at scale.** Find one note among 10 million? A database does it instantly
  (indexes). Searching a giant JSON file means loading and scanning the whole thing.
- **Many things at once.** Two requests writing the same file at the same moment
  corrupt it. Databases handle concurrent access safely.
- **Rules (integrity).** A database can *enforce* "every note MUST have a title" or
  "no two notes share an id" — the data can't go bad. A file trusts you to never slip.
- **Querying.** "Give me notes created this week, sorted by title, first 10" is one
  line of SQL. In a file, you'd hand-write all that filtering/sorting logic.

A database is a specialist built for exactly one job — storing and fetching data
correctly, fast, at any scale.

---

## SQL — the language you talk to it in

You don't poke at the database's files directly. You **send it commands in a language
called SQL** (Structured Query Language), and it does the work and hands back rows.

Here's the beautiful part: **SQL is CRUD, one layer down.** You already spent weeks
doing Create/Read/Update/Delete over HTTP. SQL is the *same four operations*, new
syntax:

| What you know (HTTP) | Your JS code now | SQL (new syntax, same idea) |
| --- | --- | --- |
| `GET /notes` | `notes` | `SELECT * FROM notes;` |
| `GET /notes/:id` | `notes.find(n => n.id === id)` | `SELECT * FROM notes WHERE id = 1;` |
| `POST /notes` | `notes.push(newNote)` | `INSERT INTO notes (...) VALUES (...);` |
| `PUT /notes/:id` | `note.title = title` | `UPDATE notes SET title = '...' WHERE id = 1;` |
| `DELETE /notes/:id` | `notes.filter(...)` | `DELETE FROM notes WHERE id = 1;` |

**You are not learning new concepts. You're learning new words for concepts you own.**
`SELECT` = read, `INSERT` = create, `UPDATE` = update, `DELETE` = delete. That's it.

---

## "Relational" and Postgres

You're learning **PostgreSQL** (Postgres) — a **relational** database. "Relational"
just means: data lives in tables, and tables can be **related** to each other (a
`users` table and a `notes` table, where each note belongs to a user). You'll start
with one table; relationships come later.

Postgres is the serious, industry-standard choice — free, powerful, everywhere. You
chose raw Postgres + SQL over shortcut tools (Supabase, ORMs) on purpose: **learn the
fundamental, and every shortcut later makes sense.** Good call.

---

## How this plugs into your Notes API (the payoff)

Remember Part 2 — you separated logic into **controllers**, and the data (`let notes`)
lived there. That was on purpose. When you swap the array for a database:

```
BEFORE:  controller does  notes.find(n => n.id === id)      (array in RAM)
AFTER:   controller does  SELECT * FROM notes WHERE id = $1  (real database)
```

**Only the controller changes.** Your routes and server never move. *That* is why you
structured the backend in Part 2 — so the storage could be swapped underneath without
touching anything else. You're about to feel that pay off.

---

## The mental model

```
        your Express app                 PostgreSQL (a separate program)
   ┌──────────────────────┐   SQL query   ┌───────────────────────────────┐
   │ controller:          │ ────────────▶ │  tables on DISK (permanent)   │
   │  "SELECT * FROM       │               │   notes: [row, row, row...]   │
   │   notes WHERE id=$1"  │ ◀──────────── │                               │
   └──────────────────────┘    rows back  └───────────────────────────────┘
```

Your app *asks* (SQL), the database *stores and answers* (rows). Two programs talking.

---

## The plan (slow, in order)

1. **Install Postgres** (a real service on your machine).
2. **Learn SQL in `psql`** — the database's own terminal. NO JavaScript yet. Just you
   and SQL, mapping CRUD onto commands. (The drills.)
3. **`npm install pg`** — the driver that lets your Express app send SQL to Postgres.
4. **Port your Notes API** — swap `let notes = []` for real SQL, one controller at a
   time. Controllers become `async` (talking to a database takes time).

Do step 2 until SQL feels *boring* before touching step 3. Learn one new thing at a
time — SQL alone first, then wiring it to Node. That's the whole reason we don't rush.

**Next:** read [sql-cheatsheet.md](./sql-cheatsheet.md), then start the drills in `psql`. 🚀
