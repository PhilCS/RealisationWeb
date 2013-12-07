using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using projet_mozambique.Models;

namespace projet_mozambique.Models
{
    public partial class Entities
    {
        public virtual List<GetSecteurs_Result> GetSecteursLocalises(HttpSessionStateBase Session)
        {
            var listeSecteurs = this.GetSecteurs().ToList();
            var langue = Session["Culture"].ToString().ToUpper();

            if (langue == "PT")
            {
                foreach (var unSecteur in listeSecteurs)
                {
                    if (!String.IsNullOrWhiteSpace(unSecteur.NOMTRAD))
                    {
                        unSecteur.NOM = unSecteur.NOMTRAD;
                        unSecteur.TEXTEACCUEIL = unSecteur.TEXTEACCUEILTRAD;
                        unSecteur.TITREACCUEIL = unSecteur.TITREACCUEILTRAD;
                    }
                }
            }

            return listeSecteurs;
        }

        public virtual List<GetSujetsPublication_Result> GetSujetsPublicationLocalises(HttpSessionStateBase Session)
        {
            var listeSujetsPub = this.GetSujetsPublication().ToList();

            if (Session["Culture"].ToString().ToUpper() == "PT")
            {
                foreach (var unSujet in listeSujetsPub)
                {
                    if (!String.IsNullOrWhiteSpace(unSujet.NOMTRAD))
                    {
                        unSujet.NOM = unSujet.NOMTRAD;
                    }
                }
            }

            return listeSujetsPub;
        }

        public virtual List<SONDAGE> GetSondagesLocalises(int idSecteur, bool resultats, int idUtil, HttpSessionStateBase Session)
        {
            var listeSondages = this.GetSondages(idSecteur, resultats, idUtil).ToList();
            var langue = Session["Culture"].ToString().ToUpper();

            foreach (var unSondage in listeSondages)
            {
                unSondage.CHOIXSONDAGES = this.GetChoixSondage(unSondage.ID).ToList();

                if (langue == "PT")
                {
                    if (!String.IsNullOrWhiteSpace(unSondage.NOMTRAD))
                    {
                        unSondage.NOM = unSondage.NOMTRAD;
                        unSondage.QUESTION = unSondage.QUESTIONTRAD;

                        foreach (var unChoix in unSondage.CHOIXSONDAGES)
                        {
                            unChoix.VALEUR = unChoix.VALEURTRAD;
                        }
                    }
                }
            }

            return listeSondages;
        }

        public virtual List<NOUVELLE> GetNouvelleLocalisee(int? idNouvelle, HttpSessionStateBase Session)
        {
            var listeNouvelles = this.GetNouvelle(idNouvelle).ToList();
            var langue = Session["Culture"].ToString().ToUpper();

            foreach (var uneNouvelle in listeNouvelles)
            {
                if (langue == "PT")
                {
                    if (!String.IsNullOrWhiteSpace(uneNouvelle.TITRETRAD))
                    {
                        uneNouvelle.TITRE = uneNouvelle.TITRETRAD;
                        uneNouvelle.DESCRIPTION = uneNouvelle.DESCRIPTIONTRAD;
                    }
                }
            }

            return listeNouvelles;
        }

        public virtual List<NOUVELLE> GetNouvellesLocalisees(HttpSessionStateBase Session)
        {
            var listeNouvelles = this.GetNouvelles().ToList();
            var langue = Session["Culture"].ToString().ToUpper();

            foreach (var uneNouvelle in listeNouvelles)
            {
                if (langue == "PT")
                {
                    if (!String.IsNullOrWhiteSpace(uneNouvelle.TITRETRAD))
                    {
                        uneNouvelle.TITRE = uneNouvelle.TITRETRAD;
                        uneNouvelle.DESCRIPTION = uneNouvelle.DESCRIPTIONTRAD;
                    }
                }
            }

            return listeNouvelles;
        }
    }
}