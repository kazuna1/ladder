# Security Basics (hashing, salts, and the attacks we defend against)

You don't need to be a security expert. You *do* need the handful of ideas below, because
getting them wrong leaks real people's passwords. This is the "if a backend dev doesn't
know this, they build a dangerous backend" list.

## Rule #1: NEVER store passwords as plain text

If your `users` table has a `password` column with `"hunter2"` in it, then the day your
database leaks (they always eventually leak), every user's actual password is exposed —
and people reuse passwords, so you've now compromised their email, bank, everything.

**Solution: store a hash, not the password.**

## Hashing — the one-way door

A **hash function** turns any input into a fixed fingerprint, and **cannot be reversed**:

```
"hunter2"  ──hash──▶  "$2a$10$N9qo8uL... (60 chars)"
"hunter2"  ──hash──▶  same fingerprint every time
"hunter3"  ──hash──▶  totally different fingerprint
```

- Same input → same hash (that's how we check it later).
- You **cannot** go from the hash back to `"hunter2"`. It's a one-way door.
- So we store the *hash*. We literally never know the user's real password. Good.

### How login works without knowing the password
```
Register: hash the password → store the hash.
Login:    hash what they just typed → compare to the stored hash.
          equal → correct password.  not equal → wrong password.
```
We compare *fingerprints*, never the passwords themselves.

## Hashing ≠ encryption (don't mix these up)

| | Reversible? | Purpose | Example |
|---|---|---|---|
| **Hashing** | ❌ No (one-way) | Store passwords, verify integrity | bcrypt on a password |
| **Encryption** | ✅ Yes (with a key) | Hide data you need to read back later | encrypting a credit card |

Passwords get **hashed** — we never need to read them back, only check them.

## Salt — why bcrypt beats plain SHA-256

Plain hashes have a weakness: `"password123"` always hashes to the *same* value. Attackers
precompute giant tables of `common password → its hash` (**rainbow tables**) and just
look yours up. Also, two users with the same password get the same hash — visible in a leak.

**A salt fixes this.** A salt is a random string mixed into the password *before* hashing:

```
hash( "hunter2" + random_salt_A ) → hash X
hash( "hunter2" + random_salt_B ) → hash Y   (different! same password, different hash)
```

Now every hash is unique, and precomputed tables are useless (they'd need a table per salt).

**Great news: bcrypt does salting for you, automatically.** When you call `bcrypt.hash`,
it generates a random salt, hashes with it, and **stores the salt inside the 60-char
output** (that `$2a$10$...` string contains the salt). At login, `bcrypt.compare` reads the
salt back out and re-hashes correctly. You don't manage salts by hand — you just trust bcrypt.

## Why bcrypt is *slow* on purpose

Fast hashes (SHA-256) are bad for passwords: an attacker with a leaked DB can try
*billions* of guesses per second. bcrypt is **deliberately slow** and its cost is
tunable via **salt rounds** (a.k.a. cost factor):

```
saltRounds = 10  →  2^10 = 1024 internal iterations  (default, ~fine)
saltRounds = 12  →  4x slower than 10
```

Slow enough that one login (a few hundred ms) is invisible to a real user, but makes
mass-guessing an attacker's stolen hashes painfully expensive. **Higher = safer but
slower.** 10–12 is the normal range. You'll feel this in a drill.

## The attacks, in plain words (so the defenses make sense)

- **Database leak** → defended by *hashing + salting* (leaked hashes are near-useless).
- **Rainbow tables** (precomputed hash lookups) → defended by *salting*.
- **Brute force / credential stuffing** (trying millions of passwords) → slowed by
  bcrypt's *cost factor*, and blocked by *rate limiting* (module 06).
- **Token tampering** (editing a JWT) → defended by the *signature* (see how-jwt-works).
- **Token theft** (stealing someone's token) → limited by *short expiry* + HTTPS + safe
  token storage (module 06).
- **SQL injection** → you already defend this with *parameterized queries* (`$1`), from the
  DB part. Keep doing that — never string-concat user input into SQL. 🔒
- **Secrets in git** → your `JWT_SECRET` and DB password live in `.env`, which is
  `.gitignore`d. Never commit secrets. (You already learned this with `PGPASSWORD`.)

## The short checklist

```
✅ Hash passwords with bcrypt (salt is automatic). Never store plaintext.
✅ Compare with bcrypt.compare, never by re-reading the password.
✅ Sign JWTs with a strong secret kept in .env, never in git.
✅ Give tokens an expiry.
✅ Use parameterized queries ($1) — no SQL injection.
✅ Send auth over HTTPS in production (so tokens can't be sniffed).
```

Next: **[auth-cheatsheet.md](./auth-cheatsheet.md)**, then start
**[01-password-hashing](./01-password-hashing/)**.
