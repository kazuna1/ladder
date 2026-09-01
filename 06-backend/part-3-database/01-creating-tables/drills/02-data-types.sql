-- MODULE 01 · DRILL 02 — Data Types
-- Each column must have a TYPE that says what it can hold. Meet the common ones.
-- ---------------------------------------------------------------------------

-- The types you'll actually use:
--   INTEGER       whole numbers            42
--   BIGINT        huge whole numbers       9000000000
--   TEXT          string, any length       'hello world'
--   VARCHAR(n)    string, max n chars      VARCHAR(50)
--   BOOLEAN       true / false             true
--   NUMERIC(p,s)  exact decimals (money)   NUMERIC(10,2) -> 19.99
--   DATE          a date                   '2026-08-24'
--   TIMESTAMP     date + time              '2026-08-24 10:30'

-- TODO 1: create a table "products" that uses several types:
--   name        → VARCHAR(100)
--   price       → NUMERIC(10,2)      (good for money — exact, 2 decimals)
--   in_stock    → BOOLEAN
--   quantity    → INTEGER
--   added_on    → DATE

CREATE TABLE products (
    name VARCHAR(100),
    price NUMERIC(10,2),
    in_stock BOOLEAN,
    quantity INTEGER,
    added_on DATE
);
-- TODO 2: \d products  → notice how each column shows its exact type.

ladder_notes=# \d products
                      Table "public.products"
  Column  |          Type          | Collation | Nullable | Default
----------+------------------------+-----------+----------+---------
 name     | character varying(100) |           |          |
 price    | numeric(10,2)          |           |          |
 in_stock | boolean                |           |          |
 quantity | integer                |           |          |
 added_on | date                   |           |          |


ladder_notes=#

-- TODO 3: create a table "events" with:
--   name       → TEXT
--   starts_at  → TIMESTAMP
--   is_public  → BOOLEAN

CREATE TABLE events (
    name TEXT,
    starts_at TIMESTAMP,
    is_public BOOLEAN
);


ladder_notes=# \d events
                          Table "public.events"
  Column   |            Type             | Collation | Nullable | Default
-----------+-----------------------------+-----------+----------+---------
 name      | text                        |           |          |
 starts_at | timestamp without time zone |           |          |
 is_public | boolean                     |           |          |


ladder_notes=#
-- WHAT TO NOTICE:
-- - Pick the type that fits the data: money → NUMERIC (never use floating types for
--   money — they round wrong). Names → TEXT or VARCHAR. Yes/no → BOOLEAN.
-- - VARCHAR(n) caps the length; TEXT has no cap. For most strings, TEXT is fine.
-- - The type is a promise + a guard: the DB will REJECT a value that doesn't fit
--   (e.g. putting 'hello' into an INTEGER column errors).
