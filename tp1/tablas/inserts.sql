USE Aerolinea;

BEGIN TRANSACTION

-- INSERT INTO clases VALUES (idClase, nombre)
INSERT INTO clases VALUES ('Primera')
INSERT INTO clases VALUES ('Buisness')
INSERT INTO clases VALUES ('Turista')
INSERT INTO clases VALUES ('Economica')


-- INSERT INTO paises VALUES (idPais,nombre)
INSERT INTO paises VALUES ('Argentina')
INSERT INTO paises VALUES ('USA')
INSERT INTO paises VALUES ('Inglaterra')
INSERT INTO paises VALUES ('Brasil')
INSERT INTO paises VALUES ('Uruguay')
INSERT INTO paises VALUES ('Qatar')


-- INSERT INTO ciudades VALUES (idCiudad,nombre,idPais)
INSERT INTO ciudades VALUES ('Buenos Aires',1)
INSERT INTO ciudades VALUES ('Cordoba',1)
INSERT INTO ciudades VALUES ('Londres',3)
INSERT INTO ciudades VALUES ('New York',2)
INSERT INTO ciudades VALUES ('Montevideo',5)
INSERT INTO ciudades VALUES ('Doha',6)
INSERT INTO ciudades VALUES ('Sao Paulo',4)

-- INSERT INTO aeropuertos VALUES (idAeropuerto,tasa,opcionesTransporte,nombre,idCiudad)
INSERT INTO aeropuertos VALUES (350,'subte o bondi','JFK',4)
INSERT INTO aeropuertos VALUES (300,'bondi','LGA',4)
INSERT INTO aeropuertos VALUES (20,'taxi','Ezeiza',1)
INSERT INTO aeropuertos VALUES (10,'bondi','Aeroparque',1)
INSERT INTO aeropuertos VALUES (600,'taxi','Heathrow',3)
INSERT INTO aeropuertos VALUES (620,'sulky','Pajas Blancas',2)
INSERT INTO aeropuertos VALUES (50,'auto','Carrasco',5)
INSERT INTO aeropuertos VALUES (110,'camello','Doha International Airport',6)
INSERT INTO aeropuertos VALUES (180,'subte','Guarulhos',7)

-- INSERT INTO telefonosAeropuertos VALUES (idAeropuerto,numero)
INSERT INTO telefonosAeropuertos VALUES (1,12312312)
INSERT INTO telefonosAeropuertos VALUES (2,12987654)
INSERT INTO telefonosAeropuertos VALUES (3,89865456)
INSERT INTO telefonosAeropuertos VALUES (3,42718920)
INSERT INTO telefonosAeropuertos VALUES (4,92715262)
INSERT INTO telefonosAeropuertos VALUES (5,99912283)
INSERT INTO telefonosAeropuertos VALUES (6,11283471)
INSERT INTO telefonosAeropuertos VALUES (7,11724719)
INSERT INTO telefonosAeropuertos VALUES (8,83741967)
INSERT INTO telefonosAeropuertos VALUES (8,80880131)
INSERT INTO telefonosAeropuertos VALUES (8,22222222)
INSERT INTO telefonosAeropuertos VALUES (9,13187416)

-- INSERT INTO aeronaves VALUES (tripulacion,millas,modelo,idPaisOrigen)
INSERT INTO aeronaves VALUES ('Capitan Jack Sparrow',40000,'Boeing 747',4)
INSERT INTO aeronaves VALUES ('Master Gibbs',12000,'Boeing 767',5)
INSERT INTO aeronaves VALUES ('Almirante Brown',35900,'Airbus A320',2)
INSERT INTO aeronaves VALUES ('Capitan Barbosa',88880,'Douglas DC-9',3)
INSERT INTO aeronaves VALUES ('Capitan Barbosa',77110,'Boeing 747',4)
INSERT INTO aeronaves VALUES ('Capitan Picard',11100,'Boeing 747',5)
INSERT INTO aeronaves VALUES ('Capitan Han Solo',99999,'Millenium Falcon',6)
INSERT INTO aeronaves VALUES ('Baron Rojo',99999,'Fokker Dr 1',1)

