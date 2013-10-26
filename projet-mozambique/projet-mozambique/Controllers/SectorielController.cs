using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using projet_mozambique.Models;
using projet_mozambique.Utilitaires;

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
            ObtenirMessagesRecus();
            return View();
        }

        /// <summary>
        /// Retourne la vue partielle qui affiche les messages reçus
        /// </summary>
        /// <returns></returns>
        public PartialViewResult BoiteReception()
        {
            ObtenirMessagesRecus();
            return PartialView("ListeMessages");
        }

        /// <summary>
        /// Méthode qui va chercher les messages reçus pour pouvoir les passer à la vue
        /// </summary>
        private void ObtenirMessagesRecus()
        {
            MVPEntities db = new MVPEntities();
            List<GetMessagesPrives_Result> lstMbd = db.GetMessagesPrives(1).ToList();
            List<MessageMessagerie> lstM = new List<MessageMessagerie>();
            List<PIECEJOINTE> lstPJ;
            PIECEJOINTE pj;
            int dernierMess = -1;
            int posDernierMess = -1;

            foreach (GetMessagesPrives_Result m in lstMbd)
            {
                if (m.IDMESSAGE == dernierMess)
                {
                    pj = new PIECEJOINTE();
                    pj.ID = m.IDPIECEJOINTE ?? 0;
                    lstM[posDernierMess].lstPiecesJointes.Add(pj);
                }
                else
                {
                    lstPJ = new List<PIECEJOINTE>();

                    if (m.IDPIECEJOINTE != null)
                    {
                        pj = new PIECEJOINTE();
                        pj.ID = m.IDPIECEJOINTE ?? 0;
                        lstPJ.Add(pj);
                    }

                    lstM.Add(new MessageMessagerie(m.IDMESSAGE, m.SUJET, m.CONTENU, lstPJ, m.LU, m.DATEENVOI));
                    dernierMess = m.IDMESSAGE;
                    posDernierMess++;
                }
            }

            ViewData[Constantes.CLE_LISTE_MSG] = lstM;
        }

        /// <summary>
        /// Retourne la vue partielle qui affiche les messages envoyés
        /// </summary>
        /// <returns></returns>
        public PartialViewResult MessagesEnvoyes()
        {
            MVPEntities db = new MVPEntities();

            List<GetMessagesEnvoyes_Result> lstMbd = db.GetMessagesEnvoyes(1).ToList();
            List<MessageMessagerie> lstM = new List<MessageMessagerie>();
            List<PIECEJOINTE> lstPJ;
            PIECEJOINTE pj;
            int dernierMess = -1;
            int posDernierMess = -1;

            foreach (GetMessagesEnvoyes_Result m in lstMbd)
            {
                if (m.IDMESSAGE == dernierMess)
                {
                    pj = new PIECEJOINTE();
                    pj.ID = m.IDPIECE ?? 0;
                    lstM[posDernierMess].lstPiecesJointes.Add(pj);
                }
                else
                {
                    lstPJ = new List<PIECEJOINTE>();

                    if (m.IDPIECE != null)
                    {
                        pj = new PIECEJOINTE();
                        pj.ID = m.IDPIECE ?? 0;
                        lstPJ.Add(pj);
                    }

                    lstM.Add(new MessageMessagerie(m.IDMESSAGE, m.SUJET, m.CONTENU, lstPJ, true, m.DATEENVOI));
                    dernierMess = m.IDMESSAGE;
                    posDernierMess++;
                }
            }

            ViewData[Constantes.CLE_LISTE_MSG] = lstM;
            
            return PartialView("ListeMessages");
        }

        /// <summary>
        /// Retourne la vue partielle qui affiche les messages supprimés
        /// </summary>
        /// <returns></returns>
        public PartialViewResult Corbeille()
        {
            MVPEntities db = new MVPEntities();

            List<GetMessagesSupprimes_Result> lstMbd = db.GetMessagesSupprimes(1).ToList();
            List<MessageMessagerie> lstM = new List<MessageMessagerie>();
            List<PIECEJOINTE> lstPJ;
            PIECEJOINTE pj;
            int dernierMess = -1;
            int posDernierMess = -1;

            foreach (GetMessagesSupprimes_Result m in lstMbd)
            {
                if (m.IDMESSAGE == dernierMess)
                {
                    pj = new PIECEJOINTE();
                    pj.ID = m.IDPIECE ?? 0;
                    lstM[posDernierMess].lstPiecesJointes.Add(pj);
                }
                else
                {
                    lstPJ = new List<PIECEJOINTE>();

                    if (m.IDPIECE != null)
                    {
                        pj = new PIECEJOINTE();
                        pj.ID = m.IDPIECE ?? 0;
                        lstPJ.Add(pj);
                    }

                    lstM.Add(new MessageMessagerie(m.IDMESSAGE, m.SUJET, m.CONTENU, lstPJ, m.LU ?? false, m.DATEENVOI));
                    dernierMess = m.IDMESSAGE;
                    posDernierMess++;
                }
            }

            ViewData[Constantes.CLE_LISTE_MSG] = lstM;

            return PartialView("ListeMessages");
        }

        public PartialViewResult LectureMessage(int id, bool lu)
        {
            MVPEntities db = new MVPEntities();

            if (!lu)
            {
                db.LireMessage(id, 1);
            }

            List<GetMessage_Result> lstMess = db.GetMessage(id).ToList();
            List<PIECEJOINTE> lstPJ = new List<PIECEJOINTE>();
            PIECEJOINTE pj;

            foreach (GetMessage_Result item in lstMess)
	        {
		        pj = new PIECEJOINTE();
                pj.ID = item.IDPIECE ?? 0;
                pj.NOMPIECE = item.NOMPIECE;
                pj.TAILLEPIECE = item.TAILLEPIECE;

                lstPJ.Add(pj);
	        }

            MessageMessagerie mess = new MessageMessagerie(0, lstMess[0].SUJET, lstMess[0].CONTENU,
                                     lstPJ, true, lstMess[0].DATEENVOI);

            ViewData[Constantes.CLE_MESSAGE] = mess;    

            return PartialView();
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
