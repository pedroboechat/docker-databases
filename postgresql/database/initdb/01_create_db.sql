SET
    check_function_bodies = false;

CREATE TABLE "Auth"(
    id serial NOT NULL,
    username varchar(100) NOT NULL,
    pswd varchar(600) NOT NULL,
    valid_token varchar(600),
    created_at timestamp WITH time zone,
    updated_at timestamp WITH time zone,
    CONSTRAINT "Auth_pkey" PRIMARY KEY(id)
);

CREATE FUNCTION set_created_date() RETURNS trigger AS $$ BEGIN NEW.created_at := CURRENT_TIMESTAMP;

RETURN NEW;

END;

$$ LANGUAGE plpgsql;

CREATE FUNCTION set_updated_date() RETURNS trigger AS $$ BEGIN NEW.updated_at := CURRENT_TIMESTAMP;

RETURN NEW;

END;

$$ LANGUAGE plpgsql;

DO $$ DECLARE t text;

BEGIN FOR t IN
SELECT
    table_name
FROM
    information_schema.columns
WHERE
    column_name = 'created_at' LOOP EXECUTE format(
        'CREATE TRIGGER set_created_at
                        BEFORE INSERT ON %I
                        FOR EACH ROW EXECUTE PROCEDURE set_created_date()',
        t
    );

END LOOP;

END;

$$ LANGUAGE plpgsql;

DO $$ DECLARE t text;

BEGIN FOR t IN
SELECT
    table_name
FROM
    information_schema.columns
WHERE
    column_name = 'updated_at' LOOP EXECUTE format(
        'CREATE TRIGGER set_updated_at
                        BEFORE INSERT OR UPDATE ON %I
                        FOR EACH ROW EXECUTE PROCEDURE set_updated_date()',
        t
    );

END LOOP;

END;

$$ LANGUAGE plpgsql;
