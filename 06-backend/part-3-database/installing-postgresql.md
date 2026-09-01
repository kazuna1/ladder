# Installing PostgreSQL — Deeply Understood

Don't just run the command. First understand *what* you're installing, *why* it works
the way it does, and *what every setup choice means.* This is a lesson, not a chore.

---

## 1. What are you actually installing?

Here's the mental shift: **PostgreSQL is not an app you open. It's a server program
that runs quietly in the background, all the time, waiting for connections.**

Remember your Express server? You ran `node server.js`, and it **stayed alive**,
listening on port 3000 for requests. **PostgreSQL is the same idea** — a program that
starts, stays running, and listens (on port **5432**) for anyone who wants to store or
fetch data. The difference: you don't start it by hand each time — Windows runs it for
you as a **service** (more on that below).

So "installing Postgres" really means: **putting a data-storage server on your machine
and setting it to run continuously in the background.**

---

## 2. The big idea: client ↔ server (this explains EVERYTHING else)

This one concept explains the password, the port, the service — all of it.

PostgreSQL is split into two halves:

```
   THE SERVER                          THE CLIENTS
   (postgres.exe)                      (things that connect to it)
   ┌──────────────────┐                ┌──────────────┐
   │ runs in the       │◀── port 5432 ─│ psql         │ (the terminal tool)
   │ background always │◀──────────────│ your Node app│ (via the `pg` driver)
   │ stores data on    │◀──────────────│ pgAdmin      │ (a GUI)
   │ disk              │                └──────────────┘
   └──────────────────┘
```

- **The server** = the actual database engine. It holds your data on disk and does the
  real work. It has no buttons, no window — it just runs and listens.
- **The clients** = anything that *talks* to the server: `psql` (you, typing SQL), your
  Express app (sending SQL via the `pg` driver), pgAdmin (a clicky GUI).

**Even on your own laptop, you're a client connecting to a server.** That's why there's
a port (5432 — the "door" clients knock on), why there's a password (the server must
check who's allowed in), and why it runs as a service (the server has to be *up* for
clients to connect). It's the exact request→response, port, "stays alive" model you
learned with Express — just for data instead of web pages.

> **Postgres = a data server that's always running. `psql` and your app are clients
> that connect to it over port 5432.** Everything about setup follows from this.

---

## 3. What gets installed (four things)

The installer puts down a bundle:

| Piece | What it is | Do you use it? |
| --- | --- | --- |
| **PostgreSQL server** | the database engine (the important part) | yes — always running |
| **`psql`** | the command-line client — type SQL, get rows | ✅ **you live here** |
| **pgAdmin** | a graphical GUI client (click instead of type) | ❌ ignore it (for now) |
| **libraries/tools** | stuff other programs use to connect | invisibly, yes |

You'll spend your time in **`psql`** — the raw SQL terminal. pgAdmin is a
button-clicking GUI that writes SQL *for* you — the exact thing you rejected Supabase
to avoid. Skip it until SQL is muscle memory.

---

## 4. Two ways to install — and why either works

The software is identical; only *how you fetch and run the installer* differs.

### Route A — the terminal (`winget`)
```bash
winget install -e --id PostgreSQL.PostgreSQL.17
```
**What is `winget`?** It's the **Windows Package Manager** — a built-in tool that
installs software from the command line. Think "app store, but you type the app's name
instead of clicking." It finds the official PostgreSQL installer, downloads it, and
runs it for you.

**Why install from the terminal?**
- **Fast & repeatable** — one line, no clicking through a wizard.
- **Exact version** — `PostgreSQL.17` pins what you get.
- **How pros do it** — scripts and servers install this way (no human to click buttons).

### Route B — the web (download the installer yourself)
**Yes — you can absolutely download it from the web directly.** Go to
**postgresql.org/download/windows**, which hands you the **EDB installer** (a `.exe`
made by EnterpriseDB, a company that packages Postgres for Windows). Download it,
double-click, and a **graphical wizard** walks you through the same setup.

