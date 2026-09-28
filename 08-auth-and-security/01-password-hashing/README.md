# Module 01 — Password Hashing (bcrypt)

**Goal:** understand the one primitive every login rests on — turning a password into a
hash you can store, and checking it later — *in isolation*, before any API.

Read [security-basics.md](../security-basics.md) first if you haven't. The key ideas:
hashing is a one-way door, bcrypt salts automatically, and it's slow on purpose.

## Setup

Make a scratch folder and install bcryptjs (these drills run standalone with `node`):

```bash
cd 08-auth-and-security/01-password-hashing/drills
npm init -y
npm install bcryptjs
```

Add `"type": "module"` to that `package.json` so `import` works (like your other projects).
Run a drill with: `node 01-hash-a-password.js`

## Drills (in order)

- **01-hash-a-password** — hash a password, look at the 60-char output, see the salt is inside it.
- **02-compare-passwords** — the login check: right password → true, wrong → false.
- **03-salt-rounds** — feel bcrypt's "slow on purpose": time different cost factors.

## What you're proving to yourself

```
hash(password)              → a 60-char string you can safely store
compare(guess, storedHash)  → true / false   ← this IS the login check
same password hashed twice  → DIFFERENT strings (salt!) but both compare true
```

The bcrypt calls are shown in the drills — that's just library syntax (like SQL). Type
them, run them, and *read the output carefully*. Say **"review"** after and I'll quiz you
on why each result is what it is. Then module **[02-jwt-tokens](../02-jwt-tokens/)**.
