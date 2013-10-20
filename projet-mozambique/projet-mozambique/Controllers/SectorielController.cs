﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace projet_mozambique.Controllers
{
    public class SectorielController : Controller
    {
        //
        // GET: /Sectoriel/
        public ActionResult Index()
        {
            // Si l'utilisateur n'a pas accès à cette section
            // Faut trouver comment empêcher un utilisateur non connecté d'accéder à 
            // tout le controller
            if (Session["currentUserId"] == null)
            {
                return Redirect("/public");
            }
            else
            {
                return View();
            }
        }

        public ActionResult Messagerie()
        {
            return View();
        }

        public ActionResult MessagesEnvoyes()
        {
            return View();
        }

        public ActionResult Corbeille()
        {
            return View();
        }

        public ActionResult NouveauMessage()
        {
            return View();
        }

        public ActionResult MessageEnvoyeOK()
        {
            return View();
        }

        public ActionResult MessagePasEnvoye()
        {
            return View();
        }

        public ActionResult Documents()
        {
            return View();
        }

        public ActionResult Profil()
        {
            return View();
        }

        public ActionResult ModifierInfos()
        {
            return View();
        }

        public ActionResult ModifierInfosOK()
        {
            return View();
        }

        public ActionResult ModifierInfosErreur()
        {
            return View();
        }

        public ActionResult ModifierMDP()
        {
            return View();
        }

        public ActionResult ModifierMotPasseOK()
        {
            return View();
        }

        public ActionResult ModifierMotPasseErreur()
        {
            return View();
        }

        public ActionResult ModifierPreferences()
        {
            return View();
        }

        public ActionResult Forum()
        {
            return View();
        }

        public ActionResult NouveauFil()
        {
            return View();
        }

        public ActionResult FilPasAjoute()
        {
            return View();
        }

        public ActionResult FilAjouteOK()
        {
            return View();
        }

        public ActionResult FilDiscu()
        {
            return View();
        }

        public ActionResult RepondreFilDiscu()
        {
            return View();
        }

        public ActionResult MessageFilAjouteOK()
        {
            return View();
        }

        public ActionResult MessageFilPasAjoute()
        {
            return View();
        }

        public ActionResult Sondages()
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

        public ActionResult ResultRechDoc()
        {
            return View();
        }

        public ActionResult SupprimerMessage()
        {
            return View();
        }

        public ActionResult RepondreMessage()
        {
            return View();
        }

    }
}
