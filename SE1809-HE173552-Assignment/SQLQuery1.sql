 USE [PRJ_ASSIGNMENT]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[accid] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](30) NOT NULL,
	[password] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK__Account__A472ABF2DE3EADD4] PRIMARY KEY CLUSTERED 
(
	[accid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Account_Role]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account_Role](
	[roleid] [int] NOT NULL,
	[accid] [int] NOT NULL,
 CONSTRAINT [PK_Account_Role] PRIMARY KEY CLUSTERED 
(
	[roleid] ASC,
	[accid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Assesment]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assesment](
	[asid] [int] NOT NULL,
	[asname] [nvarchar](30) NOT NULL,
	[subid] [int] NOT NULL,
	[weight] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[asid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attendance]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendance](
	[atid] [int] IDENTITY(1,1) NOT NULL,
	[sesid] [int] NOT NULL,
	[sid] [nvarchar](10) NOT NULL,
	[dateTime] [datetime] NOT NULL,
	[status] [nvarchar](10) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK__Attendan__5B37D0E92B90042C] PRIMARY KEY CLUSTERED 
(
	[atid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[eid] [int] NOT NULL,
	[exname] [nvarchar](50) NOT NULL,
	[asid] [int] NOT NULL,
	[dateTime] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feature]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feature](
	[feaid] [int] NOT NULL,
	[feaname] [nvarchar](100) NOT NULL,
	[url] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Feature] PRIMARY KEY CLUSTERED 
(
	[feaid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grade]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grade](
	[grid] [int] NOT NULL,
	[eid] [int] NOT NULL,
	[subid] [int] NOT NULL,
	[score] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[grid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Group]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group](
	[gid] [int] NOT NULL,
	[gname] [nvarchar](50) NULL,
	[subid] [int] NOT NULL,
	[pic] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK__Group__DCD80EF8FF21DCB6] PRIMARY KEY CLUSTERED 
(
	[gid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Group_Student]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group_Student](
	[gid] [int] NOT NULL,
	[sid] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK] PRIMARY KEY CLUSTERED 
(
	[gid] ASC,
	[sid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lecture]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lecture](
	[lid] [nvarchar](10) NOT NULL,
	[lname] [nvarchar](50) NOT NULL,
	[email] [nvarchar](30) NOT NULL,
	[laccid] [int] NOT NULL,
 CONSTRAINT [PK__Lecture__DE105D078BCB3FE9] PRIMARY KEY CLUSTERED 
(
	[lid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Major]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Major](
	[maid] [int] NOT NULL,
	[maname] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Major] PRIMARY KEY CLUSTERED 
(
	[maid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[roleid] [int] NOT NULL,
	[rolename] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[roleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role_Feature]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role_Feature](
	[feaid] [int] NOT NULL,
	[roleid] [int] NOT NULL,
 CONSTRAINT [PK_Role_Feature] PRIMARY KEY CLUSTERED 
(
	[feaid] ASC,
	[roleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[rid] [int] NOT NULL,
	[rname] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK__Room__C2B7EDE85441F777] PRIMARY KEY CLUSTERED 
(
	[rid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Session]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Session](
	[sesid] [int] IDENTITY(1,1) NOT NULL,
	[gid] [int] NOT NULL,
	[lid] [nvarchar](10) NOT NULL,
	[slid] [int] NOT NULL,
	[date] [date] NOT NULL,
	[rid] [int] NOT NULL,
	[isAttended] [bit] NULL,
 CONSTRAINT [PK__Session__DF939E61EEB75DED] PRIMARY KEY CLUSTERED 
(
	[sesid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Slot]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slot](
	[slid] [int] NOT NULL,
	[from] [time](7) NOT NULL,
	[to] [time](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[slid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[sid] [nvarchar](10) NOT NULL,
	[sname] [nvarchar](50) NOT NULL,
	[email] [nvarchar](30) NOT NULL,
	[saccid] [int] NOT NULL,
	[maid] [int] NOT NULL,
 CONSTRAINT [PK__Student__DDDFDD36D0EA7240] PRIMARY KEY CLUSTERED 
(
	[sid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subject](
	[subid] [int] NOT NULL,
	[subname] [nvarchar](50) NOT NULL,
	[credit] [int] NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[trid] [int] NOT NULL,
	[maid] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[subid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Term]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Term](
	[teid] [int] NOT NULL,
	[tename] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK__Term__E0F79A486234010F] PRIMARY KEY CLUSTERED 
(
	[teid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrainingDepartment]    Script Date: 3/7/2024 9:32:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrainingDepartment](
	[trid] [int] NOT NULL,
	[trname] [nvarchar](50) NOT NULL,
	[teid] [int] NOT NULL,
 CONSTRAINT [PK__Training__9C32E7AAEE397E11] PRIMARY KEY CLUSTERED 
(
	[trid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 
GO
INSERT [dbo].[Account] ([accid], [username], [password]) VALUES (2, N'VuVTHE131355', N'123')
GO
INSERT [dbo].[Account] ([accid], [username], [password]) VALUES (3, N'FU540772', N'12')
GO
INSERT [dbo].[Account] ([accid], [username], [password]) VALUES (4, N'HuongTTFU884370', N'1')
GO
INSERT [dbo].[Account] ([accid], [username], [password]) VALUES (5, N'MinhDNHE021314', N'dao')
GO
INSERT [dbo].[Account] ([accid], [username], [password]) VALUES (6, N'GiaiTCHE725824', N'1234')
GO
INSERT [dbo].[Account] ([accid], [username], [password]) VALUES (7, N'GiayCVHE861653', N'12345')
GO
INSERT [dbo].[Account] ([accid], [username], [password]) VALUES (8, N'ChimTTHE217341', N'123')
GO
INSERT [dbo].[Account] ([accid], [username], [password]) VALUES (9, N'QuanVTFU538544', N'1')
GO
INSERT [dbo].[Account] ([accid], [username], [password]) VALUES (10, N'AnhKDFU484522', N'123')
GO
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Attendance] ON 
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (11, 6, N'HE021314', CAST(N'2024-03-03T02:17:13.423' AS DateTime), N'Present', N'sdk')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (12, 6, N'HE131355', CAST(N'2024-03-03T02:17:13.427' AS DateTime), N'Absent', N'nhu lon')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (13, 6, N'HE217341', CAST(N'2024-03-03T02:17:13.427' AS DateTime), N'Present', N'')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (14, 6, N'HE725824', CAST(N'2024-03-03T02:17:13.427' AS DateTime), N'Absent', N'')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (15, 6, N'HE861653', CAST(N'2024-03-03T02:17:13.430' AS DateTime), N'Present', N'')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (16, 5, N'HE021314', CAST(N'2024-03-04T10:16:50.850' AS DateTime), N'Present', N's ')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (17, 5, N'HE131355', CAST(N'2024-03-04T10:16:50.850' AS DateTime), N'Absent', N'sd')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (18, 5, N'HE217341', CAST(N'2024-03-04T10:16:50.850' AS DateTime), N'Present', N's')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (19, 5, N'HE725824', CAST(N'2024-03-04T10:16:50.850' AS DateTime), N'Absent', N'sdsd')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (20, 5, N'HE861653', CAST(N'2024-03-04T10:16:50.850' AS DateTime), N'Absent', N'sdsddsd')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (21, 20, N'HE021314', CAST(N'2024-03-04T16:21:52.387' AS DateTime), N'Present', N'')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (22, 20, N'HE131355', CAST(N'2024-03-04T16:21:52.387' AS DateTime), N'Present', N'')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (23, 20, N'HE217341', CAST(N'2024-03-04T16:21:52.387' AS DateTime), N'Present', N'')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (24, 20, N'HE725824', CAST(N'2024-03-04T16:21:52.387' AS DateTime), N'Present', N'')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (25, 20, N'HE861653', CAST(N'2024-03-04T16:21:52.387' AS DateTime), N'Present', N'')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (26, 28, N'HE021314', CAST(N'2024-03-05T10:17:19.003' AS DateTime), N'Present', N'')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (27, 28, N'HE131355', CAST(N'2024-03-05T10:17:19.003' AS DateTime), N'Present', N'')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (28, 28, N'HE217341', CAST(N'2024-03-05T10:17:19.007' AS DateTime), N'Absent', N'v')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (29, 28, N'HE725824', CAST(N'2024-03-05T10:17:19.007' AS DateTime), N'Present', N'')
GO
INSERT [dbo].[Attendance] ([atid], [sesid], [sid], [dateTime], [status], [description]) VALUES (30, 28, N'HE861653', CAST(N'2024-03-05T10:17:19.007' AS DateTime), N'Absent', N'')
GO
SET IDENTITY_INSERT [dbo].[Attendance] OFF
GO
INSERT [dbo].[Group] ([gid], [gname], [subid], [pic]) VALUES (1, N'SE1809', 1, N'FU884370')
GO
INSERT [dbo].[Group] ([gid], [gname], [subid], [pic]) VALUES (2, N'SE1810', 2, N'FU538544')
GO
INSERT [dbo].[Group] ([gid], [gname], [subid], [pic]) VALUES (3, N'SE1809', 3, N'FU484522')
GO
INSERT [dbo].[Group_Student] ([gid], [sid]) VALUES (1, N'HE021314')
GO
INSERT [dbo].[Group_Student] ([gid], [sid]) VALUES (1, N'HE131355')
GO
INSERT [dbo].[Group_Student] ([gid], [sid]) VALUES (1, N'HE217341')
GO
INSERT [dbo].[Group_Student] ([gid], [sid]) VALUES (1, N'HE725824')
GO
INSERT [dbo].[Group_Student] ([gid], [sid]) VALUES (1, N'HE861653')
GO
INSERT [dbo].[Group_Student] ([gid], [sid]) VALUES (2, N'HE021314')
GO
INSERT [dbo].[Group_Student] ([gid], [sid]) VALUES (2, N'HE131355')
GO
INSERT [dbo].[Group_Student] ([gid], [sid]) VALUES (2, N'HE217341')
GO
INSERT [dbo].[Group_Student] ([gid], [sid]) VALUES (2, N'HE725824')
GO
INSERT [dbo].[Group_Student] ([gid], [sid]) VALUES (3, N'HE021314')
GO
INSERT [dbo].[Group_Student] ([gid], [sid]) VALUES (3, N'HE131355')
GO
INSERT [dbo].[Group_Student] ([gid], [sid]) VALUES (3, N'HE217341')
GO
INSERT [dbo].[Group_Student] ([gid], [sid]) VALUES (3, N'HE725824')
GO
INSERT [dbo].[Group_Student] ([gid], [sid]) VALUES (3, N'HE861653')
GO
INSERT [dbo].[Lecture] ([lid], [lname], [email], [laccid]) VALUES (N'FU484522', N'Khuat Duc Anh', N'AnhKDFU484522@fu.edu.vn', 10)
GO
INSERT [dbo].[Lecture] ([lid], [lname], [email], [laccid]) VALUES (N'FU538544', N'Vien Thanh Quan', N'QuanVTFU538544@fu.edu.vn', 9)
GO
INSERT [dbo].[Lecture] ([lid], [lname], [email], [laccid]) VALUES (N'FU540772', N'Trinh Van Truong', N'TruongTVFU540772@fu.edu.vn', 3)
GO
INSERT [dbo].[Lecture] ([lid], [lname], [email], [laccid]) VALUES (N'FU884370', N'Tran Thi Huong', N'HuongTTFU884370@fu.edu.vn', 4)
GO
INSERT [dbo].[Major] ([maid], [maname]) VALUES (1, N'Information Technology')
GO
INSERT [dbo].[Major] ([maid], [maname]) VALUES (2, N'Graphic Design')
GO
INSERT [dbo].[Major] ([maid], [maname]) VALUES (3, N'Business Administration')
GO
INSERT [dbo].[Major] ([maid], [maname]) VALUES (4, N'Artificial Intelligence')
GO
INSERT [dbo].[Room] ([rid], [rname]) VALUES (1, N'BE-116')
GO
INSERT [dbo].[Room] ([rid], [rname]) VALUES (2, N'BE-319')
GO
SET IDENTITY_INSERT [dbo].[Session] ON 
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (5, 1, N'FU884370', 1, CAST(N'2024-02-29' AS Date), 1, 1)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (6, 1, N'FU884370', 1, CAST(N'2024-03-01' AS Date), 1, 1)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (10, 1, N'FU884370', 1, CAST(N'2025-02-24' AS Date), 1, 0)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (11, 1, N'FU884370', 3, CAST(N'2025-02-24' AS Date), 1, 0)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (14, 1, N'FU884370', 1, CAST(N'2024-03-04' AS Date), 1, NULL)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (15, 1, N'FU884370', 1, CAST(N'2024-03-05' AS Date), 1, NULL)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (20, 3, N'FU484522', 1, CAST(N'2024-02-27' AS Date), 2, 1)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (21, 3, N'FU484522', 2, CAST(N'2024-02-28' AS Date), 2, NULL)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (22, 3, N'FU484522', 1, CAST(N'2024-03-06' AS Date), 2, NULL)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (23, 3, N'FU484522', 2, CAST(N'2024-03-07' AS Date), 2, NULL)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (24, 1, N'FU884370', 1, CAST(N'2024-03-12' AS Date), 1, NULL)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (25, 1, N'FU884370', 1, CAST(N'2024-03-13' AS Date), 1, NULL)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (26, 3, N'FU484522', 1, CAST(N'2024-03-14' AS Date), 2, NULL)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (27, 3, N'FU484522', 2, CAST(N'2024-03-15' AS Date), 2, NULL)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (28, 1, N'FU884370', 1, CAST(N'2024-02-20' AS Date), 1, 1)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (29, 1, N'FU884370', 1, CAST(N'2024-02-21' AS Date), 1, NULL)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (30, 3, N'FU484522', 1, CAST(N'2024-02-22' AS Date), 2, NULL)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (31, 3, N'FU484522', 2, CAST(N'2024-02-23' AS Date), 2, NULL)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (32, 1, N'FU884370', 1, CAST(N'2024-03-19' AS Date), 1, NULL)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (33, 1, N'FU884370', 1, CAST(N'2024-03-20' AS Date), 1, NULL)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (34, 3, N'FU484522', 1, CAST(N'2024-03-21' AS Date), 2, NULL)
GO
INSERT [dbo].[Session] ([sesid], [gid], [lid], [slid], [date], [rid], [isAttended]) VALUES (35, 3, N'FU484522', 2, CAST(N'2024-03-22' AS Date), 2, NULL)
GO
SET IDENTITY_INSERT [dbo].[Session] OFF
GO
INSERT [dbo].[Slot] ([slid], [from], [to]) VALUES (1, CAST(N'07:30:00' AS Time), CAST(N'09:50:00' AS Time))
GO
INSERT [dbo].[Slot] ([slid], [from], [to]) VALUES (2, CAST(N'10:00:00' AS Time), CAST(N'12:20:00' AS Time))
GO
INSERT [dbo].[Slot] ([slid], [from], [to]) VALUES (3, CAST(N'12:50:00' AS Time), CAST(N'15:10:00' AS Time))
GO
INSERT [dbo].[Slot] ([slid], [from], [to]) VALUES (4, CAST(N'15:20:00' AS Time), CAST(N'17:40:00' AS Time))
GO
INSERT [dbo].[Student] ([sid], [sname], [email], [saccid], [maid]) VALUES (N'HE021314', N'Dao Nhat Minh', N'MinhDNHE021314@fpt.edu.vn', 5, 1)
GO
INSERT [dbo].[Student] ([sid], [sname], [email], [saccid], [maid]) VALUES (N'HE131355', N'Vien Thanh Vu', N'VuVTHE131355@fpt.edu.vn', 2, 1)
GO
INSERT [dbo].[Student] ([sid], [sname], [email], [saccid], [maid]) VALUES (N'HE217341', N'Thinh Thich Chim', N'ChimTTHE217341@fpt.edu.vn', 8, 1)
GO
INSERT [dbo].[Student] ([sid], [sname], [email], [saccid], [maid]) VALUES (N'HE725824', N'Truong Cong Giai', N'GiaiTCHE725824@fpt.edu.vn', 6, 1)
GO
INSERT [dbo].[Student] ([sid], [sname], [email], [saccid], [maid]) VALUES (N'HE861653', N'Cau Van Giay', N'GiayCVHE861653@fpt.edu.vn', 7, 1)
GO
INSERT [dbo].[Subject] ([subid], [subname], [credit], [Description], [trid], [maid]) VALUES (1, N'PRJ301', 3, N'Mon hoc giup cac em ren ri nang lap trinh', 1, 1)
GO
INSERT [dbo].[Subject] ([subid], [subname], [credit], [Description], [trid], [maid]) VALUES (2, N'PRO192', 3, N'Mon hoc nay giup cac em ren ki nang lap trinh va tu duy huong doi tuong', 1, 1)
GO
INSERT [dbo].[Subject] ([subid], [subname], [credit], [Description], [trid], [maid]) VALUES (3, N'IOT102', 3, N'Mon hoc nay giup cac em ren ki nang lap trinh nhung va ap dung tien bo khoa hoc cong nghe vao cs', 3, 1)
GO
INSERT [dbo].[Term] ([teid], [tename]) VALUES (1, N'Spring2024')
GO
INSERT [dbo].[Term] ([teid], [tename]) VALUES (2, N'Summer2024')
GO
INSERT [dbo].[Term] ([teid], [tename]) VALUES (3, N'Fall2024')
GO
INSERT [dbo].[Term] ([teid], [tename]) VALUES (4, N'Spring2023')
GO
INSERT [dbo].[Term] ([teid], [tename]) VALUES (5, N'Summer2023')
GO
INSERT [dbo].[Term] ([teid], [tename]) VALUES (6, N'Fall2023')
GO
INSERT [dbo].[TrainingDepartment] ([trid], [trname], [teid]) VALUES (1, N'Programing', 1)
GO
INSERT [dbo].[TrainingDepartment] ([trid], [trname], [teid]) VALUES (2, N'Soft skill', 1)
GO
INSERT [dbo].[TrainingDepartment] ([trid], [trname], [teid]) VALUES (3, N'Embeded Engineer', 1)
GO
ALTER TABLE [dbo].[Account_Role]  WITH CHECK ADD  CONSTRAINT [FK_Account_Role_Account] FOREIGN KEY([accid])
REFERENCES [dbo].[Account] ([accid])
GO
ALTER TABLE [dbo].[Account_Role] CHECK CONSTRAINT [FK_Account_Role_Account]
GO
ALTER TABLE [dbo].[Account_Role]  WITH CHECK ADD  CONSTRAINT [FK_Account_Role_Role] FOREIGN KEY([roleid])
REFERENCES [dbo].[Role] ([roleid])
GO
ALTER TABLE [dbo].[Account_Role] CHECK CONSTRAINT [FK_Account_Role_Role]
GO
ALTER TABLE [dbo].[Assesment]  WITH CHECK ADD FOREIGN KEY([subid])
REFERENCES [dbo].[Subject] ([subid])
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK__Attendanc__sesid__6754599E] FOREIGN KEY([sesid])
REFERENCES [dbo].[Session] ([sesid])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK__Attendanc__sesid__6754599E]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK__Attendance__sid__68487DD7] FOREIGN KEY([sid])
REFERENCES [dbo].[Student] ([sid])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK__Attendance__sid__68487DD7]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD FOREIGN KEY([asid])
REFERENCES [dbo].[Assesment] ([asid])
GO
ALTER TABLE [dbo].[Grade]  WITH CHECK ADD FOREIGN KEY([eid])
REFERENCES [dbo].[Exam] ([eid])
GO
ALTER TABLE [dbo].[Grade]  WITH CHECK ADD FOREIGN KEY([subid])
REFERENCES [dbo].[Subject] ([subid])
GO
ALTER TABLE [dbo].[Group]  WITH CHECK ADD FOREIGN KEY([subid])
REFERENCES [dbo].[Subject] ([subid])
GO
ALTER TABLE [dbo].[Group]  WITH CHECK ADD  CONSTRAINT [FK_Group_Lecture] FOREIGN KEY([pic])
REFERENCES [dbo].[Lecture] ([lid])
GO
ALTER TABLE [dbo].[Group] CHECK CONSTRAINT [FK_Group_Lecture]
GO
ALTER TABLE [dbo].[Group_Student]  WITH CHECK ADD  CONSTRAINT [FK__Group_Stude__gid__6D0D32F4] FOREIGN KEY([gid])
REFERENCES [dbo].[Group] ([gid])
GO
ALTER TABLE [dbo].[Group_Student] CHECK CONSTRAINT [FK__Group_Stude__gid__6D0D32F4]
GO
ALTER TABLE [dbo].[Group_Student]  WITH CHECK ADD  CONSTRAINT [FK__Group_Stude__sid__6E01572D] FOREIGN KEY([sid])
REFERENCES [dbo].[Student] ([sid])
GO
ALTER TABLE [dbo].[Group_Student] CHECK CONSTRAINT [FK__Group_Stude__sid__6E01572D]
GO
ALTER TABLE [dbo].[Lecture]  WITH CHECK ADD  CONSTRAINT [FK_Lecture_Account] FOREIGN KEY([laccid])
REFERENCES [dbo].[Account] ([accid])
GO
ALTER TABLE [dbo].[Lecture] CHECK CONSTRAINT [FK_Lecture_Account]
GO
ALTER TABLE [dbo].[Role_Feature]  WITH CHECK ADD  CONSTRAINT [FK_Role_Feature_Feature] FOREIGN KEY([feaid])
REFERENCES [dbo].[Feature] ([feaid])
GO
ALTER TABLE [dbo].[Role_Feature] CHECK CONSTRAINT [FK_Role_Feature_Feature]
GO
ALTER TABLE [dbo].[Role_Feature]  WITH CHECK ADD  CONSTRAINT [FK_Role_Feature_Role] FOREIGN KEY([roleid])
REFERENCES [dbo].[Role] ([roleid])
GO
ALTER TABLE [dbo].[Role_Feature] CHECK CONSTRAINT [FK_Role_Feature_Role]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK__Session__gid__6FE99F9F] FOREIGN KEY([gid])
REFERENCES [dbo].[Group] ([gid])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK__Session__gid__6FE99F9F]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_Lecture] FOREIGN KEY([lid])
REFERENCES [dbo].[Lecture] ([lid])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_Lecture]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_Room] FOREIGN KEY([rid])
REFERENCES [dbo].[Room] ([rid])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_Room]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_Slot] FOREIGN KEY([slid])
REFERENCES [dbo].[Slot] ([slid])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_Slot]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Account1] FOREIGN KEY([saccid])
REFERENCES [dbo].[Account] ([accid])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Account1]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Major1] FOREIGN KEY([maid])
REFERENCES [dbo].[Major] ([maid])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Major1]
GO
ALTER TABLE [dbo].[Subject]  WITH CHECK ADD  CONSTRAINT [FK_Subject_Major] FOREIGN KEY([maid])
REFERENCES [dbo].[Major] ([maid])
GO
ALTER TABLE [dbo].[Subject] CHECK CONSTRAINT [FK_Subject_Major]
GO
ALTER TABLE [dbo].[Subject]  WITH CHECK ADD  CONSTRAINT [FK_Subject_TrainingDepartment] FOREIGN KEY([trid])
REFERENCES [dbo].[TrainingDepartment] ([trid])
GO
ALTER TABLE [dbo].[Subject] CHECK CONSTRAINT [FK_Subject_TrainingDepartment]
GO
ALTER TABLE [dbo].[TrainingDepartment]  WITH CHECK ADD  CONSTRAINT [FK__TrainingDe__teid__787EE5A0] FOREIGN KEY([teid])
REFERENCES [dbo].[Term] ([teid])
GO
ALTER TABLE [dbo].[TrainingDepartment] CHECK CONSTRAINT [FK__TrainingDe__teid__787EE5A0]
GO
SELECT * FROM Account
INSERT INTO [Role] VALUES(1, N'Lecturer')
INSERT INTO [Role] VALUES(2, N'Student')

