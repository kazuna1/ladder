# Auth Cheatsheet (keep this open)

The syntax reference. Concepts live in the other docs — this is the "how do I call it".

## Install

```bash
npm install express pg bcryptjs jsonwebtoken
# bcryptjs = pure JS (no build tools). jsonwebtoken = JWT sign/verify.
```

## bcryptjs — password hashing

```js
import bcrypt from "bcryptjs";

// Hash (on REGISTER). saltRounds = cost factor (10–12 typical). Salt is automatic.
const hash = await bcrypt.hash(plainPassword, 10);   // → "$2a$10$....." (60 chars). Store THIS.

// Compare (on LOGIN). Reads the salt out of the stored hash for you.
const ok = await bcrypt.compare(plainPassword, storedHash);  // → true | false
```

- Store the 60-char hash in the DB. Never the plain password.
- `compare` returns a boolean. `true` = correct password.

## jsonwebtoken — signing & verifying tokens

```js
import jwt from "jsonwebtoken";

// SIGN (on successful LOGIN). Payload = non-secret identity. Never put a password in it.
const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET, { expiresIn: "1h" });

// VERIFY (on every PROTECTED request). Throws if invalid/expired/tampered.
const payload = jwt.verify(token, process.env.JWT_SECRET);  // → { userId: 7, iat, exp }

// DECODE without verifying (rarely used — does NOT check the signature; don't trust it):
const unsafe = jwt.decode(token);
```

Common `expiresIn` values: `"15m"`, `"1h"`, `"7d"`. Errors thrown by `verify`:
`TokenExpiredError`, `JsonWebTokenError` (bad signature/malformed).

## The Authorization header (how the client sends the token)

```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjd9.abc123
               └─scheme─┘ └──────────────────── the token ────────────────────┘
```

Read it in Express:
```js
const header = req.headers.authorization;      // "Bearer eyJ..."
const token  = header?.split(" ")[1];           // → "eyJ..."   (grab the part after "Bearer ")
```

## Auth middleware skeleton (the gate)

```js
// The SHAPE only — you write the logic in module 04.
export function requireAuth(req, res, next) {
  // 1. read the Authorization header
  // 2. no header / wrong format → 401
  // 3. jwt.verify(token, secret)  inside try/catch → catch = 401
  // 4. attach the payload:  req.user = payload
  // 5. next()
}

// Use it to protect a route:
app.get("/notes", requireAuth, getNotes);   // middleware runs BEFORE the controller
```

## Status codes for auth

| Code | Meaning | When |
|---|---|---|
| `200` | OK | login success, protected read works |
| `201` | Created | register success |
| `400` | Bad Request | missing email/password in the body |
| `401` | Unauthorized | *WHO?* — no token, bad token, wrong password |
| `403` | Forbidden | *NOT ALLOWED* — valid user, but not *their* resource |
| `409` | Conflict | register with an email that already exists |

**401 vs 403:** 401 = "I don't know you" (authentication). 403 = "I know you, but no"
(authorization).

## users table (Postgres)

```sql
CREATE TABLE users (
  id            INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  email         TEXT UNIQUE NOT NULL,      -- UNIQUE stops duplicate accounts
  password_hash TEXT NOT NULL,             -- the bcrypt hash, NOT the password
  created_at    TIMESTAMPTZ DEFAULT now()
);
```

## .env (never commit this)

```
PGPASSWORD=your_db_password
JWT_SECRET=some_long_random_string_change_me
```

Run with: `node --env-file=.env server.js`

## The whole flow in 6 lines

```
register: hash password        → INSERT user            → 201
login:    bcrypt.compare        → jwt.sign({userId})     → { token }
request:  Authorization: Bearer → jwt.verify → req.user  → return that user's data
```
