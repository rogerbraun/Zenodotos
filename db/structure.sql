CREATE TABLE "active_admin_comments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "resource_id" integer NOT NULL, "resource_type" varchar(255) NOT NULL, "author_id" integer, "author_type" varchar(255), "body" text, "created_at" datetime, "updated_at" datetime, "namespace" varchar(255));
CREATE TABLE "admin_users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(128) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "books" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "titel" varchar(255), "autor" varchar(255), "hrsg" varchar(255), "signatur" varchar(255), "jahr" integer, "kommentar" text, "anmerkungen" text, "auflage" varchar(255), "baende" varchar(255), "bearbeiter" varchar(255), "bestelladresse" text, "drehbuch" varchar(255), "format" varchar(255), "inhalt" text, "sprache" varchar(255), "literaturvorlage" varchar(255), "nebensignatur" varchar(255), "ort" varchar(255), "platz" varchar(255), "preis" varchar(255), "publikationsart" varchar(255), "reihe" varchar(255), "seiten" varchar(255), "stifter" varchar(255), "verlag" varchar(255), "standort" varchar(255), "datensatz" integer, "aufnahmedatum" date, "issn" varchar(255), "isbn" varchar(255), "invent" varchar(255), "autor_japanisch" varchar(255), "hrsg_japanisch" varchar(255), "drehbuch_japanisch" varchar(255), "reihe_japanisch" varchar(255), "titel_japanisch" varchar(255), "verlag_japanisch" varchar(255), "literaturvorlage_japanisch" varchar(255), "nacsis_japanisch" text, "jid" integer, "nacsis_url" varchar(255), "interne_notizen" varchar(255), "created_at" datetime, "updated_at" datetime, "vormerken" text, "altes_datum" varchar(255));
CREATE TABLE "books_collections" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "book_id" integer, "collection_id" integer);
CREATE VIRTUAL TABLE books_fts USING fts4(id TEXT, titel TEXT, autor TEXT, hrsg TEXT, signatur TEXT, jahr TEXT, kommentar TEXT, anmerkungen TEXT, auflage TEXT, baende TEXT, bearbeiter TEXT, bestelladresse TEXT, drehbuch TEXT, format TEXT, inhalt TEXT, sprache TEXT, literaturvorlage TEXT, nebensignatur TEXT, ort TEXT, platz TEXT, preis TEXT, publikationsart TEXT, reihe TEXT, seiten TEXT, stifter TEXT, verlag TEXT, standort TEXT, datensatz TEXT, aufnahmedatum TEXT, issn TEXT, isbn TEXT, invent TEXT, autor_japanisch TEXT, hrsg_japanisch TEXT, drehbuch_japanisch TEXT, reihe_japanisch TEXT, titel_japanisch TEXT, verlag_japanisch TEXT, literaturvorlage_japanisch TEXT, nacsis_japanisch TEXT, jid TEXT, nacsis_url TEXT, interne_notizen TEXT, created_at TEXT, updated_at TEXT, vormerken TEXT, altes_datum TEXT);
CREATE TABLE 'books_fts_content'(docid INTEGER PRIMARY KEY, 'c0id', 'c1titel', 'c2autor', 'c3hrsg', 'c4signatur', 'c5jahr', 'c6kommentar', 'c7anmerkungen', 'c8auflage', 'c9baende', 'c10bearbeiter', 'c11bestelladresse', 'c12drehbuch', 'c13format', 'c14inhalt', 'c15sprache', 'c16literaturvorlage', 'c17nebensignatur', 'c18ort', 'c19platz', 'c20preis', 'c21publikationsart', 'c22reihe', 'c23seiten', 'c24stifter', 'c25verlag', 'c26standort', 'c27datensatz', 'c28aufnahmedatum', 'c29issn', 'c30isbn', 'c31invent', 'c32autor_japanisch', 'c33hrsg_japanisch', 'c34drehbuch_japanisch', 'c35reihe_japanisch', 'c36titel_japanisch', 'c37verlag_japanisch', 'c38literaturvorlage_japanisch', 'c39nacsis_japanisch', 'c40jid', 'c41nacsis_url', 'c42interne_notizen', 'c43created_at', 'c44updated_at', 'c45vormerken', 'c46altes_datum');
CREATE TABLE "books_fts_docsize" ("docid" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "size" blob);
CREATE TABLE "books_fts_segdir" ("level" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "idx" integer, "start_block" integer, "leaves_end_block" integer, "end_block" integer, "root" blob);
CREATE TABLE 'books_fts_segments'(blockid INTEGER PRIMARY KEY, block BLOB);
CREATE TABLE 'books_fts_stat'(id INTEGER PRIMARY KEY, value BLOB);
CREATE TABLE "borrowers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "anschrift" varchar(255), "bearbeiter" varchar(255), "email" varchar(255), "heimatanschrift" varchar(255), "matrikelnr" integer, "mobiltelefon" varchar(255), "name" varchar(255), "status" varchar(255), "telefon" varchar(255), "telefon2" varchar(255), "ub_nr" varchar(255), "vermerke" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE VIRTUAL TABLE borrowers_fts USING fts4(id TEXT, anschrift TEXT, bearbeiter TEXT, email TEXT, heimatanschrift TEXT, matrikelnr TEXT, mobiltelefon TEXT, name TEXT, status TEXT, telefon TEXT, telefon2 TEXT, ub_nr TEXT, vermerke TEXT, created_at TEXT, updated_at TEXT);
CREATE TABLE 'borrowers_fts_content'(docid INTEGER PRIMARY KEY, 'c0id', 'c1anschrift', 'c2bearbeiter', 'c3email', 'c4heimatanschrift', 'c5matrikelnr', 'c6mobiltelefon', 'c7name', 'c8status', 'c9telefon', 'c10telefon2', 'c11ub_nr', 'c12vermerke', 'c13created_at', 'c14updated_at');
CREATE TABLE 'borrowers_fts_docsize'(docid INTEGER PRIMARY KEY, size BLOB);
CREATE TABLE 'borrowers_fts_segdir'(level INTEGER,idx INTEGER,start_block INTEGER,leaves_end_block INTEGER,end_block INTEGER,root BLOB,PRIMARY KEY(level, idx));
CREATE TABLE 'borrowers_fts_segments'(blockid INTEGER PRIMARY KEY, block BLOB);
CREATE TABLE 'borrowers_fts_stat'(id INTEGER PRIMARY KEY, value BLOB);
CREATE TABLE "collections" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255));
CREATE TABLE "lendings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "return_date" date, "borrower_id" integer, "book_id" integer, "returned" boolean DEFAULT 'f', "created_at" datetime, "updated_at" datetime, "printout_id" integer, "extCount" integer DEFAULT 0);
CREATE TABLE "lendings_reminders" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "lending_id" integer, "reminder_id" integer);
CREATE TABLE "printouts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "reminders" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "send_date" date, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "sent" boolean);
CREATE TABLE "reservations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "book_id" integer, "borrower_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "settings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "var" varchar(255) NOT NULL, "value" text, "target_id" integer, "target_type" varchar(30), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "versions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "item_type" varchar(255) NOT NULL, "item_id" integer NOT NULL, "event" varchar(255) NOT NULL, "whodunnit" varchar(255), "object" text, "created_at" datetime);
CREATE INDEX "index_active_admin_comments_on_author_type_and_author_id" ON "active_admin_comments" ("author_type", "author_id");
CREATE INDEX "index_active_admin_comments_on_namespace" ON "active_admin_comments" ("namespace");
CREATE INDEX "index_admin_notes_on_resource_type_and_resource_id" ON "active_admin_comments" ("resource_type", "resource_id");
CREATE UNIQUE INDEX "index_admin_users_on_email" ON "admin_users" ("email");
CREATE UNIQUE INDEX "index_admin_users_on_reset_password_token" ON "admin_users" ("reset_password_token");
CREATE INDEX "index_lendings_on_book_id" ON "lendings" ("book_id");
CREATE INDEX "index_lendings_on_borrower_id" ON "lendings" ("borrower_id");
CREATE UNIQUE INDEX "index_settings_on_target_type_and_target_id_and_var" ON "settings" ("target_type", "target_id", "var");
CREATE INDEX "index_versions_on_item_type_and_item_id" ON "versions" ("item_type", "item_id");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20111025122650');

