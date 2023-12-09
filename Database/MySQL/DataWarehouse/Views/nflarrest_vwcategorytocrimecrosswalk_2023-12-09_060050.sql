/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;


CREATE OR REPLACE VIEW `vwcategorytocrimecrosswalk` AS select `xw_category_to_crime`.`xw_crime_id` AS `xw_crime_id`,`xw_category_to_crime`.`Category` AS `Category`,`xw_category_to_crime`.`dim_crime_id` AS `dim_crime_id`,`xw_category_to_crime`.`record_count` AS `record_count` from `xw_category_to_crime` order by `xw_category_to_crime`.`dim_crime_id`,`xw_category_to_crime`.`record_count` desc;