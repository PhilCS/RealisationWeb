using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using projet_mozambique.Models;

namespace projet_mozambique.Utilitaires
{
    public static class Fichiers
    {
        public static string CheminEnvois(string nomFichier)
        {
            return HttpContext.Current.Server.MapPath(@"..\uploads\" + nomFichier);
        }

        public static string CheminEnvoisImages(string nomFichier)
        {
            return HttpContext.Current.Server.MapPath(@"..\Content\images\photos\" + nomFichier);
        }

        public static string GetNomOriginal(string nomComplet)
        {
            nomComplet = nomComplet.Trim();

            string extension = Path.GetExtension(nomComplet);
            string prefixe = Path.GetFileNameWithoutExtension(nomComplet);
            prefixe = prefixe.Substring(0, Math.Min(prefixe.Length, 10) - extension.Length);

            return prefixe + extension;
        }

        public static string GetNomServeur(string nomComplet)
        {
            nomComplet = nomComplet.Trim();

            string extension = Path.GetExtension(nomComplet);
            string prefixe = Path.GetFileNameWithoutExtension(nomComplet);
            prefixe = prefixe.Substring(0, Math.Min(prefixe.Length, 32) - extension.Length);

            string nomServeur = prefixe + extension;
            string suffixe;

            for (int i = 1; File.Exists(CheminEnvois(nomServeur)); i++)
            {
                suffixe = "_" + i;
                prefixe = prefixe.Substring(0, Math.Min(prefixe.Length, 32) - (extension.Length + suffixe.Length));
                nomServeur = prefixe + suffixe + extension;
            }

            return nomServeur;
        }

    }
}
