using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projet_mozambique.Models
{  
    public class LoginModel
    {
        [Required(AllowEmptyStrings=false, ErrorMessageResourceName = "fieldRequired", 
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "UserName", ResourceType = typeof(Resources.DisplayName))]
        public string UserName { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [DataType(DataType.Password)]
        [Display(Name = "Password", ResourceType = typeof(Resources.DisplayName))]
        public string Password { get; set; }

        [Display(Name = "RememberMe", ResourceType = typeof(Resources.DisplayName))]
        public bool RememberMe { get; set; }
    }

    public class ProfileModel
    {
        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "Email", ResourceType = typeof(Resources.DisplayName))]
        [StringLength(100, ErrorMessageResourceName = "fieldStringLength",
            ErrorMessageResourceType = typeof(Resources.Messages), MinimumLength = 6)]
        public string courriel { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "FirstName", ResourceType = typeof(Resources.DisplayName))]
        public string prenom { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "LastName", ResourceType = typeof(Resources.DisplayName))]
        public string nom { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "Adress", ResourceType = typeof(Resources.DisplayName))]
        public string adresse { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "City", ResourceType = typeof(Resources.DisplayName))]
        public string ville { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "Language", ResourceType = typeof(Resources.DisplayName))]
        [StringLength(2)]
        public string langue { get; set; }
    }

    public class PasswordModel
    {
        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [DataType(DataType.Password)]
        [Display(Name = "OldPassword", ResourceType = typeof(Resources.DisplayName))]
        public string OldPassword { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [DataType(DataType.Password)]
        [StringLength(100, ErrorMessageResourceName = "fieldStringLength",
            ErrorMessageResourceType = typeof(Resources.Messages), MinimumLength = 6)]
        [Display(Name = "NewPassword", ResourceType = typeof(Resources.DisplayName))]
        public string NewPassword { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [DataType(DataType.Password)]
        [Compare("NewPassword", ErrorMessageResourceName = "NewPasswordMatch",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "ConfirmPassword", ResourceType = typeof(Resources.DisplayName))]
        public string ConfirmPassword { get; set; }
    }

    public class ResetPassword
    {
        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [Display(Name = "UserName", ResourceType = typeof(Resources.DisplayName))]
        public string UserName { get; set; }
    }

    public class ResetPasswordConfirmModel
    {
        public string Token { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [StringLength(100, ErrorMessageResourceName = "fieldStringLength", 
            ErrorMessageResourceType = typeof(Resources.Messages), MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "NewPassword", ResourceType = typeof(Resources.DisplayName))]
        public string NewPassword { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessageResourceName = "fieldRequired",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        [DataType(DataType.Password)]
        [Display(Name = "ConfirmPassword", ResourceType = typeof(Resources.DisplayName))]
        [Compare("NewPassword", ErrorMessageResourceName = "NewPasswordMatch",
            ErrorMessageResourceType = typeof(Resources.Messages))]
        public string ConfirmPassword { get; set; }
    }
}