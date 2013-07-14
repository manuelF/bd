IF OBJECT_ID ('RestringirReservasUsuario','TR') IS NOT NULL
   DROP TRIGGER RestringirReservasUsuario;
GO

CREATE TRIGGER RestringirReservasUsuario ON Reservas
	AFTER INSERT
AS 
	DECLARE @fechaSalida DATETIME
	DECLARE @fechaLlegada DATETIME
					
	DECLARE @idAeropuertoSalida INTEGER
	DECLARE @idAeropuertoLlegada INTEGER

	-- Conseguimos las fechas y aeropuertos 
	-- de salida y llegada
	SELECT @fechaSalida=v.fechaSalida, @idAeropuertoSalida=v.aeropuertoSalida
		FROM vuelos v,vuelosConEscalas ve, reservas,inserted as new
			WHERE v.idVuelo = ve.idVueloPartida
			AND ve.idVueloConEscalas = new.idViajeConEscalas

	SELECT @fechaLlegada=v.fechaLlegada, @fechaSalida=v.idAeropuertoLlegada
		FROM vuelos v,vuelosConEscalas ve, reservas, inserted as new
			WHERE v.idVuelo = ve.idVueloLlegada
			AND ve.idVueloConEscalas = new.idViajeConEscalas
	-- Conseguimos el aeropuerto de llegada y el de salida
	
	-- Nos fijamos si una reserva con distinto aeropuerto 
	-- se superpone 	
	SELECT r.idReserva AS idReserva
		FROM reservas r,vuelos v,vuelosConEscalas ve,
			 haceEscalaEn he, inserted as new
			WHERE v.fechaSalida <= @fechaSalida
				AND v.fechaLlegada >= @fechaLlegada
				AND he.idVuelo = v.idVuelo
				AND he.idVueloConEscalas = r.idVueloConEscalas
				AND r.idReserva = new.idUsuario
		EXCEPT
		SELECT r.idReserva AS idReserva
			FROM reservas r, vuelos v, haceEscalaEn he
			WHERE v.idAeropuertoSalida = @idAeropuertoSalida
				AND v.idVuelo = he.idVuelo
				AND v.idVueloConEscalas = r.idVueloConEscalas
		 INTERSECT
		 SELECT r.idReserva AS idReserva
			FROM reservas r, vuelos v, haceEscalaEn he
			WHERE v.idAeropuertoLlegada = @idAeropuertoLlegada
				AND v.idVuelo = he.idVuelo
				AND v.idVueloConEscalas = r.idVueloConEscalas

	IF(@@ROWCOUNT > 0)
		BEGIN 
			RAISERROR ('Reservas se superponen',10,1)
			ROLLBACK TRANSACTION
			RETURN
		END
	
	-- Nos fijamos si hay mas de 2 reservas con esa fecha 
	-- de partida igual aeropuerto
	SELECT r.idReservas
		FROM reservas r,vuelos v,vuelosConEscala ve
		WHERE r.idVuelosConEscalas = ve.idVueloConEscalas
			AND v.idVuelo = ve.idVueloPartida
			AND v.idAeropuertoLlegada = @idAeropuertoLlegada
			AND v.fechaSalida = @fechaSalida
	INTERSECT
	SELECT r.idReservas
   		FROM reservas r,vuelos v,vuelosConEscala ve
		WHERE r.idVueloConEscalas = ve.idVueloConEscalas
			AND v.idVuelo = ve.idVueloPartida
			AND v.idAeropuertoLlegada = @idAeropuertoLlegada
			AND v.fechaLlegada = @fechaLlegada
	
	if(@@ROWCOUNT > 1)
		BEGIN
			RAISERROR ('Mas de dos reservas por aeropuerto',10,1)
			ROLLBACK TRANSACTION
			RETURN
		END

	-- Nos fijamos si, habiendo una reserva, la reserva tiene 
	-- fecha de partida en los proximos dias	
	IF(@@ROWCOUNT = 1)
		BEGIN
			IF @fechaSalida >= DATEADD(day,7,GETDATE()) 
			BEGIN
				RAISERROR('La reserva es para dentro de mas de 7 dias',10,1)
				ROLLBACK TRANSACTION
				RETURN
			END
		END