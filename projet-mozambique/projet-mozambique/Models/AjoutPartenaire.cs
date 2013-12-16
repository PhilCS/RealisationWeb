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

            [Display(Name = "Name", ResourceType = typeof(Names.DisplayName))]
            [Required]
            [StringLength(60)]
            public string NOM { get; set; }

            [Display(Name = "Mission", ResourceType = typeof(Names.DisplayName))]
            [Required]
            public string RAISONSOCIALE { get; set; }

            [Display(Name = "Address", ResourceType = typeof(Names.DisplayName))]
            [StringLength(65)]
            [Required]
            public string ADRESSE { get; set; }

            [Display(Name = "City", ResourceType = typeof(Names.DisplayName))]
            [StringLength(65)]
            [Required]
            public string VILLE { get; set; }

            [Display(Name = "Country", ResourceType = typeof(Names.DisplayName))]
            [StringLength(60)]
            [Required]
            public string PAYS { get; set; }

            [Display(Name = "Phone", ResourceType = typeof(Names.DisplayName))]
            [StringLength(20)]
            [Required]
            public string TELEPHONE { get; set; }

            [Display(Name = "Website", ResourceType = typeof(Names.DisplayName))]
            [StringLength(150)]
            [Required]
            public string SITEWEB { get; set; }

            [Display(Name = "Email", ResourceType = typeof(Names.DisplayName))]
            [Required]
            [StringLength(150)]
            public string COURRIEL { get; set; }
        }
    }
}
