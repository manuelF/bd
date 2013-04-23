CREATE TRIGGER RestringirReservasUsuario ON Reservas
	BEFORE INSERT
	FOR EACH ROW

	BEGIN

	DECLARE fechaSalida AS DATE
	DECLARE fechaLlegada AS DATE
					
	-- Conseguimos las fechas de salida y llegada
	SELECT v.fechaSalida INTO fechaSalida 
		FROM vuelos v,vuelosConEscalas ve, EsReservaDe er
			WHERE v.idVuelo = ve.idVueloPartida
			AND ve.idVueloConEscalas = er.idVueloConEscalas
			AND er.idReserva = :NEW.idReserva

	SELECT v.fechaLlegada INTO fechaLlegada
	FROM vuelos v,vuelosConEscalas ve, EsReservaDe er
	WHERE v.idVuelo = ve.idVueloLlegada
	AND ve.idVueloConEscalas = er.idVueloConEscalas
	AND er.idReserva = :NEW.idReserva
				
	-- Nos fijamos si una reserva se superpone
	IF( SELECT COUNT(*) FROM reservas WHERE EXISTS
		( SELECT * FROM vuelos v,vuelosConEscala ve,
			EsReservaPara ep,Reservas r, Usuario u
			WHERE v.fechaSalida <= fechaSalida
				AND v.fechaLlegada >= fechaLlegada
				AND v.
		)
	> 0)
		BEGIN
						

			RAISEERROR ('Restriccion de reservas violada')
			ROLLBACK TRANSACTION
		END
	END