-- INSERT INTO vuelosDirectos VALUES (idVuelo,idAeronave,fechaSalida,fechaLlegada,idAeropuertoSalida,idAeropuertoLlegada)
INSERT INTO vuelosDirectos VALUES (1,'20000101','20000102',1,2) -- 1
INSERT INTO vuelosDirectos VALUES (1,'20010101','20010102',2,4) -- 2
INSERT INTO vuelosDirectos VALUES (1,'20020101','20020102',4,3) -- 3
INSERT INTO vuelosDirectos VALUES (2,'20030101','20030102',4,2) -- 4
INSERT INTO vuelosDirectos VALUES (2,'20040101','20040102',1,6) -- 5
INSERT INTO vuelosDirectos VALUES (4,'20050101','20050102',3,4) -- 6
INSERT INTO vuelosDirectos VALUES (5,'20060101','20060102',9,1) -- 7
INSERT INTO vuelosDirectos VALUES (6,'20070101','20070102',4,8) -- 8
INSERT INTO vuelosDirectos VALUES (7,'20080101','20080102',8,4) -- 9
INSERT INTO vuelosDirectos VALUES (7,'20090101','20090102',6,5) -- 10
INSERT INTO vuelosDirectos VALUES (3,'20100101','20100102',5,7) -- 11
INSERT INTO vuelosDirectos VALUES (2,'20110101','20110102',7,8) -- 12
INSERT INTO vuelosDirectos VALUES (1,'20120101','20120102',8,9) -- 13
INSERT INTO vuelosDirectos VALUES (1,'20120101','20120103',3,2) --Con esto crashea el trigger de no superponer
INSERT INTO vuelosDirectos VALUES (8,'20120101','20120102',8,9) --Con esto crashea el trigger de no sobrevender

-- INSERT INTO disponeDeAsientos VALUES (idAeronave,idClase,asientos)
INSERT INTO disponeDeAsientos VALUES (7,4,90)
INSERT INTO disponeDeAsientos VALUES (7,3,60)
INSERT INTO disponeDeAsientos VALUES (7,2,30)
INSERT INTO disponeDeAsientos VALUES (7,1,15)

INSERT INTO disponeDeAsientos VALUES (6,4,45)
INSERT INTO disponeDeAsientos VALUES (6,3,30)
INSERT INTO disponeDeAsientos VALUES (6,2,15)
INSERT INTO disponeDeAsientos VALUES (6,1,10)

INSERT INTO disponeDeAsientos VALUES (5,4,20)
INSERT INTO disponeDeAsientos VALUES (5,3,40)
INSERT INTO disponeDeAsientos VALUES (5,2,2)
INSERT INTO disponeDeAsientos VALUES (5,1,12)

INSERT INTO disponeDeAsientos VALUES (4,4,45)
INSERT INTO disponeDeAsientos VALUES (4,3,10)
INSERT INTO disponeDeAsientos VALUES (4,2,21)
INSERT INTO disponeDeAsientos VALUES (4,1,11)

INSERT INTO disponeDeAsientos VALUES (3,4,88)
INSERT INTO disponeDeAsientos VALUES (3,3,12)
INSERT INTO disponeDeAsientos VALUES (3,2,5)
INSERT INTO disponeDeAsientos VALUES (3,1,5)

INSERT INTO disponeDeAsientos VALUES (2,4,2)
INSERT INTO disponeDeAsientos VALUES (2,3,3)
INSERT INTO disponeDeAsientos VALUES (2,2,4)
INSERT INTO disponeDeAsientos VALUES (2,1,10)

INSERT INTO disponeDeAsientos VALUES (1,4,40)
INSERT INTO disponeDeAsientos VALUES (1,3,30)
INSERT INTO disponeDeAsientos VALUES (1,2,20)
INSERT INTO disponeDeAsientos VALUES (1,1,10)

INSERT INTO disponeDeAsientos VALUES (8,1,0) --Esta es para romper invariante

-- INSERT INTO vuelosConEscalas VALUES (idVueloConEscalas,idViajePartida,idViajeLlegada)
INSERT INTO vuelosConEscalas VALUES (5,13)  --1
INSERT INTO vuelosConEscalas VALUES (7,3)	--2
INSERT INTO vuelosConEscalas VALUES (8,4)	--3
INSERT INTO vuelosConEscalas VALUES (5,5)	--4
INSERT INTO vuelosConEscalas VALUES (6,6)	--5
INSERT INTO vuelosConEscalas VALUES (3,3)	--6
INSERT INTO vuelosConEscalas VALUES (10,10) --7
INSERT INTO vuelosConEscalas VALUES (11,11) --8
INSERT INTO vuelosConEscalas VALUES (8,8)	--9
INSERT INTO vuelosConEscalas VALUES (13,13) --10
INSERT INTO vuelosConEscalas VALUES (7,7)	--11
INSERT INTO vuelosConEscalas VALUES (14,14)	--12
INSERT INTO vuelosConEscalas VALUES (15,15)	--13

-- INSERT INTO preciosParaClase VALUES (idVueloConEscalas,idClase,precio)
INSERT INTO preciosParaClase VALUES (1,1,10000)
INSERT INTO preciosParaClase VALUES (1,2,6000)
INSERT INTO preciosParaClase VALUES (1,3,3000)
INSERT INTO preciosParaClase VALUES (1,4,2000)

