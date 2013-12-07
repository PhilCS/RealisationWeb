USE [MVP]
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

GO
IF COL_LENGTH('PUBLICATION', 'TAILLEFICHIER') IS NULL
ALTER TABLE PUBLICATION
ADD TAILLEFICHIER int NOT NULL DEFAULT 0

GO
ALTER TABLE MOTCLE
ALTER COLUMN VALEUR nvarchar(50) not null

GO
IF OBJECT_ID('[dbo].[Split]', 'TF') IS NOT NULL DROP FUNCTION [dbo].[Split]
GO
CREATE FUNCTION [dbo].[Split] (@rowdat nvarchar(2000), @spliton nvarchar(5))  
RETURNS @rtnvalue TABLE 
(
	VALEUR nvarchar(50)
)
AS  
BEGIN 
	WHILE (CHARINDEX(@spliton, @rowdat) > 0)
	BEGIN
		INSERT INTO @rtnvalue (VALEUR)
		SELECT VALEUR = LTRIM(RTRIM(SUBSTRING(@rowdat, 1, CHARINDEX(@spliton, @rowdat) - 1)))

		SET @rowdat = SUBSTRING(@rowdat, CHARINDEX(@spliton, @rowdat) + 1, LEN(@rowdat))
	END

	INSERT INTO @rtnvalue (VALEUR)
	SELECT VALEUR = LTRIM(RTRIM(@rowdat))

	RETURN
END

GO
IF OBJECT_ID('[dbo].[NettoyerMotsCles]', 'P') IS NOT NULL DROP PROCEDURE [dbo].[NettoyerMotsCles]
GO
CREATE PROCEDURE [dbo].[NettoyerMotsCles]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- Suppression des mots clés n'ayant plus de jointures
	DELETE mc FROM MOTCLE mc
	WHERE NOT EXISTS (SELECT 1 FROM MOTCLEPUBLICATION mcp WHERE mcp.IDMOTCLE = mc.ID)
END

GO
IF OBJECT_ID('[dbo].[UpdateMotsClesPub]', 'P') IS NOT NULL DROP PROCEDURE [dbo].[UpdateMotsClesPub]
GO
CREATE PROCEDURE [dbo].[UpdateMotsClesPub]
	@idpub int,
	@motscles nvarchar(2000)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- Obtention des nouveaux mots clés, et de leurs IDs dans la table MOTCLE (ou NULL si inexistant)
	DECLARE @nouvMotsCles TABLE (ID int, VALEUR nvarchar(50))
	INSERT INTO @nouvMotsCles (ID, VALEUR)
	SELECT DISTINCT mc.ID, smc.VALEUR
	FROM dbo.Split(@motscles, ' ') smc LEFT OUTER JOIN MOTCLE mc ON (smc.VALEUR = mc.VALEUR)
	
	-- Génération de la liste de nouveaux mots clés à ajouter
	DECLARE @ajoutMotsCles TABLE (ID int not null primary key identity(1,1), IDMOTCLE int, VALEUR nvarchar(50))
	INSERT INTO @ajoutMotsCles (IDMOTCLE, VALEUR)
	SELECT nmc.ID, nmc.VALEUR
	FROM @nouvMotsCles nmc
	WHERE nmc.ID IS NULL
		  OR NOT EXISTS (SELECT 1 FROM MOTCLEPUBLICATION mcp WHERE mcp.IDMOTCLE = nmc.ID AND mcp.IDPUBLICATION = @idpub)
	
	-- Comptage des nouveaux mots clés à ajouter
	DECLARE @countMotCles int
	SET @countMotCles = @@ROWCOUNT
	
	-- Variable d'incrémentation
	DECLARE @num int
	SET @num = 1
	
	-- Variables pour contenir mot clé actif
	DECLARE @idMotCle int
	DECLARE @valMotCle nvarchar(50)
	
	-- Parcourir les nouveaux mots clés à ajouter
	WHILE @num <= @countMotCles
	BEGIN
		SELECT @idMotCle = IDMOTCLE, @valMotCle = VALEUR FROM @ajoutMotsCles WHERE ID = @num
		
		-- Créer le mot clé si inexistant, et ré-assigner le nouvel ID à @nouvMotsCles
		IF @idMotCle IS NULL
		BEGIN
			INSERT INTO MOTCLE (VALEUR) VALUES (@valMotCle)
			SELECT @idMotCle = SCOPE_IDENTITY()
			UPDATE @nouvMotsCles SET ID = @idMotCle WHERE VALEUR = @valMotCle
		END
		
		-- Associer le mot clé à la publication
		INSERT INTO MOTCLEPUBLICATION (IDPUBLICATION, IDMOTCLE) VALUES (@idpub, @idMotCle)
		
		SET @num = @num + 1
	END;
	
	-- Suppression des jointures
	DELETE mcp FROM MOTCLEPUBLICATION mcp
	WHERE mcp.IDPUBLICATION = @idpub
		  AND NOT EXISTS (SELECT 1 FROM @nouvMotsCles nmc WHERE nmc.ID = mcp.IDMOTCLE)
	
	-- Suppression des mots clés n'ayant plus de jointures
	EXEC dbo.NettoyerMotsCles
