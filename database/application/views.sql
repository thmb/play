CREATE MATERIALIZED VIEW "business"."users_projects" AS
    SELECT
        "users"."id" AS "user_id",
        "users"."name" AS "user_name",
        "users"."address" AS "user_address",
        "users"."location" AS "user_location",
        "projects"."id" AS "project_id",
        "projects"."title" AS "project_title",
        "projects"."report" AS "project_report",
        jsonb_build_object(
            'deadline', "projects"."deadline",
            'budget', "projects"."budget",
        ) AS "project_settings",
    FROM
        "business"."users"
    INNER JOIN
        "business"."tasks"
    ON
        "users"."id" = "tasks"."user_id"
    INNER JOIN
        "business"."projects"
    ON
        "tasks"."project_id" = "projects"."id"
    WHERE
        "projects"."done" IS FALSE;


CREATE INDEX "users_projects_user_id"
    ON "business"."users_projects" ("user_id");

CREATE INDEX "users_projects_user_name"
    ON "business"."users_projects" ("user_name");

CREATE INDEX "users_projects_user_address"
    ON "business"."users_projects"
    USING gin("user_address");

CREATE INDEX "users_projects_user_location"
    ON "business"."users_projects" ("user_location");
