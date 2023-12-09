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
INSERT INTO dim_arrest_detail_type(dim_arrest_detail_type_id,dim_arrest_detail_type_name,dim_arrest_detail_type_description) VALUES('1','\'News_Source\'','\'A Arrest Detail Object containing a link to a news story regarding this arrest\''),('2','\'Drug\'','\'A reference to the Drug Table, for known incidents with drug connection that is public.\''),('3','\'Incident_Location\'','\'City/Location where the incident took place.\'');