INSERT INTO Feature VALUES(1, N'View timetable', N'view/timetable.jsp')
INSERT INTO Feature VALUES(2, N'View home', N'view/home.jsp')
INSERT INTO Feature VALUES(3, N'View attendance', N'view/attendance.jsp')
INSERT INTO Feature VALUES(4, N'View attendance report', N'view/attendance_report.jsp')

INSERT INTO Role_Feature VALUES(1, 2)
INSERT INTO Role_Feature VALUES(1, 1)
INSERT INTO Role_Feature VALUES(2, 2)
INSERT INTO Role_Feature VALUES(2, 1)
INSERT INTO Role_Feature VALUES(3, 2)
INSERT INTO Role_Feature VALUES(3, 1)
INSERT INTO Role_Feature VALUES(4, 2)
INSERT INTO Role_Feature VALUES(4, 1)

INSERT INTO Account_Role VALUES(2, 2)
INSERT INTO Account_Role VALUES(1, 4)
INSERT INTO Account_Role VALUES(2, 5)
INSERT INTO Account_Role VALUES(2, 6)
INSERT INTO Account_Role VALUES(2, 7)
INSERT INTO Account_Role VALUES(2, 8)
INSERT INTO Account_Role VALUES(1, 9)
INSERT INTO Account_Role VALUES(1, 10)
INSERT INTO Account_Role VALUES(1, 8)

