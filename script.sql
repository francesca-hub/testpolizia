USE [master]
GO
/****** Object:  Database [Polizia_Francesca]    Script Date: 14/05/2021 13:08:20 ******/
CREATE DATABASE [Polizia_Francesca]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Polizia_Francesca', FILENAME = N'C:\Users\fradi\Polizia_Francesca.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Polizia_Francesca_log', FILENAME = N'C:\Users\fradi\Polizia_Francesca_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Polizia_Francesca] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Polizia_Francesca].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Polizia_Francesca] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET ARITHABORT OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Polizia_Francesca] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Polizia_Francesca] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Polizia_Francesca] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Polizia_Francesca] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Polizia_Francesca] SET  MULTI_USER 
GO
ALTER DATABASE [Polizia_Francesca] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Polizia_Francesca] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Polizia_Francesca] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Polizia_Francesca] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Polizia_Francesca] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Polizia_Francesca] SET QUERY_STORE = OFF
GO
USE [Polizia_Francesca]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [Polizia_Francesca]
GO
/****** Object:  Table [dbo].[Agenti]    Script Date: 14/05/2021 13:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agenti](
	[IdAgenti] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](30) NOT NULL,
	[Cognome] [nvarchar](50) NOT NULL,
	[CodiceFiscale] [nchar](16) NOT NULL,
	[DataNascita] [date] NOT NULL,
	[AnniServizio] [int] NOT NULL,
 CONSTRAINT [PK_Agenti] PRIMARY KEY CLUSTERED 
(
	[IdAgenti] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Area metropolitana]    Script Date: 14/05/2021 13:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Area metropolitana](
	[IdArea] [int] IDENTITY(1,1) NOT NULL,
	[CodiceArea] [nchar](5) NOT NULL,
	[AltoRischio] [bit] NOT NULL,
 CONSTRAINT [PK_Area metropolitana] PRIMARY KEY CLUSTERED 
(
	[IdArea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TurnoPattuglia]    Script Date: 14/05/2021 13:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TurnoPattuglia](
	[IdTurnoPattuglia] [int] IDENTITY(1,1) NOT NULL,
	[IdArea] [int] NOT NULL,
	[IdAgente] [int] NOT NULL,
 CONSTRAINT [PK_TurnoPattuglia] PRIMARY KEY CLUSTERED 
(
	[IdTurnoPattuglia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Vista1]    Script Date: 14/05/2021 13:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Vista1]
AS
SELECT TOP (100) PERCENT COUNT(*) AS Agenticonpiudi3annidiservizio, COUNT(*) AS agentiinareeadaltorischio
FROM   dbo.Agenti INNER JOIN
             dbo.TurnoPattuglia ON dbo.Agenti.IdAgenti = dbo.TurnoPattuglia.IdArea INNER JOIN
             dbo.[Area metropolitana] ON dbo.TurnoPattuglia.IdArea = dbo.[Area metropolitana].IdArea
GROUP BY dbo.Agenti.AnniServizio
HAVING (dbo.Agenti.AnniServizio >= 3)
GO
/****** Object:  Index [codicefiscale]    Script Date: 14/05/2021 13:08:22 ******/
CREATE UNIQUE NONCLUSTERED INDEX [codicefiscale] ON [dbo].[Agenti]
(
	[IdAgenti] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TurnoPattuglia]  WITH CHECK ADD  CONSTRAINT [FK_TurnoPattuglia_Agenti1] FOREIGN KEY([IdArea])
REFERENCES [dbo].[Agenti] ([IdAgenti])
GO
ALTER TABLE [dbo].[TurnoPattuglia] CHECK CONSTRAINT [FK_TurnoPattuglia_Agenti1]
GO
ALTER TABLE [dbo].[TurnoPattuglia]  WITH CHECK ADD  CONSTRAINT [FK_TurnoPattuglia_Area metropolitana] FOREIGN KEY([IdArea])
REFERENCES [dbo].[Area metropolitana] ([IdArea])
GO
ALTER TABLE [dbo].[TurnoPattuglia] CHECK CONSTRAINT [FK_TurnoPattuglia_Area metropolitana]
GO
/****** Object:  StoredProcedure [dbo].[elenco]    Script Date: 14/05/2021 13:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[elenco]

@idagenti int,
@idarea int,
@anniservizio int

AS
BEGIN
	SELECT TOP (100) PERCENT COUNT(*) AS Agenticonpiudi3annidiservizio, COUNT(*) AS agentiinareeadaltorischio
FROM   dbo.Agenti INNER JOIN
             dbo.TurnoPattuglia ON dbo.Agenti.IdAgenti = dbo.TurnoPattuglia.IdArea INNER JOIN
             dbo.[Area metropolitana] ON dbo.TurnoPattuglia.IdArea = dbo.[Area metropolitana].IdArea
GROUP BY dbo.Agenti.AnniServizio
HAVING (dbo.Agenti.AnniServizio >= 3)

END
GO
/****** Object:  StoredProcedure [dbo].[EliminaAgente]    Script Date: 14/05/2021 13:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EliminaAgente]
    @nome nvarchar(30),
	@cognome nvarchar(50),
	@codicefiscale nchar(16), 
	@datanascita date,
	@anniservizio int
AS
BEGIN
	delete from Agenti where CodiceFiscale=@codicefiscale 
 
END
GO
/****** Object:  StoredProcedure [dbo].[InserimentoAgente]    Script Date: 14/05/2021 13:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InserimentoAgente]
	@nome nvarchar(30),
	@cognome nvarchar(50),
	@codicefiscale nchar(16),
	@datanascita date,
	@anniservizio int
AS
BEGIN
	
	insert into Agenti (Nome, Cognome, CodiceFiscale, DataNascita, AnniServizio) values (@nome,
	@cognome, @codicefiscale, @datanascita, @anniservizio)
END
GO
/****** Object:  StoredProcedure [dbo].[VisualizzaAgentiPerArea]    Script Date: 14/05/2021 13:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[VisualizzaAgentiPerArea]	
@codicearea nchar(5),
@idagente int 
AS
BEGIN
	SELECT dbo.[Area metropolitana].CodiceArea, dbo.TurnoPattuglia.IdAgente
FROM   dbo.Agenti INNER JOIN
             dbo.TurnoPattuglia ON dbo.Agenti.IdAgenti = dbo.TurnoPattuglia.IdArea INNER JOIN
             dbo.[Area metropolitana] ON dbo.TurnoPattuglia.IdArea = dbo.[Area metropolitana].IdArea
   
END
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
         Begin Table = "Agenti"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Area metropolitana"
            Begin Extent = 
               Top = 10
               Left = 676
               Bottom = 180
               Right = 898
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TurnoPattuglia"
            Begin Extent = 
               Top = 9
               Left = 368
               Bottom = 179
               Right = 603
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
         Width = 2320
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vista1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vista1'
GO
USE [master]
GO
ALTER DATABASE [Polizia_Francesca] SET  READ_WRITE 
GO
