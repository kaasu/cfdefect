/****** Object:  Table [dbo].[cd_announcements]   ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_announcements]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_announcements]
GO

/****** Object:  Table [dbo].[cd_groups]     *****/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_groups]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_groups]
GO

/****** Object:  Table [dbo].[cd_issues]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_issues]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_issues]
GO
/****** Object:  Table [dbo].[cd_issues]     ******/if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_issuestypes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)drop table [dbo].[cd_issuestypes]GO
/****** Object:  Table [dbo].[cd_projectloci]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_projectloci]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_projectloci]
GO

/****** Object:  Table [dbo].[cd_projects]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_projects]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_projects]
GO

/****** Object:  Table [dbo].[cd_projects_projectloci]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_projects_projectloci]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_projects_projectloci]
GO

/****** Object:  Table [dbo].[cd_projects_users]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_projects_users]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_projects_users]
GO

/****** Object:  Table [dbo].[cd_projects_users_email]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_projects_users_email]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_projects_users_email]
GO

/****** Object:  Table [dbo].[cd_severities]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_severities]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_severities]
GO

/****** Object:  Table [dbo].[cd_statuses]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_statuses]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_statuses]
GO

/****** Object:  Table [dbo].[cd_users]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_users]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_users]
GO

/****** Object:  Table [dbo].[cd_users_groups]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_users_groups]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_users_groups]
GO

CREATE TABLE [cd_announcements] (
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[title] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[body] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[projectidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[useridfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[posted] [datetime] NOT NULL ,
	CONSTRAINT [PK_cd_announcements] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [cd_groups] (
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	CONSTRAINT [PK_cd_groups] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

CREATE TABLE [cd_issues] (
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[projectidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[created] [datetime] NOT NULL ,
	[updated] [datetime] NOT NULL ,
	[name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[useridfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[creatoridfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[description] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[history] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[issuetypeidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[locusidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[severityidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[statusidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[relatedurl] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[attachment] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[publicid] [int] NULL ,
	[duedate] [datetime] NULL ,
	CONSTRAINT [PK_cd_issues] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [cd_issuetypes] (
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[rank] [int] NOT NULL ,
	[name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	CONSTRAINT [PK_cd_issuetypes] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

CREATE TABLE [cd_projectloci] (
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[name] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	CONSTRAINT [PK_cd_projectloci] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

CREATE TABLE [cd_projects] (
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	CONSTRAINT [PK_cd_projects] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

CREATE TABLE [cd_projects_projectloci] (
	[projectidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[projectlociidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [cd_projects_users] (
	[projectidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[useridfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [cd_projects_users_email] (
	[useridfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[projectidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [cd_severities] (
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[rank] [int] NOT NULL ,
	[name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	CONSTRAINT [PK_cd_severities] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

CREATE TABLE [cd_users] (
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[username] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[password] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[emailaddress] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	CONSTRAINT [PK_cd_users] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

CREATE TABLE [cd_users_groups] (
	[useridfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[groupidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [cd_statuses] (
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[rank] [int] NOT NULL ,
	[name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	CONSTRAINT [PK_cd_statuses] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

INSERT INTO [cd_groups](id, name) VALUES 
('99C5AACE-92B3-7D72-6E5B4017FD38ACED','admin');

INSERT INTO cd_issuetypes(id, name,rank) VALUES 
('47B0B2F8-1111-82AF-D68EA128E83692F5','Bug', 1 );

INSERT INTO cd_issuetypes(id, name,rank) VALUES 
('47B16214-1111-82AF-D68B6F8C349D0E5F','Enhancement', 2 );

INSERT INTO cd_projectloci(id, name) VALUES 
('A5EF700C-AB69-4306-4449F6526B7009E4','Front End');

INSERT INTO cd_projectloci(id, name) VALUES ('A5EFAF58-9200-29D3-A4CC2FC42580944D','Administration');

INSERT INTO cd_projectloci(id, name) VALUES 
('A5F0620E-F052-9042-7478FF91A21A420A','Documentation');

INSERT INTO cd_projectloci(id, name) VALUES 
('A5F174B6-AF3C-D585-4E7BCBABA1403DA5','Design');

INSERT INTO cd_projectloci(id, name) VALUES 
('A5F47B30-BB4C-8AB5-3524012968ACD958','Database');

INSERT INTO cd_projectloci(id, name) VALUES 
('D24608FA-D932-FD61-D6A16A505941A5DD','Code');

INSERT INTO cd_severities(id, name, rank)  VALUES 
('B39A54CA-9301-0F14-4A3A11FAB743FC0A','Low',1);

INSERT INTO cd_severities(id, name, rank) VALUES 
('B39AD7F4-B8B1-2D90-80C3EFB34D77C27B','Normal',2);

INSERT INTO cd_severities(id, name, rank) VALUES 
('B39AF9E4-A525-B9AE-20F2B6728C98A61B','High',3);

INSERT INTO cd_statuses(id, name, rank) VALUES 
('B39CBA41-F798-06C7-3C7B89400E935B36','Open',1);

INSERT INTO cd_statuses(id, name, rank) VALUES 
('B39CDD69-BC54-D278-386E2C062727CCEE','Fixed',2);

INSERT INTO cd_statuses(id, name, rank) VALUES 
('B39D0043-B9C9-B5CB-85A208D3154A760F','Closed',3);

INSERT INTO cd_users(id,name, username, password,emailaddress) values 
('94CC6A2B-A60E-187D-5BFEA49A0FB60145','admin','admin','password','admin@localhost.com');

INSERT INTO cd_users_groups(groupidfk, useridfk) VALUES 
('99C5AACE-92B3-7D72-6E5B4017FD38ACED','94CC6A2B-A60E-187D-5BFEA49A0FB60145');
