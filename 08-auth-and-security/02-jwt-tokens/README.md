# Module 02 — JWT Tokens

**Goal:** understand the token — the tamper-proof ID card — *in isolation*. Sign one,
read what's inside, verify it, and watch verification FAIL when you tamper or when it
expires. After this, tokens will feel mechanical, not magical.

Read [how-jwt-works.md](../how-jwt-works.md) first — the three parts (header.payload.
signature) and why the signature makes tampering impossible.

## Setup

```bash
cd 08-auth-and-security/02-jwt-tokens/drills
npm init -y
npm install jsonwebtoken
```

Add `"type": "module"` to that `package.json`. Run: `node 01-sign-a-token.js`

## Drills (in order)

- **01-sign-a-token** — sign a token, paste it into jwt.io, see your payload in plaintext.
- **02-verify-a-token** — verify → get the payload back. The server's "who is this?" step.
- **03-expiry-and-tampering** — watch verify THROW when the token is edited or expired.

## What you're proving to yourself

```
sign({userId: 7}, SECRET)     → "eyJ...".  Contains userId, readable by anyone.
verify(token, SECRET)          → { userId: 7 }   (only if untouched + right secret)
edit the token / wrong secret  → verify THROWS   ← this is the security
```

The jwt calls are shown — that's library syntax. Type them, run them, and *break things
on purpose* in drill 03 so you trust the guarantee. Say **"review"** when done, then move
to **[03-register-and-login](../03-register-and-login/)** where you build the real API.
