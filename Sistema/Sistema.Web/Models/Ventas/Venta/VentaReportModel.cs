using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema.Web.Models.Ventas.Venta
{
    public class VentaReportModel
    {
        public string codigo_arti { get; set; }
        public string nom_arti { get; set; }
        public int cantidad { get; set; }
        public decimal valor { get; set; }
        public DateTime fecha { get; set; }
    }
}
