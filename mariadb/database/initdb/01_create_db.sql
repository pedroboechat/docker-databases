CREATE TABLE "Auth"(
    id serial NOT NULL,
    username varchar(100) NOT NULL,
    pswd varchar(600) NOT NULL,
    valid_token varchar(600),
    created_at timestamp WITH time zone,
    updated_at timestamp WITH time zone,
    CONSTRAINT "Auth_pkey" PRIMARY KEY(id)
);