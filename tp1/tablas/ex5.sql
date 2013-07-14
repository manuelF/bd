CREATE PROCEDURE cancelarReservaDuplicada(@idReserva INTEGER)
AS
	DECLARE @fechaSalida DATETIME;
	DECLARE @fechaLlegada DATETIME;
	
	DECLARE @idAeropuertoSalida INTEGER;
	DECLARE @idAeropuertoLLegada INTEGER;
	
	-- Conseguimos la fecha y aeropuerto de salida
	SELECT @fechaSalida=v.fechaSalida, @idAeropuertoSalida=v.idAeropuertoSalida
		FROM vuelosDirectos v, vuelosConEscalas ve, reservas re
		WHERE v.idVuelo = ve.idVueloPartida AND
			  ve.idVueloConEscalas = re.idVueloConEscalas AND
			  re.idReserva = idReserva;

	-- Conseguimos la fecha y aeropuerto de llegada
	SELECT @fechaLlegada=v.fechaLlegada, @idAeropuertoLlegada=v.idAeropuertoLlegada
		FROM vuelosDirectos v, vuelosConEscalas ve, reservas re
		WHERE v.idVuelo = ve.idVueloLlegada AND
			  ve.idVueloConEscalas = re.idVueloConEscalas AND
			  re.idReserva = idReserva;

	DELETE FROM reservas WHERE idReserva = (
		-- La reserva es la minima con respecto al precio, 
		-- que tiene el mismo aeropuerto de salida y de llegada y que 
		-- no se superpone dentro de los proximos 7 dias
		
		SELECT TOP 1 r.idReserva 
		FROM reservas r, vuelosDirectos v, vuelosDirectos vv, 
				vuelosConEscalas ve, preciosParaClase ppc
		WHERE r.idVueloConEscalas = ve.idVueloConEscalas
			AND v.idVuelo = ve.idVueloPartida
			AND vv.idVuelo = ve.idVueloLlegada
			AND v.idAeropuertoSalida = @idAeropuertoSalida
			AND vv.idAeropuertoLlegada = @idAeropuertoLlegada
			AND v.fechaSalida <= DATEADD(DAY,7,@fechaSalida)
			AND ppc.idClase = r.idClase
			AND ppc.idVueloConEscalas = r.idVueloConEscalas
			AND ppc.idClase = r.idClase
		ORDER BY ppc.precio DESC
	);