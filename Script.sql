USE [master]
GO
/****** Object:  Database [Andycabar]    Script Date: 9/15/2017 1:42:05 PM ******/
CREATE DATABASE [Andycabar]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Andycabar', FILENAME = N'D:\inestaled\sql2016\MSSQL13.MSSQLSERVER\MSSQL\DATA\Andycabar.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Andycabar_log', FILENAME = N'D:\inestaled\sql2016\MSSQL13.MSSQLSERVER\MSSQL\DATA\Andycabar_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Andycabar] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Andycabar].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Andycabar] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Andycabar] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Andycabar] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Andycabar] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Andycabar] SET ARITHABORT OFF 
GO
ALTER DATABASE [Andycabar] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Andycabar] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Andycabar] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Andycabar] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Andycabar] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Andycabar] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Andycabar] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Andycabar] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Andycabar] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Andycabar] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Andycabar] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Andycabar] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Andycabar] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Andycabar] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Andycabar] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Andycabar] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Andycabar] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Andycabar] SET RECOVERY FULL 
GO
ALTER DATABASE [Andycabar] SET  MULTI_USER 
GO
ALTER DATABASE [Andycabar] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Andycabar] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Andycabar] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Andycabar] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Andycabar] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Andycabar', N'ON'
GO
ALTER DATABASE [Andycabar] SET QUERY_STORE = OFF
GO
USE [Andycabar]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Andycabar]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 9/15/2017 1:42:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Profit] [decimal](18, 2) NULL,
	[SalePrice] [decimal](12, 2) NOT NULL,
	[DetailedName] [nvarchar](150) NOT NULL,
	[CompanyCost] [decimal](12, 2) NOT NULL,
	[GroupId] [int] NOT NULL,
	[Image] [varbinary](max) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductTransfer]    Script Date: 9/15/2017 1:42:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductTransfer](
	[Barcode] [varchar](50) NOT NULL,
	[ProductId] [bigint] NOT NULL,
	[ProduceEvent] [datetime] NOT NULL,
	[EntranceEvent] [datetime] NULL,
	[BarcodeEvent] [datetime] NULL,
	[SaleEvent] [datetime] NULL,
	[SubmitEvent] [datetime] NOT NULL,
	[ExpireEvent] [datetime] NOT NULL,
	[StoreId] [int] NOT NULL,
	[YourBarcode] [nvarchar](50) NULL,
 CONSTRAINT [PK_ProductTransfer] PRIMARY KEY CLUSTERED 
(
	[Barcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[v_ProductDetails]    Script Date: 9/15/2017 1:42:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ProductDetails]
AS
SELECT        dbo.Product.*, dbo.ProductTransfer.*
FROM            dbo.Product INNER JOIN
                         dbo.ProductTransfer ON dbo.Product.Id = dbo.ProductTransfer.ProductId

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 9/15/2017 1:42:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[UserId] [int] NOT NULL,
	[Email] [nvarchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Seller]    Script Date: 9/15/2017 1:42:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seller](
	[UserId] [int] NOT NULL,
	[NationalCode] [nvarchar](50) NOT NULL,
	[StoreId] [int] NOT NULL,
 CONSTRAINT [PK_Seller] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 9/15/2017 1:42:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Mobile] [nvarchar](50) NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[VerificationCode] [int] NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 9/15/2017 1:42:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](12, 2) NOT NULL,
	[Submit] [datetime] NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[v_Factors]    Script Date: 9/15/2017 1:42:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Factors]
AS
SELECT        dbo.[Transaction].Id, dbo.[Transaction].Amount, dbo.[Transaction].Submit, dbo.Seller.StoreName, dbo.[Transaction].CustomerId
FROM            dbo.[User] INNER JOIN
                         dbo.Customer ON dbo.[User].Id = dbo.Customer.UserId INNER JOIN
                         dbo.[Transaction] ON dbo.Customer.UserId = dbo.[Transaction].CustomerId INNER JOIN
                         dbo.Seller ON dbo.[User].Id = dbo.Seller.UserId AND dbo.[Transaction].SellerId = dbo.Seller.UserId AND dbo.[Transaction].CustomerId = dbo.Seller.BankAcount

