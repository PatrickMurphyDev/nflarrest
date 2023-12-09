/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
DROP TABLE IF EXISTS dim_arrest_detail_type;
CREATE TABLE `dim_arrest_detail_type` (
  `dim_arrest_detail_type_id` int NOT NULL AUTO_INCREMENT,
  `dim_arrest_detail_type_name` varchar(155) DEFAULT NULL,
  `dim_arrest_detail_type_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`dim_arrest_detail_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;