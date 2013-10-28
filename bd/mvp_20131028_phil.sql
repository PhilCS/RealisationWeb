USE [master]
GO
/****** Object:  Database [MVP]    Script Date: 2013-10-28 04:55:53 ******/
CREATE DATABASE [MVP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MVP', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\MVP.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MVP_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\MVP_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MVP] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MVP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MVP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MVP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MVP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MVP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MVP] SET ARITHABORT OFF 
GO
ALTER DATABASE [MVP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MVP] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [MVP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MVP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MVP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MVP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MVP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MVP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MVP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MVP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MVP] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MVP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MVP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MVP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MVP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MVP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MVP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MVP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MVP] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MVP] SET  MULTI_USER 
GO
ALTER DATABASE [MVP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MVP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MVP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MVP] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [MVP]
GO
/****** Object:  User [profFXG]    Script Date: 2013-10-28 04:55:53 ******/
CREATE USER [profFXG] FOR LOGIN [profFXG] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [profFXG]
GO
/****** Object:  StoredProcedure [dbo].[AjouterChoixSondage]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterDestinataireMess]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterEcole]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterEven]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterFilDiscussion]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterMessageForum]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterMessagePrive]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterMotCle]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterNouvelle]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterPartenaire]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterPieceJointe]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterPublication]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AjouterPublication]
	@titre varchar(60),
	@description varchar(100),
	@secteur int,
	@sujet int,
	@nomfichieroriginal varchar(100),
	@nomfichierserveur varchar(32),
	@mimetype varchar(100),
	@idpublicateur int,
	@idpub int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO PUBLICATION (TITRE, DESCRIPTION, IDSECTEUR, IDSUJET, NOMFICHIERORIGINAL, NOMFICHIERSERVEUR, MIMETYPE, IDPUBLICATEUR)
	VALUES (@titre, @description, @secteur, @sujet, @nomfichieroriginal, @nomfichierserveur, @mimetype, @idpublicateur)

	SET @idpub = @@IDENTITY
END


GO
/****** Object:  StoredProcedure [dbo].[AjouterSectEcole]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterSecteur]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterSectEven]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterSondage]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterSujetPub]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterUtilSecteur]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AjouterVoteSondage]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[AugmenterNbrLectures]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[GetContenu]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetContenu] 
	@nomPage varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM CONTENU WHERE PAGE = @nomPage
END


GO
/****** Object:  StoredProcedure [dbo].[GetDestinataires]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  StoredProcedure [dbo].[GetEven]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[GetEvents]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[GetFilDiscussion]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[GetForum]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[GetMessage]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  StoredProcedure [dbo].[GetMessagesEnvoyes]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  StoredProcedure [dbo].[GetMessagesForum]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[GetMessagesPrives]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  StoredProcedure [dbo].[GetMessagesSupprimes]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  StoredProcedure [dbo].[GetNouvelle]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNouvelle]
	@idNouvelle int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM NOUVELLE WHERE ID = @idNouvelle
END

GO
/****** Object:  StoredProcedure [dbo].[GetNouvelles]    Script Date: 2013-10-28 04:55:53 ******/
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

	SELECT * FROM NOUVELLE ORDER BY DATEPUBLICATION DESC;
END

GO
/****** Object:  StoredProcedure [dbo].[GetPartenaire]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[GetPartenaires]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[GetPubParMotCle]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPubParMotCle]
	 @idsecteur int,
	 @motcle varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT p.*
	FROM PUBLICATION p INNER JOIN MOTCLEPUBLICATION mp ON (mp.IDPUBLICATION = p.ID)
					   INNER JOIN MOTCLE m ON (mp.IDMOTCLE = m.ID)
	WHERE p.IDSECTEUR = @idsecteur AND m.VALEUR LIKE @motcle
END


GO
/****** Object:  StoredProcedure [dbo].[GetPubParSecteur]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[GetPubParSujet]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[GetRechercheNouvelle]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRechercheNouvelle]
	@rech varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM NOUVELLE WHERE TITRE LIKE '%' + @rech + '%' OR DESCRIPTION LIKE '%' + @rech + '%' COLLATE SQL_Latin1_General_CP1_CI_AS;
END

GO
/****** Object:  StoredProcedure [dbo].[GetResultatsSondage]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[GetSecteurs]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[GetSondage]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[GetSondages]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[GetSujetsPublication]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSujetsPublication]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT * FROM SUJETPUBLICATION;
END

-- =============================================
-- Authors:		Marie-Christine Noreau
--				Philippe Carpentier-Savard
-- Create date: 2013-09-16
-- Modificaton date: 2013-10-25
-- =============================================

GO
/****** Object:  StoredProcedure [dbo].[getUtil]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getUtil] 
	@username varchar(25)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM UTILISATEUR WHERE NOMUTIL = @username
END


GO
/****** Object:  StoredProcedure [dbo].[GetUtilParSecteur]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[GetUtilProfil]    Script Date: 2013-10-28 04:55:53 ******/
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

	SELECT COURRIEL, NOM, PRENOM, ADRESSE, VILLE, DATENAISSANCE, LANGUE
	FROM UTILISATEUR WHERE ID = @id
END




