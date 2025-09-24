create or replace package body yalp_maintenance

as

    procedure application_clear_scheduled

    as

        -- TODO: HERE WE SHOULD LOOK AT EACH APPLICATION AND THEIR SETTING.
        -- TODO: FOR NOW WE JUST DELETE ALL.

    begin

        delete from logger_log
        where log_time < systimestamp - interval '1' day;

        commit;

    end application_clear_scheduled;

    procedure clear_user_log (
        days_to_clear           in          number          default 0
    )

    as

        l_log_application       logger_applications.application_name%type;
        l_log_user              logger_applications.application_user%type := user;
        l_grabbed_action        varchar2(64);

    begin

        dbms_application_info.read_module(
            module_name         =>      l_log_application
            , action_name       =>      l_grabbed_action
        );

        delete from logger_log
        where log_time < systimestamp - interval '0' day
        and log_application = (
            select
                application_id
            from
                logger_applications
            where
                application_name = l_log_application
            and
                application_user = l_log_user
        );

        commit;

    end clear_user_log;

end yalp_maintenance;
/