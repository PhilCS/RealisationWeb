using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace projet_mozambique.Models
{
    [MetadataType(typeof(ValidationPartenaire))]
    public partial class PARTENAIRE
    {
        private class ValidationPartenaire
        {
            [Key]
            public int? ID { get; set; }

            [Display(ResourceType = typeof(Resources.Partenaire), Name = "nom")]
            [Required]
            [StringLength(60)]
            public string NOM { get; set; }

            [Display(ResourceType = typeof(Resources.Partenaire), Name = "raisonSociale")]
            [Required]
            public string RAISONSOCIALE { get; set; }

            [Display(ResourceType = typeof(Resources.Partenaire), Name = "adresse")]
            [StringLength(65)]
            public string ADRESSE { get; set; }

            [Display(ResourceType = typeof(Resources.Partenaire), Name = "ville")]
            [StringLength(65)]
            public string VILLE { get; set; }

            [Display(ResourceType = typeof(Resources.Partenaire), Name = "pays")]
            [StringLength(60)]
            public string PAYS { get; set; }

            [Display(ResourceType = typeof(Resources.Partenaire), Name = "telephone")]
            [StringLength(20)]
            public string TELEPHONE { get; set; }

            [Display(ResourceType = typeof(Resources.Partenaire), Name = "siteWeb")]
            [StringLength(150)]
            public string SITEWEB { get; set; }

            [Display(ResourceType = typeof(Resources.Partenaire), Name = "courriel")]
            [Required]
            [StringLength(150)]
            public string COURRIEL { get; set; }
        }
    }
}
