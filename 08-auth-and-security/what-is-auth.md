# What is Auth? (the whole mental model)

## The problem, in one sentence

Your API has no idea who is calling it. `DELETE /notes/5` works for *anyone*. We need
the server to (1) know **who** is asking, and (2) decide **whether they're allowed**.

## Two words, kept separate

| Word | Question | Example |
|---|---|---|
| **Authentication** (authn) | *Who are you?* | Logging in with email + password |
| **Authorization** (authz) | *What are you allowed to do?* | "You can delete *your* note, not mine" |

You always do authentication **first** (find out who), then authorization (check what).
A bouncer checks your ID (authn), then checks if your name is on the list (authz).

## The core challenge: HTTP has no memory

HTTP is **stateless**. Every request is a stranger knocking on the door. Request #2
doesn't "remember" that request #1 logged in. The server forgets you the instant it
replies. So how does a website keep you logged in across many requests?

Two classic answers:

### Option A — Sessions (the old way)
1. You log in. The server creates a **session** in its own memory/database:
   `session abc123 → user 7`.
2. It sends you a cookie holding `abc123`.
3. Every request, your browser auto-sends the cookie. The server looks up `abc123`
   in its store, finds "user 7", and knows it's you.

**The catch:** the server must *store and look up* every session. With millions of
users across many servers, that shared store becomes a bottleneck. (Solvable, but heavy.)

### Option B — Tokens / JWT (the modern API way) ← we use this
1. You log in. The server builds a **signed token** that literally *contains*
   `{ userId: 7 }`, signs it with a secret key, and hands it to you.
2. You store the token and send it on every request (in a header).
3. The server **verifies the signature** and reads `userId: 7` straight from the token.
   **It stores nothing.** No lookup. The token itself is the proof.

The magic: the token is **tamper-proof**. If you try to change `7` to `8`, the
signature breaks and the server rejects it. (That's the [JWT deep-dive](./how-jwt-works.md).)

```
Sessions: server remembers you  (state lives on the server)
Tokens:   you carry the proof    (state lives in your pocket — stateless server)
```

We build **token-based auth** because it fits APIs, scales cleanly, and is what
Spring Boot + most backends use too. (The concept transfers 100%.)

## The full flow you're about to build

```
REGISTER (once):
  client → POST /register {email, password}
  server → hash the password, save user to DB, respond 201

LOGIN (each session):
  client → POST /login {email, password}
  server → find user, compare password to the stored hash
           match?  → sign a JWT { userId } → respond { token }
           no match? → 401 Unauthorized

EVERY PROTECTED REQUEST after that:
  client → GET /notes   with header:  Authorization: Bearer <token>
  server → middleware verifies the token → attaches req.user = { userId }
           → controller now knows who's asking → returns only THEIR data
```

## Two things people confuse — nail these

- **Hashing ≠ encryption.** We *hash* passwords (one-way, can't be reversed — even we
  can't read them). We *sign* tokens (also not encryption — the token is readable, it's
  just tamper-proof). More in [security-basics.md](./security-basics.md).
- **401 vs 403.** `401 Unauthorized` = "I don't know who you are" (missing/bad token —
  an *authentication* failure). `403 Forbidden` = "I know who you are, but you can't do
  this" (an *authorization* failure). Wrong password → 401. Deleting someone else's
  note → 403.

## Where this fits your journey

This is the first "mid-level" backend topic. Once you own auth, you understand the
shape of *every* real app: users, protected data, permissions. And it's identical in
Spring Boot (`Spring Security` + JWT) — you'll just re-type it in Java later.

Next: **[how-jwt-works.md](./how-jwt-works.md)** — open the token up and look inside.
