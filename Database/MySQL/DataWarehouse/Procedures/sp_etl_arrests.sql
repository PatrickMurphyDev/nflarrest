-- Active: 1701775194203@@127.0.0.1@3306@nflarrest
	--CREATE TEMPORARY TABLE StageData
	
/*
	CREATE TEMPORARY
	TABLE StageDataFailed
	SELECT *
	FROM StageData
	WHERE (day_key IS NULL)
	    OR (dim_player_position_id IS NULL)
	    OR (dim_team_id IS NULL)
        OR (dim_crime_id IS NULL);*/

DELIMITER //
DROP PROCEDURE if EXISTS sp_etl_arrests;

CREATE PROCEDURE `SP_ETL_ARRESTS`()
 BEGIN
	INSERT INTO
	    fct_arrests (
	        dim_date_id,
	        dim_team_id,
	        dim_player_position_id,
	        dim_crime_id,
	        `Name`,
	        `Description`,
	        `Encounter_raw`,
	        `Crime_raw`,
	        `Outcome_raw`
	    )
        SELECT
	    dd.day_key,
	    dt.dim_team_id,
	    dpp.dim_player_position_id,
	    if(dc.dim_crime_id is null, 27, dc.dim_crime_id) as dim_crime_id,
	    stg.`Name`,
	    stg.`Description`,
	    stg.`Encounter`,
	    stg.`Category`,
	    stg.`Outcome`
	FROM stg_arrests as stg
	    LEFT JOIN dim_day as dd ON dd.`date` = stg.`Date`
	    LEFT JOIN dim_player_position as dpp ON dpp.position_code = stg.`Position`
	    LEFT JOIN dim_team as dt ON dt.team_code = stg.`Team`
	    LEFT JOIN xw_category_to_crime as xwc ON xwc.`Category` = stg.`Category` AND xwc.record_count = (SELECT MAX(xwc2.record_count) FROM xw_category_to_crime as xwc2 WHERE xwc2.`Category` = stg.`Category`)
	    LEFT JOIN dim_crime as dc ON xwc.dim_crime_id = dc.dim_crime_id
    WHERE (dd.day_key IS NOT NULL)
	    AND (dpp.dim_player_position_id IS NOT NULL)
	    AND (dt.dim_team_id IS NOT NULL);

	TRUNCATE TABLE stg_arrests;

	END

DELIMITER ;