--Created by: group6(S322)
--Assignment2, Apr 5 2024

CONNECT group6/group123;

-- inserting to TYPE
INSERT INTO Type(typeID, name) VALUES(seq_type_id.NEXTVAL, 'Independent');
INSERT INTO Type(typeID, name) VALUES(seq_type_id.NEXTVAL, 'Commercial');
INSERT INTO Type(typeID, name) VALUES(seq_type_id.NEXTVAL, 'Soundtrack');
INSERT INTO Type(typeID, name) VALUES(seq_type_id.NEXTVAL, 'Live');
INSERT INTO Type(typeID, name) VALUES(seq_type_id.NEXTVAL, 'Retro');

-- inserting to GENRE
INSERT INTO Genre(genreID, name) VALUES(seq_genre_id.NEXTVAL, 'Rock');
INSERT INTO Genre(genreID, name) VALUES(seq_genre_id.NEXTVAL, 'Pop');
INSERT INTO Genre(genreID, name) VALUES(seq_genre_id.NEXTVAL, 'Jazz');
INSERT INTO Genre(genreID, name) VALUES(seq_genre_id.NEXTVAL, 'EDM');
INSERT INTO Genre(genreID, name) VALUES(seq_genre_id.NEXTVAL, 'Classical');

-- inserting to ARTIST
INSERT INTO ARTIST(artistID, typeID, country) VALUES(seq_artist_id.NEXTVAL,1, 'USA');
INSERT INTO ARTIST(artistID, typeID, country) VALUES(seq_artist_id.NEXTVAL,2, 'CANADA');
INSERT INTO ARTIST(artistID, typeID, country) VALUES(seq_artist_id.NEXTVAL,3, 'CUBA');
INSERT INTO ARTIST(artistID, typeID, country) VALUES(seq_artist_id.NEXTVAL,4, 'Thiland');
INSERT INTO ARTIST(artistID, typeID, country) VALUES(seq_artist_id.NEXTVAL,5, 'Mexico');

-- inserting to FNAMES
INSERT INTO FNAMES(FID, FIRSTNAME) values(seq_fnames_id.NEXTVAL, 'Luke');
INSERT INTO FNAMES(FID, FIRSTNAME) values(seq_fnames_id.NEXTVAL, 'Zach');
INSERT INTO FNAMES(FID, FIRSTNAME) values(seq_fnames_id.NEXTVAL, 'Kacey');
INSERT INTO FNAMES(FID, FIRSTNAME) values(seq_fnames_id.NEXTVAL, 'Post');
INSERT INTO FNAMES(FID, FIRSTNAME) values(seq_fnames_id.NEXTVAL, 'Lil');

-- inserting to LNAMES
INSERT INTO LNAMES(LID, LASTNAME) values(seq_lnames_id.NEXTVAL, 'Combs');
INSERT INTO LNAMES(LID, LASTNAME) values(seq_lnames_id.NEXTVAL, 'Bryan');
INSERT INTO LNAMES(LID, LASTNAME) values(seq_lnames_id.NEXTVAL, 'Musgraves');
INSERT INTO LNAMES(LID, LASTNAME) values(seq_lnames_id.NEXTVAL, 'Malone');
INSERT INTO LNAMES(LID, LASTNAME) values(seq_lnames_id.NEXTVAL, 'Baby');

-- inserting to ARTIST_FNAME
insert into ARTIST_FNAME(ID, AID, FID, STARTTIME) values(seq_artist_firstname_id.NEXTVAL,1,1,SYSTIMESTAMP);
insert into ARTIST_FNAME(ID, AID, FID, STARTTIME) values(seq_artist_firstname_id.NEXTVAL,2,2,SYSTIMESTAMP);
insert into ARTIST_FNAME(ID, AID, FID, STARTTIME) values(seq_artist_firstname_id.NEXTVAL,3,3,SYSTIMESTAMP);
insert into ARTIST_FNAME(ID, AID, FID, STARTTIME) values(seq_artist_firstname_id.NEXTVAL,4,4,SYSTIMESTAMP);
insert into ARTIST_FNAME(ID, AID, FID, STARTTIME) values(seq_artist_firstname_id.NEXTVAL,5,5,SYSTIMESTAMP);

-- inserting to ARTIST_LNAME
insert into ARTIST_LNAME(ID, AID, LID, STARTTIME) values(seq_artist_lastname_id.NEXTVAL,1,1,SYSTIMESTAMP);
insert into ARTIST_LNAME(ID, AID, LID, STARTTIME) values(seq_artist_lastname_id.NEXTVAL,2,2,SYSTIMESTAMP);
insert into ARTIST_LNAME(ID, AID, LID, STARTTIME) values(seq_artist_lastname_id.NEXTVAL,3,3,SYSTIMESTAMP);
insert into ARTIST_LNAME(ID, AID, LID, STARTTIME) values(seq_artist_lastname_id.NEXTVAL,4,4,SYSTIMESTAMP);
insert into ARTIST_LNAME(ID, AID, LID, STARTTIME) values(seq_artist_lastname_id.NEXTVAL,5,5,SYSTIMESTAMP);

-- inserting to Vinylalbum
insert into VinylAlbum(vinylalbumID, artistID, title, genreID) values(seq_vinylalbum_id.NEXTVAL,1,'Fearless',1);

-- inserting to TrackList
insert into TrackList(tracklistID, vinylalbumID, songName) values(seq_tracklist_id.NEXTVAL,1,'Two of Us');
insert into TrackList(tracklistID, vinylalbumID, songName) values(seq_tracklist_id.NEXTVAL,1,'Dig a Pony');
insert into TrackList(tracklistID, vinylalbumID, songName) values(seq_tracklist_id.NEXTVAL,1,'Across the Universe');
insert into TrackList(tracklistID, vinylalbumID, songName) values(seq_tracklist_id.NEXTVAL,1,'I Me Mine');
insert into TrackList(tracklistID, vinylalbumID, songName) values(seq_tracklist_id.NEXTVAL,1,'Dig It');

-- End of File