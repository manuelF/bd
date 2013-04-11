CREATE TABLE Flights(
    flightid integer AUTOINCREMENT PRIMARY KEY,
    code varchar(10),
    originid integer FOREIGN KEY (Airports.id),
    destinationid integer FOREIGN KEY (Airports.id)
);
