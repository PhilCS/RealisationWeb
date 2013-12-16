using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Objects;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Postal;
using projet_mozambique.Models;
using projet_mozambique.Utilitaires;
using WebMatrix.Data;
using WebMatrix.WebData;

namespace projet_mozambique.Controllers
{
    public partial class PublicController
    {
        public ActionResult nouvelles(int? page)
        {
            Entities db = new Entities();
            const int nbParPage = 5;

            List<NOUVELLE> lstN = db.GetNouvellesLocalisees(Session).ToList();
            ListePaginee<NOUVELLE> nouvPaginees =
                new ListePaginee<NOUVELLE>(lstN, page ?? 0, nbParPage);

            ViewData[Constantes.CLE_NOUVELLES] = nouvPaginees;

            return View("Nouvelles");
        }

        public ActionResult getNouvelle(int? id)
        {
            if (id != null)
            {
                NOUVELLE n = db.GetNouvelleLocalisee(id, Session).FirstOrDefault();

                if (n != null)
                {
                    ViewData[Constantes.CLE_NOUVELLE] = n;

                    return View("Nouvelle");
                }
            }

            return RedirectToAction("Nouvelles");
        }

        public ActionResult getResultats(string type, string recherche)
        {
            List<GetRechercheNouvelle_Result> lstR = db.GetRechercheNouvelle(recherche.Trim()).ToList();

            ViewData[Constantes.CLE_RESUL_RECH] = lstR;
            ViewData[Constantes.CLE_TYPE_RECHERCHE] = type;
            ViewData[Constantes.CLE_RECHERCHE] = type;

            return View("PageResultat");
        }
    }

    public partial class AdminController
    {
        public ActionResult GestionNouvelles(int? gestion)
        {
            if (gestion != null)
            {
                if (gestion == 2)
                {
                    List<NOUVELLE> lstN = db.GetNouvellesLocalisees(Session).ToList();
                    ViewData[Constantes.CLE_NOUVELLES] = lstN;
                }

                return View();
            }

            return RedirectToAction("SectionPublique");
        }

        [HttpPost]
        public ActionResult ActionNouvelle(int id, string modifier, string supprimer)
        {
            if (!String.IsNullOrEmpty(modifier))
            {
                return RedirectToAction("ModifierNouvelle", "Admin", new { @id = id });
            }
            else if (!String.IsNullOrEmpty(supprimer))
            {
                //db.SupprimerNouvelle(id);
                //TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Nouvelles.nouvelleSupprimee);

                return RedirectToAction("SupprimerNouvelle", new { @id = id });
            }

            return RedirectToAction("SectionPublique");
        }

        [HttpGet]
        public ActionResult AjouterNouvelle()
        {
            NouvelleMultilangue nouvelleMulti = new NouvelleMultilangue();

            nouvelleMulti.langue1 = new NOUVELLE();
            nouvelleMulti.langue2 = new NOUVELLE();

            var langue = (Session["Culture"] ?? "").ToString().ToUpper();

            if (langue == "FR")
            {
                nouvelleMulti.langue1.nomLangue = Resources.Shared.choixLangueFR;
                nouvelleMulti.langue2.nomLangue = Resources.Shared.choixLanguePT;

                nouvelleMulti.langue1.codeLangue = "FR";
                nouvelleMulti.langue2.codeLangue = "PT";
            }
            else
            {
                nouvelleMulti.langue1.nomLangue = Resources.Shared.choixLanguePT;
                nouvelleMulti.langue2.nomLangue = Resources.Shared.choixLangueFR;

                nouvelleMulti.langue1.codeLangue = "PT";
                nouvelleMulti.langue2.codeLangue = "FR";
            }

            nouvelleMulti.langue1.langueChoisie = true;
            nouvelleMulti.langue2.langueChoisie = false;

            return View(nouvelleMulti);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AjouterNouvelle([Bind(Exclude = "ID")] NouvelleMultilangue nouvelleMulti)
        {
            if (!nouvelleMulti.langue1.langueChoisie)
            {
                foreach (var key in ModelState.Keys.Where(key => key.StartsWith("langue1.")))
                {
                    ModelState[key].Errors.Clear();
                }
            };

            if (!nouvelleMulti.langue2.langueChoisie)
            {
                foreach (var key in ModelState.Keys.Where(key => key.StartsWith("langue2.")))
                {
                    ModelState[key].Errors.Clear();
                }
            };

            if (!nouvelleMulti.langue1.langueChoisie && !nouvelleMulti.langue2.langueChoisie)
            {
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Messages.aucuneLangueErreur);
            }
            else if (ModelState.IsValid)
            {
                NOUVELLE nouvelleFR = null;
                NOUVELLE nouvellePT = null;

                if (nouvelleMulti.langue1.codeLangue == "FR")
                    nouvelleFR = nouvelleMulti.langue1;
                else if (nouvelleMulti.langue2.codeLangue == "FR")
                    nouvelleFR = nouvelleMulti.langue2;

                if (nouvelleMulti.langue1.codeLangue == "PT")
                    nouvellePT = nouvelleMulti.langue1;
                else if (nouvelleMulti.langue2.codeLangue == "PT")
                    nouvellePT = nouvelleMulti.langue2;

                db.AjouterNouvelle(nouvelleFR.TITRE ?? "",
                                   nouvellePT.TITRE ?? "",
                                   Message.NewlineToBr(nouvelleFR.DESCRIPTION ?? ""),
                                   Message.NewlineToBr(nouvellePT.DESCRIPTION ?? ""));

                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Nouvelles.nouvelleAjoutee);

                return View("SectionPublique");
            }

            return View(nouvelleMulti);
        }

