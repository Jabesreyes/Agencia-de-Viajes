using AgenciaViajes.Models;
using Microsoft.EntityFrameworkCore.Metadata.Internal;

namespace AgenciaViajes
{
    public static class Utils
    {
        public static bool IsAdmin(ISession Session)
        {
            var tipo = Session.GetString("tipoUsuario");
            if (tipo == null)
            {
                return false;
            }
            return Int32.Parse(tipo) == 3;
        }
    }
}