END

GO
ALTER PROCEDURE [dbo].[GetPubParMotCle]
	@idsecteur int,
	@idcategorie int,
	@motscles nvarchar(2000)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT p.*
	FROM PUBLICATION p INNER JOIN MOTCLEPUBLICATION mcp ON (mcp.IDPUBLICATION = p.ID)
					   INNER JOIN MOTCLE mc ON (mcp.IDMOTCLE = mc.ID)
	WHERE (p.IDSECTEUR = @idsecteur OR ISNULL(@idsecteur, 0) < 1)
		  AND (p.IDSUJET = @idcategorie OR ISNULL(@idcategorie, 0) < 1)
		  AND EXISTS (SELECT 1 FROM dbo.Split(@motscles, ' ') smc WHERE mc.VALEUR LIKE ('%'+ smc.VALEUR +'%'))
	ORDER BY p.DATECREATION DESC
END

GO
IF OBJECT_ID('[dbo].[GetPublication]', 'P') IS NOT NULL DROP PROCEDURE [dbo].[GetPublication]
GO
CREATE PROCEDURE [dbo].[GetPublication]
	@idpub int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT * FROM PUBLICATION WHERE ID = @idpub
END

GO
ALTER PROCEDURE [dbo].[SupprimerPublication]
	@id int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Suppression de la publication
	DELETE FROM PUBLICATION WHERE ID = @id
	
	-- Suppression des mots clés n'ayant plus de jointures
	EXEC dbo.NettoyerMotsCles
END

GO
ALTER TABLE SONDAGE
ALTER COLUMN NOM nvarchar(60) not null
GO
ALTER TABLE SONDAGE
ALTER COLUMN QUESTION nvarchar(255) not null
GO
IF COL_LENGTH('SONDAGE', 'NOMTRAD') IS NULL
ALTER TABLE SONDAGE
ADD NOMTRAD nvarchar(60) not null DEFAULT ''
GO
IF COL_LENGTH('SONDAGE', 'QUESTIONTRAD') IS NULL
ALTER TABLE SONDAGE
ADD QUESTIONTRAD nvarchar(255) not null DEFAULT ''

GO
ALTER TABLE CHOIXSONDAGE
ALTER COLUMN VALEUR nvarchar(60) not null
GO
IF COL_LENGTH('CHOIXSONDAGE', 'VALEURTRAD') IS NULL
ALTER TABLE CHOIXSONDAGE
ADD VALEURTRAD nvarchar(60) not null DEFAULT ''

GO
ALTER PROCEDURE [dbo].[AjouterSondage]
	@nom nvarchar(60),
	@nomtrad nvarchar(60),
	@question nvarchar(255),
	@questiontrad nvarchar(255),
	@debut datetime, 
	@fin datetime,
	@createur int, 
	@secteur int,
	@idsondage int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	INSERT INTO SONDAGE (NOM, NOMTRAD, QUESTION, QUESTIONTRAD, DATEDEBUT, DATEFIN, IDCREATEUR, IDSECTEUR)
	VALUES (@nom, @nomtrad, @question, @questiontrad, @debut, @fin, @createur, @secteur)
	
	SELECT @idsondage = SCOPE_IDENTITY()
END

GO
ALTER PROCEDURE [dbo].[AjouterChoixSondage]
	@sondage int, 
	@valeur nvarchar(60),
	@valeurtrad nvarchar(60)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	INSERT INTO CHOIXSONDAGE (IDSONDAGE, VALEUR, VALEURTRAD)
	VALUES (@sondage, @valeur, @valeurtrad)
END

