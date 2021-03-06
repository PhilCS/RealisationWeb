USE [MVP]
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- MOTCLEPUBLICATION

GO
ALTER TABLE MOTCLEPUBLICATION
DROP CONSTRAINT FK_MOTCLEPUB_MOTCLE
GO
ALTER TABLE MOTCLEPUBLICATION
ADD CONSTRAINT FK_MOTCLEPUB_MOTCLE FOREIGN KEY (IDMOTCLE) REFERENCES MOTCLE (ID) ON DELETE CASCADE

GO
ALTER TABLE MOTCLEPUBLICATION
DROP CONSTRAINT FK_MOTCLEPUB_PUB
GO
ALTER TABLE MOTCLEPUBLICATION
ADD CONSTRAINT FK_MOTCLEPUB_PUB FOREIGN KEY (IDPUBLICATION) REFERENCES PUBLICATION (ID) ON DELETE CASCADE

-- VOTESONDAGE

GO
ALTER TABLE VOTESONDAGE
DROP CONSTRAINT FK_VOTESOND_CHOIX
GO
ALTER TABLE VOTESONDAGE
ADD CONSTRAINT FK_VOTESOND_CHOIX FOREIGN KEY (IDCHOIX) REFERENCES CHOIXSONDAGE (ID) ON DELETE CASCADE

-- CHOIXSONDAGE

GO
ALTER TABLE CHOIXSONDAGE
DROP CONSTRAINT FK_CHOIXSOND_SOND
GO
ALTER TABLE CHOIXSONDAGE
ADD CONSTRAINT FK_CHOIXSOND_SOND FOREIGN KEY (IDSONDAGE) REFERENCES SONDAGE (ID) ON DELETE CASCADE

-- ECOLESECTEUR

GO
ALTER TABLE ECOLESECTEUR
DROP CONSTRAINT FK_ECOLESECT_SECT
GO
ALTER TABLE ECOLESECTEUR
ADD CONSTRAINT FK_ECOLESECT_SECT FOREIGN KEY (IDSECTEUR) REFERENCES SECTEUR (ID) ON DELETE CASCADE

GO
ALTER TABLE ECOLESECTEUR
DROP CONSTRAINT FK_ECOLESECT_ECOLE
GO
ALTER TABLE ECOLESECTEUR
ADD CONSTRAINT FK_ECOLESECT_ECOLE FOREIGN KEY (IDECOLE) REFERENCES ECOLE (ID) ON DELETE CASCADE

-- EVENEMENTSECTEUR

GO
ALTER TABLE EVENEMENTSECTEUR
DROP CONSTRAINT FK_EVENSECT_SECT
GO
ALTER TABLE EVENEMENTSECTEUR
ADD CONSTRAINT FK_EVENSECT_SECT FOREIGN KEY (IDSECTEUR) REFERENCES SECTEUR (ID) ON DELETE CASCADE

GO
ALTER TABLE EVENEMENTSECTEUR
DROP CONSTRAINT FK_EVENSECT_EVEN
GO
ALTER TABLE EVENEMENTSECTEUR
ADD CONSTRAINT FK_EVENSECT_EVEN FOREIGN KEY (IDEVENEMENT) REFERENCES EVENEMENT (ID) ON DELETE CASCADE

-- FILDISCUSSION

GO
ALTER TABLE FILDISCUSSION
DROP CONSTRAINT FK_FILDISC_FORUM
GO
ALTER TABLE FILDISCUSSION
ADD CONSTRAINT FK_FILDISC_FORUM FOREIGN KEY (IDFORUM) REFERENCES FORUM (ID) ON DELETE CASCADE

-- FORUM

GO
ALTER TABLE FORUM
DROP CONSTRAINT FK_FORUM_SECT
GO
ALTER TABLE FORUM
ADD CONSTRAINT FK_FORUM_SECT FOREIGN KEY (IDSECTEUR) REFERENCES SECTEUR (ID) ON DELETE CASCADE

-- MESSAGEFORUM

GO
ALTER TABLE MESSAGEFORUM
DROP CONSTRAINT FK_MESS_UTIL
GO
ALTER TABLE MESSAGEFORUM
ADD CONSTRAINT FK_MESS_UTIL FOREIGN KEY (IDUTILISATEUR) REFERENCES UTILISATEUR (ID) ON DELETE CASCADE

GO
ALTER TABLE MESSAGEFORUM
DROP CONSTRAINT FK_MESS_FILDISC
GO
ALTER TABLE MESSAGEFORUM
ADD CONSTRAINT FK_MESS_FILDISC FOREIGN KEY (IDFILDISCUSSION) REFERENCES FILDISCUSSION (ID) ON DELETE CASCADE

-- PUBLICATION

GO
ALTER TABLE PUBLICATION
DROP CONSTRAINT FK_PUB_UTIL
GO
ALTER TABLE PUBLICATION
ADD CONSTRAINT FK_PUB_UTIL FOREIGN KEY (IDPUBLICATEUR) REFERENCES UTILISATEUR (ID) ON DELETE CASCADE

GO
ALTER TABLE PUBLICATION
DROP CONSTRAINT FK_PUB_SUJET
GO
ALTER TABLE PUBLICATION
ADD CONSTRAINT FK_PUB_SUJET FOREIGN KEY (IDSUJET) REFERENCES SUJETPUBLICATION (ID) ON DELETE CASCADE

GO
ALTER TABLE PUBLICATION
DROP CONSTRAINT FK_PUB_SECT
GO
ALTER TABLE PUBLICATION
ADD CONSTRAINT FK_PUB_SECT FOREIGN KEY (IDSECTEUR) REFERENCES SECTEUR (ID) ON DELETE CASCADE

-- SONDAGE

GO
ALTER TABLE SONDAGE
DROP CONSTRAINT FK_SOND_SECT
GO
ALTER TABLE SONDAGE
ADD CONSTRAINT FK_SOND_SECT FOREIGN KEY (IDSECTEUR) REFERENCES SECTEUR (ID) ON DELETE CASCADE

GO
ALTER TABLE SONDAGE
DROP CONSTRAINT FK_SOND_CREATEUR
GO
ALTER TABLE SONDAGE
ADD CONSTRAINT FK_SOND_CREATEUR FOREIGN KEY (IDCREATEUR) REFERENCES UTILISATEUR (ID) ON DELETE CASCADE

-- UTILISATEURSECTEUR

GO
ALTER TABLE UTILISATEURSECTEUR
DROP CONSTRAINT FK_UTILSECT_UTIL
GO
ALTER TABLE UTILISATEURSECTEUR
ADD CONSTRAINT FK_UTILSECT_UTIL FOREIGN KEY (IDUTILISATEUR) REFERENCES UTILISATEUR (ID) ON DELETE CASCADE

GO
ALTER TABLE UTILISATEURSECTEUR
DROP CONSTRAINT FK_UTILSECT_SECT
GO
ALTER TABLE UTILISATEURSECTEUR
ADD CONSTRAINT FK_UTILSECT_SECT FOREIGN KEY (IDSECTEUR) REFERENCES SECTEUR (ID) ON DELETE CASCADE
