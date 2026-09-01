# Module 06 — Updating (Update)

`UPDATE` changes existing rows — the **U** in CRUD (your `PUT`). The critical habit:
**always include `WHERE`**, or you change *every row*.

## What you'll learn
- `UPDATE table SET col = value WHERE ...`
- Update **multiple columns** at once
- Update using **expressions** (`price = price * 1.1`)
- `RETURNING *` to see the changed row
- The **WHERE-or-disaster** rule

## Prereq
The `books` table. (You'll modify it — re-seed from Module 02 drill 03 if needed.)

## Drills
- **01-update-basics** — SET one/many, WHERE, RETURNING
- **02-update-expressions** — compute new values, conditional updates

Say **"review"** after a drill.
