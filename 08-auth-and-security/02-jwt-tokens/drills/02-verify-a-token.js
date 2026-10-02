// MODULE 02 · DRILL 02 — Verify a token (the server's "who is this?")
// Run:  node 02-verify-a-token.js
// Goal: turn a token back into trusted data with verify().
// ---------------------------------------------------------------------------
import jwt from "jsonwebtoken";

const SECRET = "dev_secret_do_not_use_in_real_life";

// A token the "server" issued earlier:
const token = jwt.sign({ userId: 7 }, SECRET, { expiresIn: "1h" });

// TODO 1: verify the token with the SAME secret. Print the returned payload.
//   HINT: const payload = jwt.verify(token, SECRET);
//   console.log(payload);   // → { userId: 7, iat: ..., exp: ... }
const payload = jwt.verify(token, SECRET);
console.log(payload);

// TODO 2: read userId OUT of the payload and print just that.
//   This is exactly what your auth middleware will do: verify → grab userId →
//   attach it to req.user so the controller knows who's asking.

const userid = jwt.verify(token, SECRET);
console.log(userid.userId);

// TODO 3 (compare to jwt.decode): also print jwt.decode(token). It shows the same
//   payload BUT does NOT check the signature. Write in a comment why you must use
//   verify (not decode) to TRUST a token. (decode = "just read it"; verify = "read it
//   AND prove it wasn't forged".)

console.log(jwt.decode(token));

//so its just decodes not verify i guess

// WHAT TO NOTICE:
// - verify does two jobs at once: checks the signature (not tampered, right secret) AND
//   checks expiry. If either fails, it THROWS instead of returning — you'll see that next.
// - The payload it returns is the SAME object you signed. That round-trip {userId} in,
//   {userId} out — is how a stateless server "remembers" you without storing anything.
