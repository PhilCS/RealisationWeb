USE [MVP]
GO
SET IDENTITY_INSERT [dbo].[SONDAGE] ON 

INSERT [dbo].[SONDAGE] ([NOM], [QUESTION], [DATEDEBUT], [DATEFIN], [IDCREATEUR], [IDSECTEUR], [NOMTRAD], [QUESTIONTRAD]) VALUES (11, N'Pommes', N'Aimez-vous les pommes', CAST(0x0000A28F00000000 AS DateTime), CAST(0x0000A2A500000000 AS DateTime), 1, 1, N'Apples', N'Do you like apples?')
INSERT [dbo].[SONDAGE] ([NOM], [QUESTION], [DATEDEBUT], [DATEFIN], [IDCREATEUR], [IDSECTEUR], [NOMTRAD], [QUESTIONTRAD]) VALUES (12, N'Ciment', N'Quelle sorte de ciment pr�f�rez-vous?', CAST(0x0000A28F00000000 AS DateTime), CAST(0x0000A2A500000000 AS DateTime), 1, 2, N'Cement', N'What type of cement do you prefer?')
SET IDENTITY_INSERT [dbo].[SONDAGE] OFF
SET IDENTITY_INSERT [dbo].[CHOIXSONDAGE] ON 

INSERT [dbo].[CHOIXSONDAGE] ([ID], [IDSONDAGE], [VALEUR], [VALEURTRAD]) VALUES (3, 11, N'Oui', N'Yes')
INSERT [dbo].[CHOIXSONDAGE] ([ID], [IDSONDAGE], [VALEUR], [VALEURTRAD]) VALUES (4, 11, N'Non', N'No')
INSERT [dbo].[CHOIXSONDAGE] ([ID], [IDSONDAGE], [VALEUR], [VALEURTRAD]) VALUES (5, 12, N'Portland', N'Portland')
INSERT [dbo].[CHOIXSONDAGE] ([ID], [IDSONDAGE], [VALEUR], [VALEURTRAD]) VALUES (6, 12, N'Rosendale', N'Rosendale')
INSERT [dbo].[CHOIXSONDAGE] ([ID], [IDSONDAGE], [VALEUR], [VALEURTRAD]) VALUES (7, 12, N'Massonerie', N'Masonry')
SET IDENTITY_INSERT [dbo].[CHOIXSONDAGE] OFF

INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (3, 1)
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (3, 6)
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (5, 7)
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (6, 1)
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (6, 3)
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (7, 4)
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (8, 1)
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (10, 1)
