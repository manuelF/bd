IF OBJECT_ID ('RestringirReservasUsuario','TR') IS NOT NULL
   DROP TRIGGER RestringirReservasUsuario;
GO

USE Aerolinea;
GO

CREATE TRIGGER RestringirReservasUsuario ON reservas
	AFTER INSERT
AS 
	DECLARE @fechaSalida DATETIME
	DECLARE @fechaLlegada DATETIME
					
	DECLARE @idAeropuertoSalida INTEGER
	DECLARE @idAeropuertoLlegada INTEGER

	DECLARE @usuario INTEGER
	DECLARE @idVuelo INTEGER
	DECLARE @idNueva INTEGER
	
	-- Conseguimos el usuario, vuelo e id de reserva
	SELECT	@usuario=inserted.idUsuario,
			@idVuelo = idVueloConEscalas, 
			@idNueva = idReserva
	FROM inserted
	
	-- Conseguimos las fechas y aeropuertos 
	-- de salida y llegada
	SELECT @fechaSalida=v.fechaSalida, @idAeropuertoSalida=v.idAeropuertoSalida
		FROM vuelosDirectos v,vuelosConEscalas ve, reservas,inserted as new
			WHERE v.idVuelo = ve.idVueloPartida
			AND ve.idVueloConEscalas = @idVuelo

	SELECT @fechaLlegada=v.fechaLlegada, @idAeropuertoLlegada=v.idAeropuertoLlegada
		FROM vuelosDirectos v,vuelosConEscalas ve, reservas, inserted as new
			WHERE v.idVuelo = ve.idVueloLlegada
			AND ve.idVueloConEscalas = @idVuelo

	-- Conseguimos el aeropuerto de llegada y el de salida
	
	-- Nos fijamos si una reserva con distinto aeropuerto 
	-- se superpone. Para eso obtenemos todas las que se superponen
	-- y les sacamos las que tienen el mismo aeropuerto 	
	SELECT r.idReserva AS idReserva
		-- Reservas que se superponen
		FROM reservas r,vuelosDirectos v,vuelosConEscalas ve,haceEscalaEn he
			WHERE 
				v.fechaSalida < @fechaLlegada 
				AND v.fechaLlegada > @fechaSalida
				AND ve.idVueloConEscalas = r.idVueloConEscalas
				AND ((he.idVueloConEscalas = ve.idVueloConEscalas AND
						he.idVuelo = v.idVuelo) OR 
					  ve.idVueloPartida = v.idVuelo OR
					  ve.idVueloLlegada = v.idVuelo)
				AND r.idUsuario = @usuario
		EXCEPT
		(
		-- Reservas que tienen el mismo aeropuerto de salida y misma fecha de salida
		SELECT r.idReserva AS idReserva
			FROM reservas r, vuelosDirectos v, 
				 vuelosConEscalas ve			
		WHERE v.idAeropuertoSalida = @idAeropuertoSalida
				AND v.idVuelo = ve.idVueloPartida
				AND v.fechaSalida = @fechaSalida
				AND ve.idVueloConEscalas = r.idVueloConEscalas
				AND r.idUsuario = @usuario
		 INTERSECT
		 -- Reservas que tienen el mismo aeropuerto de llegada y misma fecha de llegada
		 SELECT r.idReserva AS idReserva
			FROM reservas r, vuelosConEscalas ve, vuelosDirectos v
			WHERE v.idAeropuertoLlegada = @idAeropuertoLlegada
				AND v.idVuelo = ve.idVueloLlegada
				AND v.fechaLlegada = @fechaLlegada
				AND ve.idVueloConEscalas = r.idVueloConEscalas
				AND r.idUsuario = @usuario
		)

	IF(@@ROWCOUNT > 0)
		BEGIN
			RAISERROR ('Reserva se superpone con otra',10,1)
			ROLLBACK TRANSACTION
			RETURN
		END
	
	-- Nos fijamos si hay mas de 2 reservas con esa fecha 
	-- de partida y llegada e iguales aeropuertos de salida y llegada
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
				RAISERROR('La reserva es para dentro los proximos 7 dias',10,1)
				ROLLBACK TRANSACTION
				RETURN
			END
		END