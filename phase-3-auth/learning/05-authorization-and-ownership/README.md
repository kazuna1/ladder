# Module 05 — Authorization & Ownership  (outline)

> **This module is an outline.** I'll flesh out its full drills when you finish 01–04 —
> no point overwhelming you now (same approach as the DB part's module 08).

Authentication answered *who are you?*. **Authorization** answers *what are you allowed
to do?* — the difference between "logged in" and "allowed to touch *this* thing".

## The idea you'll build

Right now any logged-in user can read/delete any note. Real apps scope data to its owner:

1. **Ownership column.** Notes get a `user_id` (foreign key → `users.id`). A note
   *belongs to* the user who created it.
2. **Write with ownership.** On `POST /notes`, set `user_id = req.user.userId` (from the
   token — never trust a user_id sent in the body).
3. **Read your own.** `GET /notes` → `WHERE user_id = $1` with the token's id. Each user
   sees only their notes.
4. **Guard mutations.** On `DELETE /notes/:id`, first fetch the note. If it doesn't exist
   → `404`. If it exists but `note.user_id !== req.user.userId` → **`403 Forbidden`**
   (you're logged in, but it's not yours).

## The 401 vs 403 rule (nail this)

```
401 Unauthorized → "I don't know who you are"  (no/bad token)      → authentication
403 Forbidden    → "I know you, but you can't"  (not your resource) → authorization
```

## Optional stretch — roles

A `role` column (`"user"` / `"admin"`) + a tiny `requireRole("admin")` middleware →
admin-only routes. This is the seed of real permission systems (RBAC).

## Concepts this leans on (you'll have them by now)

- Foreign keys / relationships (DB module 08 mid-level).
- The `requireAuth` middleware from module 04 (it supplies `req.user`).

When you reach here, say **"flesh out module 05"** and I'll build the drills +
the ownership refactor steps.
