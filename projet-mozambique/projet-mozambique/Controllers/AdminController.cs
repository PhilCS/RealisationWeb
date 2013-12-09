using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.IO;
using System.Net;
using System.Web;
using System.Web.Mvc;
using projet_mozambique.Models;
using projet_mozambique.Utilitaires;
using WebMatrix.WebData;
using WebMatrix.Data;
using System.Web.Security;
using System.Net.Mail;

namespace projet_mozambique.Controllers
{
    [AccessDeniedAuthorize(Roles = "admin")]
    public partial class AdminController : Controller
    {
        private Entities db = new Entities();
        //
        // GET: /Admin/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GestionUtilisateurs()
        {
            List<ECOLE> lstEcoles = db.ECOLE.ToList();
            List<SECTEUR> lstSecteurs = db.SECTEUR.ToList();

            ViewData[Constantes.CLE_LISTE_ECOLES] = lstEcoles;
            ViewData[Constantes.CLE_SECTEURS] = lstSecteurs;
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult GestionUtilisateurs(string txtInput, int? idSecteur, int? idEcole)
        {
            if (!string.IsNullOrEmpty(Request.Form["rechUtils"]))
            {
                IQueryable<UTILISATEUR> resultats;
                if (!string.IsNullOrEmpty(txtInput))
                {
                    if(idSecteur != 0)
                    {
                        resultats = from u in db.UTILISATEUR
                                    where (u.NOMUTIL.Contains(txtInput) ||
                                    u.NOM.Contains(txtInput) || u.PRENOM.Contains(txtInput)) &&
                                    u.UTILISATEURSECTEUR.Any(s => s.IDSECTEUR == idSecteur)
                                    select u;

                        if (idEcole != 0)
                            resultats = resultats.Where(e => e.IDECOLE == idEcole);
                    }
                    else if (idEcole != 0)
                    {
                        resultats = from u in db.UTILISATEUR
                                    where u.NOMUTIL.Contains(txtInput) ||
                                    u.NOM.Contains(txtInput) || u.PRENOM.Contains(txtInput)
                                    select u;

                        resultats = resultats.Where(e => e.IDECOLE == idEcole);
                    }
                    else
                    {
                        resultats = from u in db.UTILISATEUR
                                    where u.NOMUTIL.Contains(txtInput) || u.NOM.Contains(txtInput) ||
                                    u.PRENOM.Contains(txtInput)
                                    select u;
                    }
                }
                else
                {
                    if (idSecteur != 0)
                    {
                        resultats = from u in db.UTILISATEUR
                                    where u.UTILISATEURSECTEUR.Any(s => s.IDSECTEUR == idSecteur)
                                    select u;

                        if (idEcole != 0)
                            resultats = resultats.Where(e => e.IDECOLE == idEcole);
                        
                    }
                    else if (idEcole != 0)
                    {
                        resultats = from u in db.UTILISATEUR
                                        where u.IDECOLE == idEcole
                                        select u;
                    }
                    else
                    {
                        resultats = from u in db.UTILISATEUR
                                        select u;
                    }
                }

                List<UTILISATEUR> lstUtils = lstUtils = resultats.ToList();
                ViewData[Constantes.CLE_LISTE_UTILISATEURS] = lstUtils;

                List<ECOLE> lstEcoles = db.ECOLE.DefaultIfEmpty().ToList();
                List<SECTEUR> lstSecteurs = db.SECTEUR.DefaultIfEmpty().ToList();

                ViewData[Constantes.CLE_LISTE_ECOLES] = lstEcoles;
                ViewData[Constantes.CLE_SECTEURS] = lstSecteurs;
            }
            return View();
        }

        public ActionResult AjoutUtilisateur()
        {
            List<ECOLE> lstEcoles = db.ECOLE.ToList();
            List<webpages_Roles> lstRoles = db.webpages_Roles.ToList();

            AjoutUtilModel model = new AjoutUtilModel
            {
                Ecoles = lstEcoles.Select(e => new SelectListItem
                {
                    Text = e.NOM,
                    Value = e.ID.ToString()
                }),

                Roles = lstRoles.Select(r => new SelectListItem
                {
                    Text = r.RoleName,
                    Value = r.RoleName
                })
            };

            
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AjoutUtilisateur(AjoutUtilModel model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    string confirmToken = WebSecurity.CreateUserAndAccount(model.nomUtil, model.password, propertyValues: new
                    {
                        COURRIEL = model.courriel,
                        PRENOM = model.prenom,
                        NOM = model.nom,
                        ADRESSE = model.adresse,
                        VILLE = model.ville,
                        DATENAISSANCE = model.dateNaissance,
                        IDECOLE = model.idEcole,
                        ACTIF = model.active
                    }, requireConfirmationToken: true);

                    if (!string.IsNullOrEmpty(confirmToken))
                    {
                        Roles.AddUserToRole(model.nomUtil, model.roleName);
                    }

                    if (model.roleName.Equals("admin"))
                    {
                        List<SECTEUR> allSect = db.SECTEUR.ToList();

                        int idUtil = WebSecurity.GetUserId(model.nomUtil);
                        foreach (var s in allSect)
                        {
                            UTILISATEURSECTEUR lien = new UTILISATEURSECTEUR();
                            lien.IDSECTEUR = s.ID;
                            lien.IDUTILISATEUR = idUtil;
                            lien.DEBUTACCES = DateTime.Now;
                            lien.FINACCES = DateTime.Now.AddYears(10);

                            db.UTILISATEURSECTEUR.Add(lien);
                        }

                        db.SaveChanges();
                    }

                    MailMessage mail = new MailMessage();
                    mail.From = new MailAddress(Constantes.EMAIL);
                    mail.To.Add(model.courriel);
                    mail.Subject = Resources.Sectoriel.ConfirmAccount;
                    string lienRetour = "http://localhost:53486/Sectoriel/ConfirmationCompte/" + confirmToken;
                    string message = String.Format(Resources.Sectoriel.msgConfirmAccount, model.nomUtil);
                    message += "<a href=\"";
                    message += lienRetour;
                    message += "\">";
                    message += lienRetour;
                    message += "</a>";
                    mail.IsBodyHtml = true;
                    mail.Body = message;

                    SmtpClient smtp = new SmtpClient();
                    smtp.Host = Constantes.HOST;
                    smtp.Port = Constantes.PORT;
                    smtp.UseDefaultCredentials = false;
                    smtp.Credentials = new System.Net.NetworkCredential(Constantes.EMAIL, Constantes.EMAIL_PWD);
                    smtp.EnableSsl = true;
                    smtp.Send(mail);
                   

                    TempData[Constantes.CLE_MSG_RETOUR] =
                        new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Messages.UserAddedOk);

                    return RedirectToAction("GestionUtilisateurs", "Admin");

                }
                catch (Exception e)
                {
                    ModelState.AddModelError("", e.Message);
                }
            }
           
