CREATE PROCEDURE reporteAeropuertosPorRango(@inicio date, @fin date)
AS
		
		SELECT	ISNULL(lhs.aeropuerto,rhs.aeropuerto) AS aeropuerto,
				ISNULL(lhs.mes,rhs.mes) AS mes,
				ISNULL(lhs.anio,rhs.anio) AS anio,
				ISNULL(entraron,0) AS entraron,
				ISNULL(salieron,0) AS salieron,
				ISNULL(entraron,0)+ISNULL(salieron,0) AS total 
		FROM
			(SELECT A.idAeropuerto AS aeropuerto, MONTH(v.fechaLlegada) AS mes, 
				YEAR(v.fechaLlegada) AS anio, 
				COUNT(*) AS entraron 
			FROM
				Aeropuertos A, reservas r,vuelosConEscalas ve,vuelosDirectos v 
			WHERE
				r.idVueloConEscalas = ve.idVueloConEscalas
				AND v.idAeropuertoLlegada = A.idAeropuerto AND
					(ve.idVueloPartida = v.idVuelo OR
					 ve.idVueloLlegada = v.idVuelo OR EXISTS
					 (SELECT * FROM haceEscalaEn WHERE 
				 		haceEscalaEn.idVueloConEscalas = ve.idVueloConEscalas AND
				 		haceEscalaEn.idVuelo = v.idVuelo)) 
			GROUP BY A.idAeropuerto,MONTH(v.fechaLlegada),YEAR(v.fechaLlegada) 
			) AS lhs 
			
			FULL OUTER JOIN 
			
			(SELECT A.idAeropuerto AS aeropuerto, MONTH(v.fechaSalida) AS mes, 
				YEAR(v.fechaSalida) AS anio, 
				COUNT(*) AS salieron 
			 FROM
				Aeropuertos A, reservas r,vuelosConEscalas ve,vuelosDirectos v 
			 WHERE
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