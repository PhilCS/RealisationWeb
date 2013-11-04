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
using System.IO;
using System.Data.Common;
using System.Transactions;

namespace projet_mozambique.Controllers
{
    [Authorize]
    public partial class SectorielController : Controller
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

                    if (WebSecurity.Login(currentUser.NOMUTIL, model.Password, model.RememberMe))
                    {
                        CultureInfo ci = new CultureInfo(currentUser.LANGUE.ToLower());

                        if (model.RememberMe)
                        {
                            HttpCookie cookie = new HttpCookie("lang");
                            cookie.Expires = DateTime.Now.AddMonths(3);
                            cookie.Value = ci.Name;
                            Response.AppendCookie(cookie);
                        }

                        /*if (Request.Cookies.AllKeys.Contains("lang"))
                            Request.Cookies["lang"].Value = ci.Name;*/

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
                Response.Cookies.Remove("lang");

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

                if (Request.Cookies.AllKeys.Contains("lang"))
                {
                    HttpCookie cookie = Request.Cookies["lang"];
                    cookie.Value = ci.Name;
                    Response.Cookies.Set(cookie);
                }

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
            if (ModelState.IsValid)
            {
                if (WebSecurity.ChangePassword(User.Identity.Name, model.OldPassword, model.NewPassword))
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, "Votre mot de passe a été changé.");
                    return RedirectToAction("Profil", "Sectoriel");
                }
                else
                {
                    ModelState.AddModelError("", "Votre mot de passe n'a pu être changé");
                }
                
            }
            return View(model);
        }
        

        /// <summary>
        /// Retourne la vue partielle qui affiche les messages envoyés
        /// </summary>
        /// <returns></returns>
        public PartialViewResult MessagesEnvoyes()
        {
            int userId = WebSecurity.GetUserId(User.Identity.Name);
            List<GetMessagesEnvoyes_Result> lstMbd = db.GetMessagesEnvoyes(userId).ToList();
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
            int userId = WebSecurity.GetUserId(User.Identity.Name);
            List<GetMessagesPrives_Result> lstMbd = db.GetMessagesPrives(userId).ToList();
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
            int userId = WebSecurity.GetUserId(User.Identity.Name);

            List<GetMessagesSupprimes_Result> lstMbd = db.GetMessagesSupprimes(userId).ToList();
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

                    lstM.Add(new MessageMessagerie(m.IDMESSAGE, m.SUJET, m.CONTENU, lstPJ, true, m.DATEENVOI));
                    dernierMess = m.IDMESSAGE;
                    posDernierMess++;
                }
            }

            ViewData[Constantes.CLE_LISTE_MSG] = lstM;
            ViewData[Constantes.CLE_CORBEILLE] = true;
            return PartialView("ListeMessages");
        }

        public PartialViewResult LectureMessage(int id, bool lu)
        {
            int userId = WebSecurity.GetUserId(User.Identity.Name);

            if (!lu)
            {
                db.LireMessage(id, userId);
            }

            List<GetMessage_Result> lstMess = db.GetMessage(id).ToList();
            List<PIECEJOINTE> lstPJ = new List<PIECEJOINTE>();
            PIECEJOINTE pj;

            foreach (GetMessage_Result item in lstMess)
            {
                if (item.IDPIECE != null)
                {
                    pj = new PIECEJOINTE();
                    pj.ID = item.IDPIECE ?? 0;
                    pj.NOMPIECE = item.NOMPIECE;
                    pj.TAILLEPIECE = item.TAILLEPIECE;

                    lstPJ.Add(pj);
                }
            }

            var nom = from u in db.UTILISATEUR
                      join mp in db.MESSAGEPRIVE on u.ID equals mp.IDEXPEDITEUR
                      where mp.ID == id
                      select new { u.NOMUTIL, nom = u.PRENOM + " " + u.NOM };

            MessageMessagerie mess = new MessageMessagerie(id, lstMess[0].SUJET, lstMess[0].CONTENU,
                                     lstPJ, true, lstMess[0].DATEENVOI, nom.FirstOrDefault().nom, nom.FirstOrDefault().NOMUTIL);

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


        public ActionResult Download(int id)
        {
            var query = from pj in db.PIECEJOINTE
                        where pj.ID == id
                        select new { pj.PIECESERIALISEE, pj.NOMPIECE };

            return File(
                query.FirstOrDefault().PIECESERIALISEE, 
                System.Net.Mime.MediaTypeNames.Application.Octet, 
                query.FirstOrDefault().NOMPIECE);
        }

        
        public ActionResult NouveauMessage()
        {
            MessageModel mess = new MessageModel();

            if (TempData[Constantes.CLE_MESSAGE] != null)
            {
                MessageModel messOrigine = (TempData[Constantes.CLE_MESSAGE] as MessageModel);
                mess.contenu = "\r\n\r\n******************************\r\n\r\n" + messOrigine.contenu;
                mess.destinataires = messOrigine.destinataires;
                mess.sujet = "RE: " + messOrigine.sujet;
                ViewData[Constantes.CLE_TITRE] = Resources.Sectoriel.repondreMessage;
            }
            else
                ViewData[Constantes.CLE_TITRE] = Resources.Sectoriel.nouveauMessage;


            return View(mess);
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult NouveauMessage(MessageModel message)
        {
            if (ModelState.IsValid)
            {
                List<int> lstDest = new List<int>();
                string[] dest = message.destinataires.Split(new Char[] { ';' });
                int idNouveau;

                //PIÈCE JOINTE 
                HttpPostedFileBase pj;
                int MaxContentLength = 1024 * 1024 * 15;
                string taillePiece = string.Empty;
                string nomPiece = string.Empty;
                byte[] dataPiece = null;


                foreach (string d in dest)
                {
                    if (d.Trim() != string.Empty)
                    {
                        var util = from u in db.UTILISATEUR
                                   where u.NOMUTIL.ToUpper() == d.Trim().ToUpper()
                                   select u.ID;

                        if (util.FirstOrDefault() != 0 && !lstDest.Contains(util.FirstOrDefault()))
                            lstDest.Add(util.FirstOrDefault());
                        else if (util.FirstOrDefault() == 0)
                            ModelState.AddModelError("", String.Format(Resources.Sectoriel.destinataireInexistant, d));
                    }
                }

                //PIÈCE JOINTE
                if (message.piecesJointes != null)
                {
                    pj = message.piecesJointes;

                    if (pj.ContentLength > MaxContentLength)
                    {
                        ModelState.AddModelError("", string.Format(Resources.Messages.pieceTropLourde, (MaxContentLength / 1024).ToString()));
                    }
                    else
                    {
                        taillePiece = pj.ContentLength.ToString();
                        nomPiece = pj.FileName;

                        MemoryStream target = new MemoryStream();
                        pj.InputStream.CopyTo(target);
                        dataPiece = target.ToArray();
                    }
 
                }

                if (!ModelState.IsValid)
                    return View(message);

                //AJOUT DU MESSAGE
                db.AjouterMessagePrive(WebSecurity.GetUserId(User.Identity.Name),
                                        message.sujet,
                                        message.contenu.Replace("\r\n", Constantes.BR));

                var id = (from mp in db.MESSAGEPRIVE
                            orderby mp.ID descending
                            select mp.ID).Take(1);

                idNouveau = id.FirstOrDefault();

                //AJOUT DES DESTINATAIRES
                foreach (var u in lstDest)
                {
                    db.AjouterDestinataireMess(idNouveau, u);
                }

                //AJOUT PIÈCE JOINTE
                if (message.piecesJointes != null)
                {
                    db.AjouterPieceJointe(idNouveau, dataPiece, taillePiece, nomPiece);
                }

                TempData[Constantes.CLE_MESSAGE] = Resources.Messages.messageEnvoye;
                        
                return RedirectToAction("Messagerie");
            }

            return View(message);
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

        public ActionResult Messagerie(int? location)
        {
            if (location == 1)
            {
                return BoiteReception();
            }
            if (location == 2)
            {
                return MessagesEnvoyes();
            }
            else if (location == 2)
            {
                return Corbeille();
            }
            else
            {
                ObtenirMessagesRecus();
                return View();
            }
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

        public ActionResult SupprimerMessages(int[] lstId, int definitif)
        {
            if (lstId != null)
            {
                int idUser = WebSecurity.GetUserId(User.Identity.Name);

                foreach (var id in lstId)
                {
                    var query = from mp in db.MESSAGEPRIVE
                                where mp.IDEXPEDITEUR == idUser && mp.ID == id
                                select mp;

                    if (query.FirstOrDefault() != null)
                    {
                        if (definitif == 1)
                            query.FirstOrDefault().SUPPRIMEDEFINITIF = true;
                        else
                            query.FirstOrDefault().SUPPRIME = true;
                    }
                    else
                    {
                        var query2 = from dm in db.DESTINATAIREMESSAGE
                                     where dm.IDUTILISATEUR == idUser && dm.IDMESSAGE == id
                                     select dm;
                        if (definitif == 1)
                            query2.FirstOrDefault().SUPPRIMEDEFINITIF = true;
                        else
                            query2.FirstOrDefault().SUPPRIME = true;
                    }

                    db.SaveChanges();
                }

                if (lstId.Length > 1)
                    Session[Constantes.CLE_MESSAGE] = Resources.Messages.messagesSupprimes;
                else
                    Session[Constantes.CLE_MESSAGE] = Resources.Messages.messageSupprime;
            }

            return RedirectToAction("Messagerie");
        }

        public ActionResult SupprimerMessage(int id, int definitif)
        {
            return SupprimerMessages(new int[1] { id }, definitif);
        }

        public ActionResult RepondreMessage(int id)
        {
            var messOrigine = from u in db.UTILISATEUR
                           join mp in db.MESSAGEPRIVE on u.ID equals mp.IDEXPEDITEUR
                           where mp.ID == id
                           select new { u.NOMUTIL, mp.CONTENU, mp.SUJET };

            MessageModel mess = new MessageModel();
            mess.destinataires = messOrigine.FirstOrDefault().NOMUTIL;
            mess.sujet = messOrigine.FirstOrDefault().SUJET;
            mess.contenu = messOrigine.FirstOrDefault().CONTENU;

            TempData[Constantes.CLE_MESSAGE] = mess;

            return RedirectToAction("NouveauMessage");
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
