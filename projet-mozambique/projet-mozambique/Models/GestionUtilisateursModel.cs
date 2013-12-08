using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projet_mozambique.Models
{
    public class AjoutUtilSecteurModel
    {
        public int idSecteur { get; set; }
        
        public IEnumerable<System.Web.Mvc.SelectListItem> Utilisateurs { get; set; }

        [Required(ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "UserName", ResourceType = typeof(Names.DisplayName))]
        public int idUtil { get; set; }

        [Required(ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "DebutAcces", ResourceType = typeof(Names.DisplayName))]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime debutAcces { get; set; }

        [Required(ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "FinAcces", ResourceType = typeof(Names.DisplayName))]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime finAcces { get; set; } 
    }
    
    public class AjoutUtilModel
    {
        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
           ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "UserName", ResourceType = typeof(Names.DisplayName))]
        [StringLength(25, ErrorMessageResourceName = "fieldStringLength",
            ErrorMessageResourceType = typeof(Resources.Messages), MinimumLength = 6)]
        public string nomUtil { get; set; }
        
        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
           ErrorMessageResourceType = typeof(Resources.Messages))]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "Email", ResourceType = typeof(Names.DisplayName))]
        [StringLength(100, ErrorMessageResourceName = "fieldStringLength",
            ErrorMessageResourceType = typeof(Resources.Messages), MinimumLength = 6)]
        public string courriel { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "ConfirmEmail", ResourceType = typeof(Names.DisplayName))]
        [Compare("courriel", ErrorMessageResourceName = "EmailMatch",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        public string courrielConfirm { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "FirstName", ResourceType = typeof(Names.DisplayName))]
        public string prenom { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "LastName", ResourceType = typeof(Names.DisplayName))]
        public string nom { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "Address", ResourceType = typeof(Names.DisplayName))]
        public string adresse { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "City", ResourceType = typeof(Names.DisplayName))]
        public string ville { get; set; }

        [Required(ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "UserBDay", ResourceType = typeof(Names.DisplayName))]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public Nullable<DateTime> dateNaissance { get; set; }

        [Required(ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        public bool active { get; set; }

        public IEnumerable<System.Web.Mvc.SelectListItem> Ecoles { get; set; }

        [Required(ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "School", ResourceType = typeof(Names.DisplayName))]
        public int idEcole { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [DataType(DataType.Password)]
        [StringLength(100, ErrorMessageResourceName = "fieldStringLength",
            ErrorMessageResourceType = typeof(Resources.Messages), MinimumLength = 6)]
        [Display(Name = "Password", ResourceType = typeof(Names.DisplayName))]
        public string password { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [DataType(DataType.Password)]
        [Compare("password", ErrorMessageResourceName = "NewPasswordMatch",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "ConfirmPassword", ResourceType = typeof(Names.DisplayName))]
        public string confirmPassword { get; set; }

        public IEnumerable<System.Web.Mvc.SelectListItem> Roles { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "Role", ResourceType = typeof(Names.DisplayName))]
        public string roleName { get; set; }
    }

    public class ModifUtilisateurModel
    {
        [Required(ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        public int idUtil { get; set; }
        
        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
           ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "UserName", ResourceType = typeof(Names.DisplayName))]
        [StringLength(25, ErrorMessageResourceName = "fieldStringLength",
            ErrorMessageResourceType = typeof(Resources.Messages), MinimumLength = 6)]
        public string nomUtil { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
           ErrorMessageResourceType = typeof(Resources.Messages))]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "Email", ResourceType = typeof(Names.DisplayName))]
        [StringLength(100, ErrorMessageResourceName = "fieldStringLength",
            ErrorMessageResourceType = typeof(Resources.Messages), MinimumLength = 6)]
        public string courriel { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "ConfirmEmail", ResourceType = typeof(Names.DisplayName))]
        [Compare("courriel", ErrorMessageResourceName = "EmailMatch",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        public string courrielConfirm { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "FirstName", ResourceType = typeof(Names.DisplayName))]
        public string prenom { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "LastName", ResourceType = typeof(Names.DisplayName))]
        public string nom { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "Address", ResourceType = typeof(Names.DisplayName))]
        public string adresse { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "City", ResourceType = typeof(Names.DisplayName))]
        public string ville { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "UserBDay", ResourceType = typeof(Names.DisplayName))]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public Nullable<DateTime> dateNaissance { get; set; }

        [Required(ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "Etat", ResourceType = typeof(Names.DisplayName))]
        public bool active { get; set; }

        [Display(Name = "LastConnexion", ResourceType = typeof(Names.DisplayName))]
        public DateTime derniereConnexion { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "Language", ResourceType = typeof(Names.DisplayName))]
        [StringLength(2)]
        public string langue { get; set; }

        public IEnumerable<System.Web.Mvc.SelectListItem> Ecoles { get; set; }

        [Required(ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "School", ResourceType = typeof(Names.DisplayName))]
        public int idEcole { get; set; }

        public IEnumerable<System.Web.Mvc.SelectListItem> Roles { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "Role", ResourceType = typeof(Names.DisplayName))]
        public string roleName { get; set; }
    }

    public class ModifSecteurUtilDates
    {
        [Required(ErrorMessageResourceName = "fieldRequired",
           ErrorMessageResourceType = typeof(Resources.Messages))]
        public int idUtil { get; set; }

        [Required(ErrorMessageResourceName = "fieldRequired",
           ErrorMessageResourceType = typeof(Resources.Messages))]
        public int idSecteur { get; set; }

        [Required(ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "DebutAcces", ResourceType = typeof(Names.DisplayName))]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime debutAcces { get; set; }

        [Required(ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "FinAcces", ResourceType = typeof(Names.DisplayName))]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime finAcces { get; set; } 
    }
}