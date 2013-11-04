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
            List<GetPartenaires_Result> listePartenaires = db.GetPartenaires().ToList();
            ViewData[Constantes.CLE_PARTENAIRES] = listePartenaires;

            return View();
        }
    }

    public partial class AdminController
    {
        [HttpGet]
        public ActionResult GestionPartenaire(int? id)
        {
            if (id != null)
            {
                List<PARTENAIRE> listePart = db.GetPartenaire(id).ToList();

                if (listePart.Count > 0)
                {
                    return View(listePart.FirstOrDefault());
                }
                else
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Partenaire.partenaireInexistant);
                    return RedirectToAction("Partenaires", "Public");
                }
            }
            
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AjouterPartenaire([Bind(Exclude = "ID")] PARTENAIRE envoiPart)
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

            return View("GestionPartenaire", envoiPart);
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
                    return RedirectToAction("Partenaires", "Public");
                }
                catch (Exception ex)
                {
                    TempData[Constantes.CLE_MSG_RETOUR] = new Message(Message.TYPE_MESSAGE.ERREUR, Resources.Partenaire.partenaireErreur + " (" + ex.GetType() + ")");
                }
            }

            return View("GestionPartenaire", envoiPart);
        }
    }
}
