/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
DROP TABLE IF EXISTS build_environment;
CREATE TABLE `build_environment` (
  `build_environment_id` int NOT NULL AUTO_INCREMENT,
  `build_environment_name` varchar(45) DEFAULT NULL,
  `build_environment_description` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`build_environment_id`),
  UNIQUE KEY `build_environment_id_UNIQUE` (`build_environment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS build_release;
CREATE TABLE `build_release` (
  `build_release_id` int NOT NULL AUTO_INCREMENT,
  `build_environment_id` int NOT NULL,
  `build_release_type_id` int NOT NULL,
  `build_release_version` varchar(45) DEFAULT NULL,
  `build_release_description` varchar(254) DEFAULT 'No Description Supplied',
  `build_release_date` datetime DEFAULT NULL,
  PRIMARY KEY (`build_release_id`),
  UNIQUE KEY `build_release_id_UNIQUE` (`build_release_id`)
) ENGINE=InnoDB AUTO_INCREMENT=372 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS build_release_detail;
CREATE TABLE `build_release_detail` (
  `build_release_detail_id` int NOT NULL AUTO_INCREMENT,
  `build_release_id` int NOT NULL,
  `build_release_detail_type_id` int NOT NULL,
  `build_release_detail_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`build_release_detail_id`),
  UNIQUE KEY `build_release_detail_id_UNIQUE` (`build_release_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2622 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS build_release_detail_type;
CREATE TABLE `build_release_detail_type` (
  `build_release_detail_type_id` int NOT NULL AUTO_INCREMENT,
  `build_release_detail_type_name` varchar(45) DEFAULT NULL,
  `build_release_detail_type_descriptionl` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`build_release_detail_type_id`),
  UNIQUE KEY `build_release_detail_type_id_UNIQUE` (`build_release_detail_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS build_release_type;
CREATE TABLE `build_release_type` (
  `build_release_type_id` int NOT NULL AUTO_INCREMENT,
  `build_release_type_name` varchar(45) DEFAULT NULL,
  `build_release_type_description` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`build_release_type_id`),
  UNIQUE KEY `build_release_type_id_UNIQUE` (`build_release_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS dim_arrest_detail_type;
CREATE TABLE `dim_arrest_detail_type` (
  `dim_arrest_detail_type_id` int NOT NULL AUTO_INCREMENT,
  `dim_arrest_detail_type_name` varchar(155) DEFAULT NULL,
  `dim_arrest_detail_type_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`dim_arrest_detail_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS dim_crime;
CREATE TABLE `dim_crime` (
  `dim_crime_id` int NOT NULL AUTO_INCREMENT,
  `crime_name` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `crime_hex_color` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '000000',
  PRIMARY KEY (`dim_crime_id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Crime Dimension';

DROP TABLE IF EXISTS dim_day;
CREATE TABLE `dim_day` (
  `day_key` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `date_num` int DEFAULT NULL,
  `day_num` int DEFAULT NULL,
  `day_of_year` int DEFAULT NULL,
  `day_of_week` int DEFAULT NULL,
  `day_of_week_name` varchar(20) DEFAULT NULL,
  `week_num` int DEFAULT NULL,
  `week_begin_date` datetime DEFAULT NULL,
  `week_end_date` datetime DEFAULT NULL,
  `last_week_begin_date` datetime DEFAULT NULL,
  `last_week_end_date` datetime DEFAULT NULL,
  `last_2_week_begin_date` datetime DEFAULT NULL,
  `last_2_week_end_date` datetime DEFAULT NULL,
  `month_num` int DEFAULT NULL,
  `month_name` varchar(20) DEFAULT NULL,
  `YEARMONTH_NUM` int DEFAULT NULL,
  `last_month_num` int DEFAULT NULL,
  `last_month_name` varchar(20) DEFAULT NULL,
  `last_month_year` int DEFAULT NULL,
  `last_yearmonth_num` int DEFAULT NULL,
  `quarter_num` int DEFAULT NULL,
  `year_num` int DEFAULT NULL,
  `created_date` timestamp NOT NULL,
  `updated_date` timestamp NOT NULL,
  `season` year DEFAULT NULL COMMENT 'The season that this record is associated with',
  `SeasonState` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`day_key`)
) ENGINE=InnoDB AUTO_INCREMENT=9108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Date / Day Dimension';

DROP TABLE IF EXISTS dim_player_position;
CREATE TABLE `dim_player_position` (
  `dim_player_position_id` int NOT NULL AUTO_INCREMENT,
  `position_code` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `position_title` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `position_type` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT 'O = offense, D = Defense, S = special teams',
  PRIMARY KEY (`dim_player_position_id`),
  UNIQUE KEY `position_tag` (`position_code`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Player Position Dimension';

DROP TABLE IF EXISTS dim_season;
CREATE TABLE `dim_season` (
  `season` year NOT NULL,
  `season_start` date NOT NULL,
  `season_end` date NOT NULL,
  `playoff_start` date NOT NULL,
  `superbowl_date` date NOT NULL,
  UNIQUE KEY `season` (`season`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='NFL Season Dimension';

DROP TABLE IF EXISTS dim_team;
CREATE TABLE `dim_team` (
  `dim_team_id` int NOT NULL AUTO_INCREMENT,
  `team_code` varchar(11) DEFAULT NULL,
  `team_full_name` varchar(25) DEFAULT NULL,
  `team_preffered_name` varchar(55) DEFAULT NULL,
  `team_city` varchar(35) DEFAULT NULL,
  `team_state` varchar(25) DEFAULT NULL,
  `team_division` varchar(11) DEFAULT NULL,
  `team_logo_id` int DEFAULT NULL,
  `team_conference` varchar(3) DEFAULT NULL,
  `team_stadium` varchar(35) DEFAULT NULL,
  `team_hex_color` varchar(6) DEFAULT NULL,
  `team_hex_alt_color` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`dim_team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Team Dimension';

DROP TABLE IF EXISTS dim_team_change;
CREATE TABLE `dim_team_change` (
  `dim_team_change_id` int NOT NULL AUTO_INCREMENT,
  `dim_team_id_old` int NOT NULL,
  `dim_team_id_new` int NOT NULL,
  `change_description` varchar(255) DEFAULT NULL,
  `change_date` date DEFAULT NULL,
  PRIMARY KEY (`dim_team_change_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='dimension to track team changes to map a team to its current info';

DROP TABLE IF EXISTS fct_arrest_detail;
CREATE TABLE `fct_arrest_detail` (
  `fct_arrest_detail_id` int NOT NULL AUTO_INCREMENT,
  `fct_arrest_id` int DEFAULT NULL,
  `fct_arrest_detail_type_id` int DEFAULT NULL,
  `fct_arrest_detail_value` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`fct_arrest_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS fct_arrests;
CREATE TABLE `fct_arrests` (
  `fct_arrests_id` int NOT NULL AUTO_INCREMENT,
  `dim_date_id` int DEFAULT NULL,
  `dim_team_id` int DEFAULT NULL,
  `dim_player_position_id` int DEFAULT NULL,
  `dim_crime_id` int DEFAULT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Encounter_raw` varchar(45) DEFAULT NULL,
  `Crime_raw` varchar(255) DEFAULT NULL,
  `Outcome_raw` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fct_arrests_id`)
) ENGINE=InnoDB AUTO_INCREMENT=985 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Arrests Fact Table';

DROP TABLE IF EXISTS mat_arrests;
CREATE TABLE `mat_arrests` (
  `fct_arrest_id` int NOT NULL DEFAULT '0',
  `date` date DEFAULT NULL,
  `team_code` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `team_full_name` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `team_preffered_name` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `team_city` varchar(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `team_logo_id` int NOT NULL,
  `team_conference` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `team_division` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `team_Conference_Division` varchar(9) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT 'A computed column of confrence + division strings',
  `team_hex_color` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT 'The hex value that represents the team main color, without the preceding # hash symbol',
  `team_hex_alt_color` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT 'The hex value that represents the team second color, without the preceding # hash symbol',
  `player_name` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `position` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `position_name` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `position_type` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT 'O = offense, D = Defense, S = special teams',
  `Encounter` varchar(12) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Category` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Crime_category` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Crime_category_color` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `Description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Outcome` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Season` year NOT NULL DEFAULT '0000',
  `ArrestSeasonState` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `general_category_id` int NOT NULL,
  `legal_level_id` int NOT NULL,
  `resolution_category_id` int NOT NULL,
  `Year` int DEFAULT NULL,
  `Month` int DEFAULT NULL,
  `Day` int DEFAULT NULL,
  `Day_of_Week` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Day_of_Week_int` int DEFAULT NULL,
  `YearToDate` int DEFAULT NULL,
  `DaysSince` bigint DEFAULT NULL,
  `DaysToLastArrest` bigint DEFAULT NULL,
  `DaysToLastCrimeArrest` bigint DEFAULT NULL,
  `DaysToLastTeamArrest` bigint DEFAULT NULL,
  PRIMARY KEY (`fct_arrest_id`),
  KEY `date_index` (`date`),
  KEY `team_index` (`team_code`),
  KEY `player_index` (`player_name`),
  KEY `crime_index` (`Category`),
  KEY `crime_category_index` (`Crime_category`),
  KEY `position_index` (`position`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

DROP TABLE IF EXISTS stg_arrests;
CREATE TABLE `stg_arrests` (
  `stg_arrests_id` int NOT NULL AUTO_INCREMENT,
  `Date` varchar(45) DEFAULT NULL,
  `Team` varchar(11) DEFAULT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `Position` varchar(5) DEFAULT NULL,
  `Encounter` varchar(12) DEFAULT NULL,
  `Category` varchar(25) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Outcome` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`stg_arrests_id`),
  UNIQUE KEY `reqGrainStg` (`Date`,`Team`,`Name`,`Description`,`Category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Staging Table for NFL Arrests';

DROP TABLE IF EXISTS xw_category_to_crime;
CREATE TABLE `xw_category_to_crime` (
  `xw_crime_id` int NOT NULL AUTO_INCREMENT,
  `Category` varchar(25) NOT NULL,
  `dim_crime_id` int NOT NULL,
  `record_count` int NOT NULL,
  PRIMARY KEY (`xw_crime_id`),
  UNIQUE KEY `index2` (`Category`,`dim_crime_id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='cross walk for category to crime id';

CREATE OR REPLACE VIEW `vwarrestsweb` AS select `mat_arrests`.`fct_arrest_id` AS `arrest_stats_id`,`mat_arrests`.`date` AS `Date`,`mat_arrests`.`team_code` AS `Team`,`mat_arrests`.`team_full_name` AS `Team_name`,`mat_arrests`.`team_preffered_name` AS `Team_preffered_name`,`mat_arrests`.`team_city` AS `Team_city`,`mat_arrests`.`team_logo_id` AS `Team_logo_id`,`mat_arrests`.`team_conference` AS `Team_Conference`,`mat_arrests`.`team_division` AS `Team_Division`,`mat_arrests`.`team_Conference_Division` AS `Team_Conference_Division`,`mat_arrests`.`team_hex_color` AS `Team_hex_color`,`mat_arrests`.`team_hex_alt_color` AS `Team_hex_alt_color`,`mat_arrests`.`player_name` AS `Name`,`mat_arrests`.`position` AS `Position`,`mat_arrests`.`position_name` AS `Position_name`,`mat_arrests`.`position_type` AS `Position_type`,`mat_arrests`.`Encounter` AS `Encounter`,`mat_arrests`.`Category` AS `Category`,`mat_arrests`.`Crime_category` AS `Crime_category`,`mat_arrests`.`Crime_category_color` AS `Crime_category_color`,`mat_arrests`.`Description` AS `Description`,`mat_arrests`.`Outcome` AS `Outcome`,`mat_arrests`.`Season` AS `Season`,`mat_arrests`.`ArrestSeasonState` AS `ArrestSeasonState`,`mat_arrests`.`general_category_id` AS `general_category_id`,`mat_arrests`.`legal_level_id` AS `legal_level_id`,`mat_arrests`.`resolution_category_id` AS `resolution_category_id`,`mat_arrests`.`Year` AS `Year`,`mat_arrests`.`Month` AS `Month`,`mat_arrests`.`Day` AS `Day`,`mat_arrests`.`Day_of_Week` AS `Day_of_Week`,`mat_arrests`.`Day_of_Week_int` AS `Day_of_Week_int`,`mat_arrests`.`YearToDate` AS `YearToDate`,`mat_arrests`.`DaysSince` AS `DaysSince`,`mat_arrests`.`DaysToLastArrest` AS `DaysToLastArrest`,`mat_arrests`.`DaysToLastCrimeArrest` AS `DaysToLastCrimeArrest`,`mat_arrests`.`DaysToLastTeamArrest` AS `DaysToLastTeamArrest` from `mat_arrests`;

CREATE OR REPLACE VIEW `vwbuildreleases` AS select `br`.`build_release_id` AS `build_release_id`,`e`.`build_environment_id` AS `build_environment_id`,`e`.`build_environment_name` AS `build_environment_name`,`e`.`build_environment_description` AS `build_environment_description`,`rt`.`build_release_type_id` AS `build_release_type_id`,`rt`.`build_release_type_name` AS `build_release_type_name`,`rt`.`build_release_type_description` AS `build_release_type_description`,`br`.`build_release_version` AS `build_release_version`,`br`.`build_release_description` AS `build_release_description`,`br`.`build_release_date` AS `build_release_date`,(select max(`build_release_detail`.`build_release_detail_value`) AS `cnt` from `build_release_detail` where ((`build_release_detail`.`build_release_id` = `br`.`build_release_id`) and (`build_release_detail`.`build_release_detail_type_id` = 1))) AS `build_release_detail_filecount`,(select max(`build_release_detail`.`build_release_detail_value`) AS `cnt` from `build_release_detail` where ((`build_release_detail`.`build_release_id` = `br`.`build_release_id`) and (`build_release_detail`.`build_release_detail_type_id` = 3))) AS `build_release_detail_commithash`,(select max(`build_release_detail`.`build_release_detail_value`) AS `cnt` from `build_release_detail` where ((`build_release_detail`.`build_release_id` = `br`.`build_release_id`) and (`build_release_detail`.`build_release_detail_type_id` = 4))) AS `build_release_detail_ArrestCount`,(select group_concat(`build_release_detail`.`build_release_detail_value` separator ', ') from `build_release_detail` where ((`build_release_detail`.`build_release_id` = `br`.`build_release_id`) and (`build_release_detail`.`build_release_detail_type_id` = 2)) group by `build_release_detail`.`build_release_id`) AS `build_release_detail_commitfiles`,(select concat('[',group_concat(concat('\'',`build_release_detail`.`build_release_detail_value`,'\'') separator ', '),']') from `build_release_detail` where ((`build_release_detail`.`build_release_id` = `br`.`build_release_id`) and (`build_release_detail`.`build_release_detail_type_id` = 2)) group by `build_release_detail`.`build_release_id`) AS `build_release_detail_commitfiles_json` from ((`build_release` `br` join `build_environment` `e` on((`br`.`build_environment_id` = `e`.`build_environment_id`))) join `build_release_type` `rt` on((`rt`.`build_release_type_id` = `br`.`build_release_type_id`))) order by `br`.`build_release_id` desc;

CREATE OR REPLACE VIEW `vwcategorytocrimecrosswalk` AS select `xw_category_to_crime`.`xw_crime_id` AS `xw_crime_id`,`xw_category_to_crime`.`Category` AS `Category`,`xw_category_to_crime`.`dim_crime_id` AS `dim_crime_id`,`xw_category_to_crime`.`record_count` AS `record_count` from `xw_category_to_crime` order by `xw_category_to_crime`.`dim_crime_id`,`xw_category_to_crime`.`record_count` desc;DROP PROCEDURE IF EXISTS sp_day_dim;
CREATE PROCEDURE `sp_day_dim`(
        p_StartDate datetime,
	    p_EndDate datetime
    )
BEGIN
  Declare StartDate datetime;
  Declare EndDate datetime;
  Declare RunDate datetime;

  -- Set date variables

  Set StartDate = p_StartDate; -- update this value to reflect the earliest date that you will use.
  Set EndDate = p_EndDate; -- update this value to reflect the latest date that you will use.
  Set RunDate = StartDate;

  -- Loop through each date and insert into DimTime table

  WHILE RunDate <= EndDate DO

    INSERT Into dim_day(
     date ,
     date_num,
     day_num ,
     Day_of_Year,
     Day_of_Week,
     Day_of_week_name,
     Week_num,
     week_begin_date,
     week_end_date,
     last_week_begin_date,
     last_week_end_date,
     last_2_week_begin_date,
     last_2_week_end_date,
     Month_num ,
     Month_Name,
     yearmonth_num,
     last_month_num,
     last_month_name,
     last_month_year,
     last_yearmonth_num,
     Quarter_num ,
     Year_num  ,
     created_date, 
     updated_date,
     season,
     SeasonState
    )
    select 
    RunDate date
    ,CONCAT(year(RunDate), lpad(MONTH(RunDate),2,'0'),lpad(day(RunDate),2,'0')) date_num
    ,day(RunDate) day_num
    ,DAYOFYEAR(RunDate) day_of_year
    ,DAYOFWEEK(RunDate) day_of_week
    ,DAYNAME(RunDate) day_of_week_name
    ,WEEK(RunDate) week_num
    ,DATE_ADD(RunDate, INTERVAL(1-DAYOFWEEK(RunDate)) DAY) week_begin_date
    ,ADDTIME(DATE_ADD(RunDate, INTERVAL(7-DAYOFWEEK(RunDate)) DAY),'23:59:59') week_end_date
    ,DATE_ADD(RunDate, INTERVAL ((1-DAYOFWEEK(RunDate))-7) DAY) last_week_begin_date
    ,ADDTIME(DATE_ADD(RunDate, INTERVAL ((7-DAYOFWEEK(RunDate))-7) DAY),'23:59:59')last_week_end_date
    ,DATE_ADD(RunDate, INTERVAL ((1-DAYOFWEEK(RunDate))-14) DAY) last_2_week_begin_date
    ,ADDTIME(DATE_ADD(RunDate, INTERVAL ((7-DAYOFWEEK(RunDate))-7) DAY),'23:59:59')last_2_week_end_date
    ,MONTH(RunDate) month_num
    ,MONTHNAME(RunDate) month_name
    ,CONCAT(year(RunDate), lpad(MONTH(RunDate),2,'0')) YEARMONTH_NUM
    ,MONTH(date_add(RunDate,interval -1 month)) last_month_num
    ,MONTHNAME(date_add(RunDate,interval -1 month)) last_month_name
    ,year(date_add(RunDate,interval -1 month)) last_month_year
    ,CONCAT(year(date_add(RunDate,interval -1 month)),lpad(MONTH(date_add(RunDate,interval -1 month)),2,'0')) Last_YEARMONTH_NUM
    ,QUARTER(RunDate) quarter_num
    ,YEAR(RunDate) year_num
    ,now() created_date
    ,now() update_date
    ,s.season
    ,if(RunDate BETWEEN s.season_start AND s.season_end, 'In Season', 'Off Season')
    FROM dim_season as s
    where (RunDate BETWEEN s.season_start AND s.season_end)
        OR ((RunDate NOT BETWEEN s.season_start AND s.season_end) AND s.season = year(RunDate))
    LIMIT 1;
-- commit;
-- increase the value of the @date variable by 1 day

Set RunDate = ADDDATE(RunDate,1);

END WHILE;
commit;
END;