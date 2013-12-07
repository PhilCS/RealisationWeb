using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projet_mozambique.Models
{
    [MetadataType(typeof(ValidationNouvelle))]
    public partial class NOUVELLE
    {
        public bool langueChoisie { get; set; }
        public string codeLangue { get; set; }
        public string nomLangue { get; set; }

        private class ValidationNouvelle
        {
            [Required]
            [Display(Name = "Title", ResourceType = typeof(Names.DisplayName))]
            [MaxLength(100)]
            public string TITRE { get; set; }

            [Required]
            [Display(Name = "Description", ResourceType = typeof(Names.DisplayName))]
            public string DESCRIPTION { get; set; }
        }
    }
}