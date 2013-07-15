USE Aerolinea;

SELECT nombre, apellido, idUsuario FROM usuarios
	WHERE idUsuario IN (
		SELECT u.idUsuario FROM usuarios u WHERE NOT EXISTS (
				SELECT p.idPais FROM paises p WHERE NOT EXISTS (
					SELECT idReserva FROM reservas r, vuelosConEscalas ve,
						vuelosDirectos v, aeropuertos ap, ciudades c
					WHERE r.idUsuario = u.idUsuario	
						AND r.idVueloConEscalas = ve.idVueloConEscalas
						AND ve.idVueloLlegada = v.idVuelo
						AND ap.idAeropuerto = v.idAeropuertoLlegada
						AND c.idCiudad = ap.idCiudad
						AND c.idPais = p.idPais)));
GO