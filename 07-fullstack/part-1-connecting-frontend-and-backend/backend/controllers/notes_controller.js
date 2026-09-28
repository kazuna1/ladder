import { pool } from "../db.js";

export async function getAllNotes(req, res) {
  try {
    const result = await pool.query("SELECT * FROM notes");
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database error" });
  }
}

export async function getNote(req, res) {
  try {
    const id = req.params.id;
    const result = await pool.query("SELECT * FROM notes WHERE id=$1", [id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Note not found" });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database error" });
  }
}

export async function createNote(req, res) {
  try {
    const { title, body } = req.body;
    if (!title) {
      return res.status(400).json({ error: "title required" });
    }
    const result = await pool.query(
      "INSERT INTO notes (title,body) VALUES ($1,$2) RETURNING * ",
      [title, body || ""],
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database error" });
  }
}

export async function deleteNote(req, res) {
  try {
    const id = req.params.id;
    const result = await pool.query(
      "DELETE FROM notes WHERE id = $1 RETURNING *",
      [id],
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Note not found" });
    }
    res.status(200).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "DB error" });
  }
}

export async function updateNote(req, res) {
  try {
    const id = req.params.id;
    const { title, body } = req.body;
    const result = await pool.query(
      "UPDATE notes SET title = COALESCE($1, title),body  = COALESCE($2, body) WHERE id = $3 RETURNING *",
      [title ?? null, body ?? null, id],
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Note not found" });
    }
    res.status(200).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database error" });
  }
}