SELECT * FROM Role
SELECT * FROM [Subject]

SELECT r.roleid, r.rolename, f.[url] FROM Account a JOIN Account_Role ar ON a.accid = ar.accid
JOIN [Role] r ON r.roleid = ar.roleid JOIN Role_Feature rf ON r.roleid = rf.roleid
JOIN Feature f ON f.feaid = rf.feaid 

--Lay thong tin diem danh cua sinh vien
SELECT stu.[sid], ss.[date], g.gname, sl.slid, r.rname,
l.lid, att.[status], att.[description] FROM [Session] ss
INNER JOIN [Group] g ON g.gid = ss.gid
INNER JOIN Lecture l ON l.lid = g.pic
INNER JOIN Room r ON r.rid = ss.rid
INNER JOIN Slot sl ON sl.slid = ss.slid
INNER JOIN Group_Student gs ON g.gid = gs.gid
INNER JOIN Student stu ON stu.[sid] = gs.[sid] LEFT JOIN Attendance att
ON stu.[sid] = att.[sid] AND ss.sesid = att.sesid
INNER JOIN [Subject] sub ON sub.subid = g.subid
WHERE stu.[sid] = ? AND sub.subid = ?
ORDER BY ss.[date]

--lay ra tat ca cac ki
SELECT * FROM Term

