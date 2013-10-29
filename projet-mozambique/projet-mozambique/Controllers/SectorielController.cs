using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using projet_mozambique.Models;
using WebMatrix.WebData;
using WebMatrix.Data;
using projet_mozambique.Utilitaires;
using System.Globalization;

namespace projet_mozambique.Controllers
{
    [Authorize]
    public class SectorielController : Controller
    {
        private Entities db = new Entities();
        //
        // GET: /Sectoriel/
        public ActionResult Index()
        {
            var secteur = from s in db.SECTEUR
                      where s.NOM.ToLower() == "agriculture"
                      select s;

            SECTEUR unSECTEUR = secteur.FirstOrDefault();
             
            return View(unSECTEUR);
        }

        [AllowAnonymous]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginModel model)
        {
            if (ModelState.IsValid)
            {

                var utilisateur = from u in db.UTILISATEUR
                                  where u.NOMUTIL == model.UserName
                                  select u;

                if (utilisateur.Count() != 0)
                {
                    UTILISATEUR currentUser = (UTILISATEUR)utilisateur.First();

                    if (WebSecurity.Login(currentUser.NOMUTIL, model.Password, true))
                    {
                        return RedirectToAction("Index", "Sectoriel");
                    }
                    else
                    {
                        ModelState.AddModelError("", "Le mot de passe est incorrect.");
                    } 
                }
                else
                {
                    ModelState.AddModelError("", "Le nom d'utilisateur fourni n'existe pas.");
                }
            }

            // Si nous sommes arrivés là, quelque chose a échoué, réafficher le formulaire
            return View(model);
        }
        /// <summary>
        /// Retourne la vue partielle qui affiche les messages reçus
        /// </summary>
        /// <returns></returns>
        public PartialViewResult BoiteReception()
        {
            ObtenirMessagesRecus();
            return PartialView("ListeMessages");
        }

        public ActionResult LogOut()
        {
            WebSecurity.Logout();
            return RedirectToAction("Index", "Public");
        }


        public ActionResult Profil()
        {
            return View();
        }
        

        /// <summary>
        /// Retourne la vue partielle qui affiche les messages envoyés
        /// </summary>
        /// <returns></returns>
        public PartialViewResult MessagesEnvoyes()
        {
            List<GetMessagesEnvoyes_Result> lstMbd = db.GetMessagesEnvoyes(1).ToList();
            List<MessageMessagerie> lstM = new List<MessageMessagerie>();
            List<PIECEJOINTE> lstPJ;
            PIECEJOINTE pj;
            int dernierMess = -1;
            int posDernierMess = -1;

            foreach (GetMessagesEnvoyes_Result m in lstMbd)
            {
                if (m.IDMESSAGE == dernierMess)
                {
                    pj = new PIECEJOINTE();
                    pj.ID = m.IDPIECE ?? 0;
                    lstM[posDernierMess].lstPiecesJointes.Add(pj);
                }
                else
                {
                    lstPJ = new List<PIECEJOINTE>();

                    if (m.IDPIECE != null)
                    {
                        pj = new PIECEJOINTE();
                        pj.ID = m.IDPIECE ?? 0;
                        lstPJ.Add(pj);
                    }

                    lstM.Add(new MessageMessagerie(m.IDMESSAGE, m.SUJET, m.CONTENU, lstPJ, true, m.DATEENVOI));
                    dernierMess = m.IDMESSAGE;
                    posDernierMess++;
                }
            }

            ViewData[Constantes.CLE_LISTE_MSG] = lstM;
            
            return PartialView("ListeMessages");
        }

        /// <summary>
        /// Méthode qui va chercher les messages reçus pour pouvoir les passer à la vue
        /// </summary>
        private void ObtenirMessagesRecus()
        {
            List<GetMessagesPrives_Result> lstMbd = db.GetMessagesPrives(1).ToList();
            List<MessageMessagerie> lstM = new List<MessageMessagerie>();
            List<PIECEJOINTE> lstPJ;
            PIECEJOINTE pj;
            int dernierMess = -1;
            int posDernierMess = -1;

            foreach (GetMessagesPrives_Result m in lstMbd)
            {
                if (m.IDMESSAGE == dernierMess)
                {
                    pj = new PIECEJOINTE();
                    pj.ID = m.IDPIECEJOINTE ?? 0;
                    lstM[posDernierMess].lstPiecesJointes.Add(pj);
                }
                else
                {
                    lstPJ = new List<PIECEJOINTE>();

                    if (m.IDPIECEJOINTE != null)
                    {
                        pj = new PIECEJOINTE();
                        pj.ID = m.IDPIECEJOINTE ?? 0;
                        lstPJ.Add(pj);
                    }

                    lstM.Add(new MessageMessagerie(m.IDMESSAGE, m.SUJET, m.CONTENU, lstPJ, m.LU, m.DATEENVOI));
                    dernierMess = m.IDMESSAGE;
                    posDernierMess++;
                }
            }

            ViewData[Constantes.CLE_LISTE_MSG] = lstM;
        }

