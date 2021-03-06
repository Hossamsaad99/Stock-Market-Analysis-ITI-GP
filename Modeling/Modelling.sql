USE [master]
GO
/****** Object:  Database [GP_DWH]    Script Date: 7/2/2022 6:19:17 PM ******/
CREATE DATABASE [GP_DWH]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GP_DWH', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\GP_DWH.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GP_DWH_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\GP_DWH_log.ldf' , SIZE = 204800KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [GP_DWH] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GP_DWH].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GP_DWH] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GP_DWH] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GP_DWH] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GP_DWH] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GP_DWH] SET ARITHABORT OFF 
GO
ALTER DATABASE [GP_DWH] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GP_DWH] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GP_DWH] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GP_DWH] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GP_DWH] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GP_DWH] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GP_DWH] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GP_DWH] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GP_DWH] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GP_DWH] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GP_DWH] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GP_DWH] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GP_DWH] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GP_DWH] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GP_DWH] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GP_DWH] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GP_DWH] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GP_DWH] SET RECOVERY FULL 
GO
ALTER DATABASE [GP_DWH] SET  MULTI_USER 
GO
ALTER DATABASE [GP_DWH] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GP_DWH] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GP_DWH] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GP_DWH] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GP_DWH] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GP_DWH] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'GP_DWH', N'ON'
GO
ALTER DATABASE [GP_DWH] SET QUERY_STORE = OFF
GO
USE [GP_DWH]
GO
/****** Object:  Table [dbo].[company_info_dim]    Script Date: 7/2/2022 6:19:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company_info_dim](
	[Symbol] [nvarchar](50) NOT NULL,
	[shortName] [nvarchar](50) NULL,
	[fullTimeEmployees] [int] NULL,
	[logo_url] [nvarchar](100) NULL,
	[company_sector_dim_Index] [tinyint] NULL,
	[Index_Loc] [tinyint] NULL,
 CONSTRAINT [PK_company_info_dim] PRIMARY KEY CLUSTERED 
(
	[Symbol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[company_Loc_dim]    Script Date: 7/2/2022 6:19:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company_Loc_dim](
	[country] [nvarchar](50) NOT NULL,
	[city] [nvarchar](50) NOT NULL,
	[state] [nvarchar](50) NULL,
	[Index] [tinyint] NOT NULL,
 CONSTRAINT [PK_company_Loc_dim] PRIMARY KEY CLUSTERED 
(
	[Index] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[company_sector_dim]    Script Date: 7/2/2022 6:19:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company_sector_dim](
	[sector] [nvarchar](50) NOT NULL,
	[industry] [nvarchar](50) NOT NULL,
	[Index] [tinyint] NOT NULL,
 CONSTRAINT [PK_company_sector_dim] PRIMARY KEY CLUSTERED 
(
	[Index] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Date_dim]    Script Date: 7/2/2022 6:19:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Date_dim](
	[Date] [date] NOT NULL,
	[Year] [smallint] NOT NULL,
	[Start_of_Year] [date] NOT NULL,
	[End_of_Year] [date] NOT NULL,
	[Month] [tinyint] NOT NULL,
	[Start_of_Month] [date] NOT NULL,
	[End_of_Month] [date] NOT NULL,
	[Days_in_Month] [tinyint] NOT NULL,
	[Day] [tinyint] NOT NULL,
	[Day_Name] [nvarchar](50) NOT NULL,
	[Day_of_Week] [tinyint] NOT NULL,
	[Day_of_Year] [smallint] NOT NULL,
	[Month_Name] [nvarchar](50) NOT NULL,
	[Quarter] [tinyint] NOT NULL,
 CONSTRAINT [PK_Date_dim] PRIMARY KEY CLUSTERED 
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fact_daily_monitoring]    Script Date: 7/2/2022 6:19:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fact_daily_monitoring](
	[Date] [date] NOT NULL,
	[Symbol] [nvarchar](50) NOT NULL,
	[Close] [float] NOT NULL,
	[High] [float] NOT NULL,
	[Low] [float] NOT NULL,
	[Open] [float] NOT NULL,
	[Volume] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fact_s&p_historic]    Script Date: 7/2/2022 6:19:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fact_s&p_historic](
	[Date] [date] NOT NULL,
	[Open] [float] NOT NULL,
	[High] [float] NOT NULL,
	[Low] [float] NOT NULL,
	[Close] [float] NOT NULL,
	[Volume] [bigint] NOT NULL,
 CONSTRAINT [PK_fact_s&p_historic] PRIMARY KEY CLUSTERED 
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fact_stock_market]    Script Date: 7/2/2022 6:19:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fact_stock_market](
	[Symbol] [nvarchar](50) NOT NULL,
	[askSize] [int] NULL,
	[bidSize] [int] NULL,
	[beta_0_1] [float] NULL,
	[debtToEquity] [float] NULL,
	[totalDebt] [bigint] NULL,
	[Equity] [float] NULL,
	[dividendYield] [float] NULL,
	[Dividned] [float] NULL,
	[ebitda] [bigint] NULL,
	[netIncomeToCommon] [bigint] NULL,
	[grossMargins] [float] NULL,
	[grossProfits] [bigint] NULL,
	[marketCap] [bigint] NULL,
	[freeCashflow] [bigint] NULL,
	[Dividend_payout_Ratio_dividned_EPS] [float] NULL,
	[PEG_Ratio_PE_Growth] [float] NULL,
	[bookValue] [float] NULL,
	[priceToSales] [float] NULL,
	[EPS_Growth] [float] NULL,
	[revenueGrowth] [float] NULL,
	[totalRevenue] [bigint] NULL,
	[Total_sharesOutstanding] [bigint] NULL,
 CONSTRAINT [PK_fact_stock_market] PRIMARY KEY CLUSTERED 
(
	[Symbol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[company_info_dim]  WITH CHECK ADD  CONSTRAINT [FK_company_info_dim_company_Loc_dim] FOREIGN KEY([Index_Loc])
REFERENCES [dbo].[company_Loc_dim] ([Index])
GO
ALTER TABLE [dbo].[company_info_dim] CHECK CONSTRAINT [FK_company_info_dim_company_Loc_dim]
GO
ALTER TABLE [dbo].[company_info_dim]  WITH CHECK ADD  CONSTRAINT [FK_company_info_dim_company_sector_dim] FOREIGN KEY([company_sector_dim_Index])
REFERENCES [dbo].[company_sector_dim] ([Index])
GO
ALTER TABLE [dbo].[company_info_dim] CHECK CONSTRAINT [FK_company_info_dim_company_sector_dim]
GO
ALTER TABLE [dbo].[fact_daily_monitoring]  WITH CHECK ADD  CONSTRAINT [FK_fact_daily_monitoring_company_info_dim] FOREIGN KEY([Symbol])
REFERENCES [dbo].[company_info_dim] ([Symbol])
GO
ALTER TABLE [dbo].[fact_daily_monitoring] CHECK CONSTRAINT [FK_fact_daily_monitoring_company_info_dim]
GO
ALTER TABLE [dbo].[fact_daily_monitoring]  WITH CHECK ADD  CONSTRAINT [FK_fact_daily_monitoring_Date_dim1] FOREIGN KEY([Date])
REFERENCES [dbo].[Date_dim] ([Date])
GO
ALTER TABLE [dbo].[fact_daily_monitoring] CHECK CONSTRAINT [FK_fact_daily_monitoring_Date_dim1]
GO
ALTER TABLE [dbo].[fact_s&p_historic]  WITH CHECK ADD  CONSTRAINT [FK_fact_s&p_historic_Date_dim] FOREIGN KEY([Date])
REFERENCES [dbo].[Date_dim] ([Date])
GO
ALTER TABLE [dbo].[fact_s&p_historic] CHECK CONSTRAINT [FK_fact_s&p_historic_Date_dim]
GO
ALTER TABLE [dbo].[fact_stock_market]  WITH CHECK ADD  CONSTRAINT [FK_fact_stock_market_company_info_dim] FOREIGN KEY([Symbol])
REFERENCES [dbo].[company_info_dim] ([Symbol])
GO
ALTER TABLE [dbo].[fact_stock_market] CHECK CONSTRAINT [FK_fact_stock_market_company_info_dim]
GO
USE [master]
GO
ALTER DATABASE [GP_DWH] SET  READ_WRITE 
GO
