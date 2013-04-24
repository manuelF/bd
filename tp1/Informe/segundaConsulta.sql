CREATE TRIGGER RestringirReservasUsuario ON Reservas
	BEFORE INSERT
	FOR EACH ROW

	BEGIN

	DECLARE fechaSalida AS DATE
	DECLARE fechaLlegada AS DATE
					
	DECLARE idAeropuertoSalida	AS INTEGER
	DECLARE idAeropuertoLlegada AS INTEGER

	-- Conseguimos las fechas y aeropuertos 
	-- de salida y llegada
	SELECT v.fechaSalida, v.aeropuertoSalida INTO 
		fechaSalida, idAeropuertoSalida
		FROM vuelos v,vuelosConEscalas ve, reservas
			WHERE v.idVuelo = ve.idVueloPartida
			AND ve.idVueloConEscalas = :NEW.idViajeConEscalas

	SELECT v.fechaLlegada, v.idAeropuertoLlegada INTO 
		fechaLlegada,idAeropuertoLlegada
		FROM vuelos v,vuelosConEscalas ve, reservas
			WHERE v.idVuelo = ve.idVueloLlegada
			AND ve.idVueloConEscalas = :NEW.idViajeConEscalas

	-- Conseguimos el aeropuerto de llegada y el de salida
	
	-- Nos fijamos si una reserva con distinto aeropuerto 
	-- se superpone 	
	SELECT r.idReserva AS idReserva
		FROM reservas r,vuelos v,vuelosConEscalas ve,
			 haceEscalaEn he
			WHERE v.fechaSalida <= fechaSalida
				AND v.fechaLlegada >= fechaLlegada
				AND he.idVuelo = v.idVuelo
				AND he.idVueloConEscalas = r.idVueloConEscalas
				AND r.idReserva = :NEW.idUsuario
		MINUS
		SELECT r.idReserva AS idReserva
			FROM reservas r, vuelos v, haceEscalaEn he
			WHERE v.idAeropuertoSalida = idAeropuertoSalida
				AND v.idVuelo = he.idVuelo
				AND v.idVueloConEscalas = r.idVueloConEscalas
		 INTERSECT
		 SELECT r.idReserva AS idReserva
			FROM reservas r, vuelos v, haceEscalaEn he
			WHERE v.idAeropuertoLlegada = idAeropuertoLlegada
				AND v.idVuelo = he.idVuelo
				AND v.idVueloConEscalas = r.idVueloConEscalas
	
	IF(@@ROWCOUNT > 0)
		BEGIN 
			RAISEERROR ('Reservas se superponen')
			ROLLBACK TRANSACTION
		END
	
	-- Nos fijamos si hay mas de 2 reservas con esa fecha 
	-- de partida igual aeropuerto
	SELECT r.idReservas
		FROM reservas r,vuelos v,vuelosConEscala ve
		WHERE r.idVuelosConEscalas = ve.idVueloConEscalas
			AND v.idVuelo = ve.idVueloPartida
			AND v.idAeropuertoLlegada = idAeropuertoLlegada
			AND v.fechaSalida = fechaSalida
	INTERSECT
	SELECT r.idReservas
   		FROM reservas r,vuelos v,vuelosConEscala ve
		WHERE r.idVueloConEscalas = ve.idVueloConEscalas
			AND v.idVuelo = ve.idVueloPartida
			AND v.idAeropuertoLlegada = idAeropuertoLlegada
			AND v.fechaLlegada = fechaLlegada
	
	if @@ROWCOUNT > 1
		BEGIN
			RAISEERROR ('Mas de dos reservas por aeropuerto')
			ROLLBACK TRANSACTION
		END

	-- Nos fijamos si, habiendo una reserva, la reserva tiene 
	-- fecha de partida en los proximos dias	
	IF @@ROWCOUNT = 1
		BEGIN
			IF fechaSalida >= DATEADD(fechaSalida,DATEADD(day,7,GETDATE()))
			BEGIN
				RAISEERROR('La reserva es para dentro de mas de 7 dias')
				ROLLBACK TRANSACTION
			END
		END
	END
