# project-auth-api — build auth for real (by hand)

This is where modules 03–05 come to life. You build a small API with **users +
authentication + protected, per-user data**. Logic is yours to write (my rule); this
README gives the setup, the file map, and the build order.

## Setup (once)

```bash
cd 08-auth-and-security/project-auth-api
npm init -y
npm install express pg bcryptjs jsonwebtoken
```

Then in `package.json`: add `"type": "module"` and a start script:
```json
"scripts": { "start": "node --env-file=.env server.js" }
```

**Database:** create a DB and the users table:
```bash
psql -U postgres
CREATE DATABASE auth_api;
\c auth_api
\i users-table.sql      -- runs the schema in this folder
```

**Secrets:** copy `.env.example` → `.env` and fill in real values. `.env` is gitignored
(add it to `.gitignore` if not already). **Never commit `.env`.**

```
PGPASSWORD=your_db_password
JWT_SECRET=paste_a_long_random_string_here
```

Run the server: `npm start`  (port 3001 — 3000 is your VybeRooms app).

## Files you'll create (by hand)

You've built this exact structure before (notes API) — same skeleton, plus auth:

```
project-auth-api/
  .env.example        ✅ given (copy to .env)
  users-table.sql     ✅ given (the schema)
  db.js               ← YOU: the pg Pool (copy your proven one; database: "auth_api")
  server.js           ← YOU: express app, cors, express.json, mount routers, listen(3001)
  routes/
    auth_router.js    ← YOU: POST /register, POST /login
    notes_router.js   ← YOU: the notes CRUD, each protected with requireAuth
  controllers/
    auth_controller.js  ← YOU: register + login logic (module 03)
    notes_controller.js ← YOU: notes logic, scoped to req.user (module 05)
  middleware/
    require_auth.js   ← YOU: the requireAuth gate (module 04)
```

## Build order (follow the modules)

1. **Setup** — the steps above. Confirm `npm start` runs and DB connects.
2. **Module 03** — build `auth_controller.js` + `auth_router.js`
   (`POST /register`, `POST /login`). Test with Thunder Client. Get a token back.
3. **Module 04** — build `middleware/require_auth.js`. Add a notes router/controller and
   protect every notes route with it. Test: no token → 401, real token → 200.
4. **Module 05** — add `user_id` to notes (ownership). Scope reads to the logged-in user;
   `403` on touching someone else's. (I'll flesh this module out when you get there.)

## Reference while building

- [../auth-cheatsheet.md](../auth-cheatsheet.md) — every call you need.
- [../03-register-and-login/README.md](../03-register-and-login/README.md) — step-by-step hints.
- [../04-protected-routes/README.md](../04-protected-routes/README.md) — the middleware.

Say **"review"** after each endpoint and I'll check your logic + security (e.g. "are you
returning the hash by accident?", "is the login error generic?"). Start with **Setup**,
then **module 03**. 🔐
