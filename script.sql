USE [master]
GO
/****** Object:  Database [Assignment2_NguyenPhiHung]    Script Date: 2021-03-20 5:41:11 PM ******/
CREATE DATABASE [Assignment2_NguyenPhiHung]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Assignment2_NguyenPhiHung', FILENAME = N'D:\SQL2019\Assignment2_NguyenPhiHung.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Assignment2_NguyenPhiHung_log', FILENAME = N'D:\SQL2019\Assignment2_NguyenPhiHung_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Assignment2_NguyenPhiHung].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET ARITHABORT OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET  MULTI_USER 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET QUERY_STORE = OFF
GO
USE [Assignment2_NguyenPhiHung]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetAnswerID]    Script Date: 2021-03-20 5:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fnGetAnswerID]()
returns varchar(8)
as
begin
	declare @ID varchar(8)
	if(select count(AnswerID) from Answer) =0
		set @ID = '0'
	else
		select @ID = max (right(AnswerID, 7)) from Answer
		select @ID = case
			when @ID >= 0 and @ID < 9 then 'A000000' + convert(char, convert(int, @ID) + 1)
			when @ID >= 9 and @ID < 99 then 'A00000' + convert(char, convert(int, @ID) + 1)
			when @ID >= 99 and @ID < 999 then 'A0000' + convert(char, convert(int, @ID) + 1)
			when @ID >= 999 and @ID < 9999 then 'A000' + convert(char, convert(int, @ID) + 1)
			when @ID >= 9999 and @ID < 99999 then 'A00' + convert(char, convert(int, @ID) + 1)
			when @ID >= 99999 and @ID < 999999 then 'A0' + convert(char, convert(int, @ID) + 1)
			when @ID >= 999999 and @ID < 9999999 then 'A' + convert(char, convert(int, @ID) + 1)
		end
	return @ID
end
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetQuestionID]    Script Date: 2021-03-20 5:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fnGetQuestionID]()
returns varchar(8)
as
begin
	declare @ID varchar(8)
	if(select count(QuestionID) from Question) = 0
		set @ID='0'
	else 
		select @ID = max (right(QuestionID, 7)) from Question
		select @ID = case 
			when @ID >= 0 and @ID < 9 then 'Q000000' + convert(char, convert(int, @ID) + 1)
			when @ID >= 9 and @ID < 99 then 'Q00000' + convert(char, convert(int, @ID) + 1)
			when @ID >= 99 and @ID < 999 then 'Q0000' + convert(char, convert(int, @ID) + 1)
			when @ID >= 999 and @ID < 9999 then 'Q000' + convert(char, convert(int, @ID) + 1)
			when @ID >= 9999 and @ID < 99999 then 'Q00' + convert(char, convert(int, @ID) + 1)
			when @ID >= 99999 and @ID < 999999 then 'Q0' + convert(char, convert(int, @ID) + 1)
			when @ID >= 999999 and @ID < 9999999 then 'Q' + convert(char, convert(int, @ID) + 1)
		end
	return @ID
