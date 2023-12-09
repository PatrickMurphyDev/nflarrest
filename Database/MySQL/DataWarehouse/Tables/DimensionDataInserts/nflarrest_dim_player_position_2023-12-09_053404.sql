/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
DROP TABLE IF EXISTS dim_player_position;
CREATE TABLE `dim_player_position` (
  `dim_player_position_id` int NOT NULL AUTO_INCREMENT,
  `position_code` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `position_title` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `position_type` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT 'O = offense, D = Defense, S = special teams',
  PRIMARY KEY (`dim_player_position_id`),
  UNIQUE KEY `position_tag` (`position_code`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='Player Position Dimension';
INSERT INTO dim_player_position(dim_player_position_id,position_code,position_title,position_type) VALUES('1','\'CE\'','\'Center\'','\'O\''),('2','\'G\'','\'Guard\'','\'O\''),('3','\'OT\'','\'Offensive Tackle\'','\'O\''),('4','\'TE\'','\'Tight End\'','\'O\''),('5','\'WR\'','\'Wide Receiver\'','\'O\''),('6','\'FB\'','\'Fullback\'','\'O\''),('7','\'RB\'','\'Running Back\'','\'O\''),('8','\'TB\'','\'Tailback\'','\'O\''),('9','\'WB\'','\'Wingback\'','\'O\''),('10','\'SB\'','\'Slotback\'','\'O\''),('11','\'QB\'','\'Quarterback\'','\'O\''),('12','\'DE\'','\'Defensive End\'','\'D\''),('13','\'DT\'','\'Defensive Tackle\'','\'D\''),('14','\'LB\'','\'Linebacker\'','\'D\''),('15','\'CB\'','\'Cornerback\'','\'D\''),('16','\'SS\'','\'Strong Safety\'','\'D\''),('17','\'FS\'','\'Free Safety\'','\'D\''),('18','\'K\'','\'Kicker\'','\'S\''),('19','\'KR\'','\'Kick Returner\'','\'S\''),('20','\'P\'','\'Punter\'','\'S\''),('21','\'GN\'','\'Gunner\'','\'S\''),('22','\'WD\'','\'Wedge Buster\'','\'S\''),('23','\'PR\'','\'Punt Returner\'','\'S\''),('24','\'S\'','\'Safety\'','\'D\''),('25','\'DL\'','\'Defensive Lineman\'','\'D\''),('26','\'C\'','\'Center\'','\'O\''),('27','\'DB\'','\'Defensive Back\'','\'D\''),('28','\'OL\'','\'Offensive Lineman\'','\'O\''),('29','\'DE/DT\'','\'Defensive End / Tackle\'','\'D\''),('30','\'OG\'','\'Offensive Guard\'','\'O\'');