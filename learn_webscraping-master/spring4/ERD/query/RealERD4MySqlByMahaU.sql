SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS T_ROLES;
DROP TABLE IF EXISTS T_AUTHORITIES;
DROP TABLE IF EXISTS T_LIBRARY_BOOK;
DROP TABLE IF EXISTS T_BOOKS;
DROP TABLE IF EXISTS T_COMMONCODES;
DROP TABLE IF EXISTS T_FILEINFORS;
DROP TABLE IF EXISTS T_LIBRARYS;
DROP TABLE IF EXISTS T_MEMBERS;
DROP TABLE IF EXISTS T_RECODELOGS;




/* Create Tables */

CREATE TABLE T_AUTHORITIES
(
	AUTHORITYID varchar(50) NOT NULL,
	AUTHORITYNAME varchar(50) NOT NULL,
	DESCRIPTION varchar(100),
	PRIMARY KEY (AUTHORITYID)
);


CREATE TABLE T_BOOKS
(
	BOOKID double NOT NULL,
	BOOKNAME varchar(100) NOT NULL,
	PUBLISHER varchar(50) NOT NULL,
	AUTHOR varchar(50) NOT NULL,
	BOOKINFORMATION varchar(2000),
	PRIMARY KEY (BOOKID)
);


CREATE TABLE T_COMMONCODES
(
	COMMONCODEID double NOT NULL,
	-- INSERT MENUALLY
	PARENTCODE varchar(5) NOT NULL COMMENT 'INSERT MENUALLY',
	-- INSERT COLUME NAME ON TABLE OR CODE ID
	CHILDCODE varchar(50) NOT NULL COMMENT 'INSERT COLUME NAME ON TABLE OR CODE ID',
	CODENAME varchar(50),
	DESCRIPTION varchar(100),
	PRIMARY KEY (COMMONCODEID),
	UNIQUE (PARENTCODE, CHILDCODE)
);


CREATE TABLE T_FILEINFORS
(
	FILEINFORID double NOT NULL,
	-- PHYSICAL_FILE_NAME
	PHYSICALFILENAME varchar(255) NOT NULL COMMENT 'PHYSICAL_FILE_NAME',
	-- LOGICAL_FILE_NAME
	LOGICALFILENAME varchar(255) NOT NULL COMMENT 'LOGICAL_FILE_NAME',
	-- PHYSICAL_FILE_DIRECTORY
	PHYSICALFILEDIRECTORY varchar(150) COMMENT 'PHYSICAL_FILE_DIRECTORY',
	-- FILE_SIZE
	FILESIZE bigint COMMENT 'FILE_SIZE',
	-- use to need that upload multi file different sort of it.
	FILETYPE varchar(10) COMMENT 'use to need that upload multi file different sort of it.',
	FILECONTENTTYPE varchar(50),
	-- PHYSICAL_THUMBNAIL_DIRECTORY
	PHYSICALTHUMBNAILDIRECTORY varchar(150) COMMENT 'PHYSICAL_THUMBNAIL_DIRECTORY',
	-- PHYSICAL_THUMBNAIL_FILE_NAME
	PHYSICALTHUMBNAILFILENAME varchar(50) COMMENT 'PHYSICAL_THUMBNAIL_FILE_NAME',
	RELATEDID double NOT NULL,
	PRIMARY KEY (FILEINFORID)
);


CREATE TABLE T_LIBRARYS
(
	LIBRARYID double NOT NULL,
	LIBRARYNAME varchar(50) NOT NULL,
	LATITUDE varchar(20),
	LONGITUDE varchar(20),
	ADDTIONLOCATION varchar(200),
	ADDTIONAL_INFORMATION varchar(2000),
	PRIMARY KEY (LIBRARYID)
);


CREATE TABLE T_LIBRARY_BOOK
(
	LIBRARYID double NOT NULL,
	BOOKID double NOT NULL,
	UNIQUE (LIBRARYID, BOOKID)
);


CREATE TABLE T_MEMBERS
(
	-- Physical ID
	MEMBERID double NOT NULL COMMENT 'Physical ID',
	-- Logical ID
	-- 
	EMAIL varchar(200) NOT NULL COMMENT 'Logical ID
',
	MEMBERNAME varchar(50) NOT NULL,
	PASSWORD varchar(20) NOT NULL,
	ENABLED varchar(1) NOT NULL,
	PRIMARY KEY (MEMBERID),
	UNIQUE (EMAIL)
);


CREATE TABLE T_RECODELOGS
(
	RELTEDID double NOT NULL,
	INSERT_DATE varchar(20) NOT NULL,
	INSERT_MEMBERID decimal NOT NULL,
	INSERT_MEMBERNAME varchar(50) NOT NULL,
	UPDATE_DATE varchar(20) NOT NULL,
	UPDATE_MEMBERID decimal NOT NULL,
	UPDATE_MEMBERNAME varchar(50) NOT NULL,
	PRIMARY KEY (RELTEDID)
);


CREATE TABLE T_ROLES
(
	-- Physical ID
	MEMBERID double NOT NULL COMMENT 'Physical ID',
	AUTHORITYID varchar(50) NOT NULL,
	UNIQUE (MEMBERID, AUTHORITYID)
);



/* Create Foreign Keys */

ALTER TABLE T_ROLES
	ADD FOREIGN KEY (AUTHORITYID)
	REFERENCES T_AUTHORITIES (AUTHORITYID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE T_LIBRARY_BOOK
	ADD FOREIGN KEY (BOOKID)
	REFERENCES T_BOOKS (BOOKID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE T_LIBRARY_BOOK
	ADD FOREIGN KEY (LIBRARYID)
	REFERENCES T_LIBRARYS (LIBRARYID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE T_ROLES
	ADD FOREIGN KEY (MEMBERID)
	REFERENCES T_MEMBERS (MEMBERID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



