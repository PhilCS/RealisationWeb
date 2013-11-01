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
using Postal;

namespace projet_mozambique.Controllers
{
    [Authorize]
    public class SectorielController : Controller
    {
        private Entities db = new Entities();
        //
        // GET: /Sectoriel/
        /// <summary>
        /// Page d'accueil sectoriel selon un secteur sélectionné
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            var secteur = from s in db.SECTEUR
                      where s.NOM.ToLower() == "agriculture"
                      select s;

            SECTEUR unSECTEUR = secteur.FirstOrDefault();
             
            return View(unSECTEUR);
        }

        /// <summary>
        /// Page de connexion 
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult Login()
        {
            return View();
        }

        /// <summary>
        /// Page de connexion [POST]
        /// </summary>
        /// <param name="model">Informations requises</param>
        /// <returns></returns>
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
                        CultureInfo ci = new CultureInfo(currentUser.LANGUE.ToLower());
                        Session["Culture"] = ci;

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
        /// Déconnexion de l'utilisateur
        /// </summary>
        /// <returns>Page d'accueil publique</returns>
        public ActionResult LogOut()
        {
            WebSecurity.Logout();

            if (Request.Cookies.AllKeys.Contains("lang"))
                Request.Cookies.Remove("lang");

            return RedirectToAction("Index", "Public");
        }

        /// <summary>
        /// Réinitialisation du mot de passe
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult ReinitialiserMotPasse()
        {
            return View();
        }

        /// <summary>
        /// Réinitialisation du mot de passe [POST]
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        [AllowAnonymous]
        public ActionResult ReinitialiserMotPasse(ResetPassword model)
        {
            if (ModelState.IsValid)
            {
                var user = db.UTILISATEUR.FirstOrDefault(u => u.NOMUTIL == model.UserName);

                if (user != null)
                {
                    string emailAddress = user.COURRIEL;
                    if (!string.IsNullOrEmpty(emailAddress))
                    {
                        string confirmationToken =
                            WebSecurity.GeneratePasswordResetToken(model.UserName);
                        dynamic email = new Email("ResetPassword");
                        email.To = emailAddress;
                        email.UserName = model.UserName;
                        email.ConfirmationToken = confirmationToken;
                        email.Send();

                        return RedirectToAction("ConfirmationCourriel");
                    }
                }
                else
                {
                    ModelState.AddModelError("", "Invalid user name");
                }
            }

            return View(model);
        }

        /// <summary>
        /// Confirmation de l'envoi du courriel pour la réinitialisation du mot de passe
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult ConfirmationCourriel()
        {
            return View();
        }

        /// <summary>
        /// Confirmer la réinitialisation du mot de passe
        /// </summary>
        /// <param name="Id"></param>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult ConfirmationReinitialMotPasse(string Id)
        {
            ResetPasswordConfirmModel model = new ResetPasswordConfirmModel() { Token = Id };
            return View(model);
        }
        
        /// <summary>
        /// Confirmer la réinitialisation du mot de passe [POST]
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [AllowAnonymous]
        [HttpPost]
        public ActionResult ConfirmationReinitialMotPasse(ResetPasswordConfirmModel model)
        {
            if (WebSecurity.ResetPassword(model.Token, model.NewPassword))
            {
                TempData[Constantes.CLE_MSG_RETOUR] =
                new Message(Message.TYPE_MESSAGE.SUCCES, "Votre mot de passe a bien été réinitialisé.");
            }
            else
            {
                TempData[Constantes.CLE_MSG_RETOUR] =
                new Message(Message.TYPE_MESSAGE.ERREUR, "Votre mot de passe n'a pas été réinitialisé.");
            }
              
            return RedirectToAction("Login", "Sectoriel");
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
        
        /// <summary>
        /// Profil de l'utilisateur (infos persos + mot de passe)
        /// </summary>
        /// <returns></returns>
        public ActionResult Profil()
        {
            return View();
        }

        /// <summary>
        /// Modifcation des informations personnelles de l'utilisateur
        /// </summary>
        /// <returns></returns>
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
            model.langue = profil.LANGUE.ToLower();

            return View(model);

        }

        /// <summary>
        /// Modifcation des informations personnelles de l'utilisateur [POST]
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ModifierInfos(ProfileModel model)
        {
            if (ModelState.IsValid && (model.langue.ToLower().Equals("fr") || model.langue.ToLower().Equals("pt")))
            {
                int id = WebSecurity.GetUserId(User.Identity.Name);

                CultureInfo ci = new CultureInfo(model.langue.ToLower());
                Session["Culture"] = ci;

                db.ModifierUtilProfil(id, model.courriel, model.nom, model.prenom, model.adresse, model.ville, model.langue);
                db.SaveChanges();
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, "Vos informations personnelles ont été mises à jour.");
                return RedirectToAction("Profil", "Sectoriel");
            }
            return View(model);
        }

        /// <summary>
        /// Modification du mot de passe
        /// </summary>
        /// <returns></returns>
        public ActionResult ModifierMDP()
        {
            return View();
        }

        /// <summary>
        /// Modification du mot de passe [POST]
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ModifierMDP(PasswordModel model)
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

            MessageMessagerie mess = new MessageMessagerie(id, lstMess[0].SUJET, lstMess[0].CONTENU,
                                     lstPJ, true, lstMess[0].DATEENVOI);

            List<string> lstDest = new List<string>();

            var dest = from dm in db.DESTINATAIREMESSAGE
                       join u in db.UTILISATEUR on dm.IDUTILISATEUR equals u.ID
                       where dm.IDMESSAGE == mess.id
                       select new { u.NOMUTIL };

            foreach (var d in dest)
            {
                lstDest.Add(d.NOMUTIL);
            }

            mess.lstDestinataires = lstDest;

            ViewData[Constantes.CLE_MESSAGE] = mess;    

            return PartialView();
        }

        
        public ActionResult NouveauMessage()
        {
            return View();
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult NouveauMessage(MessageModel message)
        {
            List<int> lstDest = new List<int>();
            string[] dest = message.destinataires.Split(new Char[] {' '});
            int idNouveau;

            foreach (string d in dest)
            {
                var util = from u in db.UTILISATEUR
                           where u.NOMUTIL == d
                           select u.ID;

                lstDest.Add(util.FirstOrDefault());
            }

            idNouveau = db.AjouterMessagePrive(WebSecurity.GetUserId(User.Identity.Name), message.sujet, message.contenu);

            

            return View();
        }

        public ContentResult SelectionDest(string rech)
        {
            List<string> lst = new List<string>();
            string html = string.Empty;
            
            var utils = from u in db.UTILISATEUR
                        where u.NOM.ToUpper().StartsWith(rech.ToUpper()) || u.PRENOM.ToUpper().StartsWith(rech.ToUpper())
                        select u;

            foreach (var u in utils)
            {
                html += "<li>" + u.PRENOM + " " + u.NOM + " (" + u.NOMUTIL + ")</li>";
            }

            ViewData[Constantes.CLE_LISTE_UTILISATEURS] = lst;

            return Content(html);
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
