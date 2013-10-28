using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace projet_mozambique.Models
{
    public class MessageMessagerie
    {
        public int id;
        public string sujet;
        public string message;
        public List<PIECEJOINTE> lstPiecesJointes;
        public bool lu;
        public DateTime dateEnvoi;
        public List<string> lstDestinataires;

        public MessageMessagerie(int id, string sujet, string message, List<PIECEJOINTE> lstPiecesJointes, bool lu, DateTime dateEnvoi)
        {
            this.id = id;
            this.sujet = sujet;
            this.message = message;
            this.lstPiecesJointes = lstPiecesJointes;
            this.lu = lu;
            this.dateEnvoi = dateEnvoi;
        }
    }
}