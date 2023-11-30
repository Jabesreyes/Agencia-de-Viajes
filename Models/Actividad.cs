namespace AgenciaViajes.Models
{
    public class Actividad
    {
        public int ActividadID { get; set; }
        public int DestinoID { get; set; }
        public string Nombre { get; set; }
        public int Dias { get; set; }
        public decimal Precio { get; set; }
        public string TipoActividad { get; set; }

        // Propiedad de navegación a Destino
        public Destino Destino { get; set; }
    }
}
