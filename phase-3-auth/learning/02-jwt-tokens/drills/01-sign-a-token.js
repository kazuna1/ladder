// MODULE 02 · DRILL 01 — Sign a token
// Run:  node 01-sign-a-token.js
// Goal: create a JWT and see that its payload is READABLE (encoded, not encrypted).
// ---------------------------------------------------------------------------
import jwt from "jsonwebtoken";

// In a real app this lives in .env. Hardcoded here just for the drill.
const SECRET = "dev_secret_do_not_use_in_real_life";

// TODO 1: sign a token carrying { userId: 7 }, expiring in 1 hour. Print it.
//   HINT: const token = jwt.sign({ userId: 7 }, SECRET, { expiresIn: "1h" });
//   console.log(token);

const token = jwt.sign({ userId: 7 }, SECRET, { expiresIn: "1h" });
console.log(token);
// TODO 2: copy the printed token and paste it into https://jwt.io (or just eyeball it).
//   It has 3 dot-separated parts. The MIDDLE part is your payload, only Base64-encoded.
//   Confirm you can see userId: 7. Write in a comment: "payload is readable → I must
//   NOT put secrets (like a password) in it."
/* here is payload: {
  "userId": 7,
  "iat": 1790741227,
  "exp": 1790744827
}*/
// TODO 3: sign a SECOND token that also puts an email in the payload, e.g.
//   { userId: 7, email: "me@example.com" }. Print it. (Just to see custom claims work.)

const token2 = jwt.sign({ userId: 7, email: "me@example.com" }, SECRET, {
  expiresIn: "24h",
});
console.log(token2);

/*{
  "userId": 7,
  "email": "me@example.com",
  "iat": 1790741388,
  "exp": 1790827788
}*/
// WHAT TO NOTICE:
// - sign() = "stamp this data with my secret so nobody can alter it." The data stays
//   visible; the SIGNATURE (3rd part) is what protects it.
// - The token is what you'd send back from POST /login as { token }.
// - iat (issued-at) and exp (expiry) get added into the payload automatically.
