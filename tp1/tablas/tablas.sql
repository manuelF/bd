CREATE TABLE usuarios(
	idUsuario integer NOT NULL,
	username varchar NOT NULL,
	nombre varchar NOT NULL,
	apellido varchar NOT NULL,
	telefono integer,
	fechaNacimiento date,
	preferencias varchar,
	dirección varchar,
	profesion varchar
	email varchar,
	clavehash varchar,
	idClase integer,
	idPaisNacimiento integer,
	idClaseFrecuente integer
) Primary Key (idUsuario)
Foreign Key idClase idPaisNacimiento idClaseFrecuente

CREATE TABLE tarjetas(
	idUsuario integer NOT NULL,
	idTarjeta integer NOT NULL,
	empresa integer, 
	nroTarjeta integer NOT NULL,
	codigoSeguridad integer NOT NULL,
	direccion varchar
) Primary Key idTarjeta
Foreign Key idUsuario

CREATE TABLE ciudadesFavoritas(
	idUsuario integer NOT NULL,
	idCiudad integer NOT NULL
) Primary Key (idUsuario,idCiudad)
Foreign Key idUsuario idCiudad

CREATE TABLE reservas(
	idReserva integer NOT NULL,
	idUsuario integer NOT NULL,
	tipoPago varchar,
	fechaCaducidad date,
	datosViajante varchar, 
	idVueloConEscalas integer,
	idClase integer
) Primary Key (idReserva)
Foreign Key idUsuario idVueloConEscalas idClase

CREATE TABLE vuelosConEscalas(
	idViajeConEscalas integer NOT NULL,
	idViajePartida integer,
	idViajeLlegada integer
) Primary Key (idViajeConEscalas)
Foreign Key idViajePartida idViajeLlegada



CREATE TABLE preciosParaClase(
	idVueloConEscalas integer NOT NULL,
	isClase integer,
	precio money
) Primary Key (idVueloConEscalas,idClase)
Foreign Key idVueloConEscalas idClase


CREATE TABLE vuelosDirectos(
	idVuelo integer NOT NULL,
	idAeronave integer NOT NULL,
	fechaSalida datetime NOT NULL,
	fechaLlegada datetime NOT NULL,
	idAeropuertoSalida integer NOT NULL,
	idAeropuertoLlegada integer NOT NULL
) Primary Key (idVuelo)
Foreign Key idAeropuertoLlegada idAeropuertoSalida


CREATE TABLE haceEscalaEn(
	idVueloConEscalas integer NOT NULL,
	idVuelo integer NOT NULL,
	numeroEscala integer
) Primary Key (idVueloConEscalas,idVuelo)
Foreign Key idVueloConEscalas idVuelo


CREATE TABLE aeropuertos(
	idAeropuerto integer NOT NULL,
	tasa money,
	opcionesTransporte varchar,
	nombre varchar NOT NULL,
	idCiudad integer NOT NULL
) Primary Key (idAeropuerto)
Foreign Key idCiudad


CREATE TABLE telefonosAeropuertos(
	idAeropuerto integer NOT NULL,
	numero integer
) Primary Key (idAeropuerto,numero)
Foreign Key idAeropuerto


CREATE TABLE aeronaves(
	idAeronave integer NOT NULL,
	tripulacion varchar,
	millas integer,
	modelo varchar,
	idPaisOrigen integer NOT NULL
) Primary Key idAeronave
Foreign Key idPaisOrigen


CREATE TABLE paises(
	idPais integer NOT NULL,
	nombre varchar NOT NULL
) Primary Key (idPais)


CREATE TABLE ciudades(
	idCiudad integer NOT NULL,
	nombre varchar NOT NULL,
	idPais integer NOT NULL
) Primary Key (idCiudad)
Foreign Key idPais


CREATE TABLE clases(
	idClase integer NOT NULL,
	nombre varchar NOT NULL
) Primary Key idClase


CREATE TABLE disponeDeAsientos(
	idAeronave integer NOT NULL,
	idClase integer NOT NULL,
	asientos integer NOT NULL
) Primary Key (idAeronave,idClase)
Foreign Key idAeronave idClase


CREATE TABLE ciudadesFavoritas(
	idUsuario integer NOT NULL,
	idCiudad integer
) Primary Key (idUsuario,idCiudad)
Foreign Key idUsuario idCiudad
