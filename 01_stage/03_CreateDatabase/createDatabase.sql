CREATE DATABASE users;

CREATE SCHEMA IF NOT EXISTS users;

DROP TABLE IF EXISTS "companies";
CREATE TABLE "users"."companies" (
    "ID" numeric NOT NULL,
    "name" character varying(100) NOT NULL,
    "translated_name" character varying(100),
    "site" character varying(100),
    "logo" bytea,
    CONSTRAINT "companies_ID" PRIMARY KEY ("ID")
) WITH (oids = false);


DROP TABLE IF EXISTS "hardskills";
CREATE TABLE "users"."hardskills" (
    "ID" numeric NOT NULL,
    "name" character varying(100) NOT NULL,
    CONSTRAINT "hardskills_ID" PRIMARY KEY ("ID")
) WITH (oids = false);


DROP TABLE IF EXISTS "subscriptions";
CREATE TABLE "users"."subscriptions" (
    "user_id" uuid NOT NULL,
    "subscription_id" uuid NOT NULL
) WITH (oids = false);


DROP TABLE IF EXISTS "user_hardskills";
CREATE TABLE "users"."user_hardskills" (
    "user_id" uuid NOT NULL,
    "hardskill_id" numeric NOT NULL
) WITH (oids = false);


DROP TABLE IF EXISTS "user_secure";
CREATE TABLE "users"."user_secure" (
    "ID" uuid NOT NULL,
    "user_id" uuid NOT NULL,
    "password" character varying(15) NOT NULL,
    "registration_email" character varying(100) NOT NULL,
    CONSTRAINT "secure_id_regEmail" UNIQUE ("user_id", "registration_email")
) WITH (oids = false);


DROP TABLE IF EXISTS "users";
CREATE TABLE "users"."users" (
    "ID" uuid NOT NULL,
    "name" character varying(150) NOT NULL,
    "last_name" character varying(150),
    "surname" character varying(150),
    "gender" character varying,
    "birthdate" date,
    "location" character varying(250),
    "nickname" character varying(15) NOT NULL,
    "avatar" bytea,
    "gitHub" character varying(150),
    "user_description" character varying(500),
    CONSTRAINT "users_location" UNIQUE ("name", "last_name", "location"),
    CONSTRAINT "users_ID" PRIMARY KEY ("ID"),
    CONSTRAINT "users_nickname" UNIQUE ("nickname")
) WITH (oids = false);

CREATE INDEX "users_birthdate" ON "users"."users" USING btree ("name", "last_name", "birthdate");
CREATE INDEX "users_name_lastName" ON "users"."users" USING btree ("name", "last_name");

-- create table UsersLogs
DROP TABLE IF EXISTS "user_logs";
CREATE TABLE "users"."user_logs" (
    "ID" uuid NOT NULL,
    "user_id" uuid NOT NULL,
    "date_registration" timestamp NOT NULL,
    "last_loged_date" timestamp NOT NULL,
    CONSTRAINT "user_logs_id" PRIMARY KEY ("ID")
) WITH (oids = false);

-- create table WorkExperience
DROP TABLE IF EXISTS "work_experience";
CREATE TABLE "users"."work_experience" (
    "user_id" uuid NOT NULL,
    "company_id" numeric NOT NULL,
    "position" character varying(100),
    "start_date" date NOT NULL,
    "finish_date" date
) WITH (oids = false);

CREATE INDEX "user_exp_fk" ON "users"."work_experience" USING btree ("user_id", "company_id");

-- constraints
ALTER TABLE ONLY "users"."subscriptions" ADD CONSTRAINT "subscript_to_user_fk" FOREIGN KEY (subscription_id) REFERENCES "users"("ID") ON DELETE SET NULL NOT DEFERRABLE;
ALTER TABLE ONLY "users"."subscriptions" ADD CONSTRAINT "user_to_subscript_fk" FOREIGN KEY (user_id) REFERENCES "users"("ID") ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "users"."user_hardskills" ADD CONSTRAINT "skills_fk" FOREIGN KEY (hardskill_id) REFERENCES "hardskills"("ID") ON DELETE SET NULL NOT DEFERRABLE;
ALTER TABLE ONLY "users"."user_hardskills" ADD CONSTRAINT "user_skills_fk" FOREIGN KEY (user_id) REFERENCES "users"("ID") ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "users"."user_secure" ADD CONSTRAINT "user_secure_fk" FOREIGN KEY (user_id) REFERENCES "users"("ID") ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "users"."user_logs" ADD CONSTRAINT "user_log_fk" FOREIGN KEY (user_id) REFERENCES "users"("ID") ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "users"."work_experience" ADD CONSTRAINT "exp_company_id_fk" FOREIGN KEY (company_id) REFERENCES "companies"("ID") ON DELETE SET NULL NOT DEFERRABLE;
ALTER TABLE ONLY "users"."work_experience" ADD CONSTRAINT "exp_user_id_fk" FOREIGN KEY (user_id) REFERENCES "users"("ID") ON DELETE CASCADE NOT DEFERRABLE;