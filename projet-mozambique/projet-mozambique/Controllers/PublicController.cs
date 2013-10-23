using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using projet_mozambique.Models;

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

        [HttpPost]
        public ActionResult doLogin(string UserString, string PWString, bool RememberMe)
        {
            //UtilisateursDataContext tblUtil = new UtilisateursDataContext();
            //if (!String.IsNullOrEmpty(UserString) && !String.IsNullOrEmpty(PWString))
            //{
            //    //var utilisateur = from u in tblUtil.UTILISATEUR
            //    //                  where u.NOMUTIL == UserString && u.MOTPASSE == PWString
            //    //                  select new { UserId = u .ID, UserName = u.NOMUTIL, Secteur = u.UTILISATEURSECTEUR };
            //    //if (utilisateur.Count() != 0)
            //    //{
            //    //    int id = utilisateur.First().UserId;
            //    //    string name = utilisateur.First().UserName;

            //    //    Session["currentUserName"] = name;
            //    //    Session["currentUserId"] = id;

            //    //    int nbSecteur = 0;

            //    //    foreach (var s in utilisateur.First().Secteur)
            //    //    {
            //    //        nbSecteur++;
            //    //        Session["userSector" + nbSecteur.ToString()] = s.SECTEUR.NOM;
            //    //    }
                    
            //        return RedirectToAction("Index", "sectoriel");
                    
            //    }
            //}

            return View("Index");
        }

    }
}
