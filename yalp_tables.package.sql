create or replace package yalp_piped_tables

as

    type log_entry is record (
        log_time            timestamp
        , log_application   varchar2(50)
        , log_level         varchar2(25)
        , message           varchar2(4000)
    );

    type log_entries is table of log_entry;

    function stream_entries (
        filter_user         number      default 1
    )
    return log_entries
    pipelined;

end yalp_piped_tables;
/