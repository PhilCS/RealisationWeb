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
using projet_mozambique.ViewModels;

namespace projet_mozambique.Controllers
{
    [Authorize(Roles="admin")]
    public class AdminController : Controller
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

        public ActionResult Secteurs()
        {
            return View("Secteurs");
        }

        public ActionResult SectionPublique()
        {
            return View();
        }

        public ActionResult gestionNouvelles(int? gestion)
        {
            if (gestion == 2)
            {
                List<GetNouvelles_Result> lstN = db.GetNouvelles().ToList();
                ViewData[Constantes.CLE_NOUVELLES] = lstN;
            }

            return View("GestionNouvelles");
        }

        [HttpPost]
        public ActionResult confModifierNouvelle(int id, string titre, string description)
        {
            string desc = description.Replace("\r\n", "<br/>");
            db.ModifierNouvelle(id, titre, desc);

            TempData[Constantes.CLE_MSG_RETOUR] =
                new Message(Message.TYPE_MESSAGE.SUCCES, "La nouvelle a bien été modifiée.");

            return RedirectToAction("GestionNouvelles", new { gestion = 2 });
        }

        [HttpPost]
        public ActionResult modifierNouvelle(int id)
        {
            if (!string.IsNullOrEmpty(Request.Form["modifier"]))
            {
                GetNouvelle_Result n = db.GetNouvelle(id).FirstOrDefault();
                n.DESCRIPTION = n.DESCRIPTION.Replace("<br/>", "\r\n");

                TempData[Constantes.CLE_NOUVELLE] = n;

                return View("GestionNouvelles");
            }
            else if (!string.IsNullOrEmpty(Request.Form["supprimer"]))
            {
                db.SupprimerNouvelle(id);
                TempData[Constantes.CLE_MSG_RETOUR] =
                    new Message(Message.TYPE_MESSAGE.SUCCES, "La nouvelle a bien été supprimée.");

                return RedirectToAction("GestionNouvelles", new { gestion = 2 });
            }
            else
            {
                return View("GestionNouvelles", new { gestion = 2 });
            }

            
        }

        /// <summary>
        /// Action qui ajoute une nouvelle à la base de données
        /// </summary>
        /// <param name="titre">Titre de la nouvelle</param>
        /// <param name="texte">Texte de la nouvelle</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult ajouterNouvelle(string titre, string texte)
        {
            string textFormat;
            Message msg;

            if (!string.IsNullOrEmpty(titre) && !string.IsNullOrEmpty(texte))
            {
                textFormat = texte.Replace("\r\n", "<br/>");

                db.AjouterNouvelle(titre, textFormat);
                msg = new Message(Message.TYPE_MESSAGE.SUCCES, "La nouvelle a bien été ajoutée.");

                TempData[Constantes.CLE_MSG_RETOUR] = msg;
                return View("SectionPublique");
            }
            else
            {
                msg = new Message(Message.TYPE_MESSAGE.ERREUR, "La nouvelle n'a pu être ajoutée.");

                if (string.IsNullOrEmpty(titre))
                {
                    msg.lstErreurs.Add("Le titre ne peut être vide.");
                }
            
                if (string.IsNullOrEmpty(texte))
                {
                    msg.lstErreurs.Add("La description ne peut être vide.");
                }

                TempData[Constantes.CLE_MSG_RETOUR] = msg;
                return RedirectToAction("gestionNouvelles", new { gestion = 1 });
            }

        }

