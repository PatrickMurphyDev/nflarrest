/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
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