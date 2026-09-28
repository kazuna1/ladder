// MODULE 02 · DRILL 03 — Break it on purpose (expiry + tampering)
// Run:  node 03-expiry-and-tampering.js
// Goal: SEE verify() throw. Trust comes from watching the guarantee hold.
// Wrap each attempt in try/catch and print the error NAME so you see which failure it is.
// ---------------------------------------------------------------------------
import jwt from "jsonwebtoken";

const SECRET = "dev_secret_do_not_use_in_real_life";

// TODO 1: WRONG SECRET. Sign with SECRET, then verify with "some_other_secret".
//   HINT:
//     const token = jwt.sign({ userId: 7 }, SECRET);
//     try { jwt.verify(token, "some_other_secret"); }
//     catch (err) { console.log("wrong secret →", err.name); }
//   Expected err.name: "JsonWebTokenError" (invalid signature).


// TODO 2: TAMPERED TOKEN. Take a valid token, change one character in the middle
//   (payload) part, then verify with the correct SECRET.
//   HINT: build a broken string, e.g. token.slice(0, -3) + "abc", and verify it.
//   Expected: it THROWS — the signature no longer matches the edited payload.


// TODO 3: EXPIRED TOKEN. Sign with { expiresIn: "1s" }, wait ~1.5s, then verify.
//   HINT to wait: await new Promise(r => setTimeout(r, 1500));
//   Expected err.name: "TokenExpiredError".


// WHAT TO NOTICE:
// - Every attack on the token (guess the secret, edit the payload, reuse an old one)
//   ends in verify() THROWING. That's why your middleware wraps verify in try/catch and
//   returns 401 in the catch — any failure = "I don't trust you".
// - You did NOT need a database to reject these. The math (signature) did it. Stateless.
