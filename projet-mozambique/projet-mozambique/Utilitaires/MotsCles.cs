using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;

namespace projet_mozambique.Utilitaires
{
    public static class MotsCles
    {
        public static string NettoyerChaine(string s)
        {
            string normalized = s.Normalize(NormalizationForm.FormD);

            StringBuilder resultBuilder = new StringBuilder();
            foreach (var character in normalized)
            {
                UnicodeCategory category = CharUnicodeInfo.GetUnicodeCategory(character);

                if (category == UnicodeCategory.LowercaseLetter ||
                    category == UnicodeCategory.UppercaseLetter ||
                    category == UnicodeCategory.SpaceSeparator)
                {
                    resultBuilder.Append(Char.ToLower(character));
                }
                else
                {
                    resultBuilder.Append(' ');
                }
            }

            // return Regex.Replace(resultBuilder.ToString(), @"\s+", "-");
            return resultBuilder.ToString();
        }

        public static string TraiterMotsCles(List<String> motsCles)
        {
            motsCles.RemoveAll(s => String.IsNullOrEmpty(s));

            for (int i = 0; i < motsCles.Count; i++)
            {
                var motCleTrim = motsCles[i].Trim();
                motsCles[i] = motCleTrim.Substring(0, Math.Min(motCleTrim.Length, 50));
            }

            // Élimination des doublons et nettoyage
            IEnumerable<String> motsClesUniques = motsCles.Distinct();
            string strMotsCles = NettoyerChaine(String.Join(" ", motsClesUniques));

            // Élimination des nouveaux doublons après nettoyage, limitation à 100 mots-clés maximum
            motsClesUniques = strMotsCles.Split(new Char[] { ' ' }).Distinct().Take(100);
            strMotsCles = String.Join(" ", motsClesUniques);

            return strMotsCles;
        }
    }
}