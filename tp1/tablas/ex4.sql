CREATE PROCEDURE reporteAeropuertosPorRango(@inicio date, @fin date)
AS
	SELECT A.idAeropuerto AS aeropuerto, MONTH(v.fechaLlegada) AS mes, 
			YEAR(v.fechaLlegada) AS anio, 
			COUNT(*) AS entraron FROM
		Aeropuertos A, reservas r,vuelosConEscalas ve,vuelosDirectos v WHERE
			r.idVueloConEscalas = ve.idVueloConEscalas
			AND v.idAeropuertoLlegada = A.idAeropuerto AND
				(ve.idVueloPartida = v.idVuelo OR
				 ve.idVueloLlegada = v.idVuelo OR EXISTS
				 (SELECT * FROM haceEscalaEn WHERE 
				 	haceEscalaEn.idVueloConEscalas = ve.idVueloConEscalas AND
				 	haceEscalaEn.idVuelo = v.idVuelo)) 
		GROUP BY A.idAeropuerto,MONTH(v.fechaLlegada),YEAR(v.fechaLlegada) 
		
		SELECT A.idAeropuerto AS aeropuerto, MONTH(v.fechaSalida) AS mes, 
			YEAR(v.fechaSalida) AS anio, 
			COUNT(*) AS salieron FROM
		Aeropuertos A, reservas r,vuelosConEscalas ve,vuelosDirectos v WHERE
			r.idVueloConEscalas = ve.idVueloConEscalas
			AND v.idAeropuertoSalida = A.idAeropuerto AND
				(ve.idVueloPartida = v.idVuelo OR
				 ve.idVueloLlegada = v.idVuelo OR EXISTS
				 (SELECT * FROM haceEscalaEn WHERE 
				 	haceEscalaEn.idVueloConEscalas = ve.idVueloConEscalas AND
				 	haceEscalaEn.idVuelo = v.idVuelo)) 
		GROUP BY A.idAeropuerto,MONTH(v.fechaSalida),YEAR(v.fechaSalida)
/**
	SELECT A.idAeropuerto, A.nombre, MONTH(@actual),YEAR(@actual), PasajerosIN.pasajerosIN, PasajerosOUT.PasajerosOUT
	FROM Aeropuertos as A, (
		-- tabla con la cantidad de pasajeros de entrada a un aeropuerto
		SELECT COUNT(*) as pasajerosIN 
		FROM VuelosDirectos V, (
			-- resevas de un vuelo en particular
			
			SELECT idReserva FROM Reservas
			--reservas que contengan al vuelo
			where EXISTS (
				Select * FROM VueloConEscalas VE
				WHERE VE.idViajePartida == V.idVuelo
				OR VE.idViajeLlegada == V.idVuelo
				OR EXISTS (
					SELECT * FROM HaceEscalaEN E
					Where E.idVuelo == V.idVuelo
					AND E.idVueloConEscalas == VE.idViajeConEscalas
					)
				)
		) as reservas
		
		Where V.idAeropuertoLlegada == A.idAeropuerto AND
		YEAR(V.fechaLlegada) ==  YEAR(@actual) AND MONTH(V.fechaLlegada) == MONTH(@actual)
	) as PasajerosIN,
	(
	-- copy page de arriba cambiado fecha de llegada por fecha de salida
	
		(
		-- tabla con la cantidad de pasajeros de entrada a un aeropuerto
		SELECT COUNT(*) as pasajerosIN 
		FROM VuelosDirectos V, (
			-- resevas de un vuelo en particular
			
			SELECT idReservas FROM Reservas
			--reservas que contengan al vuelo
			where EXISTS (
				Select * FROM VueloConEscalas VE
				WHERE VE.idViajePartida == V.idVuelo
				OR VE.idVieajeLlegada == V.idVuelo
				OR EXISTS (
					SELECT * FROM HaceEscalaEN E
					Where E.idVuelo == V.idVuelo
					AND E.idVueloConEscalas == VE.idViajeConEscalas
					)
				)
		) as reservas
		
		Where V.idAeropuertoLlegada == A.idAeropuerto AND
		YEAR(V.fechaSalida) ==  YEAR(@actual) AND MONTH(V.fechaSalida) == MONTH(@actual)
	) as PasajerosOUT







		@actual = DATEADD(month,1,@actual)	
	END
	SELECT min

CREATE PROCEDURE reporteAeropuertosPorRango(@inicio date, @fin date)
AS
	SELECT A.idAeropuerto, A.nombre, PasajerosIN.MES,PasajerosIN.ANO, PasajerosIN.pasajerosIN, PasajerosOUT.PasajerosOUT, 
	FROM Aeropuertos as A, (
		-- tabla con la cantidad de pasajeros de entrada a un aeropuerto
		SELECT YEAR(V.fechaLlegada) as ANO, MONTH(V.fechaLlegada) as MES, COUNT(*) as pasajerosIN 
		FROM VuelosDirectos V, (
			-- resevas de un vuelo en particular
			
			SELECT idReservas FROM Reservas
			--reservas que contengan al vuelo
			where EXISTS (
				Select * FROM VueloConEscalas VE
				WHERE VE.idViajePartida == V.idVuelo
				OR VE.idVieajeLlegada == V.idVuelo
				OR EXISTS (
					SELECT * FROM HaceEscalaEN E
					Where E.idVuelo == V.idVuelo
					AND E.idVueloConEscalas == VE.idViajeConEscalas
					)
				)
		) as reservas
		
		Where V.idAeropuertoLlegada == A.idAeropuerto AND
		V.fechaLlegada >= inicio AND V.fechaLlegada <= fin
	
		-- agrupo por año y mes, con el count(*) me va a contrar cada reserva que tenia un vuelo de llegada en ese mes
		GROUP BY YEAR(V.fechaLlegada), MONTH(V.fechaLlegada)
	) as PasajerosIN,
	(
	-- copy page de arriba cambiado fecha de llegada por fecha de salida
	
		-- tabla con la cantidad de pasajeros de entrada a un aeropuerto
		SELECT YEAR(V.fechaSalida) as ANO, MONTH(V.fechaSalida) as MES, COUNT(*) as pasajerosIN 
		FROM VuelosDirectos V, (
			-- resevas de un vuelo en particular
			
			SELECT idReservas FROM Reservas
			--reservas que contengan al vuelo
			where EXISTS (
				Select * FROM VueloConEscalas VE
				WHERE VE.idViajePartida == V.idVuelo
				OR VE.idVieajeLlegada == V.idVuelo
				OR EXISTS (
					SELECT * FROM HaceEscalaEN E
					Where E.idVuelo == V.idVuelo
					AND E.idVueloConEscalas == VE.idViajeConEscalas
					)
				)
		) as reservas
		
		Where V.idAeropuertoLlegada == A.idAeropuerto AND
		V.fechaSalida >= inicio AND V.fechaSalida <= fin
	
		-- agrupo por año y mes, con el count(*) me va a contrar cada reserva que tenia un vuelo de llegada en ese mes
		GROUP BY YEAR(V.fechaSalida), MONTH(V.fechaSalida)
	) as PasajerosOUT
	WHERE PasajerosIN.MES == PasajerosOUT.MES 
	AND PasajerosIN.ANO == PasajerosOUT.ANO
	
	ORDER BY (PasajerosIN.pasajerosIN + PasajerosOUT.pasajerosOUT) DESC
*/