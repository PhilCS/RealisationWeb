USE [MVP]
GO
/****** Object:  User [profFXG]    Script Date: 2013-10-21 09:53:58 ******/
CREATE USER [profFXG] FOR LOGIN [profFXG] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  StoredProcedure [dbo].[AjouterChoixSondage]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christ
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterChoixSondage]
	@sondage int, 
	@valeur varchar(60)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO CHOIXSONDAGE VALUES (@sondage, @valeur)
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterDestinataireMess]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterDestinataireMess]
	@message int, 
	@destinataire int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO DESTINATAIREMESSAGE(IDMESSAGE, IDUTILISATEUR) VALUES (@message, @destinataire)
	
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterEcole]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterEcole]
	@nom varchar(60), 
	@adresse varchar(50), 
	@ville varchar(40)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO ECOLE(NOM, ADRESSE, VILLE) VALUES (@nom, @adresse, @ville)
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterEven]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description: <Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterEven](@nomeven varchar(50), @dateeven date, @debut time = null, @fin time = null, 
							@categorie int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO EVENEMENT (NOM, DATEEVEN, HEUREDEBUT, HEUREFIN, IDCATEGORIE)
	VALUES (@nomeven, @dateeven, @debut, @fin, @categorie)
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterFilDiscussion]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterFilDiscussion]
	@sujet varchar(100),
	@forum int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO FILDISCUSSION (SUJET, IDFORUM) VALUES (@sujet, @forum)
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterMessageForum]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterMessageForum]
	@contenu text,
	@util int, 
	@fildiscu int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO MESSAGEFORUM(CONTENU, IDUTILISATEUR, IDFILDISCUSSION) VALUES (@contenu, @util, @fildiscu)

	-- Ajouter l'id du message créé comme idDernierMessage dans FILDISCUSSION (Déclencheur)
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterMessagePrive]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterMessagePrive]
	@expediteur int, 
	@sujet varchar(50),
	@contenu text
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO MESSAGEPRIVE(IDEXPEDITEUR, SUJET, CONTENU) VALUES (@expediteur, @sujet, @contenu)
	

END



