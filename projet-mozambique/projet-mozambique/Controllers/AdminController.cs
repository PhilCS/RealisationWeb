using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace projet_mozambique.Controllers
{
    public class AdminController : Controller
    {
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

        public ActionResult roles()
        {
            return View("Roles");
        }

        public ActionResult getRole(string nomRole)
        {
            ViewData["role"] = nomRole;
            return View("Role");
        }

        public ActionResult ajoutRole()
        {
            return View("AjouterRole");
        }

        public ActionResult ecoles()
        {
            return View("Ecoles");
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

        public ActionResult publique()
        {
            return View("SectionPublique");
        }

        public ActionResult gestionNouvelles()
        {
            return View("GestionNouvelles");
        }

        public ActionResult gestionPartenaires()
        {
            return View("GestionPartenaire");
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

        public ActionResult ModifAccueil()
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
