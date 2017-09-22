using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NoteFood.Web.Models.Dominio
{
    public class SubGrupo
    {
        public int SubId { get; set; }
        public string Nome { get; set; }

        public List<Alimento> Alimentos { get; set; }
    }
}