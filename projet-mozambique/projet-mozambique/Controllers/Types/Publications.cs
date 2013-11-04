using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.IO;
using System.Net;
using System.Net.Mime;
using System.Web;
using System.Web.Mvc;
using WebMatrix.WebData;
using projet_mozambique.Models;
using projet_mozambique.Utilitaires;

namespace projet_mozambique.Controllers
{
    public partial class SectorielController
    {
        public ActionResult Publications(int? secteur, int? categorie, string motcle)
        {
            List<PUBLICATION> listePubs;

            if (secteur == null)
            {
                secteur = 1;
            }

            if (String.IsNullOrEmpty(motcle))
            {
                if (categorie == null)
                {
                    listePubs = db.GetPubParSecteur(secteur).ToList();
                }
                else
                {
                    listePubs = db.GetPubParSujet(secteur, categorie).ToList();
                }
            }
            else
            {
                listePubs = db.GetPubParMotCle(secteur, motcle).ToList();
            }

            List<GetSecteurs_Result> listeSecteurs = db.GetSecteurs().ToList();
            List<GetSujetsPublication_Result> listeSujetsPub = db.GetSujetsPublication().ToList();

            ViewData[Constantes.CLE_SECTEURS] = listeSecteurs;
            ViewData[Constantes.CLE_SUJETSPUBLICATION] = listeSujetsPub;
            ViewData[Constantes.CLE_PUBLICATIONS] = listePubs;

            return View();
        }

        public ActionResult ObtenirPublication(string nomFichier)
        {
            var cd = new ContentDisposition {FileName = nomFichier, Inline = false};
            Response.AppendHeader("Content-Disposition", cd.ToString());

            return File(System.IO.File.ReadAllBytes(Fichiers.CheminEnvois(nomFichier)), nomFichier);
        }
    }
    
    public partial class AdminController
    {
        [HttpGet]
        public ActionResult AjoutPublication()
        {
            List<GetSecteurs_Result> listeSecteurs = db.GetSecteurs().ToList();
            List<GetSujetsPublication_Result> listeSujetsPub = db.GetSujetsPublication().ToList();

            ViewData[Constantes.CLE_SECTEURS] = listeSecteurs;
            ViewData[Constantes.CLE_SUJETSPUBLICATION] = listeSujetsPub;

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AjoutPublication(PUBLICATION envoiPubli)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    HttpPostedFileBase fichier = envoiPubli.fichier;
                    
                    string mimetype = fichier.ContentType;
                    string nomOriginal = Fichiers.GetNomOriginal(fichier.FileName);
                    string nomServeur = Fichiers.GetNomServeur(fichier.FileName);

                    fichier.SaveAs(Fichiers.CheminEnvois(nomServeur));

                    ObjectParameter idPub = new ObjectParameter("idpub", typeof(int));
                    db.AjouterPublication(envoiPubli.TITRE, envoiPubli.DESCRIPTION, envoiPubli.IDSECTEUR, envoiPubli.IDSUJET, nomOriginal, nomServeur, mimetype, WebSecurity.CurrentUserId, idPub);

                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Publication.publicationAjoutee);

                    return RedirectToAction("Publications", "Sectoriel");
                }
                catch (Exception ex)
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Publication.publicationErreur + " (" + ex.GetType() + ")");
                }
            }

            List<GetSecteurs_Result> listeSecteurs = db.GetSecteurs().ToList();
            List<GetSujetsPublication_Result> listeSujetsPub = db.GetSujetsPublication().ToList();

            ViewData[Constantes.CLE_SECTEURS] = listeSecteurs;
            ViewData[Constantes.CLE_SUJETSPUBLICATION] = listeSujetsPub;

            return View(envoiPubli);
        }

        public ActionResult SupprimerPublication()
        {
            return View();
        }
    }
}
