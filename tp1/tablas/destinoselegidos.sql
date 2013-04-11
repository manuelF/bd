CREATE TABLE ChosenDestinations (
    userid integer FOREIGN KEY (Users.id),
    cityid integer FOREIGN KEY (Cities.id),
    primary key on (userid, cityid)

);