        public ActionResult gestionPartenaires()
        {
            return View("GestionPartenaire");
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
                    model.urlImage = contentResult.URLIMAGE;

                    return View(model);
                }
            }

            return RedirectToAction("Index");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ModifPagePublique(ContentModel model, string nomPage)
        {
            if (ModelState.IsValid)
            {
                if (nomPage != null)
                {
                    try
                    {
                        db.ModifierContenu(nomPage, model.titre, model.titreTrad, model.contenu, model.contenuTrad, model.urlImage);
                        db.SaveChanges();

                        if(nomPage.Equals("about"))
                        {
                            return RedirectToAction("APropos", "Public");
                        }
                        else if (nomPage.Equals("contact"))
                        {
                            return RedirectToAction("NousJoindre", "Public");
                        }
                        else
                        {
                            return RedirectToAction("Index", "Public");
                        }
                    }
                    catch
                    {
                        return RedirectToAction("Index");
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

        public ActionResult ForumModerateur()
        {
            return View();
        }

        public ActionResult FilDiscuModerateur()
        {
            return View();
        }

        public ActionResult ModifierMsgFil()
        {
            return View();
        }

        public ActionResult SupprimerFil()
        {
            return View();
        }

        public ActionResult Sondages()
        {
            return View();
        }

        public ActionResult SupprimerPublication()
        {
            return View();
        }

        public ActionResult Documents(int? secteur, int? categorie, string motcle)
        {
            List<PUBLICATION> listePubs;

            if (secteur == null)
            {
                secteur = 1;
            }

            if (String.IsNullOrEmpty(motcle))
            {
                if (categorie == null)
                {
                    listePubs = db.GetPubParSecteur(secteur).ToList();
                }
                else
                {
                    listePubs = db.GetPubParSujet(secteur, categorie).ToList();
                }
            }
            else
            {
                listePubs = db.GetPubParMotCle(secteur, motcle).ToList();
            }

            List<GetSecteurs_Result> listeSecteurs = db.GetSecteurs().ToList();
            List<GetSujetsPublication_Result> listeSujetsPub = db.GetSujetsPublication().ToList();

            ViewData[Constantes.CLE_SECTEURS] = listeSecteurs;
            ViewData[Constantes.CLE_SUJETSPUBLICATION] = listeSujetsPub;
            ViewData[Constantes.CLE_PUBLICATIONS] = listePubs;

            return View();
        }

        [HttpGet]
        public ActionResult PublicationDocument()
        {
            List<GetSecteurs_Result> listeSecteurs = db.GetSecteurs().ToList();
            List<GetSujetsPublication_Result> listeSujetsPub = db.GetSujetsPublication().ToList();

            TempData[Constantes.CLE_SECTEURS] = listeSecteurs;
            TempData[Constantes.CLE_SUJETSPUBLICATION] = listeSujetsPub;

            return View();
        }

        [HttpPost]
        public ActionResult PublicationDocument(AjoutPublication ajoutPubli)
        {
            List<GetSecteurs_Result> listeSecteurs = db.GetSecteurs().ToList();
            List<GetSujetsPublication_Result> listeSujetsPub = db.GetSujetsPublication().ToList();

            TempData[Constantes.CLE_SECTEURS] = listeSecteurs;
            TempData[Constantes.CLE_SUJETSPUBLICATION] = listeSujetsPub;

            if (ModelState.IsValid)
            {
                HttpPostedFileBase fichier = ajoutPubli.fichier;

                string mimetype = fichier.ContentType;
                string nomOriginal = Fichiers.GetNomOriginal(fichier.FileName);
                string nomServeur = Fichiers.GetNomServeur(fichier.FileName);

                fichier.SaveAs(Fichiers.CheminEnvois(nomServeur));

                ObjectParameter idPub = new ObjectParameter("idpub", typeof(int));
                db.AjouterPublication(ajoutPubli.titre, ajoutPubli.description, ajoutPubli.secteur, ajoutPubli.categorie, nomOriginal, nomServeur, mimetype, 1, idPub);

                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, "La publication a bien été ajoutée");

                return RedirectToAction("Documents");
            }
            else
            {
                return View();
            }
        }

        public ActionResult TelechargerPublication(string nomFichier)
        {
            var cd = new System.Net.Mime.ContentDisposition
            {
                FileName = nomFichier,
                Inline = false,
            };

            Response.AppendHeader("Content-Disposition", cd.ToString());

            return File(System.IO.File.ReadAllBytes(Fichiers.CheminEnvois(nomFichier)), nomFichier);
        }

        public ActionResult AjouterEvenement()
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

        public ActionResult ModifierEvenement()
        {
            return View();
        }

        public ActionResult ModifEvenementOK()
        {
            return View();
        }

        public ActionResult ModifEvenementErreur()
        {
            return View();
        }

        public ActionResult AjoutEvenementOK()
        {
            return View();
        }

        public ActionResult AjoutEvenementErreur()
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

        public ActionResult FilAjouteOK()
        {
            return View();
        }

        public ActionResult FilPasAjoute()
        {
            return View();
        }

        public ActionResult FilModifieOK()
        {
            return View();
        }

        public ActionResult SupprimerSondage()
        {
            return View();
        }

    }
}