INSERT INTO schema_migrations (version) VALUES ('20111025130538');

INSERT INTO schema_migrations (version) VALUES ('20111025150546');

INSERT INTO schema_migrations (version) VALUES ('20111025150547');

INSERT INTO schema_migrations (version) VALUES ('20111030190615');

INSERT INTO schema_migrations (version) VALUES ('20111030193949');

INSERT INTO schema_migrations (version) VALUES ('20111117215909');

INSERT INTO schema_migrations (version) VALUES ('20111214134158');

INSERT INTO schema_migrations (version) VALUES ('20111214135050');

INSERT INTO schema_migrations (version) VALUES ('20111217175929');

INSERT INTO schema_migrations (version) VALUES ('20111219142825');

INSERT INTO schema_migrations (version) VALUES ('20111220223043');

INSERT INTO schema_migrations (version) VALUES ('20120128154852');

INSERT INTO schema_migrations (version) VALUES ('20120128161530');

INSERT INTO schema_migrations (version) VALUES ('20120128162740');

INSERT INTO schema_migrations (version) VALUES ('20120202205704');

INSERT INTO schema_migrations (version) VALUES ('20120403130112');

INSERT INTO schema_migrations (version) VALUES ('20120404111924');

INSERT INTO schema_migrations (version) VALUES ('20120419123809');

INSERT INTO schema_migrations (version) VALUES ('20130321184657');