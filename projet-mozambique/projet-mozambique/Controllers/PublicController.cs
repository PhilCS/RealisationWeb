using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace projet_mozambique.Controllers
{
    public class PublicController : Controller
    {
        //
        // GET: /Public/

        public ActionResult index()
        {
            return View();
        }

        public ActionResult nouvelles()
        {
            return View("Nouvelles");
        }

        public ActionResult getNouvelle()
        {
            return View("Nouvelle");
        }

        public ActionResult partenaires()
        {
            return View("Partenaires");
        }

        public ActionResult apropos()
        {
            return View("APropos");
        }

        public ActionResult nousjoindre()
        {
            return View("NousJoindre");
        }

        public ActionResult getResultats()
        {
            return View("PageResultat");
        }

    }
}
