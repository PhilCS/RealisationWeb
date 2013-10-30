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
        [Required]
        [Display(Name = "UserName", ResourceType = typeof(Names.DisplayName))]
        public string UserName { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Password", ResourceType = typeof(Names.DisplayName))]
        public string Password { get; set; }

        [Display(Name = "RememberMe", ResourceType = typeof(Names.DisplayName))]
        public bool RememberMe { get; set; }
    }

    public class ProfileModel
    {
        [Required]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "Email", ResourceType = typeof(Names.DisplayName))]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        public string courriel { get; set; }

        [Required]
        [Display(Name = "FirstName", ResourceType = typeof(Names.DisplayName))]
        public string prenom { get; set; }

        [Required]
        [Display(Name = "LastName", ResourceType = typeof(Names.DisplayName))]
        public string nom { get; set; }

        [Required]
        [Display(Name = "Adress", ResourceType = typeof(Names.DisplayName))]
        public string adresse { get; set; }

        [Required]
        [Display(Name = "City", ResourceType = typeof(Names.DisplayName))]
        public string ville { get; set; }

        [Required]
        [Display(Name = "Language", ResourceType = typeof(Names.DisplayName))]
        [StringLength(2)]
        public string langue { get; set; }
    }

    public class PasswordModel
    {
        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "OldPassword", ResourceType = typeof(Names.DisplayName))]
        public string OldPassword { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [Display(Name = "NewPassword", ResourceType = typeof(Names.DisplayName))]
        public string NewPassword { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Compare("NewPassword", ErrorMessage = "The new password and confirmation password do not match.")]
        [Display(Name = "ConfirmPassword", ResourceType = typeof(Names.DisplayName))]
        public string ConfirmPassword { get; set; }
    }

    public class ResetPassword
    {
        [Required]
        [Display(Name = "UserName", ResourceType = typeof(Names.DisplayName))]
        public string UserName { get; set; }
    }

    public class ResetPasswordConfirmModel
    {
        public string Token { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "NewPassword", ResourceType = typeof(Names.DisplayName))]
        public string NewPassword { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "ConfirmPassword", ResourceType = typeof(Names.DisplayName))]
        [Compare("NewPassword", ErrorMessage = "The new password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }
    }
}