USE [tecnical_test_stone]
GO
	/****** Object:  Table [dbo].[BranchOffice]    Script Date: 11/6/2024 12:06:56 PM ******/
SET
	ANSI_NULLS ON
GO
SET
	QUOTED_IDENTIFIER ON
GO
	CREATE TABLE [dbo].[BranchOffice](
		[id_broff] [bigint] IDENTITY(1, 1) NOT NULL,
		[company_id] [bigint] NOT NULL,
		[broff_name] [nvarchar](255) NOT NULL,
		[broff_code] [nvarchar](255) NOT NULL,
		[broff_address] [nvarchar](255) NOT NULL,
		[broff_city] [nvarchar](255) NOT NULL,
		[broff_state] [nvarchar](255) NOT NULL,
		[broff_country] [nvarchar](255) NOT NULL,
		[broff_phone] [nvarchar](255) NOT NULL,
		[broff_email] [nvarchar](255) NOT NULL,
		[broff_active] [bit] NOT NULL,
		PRIMARY KEY CLUSTERED ([id_broff] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY],
		CONSTRAINT [UQ_Company_BranchCode] UNIQUE NONCLUSTERED ([company_id] ASC, [broff_code] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY]
	) ON [PRIMARY]
GO
	/****** Object:  Table [dbo].[Company]    Script Date: 11/6/2024 12:06:56 PM ******/
SET
	ANSI_NULLS ON
GO
SET
	QUOTED_IDENTIFIER ON
