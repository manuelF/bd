CREATE TABLE usuarios(
	idUsuario integer NOT NULL,
	username varchar
	nombre varchar
	apellido varchar
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
	idUsuario integer,
	idTarjeta integer,
	empresa integer, 
	nroTarjeta integer,
	codigoSeguridad integer,
	direccion varchar
) Primary Key idTarjeta
Foreign Key idUsuario

CREATE TABLE ciudadesFavoritas(
	idUsuario integer,
	idCiudad integer
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
	idViajeConEscalas integer,
	idViajePartida integer,
	idViajeLlegada integer
) Primary Key (idViajeConEscalas)
Foreign Key idViajePartida idViajeLlegada



CREATE TABLE preciosParaClase(
	idVueloConEscalas integer,
	isClase integer,
	precio money
) Primary Key (idVueloConEscalas,idClase)
Foreign Key idVueloConEscalas idClase


CREATE TABLE vuelosDirectos(
	idVuelo integer,
	idAeronave integer,
	fechaSalida datetime,
	fechaLlegada datetime,
	idAeropuertoSalida integer,
	idAeropuertoLlegada integer
) Primary Key (idVuelo)
Foreign Key idAeropuertoLlegada idAeropuertoSalida


CREATE TABLE haceEscalaEn(
	idVueloConEscalas integer,
	idVuelo integer,
	numeroEscala integer
) Primary Key (idVueloConEscalas,idVuelo)
Foreign Key idVueloConEscalas idVuelo


CREATE TABLE aeropuertos(
	idAeropuerto integer,
	tasa money,
	opcionesTransporte varchar,
	nombre varchar,
	idCiudad integer
) Primary Key (idAeropuerto)
Foreign Key idCiudad



CREATE TABLE telefonosAeropuertos(
	idAeropuerto integer,
	numero integer
) Primary Key (idAeropuerto,numero)
Foreign Key idAeropuerto


CREATE TABLE aeronaves(
	idAeronave integer,
	triplacion varchar,
	millas integer,
	modelo varchar,
	idPaisOrigen integer
) Primary Key idAeronave
Foreign Key idPaisOrigen


CREATE TABLE paises(
	idPais integer,
	nombre varchar
) Primary Key (idPais)


CREATE TABLE ciudades(
	idCiudad integer,
	nombre varchar,
	idPais integer
) Primary Key (idCiudad)
Foreign Key idPais


CREATE TABLE clases(
	idClase integer,
	nombre varchar
) Primary Key idClase


CREATE TABLE disponeDeAsientos(
	idAeronave integer,
	idClase integer,
	asientos integer
) Primary Key (idAeronave,idClase)
Foreign Key idAeronave idClase


CREATE TABLE ciudadesFavoritas(
	idUsuario integer,
	idCiudad integer
) Primary Key (idUsuario,idCiudad)
Foreign Key idUsuario idCiudad
