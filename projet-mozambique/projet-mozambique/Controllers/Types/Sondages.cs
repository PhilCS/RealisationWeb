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

            ViewData[Constantes.CLE_SONDAGES] = listeSondages;

            return View();
        }

        [HttpGet]
        public ActionResult Sondages()
        {
            List<SONDAGE> listeSondages = db.GetSondagesLocalises((int)Session["currentSecteur"], false, WebSecurity.CurrentUserId, Session);
            ViewData[Constantes.CLE_SONDAGES] = listeSondages;

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

            ViewData[Constantes.CLE_SONDAGES] = listeSondages;

            return View();
        }
    }

    public partial class AdminController
    {
        public ActionResult AjoutSondage()
        {
            SondageMultilangue sondageMulti = new SondageMultilangue();

            sondageMulti.langue1 = new SONDAGE();
            sondageMulti.langue2 = new SONDAGE();

            var langue = Session["Culture"] ?? "";

            if (langue.ToString().ToUpper() == "FR")
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

            for (int i = 0; i < 2; i++)
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

            int nbChoix = Math.Max(sondageMulti.langue1.CHOIXSONDAGES.Count(),
                                   sondageMulti.langue2.CHOIXSONDAGES.Count());

            for (int i = sondageMulti.langue1.CHOIXSONDAGES.Count(); i < nbChoix; i++)
            {
                sondageMulti.langue1.CHOIXSONDAGES.Add(new CHOIXSONDAGE());
            }

            for (int i = sondageMulti.langue2.CHOIXSONDAGES.Count(); i < nbChoix; i++)
            {
                sondageMulti.langue2.CHOIXSONDAGES.Add(new CHOIXSONDAGE());
            }

            if (!sondageMulti.langue1.langueChoisie && !sondageMulti.langue2.langueChoisie)
            {
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Sondages.aucuneLangueErreur);
            }
            else if (ModelState.IsValid)
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

                    for (int i = 0; i < nbChoix; i++)
                    {
                        db.AjouterChoixSondage(sondageMulti.IDSONDAGE,
                                               sondageFR.CHOIXSONDAGES[i].VALEUR ?? "",
                                               sondagePT.CHOIXSONDAGES[i].VALEUR ?? "");
                    }

                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Sondages.sondageAjoute);

                    //return RedirectToAction("Sondages", "Sectoriel");
                }
                catch (Exception ex)
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Sondages.sondageErreur + " (" + ex.GetType() + ")");
                }
            }

            List<GetSecteurs_Result> listeSecteurs = db.GetSecteursLocalises(Session);
            ViewData[Constantes.CLE_SECTEURS] = listeSecteurs;

            return View(sondageMulti);
        }        
    }
}
