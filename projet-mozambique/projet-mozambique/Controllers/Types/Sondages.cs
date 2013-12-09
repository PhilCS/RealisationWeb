using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.IO;
using System.Linq;
using System.Net.Mime;
using System.Web;
using System.Web.Mvc;
using WebMatrix.WebData;
using projet_mozambique.Models;
using projet_mozambique.Utilitaires;

namespace projet_mozambique.Controllers
{
    public partial class SectorielController
    {
        [HttpGet]
        public ActionResult ResultatsSondages()
        {
            List<SONDAGE> listeSondages = db.GetSondagesLocalises((int)Session["currentSecteur"], true, 0, Session);

            foreach (var unSondage in listeSondages)
            {
                List<GetVotesSondage_Result> listeVotes = db.GetVotesSondage(unSondage.ID).ToList();
                unSondage.nbVotesTotal = 0;

                foreach (var unChoix in unSondage.CHOIXSONDAGES)
                {
                    unChoix.nbVotes = listeVotes.Count(v => v.IDCHOIX == unChoix.ID);
                    unSondage.nbVotesTotal += unChoix.nbVotes;
                }
            }

            ViewData[Constantes.CLE_SONDAGES] = listeSondages.Where(s => !String.IsNullOrEmpty(s.QUESTION) && s.CHOIXSONDAGES.Count > 0).ToList();

            return View();
        }

