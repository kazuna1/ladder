# SQL — Simple Cheatsheet

Your reference for the whole database part. SQL is **CRUD one layer down** — you
already own the concepts; this is the syntax.

> **Convention:** SQL keywords are written UPPERCASE (`SELECT`, `FROM`) and your names
> lowercase (`notes`, `title`). SQL doesn't *require* it, but everyone does it for
> readability. **Every statement ends with a semicolon `;`.**

---

## 0. Talking to Postgres: `psql`

`psql` is Postgres's own terminal — you type SQL, it answers. Connect like this:

```bash
psql -U postgres -d ladder_notes      # -U = user, -d = database
```

Handy psql meta-commands (start with a backslash, NOT SQL — no semicolon):
```
\l          list all databases
\c dbname   connect to a database
\dt         list tables in the current database
\d notes    describe the "notes" table (its columns/types)
\q          quit psql
```

Create a database to play in (run once):
```sql
CREATE DATABASE ladder_notes;
```

---

## 1. CREATE TABLE — define the shape (do this once)

A table needs a name and **columns, each with a type**:

```sql
CREATE TABLE notes (
  id     INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title  TEXT NOT NULL,
  body   TEXT DEFAULT ''
);
```

Line by line:
- **`id INTEGER GENERATED ALWAYS AS IDENTITY`** — the database auto-assigns the id
  (1, 2, 3...). No more `Date.now()`! **`PRIMARY KEY`** = "this is the unique identifier;
  no duplicates, never null."
- **`title TEXT NOT NULL`** — text, and **required** (the DB rejects a note with no
  title — your `if (!title)` guard, enforced by the database itself).
- **`body TEXT DEFAULT ''`** — text, optional; if not given, it's an empty string.

### Common data types
| Type | Holds | Example |
| --- | --- | --- |
| `INTEGER` | whole numbers | `42` |
| `TEXT` | any length string | `'hello world'` |
| `VARCHAR(100)` | string, max length | `'short'` |
| `BOOLEAN` | true / false | `true` |
| `TIMESTAMP` | date + time | `2026-08-24 10:00` |

### Common constraints (rules the DB enforces)
| Constraint | Means |
| --- | --- |
| `PRIMARY KEY` | unique identifier for the row |
| `NOT NULL` | this column can't be empty |
| `DEFAULT x` | if not provided, use `x` |
| `UNIQUE` | no two rows can share this value |

> ⚠️ **Strings use SINGLE quotes** in SQL: `'hello'`. Double quotes `"..."` mean
> something else (a column/table name). This trips up everyone once.

---

## 2. INSERT — create a row (= POST / push)

```sql
INSERT INTO notes (title, body) VALUES ('Buy milk', '2 liters');
```
- You list the **columns** you're filling, then the **VALUES** in the same order.
- You DON'T give `id` — the database generates it.

Get the new row back (like your `res.json(newNote)`):
```sql
INSERT INTO notes (title, body) VALUES ('Buy milk', '2 liters') RETURNING *;
```
**`RETURNING *`** = "and hand me back the row you just made" (with its new id).

---

## 3. SELECT — read rows (= GET)

```sql
SELECT * FROM notes;                 -- all columns, all rows  (GET /notes)
SELECT title, body FROM notes;       -- only these columns
SELECT * FROM notes WHERE id = 1;    -- one specific row       (GET /notes/:id)
```
- **`*`** = all columns.
- **`WHERE`** = the filter — which rows to include (this is your `.find()` / `.filter()`).

### WHERE conditions
```sql
WHERE id = 1;                        -- equals
WHERE title = 'Buy milk';            -- string match (single quotes!)
WHERE id > 5;                        -- greater than
WHERE title LIKE '%milk%';           -- contains "milk" (% = wildcard)
```

### Sorting & limiting
```sql
SELECT * FROM notes ORDER BY title;         -- A→Z by title
SELECT * FROM notes ORDER BY id DESC;        -- newest first (DESC = descending)
SELECT * FROM notes ORDER BY id DESC LIMIT 10;  -- just the first 10
```

---

## 4. UPDATE — change rows (= PUT)

```sql
UPDATE notes SET title = 'Buy oat milk' WHERE id = 1;
```
- **`SET`** = which columns to change (this is your `note.title = title`).
- **`WHERE`** = which rows. Change multiple columns with commas:
```sql
UPDATE notes SET title = 'New', body = 'Updated' WHERE id = 1 RETURNING *;
```

> 🚨 **NEVER forget the `WHERE`.** `UPDATE notes SET title = 'x';` (no WHERE) changes
> **EVERY row in the table.** Same for DELETE. The WHERE is what makes it "just this one."

---

## 5. DELETE — remove rows (= DELETE / filter)

```sql
DELETE FROM notes WHERE id = 1;
DELETE FROM notes WHERE id = 1 RETURNING *;   -- and show me what I deleted
```
Same rule: **always include `WHERE`**, or you wipe the whole table.

---

## The CRUD ↔ SQL bridge (the whole point)

| Your endpoint | Your JS (array) | SQL |
| --- | --- | --- |
| `GET /notes` | `notes` | `SELECT * FROM notes;` |
| `GET /notes/:id` | `notes.find(n => n.id === id)` | `SELECT * FROM notes WHERE id = 1;` |
| `POST /notes` | `notes.push(newNote)` | `INSERT INTO notes (...) VALUES (...) RETURNING *;` |
| `PUT /notes/:id` | `note.title = title` | `UPDATE notes SET title = '...' WHERE id = 1 RETURNING *;` |
| `DELETE /notes/:id` | `notes.filter(n => n.id !== id)` | `DELETE FROM notes WHERE id = 1 RETURNING *;` |

**Read it left to right: the endpoint you built → the array code you wrote → the SQL
that replaces it.** Nothing new conceptually — `SELECT`=read, `INSERT`=create,
`UPDATE`=update, `DELETE`=delete.

---

## Quick reference

| Statement | Job | CRUD |
| --- | --- | --- |
| `CREATE TABLE` | define a table's shape | (setup) |
| `INSERT INTO ... VALUES` | add a row | Create |
| `SELECT ... FROM ... WHERE` | read rows | Read |
| `UPDATE ... SET ... WHERE` | change rows | Update |
| `DELETE FROM ... WHERE` | remove rows | Delete |
| `RETURNING *` | give back the affected row(s) | — |
| `ORDER BY`, `LIMIT` | sort / cap results | — |

## The mental model

```
CREATE TABLE  → build the shelf
INSERT        → put a thing on it
SELECT        → look at what's on it   (WHERE = look at only some)
UPDATE        → change a thing on it   (WHERE = only this one)
DELETE        → take a thing off it    (WHERE = only this one)
```

**`WHERE` is the "which rows" filter — the single most important word in SQL.** With
it, you touch one row. Without it, you touch them all. Never forget it on UPDATE/DELETE.
