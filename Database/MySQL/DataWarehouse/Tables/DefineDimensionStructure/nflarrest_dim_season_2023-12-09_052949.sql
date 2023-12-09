/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
DROP TABLE IF EXISTS dim_season;
CREATE TABLE `dim_season` (
  `season` year NOT NULL,
  `season_start` date NOT NULL,
  `season_end` date NOT NULL,
  `playoff_start` date NOT NULL,
  `superbowl_date` date NOT NULL,
  UNIQUE KEY `season` (`season`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='NFL Season Dimension';