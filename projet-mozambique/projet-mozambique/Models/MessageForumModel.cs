using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projet_mozambique.Models
{
    public class MessageForumModel
    {
        [Required(ErrorMessageResourceName = "sujetObligatoire", ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "Sujet", ResourceType = typeof(Names.DisplayName))]
        public string sujet { get; set; }

        [Required(ErrorMessageResourceName = "contenuObligatoire", ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "Contenu", ResourceType = typeof(Names.DisplayName))]
        public string contenu { get; set; }

        public string auteur { get; set; }
        public DateTime datePublication { get; set; }
        public DateTime dateModification { get; set; }
        public int idFil { get; set; }
        public int idMessage { get; set; }
    }
}