SELECT * FROM [Subject] sub
INNER JOIN TrainingDepartment td ON td.trid = sub.trid
INNER JOIN Term t ON t.teid = td.teid
Where t.teid = 2;

--lay thong tin diem danh cua sinh vien dua tren cac ki
SELECT stu.[sid], g.gname, ss.[date], att.[status], sub.subname FROM [Session] ss
INNER JOIN [Group] g ON g.gid = ss.gid
INNER JOIN Lecture l ON l.lid = g.pic
INNER JOIN Room r ON r.rid = ss.rid
INNER JOIN Slot sl ON sl.slid = ss.slid
INNER JOIN Group_Student gs ON g.gid = gs.gid
INNER JOIN Student stu ON stu.[sid] = gs.[sid] LEFT JOIN Attendance att
ON stu.[sid] = att.[sid] AND ss.sesid = att.sesid
INNER JOIN [Subject] sub ON sub.subid = g.subid
INNER JOIN TrainingDepartment td ON td.trid = sub.trid
INNER JOIN Term t ON t.teid = td. WHERE stu.[sid] = 'HE131355' AND t.teid = 1 AND sub.subid = 1;

SELECT * FROM Role
--lay danh sach cac group dua tren giang vien va mon hoc giang vien dang day
SELECT g.gid, g.gname FROM [Group] g INNER JOIN Lecture l ON l.lid = g.pic
INNER JOIN [Subject] sub ON sub.subid = g.subid
WHERE l.lid = 'FU884370' AND sub.subid = 1 AND g.teid = 1

