using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projet_mozambique.Models
{
    public class ContentModel
    {
        public string nomPage { get; set; }

        [Required]
        [Display(Name = "PageTitle", ResourceType = typeof(Names.DisplayName))] 
        public string titre { get; set; }

        [Required]
        [Display(Name = "PageTitleTrad", ResourceType = typeof(Names.DisplayName))] 
        public string titreTrad { get; set; }

        [Required]
        [Display(Name = "PageContent", ResourceType = typeof(Names.DisplayName))]
        public string contenu { get; set; }

        [Required]
        [Display(Name = "PageContentTrad", ResourceType = typeof(Names.DisplayName))]
        public string contenuTrad { get; set; }

        [Display(Name = "UrlImage", ResourceType = typeof(Names.DisplayName))]
        public string urlImage { get; set; }
        
    }
}