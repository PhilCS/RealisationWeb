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

        public ActionResult Utilisateurs()
        {
            return View();
        }

        public ActionResult rechUtil()
        {
            return View("RechUtilisateur");
        }

        public ActionResult modifierUtil()
        {
            return View("ModifUtilisateur");
        }

        public ActionResult ajoutUtil()
        {
            return View("AjoutUtilisateur");
        }

        public ActionResult Ecoles()
        {
            //ViewData["ecole"] = nomEcole;
            return View();
        }

        public ActionResult ajoutEcole()
        {
            return View("AjoutEcole");
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
                                new Message(Message.TYPE_MESSAGE.SUCCES, "Secteur supprimé");

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
                    return RedirectToAction("GestionSecteur");
                }
            }

            TempData[Constantes.CLE_MSG_RETOUR] =
                                new Message(Message.TYPE_MESSAGE.ERREUR, "Secteur inexistant");
            return RedirectToAction("GestionSecteur");
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
                                new Message(Message.TYPE_MESSAGE.ERREUR, @Resources.Messages.SectInexistant);
                }
                else
                {
                    var lesUtils = from u in db.UTILISATEURSECTEUR
                                   where u.IDSECTEUR == idSect
                                   select u.UTILISATEUR;

                    List<UTILISATEUR> lstUtils = lesUtils.ToList();

                    ViewData[Constantes.CLE_LISTE_UTILISATEURS] = lstUtils;
                    ViewData[Constantes.CLE_NOMSECTEUR] = leS.FirstOrDefault().NOM + "/" + leS.FirstOrDefault().NOMTRAD;                
                }
                
               return View();
            }

            return RedirectToAction("Index");
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
                                new Message(Message.TYPE_MESSAGE.ERREUR, @Resources.Messages.SectInexistant);
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
                }
            }

            return RedirectToAction("EcolesSecteur", new { @idSect = idSecteur });
            
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
                        ModelState.AddModelError("", @Resources.Messages.FileType + string.Join(", ", AllowedFileExtensions));
                    }
                    else if (fichier.ContentLength > MaxContentLength)
                    {
                        ModelState.AddModelError("", @Resources.Messages.FileTooLarge + (MaxContentLength / 1024).ToString() + "MB");
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

                db.SaveChanges();

                TempData[Constantes.CLE_MSG_RETOUR] =
                    new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Messages.SectModifOk);

                return RedirectToAction("GestionSecteurs");
            }

            return View();
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
                        ModelState.AddModelError("", @Resources.Messages.FileType + string.Join(", ", AllowedFileExtensions));
                    }
                    else if (fichier.ContentLength > MaxContentLength)
                    {
                        ModelState.AddModelError("", @Resources.Messages.FileTooLarge + (MaxContentLength / 1024).ToString() + "MB");
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

            return View();
        }

        public ActionResult SectionPublique()
        {
            return View();
        }

        public ActionResult gestionNouvelles(int? gestion)
        {
            if (gestion != null)
            {
                if (gestion == 2)
                {
                    List<GetNouvelles_Result> lstN = db.GetNouvelles().ToList();
                    ViewData[Constantes.CLE_NOUVELLES] = lstN;
                }

                return View("GestionNouvelles");
            }

            return RedirectToAction("SectionPublique");
        }

        [HttpPost]
        public ActionResult ActionNouvelle(int id)
        {
            if (!string.IsNullOrEmpty(Request.Form["modifier"]))
            {
                return RedirectToAction("ModifierNouvelle", "Admin", new { @id = id });
            }
            else if (!string.IsNullOrEmpty(Request.Form["supprimer"]))
            {
                db.SupprimerNouvelle(id);
                TempData[Constantes.CLE_MSG_RETOUR] =
                            new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Messages.nouvelleSupprimee);

                return RedirectToAction("GestionNouvelles", new { gestion = 2 });
            }

            return RedirectToAction("SectionPublique");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ModifierNouvelle(NouvelleModel model)
        {
            if (ModelState.IsValid)
            {
                string desc = model.description.Replace("\r\n", Constantes.BR);
                db.ModifierNouvelle(model.id, model.titre, model.description);
            
                TempData[Constantes.CLE_MSG_RETOUR] =
                    new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Messages.nouvelleModifiee);

                return RedirectToAction("GestionNouvelles", new { gestion = 2 });
            }

            return View(model);
        }

        public ActionResult ModifierNouvelle(int id)
        {
            GetNouvelle_Result n = db.GetNouvelle(id).FirstOrDefault();
            NouvelleModel nouvelle = new NouvelleModel();

            nouvelle.id = n.ID;
            nouvelle.datePublication = n.DATEPUBLICATION;
            nouvelle.titre = n.TITRE;
            nouvelle.description = n.DESCRIPTION.Replace(Constantes.BR, "\r\n");

            return View(nouvelle);
        }

        public ActionResult AjouterNouvelle()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AjouterNouvelle(NouvelleModel model)
        {
            if (ModelState.IsValid)
            {
                string desc = model.description.Replace("\r\n", Constantes.BR);

                db.AjouterNouvelle(model.titre, desc);

                TempData[Constantes.CLE_MSG_RETOUR] =
                    new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Messages.nouvelleAjoutee);

                return View("SectionPublique");
            }

            return View(model);
        
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
                            ModelState.AddModelError("", @Resources.Messages.FileType + string.Join(", ", AllowedFileExtensions));
                        }
                        else if (fichier.ContentLength > MaxContentLength)
                        {
                            ModelState.AddModelError("", @Resources.Messages.FileTooLarge + (MaxContentLength / 1024).ToString() + "MB");
                        }
                        else
                        {
                            //HttpPostedFileBase file = Request.Files.Get(0);

                            //string url = Fichiers.CheminEnvoisImages(fichier.FileName);
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

        public ActionResult ModifAPropos()
        {
            return View("ModifierAPropos");
        }

        public ActionResult modifierNousJoindre()
        {
            return View("ModifierNousJoindre");
        }

        public ActionResult ModifierMsgFil()
        {
            return View();
        }

        public ActionResult Sondages()
        {
            return View();
        }

        public ActionResult AjouterSondage()
        {
            return View();
        }

        public ActionResult AjoutSondageOK()
        {
            return View();
        }

        public ActionResult AjoutSondageErreur()
        {
            return View();
        }

        public ActionResult IndexModifie()
        {
            return View();
        }

        public ActionResult NouveauFil()
        {
            return View();
        }

        public ActionResult SupprimerSondage()
        {
            return View();
        }

    }
}
