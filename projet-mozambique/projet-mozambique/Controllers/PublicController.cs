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
    }
}
