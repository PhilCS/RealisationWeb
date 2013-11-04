using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projet_mozambique.Models
{
    public class NouvelleModel
    {
        public int id { get; set; }

        [MaxLength(100)]
        [Required(ErrorMessageResourceName = "titreVide", ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "Titre", ResourceType = typeof(Names.DisplayName))]
        public string titre { get; set; }

        [Required(ErrorMessageResourceName = "descriptionVide", ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "Description", ResourceType = typeof(Names.DisplayName))]
        public string description { get; set; }

        public System.DateTime datePublication { get; set; }
    }
}