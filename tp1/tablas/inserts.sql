--INSERT INTO usuarios....  (id,nombre,apellido,tel,fechaNac,prefer,dir,profesion,mail,hash,idClase,idPaisNacimiento,idClaseFrecuente)
INSERT INTO usuarios VALUES (1,'Juampi','Darago',41238894,'14/1/1991','preferenciasDeJuampi','Santa Fe 1234','Vago','jpdarago@tuhermana.com',123123123,1,1,1)
INSERT INTO usuarios VALUES (2,'Manu','Ferrería',47896512,'31/12/1989','preferenciasDeManu','Cabildo 1331','Vago','mferreria@tuhermana.com',172834961,1,1,1)
INSERT INTO usuarios VALUES (3,'Pablo','Gauna',478912342,'15/8/1988','preferenciasDePablo','Lejos 12314','Vago pero en Facebook','pagauna@tuhermana.com',721343214,1,1,1)
INSERT INTO usuarios VALUES (4,'Julián','Sackmann',45671832,'26/12/1989','preferenciasDeJuli','Cerca 11123','Vago y boludo','quepajaesto@tuvieja.com',987656753,1,1,1)
INSERT INTO usuarios VALUES (5,'Gastón','Bengolea',71627489,'7/11/1988','preferenciasDeGasti','Libertador 1234','Vago','elena@tuvieja.com',875132975,1,1,1)
INSERT INTO usuarios VALUES (6,'Matías','Bender',71628411,'22/8/1990','preferenciasDeMati','Por Ahí 1211','Responde preguntas por mail','watibender@tutia.com',919191919,1,1,1)
INSERT INTO usuarios VALUES (7,'Vanesa','Stricker',14142625,'7/6/1990','preferenciasDeVane','Quilmes 1122','Monitos o algo asi','nuestroseñorjesucristo@dios.com',816351277,1,1,1)
INSERT INTO usuarios VALUES (8,'Federico','Lebrón',99999987,'16/1/1988','preferenciasDeLebron','Google 1133','Hablar','lebron@tuhermana.com',999999999,1,1,1)

--INSERT INTO tarjetas VALUES (idUsuario,idTarjeta,empresa,nroTarjeta,codigoSeg,dir)
INSERT INTO tarjetas VALUES (1,1,'Santander Rio','7123212345678765','444','Cangrejos 1211')
INSERT INTO tarjetas VALUES (1,2,'HSBC','9898989897678985','865','Cangrejos 1211')
INSERT INTO tarjetas VALUES (2,3,'Santander Rio','7676543423431233','998','Cabildo 1331')
INSERT INTO tarjetas VALUES (3,4,'Patagonia','1234512361231236','444','Lejos 12314') --¿Mismo cod de seg?
INSERT INTO tarjetas VALUES (5,5,'Santander Rio','1234512361231236','123','Google 1133') --¿Mismo nro de tarjeta?
INSERT INTO tarjetas VALUES (3,6,'City Bank','4543256765789543','111','Lejos 1211')
INSERT INTO tarjetas VALUES (8,7,'Banco de Google','4444444444444444','666','Google 1113')
INSERT INTO tarjetas VALUES (1,8,'Nación','1234567890123456','543','Santa Fe 1234')

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
INSERT INTO paises VALUES (1,Argentina)
INSERT INTO paises VALUES (2,USA)
INSERT INTO paises VALUES (3,Inglaterra)
INSERT INTO paises VALUES (4,Brasil)
INSERT INTO paises VALUES (5,Timor Oriental)
INSERT INTO paises VALUES (6,Argentina) --nombre repetido?
INSERT INTO paises VALUES (7,Uruguay)
INSERT INTO paises VALUES (8,Qatar)

-- INSERT INTO ciudades VALUES (idCiudad,nombre,idPais)
INSERT INTO ciudades VALUES (1,Buenos Aires,1)
INSERT INTO ciudades VALUES (2,Córdoba,1)
INSERT INTO ciudades VALUES (3,Londres,3)
INSERT INTO ciudades VALUES (4,New York,2)
INSERT INTO ciudades VALUES (5,Córdoba,1) --nombre repetido?
INSERT INTO ciudades VALUES (6,Montevideo,7)
INSERT INTO ciudades VALUES (7,Doha,8)
INSERT INTO ciudades VALUES (8,Lusail,8)
INSERT INTO ciudades VALUES (9,Sao Paulo,4)
	-- jaja los uruguetas no tienen ciudades.





