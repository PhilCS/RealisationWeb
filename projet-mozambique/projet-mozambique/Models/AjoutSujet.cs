using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace projet_mozambique.Models
{
    [MetadataType(typeof(ValidationSujet))]
    public partial class SUJETPUBLICATION
    {
        private class ValidationSujet
        {
            [Key]
            public int? ID { get; set; }

            [Display(Name = "Name", ResourceType = typeof(Names.DisplayName))]
            [StringLength(50)]
            public string NOM { get; set; }

            [StringLength(50)]
            public string NOMTRAD { get; set; }
        }
    }
}
