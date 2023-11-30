namespace AgenciaViajes.Models
{
    public class Busqueda
    {
        public int BusquedaID { get; set; }
        public int UsuarioID { get; set; }
        public int DestinoID { get; set; }
        public DateTime Fecha { get; set; }

        // Propiedades de navegación a Usuario y Destino
        public Usuario Usuario { get; set; }
        public Destino Destino { get; set; }
    }
}
