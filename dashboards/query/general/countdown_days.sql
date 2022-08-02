-- number of days until the target decommission date for the paas platform
--- ${local.decommission_target_date}
select date '2023-12-22' - current_date as countdown