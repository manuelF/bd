USE Aerolinea;

CREATE TABLE paises(
	idPais INTEGER IDENTITY NOT NULL,
	nombre VARCHAR(255) NOT NULL,
    PRIMARY KEY (idPais)
);

CREATE TABLE ciudades(
	idCiudad INTEGER IDENTITY NOT NULL,
	nombre VARCHAR(255) NOT NULL,
	idPais INTEGER NOT NULL
        FOREIGN KEY REFERENCES paises(idPais),
    PRIMARY KEY (idCiudad)    
);

CREATE TABLE aeropuertos(
	idAeropuerto INTEGER IDENTITY NOT NULL,
	tasa MONEY,
	opcionesTransporte VARCHAR(255),
	nombre VARCHAR(255) NOT NULL,
	idCiudad INTEGER NOT NULL
        FOREIGN KEY REFERENCES ciudades(idCiudad),
    PRIMARY KEY (idAeropuerto)
);

CREATE TABLE telefonosAeropuertos(
	idAeropuerto INTEGER NOT NULL
        FOREIGN KEY REFERENCES aeropuertos(idAeropuerto),
	numero INTEGER,
    PRIMARY KEY(idAeropuerto,numero)
);


CREATE TABLE clases(
	idClase INTEGER IDENTITY NOT NULL,
	nombre VARCHAR(255) NOT NULL,
    PRIMARY KEY (idClase)
); 

CREATE TABLE aeronaves(
	idAeronave INTEGER IDENTITY NOT NULL,
	tripulacion VARCHAR(255),
	millas INTEGER,
	modelo VARCHAR(255),
	idPaisOrigen INTEGER NOT NULL
        FOREIGN KEY REFERENCES paises(idPais),
    PRIMARY KEY(idAeronave)
);


CREATE TABLE vuelosDirectos(
	idVuelo INTEGER IDENTITY NOT NULL,
	idAeronave INTEGER NOT NULL,
	fechaSalida DATETIME NOT NULL,
	fechaLlegada DATETIME NOT NULL,
	idAeropuertoSalida INTEGER NOT NULL
        FOREIGN KEY REFERENCES aeropuertos(idAeropuerto),
	idAeropuertoLlegada INTEGER NOT NULL
        FOREIGN KEY REFERENCES aeropuertos(idAeropuerto),
    PRIMARY KEY(idVuelo)
);


CREATE TABLE usuarios(
	idUsuario INTEGER IDENTITY NOT NULL,
	username VARCHAR(100) NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	telefono INTEGER,
	fechaNacimiento DATE,
	preferencias VARCHAR(255),
	dirección VARCHAR(255),
	profesion VARCHAR(255),
	email VARCHAR(255),
	clavehash VARCHAR(255),
	idPaisNacimiento INTEGER FOREIGN KEY REFERENCES paises(idPais),
	idClaseFrecuente INTEGER FOREIGN KEY REFERENCES clases(idClase),
    Primary Key (idUsuario)
);


CREATE TABLE disponeDeAsientos(
	idAeronave INTEGER NOT NULL
        FOREIGN KEY REFERENCES aeronaves(idAeronave),
	idClase INTEGER NOT NULL
        FOREIGN KEY REFERENCES clases(idClase),
	asientos INTEGER NOT NULL,
    PRIMARY KEY (idAeronave,idClase)
);


CREATE TABLE ciudadesFavoritas(
	idUsuario INTEGER NOT NULL
        FOREIGN KEY REFERENCES usuarios(idUsuario),
	idCiudad INTEGER
        FOREIGN KEY REFERENCES ciudades(idCiudad),
    PRIMARY KEY (idUsuario,idCiudad)    
);


CREATE TABLE tarjetas(
	nroTarjeta INTEGER NOT NULL,
	idUsuario INTEGER NOT NULL FOREIGN KEY REFERENCES usuarios(idUsuario),
	empresa VARCHAR(255),
	codigoSeguridad INTEGER NOT NULL,
	direccion VARCHAR(255),
    PRIMARY KEY (nroTarjeta)        
);

CREATE TABLE vuelosConEscalas(
	idVueloConEscalas INTEGER IDENTITY NOT NULL,
	idVueloPartida INTEGER FOREIGN KEY REFERENCES vuelosDirectos(idVuelo),
	idVueloLlegada INTEGER FOREIGN KEY REFERENCES vuelosDirectos(idVuelo),
    PRIMARY KEY (idVueloConEscalas)
);

CREATE TABLE preciosParaClase(
	idVueloConEscalas INTEGER NOT NULL FOREIGN KEY REFERENCES vuelosConEscalas(idVueloConEscalas),
	idClase INTEGER FOREIGN KEY REFERENCES clases(idClase),
	precio MONEY,
    PRIMARY KEY (idVueloConEscalas,idClase)
);

CREATE TABLE reservas(
	idReserva INTEGER IDENTITY NOT NULL,
	idUsuario INTEGER NOT NULL FOREIGN KEY REFERENCES usuarios(idUsuario),
	tipoPago VARCHAR(255),
	fechaCaducidad DATE,
	datosViajante VARCHAR(255), 
	idVueloConEscalas INTEGER FOREIGN KEY REFERENCES vuelosConEscalas(idVueloConEscalas), -- NOT SURE
	idClase INTEGER FOREIGN KEY REFERENCES clases(idClase),
    PRIMARY KEY (idReserva)
);

CREATE TABLE haceEscalaEn(
	idVueloConEscalas INTEGER NOT NULL
        FOREIGN KEY REFERENCES vuelosConEscalas(idVueloConEscalas),
	idVuelo integer NOT NULL
        FOREIGN KEY REFERENCES vuelosDirectos(idVuelo),
	numeroEscala INTEGER,
    PRIMARY KEY (idVueloConEscalas,idVuelo)    
);