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

        public ActionResult getSecteur(int id)
        {
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
                    ContentModel model = new ContentModel();

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
        public ActionResult ModifPagePublique(ContentModel model)
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
                            ModelState.AddModelError("", "Please upload Your Photo of type: " + string.Join(", ", AllowedFileExtensions));
                        }
                        else if (fichier.ContentLength > MaxContentLength)
                        {
                            ModelState.AddModelError("", "Your Photo is too large, maximum allowed size is : " + (MaxContentLength / 1024).ToString() + "MB");
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
