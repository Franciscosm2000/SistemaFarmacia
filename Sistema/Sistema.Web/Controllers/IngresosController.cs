using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Sistema.Datos;
using Sistema.Entidades.Almacen;
using Sistema.Web.Models.Almacen.Ingreso;

namespace Sistema.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class IngresosController : ControllerBase
    {
        private readonly DbContextSistema _context;

        public IngresosController(DbContextSistema context)
        {
            _context = context;
        }

        // GET: api/Ingresos/Listar
        [Authorize(Roles = "Vendedor,Administrador")]
        [HttpGet("[action]")]
        public async Task<IEnumerable<IngresoViewModel>> Listar()
        {
            var ingreso = await _context.Ingresos
                .Include(i => i.usuario)
                .Include(i=>i.persona)
                .OrderByDescending(i=>i.fecha_hora)
                .ToListAsync();

            return ingreso.Select(i => new IngresoViewModel
            {
                idingreso = i.idingreso,
                idproveedor = i.idproveedor,
                proveedor = i.persona.nombre,
                idusuario = i.idusuario,
                usuario = i.usuario.nombre,
                tipo_comprobante = i.tipo_comprobante,
                num_comprobante = i.num_comprobante,
                fecha_hora = i.fecha_hora,
                impuesto = i.impuesto,
                total = i.total,
                estado = i.estado
            });

        }


        // GET: api/Ingresos/ListarFiltro/texto
        [Authorize(Roles = "Vendedor,Administrador")]
        [HttpGet("[action]/{texto}")]
        public async Task<IEnumerable<IngresoViewModel>> ListarFiltro([FromRoute] string texto)
        {
            var ingreso = await _context.Ingresos
                .Include(i => i.usuario)
                .Include(i => i.persona)
                .Where(i=>i.num_comprobante.Contains(texto))
                .OrderByDescending(i => i.fecha_hora)
                .ToListAsync();

            return ingreso.Select(i => new IngresoViewModel
            {
                idingreso = i.idingreso,
                idproveedor = i.idproveedor,
                proveedor = i.persona.nombre,
                idusuario = i.idusuario,
                usuario = i.usuario.nombre,
                tipo_comprobante = i.tipo_comprobante,
                num_comprobante = i.num_comprobante,
                fecha_hora = i.fecha_hora,
                impuesto = i.impuesto,
                total = i.total,
                estado = i.estado
            });

        }

        // GET: api/Ingresos/ListarDetalles
        [Authorize(Roles = "Vendedor,Administrador")]
        [HttpGet("[action]/{idingreso}")]
        public async Task<IEnumerable<DetalleViewModel>> ListarDetalles([FromRoute] int idingreso)
        {
            var detalle = await _context.DetallesIngresos
                .Include(a => a.articulo)
                .Where(d=>d.idingreso==idingreso)
                .ToListAsync();

            return detalle.Select(d => new DetalleViewModel
            {
                idarticulo=d.idarticulo,
                articulo=d.articulo.nombre,
                cantidad=d.cantidad,
                precio=d.precio
            });

        }

        // POST: api/Ingresos/Crear
        [Authorize(Roles = "Vendedor,Administrador")]
        [HttpPost("[action]")]
        public async Task<IActionResult> Crear([FromBody] CrearViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var fechaHora = DateTime.Now;

            Ingreso ingreso = new Ingreso {
                idproveedor = model.idproveedor,
                idusuario = model.idusuario,
                tipo_comprobante = model.tipo_comprobante,
                num_comprobante = model.num_comprobante,
                fecha_hora = fechaHora,
                impuesto = model.impuesto,
                total = model.total,
                estado = "Aceptado"
            };      

            
            try
            {
                _context.Ingresos.Add(ingreso);
                await _context.SaveChangesAsync();

                var id = ingreso.idingreso;
                foreach (var det in model.detalles)
                {
                    DetalleIngreso detalle = new DetalleIngreso
                    {
                        idingreso = id,
                        idarticulo = det.idarticulo,
                        cantidad = det.cantidad,
                        precio = det.precio
                    };
                    _context.DetallesIngresos.Add(detalle);
                }
                await _context.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

            return Ok();
        }

        // PUT: api/Ingresos/Anular/1
        [Authorize(Roles = "Vendedor,Administrador")]
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Anular([FromRoute] int id)
        {

            if (id <= 0)
            {
                return BadRequest("Error de id ingreso.");
            }

            var ingreso = await _context.Ingresos.FirstOrDefaultAsync(c=>c.idingreso == id);

            if (ingreso == null)
            {
                return NotFound("Ingreso no encontrado.");
            }

            ingreso.estado = "Anulado";

            try
            {
                await _context.SaveChangesAsync();
                
                // Inicio de código para devolver stock
                // 1. Obtenemos los detalles
                var detalle = await _context.DetallesIngresos.Include(a => a.articulo).Where(d => d.idingreso == id).ToListAsync();
                //2. Recorremos los detalles
                foreach (var det in detalle)
                {
                    //Obtenemos el artículo del detalle actual
                    var articulo = await _context.Articulos.FirstOrDefaultAsync(a => a.idarticulo == det.articulo.idarticulo);
                    //actualizamos el stock
                    articulo.stock = det.articulo.stock-det.cantidad;
                    //Guardamos los cambios
                    await _context.SaveChangesAsync();
                }
                // Fin del código para devolver stock

                }
            catch (Exception e)
            {
                // Guardar Excepción
                return BadRequest(e.Message);
            }

            return Ok();
        }


        //REPORTE
        [Authorize(Roles = "Administrador")]
        [HttpGet("[action]/{desde}/{hasta}")]
        public async Task<List<IngresoReportModel>> IngresosXFecha([FromRoute] DateTime desde , DateTime hasta) {

            var ingresos = await _context.Ingresos.Where(i => i.fecha_hora >= desde && i.fecha_hora <= hasta).ToListAsync(); //Ingresos

            List<IngresoReportModel> resultado = new List<IngresoReportModel>();

            foreach (var item in ingresos)
            {
                var detalle_ing = await _context.DetallesIngresos.Where(d=> d.idingreso == item.idingreso) //detalle de dichos ingresos 
                    .Include(a=> a.articulo)
                    .ToListAsync();

                foreach (var item2 in detalle_ing)
                {
                    resultado.Add(new IngresoReportModel()          //insersion en coleccion 
                    {
                        codigo_arti = item2.articulo.codigo,
                        nom_arti = item2.articulo.nombre,
                        cantidad = item2.cantidad,
                        valor = Math.Round((decimal) item2.cantidad * item2.precio,2),
                        fecha = item.fecha_hora
                    });
                }
            }

            return resultado;
        }

        private bool IngresoExists(int id)
        {
            return _context.Ingresos.Any(e => e.idingreso == id);
        }
    }
}