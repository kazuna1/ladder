// ============================================================================
// HOMEWORK 1 — Hash a whole list
// Module 01 · Password Hashing  |  Run:  node homework1.js
// ============================================================================
// Rebuild from memory. No peeking at the office drills.
// Setup once:  npm init -y  →  npm install bcryptjs  →  npm pkg set type=module
// ----------------------------------------------------------------------------
import bcrypt from "bcryptjs";

// GOAL: hash SEVERAL passwords, not just one (drills bcrypt.hash + await in a loop).
//
// INSTRUCTIONS:
//   1. Make an array of 3 passwords, e.g. ["cat123", "dog456", "bird789"].
//   2. Loop over them. Hash each one with cost factor 10.
//   3. Print each as:  password → hash
//
// EXPECTED OUTPUT (shape):
//   cat123  → $2a$10$....
//   dog456  → $2a$10$....
//   bird789 → $2a$10$....
//
// THEN ANSWER (in a comment): all 3 hashes start with "$2a$10$" but are otherwise
//   totally different. Even two identical passwords wouldn't match. WHY?
//
// ---- your code below ----


// STUCK: (if you froze, write exactly where — bring it to the office)
