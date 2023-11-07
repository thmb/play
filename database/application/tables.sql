CREATE SCHEMA IF NOT EXISTS "business";

CREATE TABLE "business"."authentications" (
    "user_id" uuid PRIMARY KEY,
    "username" varchar(64) NOT NULL,
    "password" varchar(128) NOT NULL,
    "version" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "business"."authorizations" (
    "user_id" uuid,
    "role_id" uuid,
    PRIMARY KEY ("user_id", "role_id")
);

CREATE TABLE "business"."roles" (
    "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
    "name" varchar(32) NOT NULL,
    "permissions" varchar(32)[] NOT NULL,
    "version" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "business"."users" (
    "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
    "name" varchar(64) NOT NULL,
    "skills" varchar(32)[] NOT NULL,
    "address" jsonb,
    "location" geometry(point,4326),
    "payment" float,
    "version" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "business"."tasks" (
    "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
    "previous_id" uuid,
    "user_id" uuid,
    "project_id" uuid NOT NULL,
    "items" jsonb[] NOT NULL,
    "effort" interger,
    "version" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "business"."projects" (
    "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
    "title" varchar(64),
    "report" text,
    "deadline" timestamptz,
    "budget" double,
    "done" boolean NOT NULL DEFAULT (false),
    "version" timestamptz NOT NULL DEFAULT (now())
);

CREATE INDEX ON "business"."authentications" ("username");

CREATE INDEX ON "business"."authentications" ("password");

CREATE INDEX ON "business"."authentications" ("version");

CREATE INDEX ON "business"."roles" ("name");

CREATE INDEX ON "business"."roles" ("permissions");

CREATE INDEX ON "business"."roles" ("version");

CREATE INDEX ON "business"."users" ("name");

CREATE INDEX ON "business"."users" ("skills");

CREATE INDEX ON "business"."users" ("address");

CREATE INDEX ON "business"."users" ("location");

CREATE INDEX ON "business"."users" ("payment");

CREATE INDEX ON "business"."users" ("version");

CREATE INDEX ON "business"."tasks" ("previous_id");

CREATE INDEX ON "business"."tasks" ("user_id");

CREATE INDEX ON "business"."tasks" ("project_id");

CREATE INDEX ON "business"."tasks" ("items");

CREATE INDEX ON "business"."tasks" ("effort");

CREATE INDEX ON "business"."tasks" ("version");

CREATE INDEX ON "business"."projects" ("title");

CREATE INDEX ON "business"."projects" ("report");

CREATE INDEX ON "business"."projects" ("deadline");

CREATE INDEX ON "business"."projects" ("budget");

CREATE INDEX ON "business"."projects" ("done");

CREATE INDEX ON "business"."projects" ("version");

COMMENT ON COLUMN "business"."users"."skills" IS 'item skill';

COMMENT ON COLUMN "business"."users"."address" IS 'street, number, city, etc';

COMMENT ON COLUMN "business"."users"."location" IS 'lat, lng';

COMMENT ON COLUMN "business"."users"."payment" IS 'amount per hour';

COMMENT ON COLUMN "business"."tasks"."previous_id" IS 'dependency';

COMMENT ON COLUMN "business"."tasks"."user_id" IS 'planning phase';

COMMENT ON COLUMN "business"."tasks"."items" IS 'type, date, skill, content';

COMMENT ON COLUMN "business"."tasks"."effort" IS 'amount of time (hours)';

COMMENT ON COLUMN "business"."projects"."report" IS 'rich (HTML/MD) content';

COMMENT ON COLUMN "business"."projects"."budget" IS 'USD, EUR or Bitcoin';

ALTER TABLE "business"."authentications" ADD FOREIGN KEY ("user_id") REFERENCES "business"."users" ("id");

ALTER TABLE "business"."authorizations" ADD FOREIGN KEY ("user_id") REFERENCES "business"."users" ("id");

ALTER TABLE "business"."authorizations" ADD FOREIGN KEY ("role_id") REFERENCES "business"."roles" ("id");

ALTER TABLE "business"."tasks" ADD FOREIGN KEY ("previous_id") REFERENCES "business"."tasks" ("id");

ALTER TABLE "business"."tasks" ADD FOREIGN KEY ("user_id") REFERENCES "business"."users" ("id");

ALTER TABLE "business"."tasks" ADD FOREIGN KEY ("project_id") REFERENCES "business"."projects" ("id");
