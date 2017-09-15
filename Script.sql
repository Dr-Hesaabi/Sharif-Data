USE [master]
GO
/****** Object:  Database [Andycabar]    Script Date: 9/15/2017 2:25:02 PM ******/
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
/****** Object:  Table [dbo].[Product]    Script Date: 9/15/2017 2:25:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[ProductTransfer]    Script Date: 9/15/2017 2:25:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
 CONSTRAINT [PK_ProductTransfer] PRIMARY KEY CLUSTERED 
(
	[Barcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[v_ProductDetails]    Script Date: 9/15/2017 2:25:03 PM ******/
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
/****** Object:  Table [dbo].[Seller]    Script Date: 9/15/2017 2:25:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seller](
	[UserId] [int] NOT NULL,
	[NationalCode] [int] NOT NULL,
	[StoreId] [int] NOT NULL,
 CONSTRAINT [PK_Seller] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 9/15/2017 2:25:03 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 9/15/2017 2:25:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[Transaction]    Script Date: 9/15/2017 2:25:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](12, 2) NOT NULL,
	[Submit] [datetime] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[SellerId] [int] NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[v_Factors]    Script Date: 9/15/2017 2:25:03 PM ******/
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
/****** Object:  Table [dbo].[Business]    Script Date: 9/15/2017 2:25:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[Group]    Script Date: 9/15/2017 2:25:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Image] [varbinary](max) NULL,
	[BusinessId] [int] NOT NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[v_ProductSearch]    Script Date: 9/15/2017 2:25:03 PM ******/
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
/****** Object:  Table [dbo].[Associtation_TransactionProduct]    Script Date: 9/15/2017 2:25:03 PM ******/
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
/****** Object:  Table [dbo].[Marketer]    Script Date: 9/15/2017 2:25:03 PM ******/
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
/****** Object:  Table [dbo].[SalesOfficer]    Script Date: 9/15/2017 2:25:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesOfficer](
	[UserId] [int] NOT NULL,
	[NationalCode] [varchar](50) NOT NULL,
	[BusinessId] [int] NOT NULL,
 CONSTRAINT [PK_SalesOfficer] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Store]    Script Date: 9/15/2017 2:25:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[Id] [int] NOT NULL,
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
/****** Object:  Table [dbo].[SystemOprator]    Script Date: 9/15/2017 2:25:03 PM ******/
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
SET IDENTITY_INSERT [dbo].[Associtation_TransactionProduct] ON 

INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (1, 1, 9)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (3, 1, 9)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (4, 1, 9)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (5, 1, 9)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (6, 1, 9)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (7, 1, 9)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (8, 1, 9)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (9, 1, 9)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (10, 1, 9)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (11, 1, 9)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (12, 1, 9)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (13, 1, 9)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (14, 1, 9)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (15, 1, 9)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (16, 1, 10)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (17, 1, 10)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (18, 1, 10)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (19, 1, 10)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (20, 1, 10)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (21, 1, 10)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (22, 1, 10)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (23, 1, 10)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (24, 1, 10)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (25, 1, 10)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (26, 1, 10)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (27, 1, 10)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (28, 1, 10)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (29, 1, 11)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (30, 1, 11)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (31, 1, 11)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (32, 1, 11)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (33, 1, 11)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (34, 1, 11)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (35, 1, 11)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (36, 1, 11)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (37, 1, 11)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (38, 1, 11)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (39, 1, 11)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (40, 1, 11)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (41, 1, 11)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (42, 1, 12)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (43, 1, 12)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (44, 1, 12)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (45, 1, 12)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (46, 1, 12)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (47, 1, 12)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (48, 1, 12)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (49, 1, 12)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (50, 1, 12)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (51, 1, 12)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (52, 1, 12)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (53, 1, 12)
INSERT [dbo].[Associtation_TransactionProduct] ([Id], [ProductId], [TransactionId]) VALUES (54, 1, 12)
SET IDENTITY_INSERT [dbo].[Associtation_TransactionProduct] OFF
SET IDENTITY_INSERT [dbo].[Business] ON 

INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (1, N'Name1', N'Address1', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (2, N'reza rezaei', N'Tehran Address', NULL)
INSERT [dbo].[Business] ([Id], [Name], [Address], [Logo]) VALUES (3, N'Nima Heidari', N'Hamedan Address', NULL)
SET IDENTITY_INSERT [dbo].[Business] OFF
INSERT [dbo].[Customer] ([UserId], [Email]) VALUES (2, N'cus.ali@gmail.com')
INSERT [dbo].[Customer] ([UserId], [Email]) VALUES (6, N'ALIZADE@gmail.com')
INSERT [dbo].[Customer] ([UserId], [Email]) VALUES (13, N'abasali@yahoo.com')
INSERT [dbo].[Customer] ([UserId], [Email]) VALUES (15, N'khalghi75@gmail.com')
SET IDENTITY_INSERT [dbo].[Group] ON 

INSERT [dbo].[Group] ([Id], [Name], [Image], [BusinessId]) VALUES (1, N'ali', NULL, 1)
INSERT [dbo].[Group] ([Id], [Name], [Image], [BusinessId]) VALUES (2, N'reza', NULL, 2)
INSERT [dbo].[Group] ([Id], [Name], [Image], [BusinessId]) VALUES (3, N'akbar', NULL, 3)
SET IDENTITY_INSERT [dbo].[Group] OFF
INSERT [dbo].[Marketer] ([UserId], [NationalCode]) VALUES (4, N'1234567891')
INSERT [dbo].[Marketer] ([UserId], [NationalCode]) VALUES (9, N'8888888888')
INSERT [dbo].[Marketer] ([UserId], [NationalCode]) VALUES (14, N'6546546545')
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([Id], [Description], [Profit], [SalePrice], [DetailedName], [CompanyCost], [GroupId], [Image]) VALUES (1, N'10', CAST(-78.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(12, 2)), N'MMM', CAST(12.00 AS Decimal(12, 2)), 3, NULL)
SET IDENTITY_INSERT [dbo].[Product] OFF
INSERT [dbo].[SalesOfficer] ([UserId], [NationalCode], [BusinessId]) VALUES (3, N'654123654', 1)
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'admin', N'admin')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'ali', N'12345678')
INSERT [dbo].[SystemOprator] ([Username], [Password]) VALUES (N'rezaie', N'987654321')
SET IDENTITY_INSERT [dbo].[Transaction] ON 

