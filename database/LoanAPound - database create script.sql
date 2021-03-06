USE [master]
GO
/****** Object:  Database [LoanAPound]    Script Date: 17/10/2017 14:31:11 ******/
CREATE DATABASE [LoanAPound]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LoanAPound', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS01\MSSQL\DATA\LoanAPound.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LoanAPound_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS01\MSSQL\DATA\LoanAPound_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [LoanAPound] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LoanAPound].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LoanAPound] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LoanAPound] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LoanAPound] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LoanAPound] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LoanAPound] SET ARITHABORT OFF 
GO
ALTER DATABASE [LoanAPound] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LoanAPound] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LoanAPound] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LoanAPound] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LoanAPound] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LoanAPound] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LoanAPound] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LoanAPound] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LoanAPound] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LoanAPound] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LoanAPound] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LoanAPound] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LoanAPound] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LoanAPound] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LoanAPound] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LoanAPound] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LoanAPound] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LoanAPound] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LoanAPound] SET  MULTI_USER 
GO
ALTER DATABASE [LoanAPound] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LoanAPound] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LoanAPound] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LoanAPound] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LoanAPound] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LoanAPound] SET QUERY_STORE = OFF
GO
USE [LoanAPound]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [LoanAPound]
GO
/****** Object:  User [IIS APPPOOL\DefaultAppPool]    Script Date: 17/10/2017 14:31:11 ******/
CREATE USER [IIS APPPOOL\DefaultAppPool] FOR LOGIN [IIS APPPOOL\DefaultAppPool] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [IIS APPPOOL\DefaultAppPool]
GO
/****** Object:  Table [dbo].[Applicant]    Script Date: 17/10/2017 14:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Applicant](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](25) NOT NULL,
	[FirstName] [nvarchar](25) NOT NULL,
	[MiddleName] [nvarchar](25) NULL,
	[Surname] [nvarchar](25) NOT NULL,
	[EmailAddress] [nvarchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Application]    Script Date: 17/10/2017 14:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Application](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicantID] [int] NOT NULL,
	[LoanID] [int] NOT NULL,
	[LoanAmount] [numeric](15, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ApplicationStatus]    Script Date: 17/10/2017 14:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationID] [int] NOT NULL,
	[StatusID] [int] NOT NULL,
	[DateAchieved] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CreditScoreEngine]    Script Date: 17/10/2017 14:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CreditScoreEngine](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CreditScoreResult]    Script Date: 17/10/2017 14:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CreditScoreResult](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicantID] [int] NOT NULL,
	[CreditScoreEngineID] [int] NOT NULL,
	[DateAchieved] [datetime2](7) NULL,
	[Result] [numeric](38, 10) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Criterion]    Script Date: 17/10/2017 14:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Criterion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[CriterionTypeID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CriterionType]    Script Date: 17/10/2017 14:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CriterionType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Loan]    Script Date: 17/10/2017 14:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loan](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[Description] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoanDatetimeCriterionValue]    Script Date: 17/10/2017 14:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoanDatetimeCriterionValue](
	[LoanID] [int] NULL,
	[CriterionID] [int] NULL,
	[Value] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoanNumericCriterionValue]    Script Date: 17/10/2017 14:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoanNumericCriterionValue](
	[LoanID] [int] NULL,
	[CriterionID] [int] NULL,
	[Value] [numeric](38, 10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoanStringCriterionValue]    Script Date: 17/10/2017 14:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoanStringCriterionValue](
	[LoanID] [int] NULL,
	[CriterionID] [int] NULL,
	[Value] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 17/10/2017 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Applicant] ON 
GO
INSERT [dbo].[Applicant] ([ID], [Title], [FirstName], [MiddleName], [Surname], [EmailAddress]) VALUES (1, N'Mr', N'Adam', N'Alan', N'Arkwright', N'adam@yahoo.com')
GO
INSERT [dbo].[Applicant] ([ID], [Title], [FirstName], [MiddleName], [Surname], [EmailAddress]) VALUES (2, N'Mrs', N'Beatrice', N'Bianca', N'Baines', N'bbb@gmail.com')
GO
INSERT [dbo].[Applicant] ([ID], [Title], [FirstName], [MiddleName], [Surname], [EmailAddress]) VALUES (3, N'Mr', N'Colin', N'Carl', N'Crighton', N'c_c_c@yahoo.com')
GO
INSERT [dbo].[Applicant] ([ID], [Title], [FirstName], [MiddleName], [Surname], [EmailAddress]) VALUES (4, N'Mrs', N'Dianne', N'Doris', N'Dawes', N'd.dawes@b.com')
GO
INSERT [dbo].[Applicant] ([ID], [Title], [FirstName], [MiddleName], [Surname], [EmailAddress]) VALUES (5, N'Dr', N'Eric', N'Edward', N'Engels', N'eric@outlook.com')
GO
INSERT [dbo].[Applicant] ([ID], [Title], [FirstName], [MiddleName], [Surname], [EmailAddress]) VALUES (6, N'Dr', N'Fiona', N'Fatima', N'Fontaine', N'fi@gmail.com')
GO
INSERT [dbo].[Applicant] ([ID], [Title], [FirstName], [MiddleName], [Surname], [EmailAddress]) VALUES (7, N'Mr', N'Gareth', N'Gordon', N'Griffiths', N'garethgriffiths@yahoo.com')
GO
INSERT [dbo].[Applicant] ([ID], [Title], [FirstName], [MiddleName], [Surname], [EmailAddress]) VALUES (8, N'Miss', N'Hannah', N'Hazel', N'Haynes', N'hh@outlook.com')
GO
INSERT [dbo].[Applicant] ([ID], [Title], [FirstName], [MiddleName], [Surname], [EmailAddress]) VALUES (9, N'Mr', N'Igor', N'Ian', N'Irvine', N'igor.irvine@yandex.com')
GO
INSERT [dbo].[Applicant] ([ID], [Title], [FirstName], [MiddleName], [Surname], [EmailAddress]) VALUES (10, N'Miss', N'Jane', N'Joanne', N'Jones', N'JJJones@gmail.com')
GO
SET IDENTITY_INSERT [dbo].[Applicant] OFF
GO
SET IDENTITY_INSERT [dbo].[CreditScoreEngine] ON 
GO
INSERT [dbo].[CreditScoreEngine] ([ID], [TypeName]) VALUES (1, N'LoanAPoundBusinessLayer.CreditScoreEngine1')
GO
INSERT [dbo].[CreditScoreEngine] ([ID], [TypeName]) VALUES (2, N'LoanAPoundBusinessLayer.CreditScoreEngine2')
GO
INSERT [dbo].[CreditScoreEngine] ([ID], [TypeName]) VALUES (3, N'LoanAPoundBusinessLayer.CreditScoreEngine3')
GO
SET IDENTITY_INSERT [dbo].[CreditScoreEngine] OFF
GO
SET IDENTITY_INSERT [dbo].[Criterion] ON 
GO
INSERT [dbo].[Criterion] ([ID], [Name], [CriterionTypeID]) VALUES (1, N'Term', 2)
GO
INSERT [dbo].[Criterion] ([ID], [Name], [CriterionTypeID]) VALUES (2, N'Borrowing rate', 2)
GO
INSERT [dbo].[Criterion] ([ID], [Name], [CriterionTypeID]) VALUES (3, N'Provider', 1)
GO
INSERT [dbo].[Criterion] ([ID], [Name], [CriterionTypeID]) VALUES (4, N'Start date', 3)
GO
INSERT [dbo].[Criterion] ([ID], [Name], [CriterionTypeID]) VALUES (5, N'End date', 3)
GO
INSERT [dbo].[Criterion] ([ID], [Name], [CriterionTypeID]) VALUES (6, N'UK citizens only flag', 2)
GO
SET IDENTITY_INSERT [dbo].[Criterion] OFF
GO
SET IDENTITY_INSERT [dbo].[CriterionType] ON 
GO
INSERT [dbo].[CriterionType] ([ID], [Name]) VALUES (1, N'String')
GO
INSERT [dbo].[CriterionType] ([ID], [Name]) VALUES (2, N'Numeric')
GO
INSERT [dbo].[CriterionType] ([ID], [Name]) VALUES (3, N'Datetime')
GO
SET IDENTITY_INSERT [dbo].[CriterionType] OFF
GO
SET IDENTITY_INSERT [dbo].[Status] ON 
GO
INSERT [dbo].[Status] ([ID], [Name]) VALUES (1, N'Open')
GO
INSERT [dbo].[Status] ([ID], [Name]) VALUES (2, N'Scored')
GO
INSERT [dbo].[Status] ([ID], [Name]) VALUES (3, N'Pending decision')
GO
INSERT [dbo].[Status] ([ID], [Name]) VALUES (4, N'Approved')
GO
SET IDENTITY_INSERT [dbo].[Status] OFF
GO
ALTER TABLE [dbo].[Application]  WITH CHECK ADD  CONSTRAINT [FK_ApplicantApplication] FOREIGN KEY([ApplicantID])
REFERENCES [dbo].[Applicant] ([ID])
GO
ALTER TABLE [dbo].[Application] CHECK CONSTRAINT [FK_ApplicantApplication]
GO
ALTER TABLE [dbo].[Application]  WITH CHECK ADD  CONSTRAINT [FK_LoanApplication] FOREIGN KEY([LoanID])
REFERENCES [dbo].[Loan] ([ID])
GO
ALTER TABLE [dbo].[Application] CHECK CONSTRAINT [FK_LoanApplication]
GO
ALTER TABLE [dbo].[ApplicationStatus]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationApplicationStatus] FOREIGN KEY([ApplicationID])
REFERENCES [dbo].[Application] ([ID])
GO
ALTER TABLE [dbo].[ApplicationStatus] CHECK CONSTRAINT [FK_ApplicationApplicationStatus]
GO
ALTER TABLE [dbo].[ApplicationStatus]  WITH CHECK ADD  CONSTRAINT [FK_StatusApplicationStatus] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Status] ([ID])
GO
ALTER TABLE [dbo].[ApplicationStatus] CHECK CONSTRAINT [FK_StatusApplicationStatus]
GO
ALTER TABLE [dbo].[CreditScoreResult]  WITH CHECK ADD  CONSTRAINT [FK_ApplicantCreditScoreResult] FOREIGN KEY([ApplicantID])
REFERENCES [dbo].[Applicant] ([ID])
GO
ALTER TABLE [dbo].[CreditScoreResult] CHECK CONSTRAINT [FK_ApplicantCreditScoreResult]
GO
ALTER TABLE [dbo].[CreditScoreResult]  WITH CHECK ADD  CONSTRAINT [FK_CreditScoreEngineCreditScoreResult] FOREIGN KEY([CreditScoreEngineID])
REFERENCES [dbo].[CreditScoreEngine] ([ID])
GO
ALTER TABLE [dbo].[CreditScoreResult] CHECK CONSTRAINT [FK_CreditScoreEngineCreditScoreResult]
GO
ALTER TABLE [dbo].[Criterion]  WITH CHECK ADD  CONSTRAINT [FK_CriterionType] FOREIGN KEY([CriterionTypeID])
REFERENCES [dbo].[CriterionType] ([ID])
GO
ALTER TABLE [dbo].[Criterion] CHECK CONSTRAINT [FK_CriterionType]
GO
ALTER TABLE [dbo].[LoanDatetimeCriterionValue]  WITH CHECK ADD  CONSTRAINT [FK_CriterionLoanDatetimeCriterionValue] FOREIGN KEY([CriterionID])
REFERENCES [dbo].[Criterion] ([ID])
GO
ALTER TABLE [dbo].[LoanDatetimeCriterionValue] CHECK CONSTRAINT [FK_CriterionLoanDatetimeCriterionValue]
GO
ALTER TABLE [dbo].[LoanDatetimeCriterionValue]  WITH CHECK ADD  CONSTRAINT [FK_LoanLoanDatetimeCriterionValue] FOREIGN KEY([LoanID])
REFERENCES [dbo].[Loan] ([ID])
GO
ALTER TABLE [dbo].[LoanDatetimeCriterionValue] CHECK CONSTRAINT [FK_LoanLoanDatetimeCriterionValue]
GO
ALTER TABLE [dbo].[LoanNumericCriterionValue]  WITH CHECK ADD  CONSTRAINT [FK_CriterionLoanNumericCriterionValue] FOREIGN KEY([CriterionID])
REFERENCES [dbo].[Criterion] ([ID])
GO
ALTER TABLE [dbo].[LoanNumericCriterionValue] CHECK CONSTRAINT [FK_CriterionLoanNumericCriterionValue]
GO
ALTER TABLE [dbo].[LoanNumericCriterionValue]  WITH CHECK ADD  CONSTRAINT [FK_LoanLoanNumericCriterionValue] FOREIGN KEY([LoanID])
REFERENCES [dbo].[Loan] ([ID])
GO
ALTER TABLE [dbo].[LoanNumericCriterionValue] CHECK CONSTRAINT [FK_LoanLoanNumericCriterionValue]
GO
ALTER TABLE [dbo].[LoanStringCriterionValue]  WITH CHECK ADD  CONSTRAINT [FK_CriterionLoanStringCriterionValue] FOREIGN KEY([CriterionID])
REFERENCES [dbo].[Criterion] ([ID])
GO
ALTER TABLE [dbo].[LoanStringCriterionValue] CHECK CONSTRAINT [FK_CriterionLoanStringCriterionValue]
GO
ALTER TABLE [dbo].[LoanStringCriterionValue]  WITH CHECK ADD  CONSTRAINT [FK_LoanLoanStringCriterionValue] FOREIGN KEY([LoanID])
REFERENCES [dbo].[Loan] ([ID])
GO
ALTER TABLE [dbo].[LoanStringCriterionValue] CHECK CONSTRAINT [FK_LoanLoanStringCriterionValue]
GO
USE [master]
GO
ALTER DATABASE [LoanAPound] SET  READ_WRITE 
GO
