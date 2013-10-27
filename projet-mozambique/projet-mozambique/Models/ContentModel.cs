using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projet_mozambique.Models
{
    public class ContentModel
    {
        [Required]
        [Display(Name = "Titre de la page")]
        public string titre { get; set; }

        [Required]
        [Display(Name = "Titre traduit de la page")]
        public string titreTrad { get; set; }

        [Required]
        [Display(Name = "Contenu de la page")]
        public string contenu { get; set; }

        [Required]
        [Display(Name = "Contenu traduit de la page")]
        public string contenuTrad { get; set; }

        [Display(Name = "Url de l'image (facultatif)")]
        public string urlImage { get; set; }
    }
}