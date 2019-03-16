CREATE SEQUENCE events_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."events" (
    "id" integer DEFAULT nextval('events_id_seq') NOT NULL,
    "timestamp" timestamp NOT NULL,
    "type" character varying NOT NULL,
    "payload" text NOT NULL
) WITH (oids = false);