GO
/****** Object:  Table [dbo].[Group]    Script Date: 9/15/2017 1:42:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Group](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[BusinessId] [int] NOT NULL,
	[Image] [varbinary](max) NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Business]    Script Date: 9/15/2017 1:42:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Business](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[Logo] [varbinary](max) NULL,
 CONSTRAINT [PK_Business] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[v_ProductSearch]    Script Date: 9/15/2017 1:42:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ProductSearch]
AS
SELECT        dbo.Product.Description, dbo.Product.Profit, dbo.Product.SalePrice, dbo.Product.CompanyCost, dbo.Product.DetailedName AS ProductName, dbo.Product.GroupId, dbo.[Group].Name AS GroupName, dbo.[Group].BusinessId, 
                         dbo.[Group].Image AS imageGroup, dbo.Business.Name AS BusinessName, dbo.Business.Address, dbo.Business.Logo, dbo.Product.Image AS imageProduct, dbo.ProductTransfer.Barcode, dbo.ProductTransfer.ProduceEvent, 
                         dbo.ProductTransfer.EntranceEvent, dbo.ProductTransfer.BarcodeEvent, dbo.ProductTransfer.SaleEvent, dbo.ProductTransfer.SubmitEvent, dbo.ProductTransfer.ExpireEvent, dbo.Product.Id AS productId
FROM            dbo.[Group] INNER JOIN
                         dbo.Product ON dbo.[Group].Id = dbo.Product.GroupId INNER JOIN
                         dbo.Business ON dbo.[Group].BusinessId = dbo.Business.Id INNER JOIN
                         dbo.ProductTransfer ON dbo.Product.Id = dbo.ProductTransfer.ProductId

GO
/****** Object:  Table [dbo].[Associtation_TransactionProduct]    Script Date: 9/15/2017 1:42:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Associtation_TransactionProduct](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [bigint] NOT NULL,
	[TransactionId] [int] NOT NULL,
 CONSTRAINT [PK_Associtation_TransactionProduct] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Marketer]    Script Date: 9/15/2017 1:42:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marketer](
	[UserId] [int] NOT NULL,
	[NationalCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Marketer] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Store]    Script Date: 9/15/2017 1:42:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Store](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Latitude] [decimal](15, 6) NULL,
	[Longitude] [decimal](15, 6) NULL,
	[Address] [nvarchar](4000) NULL,
	[Logo] [varbinary](max) NULL,
	[BankAccount] [nvarchar](50) NULL,
 CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SystemOprator]    Script Date: 9/15/2017 1:42:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemOprator](
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](4000) NOT NULL,
 CONSTRAINT [PK_SystemOprator] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Business] ON 

INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (5, N'دانیال ترابر', N'San Carlos de Bariloche', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (6, N'آیسان بار', N'Bakeriveien 125', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (7, N'بھان گستران پارس', N'67 rue Beauvau', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (8, N'پارس تیر', N'Askeladden 144', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (9, N'پیشروحمل کالا', N'97 rue de Penthièvre', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (10, N'پیک تیزرخش', N'Bakeriveien 125', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (11, N'توسن كالا', N'Askeladden 144', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (12, N'حمل و نقل بین المللی مھداد', N'17 Chemin Challet', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (13, N'حمل ونقل بین المللی پیشرو حمل کالا', N'67 rue Beauvau', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (14, N'دژپاد', N'San Carlos de Bariloche', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (15, N'راه طولانی', N'97 rue de Penthièvre', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (16, N'سامین آسیا ترابر', N'17 Chemin Challet', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (17, N'سپاروک', N'35 rue Sadi Carnot', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (18, N'شاران گشت', N'67 rue Beauvau', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (19, N'شرکت حمل و نقل بین المللی ره انجام', N'17 Chemin Challet', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (20, N'شرکت مارین سرویس کیا', N'97 rue de Penthièvre', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (21, N'طلایه داران غدیر زنگان', N'17 Chemin Challet', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (22, N'عظیم ترابر', N'35 rue Sadi Carnot', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (23, N'کالا تندبر', N'17 Chemin Challet', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (24, N'نور ترابر سروش', N'Askeladden 144', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (25, N'آراسته ترابر', N'97 rue de Penthièvre', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (26, N'آرامش حمل البرز', N'Bakeriveien 125', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (27, N'آران آسمان', N'35 rue Sadi Carnot', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (28, N'آرکا ریل آذر', N'67 rue Beauvau', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (29, N'آرمان ترابر آریا', N'17 Chemin Challet', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (30, N'آرمان ترابر آریا', N'Askeladden 144', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (31, N'آريا آبي آرامش', N'35 rue Sadi Carnot', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (32, N'آریا ترابر ایرانیان', N'67 rue Beauvau', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (33, N'آریا ترابر ایرانیان', N'17 Chemin Challet', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (34, N'آریامس', N'97 rue de Penthièvre', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (35, N'آژان تجارت كاركیا', N'Bakeriveien 125', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (36, N'آسا ترابر شرق', N'35 rue Sadi Carnot', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (37, N'آسابرودت طوس', N'97 rue de Penthièvre', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (38, N'آسه بان', N'17 Chemin Challet', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (39, N'آلتون', N'San Carlos de Bariloche', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (40, N'آلوم رول نوين', N'97 rue de Penthièvre', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (41, N'آماد راین', N'17 Chemin Challet', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (42, N'آیسان بار', N'17 Chemin Challet', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (43, N'ا.بی.سی بست فریت', N'Bakeriveien 125', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (44, N'احسان خواجه زاده', N'San Carlos de Bariloche', NULL)
SET IDENTITY_INSERT [dbo].[Business] OFF
INSERT [dbo].[Customer] ([UserId], [Email]) VALUES (18, N'tayyebi@gmail.com')
INSERT [dbo].[Customer] ([UserId], [Email]) VALUES (19, N'kjdjklfj')
SET IDENTITY_INSERT [dbo].[Group] ON 

INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (2, N'Group 1', 29, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (3, N'Group 2', 7, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (4, N'Group 3', 11, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (5, N'Group 4', 27, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (6, N'Group 5', 44, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (7, N'Group 6', 28, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (8, N'Group 7', 28, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (9, N'Group 8', 15, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (10, N'Group 9', 17, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (11, N'Group 10', 30, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (12, N'Group 11', 16, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (13, N'Group 12', 10, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (14, N'Group 13', 31, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (15, N'Group 14', 7, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (16, N'Group 15', 42, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (17, N'Group 16', 31, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (18, N'Group 17', 18, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (19, N'Group 18', 44, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (20, N'Group 19', 35, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (21, N'Group 20', 19, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (22, N'Group 21', 30, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (23, N'Group 22', 20, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (24, N'Group 23', 15, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (25, N'Group 24', 7, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (26, N'Group 25', 6, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (27, N'Group 26', 16, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (28, N'Group 27', 20, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (29, N'Group 28', 40, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (30, N'Group 29', 25, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (31, N'Group 30', 5, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (32, N'Group 31', 44, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (33, N'Group 32', 27, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (34, N'Group 33', 38, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (35, N'Group 34', 11, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (36, N'Group 35', 17, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (37, N'Group 36', 34, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (38, N'Group 37', 31, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (39, N'Group 38', 24, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (40, N'Group 39', 37, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (41, N'Group 40', 11, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (42, N'Group 41', 22, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (43, N'Group 42', 19, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (44, N'Group 43', 35, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (45, N'Group 44', 9, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (46, N'Group 45', 15, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (47, N'Group 46', 20, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (48, N'Group 47', 44, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (49, N'Group 48', 22, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (50, N'Group 49', 5, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (51, N'Group 50', 5, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (52, N'Group 51', 30, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (53, N'Group 52', 21, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (54, N'Group 53', 15, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (55, N'Group 54', 12, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (56, N'Group 55', 19, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (57, N'Group 56', 9, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (58, N'Group 57', 32, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (59, N'Group 58', 34, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (60, N'Group 59', 39, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (61, N'Group 60', 38, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (62, N'Group 61', 20, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (63, N'Group 62', 38, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (64, N'Group 63', 5, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (65, N'Group 64', 16, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (66, N'Group 65', 30, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (67, N'Group 66', 38, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (68, N'Group 67', 17, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (69, N'Group 68', 14, NULL)
INSERT [dbo].[Group] ([Id], [Name], [BusinessId], [Image]) VALUES (70, N'Group 69', 37, NULL)
SET IDENTITY_INSERT [dbo].[Group] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (2, N'The company was founded as a result of what Amazon founder Jeff Bezos called his "regret minimization framework," which described his efforts to fend off any regrets for not participating sooner in the Internet business boom during that time.[13] In 1994, Bezos left his employment as vice-president of D. E. Shaw & Co., a Wall Street firm, and moved to Seattle, Washington. He began to work on a business plan[14] for what would eventually become Amazon.com.', CAST(5000.00 AS Decimal(18, 2)), CAST(505104.00 AS Decimal(12, 2)), N'Superlab', CAST(504104.00 AS Decimal(12, 2)), 2, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (3, N'On July 5, 1994, Bezos incorporated the company as Cadabra, Inc.[15] Bezos changed the name to Amazon.com, Inc. a few months later, after a lawyer misheard its original name as "cadaver".[16] In September 1994, Bezos purchased the URL Relentless.com and briefly considered naming his online store Relentless, but friends told him the name sounded a bit sinister. The domain is still owned by Bezos and still redirects to the retailer.[17][18] The company went online as Amazon.com in 1995.[19]', CAST(5000.00 AS Decimal(18, 2)), CAST(973233.00 AS Decimal(12, 2)), N'Truelux', CAST(963233.00 AS Decimal(12, 2)), 2, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (4, N'Bezos selected the name Amazon by looking through the dictionary; he settled on "Amazon" because it was a place that was "exotic and different", just as he had envisioned for his Internet enterprise. The Amazon River, he noted, was the biggest river in the world, and he planned to make his store the biggest in the world.[19] Bezos placed a premium on his head start in building a brand and told a reporter, "There''s nothing about our model that can''t be copied over time. But you know, McDonald''s got copied. And it still built a huge, multibillion-dollar company. A lot of it comes down to the brand name. Brand names are more important online than they are in the physical world."[20] Additionally, a name beginning with "A" was preferential due to the probability it would occur at the top of any list that was alphabetized.[citation needed]', CAST(5000.00 AS Decimal(18, 2)), CAST(354822.00 AS Decimal(12, 2)), N'Zone-Is', CAST(344822.00 AS Decimal(12, 2)), 2, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (5, N'After reading a report about the future of the Internet that projected annual Web commerce growth at 2,300%, Bezos created a list of 20 products that could be marketed online. He narrowed the list to what he felt were the five most promising products, which included: compact discs, computer hardware, computer software, videos, and books. Bezos finally decided that his new business would sell books online, due to the large worldwide demand for literature, the low price points for books, along with the huge number of titles available in print.[21] Amazon[22] was founded in the garage of Bezos'' home in Bellevue, Washington.[23]', CAST(5000.00 AS Decimal(18, 2)), CAST(117885.00 AS Decimal(12, 2)), N'Flexeco', CAST(107885.00 AS Decimal(12, 2)), 2, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (6, N'The company began as an online bookstore, which was an idea spurred off with a discussion with John Ingram of Ingram Book (now called Ingram Content Group), along with Keyur Patel who still holds a stake in Amazon.[24] Amazon was able to access books at wholesale from Ingram. In the first two months of business, Amazon sold to all 50 states and over 45 countries. Within two months, Amazon''s sales were up to $20,000/week.[25] While the largest brick and mortar bookstores and mail order catalogs might offer 200,000 titles, an online bookstore could "carry" several times more, since it would have a practically unlimited virtual (not actual) warehouse: those of the actual product makers/suppliers.[citation needed]', CAST(5000.00 AS Decimal(18, 2)), CAST(903640.00 AS Decimal(12, 2)), N'Sildom', CAST(893640.00 AS Decimal(12, 2)), 2, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (7, N'Amazon was incorporated in 1994 in Washington State. In July 1995, the company began service and sold its first book on Amazon.com: Douglas Hofstadter''s Fluid Concepts and Creative Analogies: Computer Models of the Fundamental Mechanisms of Thought.[26] In October 1995, the company announced itself to the public.[27] In 1996, it was reincorporated in Delaware. Amazon issued its initial public offering of stock on May 15, 1997, trading under the NASDAQ stock exchange symbol AMZN, at a price of US$18.00 per share ($1.50 after three stock splits in the late 1990s).[citation needed]', CAST(5000.00 AS Decimal(18, 2)), CAST(985893.00 AS Decimal(12, 2)), N'Xxx- Hotcom', CAST(975893.00 AS Decimal(12, 2)), 2, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (8, N'Barnes & Noble sued Amazon on May 12, 1997, alleging that Amazon''s claim to be "the world''s largest bookstore" was false because it "...isn''t a bookstore at all. It''s a book broker." The suit was later settled out of court and Amazon continued to make the same claim.[28] Walmart sued Amazon on October 16, 1998, alleging that Amazon had stolen Walmart''s trade secrets by hiring former Walmart executives. Although this suit was also settled out of court, it caused Amazon to implement internal restrictions and the reassignment of the former Walmart executives.[28]', CAST(5000.00 AS Decimal(18, 2)), CAST(160464.00 AS Decimal(12, 2)), N'Viahold', CAST(150464.00 AS Decimal(12, 2)), 2, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (9, N'Since June 19, 2000, Amazon''s logotype has featured a curved arrow leading from A to Z, representing that the company carries every product from A to Z, with the arrow shaped like a smile.[29]', CAST(5000.00 AS Decimal(18, 2)), CAST(519101.00 AS Decimal(12, 2)), N'Vivatop', CAST(509101.00 AS Decimal(12, 2)), 2, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (10, N'Amazon''s initial business plan was unusual; it did not expect to make a profit for four to five years. This "slow" growth caused stockholders to complain that the company was not reaching profitability fast enough to justify their investment or even survive in the long-term. When the dot-com bubble burst at the start of the 21st century and destroyed many e-companies in the process, Amazon survived and grew on past the tech crash to become a huge player in online sales. The company finally turned its first profit in the fourth quarter of 2001: $5 million (i.e., 1¢ per share), on revenues of more than $1 billion. This profit margin, though extremely modest, proved to skeptics that Bezos'' unconventional business model could succeed.[30] In 1999, Time magazine named Bezos the Person of the Year when it recognized the company''s success in popularizing online shopping.[citation needed]', CAST(5000.00 AS Decimal(18, 2)), CAST(541772.00 AS Decimal(12, 2)), N'Groove-Top', CAST(531772.00 AS Decimal(12, 2)), 2, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (11, N'In 2011, Amazon had 30,000 full-time employees in the USA, and by the end of 2016, it had 180,000 employees. The company employs 306,800 people worldwide in full and part-time jobs.[31]', CAST(5000.00 AS Decimal(18, 2)), CAST(838596.00 AS Decimal(12, 2)), N'Blue-Ex', CAST(828596.00 AS Decimal(12, 2)), 2, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (12, N'On October 11, 2016, Amazon announced plans to build convenience stores and develop curbside pickup locations for food.[32] In December 2016, the Amazon Go store was opened to Amazon employees in Seattle.[33] The store uses a variety of sensors and automatically charges a shopper''s Amazon account as they walk out of the store, eliminating the need for checkout lines.[34][35] The store is planned to open for the general public in early 2017', CAST(5000.00 AS Decimal(18, 2)), CAST(721161.00 AS Decimal(12, 2)), N'In Hatfind', CAST(711161.00 AS Decimal(12, 2)), 2, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (13, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(932789.00 AS Decimal(12, 2)), N'Domflex', CAST(922789.00 AS Decimal(12, 2)), 2, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (14, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(979067.00 AS Decimal(12, 2)), N'Sail Zumfix', CAST(969067.00 AS Decimal(12, 2)), 2, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (15, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(169520.00 AS Decimal(12, 2)), N'Gravefax', CAST(159520.00 AS Decimal(12, 2)), 2, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (16, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(166082.00 AS Decimal(12, 2)), N'Spanwarm', CAST(156082.00 AS Decimal(12, 2)), 16, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (17, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(716377.00 AS Decimal(12, 2)), N'Nim Top', CAST(706377.00 AS Decimal(12, 2)), 17, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (18, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(272547.00 AS Decimal(12, 2)), N'Tamptip', CAST(262547.00 AS Decimal(12, 2)), 18, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (19, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(691599.00 AS Decimal(12, 2)), N'It Saneco', CAST(681599.00 AS Decimal(12, 2)), 19, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (20, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(605872.00 AS Decimal(12, 2)), N'Math-It', CAST(595872.00 AS Decimal(12, 2)), 20, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (21, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(307920.00 AS Decimal(12, 2)), N'Aptip', CAST(297920.00 AS Decimal(12, 2)), 21, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (22, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(319369.00 AS Decimal(12, 2)), N'Tranhold', CAST(309369.00 AS Decimal(12, 2)), 22, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (23, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(285106.00 AS Decimal(12, 2)), N'Solotonron', CAST(275106.00 AS Decimal(12, 2)), 23, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (24, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(200667.00 AS Decimal(12, 2)), N'Strong Stock', CAST(190667.00 AS Decimal(12, 2)), 24, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (25, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(929422.00 AS Decimal(12, 2)), N'Vol Fresh', CAST(919422.00 AS Decimal(12, 2)), 25, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (26, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(838007.00 AS Decimal(12, 2)), N'Yearfind', CAST(828007.00 AS Decimal(12, 2)), 26, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (27, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(321029.00 AS Decimal(12, 2)), N'Trantouch', CAST(311029.00 AS Decimal(12, 2)), 27, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (28, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(428781.00 AS Decimal(12, 2)), N'Konlam', CAST(418781.00 AS Decimal(12, 2)), 28, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (29, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(569964.00 AS Decimal(12, 2)), N'Saltit', CAST(559964.00 AS Decimal(12, 2)), 29, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (30, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(244578.00 AS Decimal(12, 2)), N'New Cof', CAST(234578.00 AS Decimal(12, 2)), 30, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (31, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(921156.00 AS Decimal(12, 2)), N'Doncof', CAST(911156.00 AS Decimal(12, 2)), 31, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (32, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(466345.00 AS Decimal(12, 2)), N'Hot Zap', CAST(456345.00 AS Decimal(12, 2)), 32, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (33, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(689401.00 AS Decimal(12, 2)), N'Subsaotone', CAST(679401.00 AS Decimal(12, 2)), 33, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (34, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(101088.00 AS Decimal(12, 2)), N'Freenix', CAST(91088.00 AS Decimal(12, 2)), 34, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (35, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(965556.00 AS Decimal(12, 2)), N'Zontouch', CAST(955556.00 AS Decimal(12, 2)), 35, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (36, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(252873.00 AS Decimal(12, 2)), N'Quadex', CAST(242873.00 AS Decimal(12, 2)), 36, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (37, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(950957.00 AS Decimal(12, 2)), N'Med Tip', CAST(940957.00 AS Decimal(12, 2)), 37, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (38, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(904021.00 AS Decimal(12, 2)), N'Bamtrax', CAST(894021.00 AS Decimal(12, 2)), 38, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (39, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(518517.00 AS Decimal(12, 2)), N'U--Lam', CAST(508517.00 AS Decimal(12, 2)), 39, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (40, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(377160.00 AS Decimal(12, 2)), N'Trisit', CAST(367160.00 AS Decimal(12, 2)), 40, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (41, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(434349.00 AS Decimal(12, 2)), N'Hat-Lab', CAST(424349.00 AS Decimal(12, 2)), 41, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (42, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(250614.00 AS Decimal(12, 2)), N'Zumstock', CAST(240614.00 AS Decimal(12, 2)), 42, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (43, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(634735.00 AS Decimal(12, 2)), N'La Lex', CAST(624735.00 AS Decimal(12, 2)), 43, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (44, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(729402.00 AS Decimal(12, 2)), N'Zummadom', CAST(719402.00 AS Decimal(12, 2)), 44, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (45, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(273902.00 AS Decimal(12, 2)), N'Doning', CAST(263902.00 AS Decimal(12, 2)), 45, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (46, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(794278.00 AS Decimal(12, 2)), N'Stimit', CAST(784278.00 AS Decimal(12, 2)), 46, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (47, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(199950.00 AS Decimal(12, 2)), N'Zone Fix', CAST(189950.00 AS Decimal(12, 2)), 47, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (48, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(512426.00 AS Decimal(12, 2)), N'Y- Sonlam', CAST(502426.00 AS Decimal(12, 2)), 48, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (49, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(458930.00 AS Decimal(12, 2)), N'Open Tanzap', CAST(448930.00 AS Decimal(12, 2)), 49, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (50, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(347166.00 AS Decimal(12, 2)), N'Itfind', CAST(337166.00 AS Decimal(12, 2)), 50, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (51, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(117235.00 AS Decimal(12, 2)), N'Zumma In', CAST(107235.00 AS Decimal(12, 2)), 51, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (52, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(925536.00 AS Decimal(12, 2)), N'Whitedox', CAST(915536.00 AS Decimal(12, 2)), 52, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (53, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(299922.00 AS Decimal(12, 2)), N'Faxnix', CAST(289922.00 AS Decimal(12, 2)), 53, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (54, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(286836.00 AS Decimal(12, 2)), N'Zoo Tax', CAST(276836.00 AS Decimal(12, 2)), 54, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (55, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(460553.00 AS Decimal(12, 2)), N'Betais', CAST(450553.00 AS Decimal(12, 2)), 55, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (56, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(816366.00 AS Decimal(12, 2)), N'Geostock', CAST(806366.00 AS Decimal(12, 2)), 56, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (57, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(518068.00 AS Decimal(12, 2)), N'Tamp-Sing', CAST(508068.00 AS Decimal(12, 2)), 57, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (58, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(895891.00 AS Decimal(12, 2)), N'Medstock', CAST(885891.00 AS Decimal(12, 2)), 58, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (59, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(989390.00 AS Decimal(12, 2)), N'Air Fresh', CAST(979390.00 AS Decimal(12, 2)), 59, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (60, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(891104.00 AS Decimal(12, 2)), N'Tincore', CAST(881104.00 AS Decimal(12, 2)), 60, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (61, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(332175.00 AS Decimal(12, 2)), N'Warmstock', CAST(322175.00 AS Decimal(12, 2)), 61, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (62, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(691293.00 AS Decimal(12, 2)), N'Stronglight', CAST(681293.00 AS Decimal(12, 2)), 62, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (63, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(189296.00 AS Decimal(12, 2)), N'Quoeco', CAST(179296.00 AS Decimal(12, 2)), 63, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (64, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(756573.00 AS Decimal(12, 2)), N'Movebam', CAST(746573.00 AS Decimal(12, 2)), 64, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (65, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(652809.00 AS Decimal(12, 2)), N'Voyawarm', CAST(642809.00 AS Decimal(12, 2)), 65, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (66, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(125001.00 AS Decimal(12, 2)), N'Qvo Tonit', CAST(115001.00 AS Decimal(12, 2)), 66, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (67, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(273132.00 AS Decimal(12, 2)), N'Goldenhold', CAST(263132.00 AS Decimal(12, 2)), 67, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (68, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(953171.00 AS Decimal(12, 2)), N'Geo Kix', CAST(943171.00 AS Decimal(12, 2)), 68, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (69, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(365028.00 AS Decimal(12, 2)), N'Subtraxdom', CAST(355028.00 AS Decimal(12, 2)), 69, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (70, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(565014.00 AS Decimal(12, 2)), N'Ransoft', CAST(555014.00 AS Decimal(12, 2)), 70, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (71, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(744978.00 AS Decimal(12, 2)), N'Gravetom', CAST(734978.00 AS Decimal(12, 2)), 2, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (72, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(881740.00 AS Decimal(12, 2)), N'Lotqvolex', CAST(871740.00 AS Decimal(12, 2)), 3, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (73, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(751282.00 AS Decimal(12, 2)), N'Lam-Eco', CAST(741282.00 AS Decimal(12, 2)), 4, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (74, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(732797.00 AS Decimal(12, 2)), N'Goldtop', CAST(722797.00 AS Decimal(12, 2)), 5, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (75, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(411779.00 AS Decimal(12, 2)), N'Stat Lax', CAST(401779.00 AS Decimal(12, 2)), 6, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (76, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(359043.00 AS Decimal(12, 2)), N'Fun Lax', CAST(349043.00 AS Decimal(12, 2)), 7, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (77, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(261643.00 AS Decimal(12, 2)), N'Zumtone', CAST(251643.00 AS Decimal(12, 2)), 8, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (78, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(861947.00 AS Decimal(12, 2)), N'Itsoft', CAST(851947.00 AS Decimal(12, 2)), 9, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (79, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(713921.00 AS Decimal(12, 2)), N'Gravezap', CAST(703921.00 AS Decimal(12, 2)), 10, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (80, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(116582.00 AS Decimal(12, 2)), N'Villafix', CAST(106582.00 AS Decimal(12, 2)), 11, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (81, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(726192.00 AS Decimal(12, 2)), N'Funtop', CAST(716192.00 AS Decimal(12, 2)), 12, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (82, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(469090.00 AS Decimal(12, 2)), N'Anphase', CAST(459090.00 AS Decimal(12, 2)), 13, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (83, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(605420.00 AS Decimal(12, 2)), N'Movedex', CAST(595420.00 AS Decimal(12, 2)), 14, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (84, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(669369.00 AS Decimal(12, 2)), N'Latdom', CAST(659369.00 AS Decimal(12, 2)), 15, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (85, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(905779.00 AS Decimal(12, 2)), N'Vilatraxfan', CAST(895779.00 AS Decimal(12, 2)), 16, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (86, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(256667.00 AS Decimal(12, 2)), N'Tam-Tam', CAST(246667.00 AS Decimal(12, 2)), 17, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (87, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(152587.00 AS Decimal(12, 2)), N'Uno-Fresh', CAST(142587.00 AS Decimal(12, 2)), 18, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (88, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(631289.00 AS Decimal(12, 2)), N'Vol Redplus', CAST(621289.00 AS Decimal(12, 2)), 19, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (89, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(874601.00 AS Decimal(12, 2)), N'Sol Ozehold', CAST(864601.00 AS Decimal(12, 2)), 20, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (90, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(265321.00 AS Decimal(12, 2)), N'Tamstrong', CAST(255321.00 AS Decimal(12, 2)), 21, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (91, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(387328.00 AS Decimal(12, 2)), N'Hat Home', CAST(377328.00 AS Decimal(12, 2)), 22, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (92, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(886105.00 AS Decimal(12, 2)), N'Vilalab', CAST(876105.00 AS Decimal(12, 2)), 23, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (93, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(376687.00 AS Decimal(12, 2)), N'Zummatrax', CAST(366687.00 AS Decimal(12, 2)), 24, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (94, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(403671.00 AS Decimal(12, 2)), N'Bamkix', CAST(393671.00 AS Decimal(12, 2)), 25, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (95, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(788551.00 AS Decimal(12, 2)), N'Move Hotphase', CAST(778551.00 AS Decimal(12, 2)), 26, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (96, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(987893.00 AS Decimal(12, 2)), N'Sunphase', CAST(977893.00 AS Decimal(12, 2)), 27, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (97, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(879442.00 AS Decimal(12, 2)), N'Jaystock', CAST(869442.00 AS Decimal(12, 2)), 28, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (98, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(393476.00 AS Decimal(12, 2)), N'Spanfind', CAST(383476.00 AS Decimal(12, 2)), 29, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (99, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(707838.00 AS Decimal(12, 2)), N'Faxla', CAST(697838.00 AS Decimal(12, 2)), 30, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (100, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(827006.00 AS Decimal(12, 2)), N'Lam Tanplus', CAST(817006.00 AS Decimal(12, 2)), 31, NULL)
GO
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (101, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(691183.00 AS Decimal(12, 2)), N'Air Is', CAST(681183.00 AS Decimal(12, 2)), 32, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (102, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(129800.00 AS Decimal(12, 2)), N'Opestock', CAST(119800.00 AS Decimal(12, 2)), 33, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (103, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(218637.00 AS Decimal(12, 2)), N'Dannix', CAST(208637.00 AS Decimal(12, 2)), 34, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (104, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(864921.00 AS Decimal(12, 2)), N'Ishome', CAST(854921.00 AS Decimal(12, 2)), 35, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (105, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(468313.00 AS Decimal(12, 2)), N'Homenix', CAST(458313.00 AS Decimal(12, 2)), 36, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (106, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(701908.00 AS Decimal(12, 2)), N'Ronhold', CAST(691908.00 AS Decimal(12, 2)), 37, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (107, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(409011.00 AS Decimal(12, 2)), N'Solocom', CAST(399011.00 AS Decimal(12, 2)), 38, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (108, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(108325.00 AS Decimal(12, 2)), N'Namtrax', CAST(98325.00 AS Decimal(12, 2)), 39, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (109, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(618175.00 AS Decimal(12, 2)), N'Top-Top', CAST(608175.00 AS Decimal(12, 2)), 40, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (110, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(305384.00 AS Decimal(12, 2)), N'Cof-Eco', CAST(295384.00 AS Decimal(12, 2)), 41, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (111, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(524788.00 AS Decimal(12, 2)), N'Coftax', CAST(514788.00 AS Decimal(12, 2)), 42, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (112, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(740096.00 AS Decimal(12, 2)), N'Geotam', CAST(730096.00 AS Decimal(12, 2)), 43, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (113, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(472811.00 AS Decimal(12, 2)), N'Zen-Nix', CAST(462811.00 AS Decimal(12, 2)), 44, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (114, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(525951.00 AS Decimal(12, 2)), N'Trisair', CAST(515951.00 AS Decimal(12, 2)), 45, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (115, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(521365.00 AS Decimal(12, 2)), N'Danwarm', CAST(511365.00 AS Decimal(12, 2)), 46, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (116, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(219194.00 AS Decimal(12, 2)), N'Temp Sanhome', CAST(209194.00 AS Decimal(12, 2)), 47, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (117, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(816764.00 AS Decimal(12, 2)), N'Dongkaydom', CAST(806764.00 AS Decimal(12, 2)), 48, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (118, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(490576.00 AS Decimal(12, 2)), N'Nim-Tex', CAST(480576.00 AS Decimal(12, 2)), 49, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (119, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(484394.00 AS Decimal(12, 2)), N'Zummatough', CAST(474394.00 AS Decimal(12, 2)), 50, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (120, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(626741.00 AS Decimal(12, 2)), N'Kin Phase', CAST(616741.00 AS Decimal(12, 2)), 51, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (121, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(370190.00 AS Decimal(12, 2)), N'Movezimjob', CAST(360190.00 AS Decimal(12, 2)), 52, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (122, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(251563.00 AS Decimal(12, 2)), N'Opeflex', CAST(241563.00 AS Decimal(12, 2)), 53, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (123, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(856874.00 AS Decimal(12, 2)), N'Qvo Sillab', CAST(846874.00 AS Decimal(12, 2)), 54, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (124, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(846404.00 AS Decimal(12, 2)), N'Damfresh', CAST(836404.00 AS Decimal(12, 2)), 55, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (125, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(150904.00 AS Decimal(12, 2)), N'Indigo String', CAST(140904.00 AS Decimal(12, 2)), 56, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (126, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(462564.00 AS Decimal(12, 2)), N'Spantough', CAST(452564.00 AS Decimal(12, 2)), 57, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (127, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(880428.00 AS Decimal(12, 2)), N'Drip-Trax', CAST(870428.00 AS Decimal(12, 2)), 58, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (128, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(594880.00 AS Decimal(12, 2)), N'Light Dantam', CAST(584880.00 AS Decimal(12, 2)), 59, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (129, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(585506.00 AS Decimal(12, 2)), N'Renix', CAST(575506.00 AS Decimal(12, 2)), 60, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (130, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(454810.00 AS Decimal(12, 2)), N'Dongtough', CAST(444810.00 AS Decimal(12, 2)), 61, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (131, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(706466.00 AS Decimal(12, 2)), N'Stanfind', CAST(696466.00 AS Decimal(12, 2)), 62, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (132, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(719377.00 AS Decimal(12, 2)), N'Zumma Runcof', CAST(709377.00 AS Decimal(12, 2)), 63, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (133, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(284251.00 AS Decimal(12, 2)), N'Singlelux', CAST(274251.00 AS Decimal(12, 2)), 64, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (134, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(960860.00 AS Decimal(12, 2)), N'Goodgoin', CAST(950860.00 AS Decimal(12, 2)), 65, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (135, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(846750.00 AS Decimal(12, 2)), N'Unatough', CAST(836750.00 AS Decimal(12, 2)), 66, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (136, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(493230.00 AS Decimal(12, 2)), N'Zumsoft', CAST(483230.00 AS Decimal(12, 2)), 67, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (137, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(402034.00 AS Decimal(12, 2)), N'Holdlex', CAST(392034.00 AS Decimal(12, 2)), 68, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (138, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(688390.00 AS Decimal(12, 2)), N'Move-Ex', CAST(678390.00 AS Decimal(12, 2)), 69, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (139, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(585929.00 AS Decimal(12, 2)), N'Fixla', CAST(575929.00 AS Decimal(12, 2)), 70, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (140, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(370422.00 AS Decimal(12, 2)), N'Statdax', CAST(360422.00 AS Decimal(12, 2)), 2, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (141, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(117931.00 AS Decimal(12, 2)), N'Tonis', CAST(107931.00 AS Decimal(12, 2)), 3, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (142, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(145166.00 AS Decimal(12, 2)), N'Soft Light', CAST(135166.00 AS Decimal(12, 2)), 4, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (143, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(674131.00 AS Decimal(12, 2)), N'Zotdox', CAST(664131.00 AS Decimal(12, 2)), 5, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (144, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(624248.00 AS Decimal(12, 2)), N'Rejob', CAST(614248.00 AS Decimal(12, 2)), 6, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (145, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(716513.00 AS Decimal(12, 2)), N'Phystex', CAST(706513.00 AS Decimal(12, 2)), 7, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (146, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(697881.00 AS Decimal(12, 2)), N'Job Mattax', CAST(687881.00 AS Decimal(12, 2)), 8, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (147, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(968433.00 AS Decimal(12, 2)), N'Toning', CAST(958433.00 AS Decimal(12, 2)), 9, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (148, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(427450.00 AS Decimal(12, 2)), N'Bigphase', CAST(417450.00 AS Decimal(12, 2)), 10, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (149, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(187685.00 AS Decimal(12, 2)), N'Dantax', CAST(177685.00 AS Decimal(12, 2)), 11, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (150, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(108782.00 AS Decimal(12, 2)), N'Statfan', CAST(98782.00 AS Decimal(12, 2)), 12, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (151, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(607791.00 AS Decimal(12, 2)), N'Flexfax', CAST(597791.00 AS Decimal(12, 2)), 13, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (152, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(464610.00 AS Decimal(12, 2)), N'Zun Lax', CAST(454610.00 AS Decimal(12, 2)), 14, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (153, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(505808.00 AS Decimal(12, 2)), N'It Ozetone', CAST(495808.00 AS Decimal(12, 2)), 15, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (154, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(585598.00 AS Decimal(12, 2)), N'Ozerdom', CAST(575598.00 AS Decimal(12, 2)), 16, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (155, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(646400.00 AS Decimal(12, 2)), N'Uni-Sing', CAST(636400.00 AS Decimal(12, 2)), 17, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (156, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(740799.00 AS Decimal(12, 2)), N'Warmhome', CAST(730799.00 AS Decimal(12, 2)), 18, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (157, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(625101.00 AS Decimal(12, 2)), N'Touch Lattop', CAST(615101.00 AS Decimal(12, 2)), 19, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (158, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(595126.00 AS Decimal(12, 2)), N'Nimsoft', CAST(585126.00 AS Decimal(12, 2)), 20, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (159, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(126721.00 AS Decimal(12, 2)), N'Touch Touch', CAST(116721.00 AS Decimal(12, 2)), 21, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (160, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(907262.00 AS Decimal(12, 2)), N'Hay Tom', CAST(897262.00 AS Decimal(12, 2)), 22, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (161, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(212352.00 AS Decimal(12, 2)), N'Zootouch', CAST(202352.00 AS Decimal(12, 2)), 23, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (162, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(345268.00 AS Decimal(12, 2)), N'Faselab', CAST(335268.00 AS Decimal(12, 2)), 24, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (163, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(972054.00 AS Decimal(12, 2)), N'Fun Ron', CAST(962054.00 AS Decimal(12, 2)), 25, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (164, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(594316.00 AS Decimal(12, 2)), N'Driptex', CAST(584316.00 AS Decimal(12, 2)), 26, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (165, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(109448.00 AS Decimal(12, 2)), N'Qvocore', CAST(99448.00 AS Decimal(12, 2)), 27, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (166, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(377233.00 AS Decimal(12, 2)), N'Greenkix', CAST(367233.00 AS Decimal(12, 2)), 28, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (167, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(486208.00 AS Decimal(12, 2)), N'Xxx-flex', CAST(476208.00 AS Decimal(12, 2)), 29, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (168, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(784639.00 AS Decimal(12, 2)), N'Airsailhold', CAST(774639.00 AS Decimal(12, 2)), 30, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (169, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(462827.00 AS Decimal(12, 2)), N'Jobron', CAST(452827.00 AS Decimal(12, 2)), 31, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (170, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(855411.00 AS Decimal(12, 2)), N'Voyahome', CAST(845411.00 AS Decimal(12, 2)), 32, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (171, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(267250.00 AS Decimal(12, 2)), N'Medis', CAST(257250.00 AS Decimal(12, 2)), 33, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (172, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(426968.00 AS Decimal(12, 2)), N'Matdantip', CAST(416968.00 AS Decimal(12, 2)), 34, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (173, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(312687.00 AS Decimal(12, 2)), N'Zum-Lux', CAST(302687.00 AS Decimal(12, 2)), 35, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (174, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(548717.00 AS Decimal(12, 2)), N'Physhold', CAST(538717.00 AS Decimal(12, 2)), 36, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (175, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(444784.00 AS Decimal(12, 2)), N'Betagohome', CAST(434784.00 AS Decimal(12, 2)), 37, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (176, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(934978.00 AS Decimal(12, 2)), N'Hay-Lab', CAST(924978.00 AS Decimal(12, 2)), 38, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (177, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(315729.00 AS Decimal(12, 2)), N'Dentozap', CAST(305729.00 AS Decimal(12, 2)), 39, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (178, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(217603.00 AS Decimal(12, 2)), N'Zenwarm', CAST(207603.00 AS Decimal(12, 2)), 40, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (179, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(351266.00 AS Decimal(12, 2)), N'Math Touch', CAST(341266.00 AS Decimal(12, 2)), 41, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (180, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(700976.00 AS Decimal(12, 2)), N'Tan-Lex', CAST(690976.00 AS Decimal(12, 2)), 42, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (181, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(410394.00 AS Decimal(12, 2)), N'Tanstring', CAST(400394.00 AS Decimal(12, 2)), 43, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (182, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(804505.00 AS Decimal(12, 2)), N'Tripplein', CAST(794505.00 AS Decimal(12, 2)), 44, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (183, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(487830.00 AS Decimal(12, 2)), N'Indigo Lab', CAST(477830.00 AS Decimal(12, 2)), 45, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (184, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(266334.00 AS Decimal(12, 2)), N'Goldening', CAST(256334.00 AS Decimal(12, 2)), 46, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (185, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(673495.00 AS Decimal(12, 2)), N'Redfresh', CAST(663495.00 AS Decimal(12, 2)), 47, NULL)
INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (186, N'', CAST(5000.00 AS Decimal(18, 2)), CAST(854089.00 AS Decimal(12, 2)), N'Kintax', CAST(844089.00 AS Decimal(12, 2)), 48, NULL)
SET IDENTITY_INSERT [dbo].[Product] OFF
INSERT [dbo].[Seller] ([UserId], [NationalCode], [StoreId]) VALUES (33, N'3545669872', 2)
INSERT [dbo].[Seller] ([UserId], [NationalCode], [StoreId]) VALUES (34, N'3545669873', 3)
INSERT [dbo].[Seller] ([UserId], [NationalCode], [StoreId]) VALUES (35, N'3545669874', 4)
INSERT [dbo].[Seller] ([UserId], [NationalCode], [StoreId]) VALUES (36, N'3545669875', 5)
INSERT [dbo].[Seller] ([UserId], [NationalCode], [StoreId]) VALUES (37, N'3545669876', 6)
INSERT [dbo].[Seller] ([UserId], [NationalCode], [StoreId]) VALUES (38, N'3545669877', 7)
INSERT [dbo].[Seller] ([UserId], [NationalCode], [StoreId]) VALUES (39, N'3545669878', 8)
INSERT [dbo].[Seller] ([UserId], [NationalCode], [StoreId]) VALUES (40, N'3545669879', 9)
INSERT [dbo].[Seller] ([UserId], [NationalCode], [StoreId]) VALUES (41, N'3545669880', 10)
INSERT [dbo].[Seller] ([UserId], [NationalCode], [StoreId]) VALUES (42, N'3545669881', 11)
SET IDENTITY_INSERT [dbo].[Store] ON 

INSERT [dbo].[Store] ([Id], [Name], [Latitude], [Longitude], [Address], [Logo], [BankAccount]) VALUES (2, N'Zina Bergfeld', NULL, CAST(24.250000 AS Decimal(15, 6)), N'13.75', NULL, NULL)
INSERT [dbo].[Store] ([Id], [Name], [Latitude], [Longitude], [Address], [Logo], [BankAccount]) VALUES (3, N'Melvin Myler', NULL, CAST(24.310000 AS Decimal(15, 6)), N'13.91', NULL, NULL)
INSERT [dbo].[Store] ([Id], [Name], [Latitude], [Longitude], [Address], [Logo], [BankAccount]) VALUES (4, N'Miguel Leiser', NULL, CAST(24.370000 AS Decimal(15, 6)), N'14.07', NULL, NULL)
INSERT [dbo].[Store] ([Id], [Name], [Latitude], [Longitude], [Address], [Logo], [BankAccount]) VALUES (5, N'Diego Montalbano', NULL, CAST(24.430000 AS Decimal(15, 6)), N'14.23', NULL, NULL)
INSERT [dbo].[Store] ([Id], [Name], [Latitude], [Longitude], [Address], [Logo], [BankAccount]) VALUES (6, N'Riley Subia', NULL, CAST(24.490000 AS Decimal(15, 6)), N'14.39', NULL, NULL)
INSERT [dbo].[Store] ([Id], [Name], [Latitude], [Longitude], [Address], [Logo], [BankAccount]) VALUES (7, N'Loralee Lorentzen', NULL, CAST(24.550000 AS Decimal(15, 6)), N'14.55', NULL, NULL)
INSERT [dbo].[Store] ([Id], [Name], [Latitude], [Longitude], [Address], [Logo], [BankAccount]) VALUES (8, N'Martin Llanes', NULL, CAST(24.610000 AS Decimal(15, 6)), N'14.71', NULL, NULL)
INSERT [dbo].[Store] ([Id], [Name], [Latitude], [Longitude], [Address], [Logo], [BankAccount]) VALUES (9, N'Magan Mccloskey', NULL, CAST(24.670000 AS Decimal(15, 6)), N'14.87', NULL, NULL)
INSERT [dbo].[Store] ([Id], [Name], [Latitude], [Longitude], [Address], [Logo], [BankAccount]) VALUES (10, N'Mildred Via', NULL, CAST(24.730000 AS Decimal(15, 6)), N'15.03', NULL, NULL)
INSERT [dbo].[Store] ([Id], [Name], [Latitude], [Longitude], [Address], [Logo], [BankAccount]) VALUES (11, N'Venice Bishop', NULL, CAST(24.790000 AS Decimal(15, 6)), N'15.19', NULL, NULL)
INSERT [dbo].[Store] ([Id], [Name], [Latitude], [Longitude], [Address], [Logo], [BankAccount]) VALUES (12, N'Sue Fisch', NULL, CAST(24.850000 AS Decimal(15, 6)), N'15.35', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Store] OFF
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'ANDERSON', N'iloveyou')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'BROWN', N'soccer')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'DAVIS', N'harley')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'GARCIA', N'ranger')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'HARRIS', N'robert')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'JACKSON', N'zxcvbnm')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'JOHNSON', N'asdfgh')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'JONES', N'buster')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'MARTIN', N'thomas')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'MARTINEZ', N'daniel')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'MILLER', N'batman')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'MOORE', N'tigger')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'ROBINSON', N'starwars')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'SMITH', N'klaster')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'TAYLOR', N'sunshine')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'THOMAS', N'hime')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'THOMPSON', N'hockey')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'WHITE', N'charlie')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'WILLIAMS', N'hunter')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'WILSON', N'andrew')
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (18, N'09388063351', N'Customer', 8171, N'MohamRe')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (19, N'09365857579', N'Customer', 8865, N' ')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (20, N'09365857579', N'Customer', 4223, N'465')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (21, N'9365857580', N'Customer', 4749, N'Jacob Lindblad')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (22, N'9365857581', N'Customer', 2081, N'Natalie Tigue')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (23, N'9365857582', N'Customer', 6339, N'Pattie Shepherd')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (24, N'9365857583', N'Customer', 1380, N'Marni Huth')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (25, N'9365857584', N'Customer', 4314, N'Freddie Dunkelberger')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (26, N'9365857585', N'Customer', 4050, N'Maximo Soderstrom')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (27, N'9365857586', N'Customer', 9786, N'Cordell Mcgovern')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (28, N'9365857587', N'Customer', 8822, N'Analisa Hawkes')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (29, N'9365857588', N'Customer', 2267, N'Norine Smits')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (30, N'9365857589', N'Customer', 4949, N'Brain Stanger')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (31, N'9365857590', N'Customer', 7050, N'Lillia Lohmann')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (32, N'9365857591', N'Seller', 4714, N'Neil Courtney')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (33, N'9365857592', N'Seller', 9184, N'Vernice Parm')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (34, N'9365857593', N'Seller', 2989, N'Alva Yost')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (35, N'9365857594', N'Seller', 6330, N'Enriqueta Auld')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (36, N'9365857595', N'Seller', 8810, N'Cathryn Burner')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (37, N'9365857596', N'Seller', 7423, N'Cathleen Autrey')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (38, N'9365857597', N'Seller', 4887, N'Maia Bookman')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (39, N'9365857598', N'Seller', 1586, N'Marilyn Pablo')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (40, N'9365857599', N'Seller', 8206, N'Carry Croft')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (41, N'9365857600', N'Seller', 6443, N'Clare Mitton')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (42, N'9365857601', N'Seller', 9794, N'Mira Fucci')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (43, N'9365857602', N'Marketer', 6480, N'Ingeborg Christopherso')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (44, N'9365857603', N'Marketer', 6608, N'Hiram Garmany')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (45, N'9365857604', N'Marketer', 1447, N'Sheri Bolton')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (46, N'9365857605', N'Marketer', 3781, N'Gladis Gridley')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (47, N'9365857606', N'Marketer', 3564, N'Kyla Stidham')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (48, N'9365857607', N'Marketer', 6903, N'Hoa Guzik')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (49, N'9365857608', N'Marketer', 6694, N'Alesia Moshier')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (50, N'9365857609', N'Marketer', 9361, N'Francesca Leak')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (51, N'9365857610', N'Marketer', 4140, N'Shelley Salisbury')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (52, N'9365857611', N'Marketer', 7513, N'Laree Arbour')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (53, N'9365857612', N'Marketer', 6760, N'Margarita Lima')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (54, N'9365857613', N'Marketer', 6224, N'Stephan Klocke')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (55, N'9365857614', N'Marketer', 1294, N'Claudine Coles')
SET IDENTITY_INSERT [dbo].[User] OFF
ALTER TABLE [dbo].[ProductTransfer] ADD  CONSTRAINT [DF_ProductTransfer_Barcode]  DEFAULT (substring(replace(CONVERT([varchar](36),newid()),'-',''),(0),(17))) FOR [Barcode]
GO
ALTER TABLE [dbo].[Associtation_TransactionProduct]  WITH CHECK ADD  CONSTRAINT [FK_Associtation_TransactionProduct_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Associtation_TransactionProduct] CHECK CONSTRAINT [FK_Associtation_TransactionProduct_Product]
GO
ALTER TABLE [dbo].[Associtation_TransactionProduct]  WITH CHECK ADD  CONSTRAINT [FK_Associtation_TransactionProduct_Transaction1] FOREIGN KEY([TransactionId])
REFERENCES [dbo].[Transaction] ([Id])
GO
ALTER TABLE [dbo].[Associtation_TransactionProduct] CHECK CONSTRAINT [FK_Associtation_TransactionProduct_Transaction1]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_User]
GO
ALTER TABLE [dbo].[Group]  WITH CHECK ADD  CONSTRAINT [FK_Group_Business] FOREIGN KEY([BusinessId])
REFERENCES [dbo].[Business] ([Id])
GO
ALTER TABLE [dbo].[Group] CHECK CONSTRAINT [FK_Group_Business]
GO
ALTER TABLE [dbo].[Marketer]  WITH CHECK ADD  CONSTRAINT [FK_Marketer_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Marketer] CHECK CONSTRAINT [FK_Marketer_User]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Group] FOREIGN KEY([GroupId])
REFERENCES [dbo].[Group] ([Id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Group]
GO
ALTER TABLE [dbo].[ProductTransfer]  WITH CHECK ADD  CONSTRAINT [FK_ProductTransfer_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[ProductTransfer] CHECK CONSTRAINT [FK_ProductTransfer_Product]
GO
ALTER TABLE [dbo].[ProductTransfer]  WITH CHECK ADD  CONSTRAINT [FK_ProductTransfer_Store] FOREIGN KEY([StoreId])
REFERENCES [dbo].[Store] ([Id])
GO
ALTER TABLE [dbo].[ProductTransfer] CHECK CONSTRAINT [FK_ProductTransfer_Store]
GO
ALTER TABLE [dbo].[Seller]  WITH CHECK ADD  CONSTRAINT [FK_Seller_Store] FOREIGN KEY([StoreId])
REFERENCES [dbo].[Store] ([Id])
GO
ALTER TABLE [dbo].[Seller] CHECK CONSTRAINT [FK_Seller_Store]
GO
ALTER TABLE [dbo].[Seller]  WITH CHECK ADD  CONSTRAINT [FK_Seller_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Seller] CHECK CONSTRAINT [FK_Seller_User]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_User] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([UserId])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_User]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "User"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 215
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customer"
            Begin Extent = 
               Top = 4
               Left = 365
               Bottom = 100
               Right = 535
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Transaction"
            Begin Extent = 
               Top = 38
               Left = 672
               Bottom = 168
               Right = 842
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Seller"
            Begin Extent = 
               Top = 105
               Left = 260
               Bottom = 235
               Right = 430
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_Factors'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_Factors'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_Factors'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Product"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductTransfer"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ProductDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ProductDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Group"
            Begin Extent = 
               Top = 52
               Left = 404
               Bottom = 182
               Right = 574
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Business"
            Begin Extent = 
               Top = 6
               Left = 662
               Bottom = 136
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Product"
            Begin Extent = 
               Top = 50
               Left = 194
               Bottom = 180
               Right = 364
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductTransfer"
            Begin Extent = 
               Top = 56
               Left = 0
               Bottom = 186
               Right = 170
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 22
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Co' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ProductSearch'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'lumn = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ProductSearch'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ProductSearch'
GO
USE [master]
GO
ALTER DATABASE [Andycabar] SET  READ_WRITE 
GO
