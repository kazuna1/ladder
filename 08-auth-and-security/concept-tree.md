# Auth — the full concept tree (every name, one place)

Every concept in Phase 8, as a tree. 🔴 = core (must know now) · ⚪ = later/advanced.
Use this to *name* things and see what belongs under what.

```
AUTH
│
├── 🔴 AUTHENTICATION  ("WHO are you?")
│   │
│   ├── 🔴 Password handling
│   │   ├── 🔴 Hashing ................. turn password into a fingerprint
│   │   │   ├── 🔴 one-way ............. cannot be reversed
│   │   │   └── 🔴 hashing ≠ encryption  (encryption is reversible, hashing isn't)
│   │   ├── 🔴 Salt .................... random value mixed in before hashing
│   │   │   ├── 🔴 unique per password . makes identical passwords hash differently
│   │   │   ├── 🔴 stored inside the hash (not secret!)
│   │   │   └── 🔴 stops rainbow tables  (kills bulk cracking)
│   │   ├── 🔴 bcrypt (we use bcryptjs)  the tool that does hashing + salting
│   │   │   ├── 🔴 bcrypt.hash(pw, saltRounds) → register
│   │   │   ├── 🔴 bcrypt.compare(pw, hash) → login  (returns true/false)
│   │   │   ├── 🔴 salt rounds / cost factor (10–12) — how slow
│   │   │   └── 🔴 slow-on-purpose ..... makes mass guessing expensive
│   │   ├── 🔴 password_hash column .... store THIS, never the plain password
│   │   └── ⚪ pepper ................. a SECRET salt in .env (advanced, optional)
│   │
│   ├── 🔴 Auth endpoints
│   │   ├── 🔴 POST /register .......... hash + INSERT user (409 if email exists)
│   │   └── 🔴 POST /login ............. compare + issue a token (401 if wrong)
│   │
│   ├── 🔴 JWT  (the token = tamper-proof ID card)
│   │   ├── 🔴 structure = header . payload . signature  (3 dot-parts)
│   │   │   ├── 🔴 header ............. algorithm info (HS256)
│   │   │   ├── 🔴 payload / claims ... the DATA — readable! (Base64, not secret)
│   │   │   │   ├── 🔴 userId ......... your custom claim (who it is)
│   │   │   │   ├── 🔴 iat ............ issued-at (auto)
│   │   │   │   └── 🔴 exp ............ expiry (auto, if you set expiresIn)
│   │   │   └── 🔴 signature ......... HMAC(payload, secret) — the tamper-proof seal
│   │   ├── 🔴 JWT_SECRET ............. the ONE key that signs AND verifies (hide it!)
│   │   ├── 🔴 jwt.sign(payload, secret, {expiresIn}) → make a token (login)
│   │   ├── 🔴 jwt.verify(token, secret) → check + read it (every request); throws if bad
│   │   ├── ⚪ jwt.decode(token) ...... reads WITHOUT verifying (don't trust it)
│   │   ├── 🔴 expiry (expiresIn: "1h") . tokens die after a while
│   │   └── 🔴 stateless .............. server stores nothing; the token IS the proof
│   │
│   ├── 🔴 Sending the token
│   │   ├── 🔴 Authorization header .... where the client puts it
│   │   └── 🔴 Bearer scheme ........... "Bearer <token>" — grab part after the space
│   │
│   └── 🔴 Auth middleware  (the gate)
│       ├── 🔴 requireAuth(req, res, next)
│       ├── 🔴 read header → jwt.verify → attach req.user
│       ├── 🔴 req.user = { userId } .... how controllers know who's asking
│       └── 🔴 next() ................... pass to the controller (or 401 and stop)
│
├── 🔴 AUTHORIZATION  ("WHAT are you allowed to do?")
│   ├── 🔴 ownership ................... data belongs to a user
│   │   ├── 🔴 user_id foreign key ..... notes.user_id → users.id
│   │   ├── 🔴 set from req.user ....... never trust a user_id in the body
│   │   └── 🔴 scope reads ............. WHERE user_id = req.user.userId
│   ├── 🔴 403 on someone else's data .. logged in, but not yours
│   └── ⚪ roles / RBAC ............... role column + requireRole("admin")
│
├── 🔴 STATUS CODES  (the answers)
│   ├── 🔴 400 Bad Request ............ missing fields
│   ├── 🔴 401 Unauthorized ........... WHO? (no/bad token, wrong password) = authN
│   ├── 🔴 403 Forbidden .............. NOT ALLOWED (not your resource) = authZ
│   └── 🔴 409 Conflict ............... email already registered
│
└── ⚪ SECURITY HARDENING  (production polish — module 06)
    ├── 🔴 secrets in .env + .gitignore  (JWT_SECRET, PGPASSWORD)
    ├── 🔴 parameterized queries ($1) .. no SQL injection (you already do this)
    ├── 🔴 generic auth errors ......... "invalid email or password" (don't leak)
    ├── ⚪ token storage .............. localStorage vs httpOnly cookie (trade-off)
    ├── ⚪ refresh tokens ............. short access + long refresh = stay logged in
    ├── ⚪ rate limiting .............. cap login attempts (anti brute-force)
    ├── ⚪ helmet ..................... safe HTTP headers
    └── ⚪ CORS origin lock + HTTPS ... in production
```

## The two trunks, one line each
- **Authentication** = *bcrypt* (password) + *JWT* (token). Prove who you are.
- **Authorization** = *ownership* + *roles*. Decide what you may touch.

## Where each concept is taught
```
bcrypt subtree ........... module 01  (drills)
JWT subtree .............. module 02  (drills)
endpoints (register/login) module 03  (build)
header + middleware ...... module 04  (build)
authorization subtree .... module 05  (build)
hardening subtree ........ module 06  (checklist)
```
