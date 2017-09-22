using NoteFood.Web.Models.Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MySql.Data.MySqlClient;
using NoteFood.Web.Models.ViewModel;

namespace NoteFood.Web.Controllers
{
    public class AlimentosController : Controller
    {
        private const string CONEXAO = "Server=localhost;Database=notefood;Uid=root;Pwd=paulodb;";

        private MySqlConnection Conectar()
        {
            MySqlConnection conn = new MySqlConnection(CONEXAO);
            conn.Open();
            return conn;
        }

        public ActionResult Index()
        {
            var conn = Conectar();
            MySqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "SELECT ID, NOME, DESCRICAO, PORCAO, VALORPORCAO, SUB_GRUPO_ID FROM ALIMENTO ;";

            List<Alimento> alimentos = new List<Alimento>();

            // Ler para preencher a lista de alimentos
            MySqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                Alimento alimento = new Alimento();
                alimento.Id = Convert.ToInt32(reader["ID"]);
                alimento.Nome = reader["NOME"].ToString();
                alimento.Descricao = (reader["DESCRICAO"] != DBNull.Value) ? reader["DESCRICAO"].ToString() : string.Empty;
                alimento.Porcao = reader["PORCAO"].ToString();
                alimento.ValorPorcao = Convert.ToInt32(reader["VALORPORCAO"]);
                alimento.Sub_Grupo_Id = Convert.ToInt32(reader["SUB_GRUPO_ID"]);
                 
                alimentos.Add(alimento);
            }

            conn.Close();

            return View(alimentos);
        }

        [HttpPost]
        public JsonResult RegistrarAlimentoSelecionado(AlimentoSelecionado alimentoSelecionado)
        {
            var conn = Conectar();
            var cmd = conn.CreateCommand();
            cmd.CommandText = "INSERT INTO ALIMENTO_SELECIONADO (ALIMENTO_ID, QTD) VALUES (@ALIMENTO_ID, @QTD);";
            cmd.Parameters.AddWithValue("@ALIMENTO_ID", alimentoSelecionado.Alimento_Id);
            cmd.Parameters.AddWithValue("@QTD", alimentoSelecionado.Qtd);
            cmd.ExecuteNonQuery();
            conn.Close();
            return Json(true, JsonRequestBehavior.AllowGet);
        }
    }
}