        [HttpGet]
        public ActionResult Sondages()
        {
            List<SONDAGE> listeSondages = db.GetSondagesLocalises((int)Session["currentSecteur"], false, WebSecurity.CurrentUserId, Session);
            ViewData[Constantes.CLE_SONDAGES] = listeSondages.Where(s => !String.IsNullOrEmpty(s.QUESTION) && s.CHOIXSONDAGES.Count > 0).ToList();

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Sondages(int? idSondage, int? idChoix)
        {
            List<SONDAGE> listeSondages = db.GetSondagesLocalises((int)Session["currentSecteur"], false, WebSecurity.CurrentUserId, Session);
            var unSondage = listeSondages.Where(s => s.ID == idSondage).ToList();

            if (unSondage.Count() > 0)
            {
                SONDAGE sondageChoisi = unSondage.First();
                var unChoix = sondageChoisi.CHOIXSONDAGE.Where(cs => cs.ID == idChoix);

                if (unChoix.Count() > 0)
                {
                    var choixSelect = unChoix.First();

                    db.AjouterVoteSondage(WebSecurity.CurrentUserId, choixSelect.ID);
                    listeSondages.RemoveAll(s => s.ID == choixSelect.IDSONDAGE);

                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Sondages.voteSucces);
                }
                else
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Sondages.choixInvalide);
                }
            }
            else
            {
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Sondages.sondageInvalide);
            }

            ViewData[Constantes.CLE_SONDAGES] = listeSondages.Where(s => !String.IsNullOrEmpty(s.QUESTION) && s.CHOIXSONDAGES.Count > 0).ToList();

            return View();
        }

        private const string droitsSondage = "admin,professeur,professeurModerateur";

        [HttpGet]
        [AccessDeniedAuthorize(Roles = droitsSondage)]
        public ActionResult AjoutSondage()
        {
            SondageMultilangue sondageMulti = new SondageMultilangue();

            sondageMulti.langue1 = new SONDAGE();
            sondageMulti.langue2 = new SONDAGE();

            var langue = (Session["Culture"] ?? "").ToString().ToUpper();

            if (langue == "FR")
            {
                sondageMulti.langue1.nomLangue = Resources.Shared.choixLangueFR;
                sondageMulti.langue2.nomLangue = Resources.Shared.choixLanguePT;

                sondageMulti.langue1.codeLangue = "FR";
                sondageMulti.langue2.codeLangue = "PT";
            }
            else
            {
                sondageMulti.langue1.nomLangue = Resources.Shared.choixLanguePT;
                sondageMulti.langue2.nomLangue = Resources.Shared.choixLangueFR;

                sondageMulti.langue1.codeLangue = "PT";
                sondageMulti.langue2.codeLangue = "FR";
            }

            sondageMulti.langue1.langueChoisie = true;
            sondageMulti.langue2.langueChoisie = false;

            sondageMulti.langue1.CHOIXSONDAGES = new List<CHOIXSONDAGE>();
            sondageMulti.langue2.CHOIXSONDAGES = new List<CHOIXSONDAGE>();

            List<SelectListItem> listeNombreChoix = Enumerable.Range(2, 9).Select(e => new SelectListItem { Text = e.ToString(), Value = e.ToString() }).ToList();
            ViewData[Constantes.CLE_NOMBRE_CHOIX] = listeNombreChoix;

            sondageMulti.nbChoix = 2;

            for (int i = 0; i < sondageMulti.nbChoix; i++)
            {
                sondageMulti.langue1.CHOIXSONDAGES.Add(new CHOIXSONDAGE { VALEUR = "" });
                sondageMulti.langue2.CHOIXSONDAGES.Add(new CHOIXSONDAGE { VALEUR = "" });
            }

            List<GetSecteurs_Result> listeSecteurs = db.GetSecteursLocalises(Session);
            ViewData[Constantes.CLE_SECTEURS] = listeSecteurs;

            return View(sondageMulti);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [AccessDeniedAuthorize(Roles = droitsSondage)]
        public ActionResult AjoutSondage(SondageMultilangue sondageMulti)
        {
            if (!sondageMulti.langue1.langueChoisie)
            {
                foreach (var key in ModelState.Keys.Where(key => key.StartsWith("langue1.")))
                {
                    ModelState[key].Errors.Clear();
                }
            };

            if (!sondageMulti.langue2.langueChoisie)
            {
                foreach (var key in ModelState.Keys.Where(key => key.StartsWith("langue2.")))
                {
                    ModelState[key].Errors.Clear();
                }
            };

            if (sondageMulti.langue1.CHOIXSONDAGES == null)
                sondageMulti.langue1.CHOIXSONDAGES = new List<CHOIXSONDAGE>();

            if (sondageMulti.langue2.CHOIXSONDAGES == null)
                sondageMulti.langue2.CHOIXSONDAGES = new List<CHOIXSONDAGE>();


            int l1ChoixCount = sondageMulti.langue1.CHOIXSONDAGES.Count;

            if (l1ChoixCount > sondageMulti.nbChoix)
            {
                sondageMulti.langue1.CHOIXSONDAGES.RemoveRange(sondageMulti.nbChoix, l1ChoixCount - sondageMulti.nbChoix);
            }
            else
            {
                for (int i = l1ChoixCount; i < sondageMulti.nbChoix; i++)
                {
                    sondageMulti.langue1.CHOIXSONDAGES.Add(new CHOIXSONDAGE());
                }
            }


            int l2ChoixCount = sondageMulti.langue2.CHOIXSONDAGES.Count;

            if (l2ChoixCount > sondageMulti.nbChoix)
            {
                sondageMulti.langue2.CHOIXSONDAGES.RemoveRange(sondageMulti.nbChoix, l2ChoixCount - sondageMulti.nbChoix);
            }
            else
            {
                for (int i = l2ChoixCount; i < sondageMulti.nbChoix; i++)
                {
                    sondageMulti.langue2.CHOIXSONDAGES.Add(new CHOIXSONDAGE());
                }
            }


            if (!sondageMulti.langue1.langueChoisie && !sondageMulti.langue2.langueChoisie)
            {
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Messages.aucuneLangueErreur);
            }
            else if (ModelState.IsValid && Math.Max(l1ChoixCount, l2ChoixCount) == sondageMulti.nbChoix)
            {
                try
                {
                    SONDAGE sondageFR = null;
                    SONDAGE sondagePT = null;

                    if (sondageMulti.langue1.codeLangue == "FR")
                        sondageFR = sondageMulti.langue1;
                    else if (sondageMulti.langue2.codeLangue == "FR")
                        sondageFR = sondageMulti.langue2;

                    if (sondageMulti.langue1.codeLangue == "PT")
                        sondagePT = sondageMulti.langue1;
                    else if (sondageMulti.langue2.codeLangue == "PT")
                        sondagePT = sondageMulti.langue2;

                    ObjectParameter idNouvSondage = new ObjectParameter("idsondage", typeof(int));
                    db.AjouterSondage(sondageFR.NOM ?? "",
                                      sondagePT.NOM ?? "",
                                      sondageFR.QUESTION ?? "",
                                      sondagePT.QUESTION ?? "",
                                      sondageMulti.DATEDEBUT,
                                      sondageMulti.DATEFIN,
                                      WebSecurity.CurrentUserId,
                                      sondageMulti.IDSECTEUR,
                                      idNouvSondage);

                    sondageMulti.IDSONDAGE = (int)idNouvSondage.Value;

                    for (int i = 0; i < sondageMulti.nbChoix; i++)
                    {
                        db.AjouterChoixSondage(sondageMulti.IDSONDAGE,
                                               sondageFR.CHOIXSONDAGES[i].VALEUR ?? "",
                                               sondagePT.CHOIXSONDAGES[i].VALEUR ?? "");
                    }

                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Sondages.sondageAjoute);

                    return RedirectToAction("Sondages", "Sectoriel");
                }
                catch (Exception ex)
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Sondages.sondageErreur + " (" + ex.GetType() + ")");
                }
            }

            List<SelectListItem> listeNombreChoix = Enumerable.Range(2, 9).Select(e => new SelectListItem { Text = e.ToString(), Value = e.ToString() }).ToList();
            ViewData[Constantes.CLE_NOMBRE_CHOIX] = listeNombreChoix;

            List<GetSecteurs_Result> listeSecteurs = db.GetSecteursLocalises(Session);
            ViewData[Constantes.CLE_SECTEURS] = listeSecteurs;

            return View(sondageMulti);
        }

        [HttpGet]
        [AccessDeniedAuthorize(Roles = droitsSondage)]
        public ActionResult SupprimerSondage(int? id)
        {
            GetSondage_Result sond = null;

            try
            {
                if (id == null)
                    throw new ArgumentNullException("id");

                sond = db.GetSondage(id).First();
            }
            catch
            {
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Sondages.idSondageInvalide);
            }

            if (sond != null)
            {
                return View(sond);
            }

            return RedirectToAction("ResultatsSondages", "Sectoriel");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [AccessDeniedAuthorize(Roles = droitsSondage)]
        public ActionResult SupprimerSondage(int? id, string confirmer, string annuler)
        {
            if (!String.IsNullOrEmpty(confirmer) && String.IsNullOrEmpty(annuler))
            {
                GetSondage_Result sond = null;

                try
                {
                    if (id == null)
                        throw new ArgumentNullException("id");

                    sond = db.GetSondage(id).First();
                }
                catch
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Sondages.idSondageInvalide);
                }

                if (sond != null)
                {
                    db.SupprimerSondage(id);

                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Sondages.sondageSupprime);
                }
            }

            return RedirectToAction("ResultatsSondages", "Sectoriel");
        }
    }
}
