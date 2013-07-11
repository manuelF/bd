SELECT nombre, apellido, idUsuario FROM usuarios
	WHERE idUsuario IN (
		SELECT u.idUsuario FROM usuarios u WHERE NOT EXISTS (
				SELECT p.idPais FROM paises p WHERE NOT EXISTS (
					SELECT idReserva FROM reservas r, vuelosConEscala ve,
						vuelos v, aeropuertos ap, ciudad c
					WHERE r.idUsuario = u.idUsuario	
						AND r.idVueloConEscala = ve.idVueloConEscala
						AND ve.idVueloLlegada = v.idVuelo
						AND ap.idAeropuerto = v.idAeropuertoLlegada
						AND c.idCiudad = ap.idCiudad
						AND c.idPais = p.idPais)));