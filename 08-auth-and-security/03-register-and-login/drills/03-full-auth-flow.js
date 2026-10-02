// MODULE 03 · DRILL 03 — the full flow in one file (register → login → verify)
// Run:  node 03-full-auth-flow.js
// Goal: connect ALL 4 functions you've learned into one story, no Express/DB.
//       This is the entire auth engine in miniature. If you can write this blank,
//       the real Express+Postgres version is just plumbing on top.
// ---------------------------------------------------------------------------
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

const SECRET = "dev_secret_do_not_use_in_real_life";
const users = [];
let nextId = 1;

// TODO 1: async function register(email, password)
//   validate → duplicate check → bcrypt.hash → store {id,email,passwordHash} → return {id,email}

async function register(email, password) {
  const id = nextId++;
  if (!email || !password) {
    return { error: "invalid email or password" };
  }
  if (users.find((u) => u.email === email)) {
    return { error: "email already registered" };
  }
  const hash = await bcrypt.hash(password, 10);
  users.push({ id, email, passwordHash: hash });
  return { id, email };
}
// TODO 2: async function login(email, password)
//   find user → bcrypt.compare → on success jwt.sign({userId}) → return { token }
//   on any failure → return { error: "invalid email or password" }

async function login(email, password) {
  const user = users.find((u) => u.email === email);
  if (!user) {
    return { error: "invalid email or password" };
  }
  const ok = await bcrypt.compare(password, user.passwordHash);
  if (ok) {
    const token = jwt.sign({ userId: user.id }, SECRET, { expiresIn: "72h" });
    return { token };
  }
}

// TODO 3: function authenticate(token)  ← simulates a protected request
//   jwt.verify(token, SECRET) inside try/catch
//   valid → return the payload ({ userId, ... });  invalid/expired → return { error: "unauthorized" }

function authenticate(token) {
  try {
    const payload = jwt.verify(token, SECRET);
    return payload;
  } catch (err) {
    return { error: "unauthorized" };
  }
}

// ---- test the whole journey (uncomment once all three exist) ----
await register("alice@example.com", "cats123");
const { token } = await login("alice@example.com", "cats123");
console.log("token:", token);
console.log("protected request →", authenticate(token)); // → { userId: 1, ... }
console.log("bad token →", authenticate(token.slice(0, -3) + "x")); // → { error: unauthorized }

// WHAT TO NOTICE:
// - 3 moments, 4 functions:
//     register → bcrypt.hash
//     login    → bcrypt.compare + jwt.sign
//     request  → jwt.verify
// - No server "session" is stored anywhere. The token carries the identity. Stateless.
// - The real project adds: Express routes (POST /register, /login), a Postgres users table,
//   and a requireAuth middleware that runs authenticate() before protected controllers.
