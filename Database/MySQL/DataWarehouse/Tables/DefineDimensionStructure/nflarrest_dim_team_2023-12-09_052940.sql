/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
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