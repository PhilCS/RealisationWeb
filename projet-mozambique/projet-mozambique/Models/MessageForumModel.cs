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
        public string contenu { get; set; }
        public string auteur { get; set; }
        public DateTime datePublication { get; set; }
        public DateTime dateModification { get; set; }
    }
}