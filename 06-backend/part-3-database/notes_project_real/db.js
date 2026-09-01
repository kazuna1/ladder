import pg from "pg";
const { Pool } = pg;

export const pool = new Pool({
  host: "localhost", // the DB is on this machine
  port: 5432, // Postgres's default door
  user: "postgres", // the superuser
  password: process.env.PGPASSWORD, // read from .env (Step 6)
  database: "ladder_notes", // the database you created
});
