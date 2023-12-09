/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
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