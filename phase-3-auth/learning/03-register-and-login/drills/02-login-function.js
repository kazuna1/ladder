// MODULE 03 · DRILL 02 — login() in isolation (no Express, no DB yet)
// Run:  node 02-login-function.js
// Goal: build the LOGIN logic — check the password, hand back a signed token.
//       This is exactly what POST /login will do.
// Setup: this folder also needs jsonwebtoken → npm install jsonwebtoken
// ---------------------------------------------------------------------------
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

const SECRET = "dev_secret_do_not_use_in_real_life";

// A fake "database" with ONE already-registered user.
// (In drill 01 you built register(); here we just hardcode a stored user so we can log in.)
const users = [
  {
    id: 1,
    email: "alice@example.com",
    passwordHash: await bcrypt.hash("cats123", 10),
  },
];

// TODO: build  async function login(email, password)
//   Steps (write the logic yourself):
//     1. FIND the user by email in `users`.  (users.find(...))
//     2. NOT FOUND → return { error: "invalid email or password" }.
//        (Generic message on purpose — don't reveal whether the email exists.)
//     3. COMPARE: await bcrypt.compare(password, user.passwordHash)
//     4. FALSE → return { error: "invalid email or password" }  (same generic message).
//     5. TRUE → sign a token:  jwt.sign({ userId: user.id }, SECRET, { expiresIn: "1h" })
//        → return { token }.

async function login(email, password) {
  const user = users.find((u) => u.email === email);
  if (!user) {
    return { error: "invalid email or password" };
  }
  const ok = await bcrypt.compare(password, user.passwordHash);
  if (ok) {
    const token = jwt.sign({ userId: user.id }, SECRET, { expiresIn: "24h" });
    return { token };
  } else {
    return { error: "invalid email or password" };
  }
}

// ---- test it (uncomment once login exists) ----
console.log(await login("alice@example.com", "cats123")); // → { token: "eyJ..." }
console.log(await login("alice@example.com", "wrong")); // → { error: ... }
console.log(await login("ghost@example.com", "cats123")); // → { error: ... }

// WHAT TO NOTICE:
// - login = find → compare → sign. The token carries ONLY { userId } — enough to know who.
// - Wrong password AND missing user return the SAME message (no info leak to attackers).
// - The { token } is what the client stores and sends back on every future request.