            return View(model);
        }

        public ActionResult ModifUtilisateur(int? idUtil)
        {
            if (idUtil != null)
            {
                UTILISATEUR leU = db.UTILISATEUR.SingleOrDefault(u => u.ID == idUtil);

                List<ECOLE> lstEcoles = db.ECOLE.ToList();
                List<webpages_Roles> lstRoles = db.webpages_Roles.ToList();

                ModifUtilisateurModel model = new ModifUtilisateurModel();

                model.nomUtil = leU.NOMUTIL;
                model.courriel = leU.COURRIEL;
                model.courrielConfirm = leU.COURRIEL;
                model.prenom = leU.PRENOM;
                model.nom = leU.NOM;
                model.adresse = leU.ADRESSE;
                model.ville = leU.VILLE;
                model.dateNaissance = leU.DATENAISSANCE;
                model.derniereConnexion = leU.DERNIERECONNEXION.Value;
                model.langue = leU.LANGUE;
                model.idEcole = leU.IDECOLE;
                model.active = leU.ACTIF;
                model.Ecoles = lstEcoles.Select(e => new SelectListItem
                    {
                        Text = e.NOM,
                        Value = e.ID.ToString()
                    });
                model.Roles = lstRoles.Select(r => new SelectListItem
                    {
                        Text = r.RoleName,
                        Value = r.RoleName
                    });
                model.roleName = leU.webpages_Roles.SingleOrDefault().RoleName;

                return View(model);
            }

            return RedirectToAction("GestionUtilisateurs", "Admin");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ModifUtilisateur(ModifUtilisateurModel model)
        {
            if (ModelState.IsValid)
            { 
                UTILISATEUR u = db.UTILISATEUR.SingleOrDefault(i => i.ID == model.idUtil);
                if(!u.NOMUTIL.Equals(model.nomUtil))
                    u.NOMUTIL = model.nomUtil;

                u.COURRIEL = model.courriel;
                u.PRENOM = model.prenom;
                u.NOM = model.nom;
                u.ADRESSE = model.adresse;
                u.VILLE = model.ville;
                u.DATENAISSANCE = u.DATENAISSANCE;
                u.LANGUE = model.langue;
                u.IDECOLE = model.idEcole;
                u.ACTIF = model.active;
                
                db.SaveChanges();

                string currentRole = u.webpages_Roles.FirstOrDefault().RoleName;

                if (!currentRole.Equals(model.roleName))
                {
                    Roles.RemoveUserFromRole(u.NOMUTIL, currentRole);
                    Roles.AddUserToRole(u.NOMUTIL, model.roleName);
                }

                if (currentRole.Equals("admin") && !currentRole.Equals(model.roleName))
                {
                    var utilSect = from uti in db.UTILISATEURSECTEUR
                                   where uti.IDUTILISATEUR == u.ID
                                   select uti;

                    foreach(var utSect in utilSect)
                    {
                        UTILISATEURSECTEUR usect = (UTILISATEURSECTEUR)utSect;

                        db.UTILISATEURSECTEUR.Remove(usect);
                    }
                }
                if (model.roleName.Equals("admin"))
                {
                    List<SECTEUR> allSect = db.SECTEUR.ToList();

                    int idUtil = WebSecurity.GetUserId(model.nomUtil);
                    foreach (var s in allSect)
                    {
                        bool lienExiste = db.UTILISATEURSECTEUR.Any(us => us.IDSECTEUR == s.ID && us.IDUTILISATEUR == idUtil);
                        
                        if (!lienExiste)
                        {
                            UTILISATEURSECTEUR lien = new UTILISATEURSECTEUR();
                            lien.IDSECTEUR = s.ID;
                            lien.IDUTILISATEUR = idUtil;
                            lien.DEBUTACCES = DateTime.Now;
                            lien.FINACCES = DateTime.Now.AddYears(10);

                            db.UTILISATEURSECTEUR.Add(lien);
                        }
                    }
                }

                db.SaveChanges();

                TempData[Constantes.CLE_MSG_RETOUR] =
                            new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Messages.UserModifOk);

                return RedirectToAction("GestionUtilisateurs", "Admin");
            }

            return View(model);
        }

