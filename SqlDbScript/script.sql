USE [master]
GO
/****** Object:  Database [Tournaments]    Script Date: 09.03.2023 23:46:46 ******/
CREATE DATABASE [Tournaments]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Tournaments', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Tournaments.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Tournaments_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Tournaments_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Tournaments] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Tournaments].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Tournaments] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Tournaments] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Tournaments] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Tournaments] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Tournaments] SET ARITHABORT OFF 
GO
ALTER DATABASE [Tournaments] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Tournaments] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Tournaments] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Tournaments] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Tournaments] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Tournaments] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Tournaments] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Tournaments] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Tournaments] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Tournaments] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Tournaments] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Tournaments] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Tournaments] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Tournaments] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Tournaments] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Tournaments] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Tournaments] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Tournaments] SET RECOVERY FULL 
GO
ALTER DATABASE [Tournaments] SET  MULTI_USER 
GO
ALTER DATABASE [Tournaments] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Tournaments] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Tournaments] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Tournaments] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Tournaments] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Tournaments] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Tournaments', N'ON'
GO
ALTER DATABASE [Tournaments] SET QUERY_STORE = ON
GO
ALTER DATABASE [Tournaments] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Tournaments]
GO
/****** Object:  Table [dbo].[MatchupEntries]    Script Date: 09.03.2023 23:46:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchupEntries](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[MatchupId] [int] NOT NULL,
	[ParentMatchupId] [int] NULL,
	[TeamCompetingId] [int] NULL,
	[Score] [float] NULL,
 CONSTRAINT [PK_MatchupEntries] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Matchups]    Script Date: 09.03.2023 23:46:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Matchups](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[WinnerId] [int] NULL,
	[MatchupRound] [int] NOT NULL,
	[TournamentId] [int] NOT NULL,
 CONSTRAINT [PK_Matchups] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[People]    Script Date: 09.03.2023 23:46:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[People](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[EmailAddress] [nvarchar](200) NOT NULL,
	[PhoneNumber] [nvarchar](20) NULL,
 CONSTRAINT [PK_People] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prizes]    Script Date: 09.03.2023 23:46:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prizes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PlaceNumber] [int] NOT NULL,
	[PlaceName] [nvarchar](100) NOT NULL,
	[PrizeAmount] [money] NOT NULL,
	[PrizePercentage] [float] NOT NULL,
 CONSTRAINT [PK_Prizes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamMembers]    Script Date: 09.03.2023 23:46:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamMembers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TeamId] [int] NOT NULL,
	[PersonId] [int] NOT NULL,
 CONSTRAINT [PK_TeamMember] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teams]    Script Date: 09.03.2023 23:46:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teams](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Teams] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestPerson]    Script Date: 09.03.2023 23:46:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestPerson](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[EmailAdress] [nvarchar](200) NOT NULL,
	[PhoneNumber] [varchar](20) NULL,
	[NumberOfKids] [int] NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_TestPerson] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TournamentEntries]    Script Date: 09.03.2023 23:46:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TournamentEntries](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TournamentId] [int] NOT NULL,
	[TeamId] [int] NOT NULL,
 CONSTRAINT [PK_TournamentEntries] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TournamentPrizes]    Script Date: 09.03.2023 23:46:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TournamentPrizes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TournamentId] [int] NOT NULL,
	[PrizeId] [int] NOT NULL,
 CONSTRAINT [PK_TournamentPrizes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tournaments]    Script Date: 09.03.2023 23:46:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tournaments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TournamentName] [nvarchar](200) NOT NULL,
	[EntryFee] [money] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Tournaments] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestPerson] ADD  CONSTRAINT [DF_TestPerson_NumberOfKids]  DEFAULT ((0)) FOR [NumberOfKids]
GO
ALTER TABLE [dbo].[TestPerson] ADD  CONSTRAINT [DF_TestPerson_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Tournaments] ADD  CONSTRAINT [DF_Tournaments_EntryFee]  DEFAULT ((0)) FOR [EntryFee]
GO
ALTER TABLE [dbo].[MatchupEntries]  WITH CHECK ADD  CONSTRAINT [FK_MatchupEntries_Matchups] FOREIGN KEY([MatchupId])
REFERENCES [dbo].[Matchups] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MatchupEntries] CHECK CONSTRAINT [FK_MatchupEntries_Matchups]
GO
ALTER TABLE [dbo].[MatchupEntries]  WITH CHECK ADD  CONSTRAINT [FK_MatchupEntries_Matchups1] FOREIGN KEY([ParentMatchupId])
REFERENCES [dbo].[Matchups] ([id])
GO
ALTER TABLE [dbo].[MatchupEntries] CHECK CONSTRAINT [FK_MatchupEntries_Matchups1]
GO
ALTER TABLE [dbo].[MatchupEntries]  WITH CHECK ADD  CONSTRAINT [FK_MatchupEntries_Teams] FOREIGN KEY([TeamCompetingId])
REFERENCES [dbo].[Teams] ([id])
GO
ALTER TABLE [dbo].[MatchupEntries] CHECK CONSTRAINT [FK_MatchupEntries_Teams]
GO
ALTER TABLE [dbo].[Matchups]  WITH CHECK ADD  CONSTRAINT [FK_Matchups_Teams] FOREIGN KEY([WinnerId])
REFERENCES [dbo].[Teams] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Matchups] CHECK CONSTRAINT [FK_Matchups_Teams]
GO
ALTER TABLE [dbo].[Matchups]  WITH CHECK ADD  CONSTRAINT [FK_Matchups_Tournaments] FOREIGN KEY([TournamentId])
REFERENCES [dbo].[Tournaments] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Matchups] CHECK CONSTRAINT [FK_Matchups_Tournaments]
GO
ALTER TABLE [dbo].[TeamMembers]  WITH CHECK ADD  CONSTRAINT [FK_TeamMembers_People] FOREIGN KEY([PersonId])
REFERENCES [dbo].[People] ([id])
GO
ALTER TABLE [dbo].[TeamMembers] CHECK CONSTRAINT [FK_TeamMembers_People]
GO
ALTER TABLE [dbo].[TeamMembers]  WITH CHECK ADD  CONSTRAINT [FK_TeamMembers_Teams] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Teams] ([id])
GO
ALTER TABLE [dbo].[TeamMembers] CHECK CONSTRAINT [FK_TeamMembers_Teams]
GO
ALTER TABLE [dbo].[TournamentEntries]  WITH CHECK ADD  CONSTRAINT [FK_TournamentEntries_Teams] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Teams] ([id])
GO
ALTER TABLE [dbo].[TournamentEntries] CHECK CONSTRAINT [FK_TournamentEntries_Teams]
GO
ALTER TABLE [dbo].[TournamentEntries]  WITH CHECK ADD  CONSTRAINT [FK_TournamentEntries_TournamentEntries] FOREIGN KEY([TournamentId])
REFERENCES [dbo].[Tournaments] ([id])
GO
ALTER TABLE [dbo].[TournamentEntries] CHECK CONSTRAINT [FK_TournamentEntries_TournamentEntries]
GO
ALTER TABLE [dbo].[TournamentPrizes]  WITH CHECK ADD  CONSTRAINT [FK_TournamentPrizes_Prizes] FOREIGN KEY([PrizeId])
REFERENCES [dbo].[Prizes] ([id])
GO
ALTER TABLE [dbo].[TournamentPrizes] CHECK CONSTRAINT [FK_TournamentPrizes_Prizes]
GO
ALTER TABLE [dbo].[TournamentPrizes]  WITH CHECK ADD  CONSTRAINT [FK_TournamentPrizes_Tournaments] FOREIGN KEY([TournamentId])
REFERENCES [dbo].[Tournaments] ([id])
GO
ALTER TABLE [dbo].[TournamentPrizes] CHECK CONSTRAINT [FK_TournamentPrizes_Tournaments]
GO
/****** Object:  StoredProcedure [dbo].[MatchupEntries_Update]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MatchupEntries_Update]
	@id int,
	@teamCompetingId int = null,
	@Score float = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE dbo.MatchupEntries
	SET TeamCompetingId = @teamCompetingId, Score = @Score
	WHERE id = @id;

END
GO
/****** Object:  StoredProcedure [dbo].[spMatchupEntries_GetByMatchup]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spMatchupEntries_GetByMatchup] 
	-- Add the parameters for the stored procedure here
	@MatchupId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT me.*
	FROM dbo.MatchupEntries AS me
	WHERE me.MatchupId = @MatchupId;

END
GO
/****** Object:  StoredProcedure [dbo].[spMatchupEntries_Insert]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spMatchupEntries_Insert]
	-- Add the parameters for the stored procedure here
	@MatchupId int,
	@ParentMatchupId int,
	@TeamCompetingId int,
	@id int = 0 output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo.MatchupEntries(MatchupId,ParentMatchupId,TeamCompetingId)
	VALUES (@MatchupId,@ParentMatchupId,@TeamCompetingId)

	SELECT @id = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[spMatchups_GetByTournament]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spMatchups_GetByTournament] 
	-- Add the parameters for the stored procedure here
	@TournamentId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT m.*
	FROM dbo.Matchups AS m
	WHERE m.TournamentId = @TournamentId
	ORDER BY MatchupRound;

END
GO
/****** Object:  StoredProcedure [dbo].[spMatchups_Insert]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spMatchups_Insert]
	-- Add the parameters for the stored procedure here
	@TournamentId int,
	@MatchupRound int,
	@id int = 0 output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo.Matchups(TournamentId,MatchupRound)
	VALUES (@TournamentId,@MatchupRound)

	select @id = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[spMatchups_Update]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spMatchups_Update]
	@id int,
	@WinnerId int
AS
BEGIN

	UPDATE dbo.Matchups
	SET WinnerId = @WinnerId
	WHERE id = @id

END
GO
/****** Object:  StoredProcedure [dbo].[spPeople_GetAll]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spPeople_GetAll] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT p.*
	FROM dbo.People AS p

END
GO
/****** Object:  StoredProcedure [dbo].[spPeople_Insert]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spPeople_Insert]
	@FirstName nvarchar(100),
	@LastName nvarchar(100),
	@EmailAddress nvarchar(200),
	@PhoneNumber nvarchar(20),
	@id int = 0 output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo.People(FirstName, LastName, EmailAddress, PhoneNumber)
	VALUES (@FirstName, @LastName, @EmailAddress, @PhoneNumber);

	SELECT @id=SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[spPrizes_GetByTournament]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spPrizes_GetByTournament] 
	-- Add the parameters for the stored procedure here
	@TournamentId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT p.*
	FROM dbo.Prizes AS p
	INNER JOIN dbo.TournamentPrizes t on p.id = t.PrizeId
	WHERE t.TournamentId = @TournamentId;

END
GO
/****** Object:  StoredProcedure [dbo].[spPrizes_Insert]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spPrizes_Insert]
	-- Add the parameters for the stored procedure here
	@PlaceNumber int,
	@PlaceName nvarchar(50),
	@PrizeAmount money,
	@PrizePercentage float,
	@id int = 0 output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo.Prizes (PlaceNumber, PlaceName, PrizeAmount, PrizePercentage)
	VALUES (@PlaceNumber, @PlaceName, @PrizeAmount, @PrizePercentage)

	SELECT @id = SCOPE_IDENTITY();

END
GO
/****** Object:  StoredProcedure [dbo].[spTeam_GetAll]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spTeam_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * 
	FROM dbo.Teams;
END
GO
/****** Object:  StoredProcedure [dbo].[spTeam_GetByTournament]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTeam_GetByTournament] 
	-- Add the parameters for the stored procedure here
	@TournamentId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT t.*
	FROM dbo.Teams AS t
	INNER JOIN dbo.TournamentEntries as te on t.id = te.TeamId
	INNER JOIN dbo.Tournaments as tour on te.TournamentId = tour.id
	WHERE tour.id = @TournamentId

END
GO
/****** Object:  StoredProcedure [dbo].[spTeamMembers_GetByTeam]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTeamMembers_GetByTeam] 
	-- Add the parameters for the stored procedure here
	@TeamId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT p.*
	FROM dbo.TeamMembers AS tm
	INNER JOIN dbo.People AS p ON tm.PersonId = p.id
	WHERE tm.TeamId = @TeamId

END
GO
/****** Object:  StoredProcedure [dbo].[spTeamMembers_Insert]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spTeamMembers_Insert]
	-- Add the parameters for the stored procedure here
	@TeamId int,
	@PersonId int,
	@id int = 0 output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO dbo.TeamMembers(TeamId,PersonId)
	VALUES (@TeamId, @PersonId);

	SELECT @id = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[spTeams_Insert]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTeams_Insert]
	-- Add the parameters for the stored procedure here
	@TeamName nvarchar(100),
	@id int = 0 output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo.Teams (TeamName)
	VALUES (@TeamName);

	SELECT @id = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[spTournament_GetAll]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTournament_GetAll] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT t.*
	FROM dbo.Tournaments AS t

END
GO
/****** Object:  StoredProcedure [dbo].[spTournamentEntries_Insert]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spTournamentEntries_Insert] 
	-- Add the parameters for the stored procedure here
	@TournamentId int,
	@TeamId int,
	@id int = 0 output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo.TournamentEntries(TournamentId,TeamId)
	VALUES (@TournamentId,@TeamId)

	select @id = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[spTournamentPrizes_Insert]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spTournamentPrizes_Insert]
	-- Add the parameters for the stored procedure here
	@TournamentId int,
	@PrizeId int,
	@id int = 0 output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo.TournamentPrizes (TournamentId, PrizeId)
	VALUES (@TournamentId,@PrizeId)

	select @id = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[spTournaments_Insert]    Script Date: 09.03.2023 23:46:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spTournaments_Insert]
	-- Add the parameters for the stored procedure here
	@TournamentName nvarchar(200),
	@EntryFee money,
	@id int = 0 output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo.Tournaments(TournamentName, EntryFee, Active)
	VALUES (@TournamentName,@EntryFee, 1);

	select @id = SCOPE_IDENTITY();
END
GO
USE [master]
GO
ALTER DATABASE [Tournaments] SET  READ_WRITE 
GO