GO
/****** Object:  StoredProcedure [dbo].[AjouterMotCle]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterMotCle]
	@idpub int,
	@valeur varchar(50),
	@return_value int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @motexiste int
	DECLARE @dernier int

	SET @motexiste = (SELECT COUNT(*) FROM MOTCLE WHERE VALEUR LIKE @valeur)
	
	IF @motexiste = 0
		BEGIN
			INSERT INTO MOTCLE VALUES (@valeur)
			SET @dernier = @@IDENTITY
			SET @return_value = 1
		END
	ELSE 
		BEGIN
			SET @dernier = (SELECT VALEUR FROM MOTCLE WHERE VALEUR LIKE @valeur)
			SET @return_value = 0
		END

	INSERT INTO MOTCLEPUBLICATION VALUES (@idpub, @dernier)
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterNouvelle]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterNouvelle]
	@titre varchar(60), 
	@description text
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO NOUVELLE (TITRE, DESCRIPTION) VALUES (@titre, @description)
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterPartenaire]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterPartenaire]
	@nom varchar(60),
	@raisonsociale text,
	@adr varchar(65),
	@ville varchar(65),
	@pays varchar(60),
	@tel varchar(20),
	@siteweb varchar(150),
	@courriel varchar(150)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO PARTENAIRE VALUES (@nom, @raisonsociale, @adr, @ville, @pays, @tel, @siteweb, @courriel)
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterPieceJointe]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterPieceJointe]
	@message int, 
	@pieceserialisee varbinary(max),
	@taillepiece varchar(40), 
	@nompiece varchar(150)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO PIECEJOINTE VALUES (@message, @pieceserialisee, @taillepiece, @nompiece)
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterPublication]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterPublication]
	@titre varchar(60),
	@emplacement varchar(200),
	@sujet int, 
	@secteur int,
	@idpub int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO PUBLICATION (TITRE, EMPLACEMENTSERVEUR, IDSUJET, IDSECTEUR)
	VALUES (@titre, @emplacement, @sujet, @secteur)

	SET @idpub = @@IDENTITY
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterRole]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterRole]
	@nom varchar(45)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO ROLE VALUES (@nom)
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterSectEcole]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterSectEcole]
	@idecole int, 
	@idsecteur int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO ECOLESECTEUR VALUES (@idecole, @idsecteur)
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterSecteur]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterSecteur]
	@nom varchar(40)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO SECTEUR VALUES (@nom)
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterSectEven]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterSectEven] (@secteur int, @even int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO EVENEMENTSECTEUR VALUES (@even, @secteur)
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterSondage]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterSondage]
	@nom varchar(60),
	@question varchar(255),
	@debut datetime, 
	@fin datetime,
	@createur int, 
	@secteur int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO SONDAGE VALUES (@nom, @question, @debut, @fin, @createur, @secteur)
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterSujetPub]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterSujetPub]
	@sujet varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO SUJETPUBLICATION VALUES(@sujet)
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterUtilisateur]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterUtilisateur] (@nomutil varchar(25), @motpasse varchar(40), @courriel varchar(100), 
							@prenom varchar(60), @nom varchar(60), @adresse varchar(50), @ville varchar(50), 
							@datenaissance date, @langue char(2) = 'FR', @role int, @ecole int) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @jeton varchar(32) = 'abcde';

	INSERT INTO UTILISATEUR(nomutil, motpasse, courriel, prenom, nom, adresse, ville, datenaissance,
							langue, idrole, idecole)
	VALUES (@nomutil, @motpasse, @courriel, @prenom, @nom, @adresse, @ville, 
									@datenaissance, @langue, @role, @ecole);

	-- Lors de la création d'un utilisateur, un courriel doit être envoyé à celui-ci pour confirmation.
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterUtilSecteur]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterUtilSecteur] (@id int, @secteur int) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO UTILISATEURSECTEUR VALUES (@id, @secteur)
END



GO
/****** Object:  StoredProcedure [dbo].[AjouterVoteSondage]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AjouterVoteSondage]
	@util int, 
	@choix int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO VOTESONDAGE VALUES (@util, @choix)
END



GO
/****** Object:  StoredProcedure [dbo].[AssocierRoleDroit]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AssocierRoleDroit]
	@idrole int,
	@iddroit int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO ROLEDROIT VALUES (@idrole, @iddroit)
END



GO
/****** Object:  StoredProcedure [dbo].[AugmenterNbrLectures]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AugmenterNbrLectures]
	@idfildiscussion int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @nblectures int

	SET @nblectures = (SELECT NBLECTURES FROM FILDISCUSSION WHERE ID = @idfildiscussion)

	UPDATE FILDISCUSSION
	SET NBLECTURES = @nblectures + 1
	WHERE ID = @idfildiscussion
END



GO
/****** Object:  StoredProcedure [dbo].[DeassocierRoleDroit]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeassocierRoleDroit]
	@idrole int,
	@iddroit int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE FROM ROLEDROIT WHERE IDROLE = @idrole AND IDDROIT = @iddroit
END



GO
/****** Object:  StoredProcedure [dbo].[GetEven]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEven] (@id int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT EVENEMENT.NOM, DATEEVEN, HEUREDEBUT, HEUREFIN, CATEGORIEEVENEMENT.NOM AS NOMCATE
	FROM EVENEMENT, CATEGORIEEVENEMENT
	WHERE IDCATEGORIE = CATEGORIEEVENEMENT.ID AND EVENEMENT.ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[GetEvents]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEvents] 
	@secteur int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM EVENEMENT, EVENEMENTSECTEUR, CATEGORIEEVENEMENT WHERE EVENEMENT.ID = IDEVENEMENT 
	AND CATEGORIEEVENEMENT.ID = IDCATEGORIE AND IDSECTEUR = @secteur
END



GO
/****** Object:  StoredProcedure [dbo].[GetFilDiscussion]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetFilDiscussion] 
	@idforum int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM FILDISCUSSION WHERE IDFORUM = @idforum

END


GO
/****** Object:  StoredProcedure [dbo].[GetForum]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetForum]
	 @secteur int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM FORUM WHERE IDSECTEUR = @secteur

END


GO
/****** Object:  StoredProcedure [dbo].[GetMessagesForum]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetMessagesForum]
	 @idfil int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM MESSAGEFORUM WHERE IDFILDISCUSSION = @idfil

END


GO
/****** Object:  StoredProcedure [dbo].[GetNouvelles]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetNouvelles]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM NOUVELLE
END



GO
/****** Object:  StoredProcedure [dbo].[GetPartenaire]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-20
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPartenaire]
	@idpar int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT NOM, RAISONSOCIALE, ADRESSE, VILLE, PAYS, TELEPHONE, SITEWEB, COURRIEL
	FROM PARTENAIRE
	WHERE ID = @idpar

END


GO
/****** Object:  StoredProcedure [dbo].[GetPartenaires]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-20
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPartenaires]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ID, NOM FROM PARTENAIRE

END


GO
/****** Object:  StoredProcedure [dbo].[GetPubParMotCle]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPubParMotCle]
	 @idsecteur int,
	 @motcle varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT TITRE, DATECREATION, EMPLACEMENTSERVEUR, sp.NOM 
	FROM PUBLICATION p, MOTCLEPUBLICATION mp, MOTCLE m, SUJETPUBLICATION sp
	WHERE p.IDSUJET = sp.ID AND p.IDSECTEUR = @idsecteur AND mp.IDPUBLICATION = p.ID
	AND mp.IDMOTCLE = m.ID AND m.VALEUR LIKE @motcle

END


GO
/****** Object:  StoredProcedure [dbo].[GetPubParSecteur]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPubParSecteur]
	 @idsecteur int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM PUBLICATION WHERE IDSECTEUR = @idsecteur

END


GO
/****** Object:  StoredProcedure [dbo].[GetPubParSujet]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPubParSujet]
	 @idsecteur int,
	 @idsujet int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM PUBLICATION WHERE IDSECTEUR = @idsecteur AND IDSUJET = @idsujet

END


GO
/****** Object:  StoredProcedure [dbo].[GetResultatsSondage]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-20
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetResultatsSondage]
	@idsondage int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT NOMUTIL, VALEUR
	FROM CHOIXSONDAGE CS, VOTESONDAGE VS, UTILISATEUR U
	WHERE VS.IDUTILISATEUR = U.ID AND VS.IDCHOIX = CS.ID AND CS.IDSONDAGE = @idsondage

END


GO
/****** Object:  StoredProcedure [dbo].[GetRole]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-20
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetRole]
	@idrole int	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ID, TYPE, DESCRIPTION 
	FROM DROIT, ROLEDROIT
	WHERE IDDROIT = ID AND IDROLE = @idrole

END


GO
/****** Object:  StoredProcedure [dbo].[GetRoles]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-20
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetRoles]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM ROLE

END


GO
/****** Object:  StoredProcedure [dbo].[GetSecteurs]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-20
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSecteurs]	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM SECTEUR

END


GO
/****** Object:  StoredProcedure [dbo].[GetSondage]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-20
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSondage]
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT S.NOM, QUESTION, DATEDEBUT, DATEFIN, NOMUTIL
	FROM SONDAGE S, CHOIXSONDAGE CS, UTILISATEUR U
	WHERE S.ID = CS.IDSONDAGE AND S.IDCREATEUR = U.ID AND S.ID = @id

END


GO
/****** Object:  StoredProcedure [dbo].[GetSondages]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-20
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSondages]
	@idsecteur int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT SONDAGE.ID, SONDAGE.NOM, QUESTION, DATEDEBUT, DATEFIN, NOMUTIL
	FROM SONDAGE, UTILISATEUR
	WHERE IDCREATEUR = UTILISATEUR.ID AND IDSECTEUR = @idsecteur

END


GO
/****** Object:  StoredProcedure [dbo].[GetUtilAcces]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUtilAcces] (@id int) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT ROLE.ID, ROLE.NOM, DROIT.ID, DROIT.TYPE, DROIT.DESCRIPTION FROM UTILISATEUR, ROLE, DROIT, ROLEDROIT 
	WHERE UTILISATEUR.IDROLE = ROLE.ID AND ROLE.ID = ROLEDROIT.IDROLE AND DROIT.ID = ROLEDROIT.IDDROIT 
	AND UTILISATEUR.ID = 2
END



GO
/****** Object:  StoredProcedure [dbo].[GetUtilParSecteur]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-20
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUtilParSecteur]
	@idsecteur int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT NOMUTIL, NOM, PRENOM 
	FROM UTILISATEUR, UTILISATEURSECTEUR 
	WHERE IDSECTEUR = ID

END


GO
/****** Object:  StoredProcedure [dbo].[GetUtilProfil]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUtilProfil] (@id int) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT COURRIEL, NOM, PRENOM, ADRESSE, VILLE, LANGUE
	FROM UTILISATEUR WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[GetUtils]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUtils] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM UTILISATEUR
END



GO
/****** Object:  StoredProcedure [dbo].[MessagePriveCorbeille]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-20
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[MessagePriveCorbeille]
	@idmess int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE DESTINATAIREMESSAGE
	SET SUPPRIME = 1
	WHERE IDMESSAGE = @idmess

END


GO
/****** Object:  StoredProcedure [dbo].[MessagePriveSuppDef]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-20
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[MessagePriveSuppDef]
	@idmess int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE DESTINATAIREMESSAGE
	SET SUPPRIMEDEFINITIF = 1
	WHERE IDMESSAGE = @idmess

END


GO
/****** Object:  StoredProcedure [dbo].[ModiferEven]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description: <Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ModiferEven](@ideven int, @nomeven varchar(50), @dateeven date, @debut time = null, @fin time = null, 
							@categorie int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE EVENEMENT
	SET NOM = @nomeven, DATEEVEN = @dateeven, HEUREDEBUT = @debut, HEUREFIN = @fin, 
	IDCATEGORIE = @categorie
	WHERE ID = @ideven
END



GO
/****** Object:  StoredProcedure [dbo].[ModifierChoixSondage]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ModifierChoixSondage]
	@id int, 
	@valeur varchar(60)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE CHOIXSONDAGE
	SET VALEUR = @valeur
	WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[ModifierEcole]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ModifierEcole]
	@id int,
	@nom varchar(60), 
	@adresse varchar(50), 
	@ville varchar(40)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE ECOLE
	SET NOM = @nom, ADRESSE = @adresse, VILLE = @ville
	WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[ModifierMessageForum]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ModifierMessageForum]
	@id int,
	@contenu text
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE MESSAGEFORUM
	SET CONTENU = @contenu
	WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[ModifierNouvelle]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ModifierNouvelle]
	@id int,
	@titre varchar(60), 
	@description text
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE NOUVELLE
	SET TITRE = @titre, DESCRIPTION = @description
	WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[ModifierPartenaire]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ModifierPartenaire]
	@id int,
	@nom varchar(60),
	@raisonsociale text,
	@adr varchar(65),
	@ville varchar(65),
	@pays varchar(60),
	@tel varchar(20),
	@siteweb varchar(150),
	@courriel varchar(150)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE PARTENAIRE
	SET NOM = @nom, RAISONSOCIALE = @raisonsociale, ADRESSE = @adr, VILLE = @ville, PAYS = @pays, TELEPHONE = @tel, SITEWEB = @siteweb, COURRIEL = @courriel
	WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[ModifierPublication]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ModifierPublication]
	@id int, 
	@titre varchar(60),
	@sujet int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE PUBLICATION 
	SET TITRE = @titre, IDSUJET = @sujet
	WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[ModifierSondage]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ModifierSondage]
	@id int,
	@nom varchar(60),
	@question varchar(255),
	@debut datetime, 
	@fin datetime, 
	@secteur int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE SONDAGE
	SET NOM = @nom, QUESTION = @question, DATEDEBUT = @debut, DATEFIN = @fin, IDSECTEUR = @secteur
	WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[ModifierSujetFilDiscussion]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ModifierSujetFilDiscussion]
	@id int,
	@sujet varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE FILDISCUSSION
	SET SUJET = @sujet, DATEMODIFICATION = GETDATE()
	WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[ModifierUtilEcole]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ModifierUtilEcole] (@id int, @ecole int) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE UTILISATEUR SET IDECOLE = @ecole WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[ModifierUtilMotPasse]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ModifierUtilMotPasse] (@id int, @newmp varchar(40)) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE UTILISATEUR SET MOTPASSE = @newmp WHERE ID = @id;
END



GO
/****** Object:  StoredProcedure [dbo].[ModifierUtilProfil]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ModifierUtilProfil] (@id int, @courriel varchar(100), @nom varchar(60), @prenom varchar(60),
										@adresse varchar(50), @ville varchar(50), @langue char(2)) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE UTILISATEUR 
	SET COURRIEL = @courriel, NOM = @nom, PRENOM = @prenom, ADRESSE = @adresse, VILLE = @ville, LANGUE = @langue
	WHERE ID = @id;
END



GO
/****** Object:  StoredProcedure [dbo].[ModifierUtilRole]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ModifierUtilRole] (@id int, @role int) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE UTILISATEUR 
	SET IDROLE = @role
	WHERE ID = @id;
END



GO
/****** Object:  StoredProcedure [dbo].[ReinitMotPasse]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ReinitMotPasse] (@id int) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE UTILISATEUR 
	SET REINITIALISERMOTPASSE = 1
	WHERE ID = @id;
END



GO
/****** Object:  StoredProcedure [dbo].[SupprimerChoixSondage]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SupprimerChoixSondage]
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE FROM CHOIXSONDAGE WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[SupprimerEcole]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SupprimerEcole]
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE FROM ECOLE WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[SupprimerEven]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description: <Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SupprimerEven] (@id int) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM EVENEMENT WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[SupprimerFilDiscussion]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-20
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SupprimerFilDiscussion]
	@idfil int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM FILDISCUSSION WHERE ID = @idfil

END


GO
/****** Object:  StoredProcedure [dbo].[SupprimerMessageForum]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-20
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SupprimerMessageForum]
	@idmess int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM MESSAGEFORUM WHERE ID = @idmess

END


GO
/****** Object:  StoredProcedure [dbo].[SupprimerMotClePub]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SupprimerMotClePub]
	@idpub int, 
	@idmotcle int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE FROM MOTCLEPUBLICATION WHERE IDPUBLICATION = @idpub AND IDMOTCLE = @idmotcle
END



GO
/****** Object:  StoredProcedure [dbo].[SupprimerNouvelle]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SupprimerNouvelle]
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE FROM NOUVELLE WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[SupprimerPartenaire]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SupprimerPartenaire]
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE FROM PARTENAIRE WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[SupprimerPublication]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SupprimerPublication]
	@id int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM PUBLICATION WHERE ID = @id
	-- Supprimer les associations avec les mots clés
	-- Vérifier si le mot clé est associé à une autre publication. Si non, supprimer le mot clé aussi
END



GO
/****** Object:  StoredProcedure [dbo].[SupprimerRole]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SupprimerRole]
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE FROM ROLE WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[SupprimerSectEcole]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SupprimerSectEcole]
	@idecole int, 
	@idsecteur int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE FROM ECOLESECTEUR WHERE IDECOLE = @idecole AND IDSECTEUR = @idsecteur
END



GO
/****** Object:  StoredProcedure [dbo].[SupprimerSecteur]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SupprimerSecteur]
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE FROM SECTEUR WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[SupprimerSectEven]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SupprimerSectEven] (@secteur int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM EVENEMENTSECTEUR WHERE IDSECTEUR = @secteur
END



GO
/****** Object:  StoredProcedure [dbo].[SupprimerSondage]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SupprimerSondage]
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE FROM SONDAGE WHERE ID = @id
END



GO
/****** Object:  StoredProcedure [dbo].[SupprimerUtilisateur]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SupprimerUtilisateur] (@nomutil varchar(25), @permanent bit) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @permanent = 0 
		UPDATE UTILISATEUR SET COMPTEACTIF = 0 WHERE NOMUTIL = @nomutil;
	ELSE
		DELETE FROM UTILISATEUR WHERE NOMUTIL = @nomutil;
	
END



GO
/****** Object:  StoredProcedure [dbo].[SupprimerUtilSect]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marie-Christine Noreau
-- Create date: 2013-09-16
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SupprimerUtilSect] (@id int, @secteur int) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE FROM UTILISATEURSECTEUR WHERE IDUTILISATEUR = @id AND IDSECTEUR = @secteur
END



GO
/****** Object:  Table [dbo].[CATEGORIEEVENEMENT]    Script Date: 2013-10-21 09:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CATEGORIEEVENEMENT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOM] [varchar](40) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CHOIXSONDAGE]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CHOIXSONDAGE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDSONDAGE] [int] NOT NULL,
	[VALEUR] [varchar](60) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CONFIRMINSCRIPTION]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CONFIRMINSCRIPTION](
	[IDUTILISATEUR] [int] NOT NULL,
	[DATEENVOI] [datetime] NOT NULL,
	[JETON] [varchar](32) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDUTILISATEUR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DESTINATAIREMESSAGE]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DESTINATAIREMESSAGE](
	[IDMESSAGE] [int] NOT NULL,
	[IDUTILISATEUR] [int] NOT NULL,
	[SUPPRIME] [bit] NOT NULL,
	[SUPPRIMEDEFINITIF] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDMESSAGE] ASC,
	[IDUTILISATEUR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DROIT]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DROIT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TYPE] [varchar](45) NOT NULL,
	[DESCRIPTION] [varchar](255) NOT NULL,
 CONSTRAINT [PK__DROIT__3214EC273A4DB915] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ECOLE]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ECOLE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOM] [varchar](60) NOT NULL,
	[PROVINCE] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ECOLESECTEUR]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ECOLESECTEUR](
	[IDECOLE] [int] NOT NULL,
	[IDSECTEUR] [int] NOT NULL,
 CONSTRAINT [PK_ECOLESECTEUR] PRIMARY KEY CLUSTERED 
(
	[IDECOLE] ASC,
	[IDSECTEUR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EVENEMENT]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EVENEMENT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOM] [varchar](50) NOT NULL,
	[DATEEVEN] [date] NOT NULL,
	[HEUREDEBUT] [time](7) NULL,
	[HEUREFIN] [time](7) NULL,
	[IDCATEGORIE] [int] NOT NULL,
	[IDCREATEUR] [int] NOT NULL,
 CONSTRAINT [PK__EVENEMEN__3214EC27737AF2B3] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EVENEMENTSECTEUR]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EVENEMENTSECTEUR](
	[IDEVENEMENT] [int] NOT NULL,
	[IDSECTEUR] [int] NOT NULL,
 CONSTRAINT [PK_EVENEMENTSECTEUR] PRIMARY KEY CLUSTERED 
(
	[IDEVENEMENT] ASC,
	[IDSECTEUR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FILDISCUSSION]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FILDISCUSSION](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SUJET] [varchar](100) NOT NULL,
	[DATEPUBLICATION] [datetime] NOT NULL,
	[DATEMODIFICATION] [datetime] NULL,
	[NBLECTURES] [int] NOT NULL,
	[IDFORUM] [int] NULL,
 CONSTRAINT [PK__FILDISCU__3214EC27A2BD0383] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FORUM]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FORUM](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TITRE] [varchar](50) NOT NULL,
	[IDSECTEUR] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MESSAGEFORUM]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MESSAGEFORUM](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DATEPUBLICATION] [datetime] NOT NULL,
	[DATEMODIFICATION] [datetime] NULL,
	[CONTENU] [text] NOT NULL,
	[IDUTILISATEUR] [int] NOT NULL,
	[IDFILDISCUSSION] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MESSAGEPRIVE]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MESSAGEPRIVE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDEXPEDITEUR] [int] NOT NULL,
	[SUJET] [varchar](50) NOT NULL,
	[CONTENU] [text] NOT NULL,
	[DATEENVOI] [datetime] NOT NULL,
	[SUPPRIME] [bit] NOT NULL,
	[SUPPRIMEDEFINITIF] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOTCLE]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOTCLE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[VALEUR] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOTCLEPUBLICATION]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOTCLEPUBLICATION](
	[IDPUBLICATION] [int] NOT NULL,
	[IDMOTCLE] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPUBLICATION] ASC,
	[IDMOTCLE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NOUVELLE]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NOUVELLE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TITRE] [varchar](60) NOT NULL,
	[DESCRIPTION] [text] NOT NULL,
	[DATEPUBLICATION] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PARTENAIRE]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PARTENAIRE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOM] [varchar](60) NOT NULL,
	[RAISONSOCIALE] [text] NOT NULL,
	[ADRESSE] [varchar](65) NULL,
	[VILLE] [varchar](65) NULL,
	[PAYS] [varchar](60) NULL,
	[TELEPHONE] [varchar](20) NULL,
	[SITEWEB] [varchar](150) NULL,
	[COURRIEL] [varchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PIECEJOINTE]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PIECEJOINTE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDMESSAGE] [int] NOT NULL,
	[PIECESERIALISEE] [varbinary](max) NOT NULL,
	[TAILLEPIECE] [varchar](40) NOT NULL,
	[NOMPIECE] [varchar](150) NOT NULL,
 CONSTRAINT [PK__PIECEJOI__3214EC2774BBDE7D] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PUBLICATION]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PUBLICATION](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TITRE] [varchar](60) NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
	[EMPLACEMENTSERVEUR] [varchar](200) NOT NULL,
	[IDPUBLICATEUR] [int] NOT NULL,
	[TYPEMIME] [varchar](20) NULL,
	[IDSUJET] [int] NOT NULL,
	[IDSECTEUR] [int] NOT NULL,
 CONSTRAINT [PK__PUBLICAT__3214EC279D945C0C] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ROLE]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ROLE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOM] [varchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ROLEDROIT]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLEDROIT](
	[IDROLE] [int] NOT NULL,
	[IDDROIT] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDROLE] ASC,
	[IDDROIT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SECTEUR]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SECTEUR](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOM] [varchar](40) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SONDAGE]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SONDAGE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOM] [varchar](60) NOT NULL,
	[QUESTION] [varchar](255) NOT NULL,
	[DATEDEBUT] [datetime] NOT NULL,
	[DATEFIN] [datetime] NOT NULL,
	[IDCREATEUR] [int] NOT NULL,
	[IDSECTEUR] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SUJETPUBLICATION]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SUJETPUBLICATION](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOM] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UTILISATEUR]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UTILISATEUR](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMUTIL] [varchar](25) NOT NULL,
	[MOTPASSE] [varchar](40) NOT NULL,
	[COURRIEL] [varchar](100) NOT NULL,
	[PRENOM] [varchar](60) NOT NULL,
	[NOM] [varchar](60) NOT NULL,
	[ADRESSE] [varchar](50) NOT NULL,
	[VILLE] [varchar](50) NOT NULL,
	[DATENAISSANCE] [date] NOT NULL,
	[DATECREATION] [date] NOT NULL,
	[DERNIERECONNEXION] [datetime] NULL,
	[COMPTEACTIF] [bit] NOT NULL,
	[LANGUE] [char](2) NOT NULL,
	[IDROLE] [int] NOT NULL,
	[IDECOLE] [int] NOT NULL,
	[REINITIALISERMOTPASSE] [bit] NOT NULL,
 CONSTRAINT [PK__UTILISAT__3214EC278FE56C5C] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__UTILISAT__190F3DCBCE897D42] UNIQUE NONCLUSTERED 
(
	[COURRIEL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__UTILISAT__3BA84E4815D1A094] UNIQUE NONCLUSTERED 
(
	[NOMUTIL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UTILISATEURSECTEUR]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UTILISATEURSECTEUR](
	[IDUTILISATEUR] [int] NOT NULL,
	[IDSECTEUR] [int] NOT NULL,
	[DEBUTACCES] [date] NOT NULL,
	[FINACCES] [date] NOT NULL,
 CONSTRAINT [PK__UTILISAT__9490A9EA4B515193] PRIMARY KEY CLUSTERED 
(
	[IDUTILISATEUR] ASC,
	[IDSECTEUR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VOTESONDAGE]    Script Date: 2013-10-21 09:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VOTESONDAGE](
	[IDUTILISATEUR] [int] NOT NULL,
	[IDCHOIX] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDUTILISATEUR] ASC,
	[IDCHOIX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[CONFIRMINSCRIPTION] ADD  CONSTRAINT [DF_CONFIRMINSCRIPTION_JETON]  DEFAULT (getdate()) FOR [JETON]
GO
ALTER TABLE [dbo].[DESTINATAIREMESSAGE] ADD  DEFAULT ((0)) FOR [SUPPRIME]
GO
ALTER TABLE [dbo].[DESTINATAIREMESSAGE] ADD  DEFAULT ((0)) FOR [SUPPRIMEDEFINITIF]
GO
ALTER TABLE [dbo].[FILDISCUSSION] ADD  CONSTRAINT [DF_FILDISCUSSION_DATEPUBLICATION]  DEFAULT (getdate()) FOR [DATEPUBLICATION]
GO
ALTER TABLE [dbo].[FILDISCUSSION] ADD  CONSTRAINT [DF_FILDISCUSSION_DATEMODIFICATION]  DEFAULT (NULL) FOR [DATEMODIFICATION]
GO
ALTER TABLE [dbo].[FILDISCUSSION] ADD  CONSTRAINT [DF__FILDISCUS__NBLEC__4316F928]  DEFAULT ((0)) FOR [NBLECTURES]
GO
ALTER TABLE [dbo].[MESSAGEFORUM] ADD  CONSTRAINT [DF_MESSAGEFORUM_DATEPUBLICATION]  DEFAULT (getdate()) FOR [DATEPUBLICATION]
GO
ALTER TABLE [dbo].[MESSAGEFORUM] ADD  DEFAULT (NULL) FOR [DATEMODIFICATION]
GO
ALTER TABLE [dbo].[MESSAGEPRIVE] ADD  CONSTRAINT [DF_MESSAGEPRIVE_DATEENVOI]  DEFAULT (getdate()) FOR [DATEENVOI]
GO
ALTER TABLE [dbo].[MESSAGEPRIVE] ADD  CONSTRAINT [DF_MESSAGEPRIVE_SUPPRIME]  DEFAULT ((0)) FOR [SUPPRIME]
GO
ALTER TABLE [dbo].[MESSAGEPRIVE] ADD  CONSTRAINT [DF_MESSAGEPRIVE_SUPPRIMEDEFINITIF]  DEFAULT ((0)) FOR [SUPPRIMEDEFINITIF]
GO
ALTER TABLE [dbo].[NOUVELLE] ADD  DEFAULT (getdate()) FOR [DATEPUBLICATION]
GO
ALTER TABLE [dbo].[PUBLICATION] ADD  CONSTRAINT [DF_PUBLICATION_DATECREATION]  DEFAULT (getdate()) FOR [DATECREATION]
GO
ALTER TABLE [dbo].[UTILISATEUR] ADD  CONSTRAINT [DF_UTILISATEUR_DATECREATION]  DEFAULT (getdate()) FOR [DATECREATION]
GO
ALTER TABLE [dbo].[UTILISATEUR] ADD  CONSTRAINT [DF_UTILISATEUR_DERNIERECONNEXION]  DEFAULT (NULL) FOR [DERNIERECONNEXION]
GO
ALTER TABLE [dbo].[UTILISATEUR] ADD  CONSTRAINT [DF__UTILISATE__COMPT__1BFD2C07]  DEFAULT ((1)) FOR [COMPTEACTIF]
GO
ALTER TABLE [dbo].[UTILISATEUR] ADD  CONSTRAINT [DF__UTILISATE__LANGU__1CF15040]  DEFAULT ('FR') FOR [LANGUE]
GO
ALTER TABLE [dbo].[UTILISATEUR] ADD  CONSTRAINT [DF__UTILISATE__REINI__1DE57479]  DEFAULT ((1)) FOR [REINITIALISERMOTPASSE]
GO
ALTER TABLE [dbo].[CHOIXSONDAGE]  WITH CHECK ADD  CONSTRAINT [FK_CHOIXSOND_SOND] FOREIGN KEY([IDSONDAGE])
REFERENCES [dbo].[SONDAGE] ([ID])
GO
ALTER TABLE [dbo].[CHOIXSONDAGE] CHECK CONSTRAINT [FK_CHOIXSOND_SOND]
GO
ALTER TABLE [dbo].[CONFIRMINSCRIPTION]  WITH CHECK ADD  CONSTRAINT [FK_CONFINSC_UTIL] FOREIGN KEY([IDUTILISATEUR])
REFERENCES [dbo].[UTILISATEUR] ([ID])
GO
ALTER TABLE [dbo].[CONFIRMINSCRIPTION] CHECK CONSTRAINT [FK_CONFINSC_UTIL]
GO
ALTER TABLE [dbo].[DESTINATAIREMESSAGE]  WITH CHECK ADD  CONSTRAINT [FK_DESTMESS_MESSPRIVE] FOREIGN KEY([IDMESSAGE])
REFERENCES [dbo].[MESSAGEPRIVE] ([ID])
GO
ALTER TABLE [dbo].[DESTINATAIREMESSAGE] CHECK CONSTRAINT [FK_DESTMESS_MESSPRIVE]
GO
ALTER TABLE [dbo].[DESTINATAIREMESSAGE]  WITH CHECK ADD  CONSTRAINT [FK_DESTMESS_UTIL] FOREIGN KEY([IDUTILISATEUR])
REFERENCES [dbo].[UTILISATEUR] ([ID])
GO
ALTER TABLE [dbo].[DESTINATAIREMESSAGE] CHECK CONSTRAINT [FK_DESTMESS_UTIL]
GO
ALTER TABLE [dbo].[ECOLESECTEUR]  WITH CHECK ADD  CONSTRAINT [FK_ECOLESECT_ECOLE] FOREIGN KEY([IDECOLE])
REFERENCES [dbo].[ECOLE] ([ID])
GO
ALTER TABLE [dbo].[ECOLESECTEUR] CHECK CONSTRAINT [FK_ECOLESECT_ECOLE]
GO
ALTER TABLE [dbo].[ECOLESECTEUR]  WITH CHECK ADD  CONSTRAINT [FK_ECOLESECT_SECT] FOREIGN KEY([IDSECTEUR])
REFERENCES [dbo].[SECTEUR] ([ID])
GO
ALTER TABLE [dbo].[ECOLESECTEUR] CHECK CONSTRAINT [FK_ECOLESECT_SECT]
GO
ALTER TABLE [dbo].[EVENEMENT]  WITH CHECK ADD  CONSTRAINT [FK_EVEN_CATE] FOREIGN KEY([IDCATEGORIE])
REFERENCES [dbo].[CATEGORIEEVENEMENT] ([ID])
GO
ALTER TABLE [dbo].[EVENEMENT] CHECK CONSTRAINT [FK_EVEN_CATE]
GO
ALTER TABLE [dbo].[EVENEMENT]  WITH CHECK ADD  CONSTRAINT [FK_EVEN_UTIl] FOREIGN KEY([IDCREATEUR])
REFERENCES [dbo].[UTILISATEUR] ([ID])
GO
ALTER TABLE [dbo].[EVENEMENT] CHECK CONSTRAINT [FK_EVEN_UTIl]
GO
ALTER TABLE [dbo].[EVENEMENTSECTEUR]  WITH CHECK ADD  CONSTRAINT [FK_EVENSECT_EVEN] FOREIGN KEY([IDEVENEMENT])
REFERENCES [dbo].[EVENEMENT] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EVENEMENTSECTEUR] CHECK CONSTRAINT [FK_EVENSECT_EVEN]
GO
ALTER TABLE [dbo].[EVENEMENTSECTEUR]  WITH CHECK ADD  CONSTRAINT [FK_EVENSECT_SECT] FOREIGN KEY([IDSECTEUR])
REFERENCES [dbo].[SECTEUR] ([ID])
GO
ALTER TABLE [dbo].[EVENEMENTSECTEUR] CHECK CONSTRAINT [FK_EVENSECT_SECT]
GO
ALTER TABLE [dbo].[FILDISCUSSION]  WITH CHECK ADD  CONSTRAINT [FK_FILDISC_FORUM] FOREIGN KEY([IDFORUM])
REFERENCES [dbo].[FORUM] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FILDISCUSSION] CHECK CONSTRAINT [FK_FILDISC_FORUM]
GO
ALTER TABLE [dbo].[FORUM]  WITH CHECK ADD  CONSTRAINT [FK_FORUM_SECT] FOREIGN KEY([IDSECTEUR])
REFERENCES [dbo].[SECTEUR] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FORUM] CHECK CONSTRAINT [FK_FORUM_SECT]
GO
ALTER TABLE [dbo].[MESSAGEFORUM]  WITH CHECK ADD  CONSTRAINT [FK_MESS_FILDISC] FOREIGN KEY([IDFILDISCUSSION])
REFERENCES [dbo].[FILDISCUSSION] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MESSAGEFORUM] CHECK CONSTRAINT [FK_MESS_FILDISC]
GO
ALTER TABLE [dbo].[MESSAGEFORUM]  WITH CHECK ADD  CONSTRAINT [FK_MESS_UTIL] FOREIGN KEY([IDUTILISATEUR])
REFERENCES [dbo].[UTILISATEUR] ([ID])
GO
ALTER TABLE [dbo].[MESSAGEFORUM] CHECK CONSTRAINT [FK_MESS_UTIL]
GO
ALTER TABLE [dbo].[MESSAGEPRIVE]  WITH CHECK ADD  CONSTRAINT [FK_MESSPRIV_EXPED] FOREIGN KEY([IDEXPEDITEUR])
REFERENCES [dbo].[UTILISATEUR] ([ID])
GO
ALTER TABLE [dbo].[MESSAGEPRIVE] CHECK CONSTRAINT [FK_MESSPRIV_EXPED]
GO
ALTER TABLE [dbo].[MOTCLEPUBLICATION]  WITH CHECK ADD  CONSTRAINT [FK_MOTCLEPUB_MOTCLE] FOREIGN KEY([IDMOTCLE])
REFERENCES [dbo].[MOTCLE] ([ID])
GO
ALTER TABLE [dbo].[MOTCLEPUBLICATION] CHECK CONSTRAINT [FK_MOTCLEPUB_MOTCLE]
GO
ALTER TABLE [dbo].[MOTCLEPUBLICATION]  WITH CHECK ADD  CONSTRAINT [FK_MOTCLEPUB_PUB] FOREIGN KEY([IDPUBLICATION])
REFERENCES [dbo].[PUBLICATION] ([ID])
GO
ALTER TABLE [dbo].[MOTCLEPUBLICATION] CHECK CONSTRAINT [FK_MOTCLEPUB_PUB]
GO
ALTER TABLE [dbo].[PIECEJOINTE]  WITH CHECK ADD  CONSTRAINT [FK_PIECEJOINTE_MESS] FOREIGN KEY([IDMESSAGE])
REFERENCES [dbo].[MESSAGEPRIVE] ([ID])
GO
ALTER TABLE [dbo].[PIECEJOINTE] CHECK CONSTRAINT [FK_PIECEJOINTE_MESS]
GO
ALTER TABLE [dbo].[PUBLICATION]  WITH CHECK ADD  CONSTRAINT [FK_PUB_SECT] FOREIGN KEY([IDSECTEUR])
REFERENCES [dbo].[SECTEUR] ([ID])
GO
ALTER TABLE [dbo].[PUBLICATION] CHECK CONSTRAINT [FK_PUB_SECT]
GO
ALTER TABLE [dbo].[PUBLICATION]  WITH CHECK ADD  CONSTRAINT [FK_PUB_SUJET] FOREIGN KEY([IDSUJET])
REFERENCES [dbo].[SUJETPUBLICATION] ([ID])
GO
ALTER TABLE [dbo].[PUBLICATION] CHECK CONSTRAINT [FK_PUB_SUJET]
GO
ALTER TABLE [dbo].[PUBLICATION]  WITH CHECK ADD  CONSTRAINT [FK_PUB_UTIL] FOREIGN KEY([IDPUBLICATEUR])
REFERENCES [dbo].[UTILISATEUR] ([ID])
GO
ALTER TABLE [dbo].[PUBLICATION] CHECK CONSTRAINT [FK_PUB_UTIL]
GO
ALTER TABLE [dbo].[ROLEDROIT]  WITH CHECK ADD  CONSTRAINT [FK_ROLEDROIT_DROIT] FOREIGN KEY([IDDROIT])
REFERENCES [dbo].[DROIT] ([ID])
GO
ALTER TABLE [dbo].[ROLEDROIT] CHECK CONSTRAINT [FK_ROLEDROIT_DROIT]
GO
ALTER TABLE [dbo].[ROLEDROIT]  WITH CHECK ADD  CONSTRAINT [FK_ROLEDROIT_ROLE] FOREIGN KEY([IDROLE])
REFERENCES [dbo].[ROLE] ([ID])
GO
ALTER TABLE [dbo].[ROLEDROIT] CHECK CONSTRAINT [FK_ROLEDROIT_ROLE]
GO
ALTER TABLE [dbo].[SONDAGE]  WITH CHECK ADD  CONSTRAINT [FK_SOND_CREATEUR] FOREIGN KEY([IDCREATEUR])
REFERENCES [dbo].[UTILISATEUR] ([ID])
GO
ALTER TABLE [dbo].[SONDAGE] CHECK CONSTRAINT [FK_SOND_CREATEUR]
GO
ALTER TABLE [dbo].[SONDAGE]  WITH CHECK ADD  CONSTRAINT [FK_SOND_SECT] FOREIGN KEY([IDSECTEUR])
REFERENCES [dbo].[SECTEUR] ([ID])
GO
ALTER TABLE [dbo].[SONDAGE] CHECK CONSTRAINT [FK_SOND_SECT]
GO
ALTER TABLE [dbo].[UTILISATEUR]  WITH CHECK ADD  CONSTRAINT [FK_UTIL_ECOLE] FOREIGN KEY([IDECOLE])
REFERENCES [dbo].[ECOLE] ([ID])
GO
ALTER TABLE [dbo].[UTILISATEUR] CHECK CONSTRAINT [FK_UTIL_ECOLE]
GO
ALTER TABLE [dbo].[UTILISATEUR]  WITH CHECK ADD  CONSTRAINT [FK_UTIL_ROLE] FOREIGN KEY([IDROLE])
REFERENCES [dbo].[ROLE] ([ID])
GO
ALTER TABLE [dbo].[UTILISATEUR] CHECK CONSTRAINT [FK_UTIL_ROLE]
GO
ALTER TABLE [dbo].[UTILISATEURSECTEUR]  WITH CHECK ADD  CONSTRAINT [FK_UTILSECT_SECT] FOREIGN KEY([IDSECTEUR])
REFERENCES [dbo].[SECTEUR] ([ID])
GO
ALTER TABLE [dbo].[UTILISATEURSECTEUR] CHECK CONSTRAINT [FK_UTILSECT_SECT]
GO
ALTER TABLE [dbo].[UTILISATEURSECTEUR]  WITH CHECK ADD  CONSTRAINT [FK_UTILSECT_UTIL] FOREIGN KEY([IDUTILISATEUR])
REFERENCES [dbo].[UTILISATEUR] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UTILISATEURSECTEUR] CHECK CONSTRAINT [FK_UTILSECT_UTIL]
GO
ALTER TABLE [dbo].[VOTESONDAGE]  WITH CHECK ADD  CONSTRAINT [FK_VOTESOND_CHOIX] FOREIGN KEY([IDCHOIX])
REFERENCES [dbo].[CHOIXSONDAGE] ([ID])
GO
ALTER TABLE [dbo].[VOTESONDAGE] CHECK CONSTRAINT [FK_VOTESOND_CHOIX]
GO
ALTER TABLE [dbo].[VOTESONDAGE]  WITH CHECK ADD  CONSTRAINT [FK_VOTESOND_UTIL] FOREIGN KEY([IDUTILISATEUR])
REFERENCES [dbo].[UTILISATEUR] ([ID])
GO
ALTER TABLE [dbo].[VOTESONDAGE] CHECK CONSTRAINT [FK_VOTESOND_UTIL]
GO
ALTER TABLE [dbo].[UTILISATEUR]  WITH CHECK ADD  CONSTRAINT [CHK_UTIL_LANGUE] CHECK  (([LANGUE]='PT' OR [LANGUE]='FR'))
GO
ALTER TABLE [dbo].[UTILISATEUR] CHECK CONSTRAINT [CHK_UTIL_LANGUE]
GO
