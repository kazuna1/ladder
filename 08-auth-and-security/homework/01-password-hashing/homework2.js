// ============================================================================
// HOMEWORK 2 — Mini register + login  (the whole password half, in miniature)
// Module 01 · Password Hashing  |  Run:  node homework2.js
// ============================================================================
// Rebuild from memory. No peeking. This is the SHAPE of the real /register and
// /login you'll build in module 03 — just without Express or a real database.
// ----------------------------------------------------------------------------
import bcrypt from "bcryptjs";

// GOAL: combine BOTH functions (hash + compare) into one tiny real flow.
//
// INSTRUCTIONS:
//   1. Make a fake "database": an array of user objects  { username, passwordHash }.
//   2. Write  async register(username, password)  → hashes the password,
//      pushes { username, passwordHash } into the array.
//   3. Write  async login(username, password)  → finds the user by username, then
//      uses bcrypt.compare to check the password. Returns true / false.
//        - if the username doesn't exist, return false (don't crash).
//   4. Test: register "alice", then login alice with the RIGHT password, a WRONG one,
//      and a username that doesn't exist ("ghost").
//
// EXPECTED OUTPUT:
//   register: alice created
//   login alice + correct password → true
//   login alice + wrong password   → false
//   login ghost + anything         → false
//
// ---- your code below ----


// STUCK: (write exactly where you froze — bring it to the office)
