begin
    dbms_scheduler.create_job (
        job_name            =>      'YALP_SCHEDULED_CLEAR_GENERIC'
        , job_type          =>      'STORED_PROCEDURE'
        , job_action        =>      'YALP.YALP_MAINTENANCE.APPLICATION_CLEAR_SCHEDULED'
        , start_date        =>      systimestamp
        , repeat_interval   =>      'FREQ=DAILY;INTERVAL=1'
        , enabled           =>      true
    );
end;
/