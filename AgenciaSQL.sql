--Primera porcion de Codigo sql
CREATE DATABASE Agencia;
USE Agencia;
-- Creación de la tabla de Usuarios
CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL,
	Email VARCHAR(50) NOT NULL,
	Password VARCHAR(255) NOT NULL,
    ListaDestinos VARCHAR(100),
    -- Otros campos según necesidades
);

-- Creación de la tabla de Destinos
CREATE TABLE Destinos (
    DestinoID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100),
    Imagen NVARCHAR(255),
    Pais NVARCHAR(50),
    Zona NVARCHAR(50),
    -- Otros campos según necesidades
);

-- Creación de la tabla de Búsquedas
CREATE TABLE Busquedas (
    BusquedaID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT,
    DestinoID INT,
    Fecha DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (DestinoID) REFERENCES Destinos(DestinoID)
);

-- Creación de la tabla de Actividades
CREATE TABLE Actividades (
    ActividadID INT PRIMARY KEY IDENTITY(1,1),
    DestinoID INT,
    Nombre NVARCHAR(100),
    Dias INT,
    Precio DECIMAL(10, 2),
    TipoActividad NVARCHAR(MAX),
    FOREIGN KEY (DestinoID) REFERENCES Destinos(DestinoID)
);

--Segunda porcion de Codigo
CREATE TABLE TiposUsuarios (
    TipoUsuarioID INT PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL
);

INSERT INTO TiposUsuarios (TipoUsuarioID, Nombre)
VALUES 
    (1, 'Invitado'),
    (2, 'Registrado'),
    (3, 'Administrador');

-- tercera porcion de Codigo
ALTER TABLE Usuarios
ADD TipoUsuarioID INT;

-- Asigna un tipo de usuario por defecto, por ejemplo, Invitado
UPDATE Usuarios SET TipoUsuarioID = 1;

-- Añade la restricción de clave foránea
ALTER TABLE Usuarios
ADD CONSTRAINT FK_Usuarios_TiposUsuarios
FOREIGN KEY (TipoUsuarioID) REFERENCES TiposUsuarios(TipoUsuarioID);

--CUARTA PORCION DE CODIGO 

ALTER TABLE DESTINOS
ADD Descripcion NVARCHAR(MAX);

--INSERCION DE LOS DESTINOS

INSERT INTO Destinos (Nombre,Imagen,Pais,Zona,Descripcion)
VALUES('Ahu Tongariki, Isla de Pascua','https://cdn.inteligenciaviajera.com/wp-content/uploads/2020/04/lugares-turisticos-1.jpg','Chile','Oceano Pacifico','La Isla de Pascua, en medio del oceano pacifico, es una de la islas habitadas más remotas del planeta. Estamos seguros de que ya has oído hablar de esta misteriosa isla, y sobretodo de Ahu Tongariki, icono representativo de la Isla de Pascua en todo el mundo. Se trata del monumento ceremonial más grande de la Polinesia y la mayor construcción en toda la isla. Una plataforma de casi 100 metros de longitud donde se sostienen 15 moais, esculturas tradicionales de la cultura Rapa Nui, construidos para preservar la energía de sus ancestros. Una autentica obra arquitectónica y también uno de los lugares más mágicos para disfrutar de la salida del sol en la Isla de Pascua.');

INSERT INTO Destinos (Nombre,Imagen,Pais,Zona,Descripcion)
VALUES ('Stonehenge','https://cdn.inteligenciaviajera.com/wp-content/uploads/2020/04/sitios-turisticos-2.jpg','Inglaterra','Reino Unido','¿Quién no ha visto alguna vez el monumento megalitico de Stonehenge en el típico libro de historia? Hablar de Stonehenge no es solo hablar del mayor círculo de piedra del mundo y una de las construcciones más antiguas de nuestra historia (5.000 años a.C.) . También es hablar de uno de los lugares más misteriosos del planeta, pues la finalidad exacta de esta construcción sigue siendo a día de hoy un enigma. Se cree que pudo ser un cementerio, un lugar de culto, un observatorio astronómico, un símbolo de unidad entre las diferentes tribus de la época…  Sea como fuese, te recomendamos que vayas por ti mismo o misma y que no dejes de sentir el misticismo y la energía que desprende este lugar.');

INSERT INTO Destinos (Nombre,Imagen,Pais,Zona,Descripcion)
VALUES ('La Pirámide del Sol','https://cdn.inteligenciaviajera.com/wp-content/uploads/2020/04/mejores-sitios-turisticos.jpg','Mexico','NorteAmerica','Icono del gran Conjunto Arqueológico de Teotihuacán, situado al norte de la Ciudad de México. La Pirámide del Sol llama la atención por su enorme tamaño, especialmente notable cuando te plantas justo delante dispuesto a alcanzar la cima de 63 metros de altura superando paso a paso sus casi 240 peldaños.Ten en cuenta el clima y los días de mucho sol. En esta zona de México el clima suele ser caluroso, por lo que si vas a estar largas horas, no olvides tu protección solar, gafas y una botella de agua.');

INSERT INTO Destinos (Nombre,Imagen,Pais,Zona,Descripcion)
VALUES ('Mezquita Azul','https://cdn.inteligenciaviajera.com/wp-content/uploads/2020/04/mejores-lugares-turisticos.jpg','Estambul','Turquia','Ver la Mezquita Azul de cerca es uno de esos momentos inborrables que tus ojos recordarán para siempre. Es la mezquita más importante de Estambul y también una de las que más belleza desprende (por no decir la que más) tanto por fuera como por dentro. En el exterior encontrarás una verdadera obra arquitectónica dibujada con arcos, curvas, majestuosas cúpulas y sus característicos 6 minaretes. Pero también te recomendamos que no te pierdas el interior. Cuando estés dentro, mira hacia arriba y verás más de 20.000 azulejos de color azul adornando la cúpula principal y la parte superior del edificio, de ahí su nombre.');