--roi lay thong tin diem danh dua tren giang vien, group va mon hoc
SELECT * FROM Lecture l INNER JOIN [Group] g ON l.lid = g.pic
INNER JOIN [Session] ss ON g.gid = ss.gid 
INNER JOIN [Subject] sub ON sub.subid = g.subid
INNER JOIN Group_Student gs ON g.gid = gs.gid
INNER JOIN Student stu ON stu.[sid] = gs.[sid]
LEFT JOIN Attendance att ON stu.[sid] = att.[sid] AND ss.sesid = att.sesid
WHERE l.lid = 'FU884370' AND sub.subid = 1 AND g.gid = 1
SELECT * FROM Attendance

SELECT * FROM TrainingDepartment td JOIN Term_TrainingDepartment ttd ON td.trid = ttd.trid
JOIN Term t ON t.teid = ttd.teid

SELECT stu.[sid], stu.sname, ss.[date], ss.sesid, g.gname, sl.slid, r.rname,
l.lid, att.[status], att.[description] FROM [Session] ss
                    INNER JOIN [Group] g ON g.gid = ss.gid
                   INNER JOIN Lecture l ON l.lid = g.pic
                    INNER JOIN Room r ON r.rid = ss.rid
                    INNER JOIN Slot sl ON sl.slid = ss.slid
                   INNER JOIN Group_Student gs ON g.gid = gs.gid
                    INNER JOIN Student stu ON stu.[sid] = gs.[sid] LEFT JOIN Attendance att
                    ON stu.[sid] = att.[sid] AND ss.sesid = att.sesid
                    INNER JOIN [Subject] sub ON sub.subid = g.subid
					INNER JOIN TrainingDepartment td ON td.trid = sub.trid
					INNER JOIN Term_TrainingDepartment ttd ON td.trid = ttd.trid
					INNER JOIN Term t ON t.teid = ttd.teid AND t.teid = g.teid
					  WHERE stu.[sid] = 'HE861653' AND sub.subid = 1  AND g.teid = 1
                    ORDER BY ss.[date]