GO
	CREATE TABLE [dbo].[Company](
		[id_compa] [bigint] IDENTITY(1, 1) NOT NULL,
		[compa_name] [nvarchar](255) NOT NULL,
		[compa_tradename] [nvarchar](255) NOT NULL,
		[compa_doctype] [nvarchar](2) NOT NULL,
		[compa_docnum] [nvarchar](255) NOT NULL,
		[compa_address] [nvarchar](255) NOT NULL,
		[compa_city] [nvarchar](255) NOT NULL,
		[compa_state] [nvarchar](255) NOT NULL,
		[compa_country] [nvarchar](255) NOT NULL,
		[compa_industry] [nvarchar](255) NOT NULL,
		[compa_phone] [nvarchar](255) NOT NULL,
		[compa_email] [nvarchar](255) NOT NULL,
		[compa_website] [nvarchar](255) NULL,
		[compa_logo] [nvarchar](max) NULL,
		[compa_active] [bit] NOT NULL,
		PRIMARY KEY CLUSTERED ([id_compa] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
	/****** Object:  Table [dbo].[CostCenter]    Script Date: 11/6/2024 12:06:56 PM ******/
SET
	ANSI_NULLS ON
GO
SET
	QUOTED_IDENTIFIER ON
GO
	CREATE TABLE [dbo].[CostCenter](
		[id_cosce] [bigint] IDENTITY(1, 1) NOT NULL,
		[company_id] [bigint] NOT NULL,
		[cosce_parent_id] [bigint] NULL,
		[cosce_code] [nvarchar](255) NOT NULL,
		[cosce_name] [nvarchar](255) NOT NULL,
		[cosce_description] [nvarchar](max) NULL,
		[cosce_budget] [decimal](15, 2) NOT NULL,
		[cosce_level] [smallint] NOT NULL,
		[cosce_active] [bit] NOT NULL,
		PRIMARY KEY CLUSTERED ([id_cosce] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY],
		CONSTRAINT [UQ_Company_CostCenterCode] UNIQUE NONCLUSTERED ([company_id] ASC, [cosce_code] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
	/****** Object:  Table [dbo].[EntityCatalog]    Script Date: 11/6/2024 12:06:56 PM ******/
SET
	ANSI_NULLS ON
GO
SET
	QUOTED_IDENTIFIER ON
GO
	CREATE TABLE [dbo].[EntityCatalog](
		[id_entit] [int] IDENTITY(1, 1) NOT NULL,
		[entit_name] [nvarchar](255) NOT NULL,
		[entit_descrip] [nvarchar](255) NOT NULL,
		[entit_active] [bit] NOT NULL,
		[entit_config] [nvarchar](max) NULL,
		PRIMARY KEY CLUSTERED ([id_entit] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY],
		UNIQUE NONCLUSTERED ([entit_name] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
	/****** Object:  Table [dbo].[PermiRole]    Script Date: 11/6/2024 12:06:56 PM ******/
SET
	ANSI_NULLS ON
GO
SET
	QUOTED_IDENTIFIER ON
GO
	CREATE TABLE [dbo].[PermiRole](
		[id_perol] [bigint] IDENTITY(1, 1) NOT NULL,
		[role_id] [bigint] NOT NULL,
		[permission_id] [bigint] NOT NULL,
		[entitycatalog_id] [int] NOT NULL,
		[perol_include] [bit] NOT NULL,
		PRIMARY KEY CLUSTERED ([id_perol] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY],
		CONSTRAINT [UQ_Role_Permission] UNIQUE NONCLUSTERED (
			[role_id] ASC,
			[permission_id] ASC,
			[entitycatalog_id] ASC
		) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY]
	) ON [PRIMARY]
GO
	/****** Object:  Table [dbo].[PermiRoleRecord]    Script Date: 11/6/2024 12:06:56 PM ******/
SET
	ANSI_NULLS ON
GO
SET
	QUOTED_IDENTIFIER ON
GO
	CREATE TABLE [dbo].[PermiRoleRecord](
		[id_perrc] [bigint] IDENTITY(1, 1) NOT NULL,
		[role_id] [bigint] NOT NULL,
		[permission_id] [bigint] NOT NULL,
		[entitycatalog_id] [int] NOT NULL,
		[perrc_record] [bigint] NOT NULL,
		[perrc_include] [bit] NOT NULL,
		PRIMARY KEY CLUSTERED ([id_perrc] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY],
		CONSTRAINT [UQ_Role_Permission_Entity_Record] UNIQUE NONCLUSTERED (
			[role_id] ASC,
			[permission_id] ASC,
			[entitycatalog_id] ASC,
			[perrc_record] ASC
		) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY]
	) ON [PRIMARY]
GO
	/****** Object:  Table [dbo].[Permission]    Script Date: 11/6/2024 12:06:56 PM ******/
SET
	ANSI_NULLS ON
GO
SET
	QUOTED_IDENTIFIER ON
GO
	CREATE TABLE [dbo].[Permission](
		[id_permi] [bigint] IDENTITY(1, 1) NOT NULL,
		[name] [nvarchar](255) NOT NULL,
		[description] [nvarchar](max) NULL,
		[can_create] [bit] NOT NULL,
		[can_read] [bit] NOT NULL,
		[can_update] [bit] NOT NULL,
		[can_delete] [bit] NOT NULL,
		[can_import] [bit] NOT NULL,
		[can_export] [bit] NOT NULL,
		PRIMARY KEY CLUSTERED ([id_permi] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
	/****** Object:  Table [dbo].[PermiUser]    Script Date: 11/6/2024 12:06:56 PM ******/
SET
	ANSI_NULLS ON
GO
SET
	QUOTED_IDENTIFIER ON
GO
	CREATE TABLE [dbo].[PermiUser](
		[id_peusr] [bigint] IDENTITY(1, 1) NOT NULL,
		[usercompany_id] [bigint] NOT NULL,
		[permission_id] [bigint] NOT NULL,
		[entitycatalog_id] [int] NOT NULL,
		[peusr_include] [bit] NOT NULL,
		PRIMARY KEY CLUSTERED ([id_peusr] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY],
		CONSTRAINT [UQ_UserCompany_Permission_Entity] UNIQUE NONCLUSTERED (
			[usercompany_id] ASC,
			[permission_id] ASC,
			[entitycatalog_id] ASC
		) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY]
	) ON [PRIMARY]
GO
	/****** Object:  Table [dbo].[PermiUserRecord]    Script Date: 11/6/2024 12:06:56 PM ******/
SET
	ANSI_NULLS ON
GO
SET
	QUOTED_IDENTIFIER ON
GO
	CREATE TABLE [dbo].[PermiUserRecord](
		[id_peusr] [bigint] IDENTITY(1, 1) NOT NULL,
		[usercompany_id] [bigint] NOT NULL,
		[permission_id] [bigint] NOT NULL,
		[entitycatalog_id] [int] NOT NULL,
		[peusr_record] [bigint] NOT NULL,
		[peusr_include] [bit] NOT NULL,
		PRIMARY KEY CLUSTERED ([id_peusr] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY],
		CONSTRAINT [UQ_UserCompany_Permission_Entity_Record] UNIQUE NONCLUSTERED (
			[usercompany_id] ASC,
			[permission_id] ASC,
			[entitycatalog_id] ASC,
			[peusr_record] ASC
		) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY]
	) ON [PRIMARY]
GO
	/****** Object:  Table [dbo].[Role]    Script Date: 11/6/2024 12:06:56 PM ******/
SET
	ANSI_NULLS ON
GO
SET
	QUOTED_IDENTIFIER ON
GO
	CREATE TABLE [dbo].[Role](
		[id_role] [bigint] IDENTITY(1, 1) NOT NULL,
		[company_id] [bigint] NOT NULL,
		[role_name] [nvarchar](255) NOT NULL,
		[role_code] [nvarchar](255) NOT NULL,
		[role_description] [nvarchar](max) NULL,
		[role_active] [bit] NOT NULL,
		PRIMARY KEY CLUSTERED ([id_role] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY],
		CONSTRAINT [UQ_Company_RoleCode] UNIQUE NONCLUSTERED ([company_id] ASC, [role_code] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
	/****** Object:  Table [dbo].[User]    Script Date: 11/6/2024 12:06:56 PM ******/
SET
	ANSI_NULLS ON
GO
SET
	QUOTED_IDENTIFIER ON
GO
	CREATE TABLE [dbo].[User](
		[id_user] [bigint] IDENTITY(1, 1) NOT NULL,
		[user_username] [nvarchar](255) NOT NULL,
		[user_password] [nvarchar](255) NOT NULL,
		[user_email] [nvarchar](255) NOT NULL,
		[user_phone] [nvarchar](255) NULL,
		[user_is_admin] [bit] NOT NULL,
		[user_is_active] [bit] NOT NULL,
		PRIMARY KEY CLUSTERED ([id_user] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY],
		CONSTRAINT [UQ_User_Email] UNIQUE NONCLUSTERED ([user_email] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY],
		CONSTRAINT [UQ_User_Username] UNIQUE NONCLUSTERED ([user_username] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY]
	) ON [PRIMARY]
GO
	/****** Object:  Table [dbo].[UserCompany]    Script Date: 11/6/2024 12:06:56 PM ******/
SET
	ANSI_NULLS ON
GO
SET
	QUOTED_IDENTIFIER ON
GO
	CREATE TABLE [dbo].[UserCompany](
		[id_useco] [bigint] IDENTITY(1, 1) NOT NULL,
		[user_id] [bigint] NOT NULL,
		[company_id] [bigint] NOT NULL,
		[useco_active] [bit] NOT NULL,
		PRIMARY KEY CLUSTERED ([id_useco] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY],
		CONSTRAINT [UQ_User_Company] UNIQUE NONCLUSTERED ([user_id] ASC, [company_id] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON,
			OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
		) ON [PRIMARY]
	) ON [PRIMARY]
GO
ALTER TABLE
	[dbo].[BranchOffice]
ADD
	DEFAULT ((1)) FOR [broff_active]
GO
ALTER TABLE
	[dbo].[Company]
ADD
	DEFAULT ((1)) FOR [compa_active]
GO
ALTER TABLE
	[dbo].[CostCenter]
ADD
	DEFAULT ((0)) FOR [cosce_budget]
GO
ALTER TABLE
	[dbo].[CostCenter]
ADD
	DEFAULT ((1)) FOR [cosce_level]
GO
ALTER TABLE
	[dbo].[CostCenter]
ADD
	DEFAULT ((1)) FOR [cosce_active]
GO
ALTER TABLE
	[dbo].[EntityCatalog]
ADD
	DEFAULT ((1)) FOR [entit_active]
GO
ALTER TABLE
	[dbo].[PermiRole]
ADD
	DEFAULT ((1)) FOR [perol_include]
GO
ALTER TABLE
	[dbo].[PermiRoleRecord]
ADD
	DEFAULT ((1)) FOR [perrc_include]
GO
ALTER TABLE
	[dbo].[Permission]
ADD
	DEFAULT ((0)) FOR [can_create]
GO
ALTER TABLE
	[dbo].[Permission]
ADD
	DEFAULT ((0)) FOR [can_read]
GO
ALTER TABLE
	[dbo].[Permission]
ADD
	DEFAULT ((0)) FOR [can_update]
GO
ALTER TABLE
	[dbo].[Permission]
ADD
	DEFAULT ((0)) FOR [can_delete]
GO
ALTER TABLE
	[dbo].[Permission]
ADD
	DEFAULT ((0)) FOR [can_import]
GO
ALTER TABLE
	[dbo].[Permission]
ADD
	DEFAULT ((0)) FOR [can_export]
GO
ALTER TABLE
	[dbo].[PermiUser]
ADD
	DEFAULT ((1)) FOR [peusr_include]
GO
ALTER TABLE
	[dbo].[PermiUserRecord]
ADD
	DEFAULT ((1)) FOR [peusr_include]
GO
ALTER TABLE
	[dbo].[Role]
ADD
	DEFAULT ((1)) FOR [role_active]
GO
ALTER TABLE
	[dbo].[User]
ADD
	DEFAULT ((0)) FOR [user_is_admin]
GO
ALTER TABLE
	[dbo].[User]
ADD
	DEFAULT ((1)) FOR [user_is_active]
GO
ALTER TABLE
	[dbo].[UserCompany]
ADD
	DEFAULT ((1)) FOR [useco_active]
GO
ALTER TABLE
	[dbo].[BranchOffice] WITH CHECK
ADD
	CONSTRAINT [FK_BranchOffice_Company] FOREIGN KEY([company_id]) REFERENCES [dbo].[Company] ([id_compa])
GO
ALTER TABLE
	[dbo].[BranchOffice] CHECK CONSTRAINT [FK_BranchOffice_Company]
GO
ALTER TABLE
	[dbo].[CostCenter] WITH CHECK
ADD
	CONSTRAINT [FK_CostCenter_Company] FOREIGN KEY([company_id]) REFERENCES [dbo].[Company] ([id_compa])
GO
ALTER TABLE
	[dbo].[CostCenter] CHECK CONSTRAINT [FK_CostCenter_Company]
GO
ALTER TABLE
	[dbo].[CostCenter] WITH CHECK
ADD
	CONSTRAINT [FK_CostCenter_Parent] FOREIGN KEY([cosce_parent_id]) REFERENCES [dbo].[CostCenter] ([id_cosce])
GO
ALTER TABLE
	[dbo].[CostCenter] CHECK CONSTRAINT [FK_CostCenter_Parent]
GO
ALTER TABLE
	[dbo].[PermiRole] WITH CHECK
ADD
	CONSTRAINT [FK_PermiRole_EntityCatalog] FOREIGN KEY([entitycatalog_id]) REFERENCES [dbo].[EntityCatalog] ([id_entit])
GO
ALTER TABLE
	[dbo].[PermiRole] CHECK CONSTRAINT [FK_PermiRole_EntityCatalog]
GO
ALTER TABLE
	[dbo].[PermiRole] WITH CHECK
ADD
	CONSTRAINT [FK_PermiRole_Permission] FOREIGN KEY([permission_id]) REFERENCES [dbo].[Permission] ([id_permi])
GO
ALTER TABLE
	[dbo].[PermiRole] CHECK CONSTRAINT [FK_PermiRole_Permission]
GO
ALTER TABLE
	[dbo].[PermiRole] WITH CHECK
ADD
	CONSTRAINT [FK_PermiRole_Role] FOREIGN KEY([role_id]) REFERENCES [dbo].[Role] ([id_role])
GO
ALTER TABLE
	[dbo].[PermiRole] CHECK CONSTRAINT [FK_PermiRole_Role]
GO
ALTER TABLE
	[dbo].[PermiRoleRecord] WITH CHECK
ADD
	CONSTRAINT [FK_PermiRoleRecord_EntityCatalog] FOREIGN KEY([entitycatalog_id]) REFERENCES [dbo].[EntityCatalog] ([id_entit])
GO
ALTER TABLE
	[dbo].[PermiRoleRecord] CHECK CONSTRAINT [FK_PermiRoleRecord_EntityCatalog]
GO
ALTER TABLE
	[dbo].[PermiRoleRecord] WITH CHECK
ADD
	CONSTRAINT [FK_PermiRoleRecord_Permission] FOREIGN KEY([permission_id]) REFERENCES [dbo].[Permission] ([id_permi])
GO
ALTER TABLE
	[dbo].[PermiRoleRecord] CHECK CONSTRAINT [FK_PermiRoleRecord_Permission]
GO
ALTER TABLE
	[dbo].[PermiRoleRecord] WITH CHECK
ADD
	CONSTRAINT [FK_PermiRoleRecord_Role] FOREIGN KEY([role_id]) REFERENCES [dbo].[Role] ([id_role])
GO
ALTER TABLE
	[dbo].[PermiRoleRecord] CHECK CONSTRAINT [FK_PermiRoleRecord_Role]
GO
ALTER TABLE
	[dbo].[PermiUser] WITH CHECK
ADD
	CONSTRAINT [FK_PermiUser_EntityCatalog] FOREIGN KEY([entitycatalog_id]) REFERENCES [dbo].[EntityCatalog] ([id_entit])
GO
ALTER TABLE
	[dbo].[PermiUser] CHECK CONSTRAINT [FK_PermiUser_EntityCatalog]
GO
ALTER TABLE
	[dbo].[PermiUser] WITH CHECK
ADD
	CONSTRAINT [FK_PermiUser_Permission] FOREIGN KEY([permission_id]) REFERENCES [dbo].[Permission] ([id_permi])
GO
ALTER TABLE
	[dbo].[PermiUser] CHECK CONSTRAINT [FK_PermiUser_Permission]
GO
ALTER TABLE
	[dbo].[PermiUser] WITH CHECK
ADD
	CONSTRAINT [FK_PermiUser_UserCompany] FOREIGN KEY([usercompany_id]) REFERENCES [dbo].[UserCompany] ([id_useco])
GO
ALTER TABLE
	[dbo].[PermiUser] CHECK CONSTRAINT [FK_PermiUser_UserCompany]
GO
ALTER TABLE
	[dbo].[PermiUserRecord] WITH CHECK
ADD
	CONSTRAINT [FK_PermiUserRecord_EntityCatalog] FOREIGN KEY([entitycatalog_id]) REFERENCES [dbo].[EntityCatalog] ([id_entit])
GO
ALTER TABLE
	[dbo].[PermiUserRecord] CHECK CONSTRAINT [FK_PermiUserRecord_EntityCatalog]
GO
ALTER TABLE
	[dbo].[PermiUserRecord] WITH CHECK
ADD
	CONSTRAINT [FK_PermiUserRecord_Permission] FOREIGN KEY([permission_id]) REFERENCES [dbo].[Permission] ([id_permi])
GO
ALTER TABLE
	[dbo].[PermiUserRecord] CHECK CONSTRAINT [FK_PermiUserRecord_Permission]
GO
ALTER TABLE
	[dbo].[PermiUserRecord] WITH CHECK
ADD
	CONSTRAINT [FK_PermiUserRecord_UserCompany] FOREIGN KEY([usercompany_id]) REFERENCES [dbo].[UserCompany] ([id_useco])
GO
ALTER TABLE
	[dbo].[PermiUserRecord] CHECK CONSTRAINT [FK_PermiUserRecord_UserCompany]
GO
ALTER TABLE
	[dbo].[Role] WITH CHECK
ADD
	CONSTRAINT [FK_Role_Company] FOREIGN KEY([company_id]) REFERENCES [dbo].[Company] ([id_compa])
GO
ALTER TABLE
	[dbo].[Role] CHECK CONSTRAINT [FK_Role_Company]
GO
ALTER TABLE
	[dbo].[UserCompany] WITH CHECK
ADD
	CONSTRAINT [FK_UserCompany_Company] FOREIGN KEY([company_id]) REFERENCES [dbo].[Company] ([id_compa])
GO
ALTER TABLE
	[dbo].[UserCompany] CHECK CONSTRAINT [FK_UserCompany_Company]
GO
ALTER TABLE
	[dbo].[UserCompany] WITH CHECK
ADD
	CONSTRAINT [FK_UserCompany_User] FOREIGN KEY([user_id]) REFERENCES [dbo].[User] ([id_user])
GO
ALTER TABLE
	[dbo].[UserCompany] CHECK CONSTRAINT [FK_UserCompany_User]
GO
ALTER TABLE
	[dbo].[Company] WITH CHECK
ADD
	CONSTRAINT [CK_Company_DocType] CHECK (
		(
			[compa_doctype] = 'OT'
			OR [compa_doctype] = 'PP'
			OR [compa_doctype] = 'CE'
			OR [compa_doctype] = 'CC'
			OR [compa_doctype] = 'NI'
		)
	)
GO
ALTER TABLE
	[dbo].[Company] CHECK CONSTRAINT [CK_Company_DocType]
GO
ALTER TABLE
	[dbo].[CostCenter] WITH CHECK
ADD
	CONSTRAINT [CK_CostCenter_Level] CHECK (([cosce_level] >(0)))
GO
ALTER TABLE
	[dbo].[CostCenter] CHECK CONSTRAINT [CK_CostCenter_Level]
GO