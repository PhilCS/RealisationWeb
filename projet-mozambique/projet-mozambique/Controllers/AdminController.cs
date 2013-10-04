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

        public ActionResult ajoutUtil()
        {
            return View("AjoutUtilisateur");
        }

        public ActionResult roles()
        {
            return View("Roles");
        }

        public ActionResult publique()
        {
            return View("SectionPublique");
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
    }
}
