CREATE OR REPLACE FUNCTION refresh_users_projects()
    RETURNS TRIGGER LANGUAGE plpgsql
    AS $$
    BEGIN
        REFRESH MATERIALIZED VIEW "business"."users_projects";
        RETURN NULL;
    END $$;


CREATE TRIGGER "users_refresh_users_projects"
    AFTER INSERT OR UPDATE OR DELETE OR TRUNCATE
    ON "business"."users"
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_users_projects();

CREATE TRIGGER "tasks_refresh_users_projects"
    AFTER INSERT OR UPDATE OR DELETE OR TRUNCATE
    ON "business"."tasks"
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_users_projects();

CREATE TRIGGER "projects_refresh_users_projects"
    AFTER INSERT OR UPDATE OR DELETE OR TRUNCATE
    ON "business"."projects"
    FOR EACH STATEMENT
    EXECUTE FUNCTION refresh_users_projects();
