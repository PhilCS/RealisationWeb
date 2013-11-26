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
            if (Session["currentSecteur"] != null)
            {
                int currentSecteur = (int)Session["currentSecteur"];

                SECTEUR unSecteur = null;

                if (currentSecteur != 0)
                {
                    var sectSelect = from s in db.SECTEUR
                                     where s.ID == currentSecteur
                                     select s;
                    unSecteur = sectSelect.FirstOrDefault();
                }

                return View(unSecteur);
            }
            else
                return LogOut();
        }

        [HttpPost]
        public ActionResult ChangeSecteur(string secteur, string returnUrl)
        {
            if (secteur != null && returnUrl != null)
            {
                Session["currentSecteur"] = int.Parse(secteur);

                if (Request.Cookies["currentSect"] != null)
                {
                    var c = new HttpCookie("currentSect");
                    c.Expires = DateTime.Now.AddMonths(3);
                    c.Value = secteur;
                    Response.Cookies.Add(c);
                }

                if (Url.IsLocalUrl(returnUrl))
                {
                    return Redirect(returnUrl);
                }
                else
                {
                    return RedirectToAction("Index", "Public");
                }
            }
            else
                return LogOut();
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

                        Dictionary<int, string> lstSect = new Dictionary<int, string>();

                        DateTime currentDate = DateTime.Now;

                        var sectUtil = from s in db.UTILISATEURSECTEUR
                                       where s.IDUTILISATEUR == currentUser.ID && s.DEBUTACCES <= currentDate
                                       && s.FINACCES >= currentDate
                                       select s;

                        string cookieStr = "";

                        if (sectUtil.FirstOrDefault() != null)
                        {
                            foreach (var v in sectUtil)
                            {
                                lstSect.Add(v.IDSECTEUR, v.SECTEUR.NOM + "/" + v.SECTEUR.NOMTRAD);
                                cookieStr += v.IDSECTEUR.ToString();
                                cookieStr += ',';
                                cookieStr += v.SECTEUR.NOM;
                                cookieStr += '/';
                                cookieStr += v.SECTEUR.NOMTRAD;
                                cookieStr += '&';
                            }
                        }
                        else
                        {
                            lstSect = null;
                        }


                        //Liste des secteurs de l'utilisateur
                        Session["lstSect"] = lstSect;

                        if (lstSect == null)
                        {
                            // Si l'utilisateur ne fait partie d'aucun secteur, le secteur courant est 0 
                            // et la page d'accueil de l'utilisateur affiche que l'utilisateur ne fait partie d'aucun secteur
                            Session["currentSecteur"] = 0;
                        }
                        else
                        {
                            //Index du secteur sélectionné dans la liste des secteurs de l'utilisateur
                            Session["currentSecteur"] = lstSect.First().Key;
                        }
                        
                        Session["Culture"] = ci;

                        if (model.RememberMe)
                        {
                            HttpCookie cookie = new HttpCookie("lang");
                            cookie.Expires = DateTime.Now.AddMonths(3);
                            cookie.Value = ci.Name;
                            Response.AppendCookie(cookie);

                            if (cookieStr != "" && lstSect != null)
                            {
                                HttpCookie cookieLst = new HttpCookie("lstSect");
                                cookieLst.Expires = DateTime.Now.AddMonths(3);
                                cookieLst.Value = cookieStr;
                                Response.AppendCookie(cookieLst);

                                HttpCookie cookieCurrent = new HttpCookie("currentSect");
                                cookieCurrent.Expires = DateTime.Now.AddMonths(3);
                                cookieCurrent.Value = lstSect.First().Key.ToString();
                                Response.AppendCookie(cookieCurrent);
                            }
                        }

                        return RedirectToAction("Index", "Sectoriel");
                    }
                    else
                    {
                        ModelState.AddModelError("", @Resources.Messages.PasswordInvalid);
                    }
                }
                else
                {
                    ModelState.AddModelError("", @Resources.Messages.UsernameInvalid);
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

            if (Request.Cookies["lang"] != null)
            {
                var c = new HttpCookie("lang");
                c.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(c);
            }

            if (Request.Cookies["lstSect"] != null)
            {
                var c = new HttpCookie("lstSect");
                c.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(c);
            }

            if (Request.Cookies["currentSect"] != null)
            {
                var c = new HttpCookie("currentSect");
                c.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(c);
            }

            Session["lstSect"] = null;
            Session["currentSecteur"] = null;

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
                    ModelState.AddModelError("", @Resources.Messages.UsernameInvalid);
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
                new Message(Message.TYPE_MESSAGE.SUCCES, @Resources.Messages.ResetPasswordOK);
            }
            else
            {
                TempData[Constantes.CLE_MSG_RETOUR] =
                new Message(Message.TYPE_MESSAGE.ERREUR, @Resources.Messages.ResetPasswortInvalid);
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
            model.courrielConfirm = profil.COURRIEL;
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
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, @Resources.Messages.ModifierInfosOK);
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
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, @Resources.Messages.PasswordChangeOK);
                    return RedirectToAction("Profil", "Sectoriel");
                }
                else
                {
                    ModelState.AddModelError("", @Resources.Messages.ErrorMessage + " " +
                        @Resources.Messages.PasswordChangeNotOK);
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

        public ActionResult Download(int? id)
        {
            if (id != null)
            {
                var query = from pj in db.PIECEJOINTE
                            where pj.ID == id
                            select new { pj.PIECESERIALISEE, pj.NOMPIECE };

                if (query.Any())
                {
                    return File(
                        query.FirstOrDefault().PIECESERIALISEE,
                        System.Net.Mime.MediaTypeNames.Application.Octet,
                        query.FirstOrDefault().NOMPIECE);
                }
            }

            return RedirectToAction("Messagerie");
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

        //TODO : PAGINER MESSAGES
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

        public ActionResult Forum(int? page)
        {
            if (Session != null)
            {
                GetForum_Result f = null;

                int secteur = (int)Session["currentSecteur"];

                if (secteur != 0)
                {
                    f = db.GetForum(secteur).FirstOrDefault();
                    List<GetFilDiscussion_Result> lstFil = db.GetFilDiscussion(f.ID).ToList();
                    FilModel fil;
                    int idFil;
                    List<FilModel> lstFilModel = new List<FilModel>();

                    for (int i = 0; i < lstFil.Count; i++)
                    {
                        fil = new FilModel();
                        idFil = lstFil[i].ID;

                        fil.id = lstFil[i].ID;
                        fil.nbLectures = lstFil[i].NBLECTURES;
                        fil.nbMessages = (from m in db.MESSAGEFORUM
                                          join fi in db.FILDISCUSSION on m.IDFILDISCUSSION equals fi.ID
                                          where fi.ID == idFil
                                          select m).Count();
                        fil.sujet = lstFil[i].SUJET;

                        fil.dernierParticipant = (from u in db.UTILISATEUR
                                                  join m in db.MESSAGEFORUM on u.ID equals m.IDUTILISATEUR
                                                  where m.IDFILDISCUSSION == idFil
                                                  orderby m.DATEPUBLICATION descending
                                                  select u.PRENOM + " " + u.NOM).Take(1).FirstOrDefault();

                        fil.dateDerniereReponse = (from u in db.UTILISATEUR
                                                   join m in db.MESSAGEFORUM on u.ID equals m.IDUTILISATEUR
                                                   where m.IDFILDISCUSSION == idFil
                                                   orderby m.DATEPUBLICATION descending
                                                   select m.DATEPUBLICATION).Take(1).FirstOrDefault();

                        lstFilModel.Add(fil);
                    }

                    ListePaginee<FilModel> lstFilModelPag = new ListePaginee<FilModel>(lstFilModel, page ?? 0, 15);

                    ViewData[Constantes.CLE_FILSFORUM] = lstFilModelPag;

                }

                ViewData[Constantes.CLE_FORUM] = f;
                return View();
            }
            else
                return RedirectToAction("LogOut");
        }

        public ActionResult NouveauFil()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult NouveauFil(MessageForumModel model)
        {
            if (ModelState.IsValid)
            {
                TempData[Constantes.CLE_MESSAGE] = Resources.Messages.filAjoute;
                int idUtil = WebSecurity.GetUserId(User.Identity.Name);
                int idSecteur = (int)Session["currentSecteur"];
                int idForum = (from f in db.FORUM
                              where f.IDSECTEUR == idSecteur
                              select f.ID).FirstOrDefault();

                FILDISCUSSION nouvFil = new FILDISCUSSION
                {
                    SUJET = model.sujet,
                    IDFORUM = idForum,
                    DATEPUBLICATION = DateTime.Now
                };

                db.FILDISCUSSION.Add(nouvFil);
                db.SaveChanges();
                db.AjouterMessageForum(model.contenu.Replace("\r\n", Constantes.BR), idUtil, nouvFil.ID);

                return RedirectToAction("Forum");    
            }

            return View();
        }

        public ActionResult FilDiscu(int? id, int? idPage)
        {
            if (id != null)
            {
                if (filDiscuSecteurCourant(id ?? -1))
                {
                    int idUtil = WebSecurity.GetUserId(User.Identity.Name);

                    var fil = from f in db.FILDISCUSSION
                              where f.ID == id
                              select f;

                    fil.FirstOrDefault().NBLECTURES += 1;
                    db.SaveChanges();

                    var lstM = db.GetMessagesForum(id);
                    List<MessageForumModel> lstMMod = new List<MessageForumModel>();
                    ListePaginee<MessageForumModel> lstMessPag;
                    MessageForumModel mm;

                    foreach (var m in lstM)
                    {
                        mm = new MessageForumModel();
                        mm.contenu = m.CONTENU.Replace(Constantes.BR, "\r\n");
                        mm.datePublication = m.DATEPUBLICATION;
                        mm.dateModification = m.DATEMODIFICATION ?? DateTime.MinValue;
                        mm.auteur = (from u in db.UTILISATEUR
                                     where u.ID == m.IDUTILISATEUR
                                     select u.PRENOM + " " + u.NOM).FirstOrDefault();
                        lstMMod.Add(mm);
                    }

                    FilModel filMod = new FilModel();
                    FILDISCUSSION unFil = fil.FirstOrDefault();
                    lstMessPag = new ListePaginee<MessageForumModel>(lstMMod, idPage ?? 0, 15);

                    filMod.id = unFil.ID;
                    filMod.listeMessages = lstMessPag;
                    filMod.sujet = unFil.SUJET;

                    ViewData[Constantes.CLE_FILDISCUSSION] = filMod;

                    return View();
                }
            }

            return RedirectToAction("Forum");
        }

        [AccessDeniedAuthorize(Roles = "admin,professeurModerateur")]
        public ActionResult SupprimerFil(int? idFil, int? noPage)
        {
            if (idFil != null)
            {
                db.SupprimerFilDiscussion(idFil);

                TempData[Constantes.CLE_MESSAGE] = Resources.Messages.filSupprime;
            }

            return RedirectToAction("Forum", "Sectoriel", new { page = noPage });
        }

        private bool filDiscuSecteurCourant(int id)
        { 
            int idSecteur = (int)Session["currentSecteur"];
            var x = from fi in db.FILDISCUSSION
                    join fo in db.FORUM on fi.IDFORUM equals fo.ID
                    join s in db.SECTEUR on fo.IDSECTEUR equals s.ID
                    where fi.ID == id && s.ID == idSecteur
                    select fi;

            if (x.Any())
                return true;

            return false;
        }

        public ActionResult RepondreFilDiscu()
        {
            return View();
        }

        public ActionResult Sondages()
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

        public ActionResult RepondreMessage(int? id)
        {
            if (id != null)
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

            return RedirectToAction("Messagerie");
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
