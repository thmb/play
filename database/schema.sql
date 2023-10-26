CREATE TABLE "authentications" (
  "user_id" uuid PRIMARY KEY,
  "username" varchar(64) NOT NULL,
  "password" varchar(128) NOT NULL,
  "version" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "authorizations" (
  "user_id" uuid,
  "role_id" uuid,
  PRIMARY KEY ("user_id", "role_id")
);

CREATE TABLE "roles" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "name" varchar(32) NOT NULL,
  "permissions" varchar(32)[] NOT NULL,
  "version" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "users" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "name" varchar(64) NOT NULL,
  "skills" varchar(32)[] NOT NULL,
  "address" jsonb,
  "location" geometry(point,4326),
  "payment" double,
  "version" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "tasks" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "previous_id" uuid,
  "user_id" uuid,
  "project_id" uuid NOT NULL,
  "items" jsonb[] NOT NULL,
  "effort" interger,
  "version" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "projects" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "title" varchar(64),
  "report" text,
  "deadline" timestamptz,
  "budget" float,
  "done" boolean NOT NULL DEFAULT (false),
  "version" timestamptz NOT NULL DEFAULT (now())
);

CREATE INDEX ON "authentications" ("username");

CREATE INDEX ON "authentications" ("password");

CREATE INDEX ON "authentications" ("version");

CREATE INDEX ON "roles" ("name");

CREATE INDEX ON "roles" ("permissions");

CREATE INDEX ON "roles" ("version");

CREATE INDEX ON "users" ("name");

CREATE INDEX ON "users" ("skills");

CREATE INDEX ON "users" ("address");

CREATE INDEX ON "users" ("location");

CREATE INDEX ON "users" ("payment");

CREATE INDEX ON "users" ("version");

CREATE INDEX ON "tasks" ("previous_id");

CREATE INDEX ON "tasks" ("user_id");

CREATE INDEX ON "tasks" ("project_id");

CREATE INDEX ON "tasks" ("items");

CREATE INDEX ON "tasks" ("effort");

CREATE INDEX ON "tasks" ("version");

CREATE INDEX ON "projects" ("title");

CREATE INDEX ON "projects" ("report");

CREATE INDEX ON "projects" ("deadline");

CREATE INDEX ON "projects" ("budget");

CREATE INDEX ON "projects" ("done");

CREATE INDEX ON "projects" ("version");

COMMENT ON COLUMN "users"."skills" IS 'item skill';

COMMENT ON COLUMN "users"."address" IS 'street, number, city, etc';

COMMENT ON COLUMN "users"."location" IS 'lat, lng';

COMMENT ON COLUMN "users"."payment" IS 'amount per hour ';

COMMENT ON COLUMN "tasks"."previous_id" IS 'in sequence';

COMMENT ON COLUMN "tasks"."user_id" IS 'allows null for project plan';

COMMENT ON COLUMN "tasks"."items" IS 'type, date, skill, content';

COMMENT ON COLUMN "tasks"."effort" IS 'in hours';

COMMENT ON COLUMN "projects"."report" IS 'HTML content';

COMMENT ON COLUMN "projects"."budget" IS 'EUR or Bitcoin';

ALTER TABLE "authentications" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "authorizations" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "authorizations" ADD FOREIGN KEY ("role_id") REFERENCES "roles" ("id");

ALTER TABLE "tasks" ADD FOREIGN KEY ("previous_id") REFERENCES "tasks" ("id");

ALTER TABLE "tasks" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "tasks" ADD FOREIGN KEY ("project_id") REFERENCES "projects" ("id");
