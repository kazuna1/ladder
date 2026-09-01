-- MODULE 01 · DRILL 03 — Constraints (rules on a column)
-- After the type, you can STACK rules the database will enforce for you.
-- ---------------------------------------------------------------------------

-- The constraints you'll actually use:
--   NOT NULL                        this column can't be empty
--   DEFAULT x                       if not given, use x
--   UNIQUE                          no two rows can share this value
--   PRIMARY KEY                     the row's unique id (UNIQUE + NOT NULL, one per table)
--   GENERATED ALWAYS AS IDENTITY    auto-number this column (1, 2, 3...) — for ids

-- TODO 1: create a table "users" that uses several constraints:
--   id       → INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY
--   email    → TEXT NOT NULL UNIQUE          (required AND no duplicates)
--   name     → TEXT NOT NULL
--   is_admin → BOOLEAN DEFAULT false          (defaults to false if not given)
--
--   shape:
--   CREATE TABLE users (
--     id       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--     email    TEXT NOT NULL UNIQUE,
--     name     TEXT NOT NULL,
--     is_admin BOOLEAN DEFAULT false
--   );


CREATE TABLE users (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    is_admin BOOLEAN DEFAULT false
);

-- TODO 2: \d users → read the constraints column. Notice:
--   - id shows as the primary key
--   - email shows not-null + a unique index

ladder_notes=# \d users
                           Table "public.users"
  Column  |  Type   | Collation | Nullable |           Default
----------+---------+-----------+----------+------------------------------
 id       | integer |           | not null | generated always as identity
 email    | text    |           | not null |
 name     | text    |           | not null |
 is_admin | boolean |           |          | false
Indexes:
    "users_pkey" PRIMARY KEY, btree (id)
    "users_email_key" UNIQUE CONSTRAINT, btree (email)


ladder_notes=#
-- TODO 3 (understand stacking): a column can have MANY constraints in a row.
--   Look at email above: TEXT + NOT NULL + UNIQUE = three rules stacked. Order among
--   constraints mostly doesn't matter. Type always comes first, right after the name.



-- WHAT TO NOTICE:
-- - Constraints move your validation INTO the database. Your old `if (!email)` guard
--   becomes NOT NULL. "No two users with the same email" becomes UNIQUE. The DB now
--   refuses bad data itself — even if your code forgets to check.
-- - PRIMARY KEY = the id. GENERATED ALWAYS AS IDENTITY = auto-fills it. Together they're
--   the standard id setup for every table.
