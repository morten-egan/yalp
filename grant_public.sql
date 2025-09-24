grant execute on yalp_logger to public;
grant select on base_view to public;
grant select on base_view_10 to public;
grant select on base_view_100 to public;
grant execute on yalp_maintenance to public;

create public synonym yl for yalp.yalp_logger;
create public synonym ylog for yalp.base_view;
create public synonym ylog10 for yalp.base_view_10;
create public synonym ylog100 for yalp.base_view_100;
create public synonym ylm for yalp.yalp_maintenance;