GO
/****** Object:  StoredProcedure [dbo].[GetUtils]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[LireMessage]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  StoredProcedure [dbo].[MessagePriveCorbeille]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[MessagePriveSuppDef]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[ModiferEven]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[ModifierChoixSondage]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[ModifierContenu]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModifierContenu]
	@nomPage varchar(50),
	@titre varchar(60),
	@titre_trad varchar(60), 
	@cont text,
	@cont_trad text,
	@urlImage varchar(100)
AS
	UPDATE CONTENU
	SET TITRE = @titre, TITRE_TRAD = @titre_trad, CONTENU = @cont, CONTENU_TRAD = @cont_trad, URLIMAGE = @urlImage
	WHERE PAGE = @nomPage
RETURN 0

GO
/****** Object:  StoredProcedure [dbo].[ModifierEcole]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[ModifierMessageForum]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[ModifierNouvelle]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[ModifierPartenaire]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[ModifierPublication]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[ModifierSondage]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[ModifierSujetFilDiscussion]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[ModifierUtilEcole]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[ModifierUtilProfil]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[ReinitMotPasse]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SupprimerChoixSondage]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SupprimerEcole]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SupprimerEven]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SupprimerFilDiscussion]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SupprimerMessageForum]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SupprimerMotClePub]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SupprimerNouvelle]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SupprimerPartenaire]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SupprimerPublication]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SupprimerSectEcole]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SupprimerSecteur]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SupprimerSectEven]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SupprimerSondage]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SupprimerUtilisateur]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SupprimerUtilSect]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[CATEGORIEEVENEMENT]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[CHOIXSONDAGE]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[CONTENU]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CONTENU](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PAGE] [varchar](50) NOT NULL,
	[TITRE] [varchar](60) NOT NULL,
	[TITRE_TRAD] [varchar](60) NOT NULL,
	[CONTENU] [text] NOT NULL,
	[CONTENU_TRAD] [text] NOT NULL,
	[URLIMAGE] [varchar](100) NULL,
 CONSTRAINT [PK_CONTENT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DESTINATAIREMESSAGE]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DESTINATAIREMESSAGE](
	[IDMESSAGE] [int] NOT NULL,
	[IDUTILISATEUR] [int] NOT NULL,
	[SUPPRIME] [bit] NOT NULL,
	[SUPPRIMEDEFINITIF] [bit] NOT NULL,
	[LU] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDMESSAGE] ASC,
	[IDUTILISATEUR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ECOLE]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[ECOLESECTEUR]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[EVENEMENT]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[EVENEMENTSECTEUR]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[FILDISCUSSION]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[FORUM]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[MESSAGEFORUM]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[MESSAGEPRIVE]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[MOTCLE]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[MOTCLEPUBLICATION]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[NOUVELLE]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NOUVELLE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TITRE] [varchar](100) NOT NULL,
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
/****** Object:  Table [dbo].[PARTENAIRE]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[PIECEJOINTE]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[PUBLICATION]    Script Date: 2013-10-28 04:55:53 ******/
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
	[DESCRIPTION] [varchar](100) NOT NULL,
	[IDPUBLICATEUR] [int] NOT NULL,
	[IDSUJET] [int] NOT NULL,
	[IDSECTEUR] [int] NOT NULL,
	[MIMETYPE] [varchar](100) NULL,
	[NOMFICHIERORIGINAL] [varchar](100) NULL,
	[NOMFICHIERSERVEUR] [varchar](32) NULL,
 CONSTRAINT [PK__PUBLICAT__3214EC279D945C0C] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SECTEUR]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SECTEUR](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOM] [varchar](40) NOT NULL,
	[TITREACCUEIL] [varchar](40) NOT NULL,
	[TEXTEACCUEIL] [text] NOT NULL,
	[URLIMAGEACCUEIL] [varchar](100) NOT NULL,
 CONSTRAINT [PK__SECTEUR__3214EC275D936103] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SONDAGE]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[SUJETPUBLICATION]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[UTILISATEUR]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UTILISATEUR](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMUTIL] [varchar](25) NOT NULL,
	[COURRIEL] [varchar](100) NOT NULL,
	[PRENOM] [varchar](60) NOT NULL,
	[NOM] [varchar](60) NOT NULL,
	[ADRESSE] [varchar](50) NOT NULL,
	[VILLE] [varchar](50) NOT NULL,
	[DATENAISSANCE] [date] NOT NULL,
	[DERNIERECONNEXION] [datetime] NULL,
	[LANGUE] [char](2) NOT NULL,
	[IDECOLE] [int] NOT NULL,
 CONSTRAINT [PK__UTILISAT__3214EC278FE56C5C] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UTILISATEURSECTEUR]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[VOTESONDAGE]    Script Date: 2013-10-28 04:55:53 ******/
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
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Membership](
	[UserId] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConfirmationToken] [nvarchar](128) NULL,
	[IsConfirmed] [bit] NULL,
	[LastPasswordFailureDate] [datetime] NULL,
	[PasswordFailuresSinceLastSuccess] [int] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordChangedDate] [datetime] NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[PasswordVerificationToken] [nvarchar](128) NULL,
	[PasswordVerificationTokenExpirationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_OAuthMembership](
	[Provider] [nvarchar](30) NOT NULL,
	[ProviderUserId] [nvarchar](100) NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Provider] ASC,
	[ProviderUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 2013-10-28 04:55:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_UsersInRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[CATEGORIEEVENEMENT] ON 

INSERT [dbo].[CATEGORIEEVENEMENT] ([ID], [NOM]) VALUES (1, N'Technical')
INSERT [dbo].[CATEGORIEEVENEMENT] ([ID], [NOM]) VALUES (2, N'Accounting')
INSERT [dbo].[CATEGORIEEVENEMENT] ([ID], [NOM]) VALUES (3, N'Web')
INSERT [dbo].[CATEGORIEEVENEMENT] ([ID], [NOM]) VALUES (4, N'Corporate Sales')
INSERT [dbo].[CATEGORIEEVENEMENT] ([ID], [NOM]) VALUES (5, N'Accessory Sales')
INSERT [dbo].[CATEGORIEEVENEMENT] ([ID], [NOM]) VALUES (6, N'Consumer Sales')
INSERT [dbo].[CATEGORIEEVENEMENT] ([ID], [NOM]) VALUES (7, N'Marketing')
INSERT [dbo].[CATEGORIEEVENEMENT] ([ID], [NOM]) VALUES (8, N'Cutomer')
INSERT [dbo].[CATEGORIEEVENEMENT] ([ID], [NOM]) VALUES (9, N'Corporate Care')
INSERT [dbo].[CATEGORIEEVENEMENT] ([ID], [NOM]) VALUES (10, N'Technical Sales')
SET IDENTITY_INSERT [dbo].[CATEGORIEEVENEMENT] OFF
SET IDENTITY_INSERT [dbo].[CHOIXSONDAGE] ON 

INSERT [dbo].[CHOIXSONDAGE] ([ID], [IDSONDAGE], [VALEUR]) VALUES (1, 8, N'Oui')
INSERT [dbo].[CHOIXSONDAGE] ([ID], [IDSONDAGE], [VALEUR]) VALUES (2, 9, N'Non')
SET IDENTITY_INSERT [dbo].[CHOIXSONDAGE] OFF
SET IDENTITY_INSERT [dbo].[CONTENU] ON 

INSERT [dbo].[CONTENU] ([ID], [PAGE], [TITRE], [TITRE_TRAD], [CONTENU], [CONTENU_TRAD], [URLIMAGE]) VALUES (5, N'Accueil', N'Bienvenue', N'Welcome', N'je m''appelle buzz.', N'Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Maecenas sed diam eget risus varius blandit sit amet non magna. 
    Nullam quis risus eget urna mollis ornare vel eu leo. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus.', NULL)
INSERT [dbo].[CONTENU] ([ID], [PAGE], [TITRE], [TITRE_TRAD], [CONTENU], [CONTENU_TRAD], [URLIMAGE]) VALUES (6, N'About', N'Qui sommes-nous?', N'About us', N'Nulla vitae elit libero, a pharetra augue. Vivamus sagittis lacus vel augue laoreet
        rutrum faucibus dolor auctor. Donec ullamcorper nulla non metus auctor fringilla.
        Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa 
    justo sit amet risus. Maecenas sed diam eget risus varius blandit sit amet non magna.', N'Nulla vitae elit libero, a pharetra augue. Vivamus sagittis lacus vel augue laoreet
        rutrum faucibus dolor auctor. Donec ullamcorper nulla non metus auctor fringilla.
        Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa 
    justo sit amet risus. Maecenas sed diam eget risus varius blandit sit amet non magna.', NULL)
INSERT [dbo].[CONTENU] ([ID], [PAGE], [TITRE], [TITRE_TRAD], [CONTENU], [CONTENU_TRAD], [URLIMAGE]) VALUES (7, N'Contact', N'Nous joindre', N'Contact us', N'5151 rue des Ormes, Maputo, HHH 111, 1 555 555 55555', N'5151 rue des Ormes, Maputo, HHH 111, 1 555 555 55555', NULL)
SET IDENTITY_INSERT [dbo].[CONTENU] OFF
INSERT [dbo].[DESTINATAIREMESSAGE] ([IDMESSAGE], [IDUTILISATEUR], [SUPPRIME], [SUPPRIMEDEFINITIF], [LU]) VALUES (1, 10, 0, 0, 0)
INSERT [dbo].[DESTINATAIREMESSAGE] ([IDMESSAGE], [IDUTILISATEUR], [SUPPRIME], [SUPPRIMEDEFINITIF], [LU]) VALUES (2, 5, 1, 0, 0)
INSERT [dbo].[DESTINATAIREMESSAGE] ([IDMESSAGE], [IDUTILISATEUR], [SUPPRIME], [SUPPRIMEDEFINITIF], [LU]) VALUES (3, 8, 0, 0, 0)
INSERT [dbo].[DESTINATAIREMESSAGE] ([IDMESSAGE], [IDUTILISATEUR], [SUPPRIME], [SUPPRIMEDEFINITIF], [LU]) VALUES (4, 4, 1, 0, 0)
INSERT [dbo].[DESTINATAIREMESSAGE] ([IDMESSAGE], [IDUTILISATEUR], [SUPPRIME], [SUPPRIMEDEFINITIF], [LU]) VALUES (5, 6, 1, 0, 0)
INSERT [dbo].[DESTINATAIREMESSAGE] ([IDMESSAGE], [IDUTILISATEUR], [SUPPRIME], [SUPPRIMEDEFINITIF], [LU]) VALUES (6, 9, 0, 0, 0)
INSERT [dbo].[DESTINATAIREMESSAGE] ([IDMESSAGE], [IDUTILISATEUR], [SUPPRIME], [SUPPRIMEDEFINITIF], [LU]) VALUES (7, 3, 0, 0, 0)
INSERT [dbo].[DESTINATAIREMESSAGE] ([IDMESSAGE], [IDUTILISATEUR], [SUPPRIME], [SUPPRIMEDEFINITIF], [LU]) VALUES (8, 1, 0, 0, 1)
INSERT [dbo].[DESTINATAIREMESSAGE] ([IDMESSAGE], [IDUTILISATEUR], [SUPPRIME], [SUPPRIMEDEFINITIF], [LU]) VALUES (9, 2, 0, 0, 0)
INSERT [dbo].[DESTINATAIREMESSAGE] ([IDMESSAGE], [IDUTILISATEUR], [SUPPRIME], [SUPPRIMEDEFINITIF], [LU]) VALUES (10, 7, 1, 0, 0)
SET IDENTITY_INSERT [dbo].[ECOLE] ON 

INSERT [dbo].[ECOLE] ([ID], [NOM], [PROVINCE]) VALUES (1, N'Instituto Agrário de Lichinga', N'Niassa')
INSERT [dbo].[ECOLE] ([ID], [NOM], [PROVINCE]) VALUES (2, N'Instituto Industrial e Comercial de NGungunhana', N'Niassa')
INSERT [dbo].[ECOLE] ([ID], [NOM], [PROVINCE]) VALUES (3, N'Instituto de Ecoturismo Armando Gabueza de Marupa', N'Niassa')
INSERT [dbo].[ECOLE] ([ID], [NOM], [PROVINCE]) VALUES (4, N'Instituto Industrial e Comercial 3 de Fevereiro', N'Nampula')
INSERT [dbo].[ECOLE] ([ID], [NOM], [PROVINCE]) VALUES (5, N'Instituto Agrário de Ribáuè', N'Nampula')
INSERT [dbo].[ECOLE] ([ID], [NOM], [PROVINCE]) VALUES (6, N'Instituto Polictécnico Agrario de Nacuxa', N'Nampula')
INSERT [dbo].[ECOLE] ([ID], [NOM], [PROVINCE]) VALUES (7, N'Escola Feminina  Comunitaria de Nacala
', N'Nampula')
INSERT [dbo].[ECOLE] ([ID], [NOM], [PROVINCE]) VALUES (8, N'Escola Profissional de Ilha de Mocambique', N'Nampula')
INSERT [dbo].[ECOLE] ([ID], [NOM], [PROVINCE]) VALUES (9, N'Escola Profissional de Murrupula', N'Nampula')
SET IDENTITY_INSERT [dbo].[ECOLE] OFF
INSERT [dbo].[ECOLESECTEUR] ([IDECOLE], [IDSECTEUR]) VALUES (1, 1)
INSERT [dbo].[ECOLESECTEUR] ([IDECOLE], [IDSECTEUR]) VALUES (2, 2)
INSERT [dbo].[ECOLESECTEUR] ([IDECOLE], [IDSECTEUR]) VALUES (3, 3)
INSERT [dbo].[ECOLESECTEUR] ([IDECOLE], [IDSECTEUR]) VALUES (4, 2)
INSERT [dbo].[ECOLESECTEUR] ([IDECOLE], [IDSECTEUR]) VALUES (4, 11)
INSERT [dbo].[ECOLESECTEUR] ([IDECOLE], [IDSECTEUR]) VALUES (5, 1)
INSERT [dbo].[ECOLESECTEUR] ([IDECOLE], [IDSECTEUR]) VALUES (6, 1)
INSERT [dbo].[ECOLESECTEUR] ([IDECOLE], [IDSECTEUR]) VALUES (7, 11)
INSERT [dbo].[ECOLESECTEUR] ([IDECOLE], [IDSECTEUR]) VALUES (8, 2)
INSERT [dbo].[ECOLESECTEUR] ([IDECOLE], [IDSECTEUR]) VALUES (8, 3)
INSERT [dbo].[ECOLESECTEUR] ([IDECOLE], [IDSECTEUR]) VALUES (8, 11)
INSERT [dbo].[ECOLESECTEUR] ([IDECOLE], [IDSECTEUR]) VALUES (9, 1)
INSERT [dbo].[ECOLESECTEUR] ([IDECOLE], [IDSECTEUR]) VALUES (9, 2)
SET IDENTITY_INSERT [dbo].[EVENEMENT] ON 

INSERT [dbo].[EVENEMENT] ([ID], [NOM], [DATEEVEN], [HEUREDEBUT], [HEUREFIN], [IDCATEGORIE], [IDCREATEUR]) VALUES (1, N'Zeejubin', CAST(0x81340B00 AS Date), CAST(0x07D6C3DBD6030000 AS Time), CAST(0x07990420F89C0000 AS Time), 8, 1)
INSERT [dbo].[EVENEMENT] ([ID], [NOM], [DATEEVEN], [HEUREDEBUT], [HEUREFIN], [IDCATEGORIE], [IDCREATEUR]) VALUES (2, N'Varpickilower', CAST(0xFD340B00 AS Date), CAST(0x0789F031C25C0000 AS Time), CAST(0x0767960A467A0000 AS Time), 9, 1)
INSERT [dbo].[EVENEMENT] ([ID], [NOM], [DATEEVEN], [HEUREDEBUT], [HEUREFIN], [IDCATEGORIE], [IDCREATEUR]) VALUES (3, N'Unwerplar', CAST(0x7D340B00 AS Date), CAST(0x079BA07136150000 AS Time), CAST(0x07EA88291AC00000 AS Time), 8, 1)
INSERT [dbo].[EVENEMENT] ([ID], [NOM], [DATEEVEN], [HEUREDEBUT], [HEUREFIN], [IDCATEGORIE], [IDCREATEUR]) VALUES (4, N'Parfropollin', CAST(0x57360B00 AS Date), CAST(0x071B0B41D50F0000 AS Time), CAST(0x078C618AE2890000 AS Time), 6, 1)
INSERT [dbo].[EVENEMENT] ([ID], [NOM], [DATEEVEN], [HEUREDEBUT], [HEUREFIN], [IDCATEGORIE], [IDCREATEUR]) VALUES (5, N'Inkilentor', CAST(0xD5330B00 AS Date), CAST(0x078F78677F510000 AS Time), CAST(0x07B36549E97E0000 AS Time), 3, 1)
INSERT [dbo].[EVENEMENT] ([ID], [NOM], [DATEEVEN], [HEUREDEBUT], [HEUREFIN], [IDCATEGORIE], [IDCREATEUR]) VALUES (6, N'Haphupentor', CAST(0x09340B00 AS Date), CAST(0x07FCED102B1C0000 AS Time), CAST(0x07787E6811740000 AS Time), 6, 1)
INSERT [dbo].[EVENEMENT] ([ID], [NOM], [DATEEVEN], [HEUREDEBUT], [HEUREFIN], [IDCATEGORIE], [IDCREATEUR]) VALUES (7, N'Rapsipover', CAST(0x52340B00 AS Date), CAST(0x0710CE4F985C0000 AS Time), CAST(0x076404F7A9890000 AS Time), 10, 1)
INSERT [dbo].[EVENEMENT] ([ID], [NOM], [DATEEVEN], [HEUREDEBUT], [HEUREFIN], [IDCATEGORIE], [IDCREATEUR]) VALUES (8, N'Tupdimower', CAST(0x85340B00 AS Date), CAST(0x07394E811D020000 AS Time), CAST(0x077A11B328990000 AS Time), 5, 1)
INSERT [dbo].[EVENEMENT] ([ID], [NOM], [DATEEVEN], [HEUREDEBUT], [HEUREFIN], [IDCATEGORIE], [IDCREATEUR]) VALUES (9, N'Gronipicistor', CAST(0x68320B00 AS Date), CAST(0x07152982160F0000 AS Time), CAST(0x07BC48691D800000 AS Time), 10, 1)
INSERT [dbo].[EVENEMENT] ([ID], [NOM], [DATEEVEN], [HEUREDEBUT], [HEUREFIN], [IDCATEGORIE], [IDCREATEUR]) VALUES (10, N'Trumunentor', CAST(0x3C330B00 AS Date), CAST(0x07B496B11F3B0000 AS Time), CAST(0x07E97D4CCCC40000 AS Time), 3, 1)
SET IDENTITY_INSERT [dbo].[EVENEMENT] OFF
SET IDENTITY_INSERT [dbo].[FILDISCUSSION] ON 

INSERT [dbo].[FILDISCUSSION] ([ID], [SUJET], [DATEPUBLICATION], [DATEMODIFICATION], [NBLECTURES], [IDFORUM]) VALUES (8, N'Refropin', CAST(0x0000A117000ACD46 AS DateTime), CAST(0x0000A11A007F6827 AS DateTime), 48, 1)
INSERT [dbo].[FILDISCUSSION] ([ID], [SUJET], [DATEPUBLICATION], [DATEMODIFICATION], [NBLECTURES], [IDFORUM]) VALUES (12, N'Thrufropover', CAST(0x00009D5700020691 AS DateTime), CAST(0x00009D5D00301ABB AS DateTime), 100, 1)
INSERT [dbo].[FILDISCUSSION] ([ID], [SUJET], [DATEPUBLICATION], [DATEMODIFICATION], [NBLECTURES], [IDFORUM]) VALUES (15, N'Grorobantor', CAST(0x00009E52013C16C1 AS DateTime), CAST(0x00009E52017B2A35 AS DateTime), 83, 1)
INSERT [dbo].[FILDISCUSSION] ([ID], [SUJET], [DATEPUBLICATION], [DATEMODIFICATION], [NBLECTURES], [IDFORUM]) VALUES (25, N'Cipdimistor', CAST(0x00009D70013DB011 AS DateTime), CAST(0x00009D720078D944 AS DateTime), 61, 3)
SET IDENTITY_INSERT [dbo].[FILDISCUSSION] OFF
SET IDENTITY_INSERT [dbo].[FORUM] ON 

INSERT [dbo].[FORUM] ([ID], [TITRE], [IDSECTEUR]) VALUES (1, N'Agriculture', 1)
INSERT [dbo].[FORUM] ([ID], [TITRE], [IDSECTEUR]) VALUES (2, N'Construction civile', 2)
INSERT [dbo].[FORUM] ([ID], [TITRE], [IDSECTEUR]) VALUES (3, N'Tourisme', 3)
INSERT [dbo].[FORUM] ([ID], [TITRE], [IDSECTEUR]) VALUES (11, N'Comptabilité', 11)
SET IDENTITY_INSERT [dbo].[FORUM] OFF
SET IDENTITY_INSERT [dbo].[MESSAGEFORUM] ON 

INSERT [dbo].[MESSAGEFORUM] ([ID], [DATEPUBLICATION], [DATEMODIFICATION], [CONTENU], [IDUTILISATEUR], [IDFILDISCUSSION]) VALUES (2, CAST(0x00009DB400399135 AS DateTime), CAST(0x00009DB700B0578B AS DateTime), N'fecit, estis linguens vobis essit. plurissimum esset pars sed novum quo quorum brevens, imaginator linguens brevens,', 6, 25)
INSERT [dbo].[MESSAGEFORUM] ([ID], [DATEPUBLICATION], [DATEMODIFICATION], [CONTENU], [IDUTILISATEUR], [IDFILDISCUSSION]) VALUES (9, CAST(0x00009DDD005B8AE0 AS DateTime), CAST(0x00009DE400512D24 AS DateTime), N'plorum parte et bono Id dolorum delerium. esset Sed quoque funem. Versus funem. trepicandor et quorum', 10, 15)
INSERT [dbo].[MESSAGEFORUM] ([ID], [DATEPUBLICATION], [DATEMODIFICATION], [CONTENU], [IDUTILISATEUR], [IDFILDISCUSSION]) VALUES (11, CAST(0x00009D90001469D0 AS DateTime), CAST(0x00009D94011883C6 AS DateTime), N'nomen venit. non glavans fecit. gravis eggredior. regit, Versus esset travissimantor et fecundio, Pro', 10, 15)
INSERT [dbo].[MESSAGEFORUM] ([ID], [DATEPUBLICATION], [DATEMODIFICATION], [CONTENU], [IDUTILISATEUR], [IDFILDISCUSSION]) VALUES (18, CAST(0x00009F8600B58933 AS DateTime), CAST(0x00009F8B00F2BDDC AS DateTime), N'Versus venit. et e Sed et novum non estis gravis habitatio Quad Tam regit, quad vobis homo, esset e pladior', 6, 25)
INSERT [dbo].[MESSAGEFORUM] ([ID], [DATEPUBLICATION], [DATEMODIFICATION], [CONTENU], [IDUTILISATEUR], [IDFILDISCUSSION]) VALUES (33, CAST(0x00009EEE014EEF09 AS DateTime), CAST(0x00009EF000878031 AS DateTime), N'nomen plurissimum sed fecit. parte eggredior. vobis transit. estis Et quad dolorum quorum et et volcans', 8, 12)
INSERT [dbo].[MESSAGEFORUM] ([ID], [DATEPUBLICATION], [DATEMODIFICATION], [CONTENU], [IDUTILISATEUR], [IDFILDISCUSSION]) VALUES (48, CAST(0x00009EF50167549A AS DateTime), CAST(0x00009EF7013C3CCB AS DateTime), N'si Versus vantis. quo quo gravis linguens imaginator pladior e gravum nomen homo, regit, quantare quoque delerium. Tam habitatio', 10, 15)
INSERT [dbo].[MESSAGEFORUM] ([ID], [DATEPUBLICATION], [DATEMODIFICATION], [CONTENU], [IDUTILISATEUR], [IDFILDISCUSSION]) VALUES (51, CAST(0x00009E6A013CB01B AS DateTime), CAST(0x00009E6E01190721 AS DateTime), N'cognitio, plorum esset linguens quorum e esset glavans volcans e et quad habitatio quartu vantis. Versus', 6, 25)
SET IDENTITY_INSERT [dbo].[MESSAGEFORUM] OFF
SET IDENTITY_INSERT [dbo].[MESSAGEPRIVE] ON 

INSERT [dbo].[MESSAGEPRIVE] ([ID], [IDEXPEDITEUR], [SUJET], [CONTENU], [DATEENVOI], [SUPPRIME], [SUPPRIMEDEFINITIF]) VALUES (1, 7, N'Endwerpollazz', N'quo Sed quo nomen Tam Versus si esset et quis bono Sed Et Pro eggredior. eudis funem. venit. venit. bono linguens regit, quad brevens, regit, in nomen regit, glavans egreddior egreddior nomen et vobis pladior quo, vobis cognitio, apparens parte novum bono et', CAST(0x00009E8F00CAE43B AS DateTime), 0, 0)
INSERT [dbo].[MESSAGEPRIVE] ([ID], [IDEXPEDITEUR], [SUJET], [CONTENU], [DATEENVOI], [SUPPRIME], [SUPPRIMEDEFINITIF]) VALUES (2, 6, N'Tippickedar', N'quad manifestum transit. Id volcans sed gravis regit, apparens funem. Sed fecundio, transit. non travissimantor rarendum eggredior. cognitio, quad parte brevens, quorum quo, trepicandor rarendum essit. manifestum plurissimum vantis. fecundio, apparens glavans pars quoque et', CAST(0x00009F29013A1906 AS DateTime), 0, 0)
INSERT [dbo].[MESSAGEPRIVE] ([ID], [IDEXPEDITEUR], [SUJET], [CONTENU], [DATEENVOI], [SUPPRIME], [SUPPRIMEDEFINITIF]) VALUES (3, 7, N'Supnipepantor', N'estum. et glavans gravum nomen essit. parte et Et nomen dolorum e fecundio, regit, quoque eggredior. quantare novum quo glavans transit. si plorum pars delerium. nomen manifestum dolorum linguens Quad si Versus quo et venit. et gravis dolorum estis linguens quorum parte fecit. apparens', CAST(0x0000A00F0081CDFB AS DateTime), 0, 0)
INSERT [dbo].[MESSAGEPRIVE] ([ID], [IDEXPEDITEUR], [SUJET], [CONTENU], [DATEENVOI], [SUPPRIME], [SUPPRIMEDEFINITIF]) VALUES (4, 4, N'Emcadan', N'quartu si quad quo parte pladior et parte venit. quad Id fecit, si funem. fecundio, brevens, quo quorum regit, in estis trepicandor quo apparens nomen estum. rarendum nomen quartu habitatio habitatio cognitio, quoque nomen apparens habitatio Pro Multum vantis. gravis si estis quoque fecit. funem. Longam,', CAST(0x00009DCA0122F847 AS DateTime), 0, 0)
INSERT [dbo].[MESSAGEPRIVE] ([ID], [IDEXPEDITEUR], [SUJET], [CONTENU], [DATEENVOI], [SUPPRIME], [SUPPRIMEDEFINITIF]) VALUES (5, 1, N'Adtinicistor', N'ut Multum non linguens plorum imaginator plorum e Et quo delerium. novum Versus non nomen linguens Pro ut ut et regit, funem. transit. habitatio fecit. estis Sed plorum Sed manifestum quo Pro Longam, quad pars quo, quis plorum essit. quad quo estis Quad quad gravum', CAST(0x0000A0A90039BE92 AS DateTime), 0, 0)
INSERT [dbo].[MESSAGEPRIVE] ([ID], [IDEXPEDITEUR], [SUJET], [CONTENU], [DATEENVOI], [SUPPRIME], [SUPPRIMEDEFINITIF]) VALUES (6, 4, N'Inglibedgar', N'quantare in linguens pars ut gravis trepicandor quo manifestum Multum venit. trepicandor egreddior brevens, nomen novum e parte quantare nomen venit. Multum plorum bono linguens Longam, Et e quad nomen in in et plorum Quad volcans non dolorum gravum quoque', CAST(0x00009F20012A3FDA AS DateTime), 0, 0)
INSERT [dbo].[MESSAGEPRIVE] ([ID], [IDEXPEDITEUR], [SUJET], [CONTENU], [DATEENVOI], [SUPPRIME], [SUPPRIMEDEFINITIF]) VALUES (7, 2, N'Winkilex', N'apparens novum esset non Pro quad eggredior. quartu quo quad vobis fecit, plurissimum brevens, Pro gravum quis quo essit. regit, gravis quo estum. volcans egreddior in plorum novum venit. pars cognitio, linguens si quis apparens quorum Sed novum estis fecit, Versus', CAST(0x00009EBC004493C1 AS DateTime), 0, 0)
INSERT [dbo].[MESSAGEPRIVE] ([ID], [IDEXPEDITEUR], [SUJET], [CONTENU], [DATEENVOI], [SUPPRIME], [SUPPRIMEDEFINITIF]) VALUES (8, 10, N'Parcadedicator', N'parte gravis e e linguens et estis quis esset plorum vobis gravum Longam, plorum egreddior quo, vobis regit, Id novum gravum glavans quad eudis vantis. esset quorum fecundio, eggredior. essit. quartu rarendum si plorum linguens regit, vobis fecit, brevens, et', CAST(0x00009D910179EFB9 AS DateTime), 0, 0)
INSERT [dbo].[MESSAGEPRIVE] ([ID], [IDEXPEDITEUR], [SUJET], [CONTENU], [DATEENVOI], [SUPPRIME], [SUPPRIMEDEFINITIF]) VALUES (9, 2, N'Reglibinover', N'linguens quad in plurissimum non volcans quorum brevens, non volcans egreddior nomen Quad Longam, et quorum vobis venit. vobis quoque vobis manifestum si manifestum plurissimum gravum Versus glavans quad Et bono vobis quo nomen et pars vobis venit. gravum plorum', CAST(0x00009FF301253F04 AS DateTime), 0, 0)
INSERT [dbo].[MESSAGEPRIVE] ([ID], [IDEXPEDITEUR], [SUJET], [CONTENU], [DATEENVOI], [SUPPRIME], [SUPPRIMEDEFINITIF]) VALUES (10, 1, N'Adrobantor', N'funem. imaginator brevens, estum. dolorum linguens et volcans et volcans quo, gravis egreddior vantis. et eudis homo, transit. pars vobis nomen dolorum egreddior et e regit, apparens essit. novum eggredior. quo delerium. plorum et Multum cognitio, nomen nomen', CAST(0x0000A10F00E07924 AS DateTime), 0, 0)
SET IDENTITY_INSERT [dbo].[MESSAGEPRIVE] OFF
SET IDENTITY_INSERT [dbo].[MOTCLE] ON 

INSERT [dbo].[MOTCLE] ([ID], [VALEUR]) VALUES (1, N'International Sales')
INSERT [dbo].[MOTCLE] ([ID], [VALEUR]) VALUES (2, N'National Sales')
INSERT [dbo].[MOTCLE] ([ID], [VALEUR]) VALUES (3, N'Accessory Sales')
INSERT [dbo].[MOTCLE] ([ID], [VALEUR]) VALUES (4, N'Cutomer')
INSERT [dbo].[MOTCLE] ([ID], [VALEUR]) VALUES (5, N'Service')
INSERT [dbo].[MOTCLE] ([ID], [VALEUR]) VALUES (6, N'Business Sales')
INSERT [dbo].[MOTCLE] ([ID], [VALEUR]) VALUES (7, N'Corporate Care')
INSERT [dbo].[MOTCLE] ([ID], [VALEUR]) VALUES (8, N'Web')
INSERT [dbo].[MOTCLE] ([ID], [VALEUR]) VALUES (9, N'Technical Sales')
INSERT [dbo].[MOTCLE] ([ID], [VALEUR]) VALUES (10, N'Corporate Sales')
INSERT [dbo].[MOTCLE] ([ID], [VALEUR]) VALUES (11, N'Consumer Sales')
INSERT [dbo].[MOTCLE] ([ID], [VALEUR]) VALUES (12, N'Accounting')
INSERT [dbo].[MOTCLE] ([ID], [VALEUR]) VALUES (13, N'Technical')
INSERT [dbo].[MOTCLE] ([ID], [VALEUR]) VALUES (14, N'Prepaid Customer')
INSERT [dbo].[MOTCLE] ([ID], [VALEUR]) VALUES (15, N'Marketing')
SET IDENTITY_INSERT [dbo].[MOTCLE] OFF
INSERT [dbo].[MOTCLEPUBLICATION] ([IDPUBLICATION], [IDMOTCLE]) VALUES (1, 2)
INSERT [dbo].[MOTCLEPUBLICATION] ([IDPUBLICATION], [IDMOTCLE]) VALUES (2, 3)
INSERT [dbo].[MOTCLEPUBLICATION] ([IDPUBLICATION], [IDMOTCLE]) VALUES (3, 5)
INSERT [dbo].[MOTCLEPUBLICATION] ([IDPUBLICATION], [IDMOTCLE]) VALUES (4, 7)
INSERT [dbo].[MOTCLEPUBLICATION] ([IDPUBLICATION], [IDMOTCLE]) VALUES (5, 8)
INSERT [dbo].[MOTCLEPUBLICATION] ([IDPUBLICATION], [IDMOTCLE]) VALUES (6, 14)
INSERT [dbo].[MOTCLEPUBLICATION] ([IDPUBLICATION], [IDMOTCLE]) VALUES (7, 10)
INSERT [dbo].[MOTCLEPUBLICATION] ([IDPUBLICATION], [IDMOTCLE]) VALUES (8, 11)
INSERT [dbo].[MOTCLEPUBLICATION] ([IDPUBLICATION], [IDMOTCLE]) VALUES (9, 13)
INSERT [dbo].[MOTCLEPUBLICATION] ([IDPUBLICATION], [IDMOTCLE]) VALUES (10, 15)
SET IDENTITY_INSERT [dbo].[NOUVELLE] ON 

INSERT [dbo].[NOUVELLE] ([ID], [TITRE], [DESCRIPTION], [DATEPUBLICATION]) VALUES (1, N'Supbanax', N'Sed novum delerium. quorum linguens et trepicandor novum Quad quo non et novum Versus non Pro Tam quo, habitatio plorum si quantare ut cognitio, novum quad esset quad quartu eudis funem. essit. quartu vobis quartu rarendum vobis plorum estis quoque non esset', CAST(0x0000A02201894026 AS DateTime))
INSERT [dbo].[NOUVELLE] ([ID], [TITRE], [DESCRIPTION], [DATEPUBLICATION]) VALUES (2, N'Happebover', N'quantare nomen non plurissimum estis Pro gravis quad et pars homo, vobis Quad pars linguens apparens parte quartu non et funem. habitatio linguens fecit. vobis essit. quo, gravum non nomen nomen quantare eggredior. vobis quoque et fecit. regit, rarendum non', CAST(0x00009F8A0158DC81 AS DateTime))
INSERT [dbo].[NOUVELLE] ([ID], [TITRE], [DESCRIPTION], [DATEPUBLICATION]) VALUES (3, N'Emsapilentor', N'quo estis brevens, et Id vantis. bono apparens e regit, plurissimum Id imaginator linguens quad vobis quad cognitio, vantis. e plurissimum nomen pars Et et gravum quad rarendum plorum vobis habitatio vantis. in quorum esset Tam apparens e vobis travissimantor quis', CAST(0x00009E500072D665 AS DateTime))
INSERT [dbo].[NOUVELLE] ([ID], [TITRE], [DESCRIPTION], [DATEPUBLICATION]) VALUES (4, N'Truglibplover', N'eudis fecit, quantare vobis eggredior. et estis si quis novum travissimantor nomen quoque linguens egreddior si vantis. si linguens Versus quad egreddior gravis Longam, quis et egreddior pars delerium. quoque Quad Quad Sed plurissimum linguens essit. quartu essit.', CAST(0x00009FDC0090F7FB AS DateTime))
INSERT [dbo].[NOUVELLE] ([ID], [TITRE], [DESCRIPTION], [DATEPUBLICATION]) VALUES (5, N'Klieristor', N'bono quad linguens in trepicandor quad Et gravis et Longam, Pro quartu linguens trepicandor novum vobis plorum gravis dolorum linguens Versus linguens e imaginator et non fecit. manifestum transit. brevens, Tam cognitio, pars et non fecit. plurissimum sed et', CAST(0x00009E93001CBE58 AS DateTime))
INSERT [dbo].[NOUVELLE] ([ID], [TITRE], [DESCRIPTION], [DATEPUBLICATION]) VALUES (6, N'Parjubedover', N'vantis. et Versus vobis Versus gravum glavans vobis plorum Multum e gravis non quo Quad Tam et in Et Multum fecit. Longam, gravis gravis Pro ut in ut Multum fecit, quorum non nomen quad parte ut venit. fecit. Tam Id quantare plurissimum non Sed e linguens parte', CAST(0x00009E0301814CAF AS DateTime))
INSERT [dbo].[NOUVELLE] ([ID], [TITRE], [DESCRIPTION], [DATEPUBLICATION]) VALUES (7, N'Hapnipimantor', N'et Multum vobis Pro Versus quis e quo eudis quo Longam, et homo, quad funem. et nomen Quad pladior gravis linguens novum Id sed quorum fecit. pars vobis quad homo, estis plorum Tam bono non Id essit. habitatio vantis. et in si quad et quartu linguens plorum', CAST(0x00009EA800E36EDA AS DateTime))
INSERT [dbo].[NOUVELLE] ([ID], [TITRE], [DESCRIPTION], [DATEPUBLICATION]) VALUES (8, N'Enddudedax', N'novum et essit. si in Sed quad quo estum. quoque bono quoque rarendum fecit. travissimantor plorum essit. glavans si cognitio, regit, e glavans Multum et Id quartu pars eudis delerium. transit. quo, vantis. quis trepicandor e quad homo, Sed apparens et essit.', CAST(0x0000A0730088A7A8 AS DateTime))
INSERT [dbo].[NOUVELLE] ([ID], [TITRE], [DESCRIPTION], [DATEPUBLICATION]) VALUES (9, N'Upwerpor', N'e Et dolorum non et vobis gravis glavans novum fecit. non non parte eggredior. homo, cognitio, in e Et eudis homo, plorum eudis Longam, linguens vobis eggredior. Versus estum. novum estum. pladior gravis novum vobis cognitio, delerium. si linguens gravum in', CAST(0x00009FAB009AB540 AS DateTime))
INSERT [dbo].[NOUVELLE] ([ID], [TITRE], [DESCRIPTION], [DATEPUBLICATION]) VALUES (10, N'Emvenover', N'quartu e eudis Tam homo, quo Et quorum plorum quantare apparens volcans Et gravum pars eggredior. Pro dolorum non quartu quantare Id nomen et plurissimum plorum vantis. quorum imaginator funem. plorum et gravis transit. parte dolorum novum Quad transit. nomen nomen pars', CAST(0x00009EA30168B5E6 AS DateTime))
SET IDENTITY_INSERT [dbo].[NOUVELLE] OFF
SET IDENTITY_INSERT [dbo].[PARTENAIRE] ON 

INSERT [dbo].[PARTENAIRE] ([ID], [NOM], [RAISONSOCIALE], [ADRESSE], [VILLE], [PAYS], [TELEPHONE], [SITEWEB], [COURRIEL]) VALUES (1, N'Frotanepor Direct ', N'Poultry', N'702 Green Hague Parkway', N'Cleveland', N'Rwanda', N'(180) 506-3394', N'http://gwc.net58/eqzfo/kkzse/ecyir/sjy.php', N'npiymlb.uyimx@example.com')
INSERT [dbo].[PARTENAIRE] ([ID], [NOM], [RAISONSOCIALE], [ADRESSE], [VILLE], [PAYS], [TELEPHONE], [SITEWEB], [COURRIEL]) VALUES (2, N'Bardudplistor  ', N'Snails', N'390 Second Way', N'Atlanta', N'Nicaragua', N'573-599-0240', N'http://adn.localv/dvjxg/psdxu/qcszo.htm', N'kakjvkin2@example.com')
INSERT [dbo].[PARTENAIRE] ([ID], [NOM], [RAISONSOCIALE], [ADRESSE], [VILLE], [PAYS], [TELEPHONE], [SITEWEB], [COURRIEL]) VALUES (3, N'Rapwerackistor  ', N'Produce', N'394 West White First Drive', N'Jackson', N'Lebanon', N'061-606-1202', N'http://pcccq.local01/eezai/acgia/bttka/vtomy/btseh.htm', N'fntfxyj55@example.com')
INSERT [dbo].[PARTENAIRE] ([ID], [NOM], [RAISONSOCIALE], [ADRESSE], [VILLE], [PAYS], [TELEPHONE], [SITEWEB], [COURRIEL]) VALUES (4, N'Tuptinaquistor Direct Group', N'Beverages', N'73 South First Blvd.', N'Miami', N'North Korea', N'345-345-1593', N'http://ocip.local32/cgbwa/yocgh/asgxy.php', N'putgjgg7@example.com')
INSERT [dbo].[PARTENAIRE] ([ID], [NOM], [RAISONSOCIALE], [ADRESSE], [VILLE], [PAYS], [TELEPHONE], [SITEWEB], [COURRIEL]) VALUES (5, N'Adjubexistor  Corp.', N'Cereals', N'99 Hague Street', N'Columbus', N'Montserrat', N'872-370-2074', N'http://wvxul.web77/pfjkr/esuft.htm', N'pqzj.bcjhdvkco@example.com')
INSERT [dbo].[PARTENAIRE] ([ID], [NOM], [RAISONSOCIALE], [ADRESSE], [VILLE], [PAYS], [TELEPHONE], [SITEWEB], [COURRIEL]) VALUES (6, N'Tupdimommor International Inc', N'Grain', N'65 Clarendon Drive', N'Arlington', N'Syria', N'(615) 395-7272', N'http://guhxt.localu63/psiue/dwscr/owuwf/bqmfj/gazv.php', N'jctvwnau0@example.com')
INSERT [dbo].[PARTENAIRE] ([ID], [NOM], [RAISONSOCIALE], [ADRESSE], [VILLE], [PAYS], [TELEPHONE], [SITEWEB], [COURRIEL]) VALUES (7, N'Supcadegower International Inc', N'Confections', N'850 East White Oak Blvd.', N'St. Petersburg', N'Bermuda', N'(559) 132-9588', N'http://oaff.netk09/orqpe/jyzbh/zkixn/vhhin/bjlh.htm', N'ziytmsdp.mygkdc@example.com')
INSERT [dbo].[PARTENAIRE] ([ID], [NOM], [RAISONSOCIALE], [ADRESSE], [VILLE], [PAYS], [TELEPHONE], [SITEWEB], [COURRIEL]) VALUES (8, N'Grokilinicator Holdings Company', N'Shell fish', N'93 Rocky First Avenue', N'Philadelphia', N'Malta', N'254-210-0600', N'http://pdnbq.local8/rkmsr/admnw/vdgdz/vkblu/dbyu.php', N'zieufw@example.com')
INSERT [dbo].[PARTENAIRE] ([ID], [NOM], [RAISONSOCIALE], [ADRESSE], [VILLE], [PAYS], [TELEPHONE], [SITEWEB], [COURRIEL]) VALUES (9, N'Qwiglibewantor International Company', N'Dairy', N'20 Green Hague Street', N'Honolulu', N'Mayotte', N'007-470-1439', N'http://xisvq.localy1/zrsar/knuca/kfpao/hfmj.php', N'ycpe19@example.com')
INSERT [dbo].[PARTENAIRE] ([ID], [NOM], [RAISONSOCIALE], [ADRESSE], [VILLE], [PAYS], [TELEPHONE], [SITEWEB], [COURRIEL]) VALUES (10, N'Truhupewex International Company', N'Seafood', N'128 West White New Drive', N'Atlanta', N'Qatar', N'(104) 083-8891', N'http://kzni.webd/mctcj/kcjvh.html', N'bikisyzc.vpmkyj@example.com')
SET IDENTITY_INSERT [dbo].[PARTENAIRE] OFF
SET IDENTITY_INSERT [dbo].[PIECEJOINTE] ON 

INSERT [dbo].[PIECEJOINTE] ([ID], [IDMESSAGE], [PIECESERIALISEE], [TAILLEPIECE], [NOMPIECE]) VALUES (1, 8, 0x874E19D7265B8CE54BB1CD9C81A438AC47C382F96C94089C665DB63426841D473918AC5EAB5591DC2B69E1DA54DE76CFAB392DBBF8568BF2467C71C8A558BFC694866268F8DA01F132A6CD02B22E4887E7E689ED57614EE38CB9182EE4C836D3A91A45CE7B0DD7D0383C885188893F1734E9E1BFCFD26F32377FDB3EC1D20C696FFA5998E8790BD90EB8B51BD8FC5A037900FAFBE77704, N'8504847', N'voamwmudz.doc')
INSERT [dbo].[PIECEJOINTE] ([ID], [IDMESSAGE], [PIECESERIALISEE], [TAILLEPIECE], [NOMPIECE]) VALUES (2, 9, 0xAB1396FC32980F652F1FE28E2FA72FBADD08B1171C54593A24D7C5C1D81182F8F681ECD5E30FA675A84FEBB91ACCD4D1D13F1DDFC5EDBA56B95CD75AD34E8D1D9CE998ADBB5AD7CE613B6ECD689F1F5803F3F098F4A33209C7951B86374BA15AC2CE1D3133261676684F7D8A7EEDEE1A3C7E57DF5EF529F9B68FE6253E5096159A130B9A82ED25DDDD792FA425A88ADAA7014AB8F4C1FCCCA4247BA43FF13718B868EF6BE153974E597902E4C584D30D050C7D3D06DD20D8163EF65D72809EEB4117ECBDB81EF85469FB5F7ABF18071F506D9F3274FA12DB471755A35D39DBD8DB17A3AE981655E61429D30A7EA619FD37D60D05E16B7746051175A1C855F62F1F869EA87459873917B81E4A26075DA1FE576B862CD6F6709F5CA887A0B41EBF32A3EAF7077188DE4FD3ED294D2C20FDB3D4A270E96F0349902E0818B0FF99639A5E18821C65998DCE8D3758E8CD22723CAAD3CC11ADD5C2A0A167D968702E4F3A898EEE149DE14E3B15A25C38AA60C20B96DC052CCC52ED8855E27AFEC0245E5EE71E5E3E335D9EC98591FB0A798AF641A4CDD29328236D37A166BFBB664F7AF143FD508B0183D8383D3BA63B56E20FCBEB395AF251CA35C3B0279DCD9EE36336160AC77B396A3F21F59956ED7D32E1BF57F4CF2CF5889F79C78DDADAE60A9A59D870254C1B939181FA38FDB87448467E45DE76A9143740, N'9225181', N'nexeelai.xls')
INSERT [dbo].[PIECEJOINTE] ([ID], [IDMESSAGE], [PIECESERIALISEE], [TAILLEPIECE], [NOMPIECE]) VALUES (3, 8, 0x6A4DB3AB8F643BEAFFFC150C0C95A3C3624D32BC8AE7047F465B940894F144A02F97E1CDDFE5F195FD13B877333972B03AB246C60584048348346533D033550EB774DC75B3D6E37D5C9CBE762E8D4B0CE9E3CDE1AA7E9BAB935D84AB80BDC5CABDAABFBE5CFCFD64CFC96A68C58D54BBE8584AEC65746339D831E2555138FC9ED7F3B883CD8DB0EDE66912E11332E60508C9C22873D865494785E62B1AA71296CCCB91D1D5D1ED5BA85C05FC6182, N'4033678', N'sveqe.xls')
INSERT [dbo].[PIECEJOINTE] ([ID], [IDMESSAGE], [PIECESERIALISEE], [TAILLEPIECE], [NOMPIECE]) VALUES (4, 6, 0xA54BDD4D8876D42BFE8E6E3C47A684D33F567B1447A1143037DB668016D268E7C45F40E03D5A8A1FF8A092426694A5B42389C6A6E56EDE0436AC15AC1053142B258677E866A395E5CB5C1BA70ED1C9A336B15C8C0CC20256813BA99044DE0FA58B671DE01DBD4D7FF3E0DB895336F565E372755EF7881F638420662AFA05A0EC4C751CA7B4E9857963DC982BE778034A4644ACD268B1AE0348B95BFC562385EE40EE3DDD1A4DB0FAECFCFA1AEFF37B0C1D1CE4B559CD, N'6139038', N'aix.bmp')
INSERT [dbo].[PIECEJOINTE] ([ID], [IDMESSAGE], [PIECESERIALISEE], [TAILLEPIECE], [NOMPIECE]) VALUES (5, 3, 0x9BC7185FFA8D88224057AAEBF83B262FF994B2E66CB69313543E4FDF3A3ECF94726BA21501EDB56C63DAB9C2450882D0F6ECEA21A6E717E433050BBC3EA9E8018715788D99102D0BDE458292FCD0CE4CBB7EE84D53AEED8A54BDE1FCE2F92EBAF1B83B2F8FF437E5BEDF43616585E76336BE00BFC09AADD927EE39DB2F3128E417C7A044959FBDC747028F746B8C25CED67EC524F96FFA560A6207A1BB5CB68DB75E4A9DE4A2CD97013878BD0B396E9BC86A04B06B04EBA7CD493A33971B0CEA4C02BD0D4287EA33B02D22C0F73C4BD0F46CD850570621B272A2CF9B689A00E52C8D71097C61594180D1FF3DE12BB091FD693F2B43BB9345E00A9A9FB74ECB162D3D9369CB4254931296CF8606E3D147F23E9DFE5BD5A271FA2B2872C6B98A3205E910A49746C6BB15AC18ACEB0C3FFD3852AD79B1CCBB589A226F9F1AE2CC590C9D811DD22DB0AB78E2E9AFBCF585EDEC2A39740C1081382DB80975D626A133DFBF9F4E8B212A0AA20101CFE30C9BA59C81B3EFA8584CFB1C48EF1A243AD55140B6CFFD553662CA, N'5532615', N'ojgqeo.php')
INSERT [dbo].[PIECEJOINTE] ([ID], [IDMESSAGE], [PIECESERIALISEE], [TAILLEPIECE], [NOMPIECE]) VALUES (6, 6, 0x2ED10B0FB255211C63D85573B18A8772A43243320FE6672CAF8E2D3C9D4F661EE9EF798640EB6AF2CEFEC0627FDD8E2B478AB1041F97F0486ADF602328E47E1472368AC2100131B8C85064112505ACD2FF01F4139D61FF51FE311B618B46CAE97FABEF4953CB1B4658F93CCE33DF2265338D2327EF6B77113638C4DEE5D02C81867B927915627E34E6AEBAA324301D1F0FB62EFE22A2F91434DE121A073C6088CDBA48B84CA84FD00EEF4141B0D3EC061AA4CF2FA12E5FE3817D45364F642CA94E32D66AE865D266665EEF3261B86360F20CFF626C31E69E5B6436CF631980AAC397F27EFD811DB5D269C8433E2C81C91AE4434364C93D1C4B370E832E03024DDD456FCAC5E46370EF4A900368, N'1361', N'irdmhgeoi.xls')
INSERT [dbo].[PIECEJOINTE] ([ID], [IDMESSAGE], [PIECESERIALISEE], [TAILLEPIECE], [NOMPIECE]) VALUES (7, 10, 0x5F2EE26DB47ED53D45F95AD633C5739986CE667B65F9BDB7043681D3531A393AB3A8D7DFA1C14F8477A0FF7570EFB09EFD55C3C19CED3D66702B697DFD02E92ABF20228BED93F8C57FE203C5F948471585E3D5FE56789DC66A716E7658D18674B7D5B650CC25B0695DFE41BAE9786C28E454F81A2CEBD347825B207C24826CAE5B8E0D2492F64860326BA05836E2DCF204469104D96B47CB016ECD70043345DB91935E5A6A4896ED0B98E7C04A7B10A07F, N'22153', N'upo.bmp')
INSERT [dbo].[PIECEJOINTE] ([ID], [IDMESSAGE], [PIECESERIALISEE], [TAILLEPIECE], [NOMPIECE]) VALUES (8, 5, 0x77DEF068D5F04741232329D75BFF26C5C7A3838187BCAFA4F840838781855E2DF1D6BB66EA28BE6E13282473C4343CE89A84B46D1CFDA6BB2F4C70946CC0C09DC4FBE58543C0DA9EE4156E5F983BDFC3039AECFCD1F011F42F00379EB82901536786AEC84FB7A5DAAA1588068E4723F36CAC90D1D3C4CCD4EAF05643883CE6BB131AF7118C16744CF51252BB680A65E7DC43310B992F80A3BADADE5E6162516D2FCDF274501266553844DCC071116BE08B6E66440ADA21E39A5357B23816EA93C1E48B9B17F196CADDDCD35553C032A96FFED2F2FB0C6354AB0FDAFDBAB41D225949FE8C85D0C89AD89B672E07CC90D920AE433A43F897B58137EF0816981028BFB0FC0AC1A5239E35381960A5354CDE7F00DC0C71E2DE60B1490B4DE0C083408B3E6E57D085187B8AA4050ADE360F4CEA118916BB03B7DCD19B58779AD6BE74B5D9D566C6F50EF9E86181CCDDD4827B39BF63CF376C8487869285352CA0E1B4E690540461A985F4038F2E5A81EBFEFD18DD3DDA72EF3D48554EDF3370D8CD477FCDE64D7F7D1990396ECCA83E29059B93871C4E620641F6530CAE13C952842AC2E6DBB404B17D9AC3ADA1042295092C48449FE8BB7EE4788CEFFA73CF06C6E7EAA1E5584D5097E20A828BB5643DD4BE0281CA85B29B6E4401622814B70ACBBDE7BA1980AFB1DEF7ACBDDE39F32F134E1B3C714D3C40344E33A156EB28822B00B6CDCEAA23530F50A3D2D9F4BD3450D14ED9F87B987D81A685CB4D0D5BF3CF2992DD832561692BC82D21AA69673F90FF50849C4E89B067384C2724580501F4AF03AF62DFB12B70E4, N'975517', N'wwseu.doc')
INSERT [dbo].[PIECEJOINTE] ([ID], [IDMESSAGE], [PIECESERIALISEE], [TAILLEPIECE], [NOMPIECE]) VALUES (9, 10, 0x304E77D3173E453A4EBCD75680A0E2764AD83944D3C22B2CFA66B8DDB14D2514B7A05961F06535E9DE1DB7451D59830E80696752369FDB6E224BD9B18568890097C29EDF468085E4A35066B50AE50EA0E3A95C47E6D2DD17C5EB3FA48C83637694B6AE5ABBA3C700E382AFE53926633D3C38CEDC0B411AC4E5861A5B41E05820EDEF205437B3E53FE15C636322F8DE9F88016753B5876A529CE97534886CBF03298FF849050E0589528EFAAFDEB6A2ECA87BD33F78056B6685CEB74E3DB1B7759D603A9300949979FCDE01268CBB74E547898C0C98808A242491C43757B74CA1D785127D7C0EEC14E25A429A0344D9C959D207B425AADD1CD6156F6ECF62214492604F07A9F668389C782A3D3DEF20DFB8FBDD84B0977C2CA7F5A7679F7E447F38FD08A3F5D2206369CE18AC809FDFE6F58FB5D4859D94FAE4235FB34E01991D33AB043FE77CE9E6DA791AE17FCFAB0815C1710FC870F99B690DBFD2726C146834FA79D59AA0FE78A6CFF90B82B37B1477579E8C8F8A54C3B169D5DABC17736D64B2AC8455D66E74C2F869F876EE18B692AA5B1BCE88D8AAA5B52331CA24BB8E5C8CA6CF06F6BEA0E929CA96215B4DC3501F4711BC589EDCDA02DFA0B23CA99E3CDA9CE94748AF9BEBBA32A5BD4189496860E0, N'871', N'jeapn.pdf')
INSERT [dbo].[PIECEJOINTE] ([ID], [IDMESSAGE], [PIECESERIALISEE], [TAILLEPIECE], [NOMPIECE]) VALUES (10, 3, 0xDCAAD204EDC9F504171EEDAC7F2B5A46BF637B076FAB260125F91E99789537525CFEC1920898FB7D53AB84CDCC862592E7428A05E4D83B3083D0DEF4AA5C8B81E79B4F816AC73E2667FDB4C32759359FD48CB1360A316D83C2900E38BA07D2F62002E53036A3272004639EE72477092A9B3E1F1EAA5476B52ECCBED9B8066C5F2BBDA22473046930659132A793865E4B86E49D7BE7B44CCC8C2F026AE54D67FEF63EBB67D5E5B796D5EFB81822CF21A86D7352D468F1787670D6984302FE4B172A34B055CAF776A12C06A5F8FB33A9BC0D5AFC71FA939505C545F6FE4D7394D6A3A1EEEE1FCCDE75FDB1A7624C7F7A3C2CDB35A801DA1C969EAB8F84007754B872CE555A45BB9D417C867349EB32B946CBB9D2713DECD5C984574F733C5974, N'163', N'gmseia.php')
SET IDENTITY_INSERT [dbo].[PIECEJOINTE] OFF
SET IDENTITY_INSERT [dbo].[PUBLICATION] ON 

INSERT [dbo].[PUBLICATION] ([ID], [TITRE], [DATECREATION], [DESCRIPTION], [IDPUBLICATEUR], [IDSUJET], [IDSECTEUR], [MIMETYPE], [NOMFICHIERORIGINAL], [NOMFICHIERSERVEUR]) VALUES (1, N'Monmunexex', CAST(0x00009D6E00BC1A0B AS DateTime), N'Donec ullamcorper nulla non metus auctor fringilla.', 1, 8, 1, NULL, NULL, NULL)
INSERT [dbo].[PUBLICATION] ([ID], [TITRE], [DATECREATION], [DESCRIPTION], [IDPUBLICATEUR], [IDSUJET], [IDSECTEUR], [MIMETYPE], [NOMFICHIERORIGINAL], [NOMFICHIERSERVEUR]) VALUES (2, N'Truwerpex', CAST(0x00009FEB01779FFC AS DateTime), N'Donec ullamcorper nulla non metus auctor fringilla.', 1, 9, 1, NULL, NULL, NULL)
INSERT [dbo].[PUBLICATION] ([ID], [TITRE], [DATECREATION], [DESCRIPTION], [IDPUBLICATEUR], [IDSUJET], [IDSECTEUR], [MIMETYPE], [NOMFICHIERORIGINAL], [NOMFICHIERSERVEUR]) VALUES (3, N'Gronipepan', CAST(0x0000A0D90063DED5 AS DateTime), N'Donec ullamcorper nulla non metus auctor fringilla.', 1, 8, 1, NULL, NULL, NULL)
INSERT [dbo].[PUBLICATION] ([ID], [TITRE], [DATECREATION], [DESCRIPTION], [IDPUBLICATEUR], [IDSUJET], [IDSECTEUR], [MIMETYPE], [NOMFICHIERORIGINAL], [NOMFICHIERSERVEUR]) VALUES (4, N'Lomtumedantor', CAST(0x00009DA5018A79AF AS DateTime), N'Donec ullamcorper nulla non metus auctor fringilla.', 1, 6, 2, NULL, NULL, NULL)
INSERT [dbo].[PUBLICATION] ([ID], [TITRE], [DATECREATION], [DESCRIPTION], [IDPUBLICATEUR], [IDSUJET], [IDSECTEUR], [MIMETYPE], [NOMFICHIERORIGINAL], [NOMFICHIERSERVEUR]) VALUES (5, N'Rapbanackistor', CAST(0x0000A0C4018B4021 AS DateTime), N'Donec ullamcorper nulla non metus auctor fringilla.', 1, 3, 2, NULL, NULL, NULL)
INSERT [dbo].[PUBLICATION] ([ID], [TITRE], [DATECREATION], [DESCRIPTION], [IDPUBLICATEUR], [IDSUJET], [IDSECTEUR], [MIMETYPE], [NOMFICHIERORIGINAL], [NOMFICHIERSERVEUR]) VALUES (6, N'Barhupower', CAST(0x0000A12F004CD787 AS DateTime), N'Donec ullamcorper nulla non metus auctor fringilla.', 1, 6, 2, NULL, NULL, NULL)
INSERT [dbo].[PUBLICATION] ([ID], [TITRE], [DATECREATION], [DESCRIPTION], [IDPUBLICATEUR], [IDSUJET], [IDSECTEUR], [MIMETYPE], [NOMFICHIERORIGINAL], [NOMFICHIERSERVEUR]) VALUES (7, N'Zeeglibewantor', CAST(0x00009E94018249F0 AS DateTime), N'Donec ullamcorper nulla non metus auctor fringilla.', 1, 10, 3, NULL, NULL, NULL)
INSERT [dbo].[PUBLICATION] ([ID], [TITRE], [DATECREATION], [DESCRIPTION], [IDPUBLICATEUR], [IDSUJET], [IDSECTEUR], [MIMETYPE], [NOMFICHIERORIGINAL], [NOMFICHIERSERVEUR]) VALUES (8, N'Trucadazz', CAST(0x00009F0C0122E191 AS DateTime), N'Donec ullamcorper nulla non metus auctor fringilla.', 1, 5, 3, NULL, NULL, NULL)
INSERT [dbo].[PUBLICATION] ([ID], [TITRE], [DATECREATION], [DESCRIPTION], [IDPUBLICATEUR], [IDSUJET], [IDSECTEUR], [MIMETYPE], [NOMFICHIERORIGINAL], [NOMFICHIERSERVEUR]) VALUES (9, N'Grobanedover', CAST(0x00009F6300102B7F AS DateTime), N'Donec ullamcorper nulla non metus auctor fringilla.', 1, 10, 3, NULL, NULL, NULL)
INSERT [dbo].[PUBLICATION] ([ID], [TITRE], [DATECREATION], [DESCRIPTION], [IDPUBLICATEUR], [IDSUJET], [IDSECTEUR], [MIMETYPE], [NOMFICHIERORIGINAL], [NOMFICHIERSERVEUR]) VALUES (10, N'Hapfropefantor', CAST(0x0000A080006570A8 AS DateTime), N'Donec ullamcorper nulla non metus auctor fringilla.', 1, 3, 3, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[PUBLICATION] OFF
SET IDENTITY_INSERT [dbo].[SECTEUR] ON 

INSERT [dbo].[SECTEUR] ([ID], [NOM], [TITREACCUEIL], [TEXTEACCUEIL], [URLIMAGEACCUEIL]) VALUES (1, N'Agriculture', N'Accueil', N'Maecenas sed diam eget risus varius blandit sit amet non magna.', N'~/Content/images/photos/moz-agriculture.jpg')
INSERT [dbo].[SECTEUR] ([ID], [NOM], [TITREACCUEIL], [TEXTEACCUEIL], [URLIMAGEACCUEIL]) VALUES (2, N'Construction civile', N'Accueil', N'Maecenas sed diam eget risus varius blandit sit amet non magna. Donec ullamcorper nulla non metus auctor fringilla.', N'~/Content/images/photos/moz-agriculture.jpg')
INSERT [dbo].[SECTEUR] ([ID], [NOM], [TITREACCUEIL], [TEXTEACCUEIL], [URLIMAGEACCUEIL]) VALUES (3, N'Tourisme', N'Accueil', N'Cras mattis consectetur purus sit amet fermentum. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.', N'~/Content/images/photos/moz-agriculture.jpg')
INSERT [dbo].[SECTEUR] ([ID], [NOM], [TITREACCUEIL], [TEXTEACCUEIL], [URLIMAGEACCUEIL]) VALUES (11, N'Comptabilité', N'Accueil', N'Cras mattis consectetur purus sit amet fermentum. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.', N'~/Content/images/photos/moz-agriculture.jpg')
SET IDENTITY_INSERT [dbo].[SECTEUR] OFF
SET IDENTITY_INSERT [dbo].[SONDAGE] ON 

INSERT [dbo].[SONDAGE] ([ID], [NOM], [QUESTION], [DATEDEBUT], [DATEFIN], [IDCREATEUR], [IDSECTEUR]) VALUES (1, N'Groglibupin', N'si habitatio si quo, fecit,', CAST(0x00009F0B00349A88 AS DateTime), CAST(0x0000A13D0163A832 AS DateTime), 7, 1)
INSERT [dbo].[SONDAGE] ([ID], [NOM], [QUESTION], [DATEDEBUT], [DATEFIN], [IDCREATEUR], [IDSECTEUR]) VALUES (2, N'Monerar', N'delerium. pladior novum quad trepicandor parte', CAST(0x0000A08100235347 AS DateTime), CAST(0x0000A16601503F84 AS DateTime), 6, 1)
INSERT [dbo].[SONDAGE] ([ID], [NOM], [QUESTION], [DATEDEBUT], [DATEFIN], [IDCREATEUR], [IDSECTEUR]) VALUES (3, N'Updudadax', N'e quoque et fecundio, linguens', CAST(0x00009FCB00A3BE70 AS DateTime), CAST(0x0000A1BE00963783 AS DateTime), 7, 1)
INSERT [dbo].[SONDAGE] ([ID], [NOM], [QUESTION], [DATEDEBUT], [DATEFIN], [IDCREATEUR], [IDSECTEUR]) VALUES (4, N'Rapvenplentor', N'regit, cognitio, et estum.', CAST(0x00009FAF008A64A4 AS DateTime), CAST(0x0000A27001403DD5 AS DateTime), 4, 1)
INSERT [dbo].[SONDAGE] ([ID], [NOM], [QUESTION], [DATEDEBUT], [DATEFIN], [IDCREATEUR], [IDSECTEUR]) VALUES (5, N'Rapglibefex', N'et bono delerium. brevens, Id', CAST(0x00009FA4014A07C5 AS DateTime), CAST(0x0000A157004C7A3F AS DateTime), 1, 2)
INSERT [dbo].[SONDAGE] ([ID], [NOM], [QUESTION], [DATEDEBUT], [DATEFIN], [IDCREATEUR], [IDSECTEUR]) VALUES (6, N'Raptinover', N'parte Versus quad manifestum esset travissimantor', CAST(0x00009E710000F3B7 AS DateTime), CAST(0x0000A18A0152D62A AS DateTime), 4, 2)
INSERT [dbo].[SONDAGE] ([ID], [NOM], [QUESTION], [DATEDEBUT], [DATEFIN], [IDCREATEUR], [IDSECTEUR]) VALUES (7, N'Endbanollin', N'et quo habitatio gravis rarendum', CAST(0x00009D3F00877B72 AS DateTime), CAST(0x0000A1F600F99603 AS DateTime), 2, 2)
INSERT [dbo].[SONDAGE] ([ID], [NOM], [QUESTION], [DATEDEBUT], [DATEFIN], [IDCREATEUR], [IDSECTEUR]) VALUES (8, N'Tuphupanower', N'non transit. linguens transit.', CAST(0x0000A0C4005AD290 AS DateTime), CAST(0x0000A1C90059BA34 AS DateTime), 10, 3)
INSERT [dbo].[SONDAGE] ([ID], [NOM], [QUESTION], [DATEDEBUT], [DATEFIN], [IDCREATEUR], [IDSECTEUR]) VALUES (9, N'Hapzapover', N'bono gravis cognitio, quo', CAST(0x00009ED100F7550A AS DateTime), CAST(0x0000A206005690B8 AS DateTime), 2, 3)
INSERT [dbo].[SONDAGE] ([ID], [NOM], [QUESTION], [DATEDEBUT], [DATEFIN], [IDCREATEUR], [IDSECTEUR]) VALUES (10, N'Retanopar', N'in manifestum linguens quad e', CAST(0x00009F870122CAB7 AS DateTime), CAST(0x0000A29C00785DDB AS DateTime), 1, 3)
SET IDENTITY_INSERT [dbo].[SONDAGE] OFF
SET IDENTITY_INSERT [dbo].[SUJETPUBLICATION] ON 

INSERT [dbo].[SUJETPUBLICATION] ([ID], [NOM]) VALUES (1, N'Poultry')
INSERT [dbo].[SUJETPUBLICATION] ([ID], [NOM]) VALUES (2, N'Shell fish')
INSERT [dbo].[SUJETPUBLICATION] ([ID], [NOM]) VALUES (3, N'Confections')
INSERT [dbo].[SUJETPUBLICATION] ([ID], [NOM]) VALUES (4, N'Produce')
INSERT [dbo].[SUJETPUBLICATION] ([ID], [NOM]) VALUES (5, N'Cereals')
INSERT [dbo].[SUJETPUBLICATION] ([ID], [NOM]) VALUES (6, N'Seafood')
INSERT [dbo].[SUJETPUBLICATION] ([ID], [NOM]) VALUES (7, N'Beverages')
INSERT [dbo].[SUJETPUBLICATION] ([ID], [NOM]) VALUES (8, N'Meat')
INSERT [dbo].[SUJETPUBLICATION] ([ID], [NOM]) VALUES (9, N'Grain')
INSERT [dbo].[SUJETPUBLICATION] ([ID], [NOM]) VALUES (10, N'Snails')
SET IDENTITY_INSERT [dbo].[SUJETPUBLICATION] OFF
SET IDENTITY_INSERT [dbo].[UTILISATEUR] ON 

INSERT [dbo].[UTILISATEUR] ([ID], [NOMUTIL], [COURRIEL], [PRENOM], [NOM], [ADRESSE], [VILLE], [DATENAISSANCE], [DERNIERECONNEXION], [LANGUE], [IDECOLE]) VALUES (1, N'Gregg316', N'iorktnq.egysvg@example.com', N'Gregg', N'Casey', N'230 rue des Pokemons', N'Maputo', CAST(0x81EC0A00 AS Date), CAST(0x00009FE600000000 AS DateTime), N'fr', 8)
INSERT [dbo].[UTILISATEUR] ([ID], [NOMUTIL], [COURRIEL], [PRENOM], [NOM], [ADRESSE], [VILLE], [DATENAISSANCE], [DERNIERECONNEXION], [LANGUE], [IDECOLE]) VALUES (2, N'Elton987', N'ywqpnuzs.mqkvcxmgre@example.com', N'Elton', N'Lyons', N'29 Second Freeway', N'Columbus', CAST(0x49F60A00 AS Date), CAST(0x0000A0F300000000 AS DateTime), N'PT', 9)
INSERT [dbo].[UTILISATEUR] ([ID], [NOMUTIL], [COURRIEL], [PRENOM], [NOM], [ADRESSE], [VILLE], [DATENAISSANCE], [DERNIERECONNEXION], [LANGUE], [IDECOLE]) VALUES (3, N'Jacob028', N'aqdvehdd.ppznsixeae@example.com', N'Jacob', N'Sweeney', N'11 East Nobel Drive', N'Fort Wayne', CAST(0x550E0B00 AS Date), CAST(0x00009FEA00000000 AS DateTime), N'PT', 8)
INSERT [dbo].[UTILISATEUR] ([ID], [NOMUTIL], [COURRIEL], [PRENOM], [NOM], [ADRESSE], [VILLE], [DATENAISSANCE], [DERNIERECONNEXION], [LANGUE], [IDECOLE]) VALUES (4, N'Beth957', N'okexfeze.uosrwkq@example.com', N'Beth', N'Cunningham', N'56 South Old Road', N'Norfolk', CAST(0x0F160B00 AS Date), CAST(0x0000A02C00000000 AS DateTime), N'FR', 6)
INSERT [dbo].[UTILISATEUR] ([ID], [NOMUTIL], [COURRIEL], [PRENOM], [NOM], [ADRESSE], [VILLE], [DATENAISSANCE], [DERNIERECONNEXION], [LANGUE], [IDECOLE]) VALUES (5, N'Sherman470', N'briqbsuo.lxacpu@example.com', N'Sherman', N'Ryan', N'43 White Fabien Way', N'Dallas', CAST(0x41060B00 AS Date), CAST(0x0000A06A00000000 AS DateTime), N'PT', 3)
INSERT [dbo].[UTILISATEUR] ([ID], [NOMUTIL], [COURRIEL], [PRENOM], [NOM], [ADRESSE], [VILLE], [DATENAISSANCE], [DERNIERECONNEXION], [LANGUE], [IDECOLE]) VALUES (6, N'Gilbert535', N'rkwmdny.ffpitd@example.com', N'Gilbert', N'Dodson', N'596 North White Cowley Way', N'Louisville', CAST(0xB7020B00 AS Date), CAST(0x0000A01800000000 AS DateTime), N'FR', 6)
INSERT [dbo].[UTILISATEUR] ([ID], [NOMUTIL], [COURRIEL], [PRENOM], [NOM], [ADRESSE], [VILLE], [DATENAISSANCE], [DERNIERECONNEXION], [LANGUE], [IDECOLE]) VALUES (7, N'Gretchen73', N'rdvhdteg.ubowtalh@example.com', N'Gretchen', N'Boone', N'46 Hague Avenue', N'Omaha', CAST(0xD21A0B00 AS Date), CAST(0x0000A0FA00000000 AS DateTime), N'FR', 9)
INSERT [dbo].[UTILISATEUR] ([ID], [NOMUTIL], [COURRIEL], [PRENOM], [NOM], [ADRESSE], [VILLE], [DATENAISSANCE], [DERNIERECONNEXION], [LANGUE], [IDECOLE]) VALUES (8, N'Claudia976', N'kaxqhext.hobyqjzza@example.com', N'Claudia', N'Padilla', N'87 South White Fabien Freeway', N'Charlotte', CAST(0xB1160B00 AS Date), CAST(0x0000A10400000000 AS DateTime), N'FR', 5)
INSERT [dbo].[UTILISATEUR] ([ID], [NOMUTIL], [COURRIEL], [PRENOM], [NOM], [ADRESSE], [VILLE], [DATENAISSANCE], [DERNIERECONNEXION], [LANGUE], [IDECOLE]) VALUES (9, N'Joanna613', N'ppocyacv.etnnzww@example.com', N'Joanna', N'Murphy', N'531 Cowley Way', N'Portland', CAST(0xFC000B00 AS Date), CAST(0x0000A0C300000000 AS DateTime), N'FR', 9)
INSERT [dbo].[UTILISATEUR] ([ID], [NOMUTIL], [COURRIEL], [PRENOM], [NOM], [ADRESSE], [VILLE], [DATENAISSANCE], [DERNIERECONNEXION], [LANGUE], [IDECOLE]) VALUES (10, N'Ginger685', N'krzbtid.igdszp@example.com', N'Ginger', N'Mckenzie', N'725 White New Road', N'Fort Worth', CAST(0x600C0B00 AS Date), CAST(0x0000A05900000000 AS DateTime), N'PT', 3)
SET IDENTITY_INSERT [dbo].[UTILISATEUR] OFF
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (1, 3, CAST(0xB9340B00 AS Date), CAST(0x19380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (2, 1, CAST(0x86320B00 AS Date), CAST(0xB8380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (3, 2, CAST(0x77320B00 AS Date), CAST(0x96380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (4, 3, CAST(0xE4330B00 AS Date), CAST(0xB6380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (5, 2, CAST(0xE9320B00 AS Date), CAST(0xDA380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (5, 3, CAST(0x22350B00 AS Date), CAST(0x85380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (6, 1, CAST(0xA9330B00 AS Date), CAST(0x25380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (6, 3, CAST(0x3E360B00 AS Date), CAST(0x4F380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (7, 1, CAST(0xFA350B00 AS Date), CAST(0x8C380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (7, 2, CAST(0x95320B00 AS Date), CAST(0x27390B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (8, 1, CAST(0x7D320B00 AS Date), CAST(0xCF380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (8, 2, CAST(0xD4320B00 AS Date), CAST(0x7C380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (9, 2, CAST(0x87350B00 AS Date), CAST(0xA2380B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (9, 3, CAST(0x67330B00 AS Date), CAST(0x5F390B00 AS Date))
INSERT [dbo].[UTILISATEURSECTEUR] ([IDUTILISATEUR], [IDSECTEUR], [DEBUTACCES], [FINACCES]) VALUES (10, 3, CAST(0xAF320B00 AS Date), CAST(0x61390B00 AS Date))
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (1, 1)
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (2, 2)
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (3, 1)
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (4, 2)
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (5, 2)
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (6, 1)
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (7, 2)
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (8, 1)
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (9, 2)
INSERT [dbo].[VOTESONDAGE] ([IDUTILISATEUR], [IDCHOIX]) VALUES (10, 1)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (1, CAST(0x0000A2620153AB59 AS DateTime), NULL, 1, CAST(0x0000A26301224BFC AS DateTime), 0, N'APl/ileYy6jUi7NQV51uZnxI5OJpbTkVHoBRlCn99VsiH2MM7Q4M+LWfAI139uktMw==', CAST(0x0000A2620153AB59 AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (2, CAST(0x0000A2620153AB5E AS DateTime), NULL, 1, NULL, 0, N'AKzASkATchnLbU5w1vhHmZ/0hTwD53o7anhKgW/Y0NPEi+onIkvLNGCtZ9jd9bOJpw==', CAST(0x0000A2620153AB5E AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (3, CAST(0x0000A2620153AB62 AS DateTime), NULL, 1, NULL, 0, N'AG3Mqvab2X19DJ5p+H1dnyTL6jnXyoI4g/+u51j3gUKqqUiU9JF4iG06l3COHsRVUQ==', CAST(0x0000A2620153AB62 AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (4, CAST(0x0000A2620153AB69 AS DateTime), NULL, 1, NULL, 0, N'ABVr/li0lZVsBfJphLx3mOSVYLMfPV0cYclbd9h14ByxjGqaYNOgNSq7mxVXfY2oFA==', CAST(0x0000A2620153AB69 AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (5, CAST(0x0000A2620153AB76 AS DateTime), NULL, 1, NULL, 0, N'AG9b20MBAZcmLCdEFilx7iRG1QBIEjUGVcubuR+oyWJlmyJfT00AQcpncNkY4WECnA==', CAST(0x0000A2620153AB76 AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (6, CAST(0x0000A2620153AB7B AS DateTime), NULL, 1, NULL, 0, N'ABWNTNDjQuzEOluf50v5nj5wV6rmk2RJt2ZYBKFWSpOeaEB9t8WN0H00IrZr+p0McA==', CAST(0x0000A2620153AB7B AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (7, CAST(0x0000A2620153AB82 AS DateTime), NULL, 1, NULL, 0, N'AHCowTg6Ma6Ni7uIg+4L+j4QZdoBVYDKK5t5gF+EtIxrZclh3u7atfovmHT0nCuuNw==', CAST(0x0000A2620153AB82 AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (8, CAST(0x0000A2620153AB88 AS DateTime), NULL, 1, NULL, 0, N'APWQY4lcZXUqjxW8C+fuDXDj5ELXNQAIzLxk1gfwj2X8dH6YQQN0x9lRnggZC77l6Q==', CAST(0x0000A2620153AB88 AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (9, CAST(0x0000A2620153AB8D AS DateTime), NULL, 1, NULL, 0, N'AO4IJ0SXBfDd0gHsHyLNsxFT26Zzj3pTxQHyaLqkMOBshdd3DskDHbh7771srwiguQ==', CAST(0x0000A2620153AB8D AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (10, CAST(0x0000A2620153AB94 AS DateTime), NULL, 1, NULL, 0, N'ALOMbCmhqZ7si9tj2eWf3iqmE309tHHWh0DnHZNLH8Iz0EHjSk/u8NpXa60dx4UF7A==', CAST(0x0000A2620153AB94 AS DateTime), N'', NULL, NULL)
SET IDENTITY_INSERT [dbo].[webpages_Roles] ON 

INSERT [dbo].[webpages_Roles] ([RoleId], [RoleName]) VALUES (1, N'admin')
INSERT [dbo].[webpages_Roles] ([RoleId], [RoleName]) VALUES (2, N'etudiant')
INSERT [dbo].[webpages_Roles] ([RoleId], [RoleName]) VALUES (3, N'professeur')
INSERT [dbo].[webpages_Roles] ([RoleId], [RoleName]) VALUES (4, N'professeurModerateur')
SET IDENTITY_INSERT [dbo].[webpages_Roles] OFF
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
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_CONTENU_PAGE]    Script Date: 2013-10-28 04:55:53 ******/
ALTER TABLE [dbo].[CONTENU] ADD  CONSTRAINT [UQ_CONTENU_PAGE] UNIQUE NONCLUSTERED 
(
	[PAGE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UTILISAT__190F3DCBCE897D42]    Script Date: 2013-10-28 04:55:53 ******/
ALTER TABLE [dbo].[UTILISATEUR] ADD  CONSTRAINT [UQ__UTILISAT__190F3DCBCE897D42] UNIQUE NONCLUSTERED 
(
	[COURRIEL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UTILISAT__3BA84E4815D1A094]    Script Date: 2013-10-28 04:55:53 ******/
ALTER TABLE [dbo].[UTILISATEUR] ADD  CONSTRAINT [UQ__UTILISAT__3BA84E4815D1A094] UNIQUE NONCLUSTERED 
(
	[NOMUTIL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_UTILISAT_NOMUTIL]    Script Date: 2013-10-28 04:55:53 ******/
ALTER TABLE [dbo].[UTILISATEUR] ADD  CONSTRAINT [UQ_UTILISAT_NOMUTIL] UNIQUE NONCLUSTERED 
(
	[NOMUTIL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B61606DB94AD3]    Script Date: 2013-10-28 04:55:53 ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DESTINATAIREMESSAGE] ADD  DEFAULT ((0)) FOR [SUPPRIME]
GO
ALTER TABLE [dbo].[DESTINATAIREMESSAGE] ADD  DEFAULT ((0)) FOR [SUPPRIMEDEFINITIF]
GO
ALTER TABLE [dbo].[DESTINATAIREMESSAGE] ADD  CONSTRAINT [DF_DESTINATAIREMESSAGE_LU]  DEFAULT ((0)) FOR [LU]
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
ALTER TABLE [dbo].[UTILISATEUR] ADD  CONSTRAINT [DF_UTILISATEUR_DERNIERECONNEXION]  DEFAULT (NULL) FOR [DERNIERECONNEXION]
GO
ALTER TABLE [dbo].[UTILISATEUR] ADD  CONSTRAINT [DF__UTILISATE__LANGU__1CF15040]  DEFAULT ('FR') FOR [LANGUE]
GO
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [IsConfirmed]
GO
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [PasswordFailuresSinceLastSuccess]
GO
ALTER TABLE [dbo].[CHOIXSONDAGE]  WITH CHECK ADD  CONSTRAINT [FK_CHOIXSOND_SOND] FOREIGN KEY([IDSONDAGE])
REFERENCES [dbo].[SONDAGE] ([ID])
GO
ALTER TABLE [dbo].[CHOIXSONDAGE] CHECK CONSTRAINT [FK_CHOIXSOND_SOND]
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
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_RoleId]
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[UTILISATEUR] ([ID])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_UserId]
GO
ALTER TABLE [dbo].[UTILISATEUR]  WITH CHECK ADD  CONSTRAINT [CHK_UTIL_LANGUE] CHECK  (([LANGUE]='PT' OR [LANGUE]='FR'))
GO
ALTER TABLE [dbo].[UTILISATEUR] CHECK CONSTRAINT [CHK_UTIL_LANGUE]
GO
USE [master]
GO
ALTER DATABASE [MVP] SET  READ_WRITE 
GO
