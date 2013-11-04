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

        [Display(Name = "File", ResourceType = typeof(Names.DisplayName))]
        public HttpPostedFileBase File { get; set; }
        
    }

    public class ValidateFileAttribute : ValidationAttribute
    {
        public override bool IsValid(object value)
        {
            int MaxContentLength = 1024 * 1024 * 2; //2 MB
            string[] AllowedFileExtensions = new string[] { ".jpg", ".jpeg" };

            var file = value as HttpPostedFileBase;

            if (!AllowedFileExtensions.Contains(file.FileName.Substring(file.FileName.LastIndexOf('.'))))
            {
                ErrorMessage = "Please upload Your Photo of type: " + string.Join(", ", AllowedFileExtensions);
                return false;
            }
            else if (file.ContentLength > MaxContentLength)
            {
                ErrorMessage = "Your Photo is too large, maximum allowed size is : " + (MaxContentLength / 1024).ToString() + "MB";
                return false;
            }
            else
                return true;
        }
    }
}