using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace projet_mozambique.ViewModels
{
    public class AjoutPublication
    {
        [Display(Name = "Titre : *")]
        [Required(ErrorMessage = "Le titre est requis")]
        [StringLength(60, ErrorMessage = "Le titre ne peut comporter plus de 60 caractères")]
        public string titre { get; set; }

        [Display(Name = "Description : *")]
        [Required(ErrorMessage = "La description est requise")]
        [StringLength(60, ErrorMessage = "Le titre ne peut comporter plus de 60 caractères")]
        public string description { get; set; }

        [Display(Name = "Fichier : *")]
        [Required(ErrorMessage = "Le fichier est requis")]
        public HttpPostedFileBase fichier { get; set; }

        [Display(Name = "Secteur : *")]
        [Required(ErrorMessage = "Le secteur est requis")]
        public int secteur { get; set; }

        [Display(Name = "Catégorie : *")]
        [Required(ErrorMessage = "La catégorie est requise")]
        public int categorie { get; set; }

        [Display(Name = "Mot clés : *")]
        [Required(ErrorMessage = "Un ou des mot-clé(s) sont requis")]
        public string motcles { get; set; }
    }
}
