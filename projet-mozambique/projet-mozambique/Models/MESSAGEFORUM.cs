//------------------------------------------------------------------------------
// <auto-generated>
//    Ce code a été généré à partir d'un modèle.
//
//    Des modifications manuelles apportées à ce fichier peuvent conduire à un comportement inattendu de votre application.
//    Les modifications manuelles apportées à ce fichier sont remplacées si le code est régénéré.
// </auto-generated>
//------------------------------------------------------------------------------

namespace projet_mozambique.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class MESSAGEFORUM
    {
        public int ID { get; set; }
        public System.DateTime DATEPUBLICATION { get; set; }
        public Nullable<System.DateTime> DATEMODIFICATION { get; set; }
        public string CONTENU { get; set; }
        public int IDUTILISATEUR { get; set; }
        public int IDFILDISCUSSION { get; set; }
    
        public virtual FILDISCUSSION FILDISCUSSION { get; set; }
        public virtual UTILISATEUR UTILISATEUR { get; set; }
    }
}
