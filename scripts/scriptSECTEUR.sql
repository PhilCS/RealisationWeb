USE [MVP]
ALTER TABLE [dbo].[SECTEUR]
ADD [NOMTRAD] [varchar](40) NOT NULL DEFAULT ''
GO
ALTER TABLE [dbo].[SECTEUR]
ADD [TITREACCUEILTRAD] [varchar](40) NOT NULL DEFAULT ''
GO
ALTER TABLE [dbo].[SECTEUR]
ADD [TEXTEACCUEILTRAD] [text] NOT NULL DEFAULT ''
GO
UPDATE [dbo].[SECTEUR] SET NOMTRAD = N'Agriculture', TITREACCUEILTRAD = N'Home', TEXTEACCUEILTRAD = N'texte traduit' WHERE ID = 1
UPDATE [dbo].[SECTEUR] SET NOMTRAD = N'Civil Construction', TITREACCUEILTRAD = N'Home', TEXTEACCUEILTRAD = N'texte traduit' WHERE ID = 2
UPDATE [dbo].[SECTEUR] SET NOMTRAD = N'Tourism', TITREACCUEILTRAD = N'Home', TEXTEACCUEILTRAD = N'texte traduit' WHERE ID = 3
UPDATE [dbo].[SECTEUR] SET NOMTRAD = N'Accounting', TITREACCUEILTRAD = N'Home', TEXTEACCUEILTRAD = N'texte traduit' WHERE ID = 4
GO
TRUNCATE TABLE [dbo].[UTILISATEURSECTEUR]
GO
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (1, 1, CAST(0xB9340B00 AS Date), CAST(0x19380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (1, 2, CAST(0xB9340B00 AS Date), CAST(0x19380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (1, 3, CAST(0xB9340B00 AS Date), CAST(0x19380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (1, 11, CAST(0xB9340B00 AS Date), CAST(0x19380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (2, 1, CAST(0x86320B00 AS Date), CAST(0xB8380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (3, 2, CAST(0x77320B00 AS Date), CAST(0x96380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (4, 3, CAST(0xE4330B00 AS Date), CAST(0xB6380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (5, 2, CAST(0xE9320B00 AS Date), CAST(0xDA380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (5, 3, CAST(0x22350B00 AS Date), CAST(0x85380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (6, 1, CAST(0xA9330B00 AS Date), CAST(0x25380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (6, 3, CAST(0x3E360B00 AS Date), CAST(0x4F380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (7, 1, CAST(0xFA350B00 AS Date), CAST(0x8C380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (7, 11, CAST(0x95320B00 AS Date), CAST(0x27390B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (8, 3, CAST(0x7D320B00 AS Date), CAST(0xCF380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (8, 11, CAST(0xD4320B00 AS Date), CAST(0x7C380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (9, 2, CAST(0x87350B00 AS Date), CAST(0xA2380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (9, 3, CAST(0x67330B00 AS Date), CAST(0x5F390B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (10, 11, CAST(0xAF320B00 AS Date), CAST(0x61390B00 AS Date))
GO
TRUNCATE TABLE [dbo].[webpages_UsersInRoles]
GO
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (1, 1)
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (2, 2)
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (3, 3)
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (4, 4)
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (5, 2)
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (6, 2)
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (7, 2)
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (8, 2)
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (9, 3)
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (10, 3)