--lay thong tin diem danh cua lop cho giang vien dua tren mon hoc va ki
SELECT stu.[sid], stu.sname, ss.[date], g.gname, sl.slid, r.rname,
l.lid, att.[status], att.[description] FROM [Session] ss
 INNER JOIN [Group] g ON g.gid = ss.gid
                   INNER JOIN Lecture l ON l.lid = g.pic
                    INNER JOIN Room r ON r.rid = ss.rid
                    INNER JOIN Slot sl ON sl.slid = ss.slid
                   INNER JOIN Group_Student gs ON g.gid = gs.gid
                    INNER JOIN Student stu ON stu.[sid] = gs.[sid] LEFT JOIN Attendance att
                    ON stu.[sid] = att.[sid] AND ss.sesid = att.sesid
                    INNER JOIN [Subject] sub ON sub.subid = g.subid
					INNER JOIN TrainingDepartment td ON td.trid = sub.trid
					INNER JOIN Term_TrainingDepartment ttd ON td.trid = ttd.trid
					INNER JOIN Term t ON t.teid = ttd.teid AND t.teid = g.teid
WHERE l.lid = 'FU884370' AND sub.subid = 1 AND g.gid = 1


SELECT stu.[sid], stu.sname,
       COUNT(DISTINCT ss.sesid) AS total_sessions
