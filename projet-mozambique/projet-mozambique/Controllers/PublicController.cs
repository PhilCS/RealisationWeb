using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using System.Data.Entity;
using projet_mozambique.Models;
using WebMatrix.WebData;
using WebMatrix.Data;
using System.Globalization;
using projet_mozambique.Utilitaires;

namespace projet_mozambique.Controllers
{
    [AllowAnonymous]
    public partial class PublicController : Controller
    {
        private Entities db = new Entities();
        //
        // GET: /Public/
        public ActionResult Index()
        {
            if (Request.IsAuthenticated)
                return RedirectToAction("Index", "Sectoriel");
            else
                return RedirectToAction("Home", "Public");

            /*GetContenu_Result contentResult = db.GetContenu("Accueil").FirstOrDefault();

            return View(contentResult);*/
        }

        public ActionResult Home()
        { 
            GetContenu_Result contentResult = db.GetContenu("Accueil").FirstOrDefault();

            return View("Index", contentResult);
        }

        public ActionResult ChangeCulture(string lang, string returnUrl)
        {
            CultureInfo ci = new CultureInfo(lang);
            Session["Culture"] = ci;
            
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            else
            {
                return RedirectToAction("Home", "Public");
            }
        }

        public ActionResult nouvelles(int? page)
        {
            Entities db = new Entities();
            const int nbParPage = 5;

            List<GetNouvelles_Result> lstN = db.GetNouvelles().ToList();
            ListePaginee<GetNouvelles_Result> nouvPaginees = 
                new ListePaginee<GetNouvelles_Result>(lstN, page ?? 0, nbParPage);

            ViewData[Constantes.CLE_NOUVELLES] = nouvPaginees;
            
            return View("Nouvelles");
        }

        public ActionResult getNouvelle(int? id)
        {
            if (id != null)
            {
                GetNouvelle_Result n = db.GetNouvelle(id).FirstOrDefault();

                if (n != null)
                {
                    ViewData[Constantes.CLE_NOUVELLE] = n;

                    return View("Nouvelle");
                }
            }

            return RedirectToAction("Nouvelles");
        }

        public ActionResult APropos()
        {
            GetContenu_Result contentResult = db.GetContenu("About").FirstOrDefault();

            return View(contentResult);
        }

        public ActionResult NousJoindre()
        {
            GetContenu_Result contentResult = db.GetContenu("Contact").FirstOrDefault();

            return View(contentResult);
        }

        [HttpPost]
        public ActionResult getResultats(string type, string recherche)
        {
            List<GetRechercheNouvelle_Result> lstR = db.GetRechercheNouvelle(recherche.Trim()).ToList();

            ViewData[Constantes.CLE_RESUL_RECH] = lstR;
            ViewData[Constantes.CLE_TYPE_RECHERCHE] = type;
            ViewData[Constantes.CLE_RECHERCHE] = type;

            return View("PageResultat");
        }
    }
}
