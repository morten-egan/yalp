-- Logging levels
insert into logger_levels (
    level_id
    , level_name
    , level_desc
) values (
    -1
    , 'OFF'
    , 'No logging'
);

insert into logger_levels (
    level_id
    , level_name
    , level_desc
) values (
    1
    , 'INFO' 
    , 'Default logging'
);

insert into logger_levels (
    level_id
    , level_name
    , level_desc
) values (
    2
    , 'WARN' 
    , 'Default logging'
);

insert into logger_levels (
    level_id
    , level_name
    , level_desc
) values (
    3
    , 'ERROR' 
    , 'Default logging'
);

insert into logger_levels (
    level_id
    , level_name
    , level_desc
) values (
    4
    , 'FATAL' 
    , 'Default logging'
);

insert into logger_levels (
    level_id
    , level_name
    , level_desc
) values (
    5
    , 'DEBUG' 
    , 'Default logging'
);

insert into logger_levels (
    level_id
    , level_name
    , level_desc
) values (
    6
    , 'TRACE' 
    , 'Default logging'
);

insert into logger_levels (
    level_id
    , level_name
    , level_desc
) values (
    999
    , 'ALL' 
    , 'Default logging'
);

-- Bootstrap applications.
insert into logger_applications (
    application_id
    , application_name
    , application_user
) values (
    0
    , 'No application set'
    , 'Any user'
);

-- Bootstrap settings
insert into logger_settings (
    setting_id
    , application_id
    , log_level
    , clear_interval
) values (
    0
    , 0
    , 1
    , 1
);

commit;