INSERT INTO Destinos (Nombre,Imagen,Pais,Zona,Descripcion)
VALUES ('Caño Cristales','https://cdn.inteligenciaviajera.com/wp-content/uploads/2020/04/mejores-lugares-turisticos-3.jpg','Colombia','La Macarena','Este río en Colombia es una auténtica joya de la naturaleza y uno de los ríos mas bonitos del mundo. También se le conoce como el río de los cinco colores ya que a través de sus aguas se pueden observar tonos amarillos, verdes, rojos, azules y negros. Vamos, una explosión de colores con el que querrás sacar la cámara inmediatamente. Esto te pasará prácticamente en todo Colombia, un país lleno de luz, color y matices por todos lados.');

INSERT INTO Destinos (Nombre,Imagen,Pais,Zona,Descripcion)
VALUES ('Desierto de la Tatacoa','https://cdn.inteligenciaviajera.com/wp-content/uploads/2020/04/lugares-turisticos-2.jpg','Colombia','Tatacoa','Ya te lo advertimos, Colombia es un país lleno de contrastes, y el desierto de la Tatacoa, una de las zonas áridas más grandes del parís, lo corrobora. Este desierto se caracteriza por por sus tierras de colores ocres y grises, sorprendidos por el verde de los cactus que aparecen a su antojo a lo largo de sus más de 300 kilómetros cuadrados.');

INSERT INTO Destinos (Nombre,Imagen,Pais,Zona,Descripcion)
VALUES ('La Gran Muralla China','https://cdn.inteligenciaviajera.com/wp-content/uploads/2020/04/sitios-turisticos-1.jpg','China','Huairou','No podía faltar en esta lista uno de los lugares más bonitos del mundo y una visita imprescindible si viajas a China. Kilómetros y kilómetros de una muralla que se construyó hace miles de años para defender al imperio chino de constantes invasiones, y que ahora se encuentra entre las 7 maravillas del mundo moderno. Hay muchos sectores posibles donde ver la Gran Muralla China, pero los más accesibles para los viajeros son aquellos los más cercanos a Pekín (Beijing).');

INSERT INTO Destinos (Nombre,Imagen,Pais,Zona,Descripcion)
VALUES ('Las cataratas Victoria','https://cdn.inteligenciaviajera.com/wp-content/uploads/2020/04/mejores-sitios-turisticos-2.jpg','Zambia','Zimbawe','Estas impresionantes cataratas se encuentran en la frontera natural entre Zambia y Zimbawe, y están consideradas como una de las más grandes del mundo. Sus dimensiones son realmente sorprendentes, más de 1.700 metros de anchura y 108 metros de altura, aproximadamente el doble de altas que las Cataratas del Niágara.');

INSERT INTO Destinos (Nombre,Imagen,Pais,Zona,Descripcion)
VALUES ('Machu Picchu','https://cdn.inteligenciaviajera.com/wp-content/uploads/2020/03/Sitios-turísticos.jpg','Peru','Cusco','Latinoamérica tiene zonas turísticas impresionantes y uno de los lugares más increíbles está en Perú. Sí, te estamos hablando de Machu Picchu, una de las maravillas del mundo moderno. Sabemos que te habíamos dicho que te mencionaríamos lugares menos famosos para viajar, pero es que cuando te hablamos de Machu Picchu quiero ir un poco más allá. No se trata de ver solo la ciudad de piedra de los Incas De verdad, se trata de uno de los destinos turísticos que más aventuras deparan. Puedes llegar a Machu Picchu desde un tren y admirar una de las 7 maravillas del mundo moderno. Pero para hacerlo de una forma más local, échale un ojo a esta guía sobre Perú por allí te desvelamos los caminos secretos. ¡La elección depende de ti!');

INSERT INTO Destinos (Nombre,Imagen,Pais,Zona,Descripcion)
VALUES ('Dubai','https://cdn.inteligenciaviajera.com/wp-content/uploads/2020/03/Sitios-turísticos-en-el-mundo.jpg','Dubai','Emiratos Arabes','¿Qué es un lugar turístico sino una oportunidad de vivir una cultura completamente distinta de primera mano? Dubái es uno de los destinos turísticos favoritos para los que aprecian el lujo y el glamour. Viajar a Dubái contrasta por completo con todos los lugares baratos para viajar que puedes llegar a encontrar en cualquier otra guía de viaje.');

INSERT INTO Destinos (Nombre,Imagen,Pais,Zona,Descripcion)
VALUES ('','','','','');

INSERT INTO Destinos (Nombre,Imagen,Pais,Zona,Descripcion)
VALUES ('','','','','');

INSERT INTO Destinos (Nombre,Imagen,Pais,Zona,Descripcion)
VALUES ('','','','','');

INSERT INTO Destinos (Nombre,Imagen,Pais,Zona,Descripcion)
VALUES ('','','','','');


--INSERCION DEL ADMIN

INSERT INTO Usuarios (Nombre,Email,Password,ListaDestinos,TipoUsuarioID)
VALUES ('Admin','admin@mail.com','$2a$11$RAAeg.q237NgO5vQJIZf8.Q9VYD4FuqqPRNnDlPZRXcHOQm3g9Bdm',NULL,3);