INSERT [dbo].[Transaction] ([Id], [Amount], [Submit], [CustomerId], [SellerId]) VALUES (9, CAST(-858.00 AS Decimal(12, 2)), CAST(N'2017-09-15T01:18:09.760' AS DateTime), 15, NULL)
INSERT [dbo].[Transaction] ([Id], [Amount], [Submit], [CustomerId], [SellerId]) VALUES (10, CAST(-858.00 AS Decimal(12, 2)), CAST(N'2017-09-15T01:22:03.477' AS DateTime), 15, NULL)
INSERT [dbo].[Transaction] ([Id], [Amount], [Submit], [CustomerId], [SellerId]) VALUES (11, CAST(-858.00 AS Decimal(12, 2)), CAST(N'2017-09-15T01:22:13.897' AS DateTime), 15, NULL)
INSERT [dbo].[Transaction] ([Id], [Amount], [Submit], [CustomerId], [SellerId]) VALUES (12, CAST(-858.00 AS Decimal(12, 2)), CAST(N'2017-09-15T01:22:15.397' AS DateTime), 15, NULL)
INSERT [dbo].[Transaction] ([Id], [Amount], [Submit], [CustomerId], [SellerId]) VALUES (13, CAST(-858.00 AS Decimal(12, 2)), CAST(N'2017-09-15T01:22:16.603' AS DateTime), 15, NULL)
SET IDENTITY_INSERT [dbo].[Transaction] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (2, N'09388063351', N'Customer', 1203, N'MOhammadREza')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (3, N'09038113433', N'SalesOfficer', 3201, N'Nia HEY')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (4, N'09999999999', N'Marketer', 8765, NULL)
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (5, N'12345678999', N'Seller', 7654, N'sel')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (6, N'88888888888', N'Customer', 4444, N'Nima hh')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (7, N'78945612312', N'SalesOffier', 7536, N'Ali mohamdii')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (8, N'78945612312', N'Seller', 4445, N'reza zade')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (9, N'77777777777', N'Marketer', 8585, N'Okkkkk')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (10, N'14141414141', N'Seller', 6666, N'mohamad rexa')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (11, N'78787878787', N'Seller', 7856, N'Alireza abasi')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (12, N'99999999999', N'Seller', 9812, N'mohamad Rezaie')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (13, N'78787877878', N'Customer', 7533, N'Abas ali hosaaini')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (14, N'22222222222', N'Marketer', 2222, N'Reza Hossaini')
INSERT [dbo].[User] ([Id], [Mobile], [Type], [VerificationCode], [Name]) VALUES (15, N'09399415733', N'Customer', 8018, N'reza khaleghiFar')
SET IDENTITY_INSERT [dbo].[User] OFF
ALTER TABLE [dbo].[ProductTransfer] ADD  CONSTRAINT [DF_ProductTransfer_Barcode]  DEFAULT (substring(replace(CONVERT([varchar](36),newid()),'-',''),(0),(17))) FOR [Barcode]
GO
ALTER TABLE [dbo].[Associtation_TransactionProduct]  WITH CHECK ADD  CONSTRAINT [FK_Associtation_TransactionProduct_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Associtation_TransactionProduct] CHECK CONSTRAINT [FK_Associtation_TransactionProduct_Product]
GO
ALTER TABLE [dbo].[Associtation_TransactionProduct]  WITH CHECK ADD  CONSTRAINT [FK_Associtation_TransactionProduct_Transaction] FOREIGN KEY([TransactionId])
REFERENCES [dbo].[Transaction] ([Id])
GO
ALTER TABLE [dbo].[Associtation_TransactionProduct] CHECK CONSTRAINT [FK_Associtation_TransactionProduct_Transaction]
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
ALTER TABLE [dbo].[SalesOfficer]  WITH CHECK ADD  CONSTRAINT [FK_SalesOfficer_Business] FOREIGN KEY([BusinessId])
REFERENCES [dbo].[Business] ([Id])
GO
ALTER TABLE [dbo].[SalesOfficer] CHECK CONSTRAINT [FK_SalesOfficer_Business]
GO
ALTER TABLE [dbo].[SalesOfficer]  WITH CHECK ADD  CONSTRAINT [FK_SalesOfficer_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[SalesOfficer] CHECK CONSTRAINT [FK_SalesOfficer_User]
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
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Seller] FOREIGN KEY([SellerId])
REFERENCES [dbo].[Seller] ([UserId])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Seller]
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
