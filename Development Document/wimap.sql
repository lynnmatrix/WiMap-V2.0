# SQL Manager 2007 Lite for MySQL 4.5.0.4
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : wimap


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES latin1 */;

SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE `wimap`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `wimap`;

#
# Structure for the `project` table : 
#

CREATE TABLE `project` (
  `name` varchar(20) NOT NULL,
  `state` int(1) unsigned zerofill NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

###############################################################
#                     地图数据                                #
###############################################################

#
# Structure for the `building` table : 
#

CREATE TABLE `building` (
  `building_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL DEFAULT '',
  PRIMARY KEY (`building_id`),
  UNIQUE KEY `building_id` (`building_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 4096 kB';

#
# Structure for the `floor` table : 
#

CREATE TABLE `floor` (
  `floor_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `floorNo` int(10) unsigned zerofill DEFAULT NULL,
  `floorHight` float unsigned zerofill DEFAULT NULL,
  `building_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`floor_id`),
  UNIQUE KEY `floor_id` (`floor_id`),
  KEY `building_id` (`building_id`),
  CONSTRAINT `floor_fk` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 4096 kB';

#
# Structure for the `map` table : 
#

CREATE TABLE `map` (
  `map_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `imagePath` varchar(256) DEFAULT NULL,
  `scale` float(9,3) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`map_id`),
  UNIQUE KEY `map_id` (`map_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 4096 kB';

#
# Structure for the `grid` table : 
#

CREATE TABLE `grid` (
  `grid_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `start_x` float(9,3) unsigned zerofill DEFAULT NULL,
  `start_y` float(9,3) unsigned zerofill DEFAULT NULL,
  `end_x` float(9,3) unsigned zerofill DEFAULT NULL,
  `end_y` float(9,3) unsigned zerofill DEFAULT NULL,
  `map_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`grid_id`),
  UNIQUE KEY `grid_id` (`grid_id`),
  KEY `map_id` (`map_id`),
  CONSTRAINT `grid_fk` FOREIGN KEY (`map_id`) REFERENCES `map` (`map_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 MAX_ROWS=100000;

#
# Structure for the `connection` table : 
#

CREATE TABLE `connection` (
  `first_grid` int(11) unsigned NOT NULL,
  `second_grid` int(11) unsigned NOT NULL,
  PRIMARY KEY (`first_grid`,`second_grid`),
  KEY `first_grid` (`first_grid`),
  KEY `second_grid` (`second_grid`),
  CONSTRAINT `connection_fk` FOREIGN KEY (`first_grid`) REFERENCES `grid` (`grid_id`),
  CONSTRAINT `connection_fk1` FOREIGN KEY (`second_grid`) REFERENCES `grid` (`grid_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `floor_map_associate` table : 
#

CREATE TABLE `floor_map_associate` (
  `floor_id` int(11) unsigned NOT NULL,
  `map_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`floor_id`,`map_id`),
  UNIQUE KEY `floor_id` (`floor_id`),
  UNIQUE KEY `map_id` (`map_id`),
  CONSTRAINT `floor_map_associate_fk` FOREIGN KEY (`floor_id`) REFERENCES `floor` (`floor_id`),
  CONSTRAINT `floor_map_associate_fk1` FOREIGN KEY (`map_id`) REFERENCES `map` (`map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 4096 kB';

#
# Structure for the `route` table : 
#

CREATE TABLE `route` (
  `start_grid` int(11) unsigned NOT NULL,
  `end_grid` int(11) unsigned NOT NULL,
  `route_no` int(11) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`route_no`),
  UNIQUE KEY `route_no` (`route_no`),
  KEY `end_grid` (`end_grid`),
  KEY `start_grid` (`start_grid`),
  CONSTRAINT `route_fk` FOREIGN KEY (`start_grid`) REFERENCES `grid` (`grid_id`),
  CONSTRAINT `route_fk1` FOREIGN KEY (`end_grid`) REFERENCES `grid` (`grid_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `route_data` table : 
#

CREATE TABLE `route_data` (
  `route_no` int(11) unsigned NOT NULL,
  `grid` int(11) unsigned NOT NULL,
  PRIMARY KEY (`route_no`,`grid`),
  KEY `route_no` (`route_no`),
  KEY `grid` (`grid`),
  CONSTRAINT `route_data_fk` FOREIGN KEY (`route_no`) REFERENCES `route` (`route_no`),
  CONSTRAINT `route_data_fk1` FOREIGN KEY (`grid`) REFERENCES `grid` (`grid_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `selectedflag` table : 
#

CREATE TABLE `selectedflag` (
  `id` int(1) NOT NULL,
  `flag` varchar(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `flag` (`flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `ap` table : 
#

CREATE TABLE `ap` (
  `mac` varchar(32) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `x` float(9,3) DEFAULT NULL,
  `y` float(9,3) DEFAULT NULL,
  `floorNo` int(3) DEFAULT NULL,
  `selected` int(1) NOT NULL DEFAULT '0',
  `buildingName` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`mac`),
  UNIQUE KEY `mac` (`mac`),
  KEY `selected` (`selected`),
  CONSTRAINT `ap_ibfk_1` FOREIGN KEY (`selected`) REFERENCES `selectedflag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192 COMMENT='InnoDB free: 3072 kB';


###############################################################
#                     训练数据                                #
###############################################################

#
# Structure for the `measure_time_train` table : 
#

CREATE TABLE `measure_time_train` (
  `measure_no` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `time` varchar(25) DEFAULT '0000-00-00 00:00:00.000',
  PRIMARY KEY (`measure_no`),
  UNIQUE KEY `measure_no` (`measure_no`)
) ENGINE=InnoDB AUTO_INCREMENT=968 DEFAULT CHARSET=utf8;

#
# Structure for the `measure_train` table : 
#

CREATE TABLE `measure_train` (
  `measure_no` int(11) unsigned NOT NULL,
  `ap_ip` varchar(15) NOT NULL,
  `rss` float(11,3) NOT NULL,
  PRIMARY KEY (`measure_no`,`ap_ip`),
  KEY `measure_no` (`measure_no`),
  KEY `ap_ip` (`ap_ip`),
  CONSTRAINT `measure_train_fk` FOREIGN KEY (`measure_no`) REFERENCES `measure_time_train` (`measure_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `label_train` table : 
#

CREATE TABLE `label_train` (
  `measure_no` int(11) unsigned NOT NULL,
  `grid_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`measure_no`),
  UNIQUE KEY `measure_no` (`measure_no`),
  KEY `grid_id` (`grid_id`),
  CONSTRAINT `label_train_fk` FOREIGN KEY (`grid_id`) REFERENCES `grid` (`grid_id`),
  CONSTRAINT `label_train_fk1` FOREIGN KEY (`grid_id`) REFERENCES `grid` (`grid_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


###############################################################
#               在线定位阶段移动目标相关数据                  #
###############################################################

#
# Structure for the `measure_time_00091d000000` table : 
#

CREATE TABLE `measure_time_00091d000000` (
  `measure_no` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `time` varchar(25) DEFAULT '0000-00-00 00:00:00.000',
  PRIMARY KEY (`measure_no`),
  UNIQUE KEY `measure_no` (`measure_no`)
) ENGINE=InnoDB AUTO_INCREMENT=424 DEFAULT CHARSET=utf8;

#
# Structure for the `measure_00091d000000` table : 
#

CREATE TABLE `measure_00091d000000` (
  `measure_no` int(11) unsigned NOT NULL,
  `ap_ip` varchar(15) NOT NULL,
  `rss` float(11,3) NOT NULL,
  PRIMARY KEY (`measure_no`,`ap_ip`),
  KEY `measure_no` (`measure_no`),
  KEY `ap_ip` (`ap_ip`),
  CONSTRAINT `measure_00091d000000_ibfk_1` FOREIGN KEY (`measure_no`) REFERENCES `measure_time_00091d000000` (`measure_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
#
# Structure for the `label_001dcc000000` table : 
#

CREATE TABLE `label_001dcc000000` (
  `measure_no` int(11) unsigned NOT NULL,
  `grid_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`measure_no`),
  UNIQUE KEY `measure_no` (`measure_no`),
  KEY `grid_id` (`grid_id`),
  CONSTRAINT `label_001dcc000000_ibfk_1` FOREIGN KEY (`grid_id`) REFERENCES `grid` (`grid_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;