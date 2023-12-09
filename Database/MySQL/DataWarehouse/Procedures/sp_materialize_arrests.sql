-- Active: 1701775194203@@127.0.0.1@3306@nflarrest
DROP PROCEDURE sp_materialize_arrests;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_materialize_arrests`()
BEGIN
    TRUNCATE TABLE mat_arrests;
    INSERT Into mat_arrests(
        fct_arrest_id,
     date ,
     team_code,
     team_full_name,
     team_preffered_name,
     team_city,
     team_logo_id,
     team_conference,
     team_division,
     `team_Conference_Division`,
     team_hex_color,
     team_hex_alt_color,
     player_name,
     position,
     position_name,
     position_type,
     `Encounter`,
     `Category`,
     `Crime_category`,
     `Crime_category_color`,
     `Description`,
     `Outcome`,
     Season,
     `ArrestSeasonState`,
     general_category_id,
     legal_level_id,
     resolution_category_id,
     year,
     `Month`,
     `Day`,
     `Day_of_Week`,
     `Day_of_Week_int`,
     `YearToDate`,
     `DaysSince`,
     `DaysToLastArrest`,
     `DaysToLastCrimeArrest`,
     `DaysToLastTeamArrest`
    )
    select
    fa.fct_arrests_id as fct_arrest_id,
    dd.date,
    dt.team_code,
    dt.team_full_name,
    dt.team_preffered_name,
    dt.team_city,
    dt.team_logo_id,
    dt.team_conference,
    dt.team_division,
    dt.team_conference as `team_Conference_Division`,
    dt.team_hex_color,
    dt.team_hex_alt_color,
    fa.Name as player_name,
    dpp.position_code as position,
    dpp.position_title as position_name,
    dpp.position_type,
    fa.Encounter_raw as `Encounter`,
    fa.`Crime_raw` as `Category`,
    dc.crime_name as `Crime_category`,
    dc.crime_hex_color as `Crime_category_color`,
    fa.`Description`,
    fa.`Outcome_raw` as `Outcome`,
    dd.`Season`,
    dd.`SeasonState` as `ArrestSeasonState`,
    dc.dim_crime_id as general_category_id,
    0 as legal_level_id,
    0 as resolution_category_id,
    dd.year_num as `Year`,
    dd.month_num as `Month`,
    dd.day_num as `Day`,
    dd.day_of_week_name as `Day_of_Week`,
    dd.day_of_week as `Day_of_Week_int`,
    0 as `YearToDate`, -- year to date should not be MATERIALIZED
    0 as `DaysSince`, -- daysSince should not be MATERIALIZED
    0 as `DaysToLastArrest`, -- should not be MATERIALIZED
    0 as `DaysToLastCrimeArrest`, -- should not be MATERIALIZED
    0 as `DaysToLastTeamArrest` -- should not be MATERIALIZED
FROM fct_arrests as fa 
    INNER JOIN dim_day as dd ON dd.day_key = fa.dim_date_id
    INNER JOIN dim_team as dt ON dt.dim_team_id = fa.dim_team_id
    INNER JOIN dim_player_position as dpp ON dpp.dim_player_position_id = fa.dim_player_position_id
    INNER JOIN dim_crime as dc ON dc.dim_crime_id = fa.dim_crime_id;
-- commit;
-- increase the value of the @date variable by 1 day
commit;
END