        /// <summary>
        /// Retourne la vue partielle qui affiche les messages supprimés
        /// </summary>
        /// <returns></returns>
        public PartialViewResult Corbeille()
        {
            List<GetMessagesSupprimes_Result> lstMbd = db.GetMessagesSupprimes(1).ToList();
            List<MessageMessagerie> lstM = new List<MessageMessagerie>();
            List<PIECEJOINTE> lstPJ;
            PIECEJOINTE pj;
            int dernierMess = -1;
            int posDernierMess = -1;

            foreach (GetMessagesSupprimes_Result m in lstMbd)
            {
                if (m.IDMESSAGE == dernierMess)
                {
                    pj = new PIECEJOINTE();
                    pj.ID = m.IDPIECE ?? 0;
                    lstM[posDernierMess].lstPiecesJointes.Add(pj);
                }
                else
                {
                    lstPJ = new List<PIECEJOINTE>();

                    if (m.IDPIECE != null)
                    {
                        pj = new PIECEJOINTE();
                        pj.ID = m.IDPIECE ?? 0;
                        lstPJ.Add(pj);
                    }

                    lstM.Add(new MessageMessagerie(m.IDMESSAGE, m.SUJET, m.CONTENU, lstPJ, m.LU ?? false, m.DATEENVOI));
                    dernierMess = m.IDMESSAGE;
                    posDernierMess++;
                }
            }

            ViewData[Constantes.CLE_LISTE_MSG] = lstM;

            return PartialView("ListeMessages");
        }

        public PartialViewResult LectureMessage(int id, bool lu)
        {
            if (!lu)
            {
                db.LireMessage(id, 1);
            }

            List<GetMessage_Result> lstMess = db.GetMessage(id).ToList();
            List<PIECEJOINTE> lstPJ = new List<PIECEJOINTE>();
            PIECEJOINTE pj;

            foreach (GetMessage_Result item in lstMess)
	        {
		        pj = new PIECEJOINTE();
                pj.ID = item.IDPIECE ?? 0;
                pj.NOMPIECE = item.NOMPIECE;
                pj.TAILLEPIECE = item.TAILLEPIECE;

                lstPJ.Add(pj);
	        }

            MessageMessagerie mess = new MessageMessagerie(0, lstMess[0].SUJET, lstMess[0].CONTENU,
                                     lstPJ, true, lstMess[0].DATEENVOI);

            ViewData[Constantes.CLE_MESSAGE] = mess;    

            return PartialView();
        }

        public ActionResult NouveauMessage()
        {
            return View();
        }

        public ActionResult ModifierInfos()
        {
            Entities entity = new Entities();

            int userId = WebSecurity.GetUserId(User.Identity.Name);
            GetUtilProfil_Result profil = db.GetUtilProfil(userId).FirstOrDefault();

            ProfileModel model = new ProfileModel();

            model.courriel = profil.COURRIEL;
            model.prenom = profil.PRENOM;
            model.nom = profil.NOM;
            model.adresse = profil.ADRESSE;
            model.ville = profil.VILLE;

            return View(model);
            
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ModifierInfos(ProfileModel model)
        {
            if (ModelState.IsValid)
            {
                int id = WebSecurity.GetUserId(User.Identity.Name);

                db.ModifierUtilProfil(id, model.courriel, model.nom, model.prenom, model.adresse, model.ville, "fr");

                ViewBag.Success = "Vos informations personnelles ont été mises à jour.";
                db.SaveChanges();  
                //ModelState.AddModelError("", "Vos informations personnelles n'ont pas été mises à jour.");
                
            }
            return View(model);
        }

        public ActionResult ModifierMDP()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ModifierMDP(PasswordModel model)
        {
            return View();
        }

        public ActionResult Messagerie()
        {
            ObtenirMessagesRecus();
            return View();
        }

        public ActionResult MessageEnvoyeOK()
        {
            return View();
        }

        public ActionResult MessagePasEnvoye()
        {
            return View();
        }

        public ActionResult Documents()
        {
            return View();
        }

        public ActionResult ModifierPreferences()
        {
            return View();
        }

        public ActionResult Forum()
        {
            return View();
        }

        public ActionResult NouveauFil()
        {
            return View();
        }

        public ActionResult FilPasAjoute()
        {
            return View();
        }

        public ActionResult FilAjouteOK()
        {
            return View();
        }

        public ActionResult FilDiscu()
        {
            return View();
        }

        public ActionResult RepondreFilDiscu()
        {
            return View();
        }

        public ActionResult MessageFilAjouteOK()
        {
            return View();
        }

        public ActionResult MessageFilPasAjoute()
        {
            return View();
        }

        public ActionResult Sondages()
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

        public ActionResult ResultRechDoc()
        {
            return View();
        }

        public ActionResult SupprimerMessage()
        {
            return View();
        }

        public ActionResult RepondreMessage()
        {
            return View();
        }

        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }
    }
}