        public ActionResult GestionSecteurs()
        {
            var allSect = from s in db.SECTEUR
                          select s;

            List<SECTEUR> lstS = allSect.ToList();

            ViewData[Constantes.CLE_SECTEURS] = lstS;

            return View();
        }

        public ActionResult Secteur(int sect)
        {
            var leS = from s in db.SECTEUR
                           where s.ID == sect
                           select s;

            if (leS.FirstOrDefault() != null)
            {
                if (!string.IsNullOrEmpty(Request.Form["modifSecteur"]))
                {
                    return RedirectToAction("ModifSecteur", "Admin", new { @idSect = sect });
                }
                else if (!string.IsNullOrEmpty(Request.Form["suppSecteur"]))
                {
                    db.SupprimerSecteur(sect);
                    db.SaveChanges();

                    TempData[Constantes.CLE_MSG_RETOUR] =
                                new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Messages.SecteurDeleted);

                    return RedirectToAction("GestionSecteurs");

                }
                else if (!string.IsNullOrEmpty(Request.Form["utilsSecteur"]))
                {
                    return RedirectToAction("UtilisateursSecteur", "Admin", new { @idSect = sect });
                }
                else if (!string.IsNullOrEmpty(Request.Form["ecolesSecteurs"]))
                {
                    return RedirectToAction("EcolesSecteur", "Admin", new { @idSect = sect });
                }
                else
                {
                    return RedirectToAction("GestionSecteurs");
                }
            }

