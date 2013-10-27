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
        [Display(Name = "Nom d'utilisateur")]
        public string UserName { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Mot de passe")]
        public string Password { get; set; }

        [Display(Name = "Mémoriser le mot de passe ?")]
        public bool RememberMe { get; set; }
    }

    public class ProfileModel
    {
        [Required]
        [Display(Name = "Courriel")]
        [DataType(DataType.EmailAddress)]
        public string courriel { get; set; }

        [Required]
        [Display(Name = "Prénom")]
        public string prenom { get; set; }

        [Required]
        [Display(Name = "Nom")]
        public string nom { get; set; }

        [Required]
        [Display(Name = "Adresse")]
        public string adresse { get; set; }

        [Required]
        [Display(Name = "Ville")]
        public string ville { get; set; }
    }

    public class PasswordModel
    {
        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Mot de passe actuel")]
        public string OldPassword { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Nouveau mot de passe")]
        public string NewPassword { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Confirmation du nouveau mot de passe")]
        public string ConfirmPassword { get; set; }
    }

}