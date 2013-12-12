using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projet_mozambique.Models
{
    public class PublicContentModel
    {
        public string nomPage { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "PageTitle", ResourceType = typeof(Names.DisplayName))] 
        public string titre { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "PageTitleTrad", ResourceType = typeof(Names.DisplayName))] 
        public string titreTrad { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "PageContent", ResourceType = typeof(Names.DisplayName))]
        public string contenu { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "PageContentTrad", ResourceType = typeof(Names.DisplayName))]
        public string contenuTrad { get; set; }

        public string fileName { get; set; }

        [Display(Name = "Image", ResourceType = typeof(Names.DisplayName))]
        public HttpPostedFileBase File { get; set; }
        
    }

    public class ContentSecteurModel
    {
        public int idSect { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "SecteurName", ResourceType = typeof(Names.DisplayName))]
        public string nom { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "SecteurTradName", ResourceType = typeof(Names.DisplayName))]
        public string nomTrad { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "PageTitle", ResourceType = typeof(Names.DisplayName))]
        public string titre { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "PageTitleTrad", ResourceType = typeof(Names.DisplayName))]
        public string titreTrad { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "PageContent", ResourceType = typeof(Names.DisplayName))]
        public string contenu { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "PageContentTrad", ResourceType = typeof(Names.DisplayName))]
        public string contenuTrad { get; set; }

        public string fileName { get; set; }

        [Display(Name = "Image", ResourceType = typeof(Names.DisplayName))]
        public HttpPostedFileBase File { get; set; }
    }

}