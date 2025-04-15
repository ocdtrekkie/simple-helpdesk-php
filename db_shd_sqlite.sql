BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "tbl_department" (
	"td_id"	INTEGER NOT NULL,
	"td_name"	TEXT NOT NULL,
	"td_description"	TEXT NOT NULL,
	PRIMARY KEY("td_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tbl_priority" (
	"tp_id"	INTEGER NOT NULL,
	"tp_name"	TEXT NOT NULL,
	PRIMARY KEY("tp_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tbl_service" (
	"ts_id"	INTEGER NOT NULL,
	"ts_name"	TEXT NOT NULL,
	"ts_description"	TEXT NOT NULL,
	PRIMARY KEY("ts_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tbl_ticket" (
	"tt_id"	INTEGER NOT NULL,
	"tt_user"	INTEGER NOT NULL,
	"tt_subject"	TEXT NOT NULL,
	"tt_department"	INTEGER NOT NULL,
	"tt_service"	INTEGER NOT NULL,
	"tt_priority"	INTEGER NOT NULL,
	"tt_message"	TEXT NOT NULL,
	"tt_status"	TEXT NOT NULL DEFAULT 'NEW',
	"tt_created"	NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("tt_id" AUTOINCREMENT),
	FOREIGN KEY("tt_department") REFERENCES "tbl_department"("td_id"),
	FOREIGN KEY("tt_priority") REFERENCES "tbl_priority"("tp_id"),
	FOREIGN KEY("tt_service") REFERENCES "tbl_service"("ts_id"),
	FOREIGN KEY("tt_user") REFERENCES "tbl_user"("tu_id")
);
CREATE TABLE IF NOT EXISTS "tbl_user" (
	"tu_id"	INTEGER NOT NULL,
	"tu_role"	TEXT NOT NULL,
	"tu_user"	TEXT NOT NULL UNIQUE,
	"tu_full_name"	TEXT NOT NULL,
	"tu_email"	TEXT NOT NULL DEFAULT '',
	PRIMARY KEY("tu_id" AUTOINCREMENT)
);
INSERT INTO "tbl_department" VALUES (1,'General','Not associated with a given department');
INSERT INTO "tbl_priority" VALUES (1,'Critical');
INSERT INTO "tbl_priority" VALUES (2,'High');
INSERT INTO "tbl_priority" VALUES (3,'Medium');
INSERT INTO "tbl_priority" VALUES (4,'Low');
INSERT INTO "tbl_service" VALUES (1,'General','Not associated with a given service');
COMMIT;
