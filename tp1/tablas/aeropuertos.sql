CREATE TABLE Airports(
    airportid integer AUTOINCREMENT PRIMARY KEY,
    code varchar(4),
    fullname varchar(100),
    cityid integer FOREIGN KEY(cities.id),
    countryid integer FOREIGN KEY(countries.id) -- esto es un asco, pero nos puede ahorrar joins innecesarios
);