            TempData[Constantes.CLE_MSG_RETOUR] =
                                new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Messages.SectInexistant);
            return RedirectToAction("GestionSecteurs");
        }

        public ActionResult UtilisateursSecteur(int? idSect)
        {
            if (idSect != null)
            {
                var leS = from s in db.SECTEUR
                          where s.ID == idSect
                          select s;

                if (leS.FirstOrDefault() == null)
                {
                    TempData[Constantes.CLE_MSG_RETOUR] =
                                new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Messages.SectInexistant);
                }
                else
                {

                    var allUtils = from u in db.UTILISATEUR
                                   where u.UTILISATEURSECTEUR.All(s => s.IDSECTEUR != idSect)
                                   select u;

                    var ecolesSecteur = from e in db.ECOLE
                                        where e.SECTEUR.Any(s => s.ID == idSect)
                                        select e.ID;

                    List<UTILISATEUR> lstAllUtils = new List<UTILISATEUR>();
                    foreach (var e in ecolesSecteur)
                    {
                        foreach (var u in allUtils)
                        {
                            if (u.IDECOLE == e)
                            {
                                lstAllUtils.Add(u);
                            }
                        }
                    }


                    var lesUtils = from u in db.UTILISATEURSECTEUR
                                   where u.IDSECTEUR == idSect
                                   select u.UTILISATEUR;

                    List<UTILISATEUR> lstUtils = lesUtils.ToList();
                    ViewData[Constantes.CLE_LISTE_UTILISATEURS] = lstUtils;
                    ViewData[Constantes.CLE_NOMSECTEUR] = leS.FirstOrDefault().NOM + "/" + leS.FirstOrDefault().NOMTRAD;
                    ViewData[Constantes.CLE_IDSECTEUR] = leS.FirstOrDefault().ID;

                    AjoutUtilSecteurModel model = new AjoutUtilSecteurModel
                    {
                        Utilisateurs = lstAllUtils.Select(u => new SelectListItem
                        {
                            Text = u.NOMUTIL,
                            Value = u.ID.ToString()
                        }), 
                        idSecteur = idSect.Value,
                    };

                    model.debutAcces = DateTime.Now;
                    model.finAcces = DateTime.Now.AddYears(1);

                    return View(model);
                }
                
               return View();
            }

            return RedirectToAction("Index");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UtilisateursSecteur(AjoutUtilSecteurModel model)
        {
            if (ModelState.IsValid)
            {
                var leS = db.SECTEUR.SingleOrDefault(s => s.ID == model.idSecteur);
                var leU = db.UTILISATEUR.SingleOrDefault(u => u.ID == model.idUtil);

                if (leS != null && leU != null)
                {
                    if (model.debutAcces.CompareTo(model.finAcces) < 0)
                    {
                        UTILISATEURSECTEUR lien = new UTILISATEURSECTEUR();
                        lien.IDSECTEUR = model.idSecteur;
                        lien.IDUTILISATEUR = model.idUtil;
                        lien.DEBUTACCES = model.debutAcces;
                        lien.FINACCES = model.finAcces;

                        db.UTILISATEURSECTEUR.Add(lien);

                        db.SaveChanges();

                        TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Messages.UserAjoutSectOk);
                    }
                    else
                    {
                        TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Messages.DateGreaterThan);
                    }
                }

                return RedirectToAction("UtilisateursSecteur", new { @idSect = model.idSecteur });
            }

            return View(model);
        }


        public ActionResult ModifUtilSecteur(int? idUtil, int? idSecteur)
        {
            if (idSecteur != null && idUtil != null)
            {
                UTILISATEURSECTEUR us = db.UTILISATEURSECTEUR.FirstOrDefault(s => s.IDSECTEUR == idSecteur && s.IDUTILISATEUR == idUtil);

                if (us != null)
                {

                    ModifSecteurUtilDates model = new ModifSecteurUtilDates();
                    model.idUtil = us.IDUTILISATEUR;
                    model.idSecteur = us.IDSECTEUR;
                    model.debutAcces = us.DEBUTACCES;
                    model.finAcces = us.FINACCES;
                    return View(model);
                }
            }

            return RedirectToAction("UtilisateursSecteur", "Admin");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ModifUtilSecteur(ModifSecteurUtilDates model)
        {
            if (ModelState.IsValid)
            {
                UTILISATEURSECTEUR us = db.UTILISATEURSECTEUR.FirstOrDefault(s => s.IDSECTEUR == model.idSecteur && s.IDUTILISATEUR == model.idUtil);

                if (us != null)
                {
                    if (model.debutAcces.CompareTo(model.finAcces) < 0)
                    {
                        us.DEBUTACCES = model.debutAcces;
                        us.FINACCES = model.finAcces;

                        db.SaveChanges();

                        TempData[Constantes.CLE_MSG_RETOUR] =
                                    new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Messages.UserModifOk);
                    }
                    else
                    {
                        ModelState.AddModelError("", Resources.Messages.DateGreaterThan);
                        return View(model);
                    }
                }

                return RedirectToAction("UtilisateursSecteur", "Admin", new { idSect = model.idSecteur });
            }
            return View(model);
        }

        public ActionResult SupprimerUtilSecteur(int? idUtil, int? idSecteur)
        {
            if (idUtil != null && idSecteur != null)
            {
                SECTEUR leS = db.SECTEUR.SingleOrDefault(s => s.ID == idSecteur);

                if (leS != null)
                {
                    var lien = from u in db.UTILISATEURSECTEUR
                               where u.IDSECTEUR == idSecteur && u.IDUTILISATEUR == idUtil
                               select u;

                    if (lien != null)
                    {
                        UTILISATEURSECTEUR util = lien.FirstOrDefault();
                        db.UTILISATEURSECTEUR.Remove(util);

                        db.SaveChanges();
                        return RedirectToAction("UtilisateursSecteur", new { @idSect = idSecteur });
                    }
                }
            }

            return RedirectToAction("GestionSecteurs");
        }

        public ActionResult EcolesSecteur(int? idSect)
        {
            if (idSect != null)
            {
                var leS = from s in db.SECTEUR
                          where s.ID == idSect
                          select s;

                if (leS.FirstOrDefault() == null)
                {
                    TempData[Constantes.CLE_MSG_RETOUR] =
                                new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Messages.SectInexistant);
                }
                else
                {
                    var allEcoles = from e in db.ECOLE
                                    where e.SECTEUR.All(s => s.ID != idSect)
                                    select e;

                    List<ECOLE> lstEcoles = leS.FirstOrDefault().ECOLE.ToList();
                    List<ECOLE> lstAllEcoles = allEcoles.ToList();


                    ViewData[Constantes.CLE_LISTE_ECOLES] = lstEcoles;
                    ViewData[Constantes.CLE_LISTE_ECOLES_ALL] = lstAllEcoles;
                    ViewData[Constantes.CLE_NOMSECTEUR] = leS.FirstOrDefault().NOM + "/" + leS.FirstOrDefault().NOMTRAD;
                    ViewData[Constantes.CLE_IDSECTEUR] = leS.FirstOrDefault().ID;
                }

                return View();
            }

            return RedirectToAction("Index");
        }

        [HttpPost]
        public ActionResult AjoutEcoleSecteur(int? idEcole, int? idSecteur)
        {
            if (!string.IsNullOrEmpty(Request.Form["ajoutEcole"]))
            {
                if (idSecteur != null && idEcole != null)
                {
                    SECTEUR leS = db.SECTEUR.SingleOrDefault(s => s.ID == idSecteur);
                    ECOLE uneEcole = db.ECOLE.SingleOrDefault(e => e.ID == idEcole);
                    leS.ECOLE.Add(uneEcole);

                    db.SaveChanges();

                    TempData[Constantes.CLE_MSG_RETOUR] =
                        new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Messages.EcoleAjoutSectOk);

                    return RedirectToAction("EcolesSecteur", new { @idSect = idSecteur });
                }
            }

            return RedirectToAction("GestionSecteurs");
        }

        public ActionResult SupprimerEcoleSecteur(int? idEcole, int? idSecteur)
        {
            SECTEUR leS = db.SECTEUR.SingleOrDefault(s => s.ID == idSecteur);

            if(leS != null)
            {
                ECOLE uneEcole = db.ECOLE.SingleOrDefault(e => e.ID == idEcole);

                if(uneEcole != null)
                {
                    leS.ECOLE.Remove(uneEcole);

                    db.SaveChanges();
                    return RedirectToAction("EcolesSecteur", new { @idSect = idSecteur });
                }
            }
            
            return RedirectToAction("GestionSecteurs");
        }

        public ActionResult ModifSecteur(int? idSect)
        {
            if (idSect != null)
            {
                SECTEUR secteur = db.SECTEUR.SingleOrDefault(s => s.ID == idSect);

                if (secteur != null)
                {
                    ContentSecteurModel model = new ContentSecteurModel();

                    model.idSect = secteur.ID;
                    model.nom = secteur.NOM;
                    model.nomTrad = secteur.NOMTRAD;
                    model.titre = secteur.TITREACCUEIL;
                    model.titreTrad = secteur.TITREACCUEILTRAD;
                    model.contenu = secteur.TEXTEACCUEIL;
                    model.contenuTrad = secteur.TEXTEACCUEILTRAD;
                    ViewBag.UrlImage = secteur.URLIMAGEACCUEIL;

                    return View(model);
                }
            }

            return RedirectToAction("Index");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ModifSecteur(ContentSecteurModel model)
        {
            if (ModelState.IsValid)
            {
                string desc = model.contenu.Replace("\r\n", Constantes.BR);
                string descTrad = model.contenuTrad.Replace("\r\n", Constantes.BR);
                SECTEUR leSecteur = db.SECTEUR.SingleOrDefault(s => s.ID == model.idSect);
                leSecteur.NOM = model.nom;
                leSecteur.NOMTRAD = model.nomTrad;
                leSecteur.TITREACCUEIL = model.titre;
                leSecteur.TITREACCUEILTRAD = model.titreTrad;
                leSecteur.TEXTEACCUEIL = desc;
                leSecteur.TEXTEACCUEILTRAD = descTrad;

                if (model.File != null)
                {
                    HttpPostedFileBase fichier = model.File;

                    int MaxContentLength = 1024 * 1024 * 2; //2 MB
                    string[] AllowedFileExtensions = new string[] { ".jpg", ".jpeg" };

                    if (!AllowedFileExtensions.Contains(fichier.FileName.Substring(fichier.FileName.LastIndexOf('.'))))
                    {
                        ModelState.AddModelError("", Resources.Messages.FileType + string.Join(", ", AllowedFileExtensions));
                    }
                    else if (fichier.ContentLength > MaxContentLength)
                    {
                        ModelState.AddModelError("", Resources.Messages.FileTooLarge + (MaxContentLength / 1024).ToString() + "MB");
                    }
                    else
                    {
                        var fileName = Path.GetFileName(fichier.FileName);
                        var path = Path.Combine(Server.MapPath("~/Content/images/photos"), fileName);

                        fichier.SaveAs(path);

                        leSecteur.URLIMAGEACCUEIL = fileName;
                    }
                }

                db.SaveChanges();

                TempData[Constantes.CLE_MSG_RETOUR] =
                    new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Messages.SectModifOk);

                return RedirectToAction("GestionSecteurs");
            }

            return View(model);
        }

        public ActionResult AjoutSecteur()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AjoutSecteur(ContentSecteurModel model)
        {
            if (ModelState.IsValid)
            {
                string desc = model.contenu.Replace("\r\n", Constantes.BR);
                string descTrad = model.contenuTrad.Replace("\r\n", Constantes.BR);
                SECTEUR leSecteur = new SECTEUR();
                leSecteur.NOM = model.nom;
                leSecteur.NOMTRAD = model.nomTrad;
                leSecteur.TITREACCUEIL = model.titre;
                leSecteur.TITREACCUEILTRAD = model.titreTrad;
                leSecteur.TEXTEACCUEIL = desc;
                leSecteur.TEXTEACCUEILTRAD = descTrad;

                if (model.File != null)
                {
                    HttpPostedFileBase fichier = model.File;

                    int MaxContentLength = 1024 * 1024 * 2; //2 MB
                    string[] AllowedFileExtensions = new string[] { ".jpg", ".jpeg" };

                    if (!AllowedFileExtensions.Contains(fichier.FileName.Substring(fichier.FileName.LastIndexOf('.'))))
                    {
                        ModelState.AddModelError("", Resources.Messages.FileType + string.Join(", ", AllowedFileExtensions));
                    }
                    else if (fichier.ContentLength > MaxContentLength)
                    {
                        ModelState.AddModelError("", Resources.Messages.FileTooLarge + (MaxContentLength / 1024).ToString() + "MB");
                    }
                    else
                    {
                        //HttpPostedFileBase file = Request.Files.Get(0);

                        //string url = Fichiers.CheminEnvoisImages(fichier.FileName);
                        var fileName = Path.GetFileName(fichier.FileName);
                        var path = Path.Combine(Server.MapPath("~/Content/images/photos"), fileName);

                        fichier.SaveAs(path);

                        leSecteur.URLIMAGEACCUEIL = fileName;
                    }
                }

                db.SECTEUR.Add(leSecteur);
                db.SaveChanges();

                var lesAdmins = from a in db.UTILISATEUR
                                where a.webpages_Roles.All(r => r.RoleName.Equals("admin"))
                                select a;

                if (lesAdmins.FirstOrDefault() != null)
                {
                    int idNewSect = leSecteur.ID;

                    UTILISATEURSECTEUR newU;
                    DateTime debut = DateTime.Now;
                    DateTime fin = DateTime.Now.AddYears(4);
                    foreach (var a in lesAdmins)
                    {
                        newU = new UTILISATEURSECTEUR();
                        newU.IDSECTEUR = idNewSect;
                        newU.IDUTILISATEUR = a.ID;
                        newU.DEBUTACCES = debut;
                        newU.FINACCES = fin;
                        db.UTILISATEURSECTEUR.Add(newU);
                    }

                    db.SaveChanges();
                }
                TempData[Constantes.CLE_MSG_RETOUR] =
                    new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Messages.SectAjoutOk);

                return RedirectToAction("GestionSecteurs");
            }

            return View(model);
        }

        public ActionResult SectionPublique()
        {
            return View();
        }

        public ActionResult ModifPagePublique(string nomPage)
        {
            if (nomPage != null)
            {
                nomPage = nomPage.ToLower();

                GetContenu_Result contentResult = db.GetContenu(nomPage.ToLower()).FirstOrDefault();

                if (contentResult != null)
                {
                    PublicContentModel model = new PublicContentModel();

                    model.nomPage = contentResult.PAGE;
                    model.titre = contentResult.TITRE;
                    model.titreTrad = contentResult.TITRE_TRAD;
                    model.contenu = contentResult.CONTENU;
                    model.contenuTrad = contentResult.CONTENU_TRAD;
                    ViewBag.UrlImage = contentResult.URLIMAGE;

                    return View(model);
                }
            }

            return RedirectToAction("Index");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ModifPagePublique(PublicContentModel model)
        {
            if (ModelState.IsValid)
            {
                if (model.nomPage != null && (model.nomPage.Equals("accueil") || model.nomPage.Equals("about") || model.nomPage.Equals("contact")))
                {
                    if (model.File != null)
                    {
                        HttpPostedFileBase fichier = model.File;

                        int MaxContentLength = 1024 * 1024 * 2; //2 MB
                        string[] AllowedFileExtensions = new string[] { ".jpg", ".jpeg" };

                        if (!AllowedFileExtensions.Contains(fichier.FileName.Substring(fichier.FileName.LastIndexOf('.'))))
                        {
                            ModelState.AddModelError("", Resources.Messages.FileType + string.Join(", ", AllowedFileExtensions));
                        }
                        else if (fichier.ContentLength > MaxContentLength)
                        {
                            ModelState.AddModelError("", Resources.Messages.FileTooLarge + (MaxContentLength / 1024).ToString() + "MB");
                        }
                        else
                        {
                            var fileName = Path.GetFileName(fichier.FileName);
                            var path = Path.Combine(Server.MapPath("~/Content/images/photos"), fileName);

                            fichier.SaveAs(path);

                            db.ModifierContenu(model.nomPage, model.titre, model.titreTrad, model.contenu, model.contenuTrad, fileName);
                        }
                    }
                    else
                    {
                        db.ModifierContenu(model.nomPage, model.titre, model.titreTrad, model.contenu, model.contenuTrad, null);
                    }

                    db.SaveChanges();

                    if (model.nomPage.Equals("about"))
                    {
                        return RedirectToAction("APropos", "Public");
                    }
                    else if (model.nomPage.Equals("contact"))
                    {
                        return RedirectToAction("NousJoindre", "Public");
                    }
                    else
                    {
                        return RedirectToAction("Index", "Public");
                    }
                }
            }
            
            return View(model);
        }

    }
}