**Why use the web installer?**
- **You SEE every choice** — the wizard shows you the password field, port, components,
  install location, as screens. Great the *first* time, when you want to understand
  each option instead of accepting defaults blindly.

### Which should YOU use?
Since you want to *understand* the setup, the **web installer (Route B) is actually
better for your first time** — you'll see each choice as a visible screen and grasp
what it's asking. Route A (winget) is the fast way once you know what it's doing. **Same
Postgres either way** — pick the one that teaches you more right now. I'd say do the web
wizard once, deliberately.

---

## 5. The setup choices — what each one MEANS

Whichever route you pick, you'll be asked these. Now you'll know why:

### Superuser password (for the `postgres` user)
The server must control *who* can touch the data — so it has an admin account called
**`postgres`** (the "superuser" — full power). You set its **password** now.
- This is the "who's allowed in" check from the client-server model.
- ⚠️ **Write it down somewhere real.** There's no "forgot password" flow — you'll type
  it every time you connect, and losing it means reinstalling.

### Port — `5432`
The **door number** the server listens on (Express used 3000; Postgres's convention is
5432). Clients connect to `localhost:5432`. **Accept the default** unless something else
already uses it. This is literally the same "port = a numbered door" idea from Phase 5.

### Install location & components
Where the files go (default is fine) and which pieces to install (keep them all — server,
psql, pgAdmin; you just won't *use* pgAdmin).

### Locale
Language/formatting for sorting and dates. Default is fine.

---

## 6. What "PATH" means and why it matters

After install, you want to type `psql` in **any** terminal and have it work. For that,
Windows needs to know *where* `psql.exe` lives. That's what **PATH** is: a list of
folders Windows searches when you type a command.

Postgres's tools live in something like:
```
C:\Program Files\PostgreSQL\18\bin        (18 = the version number; yours may differ)
```
**Adding that folder to PATH** = "Windows, also look here for commands." Then `psql`
works everywhere. The installer usually does this, but sometimes skips it — if
`psql --version` fails afterward, that's why, and you add the `bin` folder to PATH
manually (search Windows for "Edit environment variables").

> **PATH = the list of folders Windows checks for commands. Adding Postgres's `bin`
> folder makes `psql` runnable from any terminal.**

---

## 7. After install: it's running right now

Once installed, PostgreSQL registers as a **Windows service** — a program Windows keeps
running in the background automatically, and **restarts on every boot.** So:

- The database server is **already running** the moment install finishes. You don't
  "start Postgres" — it's just *up*, waiting on port 5432.
- Unlike your Express server (which you `node server.js` and `Ctrl+C` yourself), the DB
  is managed by Windows. It's *always on*.

That's the point of a service: your data server needs to be available whenever any app
wants it, so the OS keeps it alive for you.

---

## 8. Verify + first connection

**Check the tool is installed:**
```bash
psql --version          # prints a version → the client is on your PATH ✅
```

**Connect to the server (you're now a client!):**
```bash
psql -U postgres        # -U postgres = log in as the superuser
                        # it'll ask for the password you set
```
You'll land at a prompt like `postgres=#` — you're now *inside* the server, and
anything you type is SQL. Try:
```sql
SELECT version();       -- ask the server what version it is
\l                      -- list databases (a psql command, no semicolon)
\q                      -- quit
```

If that works, you've got a running database server and a way to talk to it. **That's
the whole setup** — and now you understand every piece of it.

---

## The mental model of the whole thing

```
you install → a SERVER starts running in the background (a Windows service, port 5432)
                       │
you type `psql` ──────▶ connect to it as a CLIENT (superuser + password)
                       │
                       ▼
             type SQL → server stores/fetches data on disk → hands rows back
```

**A database is a server. You install it, it runs forever in the background, and you
(and later your app) connect to it as clients.** Once that clicks, ports, passwords,
services, and PATH all stop being random steps — they're all just consequences of
"it's a server you connect to."

**Next:** install it (web wizard recommended for your first time), verify `psql` works,
then read [what-is-a-database.md](./what-is-a-database.md) and start the drills. 🚀
