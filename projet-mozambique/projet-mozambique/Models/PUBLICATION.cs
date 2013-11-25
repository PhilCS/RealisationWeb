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
    
    public partial class PUBLICATION
    {
        public PUBLICATION()
        {
            this.MOTCLE = new HashSet<MOTCLE>();
        }
    
        public int ID { get; set; }
        public string TITRE { get; set; }
        public System.DateTime DATECREATION { get; set; }
        public string DESCRIPTION { get; set; }
        public int IDPUBLICATEUR { get; set; }
        public int IDSUJET { get; set; }
        public int IDSECTEUR { get; set; }
        public string MIMETYPE { get; set; }
        public string NOMFICHIERORIGINAL { get; set; }
        public string NOMFICHIERSERVEUR { get; set; }
        public int TAILLEFICHIER { get; set; }
    
        public virtual SECTEUR SECTEUR { get; set; }
        public virtual SUJETPUBLICATION SUJETPUBLICATION { get; set; }
        public virtual UTILISATEUR UTILISATEUR { get; set; }
        public virtual ICollection<MOTCLE> MOTCLE { get; set; }
    }
}