INSERT INTO preciosParaClase VALUES (2,1,5000)
INSERT INTO preciosParaClase VALUES (2,2,3000)
INSERT INTO preciosParaClase VALUES (2,3,2000)
INSERT INTO preciosParaClase VALUES (2,4,1000)

INSERT INTO preciosParaClase VALUES (3,1,6500)
INSERT INTO preciosParaClase VALUES (3,2,3500)
INSERT INTO preciosParaClase VALUES (3,3,1200)
INSERT INTO preciosParaClase VALUES (3,4,800)

INSERT INTO preciosParaClase VALUES (4,1,7800)
INSERT INTO preciosParaClase VALUES (4,2,6400)
INSERT INTO preciosParaClase VALUES (4,3,4300)
INSERT INTO preciosParaClase VALUES (4,4,2100)

INSERT INTO preciosParaClase VALUES (5,1,3000)
INSERT INTO preciosParaClase VALUES (5,2,2000)
INSERT INTO preciosParaClase VALUES (5,3,1000)
INSERT INTO preciosParaClase VALUES (5,4,500)

-- Estos son para probar el stored procedure que borra superpuestos (ej 5)
INSERT INTO preciosParaClase VALUES (11,3,1000)
INSERT INTO preciosParaClase VALUES (11,4,5000)


--INSERT INTO usuarios VALUES (username,nombre,apellido,tel,fechaNac,prefer,dir,profesion,mail,hash,idClase,idPaisNacimiento,idClaseFrecuente)
INSERT INTO usuarios VALUES ('odioElTecladoDeLasMac','Juampi','Darago',41238894,'19910114','preferenciasDeJuampi','Santa Fe 1234','Vago','jpdarago@gmail.com',123123123,1,2)
INSERT INTO usuarios VALUES ('elManuDeLaGente','Manu','Ferreria',47896512,'19891231','preferenciasDeManu','Cabildo 1331','Vago','mferreria@gmail.com',172834961,1,3)
INSERT INTO usuarios VALUES ('agauna','Pablo','Gauna',478912342,'19880815','preferenciasDePablo','Lejos 12314','Vago pero en Facebook','pagauna@gmail.com',721343214,1,1)
INSERT INTO usuarios VALUES ('elLocoDeLaMotosierra','Julian','Sackmann',45671832,'19891226','preferenciasDeJuli','Cerca 11123','Vago','jsackmann@gmail.com',987656753,1,1)
INSERT INTO usuarios VALUES ('gbengolea','Gaston','Bengolea',71627489,'19881107','preferenciasDeGasti','Libertador 1234','Vago','gasti@bengolea.com',875132975,1,4)
INSERT INTO usuarios VALUES ('elMatiDeAltamira','Matias','Bender',71628411,'19900822','preferenciasDeMati','Por Ahi 1211','Responde preguntas por mail','watibender@pomail.com',919191919,1,1)
INSERT INTO usuarios VALUES ('arcangelGabriel','Vanesa','Stricker',14142625,'19900607','preferenciasDeVane','Quilmes 1122','Monitos o algo asi','vane@monits.com',816351277,1,3)
INSERT INTO usuarios VALUES ('lasMonadasLocas','Federico','Lebron',99999987,'19880116','preferenciasDeLebron','Google 1133','Google it','flebron@gugl.com',999999999,1,2)


--INSERT INTO tarjetas VALUES (nroTarjeta,idUsuario,empresa,codigoSeg,dir)
INSERT INTO tarjetas VALUES (75342,1,'Santander Rio',444,'Cangrejos 1211')
INSERT INTO tarjetas VALUES (91343,2,'HSBC',865,'Cangrejos 1211')
INSERT INTO tarjetas VALUES (12321,3,'Santander Rio',998,'Cabildo 1331')
INSERT INTO tarjetas VALUES (98786,4,'Patagonia',444,'Lejos 12314') --Mismo cod de seg?
INSERT INTO tarjetas VALUES (62435,5,'Santander Rio',123,'Google 1133') --Mismo nro de tarjeta?
INSERT INTO tarjetas VALUES (88876,6,'City Bank',111,'Lejos 1211')
INSERT INTO tarjetas VALUES (44444,7,'Banco de Google',666,'Google 1113')
INSERT INTO tarjetas VALUES (55523,8,'Nacion',543,'Santa Fe 1234')