GO
ALTER PROCEDURE [dbo].[GetSondages]
	@idsecteur int,
	@resultats bit,
	@idutil int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @maxDate datetime
	SET @maxDate = CONVERT(DATETIME, '9999-12-31 23:59:59.997', 121)

	SELECT s.*
	FROM SONDAGE s
	WHERE s.IDSECTEUR = @idsecteur
		  AND (@resultats = 1 OR (s.DATEDEBUT <= CURRENT_TIMESTAMP
								  AND s.DATEFIN > CURRENT_TIMESTAMP
								  AND NOT EXISTS (SELECT 1
												  FROM VOTESONDAGE vs INNER JOIN CHOIXSONDAGE cs ON (cs.ID = vs.IDCHOIX)
												  WHERE cs.IDSONDAGE = s.ID AND vs.IDUTILISATEUR = @idutil)))
	ORDER BY CASE WHEN s.DATEFIN > CURRENT_TIMESTAMP THEN s.DATEFIN ELSE @maxDate END ASC,
			 CASE WHEN s.DATEFIN <= CURRENT_TIMESTAMP THEN s.DATEFIN END DESC
END

GO
ALTER PROCEDURE [dbo].[GetSondage]
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * FROM SONDAGE WHERE ID = @id
END

GO
IF OBJECT_ID('[dbo].[GetChoixSondage]', 'P') IS NOT NULL DROP PROCEDURE [dbo].[GetChoixSondage]
GO
CREATE PROCEDURE [dbo].[GetChoixSondage]
	@idsondage int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT * FROM CHOIXSONDAGE WHERE IDSONDAGE = @idsondage
END

GO
IF OBJECT_ID('[dbo].[GetVotesSondage]', 'P') IS NOT NULL DROP PROCEDURE [dbo].[GetVotesSondage]
GO
CREATE PROCEDURE [dbo].[GetVotesSondage]
	@idsondage int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT vs.*
	FROM VOTESONDAGE vs INNER JOIN CHOIXSONDAGE cs ON (cs.ID = vs.IDCHOIX)
	WHERE cs.IDSONDAGE = @idsondage
END

GO
ALTER TABLE NOUVELLE
ALTER COLUMN TITRE nvarchar(100) NOT NULL
GO
IF COL_LENGTH('NOUVELLE', 'TITRETRAD') IS NULL
ALTER TABLE NOUVELLE
ADD TITRETRAD nvarchar(100) NOT NULL DEFAULT ''
GO
IF COL_LENGTH('NOUVELLE', 'DESCRIPTIONTRAD') IS NULL
ALTER TABLE NOUVELLE
ADD DESCRIPTIONTRAD text NOT NULL DEFAULT ''

GO
ALTER PROCEDURE [dbo].[AjouterNouvelle]
	@titre nvarchar(100),
	@titretrad nvarchar(100),
	@description text,
	@descriptiontrad text
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	INSERT INTO NOUVELLE (TITRE, TITRETRAD, DESCRIPTION, DESCRIPTIONTRAD)
	VALUES (@titre, @titretrad, @description, @descriptiontrad)
END

GO
ALTER PROCEDURE [dbo].[ModifierNouvelle]
	@id int,
	@titre nvarchar(100),
	@titretrad nvarchar(100),
	@description text,
	@descriptiontrad text
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	UPDATE NOUVELLE
	SET TITRE = @titre, TITRETRAD = @titretrad, DESCRIPTION = @description, DESCRIPTIONTRAD = @descriptiontrad
	WHERE ID = @id
END

GO
ALTER TABLE SUJETPUBLICATION
ALTER COLUMN NOM nvarchar(50) NOT NULL
GO
IF COL_LENGTH('SUJETPUBLICATION', 'NOMTRAD') IS NULL
ALTER TABLE SUJETPUBLICATION
ADD NOMTRAD nvarchar(50) NOT NULL DEFAULT ''

GO
ALTER PROCEDURE [dbo].[AjouterSujetPub]
	@nom nvarchar(50),
	@nomtrad nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO SUJETPUBLICATION (NOM, NOMTRAD)
	VALUES (@nom, @nomtrad)
END

GO
IF OBJECT_ID('[dbo].[ModifierSujetPub]', 'P') IS NOT NULL DROP PROCEDURE [dbo].[ModifierSujetPub]
GO
CREATE PROCEDURE [dbo].[ModifierSujetPub]
	@id int,
	@nom nvarchar(50),
	@nomtrad nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE SUJETPUBLICATION
	SET NOM = @nom, NOMTRAD = @nomtrad
	WHERE ID = @id
END

GO
IF OBJECT_ID('[dbo].[SupprimerSujetPub]', 'P') IS NOT NULL DROP PROCEDURE [dbo].[SupprimerSujetPub]
GO
CREATE PROCEDURE [dbo].[SupprimerSujetPub]
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM SUJETPUBLICATION WHERE ID = @id
END

GO
IF OBJECT_ID('[dbo].[GetSujetPublication]', 'P') IS NOT NULL DROP PROCEDURE [dbo].[GetSujetPublication]
GO
CREATE PROCEDURE [dbo].[GetSujetPublication]
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM SUJETPUBLICATION WHERE ID = @id
END
