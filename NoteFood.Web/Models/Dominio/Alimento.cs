using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NoteFood.Web.Models.Dominio
{
    public class Alimento
    {
        public int Id { get; set; }
        public string Nome { get; set; }
        public string Descricao { get; set; }
        public string Porcao { get; set; }
        public float ValorPorcao { get; set; }
        public int Sub_Grupo_Id { get; set; }
    }
}