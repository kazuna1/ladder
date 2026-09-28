// MODULE 01 · DRILL 01 — Hash a password
// Run:  node 01-hash-a-password.js
// Goal: turn a plain password into a storable hash and LOOK at it.
// ---------------------------------------------------------------------------
import bcrypt from "bcryptjs";

const password = "hunter2";

// TODO 1: hash the password with cost factor 10, then print it.
//   HINT: bcrypt.hash returns a Promise, so `await` it (top-level await works in ESM).
//   const hash = await bcrypt.hash(password, 10);
//   console.log("hash:", hash);

const hashedPassword = await bcrypt.hash(password, 10);
console.log("hashed password: ", hashedPassword);

// TODO 2: hash the SAME password a SECOND time and print that too.
//   Look closely: is it identical to the first hash, or different? WHY?
//   (Think about the salt. Write your guess as a comment before you run it.)
const hashedPassword2 = await bcrypt.hash(password, 10);
console.log("hashed password: ", hashedPassword2);

// TODO 3: print the LENGTH of a hash (hash.length).
//   bcrypt hashes are always the same length. What is it?
console.log(hashedPassword.length);

// WHAT TO NOTICE (fill in after running):
// - The output starts with "$2a$10$" — that prefix encodes the algorithm and cost.
// - Hashing the same password twice gave __________ results, because ____________.
// - You will store THIS string in the users table (password_hash), never "hunter2".
