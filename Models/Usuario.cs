namespace AgenciaViajes.Models
{
    public class Usuario
    {
        public int UsuarioID { get; set; }
        public string Nombre { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public int TipoUsuarioID { get; set; }
        public string? ListaDestinos { get; set; }

        // Propiedad de navegación a TipoUsuario
        public TipoUsuario TipoUsuario { get; set; }
    }
}
