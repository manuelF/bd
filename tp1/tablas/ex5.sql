CREATE PROCEDURE cancelar_reserva_duplicada(IN idReserva INTEGER)
LANGUAGE SQL
BEGIN

	DECLARE fechaSalida AS DATE;
	DECLARE fechaLlegada AS DATE;
	
	DECLARE idAeropuertoSalida AS INTEGER;
	DECLARE idAeropuertoLLegada AS INTEGER;
	
	-- Conseguimos la fecha y aeropuerto de salida
	SELECT v.fechaSalida, v.aeropuertoSalida
		INTO fechaSalida,idAeropuertoSalida
		FROM vuelos v, vueloConEscalas ve, reservas re
		WHERE v.idVuelo = ve.idVueloPartida AND
			  ve.idVueloConEscalas = re.idVueloConEscalas AND
			  re.idReserva = idReserva;

	-- Conseguimos la fecha y aeropuerto de llegada
	SELECT v.fechaLlegada, v.aeropuertoLlegada
		INTO fechaLlegada,idAeropuertoLlegada
		FROM vuelos v, vueloConEscalas ve, reservas re
		WHERE v.idVuelo = ve.idVueloLlegada AND
			  ve.idVueloConEscalas = re.idVueloConEscalas AND
			  re.idReserva = idReserva;

	DELETE FROM reservas AS r1 
	WHERE r1.idReserva = (
		-- La reserva es la minima con respecto al precio, 
		-- que tiene el mismo aeropuerto de salida y de llegada y que 
		-- no se superpone dentro de los proximos 7 dias
		
		SELECT r.idReserva 
		FROM reservas r, vuelos v, vuelos vv, vuelosConEscala ve,precioPorClase ppc
		WHERE r.idVueloConEscalas = ve.idVueloConEscalas
			AND v.idVuelo = ve.idVueloPartida
			AND vv.idVuelo = ve.idVueloLlegada
			AND v.idAeropuertoSalida = idAeropuertoSalida
			AND vv.idAeropuertoLlegada = idAeropuertoLlegada
			AND v.fechaSalida <= DATEADD(DAY,7,fechaSalida)
			AND ppc.idClase = r.idClase
			AND ppc.idVueloConEscalas = r.idVueloConEscalas
			AND ppc.idClase = r.idClase
		ORDER BY ppr.precio DESC LIMIT 1;
	);
END
