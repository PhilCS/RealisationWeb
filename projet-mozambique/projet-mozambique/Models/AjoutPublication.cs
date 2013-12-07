using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace projet_mozambique.Models
{
    [MetadataType(typeof(ValidationPublication))]
    public partial class PUBLICATION
    {
        [Display(Name = "File", ResourceType = typeof(Names.DisplayName))]
        [Required(ErrorMessageResourceType = typeof(Resources.Publication), ErrorMessageResourceName = "fichierRequis")]
        public HttpPostedFileBase fichier { get; set; }

        [Display(Name = "Keywords", ResourceType = typeof(Names.DisplayName))]
        public string motcles { get; set; }

        private class ValidationPublication
        {
            [Display(Name = "Title", ResourceType = typeof(Names.DisplayName))]
            [Required]
            [StringLength(60)]
            public string TITRE { get; set; }

            [Display(Name = "Description", ResourceType = typeof(Names.DisplayName))]
            [Required]
            [StringLength(100)]
            public string DESCRIPTION { get; set; }

            [Display(Name = "Sector", ResourceType = typeof(Names.DisplayName))]
            [Required]
            public int IDSECTEUR { get; set; }

            [Display(Name = "Subject", ResourceType = typeof(Names.DisplayName))]
            [Required]
            public int IDSUJET { get; set; }
        }
    }
}
