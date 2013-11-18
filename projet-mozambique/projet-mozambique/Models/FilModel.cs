using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using projet_mozambique.Utilitaires;

namespace projet_mozambique.Models
{
    public class FilModel
    {
        public int id { get; set; }
        public string sujet { get; set; }
        public ListePaginee<MessageForumModel> listeMessages { get; set; }
        public int nbMessages { get; set; }
        public int nbLectures { get; set; }
        public string dernierParticipant { get; set; }
        public DateTime dateDerniereReponse { get; set; }
    }
}