# Module 04 — Protected Routes (the gate)

You have tokens, but no door checks them yet. This module builds the **auth
middleware** — one function that stands in front of protected routes, verifies the
token, and either lets the request through (knowing *who* it is) or slams a `401`.

This closes the last "frontend must-know" gap too: how the client sends the token
(`Authorization: Bearer <token>`) and how the server reads it.

## Step 1 — Write `requireAuth` middleware

A middleware is just `(req, res, next) => {...}`. You've seen `express.json()` and
`cors()` — this is your own. Build it by hand:

1. Read the header: `req.headers.authorization` → looks like `"Bearer eyJ..."`.
2. Missing, or doesn't start with `"Bearer "`? → `401` (and `return`).
3. Extract the token: the part after `"Bearer "` (`.split(" ")[1]`).
4. `jwt.verify(token, process.env.JWT_SECRET)` **inside a try/catch**.
   - `catch` (expired/tampered/bad) → `401` and `return`.
5. Success → attach the identity: `req.user = payload` (so `req.user.userId` is available).
6. `next()` — hand control to the actual controller.

Hints:
- The whole thing is ~10 lines. It's the "find → bail → act → next" skeleton again.
- `req.user` is a convention: middleware *adds* info to `req` that later handlers read.
  This is exactly how `express.json()` adds `req.body`.

## Step 2 — Protect routes with it

Put the middleware *before* the controller in the route definition:

```js
// shape only — you wire your real routes
router.get("/notes",     requireAuth, getNotes);    // must be logged in
router.post("/notes",    requireAuth, createNote);
router.delete("/notes/:id", requireAuth, deleteNote);
```

Middleware runs **left to right**: `requireAuth` runs first; only if it calls `next()`
does the controller run. No valid token → the controller never even executes.

## Step 3 — Test the gate

```
GET /notes  with NO Authorization header          → 401
GET /notes  with  Authorization: Bearer <garbage> → 401
GET /notes  with  Authorization: Bearer <real>    → 200  ✅
```

In Thunder Client: log in, copy the `token`, then add a header
`Authorization: Bearer <paste token>` to your protected requests.

## What you've built

A reusable gate. *Any* route you put `requireAuth` in front of now requires a valid
login, and inside those controllers you can trust `req.user.userId`. That id is the
bridge to the next idea — making data belong to a user.

Next: **[05-authorization-and-ownership](../05-authorization-and-ownership/)** —
"you can only touch *your own* notes." (Outline for now; I'll flesh out its drills when
you reach it.)
