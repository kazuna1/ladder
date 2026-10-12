// ============================================================================
// HOMEWORK 3 — Prove the salt to yourself
// Module 01 · Password Hashing  |  Run:  node homework3.js
// ============================================================================
// Rebuild from memory. No peeking. This locks in WHY you can't compare hashes
// directly, and WHY bcrypt.compare still works anyway.
// ----------------------------------------------------------------------------
import bcrypt from "bcryptjs";

// GOAL: see the same password produce different hashes, yet all verify true.
//
// INSTRUCTIONS:
//   1. Hash the SAME password ("samepass") THREE separate times → hashA, hashB, hashC.
//      Print all three.
//   2. Show they differ: print the result of  (hashA === hashB)   → should be false.
//   3. Now bcrypt.compare("samepass", hashA), then hashB, then hashC. Print all three.
//
// EXPECTED OUTPUT:
//   hashA: $2a$10$....
//   hashB: $2a$10$....   (different from A)
//   hashC: $2a$10$....   (different again)
//   hashA === hashB ? false
//   compare vs A: true
//   compare vs B: true
//   compare vs C: true
//
// THEN ANSWER (in a comment): three different hashes, yet compare returns true for
//   all of them — because ________________________________.
//
// ---- your code below ----


// STUCK: (write exactly where you froze — bring it to the office)
