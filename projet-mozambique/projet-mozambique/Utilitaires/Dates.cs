using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading;
using System.Web;

namespace projet_mozambique.Utilitaires
{
    public static class Dates
    {
        /// <summary>
        /// Ceci donne le jour, le mois, et l'année formattés correctement pour la langue de l'utilisateur
        /// </summary>
        public static string JourMoisAnnee(DateTime date, HttpSessionStateBase Session)
        {
            CultureInfo culture = Thread.CurrentThread.CurrentCulture;
            Thread.CurrentThread.CurrentCulture = (CultureInfo)Session["Culture"];

            string retour = Regex.Replace(date.ToLongDateString(), date.ToString("dddd") + ",? ", "");

            Thread.CurrentThread.CurrentCulture = culture;
            return retour;
        }
    }
}