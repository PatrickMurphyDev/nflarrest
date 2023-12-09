-- Active: 1701775194203@@127.0.0.1@3306@nflarrest
DROP PROCEDURE sp_day_dim_update;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_day_dim_update`()
BEGIN
    Declare start_dt datetime;
    set start_dt = DATE_ADD((SELECT MAX(date) FROM dim_day), INTERVAL 1 DAY);
    CALL sp_day_dim(start_dt, NOW());
END