/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
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