/****** Object:  Table [dbo].[cd_announcement]   ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_announcement]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_announcement]
GO

/****** Object:  Table [dbo].[cd_application]   ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_application]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_application]
GO

/****** Object:  Table [dbo].[cd_issue]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_issue]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_issue]
GO

/****** Object:  Table [dbo].[cd_issue]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_issuetype]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_issuetype]
GO

/****** Object:  Table [dbo].[cd_projectlocus]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_projectlocus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_projectlocus]
GO

/****** Object:  Table [dbo].[cd_project]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_project]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_project]
GO

/****** Object:  Table [dbo].[cd_project_projectlocus]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_project_projectlocus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_project_projectlocus]
GO

/****** Object:  Table [dbo].[cd_project_user]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_project_user]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_project_user]
GO

/****** Object:  Table [dbo].[cd_project_user_email]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_project_user_email]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_project_user_email]
GO

/****** Object:  Table [dbo].[cd_severity]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_severity]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_severity]
GO

/****** Object:  Table [dbo].[cd_status]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_status]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_status]
GO

/****** Object:  Table [dbo].[cd_user]     ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cd_user]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cd_user]
GO

CREATE TABLE [cd_announcement] (
	[applicationid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[title] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[body] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[projectidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[useridfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[posted] [datetime] NOT NULL ,
	CONSTRAINT [PK_cd_announcement] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[cd_application] (
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[appkey] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[title] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [cd_issue] (
	[applicationid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
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
	CONSTRAINT [PK_cd_issue] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

CREATE TABLE [cd_issuetype] (
	[applicationid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[rank] [int] NOT NULL ,
	[name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	CONSTRAINT [PK_cd_issuetype] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

CREATE TABLE [cd_projectlocus] (
	[applicationid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[name] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	CONSTRAINT [PK_cd_projectlocus] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

CREATE TABLE [cd_project] (
	[applicationid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	CONSTRAINT [PK_cd_project] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

CREATE TABLE [cd_project_projectlocus] (
	[applicationid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[projectidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[projectlociidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [cd_project_user] (
	[applicationid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[projectidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[useridfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [cd_project_user_email] (
	[applicationid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[useridfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[projectidfk] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [cd_severity] (
	[applicationid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[rank] [int] NOT NULL ,
	[name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	CONSTRAINT [PK_cd_severity] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

CREATE TABLE [cd_user] (
	[applicationid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[username] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[password] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[emailaddress] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	CONSTRAINT [PK_cd_user] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

CREATE TABLE [cd_status] (
	[applicationid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[id] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[rank] [int] NOT NULL ,
	[name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	CONSTRAINT [PK_cd_status] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO
