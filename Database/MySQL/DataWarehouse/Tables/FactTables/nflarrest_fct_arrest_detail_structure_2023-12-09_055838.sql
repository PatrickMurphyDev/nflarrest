/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
DROP TABLE IF EXISTS fct_arrest_detail;
CREATE TABLE `fct_arrest_detail` (
  `fct_arrest_detail_id` int NOT NULL AUTO_INCREMENT,
  `fct_arrest_id` int DEFAULT NULL,
  `fct_arrest_detail_type_id` int DEFAULT NULL,
  `fct_arrest_detail_value` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`fct_arrest_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;