using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace projet_mozambique.Models
{
    public class FileViewModel
    {

        public Guid Id { get; set; }
        public string Name { get; set; }
        public bool Delete { get; set; }
        public string ExistingUrl { get; set; }

        public HttpPostedFileBase FileBase { get; set; }

    }
}