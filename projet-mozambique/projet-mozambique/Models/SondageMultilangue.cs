using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace projet_mozambique.Models
{
    public class SondageMultilangue
    {
        public int IDSONDAGE { get; set; }

        [Display(Name = "Sector", ResourceType = typeof(Names.DisplayName))]
        [Required]
        public int IDSECTEUR { get; set; }

        [Required]
        public SONDAGE langue1 { get; set; }
        public SONDAGE langue2 { get; set; }

        [Display(Name = "StartDate", ResourceType = typeof(Names.DisplayName))]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:yyyy/MM/dd}")]
        [Required]
        [DateAttribute]
        [DateRangeAttribute]
        public DateTime? DATEDEBUT { get; set; }

        [Display(Name = "EndDate", ResourceType = typeof(Names.DisplayName))]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:yyyy/MM/dd}")]
        [Required]
        [DateAttribute]
        [DateRangeAttribute]
        [DateGreaterThanAttribute("DATEDEBUT")]
        public DateTime? DATEFIN { get; set; }
    }

    // Vérification si date valide
    [AttributeUsage(AttributeTargets.Property)]
    class DateAttribute : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            try
            {
                var dateString = value.ToString();
                DateTime result;
                var success = DateTime.TryParse(dateString, out result);

                if (success)
                    return ValidationResult.Success;
                else
                    return new ValidationResult(Resources.Sondages.dateInvalide);
            }
            catch
            {
                return new ValidationResult(Resources.Sondages.dateInvalide);
            }
        }
    }

    // Vérification si date >= aujourd'hui
    [AttributeUsage(AttributeTargets.Property)]
    class DateRangeAttribute : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            var dt = value as DateTime?;
            var success = dt == null || dt.Value.Date >= DateTime.Today;

            if (success)
                return ValidationResult.Success;
            else
                return new ValidationResult(Resources.Sondages.datePassee);
        }
    }

    // Vérification si date de fin > date de début
    [AttributeUsage(AttributeTargets.Property, Inherited = true)]
    public class DateGreaterThanAttribute : ValidationAttribute
    {
        public DateGreaterThanAttribute(string dateToCompareToFieldName)
        {
            DateToCompareToFieldName = dateToCompareToFieldName;
        }

        private string DateToCompareToFieldName { get; set; }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            try
            {
                DateTime earlierDate = (DateTime)validationContext.ObjectType.GetProperty(DateToCompareToFieldName).GetValue(validationContext.ObjectInstance, null);
                DateTime laterDate = (DateTime)value;

                if (laterDate > earlierDate)
                    return ValidationResult.Success;
                else
                    return new ValidationResult(Resources.Sondages.dateFinAvantDebut);
            }
            catch
            {
                return ValidationResult.Success;
            }
        }
    }
}