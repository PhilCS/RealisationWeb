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
    
    public partial class GetMessagesPrives_Result
    {
        public int IDMESSAGE { get; set; }
        public string CONTENU { get; set; }
        public System.DateTime DATEENVOI { get; set; }
        public string SUJET { get; set; }
        public bool LU { get; set; }
        public Nullable<int> IDPIECEJOINTE { get; set; }
        public string NOMEXPED { get; set; }
    }
}