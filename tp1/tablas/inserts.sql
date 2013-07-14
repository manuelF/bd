
 --  ____                              _                   _ _           _           
 -- |  _ \                            | |                 (_) |         | |          
 -- | |_) | ___  _ __ _ __ __ _ _ __  | | __ _ ___    __ _ _| | __ _  __| | __ _ ___ 
 -- |  _ < / _ \| '__| '__/ _` | '__| | |/ _` / __|  / _` | | |/ _` |/ _` |/ _` / __|
 -- | |_) | (_) | |  | | | (_| | |    | | (_| \__ \ | (_| | | | (_| | (_| | (_| \__ \
 -- |____/ \___/|_|  |_|  \__,_|_|    |_|\__,_|___/  \__, |_|_|\__,_|\__,_|\__,_|___/
 --                                                   __/ |                          
 --                                                  |___/                           



USE Aerolinea;

TRUNCATE TABLE aeronaves;
TRUNCATE TABLE ciudades;
TRUNCATE TABLE ciudadesFavoritas
TRUNCATE TABLE clases
TRUNCATE TABLE disponeDeAsientos
TRUNCATE TABLE haceEscalaEn
TRUNCATE TABLE paises
TRUNCATE TABLE preciosParaClase
TRUNCATE TABLE reservas
TRUNCATE TABLE tarjetas
TRUNCATE TABLE telefonosAeropuertos
TRUNCATE TABLE usuarios
TRUNCATE TABLE vuelosConEscalas
TRUNCATE TABLE vuelosDirectos


--INSERT INTO usuarios VALUES (id,nombre,apellido,tel,fechaNac,prefer,dir,profesion,mail,hash,idClase,idPaisNacimiento,idClaseFrecuente)
INSERT INTO usuarios VALUES (1,'Juampi','Darago',41238894,'14/1/1991','preferenciasDeJuampi','Santa Fe 1234','Vago','jpdarago@tuhermana.com',123123123,1,1,1)
INSERT INTO usuarios VALUES (2,'Manu','Ferrería',47896512,'31/12/1989','preferenciasDeManu','Cabildo 1331','Vago','mferreria@tuhermana.com',172834961,1,1,1)
INSERT INTO usuarios VALUES (3,'Pablo','Gauna',478912342,'15/8/1988','preferenciasDePablo','Lejos 12314','Vago pero en Facebook','pagauna@tuhermana.com',721343214,1,1,1)
INSERT INTO usuarios VALUES (4,'Julián','Sackmann',45671832,'26/12/1989','preferenciasDeJuli','Cerca 11123','Vago y boludo','quepajaesto@tuvieja.com',987656753,1,1,1)
INSERT INTO usuarios VALUES (5,'Gastón','Bengolea',71627489,'7/11/1988','preferenciasDeGasti','Libertador 1234','Vago','elena@tuvieja.com',875132975,1,1,1)
INSERT INTO usuarios VALUES (6,'Matías','Bender',71628411,'22/8/1990','preferenciasDeMati','Por Ahí 1211','Responde preguntas por mail','watibender@tutia.com',919191919,1,1,1)
INSERT INTO usuarios VALUES (7,'Vanesa','Stricker',14142625,'7/6/1990','preferenciasDeVane','Quilmes 1122','Monitos o algo asi','nuestroseñorjesucristo@dios.com',816351277,1,1,1)
INSERT INTO usuarios VALUES (8,'Federico','Lebrón',99999987,'16/1/1988','preferenciasDeLebron','Google 1133','Decir giladas','lebron@tuhermana.com',999999999,1,1,1)

--INSERT INTO tarjetas VALUES (idUsuario,idTarjeta,empresa,nroTarjeta,codigoSeg,dir)
INSERT INTO tarjetas VALUES (1,1,'Santander Rio',7123212345678765,444,'Cangrejos 1211')
INSERT INTO tarjetas VALUES (1,2,'HSBC',9898989897678985,865,'Cangrejos 1211')
INSERT INTO tarjetas VALUES (2,3,'Santander Rio',7676543423431233,998,'Cabildo 1331')
INSERT INTO tarjetas VALUES (3,4,'Patagonia',1234512361231236,444,'Lejos 12314') --¿Mismo cod de seg?
INSERT INTO tarjetas VALUES (5,5,'Santander Rio',1234512361231236,123,'Google 1133') --¿Mismo nro de tarjeta?
INSERT INTO tarjetas VALUES (3,6,'City Bank',4543256765789543,111,'Lejos 1211')
INSERT INTO tarjetas VALUES (8,7,'Banco de Google',4444444444444444,666,'Google 1113')
INSERT INTO tarjetas VALUES (1,8,'Nación',1234567890123456,543,'Santa Fe 1234')

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

-- INSERT INTO paises VALUES (idPais,nombre)
INSERT INTO paises VALUES (1,'Argentina')
INSERT INTO paises VALUES (2,'USA')
INSERT INTO paises VALUES (3,'Inglaterra')
INSERT INTO paises VALUES (4,'Brasil')
--INSERT INTO paises VALUES (5,'Timor Oriental')
--INSERT INTO paises VALUES (6,'Argentina') --nombre repetido?
INSERT INTO paises VALUES (7,'Uruguay')
INSERT INTO paises VALUES (8,'Qatar')


-- INSERT INTO ciudades VALUES (idCiudad,nombre,idPais)
INSERT INTO ciudades VALUES (1,'Buenos Aires',1)
INSERT INTO ciudades VALUES (2,'Córdoba',1)
INSERT INTO ciudades VALUES (3,'Londres',3)
INSERT INTO ciudades VALUES (4,'New York',2)
--INSERT INTO ciudades VALUES (5,'Córdoba',1) --nombre repetido?
INSERT INTO ciudades VALUES (6,'Montevideo',7)
INSERT INTO ciudades VALUES (7,'Doha',8)
-- INSERT INTO ciudades VALUES (8,'Lusail',8)
INSERT INTO ciudades VALUES (9,'Sao Paulo',4)


-- INSERT INTO clases VALUES (idClase, nombre)
INSERT INTO clases VALUES (1,'Primera')
INSERT INTO clases VALUES (2,'Buisness')
INSERT INTO clases VALUES (3,'Turista')
INSERT INTO clases VALUES (4,'Económica')


-- INSERT INTO aeropuertos VALUES (idAeropuerto,tasa,opcionesTransporte,nombre,idCiudad)
INSERT INTO aeropuertos VALUES (1,350,'subte o bondi','JFK',4)
INSERT INTO aeropuertos VALUES (2,300,'bondi','LGA',4)
INSERT INTO aeropuertos VALUES (3,20,'taxi','Ezeiza',1)
INSERT INTO aeropuertos VALUES (4,10,'bondi','Aeroparque',1)
INSERT INTO aeropuertos VALUES (5,600,'taxi','Heathrow',3)
INSERT INTO aeropuertos VALUES (6,620,'sulky','Pajas Blancas',2)
INSERT INTO aeropuertos VALUES (7,50,'auto','Carrasco',6)
INSERT INTO aeropuertos VALUES (8,110,'camello','Doha International Airport',7)
INSERT INTO aeropuertos VALUES (9,180,'subte','Guarulhos',9)


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


-- INSERT INTO aeronaves VALUES (idAeronave,tripulacion,millas,modelo)
INSERT INTO aeronaves VALUES (1,'Capitan Jack Sparrow',40000,'Boeing 747',4)
INSERT INTO aeronaves VALUES (2,'Master Gibbs',12000,'Boeing 767',7)
INSERT INTO aeronaves VALUES (3,'Almirante Brown',35900,'Airbus A320',2)
INSERT INTO aeronaves VALUES (4,'Capitan Barbosa',88880,'Douglas DC-9',3)
INSERT INTO aeronaves VALUES (5,'Capitan Barbosa',77110,'Boeing 747',4)
INSERT INTO aeronaves VALUES (6,'Capitan Picard',11100,'Boeing 747',5)
INSERT INTO aeronaves VALUES (7,'Capitan Han Solo',99999,'Millenium Falcon',8)


-- INSERT INTO vuelosDirectos VALUES (idVuelo,idAeronave,fechaSalida,fechaLlegada,idAeropuertoSalida,idAeropuertoLlegada)
INSERT INTO vuelosDirectos VALUES (1,1,'11/1/2013','13/1/2013',1,2)
INSERT INTO vuelosDirectos VALUES (2,1,'15/1/2013','17/1/2013',2,4)
INSERT INTO vuelosDirectos VALUES (3,1,'21/1/2013','22/1/2013',4,3)
INSERT INTO vuelosDirectos VALUES (4,2,'20/5/2013','20/5/2013',4,2)
INSERT INTO vuelosDirectos VALUES (5,2,'18/2/2013','19/2/2013',1,6)
INSERT INTO vuelosDirectos VALUES (6,4,'28/2/2012','1/3/2012',3,4)
INSERT INTO vuelosDirectos VALUES (7,5,'31/1/2013','2/2/2013',9,1)
INSERT INTO vuelosDirectos VALUES (8,6,'10/10/2010','11/10/2010',4,8)
INSERT INTO vuelosDirectos VALUES (9,7,'18/4/2013','19/4/2013',8,4)
INSERT INTO vuelosDirectos VALUES (10,7,'18/4/2009','19/4/2009',6,5)
INSERT INTO vuelosDirectos VALUES (11,3,'18/4/2010','19/4/2010',5,7)
INSERT INTO vuelosDirectos VALUES (12,2,'18/4/2011','19/4/2011',7,8)
INSERT INTO vuelosDirectos VALUES (13,1,'18/4/2012','19/4/2012',8,9)


-- INSERT INTO disponeDeAsientos VALUES (idAeronave,idClase,asientos)
INSERT INTO disponeDeAsientos VALUES (7,4,90)
INSERT INTO disponeDeAsientos VALUES (7,3,60)
INSERT INTO disponeDeAsientos VALUES (7,2,30)
INSERT INTO disponeDeAsientos VALUES (7,1,15)

INSERT INTO disponeDeAsientos VALUES (6,4,45)
INSERT INTO disponeDeAsientos VALUES (6,3,0)
INSERT INTO disponeDeAsientos VALUES (6,2,15)
INSERT INTO disponeDeAsientos VALUES (6,1,10)

INSERT INTO disponeDeAsientos VALUES (5,4,0)
INSERT INTO disponeDeAsientos VALUES (5,3,0)
INSERT INTO disponeDeAsientos VALUES (5,2,2)
INSERT INTO disponeDeAsientos VALUES (5,1,12)

INSERT INTO disponeDeAsientos VALUES (4,4,45)
INSERT INTO disponeDeAsientos VALUES (4,3,10)
INSERT INTO disponeDeAsientos VALUES (4,2,21)
INSERT INTO disponeDeAsientos VALUES (4,1,11)

INSERT INTO disponeDeAsientos VALUES (3,4,88)
INSERT INTO disponeDeAsientos VALUES (3,3,12)
INSERT INTO disponeDeAsientos VALUES (3,2,0)
INSERT INTO disponeDeAsientos VALUES (3,1,0)

INSERT INTO disponeDeAsientos VALUES (2,4,2)
INSERT INTO disponeDeAsientos VALUES (2,3,3)
INSERT INTO disponeDeAsientos VALUES (2,2,4)
INSERT INTO disponeDeAsientos VALUES (2,1,10)

INSERT INTO disponeDeAsientos VALUES (1,4,40)
INSERT INTO disponeDeAsientos VALUES (1,3,30)
INSERT INTO disponeDeAsientos VALUES (1,2,20)
INSERT INTO disponeDeAsientos VALUES (1,1,10)


-- INSERT INTO vuelosConEscalas VALUES (idVueloConEscalas,idViajePartida,idViajeLlegada)
INSERT INTO vuelosConEscalas VALUES (1,5,13)
INSERT INTO vuelosConEscalas VALUES (2,7,3)
INSERT INTO vuelosConEscalas VALUES (3,8,4)
INSERT INTO vuelosConEscalas VALUES (4,5,5)
INSERT INTO vuelosConEscalas VALUES (5,6,6)


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


-- INSERT INTO haceEscalaEn VALUES (idVueloConEscalas,idVuelo,numeroEscala)
INSERT INTO haceEscalaEn VALUES (1,10,1)
INSERT INTO haceEscalaEn VALUES (1,11,2)
INSERT INTO haceEscalaEn VALUES (1,12,3)
INSERT INTO haceEscalaEn VALUES (2,1,1)
INSERT INTO haceEscalaEn VALUES (2,2,2)

INSERT INTO haceEscalaEn VALUES (3,9,1)


-- INSERT INTO reservas VALUES (idReserva,idUsuario,tipoPago,fechaCiaducidad,datosViajante,idVueloConEscalas,idClase)
INSERT INTO reservas VALUES (1,8,'tarjeta','1/1/2015','Este es homosexual',1,4)
INSERT INTO reservas VALUES (2,8,'tarjeta','1/1/2015','Este es homosexual',2,4)
INSERT INTO reservas VALUES (3,8,'tarjeta','1/1/2015','Este es homosexual',3,4)
INSERT INTO reservas VALUES (4,8,'tarjeta','1/1/2015','Este es homosexual',4,4)
INSERT INTO reservas VALUES (5,8,'tarjeta','1/1/2015','Este es homosexual',5,4)

INSERT INTO reservas VALUES (6,7,'efectivo','1/1/2016','Ay dios mío espero que no se caiga esta máquina de Satán voladora',4,2)
INSERT INTO reservas VALUES (7,3,'tarjeta','1/3/2015','Voy en primera, pagar Marky Sucker Verg',1,1)
INSERT INTO reservas VALUES (8,2,'lecop','1/3/2015','Necesito que me paralelicen el viaje',5,3)
INSERT INTO reservas VALUES (9,1,'CEDIN','1/3/2015','En el vuelo quiero un tecito y un bajo',3,2)
INSERT INTO reservas VALUES (10,6,'patacones clase B','1/3/2015','Un avion de la clase popular y obrera. Pero viajo en primera',2,1)