FROM [Session] ss
INNER JOIN [Group] g ON g.gid = ss.gid
INNER JOIN Group_Student gs ON g.gid = gs.gid
INNER JOIN Student stu ON stu.[sid] = gs.[sid]
LEFT JOIN Attendance att ON stu.[sid] = att.[sid] AND ss.sesid = att.sesid
INNER JOIN Lecture l ON l.lid = g.pic
INNER JOIN Room r ON r.rid = ss.rid
INNER JOIN Slot sl ON sl.slid = ss.slid
INNER JOIN [Subject] sub ON sub.subid = g.subid
INNER JOIN TrainingDepartment td ON td.trid = sub.trid
INNER JOIN Term_TrainingDepartment ttd ON td.trid = ttd.trid
INNER JOIN Term t ON t.teid = ttd.teid AND t.teid = g.teid
WHERE stu.[sid] = 'HE861653' AND sub.subid = 1 AND g.teid = 1
GROUP BY stu.[sid], stu.sname
ORDER BY total_sessions DESC;

SELECT stu.[sid], stu.sname,
       COUNT(CASE WHEN att.[status] = 'absent' THEN 1 END) AS num_absent,
       COUNT(DISTINCT ss.sesid) AS total_sessions
FROM [Session] ss
INNER JOIN [Group] g ON g.gid = ss.gid
INNER JOIN Group_Student gs ON g.gid = gs.gid
INNER JOIN Student stu ON stu.[sid] = gs.[sid]
LEFT JOIN Attendance att ON stu.[sid] = att.[sid] AND ss.sesid = att.sesid
INNER JOIN Lecture l ON l.lid = g.pic
INNER JOIN Room r ON r.rid = ss.rid
INNER JOIN Slot sl ON sl.slid = ss.slid
INNER JOIN [Subject] sub ON sub.subid = g.subid
INNER JOIN TrainingDepartment td ON td.trid = sub.trid
INNER JOIN Term_TrainingDepartment ttd ON td.trid = ttd.trid
INNER JOIN Term t ON t.teid = ttd.teid AND t.teid = g.teid
WHERE sub.subid = 3 AND g.teid = 1 AND g.gid = 3 AND g.pic = 'FU484522'
GROUP BY stu.[sid], stu.sname
ORDER BY stu.[sid]
SELECT * FROM Subject s where s.subid = 1
SELECT * FROM Account


SELECT s.[sid], s.sname, l.lid, l.lname, att.atid, att.[status], att.[description], att.[dateTime] FROM
                    Student s JOIN Group_Student gr ON s.[sid] = gr.[sid]
                    INNER JOIN [Group] g ON g.gid = gr.gid 
					INNER JOIN [Session] ss ON g.gid = ss.gid
                    INNER JOIN Lecture l ON l.lid = g.pic
                   LEFT JOIN Attendance att ON ss.sesid = att.sesid AND s.[sid] = att.[sid]
                    WHERE ss.sesid = 30





					SELECT g.gid, g.gname FROM [Group] g INNER JOIN Lecture l ON l.lid = g.pic
                    INNER JOIN [Subject] sub ON sub.subid = g.subid               WHERE l.lid = 'FU888370' AND sub.subid = 7 AND g.teid = 2

					SELECT DISTINCT sub.subid, sub.subname FROM [Subject] sub
    INNER JOIN TrainingDepartment td ON td.trid = sub.trid
                    INNER JOIN Term_TrainingDepartment ttd ON td.trid = ttd.trid INNER JOIN 
                    Term t ON t.teid = ttd.teid
					INNER JOIN [Group] g ON sub.subid = g.subid
					INNER JOIN Lecture l ON l.lid = g.pic
                    Where t.teid = 1 AND l.lid = 'FU884370' and g.teid = 1

					SELECT * FROM [Subject] sub JOIN Assesment a ON sub.subid = a.subid

					SELECT * FROM [Subject] sub JOIN TrainingDepartment td ON td.trid = sub.trid
					WHERE td.trid = ?

SELECT ass.asname, ass.[weight], ass.[description] FROM Assesment ass JOIN [Subject] sub ON sub.subid = ass.subid
WHERE sub.subid = 1


UPDATE Session
SET isAttended = NULL

SELECT * FROM
                   Student s JOIN Group_Student gr ON s.[sid] = gr.[sid]
                    INNER JOIN [Group] g ON g.gid = gr.gid INNER JOIN [Session] ss ON g.gid = ss.gid
                    INNER JOIN Lecture l ON l.lid = g.pic
                    LEFT JOIN Attendance att ON ss.sesid = att.sesid AND s.[sid] = att.[sid]
                    WHERE ss.sesid = 28

					SELECT * FROM Attendance
					INSERT INTO Attendance(sesid, [sid], [dateTime], [status], [description]) VALUES(?, ?, GETDATE(), ?, ?)
					
					SELECT * FROM Session
					
					UPDATE [Session] SET isAttended = 1 WHERE sesid = ?
					
					UPDATE Attendance
					SET sesid = ?, [sid] = ?, [dateTime] = GETDATE(), [status] = ?, [description] = ?
					WHERE sesid = ?

					DELETE FROM Attendance WHERE sesid = ?
					

					SELECT * FROM Student stu JOIN Group_Student gs ON stu.[sid] = gs.[sid]
					JOIN [Group] g ON g.gid = gs.gid JOIN [Subject] sub ON sub.subid = g.subid
				    JOIN TrainingDepartment td ON td.trid = sub.trid JOIN Term_TrainingDepartment ttd 
					ON td.trid = ttd.trid JOIN Term t ON t.teid = ttd.teid AND g.teid = t.teid
					JOIN Lecture l ON l.lid = g.pic JOIN [Session] ss ON l.lid = ss.lid AND g.gid = ss.gid
					WHERE stu.[sid] = 'HE131355' AND sub.subid = 3 AND g.teid = 1
								

			
