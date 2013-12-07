using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace projet_mozambique.Models
{
    public class NouvelleMultilangue
    {
        [Key]
        public int IDNOUVELLE { get; set; }

        [Required]
        public NOUVELLE langue1 { get; set; }
        public NOUVELLE langue2 { get; set; }
    }
}