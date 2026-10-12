# Module 03 — Register & Login

This module = **Authentication**: the register + login logic. You write it **by hand**
(my rule) — the READMEs and drills give *steps and hints*, not the code.

Two stages, same as always: **learn the logic in isolation (drills), then build it for real.**

## Stage A — Drills (logic in isolation, NO Express, NO database)

Build register/login as plain functions against a fake in-memory `users` array. This
isolates the *flow* from the plumbing. Setup: `npm init -y && npm install bcryptjs jsonwebtoken && npm pkg set type=module`

- **[drills/01-register-function.js](./drills/01-register-function.js)** — `register()`: validate → dup-check → hash → store → return safe user
- **[drills/02-login-function.js](./drills/02-login-function.js)** — `login()`: find → compare → sign token
- **[drills/03-full-auth-flow.js](./drills/03-full-auth-flow.js)** — register → login → verify, the whole engine in one file

Do these first. Say **"review"** after each. Once drill 03 works blank, the real version
below is just wrapping this logic in Express + Postgres.

## Stage B — Build the real endpoints in the project

Now build the real thing in **[../project-auth-api/](../project-auth-api/)**.
Set that project up first (its README has the setup + `users` table). Below are the
*steps and hints* — not the code. Say "review" when done.

## Endpoint 1 — `POST /register`

**Job:** create a new user with a *hashed* password.

Steps to implement (think through each before writing):
1. Read `email` and `password` from `req.body`.
2. **Validate**: both present? If not → `400`. (Guard clause + `return`, like your CRUD.)
3. **Hash** the password with `bcrypt.hash(password, 10)`. (`await` it — controller is `async`.)
4. **INSERT** the user: store `email` and the **hash** (not the password) via a
   parameterized query (`$1`, `$2`) with `RETURNING id, email`. (Never return the hash.)
5. Respond `201` with the created user (id + email only).
6. **Edge case:** email already exists. The DB throws (UNIQUE violation, error code
   `23505`). Catch it → respond `409 Conflict` with a clear message. (Other errors → `500`.)

Hints:
- You already know the INSERT + RETURNING pattern from the notes API. Same shape.
- Never send `password_hash` back in the response. Select only `id, email`.

## Endpoint 2 — `POST /login`

**Job:** verify the password and hand back a signed token.

Steps:
1. Read `email` and `password` from `req.body`. Missing → `400`.
2. **Find the user** by email (`SELECT * FROM users WHERE email = $1`).
3. **No user found?** → `401`. (Careful: use a *generic* message like "Invalid email or
   password" — don't reveal whether the email exists. That leaks info to attackers.)
4. **Compare**: `bcrypt.compare(password, user.password_hash)`. `false` → `401` (same
   generic message).
5. **Match!** → `jwt.sign({ userId: user.id }, process.env.JWT_SECRET, { expiresIn: "1h" })`.
6. Respond `200` with `{ token }` (and maybe `{ id, email }`, never the hash).

Hints:
- Notice the shape mirrors your "find → bail → act → respond" skeleton from Part 1.
- The *only* thing login puts in the token is the user id. That's enough — every future
  request will carry it back.

## The mental checkpoint

After this module, run it in Thunder Client:
```
POST /register {email, password}  → 201, user created (check the DB: password_hash is a $2a$... blob)
POST /register (same email again) → 409
POST /login    (right password)   → 200 { token: "eyJ..." }
POST /login    (wrong password)   → 401
```

You now have authentication. But `/notes` is still wide open — the token isn't *doing*
anything yet. That's the next module: **[04-protected-routes](../04-protected-routes/)**.
