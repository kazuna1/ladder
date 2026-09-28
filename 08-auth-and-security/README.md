# Phase 8 — Auth & Security

This is the **mid-backend leap**. Until now your APIs were wide open — anyone who
knew the URL could read, create, or delete anything. Real apps have **users**, and
each user should only touch **their own** data. That's *auth*.

Auth is two words people mash together — keep them separate in your head:

```
Authentication  = WHO are you?      (login — prove your identity)
Authorization   = WHAT can you do?  (permissions — are you allowed?)
```

We climb this **slowly**, primitive-first (like the SQL part): understand each
piece in isolation with tiny `node` scripts, *then* wire them into a real API.

## Read first (concept → reference)

1. **[what-is-auth.md](./what-is-auth.md)** — the whole mental model, plain words.
2. **[how-jwt-works.md](./how-jwt-works.md)** — what a token *actually is* (deep).
3. **[security-basics.md](./security-basics.md)** — hashing, salts, the attacks we defend against.
4. **[auth-cheatsheet.md](./auth-cheatsheet.md)** — the syntax reference (keep it open).

## The learning path (slow, progressive)

```
UNDERSTAND THE PRIMITIVES (tiny isolated node scripts — "see it work")
  01 · password-hashing     bcrypt: hash on register, compare on login   (never store plaintext)
  02 · jwt-tokens           sign a token, verify it, watch tampering fail (the "ID card")

BUILD THE REAL API (by hand, in project-auth-api/)
  03 · register-and-login   users table + POST /register + POST /login    (Authentication)
  04 · protected-routes     auth middleware + `Authorization: Bearer`     (the gate)
  05 · authorization        401 vs 403, "only your own data"              (Authorization)
  06 · security-hardening   secrets, token storage, rate limiting, checklist
```

**Modules 01–04 are built and ready.** 05–06 I'll flesh out with drills when you
reach them — no point overwhelming you now (same as the DB part).

## How each module works

- **01–02** (`drills/*.js`): standalone scripts you run with `node file.js` to *see*
  the mechanism in isolation. TODOs have hints. Library calls (bcrypt/jwt) are shown —
  that's just syntax, like SQL. You type them and watch the output.
- **03–05**: you **build the real endpoints by hand** in [project-auth-api/](./project-auth-api/).
  The READMEs give you the *steps and hints* — the logic is yours to write (my rule).

Say **"review"** after a drill or endpoint and I'll check it + explain.

## The one anchor idea

A login doesn't keep you "logged in" on the server. Instead, on successful login the
server hands you a **signed token** (like a tamper-proof ID card). You show that card
on every future request. The server checks the signature — if valid, it knows who you
are. **No server memory of you between requests.** That's the whole trick. Everything
here is variations on it.

## Homework (stay sharp at home) 🏠

You learn here at the office; you **rebuild it blank at home** to make it stick. See
[homework/](./homework/) — variation challenges (no hint code), unlocked per module as you
finish it at the office. Say **"unlock homework NN"** after clearing office module NN.

## Setup you'll need (once)

In `project-auth-api/` you'll `npm install express pg bcryptjs jsonwebtoken`. We use
**`bcryptjs`** (pure JavaScript — zero build headaches on Windows) rather than `bcrypt`
(native, needs C++ build tools). Same API, same result.

Start with **[what-is-auth.md](./what-is-auth.md)**, then **[01-password-hashing](./01-password-hashing/)**. 🔐
