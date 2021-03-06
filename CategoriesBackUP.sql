USE [master]
GO
/****** Object:  Database [Categories]    Script Date: 2/2/2020 9:18:52 PM ******/
CREATE DATABASE [Categories]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Categories', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Categories.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Categories_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Categories_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Categories] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Categories].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Categories] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Categories] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Categories] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Categories] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Categories] SET ARITHABORT OFF 
GO
ALTER DATABASE [Categories] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Categories] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Categories] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Categories] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Categories] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Categories] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Categories] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Categories] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Categories] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Categories] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Categories] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Categories] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Categories] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Categories] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Categories] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Categories] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Categories] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Categories] SET RECOVERY FULL 
GO
ALTER DATABASE [Categories] SET  MULTI_USER 
GO
ALTER DATABASE [Categories] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Categories] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Categories] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Categories] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Categories] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Categories', N'ON'
GO
USE [Categories]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 2/2/2020 9:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Place] [nvarchar](50) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Items]    Script Date: 2/2/2020 9:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Units] [int] NULL,
	[PricePerUnit] [float] NULL,
	[Quantity] [int] NULL,
	[CatergoryID] [int] NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[ReportItem]    Script Date: 2/2/2020 9:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ReportItem]
AS
SELECT        dbo.Items.*, dbo.Category.Name AS Category
FROM            dbo.Category RIGHT OUTER JOIN
                         dbo.Items ON dbo.Category.CategoryID = dbo.Items.CatergoryID

GO
ALTER TABLE [dbo].[Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_Category] FOREIGN KEY([CatergoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Items] CHECK CONSTRAINT [FK_Items_Category]
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
         Begin Table = "Category"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Items"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ReportItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ReportItem'
GO
USE [master]
GO
ALTER DATABASE [Categories] SET  READ_WRITE 
GO
