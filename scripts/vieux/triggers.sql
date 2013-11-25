/****** Object:  Trigger [dbo].[trg_AjoutMessageForum]    Script Date: 2013-09-20 12:22:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_AjoutMessageForum] ON [dbo].[MESSAGEFORUM] 
AFTER INSERT AS 
declare @idMessageAjoute int
declare @idFilDiscussion int

select @idMessageAjoute = i.id, @idFilDiscussion = i.idFilDiscussion from inserted i

update FilDiscussion set idDernierMessage = @idMessageAjoute, dateModification = getDate() 
where id = @idFilDiscussion

GO
/****** Object:  Trigger [dbo].[trg_AjoutSecteur]    Script Date: 2013-09-20 12:22:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_AjoutSecteur] ON [dbo].[SECTEUR] 
AFTER INSERT AS 

declare @idSecteur int
declare @nomSecteur varchar(45)

select @idSecteur = i.id, @nomSecteur = i.nom from inserted i

insert into Forum (titre, idSecteur) values (@nomSecteur, @idSecteur)

GO