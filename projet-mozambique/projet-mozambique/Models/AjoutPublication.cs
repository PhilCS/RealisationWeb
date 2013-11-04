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
        [Display(ResourceType = typeof(Resources.Publication), Name = "fichier")]
        [Required(ErrorMessageResourceType = typeof(Resources.Publication), ErrorMessageResourceName = "fichierRequis")]
        public HttpPostedFileBase fichier { get; set; }

        [Display(ResourceType = typeof(Resources.Publication), Name = "motsCles")]
        public string motcles { get; set; }

        private class ValidationPublication
        {
            [Display(ResourceType = typeof(Resources.Publication), Name = "titre")]
            [Required]
            [StringLength(60)]
            public string TITRE { get; set; }

            [Display(ResourceType = typeof(Resources.Publication), Name = "description")]
            [Required]
            [StringLength(100)]
            public string DESCRIPTION { get; set; }

            [Display(ResourceType = typeof(Resources.Publication), Name = "secteur")]
            [Required]
            public int IDSECTEUR { get; set; }

            [Display(ResourceType = typeof(Resources.Publication), Name = "categorie")]
            [Required]
            public int IDSUJET { get; set; }
        }
    }
}
