/*Table structure for table `cd_announcement` */

drop table if exists `cd_announcement`;

CREATE TABLE `cd_announcement` (
  `applicationid` varchar(35) NOT NULL default '',
  `id` varchar(35) NOT NULL default '',
  `title` varchar(50) NOT NULL default '',
  `body` text NOT NULL,
  `projectidfk` varchar(35) NOT NULL default '',
  `useridfk` varchar(35) NOT NULL default '',
  `posted` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`,`applicationid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


/*Table structure for table `cd_application` */

drop table if exists `cd_application`;

CREATE TABLE `cd_application` (
  `key` varchar(35) NOT NULL default '',
  `id` varchar(35) NOT NULL default '',
  `title` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `cd_issue` */

drop table if exists `cd_issue`;

CREATE TABLE `cd_issue` (
  `applicationid` varchar(35) NOT NULL default '',
  `Id` varchar(35) NOT NULL default '',
  `name` varchar(255) NOT NULL default '',
  `projectidfk` varchar(35) NOT NULL default '',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  `useridfk` varchar(35) NOT NULL default '',
  `creatoridfk` varchar(35) default NULL,
  `description` text NOT NULL,
  `history` text NOT NULL,
  `issuetypeidfk` varchar(35) NOT NULL default '',
  `locusidfk` varchar(35) NOT NULL default '',
  `severityidfk` varchar(35) NOT NULL default '',
  `statusidfk` varchar(35) NOT NULL default '',
  `relatedURL` varchar(255) default NULL,
  `attachment` varchar(255) default NULL,
  `publicid` int(11) NOT NULL default '0',
  `duedate` date default NULL,
  PRIMARY KEY  (`Id`,`applicationid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `cd_issuetype` */

drop table if exists `cd_issuetype`;

CREATE TABLE `cd_issuetype` (
  `applicationid` varchar(35) NOT NULL default '',
  `id` varchar(35) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `rank` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`,`applicationid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `cd_project` */

drop table if exists `cd_project`;

CREATE TABLE `cd_project` (
  `applicationid` varchar(35) NOT NULL default '',
  `Id` varchar(35) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `cd_project_projectlocus` */

drop table if exists `cd_project_projectlocus`;

CREATE TABLE `cd_project_projectlocus` (
  `applicationid` char(35) NOT NULL default '',
  `projectidfk` char(35) NOT NULL default '',
  `projectlociidfk` char(35) NOT NULL default ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `cd_project_user` */

drop table if exists `cd_project_user`;

CREATE TABLE `cd_project_user` (
  `applicationid` varchar(35) NOT NULL default '',
  `projectidfk` varchar(35) NOT NULL default '',
  `useridfk` varchar(35) NOT NULL default ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `cd_project_user_email` */

drop table if exists `cd_project_user_email`;

CREATE TABLE `cd_project_user_email` (
  `applicationid` varchar(35) NOT NULL default '',
  `projectidfk` varchar(35) NOT NULL default '',
  `useridfk` varchar(35) NOT NULL default ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `cd_projectlocus` */

drop table if exists `cd_projectlocus`;

CREATE TABLE `cd_projectlocus` (
  `Id` varchar(35) NOT NULL default '',
  `applicationid` varchar(35) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `rank` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `cd_severity` */

drop table if exists `cd_severity`;

CREATE TABLE `cd_severity` (
  `applicationid` varchar(35) NOT NULL default '',
  `Id` varchar(35) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `rank` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `cd_status` */

drop table if exists `cd_status`;

CREATE TABLE `cd_status` (
  `applicationid` varchar(35) NOT NULL default '',
  `Id` varchar(35) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `rank` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `cd_user` */

drop table if exists `cd_user`;

CREATE TABLE `cd_user` (
  `applicationid` varchar(35) NOT NULL default '',
  `Id` varchar(35) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `username` varchar(50) NOT NULL default '',
  `password` varchar(50) NOT NULL default '',
  `emailaddress` varchar(50) NOT NULL default '',
  `isadmin` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
