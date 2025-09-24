create or replace package body yalp_piped_tables

as

    function stream_entries (
        filter_user         number      default 1
    )
    return log_entries
    pipelined

    as

        l_return_entry      log_entry;
        l_stream_cursor     sys_refcursor;
        l_stream_stmt       varchar2(4000);

        l_time              timestamp;
        l_app               varchar2(50);
        l_lvl               varchar2(25);
        l_msg               varchar2(4000);

    begin

        if filter_user = 1 then 
            l_stream_stmt := 'select
                    l.log_time
                    , la.application_name
                    , ll.level_name
                    , l.message
                from
                    logger_log l
                    inner join logger_applications la on la.application_id = l.log_application
                    inner join logger_levels ll on ll.level_id = l.log_level
                where
                    la.application_user = :user_in
                order by
                    l.log_time desc';
            open l_stream_cursor for l_stream_stmt using USER;
        else
            l_stream_stmt := 'select
                    l.log_time
                    , la.application_name
                    , ll.level_name
                    , l.message
                from
                    logger_log l
                    inner join logger_applications la on la.application_id = l.log_application
                    inner join logger_levels ll on ll.level_id = l.log_level
                order by
                    l.log_time desc';
            open l_stream_cursor for l_stream_stmt;
        end if;

        loop
            fetch l_stream_cursor
            into l_return_entry.log_time, l_return_entry.log_application, l_return_entry.log_level, l_return_entry.message;
            exit when l_stream_cursor%NOTFOUND;
            pipe row(l_return_entry);
            l_return_entry := null;
        end loop;

        close l_stream_cursor;

        return;

    end stream_entries;

end yalp_piped_tables;
/