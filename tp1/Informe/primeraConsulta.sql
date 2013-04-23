SELECT nombre, apellido, idUsuario FROM usuarios
	WHERE idUsuario IN (
		SELECT idUsuario FROM usuarios WHERE NOT EXISTS (
			SELECT p.idPais FROM paises WHERE NOT EXISTS (
				SELECT idReserva FROM reservas r
				JOIN esReservaPara ep ON r.idReserva = ep.idReserva
				JOIN viajeConEscalas vce 
					ON vce.idViajeConEscalas = ep.idViajeConEscalas
				JOIN viaje v ON v.idViaje = vce.idViajeLlegada
				JOIN aeropuerto ap ON v.llega = ap.idAeropuerto
				JOIN ciudades c ON c.idCiudad = ap.idCiudad
					WHERE c.idPais = p.idPais
			)
		)
	)
