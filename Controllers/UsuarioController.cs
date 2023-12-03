using AgenciaViajes.Data;
using AgenciaViajes.Models;
using BCrypt.Net;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Configuration;
using System.Web;
namespace AgenciaViajes.Controllers
{
    public class UsuarioController : Controller
    {
        private readonly ApplicationDbContext _context;
        public UsuarioController(ApplicationDbContext context)
        {
            _context = context;
        }
        [HttpGet]
        [HttpPost]
        public async Task<IActionResult> Login(IFormCollection collection)
        {
            try
            {
                var email = collection["email"].ToString();
                var password = collection["password"].ToString();
                if (email != "" && password != "")
                {
                    var usuario = await _context.Usuarios.Where(user => user.Email == email).FirstOrDefaultAsync();
                    if (usuario != null)
                    {
                        if (BCrypt.Net.BCrypt.Verify(password, usuario.Password))
                        {
                            if (usuario.ListaDestinos != null)
                            {
                                HttpContext.Session.SetString("destinos", usuario.ListaDestinos);
                            }
                            HttpContext.Session.SetString("email", email);
                            HttpContext.Session.SetString("tipoUsuario", usuario.TipoUsuarioID.ToString());
                            HttpContext.Session.SetString("usuario_id", usuario.UsuarioID.ToString());
                            HttpContext.Session.SetString("isLogged", "1");
                            return Redirect("/");
                        }
                    }
                }
                return View();
            }
            catch (Exception e)
            {
                return View();
            }
        }
        public IActionResult Registrar()
        {
            return View();
        }
        public async Task<IActionResult> Logout()
        {
            var listaDestinos = HttpContext.Session.GetString("destinos");
            var id = HttpContext.Session.GetString("usuario_id");
            if (id != null)
            {
                var usuario = await _context.Usuarios.FirstOrDefaultAsync(u => u.UsuarioID == Int32.Parse(id));
                usuario.ListaDestinos = listaDestinos;
                _context.Update<Usuario>(usuario);
                await _context.SaveChangesAsync();
                HttpContext.Session.Clear();
            }
            return Redirect("/");
        }
        [HttpPost]
        public async Task<IActionResult> Create(IFormCollection collection)
        {
            try
            {
                var nombre = collection["nombre"];
                var email = collection["email"];
                var password = collection["password"];
                var hash = BCrypt.Net.BCrypt.HashPassword(password);
                var usuario = new Usuario { TipoUsuarioID = 1, Nombre = nombre, Email= email, Password = hash};
                _context.Usuarios.Add(usuario);
                await _context.SaveChangesAsync();
                return Redirect("/Usuario/Login");
            }
            catch
            {
                return Redirect("/Usuario/Registrar");
            }
        }

        // GET: UsuarioController/Edit/5
        public IActionResult Edit(int id)
        {
            return View();
        }

        // POST: UsuarioController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: UsuarioController/Delete/5
        public IActionResult Delete(int id)
        {
            return View();
        }

        // POST: UsuarioController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }
    }
}
