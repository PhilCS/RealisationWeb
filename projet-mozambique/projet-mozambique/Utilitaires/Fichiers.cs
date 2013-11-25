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
            prefixe = prefixe.Substring(0, Math.Min(prefixe.Length, 100 - extension.Length));

            return prefixe + extension;
        }

        public static string GetNomServeur(string nomComplet)
        {
            nomComplet = nomComplet.Trim();

            string extension = Path.GetExtension(nomComplet);
            string prefixe = Path.GetFileNameWithoutExtension(nomComplet);
            prefixe = prefixe.Substring(0, Math.Min(prefixe.Length, 32 - extension.Length));

            string nomServeur = prefixe + extension;
            string suffixe;

            for (int i = 1; File.Exists(CheminEnvois(nomServeur)); i++)
            {
                suffixe = "_" + i;
                prefixe = prefixe.Substring(0, Math.Min(prefixe.Length, 32 - (suffixe.Length + extension.Length)));
                nomServeur = prefixe + suffixe + extension;
            }

            return nomServeur;
        }

        public static string GetFichierIcone(string nomOriginal, string mimetype)
        {
            nomOriginal = nomOriginal.ToLower();
            string extension = Path.GetExtension(nomOriginal).ToLower();
            string type;

            if (mimetype.StartsWith("application/vnd.openxmlformats-officedocument.wordprocessingml") || 
                mimetype == "application/msword")
            {
                type = "word";
            }
            else if (mimetype.StartsWith("application/vnd.openxmlformats-officedocument.spreadsheetml") ||
                     mimetype == "application/vnd.ms-excel" ||
                     mimetype == "application/x-excel" || 
                     mimetype == "application/excel")
            {
                type = "excel";
            }
            else if (mimetype.StartsWith("application/vnd.openxmlformats-officedocument.presentationml") ||
                     mimetype == "application/vnd.ms-powerpoint" ||
                     mimetype == "application/x-mspowerpoint" || 
                     mimetype == "application/mspowerpoint")
            {
                type = "powerpoint";
            }
            else if (mimetype == "application/octet-stream" && (extension == ".zip" || extension == ".rar" || extension == ".7z") ||
                     mimetype == "application/zip" || 
                     mimetype == "application/x-rar-compressed" || 
                     mimetype == "application/x-7z-compressed")
            {
                type = "archive";
            }
            else if (mimetype == "application/pdf")
            {
                type = "pdf";
            }
            else if (mimetype.StartsWith("text/") || mimetype == "application/xml")
            {
                type = "text";
            }
            else
            {
                type = "generic";
            }

            return type;
        }
    }
}
