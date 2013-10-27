using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using projet_mozambique.Models;
using projet_mozambique.Utilitaires;

namespace projet_mozambique.Controllers
{
    [Authorize(Roles="admin")]
    public class AdminController : Controller
    {
        private Entities db = new Entities();
        //
        // GET: /Admin/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult utilisateurs()
        {
            return View("Utilisateurs");
        }

        public ActionResult rechUtil()
        {
            return View("RechUtilisateur");
        }

        public ActionResult modifierUtil()
        {
            return View("ModifUtilisateur");
        }

        public ActionResult ajoutUtil()
        {
            return View("AjoutUtilisateur");
        }

        public ActionResult getEcole(string nomEcole)
        {
            ViewData["ecole"] = nomEcole;
            return View("Ecole");
        }

        public ActionResult ajoutEcole()
        {
            return View("AjoutEcole");
        }

        public ActionResult secteurs()
        {
            return View("Secteurs");
        }

        public ActionResult SectionPublique()
        {
            return View();
        }

        public ActionResult gestionNouvelles(int? gestion)
        {
            if (gestion == 2)
            {
                List<GetNouvelles_Result> lstN = db.GetNouvelles().ToList();
                ViewData[Constantes.CLE_NOUVELLES] = lstN;
            }

            return View("GestionNouvelles");
        }

        [HttpPost]
        public ActionResult confModifierNouvelle(int id, string titre, string description)
        {
            string desc = description.Replace("\r\n", "<br/>");
            db.ModifierNouvelle(id, titre, desc);

            TempData[Constantes.CLE_MSG_RETOUR] =
                new Message(Message.TYPE_MESSAGE.SUCCES, "La nouvelle a bien été modifiée.");

            return RedirectToAction("GestionNouvelles", new { gestion = 2 });
        }

        [HttpPost]
        public ActionResult modifierNouvelle(int id)
        {
            if (!string.IsNullOrEmpty(Request.Form["modifier"]))
            {
                GetNouvelle_Result n = db.GetNouvelle(id).FirstOrDefault();
                n.DESCRIPTION = n.DESCRIPTION.Replace("<br/>", "\r\n");

                TempData[Constantes.CLE_NOUVELLE] = n;

                return View("GestionNouvelles");
            }
            else if (!string.IsNullOrEmpty(Request.Form["supprimer"]))
            {
                db.SupprimerNouvelle(id);
                TempData[Constantes.CLE_MSG_RETOUR] =
                    new Message(Message.TYPE_MESSAGE.SUCCES, "La nouvelle a bien été supprimée.");

                return RedirectToAction("GestionNouvelles", new { gestion = 2 });
            }
            else
            {
                return View("GestionNouvelles", new { gestion = 2 });
            }

            
        }

        /// <summary>
        /// Action qui ajoute une nouvelle à la base de données
        /// </summary>
        /// <param name="titre">Titre de la nouvelle</param>
        /// <param name="texte">Texte de la nouvelle</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult ajouterNouvelle(string titre, string texte)
        {
            string textFormat;
            Message msg;

            if (!string.IsNullOrEmpty(titre) && !string.IsNullOrEmpty(texte))
            {
                textFormat = texte.Replace("\r\n", "<br/>");

                db.AjouterNouvelle(titre, textFormat);
                msg = new Message(Message.TYPE_MESSAGE.SUCCES, "La nouvelle a bien été ajoutée.");

                TempData[Constantes.CLE_MSG_RETOUR] = msg;
                return View("SectionPublique");
            }
            else
            {
                msg = new Message(Message.TYPE_MESSAGE.ERREUR, "La nouvelle n'a pu être ajoutée.");

                if (string.IsNullOrEmpty(titre))
                {
                    msg.lstErreurs.Add("Le titre ne peut être vide.");
                }
            
                if (string.IsNullOrEmpty(texte))
                {
                    msg.lstErreurs.Add("La description ne peut être vide.");
                }

                TempData[Constantes.CLE_MSG_RETOUR] = msg;
                return RedirectToAction("gestionNouvelles", new { gestion = 1 });
            }

        }

        public ActionResult gestionPartenaires()
        {
            return View("GestionPartenaire");
        }

        public ActionResult ModifAccueil()
        {
            GetContenu_Result contentResult = db.GetContenu("Accueil").FirstOrDefault();
            ContentModel model = new ContentModel();

            model.titre = contentResult.TITRE;
            model.titreTrad = contentResult.TITRE_TRAD;
            model.contenu = contentResult.CONTENU;
            model.contenuTrad = contentResult.CONTENU_TRAD;
            model.urlImage = contentResult.URLIMAGE;

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ModifAccueil(ContentModel model)
        {
            if (ModelState.IsValid)
            {
                db.ModifierContenu("Accueil", model.titre, model.titreTrad, model.contenu, model.contenuTrad, model.urlImage);
                db.SaveChanges();
            }
            
            return View(model);
        }

        public ActionResult modifierAPropos()
        {
            return View("ModifierAPropos");
        }

        public ActionResult modifierNousJoindre()
        {
            return View("ModifierNousJoindre");
        }

        public ActionResult ForumModerateur()
        {
            return View();
        }

        public ActionResult FilDiscuModerateur()
        {
            return View();
        }

        public ActionResult ModifierMsgFil()
        {
            return View();
        }

        public ActionResult SupprimerFil()
        {
            return View();
        }

        public ActionResult Sondages()
        {
            return View();
        }

        public ActionResult SupprimerPublication()
        {
            return View();
        }

        public ActionResult Documents()
        {
            return View();
        }

        public ActionResult PublicationDocument()
        {
            return View();
        }

        public ActionResult PublicationErreur()
        {
            return View();
        }

        public ActionResult PublicationOK()
        {
            return View();
        }

        public ActionResult AjouterEvenement()
        {
            return View();
        }

        public ActionResult Calendrier()
        {
            return View();
        }

        public ActionResult Evenement()
        {
            return View();
        }

        public ActionResult AjouterSondage()
        {
            return View();
        }

        public ActionResult AjoutSondageOK()
        {
            return View();
        }

        public ActionResult AjoutSondageErreur()
        {
            return View();
        }

        public ActionResult ModifierEvenement()
        {
            return View();
        }

        public ActionResult ModifEvenementOK()
        {
            return View();
        }

        public ActionResult ModifEvenementErreur()
        {
            return View();
        }

        public ActionResult AjoutEvenementOK()
        {
            return View();
        }

        public ActionResult AjoutEvenementErreur()
        {
            return View();
        }

        public ActionResult IndexModifie()
        {
            return View();
        }

        public ActionResult NouveauFil()
        {
            return View();
        }

        public ActionResult FilAjouteOK()
        {
            return View();
        }

        public ActionResult FilPasAjoute()
        {
            return View();
        }

        public ActionResult FilModifieOK()
        {
            return View();
        }

        public ActionResult SupprimerSondage()
        {
            return View();
        }

    }
}
