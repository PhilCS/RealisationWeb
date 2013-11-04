using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projet_mozambique.Models
{
    public class MessageModel
    {
        [Required(ErrorMessageResourceName="contenuObligatoire", ErrorMessageResourceType=typeof(Resources.Messages))]
        [Display(Name = "Contenu", ResourceType = typeof(Resources.DisplayName))]
        public string contenu { get; set; }

        [Required(ErrorMessageResourceName = "sujetObligatoire", ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "Sujet", ResourceType = typeof(Resources.DisplayName))]
        public string sujet { get; set; }

        [Display(Name = "PiecesJointes", ResourceType = typeof(Resources.DisplayName))]
        public HttpPostedFileBase piecesJointes { get; set; }

        [Required(ErrorMessageResourceName = "destObligatoire", ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "NomsDest", ResourceType = typeof(Resources.DisplayName))]
        public string destinataires { get; set; }
    }
}