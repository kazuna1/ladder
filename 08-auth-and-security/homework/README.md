# Homework — sharpen at home 🏠

You learn the drills at the **office PC**. At **home**, you reinforce by re-building the
same ideas *from scratch* — no copying. This is where knowledge moves from "I saw it"
to "I can write it with my eyes closed."

## The rules (keep it simple)

1. **No dates, no schedule.** Do homework whenever. It's gated by *understanding*, not time.
2. **Only unlock homework for what you've finished at the office.** Did office module 01?
   → module 01 homework is fair game. Haven't done JWT yet? → leave module 02 homework alone.
3. **Write from a BLANK file. Don't peek at the office drills.** The whole point is recall.
   If you can only do it by copying, you haven't learned it yet — that's useful information.
4. **2–3 small snippets per concept.** Each is a *variation* of what you did, not the same thing.
5. **Stuck? That's the gold.** Don't grind for an hour. Write a `// STUCK: ...` comment saying
   exactly where you froze, move on, and bring it to the office. We review it together — the
   thing you got stuck on is the thing you'll never forget after.

## Setup at home (once per homework folder)

Same as the drills — each folder needs its own bcryptjs:
```bash
cd 08-auth-and-security/homework/01-password-hashing
npm init -y
npm install bcryptjs        # (jsonwebtoken too, once you reach module 02)
npm pkg set type=module
node hw1-....js             # run whatever file you're working on
```

## How each homework works

Each `NN-topic/README.md` lists **2–3 challenges**. For each one:
- It tells you the **goal** and the **expected output** — but **not how**.
- **You create the `.js` file yourself** (e.g. `hw1-hash-many.js`) and solve it blank.
- Compare your output to the "expected" line to self-check.

## Progress — what's unlocked

Tick a box when you finish that module at the OFFICE; then its homework is open.

```
[x] 01 · password-hashing   → homework READY  ✅
[ ] 02 · jwt-tokens         → I'll add it when you finish office module 02
[ ] 03 · register-and-login → added after office module 03
[ ] 04 · protected-routes   → added after office module 04
[ ] 05 · authorization      → added after office module 05
[ ] 06 · security-hardening → added after office module 06
```

When you clear a module at the office, say **"unlock homework NN"** and I'll write that
module's challenges.

## The habit, in one line

> **Office = learn it with hints. Home = rebuild it blank. Stuck spots = review at office.**

This same `homework/` pattern will live in every future phase (DSA, system design, Spring
Boot). It's your permanent "stay sharp" muscle. 💪
