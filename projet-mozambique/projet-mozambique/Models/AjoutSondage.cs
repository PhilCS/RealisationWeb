using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace projet_mozambique.Models
{
    [MetadataType(typeof(ValidationSondage))]
    public partial class SONDAGE
    {
        public List<CHOIXSONDAGE> CHOIXSONDAGES { get; set; }
        public bool langueChoisie { get; set; }
        public string codeLangue { get; set; }
        public string nomLangue { get; set; }
        public int nbVotesTotal { get; set; }

        private class ValidationSondage
        {
            [Display(Name = "Name", ResourceType = typeof(Names.DisplayName))]
            [Required]
            [StringLength(60)]
            public string NOM { get; set; }

            [Display(Name = "Question", ResourceType = typeof(Names.DisplayName))]
            [Required]
            [StringLength(255)]
            public string QUESTION { get; set; }
        }
    }

    [MetadataType(typeof(ValidationChoixSondage))]
    public partial class CHOIXSONDAGE
    {
        public int nbVotes { get; set; }

        private class ValidationChoixSondage
        {
            [Display(Name = "Choice", ResourceType = typeof(Names.DisplayName))]
            [Required]
            [StringLength(60)]
            public string VALEUR { get; set; }
        }
    }
}