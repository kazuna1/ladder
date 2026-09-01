// ROUTES — the menu. Which METHOD + PATH → which controller function.
// NO logic here. Just wiring. Each line: "this request runs that function."
//
// ---------------------------------------------------------------------------

import express from "express";
// TODO 1: import your controller functions (you'll write them in the controller file):
//   import {
//     getAllNotes,
//     getNote,
//     createNote,
//     updateNote,
//     deleteNote,
//   } from "../controllers/notes.controller.js";

import {
  getAllNotes,
  getNote,
  createNote,
  updateNote,
  deleteNote,
} from "../controllers/notes.controllers.js";

const router = express.Router(); // a mini-app just for /notes

// ⚠️ PATHS ARE RELATIVE. This router gets mounted at "/notes" in server.js,
// so here "/" means /notes, and "/:id" means /notes/:id. DON'T write "/notes" again.

// TODO 2: wire each route to its controller function (no arrow functions here —
//          just hand it the function NAME; the controller has the logic):
router.get("/", getAllNotes); // GET  /notes
router.get("/:id", getNote); // GET  /notes/:id
router.post("/", createNote); // POST /notes
router.put("/:id", updateNote); // PUT  /notes/:id
router.delete("/:id", deleteNote); // DELETE /notes/:id

export default router; // export the whole bundle so server.js can mount it

// WHAT TO NOTICE:
// - This file is pure WIRING — path → function. You could read it and instantly
//   see every /notes endpoint the app has, without any logic in the way.
// - "router.get('/', getAllNotes)" — you pass the function, you don't call it.
//   Express calls it (with req, res) when a matching request arrives.