end
GO
/****** Object:  Table [dbo].[Account]    Script Date: 2021-03-20 5:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Email] [varchar](100) NOT NULL,
	[AccountName] [nvarchar](100) NOT NULL,
	[Password] [varchar](200) NOT NULL,
	[AccountRoleID] [varchar](10) NOT NULL,
	[AccountStatusID] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountRole]    Script Date: 2021-03-20 5:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountRole](
	[AccountRoleID] [varchar](10) NOT NULL,
	[AccountRoleName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountStatus]    Script Date: 2021-03-20 5:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountStatus](
	[AccountStatusID] [varchar](10) NOT NULL,
	[AccountStatusName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Answer]    Script Date: 2021-03-20 5:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answer](
	[AnswerID] [varchar](8) NOT NULL,
	[AnswerContent] [nvarchar](500) NOT NULL,
	[QuestionID] [varchar](8) NOT NULL,
	[CorrectAnswer] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AnswerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 2021-03-20 5:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[QuestionID] [varchar](8) NOT NULL,
	[QuestionContent] [nvarchar](500) NOT NULL,
	[QuestionStatusID] [varchar](10) NOT NULL,
	[SubjectID] [varchar](10) NOT NULL,
	[CreatedDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionStatus]    Script Date: 2021-03-20 5:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionStatus](
	[QuestionStatusID] [varchar](10) NOT NULL,
	[QuestionStatusName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[QuestionStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quiz]    Script Date: 2021-03-20 5:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quiz](
	[QuizID] [varchar](8) NOT NULL,
	[AccountID] [varchar](100) NOT NULL,
	[SubjectID] [varchar](10) NOT NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[TotalScore] [real] NULL,
PRIMARY KEY CLUSTERED 
(
	[QuizID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuizDetail]    Script Date: 2021-03-20 5:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuizDetail](
	[QuizID] [varchar](8) NOT NULL,
	[QuestionID] [varchar](8) NOT NULL,
	[SelectedAnswerID] [varchar](8) NULL,
PRIMARY KEY CLUSTERED 
(
	[QuizID] ASC,
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 2021-03-20 5:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subject](
	[SubjectID] [varchar](10) NOT NULL,
	[SubjectName] [nvarchar](150) NOT NULL,
	[TotalQuestion] [int] NULL,
	[TotalTimeQuiz] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SubjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([Email], [AccountName], [Password], [AccountRoleID], [AccountStatusID]) VALUES (N'a@gmail.com', N'Nguyen Hung', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', N'AR1', N'AS0')
INSERT [dbo].[Account] ([Email], [AccountName], [Password], [AccountRoleID], [AccountStatusID]) VALUES (N'admin@gmail.com', N'admin', N'8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92', N'AR0', N'AS0')
INSERT [dbo].[Account] ([Email], [AccountName], [Password], [AccountRoleID], [AccountStatusID]) VALUES (N'h@gmail.com', N'Nguyen Hung', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', N'AR1', N'AS0')
INSERT [dbo].[AccountRole] ([AccountRoleID], [AccountRoleName]) VALUES (N'AR0', N'admin')
INSERT [dbo].[AccountRole] ([AccountRoleID], [AccountRoleName]) VALUES (N'AR1', N'student')
INSERT [dbo].[AccountStatus] ([AccountStatusID], [AccountStatusName]) VALUES (N'AS0', N'new')
INSERT [dbo].[AccountStatus] ([AccountStatusID], [AccountStatusName]) VALUES (N'AS1', N'deactivate')
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000001', N'8', N'Q0000001', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000002', N'4', N'Q0000001', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000003', N'2', N'Q0000001', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000004', N'1', N'Q0000001', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000005', N'System.Int16', N'Q0000002', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000006', N'System.UInt32', N'Q0000002', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000007', N'System.UInt64', N'Q0000002', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000008', N'System.UInt16', N'Q0000002', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000009', N'int a = 32; b = 40.6', N'Q0000003', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000010', N'int a = 42; b = 40', N'Q0000003', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000011', N'int a = 32; int b = 40', N'Q0000003', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000012', N'int a = b = 42', N'Q0000003', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000013', N'long < short < int < sbyte', N'Q0000004', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000014', N'sbyte < short < int < long', N'Q0000004', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000015', N'short < sbyte < int < long', N'Q0000004', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000016', N'short < int < sbyte < long', N'Q0000004', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000017', N'sbyte', N'Q0000005', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000018', N'short', N'Q0000005', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000019', N'int', N'Q0000005', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000020', N'long', N'Q0000005', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000021', N'ii', N'Q0000006', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000022', N'Both i, ii', N'Q0000006', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000023', N'i', N'Q0000006', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000024', N'None of the mentioned', N'Q0000006', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000025', N'c = a + b;', N'Q0000007', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000026', N'c = a + int(float(b));', N'Q0000007', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000027', N'c = a + convert.ToInt32(b);', N'Q0000007', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000028', N'c = int(a + b);', N'Q0000007', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000029', N'Long Int', N'Q0000008', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000030', N'Unsigned Long', N'Q0000008', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000031', N'Int', N'Q0000008', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000032', N'Unsigned Int', N'Q0000008', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000033', N'float somevariable = 12.502D', N'Q0000009', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000034', N'float somevariable = (Double) 12.502D', N'Q0000009', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000035', N'float somevariable = (float) 12.502D', N'Q0000009', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000036', N'float somevariable = (Decimal)12.502D', N'Q0000009', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000037', N'Upto 6 digit', N'Q0000010', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000038', N'Upto 8 digit', N'Q0000010', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000039', N'Upto 9 digit', N'Q0000010', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000040', N'Upto 7 digit', N'Q0000010', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000041', N'10 Bytes', N'Q0000011', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000042', N'6 Bytes', N'Q0000011', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000043', N'4 Bytes', N'Q0000011', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000044', N'8 Bytes', N'Q0000011', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000045', N'#define pi 6.28F', N'Q0000012', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000046', N'pi = 6.28F', N'Q0000012', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000047', N'const float pi = 6.28F', N'Q0000012', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000048', N'const float pi; pi = 6.28F', N'Q0000012', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000049', N'ABCD', N'Q0000013', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000050', N'DCBA', N'Q0000013', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000051', N'0 * ABCD', N'Q0000013', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000052', N'Depends on big endian or little endian architecture', N'Q0000013', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000053', N'0', N'Q0000014', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000054', N'True', N'Q0000014', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000055', N'False', N'Q0000014', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000056', N'1', N'Q0000014', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000057', N'%hx for small case letters and %HX for capital letters', N'Q0000015', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000058', N'%x for small case letters and %X for capital letters', N'Q0000015', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000059', N'No ease of doing it. C# don’t provides specifier like %x or %O to be used
		with ReadLine() OR WriteLine(). We have to write our own function', N'Q0000015', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000060', N'%Ox for small case letters and %OX for capital letters', N'Q0000015', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000061', N'8 bit', N'Q0000016', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000062', N'12 bit', N'Q0000016', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000063', N'16 bit', N'Q0000016', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000064', N'20 bit', N'Q0000016', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000065', N'Compare To()', N'Q0000017', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000066', N'Compare()', N'Q0000017', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000067', N'Copy()', N'Q0000017', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000068', N'ConCat()', N'Q0000017', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000069', N'if(s1 = s2)', N'Q0000018', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000070', N'int c; c = s1.CompareTo(s2);', N'Q0000018', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000071', N'if (s1 is s2)', N'Q0000018', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000072', N'if(strcmp(s1, s2))', N'Q0000018', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000073', N'a string is created on the stack', N'Q0000019', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000074', N'a string is primitive in nature', N'Q0000019', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000075', N'a string created on heap', N'Q0000019', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000076', N'created of string on a stack or on a heap depends on the length of the 
		string', N'Q0000019', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000077', N'Convenience and better readability of strings when string text consist 
		of backlash characters', N'Q0000020', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000078', N'Used to initialize multi-line strings', N'Q0000020', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000079', N'To embed a quotation mark by using double quotation marks inside a 
		verbatim string', N'Q0000020', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000080', N'All of the mentioned', N'Q0000020', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000081', N'To create string on stack', N'Q0000021', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000082', N'To reduce the size of string', N'Q0000021', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000083', N'To overcome problem of stackoverflow', N'Q0000021', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000084', N'None of the mentioned', N'Q0000021', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000085', N'Pointers', N'Q0000022', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000086', N'Constants', N'Q0000022', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000087', N'Variable', N'Q0000022', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000088', N'None of the mentioned', N'Q0000022', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000089', N'‘Var’ is introduced in C# (3.0) and ‘Dynamic’ is introduced in C# (4.0)', N'Q0000023', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000090', N'‘Var’ is a type of variable where declaration is done at compile time by compiler 
		while ‘Dynamic’ declaration is achieved at runtime by compiler', N'Q0000023', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000091', N'For ‘Var’ Error is caught at compile time and for ‘Dynamic’ Error is caught at runtime', N'Q0000023', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000092', N'All of the mentioned', N'Q0000023', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000093', N'<data type><var_name> = <Value>;', N'Q0000024', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000094', N'<data type><var_name>;', N'Q0000024', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000095', N'<var_name><data type>;', N'Q0000024', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000096', N'<var_name> = <value>;', N'Q0000024', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000097', N'‘Boxing’ is the process of converting a value type to the reference type and ‘Unboxing’ 
		is the process of converting reference to value type', N'Q0000025', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000098', N'‘Boxing’ is the process of converting a reference type to value type and ‘Unboxing’ is
		the process of converting value type to reference type', N'Q0000025', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000099', N'In ‘Boxing’ we need explicit conversion and in ‘Unboxing’ we need implicit conversion', N'Q0000025', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000100', N'Both ‘Boxing’ and ‘Unboxing’ we need implicit conversion', N'Q0000025', 0)
GO
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000101', N'To store a value of one data type into a variable of another data type', N'Q0000026', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000102', N'To get desired data', N'Q0000026', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000103', N'To prevent situations of runtime error during change or conversion of data type', N'Q0000026', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000104', N'None of the mentioned', N'Q0000026', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000105', N'Implicit Conversion', N'Q0000027', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000106', N'Explicit Conversion', N'Q0000027', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000107', N'Implicit Conversion and Explicit Conversion', N'Q0000027', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000108', N'None of the mentioned', N'Q0000027', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000109', N'float < char < int', N'Q0000028', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000110', N'char < int < float', N'Q0000028', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000111', N'int < char < float', N'Q0000028', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000112', N'float < int < char', N'Q0000028', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000113', N'long, ulong, ushort', N'Q0000029', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000114', N'long, ulong, uint', N'Q0000029', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000115', N'long, float, double', N'Q0000029', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000116', N'long, float, ushort', N'Q0000029', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000117', N'ushort to long', N'Q0000030', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000118', N'int to uint', N'Q0000030', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000119', N'ushort to long', N'Q0000030', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000120', N'byte to decimal', N'Q0000030', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000121', N'Makes program memory heavier', N'Q0000031', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000122', N'Results in loss of data', N'Q0000031', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000123', N'Potentially Unsafe', N'Q0000031', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000124', N'None of the mentioned', N'Q0000031', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000125', N'++ a ++', N'Q0000032', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000126', N'b ++ 1', N'Q0000032', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000127', N'c += 1', N'Q0000032', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000128', N'd =+ 1', N'Q0000032', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000129', N'>=', N'Q0000033', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000130', N'<>=', N'Q0000033', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000131', N'Not', N'Q0000033', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000132', N'<=', N'Q0000033', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000133', N'&, |', N'Q0000034', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000134', N'^, ~', N'Q0000034', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000135', N'<<, >>', N'Q0000034', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000136', N'+=, -=', N'Q0000034', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000137', N'?: < && < != < & < ++', N'Q0000035', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000138', N'?: < && < != < ++ < &', N'Q0000035', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000139', N'?: < && < & <!= < ++', N'Q0000035', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000140', N'?: < && < != < & < ++', N'Q0000035', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000141', N'for( ;’0′; )', N'Q0000036', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000142', N'for( ;0; )', N'Q0000036', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000143', N'for( ;’1′; )', N'Q0000036', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000144', N'for( ;’1′; )', N'Q0000036', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000145', N':', N'Q0000037', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000146', N'::', N'Q0000037', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000147', N'#', N'Q0000037', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000148', N'none of the mentioned', N'Q0000037', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000149', N':', N'Q0000038', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000150', N'::', N'Q0000038', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000151', N'.', N'Q0000038', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000152', N'#', N'Q0000038', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000153', N'type', N'Q0000039', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000154', N'scope', N'Q0000039', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000155', N'type & scope', N'Q0000039', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000156', N'none of the mentioned', N'Q0000039', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000157', N'Everything you use in C# is an object, including Windows Forms and controls', N'Q0000040', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000158', N'Objects have methods and events that allow them to perform actions', N'Q0000040', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000159', N'All objects created from a class will occupy equal number of bytes in memory', N'Q0000040', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000160', N'All of the mentioned', N'Q0000040', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000161', N'Abstraction', N'Q0000041', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000162', N'Polymorphism', N'Q0000041', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000163', N'Inheritance', N'Q0000041', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000164', N'Encapsulation', N'Q0000041', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000165', N'protected, public', N'Q0000042', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000166', N'private, public', N'Q0000042', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000167', N'private', N'Q0000042', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000168', N'public', N'Q0000042', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000169', N'&', N'Q0000043', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000170', N'ref', N'Q0000043', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000171', N'#', N'Q0000043', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000172', N'$', N'Q0000043', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000173', N'References can be called recursively', N'Q0000044', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000174', N'The ‘ref’ keyword causes arguments to be passed by reference', N'Q0000044', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000175', N'When ‘ref’ are used, any changes made to parameters in method will be reflected
		in variable when control is passed back to calling method', N'Q0000044', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000176', N'All of the mentioned', N'Q0000044', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000177', N'float', N'Q0000045', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000178', N'int', N'Q0000045', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000179', N'long', N'Q0000045', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000180', N'none of the mentioned', N'Q0000045', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000181', N'C# allows a function to have arguments with default values', N'Q0000046', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000182', N'Redefining a method parameter in the method’s body causes an exception', N'Q0000046', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000183', N'C# allows function to have arguments with default values', N'Q0000046', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000184', N'Omitting the return type in method definition results into exception', N'Q0000046', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000185', N'0', N'Q0000047', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000186', N'2', N'Q0000047', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000187', N'1', N'Q0000047', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000188', N'any number of values', N'Q0000047', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000189', N'1', N'Q0000048', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000190', N'2', N'Q0000048', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000191', N'Any number', N'Q0000048', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000192', N'None of the mentioned', N'Q0000048', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000193', N'Constructors can be overloaded', N'Q0000049', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000194', N'Constructors are never called explicitly', N'Q0000049', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000195', N'Constructors have same name as name of the class', N'Q0000049', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000196', N'All of the mentioned', N'Q0000049', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000197', N'initialize the objects', N'Q0000050', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000198', N'construct the data members', N'Q0000050', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000199', N'initialize the objects & construct the data members', N'Q0000050', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000200', N'none of the mentioned', N'Q0000050', 0)
GO
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000201', N'A constructor cannot be declared as private', N'Q0000051', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000202', N'A constructor cannot be overloaded', N'Q0000051', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000203', N'A constructor can be a static constructor', N'Q0000051', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000204', N'None of the mentioned', N'Q0000051', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000205', N'int', N'Q0000052', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000206', N'float', N'Q0000052', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000207', N'void', N'Q0000052', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000208', N'none of the mentioned', N'Q0000052', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000209', N'delete', N'Q0000053', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000210', N'class', N'Q0000053', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000211', N'constructor', N'Q0000053', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000212', N'none of the mentioned', N'Q0000053', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000213', N'::', N'Q0000054', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000214', N':', N'Q0000054', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000215', N'~', N'Q0000054', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000216', N'&', N'Q0000054', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000217', N'Finalize()', N'Q0000055', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000218', N'End()', N'Q0000055', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000219', N'Dispose()', N'Q0000055', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000220', N'Close()', N'Q0000055', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000221', N'Constructor', N'Q0000056', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000222', N'Finalize()', N'Q0000056', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000223', N'Destructor', N'Q0000056', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000224', N'End', N'Q0000056', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000225', N'There is one garbage collector per program running in memory', N'Q0000057', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000226', N'There is one common garbage collector for all programs', N'Q0000057', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000227', N'To garbage collect an object set all references to it as null', N'Q0000057', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000228', N'Both There is one common garbage collector for all programs & To garbage collect
		an object set all references to it as null', N'Q0000057', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000229', N'new', N'Q0000058', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000230', N'free', N'Q0000058', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000231', N'delete', N'Q0000058', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000232', N'none of the mentioned', N'Q0000058', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000233', N'A class can have one destructor only', N'Q0000059', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000234', N'Destructors cannot be inherited or overloaded', N'Q0000059', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000235', N'Destructors can have modifiers or parameters', N'Q0000059', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000236', N'All of the mentioned', N'Q0000059', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000237', N'int', N'Q0000060', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000238', N'void', N'Q0000060', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000239', N'float', N'Q0000060', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000240', N'none of the mentioned', N'Q0000060', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000241', N'Each test stage has a different purpose.', N'Q0000061', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000242', N'It is easier to manage testing in stages.', N'Q0000061', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000243', N'We can run different tests in different environments.', N'Q0000061', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000244', N'The more stages we have, the better the testing.', N'Q0000061', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000245', N'Regression testing', N'Q0000062', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000246', N'Integration testing', N'Q0000062', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000247', N'System testing', N'Q0000062', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000248', N'User acceptance testing', N'Q0000062', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000249', N'A minimal test set that achieves 100% LCSAJ coverage will also achieve 100% 
		branch coverage', N'Q0000063', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000250', N'A minimal test set that achieves 100% path coverage will also achieve 100% 
		statement coverage', N'Q0000063', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000251', N'A minimal test set that achieves 100% path coverage will generally detect more 
		faults than one that achieves 100% statement coverage.', N'Q0000063', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000252', N'A minimal test set that achieves 100% statement coverage will generally detect 
		more faults than one that achieves 100% branch coverage.', N'Q0000063', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000253', N'The system shall be user friendly.', N'Q0000064', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000254', N'The safety-critical parts of the system shall contain 0 faults.', N'Q0000064', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000255', N'The response time shall be less than one second for the specified design load.', N'Q0000064', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000256', N'The system shall be built to be portable.', N'Q0000064', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000257', N'supplements formal test design techniques.', N'Q0000065', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000258', N'can only be used in component, integration and system testing', N'Q0000065', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000259', N'is only performed in user acceptance testing.', N'Q0000065', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000260', N'is not repeatable and should not be used.', N'Q0000065', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000261', N'Test coverage criteria can be measured in terms of items exercised by a test suite.', N'Q0000066', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000262', N'A measure of test coverage criteria is the percentage of user requirements covered', N'Q0000066', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000263', N'A measure of test coverage criteria is the percentage of faults found', N'Q0000066', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000264', N'Test coverage criteria are often used when specifying test completion criteria', N'Q0000066', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000265', N'find as many faults as possible.', N'Q0000067', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000266', N'test high risk areas.', N'Q0000067', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000267', N'obtain good test coverage.', N'Q0000067', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000268', N'test whatever is easiest to test.', N'Q0000067', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000269', N'System tests are often performed by independent teams.', N'Q0000068', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000270', N'Functional testing is used more than structural testing.', N'Q0000068', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000271', N'Faults found during system tests can be very expensive to fix.', N'Q0000068', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000272', N'End-users should be involved in system tests.', N'Q0000068', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000273', N'Incidents should always be fixed.', N'Q0000069', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000274', N'An incident occurs when expected and actual results differ.', N'Q0000069', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000275', N'Incidents can be analysed to assist in test process improvement.', N'Q0000069', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000276', N'An incident can be raised against documentation.', N'Q0000069', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000277', N'time runs out.', N'Q0000070', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000278', N'the required level of confidence has been achieved.', N'Q0000070', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000279', N'no more faults are found.', N'Q0000070', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000280', N'the users won’t find any serious faults.', N'Q0000070', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000281', N'Incident resolution is the responsibility of the author of the software under test.', N'Q0000071', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000282', N'Incidents may be raised against user requirements.', N'Q0000071', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000283', N'Incidents require investigation and/or correction.', N'Q0000071', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000284', N'Incidents are raised when expected and actual results differ.', N'Q0000071', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000285', N'syntax testing', N'Q0000072', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000286', N'equivalence partitioning', N'Q0000072', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000287', N'stress testing', N'Q0000072', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000288', N'modified condition/decision coverage', N'Q0000072', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000289', N'In a system two different failures may have different severities.', N'Q0000073', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000290', N'A system is necessarily more reliable after debugging for the removal of a fault.', N'Q0000073', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000291', N'A fault need not affect the reliability of a system.', N'Q0000073', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000292', N'Undetected errors may lead to faults and eventually to incorrect behaviour.', N'Q0000073', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000293', N'They are used to support multi-user testing.', N'Q0000074', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000294', N'They are used to capture and animate user requirements.', N'Q0000074', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000295', N'They are the most frequently purchased types of CAST tool.', N'Q0000074', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000296', N'They capture aspects of user behavior.', N'Q0000074', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000297', N'Metrics from previous similar projects', N'Q0000075', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000298', N'Discussions with the development team', N'Q0000075', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000299', N'Time allocated for regression testing', N'Q0000075', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000300', N'a & b', N'Q0000075', 1)
GO
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000301', N'It states that modules are tested against user requirements.', N'Q0000076', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000302', N'It only models the testing phase.', N'Q0000076', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000303', N'It specifies the test techniques to be used.', N'Q0000076', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000304', N'It includes the verification of designs.', N'Q0000076', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000305', N'is that there is some existing system against which test output may be checked.', N'Q0000077', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000306', N'is that the tester can routinely identify the correct outcome of a test.', N'Q0000077', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000307', N'is that the tester knows everything about the software under test.', N'Q0000077', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000308', N'is that the tests are reviewed by experienced testers.', N'Q0000077', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000309', N'They are cheapest to find in the early development phases and the most expensive to fix 
		in the latest test phases', N'Q0000078', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000310', N'They are easiest to find during system testing but the most expensive to fix then.', N'Q0000078', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000311', N'Faults are cheapest to find in the early development phases but the most expensive to
		fix then.', N'Q0000078', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000312', N'Although faults are most expensive to find during early development phases, they are 
		cheapest to fix then.', N'Q0000078', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000313', N'To find faults in the software.', N'Q0000079', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000314', N'To assess whether the software is ready for release.', N'Q0000079', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000315', N'To demonstrate that the software doesn’t work.', N'Q0000079', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000316', N'To prove that the software is correct.', N'Q0000079', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000317', N'Boundary value analysis', N'Q0000080', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000318', N'Usability testing', N'Q0000080', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000319', N'Performance testing', N'Q0000080', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000320', N'Security testing', N'Q0000080', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000321', N'Features to be tested', N'Q0000081', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000322', N'Incident reports', N'Q0000081', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000323', N'Risks', N'Q0000081', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000324', N'Schedule', N'Q0000081', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000325', N'Test management', N'Q0000082', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000326', N'Test design', N'Q0000082', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000327', N'Test execution', N'Q0000082', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000328', N'Test planning', N'Q0000082', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000329', N'Statement testing', N'Q0000083', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000330', N'Path testing', N'Q0000083', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000331', N'Data flow testing', N'Q0000083', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000332', N'State transition testing', N'Q0000083', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000333', N'possible communications bottlenecks in a program.', N'Q0000084', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000334', N'the rate of change of data values as a program executes.', N'Q0000084', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000335', N'the use of data on paths through the code.', N'Q0000084', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000336', N'the intrinsic complexity of the code.', N'Q0000084', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000337', N'enable the code to be tested before the execution environment is ready.', N'Q0000085', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000338', N'can be performed by the person who wrote the code.', N'Q0000085', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000339', N'can be performed by inexperienced staff.', N'Q0000085', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000340', N'are cheap to perform.', N'Q0000085', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000341', N'Actual results', N'Q0000086', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000342', N'Program specification', N'Q0000086', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000343', N'User requirements', N'Q0000086', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000344', N'System specification', N'Q0000086', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000345', N'An inspection is lead by the author, whilst a walkthrough is lead by a trained
		moderator.', N'Q0000087', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000346', N'An inspection has a trained leader, whilst a walkthrough has no leader.', N'Q0000087', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000347', N'Authors are not present during inspections, whilst they are during walkthroughs', N'Q0000087', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000348', N'A walkthrough is lead by the author, whilst an inspection is lead by a trained 
		moderator.', N'Q0000087', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000349', N'It allows the identification of changes in user requirements.', N'Q0000088', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000350', N'It facilitates timely set up of the test environment.', N'Q0000088', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000351', N'It reduces defect multiplication.', N'Q0000088', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000352', N'It allows testers to become involved early in the project.', N'Q0000088', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000353', N'tests the individual components that have been developed.', N'Q0000089', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000354', N'tests interactions between modules or subsystems.', N'Q0000089', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000355', N'only uses components that form part of the live system.', N'Q0000089', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000356', N'tests interfaces to other systems.', N'Q0000089', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000357', N'the analysis of batch programs.', N'Q0000090', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000358', N'the reviewing of test plans.', N'Q0000090', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000359', N'the analysis of program code', N'Q0000090', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000360', N'the use of black box testing.', N'Q0000090', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000361', N'post-release testing by end user representatives at the developer’s site', N'Q0000091', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000362', N'the first testing that is performed.', N'Q0000091', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000363', N'pre-release testing by end user representatives at the developer’s site.', N'Q0000091', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000364', N'pre-release testing by end user representatives at their sites.', N'Q0000091', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000365', N'found in the software; the result of an error.', N'Q0000092', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000366', N'departure from specified behavior.', N'Q0000092', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000367', N'an incorrect step, process or data definition in a computer program.', N'Q0000092', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000368', N'a human action that produces an incorrect result.', N'Q0000092', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000369', N'makes test preparation easier.', N'Q0000093', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000370', N'means inspections are not required.', N'Q0000093', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000371', N'can prevent fault multiplication.', N'Q0000093', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000372', N'will find all faults.', N'Q0000093', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000373', N'Reviews cannot be performed on user requirements specifications.', N'Q0000094', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000374', N'Reviews are the least effective way of testing code.', N'Q0000094', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000375', N'Reviews are unlikely to find faults in test plans.', N'Q0000094', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000376', N'Reviews should be performed on specifications, code, and test plans.', N'Q0000094', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000377', N'test recording.', N'Q0000095', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000378', N'test planning', N'Q0000095', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000379', N'test configuration.', N'Q0000095', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000380', N'test specification.', N'Q0000095', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000381', N'linkage of customer requirements to version numbers.', N'Q0000096', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000382', N'facilities to compare test results with expected results.', N'Q0000096', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000383', N'the precise differences in versions of software component source code.', N'Q0000096', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000384', N'restricted access to the source code library.', N'Q0000096', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000385', N'an error', N'Q0000097', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000386', N'a fault', N'Q0000097', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000387', N'a failure', N'Q0000097', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000388', N'a failure', N'Q0000097', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000389', N'test items', N'Q0000098', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000390', N'test deliverables', N'Q0000098', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000391', N'test tasks', N'Q0000098', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000392', N'test specifications', N'Q0000098', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000393', N'when all the planned tests have been run', N'Q0000099', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000394', N'when time has run out', N'Q0000099', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000395', N'when all faults have been fixed correctly', N'Q0000099', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000396', N'it depends on the risks for the system being tested', N'Q0000099', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000397', N'1000, 50000, 99999', N'Q0000100', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000398', N'9999, 50000, 100000', N'Q0000100', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000399', N'10000, 50000, 99999', N'Q0000100', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000400', N'10000, 99999, 100000', N'Q0000100', 0)
GO
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000401', N'testing to see where the system does not function correctly', N'Q0000101', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000402', N'testing quality attributes of the system including performance and usability', N'Q0000101', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000403', N'testing a system function using only the software required for that function', N'Q0000101', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000404', N'testing for functions that should not exist', N'Q0000101', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000405', N'auditing conformance to ISO 9000', N'Q0000102', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000406', N'status accounting of configuration items', N'Q0000102', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000407', N'identification of test versions', N'Q0000102', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000408', N'controlled library access', N'Q0000102', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000409', N'to ensure that all of the small modules are tested adequately', N'Q0000103', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000410', N'to ensure that the system interfaces to other systems and networks', N'Q0000103', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000411', N'to specify which modules to combine when, and how many at once', N'Q0000103', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000412', N'to specify how the software should be divided into modules', N'Q0000103', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000413', N'to know when a specific test has finished its execution', N'Q0000104', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000414', N'to ensure that the test case specification is complete', N'Q0000104', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000415', N'to set the criteria used in generating test inputs', N'Q0000104', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000416', N'to determine when to stop testing', N'Q0000104', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000417', N'testing that the system functions with other systems', N'Q0000105', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000418', N'testing that the components that comprise the system function together', N'Q0000105', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000419', N'testing the end to end functionality of the system as a whole', N'Q0000105', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000420', N'testing the system performs functions within specified response times', N'Q0000105', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000421', N'requirements', N'Q0000106', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000422', N'documentation', N'Q0000106', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000423', N'test cases', N'Q0000106', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000424', N'improvements suggested by users', N'Q0000106', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000425', N'operating systems', N'Q0000107', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000426', N'test documentation', N'Q0000107', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000427', N'live data', N'Q0000107', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000428', N'user requirement documents', N'Q0000107', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000429', N'updating tests when the software has changed', N'Q0000108', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000430', N'testing a released system that has been changed', N'Q0000108', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000431', N'testing by users to ensure that the system meets a business need', N'Q0000108', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000432', N'testing to maintain business advantage', N'Q0000108', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000433', N'the use of a variable before it has been defined', N'Q0000109', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000434', N'unreachable (“dead”) code', N'Q0000109', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000435', N'memory leaks', N'Q0000109', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000436', N'array bound violations', N'Q0000109', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000437', N'state transition testing', N'Q0000110', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000438', N'LCSAJ', N'Q0000110', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000439', N'syntax testing', N'Q0000110', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000440', N'boundary value analysis', N'Q0000110', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000441', N'performed by customers at their own site', N'Q0000111', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000442', N'performed by customers at the software developer’s site', N'Q0000111', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000443', N'performed by an Independent Test Team', N'Q0000111', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000444', N'performed as early as possible in the lifecycle', N'Q0000111', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000445', N'finding faults in the system', N'Q0000112', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000446', N'ensuring that the system is acceptable to all users', N'Q0000112', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000447', N'testing the system with other systems', N'Q0000112', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000448', N'testing from a business perspective', N'Q0000112', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000449', N'black box test design techniques all have an associated test measurement technique', N'Q0000113', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000450', N'white box test design techniques all have an associated test measurement technique', N'Q0000113', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000451', N'cyclomatic complexity is not a test measurement technique', N'Q0000113', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000452', N'black box test measurement techniques all have an associated test design technique', N'Q0000113', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000453', N'inspection is the most formal review process', N'Q0000114', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000454', N'inspections should be led by a trained leader', N'Q0000114', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000455', N'managers can perform inspections on management documents', N'Q0000114', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000456', N'inspection is appropriate even when there are no written documents', N'Q0000114', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000457', N'calculating expected outputs', N'Q0000115', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000458', N'comparison of expected outcomes with actual outcomes', N'Q0000115', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000459', N'recording test inputs', N'Q0000115', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000460', N'reading test values from a data file', N'Q0000115', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000461', N're-testing ensures the original fault has been removed;  
		regression testing looks for unexpected side-effects', N'Q0000116', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000462', N're-testing looks for unexpected side-effects;  regression 
		testing ensures the original fault has been removed', N'Q0000116', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000463', N're-testing is done after faults are fixed;  regression testing is done earlier', N'Q0000116', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000464', N're-testing is done by developers;  regression testing is done by independent 
		testers', N'Q0000116', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000465', N'only important in system testing', N'Q0000117', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000466', N'only used in component testing', N'Q0000117', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000467', N'most useful when specified in advance', N'Q0000117', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000468', N'derived from the code', N'Q0000117', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000469', N'walkthrough', N'Q0000118', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000470', N'inspection', N'Q0000118', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000471', N'management review', N'Q0000118', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000472', N'post project review', N'Q0000118', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000473', N'component testing', N'Q0000119', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000474', N'non-functional system testing', N'Q0000119', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000475', N'user acceptance testing', N'Q0000119', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000476', N'maintenance testing', N'Q0000119', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000477', N'setting up forms and databases', N'Q0000120', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000478', N'analyzing metrics and improving processes', N'Q0000120', 0)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000479', N'writing the documents to be inspected', N'Q0000120', 1)
INSERT [dbo].[Answer] ([AnswerID], [AnswerContent], [QuestionID], [CorrectAnswer]) VALUES (N'A0000480', N'time spent on the document outside the meeting', N'Q0000120', 0)
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000001', N'How many Bytes are stored by ‘Long’ Data type in C# .net?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000002', N'Choose “.NET class” name from which data type “UInt” is derived?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000003', N'Correct Declaration of Values to variables ‘a’ and ‘b’?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000004', N'Arrange the following data type in order of increasing magnitude sbyte, short, long, int', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000005', N'Which data type should be more preferred for storing a simple number like 35 to improve 
		execution speed of a program?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000006', N'Which Conversion function of ‘Convert.TOInt32()’ and ‘Int32.Parse()’ is efficient? 
		i) Int32.Parse() is only used for strings and throws argument exception fornull string 
		ii) Convert.Int32() used for data types and returns directly "0" for null string', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000007', N'Correct way to assign values to variable ‘c’ when int a=12, float b=3.5, int c', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000008', N'Default Type of number without decimal is?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000009', N'Select a convenient declaration and initialization of a floating point number:', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000010', N'Number of digits upto which precision value of float data type is valid?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000011', N'Valid Size of float data type is?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000012', N'Correct way to define a value 6.28 in a variable ‘pi’ where value cannot be modified?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000013', N'A float occupies 4 bytes. If the hexadecimal equivalent of these 4 bytes are A, B, C 
		and D, then when this float is stored in memory in which of the following order do these bytes 
		gets stored?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000014', N'The Default value of Boolean Data Type is?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000015', N'Which of the following format specifiers is used to print hexadecimal values 
		and return value of output as Octal equivalent in C#?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000016', N'What is the Size of ‘Char’ datatype?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000017', N'Which is the String method used to compare two strings with each other?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000018', N'For two strings s1 and s2 to be equal, which is the correct way to find if the 
		contents of two strings are equal?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000019', N'Correct statement about strings are?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000020', N'Verbatim string literal is better used for?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000021', N'Why strings are of reference type in C#.NET?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000022', N'Storage location used by computer memory to store data for usage by an 
		application is?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000023', N'DIFFERENCE BETWEEN KEYWORDS ‘VAR’ AND ‘DYNAMIC’?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000024', N'Syntax for declaration and initialization of data variable is?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000025', N'Choose effective differences between ‘Boxing’ and ‘Unboxing’', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000026', N'What is the need for ‘Conversion of data type’ in C#?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000027', N'Types of ‘Data Conversion’ in C#?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000028', N'‘Implicit Conversion’ follows the order of conversion as per compatibility of 
		data type as:', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000029', N'The subset of ‘int’ data type is __________', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000030', N'Type of Conversion in which compiler is unable to convert the data type 
		implicitly is?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000031', N'Disadvantages of Explicit Conversion are?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000032', N'The correct way of incrementing the operators are:', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000033', N'Which of the following is/are not Relational operators in C#.NET?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000034', N'Which of the following options is not a Bitwise Operator in C#?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000035', N'Arrange the operators in the increasing order as defined in C#:  !=,   ?:,   &,
		++,  &&', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000036', N'Which of the following is not infinite loop?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000037', N'Which of the following is used to define the member of a class externally?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000038', N'The operator used to access member function of a class?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000039', N'What is the most specified using class declaration?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000040', N'Which of the following statements about objects in “C#” is correct?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000041', N'“A mechanism that binds together code and data in manipulates, and keeps both safe 
		from outside interference and misuse. In short it isolates a particular code and data from all 
		other codes and data. A well-defined interface controls access to that particular code and data.”', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000042', N'The data members of a class by default are?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000043', N'Which reference modifier is used to define reference variable?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000044', N'Select the wrong statement about ‘ref’ keyword in C#?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000045', N'What will be the output of the following C# expression? 
		int  a+= (float) b/= (long)c.', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000046', N'Which of the following statements are correct about functions?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000047', N'How many values does a function return?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000048', N'Number of constructors a class can define is?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000049', N'Correct statement about constructors in C#.NET is?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000050', N'Which among the following is the correct statement: Constructors are used to?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000051', N'Which of the following statements is correct about constructors in C#.NET?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000052', N'What is the return type of constructors?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000053', N'Which method has the same name as that of its class?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000054', N'Which operator among the following signifies the destructor operator?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000055', N'The method called by clients of a class to explicitly release any resources 
		like network, connection, open files etc. When the object is no longer required?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000056', N'Name a method which has the same name as that of class and which is used to 
		destroy objects also called automatically when application is finally on process of being
		getting terminated.', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000057', N'Which of the following statements are correct?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000058', N'Operator used to free the memory when memory is allocated?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000059', N'Select wrong statement about destructor in C#?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000060', N'What is the return type of destructor?', N'QS0', N'S01', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000061', N'We split testing into distinct stages primarily because:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000062', N'Which of the following is likely to benefit most from the use of test tools 
		providing test capture and replay facilities?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000063', N'Which of the following statements is NOT correct?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000064', N'Which of the following requirements is testable?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000065', N'Error guessing:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000066', N'Which of the following is NOT true of test coverage criteria?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000067', N'In prioritizing what to test, the most important objective is to:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000068', N'Which one of the following statements about system testing is NOT true?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000069', N'Which of the following is false?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000070', N'Enough testing has been performed when:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000071', N'Which of the following is NOT true of incidents?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000072', N'Which of the following is not described in a unit test standard?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000073', N'Which of the following is false?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000074', N'Which one of the following statements, about capture-replay tools, is NOT correct?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000075', N'How would you estimate the amount of re-testing likely to be required?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000076', N'Which of the following is true of the V-model?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000077', N'The oracle assumption:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000078', N'Which of the following characterizes the cost of faults?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000079', N'Which of the following should NOT normally be an objective for a test?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000080', N'Which of the following is a form of functional testing?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000081', N'Which of the following would NOT normally form part of a test plan?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000082', N'Which of these activities provides the biggest potential cost saving from the 
		use of CAST?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000083', N'Which of the following is NOT a white box technique?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000084', N'Data flow analysis studies:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000085', N'An important benefit of code inspections is that they:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000086', N'Which of the following is the best source of Expected Outcomes for User Acceptance 
		Test scripts?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000087', N'What is the main difference between a walkthrough and an inspection?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000088', N'Which one of the following describes the major benefit of verification early 
		in the life cycle?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000089', N'Integration testing in the small:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000090', N'Static analysis is best described as:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000091', N'Alpha testing is:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000092', N'A failure is:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000093', N'The most important thing about early test design is that it:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000094', N'Which of the following statements about reviews is true?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000095', N'Test cases are designed during:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000096', N'A configuration management system would NOT normally provide:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000097', N'A deviation from the specified or expected behavior that is visible to end-users is 
		called', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000098', N'IEEE 829 test plan documentation standard contains all of the following except', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000099', N'When should testing be stopped?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000100', N'Order numbers on a stock control system can range between 10000 and 99999 inclusive.
		Which of the following inputs might be a result of designing tests for only valid equivalence 
		classes and valid boundaries?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
GO
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000101', N'Non-functional system testing includes:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000102', N'Which of the following is NOT part of configuration management?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000103', N'Which of the following is the main purpose of the integration strategy for integration 
		testing in the small?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000104', N'What is the purpose of a test completion criterion?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000105', N'Functional system testing is:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000106', N'Incidents would not be raised against:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000107', N'Which of the following items would not come under Configuration Management?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000108', N'Maintenance testing is:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000109', N'What can static analysis NOT find?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000110', N'Which of the following techniques is NOT a black box technique?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000111', N'Beta testing is:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000112', N'The main focus of acceptance testing is:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000113', N'Which of the following statements about component testing is FALSE?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000114', N'Which of the following statements is NOT true?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000115', N'A typical commercial test execution tool would be able to perform all of the 
		following, EXCEPT:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000116', N'The difference between re-testing and regression testing is:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000117', N'Expected results are:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000118', N'What type of review requires formal entry and exit criteria, including metrics:', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000119', N'Which of the following uses Impact Analysis most?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[Question] ([QuestionID], [QuestionContent], [QuestionStatusID], [SubjectID], [CreatedDate]) VALUES (N'Q0000120', N'What is NOT included in typical costs for an inspection process?', N'QS0', N'S02', CAST(N'2021-03-19' AS Date))
INSERT [dbo].[QuestionStatus] ([QuestionStatusID], [QuestionStatusName]) VALUES (N'QS0', N'activate')
INSERT [dbo].[QuestionStatus] ([QuestionStatusID], [QuestionStatusName]) VALUES (N'QS1', N'deactivate')
INSERT [dbo].[Subject] ([SubjectID], [SubjectName], [TotalQuestion], [TotalTimeQuiz]) VALUES (N'S01', N'C#', 50, 1)
INSERT [dbo].[Subject] ([SubjectID], [SubjectName], [TotalQuestion], [TotalTimeQuiz]) VALUES (N'S02', N'Foundations of software testing', 40, 90)
ALTER TABLE [dbo].[Answer] ADD  DEFAULT ([dbo].[fnGetAnswerID]()) FOR [AnswerID]
GO
ALTER TABLE [dbo].[Question] ADD  DEFAULT ([dbo].[fnGetQuestionID]()) FOR [QuestionID]
GO
ALTER TABLE [dbo].[Question] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Quiz] ADD  DEFAULT ((0)) FOR [TotalScore]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([AccountRoleID])
REFERENCES [dbo].[AccountRole] ([AccountRoleID])
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([AccountStatusID])
REFERENCES [dbo].[AccountStatus] ([AccountStatusID])
GO
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Question] ([QuestionID])
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD FOREIGN KEY([QuestionStatusID])
REFERENCES [dbo].[QuestionStatus] ([QuestionStatusID])
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD FOREIGN KEY([SubjectID])
REFERENCES [dbo].[Subject] ([SubjectID])
GO
ALTER TABLE [dbo].[Quiz]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([Email])
GO
ALTER TABLE [dbo].[Quiz]  WITH CHECK ADD FOREIGN KEY([SubjectID])
REFERENCES [dbo].[Subject] ([SubjectID])
GO
ALTER TABLE [dbo].[QuizDetail]  WITH CHECK ADD FOREIGN KEY([SelectedAnswerID])
REFERENCES [dbo].[Answer] ([AnswerID])
GO
USE [master]
GO
ALTER DATABASE [Assignment2_NguyenPhiHung] SET  READ_WRITE 
GO
