CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "first_name" varchar,
  "last_name" varchar,
  "phone_number" varchar,
  "email" varchar,
  "password" varchar
);

CREATE TABLE "permissions" (
  "id" integer PRIMARY KEY,
  "name" varchar UNIQUE
);

CREATE TABLE "user_permissions" (
  "user_id" integer,
  "permission_id" integer,
  PRIMARY KEY ("user_id", "permission_id")
);

CREATE TABLE "messages" (
  "id" integer PRIMARY KEY,
  "timestamp" timestamp,
  "created_by" integer,
  "intented_for" integer,
  "message" varchar,
  "status" enum
);

CREATE TABLE "video_conferences" (
  "id" integer PRIMARY KEY,
  "created_by" integer,
  "start_at" timestamp,
  "duration" time,
  "status" enum
);

CREATE TABLE "user_video_conferences" (
  "user_id" integer,
  "conference_id" integer,
  PRIMARY KEY ("user_id", "conference_id")
);

CREATE TABLE "reservations" (
  "id" integer PRIMARY KEY,
  "start_date" timestamp,
  "return_date" timestamp,
  "status" enum,
  "user_id" integer,
  "vehicle_id" integer
);

CREATE TABLE "vehicles" (
  "id" integer PRIMARY KEY,
  "title" varchar,
  "price" float,
  "image_url" varchar,
  "description" varchar,
  "characteristics" varchar,
  "license_plate" varchar,
  "status" enum,
  "created_at" timestamp,
  "agency_id" integer
);

CREATE TABLE "agencies" (
  "id" integer PRIMARY KEY,
  "name" varchar,
  "address" varchar,
  "city" varchar,
  "postal_code" varchar,
  "contry" varchar
);

COMMENT ON COLUMN "video_conferences"."status" IS 'created, pending, cancelled, ended';

COMMENT ON COLUMN "reservations"."status" IS 'pending, confirmed, cancelled';

COMMENT ON COLUMN "vehicles"."status" IS 'available, reserved, unavailable';

ALTER TABLE "user_permissions" ADD CONSTRAINT "user_permission" FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "user_permissions" ADD CONSTRAINT "permission_user" FOREIGN KEY ("permission_id") REFERENCES "permissions" ("id");

ALTER TABLE "reservations" ADD CONSTRAINT "reservation_user" FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "reservations" ADD CONSTRAINT "reservation_vehicule" FOREIGN KEY ("vehicle_id") REFERENCES "vehicles" ("id");

ALTER TABLE "vehicles" ADD CONSTRAINT "vehicule_agency" FOREIGN KEY ("agency_id") REFERENCES "agencies" ("id");

ALTER TABLE "messages" ADD CONSTRAINT "message_user" FOREIGN KEY ("created_by") REFERENCES "users" ("id");

ALTER TABLE "messages" ADD CONSTRAINT "message_user" FOREIGN KEY ("intented_for") REFERENCES "users" ("id");

ALTER TABLE "user_video_conferences" ADD CONSTRAINT "user_video_conferences" FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "user_video_conferences" ADD CONSTRAINT "video_conferences_user" FOREIGN KEY ("conference_id") REFERENCES "video_conferences" ("id");
