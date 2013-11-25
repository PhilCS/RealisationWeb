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
    public partial class PublicController
    {
        public ActionResult Partenaires()
        {
            List<PARTENAIRE> listePartenaires = db.GetPartenaires().ToList();
            ViewData[Constantes.CLE_PARTENAIRES] = listePartenaires;

            return View();
        }
    }

    public partial class AdminController
    {
        [HttpGet]
        public ActionResult GestionPartenaires()
        {
            List<PARTENAIRE> listePartenaires = db.GetPartenaires().ToList();
            ViewData[Constantes.CLE_PARTENAIRES] = listePartenaires;

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult GestionPartenaires(int id, string modifier, string supprimer)
        {
            if (!String.IsNullOrEmpty(modifier))
            {
                return RedirectToAction("ModifierPartenaire", new { @id = id });
            }
            else if (!String.IsNullOrEmpty(supprimer))
            {
                return RedirectToAction("SupprimerPartenaire", new { @id = id });
            }

            return RedirectToAction("GestionPartenaires");
        }

        [HttpGet]
        public ActionResult AjoutPartenaire()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AjoutPartenaire([Bind(Exclude = "ID")] PARTENAIRE envoiPart)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    db.AjouterPartenaire(envoiPart.NOM, envoiPart.RAISONSOCIALE, envoiPart.ADRESSE, envoiPart.VILLE, envoiPart.PAYS, envoiPart.TELEPHONE, envoiPart.SITEWEB, envoiPart.COURRIEL);

                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Partenaire.partenaireAjoute);
                    return RedirectToAction("Partenaires", "Public");
                }
                catch (Exception ex)
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Partenaire.partenaireErreur + " (" + ex.GetType() + ")");
                }
            }

            return View(envoiPart);
        }

        [HttpGet]
        public ActionResult ModifierPartenaire(int? id)
        {
            PARTENAIRE part = null;

            try
            {
                if (id == null)
                    throw new ArgumentNullException("id");

                part = db.GetPartenaire(id).First();
            }
            catch
            {
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Partenaire.partenaireInexistant);
                return RedirectToAction("Partenaires", "Public");
            }

            if (part != null)
            {
                return View(part);
            }

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ModifierPartenaire(PARTENAIRE envoiPart)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    db.ModifierPartenaire(envoiPart.ID, envoiPart.NOM, envoiPart.RAISONSOCIALE, envoiPart.ADRESSE, envoiPart.VILLE, envoiPart.PAYS, envoiPart.TELEPHONE, envoiPart.SITEWEB, envoiPart.COURRIEL);

                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Partenaire.partenaireModifie);
                    return RedirectToAction("GestionPartenaires");
                }
                catch (Exception ex)
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Partenaire.partenaireErreur + " (" + ex.GetType() + ")");
                }
            }

            return View(envoiPart);
        }

        [HttpGet]
        public ActionResult SupprimerPartenaire(int? id)
        {
            PARTENAIRE part = null;

            try
            {
                if (id == null)
                    throw new ArgumentNullException("id");

                part = db.GetPartenaire(id).First();
            }
            catch
            {
                TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Partenaire.partenaireInexistant);
            }

            if (part != null)
            {
                return View(part);
            }

            return RedirectToAction("GestionPartenaires");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SupprimerPartenaire(int? id, string confirmer, string annuler)
        {
            if (!String.IsNullOrEmpty(confirmer) && String.IsNullOrEmpty(annuler))
            {
                PARTENAIRE part = null;

                try
                {
                    if (id == null)
                        throw new ArgumentNullException("id");

                    part = db.GetPartenaire(id).First();
                }
                catch
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Partenaire.partenaireInexistant);
                }

                if (part != null)
                {
                    db.SupprimerPartenaire(id);
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.SUCCES, Resources.Partenaire.partenaireSupprime);
                }
            }

            return RedirectToAction("GestionPartenaires");
        }
    }
}
