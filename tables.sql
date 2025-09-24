create sequence yalp_app_seq
increment by 1
start with 1
cache 10;

create sequence yalp_log_entry_seq
increment by 1
start with 10
cache 100;

create table logger_levels (
    level_id            number                  constraint logger_levels_pk primary key
    , level_name        varchar2(20)            constraint logger_levels_name_nnu not null unique
    , level_desc        varchar2(150)
);

create table logger_applications (
    application_id      number                  constraint logger_application_pk primary key
    , application_name  varchar2(100)           constraint logger_application_name_nnu not null unique
    , application_user  varchar2(100)
);

create table logger_settings (
    setting_id          number                  constraint logger_setting_pk primary key
    , application_id    number                  constraint logger_setting_app_ref references logger_applications(application_id)
    , log_level         number                  constraint logger_setting_loglvl_ref references logger_levels(level_id)
    , clear_interval    number                  constraint logger_setting_clear_int_nn not null
);

create table logger_log (
    log_id              number                  constraint logger_log_pk primary key
    , log_time          timestamp               constraint logger_log_tim_nn not null
    , log_level         number                  constraint logger_log_level_ref references logger_levels(level_id)
    , log_setting       number                  constraint logger_log_setting_ref references logger_settings(setting_id)
    , log_application   number                  constraint logger_log_application_ref references logger_applications(application_id)
    , message           clob                    constraint logger_log_message_nn not null
);