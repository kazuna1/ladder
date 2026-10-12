// MODULE 01 · DRILL 02 — Compare (this IS the login check)
// Run:  node 02-compare-passwords.js
// Goal: prove that bcrypt.compare returns true for the right password, false for wrong.
// ---------------------------------------------------------------------------
import bcrypt from "bcryptjs";

const realPassword = "hunter2";

// First, make a stored hash (pretend this came out of the database):
const storedHash = await bcrypt.hash(realPassword, 10);
console.log("stored hash:", storedHash);

// TODO 1: compare the CORRECT password against the stored hash. Print the result.
//   HINT: const ok = await bcrypt.compare("hunter2", storedHash);
//   Expected: true

const ok = await bcrypt.compare(realPassword, storedHash);
console.log(ok);
// TODO 2: compare a WRONG password ("wrongpass") against the stored hash. Print it.
//   Expected: false

const wrongPassowrd = "sdadads";
const notok = await bcrypt.compare(storedHash, wrongPassowrd);
console.log(notok);

// TODO 3: notice you never "unhashed" anything. Write, in a comment, HOW compare can
//   return true without ever turning the hash back into "hunter2".
//   (Hint: it re-hashes your guess using the salt baked into storedHash, then checks
//    if the fingerprints match. One-way door — never reversed.)

//compare verifies , unhashing is just checking not validating

// WHAT TO NOTICE:
// - This two-line check (hash on register, compare on login) is the ENTIRE password half
//   of authentication. Everything else is plumbing around it.
// - You compare fingerprints, never the passwords themselves.
