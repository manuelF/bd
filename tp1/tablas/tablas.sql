CREATE TABLE usuarios(
	idUsuario integer NOT NULL,
	username varchar(100) NOT NULL,
	nombre varchar(100) NOT NULL,
	apellido varchar(100) NOT NULL,
	telefono integer,
	fechaNacimiento date,
	preferencias varchar(100),
	dirección varchar(100),
	profesion varchar(100)
	email varchar(100),
	clavehash varchar(100),
	idClase integer FOREIGN KEY REFERENCES clases(idClase),
	idPaisNacimiento integer FOREIGN KEY REFERENCES paises(idPais),
	idClaseFrecuente integer FOREIGN KEY REFERENCES clases(idClase),
    Primary Key (idUsuario)     
    
);


CREATE TABLE tarjetas(
	idUsuario integer NOT NULL FOREIGN KEY REFERENCES usuarios(idUsuario),
	idTarjeta integer NOT NULL,
	empresa integer, 
	nroTarjeta integer NOT NULL,
	codigoSeguridad integer NOT NULL,
	direccion varchar(100),
    Primary Key (idTarjeta)
    
        
);


CREATE TABLE ciudadesFavoritas(
	idUsuario integer NOT NULL FOREIGN KEY REFERENCES usuarios(idUsuario),
	idCiudad integer NOT NULL FOREIGN KEY REFERENCES ciudades(idCiudad),
    Primary Key (idUsuario,idCiudad)
           
);


CREATE TABLE reservas(
	idReserva integer NOT NULL,
	idUsuario integer NOT NULL FOREIGN KEY REFERENCES usuarios(idUsuario),
	tipoPago varchar(100),
	fechaCaducidad date,
	datosViajante varchar(100), 
	idVueloConEscalas integer FOREIGN KEY REFERENCES vuelosConEscalas(idVueloConEscalas), -- NOT SURE
	idClase integer FOREIGN KEY REFERENCES clases(idClase),
    Primary Key (idReserva)
);


CREATE TABLE vuelosConEscalas(
	idViajeConEscalas integer NOT NULL,
	idViajePartida integer FOREIGN KEY REFERENCES vuelosDirectos(idVuelo),
	idViajeLlegada integer FOREIGN KEY REFERENCES vuelosDirectos(idVuelo),
    Primary Key (idViajeConEscalas)

    -- NO SE CUALES VAN
    
);
Foreign Key idViajePartida idViajeLlegada


CREATE TABLE preciosParaClase(
	idVueloConEscalas integer NOT NULL FOREIGN KEY REFERENCES vuelosConEscalas(idViajeConEscalas),
	idClase integer FOREIGN KEY REFERENCES clases(idClase),
	precio money,
    Primary Key (idVueloConEscalas,idClase)

);

CREATE TABLE vuelosDirectos(
	idVuelo integer NOT NULL,
	idAeronave integer NOT NULL,
	fechaSalida datetime NOT NULL,
	fechaLlegada datetime NOT NULL,
	idAeropuertoSalida integer NOT NULL 
        FOREIGN KEY REFERENCES aeropuertos(idAeropuerto),
        
	idAeropuertoLlegada integer NOT NULL
        FOREIGN KEY REFERENCES aeropuertos(idAeropuerto),
        
    Primary Key (idVuelo)
);


CREATE TABLE haceEscalaEn(
	idVueloConEscalas integer NOT NULL
        FOREIGN KEY REFERENCES vuelosConEscalas(idViajeConEscalas),
	idVuelo integer NOT NULL
        FOREIGN KEY REFERENCES vuelosDirectos(idVuelo)
	numeroEscala integer,
    Primary Key (idVueloConEscalas,idVuelo)
    
);


CREATE TABLE aeropuertos(
	idAeropuerto integer NOT NULL,
	tasa money,
	opcionesTransporte varchar(100),
	nombre varchar(100) NOT NULL,
	idCiudad integer NOT NULL
        FOREIGN KEY REFERENCES ciudades(idCiudad),
    Primary Key (idAeropuerto)
    
);


CREATE TABLE telefonosAeropuertos(
	idAeropuerto integer NOT NULL
        FOREIGN KEY REFERENCES aeropuertos(idAeropuerto),
	numero integer,
    Primary Key (idAeropuerto,numero)
    
);



CREATE TABLE aeronaves(
	idAeronave integer NOT NULL,
	tripulacion varchar(100),
	millas integer,
	modelo varchar(100),
	idPaisOrigen integer NOT NULL
        FOREIGN KEY REFERENCES paises(idPais),
    Primary Key idAeronave


);


CREATE TABLE paises(
	idPais integer NOT NULL,
	nombre varchar(100) NOT NULL,
    Primary Key (idPais)
);


CREATE TABLE ciudades(
	idCiudad integer NOT NULL,
	nombre varchar(100) NOT NULL,
	idPais integer NOT NULL
        FOREIGN KEY REFERENCES paises(idPais),
    Primary Key (idCiudad)    
);


CREATE TABLE clases(
	idClase integer NOT NULL,
	nombre varchar(100) NOT NULL,
    Primary Key (idClase)
); 


CREATE TABLE disponeDeAsientos(
	idAeronave integer NOT NULL
        FOREIGN KEY REFERENCES aeronaves(idAeronave),
	idClase integer NOT NULL
        FOREIGN KEY REFERENCES clases(idClase)
	asientos integer NOT NULL,
    Primary Key (idAeronave,idClase)

    

);


CREATE TABLE ciudadesFavoritas(
	idUsuario integer NOT NULL
        FOREIGN KEY REFERENCES usuarios(idUsuario),
	idCiudad integer
        FOREIGN KEY REFERENCES ciudades(idCiudad)
    Primary Key (idUsuario,idCiudad)

    
);

