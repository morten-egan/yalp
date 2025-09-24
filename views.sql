create or replace force view base_view as
select * from table(yalp_piped_tables.stream_entries(1));

create or replace force view base_view_10 as
select * from table(yalp_piped_tables.stream_entries(1))
where rownum < 11;

create or replace force view base_view_100 as
select * from table(yalp_piped_tables.stream_entries(1))
where rownum < 101;