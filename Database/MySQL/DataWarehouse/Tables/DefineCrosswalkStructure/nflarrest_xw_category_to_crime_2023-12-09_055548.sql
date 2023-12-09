/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
DROP TABLE IF EXISTS xw_category_to_crime;
CREATE TABLE `xw_category_to_crime` (
  `xw_crime_id` int NOT NULL AUTO_INCREMENT,
  `Category` varchar(25) NOT NULL,
  `dim_crime_id` int NOT NULL,
  `record_count` int NOT NULL,
  PRIMARY KEY (`xw_crime_id`),
  UNIQUE KEY `index2` (`Category`,`dim_crime_id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='cross walk for category to crime id';