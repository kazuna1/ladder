# Homework 01 — Password Hashing 🏠

Rebuild the bcrypt ideas from **blank files** — no peeking at the office drills.

**Setup once** (see [../README.md](../README.md)):
```bash
npm init -y  &&  npm install bcryptjs  &&  npm pkg set type=module
```

Open each file, read the instructions inside, implement below the `---- your code ----`
line, then run it and check against the "expected output". Stuck → write a `// STUCK:`
note and bring it to the office.

| File | Challenge | Drills |
|---|---|---|
| [homework1.js](./homework1.js) | Hash a whole list of passwords | `bcrypt.hash` + `await` in a loop |
| [homework2.js](./homework2.js) | Mini register + login (fake-DB array) | `hash` + `compare` combined = the real flow |
| [homework3.js](./homework3.js) | Prove the salt (same pw → 3 hashes → all verify) | why compare works despite the salt |

Run one with: `node homework1.js`

When done, next office session say **"review my homework 01"**. 🔥
