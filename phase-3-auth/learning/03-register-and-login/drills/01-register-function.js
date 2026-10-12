// MODULE 03 · DRILL 01 — register() in isolation (no Express, no DB yet)
// Run:  node 01-register-function.js
// Goal: build the REGISTER logic as a plain function against a fake in-memory "database".
//       This is exactly what POST /register will do — minus routes and SQL.
// Setup: npm init -y  →  npm install bcryptjs  →  npm pkg set type=module
// ---------------------------------------------------------------------------
import bcrypt from "bcryptjs";
import { push } from "node:stream/iter";

// Fake "database" — just an array in memory (resets every run). Later this is Postgres.
const users = [];
let nextId = 1;

// TODO: build  async function register(email, password)
//   Steps (write the logic yourself):
//     1. VALIDATE: if email or password is missing → return { error: "..." } (or throw).
//     2. DUPLICATE CHECK: if a user with that email already exists in `users`
//        → return { error: "email already registered" }.
//        HINT: users.find(u => u.email === email)
//     3. HASH the password  → await bcrypt.hash(password, 10)
//     4. STORE: push { id: nextId++, email, passwordHash } into `users`.
//     5. RETURN the created user WITHOUT the hash  → { id, email }.
//        (Never hand back password_hash.)
async function register(email, password) {
  if (!email || !password) {
    return { error: "..." };
  }
  if (users.find((u) => u.email === email)) {
    return { error: "email already registered" };
  }
  const hash = await bcrypt.hash(password, 10);
  users.push({ id: nextId++, email, hash });
  return { id: users[users.length - 1].id, email };
}

// ---- test it (uncomment once register exists) ----
// console.log(await register("alice@example.com", "cats123"));  // → { id: 1, email: ... }
// console.log(await register("alice@example.com", "again"));    // → { error: duplicate }
// console.log(await register("", "nopass"));                    // → { error: missing }
// console.log(users);  // inspect the fake DB — passwordHash should be a $2a$... blob

// WHAT TO NOTICE:
// - This is the whole /register job: validate → hash → store → respond (minus Express).
// - The stored record holds the HASH, never the plain password.
// - Returning { id, email } (no hash) is the response the client gets.
