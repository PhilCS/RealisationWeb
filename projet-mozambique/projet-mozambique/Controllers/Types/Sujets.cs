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
    public partial class AdminController
    {
        [HttpGet]
        public ActionResult GestionSujets()
        {
            List<GetSujetsPublication_Result> listeSujets = db.GetSujetsPublicationLocalises(Session).ToList();
            ViewData[Constantes.CLE_SUJETSPUBLICATION] = listeSujets;

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult GestionSujets(int id, string modifier, string supprimer)
        {
            if (!String.IsNullOrEmpty(modifier))
            {
                return RedirectToAction("ModifierSujet", new { @id = id });
            }
            else if (!String.IsNullOrEmpty(supprimer))
            {
                return RedirectToAction("SupprimerSujet", new { @id = id });
            }

            return RedirectToAction("GestionSujets", new { @id = id });
        }

        [HttpGet]
        public ActionResult AjoutSujet()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AjoutSujet([Bind(Exclude = "ID")] SUJETPUBLICATION envoiSujet)
        {
            if (String.IsNullOrWhiteSpace(envoiSujet.NOM) && String.IsNullOrWhiteSpace(envoiSujet.NOMTRAD))
            {
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Sujets.aucunNomSpecifie);
            }
            else if (ModelState.IsValid)
            {
                try
                {
                    db.AjouterSujetPub(envoiSujet.NOM ?? "",
                                       envoiSujet.NOMTRAD ?? "");

                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Sujets.sujetAjoute);

                    return RedirectToAction("GestionPublications");
                }
                catch (Exception ex)
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Sujets.sujetErreur + " (" + ex.GetType() + ")");
                }
            }

            return View(envoiSujet);
        }

        [HttpGet]
        public ActionResult ModifierSujet(int? id)
        {
            SUJETPUBLICATION suj = null;

            try
            {
                if (id == null)
                    throw new ArgumentNullException("id");

                suj = db.GetSujetPublication(id).First();
            }
            catch
            {
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Sujets.sujetInexistant);
                return RedirectToAction("GestionSujets");
            }

            if (suj != null)
            {
                return View(suj);
            }

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ModifierSujet(SUJETPUBLICATION envoiSujet)
        {
            if (String.IsNullOrWhiteSpace(envoiSujet.NOM) && String.IsNullOrWhiteSpace(envoiSujet.NOMTRAD))
            {
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Sujets.aucunNomSpecifie);
            }
            else if (ModelState.IsValid)
            {
                try
                {
                    db.ModifierSujetPub(envoiSujet.ID,
                                        envoiSujet.NOM ?? "",
                                        envoiSujet.NOMTRAD ?? "");

                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Sujets.sujetModifie);
                    return RedirectToAction("GestionSujets");
                }
                catch (Exception ex)
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Sujets.sujetErreur + " (" + ex.GetType() + ")");
                }
            }

            return View(envoiSujet);
        }

        [HttpGet]
        public ActionResult SupprimerSujet(int? id)
        {
            SUJETPUBLICATION suj = null;

            try
            {
                if (id == null)
                    throw new ArgumentNullException("id");

                suj = db.GetSujetPublication(id).First();
            }
            catch
            {
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Sujets.idSujetInvalide);
            }

            if (suj != null)
            {
                return View(suj);
            }

            return RedirectToAction("GestionSujets");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SupprimerSujet(int? id, string confirmer, string annuler)
        {
            if (!String.IsNullOrEmpty(confirmer) && String.IsNullOrEmpty(annuler))
            {
                SUJETPUBLICATION suj = null;

                try
                {
                    if (id == null)
                        throw new ArgumentNullException("id");

                    suj = db.GetSujetPublication(id).First();
                }
                catch
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Sujets.idSujetInvalide);
                }

                if (suj != null)
                {
                    db.SupprimerSujetPub(id);

                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Sujets.sujetSupprime);
                }
            }

            return RedirectToAction("GestionSujets");
        }
    }
}
