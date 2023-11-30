namespace AgenciaViajes.Models
{
    public class TipoUsuario
    {
        public int TipoUsuarioID { get; set; }
        public string Nombre { get; set; }

        // Propiedad de navegación a Usuario
        public List<Usuario> Usuarios { get; set; }
    }
}
