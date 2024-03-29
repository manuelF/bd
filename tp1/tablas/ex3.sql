USE Aerolinea
GO

IF OBJECT_ID ('RestringirCupo','TR') IS NOT NULL
   DROP TRIGGER RestringirCupo;
GO

CREATE TRIGGER RestringirCupo ON reservas
	AFTER INSERT
AS
	-- Buscamos si existe un viaje dentro del viaje con escalas de la
	-- nueva reserva tal que este sobrevendido para la clase de esta reserva
	-- Para eso vemos si
	IF EXISTS (SELECT * FROM vuelosConEscalas ve,inserted as new
		WHERE ve.idVueloConEscalas = new.idVueloConEscalas
		AND 
		EXISTS -- exista algun vuelo
		(SELECT * FROM vuelosDirectos v 
			WHERE -- tal que
			( -- el vuelo pertenezca al vuelo con escala de la reserva
			  -- nueva que se creo
				v.idVuelo = ve.idVueloPartida
				OR v.idVuelo = ve.idVueloLLegada
				OR EXISTS  
					(SELECT * FROM HaceEscalaEn he
						WHERE he.idVueloConEscalas = ve.idVueloConEscalas
						AND v.idVuelo = he.idVuelo
					)
			)
			AND
			( -- y ese vuelo este sobrevendido, o sea
			  -- que la cantidad de asientos sea menor que la cantidad de reservas
			  -- que tengan a ese vuelo
				EXISTS
				(SELECT * FROM DisponeDeAsientos da
					WHERE v.idAeronave = da.idAeronave
					AND da.idClase = new.idClase
					AND da.asientos <
						( -- contar asientos ocupados para la clase que estamos viendo
						  -- y que tenga este vuelo entre sus vuelos con escalas
						SELECT COUNT(*) FROM reservas r
							WHERE r.idClase = new.idClase
							AND 
							(EXISTS (SELECT * FROM HaceEscalaEn he2
										WHERE v.idVuelo = he2.idVuelo	
										AND he2.idVueloConEscalas = r.idVueloConEscalas) 
								OR EXISTS 
									(SELECT * FROM vuelosConEscalas ve2
										WHERE ve2.idVueloConEscalas = 
												r.idVueloConEscalas
										AND (v.idVuelo = ve2.idVueloPartida OR v.idVuelo = ve2.idVueloLLegada )
									)
							)
						)
				)
			)
		))
		BEGIN
			RAISERROR ('No hay asientos suficientes para la reserva',10,1)
			ROLLBACK TRANSACTION
			RETURN
		END
GO