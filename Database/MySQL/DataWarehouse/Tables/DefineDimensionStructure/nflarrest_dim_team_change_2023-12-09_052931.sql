/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
DROP TABLE IF EXISTS dim_team_change;
CREATE TABLE `dim_team_change` (
  `dim_team_change_id` int NOT NULL AUTO_INCREMENT,
  `dim_team_id_old` int NOT NULL,
  `dim_team_id_new` int NOT NULL,
  `change_description` varchar(255) DEFAULT NULL,
  `change_date` date DEFAULT NULL,
  PRIMARY KEY (`dim_team_change_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='dimension to track team changes to map a team to its current info';