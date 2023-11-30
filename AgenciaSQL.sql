--Primera porcion de Codigo sql

CREATE DATABASE Agencia;
USE Agencia;
-- Creación de la tabla de Usuarios
CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50),
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
    TipoActividad NVARCHAR(50),
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
