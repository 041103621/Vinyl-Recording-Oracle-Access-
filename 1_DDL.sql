--Created by: group6(S322)
--run as 'sys as sysdba'
--Assignment2, Apr 5 2024

CREATE TABLESPACE assign2
  DATAFILE 'assign2.dat' SIZE 40M 
  ONLINE; 
  
-- Create Users
CREATE USER group6 IDENTIFIED BY group123 ACCOUNT UNLOCK
	DEFAULT TABLESPACE assign2
	QUOTA 20M ON assign2;	
	
-- Create ROLES
CREATE ROLE labAdmin;

-- Grant PRIVILEGES
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE TRIGGER, CREATE PROCEDURE TO labAdmin;
GRANT labAdmin TO group6;

-- NOW we can connect as the applicationAdmin and create tables, views and triggers
CONNECT group6/group123;


-- Creating sequences for primary keys
CREATE SEQUENCE seq_type_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_genre_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_artist_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_vinylalbum_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_tracklist_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_fnames_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_lnames_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_artist_lastname_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_artist_firstname_id START WITH 1 INCREMENT BY 1;


create table TYPE 
(
  typeID number primary key,
  name VARCHAR2(20) not null
);

create table GENRE
(
  genreID number primary key,
  name VARCHAR2(20) not null
);

--create ARTIST and associated tables
CREATE TABLE ARTIST (
    artistID NUMBER PRIMARY KEY,
    typeID NUMBER not null,
    country VARCHAR2(100) not null,
	enddate TIMESTAMP,
	CONSTRAINT fk_artist_typeid FOREIGN KEY (typeID) REFERENCES Type(typeID)
);

CREATE TABLE FNAMES (
    FID NUMBER PRIMARY KEY,
    FIRSTNAME VARCHAR2(100) not null
);

CREATE TABLE LNAMES (
    LID NUMBER PRIMARY KEY,
    LASTNAME VARCHAR2(100) not null
);

CREATE TABLE ARTIST_FNAME (
    ID primary key,
    AID NUMBER, 
    FID NUMBER,  
    STARTTIME TIMESTAMP WITH TIME ZONE, 
    ENDTIME TIMESTAMP WITH TIME ZONE,
    CONSTRAINT fk_artist_fname_pid FOREIGN KEY (AID) REFERENCES ARTIST(ARTISTID),
    CONSTRAINT fk_artist_fname_fid FOREIGN KEY (FID) REFERENCES FNAMES(FID) ON DELETE SET NULL
);

CREATE TABLE ARTIST_LNAME (
    ID primary key,
    AID NUMBER,
    LID NUMBER,
    STARTTIME TIMESTAMP WITH TIME ZONE, 
    ENDTIME TIMESTAMP WITH TIME ZONE,
    CONSTRAINT fk_artist_lname_pid FOREIGN KEY (AID) REFERENCES ARTIST(ARTISTID),
    CONSTRAINT fk_artist_lname_lid FOREIGN KEY (LID) REFERENCES LNAMES(LID) ON DELETE SET NULL
);

--create views on all tables related to airst
CREATE OR REPLACE VIEW V_ARTIST_NAME AS
SELECT
    artistID,
    FIRSTNAME,
    LASTNAME
FROM ARTIST
LEFT JOIN ARTIST_FNAME
ON ARTIST.artistID = ARTIST_FNAME.AID
LEFT JOIN FNAMES
ON ARTIST_FNAME.FID = FNAMES.FID
LEFT JOIN ARTIST_LNAME
ON ARTIST.artistID = ARTIST_LNAME.AID
LEFT JOIN LNAMES
ON ARTIST_LNAME.LID = LNAMES.LID
WHERE
	(ARTIST_FNAME.ENDTIME is NULL)
			AND
	(ARTIST_LNAME.ENDTIME is NULL)
      and
   (ARTIST_FNAME.fid is not null)
      and
    (ARTIST_LNAME.lid is not null);


create or replace view v_artist 
as
select a.typeid, a.country, b.firstname, b.lastname
    from artist a, V_ARTIST_NAME b
    where a.artistid = b.artistID;

	
create or replace view v_artist_updatedelete 
as
select a."ARTISTID",a."TYPEID",a."COUNTRY", b.firstname, b.lastname
    from artist a, V_ARTIST_NAME b
    where a.artistid = b.artistID;

	

-- Creating VinylAlbum table
CREATE TABLE VinylAlbum (
    vinylalbumID NUMBER PRIMARY KEY,
    artistID NUMBER not null,
    title VARCHAR2(255) not null,
    genreID NUMBER not null, 
    releaseYear number,
    condition VARCHAR2(100),
    purchaseDate DATE,
    purchasePrice NUMBER,
    cover BLOB, -- Assuming cover will be stored as an image BLOB
    FOREIGN KEY (artistID) REFERENCES Artist(artistID),
    FOREIGN KEY (genreID) REFERENCES Genre(genreID)
);

-- Creating TrackList table
CREATE TABLE TrackList (
    tracklistID NUMBER PRIMARY KEY,
    vinylalbumID NUMBER not null, 
    songName VARCHAR2(255) not null,
    FOREIGN KEY (vinylalbumID) REFERENCES VinylAlbum(vinylalbumID)
);

-- End of File