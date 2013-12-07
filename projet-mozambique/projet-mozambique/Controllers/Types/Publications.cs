using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.IO;
using System.Linq;
using System.Net.Mime;
using System.Web;
using System.Web.Mvc;
using WebMatrix.WebData;
using projet_mozambique.Models;
using projet_mozambique.Utilitaires;

namespace projet_mozambique.Controllers
{
    using IOFile = System.IO.File;

    public partial class SectorielController
    {
        public ActionResult Publications(int? secteur, int? categorie, string motscles)
        {
            List<PUBLICATION> listePubs;
            List<GetSecteurs_Result> listeSecteurs = db.GetSecteursLocalises(Session);
            List<GetSujetsPublication_Result> listeSujetsPub = db.GetSujetsPublicationLocalises(Session).ToList();
            
            secteur = (int)Session["currentSecteur"];
            listeSecteurs = listeSecteurs.Where(s => s.ID == secteur).ToList();

            if (String.IsNullOrEmpty(motscles))
            {
                if (listeSujetsPub.Any(c => c.ID == categorie))
                {
                    listePubs = db.GetPubParSujet(secteur, categorie).ToList();
                }
                else
                {
                    listePubs = db.GetPubParSecteur(secteur).ToList();
                }
            }
            else
            {
                List<String> listeMotsCles = motscles.Split(new Char[] {' '}).ToList();
                string motsClesTraites = MotsCles.TraiterMotsCles(listeMotsCles);

                if (listeSujetsPub.Any(c => c.ID == categorie))
                {
                    listePubs = db.GetPubParMotCle(secteur, categorie, motsClesTraites).ToList();
                }
                else
                {
                    listePubs = db.GetPubParMotCle(secteur, null, motsClesTraites).ToList();
                }
            }

            ViewData[Constantes.CLE_IDSECTEUR] = secteur;
            ViewData[Constantes.CLE_IDCATEGORIE] = categorie ?? -1;
            ViewData[Constantes.CLE_SECTEURS] = listeSecteurs;
            ViewData[Constantes.CLE_SUJETSPUBLICATION] = listeSujetsPub;
            ViewData[Constantes.CLE_PUBLICATIONS] = listePubs;

            return View();
        }

        public ActionResult ObtenirPublication(int? id)
        {
            PUBLICATION pub = null;

            try
            {
                if (id == null)
                    throw new ArgumentNullException("id");

                pub = db.GetPublication(id).First();
            }
            catch
            {
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Publication.idPublicationInvalide);
            }

            if (pub != null)
            {
                var cd = new ContentDisposition { FileName = pub.NOMFICHIERORIGINAL, Inline = false };
                Response.AppendHeader("Content-Disposition", cd.ToString());

                try
                {
                    return File(IOFile.ReadAllBytes(Fichiers.CheminEnvois(pub.NOMFICHIERSERVEUR)), pub.NOMFICHIERORIGINAL);
                }
                catch (IOException)
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Publication.publicationErreurFichier);
                }
            }

            return RedirectToAction("Publications", "Sectoriel");
        }

        private const string droitsPublication = "admin,professeur,professeurModerateur";

        [HttpGet]
        [AccessDeniedAuthorize(Roles = droitsPublication)]
        public ActionResult AjoutPublication()
        {
            List<GetSecteurs_Result> listeSecteurs = db.GetSecteursLocalises(Session);
            List<GetSujetsPublication_Result> listeSujetsPub = db.GetSujetsPublicationLocalises(Session).ToList();

            ViewData[Constantes.CLE_SECTEURS] = listeSecteurs;
            ViewData[Constantes.CLE_SUJETSPUBLICATION] = listeSujetsPub;

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [AccessDeniedAuthorize(Roles = droitsPublication)]
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

                    ObjectParameter idNouvPub = new ObjectParameter("idpub", typeof(int));
                    db.AjouterPublication(envoiPubli.TITRE, envoiPubli.DESCRIPTION, envoiPubli.IDSECTEUR, envoiPubli.IDSUJET, nomOriginal, nomServeur, mimetype, WebSecurity.CurrentUserId, idNouvPub);

                    List<String> motsCles = envoiPubli.TITRE.Split(new Char[] {' '}).ToList();

                    if (!String.IsNullOrEmpty(envoiPubli.motcles))
                        motsCles.AddRange(envoiPubli.motcles.Split(new Char[] {' '}));

                    db.UpdateMotsClesPub((int)idNouvPub.Value, MotsCles.TraiterMotsCles(motsCles));

                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Publication.publicationAjoutee);

                    return RedirectToAction("Publications", "Sectoriel");
                }
                catch (Exception ex)
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Publication.publicationErreur + " (" + ex.GetType() + ")");
                }
            }

            List<GetSecteurs_Result> listeSecteurs = db.GetSecteursLocalises(Session);
            List<GetSujetsPublication_Result> listeSujetsPub = db.GetSujetsPublicationLocalises(Session).ToList();

            ViewData[Constantes.CLE_SECTEURS] = listeSecteurs;
            ViewData[Constantes.CLE_SUJETSPUBLICATION] = listeSujetsPub;

            return View(envoiPubli);
        }

        [HttpGet]
        [AccessDeniedAuthorize(Roles = droitsPublication)]
        public ActionResult SupprimerPublication(int? id)
        {
            PUBLICATION pub = null;

            try
            {
                if (id == null)
                    throw new ArgumentNullException("id");

                pub = db.GetPublication(id).First();
            }
            catch
            {
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Publication.idPublicationInvalide);
            }

            if (pub != null)
            {
                return View(pub);
            }

            return RedirectToAction("Publications", "Sectoriel");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [AccessDeniedAuthorize(Roles = droitsPublication)]
        public ActionResult SupprimerPublication(int? id, string confirmer, string annuler)
        {
            if (!String.IsNullOrEmpty(confirmer) && String.IsNullOrEmpty(annuler))
            {
                PUBLICATION pub = null;

                try
                {
                    if (id == null)
                        throw new ArgumentNullException("id");

                    pub = db.GetPublication(id).First();
                }
                catch
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Publication.idPublicationInvalide);
                }

                if (pub != null)
                {
                    db.SupprimerPublication(id);

                    string cheminEnvoi = Fichiers.CheminEnvois(pub.NOMFICHIERSERVEUR);

                    if (IOFile.Exists(cheminEnvoi))
                        IOFile.Delete(cheminEnvoi);

                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Publication.publicationSupprimee);
                }
            }

            return RedirectToAction("Publications", "Sectoriel");
        }
    }

    public partial class AdminController
    {
        public ActionResult GestionPublications()
        {
            return View();
        }
    }
}