SELECT sub.subid, sub.subname, t.teid, t.tename , g.gname, MIN(ss.date) AS [start_date], MAX(ss.date) AS [end_date]
FROM Student stu 
JOIN Group_Student gs ON stu.sid = gs.sid
JOIN [Group] g ON g.gid = gs.gid 
JOIN [Subject] sub ON sub.subid = g.subid
JOIN TrainingDepartment td ON td.trid = sub.trid 
JOIN Term_TrainingDepartment ttd ON td.trid = ttd.trid 
 JOIN Term t ON t.teid = ttd.teid AND g.teid = t.teid
JOIN Lecture l ON l.lid = g.pic 
 JOIN [Session] ss ON l.lid = ss.lid AND g.gid = ss.gid
WHERE stu.sid = 'HE131355'
GROUP BY sub.subid, sub.subname, t.teid, t.tename, g.gname

SELECT * FROM [Subject] sub JOIN [Group] g ON sub.subid = g.subid
JOIN Lecture l ON l.lid = g.pic JOIN [Session] ss ON l.lid = ss.lid
WHERE sub.subid = 1;

SELECT *  FROM [Subject] sub JOIN Assesment ass ON sub.subid = ass.subid
JOIN [Group] gr ON sub.subid = gr.subid JOIN Group_Student gs ON gr.gid = gs.gid
JOIN Student stu ON stu.[sid] = gs.[sid] LEFT JOIN Grade g ON ass.asid = g.asid AND sub.subid = g.subid
AND stu.[sid] = g.[sid] JOIN [Session] ss ON gr.gid = ss.gid JOIN Lecture l ON l.lid = gr.pic
LEFT JOIN Attendance att ON ss.sesid = att.sesid AND stu.[sid] = att.[sid]
WHERE sub.subid = 1 AND gr.teid = 1 AND gr.gid = 1 ORDER BY ss.date

SELECT stu.[sid], stu.[sname], SUM(ass.[weight] * g.score / 100) AS avg_grade
FROM [Subject] sub 
JOIN Assesment ass ON sub.subid = ass.subid
JOIN [Group] gr ON sub.subid = gr.subid 
JOIN Group_Student gs ON gr.gid = gs.gid
JOIN Student stu ON stu.[sid] = gs.[sid] 
LEFT JOIN Grade g ON ass.asid = g.asid AND sub.subid = g.subid AND stu.[sid] = g.[sid]
WHERE sub.subid = 1 AND gr.teid = 1 AND gr.gid = 1
GROUP BY stu.[sid], stu.[sname]

SELECT * FROM Assesment ass JOIN [Subject] sub ON sub.subid = ass.subid
WHERE sub.subid = 1

SELECT * FROM Role r where r.rolename != 'Admin' 

SELECT * FROM Student stu WHERE stu.sname LIKE '%Vien %'

WITH RankedGrades AS (
    SELECT g.*, 
           ROW_NUMBER() OVER(PARTITION BY g.asid ORDER BY g.score DESC) AS rank
     FROM [Subject] sub JOIN Assesment ass ON sub.subid = ass.subid JOIN Grade g ON ass.asid = g.asid AND sub.subid = g.subid
)
SELECT rg.*
FROM RankedGrades rg
WHERE rg.rank = 1;

SELECT ass.asid, ass.asname, ass.[weight], ass.[description], sub.subname, g.score FROM [Subject] sub JOIN Assesment ass ON sub.subid = ass.subid
                    JOIN [Group] gr ON sub.subid = gr.subid JOIN Group_Student gs ON gr.gid = gs.gid
                    JOIN Student stu ON stu.[sid] = gs.[sid] LEFT JOIN Grade g ON ass.asid = g.asid AND sub.subid = g.subid
                   AND stu.[sid] = g.[sid]
                    WHERE sub.subid = ? AND stu.[sid] = ?

UPDATE Session
SET isAttended = 0

SELECT * FROM Session


SELECT stu.[sid], stu.sname, ss.[date], g.gname, sl.slid, r.rname, ss.isAttended,
                    l.lid, att.[status], att.[description] FROM [Session] ss
                    INNER JOIN [Group] g ON g.gid = ss.gid
                    INNER JOIN Lecture l ON l.lid = g.pic
                    INNER JOIN Room r ON r.rid = ss.rid
                    INNER JOIN Slot sl ON sl.slid = ss.slid
                    INNER JOIN Group_Student gs ON g.gid = gs.gid
                    INNER JOIN Student stu ON stu.[sid] = gs.[sid] LEFT JOIN Attendance att
                    ON stu.[sid] = att.[sid] AND ss.sesid = att.sesid
                    INNER JOIN [Subject] sub ON sub.subid = g.subid
                    	INNER JOIN TrainingDepartment td ON td.trid = sub.trid
                    INNER JOIN Term_TrainingDepartment ttd ON td.trid = ttd.trid
                    	INNER JOIN Term t ON t.teid = ttd.teid AND t.teid = g.teid
                    	WHERE stu.[sid] = 'HE131355' AND sub.subid = 1 AND g.teid = 1
                    ORDER BY ss.[date]

					SELECT * FROM [Role] r WHERE r.rolename != 'Admin'

					INSERT INTO Account_Role(accid, roleid) VALUES()