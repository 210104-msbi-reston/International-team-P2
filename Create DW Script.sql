USE [master]
GO
/****** Object:  Database [Covid19DW]    Script Date: 2/10/2021 6:25:45 PM ******/
CREATE DATABASE [Covid19DW]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Covid19DW', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.TRAININGSERVER\MSSQL\DATA\Covid19DW.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Covid19DW_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.TRAININGSERVER\MSSQL\DATA\Covid19DW_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Covid19DW] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Covid19DW].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Covid19DW] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Covid19DW] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Covid19DW] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Covid19DW] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Covid19DW] SET ARITHABORT OFF 
GO
ALTER DATABASE [Covid19DW] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Covid19DW] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Covid19DW] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Covid19DW] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Covid19DW] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Covid19DW] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Covid19DW] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Covid19DW] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Covid19DW] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Covid19DW] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Covid19DW] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Covid19DW] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Covid19DW] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Covid19DW] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Covid19DW] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Covid19DW] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Covid19DW] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Covid19DW] SET RECOVERY FULL 
GO
ALTER DATABASE [Covid19DW] SET  MULTI_USER 
GO
ALTER DATABASE [Covid19DW] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Covid19DW] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Covid19DW] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Covid19DW] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Covid19DW] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Covid19DW', N'ON'
GO
ALTER DATABASE [Covid19DW] SET QUERY_STORE = OFF
GO
USE [Covid19DW]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [Covid19DW]
GO
/****** Object:  Table [dbo].[DimDate]    Script Date: 2/10/2021 6:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimDate](
	[DateKey] [int] NOT NULL,
	[FullDate] [date] NULL,
	[CalendarYear] [int] NULL,
	[CalendarMonth] [int] NULL,
	[CalendarDay] [int] NULL,
	[NameOfMonth] [varchar](10) NULL,
	[NameOfDay] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimGeography]    Script Date: 2/10/2021 6:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimGeography](
	[GeographyKey] [int] IDENTITY(1,1) NOT NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[StateAbbreviation] [nvarchar](2) NULL,
PRIMARY KEY CLUSTERED 
(
	[GeographyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimPatient]    Script Date: 2/10/2021 6:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimPatient](
	[PatientKey] [int] IDENTITY(1,1) NOT NULL,
	[Age] [int] NULL,
	[Ethnicity] [varchar](50) NULL,
	[Gender] [varchar](50) NULL,
	[Occupation] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactCases]    Script Date: 2/10/2021 6:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactCases](
	[Event] [varchar](20) NULL,
	[PatientKey] [int] NULL,
	[DateKey] [int] NULL,
	[GeographyKey] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactCases]  WITH CHECK ADD FOREIGN KEY([DateKey])
REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[FactCases]  WITH CHECK ADD FOREIGN KEY([GeographyKey])
REFERENCES [dbo].[DimGeography] ([GeographyKey])
GO
ALTER TABLE [dbo].[FactCases]  WITH CHECK ADD FOREIGN KEY([PatientKey])
REFERENCES [dbo].[DimPatient] ([PatientKey])
GO
USE [master]
GO
ALTER DATABASE [Covid19DW] SET  READ_WRITE 
GO
