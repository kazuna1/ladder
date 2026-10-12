# How JWT Works (open the token and look inside)

JWT = **J**SON **W**eb **T**oken. Say it "jot". It's the tamper-proof ID card the
server hands you at login. Let's take it apart so it's not magic.

## What a token looks like

A raw JWT is one long string with **three parts separated by dots**:

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjcsImlhdCI6MTcwMH0.dQw4w9WgXcQ_signature
└────────── HEADER ──────────┘ └──────── PAYLOAD ────────┘ └──── SIGNATURE ────┘
```

Three parts: **header . payload . signature**

### 1. Header
Tiny JSON saying *how* it's signed. Example: `{ "alg": "HS256", "typ": "JWT" }`.
(HS256 = the signing algorithm.)

### 2. Payload  (the "claims")
The actual data — this is what YOU put in. Example: `{ "userId": 7, "iat": 1700000000 }`.
- `userId` — your custom claim (whatever you need to identify the user).
- `iat` — "issued at" (added automatically). `exp` — "expires at" (if you set expiry).

> ⚠️ **The payload is NOT secret.** Anyone can read it. Header and payload are just
> **Base64** — that's *encoding*, not encryption. Paste any token into jwt.io and you'll
> see the contents in plain text. **So never put a password or secret in the payload.**
> Put only non-sensitive identity info (like a user id).

### 3. Signature  (the tamper-proof seal)
This is the whole point. The server computes:

```
signature = HMAC_SHA256( base64(header) + "." + base64(payload),  SECRET_KEY )
```

It mashes the header+payload together with a **secret key only the server knows**, and
produces a fingerprint. That fingerprint is the signature.

## Why tampering is impossible (the "aha")

Say an attacker grabs their own token `{ userId: 7 }` and edits the payload to
`{ userId: 1 }` (trying to become the admin). Now:

- They changed the payload → the correct signature would be *different*.
- To forge the matching signature, they'd need the **SECRET_KEY**. They don't have it.
- The server re-computes the signature from the (tampered) payload + its secret, compares
  it to the signature on the token → **they don't match → REJECTED.**

```
Verify = "recompute the signature myself with my secret. Does it match the one attached?"
   match     → payload is untouched, trust it   ✅
   no match  → someone edited it, throw it out  ❌
```

That's it. The signature doesn't *hide* the data — it *proves the data wasn't changed*
and *was issued by us*. Like a wax seal on a letter: you can read the letter through the
envelope, but a broken seal means don't trust it.

## The login handshake, start to finish

```
1. POST /login  {email, password}
2. Server checks password (bcrypt.compare). ✅
3. Server SIGNS a token:   jwt.sign({ userId: 7 }, SECRET, { expiresIn: "1h" })
4. Server responds:        { token: "eyJ...signature" }
5. Client stores the token, then on every request sends:
       Authorization: Bearer eyJ...signature
6. Server VERIFIES:        jwt.verify(token, SECRET)  →  { userId: 7 }
7. Server now knows it's user 7. No database lookup for the session. Stateless. 🎉
```

## The secret key is everything

- The secret lives **only on the server**, in `.env` (`JWT_SECRET=...`), never in git,
  never sent to the client.
- Anyone with the secret can **mint valid tokens for any user** → total account takeover.
  Guard it like a password. In production it's a long random string.

## Expiry — why tokens don't live forever

`{ expiresIn: "1h" }` bakes an `exp` timestamp into the payload. After that, `jwt.verify`
throws `TokenExpiredError`. Short-lived tokens limit the damage if one is stolen — a
thief can only use it for a little while. (The "how do I stay logged in for weeks then?"
answer is **refresh tokens** — a concept for module 06.)

## Common confusions — settle them now

- **"Is the token encrypted?"** No. It's *signed*. Readable, but not forgeable.
- **"Where do I store it on the client?"** `localStorage` (simple, but readable by JS →
  XSS risk) or an httpOnly cookie (safer against XSS). Trade-off covered in module 06.
- **"Does logout delete the token on the server?"** There's nothing on the server to
  delete — that's the stateless trade-off. Logout = client throws its token away. To
  force-kill a token server-side you need extra machinery (a denylist) — advanced.

## What to remember

> A JWT is **readable but not forgeable**. The signature = HMAC(payload, secret). Verify
> = recompute and compare. Put only a user id inside. Guard the secret with your life.

Next: **[security-basics.md](./security-basics.md)** — why we hash passwords and how.
