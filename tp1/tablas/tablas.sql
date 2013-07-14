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
	idClase integer,
	idPaisNacimiento integer,
	idClaseFrecuente integer,
    Primary Key (idUsuario),

    CONSTRAINT idClase
        REFERENCES clases(idClase),

    CONSTRAINT idPaisNacimiento
        REFERENCES paises(idPais),

    CONSTRAINT idClaseFrecuente
        REFERENCES clases(idClase)
    
);


CREATE TABLE tarjetas(
	idUsuario integer NOT NULL,
	idTarjeta integer NOT NULL,
	empresa integer, 
	nroTarjeta integer NOT NULL,
	codigoSeguridad integer NOT NULL,
	direccion varchar(100),
    Primary Key idTarjeta,
    
    CONSTRAINT idUsuario
        REFERENCES usuarios(idUsuario)
);


CREATE TABLE ciudadesFavoritas(
	idUsuario integer NOT NULL,
	idCiudad integer NOT NULL,
    Primary Key (idUsuario,idCiudad),
    
    CONSTRAINT idUsuario
        REFERENCES usuarios(idUsuario),
        
    CONSTRAINT idCiudad
        REFERENCES ciudades(idCiudad)
);


CREATE TABLE reservas(
	idReserva integer NOT NULL,
	idUsuario integer NOT NULL,
	tipoPago varchar(100),
	fechaCaducidad date,
	datosViajante varchar(100), 
	idVueloConEscalas integer,
	idClase integer,
    Primary Key (idReserva),
    
    CONSTRAINT idUsuario
        REFERENCES usuarios(idUsuario),

    CONSTRAINT idVueloConEscalas
        REFERENCES vuelosConEscalas(idVueloConEscalas), -- NOT SURE
        
    CONSTRAINT idClase
        REFERENCES clases(idClase)
            
);


CREATE TABLE vuelosConEscalas(
	idViajeConEscalas integer NOT NULL,
	idViajePartida integer,
	idViajeLlegada integer,
    Primary Key (idViajeConEscalas),

    -- NO SE CUALES VAN
    
);
Foreign Key idViajePartida idViajeLlegada


CREATE TABLE preciosParaClase(
	idVueloConEscalas integer NOT NULL,
	isClase integer,
	precio money,
    Primary Key (idVueloConEscalas,idClase),
    
    CONSTRAINT idVueloConEscalas
        REFERENCES vuelosConEscalas(idViajeConEscalas),
        -- NO SE SI ES VUELO O VIAJE


    CONSTRAINT idClase
        REFERENCES clases(idClase)

);

CREATE TABLE vuelosDirectos(
	idVuelo integer NOT NULL,
	idAeronave integer NOT NULL,
	fechaSalida datetime NOT NULL,
	fechaLlegada datetime NOT NULL,
	idAeropuertoSalida integer NOT NULL,
	idAeropuertoLlegada integer NOT NULL,
    Primary Key (idVuelo),
    

    CONSTRAINT idAeropuertoLlegada
        REFERENCES aeropuertos(idAeropuerto),
        

    CONSTRAINT idAeropuertoSalida
        REFERENCES aeropuertos(idAeropuerto)
);


CREATE TABLE haceEscalaEn(
	idVueloConEscalas integer NOT NULL,
	idVuelo integer NOT NULL,
	numeroEscala integer,
    Primary Key (idVueloConEscalas,idVuelo),
    
    CONSTRAINT idVueloConEscalas
        REFERENCES vuelosConEscalas(idViajeConEscalas),
        

    CONSTRAINT idVuelo
        REFERENCES vuelosDirectos(idVuelo)
);
Foreign Key idVueloConEscalas idVuelo


CREATE TABLE aeropuertos(
	idAeropuerto integer NOT NULL,
	tasa money,
	opcionesTransporte varchar(100),
	nombre varchar(100) NOT NULL,
	idCiudad integer NOT NULL,
    Primary Key (idAeropuerto),
    
    CONSTRAINT idCiudad
        REFERENCES ciudades(idCiudad)
);


CREATE TABLE telefonosAeropuertos(
	idAeropuerto integer NOT NULL,
	numero integer,
    Primary Key (idAeropuerto,numero),
    
    CONSTRAINT idAeropuerto
        REFERENCES aeropuertos(idAeropuerto)
);



CREATE TABLE aeronaves(
	idAeronave integer NOT NULL,
	tripulacion varchar(100),
	millas integer,
	modelo varchar(100),
	idPaisOrigen integer NOT NULL,
    Primary Key idAeronave,

    CONSTRAINT idPaisOrigen
        REFERENCES paises(idPais)
);


CREATE TABLE paises(
	idPais integer NOT NULL,
	nombre varchar(100) NOT NULL,
    Primary Key (idPais)
);


CREATE TABLE ciudades(
	idCiudad integer NOT NULL,
	nombre varchar(100) NOT NULL,
	idPais integer NOT NULL,
    Primary Key (idCiudad),
    
    CONSTRAINT idPais
        REFERENCES paises(idPais)
);


CREATE TABLE clases(
	idClase integer NOT NULL,
	nombre varchar(100) NOT NULL,
    Primary Key idClase
); 


CREATE TABLE disponeDeAsientos(
	idAeronave integer NOT NULL,
	idClase integer NOT NULL,
	asientos integer NOT NULL,
    Primary Key (idAeronave,idClase),
    
    CONSTRAINT idAeronave
        REFERENCES aeronaves(idAeronave),

    CONSTRAINT idClase
        REFERENCES clases(idClase)

);


CREATE TABLE ciudadesFavoritas(
	idUsuario integer NOT NULL,
	idCiudad integer,
    Primary Key (idUsuario,idCiudad),

    CONSTRAINT idUsuario
        REFERENCES usuarios(idUsuario),
        
    CONSTRAINT idCiudad
        REFERENCES ciudades(idCiudad)
    
);

