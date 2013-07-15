IF OBJECT_ID ('RestringirCupo','TR') IS NOT NULL
   DROP TRIGGER RestringirCupo;
GO

CREATE TRIGGER RestringirCupo ON Reservas
	AFTER INSERT
AS
	IF EXISTS (SELECT * FROM ViajesConEscalas ve,inserted new
		WHERE ve.idVueloConEscalas = new.idVueloConEscalas
		AND 
		EXISTS -- exista algun vuelo
		(SELECT * FROM vuelos v 
			WHERE -- tal que
			( -- el vuelo pertenezca al vuelo con escala
				v.idVuelo = ve.idViajePartida
				OR v.idVuelo = ve.idViajeLLegada
				OR EXISTS  
					(SELECT * FROM HaceEscalaEn he
						WHERE he.idVueloConEscalas = ve.idVueloConEscalas
						AND v.idVuelo = he.idVuelo
					)
			)
			AND
			( -- y ese vuelo no tenga mas asientos
				EXISTS
				(SELECT * FROM DisponeDeAsientos da
					WHERE v.idAeronave = da.idAeronave
					AND da.idClase = new.idClase
					AND da.asientos >=
						( -- contar asientos ocupados de un vuelo/clase
						SELECT COUNT(*) FROM reservas r
							WHERE r.idClase = new.idClase
							AND 
							(
								EXISTS
									(SELECT * FROM HaceEscalaEn he2
										WHERE v.idVuelo = he2.idVuelo	
										AND he2.idVueloConEscalas = 
												r.idVueloConEscalas
									) 
								OR EXISTS 
									(SELECT * FROM ViajesConEscalas ve2
										WHERE ve2.idVueloConEscalas = 
												r.idVueloConEscalas
										AND 
										(
										 v.idVuelo = ve2.idViajePartida 
										 OR v.idVuelo = ve2.idViajeLLegada 
										)
									)
							)
						)
				)
			)
		))
		BEGIN
			RAISERROR ('No hay asientos sufientes',10,1)
			ROLLBACK TRANSACTION
			RETURN
		END