

CREATE TABLE "demo_athlete" ("athlete_id" varchar(12) NOT NULL PRIMARY KEY, "name" varchar(30) NOT NULL, "classObject_id" integer NOT NULL REFERENCES "demo_class" ("class_id"));
INSERT INTO "demo_athlete" VALUES ('201230671352', '劳智锟', 9);
INSERT INTO "demo_athlete" VALUES ('20123067356', '杨轩', 10);
INSERT INTO "demo_athlete" VALUES ('20123065756', '吴大哥', 7);
INSERT INTO "demo_athlete" VALUES ('201230673556', '劳智锟', 4);
INSERT INTO "demo_athlete" VALUES ('201230671351', '劳智锟', 11);
INSERT INTO "demo_athlete" VALUES ('201536023658', '王师傅', 17);
INSERT INTO "demo_athlete" VALUES ('201130671353', '劳智锟', 13);
INSERT INTO "demo_athlete" VALUES ('20123067354', '杨轩', 2);
INSERT INTO "demo_athlete" VALUES ('201230673419', '吴大哥', 18);
INSERT INTO "demo_athlete" VALUES ('201230673536', '杨轩', 4);
INSERT INTO "demo_athlete" VALUES ('201230673553', '杨轩', 2);
INSERT INTO "demo_athlete" VALUES ('22', '2', 19);
INSERT INTO "demo_athlete" VALUES ('2', '2', 19);
INSERT INTO "demo_athlete" VALUES ('990', '2', 20);
INSERT INTO "demo_athlete" VALUES ('5', '4', 21);
INSERT INTO "demo_athlete" VALUES ('789', '5', 22);
INSERT INTO "demo_athlete" VALUES ('709', '4', 23);


CREATE INDEX demo_athlete_5bc1dc4b ON "demo_athlete" ("classObject_id");

CREATE TABLE "demo_class" ("class_id" integer NOT NULL PRIMARY KEY, "grade" varchar(4) NOT NULL, "major" varchar(30) NOT NULL, "num" integer NOT NULL);
INSERT INTO "demo_class" VALUES (1, '2014', '软件工程', 4);
INSERT INTO "demo_class" VALUES (2, '2012', '软件工程', 7);
INSERT INTO "demo_class" VALUES (3, '2014', '软件工程', 6);
INSERT INTO "demo_class" VALUES (4, '2012', '软件工程', 5);
INSERT INTO "demo_class" VALUES (5, '2012', '软件工程', 2);
INSERT INTO "demo_class" VALUES (6, '2012', '软件工程', 3);
INSERT INTO "demo_class" VALUES (7, '2012', '软件工程', 1);
INSERT INTO "demo_class" VALUES (8, '2014', '软件工程', 3);
INSERT INTO "demo_class" VALUES (9, '2014', '软件工程', 2);
INSERT INTO "demo_class" VALUES (10, '2012', '软件工程', 6);
INSERT INTO "demo_class" VALUES (11, '2013', '软件工程', 7);
INSERT INTO "demo_class" VALUES (12, '2013', '软件工程', 4);
INSERT INTO "demo_class" VALUES (13, '2015', '软件工程', 3);
INSERT INTO "demo_class" VALUES (14, '2015', '软件工程', 5);
INSERT INTO "demo_class" VALUES (15, '2015', '软件工程', 4);
INSERT INTO "demo_class" VALUES (16, '2015', '软件工程', 7);
INSERT INTO "demo_class" VALUES (17, '2015', '软件工程', 1);
INSERT INTO "demo_class" VALUES (18, '2012', '软件工程', 4);
INSERT INTO "demo_class" VALUES (19, '2', '2', 2);
INSERT INTO "demo_class" VALUES (20, '2', '1', 2);
INSERT INTO "demo_class" VALUES (21, '2', '1', 3);
INSERT INTO "demo_class" VALUES (22, '2', '2', 4);
INSERT INTO "demo_class" VALUES (23, '2', '3', 6);
