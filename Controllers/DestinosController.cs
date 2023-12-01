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
