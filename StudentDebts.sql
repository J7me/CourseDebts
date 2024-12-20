USE [master]
GO
/****** Object:  Database [StudentDebtsDB]    Script Date: 20.12.2024 1:42:23 ******/
CREATE DATABASE [StudentDebtsDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StudentDebtsDB', FILENAME = N'C:\Users\SH\StudentDebtsDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StudentDebtsDB_log', FILENAME = N'C:\Users\SH\StudentDebtsDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [StudentDebtsDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StudentDebtsDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [StudentDebtsDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [StudentDebtsDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [StudentDebtsDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [StudentDebtsDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [StudentDebtsDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [StudentDebtsDB] SET  MULTI_USER 
GO
ALTER DATABASE [StudentDebtsDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [StudentDebtsDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [StudentDebtsDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [StudentDebtsDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [StudentDebtsDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [StudentDebtsDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [StudentDebtsDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [StudentDebtsDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [StudentDebtsDB]
GO
/****** Object:  Table [dbo].[SubjectDebts]    Script Date: 20.12.2024 1:42:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectDebts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentName] [nvarchar](100) NOT NULL,
	[Subject] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[DueDate] [datetime] NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[SubjectDebts] ON 

INSERT [dbo].[SubjectDebts] ([Id], [StudentName], [Subject], [Description], [DueDate], [Status]) VALUES (1, N'Иван Иванов', N'Математика', N'Не сдал контрольную', CAST(N'2025-02-10T08:00:00.000' AS DateTime), N'HE3ABEPWEHO')
INSERT [dbo].[SubjectDebts] ([Id], [StudentName], [Subject], [Description], [DueDate], [Status]) VALUES (2, N'Анна Петрова', N'Физика', N'Пропустил лекцию', CAST(N'2025-02-15T09:00:00.000' AS DateTime), N'HE3ABEPWEHO')
INSERT [dbo].[SubjectDebts] ([Id], [StudentName], [Subject], [Description], [DueDate], [Status]) VALUES (3, N'Сергей Кузнецов', N'Химия', N'Не сдал лабораторную', CAST(N'2025-01-25T10:00:00.000' AS DateTime), N'HE3ABEPWEHO')
INSERT [dbo].[SubjectDebts] ([Id], [StudentName], [Subject], [Description], [DueDate], [Status]) VALUES (4, N'Мария Васильева', N'История', N'Не сдала курсовую', CAST(N'2025-01-18T14:00:00.000' AS DateTime), N'HE3ABEPWEHO')
INSERT [dbo].[SubjectDebts] ([Id], [StudentName], [Subject], [Description], [DueDate], [Status]) VALUES (5, N'Алексей Смирнов', N'Литература', N'Не сдал экзамен', CAST(N'2025-01-20T16:00:00.000' AS DateTime), N'3ABEPWEHO')
INSERT [dbo].[SubjectDebts] ([Id], [StudentName], [Subject], [Description], [DueDate], [Status]) VALUES (6, N'Екатерина Попова', N'География', N'Пропустила практику', CAST(N'2025-02-05T11:00:00.000' AS DateTime), N'3ABEPWEHO')
INSERT [dbo].[SubjectDebts] ([Id], [StudentName], [Subject], [Description], [DueDate], [Status]) VALUES (7, N'Владимир Трофимов', N'Биология', N'Не сдал задание', CAST(N'2025-01-22T12:00:00.000' AS DateTime), N'HE3ABEPWEHO')
INSERT [dbo].[SubjectDebts] ([Id], [StudentName], [Subject], [Description], [DueDate], [Status]) VALUES (8, N'Юлия Григорьева', N'Математика', N'Пропустила лекцию', CAST(N'2025-01-30T10:30:00.000' AS DateTime), N'3ABEPWEHO')
INSERT [dbo].[SubjectDebts] ([Id], [StudentName], [Subject], [Description], [DueDate], [Status]) VALUES (9, N'Иван Семёнов', N'Физика', N'Не сдал экзамен', CAST(N'2025-02-07T09:00:00.000' AS DateTime), N'HE3ABEPWEHO')
INSERT [dbo].[SubjectDebts] ([Id], [StudentName], [Subject], [Description], [DueDate], [Status]) VALUES (10, N'Наталья Фёдорова', N'Литература', N'Не сдала контрольную', CAST(N'2025-02-12T15:00:00.000' AS DateTime), N'3ABEPWEHO')
INSERT [dbo].[SubjectDebts] ([Id], [StudentName], [Subject], [Description], [DueDate], [Status]) VALUES (11, N'Евгений Орлов', N'География', N'Не сдал курсовую', CAST(N'2025-01-19T13:00:00.000' AS DateTime), N'HE3ABEPWEHO')
INSERT [dbo].[SubjectDebts] ([Id], [StudentName], [Subject], [Description], [DueDate], [Status]) VALUES (12, N'Ольга Иванова', N'История', N'Пропустила лекцию', CAST(N'2025-01-24T14:30:00.000' AS DateTime), N'3ABEPWEHO')
INSERT [dbo].[SubjectDebts] ([Id], [StudentName], [Subject], [Description], [DueDate], [Status]) VALUES (13, N'Максим Ковалёв', N'Биология', N'Не сдал задание', CAST(N'2025-02-01T17:00:00.000' AS DateTime), N'HE3ABEPWEHO')
INSERT [dbo].[SubjectDebts] ([Id], [StudentName], [Subject], [Description], [DueDate], [Status]) VALUES (14, N'Марина Егорова', N'Химия', N'Не сдала лабораторную', CAST(N'2025-02-08T16:30:00.000' AS DateTime), N'3ABEPWEHO')
INSERT [dbo].[SubjectDebts] ([Id], [StudentName], [Subject], [Description], [DueDate], [Status]) VALUES (15, N'Константин Фомин', N'Литература', N'Не сдал экзамен', CAST(N'2025-01-26T13:45:00.000' AS DateTime), N'3ABEPWEHO')
SET IDENTITY_INSERT [dbo].[SubjectDebts] OFF
GO
USE [master]
GO
ALTER DATABASE [StudentDebtsDB] SET  READ_WRITE 
GO
