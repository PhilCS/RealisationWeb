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
        [Required]
        [Display(Name = "Contenu", ResourceType = typeof(Names.DisplayName))]
        public string contenu { get; set; }

        [Required]
        [Display(Name = "Sujet", ResourceType = typeof(Names.DisplayName))]
        public string sujet { get; set; }

        [Display(Name = "PiecesJointes", ResourceType = typeof(Names.DisplayName))]
        public List<FileViewModel> piecesJointes { get; set; }

        [Required]
        [Display(Name = "NomsDest", ResourceType = typeof(Names.DisplayName))]
        public string destinataires { get; set; }
    }
}