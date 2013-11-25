USE [MVP]
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

GO
ALTER TABLE PUBLICATION
ADD TAILLEFICHIER int NOT NULL DEFAULT 0

GO
ALTER TABLE MOTCLE
ALTER COLUMN VALEUR nvarchar(50) not null

-- Ajout de suppression en cascade sur les clés étrangères de MOTCLEPUBLICATION
GO
ALTER TABLE MOTCLEPUBLICATION
DROP CONSTRAINT FK_MOTCLEPUB_MOTCLE
GO
ALTER TABLE MOTCLEPUBLICATION
ADD CONSTRAINT FK_MOTCLEPUB_MOTCLE FOREIGN KEY(IDMOTCLE) REFERENCES MOTCLE (ID) ON DELETE CASCADE
GO
ALTER TABLE MOTCLEPUBLICATION
DROP CONSTRAINT FK_MOTCLEPUB_PUB
GO
ALTER TABLE MOTCLEPUBLICATION
ADD CONSTRAINT FK_MOTCLEPUB_PUB FOREIGN KEY(IDPUBLICATION) REFERENCES PUBLICATION (ID) ON DELETE CASCADE

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
