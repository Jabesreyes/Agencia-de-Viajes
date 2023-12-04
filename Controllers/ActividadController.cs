using AgenciaViajes.Data;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AgenciaViajes.Controllers
{
    public class ActividadController : Controller
    {
        private readonly ApplicationDbContext _context;
        public ActividadController(ApplicationDbContext context)
        {
            _context = context;
        }

        // POST: ActividadController/Create
        [HttpGet]
        [HttpPost]
        public async Task<IActionResult> Agregar(int? id, IFormCollection collection)
        {
            try
            {
                if (id == null || !Utils.IsAdmin(HttpContext.Session))
                {

                    Redirect("/Destinos/");
                }
                if (HttpContext.Request.Method == "POST")
                {
                    var DestinoID = collection["destino_id"].ToString();
                    var Nombre = collection["nombre"].ToString();
                    var Dias = collection["dias"].ToString();
                    var Precio = collection["precio"].ToString();
                    var TipoActividad = collection["tipo_actividad"].ToString();
                    if (DestinoID != "" &&
                        Nombre != "" &&
                        Precio != "" &&
                        TipoActividad != "")
                    {
                        _context.Actividades.Add(
                            new Models.Actividad{
                                DestinoID = Int32.Parse(DestinoID),
                                Nombre = Nombre,
                                Dias = Int32.Parse(Dias),
                                Precio = Decimal.Parse(Precio),
                                TipoActividad = TipoActividad
                            }
                        );
                        await _context.SaveChangesAsync();
                        return Redirect("/Destinos/Details/" + id.ToString());
                    }
                }

                return View(id);
            }
            catch
            {
                return Redirect("/Destinos/");
            }
        }
    }
}
