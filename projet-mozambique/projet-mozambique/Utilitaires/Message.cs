using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace projet_mozambique.Utilitaires
{
    public class Message
    {

        public enum TYPE_MESSAGE
        { 
            ERREUR = 2,
            SUCCES = 1
        }

        public TYPE_MESSAGE typeMessage;
        public string message;
        public List<String> lstErreurs;

        public Message(TYPE_MESSAGE type, string msg)
        {
            typeMessage = type;
            message = msg;
            lstErreurs = new List<string>();
        }

        public override string ToString()
        {
            return message;
        }

        public static string BrToNewline(string message)
        {
            return Regex.Replace(message, @"<br\s*/?>", "\r\n");
        }

        public static string NewlineToBr(string message)
        {
            return Regex.Replace(message, "\r?\n|\r", "<br/>");
        }
    }
}