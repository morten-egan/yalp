create or replace package yalp_maintenance

as

    procedure application_clear_scheduled;

    procedure clear_user_log (
        days_to_clear           in          number          default 0
    );

end yalp_maintenance;
/