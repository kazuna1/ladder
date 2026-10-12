# Module 06 — Security Hardening  (outline / checklist)

> **Outline for now.** Full write-up + drills when you reach it. This is the "make it
> production-safe" polish once the auth *works*.

Getting auth working is step one. Hardening is making it safe to expose to the internet.
Topics, roughly in order of importance:

## 1. Secrets management
- `JWT_SECRET` and `PGPASSWORD` in `.env`, `.gitignore`d. Never in code, never in git.
- Production secret = a long random string, different from dev. Rotate if leaked.

## 2. Token storage on the client (the real trade-off)
- **localStorage** — simple, but readable by any JS on the page → vulnerable to **XSS**.
- **httpOnly cookie** — JS can't read it (safer vs XSS), but you must handle **CSRF**.
- No perfect answer; know the trade-off. This is a common interview + design question.

## 3. Refresh tokens (staying logged in safely)
- Short-lived **access token** (~15 min) + long-lived **refresh token** (days/weeks).
- Access token expires → client uses the refresh token to get a new one, no re-login.
- Limits damage from a stolen access token. The standard real-world pattern.

## 4. Rate limiting
- Cap login attempts (e.g. `express-rate-limit`) so attackers can't brute-force passwords
  or hammer `/login`. Defends the thing bcrypt's cost factor also slows.

## 5. Input validation & safety
- Validate/normalize email + password (length, format). Consider a library (`zod`).
- Keep using parameterized queries (`$1`) — no SQL injection. (You already do.)
- `helmet` middleware for sensible security HTTP headers.

## 6. Don't leak information
- Generic auth errors ("Invalid email or password") — don't reveal which was wrong.
- Never return `password_hash`. Never log passwords or tokens.
- Lock down CORS `origin` in production (not the wide-open `cors()` from dev).

## The production checklist

```
[ ] Secrets in .env, gitignored, strong in prod
[ ] Passwords bcrypt-hashed (cost 10–12)
[ ] JWTs signed + short expiry; refresh-token flow for long sessions
[ ] Login rate-limited
[ ] Inputs validated
[ ] Parameterized queries everywhere
[ ] Generic auth error messages
[ ] CORS origin restricted; HTTPS in prod; helmet on
```

When you get here, say **"flesh out module 06"**.
