import express from "express";
import cors from "cors";
import notes_router from "./routes/notes_router.js";

const app = express();
const PORT = 3001;

app.use(cors());
app.use(express.json());

app.use("/notes", notes_router);

app.listen(PORT, () => console.log(`API on http://localhost:${PORT}`));
