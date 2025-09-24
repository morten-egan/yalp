create user yalp identified by yalp
default tablespace users
temporary tablespace temp
quota unlimited on users;

grant create session, create table, create sequence, create procedure, create view, create public synonym to yalp;

grant create job to yalp;