create or replace package yalp_logger

as

    procedure logid (
        p_log_message               clob
        , p_log_level               logger_levels.level_id%type                         default         1
        , p_log_application         logger_applications.application_name%type           default         null
    );

    procedure log (
        p_log_message               clob
        , p_log_level_name          logger_levels.level_name%type                       default         'INFO'
        , p_log_application         logger_applications.application_name%type           default         null
    );

    procedure set (
        p_log_application_name      logger_applications.application_name%type
    );

    procedure unset;

end yalp_logger;
/