CREATE TABLE Reservations (
    reserveid integer AUTOINCREMENT PRIMARY KEY,
    userid integer FOREIGN KEY (Users.id),
    tripid integer FOREIGN KEY (Trips.id),
    --tripid tiene que relacionar una daisy chain de vuelos
    departuredate date --fecha y hora tiene que haber aca

   );
