# Auth — the whole thing on one page

## The ONE sentence

> **On register you store a salted bcrypt *hash* of the password; on login you
> bcrypt-*compare* it and hand back a signed *JWT*; on every request after, the client
> sends that token and your *middleware verifies* it to know who's asking.**

Everything below is just that sentence, slowed down.

## There are only ~8 core concepts, in 3 moments

```
MOMENT 1 — REGISTER (happens once per user)
   concepts:  hashing · salt · bcrypt.hash
   ┌──────────────────────────────────────────────────────────────┐
   │  password "qwerty123"                                          │
   │        │                                                       │
   │        ▼  bcrypt.hash(pw, 10)   ← adds a RANDOM salt, slow     │
   │  "$2a$10$Xk9...salt...hash"     ← salt is baked INSIDE          │
   │        │                                                       │
   │        ▼  INSERT into users(email, password_hash)              │
   │  [ DB row: email + the hash ]   ← never store the plain pw     │
   └──────────────────────────────────────────────────────────────┘

MOMENT 2 — LOGIN (happens each session)
   concepts:  bcrypt.compare · jwt.sign · secret · token
   ┌──────────────────────────────────────────────────────────────┐
   │  POST /login {email, password}                                 │
   │        │                                                       │
   │        ▼  SELECT user WHERE email                              │
   │        ▼  bcrypt.compare(typed pw, stored hash)                │
   │              false → 401  "invalid email or password"          │
   │              true  ↓                                           │
   │        ▼  jwt.sign({ userId }, JWT_SECRET, {expiresIn})        │
   │  respond { token: "eyJ...signature" }   ← the tamper-proof ID  │
   └──────────────────────────────────────────────────────────────┘

MOMENT 3 — EVERY REQUEST AFTER (happens constantly)
   concepts:  Authorization: Bearer · jwt.verify · middleware/req.user · (ownership)
   ┌──────────────────────────────────────────────────────────────┐
   │  GET /notes    header:  Authorization: Bearer eyJ...           │
   │        │                                                       │
   │        ▼  requireAuth middleware:                              │
   │            read header → jwt.verify(token, JWT_SECRET)         │
   │              throws → 401                                      │
   │              ok     → req.user = { userId }                    │
   │        ▼  controller runs, trusts req.user.userId              │
   │        ▼  SELECT ... WHERE user_id = req.user.userId           │
   │            (touching someone else's row → 403)                 │
   └──────────────────────────────────────────────────────────────┘
```

## How the concepts connect (the dependency chain)

```
hashing ──needs──▶ salt ──both live in──▶ bcrypt
                                            │  hash()  ── used at ─▶ REGISTER
                                            └  compare()── used at ─▶ LOGIN ─┐
                                                                            │ if match
JWT_SECRET ──signs──▶ jwt.sign ──produces──▶ TOKEN ◀── returned by LOGIN ◀──┘
                                               │
                          client sends it as   ▼
                       Authorization: Bearer ──▶ jwt.verify ──▶ req.user ──▶ ownership check
                                                    ▲
                          JWT_SECRET ──verifies──────┘   (same secret signs AND verifies)
```

Read it as: **bcrypt guards the password half. JWT guards the "stay logged in" half.
`JWT_SECRET` is the one key that both signs (login) and verifies (every request).**

## The two halves (if you remember nothing else)

| Half | Tool | Job | Where used |
|---|---|---|---|
| **Password** | bcrypt | store & check the password safely | register (hash), login (compare) |
| **Session** | JWT | prove who you are without re-login | login (sign), every request (verify) |

## Status codes = the 3 "no"s
```
400 → you sent me garbage (missing fields)
401 → I don't know who you are   (no/bad token, wrong password)   ← authentication
403 → I know you, but not allowed (not your resource)             ← authorization
```
