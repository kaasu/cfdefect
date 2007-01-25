# MySQL-Front 3.2  (Build 4.13)

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET CHARACTER SET 'latin1' */;

# Host: localhost    Database: lighthousepro
# ------------------------------------------------------
# Server version 4.1.10-nt

#
# Table Objects for table cd_groups
#

DROP TABLE IF EXISTS `cd_groups`;

CREATE TABLE `cd_groups` (
  `Id` varchar(35) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Dumping data for table cd_groups
#

INSERT INTO `cd_groups` VALUES ('99C5AACE-92B3-7D72-6E5B4017FD38ACED','admin');

#
# Table Objects for table cd_issues
#

DROP TABLE IF EXISTS `cd_announcements`;
CREATE TABLE `cd_announcements` (
  `id` varchar(35) NOT NULL,
  `title` varchar(50) NOT NULL,
  `body` text NOT NULL,
  `projectidfk` varchar(35) NOT NULL,
  `useridfk` varchar(35) NOT NULL,
  `posted` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `cd_issues`;

CREATE TABLE `cd_issues` (
  `Id` varchar(35) NOT NULL,
  `name` varchar(255) NOT NULL,
  `projectidfk` varchar(35) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `useridfk` varchar(35) NOT NULL,
  `creatoridfk` varchar(35) NULL,
  `description` text NOT NULL,
  `history` text NOT NULL,
  `issuetypeidfk` varchar(35) NOT NULL,
  `locusidfk` varchar(35) NOT NULL,
  `severityidfk` varchar(35) NOT NULL,
  `statusidfk` varchar(35) NOT NULL,
  `relatedURL` varchar(255),
  `attachment` varchar(255),
  `publicid` int(11) NOT NULL,
  `duedate` date default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Dumping data for table cd_issues
#

/*Table structure for table `cd_issuetypes` */

drop table if exists `cd_issuetypes`;

CREATE TABLE `cd_issuetypes` (
  `id` varchar(35) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `rank` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cd_issuetypes` */

insert into `cd_issuetypes` values ('476DDDF5-1111-82AF-D696221A6DA30215','Bug',1),('476E2BD7-1111-82AF-D64F7E3EE9F5CDB9','Enhancement',2);


#
# Table Objects for table cd_projectloci
#

DROP TABLE IF EXISTS `cd_projectloci`;

CREATE TABLE `cd_projectloci` (
  `Id` varchar(35) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Dumping data for table cd_projectloci
#

INSERT INTO `cd_projectloci`(id, name) VALUES ('A5EF700C-AB69-4306-4449F6526B7009E4','Front End');
INSERT INTO `cd_projectloci`(id, name) VALUES ('A5EFAF58-9200-29D3-A4CC2FC42580944D','Administration');
INSERT INTO `cd_projectloci`(id, name) VALUES ('A5F0620E-F052-9042-7478FF91A21A420A','Documentation');
INSERT INTO `cd_projectloci`(id, name) VALUES ('A5F174B6-AF3C-D585-4E7BCBABA1403DA5','Design');
INSERT INTO `cd_projectloci`(id, name) VALUES ('A5F47B30-BB4C-8AB5-3524012968ACD958','Database');
INSERT INTO `cd_projectloci`(id, name) VALUES ('D24608FA-D932-FD61-D6A16A505941A5DD','Code');

#
# Table Objects for table cd_projects
#

DROP TABLE IF EXISTS `cd_projects`;

CREATE TABLE `cd_projects` (
  `Id` varchar(35) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Dumping data for table cd_projects
#


#
# Table Objects for table projects_cd_projectloci
#

DROP TABLE IF EXISTS `cd_projects_projectloci`;

CREATE TABLE `cd_projects_projectloci` (
  `projectidfk` varchar(35) NOT NULL,
  `projectlociidfk` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Dumping data for table projects_cd_projectloci
#


#
# Table Objects for table cd_projects_users
#

DROP TABLE IF EXISTS `cd_projects_users`;

CREATE TABLE `cd_projects_users` (
  `projectidfk` varchar(35) NOT NULL,
  `useridfk` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Dumping data for table cd_projects_users
#


#
# Table Objects for table cd_projects_users_email
#

DROP TABLE IF EXISTS `cd_projects_users_email`;

CREATE TABLE `cd_projects_users_email` (
  `projectidfk` varchar(35) NOT NULL,
  `useridfk` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Dumping data for table cd_projects_users_email
#


#
# Table Objects for table cd_severities
#

DROP TABLE IF EXISTS `cd_severities`;

CREATE TABLE `cd_severities` (
  `Id` varchar(35) NOT NULL,
  `name` varchar(50) NOT NULL,
  `rank` tinyint(4) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Dumping data for table cd_severities
#

INSERT INTO `cd_severities`(id, name, rank) VALUES ('B39A54CA-9301-0F14-4A3A11FAB743FC0A','Low',1);
INSERT INTO `cd_severities`(id, name, rank) VALUES ('B39AD7F4-B8B1-2D90-80C3EFB34D77C27B','Normal',2);
INSERT INTO `cd_severities`(id, name, rank) VALUES ('B39AF9E4-A525-B9AE-20F2B6728C98A61B','High',3);

#
# Table Objects for table cd_statuses
#

DROP TABLE IF EXISTS `cd_statuses`;

CREATE TABLE `cd_statuses` (
  `Id` varchar(35) NOT NULL,
  `name` varchar(50) NOT NULL,
  `rank` tinyint(4) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Dumping data for table cd_statuses
#

INSERT INTO `cd_statuses`(id, name, rank) VALUES ('B39CBA41-F798-06C7-3C7B89400E935B36','Open',1);
INSERT INTO `cd_statuses`(id, name, rank) VALUES ('B39CDD69-BC54-D278-386E2C062727CCEE','Fixed',2);
INSERT INTO `cd_statuses`(id, name, rank) VALUES ('B39D0043-B9C9-B5CB-85A208D3154A760F','Closed',3);

#
# Table Objects for table cd_users
#

DROP TABLE IF EXISTS `cd_users`;

CREATE TABLE `cd_users` (
  `Id` varchar(35) NOT NULL,
  `name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `emailaddress` varchar(50) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Dumping data for table cd_users
#

INSERT INTO `cd_users`(id, name, username, password, emailaddress) VALUES ('94CC6A2B-A60E-187D-5BFEA49A0FB60145','admin','admin','password','admin@localhost.com');

#
# Table Objects for table users_cd_groups
#

DROP TABLE IF EXISTS `cd_users_groups`;

CREATE TABLE `cd_users_groups` (
  `groupidfk` varchar(35) NOT NULL,
  `useridfk` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Dumping data for table users_cd_groups
#

INSERT INTO `cd_users_groups`(groupidfk, useridfk) VALUES ('99C5AACE-92B3-7D72-6E5B4017FD38ACED','94CC6A2B-A60E-187D-5BFEA49A0FB60145');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
