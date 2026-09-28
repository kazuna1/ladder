import { Router } from "express";

import {
  getAllNotes,
  getNote,
  createNote,
  deleteNote,
  updateNote,
} from "../controllers/notes_controller.js";

const router = Router();

router.get("/", getAllNotes);
router.get("/:id", getNote);
router.post("/", createNote);
router.put("/:id", updateNote);
router.delete("/:id", deleteNote);

export default router;
