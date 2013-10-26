/****** À FAIRE EXÉCUTER DANS LA BD *******/

CREATE PROCEDURE [dbo].[GetNouvelle]
	@idNouvelle int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM NOUVELLE WHERE ID = @idNouvelle
END

USE [MVP]
GO
/****** Object:  StoredProcedure [dbo].[GetNouvelles]    Script Date: 2013-10-24 22:20:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetNouvelles]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM NOUVELLE ORDER BY DATEPUBLICATION DESC;
END

CREATE PROCEDURE [dbo].[GetRechercheNouvelle]
	@rech varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM NOUVELLE WHERE TITRE LIKE '%' + @rech + '%' OR DESCRIPTION LIKE '%' + @rech + '%' COLLATE SQL_Latin1_General_CP1_CI_AS;
END

Alter table NOUVELLE
alter column titre varchar(100) not null

CREATE PROCEDURE [dbo].[GetMessagesSupprimes]
	@idUtil int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT MP.ID AS IDMESSAGE, MP.CONTENU, MP.DATEENVOI, MP.SUJET,
	DM.LU, PJ.ID AS IDPIECE, U.PRENOM + ' ' + U.NOM AS NOMEXPED
	FROM MESSAGEPRIVE MP
	LEFT JOIN DESTINATAIREMESSAGE DM ON MP.ID = DM.IDMESSAGE
	LEFT JOIN PIECEJOINTE PJ ON MP.ID = PJ.IDMESSAGE
	INNER JOIN UTILISATEUR U ON MP.IDEXPEDITEUR = U.ID
	WHERE (DM.SUPPRIME = 1 AND DM.SUPPRIMEDEFINITIF = 0 AND DM.IDUTILISATEUR = @idUtil)
	OR (MP.SUPPRIME = 1 AND MP.SUPPRIMEDEFINITIF = 0 AND MP.IDEXPEDITEUR = @idUtil)
	ORDER BY MP.DATEENVOI DESC, MP.ID;
END

CREATE PROCEDURE [dbo].[GetMessagesPrives]
	@idUtil int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT MP.ID AS IDMESSAGE, MP.CONTENU, MP.DATEENVOI, MP.SUJET,
	DM.LU, PJ.ID AS IDPIECEJOINTE, U.PRENOM + ' ' + U.NOM AS NOMEXPED
	FROM MESSAGEPRIVE MP
	INNER JOIN DESTINATAIREMESSAGE DM ON MP.ID = DM.IDMESSAGE
	LEFT JOIN PIECEJOINTE PJ ON MP.ID = PJ.IDMESSAGE
	INNER JOIN UTILISATEUR U ON MP.IDEXPEDITEUR = U.ID
	WHERE DM.SUPPRIME = 0 AND DM.SUPPRIMEDEFINITIF = 0 AND DM.IDUTILISATEUR = @idUtil
	ORDER BY MP.DATEENVOI DESC, MP.ID;
END

CREATE PROCEDURE [dbo].[GetMessagesEnvoyes]
	@idUtil int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT MP.ID AS IDMESSAGE, MP.CONTENU, MP.DATEENVOI, MP.SUJET, PJ.ID AS IDPIECE
	FROM MESSAGEPRIVE MP
	LEFT JOIN PIECEJOINTE PJ ON MP.ID = PJ.IDMESSAGE
	WHERE MP.SUPPRIME = 0 AND MP.SUPPRIMEDEFINITIF = 0 AND MP.IDEXPEDITEUR = @idUtil
	ORDER BY MP.DATEENVOI DESC, MP.ID;
END

CREATE PROCEDURE [dbo].[GetMessage]
	@idMessage int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT MP.SUJET, MP.CONTENU, MP.DATEENVOI, PJ.ID AS IDPIECE, PJ.NOMPIECE, PJ.TAILLEPIECE,
	U.PRENOM + ' ' + U.NOM AS NOMEXPED
	FROM MESSAGEPRIVE MP
	LEFT JOIN PIECEJOINTE PJ ON MP.ID = PJ.IDMESSAGE
	INNER JOIN UTILISATEUR U ON MP.IDEXPEDITEUR = U.ID
	WHERE MP.ID = @idMessage
END


CREATE PROCEDURE [dbo].[GetDestinataires]
	@idMessage int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT U.PRENOM + ' ' + U.NOM AS NOMDEST
	FROM DESTINATAIREMESSAGE DM
	INNER JOIN UTILISATEUR U ON DM.IDUTILISATEUR = U.ID
	WHERE DM.IDMESSAGE = @idMessage;
END


create PROCEDURE [dbo].[LireMessage]
	@idMessage int,
	@idUtil int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE DESTINATAIREMESSAGE SET LU = 1
	WHERE IDMESSAGE = @idMessage AND IDUTILISATEUR = @idUtil;
END