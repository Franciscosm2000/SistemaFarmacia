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
using Sistema.Web.Models.Almacen.Articulo;

namespace Sistema.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ArticulosController : ControllerBase
    {
        private readonly DbContextSistema _context;

        public ArticulosController(DbContextSistema context)
        {
            _context = context;
        }

        // GET: api/Articulos/Listar
        [Authorize(Roles = "Vendedor,Administrador")]
        [HttpGet("[action]")]
        public async Task<IEnumerable<ArticuloViewModel>> Listar()
        {
            var articulo = await _context.Articulos.Include(a => a.categoria).ToListAsync();

            return articulo.Select(a => new ArticuloViewModel
            {
                idarticulo= a.idarticulo,
                idcategoria = a.idcategoria,
                categoria=a.categoria.nombre,
                codigo=a.codigo,
                nombre = a.nombre,
                stock=a.stock,
                precio_venta=a.precio_venta,
                descripcion = a.descripcion,
                condicion = a.condicion
            });

        }

        // GET: api/Articulos/ListarIngreso/texto
        [Authorize(Roles = "Vendedor,Administrador")]
        [HttpGet("[action]/{texto}")]
        public async Task<IEnumerable<ArticuloViewModel>> ListarIngreso([FromRoute] string texto)
        {
            var articulo = await _context.Articulos.Include(a => a.categoria)
                .Where(a=>a.nombre.Contains(texto))
                .Where(a=>a.condicion==true)
                .ToListAsync();

            return articulo.Select(a => new ArticuloViewModel
            {
                idarticulo = a.idarticulo,
                idcategoria = a.idcategoria,
                categoria = a.categoria.nombre,
                codigo = a.codigo,
                nombre = a.nombre,
                stock = a.stock,
                precio_venta = a.precio_venta,
                descripcion = a.descripcion,
                condicion = a.condicion
            });

        }

        // GET: api/Articulos/ListarVenta/texto
        [Authorize(Roles = "Vendedor,Administrador")]
        [HttpGet("[action]/{texto}")]
        public async Task<IEnumerable<ArticuloViewModel>> ListarVenta([FromRoute] string texto)
        {
            var articulo = await _context.Articulos.Include(a => a.categoria)
                .Where(a => a.nombre.Contains(texto))
                .Where(a => a.condicion == true)
                .Where(a=>a.stock>0)
                .ToListAsync();

            return articulo.Select(a => new ArticuloViewModel
            {
                idarticulo = a.idarticulo,
                idcategoria = a.idcategoria,
                categoria = a.categoria.nombre,
                codigo = a.codigo,
                nombre = a.nombre,
                stock = a.stock,
                precio_venta = a.precio_venta,
                descripcion = a.descripcion,
                condicion = a.condicion
            });

        }


        // GET: api/Articulos/Mostrar/1
        [Authorize(Roles = "Vendedor,Administrador")]
        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> Mostrar([FromRoute] int id)
        {

            var articulo = await _context.Articulos.Include(a=>a.categoria).
                SingleOrDefaultAsync(a=>a.idarticulo==id);

            if (articulo == null)
            {
                return NotFound();
            }

            return Ok(new ArticuloViewModel
            {
                idarticulo = articulo.idarticulo,
                idcategoria=articulo.idcategoria,
                categoria=articulo.categoria.nombre,
                codigo=articulo.codigo,
                nombre = articulo.nombre,
                descripcion = articulo.descripcion,
                stock = articulo.stock,
                precio_venta = articulo.precio_venta,
                condicion = articulo.condicion
            });
        }

        // GET: api/Articulos/BuscarCodigoIngreso/12345678
        [Authorize(Roles = "Vendedor,Administrador")]
        [HttpGet("[action]/{codigo}")]
        public async Task<IActionResult> BuscarCodigoIngreso([FromRoute] string codigo)
        {

            var articulo = await _context.Articulos.Include(a => a.categoria)
                .Where(a=>a.condicion==true).
                SingleOrDefaultAsync(a => a.codigo == codigo);

            if (articulo == null)
            {
                return NotFound();
            }

            return Ok(new ArticuloViewModel
            {
                idarticulo = articulo.idarticulo,
                idcategoria = articulo.idcategoria,
                categoria = articulo.categoria.nombre,
                codigo = articulo.codigo,
                nombre = articulo.nombre,
                descripcion = articulo.descripcion,
                stock = articulo.stock,
                precio_venta = articulo.precio_venta,
                condicion = articulo.condicion
            });
        }


        // GET: api/Articulos/BuscarCodigoVenta/12345678
        [Authorize(Roles = "Vendedor,Administrador")]
        [HttpGet("[action]/{codigo}")]
        public async Task<IActionResult> BuscarCodigoVenta([FromRoute] string codigo)
        {

            var articulo = await _context.Articulos.Include(a => a.categoria)
                .Where(a => a.condicion == true)
                .Where(a=>a.stock>0)
                .SingleOrDefaultAsync(a => a.codigo == codigo);

            if (articulo == null)
            {
                return NotFound();
            }

            return Ok(new ArticuloViewModel
            {
                idarticulo = articulo.idarticulo,
                idcategoria = articulo.idcategoria,
                categoria = articulo.categoria.nombre,
                codigo = articulo.codigo,
                nombre = articulo.nombre,
                descripcion = articulo.descripcion,
                stock = articulo.stock,
                precio_venta = articulo.precio_venta,
                condicion = articulo.condicion
            });
        }


        // PUT: api/Articulos/Actualizar
        [Authorize(Roles = "Administrador")]
        [HttpPut("[action]")]
        public async Task<IActionResult> Actualizar([FromBody] ActualizarViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (model.idarticulo <= 0)
            {
                return BadRequest("Error de id articulo.");
            }

            var articulo = await _context.Articulos.FirstOrDefaultAsync(a => a.idarticulo == model.idarticulo);

           // var dat = await _context.Articulos.Where(a=> a.codigo == articulo.codigo).ToListAsync();

            if (articulo == null)
            {
                return NotFound("Articulo no encontrado.");
            }

            articulo.idcategoria = model.idcategoria;
            articulo.codigo = model.codigo;
            articulo.nombre = model.nombre;
            articulo.precio_venta = model.precio_venta;
            articulo.stock = model.stock;
            articulo.descripcion = model.descripcion;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (Exception e)
            {
                // Guardar Excepción
                return BadRequest(e.Message);
            }

            return Ok();
        }

        // POST: api/Articulos/Crear
        [Authorize(Roles = "Vendedor,Administrador")]
        [HttpPost("[action]")]
        public async Task<IActionResult> Crear([FromBody] CrearViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var dat = await _context.Articulos.Where(a => a.codigo == model.codigo).FirstOrDefaultAsync();

            if (dat != null) {
                return BadRequest("El código ya existe.");
            }

            Articulo articulo = new Articulo
            {
                idcategoria = model.idcategoria,
                codigo = model.codigo,
                nombre = model.nombre,
                precio_venta = model.precio_venta,
                stock = model.stock,
                descripcion = model.descripcion,
                condicion = true
            };

            _context.Articulos.Add(articulo);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

            return Ok();
        }

        // PUT: api/Articulos/Desactivar/1
        [Authorize(Roles = "Administrador")]
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Desactivar([FromRoute] int id)
        {

            if (id <= 0)
            {
                return BadRequest("Error de id articulo");
            }

            var articulo = await _context.Articulos.FirstOrDefaultAsync(a => a.idarticulo == id);

            if (articulo == null)
            {
                return NotFound("Articulo no encontrado.");
            }

            articulo.condicion = false;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (Exception e)
            {
                // Guardar Excepción
                return BadRequest(e.Message);
            }

            return Ok();
        }

        // PUT: api/Articulos/Activar/1
        [Authorize(Roles = "Administrador")]
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Activar([FromRoute] int id)
        {

            if (id <= 0)
            {
                return BadRequest("Error de id articulo.");
            }

            var articulo = await _context.Articulos.FirstOrDefaultAsync(a => a.idarticulo == id);

            if (articulo == null)
            {
                return NotFound("Articulo no encontrado");
            }

            articulo.condicion = true;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (Exception e)
            {
                // Guardar Excepción
                return BadRequest(e.Message);
            }

            return Ok();
        }


        private bool ArticuloExists(int id)
        {
            return _context.Articulos.Any(e => e.idarticulo == id);
        }
    }
}