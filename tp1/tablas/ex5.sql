USE Aerolinea
GO

IF OBJECT_ID ( 'cancelarReservaDuplicada', 'P' ) IS NOT NULL 
    DROP PROCEDURE cancelarReservaDuplicada;
GO

CREATE PROCEDURE cancelarReservaDuplicada(@idReserva INTEGER)
AS
	DECLARE @fechaSalida DATETIME;
	DECLARE @fechaLlegada DATETIME;
	
	DECLARE @idAeropuertoSalida INTEGER;
	DECLARE @idAeropuertoLLegada INTEGER;
	
	DECLARE @usuario INTEGER

	-- Conseguimos el usuario de la reserva nueva
	SELECT @usuario=reservas.idUsuario FROM reservas 
	WHERE reservas.idReserva=@idReserva
	
	-- Conseguimos la fecha y aeropuerto de salida
	SELECT @fechaSalida=v.fechaSalida, @idAeropuertoSalida=v.idAeropuertoSalida
		FROM vuelosDirectos v, vuelosConEscalas ve, reservas re
		WHERE v.idVuelo = ve.idVueloPartida AND
			  ve.idVueloConEscalas = re.idVueloConEscalas AND
			  re.idReserva = @idReserva;

	-- Conseguimos la fecha y aeropuerto de llegada
	SELECT @fechaLlegada=v.fechaLlegada, @idAeropuertoLlegada=v.idAeropuertoLlegada
		FROM vuelosDirectos v, vuelosConEscalas ve, reservas re
		WHERE v.idVuelo = ve.idVueloLlegada AND
			  ve.idVueloConEscalas = re.idVueloConEscalas AND
			  re.idReserva = @idReserva;

	DECLARE @reservaABorrar AS INT;

	-- Borramos la reserva que se superponga en los proximos 7 dias, tenga
	-- mismo aeropuerto de llegada y salida y misma fecha de llegada y salida
	-- y que sea la mas barata
	SELECT TOP 1 @reservaABorrar=r.idReserva 
		FROM reservas r, vuelosDirectos v, vuelosDirectos vv, 
				vuelosConEscalas ve, preciosParaClase ppc
		WHERE r.idUsuario = @usuario AND
			r.idVueloConEscalas = ve.idVueloConEscalas
			AND v.idVuelo = ve.idVueloPartida
			AND vv.idVuelo = ve.idVueloLlegada
			AND v.idAeropuertoSalida = @idAeropuertoSalida
			AND vv.idAeropuertoLlegada = @idAeropuertoLlegada
			AND v.fechaSalida <= DATEADD(DAY,7,@fechaSalida)
			AND ppc.idClase = r.idClase
			AND ppc.idVueloConEscalas = r.idVueloConEscalas
			AND ppc.idClase = r.idClase
		ORDER BY ppc.precio ASC

	DELETE FROM reservas WHERE idReserva=@reservaABorrar	
	GO