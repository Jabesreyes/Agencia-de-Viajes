using System;
using System.Collections;
using System.Collections.Generic;
using AgenciaViajes.Data;
using AgenciaViajes.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AgenciaViajes.Controllers
{
    public class DestinosController : Controller
    {
        private readonly ApplicationDbContext _context;
        public DestinosController(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var destinos = await _context.Destinos.ToListAsync();
            return View(destinos);
        }


        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }
            if (HttpContext.Session.GetString("email") != null)
            {
                var list = HttpContext.Session.GetString("destinos");
                if (list != null)
                {
                    var destinos = list.Split(",");
                    if (destinos.Length > 10)
                    {
                        Array.Copy(destinos, destinos, destinos.Length - 1);
                    }
                    if (destinos.Where(x => x == id.ToString()).ToArray().Length == 0)
                    {
                        var destinosActualizado = destinos.Prepend(id.ToString());
                        HttpContext.Session.SetString("destinos", string.Join(",", destinosActualizado));
                    }
                } else
                {
                    HttpContext.Session.SetString("destinos", id.ToString());
                }
            }
            var destino = await _context.Destinos
                .FirstOrDefaultAsync(m => m.DestinoID == id);
            if (destino == null)
            {
                return NotFound();
            }
            var actividades = await _context.Actividades.Where(a => a.DestinoID == id).ToListAsync();


            return View(new {destino, actividades});
        }
        public async Task<IActionResult> Aleatorio()
        {
            var destinos = await _context.Destinos.ToListAsync();
            var arrDestinos = destinos.ToArray();
            var rng = new Random(); 
            RandomExtensions.Shuffle<Destino>(rng, arrDestinos);

            var destinosRandom = new List<Destino>();
            int limite = arrDestinos.Length > 10 ? 10 : arrDestinos.Length;
            for (int i = 0; i < limite; ++i)
            {
                destinosRandom.Add(arrDestinos[i]);
            }
            return View(destinosRandom);
        }
        public async Task<IActionResult> UltimasBusquedas()
        {
            var lista = HttpContext.Session.GetString("destinos");
            List<Destino>? destinos = null;
            if (lista != null)
            {
                //_context.Destinos.Async
                var ultimosDestinos = lista.Split(",").ToList();

                destinos = await _context.Destinos.Where(d => ultimosDestinos.Contains(d.DestinoID.ToString())).ToListAsync();
            }
            return View(destinos);
        }
        [HttpGet]
        [HttpPost]
        public async Task<IActionResult> Agregar(IFormCollection collection)
        {
            if (!Utils.IsAdmin(HttpContext.Session))
            {
                return Redirect("/Destinos/");
            }
            var nombre = collection["nombre"].ToString();
            var imagen = collection["imagen"].ToString();
            var pais = collection["pais"].ToString();
            var zona = collection["zona"].ToString();
            var descripcion = collection["descripcion"].ToString();

            if (
                nombre != "" &&
                imagen != "" &&
                pais != "" &&
                zona != "" &&
                descripcion != ""
            )
            {
                _context.Add(
                    new Destino
                    {
                        Nombre = nombre,
                        Imagen = imagen,
                        Pais = pais,
                        Zona = zona,
                        Descripcion = descripcion
                    }
                );
                await _context.SaveChangesAsync();
                return Redirect("/Destinos/");
            }

            return View();
        }

        [HttpGet]
        [HttpPost]
        public async Task<IActionResult> Editar(int? id, IFormCollection collection)
        {
            if (!Utils.IsAdmin(HttpContext.Session))
            {
                return Redirect("/Destinos/");
            }
            if (HttpContext.Request.Method == "POST")
            {

                var destinoId = collection["id"].ToString();
                var nombre = collection["nombre"].ToString();
                var imagen = collection["imagen"].ToString();
                var pais = collection["pais"].ToString();
                var zona = collection["zona"].ToString();
                var descripcion = collection["descripcion"].ToString();
                if (
                    destinoId != "" &&
                    nombre != "" &&
                    imagen != "" &&
                    pais != "" &&
                    zona != "" &&
                    descripcion != ""
                )
                {
                    _context.Update(
                        new Destino
                        {
                            DestinoID = Int32.Parse(destinoId),
                            Nombre = nombre,
                            Imagen = imagen,
                            Pais = pais,
                            Zona = zona,
                            Descripcion = descripcion
                        }
                    );
                    await _context.SaveChangesAsync();
                    return Redirect("/Destinos/");
                }
            }
            else
            {
                if (id == null)
                {
                    return NotFound();
                }
            }
            var destino = await _context.Destinos
                .FirstOrDefaultAsync(m => m.DestinoID == id);
            if (destino == null)
            {
                return NotFound();
            }
            return View(destino);
        }

    }
}
static class RandomExtensions
{
    public static void Shuffle<T>(this Random rng, T[] array)
    {
        int n = array.Length;
        while (n > 1)
        {
            int k = rng.Next(n--);
            T temp = array[n];
            array[n] = array[k];
            array[k] = temp;
        }
    }
}