using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using projet_mozambique.Models;
using projet_mozambique.Utilitaires;

namespace projet_mozambique.Controllers
{
    [AllowAnonymous]
    public class PublicController : Controller
    {
        //
        // GET: /Public/

        public ActionResult index()
        {
            return View();
        }

        public ActionResult nouvelles(int? page)
        {
            MVPEntities db = new MVPEntities();
            const int nbParPage = 5;

            List<GetNouvelles_Result> lstN = db.GetNouvelles().ToList();
            ListePaginee<GetNouvelles_Result> nouvPaginees = 
                new ListePaginee<GetNouvelles_Result>(lstN, page ?? 0, nbParPage);

            ViewData[Constantes.CLE_NOUVELLES] = nouvPaginees;
            
            return View("Nouvelles");
        }

        public ActionResult getNouvelle(int id)
        {
            MVPEntities db = new MVPEntities();
            GetNouvelle_Result n = db.GetNouvelle(id).FirstOrDefault();
            ViewData[Constantes.CLE_NOUVELLE] = n;            

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

        [HttpPost]
        public ActionResult getResultats(string type, string recherche)
        {
            MVPEntities db = new MVPEntities();
            List<GetRechercheNouvelle_Result> lstR = db.GetRechercheNouvelle(recherche.Trim()).ToList();

            ViewData[Constantes.CLE_RESUL_RECH] = lstR;
            ViewData[Constantes.CLE_TYPE_RECHERCHE] = type;
            ViewData[Constantes.CLE_RECHERCHE] = type;

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
