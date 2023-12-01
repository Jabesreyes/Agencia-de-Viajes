using Microsoft.EntityFrameworkCore;
using AgenciaViajes.Models;
namespace AgenciaViajes.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
        {
        }

        public DbSet<Destino> Destinos { get; set; }

    }
}
