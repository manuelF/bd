USE Aerolinea
GO

IF OBJECT_ID ( 'reporteAeropuertosPorRango', 'P' ) IS NOT NULL 
    DROP PROCEDURE reporteAeropuertosPorRango;
GO

CREATE PROCEDURE reporteAeropuertosPorRango(@inicio date, @fin date)
AS
		-- El criterio de ordenacion es por el total de personas que subieron
		-- y bajaron. Para eso usamos una columna extra, total
		SELECT	ISNULL(lhs.aeropuerto,rhs.aeropuerto) AS aeropuerto,
				ISNULL(lhs.mes,rhs.mes) AS mes,
				ISNULL(lhs.anio,rhs.anio) AS anio,
				ISNULL(entraron,0) AS entraron,
				ISNULL(salieron,0) AS salieron,
				ISNULL(entraron,0)+ISNULL(salieron,0) AS total 
		FROM
			-- Calculamos, para cada aeropuerto, cuantos viajes hay tales que tengan
			-- una reserva asociada y que haya aterrizado entre las fechas pedidas, y
			-- en el que el aeropuerto de llegada sea el aeropuerto pedido. Agrupamos
			-- el resultado por anio y mes
			(SELECT A.idAeropuerto AS aeropuerto, MONTH(v.fechaLlegada) AS mes, 
				YEAR(v.fechaLlegada) AS anio, 
				COUNT(*) AS entraron 
			FROM
				aeropuertos A, reservas r,vuelosConEscalas ve,vuelosDirectos v 
			WHERE
				v.fechaLlegada >= @inicio AND v.fechaLlegada <= @fin AND
				r.idVueloConEscalas = ve.idVueloConEscalas
				AND v.idAeropuertoLlegada = A.idAeropuerto AND
					(ve.idVueloPartida = v.idVuelo OR
					 ve.idVueloLlegada = v.idVuelo OR EXISTS
					 (SELECT * FROM haceEscalaEn WHERE 
				 		haceEscalaEn.idVueloConEscalas = ve.idVueloConEscalas AND
				 		haceEscalaEn.idVuelo = v.idVuelo))
			GROUP BY A.idAeropuerto,MONTH(v.fechaLlegada),YEAR(v.fechaLlegada) 
			) AS lhs 
			
			-- Hacemos un full outer join para unir los resultados que aparecen en las dos tablas.
			-- Si un resultado aparece en una sola de las tablas el otro resultado es nulo y por eso
			-- usamos ISNULL para ponerle ceros o el valor que corresponda. Por eso es que estan los
			-- ISNULL mas arriba

			FULL OUTER JOIN 

			-- Calculamos, para cada aeropuerto, cuantos viajes hay tales que tengan
			-- una reserva asociada y que haya aterrizado entre las fechas pedidas, y
			-- en el que el aeropuerto de salida sea el aeropuerto pedido. Agrupamos
			-- el resultado por anio y mes
			
			(SELECT A.idAeropuerto AS aeropuerto, MONTH(v.fechaSalida) AS mes, 
				YEAR(v.fechaSalida) AS anio, 
				COUNT(*) AS salieron 
			 FROM
				Aeropuertos A, reservas r,vuelosConEscalas ve,vuelosDirectos v 
			 WHERE
				v.fechaSalida >= @inicio AND v.fechaSalida <= @fin AND
				r.idVueloConEscalas = ve.idVueloConEscalas
				AND v.idAeropuertoSalida = A.idAeropuerto AND
					(ve.idVueloPartida = v.idVuelo OR
					 ve.idVueloLlegada = v.idVuelo OR EXISTS
					 (SELECT * FROM haceEscalaEn WHERE 
				 		haceEscalaEn.idVueloConEscalas = ve.idVueloConEscalas AND
				 		haceEscalaEn.idVuelo = v.idVuelo)) 
			GROUP BY A.idAeropuerto,MONTH(v.fechaSalida),YEAR(v.fechaSalida)) AS rhs

			ON lhs.aeropuerto = rhs.aeropuerto 
				AND lhs.anio = rhs.anio 
				AND lhs.mes = rhs.mes
				
		ORDER BY(total) DESC
GO