        [HttpGet]
        public ActionResult ModifierNouvelle(int? id)
        {
            NouvelleMultilangue nouvelleMulti = null;

            try
            {
                if (id == null)
                    throw new ArgumentNullException("id");

                NOUVELLE nouv = db.GetNouvelleLocalisee(id, Session).First();

                nouvelleMulti = new NouvelleMultilangue();

                nouvelleMulti.IDNOUVELLE = nouv.ID;

                nouvelleMulti.langue1 = new NOUVELLE();
                nouvelleMulti.langue2 = new NOUVELLE();

                var langue = (Session["Culture"] ?? "").ToString().ToUpper();

                if (langue == "FR")
                {
                    nouvelleMulti.langue1.nomLangue = Resources.Shared.choixLangueFR;
                    nouvelleMulti.langue2.nomLangue = Resources.Shared.choixLanguePT;

                    nouvelleMulti.langue1.codeLangue = "FR";
                    nouvelleMulti.langue2.codeLangue = "PT";

                    nouvelleMulti.langue1.TITRE = nouv.TITRE ?? "";
                    nouvelleMulti.langue2.TITRE = nouv.TITRETRAD ?? "";

                    nouvelleMulti.langue1.DESCRIPTION = Message.BrToNewline(nouv.DESCRIPTION ?? "");
                    nouvelleMulti.langue2.DESCRIPTION = Message.BrToNewline(nouv.DESCRIPTIONTRAD ?? "");
                }
                else
                {
                    nouvelleMulti.langue1.nomLangue = Resources.Shared.choixLanguePT;
                    nouvelleMulti.langue2.nomLangue = Resources.Shared.choixLangueFR;

                    nouvelleMulti.langue1.codeLangue = "PT";
                    nouvelleMulti.langue2.codeLangue = "FR";

                    nouvelleMulti.langue1.TITRE = nouv.TITRETRAD ?? "";
                    nouvelleMulti.langue2.TITRE = nouv.TITRE ?? "";

                    nouvelleMulti.langue1.DESCRIPTION = Message.BrToNewline(nouv.DESCRIPTIONTRAD ?? "");
                    nouvelleMulti.langue2.DESCRIPTION = Message.BrToNewline(nouv.DESCRIPTION ?? "");
                }

                nouvelleMulti.langue1.langueChoisie = !String.IsNullOrEmpty(nouv.TITRE);
                nouvelleMulti.langue2.langueChoisie = !String.IsNullOrEmpty(nouv.TITRETRAD);
            }
            catch
            {
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Nouvelles.nouvelleInexistante);
                return RedirectToAction("GestionPartenaires");
            }

            if (nouvelleMulti != null)
            {
                return View(nouvelleMulti);
            }

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ModifierNouvelle(NouvelleMultilangue nouvelleMulti)
        {
            if (!nouvelleMulti.langue1.langueChoisie)
            {
                foreach (var key in ModelState.Keys.Where(key => key.StartsWith("langue1.")))
                {
                    ModelState[key].Errors.Clear();
                }
            };

            if (!nouvelleMulti.langue2.langueChoisie)
            {
                foreach (var key in ModelState.Keys.Where(key => key.StartsWith("langue2.")))
                {
                    ModelState[key].Errors.Clear();
                }
            };

            if (!nouvelleMulti.langue1.langueChoisie && !nouvelleMulti.langue2.langueChoisie)
            {
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Messages.aucuneLangueErreur);
            }
            else if (ModelState.IsValid)
            {
                NOUVELLE nouvelleFR = null;
                NOUVELLE nouvellePT = null;

                if (nouvelleMulti.langue1.codeLangue == "FR")
                    nouvelleFR = nouvelleMulti.langue1;
                else if (nouvelleMulti.langue2.codeLangue == "FR")
                    nouvelleFR = nouvelleMulti.langue2;

                if (nouvelleMulti.langue1.codeLangue == "PT")
                    nouvellePT = nouvelleMulti.langue1;
                else if (nouvelleMulti.langue2.codeLangue == "PT")
                    nouvellePT = nouvelleMulti.langue2;

                db.ModifierNouvelle(nouvelleMulti.IDNOUVELLE,
                                    nouvelleFR.TITRE ?? "",
                                    nouvellePT.TITRE ?? "",
                                    Message.NewlineToBr(nouvelleFR.DESCRIPTION ?? ""),
                                    Message.NewlineToBr(nouvellePT.DESCRIPTION ?? ""));

                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Nouvelles.nouvelleModifiee);

                return RedirectToAction("GestionNouvelles", new { gestion = 2 });
            }

            return View(nouvelleMulti);
        }

        [HttpGet]
        public ActionResult SupprimerNouvelle(int? id)
        {
            NOUVELLE nouv = null;

            try
            {
                if (id == null)
                    throw new ArgumentNullException("id");

                nouv = db.GetNouvelleLocalisee(id, Session).First();
            }
            catch
            {
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Nouvelles.nouvelleInexistante);
            }

            if (nouv != null)
            {
                return View(nouv);
            }

            return RedirectToAction("GestionNouvelles", new { gestion = 2 });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SupprimerNouvelle(int? id, string confirmer, string annuler)
        {
            if (!String.IsNullOrEmpty(confirmer) && String.IsNullOrEmpty(annuler))
            {
                NOUVELLE nouv = null;

                try
                {
                    if (id == null)
                        throw new ArgumentNullException("id");

                    nouv = db.GetNouvelleLocalisee(id, Session).First();
                }
                catch
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Nouvelles.nouvelleInexistante);
                }

                if (nouv != null)
                {
                    db.SupprimerNouvelle(id);
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Nouvelles.nouvelleSupprimee);
                }
            }

            return RedirectToAction("GestionNouvelles", new { gestion = 2 });
        }

    }
}