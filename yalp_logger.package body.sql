create or replace package body yalp_logger

as

    procedure set (
        p_log_application_name      logger_applications.application_name%type
    )

    as

    begin

        dbms_application_info.set_module (
            module_name             =>          p_log_application_name
            , action_name           =>          null
        );

    end set;

    procedure unset

    as

    begin

        dbms_application_info.set_module (
            module_name             =>          null
            , action_name           =>          null
        );

    end unset;

    procedure log (
        p_log_message               clob
        , p_log_level_name          logger_levels.level_name%type                       default         'INFO'
        , p_log_application         logger_applications.application_name%type           default         null
    )

    as

        l_log_level_id              logger_levels.level_id%type := 1;
        l_log_message               logger_log.message%type := p_log_message;
        l_log_application           logger_applications.application_name%type := p_log_application;

    begin

        select
            level_id
        into
            l_log_level_id
        from
            logger_levels
        where
            upper(level_name) = upper(p_log_level_name);

        yalp_logger.logid (
            p_log_message       =>      l_log_message
            , p_log_level       =>      l_log_level_id
            , p_log_application =>      l_log_application
        );

        exception
            when no_data_found then
                yalp_logger.logid (
                    p_log_message       =>      l_log_message
                    , p_log_level       =>      1
                    , p_log_application =>      l_log_application
                );

    end log;

    function application_id_from_name (
        p_log_application           logger_applications.application_name%type
    )
    return number

    as

        l_return                    logger_applications.application_id%type;
        l_app_name                  logger_applications.application_name%type;

    begin
      
        select
            application_id
            , application_name
        into
            l_return
            , l_app_name
        from
            logger_applications
        where
            upper(application_name) = upper(p_log_application)
        and
            application_user = user;

        return l_return;

        exception
            when NO_DATA_FOUND then
                -- Application has not been put in yet. Let's do it and return the ID automatically.
                insert into logger_applications (
                    application_id
                    , application_name
                    , application_user
                ) values (
                    yalp_app_seq.nextval
                    , p_log_application
                    , user
                )
                returning application_id
                into l_return;

                -- Inherit the default settings
                insert into logger_settings (
                    setting_id
                    , application_id
                    , log_level
                    , clear_interval
                )
                select
                    yalp_app_seq.nextval
                    , l_return
                    , log_level
                    , clear_interval
                from
                    logger_settings
                where
                    application_id = 0;
                
                return l_return;

    end application_id_from_name;

    procedure logid (
        p_log_message               clob
        , p_log_level               logger_levels.level_id%type                         default         1
        , p_log_application         logger_applications.application_name%type           default         null
    )
    
    as

        -- Set as autonomous to capture all.
        pragma                  autonomous_transaction;
        l_log_level             logger_levels.level_id%type := p_log_level;
        l_log_application       logger_applications.application_name%type := p_log_application;
        l_log_setting           logger_settings.setting_id%type := 0;
        l_log_message           logger_log.message%type := p_log_message;
        l_log_application_id    logger_applications.application_id%type := 0;

        l_grabbed_action    varchar2(64);
    
    begin

        -- First check if we have set a module and use that.
        if l_log_application is null then
            dbms_application_info.read_module(
                module_name         =>      l_log_application
                , action_name       =>      l_grabbed_action
            );
        end if;

        -- Get the application ID if we have set something, else keep at zero.
        if l_log_application is not null then
            l_log_application_id := application_id_from_name(l_log_application);
        end if;

        insert into logger_log (
            log_id
            , log_time
            , log_level
            , log_setting
            , log_application
            , message
        ) values (
            yalp_log_entry_seq.nextval
            , systimestamp
            , l_log_level
            , l_log_setting
            , l_log_application_id
            , l_log_message
        );

        commit;
      
    end logid;

end yalp_logger;
/