-- Synonyms
drop public synonym yl;
drop public synonym ylog;
drop public synonym ylog10;
drop public synonym ylog100;
-- Jobs
begin
    dbms_scheduler.disable('YALP_SCHEDULED_CLEAR_GENERIC');
    dbms_scheduler.drop_job('YALP_SCHEDULED_CLEAR_GENERIC');
end;
/
-- Views
drop view base_view;
-- Packages
drop package yalp_piped_tables;
drop package yalp_maintenance;
drop package yalp_logger;
-- Sequences
drop sequence yalp_app_seq;
drop sequence yalp_log_entry_seq;
-- Tables
drop table logger_log cascade constraints purge;
drop table logger_settings cascade constraints purge;
drop table logger_applications cascade constraints purge;
drop table logger_levels cascade constraints purge;