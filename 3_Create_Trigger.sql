--Created by: group6(S322)
--Assignment2, Apr 5 2024

CONNECT group6/group123;

--1. handle delete from backend
create or replace trigger trg_insert_name
  instead of insert
  on V_ARTIST_NAME 
  for each row
declare
  v_aid number;
  v_count number;
  v_fid number;
  v_lid number;
  v_fkey number;
  v_lkey number;
  v_firstname varchar2(100);
  v_lastname varchar2(100);
begin
  --check foreign CONSTRAINT
  select count(*) into v_count from artist where artistid = :NEW.artistID;
  if v_count = 0 then
    raise_application_error(-20001, 'This ID does not exist in table Artist!');
  end if;
  
  v_aid := :NEW.artistID;
  v_firstname := :NEW.FIRSTNAME;
  v_lastname := :NEW.LASTNAME;
  v_fid := seq_fnames_id.nextval;
  v_lid := seq_lnames_id.nextval;
  v_fkey := seq_artist_firstname_id.nextval;
  v_lkey := seq_artist_lastname_id.nextval;
  
  insert into FNAMES(fid, Firstname) values(v_fid, v_firstname);
  insert into LNAMES(LID, LASTNAME) values(v_lid, v_lastname);
  insert into artist_fname(id, aid, fid, starttime) values(v_fkey, v_aid, v_fid, SYSTIMESTAMP);
  insert into artist_lname(id, aid, lid, starttime) values(v_lkey, v_aid, v_lid, SYSTIMESTAMP);
  
end trg_insert_name;

--2. handle update from backend
create or replace trigger trg_update_name
  instead of update on V_ARTIST_NAME
  for each row
declare
  v_fid  number;
  v_lid  number;
  v_aid  number;
  v_fkey number;
  v_lkey number;
  new_fid number;
  new_lid number;

begin
  v_aid := :NEW.artistID;
  --delete from trigger_logs;
  --INSERT INTO trigger_logs(log_message) VALUES ('Trigger fired. New value: ' || v_aid);

  select distinct fid
    into v_fid
    from artist_fname
   where aid = v_aid
     and fid is not null
     and endtime is null;
     
  select distinct lid
    into v_lid
    from artist_lname
   where aid = v_aid
     and lid is not null
     and endtime is null;

  BEGIN
    if :NEW.FIRSTNAME != :OLD.FIRSTNAME then
	  
      --update FNAMES set Firstname = :NEW.FIRSTNAME where fid = v_fid;
	  new_fid := seq_fnames_id.nextval;
	  insert into FNAMES(fid, FIRSTNAME) values(new_fid, :NEW.FIRSTNAME);
      update artist_fname set endtime=SYSTIMESTAMP where aid=v_aid and fid=v_fid and endtime is null;
      
      v_fkey := seq_artist_firstname_id.nextval;
      insert into artist_fname
        (id, aid, fid, starttime)
      values
        (v_fkey, v_aid, new_fid, SYSTIMESTAMP);
    end if;
  
    if :NEW.LASTNAME != :OLD.LASTNAME then
      --update LNAMES set Lastname = :NEW.LASTNAME where lid = v_lid;
	  new_lid := seq_lnames_id.nextval;
	  insert into LNAMES(lid, LASTNAME) values(new_lid, :NEW.LASTNAME);
      update artist_lname set endtime=SYSTIMESTAMP where aid=v_aid and lid=v_lid and endtime is null;
      
      v_lkey := seq_artist_lastname_id.nextval;
      insert into artist_lname
        (id, aid, lid, starttime)
      values
        (v_lkey, v_aid, new_lid, SYSTIMESTAMP);
    end if;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
  END;

end trg_update_name;

--3. handle delete from backend
create or replace trigger trg_delete_name
  instead of delete
  on V_ARTIST_NAME 
  for each row
declare
  v_aid number;
  v_fid number;
  v_lid number;
begin
  v_aid := :OLD.artistID;

  BEGIN

    select distinct fid into v_fid from artist_fname where aid = v_aid and fid is not null and endtime is null;
    update artist_fname set endtime=SYSTIMESTAMP where  aid=v_aid and fid=v_fid and endtime is null;
    --delete from FNAMES where fid = v_fid;
    
  EXCEPTION WHEN NO_DATA_FOUND THEN
    NULL;
  END;
  
  BEGIN
    select distinct lid into v_lid from ARTIST_LNAME where aid = v_aid and lid is not null and endtime is null;
    update artist_lname set endtime=SYSTIMESTAMP where  aid=v_aid and lid=v_lid and endtime is null;
    --delete from LNAMES where lid =v_lid;
    
  EXCEPTION WHEN NO_DATA_FOUND THEN
    NULL;
  END;
  
end trg_delete_name;

--4. handle insert from frontend, will trigger backend trigger->trg_insert_name
create or replace trigger trg_v_artist_insert
  instead of insert
  on v_artist 
  for each row
declare
  v_aid number;
  v_typeid number;
  v_firstname varchar2(100);
  v_lastname varchar2(100);
  v_contry varchar2(100);

begin
  v_aid := seq_artist_id.nextval;
  v_typeid := :NEW.typeid;
  v_firstname := :NEW.firstname;
  v_lastname := :NEW.lastname;
  v_contry := :NEW.country;
  
  insert into artist(artistid, typeid, country) values(v_aid, v_typeid, v_contry);
  insert into V_ARTIST_NAME(artistid, FIRSTNAME, LASTNAME) values(v_aid, v_firstname, v_lastname);
  
end trg_v_artist_insert;


--5. handle update from frontend, will trigger backend trigger->trg_update_name
create or replace trigger trg_v_artist_update
  instead of update
  on V_ARTIST_UpdateDelete 
  for each row
declare
  v_aid number;
 
 begin
   v_aid := :NEW.ARTISTID;
   if :NEW.TYPEID != :OLD.TYPEID then
     update artist
     set typeid = :NEW.TYPEID
     where artistid = v_aid;
   end if;
     
   if :NEW.COUNTRY != :OLD.COUNTRY then
     update artist
     set country = :NEW.COUNTRY
     where artistid = v_aid;
   end if;
   
   if :NEW.firstname != :OLD.firstname then
     update v_artist_name
     set firstname = :NEW.firstname
     where artistid = v_aid;
   end if;
   
   if :NEW.lastname != :OLD.lastname then
     update v_artist_name
     set lastname =:NEW.lastname
     where artistid = v_aid;
   end if; 
   
end trg_v_artist_update;

--6. handle delete from frontend, will trigger backend trigger->trg_delete_name
create or replace trigger trg_v_artist_delete
  instead of delete
  on v_artist_updatedelete 
  for each row
declare
  v_aid number;
begin
  v_aid := :OLD.ARTISTID;
  delete from v_artist_name where artistid = v_aid;
  update artist 
  set enddate = sysdate 
  where artistid = v_aid;
end trg_v_artist_delete;


-- End of File