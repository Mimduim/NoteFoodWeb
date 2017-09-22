using NoteFood.Web.Models.Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NoteFood.Web.Models.ViewModel
{
    public class AlimentoCadastroViewModel : Alimento
    {
        public SelectList ListaSubGrupos { get; set; }
    }
}