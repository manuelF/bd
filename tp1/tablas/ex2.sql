IF OBJECT_ID ('RestringirReservasUsuario','TR') IS NOT NULL
   DROP TRIGGER RestringirReservasUsuario;
GO

CREATE TRIGGER RestringirReservasUsuario ON Aerolinea.dbo.reservas
	AFTER INSERT
AS 
	DECLARE @fechaSalida DATETIME
	DECLARE @fechaLlegada DATETIME
					
	DECLARE @idAeropuertoSalida INTEGER
	DECLARE @idAeropuertoLlegada INTEGER

	DECLARE @usuario INTEGER
	DECLARE @idVuelo INTEGER
		
	SELECT @usuario=inserted.idUsuario,@idVuelo = idVueloConEscalas FROM inserted
	
	-- Conseguimos las fechas y aeropuertos 
	-- de salida y llegada
	SELECT @fechaSalida=v.fechaSalida, @idAeropuertoSalida=v.idAeropuertoSalida
		FROM vuelosDirectos v,vuelosConEscalas ve, reservas,inserted as new
			WHERE v.idVuelo = ve.idVueloPartida
			AND ve.idVueloConEscalas = new.idVueloConEscalas

	SELECT @fechaLlegada=v.fechaLlegada, @fechaSalida=v.idAeropuertoLlegada
		FROM vuelosDirectos v,vuelosConEscalas ve, reservas, inserted as new
			WHERE v.idVuelo = ve.idVueloLlegada
			AND ve.idVueloConEscalas = new.idVueloConEscalas

	-- Conseguimos el aeropuerto de llegada y el de salida
	
	-- Nos fijamos si una reserva con distinto aeropuerto 
	-- se superpone 	
	SELECT r.idReserva AS idReserva
		-- Reservas que se superponen
		FROM reservas r,vuelosDirectos v,vuelosConEscalas ve,
			 haceEscalaEn he, inserted as new
			WHERE 
				v.fechaSalida < @fechaLlegada 
				AND v.fechaLlegada > @fechaSalida
				AND he.idVueloConEscalas = r.idVueloConEscalas
				AND r.idUsuario = new.idUsuario
		EXCEPT
		(
		-- Reservas que tienen el mismo aeropuerto de salida
		SELECT r.idReserva AS idReserva
			FROM reservas r, vuelosDirectos v, haceEscalaEn he
			WHERE v.idAeropuertoSalida = @idAeropuertoSalida
				AND v.idVuelo = he.idVuelo
				AND he.idVueloConEscalas = r.idVueloConEscalas
				AND r.idUsuario = @usuario
		 INTERSECT
		 -- Reservas que tienen el mismo aeropuerto de llegada
		 SELECT r.idReserva AS idReserva
			FROM reservas r, vuelosDirectos v, haceEscalaEn he
			WHERE v.idAeropuertoLlegada = @idAeropuertoLlegada
				AND v.idVuelo = he.idVuelo
				AND he.idVueloConEscalas = r.idVueloConEscalas
				AND r.idUsuario = @usuario
		)

	IF(@@ROWCOUNT > 1)
		BEGIN
			RAISERROR ('Reservas se superponen',10,1)
			ROLLBACK TRANSACTION
			RETURN
		END
	
	-- Nos fijamos si hay mas de 2 reservas con esa fecha 
	-- de partida e iguales aeropuertos
	SELECT r.idReserva
		FROM reservas r,vuelosDirectos v,vuelosConEscalas ve
		WHERE r.idVueloConEscalas = ve.idVueloConEscalas
			AND v.idVuelo = ve.idVueloPartida
			AND v.idAeropuertoSalida = @idAeropuertoSalida
			AND v.fechaSalida = @fechaSalida
			AND r.idUsuario = @usuario
	INTERSECT
	SELECT r.idReserva
   		FROM reservas r,vuelosDirectos v,vuelosConEscalas ve
		WHERE r.idVueloConEscalas = ve.idVueloConEscalas
			AND v.idVuelo = ve.idVueloPartida
			AND v.idAeropuertoLlegada = @idAeropuertoLlegada
			AND v.fechaLlegada = @fechaLlegada
			AND r.idUsuario = @usuario
	
	if(@@ROWCOUNT > 2)
		BEGIN
			RAISERROR ('Mas de dos reservas por aeropuerto',10,1)
			ROLLBACK TRANSACTION
			RETURN
		END

	-- Nos fijamos si, habiendo una reserva, la reserva tiene 
	-- fecha de partida en los proximos dias	
	IF(@@ROWCOUNT = 2)
		BEGIN
			IF @fechaSalida <= DATEADD(day,7,GETDATE()) 
			BEGIN
				RAISERROR('La reserva es para dentro de mas de 7 dias',10,1)
				ROLLBACK TRANSACTION
				RETURN
			END
		END