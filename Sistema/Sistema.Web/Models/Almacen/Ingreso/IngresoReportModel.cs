using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema.Web.Models.Almacen.Ingreso
{
    public class IngresoReportModel
    {
        public int id_ingreso { get; set; }
        public string codigo_arti { get; set; }
        public string nom_arti { get; set; }
        public string proveedor { get; set; }
        public decimal precio { get; set; }
        public int cantidad { get; set; }
        public decimal valor { get; set; }
        public string fecha { get; set; }
    }
}
