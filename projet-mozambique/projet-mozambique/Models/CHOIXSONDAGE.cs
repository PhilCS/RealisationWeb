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
    
    public partial class CHOIXSONDAGE
    {
        public CHOIXSONDAGE()
        {
            this.UTILISATEUR = new HashSet<UTILISATEUR>();
        }
    
        public int ID { get; set; }
        public int IDSONDAGE { get; set; }
        public string VALEUR { get; set; }
        public string VALEURTRAD { get; set; }
    
        public virtual SONDAGE SONDAGE { get; set; }
        public virtual ICollection<UTILISATEUR> UTILISATEUR { get; set; }
    }
}