--INSERT INTO ciudadesFavoritas VALUES (idUsuario,idCiudad)
INSERT INTO ciudadesFavoritas VALUES (1,1)
INSERT INTO ciudadesFavoritas VALUES (1,3)
INSERT INTO ciudadesFavoritas VALUES (1,5)
INSERT INTO ciudadesFavoritas VALUES (2,1)
INSERT INTO ciudadesFavoritas VALUES (2,2)
INSERT INTO ciudadesFavoritas VALUES (3,5)
INSERT INTO ciudadesFavoritas VALUES (3,7)
INSERT INTO ciudadesFavoritas VALUES (3,1)
INSERT INTO ciudadesFavoritas VALUES (4,4)
INSERT INTO ciudadesFavoritas VALUES (5,1)
INSERT INTO ciudadesFavoritas VALUES (7,1)

-- INSERT INTO haceEscalaEn VALUES (idVueloConEscalas,idVuelo,numeroEscala)
INSERT INTO haceEscalaEn VALUES (1,10,1)
INSERT INTO haceEscalaEn VALUES (1,11,2)
INSERT INTO haceEscalaEn VALUES (1,12,3)
INSERT INTO haceEscalaEn VALUES (2,1,1)
INSERT INTO haceEscalaEn VALUES (2,2,2)
INSERT INTO haceEscalaEn VALUES (3,9,1)

-- INSERT INTO reservas VALUES (idReserva,idUsuario,tipoPago,fechaCiaducidad,datosViajante,idVueloConEscalas,idClase)
-- INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',1,4)
-- INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',2,4)
-- INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',3,4)
-- INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',4,4)
-- INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',5,4)
-- INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',6,4)
-- INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',7,4)
-- INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',8,4)
-- INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',9,4)
-- INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',10,4)
INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',4,4)
INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',8,4)
INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',10,4)
INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',9,4)
INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',7,4)
INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',11,4)

INSERT INTO reservas VALUES (7,'efectivo','20160101','Ay dios mio espero que no se caiga esta maquina de Satan voladora',4,2)
INSERT INTO reservas VALUES (3,'tarjeta','20150301','Voy en primera, pagar Marky',1,1)
INSERT INTO reservas VALUES (2,'lecop','20150301','Necesito que me paralelicen el viaje',5,3)
INSERT INTO reservas VALUES (1,'CEDIN','20160402','En el vuelo quiero un tecito y un bajo',3,2)
INSERT INTO reservas VALUES (6,'patacones clase B','20151115','Un avion de la clase popular y obrera. Pero viajo en primera',2,1)

-- TEST EJERCICIO 1: Correr la query directamente desde ex1.sql
-- El resultado debiera ser el usuario Federico Lebron (numero 8)

-- TEST EJERCICIO 2:

--INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',12,4) -- Este insert rompe el invariante de reservas no se pisan (ex2)

-- Ejecute el primer insert y luego el segundo insert
-- INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',11,3) -- Hacer esto no deberia romper porque estan juntas
-- INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',11,3) -- Hacer esto este y el anterior si, rompe ex2

-- TEST EJERCICIO 3:

--INSERT INTO reservas VALUES (6,'patacones clase B','20151115','Quiero un avion donde no pueda viajar',13,1) -- Esta rompe el invariante de asientos (ex3)

-- TEST EJERCICIO 4
--CREATE TABLE #temp(aeropuerto INTEGER, mes INTEGER, anio INTEGER, entraron INTEGER, salieron INTEGER, total INTEGER);
--INSERT INTO #temp EXEC reporteAeropuertosPorRango @inicio='1900-01-01', @fin='9999-01-01'
--SELECT aeropuerto,SUM(entraron),SUM(salieron) FROM #temp GROUP BY aeropuerto
--DROP TABLE #temp
--El resultado debiera ser igual a la tabla en el informe

-- TEST EJERCICIO 5
-- Ejecute lo siguiente
--INSERT INTO reservas VALUES (8,'tarjeta','20150101','Solo acepto Google Airlines',11,3) -- Hacer esto no deberia romper porque estan juntas
--SELECT idReserva, precio FROM reservas,preciosParaClase 
--WHERE reservas.idUsuario = 8 AND 
--	preciosParaClase.idVueloConEscalas = reservas.idVueloConEscalas AND
--	preciosParaClase.idClase = reservas.idClase
--EXEC cancelarReservaDuplicada @idReserva=6
--SELECT idReserva, precio FROM reservas,preciosParaClase 
--WHERE reservas.idUsuario = 8 AND 
--	preciosParaClase.idVueloConEscalas = reservas.idVueloConEscalas AND
--	preciosParaClase.idClase = reservas.idClase
-- Debiera borrar la reserva numero 12

COMMIT TRANSACTION
GO