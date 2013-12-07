using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace projet_mozambique.Utilitaires
{
    public class Constantes
    {
        private Constantes()
        { }

        // Courriel 
        public const string EMAIL = "projet.mozambique@outlook.com";
        public const string EMAIL_PWD = "pmAut2013";
        public const string HOST = "smtp.live.com";
        public const int PORT = 25;

        public const string BR = "<br/>";

        public const string RECH_NOUVELLES = "nouvelles";

        //CLÉS
        public const string CLE_NOUVELLE = "nouvelle";
        public const string CLE_NOUVELLES = "nouvelles";
        public const string CLE_MSG_RETOUR = "msg";
        public const string CLE_TYPE_RECHERCHE = "typeRecherche";
        public const string CLE_RECHERCHE = "recherche";
        public const string CLE_RESUL_RECH = "resulRech";
        public const string CLE_LISTE_MSG = "listeMsg";
        public const string CLE_TYPE_MSG = "typeMsg";
        public const string CLE_ERREUR = "msgErreur";
        public const string CLE_MESSAGE = "message";
        public const string CLE_PUBLICATION = "publication";
        public const string CLE_PUBLICATIONS = "publications";
        public const string CLE_SECTEURS = "secteurs";
        public const string CLE_IDSECTEUR = "idSecteur";
        public const string CLE_NOMSECTEUR = "nomSecteur";
        public const string CLE_IDCATEGORIE = "idCategorie";
        public const string CLE_IDECOLE = "idEcole";
        public const string CLE_SUJETSPUBLICATION = "sujetsPublication";
        public const string CLE_LISTE_UTILISATEURS = "listeUtilisateurs";
        public const string CLE_LISTE_UTILISATEURS_ALL = "AllUtilisateurs";
        public const string CLE_LISTE_ECOLES = "listeEcoles";
        public const string CLE_LISTE_ECOLES_ALL = "AllEcoles";
        public const string CLE_TITRE = "titre";
        public const string CLE_CORBEILLE = "corbeille";
        public const string CLE_ACTION = "action";
        public const string CLE_BOUTON = "bouton";
        public const string CLE_PARTENAIRES = "partenaires";
        public const string CLE_FORUM = "forum";
        public const string CLE_FILSFORUM = "filsForum";
        public const string CLE_FILDISCUSSION = "fil";
        public const string CLE_UTIL_AJOUTOK = "utilAjoute";
        public const string CLE_SONDAGES = "sondages";
        public const string CLE_SONDAGE = "sondage";
        public const string CLE_ANCRE = "ancre";
        public const string CLE_NOMBRE_CHOIX = "nombreChoix";

        public const string ROLE_PROF = "professeur";
        public const string ROLE_PROFMODERATEUR = "professeurModerateur";
        public const string ROLE_ADMIN = "admin";

    }
}