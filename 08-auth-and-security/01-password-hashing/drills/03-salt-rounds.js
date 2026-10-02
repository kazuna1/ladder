// MODULE 01 · DRILL 03 — Salt rounds (feel "slow on purpose")
// Run:  node 03-salt-rounds.js
// Goal: SEE that a higher cost factor makes hashing measurably slower — the feature
//       that makes stolen password hashes expensive to crack.
// ---------------------------------------------------------------------------
import bcrypt from "bcryptjs";

const password = "hunter2";

// TODO 1: time hashing at cost 8, then 10, then 12. Print each duration in ms.
//   HINT for timing one run:
//     const start = Date.now();
//     await bcrypt.hash(password, 8);
//     console.log("cost 8:", Date.now() - start, "ms");
//   Repeat for 10 and 12.
let start = Date.now();
await bcrypt.hash(password, 8);
console.log("cost 8: ", Date.now() - start, "ms");

start = Date.now();
await bcrypt.hash(password, 10);
console.log("cost 10: ", Date.now() - start, "ms");

start = Date.now();
await bcrypt.hash(password, 12);
console.log("cost 12: ", Date.now() - start, "ms");
// TODO 2: before running, PREDICT (as a comment): each +2 to the cost roughly ____x
//   the time, because cost N means 2^N internal iterations. Then run and check.

// WHAT TO NOTICE:
// - Each step up ~4x's the time (2^N). 10→12 is ~4x slower.
// - A real login pays this cost ONCE and a few hundred ms is invisible to a human.
// - But an attacker with a leaked hash table now needs ~4x the compute per guess.
//   That's the whole point: fast for one honest login, brutal for billions of guesses.
// - Typical production choice: 10 to 12. Not higher unless you have a reason.
